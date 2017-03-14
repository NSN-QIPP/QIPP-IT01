global class SPE_SPETrackerBatch implements Database.Batchable<sObject>
{
    
    global Id speTrackerIds;
    global Id spePlanIds;
    
    public SPE_SPETrackerBatch (String speTrackerId, Id spePlanId)
    {
        speTrackerIds = speTrackerId;
        spePlanIds = spePlanId;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id speTrackerIds = this.speTrackerIds;
        Id spePlanIds = this.spePlanIds;
        
        String query = 'SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c FROM SPE_SPEPlanSupplierMap__c WHERE SPEPlan__c =: spePlanIds ';
        
        return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext BC, list<SPE_SPEPlanSupplierMap__c> scope) 
    {
        //*****************Changes are done as part of Encryption ***************************//
        //SPE_TrackerExecutionExt.SPETrackerExecutionBatch(speTrackerIds, spePlanIds, scope[0].Supplier__r.EnterpriseId__c, scope[0].Supplier__c);
        SPE_TrackerExecutionExt.SPETrackerExecutionBatch(speTrackerIds, spePlanIds, scope[0].Supplier__r.EnterpriseId__c, scope[0].Supplier__c);
        
        //*****************End ***************************//
    }
    
    global void finish(Database.BatchableContext BC) 
    {
       
        Set<Id> trackerId = new Set<Id>();
        trackerId.add(speTrackerIds);
        SPE_TrackerExecutionExt.aggregateScore(trackerId);
        SPE_SPETrackerBatch1 b1 = new SPE_SPETrackerBatch1(speTrackerIds);
        Database.executeBatch(b1, 1);
        /*String userEmail =String.valueof(Userinfo.getUserEmail()); 
        String trackerName= [select Name from SPE_SPETracker__c where Id=: speTrackerIds].name;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        
        String[] toAddresses = new String[] {userEmail}; 
        mail.setToAddresses(toAddresses); 
        mail.setSubject(System.Label.SPE_MailSubjectBatch5); 
        String body = 'SPE Tracker-'+ trackerName +' scheduled by '+String.valueof(UserInfo.getFirstName())+' '+String.valueof(UserInfo.getLastName())+ ' is scheduled Successfully.'+ ''+'Please Find The Link:';
        body = body + '  '+URL.getSalesforceBaseUrl().toExternalForm() + '/'+speTrackerIds; 
        mail.setPlainTextBody(body); 
        Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});*/
    }
    

}