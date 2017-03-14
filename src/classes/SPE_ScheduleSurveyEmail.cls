global class  SPE_ScheduleSurveyEmail implements Database.Batchable <sObject>, Schedulable 
{
  global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,1);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Date TODAYs = Date.today();
       
        String status = SPE_Constants.STATUS_PENDING;
        
        String query = 'SELECT Id, SendSurveyLink__c '+
                        'FROM SPE_SPETracker__c '+
                        'WHERE ( SurveyExecutionBeforeIndays__c = : TODAYs OR SurveyReminderBeforeExecutionDate__c =: TODAYs ) AND  Status__c =: status';
       
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List <SPE_SPETracker__c> scope) 
    {
      for (SPE_SPETracker__c st : scope)
      {
        System.debug('==========>'+st.Id);
        st.SendSurveyLink__c = true;
      }
      
      update scope;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
      
    }
}