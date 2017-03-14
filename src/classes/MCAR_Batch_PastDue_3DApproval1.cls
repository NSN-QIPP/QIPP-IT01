global class MCAR_Batch_PastDue_3DApproval1 implements Database.Batchable<sObject> 
{

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
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([select Id, Name, MCAR_Manufacturer__c, OwnerId, CreatedById, MCAR_3D_Due_Date__c, X3D_Status__c from MCAR__c where 
                         MCAR__c.MCAR_Status__c = 'Open' and (MCAR__c.X3D_Status__c = '' or MCAR__c.X3D_Status__c = null ) and MCAR__c.MCAR_3D_Due_Date__c < TODAY]);  
                         
    }
    
    // The executeBatch method is called for each chunk of records returned from start.   
    // This method must be global. 
    
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
         // Create a map for the chunk of records passed into method. 
    
        List<MCAR__c> dueDatesList3d = new List<MCAR__c>((List<MCAR__c>)scope);  
        List<Messaging.SingleEmailMessage> listMail3d = new List<Messaging.SingleEmailMessage>();
        
        
        
        if (dueDatesList3d.size() > 0) 
        { 
            
            EmailTemplate et1 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_3D_Approval_Date_is_Past_Due_New' limit 1];
            List <User> lstAccountEmailOwner3d = [SELECT Email from User ];
            
            
            Map<String, User> vMapManufacIdUser = new Map<String, user>();
            List<String> vLstManufactId  = new List<String>();
            Map<String, String> vMapSupAdminIdManuId = new Map<String, String>();
            
            for(MCAR__c vMCar: dueDatesList3d)
            {
                if(vMCar.MCAR_Manufacturer__c != null)
                {
                    vLstManufactId.add(vMCar.MCAR_Manufacturer__c);
                }
            }
            
            List<MCAR_Manufacturer__c> vLstManufact = [Select Id, MCAR_Supplier_Admin__c,MCAR_Supplier_Admin__r.Email FROM MCAR_Manufacturer__c WHERE id In: vLstManufactId];
            
            
            
            for(MCAR_Manufacturer__c vManufact: vLstManufact)
            {
                system.debug('vManufact ='+vManufact.MCAR_Supplier_Admin__r.Email);
                vMapSupAdminIdManuId.put(vManufact.MCAR_Supplier_Admin__c, vManufact.Id);
            }
            
            List<User> lstAccountEmailSupplier3d = [SELECT Email from User where Id IN : vMapSupAdminIdManuId.keySet()];
            
            for(User vUser: lstAccountEmailSupplier3d)
            {
                if(vMapSupAdminIdManuId.containsKey(vUser.Id))
                {
                    if(vUser.Email == 'thiresh.reddy@atos.com.qa01')
                    system.debug('@@@Thiresh='+vUser.Id);
                    vMapManufacIdUser.put(vMapSupAdminIdManuId.get(vUser.Id), vUser);
                }
            }
            
            for(User vUser1: lstAccountEmailSupplier3d)
            {
                system.debug('vUser1 Email='+vUser1.Email);
            }
            
            for(User vUser: vMapManufacIdUser.values())
            {
                system.debug('vUser User='+vUser.Email);
            }
            
            
            
            for(Integer i = 0; i < dueDatesList3d.size(); i++)
            {  
                emailAddrs3d.clear(); // clearing the email list for new MCAR record
              
              
                // query to fetch email id of owner and add in EmailAddr list
             
                //List <User> lstAccountEmailOwner3d = [SELECT Email from User where Id =: dueDatesList3d[i].OwnerId ];
                if (lstAccountEmailOwner3d.size() > 0) 
                {
                    User ownerEmail3d = lstAccountEmailOwner3d.get(0); 
                    if(ownerEmail3d.Email != null)
                    {   
                        emailAddrs3d.add(ownerEmail3d.Email);                                  
                    }
                }
              
                 if(dueDatesList3d[i].MCAR_Manufacturer__c != null)
                 {
                     if(vMapManufacIdUser.containsKey(dueDatesList3d[i].MCAR_Manufacturer__c))
                     {
                        system.debug('vMapManufacIdUser.get(dueDatesList3d[i].MCAR_Manufacturer__c).Email='+vMapManufacIdUser.get(dueDatesList3d[i].MCAR_Manufacturer__c).Email);
                        emailAddrs3d.add(vMapManufacIdUser.get(dueDatesList3d[i].MCAR_Manufacturer__c).Email);
                     }
                 }

                 
                 if(dueDatesList3d[i].MCAR_3D_Due_Date__c < date.Today() && (dueDatesList3d[i].X3D_Status__c == '' || dueDatesList3d[i].X3D_Status__c == null ) )
                 {                
                       
                    // Setting the Initial reminder & Pastdue reminder mail after every 2 days if record is still open and its Approval is stillfalse
                   
                    if(math.MOD((dueDatesList3d[i].MCAR_3D_Due_Date__c.DAYSBETWEEN(Date.Today())),2) == 1) 
                    {                       
                        Messaging.SingleEmailMessage se3dDueApp = new Messaging.SingleEmailMessage();              
                        
                        se3dDueApp.setToAddresses(emailAddrs3d); 
                        se3dDueApp.setTargetObjectId(dueDatesList3d[i].CreatedById);  
                        system.debug('Created ID='+dueDatesList3d[i].CreatedById);
                        se3dDueApp.setWhatId(dueDatesList3d[i].Id);    
                        se3dDueApp.setSaveAsActivity(false);
                        se3dDueApp.setTemplateId(et1.Id); 
                        // Adding all emails in list called as listMail3d
                        listMail3d.add(se3dDueApp);
                     }                      
                }
                      
            }     // End of for loop
            
            for(String vStr: emailAddrs3d)
            {
             system.debug('Email='+vstr);
            }
         
            if(listMail3d.size() > 0)
            {
            // Sending all emails in list at same time, so that governer limit...
            // like Too many Email invocation and No: of SOQL queries can be controlled.
            
                Messaging.sendEmail(listMail3d);
            }
              
        } // End of If loop

    } // End of execute loop

    global void finish(Database.BatchableContext BC)
    {  
        System.debug('Executed successfullly ');
    }


}