global class SPE2_DeleteKPIIntermediate implements Database.Batchable<sObject>{
    global String kpiDefinationID; 
    global String query;
     global SPE2_DeleteKPIIntermediate(String kpiDefinationID){
        this.kpiDefinationID = kpiDefinationID;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        query = 'Select Id FROM KPI_IntermediateComputation__c Where KPI__c =: kpiDefinationID';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<KPI_IntermediateComputation__c> scope){ 
        delete scope;        
    }          
    global void finish(Database.BatchableContext BC){
        if(!Test.isRunningTest()){
            SPE2_DeletePITempValues dBatch = new SPE2_DeletePITempValues(kpiDefinationID);
            database.executebatch(dBatch,1000);
        }
    }      
}