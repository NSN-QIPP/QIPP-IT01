@istest
public class TraceEmailStatus_test {



    static testmethod void test(){
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
       MCAR_Claim_Management__c Claim = new MCAR_Claim_Management__c();
        claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
        
        insert claim;    
       
        Trace_Email__c   trace = new Trace_Email__c();
        trace.Claim_ID__c = String.valueOf(claim.id);
        trace.Claim__c = claim.Id;
        trace.Number_Of_Times_Email_Opened__c = 2;
        insert trace;
       try{ 
        test.startTest();
        ApexPages.CurrentPage().getparameters().put('claimID', claim.id);
        ApexPages.StandardController sc = new ApexPages.standardController(claim);
        PageReference pageRef = Page.TraceEmailPage; 
        pageRef.getParameters().put('cid', String.valueOf(claim.Id));
        Test.setCurrentPage(pageRef);
        
        TraceEmailStatus tEmailStatus = new TraceEmailStatus();
        tEmailStatus.traceEmail();
        
        test.stopTest();
        
        }
        catch(Exception e){
        }        
    }
}