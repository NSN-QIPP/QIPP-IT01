trigger SPE_TrackerValuesTrigger on SPE_TrackerValues__c (after insert) 
{
  if (Trigger.isAfter &&
    Trigger.isInsert)
  {
    SPE_TrackerValuesTrigger.GenerateCMTicket (Trigger.new);
  }
}