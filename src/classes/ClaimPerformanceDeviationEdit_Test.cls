@isTest(SeeAllData=true)
public class ClaimPerformanceDeviationEdit_Test {

    public static testMethod void test1()
    {
             MCAR__c mcar = new MCAR__c();
             insert mcar;
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c='a0nU0000000NdT7';
        insert claimRec;
        
        
        
       Performance_Deviation_section__c pds = new Performance_Deviation_section__c();        
        pds.Claim__c=claimRec.id;
        pds.Performance_Measure_Name__c = 'test';
        pds.Associated_Part_Code__c= mcar.id;
        pds.Associated_Part_Code__c =mcar.Name;
        pds.Frequency_of_Measurement__c=2;
        pds.Actual_Measurement__c='test';
        pds.Measurement_Standard__c='%';
        
        insert pds;
        
         test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.standardController(pds);
        ApexPages.CurrentPage().getparameters().put('id', pds.id);
        ClaimPerformanceDeviationEdit cmd = new ClaimPerformanceDeviationEdit(sc);
        cmd.UpdatePerformance();
        
        cmd.PerDevId=pds.id;
        cmd.Claim=claimRec.id;
        test.stoptest();
        
    }
}