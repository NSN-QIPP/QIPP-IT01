@isTest
public with sharing class QIRS_Action_Plan_RecordController_Test{
    
   static testmethod void test1()
     {    
        QIRS__c i=new QIRS__c();
        ApexPages.StandardController con = new ApexPages.StandardController(i);
        QIRS_Action_Plan_RecordController aa = new QIRS_Action_Plan_RecordController(con); 
        aa.QIRS_Tag='Master Analysis';
        aa.getPendingQIRSApprovalDetails();
     }
     }