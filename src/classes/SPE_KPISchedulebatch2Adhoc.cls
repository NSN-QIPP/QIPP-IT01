global class SPE_KPISchedulebatch2Adhoc implements Database.Batchable <sObject> , Schedulable 
{
    global Id kpiIds;
    
    public SPE_KPISchedulebatch2Adhoc (String s)
    {
        kpiIds = s;
    }
    
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(2000));
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
    
        System.debug('=========>'+kpiId);   
        string k='Constant';
        String query='select id, PIDefination__c, TimeFrame__c, ConstantValue__c, KPIDefinition__c, Aggregation__c, index__c from SPE_KPICalculation__c where KPIDefinition__c =:kpiId  and Aggregation__c=:k';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPICalculation__c> scope) 
    {
        List<SPE_PITempValue__c> tobeinserted= new List<SPE_PITempValue__c> ();
        SPE_KPIDefinition__c kpi= new SPE_KPIDefinition__c ();
        kpi=[select id,Adhoc_Date__c from SPE_KPIDefinition__c where Id =: kpiIds ] ;
    
        for(SPE_KPICalculation__c s:scope)
        {
            SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
            piTempValue.ExecutionPeriod__c =SPE_Utility.monthsMap.get((kpi.adhoc_date__c.addMonths(-1)).month())+' - '+ String.valueOf((kpi.adhoc_date__c.addMonths(-1)).year());
            piTempValue.PIValue__c =String.valueOf(s.ConstantValue__c);
            piTempValue.Valuetype__c = 'Number';
            piTempValue.KPIDefinition__c = s.KPIDefinition__c; 
            piTempValue.KPICalculation__c = s.id;
            piTempValue.IsConstant__c=true;
            piTempValue.Period__c = kpi.adhoc_date__c.addMonths(-1);
            tobeinserted.add(piTempValue);
        }
        
        insert tobeinserted;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        System.debug('=========>'+kpiIds);  
           if(!test.isRunningTest()){
        SPE_KPISchedulePrebatch3Adhoc dtBatch= new SPE_KPISchedulePrebatch3Adhoc(kpiIds);
        database.executebatch(dtBatch,2000);
        }
    }
}