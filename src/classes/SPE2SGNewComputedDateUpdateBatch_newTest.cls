@isTest(seeAllData=false)

public class SPE2SGNewComputedDateUpdateBatch_newTest{
    public static testMethod void TestSPE2SGNewComputedDateUpdateBatch_newTest1(){
          
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
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
      
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
   
        SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        
        SPE_ScorecardSPETemplateMap__c sct = new SPE_ScorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
        
        sc.Stage__c = 'Published';
        update sc;
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'Test Scorecard Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2016,2,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'All Markets';
        scg.SubRegion__c = 'All Market Units';
        scg.Country__c = 'All Countries';
        scg.Project__c = 'All Projects';
        
        scg.CategoryCluster__c = 'All Category Areas';
        scg.CategoryGroup__c = 'All Category Groups';
        scg.Category__c = 'All Categories';
        
        scg.BusinessUnit__c = 'All Business Units';
        scg.BusinessLine__c = 'All Business Lines';
        scg.Product__c = 'All Products';
        
        scg.Additional_Days__c = 10;
        scg.Next_Computed_Day__c =Date.newInstance(2016,05,08);      
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        list<SPE_ScorecardGenerator__c> scgList = new list<SPE_ScorecardGenerator__c>();
        scgList.add(scg);
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(5);
            kpiDefinition1.VerNumber__c = 1;
            insert kpiDefinition1;
            
            kpiDefinition1.LifecycleStage__c = 'Pilot';
            update kpiDefinition1;
            
        SPE_SPEKPIMap__c kpiMap = new SPE_SPEKPIMap__c();
        kpiMap.SPETemplate__c = speTemp.Id;
        kpiMap.KPIDefinition__c = kpiDefinition1.id;
        insert kpiMap;
        
        list<SPE_SPEKPIMap__c> kpiist = new list<SPE_SPEKPIMap__c>();
        kpiist.add(kpiMap);
        //insert kpiist;
        
          //----------Scoring Template Creation-----------------------
         SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
         scoringTemplate.Stage__c = 'Draft';       
         insert scoringTemplate;
            
         scoringTemplate.Stage__c = 'Pilot';     
         update scoringTemplate;  
        
         Date myDate = System.today();
         
       //  List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c >();
           
           SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
           spePlan.SPEPlanName__c= 'Atos Plan1';
           spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
           spePlan.EndDate__c = mydate.addMonths(1);       
           spePlan.StartDate__c = mydate.addMonths(-1);
           spePlan.SPETemplate__c = speTemp.Id; 
           spePlan.SurveyExecutionBeforeIndays__c = 5;       
           spePlan.SurveyReminderBeforeExecutionDate__c = 3;
           spePlan.Organization_Group__c = 'Services Procurement';       
           spePlan.FrequencyInMonths__c = '1';
           spePlan.SPEPlanName__c = 'New Demo Plan 122';
           spePlan.AggregationDuration__c = '1';
           spePlan.Next_Computed_Day__c = Date.newinstance(2018,11,15);
           spePlan.Region__c = 'IND';
           spePlan.SubRegion__c = 'IND MX';
           spePlan.Country__c = 'IND C';
           spePlan.Project__c = 'INDP';
           spePlan.Stage__c = 'Draft';
           spePlan.CategoryCluster__c = 'IP';
           spePlan.CategoryGroup__c = 'IP GP';
           spePlan.Category__c = 'IP CG';
           spePlan.BusinessLine__c ='PROD PROC';
           spePlan.BusinessUnit__c ='PROD BL';
           spePlan.Product__c = 'PROD RT';
           spePlan.Vintage__c = '2015P01';
           spePlan.OwnerId = u.ID; 
           insert spePlan;
   /*        lstPlan.add(spePlan);      
        
           SPE_SPEPlan__c spePlan2 = new SPE_SPEPlan__c();
           spePlan2.SPEPlanName__c= 'Atos Plan2';
           spePlan2.SPEScoringTemplate__c = scoringTemplate.Id;
           spePlan2.EndDate__c = mydate.addMonths(2);       
           spePlan2.StartDate__c = mydate.addMonths(1);
           spePlan2.SPETemplate__c = speTemp.Id; 
           spePlan2.SurveyExecutionBeforeIndays__c = 5;       
           spePlan2.SurveyReminderBeforeExecutionDate__c = 3;
           spePlan2.Organization_Group__c = 'Services Procurement';       
           spePlan2.FrequencyInMonths__c = '1';
           spePlan2.SPEPlanName__c = 'New Demo Plan 122';
           spePlan2.AggregationDuration__c = '1';
           spePlan2.Next_Computed_Day__c = Date.newinstance(2018,11,15);
           spePlan2.Region__c = 'IND';
           spePlan2.SubRegion__c = 'IND MX';
           spePlan2.Country__c = 'IND C';
           spePlan2.Project__c = 'INDP';
           spePlan2.Stage__c = 'Draft';
           spePlan2.CategoryCluster__c = 'IP';
           spePlan2.CategoryGroup__c = 'IP GP';
           spePlan2.Category__c = 'IP CG';
           spePlan2.BusinessLine__c ='PROD PROC';
           spePlan2.BusinessUnit__c ='PROD BL';
           spePlan2.Product__c = 'PROD RT';
           spePlan2.Vintage__c = '2015P01';
           spePlan2.OwnerId = u.ID; 
           lstPlan.add(spePlan2);      
         insert lstPlan;
      */   
         SPE_SPETracker__c  trackerObj = new SPE_SPETracker__c();
         trackerObj  = SPE_TestObjectCreator.createSPETracker();
         trackerObj.SPEPlan__c = spePlan.ID;
         trackerObj.DateOfExecution__c = myDate.addDays(2);
         trackerObj.Status__c = 'Pending';
         trackerObj.Name = 'December - 2018';
         insert trackerObj;
         
   /*      SPE_SPETracker__c  trackerObj2 = new SPE_SPETracker__c();
         trackerObj2  = SPE_TestObjectCreator.createSPETracker();
         trackerObj2.SPEPlan__c = lstPlan[1].ID;
         trackerObj2.DateOfExecution__c = myDate.addDays(2);
         trackerObj2.Status__c = 'Pending';
         trackerObj2.Name = 'December - 2018';
         insert trackerObj2;
         
         SPE_SPETracker__c  trackerObj3 = new SPE_SPETracker__c();
         trackerObj3  = SPE_TestObjectCreator.createSPETracker();
         trackerObj3.SPEPlan__c = lstPlan[1].ID;
         trackerObj3.DateOfExecution__c = myDate.addDays(-2);
         trackerObj3.Status__c = 'Pending';
         trackerObj3.Name = 'December - 2018';
         insert trackerObj3;
     */   
        test.startTest();
       
        SPE2SGNewComputedDateUpdateBatch_new obj = new SPE2SGNewComputedDateUpdateBatch_new();
        
        SchedulableContext scb ;
        Database.BatchableContext bcb;
        
       // obj.start(bcb);
       // obj.execute(scb);
        DataBase.executeBatch(obj,scgList.size());
      //  obj.finish(bcb); 
      }     
        
