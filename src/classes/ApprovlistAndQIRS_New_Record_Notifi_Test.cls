@isTest
public class ApprovlistAndQIRS_New_Record_Notifi_Test{
    
   public static testMethod void ApproverlistValidationTriggerTest(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS']; 
        User u = new User(Alias = 'standt', Email='testQirsUsr@testorg.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', UserName='testQirsUsr@testorg.com');
        insert u;
        
        QIRS_Action_Plan_Approver_List__c tstObj = new QIRS_Action_Plan_Approver_List__c();
        tstObj.User__c = u.ID;
        insert tstObj;
   }
   
   public static testMethod void QIRS_New_Record_NotificationTriggerTest(){
       Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS']; 
        User u = new User(Alias = 'standt', Email='testQirsUsr@testorg.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', UserName='testQirsUsr@testorg.com');
        insert u;
        
        QIRS__c tstObj = new QIRS__c();
        tstObj.Process_Owner1__c = u.ID;
   } 
}