global class QIRSSharingRecalc  {
/*
static String emailAddress = 'tejas.kardile@igatepatni.com';
Group g = [SELECT Id FROM group WHERE name = 'QIRS Admin Group'];    
global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT Id, Process_Owner1__c 
                                         FROM QIRS__c]);  
    }
global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
         Map<ID, QIRS__c> jobMap = new Map<ID, QIRS__c>((List<QIRS__c>)scope);
         List<QIRS__Share> newQIRSShrs = new List<QIRS__Share>();
         List<QIRS__Share> oldQIRSShrs = [SELECT Id FROM QIRS__Share WHERE Id IN 
             :jobMap.keySet() AND 
            (RowCause = :Schema.QIRS__Share.rowCause.CaseOwner__c OR
            RowCause = :Schema.QIRS__Share.rowCause.ChampApprover__c OR
            RowCause = :Schema.QIRS__Share.rowCause.Master_Approver__c )]; 

         for(QIRS__c qirs : jobMap.values())
         {
            QIRS__Share qirsCOShr = new QIRS__Share();
            QIRS__Share qirsAdminShr = new QIRS__Share();
             if(qirs.Process_Owner1__c != null){
                    qirsCOShr.ParentId = qirs.Id;
                    qirsCOShr.UserOrGroupId = QIRS.Process_Owner1__c;
                    qirsCOShr.AccessLevel = 'edit';
                    qirsCOShr.RowCause = Schema.QIRS__Share.RowCause.CaseOwner__c;
                    newQIRSShrs.add(qirsCOShr);
                    }
                    qirsAdminShr.UserOrGroupId = g.Id;
                    qirsAdminShr.AccessLevel = 'edit';
                    qirsAdminShr.RowCause = Schema.QIRS__Share.RowCause.Master_Approver__c;
                    qirsAdminShr.ParentId = qirs.Id;
                    newQIRSShrs.add(qirsAdminShr);
         }
           try {
           // Delete the existing sharing records.  
    
           // This allows new sharing records to be written from scratch.  
    
            Delete oldQIRSShrs;
            
           // Insert the new sharing records and capture the save result.   
    
           // The false parameter allows for partial processing if multiple records are   
    
           // passed into operation.   
    
           Database.SaveResult[] lsr = Database.insert(newQIRSShrs,false);
           
           // Process the save results for insert.  
    
           for(Database.SaveResult sr : lsr){
               if(!sr.isSuccess()){
                   // Get the first save result error.  
    
                   Database.Error err = sr.getErrors()[0];
                   
                   // Check if the error is related to trivial access level.  
    
                   // Access levels equal or more permissive than the object's default   
    
                   // access level are not allowed.      
    
                   // These sharing records are not required and thus an insert exception   
    
                   // is acceptable.   
    
                   if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                     &&  err.getMessage().contains('AccessLevel'))){
                       // Error is not related to trivial access level.  
    
                       // Send an email to the Apex job's submitter.  
    
                     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                     String[] toAddresses = new String[] {emailAddress}; 
                     mail.setToAddresses(toAddresses); 
                     mail.setSubject('Apex Sharing Recalculation Exception');
                     mail.setPlainTextBody(
                       'The Apex sharing recalculation threw the following exception: ' + 
                        err.getMessage());
                     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                   }
               }
           }   
        } catch(DmlException e) {
           // Send an email to the Apex job's submitter on failure.  
    
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {emailAddress}; 
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Apex Sharing Recalculation Exception');
            mail.setPlainTextBody(
              'The Apex sharing recalculation threw the following exception: ' + 
              e.getMessage());
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }


    
    }
    global void finish(Database.BatchableContext BC){  
        // Send an email to the Apex job's submitter notifying of job completion.  
    
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {emailAddress}; 
        mail.setToAddresses(toAddresses); 
        mail.setSubject('Apex Sharing Recalculation Completed.');
        mail.setPlainTextBody
                      ('The Apex sharing recalculation finished processing');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
*/
}