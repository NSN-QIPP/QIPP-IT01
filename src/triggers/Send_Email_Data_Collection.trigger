trigger Send_Email_Data_Collection on MCAR_Claim_Management__c (before insert, before update){
    /*list<String> EmailAddrtech = new list<String>();
    list<String> EmailAddrncc = new list<String>();
    list<String> EmailAddrmanufacturer  = new list<String>();*/
    list<String> CCEmailAddr = new list<String>();
    list<String> ToEmailAddr = new list<String>();


    for (MCAR_Claim_Management__c mcm: Trigger.new){
    if(mcm.Data_Collection_Notification_Send__c == True && mcm.Claim_Status__c == 'Data Collection')
     {

            List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: mcm.id AND Contact_Type__c != 'Manufacturer'];
            for(Claim_Contact__c c : cc)
            {
                 CCEmailAddr.add(c.Email__c);
                
                
                /*if(c.Contact_Type__c == 'Technical')
                {
                    EmailAddrtech.add(c.Email__c);
                }
                if(c.Contact_Type__c == 'Nonconformance Cost')
                {    
                    EmailAddrncc.add(c.Email__c);
                }
                  if(c.Contact_Type__c == 'Manufacturer')
                {    
                    EmailAddrmanufacturer.add(c.Email__c);
                }*/
            }   
               
            List<User> user = new List<User>();
            user = [Select Email from User where ID =: mcm.OwnerID OR ID =: mcm.Claim_Preparer__c];
            if (!user .isEmpty())
                 {
            for(User u : user)
                ToEmailAddr.add(u.Email);
                }
           /*
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Technical_Approval_Notice'];
            mail.setToAddresses(EmailAddrtech);
            System.debug('######EmailAddrtech)###########'+EmailAddrtech);
            mail.setCCAddresses(CCEmailAddr);
            System.debug('######CCEmailAddr)###########'+CCEmailAddr);
            mail.setWhatId(mcm.id);
            System.debug('######mcm.id)###########'+mcm.id);
            mail.setTemplateId(et.id);
            System.debug('######et.id)###########'+et.id);
            mail.setTargetObjectId(User[0].Id);
            System.debug('######User[0].Id)###########'+User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});    


            mail = new Messaging.SingleEmailMessage();
            et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_NCC_Approval_Notice'];
            mail.setToAddresses(EmailAddrncc);
            mail.setCCAddresses(CCEmailAddr);
            mail.setWhatId(mcm.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); */
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Final_Approval_Notice'];
            mail.setToAddresses(ToEmailAddr);
            mail.setCCAddresses(CCEmailAddr);
            mail.setWhatId(mcm.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); 



           /* mail = new Messaging.SingleEmailMessage();
            et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Final_Approval_Notice'];
            mail.setToAddresses(EmailAddrmanufacturer);
            mail.setWhatId(mcm.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); */



            mcm.Claim_Status__c='Negotiation';
            RecordType Rec = [SELECT Id FROM RecordType WHERE Name = 'MCAR Claim Negotiation layout'limit 1];
            mcm.RecordTypeId=Rec.Id;
        } 
       
         
    }
    }