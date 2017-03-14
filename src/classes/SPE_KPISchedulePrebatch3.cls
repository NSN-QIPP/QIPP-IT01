global class SPE_KPISchedulePrebatch3 implements Database.Batchable <sObject> , Schedulable {

    global void execute(SchedulableContext sc) {
        Database.executebatch(this,10000);
    }

    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        Date d=system.today();
        d=d.addDays(integer.valueOf(Label.SPE_ScheduleDateModifier));
        Set<string> k=new set<string>();
        k.add(SPE_Constants.KPICALC_MINSUPPLIER_AGGREGATION);
        k.add(SPE_Constants.KPICALC_MAXSUPPLIER_AGGREGATION);
        k.add(SPE_Constants.KPICALC_AVGSUPPLIER_AGGREGATION );


        String query='select id,PIDefination__c,TimeFrame__c,ConstantValue__c,KPIDefinition__c,Aggregation__c,index__c from SPE_KPICalculation__c where KPIDefinition__r.ScheduledDate__c=:d and Aggregation__c IN:k  AND (KPIDefinition__r.LifecycleStage__c = \'Published\' OR  KPIDefinition__r.LifecycleStage__c = \'Pilot\')';
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPICalculation__c> scope) {
    
        
        
        List<Supplier_KPI_Callculation__c> skc= new list<Supplier_KPI_Callculation__c>();
        for(SPE_KPICalculation__c k:scope)
         {
            Supplier_KPI_Callculation__c p = new Supplier_KPI_Callculation__c();
            p.enterpriseId__c= SPE_Constants.ENTERPRISEVALUEACROSS;
            p.KPI__c=k.KPIDefinition__c;
            p.KPI_Calculation__c=k.id;
            skc.add(p);
            }
         
      
            
        insert skc;

    }
    
    global void finish(Database.BatchableContext BC) {
      if(!Test.isRunningTest()){
     SPE_KPISchedulePrebatch3Exec dtBatch= new SPE_KPISchedulePrebatch3Exec (); 
     database.executebatch(dtBatch,1); 
          }
    }
}