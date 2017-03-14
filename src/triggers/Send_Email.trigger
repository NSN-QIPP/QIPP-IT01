trigger Send_Email on MCAR_Claim_Management__c (before insert, Before update){
    list<String> EmailAddrtech = new list<String>();
    list<String> EmailAddrncc = new list<String>();
    list<String> EmailAddrlegal = new list<String>();
    list<String> EmailAddrCM = new list<String>();
    list<String> EmailAddrSQS = new list<String>();
    list<String> EmailAddrSQM = new list<String>();
    list<String> CCEmailAddr = new list<String>();
    
    for (MCAR_Claim_Management__c mcm: Trigger.new){
        if(mcm.I_Agree__c == True && mcm.Claim_Status__c == 'Draft'){
            List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: mcm.id AND Contact_Type__c != 'Manufacturer'];
            for(Claim_Contact__c c : cc)
            {
                if(c.Contact_Type__c == 'Technical')
                {
                    EmailAddrtech.add(c.Email__c);
                }
                if(c.Contact_Type__c == 'Nonconformance Cost')
                {    
                    EmailAddrncc.add(c.Email__c);
                }
                if(c.Contact_Type__c == 'Legal & Compliance')
                {
                    EmailAddrlegal.add(c.Email__c);
                }
                if(c.Contact_Type__c == 'Category Manager')
                {
                    EmailAddrCM.add(c.Email__c);
                }
                if(c.Contact_Type__c == 'SQS')
                {
                    EmailAddrSQS.add(c.Email__c);
                }                
                if(c.Contact_Type__c == 'SQM')
                {
                    EmailAddrSQS.add(c.Email__c);
                }
            }   
               
            List<User> user = new List<User>();
            user = [Select Email from User where ID =: mcm.OwnerID OR ID =: mcm.Claim_Preparer__c];
            if(!user.isEmpty())
                for(User u : user)
                    CCEmailAddr.add(u.Email);
            Messaging.SingleEmailMessage mail;
            EmailTemplate et;
            if(!EmailAddrtech.isEmpty()){
                mail = new Messaging.SingleEmailMessage();
                et = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_Tech_Contact'];
                mail.setToAddresses(EmailAddrtech);
                mail.setCCAddresses(CCEmailAddr);
                mail.setWhatId(mcm.id);
                mail.setTemplateId(et.id);
                mail.setTargetObjectId(User[0].Id);
                mail.setSaveAsActivity(false);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});   
            }
            
            if(!EmailAddrncc.isEmpty()){
                mail = new Messaging.SingleEmailMessage();
                et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_NCC_Contacts'];
                mail.setToAddresses(EmailAddrncc);
                mail.setCCAddresses(CCEmailAddr);
                mail.setTemplateId(et.id);
                mail.setWhatId(mcm.id);
                mail.setTargetObjectId(User[0].Id);
                mail.setSaveAsActivity(false); 
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); 
            }
            
            if(!EmailAddrlegal.isEmpty()){
                mail = new Messaging.SingleEmailMessage();
                et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_Legal_Contact'];
                mail.setToAddresses(EmailAddrlegal);
                mail.setCCAddresses(CCEmailAddr);
                mail.setTemplateId(et.id);
                mail.setWhatId(mcm.id);
                mail.setTargetObjectId(User[0].Id);
                mail.setSaveAsActivity(false); 
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); 
            }
            
            
            mail = new Messaging.SingleEmailMessage();
            et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_Cate_Mgr_Contact'];
            mail.setToAddresses(EmailAddrCM);
            mail.setCCAddresses(CCEmailAddr);
            mail.setTemplateId(et.id);
            mail.setWhatId(mcm.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});  
            
           mail = new Messaging.SingleEmailMessage();
            et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_SQS_Contact'];
            mail.setToAddresses(EmailAddrSQS);
            mail.setCCAddresses(CCEmailAddr);
            mail.setTemplateId(et.id);
            mail.setWhatId(mcm.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
            
            /*
           mail = new Messaging.SingleEmailMessage();
            et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_SQM_Contact'];
            mail.setToAddresses(EmailAddrSQM);
            mail.setCCAddresses(CCEmailAddr);
            mail.setTemplateId(et.id);
            mail.setWhatId(mcm.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
*/
        }  
    }  
}