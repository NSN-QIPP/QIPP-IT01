trigger DeleteAnswerFromAlternateLanguageTrigger on SPE_SurveyAnswer__c (before delete) {
    Set<Id> questionId = new Set<Id>();
    List<SPE_SurveyAnswer__c> altAns= new List<SPE_SurveyAnswer__c>();
    Set<Id> lstAnswer = new Set<ID>();
    for(SPE_SurveyAnswer__c sans : trigger.old){
        lstAnswer.add(sans.Id);
    }
    system.debug('lst answer ---'+lstAnswer);
    
    altAns = [Select Id from SPE_SurveyAnswer__c where PrimarySurvey_Answer__c in :lstAnswer];
    system.debug('alt answr is---'+altAns);
    if(altAns.size()>0){
    delete altAns;
    }
}