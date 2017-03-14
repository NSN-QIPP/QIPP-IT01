public with sharing class SPE_TrackerExecutionExt 
{
    private Id sprTrackerId;
    public SPE_TrackerExecutionExt (Apexpages.Standardcontroller st)
    {
        sprTrackerId = st.getId();    
    
    }
      
    

    public Pagereference TrackerExecution()
    {
        DeleteExistingTrackerValues(sprTrackerId);
        DeleteExistingTrackerScores(sprTrackerId);
        
        SPE_SPETracker__c sprTracker = [SELECT Id, SPEPlan__c, SPETemplate__c, Name  FROM SPE_SPETracker__c WHERE Id =: sprTrackerId];
        SPE_SPETrackerBatch b = new SPE_SPETrackerBatch(sprTrackerId, sprTracker.SPEPlan__c);
        database.executeBatch(b,1);
        
        return new Pagereference('/'+sprTrackerId);
    }
    
    public static void DeleteExistingTrackerValues (Id trackerId)
    {
        List<SPE_TrackerValues__c> toBeDeletedTrackerValuess = [SELECT Id, DataLogic__c,MissingDatalogic__c, KPIDefinition__c, SPETracker__c, Supplier__c, Supplier__r.EnterpriseId__c, 
                                                            SPETracker__r.Region__c, SPETracker__r.SubRegion__c, SPETracker__r.Country__c, SPETracker__r.Project__c,SurveyComments__c  
                FROM SPE_TrackerValues__c 
                WHERE SPETracker__c =: trackerId];
        
        Database.delete(toBeDeletedTrackerValuess, false);
        
    }
    
    public static void DeleteExistingTrackerScores (Id trackerId)
    {
        List<SPE_TrackerScore__c> toBeDeletedTrackerScores = [SELECT Id FROM SPE_TrackerScore__c WHERE SPETracker__c =: trackerId];
        
        Database.delete(toBeDeletedTrackerScores, false);
    }
    
    public static void SPETrackerExecutionBatch (Id speTrackerId, Id planId, String enterpriseId, Id supplierId)
    {
        SPE_SPETracker__c speTracker = [SELECT Id, Status__c, CategoryCluster__c, CategoryGroup__c, Category__c, Region__c, SubRegion__c, Country__c, Project__c, BusinessUnit__c, 
                                               BusinessLine__c , Product__c, SPEPlan__c, DateOfExecution__c, SPETemplate__c,PilotTestDataCheck__c, Name   
                                        FROM SPE_SPETracker__c 
                                        WHERE Id =: speTrackerId];
    
        
        SPE_SPEPlan__c spePlan = [SELECT Id, Name, Stage__c, Region__c, SubRegion__c, Country__c, Category__c, Project__c, SPETemplate__c, SPETemplate__r.Name, StartDate__c, EndDate__c,
                                         FrequencyInMonths__c, SurveyExecutionBeforeIndays__c, SurveyReminderBeforeExecutionDate__c, SurveyHeader__c, SurveyFooter__c,  
                                         CategoryCluster__c, CategoryGroup__c, BusinessUnit__c, BusinessLine__c, Product__c, SPEScoringTemplate__c,SPEScoringTemplate__r.Stage__c, AggregationDuration__c 
                                  FROM SPE_SPEPlan__c 
                                  WHERE Id =: speTracker.SPEPlan__c];
                       
        Integer toBeaddedMonths = Integer.valueOf(spePlan.AggregationDuration__c);
       
        
        Date toDate = speTracker.DateOfExecution__c.addMonths(-(toBeaddedMonths));
        Date fromDate = speTracker.DateOfExecution__c.addMonths(-1);
        
        Set<String> timeFrame = new Set<String>(); 
    
        List<Date> toBeInludedKPI = new List<Date>();
        
        toBeInludedKPI.add(toDate);
        
        while (toDate <= fromDate )
        {
            toBeInludedKPI.add(toDate);
            
            toDate = toDate.addMonths(1);
        }
        
        for  (Date newDate : toBeInludedKPI)
        {
            String toBeAdded = SPE_Utility.monthsMap.get(newDate.month()) + ' - '+ String.valueOf(newDate.year());
            timeFrame.add(toBeAdded);
        }
        
        Map<Id, List<SPE_ScoringCalculation__c>> kpiScoringCalculationMap = new Map<Id, List<SPE_ScoringCalculation__c>>();
            
        List<SPE_ScoringCalculation__c> scoringCalculation = [SELECT Lower__c, LowerTo__c, Upper__c, UpperTo__c, Score__c, KPIDefinition__c 
                                                              FROM SPE_ScoringCalculation__c
                                                              WHERE ScoringTemplate__c =: spePlan.SPEScoringTemplate__c];
        
        for (SPE_ScoringCalculation__c sc: scoringCalculation)
        {   
            List<SPE_ScoringCalculation__c> newScoringList = new List<SPE_ScoringCalculation__c>();
            
            if (kpiScoringCalculationMap.get(sc.KPIDefinition__c) != null)
            {
                newScoringList = kpiScoringCalculationMap.get(sc.KPIDefinition__c);
            }
            newScoringList.add(sc);
            
            kpiScoringCalculationMap.put(sc.KPIDefinition__c, newScoringList);
             
        }
    
        List<SPE_SPEKPIMap__c> kpiList = [SELECT Id, KPIDefinition__c, Weight__c, KPIGroup1__c, KPIDefinition__r.MissingDatalogic__c, KPIDefinition__r.IsHighBetter__c
                                          FROM SPE_SPEKPIMap__c 
                                          WHERE SPETemplate__c =: speTracker.SPETemplate__c];
        
        Set<Id> kpiDefinitionIds = new Set<Id>();
        for (SPE_SPEKPIMap__c kpi : kpiList)
        {
            kpiDefinitionIds.add(kpi.KPIDefinition__c);
        }
        
        List<SPE_KPIValue__c> kpiValues = new List<SPE_KPIValue__c>();
         //**********************Changes Done As Part of Encryption*****************************//
        /*kpiValues = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c, KPIDefinition__r.Aggregation__c,
                                                  Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c 
                                           FROM SPE_KPIValue__c
                                           WHERE KPIDefinition__c In: kpiDefinitionIds
                                           AND EnterpriseId__c =: enterpriseId
                                           AND KPIValue__c != null
                                           AND ExecutionPeriod__c IN : timeFrame];*/
                                           
        kpiValues = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c, KPIDefinition__r.Aggregation__c,
                                                  Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c,SurveyComments__c 
                                           FROM SPE_KPIValue__c
                                           WHERE KPIDefinition__c In: kpiDefinitionIds
                                           AND EnterpriseIDEncrypted__c =: supplierId
                                           AND KPIValue__c != null
                                           AND ExecutionPeriod__c IN : timeFrame];                                 
        //************************END****************************//
    
        system.debug('===>'+kpiValues);
        Map<Id, List<Decimal>> kpiValuesMap = new Map<Id, List<Decimal>>();
        Map<Id,String> kpiAggregationMap =new Map<Id,String>();
        
        Map<Id, Map<String, String>> kpiEnterpriseCommentsMap = new Map<Id, Map<String, String>>(); 
        
        for (SPE_KPIValue__c kv : kpiValues)
        {
            if ( kv.KPIValue__c != null && enterpriseId == kv.EnterpriseId__c &&
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
                List<Decimal> kpiValuesList = new List<Decimal>();
                
                if (kpiValuesMap.get(kv.KPIDefinition__c) != null )
                {
                    kpiValuesList = kpiValuesMap.get(kv.KPIDefinition__c);
                }
                
                kpiValuesList.add(kv.KPIValue__c);
            
                kpiValuesMap.put(kv.KPIDefinition__c, kpiValuesList);
                
                kpiAggregationMap.put(kv.KPIDefinition__c, kv.KPIDefinition__r.Aggregation__c);
                
                // *** Survey Comments *** //
                Map<String, String> enterpriseCommentsMap = new Map<String, String>();
            
                if (kpiEnterpriseCommentsMap.get(kv.KPIDefinition__c) != null)
                {
                    enterpriseCommentsMap = kpiEnterpriseCommentsMap.get(kv.KPIDefinition__c);
                }
                
                String surveyComments = '';
                if (enterpriseCommentsMap.get(supplierId) != null)
                {
                    surveyComments = enterpriseCommentsMap.get(supplierId);
                }
                
                surveyComments = surveyComments == ''?  kv.SurveyComments__c : surveyComments + ' | ' + kv.SurveyComments__c;
                
                enterpriseCommentsMap.put(supplierId, surveyComments);
                
                kpiEnterpriseCommentsMap.put(kv.KPIDefinition__c, enterpriseCommentsMap);
                system.debug('===kpiEnterpriseCommentsMap====>' + kpiEnterpriseCommentsMap);
                // *** Survey Comments *** //
            }
            
        }
        
        
        Map<Id, Decimal> actualKPIValuesMap = new Map<Id, Decimal>();
        
        for (Id kpiId : kpiValuesMap.keySet())
        {
            actualKPIValuesMap.put(kpiId, ListToAggregate(kpiAggregationMap.get(kpiId), kpiValuesMap.get(kpiId)));
        }
        
        List<SPE_TrackerValues__c> toBeInsertedTrackerValues = new List<SPE_TrackerValues__c>();
        
        for (SPE_SPEKPIMap__c kpi:  kpiList)
        {
            SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
            trackerValue.Supplier__c = supplierId;
            trackerValue.KPIDefinition__c = kpi.KPIDefinition__c;
            trackerValue.SPETracker__c = speTracker.Id;  
            trackerValue.Weight__c = kpi.Weight__c; 
            trackerValue.KPIGroup__c = kpi.KPIGroup1__c;
            trackerValue.MissingDatalogic__c = kpi.KPIDefinition__r.MissingDatalogic__c;
            
            trackerValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpi.KPIDefinition__c) != null && kpiEnterpriseCommentsMap.get(kpi.KPIDefinition__c).get(supplierId) != null) ? kpiEnterpriseCommentsMap.get(kpi.KPIDefinition__c).get(supplierId) : '';
            
            if (actualKPIValuesMap.get(kpi.KPIDefinition__c) != null)
            {
                trackerValue.DataLogic__c = SPE_Constants.DATALOGICACTUAL; 
                trackerValue.Value__c = actualKPIValuesMap.get(kpi.KPIDefinition__c); 
                    
                trackerValue = scoreCalculation(trackerValue, kpiScoringCalculationMap.get(kpi.KPIDefinition__c), kpi.KPIDefinition__r.IsHighBetter__c);
            }
               System.debug('*************************');
            if (trackerValue.DataLogic__c != SPE_Constants.DATALOGICACTUAL)
            {
                if (kpi.KPIDefinition__r.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC1)
                {
                    trackerValue.DataLogic__c = SPE_Constants.DATALOGICASSUMED; 
                    //trackerValue.Value__c = SPE_MissingDataLogic.LogicFirst(kpi.KPIDefinition__c, toBeaddedMonths, fromDate, enterpriseId, speTracker);
                    trackerValue = SPE_MissingDataLogic.LogicFirst(kpi.KPIDefinition__c, toBeaddedMonths, fromDate, enterpriseId, speTracker, trackerValue);
                             system.debug('Control is in data logic');
                    trackerValue = scoreCalculation(trackerValue, kpiScoringCalculationMap.get(kpi.KPIDefinition__c), kpi.KPIDefinition__r.IsHighBetter__c);
                }
                else if (kpi.KPIDefinition__r.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC2)
                {
                    trackerValue.DataLogic__c = SPE_Constants.DATALOGICINVALID;
                }
                
            }
            toBeInsertedTrackerValues.add(trackerValue);
        }
               insert toBeInsertedTrackerValues; 
            System.debug('*******************************************************'+toBeInsertedTrackerValues);
        
        //veera   
        
         //SPE_Tracker_score.speTeackerPillerScores(toBeInsertedTrackerValues);
        
        
        //veera
       
         trackerScoreGenerate(supplierId, speTrackerId, toBeInsertedTrackerValues);
        
        speTracker.Status__c = SPE_Constants.STATUS_COMPLETED;
        speTracker.PilotTestDataCheck__c = spePlan.SPEScoringTemplate__r.Stage__c == 'Pilot' ? True : False;
        
        //update speTracker;
        
    }
    
    @TestVisible
    private static void trackerScoreGenerate(Id suppId, Id TrackerId, List<SPE_TrackerValues__c> TrackerValues)
    {
        List<SPE_TrackerScore__c> trackerScores = new List<SPE_TrackerScore__c>();
        
        Set<String> grps = new Set<String>();
        
        Map<String, List<Decimal>> groupScoresMaps = new Map<String, List<Decimal>>();
        Map<String, List<Decimal>> groupWeightMaps = new Map<String, List<Decimal>>();
            
        for (SPE_TrackerValues__c trackerValue : TrackerValues)
        {
            List<Decimal> scores = new List<Decimal>();
            List<Decimal> weight = new List<Decimal>();
            
            if (groupScoresMaps.get(trackerValue.KPIGroup__c) != null)
            {
                scores = groupScoresMaps.get(trackerValue.KPIGroup__c);
            }
            
            if (groupWeightMaps.get(trackerValue.KPIGroup__c) != null)
            {
                weight = groupWeightMaps.get(trackerValue.KPIGroup__c);
            }
            
            System.debug('Tracker Score ' + trackerValue.Score1__c);
            System.debug('Tracker Weight' + trackerValue.Weight__c);
            if(trackerValue.Score1__c != null){
                scores.add( trackerValue.Score1__c * trackerValue.Weight__c);
            }
            else{
                scores.add( trackerValue.Score1__c);
            }
           
            weight.add(trackerValue.Weight__c);
            
            groupScoresMaps.put(trackerValue.KPIGroup__c , scores);
            groupWeightMaps.put(trackerValue.KPIGroup__c, weight);
            grps.add(trackerValue.KPIGroup__c);
        }
        
        Decimal sumSPEScore = 0;
        Decimal cntSPEScore = 0;
        Decimal overAllWeightageScore = 0;
        Decimal overAlltotalWeightage = 0;
      
        for (String grp : grps)
        {
            Decimal totalWeightage = 0;
            Decimal sumScore = 0;
            Decimal averageScore = 0;
            Decimal weightageScore = 0;
            Integer cnt = 0;
            Decimal productSum = 0;
                
            for (Decimal d : groupWeightMaps.get(grp))
            {
                totalWeightage = totalWeightage + d;
            }
            for (Decimal d : groupScoresMaps.get(grp))
            {
                
                if (d == null)
                {
                    sumScore = null;
                    break;
                }
                else{
                    sumScore = sumScore == null ? null :  sumScore + d;
                }
            }

            productSum = totalWeightage == 0 ? 0 : (sumScore == null) ? null : (sumScore == 0 )? 0: (sumScore/totalWeightage);

            SPE_TrackerScore__c trackerScore = new SPE_TrackerScore__c();
            trackerScore.Group__c = grp;
            trackerScore.Supplier__c = suppId;
            trackerScore.SPETracker__c = TrackerId;
            trackerScore.Score__c = productSum == null ? null : productSum.setScale(4);
            trackerScore.SPEScore__c = false;
            
            trackerScores.add(trackerScore); 
            
            totalWeightage = totalWeightage == null ? 0 : totalWeightage;
            
            overAllWeightageScore = (sumScore == null || overAllWeightageScore == null) ? null : overAllWeightageScore + sumScore;
            overAlltotalWeightage = overAlltotalWeightage + totalWeightage;
             
        }
          
       
        Decimal avgSPEScore = (overAllWeightageScore == null) ? null : overAllWeightageScore/overAlltotalWeightage ;
        
        SPE_TrackerScore__c trackerScore = new SPE_TrackerScore__c();
        trackerScore.Group__c = null;
        trackerScore.Supplier__c = suppId;
        trackerScore.SPETracker__c = TrackerId;
        trackerScore.Score__c = avgSPEScore == null ? null : avgSPEScore.setScale(4);
        trackerScore.SPEScore__c = true;
        
        trackerScores.add(trackerScore);

        insert trackerScores; 
    }
    
    public static void aggregateScore(Set<Id> trackerIds)
    {
        
        List<SPE_TrackerScore__c> trackerScores = new List<SPE_TrackerScore__c>();
        List<SPE_TrackerScore__c> aggregateTrackerScoresforKPI = new List<SPE_TrackerScore__c>();
        
        Map<Id, List<SPE_TrackerScore__c>> trackerScoreMap = new Map<Id, List<SPE_TrackerScore__c>>(); 
        
        for (SPE_TrackerScore__c ts : [SELECT id,Group__c,Score__c, SPETracker__c from SPE_TrackerScore__c where SPETracker__c In: trackerIds])
        {
            List<SPE_TrackerScore__c> trackerScoreList = new List<SPE_TrackerScore__c>();
            
            if (trackerScoreMap.get(ts.SPETracker__c) != null)
            {
                trackerScoreList = trackerScoreMap.get(ts.SPETracker__c);
            }
            
            trackerScoreList.add(ts);
            system.debug('=====trackerScoreList==>' + trackerScoreList);
            trackerScoreMap.put(ts.SPETracker__c, trackerScoreList);
        }
        
        Map<Id, List<SPE_TrackerValues__c>> trackervaluesMap = new Map<Id, List<SPE_TrackerValues__c>>();
        
        for (SPE_TrackerValues__c tv: [SELECT id,Score1__c,KPIDefinition__c, SPETracker__c from SPE_TrackerValues__c where SPETracker__c In: trackerIds])
        {
            List<SPE_TrackerValues__c> trackerValuesList = new List<SPE_TrackerValues__c>();
            
            if (trackervaluesMap.get(tv.SPETracker__c) != null)
            {
                trackerValuesList = trackervaluesMap.get(tv.SPETracker__c);
            }
            
            trackerValuesList.add(tv);
            
            trackervaluesMap.put(tv.SPETracker__c, trackerValuesList);
        }
        
        
        for (Id TrackerId : trackerIds)
        {
            Set<String> grps = new Set<String>();
        
            Set<Decimal> setScores = new Set<Decimal>();
        
            Map<String, List<Decimal>> groupScoresMaps = new Map<String, List<Decimal>>();
        
            List<SPE_TrackerScore__c> trackerScoreList = new List<SPE_TrackerScore__c>();
            trackerScoreList = trackerScoreMap.get(TrackerId);
            Set<Decimal> isScoreNULL = new Set<Decimal>();
        
            
            for (SPE_TrackerScore__c speTrackScore : trackerScoreList)
            {
                List<Decimal> scores = new List<Decimal>();
                if (groupScoresMaps.get(speTrackScore.Group__c) != null)
                {
                    scores = groupScoresMaps.get(speTrackScore.Group__c);
                }
                
                scores.add(speTrackScore.Score__c);
                groupScoresMaps.put(speTrackScore.Group__c , scores);
                grps.add(speTrackScore.Group__c );
            }
        
            for (String grp : grps)
            {
                
                Decimal sumScore = 0;
                Decimal averageScore = 0;
                Integer cnt = 0;
                for (Decimal d : groupScoresMaps.get(grp))
                {
                    
                    if (d!=null && d!=0)
                    {
                        sumScore  = sumScore == null ? null : sumScore  + d;
                        cnt ++;     
                    }
                    else
                    {
                        sumScore =  null;
                        cnt ++;
                    }
                }
                
                averageScore = cnt == 0 ? 0 : (sumScore == null ? null :sumScore/cnt);
                        
                        
                SPE_TrackerScore__c trackerScore = new SPE_TrackerScore__c();
                trackerScore.Group__c = grp;
                trackerScore.SPETracker__c = TrackerId;
                trackerScore.Score__c = averageScore == null ? null : averageScore.setScale(4);
                trackerScore.SPEScore__c = false;
                
                trackerScores.add(trackerScore);
            }
            
            List<SPE_TrackerValues__c> trackerValueList = new List<SPE_TrackerValues__c>();
            trackerValueList = trackervaluesMap.get(TrackerId);
        
            Map<Id, Boolean> kpiIdIsNullScoreMap = new Map<Id, Boolean>();
            for (SPE_TrackerValues__c speTrackVal : trackerValueList)
            {
                Boolean isNull = false;
                if  (kpiIdIsNullScoreMap.get(speTrackVal.KPIDefinition__c) != null)
                {
                    isNull = kpiIdIsNullScoreMap.get(speTrackVal.KPIDefinition__c);
                }
                
                isNull =  (isNull || speTrackVal.Score1__c == null) ? true : false;
                    
                kpiIdIsNullScoreMap.put(speTrackVal.KPIDefinition__c, isNull);  
            }
            
            for(AggregateResult aggregateTrackerKPI :[SELECT KPIDefinition__c,AVG(Score1__c) tv from SPE_TrackerValues__c where SPETracker__c =: TrackerId AND KPIDefinition__c In: kpiIdIsNullScoreMap.keySet() GROUP BY KPIDefinition__c] )
            {
                SPE_TrackerScore__c trackerScoreKPI = new SPE_TrackerScore__c();
            
                trackerScoreKPI.KPIName__c = String.ValueOf(aggregateTrackerKPI.get('KPIDefinition__c'));
                trackerScoreKPI.Score__c= kpiIdIsNullScoreMap.get(trackerScoreKPI.KPIName__c) ? null : (Decimal)aggregateTrackerKPI.get('tv');  
                trackerScoreKPI.SPETracker__c = TrackerId;
                trackerScores.add(trackerScoreKPI);
            }
        
        }
        
        List<SPE_SPETracker__c> trackerList = [SELECT Id, Status__c, SPEPlan__c, SPEPlan__r.SPEScoringTemplate__r.Stage__c FROM  SPE_SPETracker__c  WHERE id In: trackerIds]; 
    
        List<Note> toBeInsretedSurveyNote = new List<Note>();
        
        List<SPE_SPETracker__c> toBeUpdatedSpeTracker = new List<SPE_SPETracker__c>();
        
        for (SPE_SPETracker__c speTracker : trackerList)
        {
            speTracker.Status__c = SPE_Constants.STATUS_COMPLETED;
            speTracker.PilotTestDataCheck__c = speTracker.SPEPlan__r.SPEScoringTemplate__r.Stage__c == 'Pilot' ? True : False;
        
            Note nt = new Note();
            nt.Title = 'SPE Tracker Executed';
            nt.Body = 'SPE Tracker Executed';
            nt.ParentId = speTracker.Id;
            toBeInsretedSurveyNote.add(nt);  
            toBeUpdatedSpeTracker.add(speTracker);   
        }
        update toBeUpdatedSpeTracker;
        
        insert trackerScores;
        
        insert toBeInsretedSurveyNote;
    }
    public static Decimal ListToAggregate(String aggr, List<Decimal> values)
    {    
        decimal result=0;
        Decimal sum = 0;
        Integer cnt = 0;
        values.sort();
        
        if(aggr == SPE_Constants.KPIAGGREGATION_AVG || aggr == null)
        {
            for (Decimal d : values)
            {
                sum = sum + d;
                cnt ++;
            }
            result = (cnt == 0 || sum ==0 ) ? 0 : sum/cnt;
        }
        else if(aggr == SPE_Constants.KPIAGGREGATION_SUM)
        {
            for (Decimal d : values)
            {
                 sum = sum + d;
                 result=sum;
            }
        }  
       else if(aggr == SPE_Constants.KPIAGGREGATION_MIN)
        {
            result = (values !=null && values[0] != null ) ? values[0] : 0;
        }
        else if(aggr == SPE_Constants.KPIAGGREGATION_MAX)
        {
            result= (values !=null && values[0] != null ) ? values[values.size()-1] : 0;
        }
        
        return result.setscale(4);
    }
    
    public static SPE_TrackerValues__c scoreCalculation (SPE_TrackerValues__c trackerValue, List<SPE_ScoringCalculation__c> scoringCalculationList, Boolean isHighBetter)
    {
        if (trackerValue.Value__c == null ||
            scoringCalculationList == null)
        { 
            return trackerValue;
        } 
        for (SPE_ScoringCalculation__c sc : scoringCalculationList)
        {
            Decimal score = SPE_MathsUtil.textToArithmeticOperator(sc.Lower__c, sc.LowerTo__c, sc.Upper__c, sc.UpperTo__c, sc.Score__c, trackerValue.Value__c);
            
            if (score != null)
            {
                
                trackerValue.Score__c = score.setscale(4);
                
                Decimal sc1 = trackerValue.Value__c - sc.Lower__c;
                
                Decimal scoreValues = 0;
                 
                if (isHighBetter)
                {
                    if (sc.UpperTo__c == '<=')
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : (sc1/(sc.Upper__c - sc.Lower__c + 0.0001) + score);
                    }
                    else
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : (sc1/(sc.Upper__c - sc.Lower__c) + score);
                    }
                }
                else
                {
                    if (sc.LowerTo__c == '>=')
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : score - (sc1/(sc.Upper__c - sc.Lower__c + 0.0001)) + 1;
                    }
                    else
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : score - (sc1/(sc.Upper__c - sc.Lower__c)) + 1;
                    }
                }
                
                scoreValues  = scoreValues > 4 ? 4 : (scoreValues < 1 ? 1 : scoreValues);
                
                trackerValue.Score1__c = scoreValues;
                break;
            }
        }
        return trackerValue;
    }
}