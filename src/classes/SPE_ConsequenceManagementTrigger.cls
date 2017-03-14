public class SPE_ConsequenceManagementTrigger
{

    public static void validationOnDelete(List<SPE_ConsequenceManagement__c> cmRecords)
    {
        for (SPE_ConsequenceManagement__c cm : cmRecords)
        {
            if (cm.OwnerId != UserInfo.getUserId() || cm.TicketStatus__c != 'Draft')
            {
                cm.addError('Deletion is not allowed');
            }
        }
    }

}