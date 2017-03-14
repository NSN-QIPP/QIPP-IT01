global class MCAR_Batch_PastDue_5DApproval implements Database.Batchable<sObject> {

    // Requirement is to send email to owner, supplier and all supplier contacts.
    // Based condition that MCAr is open, its Approval is false and Its Due Date is passed
    // Also need to send reminder mail to all ids after every 2 days if conditon is not met.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_5DApproval_PastDue_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs5d = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id, Name, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_5D_Due_Date__c, X5D_Status__c,X4D_Owner_Approve_Reject__c from MCAR__c where 
                         MCAR__c.MCAR_Status__c = 'Open' and (MCAR__c.X5D_Status__c = null or MCAR__c.X5D_Status__c = '')  and MCAR__c.MCAR_5D_Due_Date__c < TODAY and MCAR__c.X4D_Owner_Approve_Reject__c = 'APPROVE']);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesList5d = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMail5d = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesList5d.size() > 0) { 
          for(Integer i = 0; i < dueDatesList5d.size(); i++){  
          emailAddrs5d.clear(); // clearing the email list for new MCAR record
          
          
         // query to fetch email id of owner and add in EmailAddr list
          List <User> lstAccountEmailOwner5d = [SELECT Email from User where Id =: dueDatesList5d[i].OwnerId ];
             if (lstAccountEmailOwner5d.size() > 0) {
                 User ownerEmail5d = lstAccountEmailOwner5d.get(0); 
                     if(ownerEmail5d.Email != null){       
                         emailAddrs5d.add(ownerEmail5d.Email); 
                                  
                     }
            }
          
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
        if(dueDatesList5d[i].MCAR_Manufacturer__c != null){
          
              // query to fetch email id of supplier and add in EmailAddr list
               List<MCAR_Email_List__c> lstAccountEmailSupplier5d = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: dueDatesList5d[i].name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                if (lstAccountEmailSupplier5d.size() > 0) {
                     MCAR_Email_List__c supplierEmail5d = lstAccountEmailSupplier5d.get(0);  
                         if(supplierEmail5d.MCAR_Email__c != null){   
                             emailAddrs5d.add(supplierEmail5d.MCAR_Email__c);  
                            }
                    }              
              
              /*List<User> lstAccountEmailSupplier5d = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: dueDatesList5d[i].MCAR_Manufacturer__c )];
               
                if (lstAccountEmailSupplier5d.size() > 0) {
                     User supplierEmail5d = lstAccountEmailSupplier5d.get(0);  
                         if(supplierEmail5d.Email != null){       
                             emailAddrs5d.add(supplierEmail5d.Email);           
                             
                            }
                    }*/
            
              // query to fetch email id of all contacts of supplier and add in EmailAddr list       
             // Requirement Changed not to send email to all contacts o Manufacturer
        //      List<Contact> contactIdList5d =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: dueDatesList5d[i].MCAR_Manufacturer__c];
       //      if (contactIdList5d.size() > 0) {                       
         //             for(Integer j = 0; j < contactIdList5d.size(); j++){
          //                if(contactIdList5d[j].Email != null){                                     
         //                     emailAddrs5d.add(contactIdList5d[j].Email); 
         //                 }
          //            }
         //         } 
              } 
       
             System.debug('All email add list is  5d ' + emailAddrs5d);  
             
             
             // Checking the conditon Due date less than today and its Approval is false
             
             if(dueDatesList5d[i].MCAR_5d_Due_Date__c < date.Today() && (dueDatesList5d[i].X5D_Status__c == '' || dueDatesList5d[i].X5D_Status__c == null )){               
                   
                    // Setting the Initial reminder & Pastdue reminder mail after every 2 days if record is still open and its Approval is stillfalse
                   
                    if(math.MOD((dueDatesList5d[i].MCAR_5d_Due_Date__c.DAYSBETWEEN(Date.Today())),2) == 1) {                       
                        Messaging.SingleEmailMessage se5dDueApp = new Messaging.SingleEmailMessage();              
                        EmailTemplate et3 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_5D_Approval_Date_is_Past_Due_New'];
                        se5dDueApp.setToAddresses(emailAddrs5d); 
                        se5dDueApp.setTargetObjectId(dueDatesList5d[i].CreatedById);                        
                        se5dDueApp.setWhatId(dueDatesList5d[i].Id);    
                        se5dDueApp.setSaveAsActivity(false);
                        se5dDueApp.setTemplateId(et3.Id);
                        // Adding all emails in list called as listMail5d  
                        listmail5d.add(se5dDueApp);
                        
                     }                      
                  }
                  
             }     // End of for loop
     
         if(listmail5d.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listmail5d);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){  
        
        System.debug('Executed successfullly ');
        
        }


}