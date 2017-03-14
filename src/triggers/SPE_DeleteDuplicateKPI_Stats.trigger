trigger SPE_DeleteDuplicateKPI_Stats on SPE_KPIStats__c (before insert,before update) 
{

    List<SPE_KPIStats__c> deletestats = new List<SPE_KPIStats__c>();
    deletestats = [Select ID from SPE_KPIStats__c where ExecutionPeriod__c =: Trigger.new[0].ExecutionPeriod__c];
    delete deletestats;

}