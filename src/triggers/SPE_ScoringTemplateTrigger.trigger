trigger SPE_ScoringTemplateTrigger on SPE_ScoringTemplate__c (before insert,before update) {
    if((Trigger.isInsert || Trigger.isUpdate) && (Trigger.isBefore)){
          SPE_ScoringTemplateTrigger.updateHierarchyFields(trigger.new);
    }
}