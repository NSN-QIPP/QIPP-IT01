trigger SPE_SPEPlanTrigger on SPE_SPEPlan__c ( before delete, after update)
{   
    if (Trigger.isDelete)
    {
        SPE_SPEPlanTrigger.DeleteValidation(trigger.old);
    }
    if (Trigger.isUpdate && Trigger.isAfter)
    {
        //SPE_SPEPlanTrigger.UpdateSPETemplate(trigger.new, trigger.oldMap);
    }          
}