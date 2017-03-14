global class SPE_KPISchedulebatch5 implements Database.Batchable <sObject> , Schedulable {
    //global ID kpid;
    global void execute(SchedulableContext sc) {
        Database.executebatch(this,1);
    }

    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        Date d=system.today();
        d=d.addDays(integer.valueOf(Label.SPE_ScheduleDateModifier));
        String query='select id,ScheduledDate__c,Adhoc_Date__c,FrequencyinMonth__c from SPE_KPIDefinition__c where ScheduledDate__c=:d AND (LifecycleStage__c = \'Published\' OR LifecycleStage__c = \'Pilot\') ';
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPIDefinition__c> scope) {
        
        /*kpid = scope[0].ID;
        System.Debug('****KPIDefinationID'+kpid);
        System.Debug('****KPIDefinationID'+scope[0].ID);*/
        
        //*************************//
        if(scope[0].ScheduledDate__c != Null){
            scope[0].ScheduledDate__c= scope[0].ScheduledDate__c.addDays(1);
        }
        else if(scope[0].ScheduledDate__c == Null){
           scope[0].ScheduledDate__c = System.Today().addDays(1); 
        }
        //*************************//
        
        Date d = Date.newInstance(1960, 2, 17);
        d=(scope[0].ScheduledDate__c).addMonths(-1);        
        Integer numberOfDays = Date.daysInMonth(d.year(), d.month());
        d= Date.newInstance(d.year(), d.month(), numberOfDays);
        scope[0].Adhoc_Date__c=d;
        //commented for recurrence pattern implementation in SPE2.0
        //scope[0].ScheduledDate__c= scope[0].ScheduledDate__c.addMonths(integer.valueOf(scope[0].FrequencyinMonth__c)); 
       
        Update scope[0];
        scope[0].ScheduledDate__c= scope[0].ScheduledDate__c.addDays(-1);
        Update scope[0];

    }
    
    global void finish(Database.BatchableContext BC) {  
        //System.Debug('****KPIDefinationID'+kpid);
        //ID kpiID = this.kpid;
        
        Date d=system.today();
        d=d.addDays(integer.valueOf(Label.SPE_ScheduleDateModifier));      
        SPE_KPIDefinition__c KPIDefObj = new SPE_KPIDefinition__c();
        try{
        KPIDefObj = [Select ID,ScheduledDate__c,KPIValuesCalculation__c FROM SPE_KPIDefinition__c WHERE ScheduledDate__c=: d AND (LifecycleStage__c = 'Published' OR LifecycleStage__c = 'Pilot') Limit 1];
        
            if(KPIDefObj.KPIValuesCalculation__c == null){
                KPIDefObj.KPIValuesCalculation__c = 0;
            }
            KPIDefObj.KPIValuesCalculation__c = KPIDefObj.KPIValuesCalculation__c+1;
            Update KPIDefObj;
        }catch(Exception e){}
        
        SPE2KPINextScheduleUpdateBatch dtbatch= new SPE2KPINextScheduleUpdateBatch();
        database.executebatch(dtBatch,1); 
                  
    }
}