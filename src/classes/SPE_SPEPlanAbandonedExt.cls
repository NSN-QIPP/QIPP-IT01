public with sharing class SPE_SPEPlanAbandonedExt 
{	
	private Id spePlanId;
	
	public SPE_SPEPlanAbandonedExt( ApexPages.StandardController st)
	{
		spePlanId = st.getId();
	}
	
	public PageReference abandoned()
	{
		List<SPE_SPETracker__c> toBeAbandonedTracker = [SELECT Id, SPEPlan__c, Status__c 
                                                          FROM SPE_SPETracker__c
                                                          WHERE Status__c =  'Pending' AND  SPEPlan__c =: spePlanId];
                                                          
        for (SPE_SPETracker__c tracker : toBeAbandonedTracker)
        {
            tracker.Status__c = 'Abandoned';
            //toBeInsertedSPETracker.add(tracker);
        }
        update toBeAbandonedTracker;
        
        PageReference pg = new PageReference('/'+spePlanId);
        
        return pg;
	}
}