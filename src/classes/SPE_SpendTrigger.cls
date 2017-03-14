public with sharing class SPE_SpendTrigger 
{
    public static void spendCoverageCreate(List<SPE_Spend__c> spends)
    {
        List<SPE_SpendCoverage__c> toBeInstredSpendCoverages = new List<SPE_SpendCoverage__c>();
        for (SPE_Spend__c s: spends)
        {
            SPE_SpendCoverage__c sc = new SPE_SpendCoverage__c();
            
            sc.Spend__c = s.Id;
            sc.Market__c = s.Region__c;
            sc.MarketUnit__c = s.Sub_Region__c;
            sc.Country__c = s.Country__c;
            sc.Project__c = s.Project__c;
            sc.CategoryArea__c = s.CategoryArea__c;
            sc.CategoryGroup__c = s.CategoryGroup__c;
            sc.Category__c = s.Category__c;
            sc.BusinessUnit__c = s.Business_Unit__c;
            sc.BusinessLine__c = s.Business_Line__c;
            sc.Product__c = s.Product__c;
            sc.WBSElements__c = s.WBSElements__c;
            sc.NegoResponsible__c = s.Nego_Responsible__c;
            
            sc.Period__c = s.Period__c;
            if (sc.Period__c != null)
            {
                sc.SPEPeriod__c = SPE_Utility.monthsMap.get(sc.Period__c.month()) + ' - '+ String.valueOf(sc.Period__c.year());
            }
            sc.SpendNumber__c = s.Spend__c;
            sc.Supplier__c = s.EnterpriseId__c;
            
            toBeInstredSpendCoverages.add(sc);
        }
        
        insert toBeInstredSpendCoverages;
    }
}