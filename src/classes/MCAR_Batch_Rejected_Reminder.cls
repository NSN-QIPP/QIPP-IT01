global class MCAR_Batch_Rejected_Reminder implements Database.Batchable<sObject>
{
   
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
         return Database.getQueryLocator([select Id, Name , Owner_Approval__c , X2D_Reject_Date__c , X3D_Status__c , X3D_Reject_Date__c ,
                                          X4D_Owner_Approve_Reject__c , X4D_Reject_Date__c , X5D_Status__c  , X5D_Reject_Date__c , X6D_Status__c , X6D_Reject_Date__c ,
                                          X7D_Status__c , X7D_Reject_Date__c , CreatedById from MCAR__c where MCAR__c.MCAR_Status__c = 'Open']);  
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
         List<Messaging.SingleEmailMessage> mailmessages = new List<Messaging.SingleEmailMessage>(); 
             
         Set<MCAR__c> allMCARRecords = new Set<MCAR__c>((List<MCAR__c>)scope);  
         System.Debug(' Getting all record number in execute method : ' + allMCARRecords.Size());
         System.Debug(' Getting all record in execute method : ' + allMCARRecords);
                  
         for(MCAR__c m : allMCARRecords)
         {
                System.Debug('This Details is for ' + m.Name + '  MCAR Record'); 
                System.Debug('MCAR Details ' + m);
                 
                List<String> manuemail = new List<String>();
                List<MCAR_Email_List__c> OtherEmailList = [select MCAR_Email__c from MCAR_Email_List__c where MCAR__c =: m.Id and MCAR_Contact_Type__c=:'OTHER' and MCAR_Selected__c = true]; 
                if(OtherEmailList.size() > 0)
                 { 
                   for(MCAR_Email_List__c other :  OtherEmailList)
                    {
                      manuemail.add(other.MCAR_Email__c);
                    }
                 }  
                System.Debug('################## MCAR_Batch_Rejected_Reminder : selected Manufacture Contacts : ' + manuemail);
               
                Integer daydiff2 , daydiff3 , daydiff4 , daydiff5 , daydiff6, daydiff7;
                   
                if(m.X2D_Reject_Date__c != null)
                   { 
                        daydiff2  = date.today().daysBetween(m.X2D_Reject_Date__c);
                   }     
                if(m.X3D_Reject_Date__c != null)
                   { 
                       daydiff3  = date.today().daysBetween(m.X3D_Reject_Date__c);
                   }     
                if(m.X4D_Reject_Date__c != null)
                   { 
                        daydiff4  = date.today().daysBetween(m.X4D_Reject_Date__c);
                   }     
                if(m.X5D_Reject_Date__c != null)
                   { 
                        daydiff5 = date.today().daysBetween(m.X5D_Reject_Date__c);
                   }     
                if(m.X6D_Reject_Date__c != null)
                   { 
                        daydiff6 = date.today().daysBetween(m.X6D_Reject_Date__c);
                   }     
                if(m.X7D_Reject_Date__c != null)
                   { 
                        daydiff7 = date.today().daysBetween(m.X7D_Reject_Date__c);
                   }     
               System.Debug(' Date Difference daydiff2  ' + daydiff2  ) ;
               System.Debug(' Date Difference daydiff3  ' + daydiff3  ) ;
               System.Debug(' Date Difference daydiff4 ' + daydiff4  ) ;
               System.Debug(' Date Difference daydiff5  ' + daydiff5  ) ;
               System.Debug(' Date Difference daydiff6  ' + daydiff6  ) ;
               System.Debug(' Date Difference daydiff7  ' + daydiff7  ) ;
               
               if(m.Owner_Approval__c == 'NO' && daydiff2 == 7)
               {
                   try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'2D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(m.CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(m.Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug(' $$$$ MCAR_Batch_Rejected_Reminder IN 2D Step Rejection Letter $$$ ' + mail);
                        mailmessages.add(mail);
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception MCAR_Batch_Rejected_Reminder IN 2D Step Rejection Letter ##' + exe.getMessage());
                    }
               }
               if(m.X3D_Status__c == 'REJECT' && daydiff3 == 7)
               {    
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'3D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(m.CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(m.Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                       
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception MCAR_Batch_Rejected_Reminder IN 3D Step Rejection Letter ##' + exe.getMessage());
                    }
               }
               if(m.X4D_Owner_Approve_Reject__c == 'REJECT' && daydiff4 == 7)
               {    
                   try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'4D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(m.CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(m.Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                       
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception MCAR_Batch_Rejected_Reminder IN 4D Step Rejection Letter ##' + exe.getMessage());
                    }
               }  
               if(m.X5D_Status__c == 'REJECT' && daydiff5 == 7)
               {    
                   try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'5D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(m.CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(m.Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                       
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception MCAR_Batch_Rejected_Reminder IN 5D Step Rejection Letter ##' + exe.getMessage());
                    }
               }
               if(m.X6D_Status__c == 'REJECT' && daydiff6 == 7)
               {    
                   try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'6D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(m.CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(m.Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                       
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception MCAR_Batch_Rejected_Reminder IN 6D Step Rejection Letter ##' + exe.getMessage());
                    }
               }
               if(m.X7D_Status__c == 'REJECT' && daydiff7 == 7)
               {    
                  try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'7D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(m.CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(m.Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                       
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception MCAR_Batch_Rejected_Reminder IN 7D Step Rejection Letter ##' + exe.getMessage());
                    }
               }
         }
         
           try
             {
                 if(mailmessages.size() > 0)
                     {
                        Messaging.sendEmail( mailmessages);    
                     }
             }
             catch(Exception exe)
             {
                 System.Debug('##########Exception MCAR_Batch_Rejected_Reminder while sending email ############### ' + mailmessages);
             }     
    }
    
    global void finish(Database.BatchableContext BC)
    {
          
    }  
}