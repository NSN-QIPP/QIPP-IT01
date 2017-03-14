trigger SPE2_SPEPlanTrackerUpdateTrigger on SPE_SPEPlan__c(after update)
{   
    Set<ID> speplanID = new Set<ID>();
    List<SPE_SPETracker__c> listofSPETracker = new List<SPE_SPETracker__c>();
    Date strtDate = Date.newinstance(1960, 1, 1);
    String spefrequency = Null;
    Date enddate = Date.newinstance(1960, 1, 1);
    
    if (Trigger.isUpdate && Trigger.isAfter)
    {         
        for(SPE_SPEPlan__c speplan: Trigger.New){
            if(speplan.Ad_Hoc_Plan__c == false){
                if (speplan.Next_Computed_Day__c != Trigger.oldMap.get(speplan.Id).Next_Computed_Day__c){
                    System.Debug('****speplan.Next_Computed_Day__c***'+speplan.Next_Computed_Day__c);
                    speplanID.add(speplan.ID);
                    strtDate = speplan.Next_Computed_Day__c;
                    enddate = speplan.EndDate__c;
                    spefrequency = speplan.FrequencyInMonths__c;
                }
            }            
        }               
        
        if(strtDate != Date.newinstance(1960, 1, 1) && enddate != Date.newinstance(1960, 1, 1)){
            listofSPETracker = [Select ID,Name,Status__c,DateOfExecution__c,SPEPlan__c from SPE_SPETracker__c 
                                where SPEPlan__c IN: speplanID AND Status__c =: SPE_Constants.STATUS_PENDING Order By DateOfExecution__c];
            
            System.Debug('****listofSPETracker***'+listofSPETracker.size());
            
            List<SPE_SPETracker__c> listofTobeUpdatedSPETracker = new List<SPE_SPETracker__c>();
                                
            if(listofSPETracker.size() > 0){
                for(SPE_SPETracker__c speTrack: listofSPETracker){                    
                    speTrack.Name = SPE_Utility.monthsMap.get(strtDate.addMonths(-1).month()) + ' - '+ String.valueOf(strtDate.addMonths(-1).year());
                    speTrack.DateOfExecution__c = strtDate;
                    listofTobeUpdatedSPETracker.add(speTrack);
                    
                    System.Debug('****listofTobeUpdatedSPETracker***'+listofTobeUpdatedSPETracker.size());
                                    
                    if(spefrequency != Null){
                        if (spefrequency == '0'){
                            strtDate = strtDate;
                        }
                        else if(strtDate <= enddate)
                        {
                            strtDate = strtDate.addMonths(Integer.valueOf(spefrequency));
                            System.Debug('****strtDate***'+strtDate);
                        }
                    }
                }
            }
            try{
                if(listofTobeUpdatedSPETracker.size() > 0){
                    System.Debug('****listofTobeUpdatedSPETracker***'+listofTobeUpdatedSPETracker.size());
                    update listofTobeUpdatedSPETracker;
                }
            }catch(Exception e){}
        }
    }
}