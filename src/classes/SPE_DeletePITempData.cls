global class SPE_DeletePITempData implements Database.batchable<sobject>,Schedulable 
{

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
         date d=system.today().addDays(-2);    
        string query='Select id from SPE_PiValueTemp__c where CreatedDate <= :d ';
        return database.getQuerylocator(query);
    }

      global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(9999));
          if(!Test.isRunningTest()){
        system.abortJob(sc.getTriggerId());
        }
    }
    
     global void execute(Database.BatchableContext BC, List <SPE_PiValueTemp__c> scope) 
    {
        delete scope;
    }
    global void finish(database.batchablecontext bc)
    {
        
    }
 
}