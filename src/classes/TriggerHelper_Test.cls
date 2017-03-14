@isTest
private class TriggerHelper_Test{
    private static testmethod void test1(){
        TriggerHelper obj = new TriggerHelper();
        
        TriggerHelper.checkRecursive_AssignContactsForApprovalProcess();
        TriggerHelper.checkRecursive();
        TriggerHelper.checkRecursive1();
        TriggerHelper.checkRecursive2();
        TriggerHelper.checkRecursive3();
        
        
        TriggerHelper.alreadyModified = false;
        TriggerHelper.alreadyModified1 = false;
        TriggerHelper.alreadyModified2 = false;
        TriggerHelper.alreadyModified3 = false;
        TriggerHelper.alreadyModified4 = false;                                
        TriggerHelper.checkRecursive_AssignContactsForApprovalProcess();
        TriggerHelper.checkRecursive();
        TriggerHelper.checkRecursive1();
        TriggerHelper.checkRecursive2();
        TriggerHelper.checkRecursive3();        
    }
}