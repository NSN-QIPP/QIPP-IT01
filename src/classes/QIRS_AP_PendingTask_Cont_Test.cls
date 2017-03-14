@isTest
public with sharing class QIRS_AP_PendingTask_Cont_Test {

   static testmethod void test1()
     {
         QIRS__c qirs = new Qirs__c();
         
        ApexPages.StandardController con = new ApexPages.StandardController(qirs);
        QIRS_AP_PendingTask_Controller ap = new QIRS_AP_PendingTask_Controller();
              
               Test.setCurrentPageReference(new PageReference('ctask')); 
       
        PageReference pageRef = Page.QIRS_AP_PendingTask;
        Test.setCurrentPage(pageRef);
      
        ap = new QIRS_AP_PendingTask_Controller();
        
    
        ApexPages.currentPage().getParameters().put('type', 'ctask');
        
        ap.CurrentID1 ='005Z0000000Hnsp';
        ap.Type ='ctask';
        ap.QIRS_Action_plan_Tag ='Pending Tasks';
        ap.Approve_Flag =true;
        ap.Reassign_Flag =false;
        ap.getPendingTask();
        ap.Reassign();
        ap.ApprRej();
        ap = new QIRS_AP_PendingTask_Controller();
        
       ApexPages.currentPage().getParameters().put('type', 'atask');
        ap.CurrentID1 ='';
        ap.Type ='atask';
        ap.QIRS_Action_plan_Tag ='Task Analysis';
        ap.Approve_Flag = true;
        ap.Reassign_Flag = false;
        ap.getPendingTask();
        ap.Reassign();
        //ap.ApprRej();
         ap = new QIRS_AP_PendingTask_Controller(); 
         
        ApexPages.currentPage().getParameters().put('type', 'dtask');
        ap.CurrentID1 ='005Z0000000Hnsp';
        ap.Type ='dtask';
        ap.QIRS_Action_plan_Tag ='Delegate My Actions';
        ap.Approve_Flag = false;
        ap.Reassign_Flag = true;
        ap.getPendingTask();
        ap.Reassign();
        //ap.ApprRej();
         ap = new QIRS_AP_PendingTask_Controller();
     }
}