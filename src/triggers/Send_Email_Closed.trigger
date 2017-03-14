trigger Send_Email_Closed on MCAR_Claim_Management__c (before insert, before update){
 list<String> CCEmailAddr = new list<String>();
 list<String> ToEmailAddr = new list<String>();
 list<String> ToEmailAddrmanufacturer = new list<String>();  
 list<String> CCEmailAddrmanufacturer = new list<String>();

    for (MCAR_Claim_Management__c mcm: Trigger.new){
    if(mcm.Data_claim_Notification_Send__c == True && mcm.Claim_Status__c == 'Closed')
     {

            List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: mcm.id];
            for(Claim_Contact__c c : cc)
            {
                 
                 if(c.Contact_Type__c != 'Manufacturer')
                 {
                 CCEmailAddr.add(c.Email__c);
                 }
                 if(c.Contact_Type__c == 'Manufacturer')
                 {    
                    ToEmailAddrmanufacturer.add(c.Email__c);
                 }
                  if(c.Contact_Type__c == 'Category Manager')
                 {    
                    CCEmailAddrmanufacturer.add(c.Email__c);
                 }
               
      
            }   
               
            List<User> user = new List<User>();
            user = [Select Email from User where ID =: mcm.OwnerID OR ID =: mcm.Claim_Preparer__c];
            if (!user.isEmpty())
                 {
                    for(User useremail : user)
                          
                        CCEmailAddrmanufacturer.add(useremail.Email);
                         for(User useremail : user)
                        ToEmailAddr.add(useremail.Email);                        
                        
                }
          /* Claim Closure Notification */
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Closed'];
            mail.setToAddresses(ToEmailAddr);
            mail.setCCAddresses(CCEmailAddr);
            mail.setWhatId(mcm.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); 

           
          /* Closure Notification to Manufacturer */ 
            
            Messaging.SingleEmailMessage mail_manufacturer  = new Messaging.SingleEmailMessage();
            mail_manufacturer = new Messaging.SingleEmailMessage();
            EmailTemplate et_manufacturer = [SELECT id FROM EmailTemplate WHERE developerName = 'Closure_Notification_to_Manufacturer'];
            mail_manufacturer.setToAddresses(ToEmailAddrmanufacturer);
            mail_manufacturer.setCCAddresses(CCEmailAddrmanufacturer);
            mail_manufacturer.setWhatId(mcm.id);
            mail_manufacturer.setTemplateId(et_manufacturer.id);
            mail_manufacturer.setTargetObjectId(User[0].Id);
            mail_manufacturer.setSaveAsActivity(false); 
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail_manufacturer});

              
        } 
       
         
    }
    }