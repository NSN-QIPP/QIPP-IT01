@isTest(SeeAllData = false)
public class SPE2_ChangeTrackerBatchTest{     
    static testmethod void SPE2_ChangeTrackerBatchTest1(){             
    Test.startTest(); 
    
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';        
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';               
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';       
        picklistObj.Product__c = 'All Products';
        lstpicklistObj.add(picklistObj);      
        insert lstpicklistObj;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
        System.RunAs(u){ 
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'dharani.dhakineni@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'dharani.dhakineni1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'dharani.dhakineni2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'dharani.dhakineni3@atos.net';
        insert CCcon3;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
      
      //**********************Changes For Encryption******************// 
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
      //**********************END******************//   
        
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.FrequencyinMonth__c = '2';
        //kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        /*kpiDefinition1.LifecycleStage__c = 'Published';
        update kpiDefinition1;*/
        
        SPE_KPICalculation__c objKPICalc = new SPE_KPICalculation__c();
        objKPICalc.ConstantValue__c=8;
        objKPICalc.TimeFrame__c = 4;
        objKPICalc.Aggregation__c = 'Sum';
        objKPICalc.Index__c = 'A';
        objKPICalc.IndexName__c='Test Index';
        objKPICalc.Filter1__c = '1';
        objKPICalc.Filter2__c = '1';
        objKPICalc.Filter3__c = '1';
        objKPICalc.Filter4__c = '1';
        objKPICalc.Filter5__c = '1';
        objKPICalc.Filter6__c = '1';
        objKPICalc.Filter7__c = '1';
        objKPICalc.Filter8__c = '1';
        objKPICalc.Filter9__c = '1';
        objKPICalc.Filter10__c = '1';
        objKPICalc.PIDefination__c = lstPIDefObj[0].id;
        objKPICalc.KPIDefinition__c = kpiDefinition1.id;       
        insert objKPICalc;           
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'January-2020';        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue;                
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';       
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
       
         List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<10;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;
                     
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2019,10,01);       
             spePlan.StartDate__c = Date.newinstance(2018,10,01);
             spePlan.SPETemplate__c = speTemp.Id; 
             spePlan.identifierParam__c=System.Today()+';'+u.Id;
             spePlan.SurveyExecutionBeforeIndays__c = 5;       
             spePlan.SurveyReminderBeforeExecutionDate__c = 3;
             spePlan.Organization_Group__c = 'Services Procurement';       
             spePlan.FrequencyInMonths__c = '1';
             spePlan.SPEPlanName__c = 'New Demo Plan 122';
             spePlan.AggregationDuration__c = '1';
             spePlan.Next_Computed_Day__c = Date.newinstance(2018,11,15);
             spePlan.Region__c = 'All Region';
             spePlan.SubRegion__c = 'All Sub Region';
             spePlan.Country__c = 'All Countries'; 
             spePlan.Project__c = 'All Projects';
             spePlan.Stage__c = 'Draft';
             spePlan.Plan_Identifier__c = System.today()+';'+u.Id;   
             spePlan.CategoryCluster__c = 'All Category Areas';
             spePlan.CategoryGroup__c = 'All Category Groups';
             spePlan.Category__c = 'All Categories';
             spePlan.Ad_Hoc_Plan__c = true;  
             spePlan.BusinessLine__c ='All Business Lines';
             spePlan.BusinessUnit__c ='All Business Units';
             spePlan.Product__c = 'All Products';
             spePlan.Vintage__c = '2015P01';
             spePlan.OwnerId = u.ID;
            // insert spePlan;  
            lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        //speRespondent.Email__c =
        speRespondent.SPEPlan__c = lstPlan[0].id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = lstPlan[0].Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = lstPlan[0].Id;
        speTracker.DateOfExecution__c = System.Today();
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        speTracker.BusinessUnit__c ='Global Services';
        speTracker.BusinessLine__c ='All Business Line';      
        speTracker.Product__c = 'All Products';
        speTracker.Status__c='Pending';
        speTracker.Contact__c= con.id;
        speTracker.ForceSurvey__c =true;
        speTracker.isContainsSurveyBasedPI__c = true;
        speTracker.PilotTestDataCheck__c = true;
        speTracker.SendSurveyLink__c= true;
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        trackerValue.Supplier__c = acc1.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList;              
        
        SPE2_ChangeTrackerBatch obj = new SPE2_ChangeTrackerBatch(System.today()+';');
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPlan);
        obj.finish(bcb);
      }
     Test.stopTest();   
   }
    static testmethod void SPE2_ChangeTrackerBatchTest2(){             
    Test.startTest(); 
    
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';        
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';               
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';       
        picklistObj.Product__c = 'All Products';
        lstpicklistObj.add(picklistObj);      
        insert lstpicklistObj;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
        System.RunAs(u){ 
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'dharani.dhakineni@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'dharani.dhakineni1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'dharani.dhakineni2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'dharani.dhakineni3@atos.net';
        insert CCcon3;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
      
      //**********************Changes For Encryption******************// 
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
      //**********************END******************//   
        
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.FrequencyinMonth__c = '2';
        //kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        /*kpiDefinition1.LifecycleStage__c = 'Published';
        update kpiDefinition1;*/
        
        SPE_KPICalculation__c objKPICalc = new SPE_KPICalculation__c();
        objKPICalc.ConstantValue__c=8;
        objKPICalc.TimeFrame__c = 4;
        objKPICalc.Aggregation__c = 'Sum';
        objKPICalc.Index__c = 'A';
        objKPICalc.IndexName__c='Test Index';
        objKPICalc.Filter1__c = '1';
        objKPICalc.Filter2__c = '1';
        objKPICalc.Filter3__c = '1';
        objKPICalc.Filter4__c = '1';
        objKPICalc.Filter5__c = '1';
        objKPICalc.Filter6__c = '1';
        objKPICalc.Filter7__c = '1';
        objKPICalc.Filter8__c = '1';
        objKPICalc.Filter9__c = '1';
        objKPICalc.Filter10__c = '1';
        objKPICalc.PIDefination__c = lstPIDefObj[0].id;
        objKPICalc.KPIDefinition__c = kpiDefinition1.id;       
        insert objKPICalc;           
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'January-2020';        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue;                
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';       
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
       
         List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<10;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;
                     
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2019,10,01);       
             spePlan.StartDate__c = Date.newinstance(2018,10,01);
             spePlan.SPETemplate__c = speTemp.Id; 
             spePlan.identifierParam__c=System.Today()+';'+u.Id;
             spePlan.SurveyExecutionBeforeIndays__c = 5;       
             spePlan.SurveyReminderBeforeExecutionDate__c = 3;
             spePlan.Organization_Group__c = 'Services Procurement';       
             spePlan.FrequencyInMonths__c = '1';
             spePlan.SPEPlanName__c = 'New Demo Plan 122';
             spePlan.AggregationDuration__c = '1';
             spePlan.Next_Computed_Day__c = Date.newinstance(2018,11,15);
             spePlan.Region__c = 'All Region';
             spePlan.SubRegion__c = 'All Sub Region';
             spePlan.Country__c = 'All Countries'; 
             spePlan.Project__c = 'All Projects';
             spePlan.Stage__c = 'Draft';
             spePlan.Plan_Identifier__c = System.today()+';'+u.Id;   
             spePlan.CategoryCluster__c = 'All Category Areas';
             spePlan.CategoryGroup__c = 'All Category Groups';
             spePlan.Category__c = 'All Categories';
             spePlan.Ad_Hoc_Plan__c = false;  
             spePlan.BusinessLine__c ='All Business Lines';
             spePlan.BusinessUnit__c ='All Business Units';
             spePlan.Product__c = 'All Products';
             spePlan.Vintage__c = '2015P01';
             spePlan.OwnerId = u.ID;
            // insert spePlan;  
            lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        //speRespondent.Email__c =
        speRespondent.SPEPlan__c = lstPlan[0].id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = lstPlan[0].Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = lstPlan[0].Id;
        speTracker.DateOfExecution__c = System.Today();
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        speTracker.BusinessUnit__c ='Global Services';
        speTracker.BusinessLine__c ='All Business Line';      
        speTracker.Product__c = 'All Products';
        speTracker.Status__c='Pending';
        speTracker.Contact__c= con.id;
        speTracker.ForceSurvey__c =true;
        speTracker.isContainsSurveyBasedPI__c = true;
        speTracker.PilotTestDataCheck__c = true;
        speTracker.SendSurveyLink__c= true;
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        trackerValue.Supplier__c = acc1.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList;              
        
        SPE2_ChangeTrackerBatch obj = new SPE2_ChangeTrackerBatch(System.today()+';');
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPlan);
        obj.finish(bcb);
      }
     Test.stopTest();   
   }
}