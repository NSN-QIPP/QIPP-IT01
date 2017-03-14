trigger Document_PO_Check on NQT_Document__c (After insert) {
    for(NQT_Document__c doc : trigger.new){
        if(doc.NQT_Document_Type__c == 'PO'){
            EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'NQT_PO_Recived'];
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            list<String> EmailAddr = new list<String>();
            //[SELECT Email FROM User WHERE Id =: CPR1.NQT_Project_Manager__c LIMIT 1]
            //if(CPR1.NQT_Program_Manager__r.Email != null)
            Id PM = [SELECT NQT_Program_Manager__c FROM CPR__c WHERE Id =: doc.NQT_CPR__c LIMIT 1].NQT_Program_Manager__c;
               EmailAddr.add([SELECT Email FROM User WHERE Id =: PM LIMIT 1].Email); 
            //if(CPR1.NQT_Account_Manager__r.Email != null)
            Id AM = [SELECT NQT_Account_Manager__c FROM CPR__c WHERE Id =: doc.NQT_CPR__c LIMIT 1].NQT_Account_Manager__c;
               EmailAddr.add([SELECT Email FROM User WHERE Id =: AM LIMIT 1].Email);
            if(![SELECT Email FROM User WHERE Id =: doc.OwnerId LIMIT 1].isEmpty()){
                    String Email1 = [SELECT Email FROM User WHERE Id =: doc.OwnerId LIMIT 1].Email;
                    EmailAddr.add(Email1);
                    }
            /*if(CPR1.NQT_FE__c != null)
                EmailAddr.add([SELECT Email FROM User WHERE Id =: NQT_CPR__c.NQT_FE__c LIMIT 1].Email);
            if(CPR1.NQT_SE__c != null)
                EmailAddr.add([SELECT Email FROM User WHERE Id =: NQT_CPR__c.NQT_SE__c LIMIT 1].Email);
            if(CPR1.NQT_SE_MSC__c != null)
                EmailAddr.add([SELECT Email FROM User WHERE Id =: NQT_CPR__c.NQT_SE_MSC__c LIMIT 1].Email);
            if(Profile.contains('Customer'))
                EmailAddr.add(Customer.Email);*/
            
            email.setToAddresses(EmailAddr);    
            email.setTargetObjectId(AM);
            email.setWhatId(doc.id);     
            email.setSaveAsActivity(false);            
            email.setTemplateId(et.id);            
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        }
}