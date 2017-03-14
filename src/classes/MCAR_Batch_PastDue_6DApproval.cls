global class MCAR_Batch_PastDue_6DApproval implements Database.Batchable<sObject> {

    // Requirement is to send email to owner, supplier and all supplier contacts.
    // Based condition that MCAr is open, its Approval is false and Its Due Date is passed
    // Also need to send reminder mail to all ids after every 2 days if conditon is not met.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_6DApproval_PastDue_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs6d = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id, Name, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_6D_Due_Date__c,X6D_Status__c, X5D_Status__c from MCAR__c where 
                         MCAR__c.MCAR_Status__c = 'Open' and (MCAR__c.X6D_Status__c = '' or MCAR__c.X6D_Status__c = null)   and MCAR__c.MCAR_6D_Due_Date__c < TODAY and MCAR__c.X5D_Status__c = 'APPROVE']);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesList6d = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMail6d = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesList6d.size() > 0) { 
          for(Integer i = 0; i < dueDatesList6d.size(); i++){  
          emailAddrs6d.clear(); // clearing the email list for new MCAR record
          
          // query to fetch email id of owner and add in EmailAddr list
          List <User> lstAccountEmailOwner6d = [SELECT Email from User where Id =: dueDatesList6d[i].OwnerId ];
             if (lstAccountEmailOwner6d.size() > 0) {
                 User ownerEmail6d = lstAccountEmailOwner6d.get(0); 
                     if(ownerEmail6d.Email != null){       
                         emailAddrs6d.add(ownerEmail6d.Email);                              
                     }
            }
          
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
        if(dueDatesList6d[i].MCAR_Manufacturer__c != null){
           // query to fetch email id of supplier and add in EmailAddr list
               List<MCAR_Email_List__c> lstAccountEmailSupplier6d = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: dueDatesList6d[i].name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                if (lstAccountEmailSupplier6d.size() > 0) {
                     MCAR_Email_List__c supplierEmail6d = lstAccountEmailSupplier6d.get(0);  
                         if(supplierEmail6d.MCAR_Email__c != null){   
                             emailAddrs6d.add(supplierEmail6d.MCAR_Email__c);  
                            }
                    }
              /*List<User> lstAccountEmailSupplier6d = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: dueDatesList6d[i].MCAR_Manufacturer__c )];
               
                if (lstAccountEmailSupplier6d.size() > 0) {
                     User supplierEmail6d = lstAccountEmailSupplier6d.get(0);  
                         if(supplierEmail6d.Email != null){       
                             emailAddrs6d.add(supplierEmail6d.Email);           
                             
                            }
                    }*/
            
              // query to fetch email id of all contacts of supplier and add in EmailAddr list       
             // Requirement Changed not to send email to all contacts o Manufacturer
       //       List<Contact> contactIdList6d =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: dueDatesList6d[i].MCAR_Manufacturer__c];
       //      if (contactIdList6d.size() > 0) {                       
       //               for(Integer j = 0; j < contactIdList6d.size(); j++){
       //                   if(contactIdList6d[j].Email != null){                                      
       //                       emailAddrs6d.add(contactIdList6d[j].Email); 
       //                   }
        //              }
        //          } 
              } 
       
             System.debug('All email add list is  6d ' + emailAddrs6d);  
             
             
             // Checking the conditon Due date less than today and its Approval is false
             
             if(dueDatesList6d[i].MCAR_6d_Due_Date__c < date.Today() && (dueDatesList6d[i].X6D_Status__c == '' || dueDatesList6d[i].X6D_Status__c == null) ){              
                   
                    // Setting the Initial reminder & Pastdue reminder mail after every 2 days if record is still open and its Approval is stillfalse
                   
                    if(math.MOD((dueDatesList6d[i].MCAR_6d_Due_Date__c.DAYSBETWEEN(Date.Today())),2) == 1) {                      
                            Messaging.SingleEmailMessage se6dDueApp = new Messaging.SingleEmailMessage();              
                            EmailTemplate et4 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_6D_Approval_Date_is_Past_Due_New'];
                            se6dDueApp.setToAddresses(emailAddrs6d); 
                            se6dDueApp.setTargetObjectId(dueDatesList6d[i].CreatedById);                        
                            se6dDueApp.setWhatId(dueDatesList6d[i].Id);    
                            se6dDueApp.setSaveAsActivity(false);
                            se6dDueApp.setTemplateId(et4.Id);                      
                         // Adding all emails in list called as listMail4d  
                            listmail6d.add(se6dDueApp);
                         
                     }                      
                  }
                  
             }     // End of for loop
     
         if(listmail6d.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listmail6d);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){  
        
        System.debug('Executed successfullly ');
        
        }


}