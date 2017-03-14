@isTest(seeAllData =True)
private class SPE_ScheduleSurveyEmailTest{
   static testMethod void SPE_ScheduleSurveyEmailPositive(){
      Test.StartTest();
              
       Account supplier = SPE_TestObjectCreator.CreateSupplier('AtosUK');
       supplier.Name ='FCI BESANCON SA';
       supplier.EnterpriseId__c='FCI';
       supplier.SupplierId__c='25079840';
       insert supplier;
     
       SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
       
   //********************Changes For Encryption***********************//    
       //KPI.Name = 'Test KPI Definition 1231';
       KPI.KPI_Title__c = 'Test KPI Definition 1231';
   //********************Changes For Encryption***********************//    
       
       KPI.AbbreviatedName__c = 'TKPIDe11';
       KPI.Level__c = '1';
       KPI.LifecycleStage__c = 'Pilot';
       KPI.Description__c = 'Test';
       KPI.MissingDatalogic__c = 'SPE Invalid';
       KPI.OperationalType__c = 'Leading PI';
       KPI.GeoScope__c = 'All Markets';
       KPI.categoryscope__c = 'All Categories';
       KPI.BUScope__c = 'All Products';
       KPI.UoM__c = 'max';
       KPI.Group1__c = 'Cost';
       KPI.Group2__c = 'Hard';
       KPI.Type__c = 'Operational';
       KPI.ActualCalculation__c='a';
       KPI.FrequencyinMonth__c = '2';
       KPI.ScheduledDate__c = system.today().addDays(20);
       KPI.VerNumber__c = 0;
       KPI.Aggregation__c = 'AVG';
       insert KPI;
       KPI.LifecycleStage__c = 'Pilot';
       update KPI; 
      
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
            KPIValueObj.Period__c = system.today().addMonths(-1);
            
            KPIValueObj.EnterpriseID__c = 'FCI';
            KPIValueObj.EnterpriseIDEncrypted__c = supplier.Id;
            KPIValueObj.ExecutionPeriod__c = 'November - 2015';
                    
            KPIValueObj.KPIDefinition__c = KPI.Id;
            
            lstKPIValue.add(KPIValueObj);
        }
        insert lstKPIValue;
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Name = 'TestSPEEmplate02';
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
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.SPEPlanName__c='aAtoos00173';
        spePlan.Organization_Group__c = 'Services Procurement';
        spePlan.AggregationDuration__c = '1';
        spePlan.StartDate__c = Date.today().addMonths(-1);
        spePlan.EndDate__c = Date.today().addMonths(1);
        spePlan.Stage__c = 'Draft';
        insert spePlan; 

        spePlan.Stage__c = 'Published';
        update spePlan;

        SPE_SPEPlanSupplierMap__c spePlanSupplier = new SPE_SPEPlanSupplierMap__c();
        spePlanSupplier.SPEPlan__c = spePlan.Id;
        spePlanSupplier.Supplier__c = supplier.Id;
        insert spePlanSupplier;
        
        List<SPE_SPETracker__c> sptrack = new List<SPE_SPETracker__c>();
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
       speTracker.Name = 'September - 2015';
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
        
        speTracker.SPEPlan__c = spePlanSupplier.SPEPlan__c;
        speTracker.SPETemplate__c = speTemplate.Id;
        speTracker.DateOfExecution__c =system.today();
        speTracker.SendSurveyLink__c =true;
        speTracker.Status__c = 'Pending';
        sptrack.add(speTracker);
        
        insert sptrack;
         
        sptrack[0].Status__c ='Completed';
        update sptrack; 
        
        try{         
            SPE_ScheduleSurveyEmail scheduleSurveyEmail = new SPE_ScheduleSurveyEmail();
            //Database.executeBatch(scheduleSurveyEmail,1);
            Database.QueryLocator QL;
            Database.BatchableContext BC;
            SchedulableContext sc = null;
            scheduleSurveyEmail.start(BC);
            //scheduleSurveyEmail.execute(sc);
            scheduleSurveyEmail.execute(BC,sptrack);
            scheduleSurveyEmail.finish(BC);
        }catch(Exception e){}    
        Test.stopTest();  
   }
}