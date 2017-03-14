public with sharing class SPE_ScoreCardAbandonedExt 
{   
    private Id scoreCardId;
    
    public SPE_ScoreCardAbandonedExt( ApexPages.StandardController st)
    {
        scoreCardId= st.getId();
    }
    
    public PageReference abandoned()
    {
       List<SPE_ScorecardTracker__c> toBeAbandonedTracker = [SELECT Id, ScorecardGenerator__c, Status__c 
                                                          FROM SPE_ScorecardTracker__c
                                                          WHERE Status__c =:SPE_Constants.STATUS_PENDING  AND  ScorecardGenerator__c=: scoreCardId];
                                                          
        for (SPE_ScorecardTracker__c tracker : toBeAbandonedTracker)
        {
            tracker.Status__c = SPE_Constants.STATUS_ABANDONED;
            //toBeInsertedSPETracker.add(tracker);
        }
        update toBeAbandonedTracker;
        
        PageReference pg = new PageReference('/'+scoreCardId);
        
        return pg;
       
    }
}