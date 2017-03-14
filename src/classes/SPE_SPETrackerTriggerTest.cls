@isTest
public class SPE_SPETrackerTriggerTest 
{
    static testMethod void positiveTest()
    {
        
        Account acc = SPE_TestObjectCreator.CreateSupplier('AUTOMEGA MOTORS');
        acc.EnterpriseId__c = 'AUTOMEGA MOTORS'; 
        insert acc; 
        
        SPE_SurveyQuestion__c surveyQuestion = SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surveyQuestion;
        
        SPE_SurveyAnswer__c surveyAnswer = SPE_TestObjectCreator.CreateSurveyAnswer();
        surveyAnswer.SurveyQuestion__c = surveyQuestion.Id;
        insert surveyAnswer;
        
        List<SPE_PIDefinition__c> piDefList = new List<SPE_PIDefinition__c>();
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.DataAcquisitionMethod__c = 'Survey';
        piDef.SurveyQuestion__c = surveyQuestion.Id;
        piDef.Frequency__c = '0';
        insert piDef;
         
        piDef.LifecycleStage__c = 'Published'; 
        piDefList.add(piDef); 
        update piDefList;
           
        SPE_Stop__c speStop = new SPE_Stop__c();
        speStop.Stop_trigger__c = true;
        speStop.Name = 'Stop';
        insert speStop;
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI.Level__c = '1';
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
        kpiCalc.PIDefination__c = piDefList[0].Id;
        kpiCalc.TimeFrame__c = 1;
        insert kpiCalc;
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        insert speTemplate;
        speTemplate.Stage__c = 'Published';
        update speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        scoringTemplate.Stage__c= 'Published';
        update scoringTemplate;
        
        SPE_SPEKPIMap__c speKpi = SPE_TestObjectCreator.CreateSPEKPI(KPI, speTemplate);
        insert speKpi;
        
      List<SPE_ScoringCalculation__c> scoringCalculationList = new List<SPE_ScoringCalculation__c>();
        for(Integer i=0 ; i<=5 ; i++){
            SPE_ScoringCalculation__c scoringCalculation = SPE_TestObjectCreator.createScoringCalc(spekpi, scoringTemplate);
            scoringCalculation.Score__c = 1;
            scoringCalculation.Lower__c = 0;
            scoringCalculation.LowerTo__c = '>';
            scoringCalculation.Upper__c = 120000000;
            scoringCalculation.UpperTo__c = '<';
            scoringCalculationList.add(scoringCalculation);
            
        }
        insert scoringCalculationList;
        
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos1122';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        insert spePlan;
        
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c = spePlan.Id;
        insert respondent;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('AtosIndia');
        insert supplier;
        
        SPE_SPEPlanSupplierMap__c spePlanSupplier = new SPE_SPEPlanSupplierMap__c();
        spePlanSupplier.SPEPlan__c = spePlan.Id;
        spePlanSupplier.Supplier__c = supplier.Id;
        
        insert spePlanSupplier;
        
        PicklistDefaultValues__c defaultPickList = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert defaultPickList;
        
        List<SPE_KPIValue__c> lstKPIValue = new List<SPE_KPIValue__c>();
        for (Integer i=0;i<10;i++)
        {
            
          SPE_KPIValue__c  KPIValueObj = new SPE_KPIValue__c();
          
          KPIValueObj.Region__c = 'All Markets';
          KPIValueObj.SubRegion__c = 'All Market Units';
          KPIValueObj.Country__c = 'All Countries';
          KPIValueObj.Project__c = 'All Projects';
          
          KPIValueObj.Cluster__c = 'All Category Areas';
          KPIValueObj.CategoryGroup__c = 'All Category Groups';
          KPIValueObj.Category__c = 'All Categories';
          
          KPIValueObj.BusinessUnit__c = 'All Business Units';
          KPIValueObj.BusinessLine__c = 'All Business Lines';
          KPIValueObj.Product__c = 'All Products';
          
          KPIValueObj.KPIValue__c = 150.0;
          KPIValueObj.Period__c = Date.today().addMonths(-1);
          
          KPIValueObj.EnterpriseID__c = 'AtosIndia';
          KPIValueObj.ExecutionPeriod__c = SPE_Utility.monthsMap.get(KPIValueObj.Period__c.month()) + ' - '+ String.valueOf(KPIValueObj.Period__c.year());
                  
          KPIValueObj.KPIDefinition__c = KPI.Id;
          
          lstKPIValue.add(KPIValueObj);
        }
        insert lstKPIValue;
        
        List<SPE_SPETracker__c> speTrackerList =  new List<SPE_SPETracker__c>();
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.name = 'September - 2016';
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.SendSurveyLink__c = true;
        speTracker.ForceSurvey__c = true;
        speTracker.SPETemplate__c = speTemplate.Id;
        speTracker.DateOfExecution__c = system.today();
        
        speTrackerList.add(speTracker);
        
        insert speTrackerList;  
                 
        SPE_PIValues__c piValue = new SPE_PIValues__c();
        piValue.PIDefination__c = piDefList[0].Id;
        piValue.Supplier__c = acc.Id;
        piValue.EnterpriseID__c = 'AUTOMEGA MOTORS';
        
        piValue.Region__c = 'All Markets';
        piValue.SubRegion__c = 'All Market Units';
        piValue.Country__c = 'All Countries';
        piValue.Project__c = 'All Projects';
        
        piValue.Cluster__c = 'All Category Areas';
        piValue.CategoryGroup__c = 'All Category Groups';
        piValue.Category__c = 'All Categories';
        
        piValue.BusinessUnit__c = 'All Business Units';
        piValue.BusinessLine__c = 'All Business Lines';
        piValue.Product__c = 'All Products';
        piValue.SPETracker__c = speTrackerList[0].Id;
        
        piValue.Period__c = Date.today().addMonths(-1) ;
        piValue.NumberValue__c = 10;
        insert piValue; 
        
        SPE_TrackerValues__c trackerValue = SPE_TestObjectCreator.createTrackerValue();
        trackerValue.Score1__c = 1;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.Supplier__c = supplier.Id;
        trackerValue.Value__c=4;
        insert trackerValue;
        
        SPE_TrackerRespondent__c trackerRespondent = new SPE_TrackerRespondent__c();
        trackerRespondent.IsResponseReceived__c = true; 
        trackerRespondent.SPE_Tracker__c = speTrackerList[0].Id;
        trackerRespondent.SurveyRespondent__c = respondent.Id;  
        trackerRespondent.ForceSurvey__c = true;
        insert trackerRespondent;
        
        
        SPE_SPETrackerTrigger.UpdateTracker(speTracker);
        SPE_SPETrackerTrigger.scoreCalculation1(trackerValue,scoringCalculationList,true); 
        SPE_SPETrackerTrigger.RespondentRecordGenerate(speTrackerList);
        SPE_SPETrackerTrigger.isSurveyExecute(speTracker);
        
    }
   
   
   
   
    /*
    static testMethod void trackerCalculationTest()
    {
    
    
        SPE_Stop__c speStop = new SPE_Stop__c();
        speStop.Stop_trigger__c = true;
        speStop.Name = 'Stop';
        insert speStop;
        
        Boolean isHighBetter = True;
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI.Level__c = '1';
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.FromDate__c = Date.today();
        KPI.ToDate__c = Date.today().addDays(5);
        KPI.ActualCalculation__c = 'A+B+C';
        insert KPI;
       
        KPI.LifecycleStage__c = 'Pilot';
        update KPI;
        
        speStop.Stop_trigger__c = false;
        update speStop;
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        
        insert speTemplate;
        
        speTemplate.Stage__c = 'Published';
        update speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        scoringTemplate.Stage__c= 'Published';
        update scoringTemplate;
        
        SPE_SPEKPIMap__c speKpi = SPE_TestObjectCreator.CreateSPEKPI(KPI, speTemplate);
        insert speKpi;
        
        List<SPE_ScoringCalculation__c > scoringCalculationList= new List<SPE_ScoringCalculation__c>(); 
        SPE_ScoringCalculation__c  scoringCalculation = new SPE_ScoringCalculation__c(); 
         scoringCalculation.Score__c = null;
        scoringCalculationList.add(scoringCalculation);
        insert scoringCalculationList;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos1122';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        insert spePlan;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('AtosIndia');
        insert supplier;
        
        SPE_SPEPlanSupplierMap__c spePlanSupplier = new SPE_SPEPlanSupplierMap__c();
        spePlanSupplier.SPEPlan__c = spePlan.Id;
        spePlanSupplier.Supplier__c = supplier.Id;
        
        insert spePlanSupplier;
        
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c = spePlan.Id;
        insert respondent;
        
        List<SPE_KPIValue__c> lstKPIValue = new List<SPE_KPIValue__c>();
        for (Integer i=0;i<10;i++)
        {
            
          SPE_KPIValue__c  KPIValueObj = new SPE_KPIValue__c();
          
          KPIValueObj.Region__c = 'All Markets';
          KPIValueObj.SubRegion__c = 'All Market Units';
          KPIValueObj.Country__c = 'All Countries';
          KPIValueObj.Project__c = 'All Projects';
          
          KPIValueObj.Cluster__c = 'All Category Areas';
          KPIValueObj.CategoryGroup__c = 'All Category Groups';
          KPIValueObj.Category__c = 'All Categories';
          
          KPIValueObj.BusinessUnit__c = 'All Business Units';
          KPIValueObj.BusinessLine__c = 'All Business Lines';
          KPIValueObj.Product__c = 'All Products';
          
          KPIValueObj.KPIValue__c = 150.0;
          KPIValueObj.Period__c = Date.today().addMonths(-1);
          
          KPIValueObj.EnterpriseID__c = 'AtosIndia';
          KPIValueObj.ExecutionPeriod__c = SPE_Utility.monthsMap.get(KPIValueObj.Period__c.month()) + ' - '+ String.valueOf(KPIValueObj.Period__c.year());
                  
          KPIValueObj.KPIDefinition__c = KPI.Id;
          
          lstKPIValue.add(KPIValueObj);
        }
        insert lstKPIValue;
        
        List<SPE_SPETracker__c> speTrackerList = new List<SPE_SPETracker__c>();
        for(Integer i=0 ; i<=5 ; i++){
            SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            speTracker.SPEPlan__c = spePlan.Id;
            speTracker.SPETemplate__c = speTemplate.Id;
            speTracker.DateOfExecution__c = system.today();
            speTrackerList.add(speTracker);
            
        }
        
        insert speTrackerList;
                
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.SPETemplate__c = speTemplate.Id;
        speTracker.SendSurveyLink__c = false;
        speTracker.ForceSurvey__c = false;
        speTracker.DateOfExecution__c =  Date.today().addMonths(-1);

        
        insert speTracker; 
        
        SPE_TrackerRespondent__c trackerRespondent = new SPE_TrackerRespondent__c();
        trackerRespondent.IsResponseReceived__c = true; 
        trackerRespondent.SPE_Tracker__c = speTracker.Id;
        trackerRespondent.SurveyRespondent__c = respondent.Id;  
        trackerRespondent.ForceSurvey__c = true;
        insert trackerRespondent;
        
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        insert trackerValue;
        
        PicklistDefaultValues__c defaultPickList = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert defaultPickList;
        
        
        
        SPE_SPETrackerTrigger.UpdateTracker(speTracker);
        SPE_SPETrackerTrigger.scoreCalculation1(trackerValue,scoringCalculationList,true); 
        SPE_SPETrackerTrigger.RespondentRecordGenerate(speTrackerList);
        SPE_SPETrackerTrigger.isSurveyExecute(speTracker);
        //ConvertTextToDate.ConvertToDate(speTrackerList);
      
    }
*/
 }