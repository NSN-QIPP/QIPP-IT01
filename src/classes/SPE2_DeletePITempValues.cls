global class SPE2_DeletePITempValues implements Database.Batchable<sObject>{
    global String kpiDefinationID; 
    global String query;
     global SPE2_DeletePITempValues(String kpiDefinationID){
        this.kpiDefinationID = kpiDefinationID;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        query = 'Select ID from SPE_PITempValue__c WHERE KPIDefinition__c =: kpiDefinationID';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<SPE_PITempValue__c> scope){ 
        delete scope;        
    }          
    global void finish(Database.BatchableContext BC){}
}