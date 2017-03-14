@isTest
private class QIPPBCTDuplicateRecordValidation_Test
{
  
    static testmethod void test()
    {
        QIPP_Benefit_Conversion_Table__c bct = new QIPP_Benefit_Conversion_Table__c();
        bct.Financial_Impact_Calculation_Driver__c = 'NCDR';
        bct.Business_Line__c = 'VIPT';
        bct.Unit_of_Measure__c = 'Each';
        bct.Benefit_Type__c = 'CoPQ Reduction';
        bct.CoPQ_Type__c = 'Indirect Financial';
        bct.Impacted_P_L_Line__c = 'R&D Budget';
        bct.Directional_Indicator__c = 'Lower is Favorable';
        bct.Fiscal_Year__c = '2013';
        bct.Fiscal_Quarter__c = 'Q3';
        bct.CoPQ_Reduction_Conversion_Rate__c = 100;
        insert bct;
        
      
               
    }
}