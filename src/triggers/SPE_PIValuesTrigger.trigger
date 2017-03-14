trigger SPE_PIValuesTrigger on SPE_PIValues__c (before insert, before update,after insert) 
{
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
    {
        System.Debug('I am working');
        SPE_PIValuesTrigger.AutoFill(Trigger.new);
        
        //**********Code added for Encryption *********************//  || Trigger.isUpdate
        SPE_PIValuesTrigger.populateMappingKey(Trigger.new);       
        //***************End*********************************//
     }   
        // Code added for KPI = PI functionality @ 17 June 2015
    if(Trigger.isAfter && Trigger.isInsert)
    {
        SPE_PIValuesTrigger.createKPIValues(Trigger.new);
    }
}