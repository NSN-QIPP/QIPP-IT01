@isTest(SeeAllData = False)
private class SPE_SPEPIAvailabilityTest{
   // private static SPE_SPETracker__c speTracker=SPE_TestObjectCreator.createSPETracker();
    
     static testMethod void PIAvailabilityPositive()
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
        
       //insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
       
       SPE_Stop__c speStop = new SPE_Stop__c();
       speStop.Stop_trigger__c = true;
       speStop.Name = 'Stop';
       insert speStop;
       
       SPE_SurveyQuestion__c survey = new SPE_SurveyQuestion__c();
       survey.AnswerType__c = 'Free Text';
       survey.QuestionLabel__c = 'ABC';
       survey.SurveyQuestion__c ='hdgfhg';
       insert survey ;
        
       system.debug('==>survey '+survey );
        
       
       SPE_PIDefinition__c piDef= SPE_TestObjectCreator.CreatePIDefinition();
       piDef.SurveyQuestion__c = survey.Id;
       piDef.DataAcquisitionMethod__c = SPE_Constants.SURVEY_DATAACQUISITION;
       piDef.LifecycleStage__c = 'Draft';
       piDef.Frequency__c='0';
       insert piDef;
       
       piDef.LifecycleStage__c = 'Pilot';
       update piDef;
       system.debug('==>piDef'+piDef);
      
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       
     //**********************************Changes For Encryption************************// 
       //kpiDefinition1.Name = 'Test KPI Definition 123';
       kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
     //**********************************END****************************//
     
       kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
       kpiDefinition1.Level__c = '1';
       kpiDefinition1.LifecycleStage__c = 'Draft';
       kpiDefinition1.Description__c = 'Test';
       kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
       kpiDefinition1.OperationalType__c = 'Leading PI';
       kpiDefinition1.GeoScope__c = 'All Markets';
       kpiDefinition1.categoryscope__c = 'All Categories';
       kpiDefinition1.BUScope__c = 'All Products';
       kpiDefinition1.UoM__c = 'max';
       kpiDefinition1.Group1__c = 'Cost';
       kpiDefinition1.Group2__c = 'Hard';
       kpiDefinition1.Type__c = 'Operational';
       kpiDefinition1.ActualCalculation__c='a';
       kpiDefinition1.FrequencyinMonth__c = '2';
       kpiDefinition1.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
       kpiDefinition1.VerNumber__c = 0;
       kpiDefinition1.Aggregation__c = 'AVG';
       insert kpiDefinition1;
       
       kpiDefinition1.LifecycleStage__c = 'Pilot';
       update kpiDefinition1;
       
       SPE_KPICalculation__c kpiCal=SPE_TestObjectCreator.createKPICalculation();
       kpiCal.KPIDefinition__c=kpiDefinition1.Id;
       kpiCal.PIDefination__c = piDef.Id;
       kpiCal.TimeFrame__c = 2;
       insert kpiCal;
       system.debug('==>kpiCal'+kpiCal);
       
       system.debug('==>kpiDef'+kpiDefinition1);
       
       SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       
     //**********************************Changes For Encryption************************// 
       //kpiDefinition2.Name = 'Test KPI Definition 123';
       kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
     //**********************************END****************************//
       
       kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
       kpiDefinition2.Level__c = '1';
       kpiDefinition2.LifecycleStage__c = 'Draft';
       kpiDefinition2.Description__c = 'Test';
       kpiDefinition2.MissingDatalogic__c = 'SPE Invalid';
       kpiDefinition2.OperationalType__c = 'Leading PI';
       kpiDefinition2.GeoScope__c = 'All Markets';
       kpiDefinition2.categoryscope__c = 'All Categories';
       kpiDefinition2.BUScope__c = 'All Products';
       kpiDefinition2.UoM__c = 'max';
       kpiDefinition2.Group1__c = 'Cost';
       kpiDefinition2.Group2__c = 'Hard';
       kpiDefinition2.Type__c = 'Operational';
       kpiDefinition2.ActualCalculation__c='a';
       kpiDefinition2.FrequencyinMonth__c = '2';
       kpiDefinition2.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
       kpiDefinition2.VerNumber__c = 0;
       kpiDefinition2.Aggregation__c = 'AVG';
       kpiDefinition2.Master_KPI__c = kpiDefinition1.Id;
       insert kpiDefinition2;
       
       kpiDefinition2.LifecycleStage__c = 'Pilot';
       update kpiDefinition2; 
       
       system.debug('==>kpiDef'+kpiDefinition2);
       
       Account acc = new Account();
       acc.Name ='Test Account';
       acc.EnterpriseId__c='FCI';
       acc.SupplierId__c='Test1';
       insert acc;
       
       system.debug('==>acc'+acc);
        
       SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       
       insert speTemplate;
       speTemplate.Stage__c='Pilot';
       update speTemplate;
       
       system.debug('==>speTemplate'+speTemplate);
        
       SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
       scoringTemplate.Stage__c = 'Draft';
       insert scoringTemplate;
       
        scoringTemplate.Stage__c = 'Pilot';
       update scoringTemplate;
       
       system.debug('==>speTemplate'+speTemplate);
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos1';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        insert spePlan;
        
        system.debug('==>spePlan'+spePlan);
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.DateOfExecution__c= Date.newInstance(2099, 07, 02);
        speTracker.SPETemplate__c = speTemplate.Id;
        speTracker.SPEPlan__c = spePlan.Id;
        insert speTracker;
        
        system.debug('==>speTracker'+speTracker);
        
        SPE_SPEKPIMap__c speKpiMap = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        speKpiMap.KPIDefinition__c = kpiDefinition1.Id;
        speKpiMap.SPETemplate__c = speTracker.SPETemplate__c;
       
        insert speKpiMap;
       
        system.debug('==>speKpiMap'+speKpiMap);
       
       
        
        SPE_SPEPlanSupplierMap__c speSup=new SPE_SPEPlanSupplierMap__c();
        speSup.SPEPlan__c = speTracker.SPEPlan__c;
        speSup.Supplier__c=acc.Id;
        insert speSup;
        
        system.debug('==>speSup'+speSup);
        
        //Date speDate = speTracker.DateOfExecution__c.addMonths(-1);
        speStop.Stop_trigger__c = false;
        update speStop;
        
        //PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert default1;
        
        SPE_PIValues__c piValue= new SPE_PIValues__c();
        piValue.EnterpriseID__c = 'FCI';
        piValue.PIDefination__c = piDef.Id;
        piValue.Period__c = Date.newInstance(2099, 06, 10); 
        piValue.SPETracker__c =  speTracker.Id;
        piValue.Supplier__c=acc.Id;
        piValue.NumberValue__c=8;
        
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
        insert piValue;
        
        system.debug('==>piValue'+piValue);
        
       
        Apexpages.currentPage().getParameters().put('id', speTracker.Id);
        Apexpages.Standardcontroller st = new Apexpages.Standardcontroller(speTracker);
        SPE_SPEPIAvailability piavail= new SPE_SPEPIAvailability(st);
       // piavail.SPE_SPEPIAvailability();
       // piavail.piCheckAvailability(speTracker.Id);
        
      
        
     } 
       
}