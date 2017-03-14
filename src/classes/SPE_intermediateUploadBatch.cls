global class SPE_intermediateUploadBatch implements Database.Batchable<SObject>,Schedulable{
 
    global String uniqueID;
    global String isExecuteinFinish;
    global SPE_intermediateUploadBatch(String s)
    {
        uniqueID= s;
    }
    //************New Constructor for Skip All Validation Part*****************//
    global SPE_intermediateUploadBatch(String s,String isExecutable){
        uniqueID= s;
        isExecuteinFinish = isExecutable;
    }
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(100));
        /*if(!Test.isRunningTest()){
        system.abortJob(sc.getTriggerId());
        }*/
        
    }
     
    global Database.QueryLocator start(Database.BatchableContext BC) {
        id p=userinfo.getuserId();
        return Database.getQueryLocator('select Id from SPE_PiValueTemp__c where createdByid=:p AND UniqueIdentifier__c =: uniqueID limit 49999');
    }
 
     global void execute(Database.BatchableContext BC, List <SPE_PiValueTemp__c > scope) {
         update scope;
    }
 
    global void finish(Database.BatchableContext bc){
    //************New Addition Part for Skip All Validation Functionality*****************//
        if(!Test.isRunningTest() && isExecuteinFinish == 'AsynchExecution'){
            SPE_PIUploadBatch ttBat = new SPE_PIUploadBatch(uniqueID);        
            Database.executeBatch(ttBat);
        }
    }
}