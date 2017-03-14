@isTest(SeeAllData=true)

public class ApprovalProcessActionTracker_test{

    static testmethod void Approvaltracker_1(){
    
        PageReference reference = Page.ApprovalProcessActionTrackerP;
        reference.getParameters().put('compareField','PortfolioOwner');
        reference.getParameters().put('orderType','asc');
        Test.setCurrentPage(reference);
        
        ApprovalProcessActionTracker  Apptrack = new ApprovalProcessActionTracker();
        ApprovalProcessActionTracker.compareField = 'PortfolioOwner';
        ApprovalProcessActionTracker.sortOrder = 'asc';
        Apptrack.actionTrackerProcessor();
        Apptrack.getCounter();
        Apptrack.Backtopreviouspage();        
        Apptrack.sortWrpLst();
        
        ApprovalProcessActionTracker  Apptrack1 = new ApprovalProcessActionTracker();
        ApprovalProcessActionTracker.compareField = 'Approvername';
        ApprovalProcessActionTracker.sortOrder = 'asc';
        Apptrack1.actionTrackerProcessor();
        Apptrack1.getCounter();
        Apptrack1.Backtopreviouspage();        
        Apptrack1.sortWrpLst();
        
        
       // Apptrack.compareField= 'Approvername';
       // Apptrack.sortOrder= 'desc';
       // Apptrack.sortWrpLst();
    }
    
    static testmethod void SubmittedDateExportcsv_1(){
        
        SubmittedDateExportcsv_cntr csv = new SubmittedDateExportcsv_cntr();
        csv.actionTrackerProcessor();
    }
}