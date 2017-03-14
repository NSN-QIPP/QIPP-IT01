@isTest(SeeAllData = False)
private class SPE_SPEPlanCreateExtTest {
  
    //private static SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();       
    //private static SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
    
    static testMethod void createNewSPEPlanPositive() 
    {
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');     
                
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
        
        //insert SPE_TestObjectCreator.CreateDefaultPicklist();
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.EndDate__c = System.today().addMonths(1);       
        spePlan.StartDate__c = System.today(); 
        spePlan.SPETemplate__c = speTemplate.Id;        
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;      
        spePlan.SurveyExecutionBeforeIndays__c = 5;       
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;
        spePlan.Organization_Group__c = 'Services Procurement';       
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';
        insert spePlan; 
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
 
        spePlanExt.spePlan = spePlan;       
        spePlanExt.save();
        spePlanExt.checkValidation();
        spePlanExt.generateTracker();
        spePlanExt.getMarketValues();
        spePlanExt.fillMarketUnit();
        spePlanExt.fillCountry();
        spePlanExt.fillProject();
        spePlanExt.getBusinessUnitValues();
        //spePlanExt.fillBusinessLine();
        spePlanExt.showProdVals();
        spePlanExt.fillProduct();
        spePlanExt.getCategoryAreaValues(); 
        spePlanExt.fillCategoryGroup();
        spePlanExt.fillCategory();
        spePlanExt.blankMethod(); 
        
    }
    
    static testMethod void createUpdateSPEPlanPositive() 
    {
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
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
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);        
        spePlan.StartDate__c = System.today().addDays(1);
        spePlan.SPETemplate__c = speTemplate.Id;        
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '2';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';       
        insert spePlan;
        
