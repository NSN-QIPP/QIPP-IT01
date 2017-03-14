trigger SPE_SpendTrigger on SPE_Spend__c (after insert) 
{
    if (trigger.isInsert)
    {
        SPE_SpendTrigger.spendCoverageCreate(trigger.new);
    }
}