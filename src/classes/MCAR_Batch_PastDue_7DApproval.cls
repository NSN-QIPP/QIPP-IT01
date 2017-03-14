global class MCAR_Batch_PastDue_7DApproval implements Database.Batchable<sObject> {

    // Requirement is to send email to owner, supplier and all supplier contacts.
    // Based condition that MCAr is open, its Approval is false and Its Due Date is passed
    // Also need to send reminder mail to all ids after every 2 days if conditon is not met.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_7DApproval_PastDue_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs7d = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id, Name,MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_7D_Due_Date__c, X7D_Status__c, X6D_Status__c from MCAR__c where 
                         MCAR__c.MCAR_Status__c = 'Open' and (MCAR__c.X7D_Status__c = null or MCAR__c.X7D_Status__c = '' ) and MCAR__c.MCAR_7D_Due_Date__c < TODAY and MCAR__c.X6D_Status__c = 'APPROVE']);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesList7d = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMail7d = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesList7d.size() > 0) { 
          for(Integer i = 0; i < dueDatesList7d.size(); i++){  
          emailAddrs7d.clear(); // clearing the email list for new MCAR record
          
         // query to fetch email id of owner and add in EmailAddr list
          List <User> lstAccountEmailOwner7d = [SELECT Email from User where Id =: dueDatesList7d[i].OwnerId ];
             if (lstAccountEmailOwner7d.size() > 0) {
                 User ownerEmail7d = lstAccountEmailOwner7d.get(0); 
                     if(ownerEmail7d.Email != null){       
                         emailAddrs7d.add(ownerEmail7d.Email);                                  
                     }
            }
          
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
        if(dueDatesList7d[i].MCAR_Manufacturer__c != null){
          
              // query to fetch email id of supplier and add in EmailAddr list
              
               List<MCAR_Email_List__c> lstAccountEmailSupplier7d = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: dueDatesList7d[i].name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                if (lstAccountEmailSupplier7d.size() > 0) {
                     MCAR_Email_List__c supplierEmail7d = lstAccountEmailSupplier7d.get(0);  
                         if(supplierEmail7d.MCAR_Email__c != null){   
                             emailAddrs7d.add(supplierEmail7d.MCAR_Email__c);  
                            }
                    }              
              /*List<User> lstAccountEmailSupplier7d = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: dueDatesList7d[i].MCAR_Manufacturer__c )];
               
                if (lstAccountEmailSupplier7d.size() > 0) {
                     User supplierEmail7d = lstAccountEmailSupplier7d.get(0);  
                         if(supplierEmail7d.Email != null){       
                             emailAddrs7d.add(supplierEmail7d.Email);            
                       }
                    }*/
            
              // query to fetch email id of all contacts of supplier and add in EmailAddr list       
              // Requirement Changed not to send email to all contacts o Manufacturer
         //     List<Contact> contactIdList7d =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: dueDatesList7d[i].MCAR_Manufacturer__c];
         //    if (contactIdList7d.size() > 0) {                       
          //            for(Integer j = 0; j < contactIdList7d.size(); j++){
          //                if(contactIdList7d[j].Email != null){ 
            //                 emailAddrs7d.add(contactIdList7d[j].Email); 
             //             }
             //         }
            //      } 
              } 
       
             System.debug('All email add list is  7d ' + emailAddrs7d);
             
             
             // Checking the conditon Due date less than today and its Approval is false
             
             if(dueDatesList7d[i].MCAR_7d_Due_Date__c < date.Today() && (dueDatesList7d[i].X7D_Status__c == null || dueDatesList7d[i].X7D_Status__c == '' )){                
                     
                    // Setting the Initial reminder & Pastdue reminder mail after every 2 days if record is still open and its Approval is stillfalse
                   
                    if(math.MOD((dueDatesList7d[i].MCAR_7d_Due_Date__c.DAYSBETWEEN(Date.Today())),2) == 1) {                      
                            Messaging.SingleEmailMessage se7dDueApp = new Messaging.SingleEmailMessage();              
                            EmailTemplate et5 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_7D_Approval_Date_is_Past_Due_New'];
                            se7dDueApp.setToAddresses(emailAddrs7d); 
                            se7dDueApp.setTargetObjectId(dueDatesList7d[i].CreatedById);                        
                            se7dDueApp.setWhatId(dueDatesList7d[i].Id);    
                            se7dDueApp.setSaveAsActivity(false);
                            se7dDueApp.setTemplateId(et5.Id);                      
                         // Adding all emails in list called as listMail4d  
                            listmail7d.add(se7dDueApp);
                         
                     }                      
                  }
                  
             }     // End of for loop
     
         if(listmail7d.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listmail7d);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){  
        
        System.debug('Executed successfullly ');
        
        }


}