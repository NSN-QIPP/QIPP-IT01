@isTest(seeAllData = false)
private class SPE2_createkpiIntermediateComputeTest 
{
   static testMethod void createkpiIntermediateCompute () 
    {
      
        Test.startTest();
       
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 111';
        speTemplate.Stage__c='Published';
        insert speTemplate;
                
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

       List<Account> lstAcc = new List<Account>();
       Account acc1 = new Account();
       acc1.Name = 'COSCOM';
       acc1.EnterpriseId__c = 'COSCOM';
       insert acc1;
       lstAcc.add(acc1);
        
       Account acc = new Account();
       acc.Name = 'UNITEL';
       acc.EnterpriseId__c = 'UNITEL';
       insert acc;
       lstAcc.add(acc);
       System.debug('inserting supplier'+lstAcc[0].id);


       
       SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
       pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
       insert pidef;
        
       pidef.LifecycleStage__c = 'Pilot';
       update pidef;
       System.debug('pidef ::'+pidef);
        
       SPE_PIValues__c piVal= new SPE_PIValues__c(); 
       piVal.Region__c = 'All Markets';
       piVal.SubRegion__c = 'All Market Units';
       piVal.Country__c = 'All Countries';
       piVal.Project__c = 'All Projects';        
       piVal.Cluster__c = 'All Category Areas';
       piVal.CategoryGroup__c = 'All Category Groups';
       piVal.Category__c = 'All Categories';        
       piVal.BusinessUnit__c = 'All Business Units';
       piVal.BusinessLine__c = 'All Business Lines';
       piVal.Product__c = 'All Products';        
       piVal.Period__c = Date.newInstance(2016,6,14);
       piVal.NumberValue__c = 10;       
       piVal.PIDefination__c = piDef.Id;
       piVal.Supplier__c = lstAcc[0].Id;
       piVal.EnterpriseID__c = lstAcc[0].EnterpriseId__c;      
       insert piVal;
       
       SPE_SPEPlanSupplierMap__c suppPlanMap = new SPE_SPEPlanSupplierMap__c();
       suppPlanMap.SPEPlan__c = plan.Id;
       suppPlanMap.Supplier__c = lstAcc[0].Id;
       insert suppPlanMap;
       
       Set<id> trackerId = new set<id>();
       SPE_SPETracker__c tracker = new SPE_SPETracker__c();
       tracker.Name ='September - 2015';
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
        kpiValue.IdentifierParam__c = System.Today()+';';
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
        
        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiDefinition2.id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = 'FCIt';
        insert kpicomment;
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiDefinition2.id;      
        insert kpiCal;

        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiDefinition2.id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>=';
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;
        
        List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
        kpiInterComp.KPI_Mappingscope__c = '';//lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020'; 
        //lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020';
        kpiInterComp.KPI__c = kpiDefinition2.Id;
        
        insert kpiInterComp;        
        lstkpiInterComp.add(kpiInterComp);
        
        System.debug('kpiInterComp.KPI_Mappingscope__c'+kpiInterComp.KPI_Mappingscope__c);
        List<SPE_PITempValue__c> lstTempval = new List<SPE_PITempValue__c>();
        SPE_PITempValue__c tempval = new SPE_PITempValue__c();
        tempval.PIValue__c = '10';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
        //tempval.Mappingscope__c = kpiInterComp.KPI_Mappingscope__c; 
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c = acc1.Id;
        tempval.BusinessLine__c  = 'PROD PROC';
        tempval.BusinessUnit__c = 'PROD BL';
        tempval.Category__c = 'IP CG'; 
        tempval.CategoryGroup__c = 'IP GP';
        tempval.Cluster__c = 'IP';
        tempval.Country__c = 'IND C';
        tempval.Region__c = 'IND';
        tempval.SubRegion__c = 'IND MX';
        tempval.Project__c = 'INDP';
        tempval.Product__c ='PROD RT';
        tempval.ExecutionPeriod__c = 'June - 2020';
        tempval.KPICalculation__c= kpiCal.id;
        tempval.KPIDefinition__c= kpiDefinition2.id;
        tempval.isconstant__c=false;
        insert tempval;
        lstTempval.add(tempval );
        System.debug('value each'+ tempval.EnterpriseIDEncrypted__r.Id + ';' + tempval.BusinessLine__c + ';' + tempval.BusinessUnit__c + ';' + tempval.Category__c + ';' + tempval.CategoryGroup__c + ';'+ tempval.Cluster__c + ';' + tempval.Country__c + ';' + tempval.Region__c+ ';' + tempval.SubRegion__c+ ';' + tempval.Project__c + ';' + tempval.Product__c + ';'+ tempval.ExecutionPeriod__c);
        System.debug('tempval.Mappingscope__c '+tempval.Mappingscope__c );
        
        Map<Id, Map<String, String>> kpiEnterpriseComMap = new Map<Id, Map<String, String>>();
        Map<String, String> enterpriseCommentsMap = new Map<String, String>();
        String surveyComments = '';
        if (kpicomment.EnterpriseId__c != null)
        {
          surveyComments = kpicomment.EnterpriseId__c;
        }
        
        surveyComments = surveyComments == ''?  kpicomment.SurveyComments__c : surveyComments + ' | ' + kpicomment.SurveyComments__c;
        enterpriseCommentsMap.put(''+kpicomment.EnterpriseId__c, surveyComments);
        kpiEnterpriseComMap.put(kpicomment.KPI__c, +enterpriseCommentsMap);
        
        string kpidefId = kpiDefinition2.id;
        string Idenf = kpiValue.IdentifierParam__c; 
        SPE2_createkpiIntermediateCompute obj = new SPE2_createkpiIntermediateCompute(Idenf , kpidefId , kpiEnterpriseComMap);
        Database.executeBatch(obj,lstTempval.size());
        Test.stopTest();   
        
        
   }
   
   
}