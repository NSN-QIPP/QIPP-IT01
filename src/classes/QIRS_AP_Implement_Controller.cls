public class QIRS_AP_Implement_Controller 
{


    public QIRS_Action_Plan__c objAP{get;set;}
    public string strSubtitleValue {get;set;}  
    
    public QIRS_AP_Implement_Controller() 
    {
        String strAP= System.currentPagereference().getParameters().get('id');
         //String strAP= 'a0GZ0000000Bl6j';
         //List<QIRS_Action_Plan__c> lstAP = new List<QIRS_Action_Plan__c>();      
         //lstAP = [select ID from QIRS_Action_Plan__c where Id =: strAP];
//             if(lstAP.Size()>0)          
       if(([select ID from QIRS_Action_Plan__c where Id =: strAP]).size()>0)
             {
                 objAP = [select Action_Plan_Counter__c,Implementation_Comment__c,Core_ID__c,ID, Name, Task__c,Action_Type__c,Implementation_Date__c, Approver__c,Champion__c,
                 QIRS__c,Reason1__c,Required_date__c,Status__c,CreatedBy.Name, 
                 Approver1__c,Approver2__c,Approver3__c,Approver4__c,Approver5__c,Approver6__c,Approver7__c,Approver8__c,Approver9__c,Approver10__c,
                 Champion1__c,Champion2__c,Champion3__c,Champion4__c,Champion5__c,Champion6__c,Champion7__c,Champion8__c,Champion9__c,Champion10__c
                 from QIRS_Action_Plan__c where Id =: strAP ];

                 if(objAP != null)
                 {
                     strSubtitleValue = objAP.Name;  
                     if(objAP.Implementation_Date__c == null)
                     {
                         objAP.Implementation_Date__c = Date.Today();
                     }
                    
                }
                 //strmultichamp = {objAP[0].Champion1,objAP[0].Champion2};                 
             }
    }


    public PageReference cancel() 
    {
        PageReference pageRef = new PageReference('/apex/QIRS_AP_PendingTask?type=ctask');
         pageRef.setRedirect(true);
         return pageRef;
    }


    public PageReference Submit() {
    //commented by tejas on Apr 11, 2012
        
    //Added by tejas on Apr 11,2012 as we received new change request            
            if(objAP.Implementation_Date__c > Date.TODAY())
            {
                objAP.Implementation_Date__c.addError('Implementation date can not be greater than today date.'); 
               return null;
            }
            
             objAP.Status__c = QIRSBasecontroller.BaseVarImplementedbyChampion;
             objAP.Status_Date1__c = Date.Today();
             Database.SaveResult sr = Database.update(objAP);
             if(sr.isSuccess())
             {
 
                Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
                app.setObjectId(objAP.id);
                Approval.ProcessResult result = Approval.process(app);
                
                PageReference pageRef = new PageReference('/' + objAP.QIRS__c);
                 pageRef.setRedirect(true);
                 return pageRef;
             } 
             else
             {
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to update entered data.')); 
                 return null;
             }
        return null;
    }

    static testMethod void testQIRS_AP_Implement_Controller()
    {List<String> strNSNQIRS =new List<String>();
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
           
           objqirs.Impacted_Region__c = 'Asia';           
           objqirs.Countries__c = 'China';           
             insert objqirs;   
                List<QIRS__c> lstQirs = new List<QIRS__c>();             
             lstQirs.add(objqirs);      
        date myDate = date.today();
      date newDate = mydate.addDays(-1);
         QIRS_Action_Plan__c objAP1 = new QIRS_Action_Plan__c();
         objAP1.Action_Plan_Counter__c = 1;
         objAP1.Action_Type__c = 'Containment';
         objAP1.Approver__c = 'TestApp';
         objAP1.Approver1__c = UserInfo.getUserId();
         objAP1.Approver10__c = UserInfo.getUserId();
         objAP1.Approver2__c = UserInfo.getUserId();
         objAP1.Approver3__c = UserInfo.getUserId();
         objAP1.Approver4__c = UserInfo.getUserId();
         objAP1.Approver5__c =UserInfo.getUserId();
         objAP1.Approver6__c =UserInfo.getUserId();
         objAP1.Approver7__c =UserInfo.getUserId();
         objAP1.Approver8__c =UserInfo.getUserId();
         objAP1.Approver9__c =UserInfo.getUserId();
         objAP1.Champion__c = 'TestChamp';
         objAP1.Champion1__c = UserInfo.getUserId();
         objAP1.Champion10__c = UserInfo.getUserId();
         objAP1.Champion2__c = UserInfo.getUserId();
         objAP1.Champion3__c = UserInfo.getUserId();
         objAP1.Champion4__c = UserInfo.getUserId();
         objAP1.Champion5__c =UserInfo.getUserId();
         objAP1.Champion6__c =UserInfo.getUserId();
         objAP1.Champion7__c =UserInfo.getUserId();
         objAP1.Champion8__c =UserInfo.getUserId();
         objAP1.Champion9__c =UserInfo.getUserId();
         objAP1.QIRS__c =objqirs.ID;         
         objAP1.Task__c ='Test Task';
         objAP1.Status__c ='Pending for Champion';
         objAP1.Required_date__c  = newDate;  
         objAP1.Implementation_Date__c = Date.Today();  
         insert objAP1;
          QIRS_Action_Plan__c objAP2 = new QIRS_Action_Plan__c();
         objAP2.Action_Plan_Counter__c = 1;
         objAP2.Action_Type__c = 'Containment';
         objAP2.Approver__c = 'TestApp';
         objAP2.Approver1__c = UserInfo.getUserId();
         objAP2.Approver10__c = UserInfo.getUserId();
         objAP2.Approver2__c = UserInfo.getUserId();
         objAP2.Approver3__c = UserInfo.getUserId();
         objAP2.Approver4__c = UserInfo.getUserId();
         objAP2.Approver5__c =UserInfo.getUserId();
         objAP2.Approver6__c =UserInfo.getUserId();
         objAP2.Approver7__c =UserInfo.getUserId();
         objAP2.Approver8__c =UserInfo.getUserId();
         objAP2.Approver9__c =UserInfo.getUserId();
         objAP2.Champion__c = 'TestChamp';
         objAP2.Champion1__c = UserInfo.getUserId();
         objAP2.Champion10__c = UserInfo.getUserId();
         objAP2.Champion2__c = UserInfo.getUserId();
         objAP2.Champion3__c = UserInfo.getUserId();
         objAP2.Champion4__c = UserInfo.getUserId();
         objAP2.Champion5__c =UserInfo.getUserId();
         objAP2.Champion6__c =UserInfo.getUserId();
         objAP2.Champion7__c =UserInfo.getUserId();
         objAP2.Champion8__c =UserInfo.getUserId();
         objAP2.Champion9__c =UserInfo.getUserId();
         objAP2.QIRS__c =objqirs.ID;         
         objAP2.Task__c ='Test Task';
         objAP2.Status__c ='Pending for Champion';
         objAP2.Required_date__c  = newDate;  
         objAP2.Implementation_Date__c = newDate;  
         insert objAP2;
        List<QIRS_Action_Plan__c> testAP = new List<QIRS_Action_Plan__c>();
        testAP.Add(objAP2);
         ApexPages.CurrentPage().getParameters().put('id', objAP1.Id);
        QIRS_AP_Implement_Controller controller = new QIRS_AP_Implement_Controller();
       
        
       // controller.lstAP =testAP;
         controller.objAP = objAP1;
         controller.strSubtitleValue = 'Test';
         controller.Submit();
         
         
         controller.objAP = objAP2;
         controller.Submit();
         controller.cancel();
    }
}