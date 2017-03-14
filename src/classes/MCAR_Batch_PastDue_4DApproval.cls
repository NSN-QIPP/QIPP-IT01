global class MCAR_Batch_PastDue_4DApproval implements Database.Batchable<sObject> {

    // Requirement is to send email to owner, supplier and all supplier contacts.
    // Based condition that MCAr is open, its Approval is false and Its Due Date is passed
    // Also need to send reminder mail to all ids after every 2 days if conditon is not met.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_4DApproval_PastDue_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs4d = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id, Name, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_4D_Due_Date__c, MCAR_4D_Approval__c, MCAR_3D_Approval__c,X3D_Status__c,X4D_Owner_Approve_Reject__c from MCAR__c where 
                         MCAR__c.MCAR_Status__c = 'Open' and  ( MCAR__c.X4D_Owner_Approve_Reject__c = '' or MCAR__c.X4D_Owner_Approve_Reject__c = null) and MCAR__c.MCAR_4D_Due_Date__c < TODAY and  MCAR__c.X3D_Status__c = 'APPROVE']);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesList4d = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMail4d = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesList4d.size() > 0) { 
          for(Integer i = 0; i < dueDatesList4d.size(); i++){  
          emailAddrs4d.clear(); // clearing the email list for new MCAR record
          
          
         // query to fetch email id of owner and add in EmailAddr list
          List <User> lstAccountEmailOwner4d = [SELECT Email from User where Id =: dueDatesList4d[i].OwnerId ];
             if (lstAccountEmailOwner4d.size() > 0) {
                 User ownerEmail4d = lstAccountEmailOwner4d.get(0); 
                     if(ownerEmail4d.Email != null){       
                         emailAddrs4d.add(ownerEmail4d.Email); 
                              
                     }
            }
          
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
                if(dueDatesList4d[i].MCAR_Manufacturer__c != null){
          
              // query to fetch email id of supplier and add in EmailAddr list
                   List<MCAR_Email_List__c> lstAccountEmailSupplier4d = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: dueDatesList4d[i].name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                    if (lstAccountEmailSupplier4d .size() > 0) {
                     MCAR_Email_List__c supplierEmail4d = lstAccountEmailSupplier4d.get(0);  
                         if(supplierEmail4d.MCAR_Email__c != null){   
                             emailAddrs4d.add(supplierEmail4d.MCAR_Email__c);  
                            }
                    }                  
                  /*List<User> lstAccountEmailSupplier4d = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: dueDatesList4d[i].MCAR_Manufacturer__c )];
               
                    if (lstAccountEmailSupplier4d.size() > 0) {
                         User supplierEmail4d = lstAccountEmailSupplier4d.get(0);  
                             if(supplierEmail4d.Email != null){       
                                 emailAddrs4d.add(supplierEmail4d.Email);   
                                }
                    }*/
            
              // query to fetch email id of all contacts of supplier and add in EmailAddr list       
              // Requirement Changed not to send email to all contacts o Manufacturer
         //     List<Contact> contactIdList4d =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: dueDatesList4d[i].MCAR_Manufacturer__c];
         //    if (contactIdList4d.size() > 0) {                       
         //             for(Integer j = 0; j < contactIdList4d.size(); j++){
         //                 if(contactIdList4d[j].Email != null){ 
         //                     emailAddrs4d.add(contactIdList4d[j].Email); 
         //                 }
         //             }
         //         } 
              } 
              
             System.debug('All email add list is  4d ' + emailAddrs4d);  
             
             
             // Checking the conditon Due date less than today and its Approval is false
             
             if(dueDatesList4d[i].MCAR_4d_Due_Date__c < date.Today() &&  dueDatesList4d[i].X4D_Owner_Approve_Reject__c == '' || dueDatesList4d[i].X4D_Owner_Approve_Reject__c == null ){                
                   
                    // Setting the Initial reminder & Pastdue reminder mail after every 2 days if record is still open and its Approval is stillfalse
                   
                    if(math.MOD((dueDatesList4d[i].MCAR_4d_Due_Date__c.DAYSBETWEEN(Date.Today())),2) == 1) {                       
                        Messaging.SingleEmailMessage se4dDueApp = new Messaging.SingleEmailMessage();              
                        EmailTemplate et2 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_4D_Approval_Date_is_Past_Due_New'];
                        se4dDueApp.setToAddresses(emailAddrs4d); 
                        se4dDueApp.setTargetObjectId(dueDatesList4d[i].CreatedById);                        
                        se4dDueApp.setWhatId(dueDatesList4d[i].Id);    
                        se4dDueApp.setSaveAsActivity(false);
                        se4dDueApp.setTemplateId(et2.Id);
                        // Adding all emails in list called as listMail4d  
                        listmail4d.add(se4dDueApp);
                        
                     }                      
                  }
                  
             }     // End of for loop
     
         if(listmail4d.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listmail4d);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){  
        
        System.debug('Executed successfullly ');
        
        }


}