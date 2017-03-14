@isTest
private class SPE_SPEPlanCreate1Test 
{      
    static testMethod void SPEPlanCreate1TestData()
     {  
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Stage__c = 'Published';
        insert speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Name = 'Test New Scoring Template'; 
        insert scoringTemplate;
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert default1;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id; 
        spePlan.SPEPlanName__c='aAtos1';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.EndDate__c = System.today().addMonths(1);
        spePlan.StartDate__c = System.today();
        spePlan.SurveyExecutionBeforeIndays__c = 5;
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;
        spePlan.FrequencyInMonths__c = '2';
        insert spePlan;
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
        
        SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
        cm.Category__c = 'Atos Pune';
        cm.Cluster__c = 'Atos Global';
        cm.Group__c = 'Atos India';
        insert cm;
        
        ApexPages.currentPage().getParameters().put('caVal', 'Atos Global');
        ApexPages.currentPage().getParameters().put('cgVal', 'Atos India');
        
        spePlanExt.getCategoryAreaValues();
        spePlanExt.getCategoryGroupValues();
        spePlanExt.getCategoryValues();
        
        spePlanExt.spePlan = spePlan; 
        spePlanExt.checkValidation();
        spePlanExt.save();
        spePlanExt.generateTracker();
                
    }
    
     static testMethod void SPEPlanCreatePositive2()
     {  
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Stage__c = 'Published';
        insert speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Name = 'Test New Scoring Template'; 
        insert scoringTemplate;
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert default1;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id; 
        spePlan.SPEPlanName__c='aAtos1';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.EndDate__c = System.today().addMonths(1);
        spePlan.StartDate__c = System.today();
        spePlan.SurveyExecutionBeforeIndays__c = 5;
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;
        spePlan.FrequencyInMonths__c = '2';
        insert spePlan;
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
        
        ApexPages.currentPage().getParameters().put('marketVal', 'All Markets');
        ApexPages.currentPage().getParameters().put('marketUnitVal', 'All Market Units');
        ApexPages.currentPage().getParameters().put('countryVal', 'All Countries');
        ApexPages.currentPage().getParameters().put('buVal', 'All Business Units');
        ApexPages.currentPage().getParameters().put('blVal', 'All Business Lines');
        ApexPages.currentPage().getParameters().put('caVal', 'All Category Areas');
        ApexPages.currentPage().getParameters().put('cgVal', 'All Category Groups');
        
        spePlanExt.spePlan = spePlan;
        spePlanExt.getMarketValues();
        spePlanExt.getMarketUnitValues();
        spePlanExt.getCountryValues();
        spePlanExt.getProjectValues();
        
        spePlanExt.getBusinessUnitValues();
        spePlanExt.getBusinesLineValues();
        spePlanExt.getProductValues();
        
        spePlanExt.getCategoryAreaValues();
        spePlanExt.getCategoryGroupValues();
        spePlanExt.getCategoryValues();
        
        
        spePlanExt.checkValidation();
        spePlanExt.save();
        spePlanExt.generateTracker();
                
    }
    
    
    static testMethod void SPEPlanCreate1TestDataPositive1()
     {  
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Stage__c = 'Published';
        insert speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        speTemplate.Stage__c = 'Published';
        update speTemplate;
        
        PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert default1;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
                
    }
    
    static testMethod void callSaveButton() 
    {
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Stage__c = 'Published';
        insert speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Name = 'Test New Scoring Template'; 
        insert scoringTemplate;
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert default1;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id; 
        spePlan.EndDate__c = System.today().addMonths(3);
        spePlan.StartDate__c = System.today().addMonths(2);
        spePlan.SurveyExecutionBeforeIndays__c = 5;
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;
        spePlan.FrequencyInMonths__c = '2';
        spePlan.SPEPlanName__c = 'New Demo Plan';
        insert spePlan;
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
        spePlanExt.spePlan = spePlan;
        spePlanExt.checkValidation();
        spePlanExt.scopeMatch();
    }
}