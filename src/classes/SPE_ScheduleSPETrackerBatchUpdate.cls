global class SPE_ScheduleSPETrackerBatchUpdate  implements Database.Batchable <sObject>, Database.Stateful , Schedulable 
{
    global Set<Id> speTrackerIds;
    
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,1);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        speTrackerIds = new Set<Id>();
        Date TODAYs = Date.today();
        
        string numberOfDays = Label.SPE_ScheduleDateModifier == null ? '0' : Label.SPE_ScheduleDateModifier;

        Integer addDay = integer.valueOf(numberOfDays) == null ? 0 : integer.valueOf(numberOfDays);
        
        TODAYs = TODAYs.addDays(addDay);
        
        String status = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        
        //********************Changes for Encryption********************//
        /*
        String query = 'SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c, spePlan__c '+
                        'FROM SPE_SPEPlanSupplierMap__c '+
                        'WHERE Supplier__r.EnterpriseId__c != NULL AND ' +
                        'speplan__c In (SELECT Id  FROM SPE_SPEPlan__c WHERE StartDate__c <= : TODAYs AND  EndDate__c >=:TODAYs AND  Stage__c =: status)';
        */
        String query = 'SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c, spePlan__c '+
                        'FROM SPE_SPEPlanSupplierMap__c WHERE '+
                        'speplan__c In (SELECT Id FROM SPE_SPEPlan__c WHERE StartDate__c <= : TODAYs AND  EndDate__c >=:TODAYs AND Stage__c =: status)';
       
       //*********************END**************************//
        
        System.debug('The Query is: ' +query);
        
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List <SPE_SPEPlanSupplierMap__c> scope) 
    {
        //********************Changes for Encryption********************//
        if (scope != null && scope[0].Supplier__r.EnterpriseId__c != null)
        //*********************END**************************//
        {
            Date TODAYs = Date.today();
            
            string numberOfDays = Label.SPE_ScheduleDateModifier == null ? '0' : Label.SPE_ScheduleDateModifier;

            Integer addDay = integer.valueOf(numberOfDays) == null ? 0 : integer.valueOf(numberOfDays);
            
            TODAYs = TODAYs.addDays(addDay);
            
            String status = SPE_Constants.STATUS_PENDING;
            
            List<SPE_SPETracker__c> sprTracker = [SELECT Id, SPEPlan__c, SPETemplate__c, Name  FROM SPE_SPETracker__c WHERE SPEPlan__c =: scope[0].spePlan__c  AND DateOfExecution__c =: TODAYs AND Status__c =: status];
            
            if (sprTracker.size() > 0)
            {
                speTrackerIds.add(sprTracker[0].Id);
                //*****************Changes are done as part of Encryption ***************************//
                //SPE_TrackerExecutionExt.SPETrackerExecutionBatch(speTrackerIds, spePlanIds, scope[0].Supplier__r.EnterpriseId__c, scope[0].Supplier__c);
                SPE_TrackerExecutionExt.SPETrackerExecutionBatch(sprTracker[0].Id, sprTracker[0].SPEPlan__c, scope[0].Supplier__r.EnterpriseId__c, scope[0].Supplier__c);
                //*****************End ***************************//
                
            }
            
        }
    }

    global void finish(Database.BatchableContext BC) 
    {
        System.debug('===>'+speTrackerIds);
        SPE_TrackerExecutionExt.aggregateScore(speTrackerIds);
        
        Map<Id,SPE_SPETracker__c> speTrackerMap = new Map<Id,SPE_SPETracker__c>([select Name,SPEPlan__r.Owner.Email from SPE_SPETracker__c where Id In: speTrackerIds]);
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        for (Id speTrId : speTrackerIds)
        {
            String userEmail = String.valueof(Userinfo.getUserEmail());
            
            SPE_SPETracker__c tracker= [select Name,SPEPlan__r.Owner.Email from SPE_SPETracker__c where Id=: speTrId];
            
            String[] toAddresses = new String[] {userEmail, tracker.SPEPlan__r.Owner.Email}; 
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            
            mail.setToAddresses(toAddresses); 
            mail.setSubject(System.Label.SPE_MailSubjectBatch5); 
            
            String body = 'SPE Tracker-'+ tracker.Name +' scheduled by '+String.valueof(UserInfo.getFirstName())+' '+String.valueof(UserInfo.getLastName())+ ' is scheduled Successfully.'+ ''+'Please Find The Link:';
            body = body + '  '+URL.getSalesforceBaseUrl().toExternalForm() + '/'+speTrId; 
            
            mail.setPlainTextBody(body);
             
            mails.add(mail); 
        }
        
        if (mails.size() > 0)
        {
          Messaging.sendEmail(mails);
        }
    }
}