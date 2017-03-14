public class SendEmailOnClaimOwnerChangeController 
{        
    list<string> emailList;
    
    public static void sendEmailToAll(String claimId)
    {   
        try{
        MCAR_Claim_Management__c query=[select Id,Name,Previous_Owner__r.Email,Previous_Owner__r.Name,Owner.Email,Category_Manager_Email__c from MCAR_Claim_Management__c where id =:claimId];
        List<Claim_Contact__c> ccContacts = [select Email__c from Claim_Contact__c where Claims__c =: query.Id and  Contact_Type__c IN('Category Manager','SQM')];
        system.debug('****'+query.Previous_Owner__r.Email);
        system.debug('----'+query.Owner.Email);
         system.debug('****'+query.Category_Manager_Email__c);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        String[] toAddresses = new String[] {query.Owner.Email}; 
        String[] ccAddresses = new String[] {query.Previous_Owner__r.Email}; 
        mail.setToAddresses(toAddresses); 
        for(Claim_Contact__c c : ccContacts)
        {
            ccAddresses.add(c.Email__c);
        }
        mail.setCCAddresses(ccAddresses);
        mail.subject ='New Owner Assigned for '+ query.Name;
        mail.plainTextBody = 'This message is to notify you that you are the new Owner for  #'+query.Name + ' Contact the previous Owner , '+ query.Previous_Owner__r.Name+', for any further questions.';

        Messaging.SingleEmailMessage[] messages = 
         new List<Messaging.SingleEmailMessage> {mail};
         Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
          System.debug('The email was sent successfully.');
        } 
        else {
                System.debug('The email failed to send: ' + results[0].errors[0].message);

         }
        }
        Catch(Exception e){
            system.debug('Email ID is missing');
        }

}
}