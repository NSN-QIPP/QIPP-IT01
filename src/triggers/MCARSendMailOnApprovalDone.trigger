trigger MCARSendMailOnApprovalDone on MCAR__c (Before Update) {
    // This Trigger is used to send mail to MCAR owner email id , Selected supplier email id & 
    // all supplier's conatcts emailids 
    
      for (MCAR__c mcar : Trigger.new)    {  
          if(mcar.Class_Access__c == FALSE){
    if(mcar.Class_Access1__c == FALSE){
    if(mcar.Class_Access2__c == FALSE){
    if(mcar.Class_Access3__c == FALSE){
    if(mcar.Class_Access4__c == FALSE){
          
          if(mcar.MCAR_Status__c == 'Open') {

         
          list<String> EmailAddr = new list<String>();  
          List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();     
      
      
        // query to fetch email id of owner and add in EmailAddr list
        List <User> lstAccount2 = [SELECT Email from User where Id =: mcar.OwnerId ];
             if (lstAccount2.size() > 0)  {
                 User a2 = lstAccount2.get(0);   
                 if(a2.Email != null){      
                         EmailAddr.add(a2.Email); 
                     }
            }
        // Checking if MCAR_Manufacturer__c is not null then fetch supplier and all its contacts email id   
        if(mcar.MCAR_Manufacturer__c != null){
        // query to fetch email id of supplier and add in EmailAddr list
        /*List<User> lstAccount1 = [SELECT Email from User where Id IN ( Select MCAR_Supplier_Admin__c FROM MCAR_Manufacturer__c WHERE id =: mcar.MCAR_Manufacturer__c )];
     
             if (lstAccount1.size() > 0) {
                    User a = lstAccount1.get(0);
                    if(a.Email != null){     
                         EmailAddr.add(a.Email); 
                     }
                } */
                
               List<MCAR_Email_List__c> lstAccount1 = [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: mcar.name and MCAR_Selected__c =: true and MCAR_Contact_Type__c =: 'OTHER' ]; 
                if (lstAccount1.size() > 0) {
                     MCAR_Email_List__c a = lstAccount1.get(0);  
                         if(a.MCAR_Email__c != null){   
                             EmailAddr.add(a.MCAR_Email__c);  
                            }
                    }
                
                
        
      
           
        // query to fetch email id of all contacts of supplier and add in EmailAddr list       
          // Requirement Changed not to send email to all contacts o Manufacturer
        //      List<Contact> contactId =  [SELECT Email, Id FROM Contact WHERE Contact.Account.Id=: mcar.MCAR_Manufacturer__c];
        //         if (contactId.size() > 0) {
        //          for(Integer i = 0; i < contactId.size(); i++){   
         //             if(contactId[i].Email != null) {        
         //                 EmailAddr.add(contactId[i].Email);                            
         //             }
         //          }
         //       }
                
            }
        
        
            // Sending email to all email ids based on certain condition...as per requirement
            // Selecting Email Template id ..
                   
                   
           if(EmailAddr != null ){
            if(Trigger.isUpdate  ) {
                   
          
          for (Integer i = 0; i < Trigger.new.size(); i++)    {
               
                if(mcar.Class_Access__c == FALSE){
    if(mcar.Class_Access1__c == FALSE){
    if(mcar.Class_Access2__c == FALSE){
    if(mcar.Class_Access3__c == FALSE){
    if(mcar.Class_Access4__c == FALSE){    
                if(Trigger.new[i].MCAR_IsWorkflowExecuted__c== True ) {     
       // Sending mail to Email ids if Approval is Checked for 3D, 4D ,5D ,6D & 7D 
               if (Trigger.new[i].MCAR_7D_Approval__c == TRUE && Trigger.old[i].MCAR_7D_Approval__c != TRUE) {
                    Trigger.new[i].MCAR_Current_8D_Step__c = '7D=Prevent Recurrence';
                    Messaging.SingleEmailMessage se7dApp = new Messaging.SingleEmailMessage();              
                    EmailTemplate et15 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_7DApproval_Status_is_Updated_New'];
                    se7dApp.setToAddresses(EmailAddr); 
                    se7dApp.setTargetObjectId(mcar.CreatedById);
                    se7dApp.setWhatId(mcar.id);    
                    se7dApp.setSaveAsActivity(false);
                    se7dApp.setTemplateId(et15.Id); 
                    listMail.add(se7dApp);
                   } 
                   
                else if (Trigger.new[i].MCAR_6D_Approval__c == TRUE && Trigger.old[i].MCAR_6D_Approval__c != TRUE) { 
                    Trigger.new[i].MCAR_Current_8D_Step__c = '6D=Verification';
                    Messaging.SingleEmailMessage se6dApp = new Messaging.SingleEmailMessage();             
                    EmailTemplate et14 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_6DApproval_Status_is_Updated_New'];
                    se6dApp.setToAddresses(EmailAddr); 
                    se6dApp.setTargetObjectId(mcar.CreatedById);                     
                    se6dApp.setWhatId(mcar.id);    
                    se6dApp.setSaveAsActivity(false);
                    se6dApp.setTemplateId(et14.Id); 
                    listMail.add(se6dApp);
                   }
                   
                else if (Trigger.new[i].MCAR_5D_Approval__c == TRUE && Trigger.old[i].MCAR_5D_Approval__c != TRUE) {   
                    Trigger.new[i].MCAR_Current_8D_Step__c = '5D=Permanent Action';
                    Messaging.SingleEmailMessage se5dApp = new Messaging.SingleEmailMessage();             
                    EmailTemplate et13 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_5DApproval_Status_is_Updated_New'];
                    se5dApp.setToAddresses(EmailAddr); 
                    se5dApp.setTargetObjectId(mcar.CreatedById);                     
                    se5dApp.setWhatId(mcar.id);    
                    se5dApp.setSaveAsActivity(false);
                    se5dApp.setTemplateId(et13.Id);
                    listMail.add(se5dApp);  
                   } 
                   
                else if (Trigger.new[i].MCAR_4D_Approval__c == TRUE && Trigger.old[i].MCAR_4D_Approval__c != TRUE) {      
                    Trigger.new[i].MCAR_Current_8D_Step__c = '4D=Root Cause';
                    Messaging.SingleEmailMessage se4dApp = new Messaging.SingleEmailMessage();         
                    EmailTemplate et12 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_4DApproval_Status_is_Updated_New'];
                    se4dApp.setToAddresses(EmailAddr); 
                    se4dApp.setTargetObjectId(mcar.CreatedById);                     
                    se4dApp.setWhatId(mcar.id);    
                    se4dApp.setSaveAsActivity(false);
                    se4dApp.setTemplateId(et12.Id); 
                    listMail.add(se4dApp);
                   }
       
                else if (Trigger.new[i].MCAR_3D_Approval__c == TRUE && Trigger.old[i].MCAR_3D_Approval__c != TRUE) { 
                    Trigger.new[i].MCAR_Current_8D_Step__c = '3D=Continament Action';
                    Messaging.SingleEmailMessage se3dApp = new Messaging.SingleEmailMessage();               
                    EmailTemplate et11 = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_3DApproval_Status_is_Updated_New'];
                    se3dApp.setToAddresses(EmailAddr); 
                    se3dApp.setTargetObjectId(mcar.CreatedById);
                    se3dApp.setWhatId(mcar.id);    
                    se3dApp.setSaveAsActivity(false);
                    se3dApp.setTemplateId(et11.Id); 
                    listMail.add(se3dApp);
                   } 
                   
                if(listMail.size() > 0)  {            
                    Messaging.sendEmail(listMail);
                }
             }  // End of MCAR_IsWorkflowExecuted IF Loop
             
                      Trigger.new[i].MCAR_IsWorkflowExecuted__c = FALSE;
                      }else
       mcar.Class_Access4__c = FALSE;}else
       mcar.Class_Access3__c = FALSE;}else
       mcar.Class_Access2__c = FALSE;}else
       mcar.Class_Access1__c = FALSE;}else
       mcar.Class_Access__c = FALSE;
            }  // End of Trigger.new.size()   FOR Loop
            
         } // End of Trigger.Update  IF Loop
           
       }  // End of Email check IF Loop
      
     }  // End of MCAR status open IF Loop
      }else
       mcar.Class_Access4__c = FALSE;}else
       mcar.Class_Access3__c = FALSE;}else
       mcar.Class_Access2__c = FALSE;}else
       mcar.Class_Access1__c = FALSE;}else
       mcar.Class_Access__c = FALSE;
   }
        
}