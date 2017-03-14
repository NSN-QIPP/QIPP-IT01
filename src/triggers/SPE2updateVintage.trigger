trigger SPE2updateVintage on SPE_SPETracker__c (after update) {
    //This trigger will update the field Vintage in SPE Plan
    //Based on the earlist tracker in the format YYYY PMM  
   Set<id> speTrackerIds = new set<id>(); 
   List<SPE_SPEPlan__c> listPlan = new List<SPE_SPEPlan__c>();
   List<SPE_SPEPlan__c> listPlanToUpdate = new List<SPE_SPEPlan__c>();
    for( SPE_SPETracker__c Tracker : Trigger.new){
        speTrackerIds.add(Tracker.SPEPlan__c);     
    }
   try{
       Map<id,String> mplanwithTrackEarly = SPE2_VintageUpdate.returnPlanDate(speTrackerIds);
       system.debug('Test****'+mplanwithTrackEarly);
       if (mplanwithTrackEarly != NULL){
           listPlan = [Select Id,Vintage__c,Last_Tracker_Date__c FROM SPE_SPEPlan__c WHERE id IN :mplanwithTrackEarly.Keyset()];
       }
       for(SPE_SPEPlan__c plan :listPlan){
           plan.Vintage__c = mplanwithTrackEarly.get(plan.Id).split('~')[0];
           
           plan.Vintage_Date__c = date.valueOf(mplanwithTrackEarly.get(plan.Id).split('~')[1]);
           plan.Last_Tracker_Date__c = date.valueOf(mplanwithTrackEarly.get(plan.Id).split('~')[2]);
           listPlanToUpdate.add(plan);
           system.debug('Last_Tracker_Date__c::'+plan.Last_Tracker_Date__c);
       }
       if(!listPlanToUpdate.isEmpty())
           update listPlanToUpdate;
   }
   catch(Exception e){
       SPE_Error_Log__c errorLog = SPE2ErrorLogCapture.errorLogCapture(e);
       errorLog.Module_Name__c = 'SPE Tracker';//Provide Hard coded Value
       insert errorLog;
   }
}