        test.stopTest();
        
     }    
     
     public static testMethod void TestSPE2SGNewComputedDateUpdateBatch_newTest2(){
          
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
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
      
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
   
        SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        
        SPE_ScorecardSPETemplateMap__c sct = new SPE_ScorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
        
        sc.Stage__c = 'Published';
        update sc;
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'Test Scorecard Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2016,2,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'All Markets';
        scg.SubRegion__c = 'All Market Units';
        scg.Country__c = 'All Countries';
        scg.Project__c = 'All Projects';
        
        scg.CategoryCluster__c = 'All Category Areas';
        scg.CategoryGroup__c = 'All Category Groups';
        scg.Category__c = 'All Categories';
        
        scg.BusinessUnit__c = 'All Business Units';
        scg.BusinessLine__c = 'All Business Lines';
        scg.Product__c = 'All Products';
        
        scg.Additional_Days__c = 10;
        scg.Next_Computed_Day__c =Date.newInstance(2016,05,08);      
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        list<SPE_ScorecardGenerator__c> scgList = new list<SPE_ScorecardGenerator__c>();
        scgList.add(scg);
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(5);
            kpiDefinition1.VerNumber__c = 1;
            insert kpiDefinition1;
            
            kpiDefinition1.LifecycleStage__c = 'Pilot';
            update kpiDefinition1;
            
        SPE_SPEKPIMap__c kpiMap = new SPE_SPEKPIMap__c();
        kpiMap.SPETemplate__c = speTemp.Id;
        kpiMap.KPIDefinition__c = kpiDefinition1.id;
        insert kpiMap;
        
        list<SPE_SPEKPIMap__c> kpiist = new list<SPE_SPEKPIMap__c>();
        kpiist.add(kpiMap);
        //insert kpiist;
        
          //----------Scoring Template Creation-----------------------
         SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
         scoringTemplate.Stage__c = 'Draft';       
         insert scoringTemplate;
            
         scoringTemplate.Stage__c = 'Pilot';     
         update scoringTemplate;  
        
         Date myDate = System.today();

           SPE_SPEPlan__c spePlan2 = new SPE_SPEPlan__c();
           spePlan2.SPEPlanName__c= 'Atos Plan2';
           spePlan2.SPEScoringTemplate__c = scoringTemplate.Id;
           spePlan2.EndDate__c = mydate.addMonths(3);       
           spePlan2.StartDate__c = mydate.addMonths(1);
           spePlan2.SPETemplate__c = speTemp.Id; 
           spePlan2.SurveyExecutionBeforeIndays__c = 5;       
           spePlan2.SurveyReminderBeforeExecutionDate__c = 3;
           spePlan2.Organization_Group__c = 'Services Procurement';       
           spePlan2.FrequencyInMonths__c = '1';
           spePlan2.SPEPlanName__c = 'New Demo Plan 122';
           spePlan2.AggregationDuration__c = '1';
           spePlan2.Next_Computed_Day__c = Date.newinstance(2018,11,15);
           spePlan2.Region__c = 'IND';
           spePlan2.SubRegion__c = 'IND MX';
           spePlan2.Country__c = 'IND C';
           spePlan2.Project__c = 'INDP';
           spePlan2.Stage__c = 'Draft';
           spePlan2.CategoryCluster__c = 'IP';
           spePlan2.CategoryGroup__c = 'IP GP';
           spePlan2.Category__c = 'IP CG';
           spePlan2.BusinessLine__c ='PROD PROC';
           spePlan2.BusinessUnit__c ='PROD BL';
           spePlan2.Product__c = 'PROD RT';
           spePlan2.Vintage__c = '2015P01';
           spePlan2.OwnerId = u.ID; 
           spePlan2.Additional_Days__c = 1;
        //   lstPlan.add(spePlan2);      
         insert spePlan2;
         
         SPE_SPETracker__c  trackerObj2 = new SPE_SPETracker__c();
         trackerObj2  = SPE_TestObjectCreator.createSPETracker();
         trackerObj2.SPEPlan__c = spePlan2.ID;
         trackerObj2.DateOfExecution__c = myDate;
         trackerObj2.Status__c = 'Pending';
         trackerObj2.Name = 'December - 2018';
         insert trackerObj2;
         
        test.startTest();
       
        SPE2SGNewComputedDateUpdateBatch_new obj = new SPE2SGNewComputedDateUpdateBatch_new();
        
        SchedulableContext scb ;
        Database.BatchableContext bcb;
        
       // obj.start(bcb);
       // obj.execute(scb);
        DataBase.executeBatch(obj,scgList.size());
      //  obj.finish(bcb); 
      }     
        
        test.stopTest();
        
     }    
}