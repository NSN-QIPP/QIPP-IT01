@isTest
private class MCARPendingActionsTestClass {


public static testMethod void MCARPendingActionsTestMethod () {

   
    test.startTest();   
    PageReference pageRef = Page.MCARPendingApprovals;
    Test.setCurrentPage(pageRef);
    MCARPendingApprovalsController pendingApprController= new MCARPendingApprovalsController();
    pendingApprController.getquery();
    pendingApprController.getquery4d();
    pendingApprController.getquery5d();
    pendingApprController.getquery6d();        
    pendingApprController.getquery7d();        
    pendingApprController.getMcarListopen();        
    test.stopTest();    
}   

}