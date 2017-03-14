@isTest
public class SPE_TrackerExecutionExtTest 
{
   static testMethod void TrackerExecutionExt_Test1()
    {   
    
       Account acc = new Account();
       acc.Name ='Test Account';
       acc.EnterpriseId__c='FCI';
       acc.SupplierId__c='Test1';
       insert acc;
       
       SPE_Stop__c speStop = new SPE_Stop__c();
       speStop.Stop_trigger__c = true;
       speStop.Name = 'Stop';
       insert speStop;
        
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       
     //************************Changes For Encryption*********************//
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
     //************************END*********************//
     
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
       
       kpiDefinition1.LifecycleStage__c = 'Pilot';
       update kpiDefinition1;
       
       
       SPE_KPICalculation__c kpiCalc =SPE_TestObjectCreator.createKPICalculation();
       kpiCalc.KPIDefinition__c = kpiDefinition1.Id;
       insert kpiCalc;
       
       SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       
     //************************Changes For Encryption*********************//
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
     //************************END*********************//
     
       kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
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
       kpiDefinition2.IsHighBetter__c=true;
       insert kpiDefinition2;
       kpiDefinition2.LifecycleStage__c = 'Pilot';
       update kpiDefinition2; 
       
       speStop.Stop_trigger__c = false;
       update speStop;
       
       
       SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Name = 'New Test 1212'; 
        speTemplate.Stage__c='Published';
        insert speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;     
       
       SPE_SPEKPIMap__c speKpiMap = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
       speKpiMap.KPIDefinition__c = kpiDefinition2.Id;
       speKpiMap.SPETemplate__c = speTemplate.id;
       
       insert speKpiMap;
       
        List<SPE_ScoringCalculation__c> scoreCalcList = new List<SPE_ScoringCalculation__c>();
        SPE_ScoringCalculation__c scoringCalc = SPE_TestObjectCreator.createScoringCalc(speKpiMap,scoringTemplate);
        scoringCalc.KPIDefinition__c =kpiDefinition2.Id;
        scoringCalc.ScoringTemplate__c =scoringTemplate.id ;
        scoringCalc.SPEKPIMap__c =speKpiMap.Id; 
        scoringCalc.UpperTo__c='<=';
       // scoringCalc.LowerTo__c ='>=';
        scoreCalcList.add(scoringCalc);
        insert scoreCalcList;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc.id;
        insert spePlanSupMap;
        
        Set<id> trackerId = new set<id>();
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'September - 2015'; 
        speTracker.SPETemplate__c = speTemplate.Id; 
        speTracker.SPEPlan__c =spePlan.Id;
        speTracker.DateOfExecution__c = Date.newInstance(2016,12,17);
        insert speTracker;        
        
    /*  SPE_TrackerScore__c  trackerScore =SPE_TestObjectCreator.createTrackerScore();
        trackerScore.SPETracker__c = speTracker.Id;
        trackerScore.Supplier__c =acc.Id;
        trackerScore.SPEScore__c=true;
        insert trackerScore;
       
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition2.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Past Data or Category Average';
        trackerValue.Supplier__c = acc.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList; */        
        integer i = Integer.valueOf(spePlan.AggregationDuration__c);
        date d = (speTracker.DateOfExecution__c).addMonths(-i);
        system.debug('DDDDDDD'+d);
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition2.Id;
        kpiValue.KPIValue__c = 1;
        kpiValue.EnterpriseId__c='FCI';
        kpiValue.EnterpriseIDEncrypted__c = acc.Id;
        kpiValue.ExecutionPeriod__c = d.month()+'-'+ d.year();
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessLine__c ='All Business Units';
        kpiValue.BusinessUnit__c ='All Business Lines';
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
      
        /*List<Decimal> values = new List<Decimal>();
        values.add(1);
        values.add(2);
        values.add(3);
        values.add(4);
        values.add(5);
        
        String aggr = SPE_Constants.KPIAGGREGATION_AVG;
        String aggr1 = SPE_Constants.KPIAGGREGATION_SUM;
        String aggr2 = SPE_Constants.KPIAGGREGATION_MIN;
        String aggr3 = SPE_Constants.KPIAGGREGATION_MAX;
        */
        
        PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        default1.Name= 'Default';
        insert default1;
        
        Apexpages.currentPage().getParameters().put('id', speTracker.Id);
        Apexpages.Standardcontroller st = new Apexpages.Standardcontroller(speTracker);
        SPE_TrackerExecutionExt trackerExecution = new SPE_TrackerExecutionExt(st);
        trackerExecution.TrackerExecution();       
        
     } 
     
