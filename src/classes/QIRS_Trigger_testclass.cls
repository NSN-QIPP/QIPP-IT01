@istest
private class QIRS_Trigger_testclass{      
   
   public static TestMethod void testQIRS_MCAR_Update()
    {
               test.startTest();
           String Type='';
       List<Profile> tempprofile = new List<Profile>(); 
         String[] Profile = new String[] {'Nokia QIRS','Nokia QIRS Admin'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];
         List<String> strNSNQIRS =new List<String>();
         for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
             List<User> userlist= new List<User>();
             userlist= [select Id,Name from User where  IsActive = true and ProfileId In : strNSNQIRS order by Name]; 
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
             QIRS_MCAR__c objmcar = new QIRS_MCAR__c();
             objmcar.MCAR_Code__c='123';
             objmcar.QIRS__c=objqirs.Id;
             insert objmcar;
             List<QIRS_MCAR__c> lstmacr =[select Name from QIRS_MCAR__c  where Id =: objmcar.Id];
             delete lstmacr[0];
             
             QIRS_Action_Plan__c qirsAP = new QIRS_Action_Plan__c();
             
             qirsAP.QIRS__c = objqirs.Id;
             qirsAP.Action_Type__c = 'corrective';
             qirsAP.Task__c = 'test';
             qirsAP.Required_date__c = Date.today(); 
             qirsAP.Status__c = 'Rejected';           
             insert qirsAP;
             
             objqirs.Status__c = 'Closed';
             update objqirs; 
                         

           test.stopTest();
    }
public static TestMethod void testSiteNotificationValidation()
    {
             test.startTest();
             QIRS_Site_Notification__c objqsn = new QIRS_Site_Notification__c();
             objqsn.Business_Group__c='CDMA';
             objqsn.Email__c='tejas.kardile1984@gmail.com';
             objqsn.Site__c='Aichi Japan (Flextronic)';
             insert objqsn;
             test.stopTest();
    }
public static TestMethod void testdeleteBusinessGrpNotification()
    {
             test.startTest();
             QIRS_Watchlist_Notification__c objwn = new QIRS_Watchlist_Notification__c();
             objwn.Email__c='tejas.kardile1984@gmail.com';
             insert objwn;
             test.stopTest();
    }    
    
   
}