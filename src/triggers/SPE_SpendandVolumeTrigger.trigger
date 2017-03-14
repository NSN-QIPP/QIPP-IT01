trigger SPE_SpendandVolumeTrigger on SPE_SpendandVolume__c (before insert, before update) 
{
    for (SPE_SpendandVolume__c  sv: trigger.new)
    {
        if (sv.Period__c != null)
        {
            sv.SPEPeriod__c = SPE_Utility.monthsMap.get(sv.Period__c.month()) + ' - '+ String.valueOf(sv.Period__c.year());
        }
    }

}