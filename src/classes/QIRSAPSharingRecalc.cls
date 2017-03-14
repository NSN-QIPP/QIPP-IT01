global class QIRSAPSharingRecalc  { 
/*

static String emailAddress = 'tejas.kardile@igatepatni.com';

global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT QIRS__r.Id,Id, Approver1__c, Approver2__c,Approver3__c,Approver4__c,Approver5__c,
                                        Approver6__c,Approver7__c,Approver8__c,Approver9__c,Approver10__c,Champion1__c,
                                        Champion10__c,Champion2__c,Champion3__c,Champion4__c,Champion5__c,Champion6__c,
                                        Champion7__c,Champion8__c,Champion9__c
                                         FROM QIRS_Action_Plan__c]);  
    }
global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
         Map<ID, QIRS_Action_Plan__c> jobMap = new Map<ID, QIRS_Action_Plan__c>((List<QIRS_Action_Plan__c>)scope);
         List<QIRS__Share> newQIRSShrs = new List<QIRS__Share>();
         List<QIRS__Share> oldQIRSShrs = [SELECT Id FROM QIRS__Share WHERE Id IN 
             :jobMap.keySet() AND 
            (RowCause = :Schema.QIRS__Share.rowCause.CaseOwner__c OR
            RowCause = :Schema.QIRS__Share.rowCause.ChampApprover__c OR
            RowCause = :Schema.QIRS__Share.rowCause.Master_Approver__c )]; 

         for(QIRS_Action_Plan__c QIRSAP : jobMap.values())
         {
            QIRS__Share ChampShr  = new QIRS__Share();
          

            // Set the ID of record being shared 
    
            ChampShr.ParentId = QIRSAP.QIRS__r.Id;
           

            
            List<Id> ChampIds = new List<Id>();
            ChampIds.add(QIRSAP.Champion1__c);
            ChampIds.add(QIRSAP.Champion2__c);
            ChampIds.add(QIRSAP.Champion3__c);
            ChampIds.add(QIRSAP.Champion4__c);
            ChampIds.add(QIRSAP.Champion5__c);
            ChampIds.add(QIRSAP.Champion6__c);
            ChampIds.add(QIRSAP.Champion7__c);
            ChampIds.add(QIRSAP.Champion8__c);
            ChampIds.add(QIRSAP.Champion9__c);
            ChampIds.add(QIRSAP.Champion10__c);
            ChampIds.add(QIRSAP.Approver1__c);
            ChampIds.add(QIRSAP.Approver10__c);
            ChampIds.add(QIRSAP.Approver2__c);
            ChampIds.add(QIRSAP.Approver3__c);
            ChampIds.add(QIRSAP.Approver4__c);
            ChampIds.add(QIRSAP.Approver5__c);
            ChampIds.add(QIRSAP.Approver6__c);
            ChampIds.add(QIRSAP.Approver7__c);
            ChampIds.add(QIRSAP.Approver8__c);
            ChampIds.add(QIRSAP.Approver9__c);


            List<Id> DistMastApprIds = new List<Id>();
            Boolean RepeatedId;
            
            for(integer i = 0; i < ChampIds.size(); i++){
                RepeatedId = FALSE;
                for(integer j = 0; j < DistMastApprIds.size(); j++)
                    if(DistMastApprIds[j] == ChampIds[i])
                        RepeatedId = TRUE;
                if(RepeatedId == False)
                    DistMastApprIds.add(ChampIds[i]);
                }
                
            integer i = 0;
            for(Id MasterAppr : DistMastApprIds)
                if(MasterAppr != null){
                    ChampShr = new QIRS__Share();
                    ChampShr.ParentId = QIRSAP.QIRS__c;
                    ChampShr.UserOrGroupId = MasterAppr;
                    ChampShr.AccessLevel = 'edit';
                    ChampShr.RowCause = Schema.QIRS__Share.RowCause.ChampApprover__c;
                    newQIRSShrs.add(ChampShr);
                    }
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