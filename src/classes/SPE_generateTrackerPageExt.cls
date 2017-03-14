public class SPE_generateTrackerPageExt
{
  public date startDate {get;set;} 
     public date endDate {get;set;}
     public SPE_SPEPlan__c spePlan {get;set;}
     
     public SPE_SPETracker__c speTracker {get; set;}
   
     public SPE_generateTrackerPageExt(ApexPages.StandardController st) 
     {
      if (st.getId() == null)
        {
            spePlan = new SPE_SPEPlan__c(); 
        
        }
        else 
        {
          spePlan = [SELECT Id, SPEScoringTemplate__c, Name, PPM1__c, CM__c, Stage__c, SPEPlanName__c, Region__c, SubRegion__c, Country__c, Category__c, Project__c, SPETemplate__c, SPETemplate__r.Name, StartDate__c, EndDate__c,
                              FrequencyInMonths__c, SurveyExecutionBeforeIndays__c, SurveyReminderBeforeExecutionDate__c, SurveyHeader__c, SurveyFooter__c,
                              CategoryCluster__c, CategoryGroup__c, BusinessUnit__c, BusinessLine__c, Product__c, Product1__c, Product2__c, Product3__c,Organization_Group__c
                       FROM SPE_SPEPlan__c 
                       WHERE Id =: st.getId()];
       }
  }
   
  public Pagereference generateTracker()
  {
    String trackerName = SPE_Utility.monthsMap.get(startDate.addMonths(-1).month()) + ' - '+ String.valueOf(startDate.addMonths(-1).year());
        
        List<SPE_SPETracker__c> speTrackList = [SELECT Id, Name, Status__c
                            FROM SPE_SPETracker__c 
                            WHERE Status__c != 'Abandoned' AND
                                SPEPlan__c =: spePlan.Id AND
                                Name =: trackerName];
        
        speTracker = new SPE_SPETracker__c();
        for (SPE_SPETracker__c tr : speTrackList)
        {
          speTracker = tr;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,  'There is already an identical SPE Tracker, Please use the same : <a href=\'/' + speTracker.id + '\'>Tracker Number ' + speTracker.Name + '</a>'));
          
          return null;  
        }                    
    
        SPE_SPETracker__c toBeInsertedSPETracker = createSPETracker(spePlan, true);
        insert toBeInsertedSPETracker;  
        Pagereference pr = new Pagereference('/' +toBeInsertedSPETracker.Id);
        return pr;
    }
    
    private SPE_SPETracker__c createSPETracker (SPE_SPEPlan__c spePlan, Boolean isAbended)
    {
      List<SPE_SPETracker__c> toBeInsertedSPETracker = new List<SPE_SPETracker__c>();
        Date strtDate = startDate;
        
        SPE_SPETracker__c speTrack = new SPE_SPETracker__c();
        speTrack.Name = SPE_Utility.monthsMap.get(startDate.addMonths(-1).month()) + ' - '+ String.valueOf(startDate.addMonths(-1).year());
        speTrack.SPEPlan__c = spePlan.Id;
        speTrack.SPETemplate__c = spePlan.SPETemplate__c;
        speTRack.DateOfExecution__c = startDate;
        speTRack.Status__c = SPE_Constants.STATUS_PENDING;
                
        speTrack.Region__c = spePlan.Region__c;
        speTrack.SubRegion__c = spePlan.SubRegion__c;
        speTrack.Country__c = spePlan.Country__c;
        speTrack.Project__c = spePlan.Project__c;
                
        speTrack.BusinessLine__c = spePlan.BusinessLine__c;
        speTrack.BusinessUnit__c = spePlan.BusinessUnit__c;
        speTrack.Product__c = spePlan.Product__c;
                
        speTrack.Category__c = spePlan.Category__c;
        speTrack.CategoryGroup__c = spePlan.CategoryGroup__c;
        speTrack.CategoryCluster__c = spePlan.CategoryCluster__c;
                
        toBeInsertedSPETracker.add(speTrack);
        
        return speTrack;
    }

}