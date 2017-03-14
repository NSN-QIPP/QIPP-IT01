@isTest
private class MCARPendingMyActionsTestClass {


public static testMethod void MCARPendingMyActionsTestMethod () {

   
    test.startTest();   
    PageReference pageRef = Page.MCARPendingMyApprovals;
    Test.setCurrentPage(pageRef);
    MCARPendingMyApprovalsController pendingApprController= new MCARPendingMyApprovalsController();
    pendingApprController.getquery();
    pendingApprController.getquery4d();
    pendingApprController.getquery5d();
    pendingApprController.getquery6d();        
    pendingApprController.getquery7d();        
    pendingApprController.getMcarListopen();        
    test.stopTest();    
}   

}