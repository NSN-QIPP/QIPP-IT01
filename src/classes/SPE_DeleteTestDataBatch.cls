global class SPE_DeleteTestDataBatch implements Database.Batchable<sObject>,Schedulable{

/**************************************************************************************
Apex Class Name      :  SPE_DeleteTestDataBatch
Version              :  1.0 
Created Date         :  08/31/2015
Function             :  This batch is used to delete PI Values or KPI Values
              
Modification Log     :
* ------------------------------------------------------------------------------------
* Developer                   Date                   Description
* ------------------------------------------------------------------------------------                  
* Kaushik Ganguly             08/31/2015                      Original Version
* Soma Giri                   09/02/2015                      Added execute method for Schedulable Interface
*************************************************************************************/   
    
    String query; 
    String SObjectName; // Holds the sobject name for which the test data needs to be deleted
    Id recordId; // Holds the record id
    Id recOwnerId; // Holds the record's owner id
    String strEmailId; // Holds the email id of the record owner
    global SPE_DeleteTestDataBatch(Id recId){
        recordId = recId;
        SObjectName = recId.getSObjectType().getDescribe().getName(); // fetches the sobject name
        recOwnerId = UserInfo.getUserId(); // fetches the record owner id
        String strTempUserQuery = 'Select Email from User Where Id =: recOwnerId';
        SObject userRecDetails = Database.query(strTempUserQuery);
        strEmailId = String.ValueOf(userRecDetails.get('Email')); // fetches the email id of the owner
    }
    
    
     global void execute(SchedulableContext sc) 
    {
       
       Database.executeBatch(new SPE_DeleteTestDataBatch(RecordId), 2000); 
          if(!Test.isRunningTest()){
        system.abortJob(sc.getTriggerId());
        }
    }
    
    // Start Method
    global Database.QueryLocator start(Database.BatchableContext BC){
     
         /********************************************************
                        ALGORITHM
            1. Checking the object name to form the query
            2. If Object is PI Data, query from PI Values
            3. If Object is KPI, query from KPI Values
         **********************************************************/
         if(SObjectName.equalsIgnoreCase('SPE_PIDefinition__c')){
             query = 'Select Id from SPE_PIValues__c Where PIDefination__c =:recordId';
         }
         if(SObjectName.equalsIgnoreCase('SPE_KPIDefinition__c')){
             query = 'Select Id from SPE_KPIValue__c Where KPIDefinition__c =:recordId';
         }
         
         return Database.getQueryLocator(query);
    }
  
   // Execute Logic
   global void execute(Database.BatchableContext BC, List<sObject>scope){      
       try{
           database.delete(scope,true);
       }
       catch(Exception ex){
           System.debug('Exception :: ' + ex.getMessage());
       }
   }
   
   // Finish Logic
   global void finish(Database.BatchableContext BC){
        
        // Sending completion mail to the owner
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        String[] toAddresses = new String[] {strEmailId}; 
        mail.setToAddresses(toAddresses);
        String body = 'Test Data Deletion Complete'; 
        mail.setPlainTextBody(body); 
        Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
   }
}