        //insert SPE_TestObjectCreator.CreateDefaultPicklist();
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);        
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);       
        spePlanExt.generateTracker();
        
        spePlan.FrequencyInMonths__c = '3';
        update spePlan;        
        //spePlan.SPEPlanName__c = 'New Demo Plan 11';
         
        //insert SPE_TestObjectCreator.CreateDefaultPicklist();
        
        spePlanExt.spePlan = spePlan;        
        spePlanExt.save();
        spePlanExt.checkValidation();
        //spePlanExt.generateTracker();
        spePlanExt.getMarketValues();
        spePlanExt.fillMarketUnit();
        spePlanExt.fillCountry();
        spePlanExt.fillProject();
        spePlanExt.getBusinessUnitValues();
        //spePlanExt.fillBusinessLine();
        spePlanExt.showProdVals();
        spePlanExt.fillProduct();
        spePlanExt.getCategoryAreaValues(); 
        spePlanExt.fillCategoryGroup();
        spePlanExt.fillCategory();
        spePlanExt.blankMethod();
       
        spePlan = [SELECT FrequencyInMonths__c FROM SPE_SPEPlan__c WHERE Id =: spePlan.Id];       
        system.assertEquals(spePlan.FrequencyInMonths__c, '3');
        
    }
    
    static testMethod void createSPEPlanNegative() 
    {
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
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
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;       
        spePlan.EndDate__c = System.today();      
        spePlan.StartDate__c = System.today().addMonths(1);       
        spePlan.SurveyExecutionBeforeIndays__c = 5;
        spePlan.SPETemplate__c = speTemplate.Id;        
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Organization_Group__c = 'Services Procurement';        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '2';       
        spePlan.SPEPlanName__c = 'New Demo Plan 12';        
        insert spePlan;
        
        //insert SPE_TestObjectCreator.CreateDefaultPicklist();
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
        
        //spePlan.FrequencyInMonths__c = '3';
        
        spePlanExt.spePlan = spePlan;       
        spePlanExt.save();
        spePlanExt.checkValidation();
        spePlanExt.generateTracker();
        spePlanExt.getMarketValues();
        spePlanExt.fillMarketUnit();
        spePlanExt.fillCountry();
        spePlanExt.fillProject();
        spePlanExt.getBusinessUnitValues();
        //spePlanExt.fillBusinessLine();
        spePlanExt.showProdVals();
        spePlanExt.fillProduct();
        spePlanExt.getCategoryAreaValues(); 
        spePlanExt.fillCategoryGroup();
        spePlanExt.fillCategory();
        spePlanExt.blankMethod();
        
        SPE_SPEPlan__c spePlanTest = [SELECT FrequencyInMonths__c FROM SPE_SPEPlan__c WHERE Id =: spePlan.Id];       
        system.assertNotEquals(spePlanTest.FrequencyInMonths__c, '3');
        
        spePlan.EndDate__c = System.today().addMonths(1);       
        spePlan.StartDate__c = System.today();        
        spePlan.SurveyExecutionBeforeIndays__c = 2;
        update spePlan;
        
        spePlanExt.spePlan = spePlan;       
        spePlanExt.save();
        spePlanExt.checkValidation();
        spePlanExt.generateTracker();
        spePlanExt.getMarketValues();
        spePlanExt.fillMarketUnit();
        spePlanExt.fillCountry();
        spePlanExt.fillProject();
        spePlanExt.getBusinessUnitValues();
        //spePlanExt.fillBusinessLine();
        spePlanExt.showProdVals();
        spePlanExt.fillProduct();
        spePlanExt.getCategoryAreaValues(); 
        spePlanExt.fillCategoryGroup();
        spePlanExt.fillCategory();
        spePlanExt.blankMethod();
        
        spePlanTest = [SELECT SurveyExecutionBeforeIndays__c FROM SPE_SPEPlan__c WHERE Id =: spePlan.Id];        
        system.assertNotEquals(spePlanTest.SurveyExecutionBeforeIndays__c, 5);
        
        spePlan.EndDate__c = System.today().addYears(6);
        update spePlan; 
              
        spePlanExt.spePlan = spePlan;      
        spePlanExt.save();
        spePlanExt.checkValidation();
        //spePlanExt.generateTracker();
        spePlanExt.getMarketValues();
        spePlanExt.fillMarketUnit();
        spePlanExt.fillCountry();
        spePlanExt.fillProject();
        spePlanExt.getBusinessUnitValues();
        //spePlanExt.fillBusinessLine();
        spePlanExt.showProdVals();
        spePlanExt.fillProduct();
        spePlanExt.getCategoryAreaValues(); 
        spePlanExt.fillCategoryGroup();
        spePlanExt.fillCategory();
        spePlanExt.blankMethod();
        
        spePlanTest = [SELECT EndDate__c FROM SPE_SPEPlan__c WHERE Id =: spePlan.Id];       
        system.assertEquals(spePlanTest.EndDate__c, System.today().addYears(6));
    }
    
    static testMethod void callSaveButton() 
    {
      
      //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
      
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
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;        
        spePlan.EndDate__c = System.today().addMonths(1);       
        spePlan.StartDate__c = System.today();        
        spePlan.SurveyExecutionBeforeIndays__c = 5;
        spePlan.SPETemplate__c = speTemplate.Id;        
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Organization_Group__c = 'Services Procurement';        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;       
        spePlan.FrequencyInMonths__c = '2';      
        spePlan.SPEPlanName__c = 'New Demo Plan 1111';
        insert spePlan;
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);      
        SPE_SPEPlanCreateExt spePlanExt = new SPE_SPEPlanCreateExt(stCon);
        
        spePlanExt.spePlan = spePlan;       
        spePlanExt.scopeMatch();
        spePlanExt.checkValidation();
        spePlanExt.generateTracker();
        spePlanExt.getMarketValues();
        spePlanExt.fillMarketUnit();
        spePlanExt.fillCountry();
        spePlanExt.fillProject();
        spePlanExt.getBusinessUnitValues();
        //spePlanExt.fillBusinessLine();
        spePlanExt.showProdVals();
        spePlanExt.fillProduct();
        spePlanExt.getCategoryAreaValues(); 
        spePlanExt.fillCategoryGroup();
        spePlanExt.fillCategory();
        spePlanExt.blankMethod();
    }
}