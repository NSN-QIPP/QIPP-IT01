trigger SPE_ScorecardTemplateTrigger on SPE_ScorecardTemplate__c (after update, before delete) 
{
	if (Trigger.isDelete)
	{
		SPE_ScorecardTemplateTrigger.DeleteValidation(trigger.old);
	}
	
	if (Trigger.isUpdate && Trigger.isAfter)
	{
		SPE_ScorecardTemplateTrigger.UpdateSPETemplate(trigger.new, trigger.oldMap);
	}
}