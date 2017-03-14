trigger SPE_ScorecardTrackerTrigger on SPE_ScorecardTracker__c (after update) 
{
   List<SPE_ScoreCard__c> toBeCreatedScorecards = new List<SPE_ScoreCard__c>(); 
    Map<Id, SPE_ScorecardGenerator__c> trackerScorecardGeneratorMap = new Map<Id, SPE_ScorecardGenerator__c>();
    for (SPE_ScorecardTracker__c st : trigger.new)
    {
        system.debug('status is'+ st.Status__c);
        if (st.Status__c == 'Completed')
        {
            trackerScorecardGeneratorMap.put(st.ScorecardGenerator__c, null);    
        }
        
    }
    
    trackerScorecardGeneratorMap = new Map<Id, SPE_ScorecardGenerator__c> ([SELECT BusinessLine__c, BusinessUnit__c, Category__c, CategoryCluster__c, CategoryGroup__c, Country__c, DisplaySpend__c,
                                        DisplayUnits__c, EndDate__c, Product__c, Project__c, RangeEndDate__c, RangeStartDate__c, 
                                        Region__c, StartDate__c, SubRegion__c, ScorecardTemplate__c, Name
                                FROM SPE_ScorecardGenerator__c
                                WHERE Id In: trackerScorecardGeneratorMap.keySet()]);
    
    List<SPE_ScorecardSupplierMap__c> suppliers = [SELECT Id, Supplier__c, ScorecardGenerator__c 
                                                   FROM SPE_ScorecardSupplierMap__c 
                                                   WHERE ScorecardGenerator__c In: trackerScorecardGeneratorMap.keySet()];
    
    for (SPE_ScorecardTracker__c st : trigger.new)
    {
        if (st.Status__c == 'Completed')
        {
            for (SPE_ScorecardSupplierMap__c sup: suppliers)
            {
                if (sup.ScorecardGenerator__c == st.ScorecardGenerator__c)
                {
                    SPE_ScorecardGenerator__c scorecardGen = trackerScorecardGeneratorMap.get(st.ScorecardGenerator__c);
                    
                    SPE_ScoreCard__c scorecard = new SPE_ScoreCard__c();
                    
                    scorecard.BusinessLine__c = scorecardGen.BusinessLine__c;
                    scorecard.BusinessUnit__c = scorecardGen.BusinessUnit__c;
                    scorecard.Category__c = scorecardGen.Category__c;
                    scorecard.CategoryGroup__c = scorecardGen.CategoryGroup__c;
                    scorecard.CategoryCluster__c = scorecardGen.CategoryCluster__c;
                    scorecard.Country__c = scorecardGen.Country__c;
                    scorecard.SubRegion__c = scorecardGen.SubRegion__c;
                    scorecard.Region__c = scorecardGen.Region__c;
                    scorecard.Product__c = scorecardGen.Product__c;
                    scorecard.Project__c = scorecardGen.Project__c;
                    scorecard.ScorecardTemplate__c = scorecardGen.ScorecardTemplate__c;
                    scorecard.ScorecardTracker__c = st.Id;
                    scorecard.DisplaySpend__c = scorecardGen.DisplaySpend__c;
                    scorecard.DisplayUnits__c = scorecardGen.DisplayUnits__c;
                    scorecard.StartDate__c = st.DateOfExecution__c;
                    scorecard.EndDate__c = st.EndDate__c;
                    scorecard.Supplier__c  = sup.Supplier__c;
                    scorecard.Name = scorecardGen.Name + ' - ' + st.Name;
                    toBeCreatedScorecards.add(scorecard);
                }
            }
        }
    }
   
    //insert toBeCreatedScorecards;
    
}