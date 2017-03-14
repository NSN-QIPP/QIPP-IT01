global class SPE_KPISchedulebatch2 implements Database.Batchable <sObject> , Schedulable {

    global void execute(SchedulableContext sc) {
        Database.executebatch(this,integer.valueOf(10000));
    }

    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        Date d=system.today();
        d=d.addDays(integer.valueOf(Label.SPE_ScheduleDateModifier));
        string k= SPE_Constants.CONSTANTVALUE ;
        String query='select id,PIDefination__c,TimeFrame__c,ConstantValue__c,KPIDefinition__c,Aggregation__c,index__c from SPE_KPICalculation__c where KPIDefinition__r.ScheduledDate__c=:d and Aggregation__c=:k AND (KPIDefinition__r.LifecycleStage__c = \'Published\' OR  KPIDefinition__r.LifecycleStage__c = \'Pilot\')';
        system.debug('**********Query'+query);
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPICalculation__c> scope) 
    {
    
        list<SPE_PITempValue__c> tobeinserted= new list<SPE_PITempValue__c> ();
    
        for(SPE_KPICalculation__c s:scope)
        {
            SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
            piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get(((system.today().addDays(integer.valueOf(Label.SPE_ScheduleDateModifier))).addMonths(-1)).month()) + ' - '+ String.valueOf((((system.today().addDays(integer.valueOf(Label.SPE_ScheduleDateModifier)))).addMonths(-1)).year());
            piTempValue.PIValue__c =String.valueOf(s.ConstantValue__c);
            piTempValue.Valuetype__c = SPE_Constants.PI_NUMBERVALUETYPE;
            piTempValue.KPIDefinition__c = s.KPIDefinition__c; 
            piTempValue.KPICalculation__c = s.id;
            piTempValue.IsConstant__c=true;
            piTempValue.Period__c = (system.today().addDays(integer.valueOf(Label.SPE_ScheduleDateModifier))).addMonths(-1);
            
            tobeinserted.add(piTempValue);
        }
        
        insert tobeinserted;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        if(!test.isRunningTest()){
            SPE_KPISchedulePrebatch3 dtBatch= new SPE_KPISchedulePrebatch3();
            database.executebatch(dtBatch,10000);
        }
    }
}