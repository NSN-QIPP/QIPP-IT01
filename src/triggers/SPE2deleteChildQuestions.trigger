trigger SPE2deleteChildQuestions on SPE_SurveyQuestion__c (before delete) {
    List<SPE_SurveyQuestion__c> toDeleteQuestions = [Select Id,Question_Bank__c from SPE_SurveyQuestion__c Where Question_Bank__c IN: trigger.old];
    
    
    try{
        delete toDeleteQuestions;
    }catch(exception e){}
}