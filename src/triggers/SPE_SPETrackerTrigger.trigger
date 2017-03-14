trigger SPE_SPETrackerTrigger on SPE_SPETracker__c (after update, after insert, before update,before insert) 
{
    if (Trigger.isBefore &&
        Trigger.isUpdate && trigger.new[0].Status__c == SPE_Constants.STATUS_COMPLETED

        )
    {
       
        SPE_SPETrackerTrigger.UpdateTracker(trigger.new[0]);  
        
    }
    /*else{
    ConvertTextToDate.ConvertToDate(trigger.new[0]);
    
    }*/
    
    
    if (Trigger.isAfter &&
        Trigger.isUpdate && 
        trigger.new[0].Status__c == SPE_Constants.STATUS_COMPLETED && 
        trigger.old[0].Status__c == SPE_Constants.STATUS_PENDING)
    {
        //SPE_SPETrackerTrigger.TrackerValuesGenerat(trigger.new[0]);
    }
    /*if(Trigger.isBefore)
    {
     //if(trigger.isinsert)
      //{
      //ConvertTextToDate.ConvertToDate(trigger.new);
      //}
        if(trigger.isUpdate)
        {
         if(checkRecursive.runOnce())
          {
          ConvertTextToDate.ConvertToDate(trigger.new); 
          }
          } 
    }*/
    
    if (Trigger.isBefore && Trigger.isUpdate)
    {
      System.debug('=======================>');
      SPE_SPETrackerTrigger.RespondentRecordGenerate(trigger.new);
        for (SPE_SPETracker__c speTracker : trigger.new)
        {
            speTracker.SendSurveyLink__c = false;
            speTracker.ForceSurvey__c = false;
        }
      
    }
}