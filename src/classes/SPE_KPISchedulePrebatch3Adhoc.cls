global class SPE_KPISchedulePrebatch3Adhoc implements Database.Batchable <sObject> , Schedulable 
{
    global Id kpiIds;
    
    public SPE_KPISchedulePrebatch3Adhoc (String s)
    {
        kpiIds = s;
    }
    
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,10000);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Set<string> k=new set<string>();
        
        k.add('Min( Across Suppliers)');
        k.add('Max( Across Suppliers)');
        k.add('Avg( Across Suppliers)');

        Id kpiId = this.kpiIds;
        String query='select id,PIDefination__c,TimeFrame__c,ConstantValue__c,KPIDefinition__c,Aggregation__c,index__c from SPE_KPICalculation__c where KPIDefinition__c =:kpiId  and Aggregation__c IN:k';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPICalculation__c> scope) 
    {
        List<Supplier_KPI_Calculation_Adhoc__c> skc= new list<Supplier_KPI_Calculation_Adhoc__c>();
        for(SPE_KPICalculation__c k:scope)
        {
            Supplier_KPI_Calculation_Adhoc__c p = new Supplier_KPI_Calculation_Adhoc__c();
            p.KPI__c=k.KPIDefinition__c;
            p.KPI_Calculation__c=k.id;
            skc.add(p);
        }
      
        insert skc;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        if(!Test.isRunningTest())
        {
            SPE_KPISchedulePrebatch3ExecAdhoc dtBatch= new SPE_KPISchedulePrebatch3ExecAdhoc (kpiIds); 
            database.executebatch(dtBatch,1); 
        }
    }
}