@isTest
private class SPE_generateTrackerPageExtTest{
    static testMethod void createTrackerPositive(){
        
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
        
        
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.SPEPlanName__c='SPE12aAtos001';
        spePlan.Organization_Group__c = 'Services Procurement';
        spePlan.AggregationDuration__c = '1';
        insert spePlan;
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        ApexPages.currentPage().getParameters().get('id');
        SPE_generateTrackerPageExt generateTrackerExt = new SPE_generateTrackerPageExt(stCon);
        generateTrackerExt.startDate = system.today();
        generateTrackerExt.endDate = system.today().addDays(30);   
        generateTrackerExt.generateTracker(); 
    }
    
    static testMethod void constructorTestWithNullId(){
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE_generateTrackerPageExt generateTrackerExt = new SPE_generateTrackerPageExt(stCon);
    }
   
}