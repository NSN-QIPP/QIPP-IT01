public with sharing class SPE2_SurveyTrackerTrigger 
{
    
    public static void UpdateTracker(SPE2_SurveyTracker__c speTrack)
    {
        
        SPE2Survey__c speSurvey = [SELECT Id, Name, Stage__c, Market__c, MarketUnit__c, Country__c, Category__c, Project__c,StartDate__c, EndDate__c,FrequencyInMonths__c, SurveyExecutionBeforeIndays__c, SurveyReminderBeforeExecutionDate__c, CategoryArea__c, CategoryGroup__c, BusinessUnit__c, BusinessLine__c, Product__c
        FROM SPE2Survey__c 
        WHERE Id =: speTrack.Survey__c];
       
        speTrack.Project__c = speSurvey.Project__c;
        speTrack.Market__c = speSurvey.Market__c;
        speTrack.MarketUnit__c = speSurvey.MarketUnit__c;
        speTrack.Country__c = speSurvey.Country__c;
        
        speTrack.BusinessLine__c = speSurvey.BusinessLine__c;
        speTrack.BusinessUnit__c = speSurvey.BusinessUnit__c;
        speTrack.Product__c = speSurvey.Product__c;
        
        speTrack.Category__c = speSurvey.Category__c;
        speTrack.CategoryGroup__c = speSurvey.CategoryGroup__c;
        speTrack.CategoryArea__c = speSurvey.CategoryArea__c;
      
        //start
        
          
        //end
        
    }
    
    
    public static void RespondentRecordGenerate(List<SPE2_SurveyTracker__c> speTrackers)
    {   
        set<Id> spePlansIDs = new set<Id>();
        
        set<Id> speTrackerIDs = new set<Id>();
        
        for (SPE2_SurveyTracker__c speTrack : speTrackers)
        {
            spePlansIDs.add(speTrack.Survey__c);
            speTrackerIDs.add(speTrack.Id);
        }
        system.debug('speTrackerIDs ::'+speTrackerIDs); 
        Map<Id, List<SPE2_Survey_Respondents__c>> planRespondentMap = new Map<Id, List<SPE2_Survey_Respondents__c>>();
        
        Map<Id, List<SPE2_SurveyTrackerRespondent__c>> trackerRespondentMap = new Map<Id, List<SPE2_SurveyTrackerRespondent__c>>();
        
        for (SPE2_Survey_Respondents__c respondent : [SELECT Contact__c, Contact__r.DelegatedContact__c, Contact__r.LeaveTo__c, Contact__r.LeaveFrom__c, Email__c, Survey__c FROM SPE2_Survey_Respondents__c WHERE Survey__c =: spePlansIDs])
        {
            List<SPE2_Survey_Respondents__c> respondentList = new List<SPE2_Survey_Respondents__c>();
            if (planRespondentMap.get(respondent.Survey__c) != null)
            {
                respondentList = planRespondentMap.get(respondent.Survey__c);
            }
            
            respondentList.add(respondent);
            planRespondentMap.put(respondent.Survey__c, respondentList);
        }
        system.debug('planRespondentMap ::'+planRespondentMap);
        for (SPE2_SurveyTrackerRespondent__c trackerRespondent : [SELECT Id, Survey_Tracker__c, SurveyRespondent__c, IsResponseReceived__c FROM SPE2_SurveyTrackerRespondent__c WHERE Survey_Tracker__c IN : speTrackerIDs])
        {
            List<SPE2_SurveyTrackerRespondent__c> trackerRespondentList = new List<SPE2_SurveyTrackerRespondent__c>();
            if (trackerRespondentMap.get(trackerRespondent.Survey_Tracker__c) != null)
            {
                trackerRespondentList = trackerRespondentMap.get(trackerRespondent.Survey_Tracker__c);
            }
            
            trackerRespondentList.add(trackerRespondent);
            trackerRespondentMap.put(trackerRespondent.Survey_Tracker__c, trackerRespondentList);
        }    
         system.debug('trackerRespondentMap ::'+trackerRespondentMap);
        List<SPE2_SurveyTrackerRespondent__c> toBeUpsertedTrackerRespondents = new List<SPE2_SurveyTrackerRespondent__c>();
                 
        List<SPE2_SurveyTrackerRespondent__c> toBeDeletedTrackerRespondents = new List<SPE2_SurveyTrackerRespondent__c>();
        
        List<Note> toBeInsretedSurveyNote = new List<Note>();
        system.debug('speTrackers :::'+speTrackers);
        for (SPE2_SurveyTracker__c speTrack : speTrackers)
        {
            system.debug('respondentmapVal ::'+planRespondentMap.get(speTrack.Survey__c));
            system.debug('date of execution'+speTrack.DateOfExecution__c);
            
            if (speTrack.Survey_Execution_Date__c< Date.today() )
            {
                continue;
                system.debug('enetered in 1st IF block');
            }
            system.debug('survey link :::'+speTrack.SendSurveyLink__c);
            system.debug('survey execute :::'+isSurveyExecute(speTrack));
            if (speTrack.SendSurveyLink__c  && isSurveyExecute(speTrack) )
            {    
                 system.debug('enetered in 2nd IF block');
                 List<SPE2_Survey_Respondents__c> respondents = planRespondentMap.get(speTrack.Survey__c);
                 system.debug('respondents **'+respondents);
                 Set<Id> respondentId = new Set<Id>();
                 
                 if (respondents != null)
                 {
                    for (SPE2_Survey_Respondents__c resp:respondents)
                     {
                        respondentId.add(resp.Id);
                     }
                 }
                 system.debug('respondentId ::'+respondentId);
                 Map<Id, Id> respondentIdVsTrackerRespMap = new Map<Id, Id>();
                                 
                 Set<Id> toBeDeletedTrackerRespondentIds = new Set<Id> ();
                 if (trackerRespondentMap.get(speTrack.Id) != null)
                 {
                    for (SPE2_SurveyTrackerRespondent__c extResp : trackerRespondentMap.get(speTrack.Id))
                     {
                        respondentIdVsTrackerRespMap.put(extResp.SurveyRespondent__c, extResp.Id);
                        
                        if ((!respondentId.contains(extResp.SurveyRespondent__c)  && extResp.IsResponseReceived__c == false))
                        {
                            toBeDeletedTrackerRespondents.add(extResp);
                            
                            toBeDeletedTrackerRespondentIds.add(extResp.SurveyRespondent__c);
                        }
                      }
                 }
                 system.debug('respondents ::'+respondents);
                 if (respondents != null)
                 {
                    for (SPE2_Survey_Respondents__c resp : respondents)
                     {
                         SPE2_SurveyTrackerRespondent__c trackerRespondent = new SPE2_SurveyTrackerRespondent__c ();
                         if (respondentIdVsTrackerRespMap.containsKey(resp.Id) && !toBeDeletedTrackerRespondentIds.contains(resp.Id))
                         {
                            trackerRespondent.Id = respondentIdVsTrackerRespMap.get(resp.Id);
                         }
                         trackerRespondent.Contact__c = resp.Contact__r.LeaveTo__c > System.today() && resp.Contact__r.LeaveFrom__c < System.today() && resp.Contact__r.DelegatedContact__c != null ?resp.Contact__r.DelegatedContact__c : resp.Contact__c;
                         trackerRespondent.Survey_Tracker__c = speTrack.Id;
                         trackerRespondent.Survey__c = speTrack.Survey__c;
                         trackerRespondent.SurveyRespondent__c = resp.Id;
                         //trackerRespondent.ForceSurvey__c = speTrack.ForceSurvey__c;
                         
                         toBeUpsertedTrackerRespondents.add(trackerRespondent);
                         
                     }
                 }
                
                Integer numberOfSurveySent = toBeUpsertedTrackerRespondents.size();
                
                Note nt = new Note();
                nt.Title = 'Survey Send/Reminder';
                nt.Body = 'Survey Send for ' + String.valueOf(numberOfSurveySent) + ' Respondent';
                nt.ParentId = speTrack.Id;
                toBeInsretedSurveyNote.add(nt);     
            }
        }
      
        delete toBeDeletedTrackerRespondents;
        upsert toBeUpsertedTrackerRespondents;
        
        insert toBeInsretedSurveyNote;
    }
    
    public static Boolean isSurveyExecute(SPE2_SurveyTracker__c speTracker)
    {
        system.debug('entered last method');
        Map<String, Boolean> enterpriseIsSurveyExecuteMap = new Map<String, Boolean>();
        
        Boolean isSurveyExecute = false;
        
        Set<Id> kpiDefinationIds = new Set<Id>();
        
        Set<Id> piDefinationIds = new Set<Id>();
        
        //*******************Changes for Encryption*******************//
        Set<String> enterpriseIds = new  Set<String>();
        Set<ID> enterpriseIdsencrypted = new  Set<ID>(); //*************New Line Added for Encryption***********//
        
        for (SPE2_SurveySupplierMap__c speSup : [SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c 
                                                FROM SPE2_SurveySupplierMap__c
                                                WHERE SPE2_Survey__c =: speTracker.Survey__c ])
        {
            enterpriseIds.add(speSup.Supplier__r.EnterpriseId__c);
            enterpriseIdsencrypted.add(speSup.Supplier__c);//*************New Line Added for Encryption***********//
            enterpriseIsSurveyExecuteMap.put(speSup.Supplier__r.EnterpriseId__c, true);
        }
        //**********************END*******************//
        
      
        system.debug('enterpriseIsSurveyExecuteMap ::'+enterpriseIsSurveyExecuteMap.values());
        for (Boolean b : enterpriseIsSurveyExecuteMap.values())
        {
            if (b)
            {
                isSurveyExecute = true;
            }
        }
        return isSurveyExecute;
    }
}