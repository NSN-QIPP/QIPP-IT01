@isTest
public class SPE_SurveyKPITest
{
    public static testmethod void surveyKPITest() 
    {
        PageReference pageRef = Page.SPE_SurveyKPI;
        Test.setCurrentPage(pageRef);
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('AtosIndia');
        insert supplier;
        
        
        SPE_SurveyQuestion__c surveyQuestion = SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surveyQuestion;
        
        SPE_SurveyAnswer__c surveyAnswer = SPE_TestObjectCreator.CreateSurveyAnswer();
        surveyAnswer.SurveyQuestion__c = surveyQuestion.Id;
        insert surveyAnswer;
        
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.DataAcquisitionMethod__c = 'Survey';
        piDef.SurveyQuestion__c = surveyQuestion.Id;
        piDef.Frequency__c = '0';
        insert piDef;
          
        piDef.LifecycleStage__c = 'published';
        update piDef;
        
        SPE_Stop__c speStop = new SPE_Stop__c();
        speStop.Stop_trigger__c = true;
        speStop.Name = 'Stop';
        insert speStop;
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.FromDate__c = Date.today();
        KPI.ToDate__c = Date.today().addDays(5);
        KPI.ActualCalculation__c = 'A+B+C';
        insert KPI;
        
        KPI.LifecycleStage__c = 'Pilot';
        update KPI;
        
        speStop.Stop_trigger__c = false;
        update speStop;
        
        SPE_KPICalculation__c kpiCalc =  SPE_TestObjectCreator.createKPICalculation();
        kpiCalc.KPIDefinition__c =KPI.Id;
        kpiCalc.PIDefination__c = piDef.Id;
        kpiCalc.TimeFrame__c = 2;
        insert kpiCalc;      
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        insert speTemplate;
        
        speTemplate.Stage__c = 'Pilot';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKpi = SPE_TestObjectCreator.CreateSPEKPI(KPI, speTemplate);
        insert speKpi;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.AggregationDuration__c = '1';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c='aAtos11221';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.Stage__c = 'Draft';
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        Update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupplier = new SPE_SPEPlanSupplierMap__c();
        spePlanSupplier.SPEPlan__c = spePlan.Id;
        spePlanSupplier.Supplier__c = supplier.Id;
        insert spePlanSupplier;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c = 'All Business Units';
        speTracker.BusinessLine__c = 'All Business Lines';
        speTracker.Product__c = 'All Products';
        
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.SPETemplate__c = speTemplate.Id;
        speTracker.DateOfExecution__c = system.today()+2;
        
        insert speTracker;
        
        Contact con = SPE_TestObjectCreator.CreateContact('Jetha');
        con.Email = 'surveyyyTracktest@test.net';
        insert con;
        
        SPE_TrackerRespondent__c tres= new SPE_TrackerRespondent__c();
        tres.Contact__c = con.Id;
        tres.SPE_Tracker__c =speTracker.Id;
        insert tres;
        
        SPE_Respondent__c res = new SPE_Respondent__c();
        res.Contact__c = con.Id;
        res.SPEPlan__c = spePlan.Id;
        insert res;
        
        SPE_SurveyResponse__c surveyResponse = new SPE_SurveyResponse__c();
        surveyResponse.KPIDefinition__c = KPI.Id;  
        surveyResponse.Respondent__c = con.Id; 
        surveyResponse.SPEPlan__c = spePlan.id; 
        surveyResponse.SPETracker__c = speTracker.Id;
        //surveyResponse.Supplier__c = supplier.Id;
        surveyResponse.Questions__c = surveyQuestion.Id;
        surveyResponse.Answers__c = surveyAnswer.Id;
        surveyResponse.ChoiceForFreeText__c =2;
        surveyResponse.BooleanChoice__c = true; 
        surveyResponse.Invisible__c = False;
        surveyResponse.NA__c = true; 
        insert surveyResponse;
        
        
        PicklistDefaultValues__c defaultPickList = SPE_TestObjectCreator.CreateDefaultPicklist();
        defaultPickList.Name= 'Default';
        insert defaultPickList;
        
        ApexPages.currentPage().getParameters().put('trackerId',speTracker.id);
        ApexPages.currentPage().getParameters().put('conId',con.id);
        ApexPages.currentPage().getParameters().put('Id',spePlan.Id);
        
        SPE_SurveyKPI surveyKpi = new SPE_SurveyKPI();
        
        boolean b =surveyKPI.initialize();
        //surveyKpi.submit();
        
        
    }
}