global class MCAR_Batch_OpenMoreThan_90Days implements Database.Batchable<sObject> {

    // Requirement is to send email to owner, supplier and all supplier contacts.
    // Based condition that MCAr is open, its Approval is false and Its Due Date is passed
    // Also need to send reminder mail to all ids after every 2 days if conditon is not met.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_Open_MoreThan_90Days_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs90days = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id,name, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_Days_MCAR_Open__c from MCAR__c where 
                                 MCAR__c.MCAR_Status__c = 'Open' and MCAR__c.X7D_Status__c = 'APPROVE' and MCAR__c.MCAR_Days_MCAR_Open__c > 90]);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesList90days = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMail90days = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesList90days.size() > 0) { 
         
        // EmailTemplate et90days = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_record_is_opened_more_than_90_Days' limit 1];
          for(Integer i = 0; i < dueDatesList90days.size(); i++){  
          emailAddrs90days.clear(); // clearing the email list for new MCAR record
          
         // query to fetch email id of owner and add in EmailAddr list
          List <User> lstAccountEmailOwner90days = [SELECT Email from User where Id =: dueDatesList90days[i].OwnerId ];
             if (lstAccountEmailOwner90days.size() > 0) {
                 User ownerEmail90days = lstAccountEmailOwner90days.get(0); 
                     if(ownerEmail90days.Email != null){       
                         emailAddrs90days.add(ownerEmail90days.Email); 
                    }
            }
          
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
        if(dueDatesList90days[i].MCAR_Manufacturer__c != null){
          
              // query to fetch email id of supplier and add in EmailAddr list
               List<MCAR_Email_List__c> lstAccountEmailSupplier90days = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, MCAR__r.Name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: dueDatesList90days[i].name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                if (lstAccountEmailSupplier90days.size() > 0) {
                     MCAR_Email_List__c supplierEmail90days= lstAccountEmailSupplier90days.get(0);  
                         if(supplierEmail90days.MCAR_Email__c != null){   
                             emailAddrs90days.add(supplierEmail90days.MCAR_Email__c);  
                            }
                    }
              /*List<User> lstAccountEmailSupplier90days = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: dueDatesList90days[i].MCAR_Manufacturer__c )];
               
                if (lstAccountEmailSupplier90days.size() > 0) {
                     User supplierEmail90days = lstAccountEmailSupplier90days.get(0);  
                         if(supplierEmail90days.Email != null){       
                             emailAddrs90days.add(supplierEmail90days.Email); 
                            }
                    }*/
            
              // query to fetch email id of all contacts of supplier and add in EmailAddr list       
              // Requirement Changed not to send email to all contacts o Manufacturer
          //    List<Contact> contactIdList90days =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: dueDatesList90days[i].MCAR_Manufacturer__c];
         //    if (contactIdList90days.size() > 0) {                       
          //            for(Integer j = 0; j < contactIdList90days.size(); j++){
          //                if(contactIdList90days[j].Email != null){                               
          //                    emailAddrs90days.add(contactIdList90days[j].Email); 
          //                }
          //            }
          //        } 
              } 
       
             // System.debug('All email add list is  90days ' + emailAddrs90days);
             
             
             // Checking the conditon if MCAR case is opened for more than 90 Days where as all its 8D Steps are completed.
             // Setting the Initial reminder & Daily reminder mail if MCAR status is still open and its Open days are more tha 90 days.
                   
                  if(dueDatesList90days[i].MCAR_Days_MCAR_Open__c > 90){                                         
                            Messaging.SingleEmailMessage se90daysDueApp = new Messaging.SingleEmailMessage();              
                            EmailTemplate et90days = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_record_is_opened_more_than_90_Days'];
                            se90daysDueApp.setToAddresses(emailAddrs90days); 
                            se90daysDueApp.setTargetObjectId(dueDatesList90days[i].CreatedById);                        
                            se90daysDueApp.setWhatId(dueDatesList90days[i].Id);    
                            se90daysDueApp.setSaveAsActivity(false);
                            se90daysDueApp.setTemplateId(et90days.Id);                      
                         // Adding all emails in list called as listMail4d  
                            listMail90days.add(se90daysDueApp);
                         
                                           
                  }
                  
             }     // End of for loop
     
         if(listMail90days.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listMail90days);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){ 
                        
        }


}