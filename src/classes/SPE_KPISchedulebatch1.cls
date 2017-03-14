global class SPE_KPISchedulebatch1 implements Database.Batchable <sObject> , Schedulable 
{

    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(10000));
    }

    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Date d=system.today();
        d=d.addDays(integer.valueOf(Label.SPE_ScheduleDateModifier));
        system.debug('*********Date'+d);
        String query='select id,KPIDefinition__c from SPE_PITempValue__c where KPIDefinition__r.ScheduledDate__c=:d AND (KPIDefinition__r.LifecycleStage__c = \'Published\' OR  KPIDefinition__r.LifecycleStage__c = \'Pilot\' ) AND Createddate < today';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_PITempValue__c> scope) 
    {
        Set<Id> kpiIds = new Set<Id>(); 
        if (scope.size() > 0 )
        {
            for (SPE_PITempValue__c spePITemp : scope)
            {
                kpiIds.add(spePITemp.KPIDefinition__c);
            }
        }
        delete scope;  
        delete[select id from SPE_KPIComments__c where KPI__c=:kpiIds];
    }
    
    global void finish(Database.BatchableContext BC) 
    {
      if(!Test.isRunningTest())
        {
        SPE_KPISchedulebatch2 dtBatch = new SPE_KPISchedulebatch2(); 
        database.executebatch(dtBatch,10000);
        }
    }
}