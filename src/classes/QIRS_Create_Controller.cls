public with sharing class QIRS_Create_Controller {

 
    public QIRS_Create_Controller(ApexPages.StandardController controller) {
List<Profile> tempprofile = new List<Profile>();                       
         tempprofile=[SELECT Id,Name from Profile where Name =: 'Nokia QIRS' ];
         if(tempprofile.size()>0)
         {
             strNSNQIRS = tempprofile[0].Id;
             //strsisadmin = tempprofile[1].Id;
         }
       String strQIRS= System.currentPagereference().getParameters().get('id');            
        if(strQIRS == '' || strQIRS == null)
        {
            //strBusiness = 'Networks Systems';
            strBusiness = 'zzMobile Broadband';            
            IsReadOnly = false;
            strMode = 'ADD';
            strStatus ='Open';
            IsAppChamp = false;
            strSubtitleValue = 'New QIRS';
            objqirs = new QIRS__c();
            IsRenderConAppInput = true;
            IsRenderConAppOutput  = false;
        }
        else
        {
            if(([select ID from QIRS__c where Id =: strQIRS]).size()>0)
             {
                IsReadOnly = true;             
                strMode = 'EDIT';
                IsAppChamp = true;
                IsRenderConAppInput = false;
                IsRenderConAppOutput  = true;
                objqirs = [select NSN_Part_Number__c,IsDefaultReleased__c,StatusColor__c,Product_Safety__c,Supplier_Pn__c,Approval_Comments__c,Core_ID__c,Name, Factory_DC__c,Access_Stop_Ship_Code__c,Alert_Type__c,Business__c,
                Business_Group__c,Closed_Date1__c,Cost__c,Customer__c,Customer_Impact__c,Defective_Part__c,
                Estimated_close_date__c,Expected_Number_of_return__c,Exposed_Base__c,Factory__c,Group_to_Notify__c,Countries__c,
                Impacted_Region__c,Issue_Level__c,IssueLevelColor__c,Lifted_Date__c,Master_Approver__c,
                Master_Approver1__c,Master_Approver2__c, Master_Approver3__c,Master_Approver4__c,Master_Approver5__c,Master_Approver6__c,
                Master_Approver7__c,Master_Approver8__c,Master_Approver9__c,Master_Approver10__c,
                Approver_Contacted1__c, Approver_Contacted2__c,Approver_Contacted3__c,Approver_Contacted4__c,Approver_Contacted5__c,
                Approver_Contacted6__c,Approver_Contacted7__c,Approver_Contacted8__c,Approver_Contacted9__c,Approver_Contacted10__c,
                MCAR__c,Next_CRSD__c,
                Operator_Warning_Message__c, Orders_backlog__c,Orders_Impact__c,Last_Approved_Program_Milestone__c,Problem_Description1__c,Process_Owner1__c,Process_to_Stop__c,View_Product_Name__c,
                Projected_Lift_Date__c,
                Revenue_Backlog__c,Revenue_Impact__c,Serial_Numbers__c,Lock_Points_SH_Shipping__c,Site1__c,
                Status__c,Supplier__c,Symptom__c,Total_Quality_Spills_Cost__c,Units_Backlog__c,Units_Impact__c,View_AP_Color__c,View_Release_Product__c,
                Watchlist__c,WatchListType__c,WatchListComment__c,Yes__c,CreatedBy.ID,
                Case_Name__c,Impacted_Region_Customer__c,MCAR_Supplier_Claim__c,Pronto__c,Resolve__c,RCA_EDA__c,Line_Stop__c,Affected_Unit_at_Customer_Action__c,
                Affected_Unit_at_Hubs_Action__c,Affected_Unit_at_Factories_Action__c,Additional_Email__c,Affected_Units_at_HWS_Action__c,
                Affected_Units_at_Suppliers_Action__c,Affected_Units_at_HWS__c,Affected_Units_at_Suppliers__c
                from QIRS__c where Id =: strQIRS];
                 strmultiApp =  new String[]{objqirs.Master_Approver1__c,objqirs.Master_Approver2__c
                 ,objqirs.Master_Approver3__c,objqirs.Master_Approver4__c,objqirs.Master_Approver5__c,objqirs.Master_Approver6__c
                 ,objqirs.Master_Approver7__c,objqirs.Master_Approver8__c,objqirs.Master_Approver9__c,objqirs.Master_Approver10__c
                 };
                 strSubtitleValue = objqirs.Name;
                 strStatus = objqirs.Status__c;
                 strSite = objqirs.Site1__c;
                 strBusiness = objqirs.Business__c;
                 strAlertType = objqirs.Alert_Type__c;
                 strIssueLevel = objqirs.Issue_Level__c;
                 //mailToAddresses.add(u.email);
            }
        }
        //NPIError = false;
    }


    
    //public boolean NPIError{get;set;}
    
    public QIRS__c objqirs{get;set;}
    public string[] strmultiApp{get;set;}
    public string strMode {get;set;}     
    public string strSubtitleValue {get;set;} 
    public string strsisadmin {get;set;}     
    public string strNSNQIRS {get;set;} 
   // String contactedapp = null;
  //public string contactedapp {get;set;} 
 //   public boolean Isvisible {get;set;}
    public string strAlertType {get;set;}  
    public string strBusiness {get;set;}  
    public string strSite {get;set;}  
    public string strIssueLevel {get;set;}      
    public string strStatus {get;set;}  
    List<QIRS_Action_Plan_Approver_List__c> Aplist= new List<QIRS_Action_Plan_Approver_List__c>();    
    public boolean IsAppChamp {get;set;} 
    public boolean IsRenderConAppInput {get;set;}
    public boolean IsRenderConAppOutput {get;set;}    
    public boolean IsReadOnly {get;set;} 
     List<String> MasterApprlist= new List<String>();

    public Pagereference Save()
    {
    //this validation on Last_Approved_Program_Milestone__c  from lines 93 to 99 is written by VIjay on 2nd june 2013.
    
    /*if((objqirs.Alert_Type__c == 'NPI Launch Impact' && objqirs.Last_Approved_Program_Milestone__c == null) || (objqirs.Alert_Type__c == 'NPI Launch Impact' && objqirs.Last_Approved_Program_Milestone__c.isNumeric())){
        NPIError = true;
        return null;
    }
    else*/
        try
          { 
               
                     if(strMode == 'ADD')
                     { 
                           string strfakeChampionID = '';
                           String strApprover = '';
                           List<User> userlist1= new List<User>();
                           string[] SelectedUserID =strmultiApp;
                           userlist1= [select Id,Name from User where Id In :MasterApprlist];

                           
                           if(userlist1.size()>0)
                           {
                           
                               if((userlist1.size() == 1) && (UserInfo.getUserId() == userlist1[0].Id))
                               {
                                   objqirs.addError('Originator can not be only Master Approver, add another master approver.'); 
                                   return null;
                               }
                              for(Integer i = 0; i < userlist1.size(); i++)
                                 {
                                    if(i != 0)
                                    {
                                        strApprover  = strApprover +  '; ' +   userlist1[i].Name; 
                                    }
                                    if(i == 0)
                                    {
                                        objqirs.Master_Approver1__c =  userlist1[i].Id; 
                                         strApprover  = userlist1[i].Name;
                                    }
                                    else if(i == 1)
                                    {
                                        objqirs.Master_Approver2__c =  userlist1[i].Id;  
                                       
                                    } 
                                    else if(i == 2)
                                    {
                                        objqirs.Master_Approver3__c =  userlist1[i].Id; 
                                    }
                                    else if(i == 3)
                                    {
                                        objqirs.Master_Approver4__c =  userlist1[i].Id;  
                                    }                    
                                    else if(i == 4)
                                    {
                                        objqirs.Master_Approver5__c =  userlist1[i].Id;
            
                                    }
                                    else if(i == 5)
                                    {
                                        objqirs.Master_Approver6__c =  userlist1[i].Id;  
            
                                    } 
                                    else if(i == 6)
                                    {
                                        objqirs.Master_Approver7__c =  userlist1[i].Id;
            
                                    }
                                    else if(i == 7)
                                    {
                                        objqirs.Master_Approver8__c =  userlist1[i].Id;  
            
                                    }
                                    else if(i == 8)
                                    {
                                        objqirs.Master_Approver9__c =  userlist1[i].Id;
            
                                    }
                                    else if(i == 9)
                                    {
                                        objqirs.Master_Approver10__c =  userlist1[i].Id; 
                                    }                       
                                                       
                                    // ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,userlist1[i].Name));
                                 }
                                 Integer count = userlist1.size();
                                 strfakeChampionID = userlist1[count-1].Id;
                                 if(count>0)
                                 {
                                     
                                     if(count == 2 || count == 1)
                                     {
                                        objqirs.Master_Approver2__c =  strfakeChampionID;  
                                     }
                                    else if(count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver3__c =  strfakeChampionID;                               
                                     }
                                     else if(count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver4__c =  strfakeChampionID;
                                     }
                                     else if(count == 5 || count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver5__c =  strfakeChampionID;
                                     }
                                     else if(count == 6 || count == 5 || count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver6__c =  strfakeChampionID;   
                                   
                                     }
                                     else if(count == 7 || count == 6 || count == 5 || count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver7__c =  strfakeChampionID; 
                                     } 
                                     else if(count == 8 || count == 7 || count == 6 || count == 5 || count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver8__c =  strfakeChampionID;                                  
                                     }
                                     else if(count == 9 || count == 8 || count == 7 || count == 6 || count == 5 || count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver9__c =  strfakeChampionID;
                                     }   
                                     else if(count == 10 || count == 9 || count == 8 || count == 7 || count == 6 || count == 5 || count == 4 || count == 3 || count == 2  || count == 1)
                                     {
                                        objqirs.Master_Approver10__c =  strfakeChampionID;                                                           
                                     }                                                                                                                                                                                                               
                                 }            
                           }
                           
//                           IF alert type Quality Alert then set IsDefaultRelased
//                            flag true and Set Status equals to Released.
                           if(objqirs.Alert_Type__c == QIRSBasecontroller.BaseVarQAAlertType)
                           {
                               objqirs.Status__c = QIRSBasecontroller.BaseVarQIRSLifted;
                               objqirs.IsDefaultReleased__c = true;
                               objqirs.Lifted_Date__c = Date.today();
                           }
                           else
                           {
                               objqirs.Status__c = strStatus;
                           }
                           
                        objqirs.Master_Approver__c = strApprover;
                        objqirs.Site_Filter__c = objqirs.Site1__c;
                        objqirs.Business__c = strBusiness;
                       // objqirs.Status__c = strStatus;
                        objqirs.Original_Created_By__c = UserInfo.getUserId();
                         AssignContactedApp();
                         recordtype rt = [select ID from RecordType where Name = 'New Record Notification' Limit 1];
                         objqirs.RecordTypeID = rt.ID;
                        Database.SaveResult sr = Database.insert(objqirs);
                         if(sr.isSuccess())
                         {
                                 PageReference pageRef = new PageReference('/' + objqirs.Id);
                                 pageRef.setRedirect(true);
                                 return pageRef;
                        
                         } 
                         else
                         {
                             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
                         }
                      }
                      else
                       {

                             List<Profile> tempprofile = new List<Profile>(); 
                             tempprofile=[SELECT Id,Name from Profile where Name =: 'Nokia QIRS'];          
                              
                            
                              if(UserInfo.getprofileid() == tempprofile[0].Id)
                              { 
                                   if(UserInfo.getUserId() == objqirs.Process_Owner1__c || UserInfo.getUserId() == objqirs.CreatedBy.ID)
                                   {
                                       
                                   }
                                   else
                                   {
                                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Insufficient Privileges')); 
                                       return null;
                                   }
                              }
                           objqirs.Site_Filter__c = objqirs.Site1__c;
                          // AssignContactedApp();
                           Database.SaveResult sr = Database.update(objqirs);
                         if(sr.isSuccess())
                         {
                            PageReference pageRef = new PageReference('/' + objqirs.Id);
                             pageRef.setRedirect(true);
                             return pageRef;
                         } 
                         else
                         {
                             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to update entered data.')); 
                         }
                       }
              
               
          }
          catch(System.DmlException ex)
         {
            ApexPages.addMessages(ex); 
         }
          
       return  null;
    }
    Public Void AssignContactedApp()
    {
     for(Integer i = 0; i < Aplist.size(); i++)
         {
             if(Aplist[i].Approver_Contacted__c)
             {
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver1__c)
                 {
                   objqirs.Approver_Contacted1__c = true; 
                   
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver2__c)
                 {
                   objqirs.Approver_Contacted2__c = true; 
                   
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver3__c)
                 {
                   objqirs.Approver_Contacted3__c = true; 
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver4__c)
                 {
                   objqirs.Approver_Contacted4__c = true; 
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver5__c)
                 {
                   objqirs.Approver_Contacted5__c = true; 
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver6__c)
                 {
                   objqirs.Approver_Contacted6__c = true; 
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver7__c)
                 {
                   objqirs.Approver_Contacted7__c = true; 
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver8__c)
                 {
                   objqirs.Approver_Contacted8__c = true; 
                 }
                  if(Aplist[i].User__r.Id == objqirs.Master_Approver9__c)
                 {
                   objqirs.Approver_Contacted9__c = true; 
                 }
                 if(Aplist[i].User__r.Id == objqirs.Master_Approver10__c)
                 {
                   objqirs.Approver_Contacted10__c = true; 
                 }
             }
         }
    }
    public Pagereference Cancel()
    {
        PageReference pageRef = new PageReference('/apex/QIRS_HomePage?save_new=1&sfdc.override=1');
         pageRef.setRedirect(true);
         return pageRef;
            
       //return  null;
    }    
    public Pagereference getApprover()
    {
        getMultiApprover();
       return  null;
    }
   
    public List<QIRS_Action_Plan_Approver_List__c> getMultiApprover()
    {
      //List<SelectOption> options = new List<SelectOption>();

      Aplist = [select Id,Email__c,Phone__c,Approver_Contacted__c,User__r.Id,User__c,User__r.Name,User__r.MobilePhone,User__r.Phone from QIRS_Action_Plan_Approver_List__c where  
      Business__c =: strBusiness order by User__r.Name]; 
      for (Integer j=0;j<Aplist.size();j++)
      {
          MasterApprlist.add(Aplist[j].User__c);          
            if(strMode == 'EDIT')
            {
                if(objqirs != null)
                {
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver1__c && objqirs.Approver_Contacted1__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                  if(Aplist[j].User__r.Id == objqirs.Master_Approver2__c && objqirs.Approver_Contacted2__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver3__c && objqirs.Approver_Contacted3__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver4__c && objqirs.Approver_Contacted4__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver5__c && objqirs.Approver_Contacted5__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver6__c && objqirs.Approver_Contacted6__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver7__c && objqirs.Approver_Contacted7__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver8__c && objqirs.Approver_Contacted8__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver9__c && objqirs.Approver_Contacted9__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                   if(Aplist[j].User__r.Id == objqirs.Master_Approver10__c && objqirs.Approver_Contacted10__c == true)
                   {
                       Aplist[j].Approver_Contacted__c = true;
                       continue;
                   }
                }
            }

      }
      return Aplist;

     // return options;
    }
    public VOID getTEST()
    {
    }
    public List<SelectOption> getAlertType()
    {
       return  QIRSBasecontroller.getAlertTypesList(false);
    }
    public List<SelectOption> getSite()
    {
          return QIRSBasecontroller.getSitesList(false);
    }
    public List<SelectOption> getBusiness()
    {
          return QIRSBasecontroller.getBusinessList(false);
    }  
    public List<SelectOption> getStatus() 
    {
        return QIRSBasecontroller.getStatusList(true);
    }
     
}