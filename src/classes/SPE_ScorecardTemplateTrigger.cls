public with sharing class SPE_ScorecardTemplateTrigger 
{
   public static void DeleteValidation (List<SPE_ScorecardTemplate__c> oldScorcardTemps)
    {
        for(SPE_ScorecardTemplate__c score : oldScorcardTemps)
        {
            if(score.Stage__c == 'Published')
            {
                score.addError('You cannot delete Scorecard Template');
            }
        }
    }
    
    public static void UpdateSPETemplate(List<SPE_ScorecardTemplate__c> newScorecardTemps, Map<Id, SPE_ScorecardTemplate__c> oldScorecardTemps)
    {
        Set<Id> scorecardTempIds = new Set<Id>();
        
        for (SPE_ScorecardTemplate__c score : newScorecardTemps)
        {
            if (score.Stage__c == 'Published' && score.Stage__c != oldScorecardTemps.get(score.Id).Stage__c )
            {
                scorecardTempIds.add(score.Id);
            }
        }
        
        if (scorecardTempIds.size() > 0)
        {
            List<SPE_SPETemplate__c> toBeUpdatedSPETemplates = new List<SPE_SPETemplate__c>();
            
            Set<Id> speTempIds = new Set<Id>();
            
            for (SPE_ScorecardSPETemplateMap__c scoreSPETemp : [SELECT ScorecardTemplate__c, SPETemplate__c 
                                             FROM SPE_ScorecardSPETemplateMap__c 
                                             WHERE ScorecardTemplate__c In: scorecardTempIds 
                                             AND SPETemplate__r.Stage__c = 'Draft'])
            {
                if (speTempIds.contains(scoreSPETemp.SPETemplate__c) == false)
                {
                    SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
                    speTemp.Id = scoreSPETemp.SPETemplate__c;
                    speTemp.Stage__c = 'Published';
                    
                    toBeUpdatedSPETemplates.add(speTemp);
                    
                    speTempIds.add(scoreSPETemp.SPETemplate__c);
                }
            }
            
            update toBeUpdatedSPETemplates;
        }
    }
}