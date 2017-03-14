global class SPE_BatchScorecardUpdate implements Database.Batchable<sObject>,Schedulable {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT CreatedDate,Id,isScoreGenerated__c FROM SPE_ScoreCard__c WHERE CreatedDate = today';
        return Database.getQueryLocator(query);
    }
    
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(1));
    }
    
    global void execute(Database.BatchableContext BC, List<SPE_ScoreCard__c> scope) {
         for(SPE_ScoreCard__c a : scope)
         {
             a.isScoreGenerated__c= true;            
         }
         update scope;
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}