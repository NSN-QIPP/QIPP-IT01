@isTest(seeAllData = false)
private class SPE_SPETrackerBatchTest 
{
   static testMethod void SPETrackerBatchPositive() 
    {
      
        Test.startTest();
       
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 111';
        speTemplate.Stage__c='Published';
        insert speTemplate;
        
        system.debug('==============>'+speTemplate.Id);
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Name = 'Test Template 1212'; 
        insert scoringTemplate;
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        SPE_SPEPlan__c plan = new SPE_SPEPlan__c();        
        plan.SPEPlanName__c ='Test Plan';
        plan.AggregationDuration__c= '2';
        Plan.SPEPlanName__c='aAtos1';
        plan.FrequencyInMonths__c = '1';
        Plan.SPETemplate__c = speTemplate.Id;
        Plan.SPEScoringTemplate__c = scoringTemplate.Id;
        Plan.Stage__c = 'Draft';
        insert Plan;
        Plan.Stage__c = 'Published';
        update Plan;
       
       Account acc = new Account();
       acc.Name ='FCI BESANCON SA1';
       acc.EnterpriseId__c='FCIt';
       acc.SupplierId__c='250798401';
       upsert acc;
       
       SPE_SPEPlanSupplierMap__c suppPlanMap = new SPE_SPEPlanSupplierMap__c();
       suppPlanMap.SPEPlan__c = plan.Id;
       suppPlanMap.Supplier__c = acc.Id;
       insert suppPlanMap;
       
       Set<id> trackerId = new set<id>();
       SPE_SPETracker__c tracker = new SPE_SPETracker__c();
       
       tracker.Name ='October - 2015';
       tracker.SPEPlan__c= plan.Id;
       tracker.DateOfExecution__c = system.today();
       tracker.Status__c = 'Pending';
       insert tracker; 
       
        tracker.Status__c ='Completed';
        update tracker; 
        trackerId.add(tracker.id);
      
       
       SPE_Stop__c speStop = new SPE_Stop__c();
       speStop.Stop_trigger__c = true;
       speStop.Name = 'Stop 111';
       insert speStop;
        
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       
     //*****************************Changes For Encryption***************************//  
       //kpiDefinition1.Name = 'Test KPI Definitiioon0723';
       kpiDefinition1.KPI_Title__c = 'Test KPI Definitiioon0723';
     //*****************************END***************************//  
       
       kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
       kpiDefinition1.Level__c = '1';
       kpiDefinition1.LifecycleStage__c = 'Pilot';
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
       kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
       kpiDefinition1.VerNumber__c = 0;
       kpiDefinition1.Aggregation__c = 'AVG';
       insert kpiDefinition1;
       
       SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       
     //*****************************Changes For Encryption***************************//  
       //kpiDefinition2.Name = 'Test KPI Definitionn9123';
       kpiDefinition2.KPI_Title__c = 'Test KPI Definitionn9123';
     //*****************************END***************************//
     
       kpiDefinition2.AbbreviatedName__c = 'TKPIDe11';
       kpiDefinition2.Level__c = '1';
       kpiDefinition2.LifecycleStage__c = 'Pilot';
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
       kpiDefinition2.ScheduledDate__c = system.today().addDays(20);
       kpiDefinition2.VerNumber__c = 0;
       kpiDefinition2.Aggregation__c = 'AVG';
       kpiDefinition2.Master_KPI__c = kpiDefinition1.Id;
       insert kpiDefinition2;
       kpiDefinition2.LifecycleStage__c = 'Pilot';
       update kpiDefinition2; 
       
        
       speStop.Stop_trigger__c = false;
       update speStop;
       
       SPE_SPEKPIMap__c speKpiMap = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
       speKpiMap.KPIDefinition__c = kpiDefinition2.Id;
       speKpiMap.SPETemplate__c = tracker.SPETemplate__c;
       insert speKpiMap;
       
        List<SPE_ScoringCalculation__c> scoreCalcList = new List<SPE_ScoringCalculation__c>();
        SPE_ScoringCalculation__c scoringCalc = SPE_TestObjectCreator.createScoringCalc(speKpiMap,scoringTemplate);
        scoringCalc.KPIDefinition__c =kpiDefinition2.Id;
        scoringCalc.ScoringTemplate__c =plan.SPEScoringTemplate__c ;
        scoringCalc.SPEKPIMap__c =speKpiMap.Id; 
        insert scoringCalc;
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition2.Id;
        kpiValue.KPIValue__c = 1;
        kpiValue.EnterpriseId__c='FCI';
        kpiValue.ExecutionPeriod__c='November - 2015';
        insert kpiValue; 
        
        SPE_KPIValue__c kpiValue1 = new SPE_KPIValue__c();
        kpiValue1.KPIDefinition__c = kpiDefinition2.Id;
        kpiValue1.KPIValue__c = 1;
        kpiValue1.EnterpriseId__c='FCI';
        kpiValue1.ExecutionPeriod__c='October - 2015';
        insert kpiValue1; 
        
         SPE_KPIValue__c kpiValue2 = new SPE_KPIValue__c();
        kpiValue2.KPIDefinition__c = kpiDefinition2.Id;
        kpiValue2.KPIValue__c = 1;
        kpiValue2.EnterpriseId__c='FCI';
        kpiValue2.ExecutionPeriod__c='September - 2015';
        insert kpiValue2; 
       
       SPE_SPEPlanSupplierMap__c scope = new SPE_SPEPlanSupplierMap__c();
       scope.Supplier__c= acc.Id;
       scope.SPEPlan__c = plan.Id;
       insert scope;
       
       PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
       default1.Name = 'Default New'; 
       insert default1;
        
      
       SPE_SPETrackerBatch batchObj = new SPE_SPETrackerBatch(tracker.Id,plan.Id);
       Database.executeBatch(batchObj);
       Test.stopTest();    
    }
}