@isTest(SeeAllData = True)
public class SPE_SurveyTrackTest 
{
    
    /*static testMethod void positiveTest()
    {
        
       SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();     
       insert speTemplate; 
            
       speTemplate.Stage__c='Pilot';        
       update speTemplate;      
                
       SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);      
       scoringTemplate.Stage__c = 'Draft';     
       insert scoringTemplate;     
        
       scoringTemplate.Stage__c = 'Pilot';      
       update scoringTemplate;      
            
       speTemplate.Stage__c = 'Published';       
       update speTemplate;       
                
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();     
        spePlan.FrequencyInMonths__c = '1';     
        spePlan.SPETemplate__c = speTemplate.Id;        
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;     
        spePlan.SPEPlanName__c='aAtos001';      
        spePlan.Organization_Group__c = 'Services Procurement';     
        spePlan.AggregationDuration__c = '1';       
        insert spePlan;     
                
                
         SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();       
         speTracker.SPEPlan__c = spePlan.Id;        
         speTracker.SPETemplate__c = speTemplate.Id;        
         insert speTracker;
 
        Contact contact = SPE_TestObjectCreator.CreateContact('example');
        contact.email='surveyTracktest@test.net';
        
        insert contact;
                
        SPE_TrackerRespondent__c trackerRespondant = new SPE_TrackerRespondent__c();
        trackerRespondant.Contact__c= contact.id;
        trackerRespondant.SPE_Plan__c=spePLan.id;
        trackerRespondant.SPE_Tracker__c= speTracker.id;
        trackerRespondant.CreatedDate = date.newinstance(System.Today().year(), System.Today().month(), System.Today().day());
        trackerRespondant.IsResponseReceived__c=true;
        
        insert trackerRespondant;
        
        String sDate = String.ValueOf(trackerRespondant.CreatedDate);
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTracker);
        
        SPE_SurveyTrack surveyTrack = new SPE_SurveyTrack(stCon);
     } 
    */
    static testMethod void noTrackerResponseTest()
    {
            SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();     
            insert speTemplate;     
           speTemplate.Stage__c='Pilot';        
           update speTemplate;      
                
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);      
            scoringTemplate.Stage__c = 'Draft';     
            insert scoringTemplate;     
            
           scoringTemplate.Stage__c = 'Pilot';      
           update scoringTemplate;      
                
          speTemplate.Stage__c = 'Published';       
          update speTemplate;       
                
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();     
            spePlan.FrequencyInMonths__c = '1';     
            spePlan.SPETemplate__c = speTemplate.Id;        
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;     
            spePlan.SPEPlanName__c='aAtos001';      
            spePlan.Organization_Group__c = 'Services Procurement';     
            spePlan.AggregationDuration__c = '1';       
            insert spePlan;     
                
                
         SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();       
         speTracker.SPEPlan__c = spePlan.Id;        
         speTracker.SPETemplate__c = speTemplate.Id;        
         insert speTracker;
            
            Contact contact = SPE_TestObjectCreator.CreateContact('example');
            contact.email='surveyTracktest@test.net';
            insert contact;
                                
            SPE_TrackerRespondent__c trackerRespondant = new SPE_TrackerRespondent__c();
        
            Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTracker);
            
            SPE_SurveyTrack surveyTrack = new SPE_SurveyTrack(stCon);
                    
    }
    
    
    
    /*
    static testMethod void negativeTest()
    {
            SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();     
            insert speTemplate;     
           speTemplate.Stage__c='Pilot';        
           update speTemplate;      
                
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);      
            scoringTemplate.Stage__c = 'Draft';     
            insert scoringTemplate;     
            
           scoringTemplate.Stage__c = 'Pilot';      
           update scoringTemplate;      
                
          speTemplate.Stage__c = 'Published';       
          update speTemplate;       
                
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();     
            spePlan.FrequencyInMonths__c = '1';     
            spePlan.SPETemplate__c = speTemplate.Id;        
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;     
            spePlan.SPEPlanName__c='aAtos001';      
            spePlan.Organization_Group__c = 'Services Procurement';     
            spePlan.AggregationDuration__c = '1';       
            insert spePlan;     
                
                
         SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();       
         speTracker.SPEPlan__c = spePlan.Id;        
         speTracker.SPETemplate__c = speTemplate.Id;        
         insert speTracker;
            
            Contact contact = SPE_TestObjectCreator.CreateContact('example');
            contact.email='surveyTracktest@test.net';
            
            insert contact;         
                    
            SPE_TrackerRespondent__c trackerRespondant = new SPE_TrackerRespondent__c();
            trackerRespondant.Contact__c= contact.id;
            trackerRespondant.SPE_Plan__c=spePLan.id;
            trackerRespondant.SPE_Tracker__c= speTracker.id;
            trackerRespondant.IsResponseReceived__c =false;
            trackerRespondant.CreatedDate = System.today();
                   
            insert trackerRespondant;
            
            Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTracker);
            
            SPE_SurveyTrack surveyTrack = new SPE_SurveyTrack(stCon);
           
    }*/
}