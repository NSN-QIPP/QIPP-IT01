@isTest(SeeAllData = False)
private class SPE_RecalculateIsSurveyBasePITest 
{
    static testMethod void SurveyBasedPI() 
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
        
        SPE_SurveyQuestion__c surveyQuestion = SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surveyQuestion;
        
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.DataAcquisitionMethod__c = 'Survey';
        piDef.SurveyQuestion__c = surveyQuestion.Id;
        piDef.Frequency__c = '0';
        piDef.LifecycleStage__c = 'Draft';
        insert piDef;
        
        piDef.LifecycleStage__c = 'Pilot';
        update piDef;
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert kpiDefinition1;
        
        SPE_KPICalculation__c kPICalculation = SPE_TestObjectCreator.createKPICalculation();
        kPICalculation.PIDefination__c = piDef.Id;
        kPICalculation.KPIDefinition__c = kpiDefinition1.Id;
        insert kPICalculation;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        update kpiDefinition1;
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Name = 'Atos_1TestSPETEmplate';
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
        spePlan.SPEPlanName__c = 'Test 12345';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;     
        spePlan.SPEPlanName__c='SPEaAtos001';       
        spePlan.Organization_Group__c = 'Services Procurement';     
        spePlan.AggregationDuration__c = '1';
        insert spePlan;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        ApexPages.StandardController st = new ApexPages.StandardController(spePlan);
        
        SPE_RecalculateIsSurveyBasePI recalculateIsSurveyBasePI = new SPE_RecalculateIsSurveyBasePI(st);
        
    }
    static testMethod void HardPI() 
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
        
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.LifecycleStage__c = 'Draft';
        insert piDef;
        
        piDef.LifecycleStage__c = 'Pilot';
        update piDef;
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert kpiDefinition1;
        
        SPE_KPICalculation__c kPICalculation = SPE_TestObjectCreator.createKPICalculation();
        kPICalculation.PIDefination__c = piDef.Id;
        kPICalculation.KPIDefinition__c = kpiDefinition1.Id;
        insert kPICalculation;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        update kpiDefinition1;
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Name = 'Atos_TestSPETEmplate';
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
        spePlan.SPEPlanName__c = 'Test 1234';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;     
        spePlan.SPEPlanName__c='SPEaAtos001';       
        spePlan.Organization_Group__c = 'Services Procurement';     
        spePlan.AggregationDuration__c = '1';
        insert spePlan;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        ApexPages.StandardController st = new ApexPages.StandardController(spePlan);
        
        SPE_RecalculateIsSurveyBasePI recalculateIsSurveyBasePI = new SPE_RecalculateIsSurveyBasePI(st);
        
    }
}