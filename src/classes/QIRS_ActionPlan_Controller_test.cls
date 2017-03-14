@isTest(SeeAllData=false)
public class QIRS_ActionPlan_Controller_test {
    static testmethod void test1(){
        QIRS_Admin_Profile__c qirsAdmProfile = new QIRS_Admin_Profile__c(Name='QIRSAdminProfileIDValue', QIRS_Admin_Profile_ID__c='00eU0000000F08xIAC');
            insert qirsAdmProfile;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS Admin']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =qirsAdmProfile.QIRS_Admin_Profile_ID__c, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser@testorg.com');
        system.runAs(u){
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Process_Owner1__c=u.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Issue_Level__c='Medium';
        insert qirsRec;
        Date newDate= Date.today();
        QIRS_Action_Plan__c actionPlanRec = new QIRS_Action_Plan__c();
        actionPlanRec.Status__c='Open';
        actionPlanRec.QIRS__c=qirsRec.Id;
        actionPlanRec.Reason1__c=qirsRec.Problem_Description1__c;
        actionPlanRec.Required_date__c= system.today()+5;
        actionPlanRec.IsRecall__c=true;
        actionPlanRec.IsChampChange__c=true;
        actionPlanRec.IsApproverChange__c=true;
        actionPlanRec.ActionPlanDelayedFlag__c=true;
        actionPlanRec.ActionPlanExpiredFlag__c=true;
        actionPlanRec.ManagerEsclationFlag__c=true;   
        actionPlanRec.Action_Plan_Counter__c=2;
        actionPlanRec.Implementation_Comment__c='test comments';
        actionPlanRec.Core_ID__c='test ';
        actionPlanRec.Task__c='test ';
        actionPlanRec.Action_Type__c='Containment/Temporal Solution';
        actionPlanRec.Implementation_Date__c= newDate.addDays(5);
        actionPlanRec.CreatedByID=u.Id;
        insert actionPlanRec;
        
         
            
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', actionPlanRec.id);
        ApexPages.CurrentPage().getparameters().put('qirsid', qirsRec.id);
        QIRS_ActionPlan_Controller obj1= new QIRS_ActionPlan_Controller(sc);
        obj1.Isvisible= true;
        obj1.Save();
        obj1.cancel();
        obj1.AddRefCode(String.valueOf(qirsRec));
 
        test.stopTest();
        
    }
    }

    
    static testmethod void test2(){
        QIRS_Admin_Profile__c qirsAdmProfile = new QIRS_Admin_Profile__c(Name='QIRSAdminProfileIDValue', QIRS_Admin_Profile_ID__c='00eU0000000F08xIAC');
            insert qirsAdmProfile;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS Admin']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =qirsAdmProfile.QIRS_Admin_Profile_ID__c, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser@testorg.com');
        system.runAs(u){
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Process_Owner1__c=u.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Issue_Level__c='Medium';
        insert qirsRec;
        date newDate = Date.today();
        QIRS_Action_Plan__c actionPlanRec = new QIRS_Action_Plan__c();
        actionPlanRec.Status__c='Open';
        actionPlanRec.QIRS__c=qirsRec.Id;
        actionPlanRec.Reason1__c=qirsRec.Problem_Description1__c;
        actionPlanRec.Required_date__c= newDate.addDays(-2);
        actionPlanRec.IsRecall__c=true;
        actionPlanRec.IsChampChange__c=true;
        actionPlanRec.IsApproverChange__c=true;
        actionPlanRec.ActionPlanDelayedFlag__c=true;
        actionPlanRec.ActionPlanExpiredFlag__c=true;
        actionPlanRec.ManagerEsclationFlag__c=true;   
        actionPlanRec.Action_Plan_Counter__c=2;
        actionPlanRec.Implementation_Comment__c='test comments';
        actionPlanRec.Core_ID__c='test ';
        actionPlanRec.Task__c='test ';
        actionPlanRec.Action_Type__c='Containment/Temporal Solution';
        actionPlanRec.Implementation_Date__c=Date.TODAY();
        actionPlanRec.CreatedByID=u.Id;
        insert actionPlanRec;
        
         
            
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        //ApexPages.CurrentPage().getparameters().put('id', actionPlanRec.id);
        ApexPages.CurrentPage().getparameters().put('qirsid', qirsRec.id);
        QIRS_ActionPlan_Controller obj1= new QIRS_ActionPlan_Controller(sc);
        
        obj1.Save();
        //obj1.cancel();
        //obj1.AddRefCode(String.valueOf(qirsRec));
 
        test.stopTest();
        
    }
    }
}