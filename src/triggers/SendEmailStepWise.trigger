trigger SendEmailStepWise on MCAR__c (after insert , after update) 
{
    List<Mcar__c> objPreviousMCAR = Trigger.Old;
    System.Debug('###objPreviousMCAR ### ' + objPreviousMCAR);
    
    List<MCar__c> currentMCAR = Trigger.new;
    System.Debug('### currentMCAR[0] outside ### ' + currentMCAR[0]);
    
    User RecordOwner = [select ID , Email from User where Id in (select OwnerId from MCAR__c where Id =: currentMCAR[0].Id) ];
    List<String> email = new List<String>();
    email.Add(RecordOwner.Email);
    
    if(Trigger.isInsert)
    {
    // The below snippet commented by Thiresh on 03-Jul-2013

        List<Messaging.SingleEmailMessage> mailmessages = new List<Messaging.SingleEmailMessage>();
       /*
        if(currentMCAR[0].Manufacture_Accepts_Fault__c == 'NO')
        {
           try
           {
            EmailTemplate et=[Select id from EmailTemplate where name=:'2DEmailTemplate'];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(currentMCAR[0].CreatedById);
            mail.setToAddresses(email);
            mail.setWhatId(currentMCAR[0].Id);    
            mail.setSaveAsActivity(false);
            mail.setTemplateId(et.id);
            mailmessages.add(mail);
            }
            catch(Exception exe)
            {
                System.Debug('## Exception ##' + exe.getMessage());
            }
        }
        */
        // The below snippet added by Thiresh on 11-June-2013---------------MCAR_User__c
        
           List<String> manuemail1 = new List<String>();
           List<MCAR_Manufacturer_Contact__c> OtherEmailList1 = [select Email__c from MCAR_Manufacturer_Contact__c]; 
           if(OtherEmailList1.size() > 0)
            { 
               for(MCAR_Manufacturer_Contact__c other1 :  OtherEmailList1)
               {
                   manuemail1.add(other1.Email__c);
               }
           }  
           System.Debug('################## selected Manufacture Contacts Part 1 : ' + manuemail1);
            if(currentMCAR[0].Owner_Approval__c  == 'NO')
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'2D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail1);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY ### IN 2D Step Rejection Letter' + mail);
                        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });                     
                        mailmessages.add(mail);
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception 2D Step Rejection Letter##' + exe.getMessage());
                    }
             } 

        
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
           List<String> lstmanuemail = new List<String>();
           List<MCAR_Email_List__c> OtherEmailList = [select MCAR_Email__c from MCAR_Email_List__c where MCAR__c =: currentMCAR[0].Id and MCAR_Contact_Type__c=:'OTHER' and MCAR_Selected__c = true]; 
           if(OtherEmailList.size() > 0)
           { 
               for(MCAR_Email_List__c other :  OtherEmailList)
               {
                   lstmanuemail.add(other.MCAR_Email__c);
               }
           }  
         
          
            if(currentMCAR[0].Owner_Approval__c  == 'NO')
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'2D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(lstmanuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY ### IN 2D Step Rejection Letter' + mail);
                        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });                     
                        mailmessages.add(mail);
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception 2D Step Rejection Letter##' + exe.getMessage());
                    }
             }
            if(currentMCAR[0].X3D_Status__c  == 'REJECT')
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'3D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(lstmanuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                       
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 3D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if(currentMCAR[0].X4D_Owner_Approve_Reject__c  == 'REJECT')
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'4D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(lstmanuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 4D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if(currentMCAR[0].X5D_Status__c  == 'REJECT' )
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'5D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(lstmanuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 5D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if(currentMCAR[0].X6D_Status__c  == 'REJECT')
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'6D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(lstmanuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 6D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if(currentMCAR[0].X7D_Status__c  == 'REJECT')
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'7D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(lstmanuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        mailmessages.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 7D Step Rejection Letter' + exe.getMessage());
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
                 System.Debug('########## mailmessages in if ############### ' + mailmessages);
             }        
             
     }  
     
     else
     {

        List<Messaging.SingleEmailMessage> mailmessages1 = new List<Messaging.SingleEmailMessage>();
       //Done BY Chandra on 23rd Novem 2013 for restricting the erranious mails to User.
        /*if(currentMCAR[0].Manufacture_Accepts_Fault__c == 'NO' && objPreviousMCAR[0].Manufacture_Accepts_Fault__c != 'NO')
        {
           try
           {
            EmailTemplate et=[Select id from EmailTemplate where name=:'2DEmailTemplate'];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(currentMCAR[0].CreatedById);
            mail.setToAddresses(email);
            mail.setWhatId(currentMCAR[0].Id);    
            mail.setSaveAsActivity(false);
            mail.setTemplateId(et.id);
            mailmessages1.add(mail);
           }
            catch(Exception exe)
            {
                System.Debug('## Exception ##' + exe.getMessage());
            }
        }*/
        
           List<String> manuemail = new List<String>();
           List<MCAR_Email_List__c> OtherEmailList = [select MCAR_Email__c from MCAR_Email_List__c where MCAR__c =: currentMCAR[0].Id and MCAR_Contact_Type__c=:'OTHER' and MCAR_Selected__c = true]; 
           if(OtherEmailList.size() > 0)
           { 
               for(MCAR_Email_List__c other :  OtherEmailList)
               {
                   manuemail.add(other.MCAR_Email__c);
               }
           }  
           System.Debug('################## selected Manufacture Contacts Part 2 : ' + manuemail);
           
            if((currentMCAR[0].Owner_Approval__c == 'NO') && (objPreviousMCAR[0].Owner_Approval__c != 'NO'))
            {
                    try
                    {    
                        EmailTemplate et=[Select id from EmailTemplate where name=:'2D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY ### IN 2D Step Rejection Letter' + mail);
                        mailmessages1.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception 2D Step Rejection Letter##' + exe.getMessage());
                   }
             }
            if((currentMCAR[0].X3D_Status__c == 'REJECT') && (objPreviousMCAR[0].X3D_Status__c != 'REJECT'))
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'3D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY IN 3D Step Rejection Letter###' + mail);
                        mailmessages1.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 3D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if((currentMCAR[0].X4D_Owner_Approve_Reject__c == 'REJECT' ) && (objPreviousMCAR[0].X4D_Owner_Approve_Reject__c != 'REJECT'))
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'4D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY IN 4D Step Rejection Letter###' + mail);
                        mailmessages1.add(mail);
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 4D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if((currentMCAR[0].X5D_Status__c == 'REJECT') && (objPreviousMCAR[0].X5D_Status__c != 'REJECT'))
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'5D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY IN 5D Step Rejection Letter###' + mail);
                        mailmessages1.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 5D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if((currentMCAR[0].X6D_Status__c == 'REJECT' )&& (objPreviousMCAR[0].X6D_Status__c != 'REJECT'))
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'6D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY IN 6D Step Rejection Letter###' + mail);
                        mailmessages1.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 6D Step Rejection Letter' + exe.getMessage());
                    }
             }
            if((currentMCAR[0].X7D_Status__c == 'REJECT') && (objPreviousMCAR[0].X7D_Status__c != 'REJECT'))
            {
                    try
                    {
                        EmailTemplate et=[Select id from EmailTemplate where name=:'7D Step Rejection Letter'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(currentMCAR[0].CreatedById);
                        mail.setToAddresses(manuemail);
                        mail.setWhatId(currentMCAR[0].Id);    
                        mail.setSaveAsActivity(false);
                        mail.setTemplateId(et.id);
                        System.Debug('### MAIL BODY IN 7D Step Rejection Letter###' + mail);
                        mailmessages1.add(mail);                        
                    }
                    catch(Exception exe)
                    {
                        System.Debug('## Exception ## IN 7D Step Rejection Letter' + exe.getMessage());
                    }
             }
             
             try
             {
                 if(mailmessages1.size() > 0)
                     {
                        Messaging.sendEmail( mailmessages1);    
                     }
             }
             catch(Exception exe)
             {
                 System.Debug('########## mailmessages in if ############### ' + mailmessages1);
             }     
     }
}