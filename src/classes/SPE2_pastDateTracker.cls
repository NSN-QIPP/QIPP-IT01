Public class SPE2_pastDateTracker{
    
    public string trackerIdentfier{get;set;} 
    public SPE2_pastDateTracker(){
          trackerIdentfier = system.now()+';'+userinfo.getUserId();
    }
    public void scorecardTracker(list<SPE_ScorecardTracker__c> trackerList, Id userId){
        set<string> groupSet = new set<string>();
        for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
            groupSet.add(gm.Group.name);
        }      
        if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
            Set<string> trckrIds = new Set<String>();
            for(SPE_ScorecardTracker__c trk :trackerList){
                trckrIds.add(trk.Id);
            }
            list<SPE_ScorecardTracker__c>  trackerToBeExecuted = new list<SPE_ScorecardTracker__c>();
            trackerToBeExecuted = [ select Id,ScorecardGenerator__r.isAdhoc__c,Name,ScorecardGenerator__r.Aggregation_Period_Adhoc__c,
                                    Tracker_Identifier__c, DateOfExecution__c
                                    FROM SPE_ScorecardTracker__c 
                                    WHERE id in :trckrIds AND ScorecardGenerator__r.isAdhoc__c = true 
                                    AND Status__c = 'Pending' AND DateOfExecution__c <= :system.today()];
            for(SPE_ScorecardTracker__c tc :trackerToBeExecuted){
                tc.Tracker_Identifier__c = trackerIdentfier;
            }
            try{
                update trackerToBeExecuted;
                SPE2PastTrckrExecBatch execTracker = new SPE2PastTrckrExecBatch(trackerIdentfier);
                database.executeBatch(execTracker,1);
            }catch(Exception e){
            system.debug('TrackerFailure----'+e.getmessage());
            }
            
        }
    }
    public void speTracker(list<SPE_SPETracker__c> trackerList, Id userId){
        system.debug('speTrackerList----->'+trackerList);
        set<string> groupSet = new set<string>();
        for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
        groupSet.add(gm.Group.name);
        }          
        if(groupSet.contains('SPE2.0 User Group') || groupSet.contains('SPE1.0 User Group')){
            Set<string> trckrIds = new Set<String>();
            for(SPE_SPETracker__c trk :trackerList){
                trckrIds.add(trk.Id);
            }
    
        list<SPE_SPETracker__c>  trackerToBeExecuted = new list<SPE_SPETracker__c>();
            trackerToBeExecuted = [ select Id,Name,Tracker_Identifier__c, DateOfExecution__c
                                    FROM SPE_SPETracker__c
                                    WHERE id in :trckrIds AND Status__c = 'Pending' 
                                    AND DateOfExecution__c <= :system.today()];
             for(SPE_SPETracker__c tc :trackerToBeExecuted){
                tc.Tracker_Identifier__c = trackerIdentfier;
             }
             system.debug('Tracketexec******'+trackerToBeExecuted.size());
             try{
                update trackerToBeExecuted;
                SPE2PastSPETrckrExecBatch execTracker = new SPE2PastSPETrckrExecBatch(trackerIdentfier);
                database.executeBatch(execTracker,1);
             }catch(Exception e){
             system.debug('TrackerFailure----'+e.getmessage());
             }
         }
             
    }
}