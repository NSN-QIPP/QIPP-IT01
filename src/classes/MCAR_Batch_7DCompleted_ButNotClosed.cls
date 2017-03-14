global class MCAR_Batch_7DCompleted_ButNotClosed implements Database.Batchable<sObject> {

    // Requirement is to send email to owner.
    // Based condition that MCAR is open, its 7D Approval is true and Status is still open since 10days after 7D approval done.
    // Also need to send reminder mail to all ids after every 5 days if conditon is not met till MCAR Status is less than 90 days. After that other batch job will take over.
    // Need to take care of Exceptions like null pointer, no of email Invocation & No: of SOQL queries.
    // All should be under governer limit
    // This batch is Scheduled using Scheduler class called as MCAR_7DCompleted_ButNotClosed_Scheduled
    // And its Scheduled time is taken care in Devloper Console execute method
    // Prepared by Mayur Gupta(mayur.gupta@igatepatni.com) (KTNW68)
    
    list<String> emailAddrs7Dcompl = new list<String>(); 
      
    
    // The start method is called at the beginning. 
    
    // This method returns a SOQL query locator containing the MCAR open records.  
    
    // This method must be global. 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_Days_MCAR_Open__c, MCAR_7D_Due_Date__c from MCAR__c where 
                                 MCAR__c.MCAR_Status__c = 'Open' and MCAR__c.X7D_Status__c = 'APPROVE' and MCAR__c.MCAR_Days_MCAR_Open__c < 90]);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
       // Create a map for the chunk of records passed into method. 
    
       List<MCAR__c> dueDatesListAwaiting = new List<MCAR__c>((List<MCAR__c>)scope);  
       List<Messaging.SingleEmailMessage> listMailAwaiting = new List<Messaging.SingleEmailMessage>();
       
        
        
         if (dueDatesListAwaiting.size() > 0) { 
          for(Integer i = 0; i < dueDatesListAwaiting.size(); i++){  
          emailAddrs7Dcompl.clear(); // clearing the email list for new MCAR record
          
         // query to fetch email id of owner and add in EmailAddr list
          List <User> lstAccountEmailOwnerAwaiting = [SELECT Email from User where Id =: dueDatesListAwaiting[i].OwnerId ];
             if (lstAccountEmailOwnerAwaiting.size() > 0) {
                 User ownerEmailAwaiting = lstAccountEmailOwnerAwaiting.get(0); 
                     if(ownerEmailAwaiting.Email != null){       
                         emailAddrs7Dcompl.add(ownerEmailAwaiting.Email); 
                    }
            }
          
       
       
           
             
             // Checking the conditon if MCAR case is still Open and Days open is less than 90 Days where as all its 8D Steps are completed.
             // Setting the Initial reminder & Reminder mail after every 5days if MCAR status is still open and its Open days are less than 90 days.
                   
                    if(dueDatesListAwaiting[i].MCAR_Days_MCAR_Open__c < 90){ 
                     // Setting the Initial reminder & Pastdue reminder mail after every 5 days if record is still open and its Approval is done
                   
                    if(math.MOD(((dueDatesListAwaiting[i].MCAR_7D_Due_Date__c.DAYSBETWEEN(Date.Today())) + 10),5) == 1) {                          
                            Messaging.SingleEmailMessage seAwaitingDueApp = new Messaging.SingleEmailMessage();              
                            EmailTemplate etAwaiting = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_7D_Completed_But_MCAR_Not_Closed'];
                            seAwaitingDueApp.setToAddresses(emailAddrs7Dcompl); 
                            seAwaitingDueApp.setTargetObjectId(dueDatesListAwaiting[i].CreatedById);                        
                            seAwaitingDueApp.setWhatId(dueDatesListAwaiting[i].Id);    
                            seAwaitingDueApp.setSaveAsActivity(false);
                            seAwaitingDueApp.setTemplateId(etAwaiting.Id);                      
                         // Adding all emails in list called as listMailAwaiting
                            listMailAwaiting.add(seAwaitingDueApp);
                         
                     }       
                                      
                  }
                  
             }     // End of for loop
     
         if(listMailAwaiting.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listMailAwaiting);
            }
              
      } // End of If loop

    } // End of execute loop

        global void finish(Database.BatchableContext BC){         
        
        
        }


}