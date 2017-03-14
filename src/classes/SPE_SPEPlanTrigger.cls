public with sharing class SPE_SPEPlanTrigger
{
	public static void DeleteValidation(List<SPE_SPEPlan__c> oldSPEPlan)
	{
		for(SPE_SPEPlan__c rec : oldSPEPlan)
	    {
	    	List < SPE_SPETracker__c > lstTracker = [ Select Status__c FROM SPE_SPETracker__c where SPEPlan__c =: rec.id  ];
			
			for (SPE_SPETracker__c  tracker : lstTracker )
			{
				if (tracker.Status__c ==  'Completed')
				{
					rec.addError('You cannot delete SPE Plan for competed tracker status');
					break;
				}
			}
	    }
	}
	
	public static void UpdateSPETemplate(List<SPE_SPEPlan__c> newSPEPlans, Map<Id, SPE_SPEPlan__c> oldSPEPlanMaps)
	{	
		Set<Id> speTempIds = new Set<Id>();
		
		List<SPE_SPETracker__c> toBeUpdatedTracker = new List<SPE_SPETracker__c>();
		
		List<SPE_SPETemplate__c> toBeUpdatedSPETemplate = new List<SPE_SPETemplate__c>();
			
		for (SPE_SPEPlan__c spe : newSPEPlans)
		{
			if (spe.Stage__c == 'Published' && spe.Stage__c != oldSPEPlanMaps.get(spe.Id).Stage__c )
			{
				speTempIds.add(spe.SPETemplate__c);
			}
			
			else if (spe.Stage__c ==  'Obsolete')
			{
				List <SPE_SPETracker__c> lstTracker = [ Select Status__c FROM SPE_SPETracker__c where SPEPlan__c =: spe.id  ];
				
				for (SPE_SPETracker__c  tracker : lstTracker )
				{
					if (tracker.Status__c ==  'Pending')
                	{
                		tracker.Status__c = 'Abandoned';
                		
                		toBeUpdatedTracker.add(tracker);
                	}
				}
				
			}
		}
		
		if (speTempIds.size() > 0)
		{
			for (SPE_SPETemplate__c speTemplates : [SELECT Id, Stage__c FROM SPE_SPETemplate__c WHERE Id In: speTempIds AND Stage__c = 'Draft'])
			{
				SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
				speTemp.Id = speTemplates.Id;
				speTemp.Stage__c = 'Published';
				
				toBeUpdatedSPETemplate.add(speTemp);
			}
		}
		
		update toBeUpdatedSPETemplate;
		update toBeUpdatedTracker;
	}
}