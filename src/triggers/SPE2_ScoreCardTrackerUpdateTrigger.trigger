trigger SPE2_ScoreCardTrackerUpdateTrigger on SPE_ScorecardGenerator__c(after update)
{   
    Set<ID> scorecardgeneratorID = new Set<ID>();
    List<SPE_ScorecardTracker__c> listofScorecardTracker = new List<SPE_ScorecardTracker__c>();
    Date strtDate = System.Today();
    String sgfrequency = Null;
    Date enddate = System.Today();
    Integer timeFrame = 0;
    
    if (Trigger.isUpdate && Trigger.isAfter)
    {         
        for(SPE_ScorecardGenerator__c sg: Trigger.New){
            if (sg.Next_Computed_Day__c != Trigger.oldMap.get(sg.Id).Next_Computed_Day__c){
                System.Debug('****sg.Next_Computed_Day__c***'+sg.Next_Computed_Day__c);
                scorecardgeneratorID.add(sg.ID);
                strtDate = sg.Next_Computed_Day__c;
                enddate = sg.EndDate__c;
                timeFrame = integer.ValueOf(sg.TimeFrame__c);
                sgfrequency = sg.FrequencyInMonths__c;
            }            
        }               
        
        listofScorecardTracker  = [Select ID,Name,Status__c,EndDate__c,DateOfExecution__c,ScorecardGenerator__c from SPE_ScorecardTracker__c
                                   where ScorecardGenerator__c  IN: scorecardgeneratorID AND Status__c =: SPE_Constants.STATUS_PENDING 
                                   Order By DateOfExecution__c];
        
        System.Debug('****listofScorecardTracker ***'+listofScorecardTracker.size());
        
        List<SPE_ScorecardTracker__c> listofTobeUpdatedScorecardTracker = new List<SPE_ScorecardTracker__c>();
                            
        if(listofScorecardTracker.size() > 0){
            for(SPE_ScorecardTracker__c scoreTrack: listofScorecardTracker){                    
                scoreTrack.Name = SPE_Utility.monthsMap.get(strtDate.month()) + ' - '+ String.valueOf(strtDate.year());
                scoreTrack.DateOfExecution__c = strtDate;
                scoreTrack.EndDate__c = strtDate.addMonths(integer.ValueOf(sgfrequency)).addDays(-timeFrame);
                listofTobeUpdatedScorecardTracker.add(scoreTrack);
                
                System.Debug('****listofTobeUpdatedScorecardTracker***'+listofTobeUpdatedScorecardTracker.size());
                                
                if(sgfrequency != Null){
                    if (sgfrequency == '0'){
                        strtDate = strtDate;
                    }
                    else if(strtDate <= enddate)
                    {
                        strtDate = strtDate.addMonths(Integer.valueOf(sgfrequency));
                        System.Debug('****strtDate***'+strtDate);
                    }
                }
            }
        }
        try{
            if(listofTobeUpdatedScorecardTracker.size() > 0){
                System.Debug('****listofTobeUpdatedScorecardTracker***'+listofTobeUpdatedScorecardTracker.size());
                update listofTobeUpdatedScorecardTracker;
            }
        }catch(Exception e){}
    }    
}