public with sharing class SPE_SPETrackerTrigger 
{
    
    public static void UpdateTracker(SPE_SPETracker__c speTrack)
    {
        list<SPE_ScoringCalculation__c> scoringThreshold = new list<SPE_ScoringCalculation__c>();
        SPE_SPEPlan__c spePlan = [SELECT Id, Name, Stage__c, Region__c, SubRegion__c, Country__c, Category__c, Project__c, SPETemplate__c, SPETemplate__r.Name, StartDate__c, EndDate__c,
                                        FrequencyInMonths__c, SurveyExecutionBeforeIndays__c, SurveyReminderBeforeExecutionDate__c, SurveyHeader__c, SurveyFooter__c, 
                                        CategoryCluster__c, CategoryGroup__c, BusinessUnit__c, BusinessLine__c, Product__c,  SPEScoringTemplate__c 
                                  FROM SPE_SPEPlan__c 
                                  WHERE Id =: speTrack.SPEPlan__c];
        scoringThreshold  = [select id,name,Lower__c,Upper__c,Score__c from SPE_ScoringCalculation__c where ScoringTemplate__c =:speplan.SPEScoringTemplate__c];
        speTrack.Project__c = spePlan.Project__c;
        speTrack.Region__c = spePlan.Region__c;
        speTrack.SubRegion__c = spePlan.SubRegion__c;
        speTrack.Country__c = spePlan.Country__c;
        
        speTrack.BusinessLine__c = spePlan.BusinessLine__c;
        speTrack.BusinessUnit__c = spePlan.BusinessUnit__c;
        speTrack.Product__c = spePlan.Product__c;
        
        speTrack.Category__c = spePlan.Category__c;
        speTrack.CategoryGroup__c = spePlan.CategoryGroup__c;
        speTrack.CategoryCluster__c = spePlan.CategoryCluster__c;
        
        
        Map <String, Integer> months = new Map <String, Integer> {'January'=>1, 'February'=>2, 'March'=>3, 'April'=>4, 'May'=>5, 'June'=>6, 'July'=>7, 'August'=>8, 'September'=>9, 'October'=>10, 'November'=>11, 'December'=>12};    
         
          string spename = speTrack.name;
          List <String> dateParts = spename.split(' - ');  
           Integer month = months.get(dateParts[0]);
           Integer year = Integer.valueOf(dateParts[1]);
           Date parsedDate = Date.newInstance(year,month,1);
           speTrack.Period_Date__c = parsedDate;
          system.debug('test test test '+speTrack.Period_Date__c);
           //update speTrack; //This line commented by rajkumar - 2/11/16 Reason : control came from trigger and it should be updated here 
        
        //start
        /*for(SPE_ScoringCalculation__c score : scoringThreshold )
        {
          
           if(score.score__c==1)
           {
               speTrack.Score_1_lower__c = score.Lower__c;
               speTrack.Score_1_Upper_Bound__c = score.Upper__c;
              
              
           }
           else if(score.Score__c==2)
           {
              speTrack.Score_2_Lower_Bound__c = score.Lower__c;
               speTrack.Score_2_Upper_Bound__c = score.Upper__c;  
                
           }
            else if(score.Score__c==3)
            {
              speTrack.Score_3_Loewr_Bound__c = score.Lower__c;
              speTrack.Score_3_Upper_Bound__c = score.Upper__c;    
                
            }
            else if(score.Score__c==4)
            {
              speTrack.Score_4_Lower_Bound__c = score.Lower__c;
               speTrack.Score_4_Upper_Bound__c = score.Upper__c;
                
            }
            else
            {
               speTrack.Score_4_Lower_Bound__c = null;
               speTrack.Score_4_Upper_Bound__c = null; 
               
            }
           }*/
          
        //end
        
    }
    
    public static List<Decimal> scoreCalculation1 (SPE_TrackerValues__c trackerValue, List<SPE_ScoringCalculation__c> scoringCalculationList, Boolean isHighBetter)
    {
        List<Decimal> scoreList = new List<Decimal>();
        
        if (trackerValue.Value__c == null ||
            scoringCalculationList == null)
        { 
            return scoreList;
        } 
        for (SPE_ScoringCalculation__c sc : scoringCalculationList)
        {
            Decimal score = SPE_MathsUtil.textToArithmeticOperator(sc.Lower__c, sc.LowerTo__c, sc.Upper__c, sc.UpperTo__c, sc.Score__c, trackerValue.Value__c);
            
            if (score != null)
            {
                scoreList.add(score);
                
                Decimal sc1 = trackerValue.Value__c - sc.Lower__c;
                
                Decimal scoreValues = 0;
                 
                if (isHighBetter)
                {
                    scoreValues = sc1/(sc.Upper__c - sc.Lower__c) + score;
                }
                else
                {
                    scoreValues = score - sc1/(sc.Upper__c - sc.Lower__c);
                }
                
                scoreList.add(scoreValues);
                break;
            }
        }
        return scoreList;
    }
    
    public static void RespondentRecordGenerate(List<SPE_SPETracker__c> speTrackers)
    {   
        set<Id> spePlansIDs = new set<Id>();
        
        set<Id> speTrackerIDs = new set<Id>();
        
        for (SPE_SPETracker__c speTrack : speTrackers)
        {
            spePlansIDs.add(speTrack.SPEPlan__c);
            speTrackerIDs.add(speTrack.Id);
        }
         
        Map<Id, List<SPE_Respondent__c>> planRespondentMap = new Map<Id, List<SPE_Respondent__c>>();
        
        Map<Id, List<SPE_TrackerRespondent__c>> trackerRespondentMap = new Map<Id, List<SPE_TrackerRespondent__c>>();
        
        for (SPE_Respondent__c respondent : [SELECT Contact__c, Contact__r.DelegatedContact__c, Contact__r.LeaveTo__c, Contact__r.LeaveFrom__c, Email__c, SPEPlan__c FROM SPE_Respondent__c WHERE SPEPlan__c =: spePlansIDs])
        {
            List<SPE_Respondent__c> respondentList = new List<SPE_Respondent__c>();
            if (planRespondentMap.get(respondent.SPEPlan__c) != null)
            {
                respondentList = planRespondentMap.get(respondent.SPEPlan__c);
            }
            
            respondentList.add(respondent);
            planRespondentMap.put(respondent.SPEPlan__c, respondentList);
        }
        
        for (SPE_TrackerRespondent__c trackerRespondent : [SELECT Id, SPE_Tracker__c, SurveyRespondent__c, IsResponseReceived__c FROM SPE_TrackerRespondent__c WHERE SPE_Tracker__c IN : speTrackerIDs])
        {
            List<SPE_TrackerRespondent__c> trackerRespondentList = new List<SPE_TrackerRespondent__c>();
            if (trackerRespondentMap.get(trackerRespondent.SPE_Tracker__c) != null)
            {
                trackerRespondentList = trackerRespondentMap.get(trackerRespondent.SPE_Tracker__c);
            }
            
            trackerRespondentList.add(trackerRespondent);
            trackerRespondentMap.put(trackerRespondent.SPE_Tracker__c, trackerRespondentList);
        }    
        
        List<SPE_TrackerRespondent__c> toBeUpsertedTrackerRespondents = new List<SPE_TrackerRespondent__c>();
                 
        List<SPE_TrackerRespondent__c> toBeDeletedTrackerRespondents = new List<SPE_TrackerRespondent__c>();
        
        List<Note> toBeInsretedSurveyNote = new List<Note>();
        
        for (SPE_SPETracker__c speTrack : speTrackers)
        {
            if (speTrack.DateOfExecution__c < Date.today() )
            {
                continue;
            }
            if (speTrack.SendSurveyLink__c   && 
                SPE_RecalculateIsSurveyBasePI.recalculateIsSurveyPI(speTrack.SPETemplate__c) &&
                (speTrack.ForceSurvey__c || isSurveyExecute(speTrack) ))
            {    
                 List<SPE_Respondent__c> respondents = planRespondentMap.get(speTrack.SPEPlan__c);
                 
                 Set<Id> respondentId = new Set<Id>();
                 
                 if (respondents != null)
                 {
                    for (SPE_Respondent__c resp:respondents)
                     {
                        respondentId.add(resp.Id);
                     }
                 }
                 
                 Map<Id, Id> respondentIdVsTrackerRespMap = new Map<Id, Id>();
                 
                 
                 Set<Id> toBeDeletedTrackerRespondentIds = new Set<Id> ();
                 if (trackerRespondentMap.get(speTrack.Id) != null)
                 {
                    for (SPE_TrackerRespondent__c extResp : trackerRespondentMap.get(speTrack.Id))
                     {
                        respondentIdVsTrackerRespMap.put(extResp.SurveyRespondent__c, extResp.Id);
                        
                        if (speTrack.ForceSurvey__c == true || (!respondentId.contains(extResp.SurveyRespondent__c)  && extResp.IsResponseReceived__c == false))
                        {
                            toBeDeletedTrackerRespondents.add(extResp);
                            
                            toBeDeletedTrackerRespondentIds.add(extResp.SurveyRespondent__c);
                        }
                      }
                 }
                 
                 if (respondents != null)
                 {
                    for (SPE_Respondent__c resp : respondents )
                     {
                         SPE_TrackerRespondent__c trackerRespondent = new SPE_TrackerRespondent__c ();
                         if (respondentIdVsTrackerRespMap.containsKey(resp.Id) && !toBeDeletedTrackerRespondentIds.contains(resp.Id))
                         {
                            trackerRespondent.Id = respondentIdVsTrackerRespMap.get(resp.Id);
                         }
                         trackerRespondent.Contact__c = resp.Contact__r.LeaveTo__c > System.today() && resp.Contact__r.LeaveFrom__c < System.today() && resp.Contact__r.DelegatedContact__c != null ?resp.Contact__r.DelegatedContact__c : resp.Contact__c;
                         trackerRespondent.SPE_Tracker__c = speTrack.Id;
                         trackerRespondent.SPE_Plan__c = speTrack.SPEPlan__c;
                         trackerRespondent.SurveyRespondent__c = resp.Id;
                         trackerRespondent.ForceSurvey__c = speTrack.ForceSurvey__c;
                         
                         toBeUpsertedTrackerRespondents.add(trackerRespondent);
                         
                     }
                 }
                
                Integer numberOfSurveySent = toBeUpsertedTrackerRespondents.size();
                
                Note nt = new Note();
                nt.Title = speTrack.ForceSurvey__c ? 'Force a Survey' : 'Survey Send/Reminder';
                nt.Body = 'Survey Send for ' + String.valueOf(numberOfSurveySent) + ' Respondent';
                nt.ParentId = speTrack.Id;
                toBeInsretedSurveyNote.add(nt);     
            }
        }
      
        delete toBeDeletedTrackerRespondents;
        upsert toBeUpsertedTrackerRespondents;
        
        insert toBeInsretedSurveyNote;
    }
    
    public static Boolean isSurveyExecute(SPE_SPETracker__c speTracker)
    {
    
        Map<String, Boolean> enterpriseIsSurveyExecuteMap = new Map<String, Boolean>();
        
        Boolean isSurveyExecute = false;
        
        Set<Id> kpiDefinationIds = new Set<Id>();
        
        Set<Id> piDefinationIds = new Set<Id>();
        
        //*******************Changes for Encryption*******************//
        Set<String> enterpriseIds = new  Set<String>();
        Set<ID> enterpriseIdsencrypted = new  Set<ID>(); //*************New Line Added for Encryption***********//
        
        for (SPE_SPEPlanSupplierMap__c speSup : [SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c 
                                                FROM SPE_SPEPlanSupplierMap__c
                                                WHERE SPEPlan__c =: speTracker.SPEPlan__c ])
        {
            enterpriseIds.add(speSup.Supplier__r.EnterpriseId__c);
            enterpriseIdsencrypted.add(speSup.Supplier__c);//*************New Line Added for Encryption***********//
            enterpriseIsSurveyExecuteMap.put(speSup.Supplier__r.EnterpriseId__c, true);
        }
        //**********************END*******************//
        
        Map<Id, Decimal> piAggregationDurationMap = new Map<Id, Decimal>();
        
        for (SPE_SPEKPIMap__c speKPI : [SELECT Id, KPIDefinition__c, KPIDefinition__r.PI_Data__c, KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c  FROM SPE_SPEKPIMap__c WHERE SPE_SPEKPIMap__c.SPETemplate__c =: speTracker.SPETemplate__c])
        {
            kpiDefinationIds.add(speKPI.KPIDefinition__c);
            
            if (speKPI.KPIDefinition__r.PI_Data__c != null && 
              speKPI.KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c == 'Survey')
            {
              piDefinationIds.add(speKPI.KPIDefinition__r.PI_Data__c);
              
              piAggregationDurationMap.put(speKPI.KPIDefinition__r.PI_Data__c, 0);
            } 
        }
        
        for (SPE_KPICalculation__c kpiCal : [SELECT Id, KPIDefinition__c, PIDefination__c, TimeFrame__c FROM SPE_KPICalculation__c 
                                             WHERE KPIDefinition__c IN : kpiDefinationIds 
                                                   AND PIDefination__c != null 
                                                   AND PIDefination__r.DataAcquisitionMethod__c = 'Survey' ])
        {   
            piDefinationIds.add(kpiCal.PIDefination__c);
            
            piAggregationDurationMap.put(kpiCal.PIDefination__c, kpiCal.TimeFrame__c);
        }
        
        
        Decimal maxTimeDuration = 1;
        
        for (Decimal d: piAggregationDurationMap.values())
        {
            maxTimeDuration = math.max(maxTimeDuration, d);
        }
        
        
        maxTimeDuration = maxTimeDuration - 1;
        
        Date speDate = speTracker.DateOfExecution__c.addMonths(-1);
        
        
        Integer numberOfDays = Date.daysInMonth(speDate.year(), speDate.month());
        
        Date endSPEDate = Date.newInstance(speDate.year(), speDate.month(), numberOfDays);
        
        Date startSPEDate1 = speDate.addMonths(-(Integer.valueOf(maxTimeDuration)));
        
        Date startSPEDate = Date.newInstance(startSPEDate1.year(), startSPEDate1.month(), 1);
        
        Set<String> surveyNeedToBeExecute = new Set<String>();
        
        //*******************Changes For Encryption******************//
        /*for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                      Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c, EnterpriseID__c 
                       FROM SPE_PIValues__c 
                       WHERE PIDefination__c In : piDefinationIds 
                       AND EnterpriseID__c In: enterpriseIds
                       AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])*/
                       
         for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                      Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c,EnterpriseIDEncrypted__c,EnterpriseID__c 
                       FROM SPE_PIValues__c 
                       WHERE PIDefination__c In : piDefinationIds 
                       AND EnterpriseIDEncrypted__c In: enterpriseIdsencrypted
                       AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])              
                       
        //*************************END**********************//
        {
            
            
            Decimal piDuration = piAggregationDurationMap.get(kv.PIDefination__c);
            piDuration = piDuration + 1;
            
            Date speDate1 = speDate.addMonths(-(Integer.valueOf(piDuration)));
            
            Date newStartSPEDate = Date.newInstance(speDate1.year(), speDate1.month(), 1);
        
            if (kv.SPETracker__c == speTracker.Id)
            {
                //return isSurveyExecute;
                enterpriseIsSurveyExecuteMap.put(kv.EnterpriseId__c, true);
            
                surveyNeedToBeExecute.add(kv.EnterpriseId__c);
            }
            
            if (surveyNeedToBeExecute.contains(kv.EnterpriseID__c))
            {
                continue;
            }
            
            if (kv.Period__c < newStartSPEDate)
            {
                continue;
            }
            
            if ((true) &&
                ( (speTracker.CategoryCluster__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c || kv.Cluster__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c || kv.Cluster__c == speTracker.CategoryCluster__c) && 
                  (speTracker.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c || kv.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c || kv.CategoryGroup__c == speTracker.CategoryGroup__c) &&
                  (speTracker.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c || kv.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c || kv.Category__c == speTracker.Category__c)
                ) &&
                ( (speTracker.Region__c == PicklistDefaultValues__c.getall().values()[0].Market__c || kv.Region__c== PicklistDefaultValues__c.getall().values()[0].Market__c || kv.Region__c == speTracker.Region__c) &&
                  (speTracker.SubRegion__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c || kv.SubRegion__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c || kv.SubRegion__c == speTracker.SubRegion__c) &&
                  (speTracker.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c || kv.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c || kv.Country__c == speTracker.Country__c) &&
                  (speTracker.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c || kv.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c || kv.Project__c == speTracker.Project__c)
                ) &&
                ( (speTracker.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c || kv.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c || kv.BusinessUnit__c == speTracker.BusinessUnit__c) &&
                  (speTracker.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c || kv.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c || kv.BusinessLine__c == speTracker.BusinessLine__c) &&
                  (speTracker.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c || kv.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c || kv.Product__c == speTracker.Product__c)
                )
               )
            {
                //isSurveyExecute = false;
                enterpriseIsSurveyExecuteMap.put(kv.EnterpriseId__c, false);
            }
        }
        
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