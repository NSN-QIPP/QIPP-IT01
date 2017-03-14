trigger SPE2_SurveyTrackerTrigger on SPE2_SurveyTracker__c(after update, after insert, before update,before insert) 
{
    if (Trigger.isBefore &&
        Trigger.isUpdate && trigger.new[0].Status__c == SPE_Constants.STATUS_COMPLETED

        )
    {
       
        SPE2_SurveyTrackerTrigger.UpdateTracker(trigger.new[0]);  
        
    }
    if (Trigger.isBefore){
        if(trigger.isUpdate || trigger.isinsert)
        
    {
     // SPE_Tracker_ScoreBound.ScoreBound(trigger.new);    
       
    }
    }
    
    if (Trigger.isAfter &&
        Trigger.isUpdate && 
        trigger.new[0].Status__c == SPE_Constants.STATUS_COMPLETED && 
        trigger.old[0].Status__c == SPE_Constants.STATUS_PENDING)
    {
        //SPE_SPETrackerTrigger.TrackerValuesGenerat(trigger.new[0]);
    }
      if(Trigger.isAfter)
    {
     if(trigger.isUpdate || trigger.isinsert)
     {
     SPE2ConvertToDate.SPE2ConvertToDate(trigger.new);
     }
    }
    
    if (Trigger.isBefore && Trigger.isUpdate)
    {
      System.debug('=======================>');
      SPE2_SurveyTrackerTrigger.RespondentRecordGenerate(trigger.new);
        for (SPE2_SurveyTracker__c speTracker : trigger.new)
        {
            speTracker.SendSurveyLink__c = false;
           // speTracker.ForceSurvey__c = false;
        }
      
    }
}