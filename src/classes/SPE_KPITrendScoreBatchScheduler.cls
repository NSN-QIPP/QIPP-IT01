public class SPE_KPITrendScoreBatchScheduler Implements Database.Batchable<sObject>, Schedulable, Database.Stateful
{
    Date trendingDate;
    Id cmId;
    Boolean isTrendingForPast;
    
    public SPE_KPITrendScoreBatchScheduler()
    {
    }
    
    public void execute(SchedulableContext sc) 
    {
        Database.executeBatch(this, 1);
    }
    
    public SPE_KPITrendScoreBatchScheduler(Date d, Id cmId, Boolean isTrendingForPast)
    {
        trendingDate = d;
        this.cmId = cmId;
        this.isTrendingForPast = isTrendingForPast;
    }
     
    public Database.queryLocator start(Database.BatchableContext bc)
    {
        String var = 'open';
        String SOQL;
        
        if (cmId != null)
        {
            SOQL = 'SELECT SPETracker__c, SPETracker__r.SPEPlan__r.Id, KPIName__c, Supplier__c, DateofExecution__c,  LatestKPITrend__c FROM SPE_ConsequenceManagement__c WHERE ID =: cmId AND SPETracker__c != null';
        }
        else
        {
            SOQL = 'SELECT SPETracker__c, SPETracker__r.SPEPlan__r.Id, KPIName__c, Supplier__c, DateofExecution__c,  LatestKPITrend__c FROM SPE_ConsequenceManagement__c WHERE TicketStatus__c =: var AND SPETracker__c != null';
        }
        
        return Database.getQueryLocator(SOQL);
    }

    public void execute(Database.BatchableContext bc, List<SPE_ConsequenceManagement__c > scope)
    {
        String PlanId = scope[0].SPETracker__r.SPEPlan__r.Id;
        
        String planid15Digit = PlanId.substring(0, 15);
        
        List<SPE_TrackerValues__c> trackerValues;
        
        if (trendingDate == null && !isTrendingForPast)
        {
            trackerValues = [SELECT Id, SPETracker__c FROM SPE_TrackerValues__c WHERE Supplier__c =: scope[0].Supplier__c
                             AND SPEPlanId__c =: planid15Digit  AND KPIDefinition__c =: scope[0].KPIName__c
                             AND DateOfExecution__c >= : scope[0].DateofExecution__c];
        }
        
        else if (isTrendingForPast)
        {
            trackerValues = [SELECT Id, SPETracker__c, DateOfExecution__c FROM SPE_TrackerValues__c WHERE Supplier__c =: scope[0].Supplier__c
                             AND SPEPlanId__c =: planid15Digit  AND KPIDefinition__c =: scope[0].KPIName__c
                             AND DateOfExecution__c <= : scope[0].DateofExecution__c ORDER BY DateOfExecution__c ASC];
            
            List<SPE_CMKPITrend__c> trendValuesToBeDeleted = [SELECT Id FROM SPE_CMKPITrend__c WHERE ConsequenceManagement__c =: scope[0].Id AND DateOfExecution__c <= : scope[0].DateofExecution__c];
            
            Delete trendValuesToBeDeleted;
            
        }
        
        else
        {
            trackerValues = [SELECT Id, SPETracker__c, DateOfExecution__c FROM SPE_TrackerValues__c WHERE Supplier__c =: scope[0].Supplier__c
                             AND SPEPlanId__c =: planid15Digit  AND KPIDefinition__c =: scope[0].KPIName__c
                             AND DateOfExecution__c = : trendingDate ORDER BY DateOfExecution__c ASC LIMIT 1];
        }
        
        List<SPE_CMKPITrend__c> trendValues = new List<SPE_CMKPITrend__c>();
        
        for (SPE_TrackerValues__c tv : trackerValues )
        {
            SPE_CMKPITrend__c trendValue = new SPE_CMKPITrend__c ();
            trendValue.ConsequenceManagement__c = scope[0].Id;
            trendValue.TrackerValue__c = tv.Id;
            trendValue.SPETracker__c = tv.SPETracker__c;
            trendValues.add(trendValue);
        }
        
        insert trendValues ;
        
    }

    public void finish(Database.BatchableContext bc) 
    {
    }
}