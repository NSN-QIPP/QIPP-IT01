public class QIRS_ReleaseProductWiseController {

   public QIRS_ReleaseProductWiseController() 
    {
        QIRSID = System.currentPagereference().getParameters().get('id');
        if(([SELECT Watchlist__c from QIRS__c where id =: QIRSID]).size()>0)
             {
                objqirs = [SELECT Watchlist__c from QIRS__c where id =: QIRSID];                       
             }
    }
                     
 
     public QIRS__c objqirs{get;set;}          
  //  public QIRS_Product__c objQIRSReleaseProduct1{get;set;}
    Public String QIRSID{get;set;}    
    Public String QIRSName{get;set;}     
    List<QIRS_Product_Identification__c> objQIRSReleaseProduct = new List<QIRS_Product_Identification__c>();
    public List<QIRS_Product_Identification__c> getQIRSReleaseProductDetails() 
    {
     objQIRSReleaseProduct = [select QIRS__r.Name,QIRS__c,ClassAccess__c,
     Release_Product__c,Name,Product_Name__c,Technology__c
     from QIRS_Product_Identification__c where QIRS__c =: QIRSID];   
      if(objQIRSReleaseProduct.size()>0)  
      {
          QIRSName = objQIRSReleaseProduct[0].QIRS__r.Name;
      }
        return objQIRSReleaseProduct;                                   
    }


   


    public PageReference Save() 
    {
          try
          { 
            string updateReleaseProduct ='';
            string updateUnReleaseProduct ='';
            Boolean IsRelease = true;
            for(Integer i = 0; i < objQIRSReleaseProduct.size(); i++)
               {
                 if(!objQIRSReleaseProduct[i].Release_Product__c)
                 {
                     IsRelease =false;
                     break;
                 }
               }
               for(Integer i = 0; i < objQIRSReleaseProduct.size(); i++)
               {
               objQIRSReleaseProduct[i].ClassAccess__c = true;
                 if(objQIRSReleaseProduct[i].Release_Product__c)
                 {
                   
                    if(i == 0)
                         {
                         
                             updateReleaseProduct = objQIRSReleaseProduct[i].Name;
                         }
                         else
                         {
                            if(updateReleaseProduct == '')
                             {
                                 updateReleaseProduct = objQIRSReleaseProduct[i].Name;                                 
                             }
                             else
                                {
                                         updateReleaseProduct = updateReleaseProduct + '; ' + objQIRSReleaseProduct[i].Name;
                                }

                             
                            
                         
                             }
                  }
                 else
                 {
                  if(i == 0 || updateUnReleaseProduct == '')
                     {
                         updateUnReleaseProduct = objQIRSReleaseProduct[i].Name ;
                     }
                     else
                     {
                         updateUnReleaseProduct = updateUnReleaseProduct + '; ' + objQIRSReleaseProduct[i].Name;
                     }
                     
                     
                 }
             }
             if(updateUnReleaseProduct != '')
             {
                 updateUnReleaseProduct =updateUnReleaseProduct +';';
             }
               List<QIRS__c> qirs = new List<QIRS__c>();                       
               //qirs=[SELECT Product_PN__c,Watchlist__c,Lock_Points_SH_Shipping__c,Business__c,Business_Group__c,Alert_Type__c,Site1__c,Reopen__c,View_Release_Product__c,View_Product_Name__c from QIRS__c where id =: objQIRSReleaseProduct[0].QIRS__c];                       
               qirs=[SELECT Product_PN__c,Watchlist__c,Lock_Points_SH_Shipping__c,Business__c,Business_Group__c,Alert_Type__c,Site1__c,Reopen__c,View_Release_Product__c,View_Product_Name__c from QIRS__c where id =: QIRSID];                       
                 if(qirs.size() > 0)                       
                 {                      
                    if(IsRelease)
                    {
                       qirs[0].Status__c = QIRSBasecontroller.BaseVarQIRSLifted;// 'Lifted';
                       //qirs[0].Lifted_Date__c = Date.Today();
                       //The Below Line is added by Kiran on 09-04-2015 for Release Date
                       qirs[0].Lifted_Date__c = System.Now();
                       qirs[0].Watchlist__c = objqirs.Watchlist__c;
                       qirs[0].Lock_Points_SH_Shipping__c = true;
                       if(qirs[0].Reopen__c)   
                       qirs[0].Reopen__c = false; 
                    }
                     qirs[0].View_Release_Product__c = updateReleaseProduct; 
                     qirs[0].Product_PN__c = updateUnReleaseProduct; 
                     update qirs;                       
                 }
                update objQIRSReleaseProduct;
               //String[] strSite = new String[]{qirs[0].Site1__c};
                if(IsRelease)
                    {
                       List<String> SiteList = new List<String>();
                       SiteList.add(qirs[0].Site1__c);
                       //Boolean bresult = QIRSBasecontroller.SendEmail(SiteList, qirs[0].Business__c, qirs[0].Alert_Type__c, qirs[0].Business_Group__c,'Lifted',qirs[0].Id);
                       Boolean bresult = QIRSBasecontroller.SendEmail(SiteList, qirs[0].Business__c, qirs[0].Alert_Type__c, qirs[0].Business_Group__c,'Released',qirs[0].Id);                       
                    }
                 //PageReference pageRef = new PageReference('/' + objQIRSReleaseProduct[0].QIRS__c);
                 PageReference pageRef = new PageReference('/' + QIRSID);                 
                         pageRef.setRedirect(true);
                         return pageRef;
          }
          catch(System.DmlException ex)
         {
            ApexPages.addMessages(ex); 
            return null;
         }

    }
    
     public PageReference cancel() {
       //PageReference pageRef = new PageReference('/' + objQIRSReleaseProduct[0].QIRS__c);
                 PageReference pageRef = new PageReference('/' + QIRSID);                 
                         pageRef.setRedirect(true);
                         return pageRef;
    }

                         
     static testMethod void testQIRS_ReleaseProductWiseController()
     {
         List<String> strNSNQIRS =new List<String>();
         List<Profile> tempprofile = new List<Profile>(); 
         String[] Profile = new String[] {'Nokia QIRS Admin','Nokia QIRS'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];          
           for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
          
          List<User> userlist= new List<User>();
          userlist= [select Id,Name from User where 
           ProfileId In: strNSNQIRS and IsActive = true order by Name];        
      QIRS__c objqirs = new QIRS__c();
           objqirs.Site1__c = 'Alsdorf';
           objqirs.Process_Owner1__c = userlist[0].Id;           
           objqirs.Business__c = 'Networks Systems';           
           objqirs.Business_Group__c = 'CDMA';           
           objqirs.Alert_Type__c = 'NPI Launch Impact';           
           objqirs.Issue_Level__c = 'Launch Delay';                                            
             objqirs.Factory__c ='Berlin';
           objqirs.Problem_Description1__c = 'Networks Systems';           
           objqirs.Customer__c = 'CDMA';           
           objqirs.Defective_Part__c = 'Design';           
           objqirs.Symptom__c = 'Hardware';                                            
           objqirs.Projected_Lift_Date__c  =Date.today();        
            objqirs.Master_Approver1__c =userlist[0].Id;
           objqirs.Master_Approver2__c =userlist[1].Id;
           objqirs.Master_Approver3__c =userlist[2].Id;
           objqirs.Master_Approver4__c =userlist[3].Id;
           objqirs.Master_Approver5__c =userlist[4].Id;
           objqirs.Master_Approver6__c =userlist[5].Id;
           objqirs.Master_Approver7__c =userlist[6].Id;
           objqirs.Master_Approver8__c =userlist[7].Id;                                                                  
           objqirs.Master_Approver9__c =userlist[8].Id;
           objqirs.Master_Approver10__c =userlist[9].Id;           
            objqirs.Approver_Contacted1__c = true;
            objqirs.Approver_Contacted2__c = true;
            objqirs.Approver_Contacted3__c = true;
            objqirs.Approver_Contacted4__c = true;
            objqirs.Approver_Contacted5__c = true;
            objqirs.Approver_Contacted6__c = true;
            objqirs.Approver_Contacted7__c = true;
            objqirs.Approver_Contacted8__c = true;                                                                                    
            objqirs.Approver_Contacted9__c = true;            
            objqirs.Approver_Contacted10__c = true;   
           objqirs.Impacted_Region__c = 'Asia';           
           objqirs.Countries__c = 'China';           
             insert objqirs;   
             List<QIRS__c> lstQirs = new List<QIRS__c>();             
             lstQirs.add(objqirs); 
             
             QIRS_Product_Identification__c objpi = new QIRS_Product_Identification__c();
             objpi.ClassAccess__c = true;
             objpi.Product_Name__c = 'Test';
             objpi.Release_Product__c =true;
             objpi.Technology__c = 'test';
             objpi.QIRS__c = objqirs.Id;
             objpi.Name__c = 'test';
             insert objpi;
             List<QIRS_Product_Identification__c> lstPI = new List<QIRS_Product_Identification__c>();             
             lstPI.add(objpi); 

             ApexPages.CurrentPage().getParameters().put('id', objqirs.Id); 
         QIRS_ReleaseProductWiseController controller = new QIRS_ReleaseProductWiseController();
         controller.QIRSID = objqirs.Id;
         controller.objQIRSReleaseProduct = lstPI;         
          
         controller.getQIRSReleaseProductDetails();
         controller.objQIRSReleaseProduct = lstPI;  
         PageReference pg = controller.cancel();
         controller.objQIRSReleaseProduct = lstPI;           
         controller.Save();
     }

}