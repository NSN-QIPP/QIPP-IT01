global class SPE_PIEqualsKPISchedulebatch1Adhoc implements Database.Batchable <sObject>,Schedulable 
{
    global Id kpiIds;
    global Date fromDate;
    global Date toDate;
    
    public SPE_PIEqualsKPISchedulebatch1Adhoc (String s)
    {
        kpiIds = s;
        List<SPE_KPIDefinition__c> lstKPIDef = [SELECT Id, FromDate__c,ToDate__c FROM SPE_KPIDefinition__c where ID=:s];
        fromDate = lstKPIDef[0].FromDate__c;
        toDate = lstKPIDef[0].ToDate__c;
    }

    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(10000));
         if(!Test.isRunningTest()){
        system.abortJob(sc.getTriggerId());
        }
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
        String query = 'SELECT ID,Period__c FROM SPE_KPIValue__c WHERE KPIDefinition__c =: kpiId AND Period__c >= :fromDate AND Period__c <= :toDate' ;
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPIValue__c> scope) 
    {
        
        delete scope;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
          if(!Test.isRunningTest())
        {
        SPE_PIEqualsKPISchedulebatch2Adhoc dtBatch = new SPE_PIEqualsKPISchedulebatch2Adhoc(kpiIds); 
        database.executebatch(dtBatch,10000);
        }
        
    }
}