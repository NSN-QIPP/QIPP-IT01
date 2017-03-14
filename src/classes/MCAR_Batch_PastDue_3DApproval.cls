global class MCAR_Batch_PastDue_3DApproval implements Database.Batchable<sObject> {

    // Requirement is to send email to owner, supplier and all supplier contacts.
    // Based condition that MCAr is open, its Approval is false and Its Due Date is passed
    // Also need to send reminder mail to all ids after every 2 days if conditon is not met.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_3DApproval_PastDue_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs3d = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id, Name, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_3D_Due_Date__c, MCAR_3D_Approval__c from MCAR__c where 
                         MCAR__c.MCAR_Status__c = 'Open' and MCAR__c.MCAR_3D_Approval__c = false and MCAR__c.MCAR_3D_Due_Date__c < TODAY]);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesList3d = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMail3d = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesList3d.size() > 0) { 
         
         List <User> lstAccountEmailOwner3d = [SELECT Email from User   ];
          for(Integer i = 0; i < dueDatesList3d.size(); i++){  
          emailAddrs3d.clear(); // clearing the email list for new MCAR record
          
          
          // query to fetch email id of owner and add in EmailAddr list
         
         // List <User> lstAccountEmailOwner3d = [SELECT Email from User where Id =: dueDatesList3d[i].OwnerId ];
             if (lstAccountEmailOwner3d.size() > 0) {
                 User ownerEmail3d = lstAccountEmailOwner3d.get(0); 
                     if(ownerEmail3d.Email != null){   
                         emailAddrs3d.add(ownerEmail3d.Email);                                  
                     }
            }
          
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
        if(dueDatesList3d[i].MCAR_Manufacturer__c != null){
          
              // query to fetch email id of supplier and add in EmailAddr list
              //List<User> lstAccountEmailSupplier3d = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: dueDatesList3d[i].MCAR_Manufacturer__c )];
               List<MCAR_Email_List__c> lstAccountEmailSupplier3d = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: dueDatesList3d[i].name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                if (lstAccountEmailSupplier3d.size() > 0) {
                     MCAR_Email_List__c supplierEmail3d = lstAccountEmailSupplier3d.get(0);  
                         if(supplierEmail3d.MCAR_Email__c != null){   
                             emailAddrs3d.add(supplierEmail3d.MCAR_Email__c);  
                            }
                    }

            
               
                /*if (lstAccountEmailSupplier3d.size() > 0) {
                     User supplierEmail3d = lstAccountEmailSupplier3d.get(0);  
                         if(supplierEmail3d.Email != null){   
                             emailAddrs3d.add(supplierEmail3d.Email);  
                            }
                    }*/
            
              // query to fetch email id of all contacts of supplier and add in EmailAddr list       
               // Requirement Changed not to send email to all contacts o Manufacturer
          //    List<Contact> contactIdList3d =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: dueDatesList3d[i].MCAR_Manufacturer__c];
          //   if (contactIdList3d.size() > 0) {                       
         //             for(Integer j = 0; j < contactIdList3d.size(); j++){
          //                if(contactIdList3d[j].Email != null){                                     
            //                  emailAddrs3d.add(contactIdList3d[j].Email); 
            //              }
           //           }
           //       } 
              } 
              
             System.debug('All email add list is  3d ' + emailAddrs3d);  
             
             
             // Checking the conditon Due date less than today and its Approval is false
             
             if(dueDatesList3d[i].MCAR_3D_Due_Date__c < date.Today() && dueDatesList3d[i].MCAR_3D_Approval__c != TRUE){                
                   
                    // Setting the Initial reminder & Pastdue reminder mail after every 2 days if record is still open and its Approval is stillfalse
                   
                    if(math.MOD((dueDatesList3d[i].MCAR_3D_Due_Date__c.DAYSBETWEEN(Date.Today())),2) == 1) {                       
                        Messaging.SingleEmailMessage se3dDueApp = new Messaging.SingleEmailMessage();              
                        EmailTemplate et1 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_3D_Approval_Date_is_Past_Due_New'];
                        se3dDueApp.setToAddresses(emailAddrs3d); 
                        se3dDueApp.setTargetObjectId(dueDatesList3d[i].CreatedById);                        
                        se3dDueApp.setWhatId(dueDatesList3d[i].Id);    
                        se3dDueApp.setSaveAsActivity(false);
                        se3dDueApp.setTemplateId(et1.Id); 
                        // Adding all emails in list called as listMail3d
                        listMail3d.add(se3dDueApp);
                     }                      
                  }
                  
             }     // End of for loop
     
         if(listMail3d.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listMail3d);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){  
        
        System.debug('Executed successfullly ');
        
        }


}