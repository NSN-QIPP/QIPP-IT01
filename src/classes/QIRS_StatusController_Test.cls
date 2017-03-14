@isTest
public class QIRS_StatusController_Test {

    static testmethod void test1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS Admin']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser1@testorg.com');
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
        qirsRec.Master_Approver__c= u.Id;
        qirsRec.Master_Approver1__c=u.Id;
        qirsRec.Master_Approver2__c=u.Id;
        qirsRec.Master_Approver3__c=u.Id;
        qirsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        insert qirsRec;
            
       Date newDate = date.today();  
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
        
            
       QIRS_Status__c qirStatus = new QIRS_Status__c();
            qirStatus.QIRS__c = qirsRec.Id;
            qirStatus.Status__c='app';
            insert qirStatus;
            
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirStatus);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        ApexPages.CurrentPage().getparameters().put('LQ1', 'Open');
        QIRS_StatusController obj1 = new QIRS_StatusController(sc);
        QIRS_StatusController obj2 = new QIRS_StatusController();
        obj2.getState();
        obj2.setState('ProgressYellow');
        obj2.methodOne();
        obj2.cancel();
        obj2.Save();
            
        test.stopTest();
    }
    }


 static testmethod void test2(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS Admin']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser1@testorg.com');
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
        qirsRec.Master_Approver__c= u.Id;
        qirsRec.Master_Approver1__c=u.Id;
        qirsRec.Master_Approver2__c=u.Id;
        qirsRec.Master_Approver3__c=u.Id;
        qirsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        insert qirsRec;
            
       Date newDate = date.today();  
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
        
            
       QIRS_Status__c qirStatus = new QIRS_Status__c();
            qirStatus.QIRS__c = qirsRec.Id;
            qirStatus.Status__c='app';
            insert qirStatus;
            
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirStatus);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        ApexPages.CurrentPage().getparameters().put('LQ1', 'app');
        QIRS_StatusController obj1 = new QIRS_StatusController(sc);
        QIRS_StatusController obj2 = new QIRS_StatusController();
        obj2.getState();
        obj2.setState('ProgressYellow');
        obj2.methodOne();
        obj2.cancel();
        obj2.Save();
            
        test.stopTest();
    }
 }     
    static testmethod void test3(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS Admin']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser1@testorg.com');
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
        qirsRec.Master_Approver__c= u.Id;
        qirsRec.Master_Approver1__c=u.Id;
        qirsRec.Master_Approver2__c=u.Id;
        qirsRec.Master_Approver3__c=u.Id;
        qirsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='';
        insert qirsRec;
            
       Date newDate = date.today();  
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
        
            
       QIRS_Status__c qirStatus = new QIRS_Status__c();
            qirStatus.QIRS__c = qirsRec.Id;
            qirStatus.Status__c='app';
            insert qirStatus;
            
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirStatus);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        ApexPages.CurrentPage().getparameters().put('LQ1', 'rej');
        QIRS_StatusController obj1 = new QIRS_StatusController(sc);
        QIRS_StatusController obj2 = new QIRS_StatusController();
        obj2.getState();
        obj2.setState('ProgressYellow');
        obj2.methodOne();
        obj2.cancel();
        obj2.statusValue='Approved';
        obj2.IsMasterApp=false;   
        obj2.Save();
            
        test.stopTest();
    }
    }    
    

}