     static testMethod void TrackerExecutionExt_Test2()
    {   

       Account acc = new Account();
       acc.Name ='Test Account';
       acc.EnterpriseId__c='FCI';
       acc.SupplierId__c='Test1';
       insert acc;
       
       SPE_Stop__c speStop = new SPE_Stop__c();
       speStop.Stop_trigger__c = true;
       speStop.Name = 'Stop';
       insert speStop;
        
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       
     //************************Changes For Encryption*********************//
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
     //************************END*********************//
     
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
       
       kpiDefinition1.LifecycleStage__c = 'Pilot';
       update kpiDefinition1;
       
       
       SPE_KPICalculation__c kpiCalc =SPE_TestObjectCreator.createKPICalculation();
       kpiCalc.KPIDefinition__c = kpiDefinition1.Id;
       insert kpiCalc;
       
       SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       
     //************************Changes For Encryption*********************//
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
     //************************END*********************//
     
       kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
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
       kpiDefinition2.IsHighBetter__c=true;
       insert kpiDefinition2;
       kpiDefinition2.LifecycleStage__c = 'Pilot';
       update kpiDefinition2; 
       
       speStop.Stop_trigger__c = false;
       update speStop;
              
       SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       speTemplate.Name = 'New Test 1212'; 
       speTemplate.Stage__c='Published';
       insert speTemplate;
        
       SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
       scoringTemplate.Name = 'Test Template 1122'; 
       insert scoringTemplate;
       scoringTemplate.Stage__c = 'Published';
       update scoringTemplate;

       SPE_SPEKPIMap__c speKpiMap = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
       speKpiMap.KPIDefinition__c = kpiDefinition2.Id;
       speKpiMap.SPETemplate__c = speTemplate.id;
       
       insert speKpiMap;
       
       List<SPE_ScoringCalculation__c> scoreCalcList = new List<SPE_ScoringCalculation__c>();
       SPE_ScoringCalculation__c scoringCalc = SPE_TestObjectCreator.createScoringCalc(speKpiMap,scoringTemplate);
       scoringCalc.KPIDefinition__c =kpiDefinition2.Id;
       scoringCalc.ScoringTemplate__c =scoringTemplate.id ;
       scoringCalc.SPEKPIMap__c =speKpiMap.Id; 
       scoringCalc.UpperTo__c='<=';
      // scoringCalc.LowerTo__c ='>=';
       scoreCalcList.add(scoringCalc);
       insert scoreCalcList;
        
       SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
       spePlan.SPEPlanName__c='aAtos11';
       spePlan.FrequencyInMonths__c = '1';
       spePlan.AggregationDuration__c = '1';
       spePlan.SPETemplate__c = speTemplate.Id;
       spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
       spePlan.Stage__c = 'Draft';
       insert spePlan;
       spePlan.Stage__c = 'Published';
       update spePlan;
        
       SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
       spePlanSupMap.SPEPlan__c = spePlan.Id;
       spePlanSupMap.Supplier__c = acc.id;
       insert spePlanSupMap;
        
       Set<id> trackerId = new set<id>();
       SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
       speTracker.Name = 'New Tracker 1212'; 
       speTracker.SPETemplate__c = speTemplate.Id; 
       speTracker.SPEPlan__c =spePlan.Id;
       speTracker.DateOfExecution__c =system.today();
       insert speTracker; 
               
    /*  SPE_TrackerScore__c  trackerScore =SPE_TestObjectCreator.createTrackerScore();
        trackerScore.SPETracker__c = speTracker.Id;
        trackerScore.Supplier__c =acc.Id;
        trackerScore.SPEScore__c=true;
        insert trackerScore;
       
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition2.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Past Data or Category Average';
        trackerValue.Supplier__c = acc.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList; */
                
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition2.Id;
        kpiValue.KPIValue__c = 1;
        kpiValue.EnterpriseId__c='FCI';
        kpiValue.EnterpriseIDEncrypted__c=acc.Id;
        kpiValue.ExecutionPeriod__c='November-2015';
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessLine__c ='All Business Units';
        kpiValue.BusinessUnit__c ='All Business Lines';
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
       
      /*List<Decimal> values = new List<Decimal>();
        values.add(1);
        values.add(2);
        values.add(3);
        values.add(4);
        values.add(5);
        
        String aggr = SPE_Constants.KPIAGGREGATION_AVG;
        String aggr1 = SPE_Constants.KPIAGGREGATION_SUM;
        String aggr2 = SPE_Constants.KPIAGGREGATION_MIN;
        String aggr3 = SPE_Constants.KPIAGGREGATION_MAX;
        */
        
        PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
        default1.Name = 'Default';
        insert default1;
        
        SPE_ScheduleSPETrackerBatchUpdate b = new SPE_ScheduleSPETrackerBatchUpdate();        
        database.executeBatch(b,1);
        
     } 

  }