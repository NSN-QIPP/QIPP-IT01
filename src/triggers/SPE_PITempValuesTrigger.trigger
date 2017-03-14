trigger SPE_PITempValuesTrigger on SPE_PITempValue__c (before Insert) 
{
    Set<Id> AccountenterpriseId = new Set<Id>();
    
    for (SPE_PITempValue__c temp : Trigger.New)
    {
        AccountenterpriseId.add(temp.EnterpriseIDEncrypted__c);
    }
    
    Map<Id, Account> suppIDMap = new Map<Id, Account>([Select ID,EnterpriseID__c FROM Account WHERE ID IN: AccountenterpriseId]);
    
    for(SPE_PITempValue__c pitempupdate: Trigger.New)
    {
        pitempupdate.EnterpriseId__c = suppIDMap.get(pitempupdate.EnterpriseID__c).EnterpriseID__c;
    }    
}