global class SPE_KPISchedulebatch1Adhoc implements Database.Batchable <sObject>,Schedulable 
{
    global Id kpiIds;
    
    public SPE_KPISchedulebatch1Adhoc (String s)
    {
        kpiIds = s;
    }

    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(9000));
          if(!Test.isRunningTest()){
        system.abortJob(sc.getTriggerId());
        }
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
        String query = 'SELECT Id FROM SPE_PITempValue__c WHERE KPIDefinition__c =: kpiId AND Createddate < today';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_PITempValue__c> scope) 
    {
        delete scope;
        //delete[select id from SPE_KPIStats__c where kpi__c=:kpiIds];
        delete[select id from SPE_KPIComments__c where KPI__c=:kpiIds];
        //delete[Select Id FROM KPI_IntermediateComputation__c Where KPI__c =: kpiIds];
    }
    
    global void finish(Database.BatchableContext BC) 
    {
       if(!Test.isRunningTest())
        {
        SPE_KPISchedulebatch2Adhoc dtBatch = new SPE_KPISchedulebatch2Adhoc(kpiIds); 
        database.executebatch(dtBatch,2000);
        }
    }
}