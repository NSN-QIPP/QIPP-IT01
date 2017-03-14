@isTest(SeeAllData = False)
private class SPE2_SPEPlanCreateExt_NewTest {
  
   
    static testMethod void SPE2_SPEPlanCreateExt_NewPositive() 
    {
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
     
         Account a = new Account(Name = 'Test Account');
         insert a;
         
         
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.ScheduledDate__c = System.today().addDays(1);
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';       
        update kpiDefinition1;
                             
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
        
       // SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       // insert speTemplate;
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
       
        
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c= 'All Markets';
        sctemp.SubRegion__c= 'All Market Units';
        sctemp.Country__c = 'All Countries';
        sctemp.Project__c = 'All Projects';
        sctemp.CategoryCluster__c= 'All Category Areas';
        sctemp.CategoryGroup__c='All Category Groups';
        sctemp.Category__c = 'All Categories';
        sctemp.BusinessUnit__c = 'All Business Units';
        sctemp.BusinessLine__c = 'All Business Lines';
        sctemp.Product__c = 'All Products';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
        
        
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);   
        spePlan.StartDate__c = System.today().addDays(1);
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'sample';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Additional_Days__c =1;
        spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
       // update spePlan;
       /* SPE_SPETracker__c spTracker =SPE_TestObjectCreator.createSPETracker();
        spTracker.SPEPlan__c = spePlan.id;
        insert spTracker;*/
        SPE_SPEPlanSupplierMap__c suppliermap = new SPE_SPEPlanSupplierMap__c();
        suppliermap.SPEPlan__c =spePlan.id;
        suppliermap.Supplier__c=a.id;
        insert suppliermap;
        SPE_Respondent__c respondent =new SPE_Respondent__c();
        respondent.SPEPlan__c =spePlan.id;
        insert respondent;
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New;
        Test.setCurrentPage(pageRef);  
        pageRef.getParameters().put('isClone','abcd');
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', spePlan.Id);
        pageRef.getParameters().put('cgVal', 'All Category Groups');
        pageRef.getParameters().put('caVal', 'All Category Areas');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('ctVal', 'All Categories');
        pageRef.getParameters().put('projectVal', 'All Projects');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New spe2PlanExt = new SPE2_SPEPlanCreateExt_New(stCon);
     
         
        spe2PlanExt.closePopup();
        spe2PlanExt.continueCustom();
        spe2PlanExt.save();  
        spe2PlanExt.scopeMatch();
        spe2PlanExt.checkValidation();
        spe2PlanExt.generateTracker();
        spe2PlanExt.getMarketValues();
        spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
        spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();
        spe2PlanExt.ScopeChange();
        spe2PlanExt.blankMethod();
        Test.StopTest();
    }
   
   
    static testMethod void SPE2_SPEPlanCreateExt_NewPositive2() 
    {
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
        
     /*   SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                             
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
        
       // SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       // insert speTemplate;
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
       
        
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c= 'All Markets';
        sctemp.SubRegion__c= 'All Market Units';
        sctemp.Country__c = 'All Countries';
        sctemp.Project__c = 'All Projects';
        sctemp.CategoryCluster__c= 'All Category Areas';
        sctemp.CategoryGroup__c='All Category Groups';
        sctemp.Category__c = 'All Categories';
        sctemp.BusinessUnit__c = 'All Business Units';
        sctemp.BusinessLine__c = 'All Business Lines';
        sctemp.Product__c = 'All Products';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
        
        
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   */ 
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= scoringTemplate.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);        
        spePlan.StartDate__c = System.today().addDays(1);
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'sample';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.AggregationDuration__c  = '1'; 
    /*    insert spePlan;  */
        
        
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New;
        Test.setCurrentPage(pageRef);  
        pageRef.getParameters().put('isClone','abcd');
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('cgVal', 'All Category Groups');
        pageRef.getParameters().put('caVal', 'All Category Areas');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('ctVal', 'All Categories');
        pageRef.getParameters().put('projectVal', 'All Projects');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(new SPE_SPEPlan__c());       
        SPE2_SPEPlanCreateExt_New spe2PlanExt = new SPE2_SPEPlanCreateExt_New(stCon);
     
         
     /* spe2PlanExt.closePopup();
        spe2PlanExt.continueCustom();
        spe2PlanExt.save();  
        spe2PlanExt.scopeMatch();
        spe2PlanExt.checkValidation();
        spe2PlanExt.generateTracker(); */
        spe2PlanExt.getMarketValues();
        spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
        spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
        spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();
        spe2PlanExt.ScopeChange();
        spe2PlanExt.blankMethod();
        Test.StopTest();
    }
    
        static testMethod void SPE2_SPEPlanCreateExt_NewPositive3() 
    {
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
     
      
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.ScheduledDate__c = System.today().addDays(1);
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';       
        update kpiDefinition1;
                             
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
        
       // SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       // insert speTemplate;
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
       
        
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c= 'All Markets';
        sctemp.SubRegion__c= 'All Market Units';
        sctemp.Country__c = 'All Countries';
        sctemp.Project__c = 'All Projects';
        sctemp.CategoryCluster__c= 'All Category Areas';
        sctemp.CategoryGroup__c='All Category Groups';
        sctemp.Category__c = 'All Categories';
        sctemp.BusinessUnit__c = 'All Business Units';
        sctemp.BusinessLine__c = 'All Business Lines';
        sctemp.Product__c = 'All Products';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
        
        
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);   
        spePlan.StartDate__c = System.today().addDays(1);
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'sample';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
      /*  SPE_SPETracker__c spTracker =SPE_TestObjectCreator.createSPETracker();
        spTracker.SPEPlan__c = spePlan.id;
        insert spTracker;*/
        
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New;
        Test.setCurrentPage(pageRef);  
      //  pageRef.getParameters().put('isClone','');
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', spePlan.Id);
        pageRef.getParameters().put('cgVal', 'sample');
        pageRef.getParameters().put('caVal', 'sample');
        pageRef.getParameters().put('buVal', 'sample');
        pageRef.getParameters().put('marketVal', 'sample');
        pageRef.getParameters().put('marketUnitVal', 'sample');
        pageRef.getParameters().put('countryVal', 'sample');
        pageRef.getParameters().put('blVal', 'sample');
        pageRef.getParameters().put('ctVal', 'sample');
        pageRef.getParameters().put('projectVal', 'sample');
        pageRef.getParameters().put('prdVal', 'sample');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New spe2PlanExt = new SPE2_SPEPlanCreateExt_New(stCon);
        
         
        spe2PlanExt.closePopup();
        spe2PlanExt.continueCustom();
        spe2PlanExt.save();  
        spe2PlanExt.scopeMatch();
        spe2PlanExt.checkValidation();
        spe2PlanExt.generateTracker();
        spe2PlanExt.getMarketValues();
      //  spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
    //    spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();
        spe2PlanExt.ScopeChange();
        spe2PlanExt.blankMethod();
        Test.StopTest();
    }
    static testMethod void SPE2_SPEPlanCreateExt_NewPositive4() 
    {
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
     
         Account a = new Account(Name = 'Test Account');
         insert a;
         
         
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.ScheduledDate__c = System.today().addDays(1);
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';       
        update kpiDefinition1;
                             
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
        
       // SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       // insert speTemplate;
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
       
        
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c= 'All Markets';
        sctemp.SubRegion__c= 'All Market Units';
        sctemp.Country__c = 'All Countries';
        sctemp.Project__c = 'All Projects';
        sctemp.CategoryCluster__c= 'All Category Areas';
        sctemp.CategoryGroup__c='All Category Groups';
        sctemp.Category__c = 'All Categories';
        sctemp.BusinessUnit__c = 'All Business Units';
        sctemp.BusinessLine__c = 'All Business Lines';
        sctemp.Product__c = 'All Products';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
        
        
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);   
        spePlan.StartDate__c = System.today();
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'sample';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Additional_Days__c =1;
        spePlan.Next_Computed_Day__c = System.today();
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
       // update spePlan;
       /* SPE_SPETracker__c spTracker =SPE_TestObjectCreator.createSPETracker();
        spTracker.SPEPlan__c = spePlan.id;
        insert spTracker;*/
        SPE_SPEPlanSupplierMap__c suppliermap = new SPE_SPEPlanSupplierMap__c();
        suppliermap.SPEPlan__c =spePlan.id;
        suppliermap.Supplier__c=a.id;
        insert suppliermap;
        SPE_Respondent__c respondent =new SPE_Respondent__c();
        respondent.SPEPlan__c =spePlan.id;
        insert respondent;
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New;
        Test.setCurrentPage(pageRef);  
        pageRef.getParameters().put('isClone','abcd');
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', spePlan.Id);
        pageRef.getParameters().put('cgVal', 'All Category Groups');
        pageRef.getParameters().put('caVal', 'All Category Areas');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('ctVal', 'All Categories');
        pageRef.getParameters().put('projectVal', 'All Projects');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New spe2PlanExt = new SPE2_SPEPlanCreateExt_New(stCon);
     
         
        spe2PlanExt.closePopup();
        spe2PlanExt.continueCustom();
        spe2PlanExt.save();  
        spe2PlanExt.scopeMatch();
        spe2PlanExt.checkValidation();
        spe2PlanExt.generateTracker();
        spe2PlanExt.getMarketValues();
        spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
        spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();
        spe2PlanExt.ScopeChange();
        spe2PlanExt.blankMethod();
        Test.StopTest();
    }
  /*  static testMethod void SPE2_SPEPlanCreateExt_NewPositive5() 
    {
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
     
         Account a = new Account(Name = 'Test Account');
         insert a;
         
         
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.ScheduledDate__c = System.today().addDays(1);
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';       
        update kpiDefinition1;
                             
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
        
       // SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       // insert speTemplate;
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
       
        
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c= 'All Markets';
        sctemp.SubRegion__c= 'All Market Units';
        sctemp.Country__c = 'All Countries';
        sctemp.Project__c = 'All Projects';
        sctemp.CategoryCluster__c= 'All Category Areas';
        sctemp.CategoryGroup__c='All Category Groups';
        sctemp.Category__c = 'All Categories';
        sctemp.BusinessUnit__c = 'All Business Units';
        sctemp.BusinessLine__c = 'All Business Lines';
        sctemp.Product__c = 'All Products';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
        
        
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);   
        spePlan.StartDate__c = System.today().addDays(1);
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'market';
        spePlan.SubRegion__c= 'market unit';
        spePlan.Country__c = 'country';
        spePlan.Project__c = 'project';
        spePlan.CategoryCluster__c= 'category area';
        spePlan.CategoryGroup__c='category group';
        spePlan.Category__c = 'category';
        spePlan.BusinessUnit__c = 'business unit';
        spePlan.BusinessLine__c = 'business line';
        spePlan.Product__c = 'product';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Additional_Days__c =1;
        spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
       // update spePlan;
       // SPE_SPETracker__c spTracker =SPE_TestObjectCreator.createSPETracker();
      //  spTracker.SPEPlan__c = spePlan.id;
       // insert spTracker;
        SPE_SPEPlanSupplierMap__c suppliermap = new SPE_SPEPlanSupplierMap__c();
        suppliermap.SPEPlan__c =spePlan.id;
        suppliermap.Supplier__c=a.id;
        insert suppliermap;
        SPE_Respondent__c respondent =new SPE_Respondent__c();
        respondent.SPEPlan__c =spePlan.id;
        insert respondent;
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New;
        Test.setCurrentPage(pageRef);  
        pageRef.getParameters().put('isClone','abcd');
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', spePlan.Id);
        pageRef.getParameters().put('cgVal', 'cat group');
        pageRef.getParameters().put('caVal', 'cat area');
        pageRef.getParameters().put('buVal', 'business unit');
        pageRef.getParameters().put('marketVal', 'market');
        pageRef.getParameters().put('marketUnitVal', 'market unit');
        pageRef.getParameters().put('countryVal', 'country');
        pageRef.getParameters().put('blVal', 'business line');
        pageRef.getParameters().put('ctVal', 'category');
        pageRef.getParameters().put('projectVal', 'project');
        pageRef.getParameters().put('prdVal', 'product');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New spe2PlanExt = new SPE2_SPEPlanCreateExt_New(stCon);
     
         
        spe2PlanExt.closePopup();
        spe2PlanExt.continueCustom();
        spe2PlanExt.save();  
        spe2PlanExt.scopeMatch();
        spe2PlanExt.checkValidation();
        spe2PlanExt.generateTracker();
        spe2PlanExt.getMarketValues();
       // spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
       // spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();
        spe2PlanExt.ScopeChange();
        spe2PlanExt.blankMethod();
        Test.StopTest();
    }*/
}