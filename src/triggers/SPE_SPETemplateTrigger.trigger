trigger SPE_SPETemplateTrigger on SPE_SPETemplate__c (before delete, after update, before insert,before update) 
{
    if (Trigger.isDelete)
    {
        SPE_SPETemplateTrigger.DeleteValidation(trigger.old);
    }
    
   if (Trigger.isUpdate && Trigger.isAfter)
    {
      SPE_SPETemplateTrigger.UpdateKPIDefinition(trigger.new, trigger.oldMap);
    }
    
    if((Trigger.isInsert || Trigger.isUpdate) && (Trigger.isBefore)){
         SPE_SPETemplateTrigger.updateHierarchyFields(trigger.new);
      }
}