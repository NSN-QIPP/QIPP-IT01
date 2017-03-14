public with sharing  class QIRS_Action_Plan_Cancel_Comments
{
    public string qirscomment;
    public boolean Testcheck = false;
    public string strSubtitleValue{get; set;}

    public QIRS_Action_Plan_Cancel_Comments(ApexPages.StandardController controller)
    {     
    }
    
    public pagereference ActionMethod()
    {
         if(!Testcheck) 
             qirscomment = ApexPages.currentPage().getParameters().get('id');
                  
         list <QIRS_Action_Plan__c> qirsAPnumber = new list<QIRS_Action_Plan__c>();
         qirsAPnumber = [select Name from QIRS_Action_Plan__c where id =: qirscomment];
         strSubtitleValue = qirsAPnumber[0].Name;
         return null;
    }
    public string comments{get; set;}
    
    
    public pagereference Save()
    {
    if(comments == null || comments == '')
    {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the Reason for Cancelation.');
        ApexPages.addMessage(myMsg);
        return null;
    }
    else
    {            
        QIRS_Action_Plan__c qirscancel = new QIRS_Action_Plan__c(id = qirscomment);
        qirscancel.Cancel_Comments__c = comments;
        qirscancel.RecordTypeId = [SELECT Id FROM RecordType WHERE Name =: 'QIRS_Action_Plan_without_Cancel'].id;
        update qirscancel;
        QIRS_Release_Product_Controller qirscancelcomment = new QIRS_Release_Product_Controller();
        qirscancelcomment.CanceledAP(qirscomment);
        pagereference newref = new pagereference('/'+qirscomment);
        newref.setredirect(true);
        return newref;         
    }
    }
    public pagereference Cancel()
    {
     pagereference newref = new pagereference('/'+qirscomment);
            newref.setredirect(true);
            return newref;
    }





    static testmethod void test()
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
     
       QIRS_Action_Plan__c qirscancel = new QIRS_Action_Plan__c();        
       qirscancel.Cancel_Comments__c = 'test'; 
       qirscancel.Action_Type__c = 'Corrective';
       qirscancel.Task__c = 'tests';
       qirscancel.Required_date__c = system.today();    
       qirscancel.QIRS__c  =  objqirs.id;  
        qirscancel.Name  =  'QIRS-004346.8';   
       insert qirscancel;
       
       
         ApexPages.StandardController con = new ApexPages.StandardController(qirscancel);
         QIRS_Action_Plan_Cancel_Comments ppp= new QIRS_Action_Plan_Cancel_Comments(con);
         //ApexPages.CurrentPage().getParameters().put('id', qirscancel.Id); 
         ppp.Testcheck = true;
         ppp.strSubtitleValue =  qirscancel.Name;         
         ppp.comments = '';
         ppp.qirscomment=qirscancel.id;
         ppp.ActionMethod();
         
         ppp.Save();
         
         ppp.comments = 'test';
         ppp.Save();
         
         ppp.Cancel();
         
     }
     
     
}