public with sharing class SPE_ScorecardTrigger 
{

	public SPE_ScorecardTrigger(List<SPE_ScoreCard__c> scorecardList)
	{
		for (SPE_ScoreCard__c scoreCard: scorecardList)
		{
			Date strtDate = scoreCard.StartDate__c;
        
	        List<Date> toBeStartTracker = new List<Date>();
	            
	        while (strtDate <= scoreCard.EndDate__c )
	        {
	            toBeStartTracker.add(strtDate);
	            
	            strtDate = strtDate.addMonths(1);
	        }
	        
	        Set<String> trackerNames = new Set<String>();
            
	        for  (Date sDate : toBeStartTracker)
	        {
	            trackerNames.add(SPE_Utility.monthsMap.get(sDate.month()) + ' - '+ String.valueOf(sDate.year()));
	        }
			
			List<SPE_ScorecardSPETemplateMap__c> scoreCardSPETemplateMaps = [SELECT Id, SPETemplate__c, Weight__c
        	                                                                 FROM SPE_ScorecardSPETemplateMap__c
            	                                                             WHERE ScorecardTemplate__c=: scoreCard.ScorecardTemplate__c];
        
        	Set<Id> speTemplates = new Set<Id>();
        
        	for (SPE_ScorecardSPETemplateMap__c sst : scoreCardSPETemplateMaps)
	        {
	            speTemplates.add(sst.SPETemplate__c);
	        }
	        
	        List<SPE_SPEKPIMap__c> speKPImaps =  [SELECT Id, KPIDefinition__c, SPETemplate__c, KPI_Target__c 
	                                              FROM SPE_SPEKPIMap__c
	                                              WHERE SPETemplate__c IN: speTemplates];
	        
	        Map<Id, Map<Id, Decimal>> speKPItargetMaps = new Map<Id, Map<Id, Decimal>>();   
                                      
	        for (SPE_SPEKPIMap__c spe: speKPImaps)
	        {
	            Map<Id, Decimal> kpiTargetMaps = new Map<Id, Decimal>();
	            if (speKPItargetMaps.get(spe.SPETemplate__c) != null )
	            {
	                kpiTargetMaps = speKPItargetMaps.get(spe.SPETemplate__c);
	            }   
	            
	            kpiTargetMaps.put(spe.KPIDefinition__c, spe.KPI_Target__c);
	            
	            speKPItargetMaps.put(spe.SPETemplate__c, kpiTargetMaps);
	        }   
	        
        
        
        
		}
	}
	
	
}