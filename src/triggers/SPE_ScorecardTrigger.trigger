trigger SPE_ScorecardTrigger on SPE_ScoreCard__c (before insert,after update) 
{
if(trigger.isBefore){
    
    }














if(trigger.isAfter){
    
    Set<Id> scoreId = new Set<Id>();
    
    List<ScorecardKPIMap__c> toBeCreatedScorecardKPIMaps = new List<ScorecardKPIMap__c>();
            
    for (SPE_ScoreCard__c scoreCard: trigger.new)
    {
        Date strtDate = scoreCard.StartDate__c;
        system.debug('***strtDate' + strtDate);
        List<Date> toBeStartTracker = new List<Date>();
            
        while (strtDate <= scoreCard.EndDate__c )
        {
            toBeStartTracker.add(strtDate);
            system.debug('***toBeStartTracker' + toBeStartTracker);
            
            strtDate = strtDate.addMonths(1);
        }
        system.debug('***strtDate' + strtDate);
        Set<String> trackerNames = new Set<String>();
            
        for  (Date sDate : toBeStartTracker)
        {
            trackerNames.add(SPE_Utility.monthsMap.get(sDate.month()) + ' - '+ String.valueOf(sDate.year()));
        }
         system.debug('***trackerNames' + trackerNames);
            
        List<SPE_ScorecardSPETemplateMap__c> scoreCardSPETemplateMaps = [SELECT Id, SPETemplate__c, Weight__c
                                                                         FROM SPE_ScorecardSPETemplateMap__c
                                                                         WHERE ScorecardTemplate__c=: scoreCard.ScorecardTemplate__c];
        
        system.debug('***scoreCardSPETemplateMaps' + scoreCardSPETemplateMaps);
        
        Set<Id> speTemplates = new Set<Id>();
            
        for (SPE_ScorecardSPETemplateMap__c sst : scoreCardSPETemplateMaps)
        {
            speTemplates.add(sst.SPETemplate__c);
        }
        
        system.debug('***speTemplates' + speTemplates);
        
        List<SPE_SPEKPIMap__c> speKPImaps =  [SELECT Id, KPIDefinition__c, SPETemplate__c, KPI_Target__c 
                                              FROM SPE_SPEKPIMap__c
                                              WHERE SPETemplate__c IN: speTemplates];
        
        system.debug('***speKPImaps' + speKPImaps);
        
        Map<Id, Map<Id, Decimal>> speKPItargetMaps = new Map<Id, Map<Id, Decimal>>();   
                                      
        for (SPE_SPEKPIMap__c spe: speKPImaps)
        {
            Map<Id, Decimal> kpiTargetMaps = new Map<Id, Decimal>();
            if (speKPItargetMaps.get(spe.SPETemplate__c) != null )
            {
                kpiTargetMaps = speKPItargetMaps.get(spe.SPETemplate__c);
            }   
            
            kpiTargetMaps.put(spe.KPIDefinition__c, spe.KPI_Target__c);
            system.debug('***kpiTargetMaps' + kpiTargetMaps);
            speKPItargetMaps.put(spe.SPETemplate__c, kpiTargetMaps);
        } 
        
        
        system.debug('***speKPItargetMaps' + speKPItargetMaps);
        
        Map<Id, Map<Id, Map<Id,List<SPE_TrackerValues__c>>>> planTemplateKPITrackerValuesMap = new Map<Id, Map<Id, Map<Id,List<SPE_TrackerValues__c>>>>();
        
        system.debug('****scoreCard.EnterpriseId__c'+scoreCard.EnterpriseId__c);
        system.debug('****scoreCard'+scoreCard);
        
      //****************************************Changes Done for Encryption*********************************//  
        /*for (SPE_TrackerValues__c tracker: [SELECT Id, KPIDefinition__c, SPETracker__r.CategoryCluster__c, SPETracker__r.CategoryGroup__c, SPETracker__r.Category__c, 
                                                   SPETracker__r.Region__c, SPETracker__r.SubRegion__c, SPETracker__r.Country__c, SPETracker__r.Project__c, Score__c,
                                                   SPETemplate__c, Value__c, SPETracker__r.BusinessUnit__c, SPETracker__r.BusinessLine__c, SPETracker__r.Product__c,
                                                   SPETracker__r.SPEPlan__c
                                            FROM SPE_TrackerValues__c
                                            WHERE SPETracker__r.Name In: trackerNames AND 
                                                  EnterpriseId__c =: scoreCard.EnterpriseId__c AND
                                                  SPETemplate__c In: speTemplates])*/
                                                  
        for (SPE_TrackerValues__c tracker: [SELECT Id, KPIDefinition__c, SPETracker__r.CategoryCluster__c, SPETracker__r.CategoryGroup__c, SPETracker__r.Category__c, 
                                                   SPETracker__r.Region__c, SPETracker__r.SubRegion__c, SPETracker__r.Country__c, SPETracker__r.Project__c, Score__c,
                                                   SPETemplate__c, Value__c, SPETracker__r.BusinessUnit__c, SPETracker__r.BusinessLine__c, SPETracker__r.Product__c,
                                                   SPETracker__r.SPEPlan__c
                                            FROM SPE_TrackerValues__c
                                            WHERE SPETracker__r.Name In: trackerNames AND                                                  
                                                  SPETemplate__c In: speTemplates])                                          
                                                  
                                                  
        //************************************************END*******************************************//                                          
        {
        
            System.debug(scoreCard.CategoryCluster__c == tracker.SPETracker__r.CategoryCluster__c);
            System.debug(scoreCard.CategoryGroup__c == tracker.SPETracker__r.CategoryGroup__c);
            System.debug(scoreCard.Category__c == tracker.SPETracker__r.Category__c);
            System.debug(scoreCard.Region__c == tracker.SPETracker__r.Region__c);   
            System.debug(scoreCard.SubRegion__c == tracker.SPETracker__r.SubRegion__c); 
            System.debug(scoreCard.SubRegion__c == tracker.SPETracker__r.Country__c);   
            System.debug(scoreCard.Region__c == tracker.SPETracker__r.Region__c);   
        
        //****************************************Changes Done for Encryption*********************************//    
            if (  (tracker.EnterpriseId__c == scoreCard.EnterpriseId__c) &&
                ( (tracker.SPETracker__r.CategoryCluster__c == 'All Category Area' || scoreCard.CategoryCluster__c == tracker.SPETracker__r.CategoryCluster__c) && 
                  (tracker.SPETracker__r.CategoryGroup__c == 'All Category Group' || scoreCard.CategoryGroup__c == tracker.SPETracker__r.CategoryGroup__c) &&
                  (tracker.SPETracker__r.Category__c == 'All Category' || scoreCard.Category__c == tracker.SPETracker__r.Category__c)
                ) &&
                ( (tracker.SPETracker__r.Region__c == 'All CO Region' || scoreCard.Region__c == tracker.SPETracker__r.Region__c) &&
                  (tracker.SPETracker__r.SubRegion__c == 'All CO Subregion' || scoreCard.SubRegion__c == tracker.SPETracker__r.SubRegion__c) &&
                  (tracker.SPETracker__r.Country__c == 'All CO Country' || scoreCard.Country__c == tracker.SPETracker__r.Country__c) &&
                  (tracker.SPETracker__r.Project__c == 'All Project' || scoreCard.Project__c == tracker.SPETracker__r.Project__c)
                ) &&
                ( (tracker.SPETracker__r.BusinessUnit__c == 'All Business Unit' || scoreCard.BusinessUnit__c == tracker.SPETracker__r.BusinessUnit__c) &&
                  (tracker.SPETracker__r.BusinessLine__c == 'All Business Line' || scoreCard.BusinessLine__c == tracker.SPETracker__r.BusinessLine__c) &&
                  (tracker.SPETracker__r.Product__c == 'All Product' || scoreCard.Product__c == tracker.SPETracker__r.Product__c)
                )
               )
          //**********************************************END*****************************************//     
               
            {
                
                Map<Id, Map<Id,List<SPE_TrackerValues__c>>> templateKPITrackerValuesMap = new Map<Id, Map<Id,List<SPE_TrackerValues__c>>>();
                
                if (planTemplateKPITrackerValuesMap.get(tracker.SPETracker__r.SPEPlan__c) != null)
                {
                    templateKPITrackerValuesMap = planTemplateKPITrackerValuesMap.get(tracker.SPETracker__r.SPEPlan__c);
                }
            
                system.debug('***templateKPITrackerValuesMap' + templateKPITrackerValuesMap);
            
                Map<Id, List<SPE_TrackerValues__c>> kpiTrackerValueMaps = new Map< Id, List<SPE_TrackerValues__c>>();
                
                if (templateKPITrackerValuesMap.get(tracker.SPETemplate__c) != null)
                {
                    kpiTrackerValueMaps = templateKPITrackerValuesMap.get(tracker.SPETemplate__c);
                }   
                
                system.debug('***kpiTrackerValueMaps' + kpiTrackerValueMaps);
                
                List<SPE_TrackerValues__c> trackerValues = new List<SPE_TrackerValues__c>();
                
                if (kpiTrackerValueMaps.get(tracker.KPIDefinition__c) != null)
                {
                    trackerValues = kpiTrackerValueMaps.get(tracker.KPIDefinition__c);
                }
                
                system.debug('***trackerValues' + trackerValues);
                
                
                trackerValues.add(tracker);
                system.debug('***trackerValues' + trackerValues);
                
                
                kpiTrackerValueMaps.put(tracker.KPIDefinition__c, trackerValues);
                system.debug('***kpiTrackerValueMaps' + kpiTrackerValueMaps);
                
                templateKPITrackerValuesMap.put(tracker.SPETemplate__c, kpiTrackerValueMaps);
                system.debug('***templateKPITrackerValuesMap' + templateKPITrackerValuesMap);
            
                planTemplateKPITrackerValuesMap.put(tracker.SPETracker__r.SPEPlan__c, templateKPITrackerValuesMap);
                system.debug('***planTemplateKPITrackerValuesMap' + planTemplateKPITrackerValuesMap);
            }
        }
        
        
        
        
        
        
        
        Map<String, Map<String,Decimal>> aggregateResult = new Map<String, Map<String,Decimal>>();
        
        
        List<SPE_Comparableinterface> weightageLogics = new List<SPE_Comparableinterface>();
        system.debug('Custom Setting Values--' + SPE_WeightageLogic__c.getall().values());
        for (SPE_WeightageLogic__c wl : SPE_WeightageLogic__c.getall().values())
        {
            weightageLogics.add(new SPE_Comparableinterface(wl, 'Index__c'));   
        }
        
        system.debug('***weightageLogics' + weightageLogics);
        
        weightageLogics.sort();
        
        String logic = 'Logic-1';
        for (SPE_Comparableinterface cInterface : weightageLogics)
        {
            SPE_WeightageLogic__c wl = (SPE_WeightageLogic__c) cInterface.mainObj;
            if (scorecard.CategoryCluster__c == wl.CategoryCluster__c)
            {
                logic = wl.Logic__c;
                break;
            } 
        }
        
        if  (logic == 'Logic-2')
        { 
            Map<String, Map<String, Map<String,Decimal>>> enterPriseIdAggregateResult = SPE_WeightageCalculation.weightageData(new Set<String> {scorecard.EnterpriseId__c}, trackerNames, 'Spend', 
                                                                                        30000, scoreCard.CategoryCluster__c, scoreCard.CategoryGroup__c, scoreCard.Category__c, 
                                                                                        scoreCard.Region__c, scoreCard.SubRegion__c, scoreCard.Country__c, 
                                                                                        scoreCard.Project__c, scoreCard.BusinessUnit__c);
        
            aggregateResult = enterPriseIdAggregateResult.get(scorecard.EnterpriseId__c);
        }
        
        
        System.debug('***'+aggregateResult);
        
        System.debug('***'+planTemplateKPITrackerValuesMap);
        
        //templateKPITrackerValuesMap
        for (Id palnId : planTemplateKPITrackerValuesMap.keySet())
        {
            for (Id tempId : planTemplateKPITrackerValuesMap.get(palnId).keySet())
            {
                for (Id kpiId: planTemplateKPITrackerValuesMap.get(palnId).get(tempId).keySet())
                {
                    Decimal totalKPIValues = 0, totalKPICount = 0;
                    
                    if (logic == 'Logic-2')
                    {
                        Map<String, Map<String, Map<String, Map<String, Decimal>>>> regionSubregionCountryProjectMap = new Map<String, Map<String, Map<String, Map<String, Decimal>>>>();
                
                        for (SPE_TrackerValues__c tracker: planTemplateKPITrackerValuesMap.get(palnId).get(tempId).get(kpiId))
                        {
                            totalKPIValues = totalKPIValues + tracker.Value__c;
                            totalKPICount ++;
                        
                            Map<String, Map<String, Map<String, Decimal>>>  subregionCountryProjectMap = new Map<String, Map<String, Map<String, Decimal>>>();
                            if (regionSubregionCountryProjectMap.get(tracker.SPETracker__r.Region__c) != null)
                            {
                                subregionCountryProjectMap = regionSubregionCountryProjectMap.get(tracker.SPETracker__r.Region__c);
                            }
                        
                            Map<String, Map<String, Decimal>> countryProjectMap = new Map<String, Map<String, Decimal>>();
                            if (subregionCountryProjectMap.get(tracker.SPETracker__r.SubRegion__c) !=null)
                            {
                                countryProjectMap = subregionCountryProjectMap.get(tracker.SPETracker__r.SubRegion__c);
                            }  
                        
                            Map<String, Decimal> projectMap = new Map<String, Decimal>();
                            if (countryProjectMap.get(tracker.SPETracker__r.Country__c) != null)
                            {
                                projectMap = countryProjectMap.get(tracker.SPETracker__r.Country__c);
                            }
                        
                            projectMap.put(tracker.SPETracker__r.Project__c, tracker.Score__c);
                        
                            countryProjectMap.put(tracker.SPETracker__r.Country__c, projectMap);
                        
                            subregionCountryProjectMap.put(tracker.SPETracker__r.SubRegion__c, countryProjectMap);
                        
                            regionSubregionCountryProjectMap.put(tracker.SPETracker__r.Region__c, subregionCountryProjectMap);
                        }
                    
                        Decimal Score = 0, totalRegionSpend = 0, regionSpend = 0, regionScore = 0;
                        
                        System.debug('====>'+regionSubregionCountryProjectMap);
                        
                        for (String region : regionSubregionCountryProjectMap.keySet())
                        {
                        
                            Decimal subRegionScore = 0, totalSubRegionSpend = 0, subRegionSpend = 0;
                        
                            System.debug('====>'+region);
                            
                            if (region != null)
                            {
                                for (String subRegion: regionSubregionCountryProjectMap.get(region).keySet())
                                {
                                    Decimal countrySpend = 0, totalCoutrySpend = 0;
                                    
                                    System.debug('====>'+subRegion);
                                
                                    if (subRegion != null)
                                    {
                                        for (String country: regionSubregionCountryProjectMap.get(region).get(subRegion).keySet())
                                        {
                                        
                                            Decimal projectSum = 0, projectCount = 0, projectScore = 0; 
                                        
                                            if (country != null)
                                            {
                                                System.debug('====>'+subRegion);
                                                
                                                for (String project: regionSubregionCountryProjectMap.get(region).get(subRegion).get(country).keySet())
                                                {
                                                    
                                                    System.debug('====>'+project);
                                                    
                                                    projectScore = regionSubregionCountryProjectMap.get(region).get(subRegion).get(country).get(project) == null ? 0 : regionSubregionCountryProjectMap.get(region).get(subRegion).get(country).get(project);
                                                    projectSum = projectSum + projectScore; 
                                                    
                                                    System.debug('=projectScore===>'+projectScore);
                                                
                                                    projectCount ++;        
                                                }
                                            
                                                projectScore = projectCount == 0 ? 0: projectSum/projectCount;
                                            }
                                            else
                                            {
                                                projectScore = regionSubregionCountryProjectMap.get(region).get(subRegion).get(null).get(null);
                                            
                                                projectSum = projectSum + projectScore; 
                                            }
                                            
                                            System.debug('=projectScore===>'+projectScore);
                                        
                                            System.debug('=aggregateResult===>'+aggregateResult);
                                        
                                            Decimal countrySpendValue = ((aggregateResult.get('Country') == null || aggregateResult.get('Country').get(country) == null) ? 0 : aggregateResult.get('Country').get(country));
                                        
                                            System.debug('=countrySpendValue===>'+countrySpendValue);
                                        
                                            countrySpend = countrySpend + ( countrySpendValue * projectScore);
                                        
                                            totalCoutrySpend = totalCoutrySpend + countrySpendValue;
                                    
                                        }
                                        subRegionScore = totalCoutrySpend == 0 ? 0 : countrySpend/totalCoutrySpend;
                                    }
                                    else
                                    {
                                        subRegionScore = regionSubregionCountryProjectMap.get(region).get(null).get(null).get(null);
                                    }
                                
                                    Decimal subRegionSpendValue =  (aggregateResult.get('Sub-region') == null || aggregateResult.get('Sub-region').get(subRegion) == null) ? 0 : aggregateResult.get('Sub-region').get(subRegion);
                        
                                    System.debug('=subRegionSpendValue===>'+subRegionSpendValue);
                                    
                                    subRegionSpend = subRegionSpend + (subRegionSpendValue * subRegionScore);
                                
                                    totalSubRegionSpend = totalSubRegionSpend + (subRegionSpendValue);
                                
                                }
                        
                                regionScore = totalSubRegionSpend == 0 ? 0 : subRegionSpend/totalSubRegionSpend ;
                            } 
                            else
                            {
                                regionScore =  regionSubregionCountryProjectMap.get(null).get(null).get(null).get(null);
                            }
                        
                            Decimal regionSpendValue =  (aggregateResult.get('Region') == null || aggregateResult.get('Region').get(region) == null) ? 0 : aggregateResult.get('Region').get(region);
                        
                            System.debug('=regionSpendValue===>'+regionSpendValue);
                            
                            regionSpend = regionSpend + (regionSpendValue * regionScore);
                        
                            totalRegionSpend = totalRegionSpend + regionSpendValue;
                        
                        }
                    
                        score = totalRegionSpend == 0 ? 0 : regionSpend/totalRegionSpend ;
    
                        ScorecardKPIMap__c scoreCardKPI = new ScorecardKPIMap__c();
                    
                        scoreCardKPI.ScoreCard__c = scoreCard.Id;
                        scoreCardKPI.SPETemplate__c = tempId;
                        scoreCardKPI.KPI__c = kpiId; 
                        scoreCardKPI.KPITarget__c = speKPItargetMaps.get(tempId).get(kpiId);
                        scoreCardKPI.Score__c = score;          
                        scoreCardKPI.KPIValue__c = (totalKPIValues == 0 || totalKPICount == 0) ? 0 : (totalKPIValues/totalKPICount);
                    
                        toBeCreatedScorecardKPIMaps.add(scoreCardKPI);
                                    
                    }           
                    else
                    {
                        Decimal scoreCount = 0, totalScore = 0;
                        for (SPE_TrackerValues__c tracker: planTemplateKPITrackerValuesMap.get(palnId).get(tempId).get(kpiId))
                        {
                            totalScore = totalScore + tracker.Score__c;
                            scoreCount ++;  
                        }
                    
                        Decimal score = (totalScore == 0 || scoreCount ==0) ? 0 : (totalScore/scoreCount);
                    
                        ScorecardKPIMap__c scoreCardKPI = new ScorecardKPIMap__c();
                    
                        scoreCardKPI.ScoreCard__c = scoreCard.Id;
                        scoreCardKPI.SPETemplate__c = tempId;
                        scoreCardKPI.KPI__c = kpiId;
                        scoreCardKPI.KPITarget__c = speKPItargetMaps.get(tempId).get(kpiId);
                        scoreCardKPI.Score__c = score;          
                        scoreCardKPI.KPIValue__c = (totalKPIValues == 0 || totalKPICount == 0 || totalKPIValues == null || totalKPICount == null) ? 0 : (totalKPIValues/totalKPICount);
                    
                        toBeCreatedScorecardKPIMaps.add(scoreCardKPI);
                    }   
                }
            }
        }
        
        scoreId.add(scoreCard.Id);  
    }
    
    //delete [SELECT Id FROM ScorecardKPIMap__c WHERE ScoreCard__c In: scoreId];
    
    insert toBeCreatedScorecardKPIMaps;
   
 }
 }