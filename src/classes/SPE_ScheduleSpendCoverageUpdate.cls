global class SPE_ScheduleSpendCoverageUpdate  implements Database.Batchable <sObject>, Database.Stateful , Schedulable 
{
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,1);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        String blank = '';
        String query = 'SELECT Id, BusinessLine__c, BusinessUnit__c, Product__c, Category__c, CategoryArea__c, CategoryGroup__c, Market__c, MarketUnit__c, '+
                        'Country__c, Project__c, Supplier__c, SPETracker__c, SPETracker__r.Name ' +
                        'FROM SPE_TrackerScore__c '+
                        'WHERE blank =: blank AND ' +
                        'SPEScore__c =: true AND CreatedDate > TODAY';
       
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<SPE_TrackerScore__c> scope) 
    {
        SPE_TrackerScore__c ts = scope[0];
        List<SPE_SpendCoverage__c> spendCoverages = [SELECT Id, Spend__c, Market__c, MarketUnit__c, Country__c, Project__c, CategoryArea__c, CategoryGroup__c,
                                                            Category__c, BusinessUnit__c, BusinessLine__c, Product__c, SPEPeriod__c, SpendNumber__c, Supplier__c 
                                                    FROM SPE_SpendCoverage__c 
                                                    WHERE Supplier__c =: scope[0].Supplier__c AND 
                                                          SPEPeriod__c =: scope[0].SPETracker__r.Name AND
                                                          IsSPEEvaluated__c = false];
        
        List<SPE_SpendCoverage__c> toBeUpdatedSpendCoverages = new List<SPE_SpendCoverage__c>(); 
        
        for (SPE_SpendCoverage__c sc: spendCoverages)
        {
            if ( ( (sc.Market__c == ts.Market__c || ts.Market__c == PicklistDefaultValues__c.getall().values()[0].Market__c) && 
                   (sc.MarketUnit__c == ts.MarketUnit__c || ts.MarketUnit__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c) &&
                   (sc.Country__c == ts.Country__c || ts.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c) &&
                   (sc.Project__c == ts.Project__c || ts.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c) 
                  ) &&
                 ( (sc.CategoryArea__c == ts.CategoryArea__c || ts.CategoryArea__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c) && 
                   (sc.CategoryGroup__c == ts.CategoryGroup__c || ts.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c) &&
                   (sc.Category__c == ts.Category__c || ts.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c) 
                  ) &&
                 ( (sc.BusinessUnit__c == ts.BusinessUnit__c || ts.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) && 
                   (sc.BusinessLine__c == ts.BusinessLine__c || ts.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c) &&
                   (sc.Product__c == ts.Product__c || ts.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c) 
                  ) 
                )
            {
                sc.IsSPEEvaluated__c = true;
                toBeUpdatedSpendCoverages.add(sc);
            }
        }
        
        update toBeUpdatedSpendCoverages;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
    }
    
}