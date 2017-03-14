trigger SPE_KPIValueTrigger on SPE_KPIValue__c (after Insert) {
set<string> exec= new set<String>();
for(SPE_KPIStats__c s:[select id,ExecutionPeriod__c from SPE_KPIStats__c where kpi__c=:trigger.new[0].KPIDefinition__c])
    exec.add(s.ExecutionPeriod__c);
                
                if(!exec.contains(trigger.new[0].ExecutionPeriod__c)) {
                SPE_KPIStats__c stats= new SPE_KPIStats__c();
                stats.kpi__c=trigger.new[0].KPIDefinition__c;
                stats.ExecutionPeriod__c=trigger.new[0].ExecutionPeriod__c;
                stats.Records__c=(trigger.new).size();
                insert stats;
                }
}