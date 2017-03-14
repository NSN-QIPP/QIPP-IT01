@isTest(SeeAllData = true)

public class SPE_AdhocScorecardPageEXTTest{
public static testmethod void  SPE_AdhocScorecardPageEXTTest1(){
    SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
    PageReference pageRef = Page.SPE_AdhocScorecardPage;
    pageRef.getParameters().put('adhocView', 'true');
    pageRef.getParameters().put('isNew', 'true');
    pageRef.getParameters().put('UID', '1234');                   
    Test.setCurrentPage(pageRef);
    
    ApexPages.StandardController sctrl = new ApexPages.StandardController(sc);
    SPE_AdhocScorecardPageEXT ext = new SPE_AdhocScorecardPageEXT(sctrl);
    ext.redirectToSecondPg();
}
public static testmethod void  SPE_AdhocScorecardPageEXTTest3(){
    SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
    PageReference pageRef = Page.SPE_AdhocScorecardPage;
    
    pageRef.getParameters().put('UID', '1234');                   
    Test.setCurrentPage(pageRef);
    
    ApexPages.StandardController sctrl = new ApexPages.StandardController(sc);
    SPE_AdhocScorecardPageEXT ext = new SPE_AdhocScorecardPageEXT(sctrl);
    ext.redirectToSecondPg();
}
public static testmethod void  SPE_AdhocScorecardPageEXTTest2(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;   
        
        
        SPE_ProjectMaster__c projectMaster = new SPE_ProjectMaster__c();                  
        projectMaster.Market__c = 'INDIA1'; 
        projectMaster.MarketUnit__c = 'INDIA BHARTI1';          
        projectMaster.Country__c = 'India1';
        projectMaster.Project__c = 'In Bharti 4G1';
        insert projectMaster;
        
        SPE_BUBL__c BUBL = new SPE_BUBL__c();
        BUBL.BusinessUnit__c = 'Mobile Broadband1';
        BUBL.BusinessLine__c = 'TD LTE1';
        BUBL.Product__c = 'TD LTE1';
        insert BUBL;
        
        SPE_CategoryMaster__c categoryMaster = new SPE_CategoryMaster__c();
        categoryMaster.Cluster__c = 'Indirect Procurement1';
        categoryMaster.Group__c = 'IT Procurement1';
        categoryMaster.Category__c = 'IT Infra1';
        insert categoryMaster;
        
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Contact3 Test';
        con.AccountId = acc1.Id;
        con.Email = 'Deep.Banerjee12@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Contact4 Test';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Deep.Banerjee14@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Contact5 Test';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Deep.Banerjee24@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Contact6 Test';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Deep.Banerjee34@atos.net';
        insert CCcon3;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        //**********************Changes For Encryption******************// 
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            //PIDefObj.Name = 'Test PI Definition'+i;
        //**********************************END*************************//
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,10,10);
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';        
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
            kpiDefinition2.KPI_Title__c = 'Test KPI Definition 12334';
            //kpiDefinition2.Name = 'Test KPI Definition 123';
        //**********************************END*************************//
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
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        /*kpiDefinition2.LifecycleStage__c = 'Published';
        update kpiDefinition2;*/
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
           // kpiDefinition1.Name = 'Test KPI Definition 12334';
       //**********************************END*************************//
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'Market';
        kpiDefinition1.categoryscope__c = 'Category Area';
        kpiDefinition1.BUScope__c = 'Business Unit';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        /*kpiDefinition1.LifecycleStage__c = 'Published';
        update kpiDefinition1;*/
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
        
        kpiValue.Region__c = 'INDIA';
        kpiValue.SubRegion__c = 'INDIA BHARTI';
        kpiValue.Country__c = 'India';
        kpiValue.Project__c = 'In Bharti 4G';
        
        kpiValue.Cluster__c = 'Indirect Procurement';
        kpiValue.CategoryGroup__c = 'IT Procurement';
        kpiValue.Category__c = 'IT Infra';
        
        kpiValue.BusinessUnit__c = 'Mobile Broadband';
        kpiValue.BusinessLine__c = 'TD LTE';
        kpiValue.Product__c = 'TD LTE';
        
        insert kpiValue; 
               
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'INDIA';
        speTemp.SubRegion__c = 'INDIA BHARTI';
        speTemp.Country__c = 'India';
        speTemp.Project__c = 'In Bharti 4G';
        
        speTemp.CategoryCluster__c = 'Indirect Procurement';
        speTemp.CategoryGroup__c = 'IT Procurement';
        speTemp.Category__c = 'IT Infra';
        
        speTemp.BusinessUnit__c = 'Mobile Broadband';
        speTemp.BusinessLine__c = 'TD LTE';
        speTemp.Product__c = 'TD LTE';
         
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122';
        scoringTemplate.Region__c = 'INDIA';
        scoringTemplate.SubRegion__c = 'INDIA BHARTI';
        scoringTemplate.Country__c = 'India';
        scoringTemplate.Project__c = 'In Bharti 4G';
        
        scoringTemplate.CategoryCluster__c = 'Indirect Procurement';
        scoringTemplate.CategoryGroup__c = 'IT Procurement';
        scoringTemplate.Category__c = 'IT Infra';
        
        scoringTemplate.BusinessUnit__c = 'Mobile Broadband';
        scoringTemplate.BusinessLine__c = 'TD LTE';
        scoringTemplate.Product__c = 'TD LTE'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.Region__c = 'INDIA';
        spePlan.SubRegion__c = 'INDIA BHARTI';
        spePlan.Country__c = 'India';
        spePlan.Project__c = 'In Bharti 4G';
        
        spePlan.CategoryCluster__c = 'Indirect Procurement';
        spePlan.CategoryGroup__c = 'IT Procurement';
        spePlan.Category__c = 'IT Infra';
        
        spePlan.BusinessUnit__c = 'Mobile Broadband';
        spePlan.BusinessLine__c = 'TD LTE';
        spePlan.Product__c = 'TD LTE';
        spePlan.StartDate__c = Date.newInstance(2016,01,01);
        spePlan.EndDate__c = Date.newInstance(2016,12,15);
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
              
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'INDIA';
        speTracker.SubRegion__c = 'INDIA BHARTI';
        speTracker.Country__c = 'India';
        speTracker.Project__c = 'In Bharti 4G';
        
        speTracker.CategoryCluster__c = 'Indirect Procurement';
        speTracker.CategoryGroup__c = 'IT Procurement';
        speTracker.Category__c = 'IT Infra';
        
        speTracker.BusinessUnit__c = 'Mobile Broadband';
        speTracker.BusinessLine__c = 'TD LTE';
        speTracker.Product__c = 'TD LTE';
        
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
        insert trackerValue;
        tvList.add(trackerValue); 
        //insert tvList;
        
        SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        sc.BusinessUnit__c = 'Mobile Broadband';
        sc.BusinessLine__c = 'TD LTE';
        sc.Product__c = 'TD LTE';
        sc.CategoryCluster__c = 'Indirect Procurement';
        sc.CategoryGroup__c = 'IT Procurement';
        sc.Category__c = 'IT Infra';
        sc.Region__c = 'INDIA';
        sc.SubRegion__c = 'INDIA BHARTI';
        sc.Country__c = 'India';
        sc.Project__c = 'In Bharti 4G';
        sc.isAdhoc__c = True;
        sc.KPIDefinition__c = kpiDefinition1.Id;
               
        insert sc;
        
        SPE_ScorecardSPETemplateMap__c sct = new SPE_ScorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
        
        List<SPE_ScorecardSPETemplateMap__c> sctList = new List<SPE_ScorecardSPETemplateMap__c>();
        sctList.add(sct);
        
        sc.Stage__c = 'Published';
        update sc;
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'Test Scorecard Generator_Atos11212343';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2016,01,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'INDIA';
        scg.SubRegion__c = 'INDIA BHARTI';
        scg.Country__c = 'India';
        scg.Project__c = 'In Bharti 4G';
        
        scg.CategoryCluster__c = 'Indirect Procurement';
        scg.CategoryGroup__c = 'IT Procurement';
        scg.Category__c = 'IT Infra';
        
        scg.BusinessUnit__c = 'Mobile Broadband';
        scg.BusinessLine__c = 'TD LTE';
        scg.Product__c = 'TD LTE';
        
        scg.isAdhoc__c = true;
        
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'January - 2016';
        stt.DateOfExecution__c = System.Today();
        //stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'Pending';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        Date d = System.Today();
        
        
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
       // strack = [Select Id,DateOfExecution__c,Name,ScorecardGenerator__c from SPE_ScorecardTracker__c where ScorecardGenerator__c != Null AND Status__c = 'Pending' AND DateOfExecution__c =:d Limit 100];
        strack.add(stt); 
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        List<SPE_SPEPlanSupplierMap__c> supMapLst = new List<SPE_SPEPlanSupplierMap__c>();
        supMapLst.add(spePlanSupMap);
        
        
        
        SPE_TrackerValues__c  tvls = new SPE_TrackerValues__c();
        tvls.DataLogic__c= 'Actual';
        tvls.KPIGroup__c='All Groups';
        tvls.KPIDefinition__c= kpiDefinition1.id;
        tvls.LogicAnnotation__c= 'test logic';
        tvls.MissingDatalogic__c= 'test missing datalogic';
        tvls.Score__c=10;
        tvls.Spend__c=1000;
        tvls.SPETracker__c= speTracker.id;
        tvls.Supplier__c= acc1.id;
        tvls.Value__c= 10;
        tvls.Weight__c=2;
        
        insert tvls;
        
        List<SPE_TrackerValues__c> tkvalist = new List<SPE_TrackerValues__c>();
        tkvalist.add(tvls);
      
        Test.startTest();
        
        String tempName1 = '1';
        
        PageReference pageRef = Page.SPE_AdhocScorecardPage;
        pageRef.getParameters().put('id',sc.id);
        pageRef.getParameters().put('SPEPlanName',spePlan.SPEPlanName__c);
        pageRef.getParameters().put('speTracker',speTracker.Name);
        pageRef.getParameters().put('supplier',acc1.Name);
        pageRef.getParameters().put('market','INDIA');
        pageRef.getParameters().put('marketunit','INDIA BHARTI');
        
        pageRef.getParameters().put('marketVal','INDIA');
        pageRef.getParameters().put('marketUnitVal','INDIA BHARTI');
        pageRef.getParameters().put('countryVal','India');
        pageRef.getParameters().put('buVal','Mobile Broadband');
        pageRef.getParameters().put('blVal','TD LTE');
        pageRef.getParameters().put('caVal','Indirect Procurement');
        pageRef.getParameters().put('cgVal','IT Procurement');
        pageRef.getParameters().put('rerenderForm11','IT Infra');       
        
        pageRef.getParameters().put('country','India');
        pageRef.getParameters().put('project','In Bharti 4G');
        pageRef.getParameters().put('categoryarea','Indirect Procurement');
        pageRef.getParameters().put('categorygrp','IT Procurement');
        pageRef.getParameters().put('category','IT Infra');
        pageRef.getParameters().put('bunit','Mobile Broadband');
        pageRef.getParameters().put('bline','TD LTE');
        pageRef.getParameters().put('product','TD LTE');
        pageRef.getParameters().put('tempId2',tempName1);
        pageRef.getParameters().put('tempId1',tempName1);
        pageRef.getParameters().put('scoreCardTempId',sc.Id);
        pageRef.getParameters().put('tarckerValueId', trackerValue.id);
        pageRef.getParameters().put('adhocView', 'true');
        pageRef.getParameters().put('isNew', 'false');
        pageRef.getParameters().put('UID', '1234');
        
                   
        Test.setCurrentPage(pageRef);
        
        
        ApexPages.StandardController sctrl = new ApexPages.StandardController(sc);
        SPE_AdhocScorecardPageEXT ext = new SPE_AdhocScorecardPageEXT(sctrl);
        SPE_AdhocScorecardPageEXT.PlanWrapper wpclass = new SPE_AdhocScorecardPageEXT.PlanWrapper(true,supMapLst[0]);
        //ext.trackerWrapperList[0].isSelected = true;
        ext.scorecardSPETemplateMaps = new List<SPE_ScorecardSPETemplateMap__c>();
        ext.scorecardSPETemplateMaps.add(sct);
        ext.trackerWrapperListRequested = tvList;
        ext.lstSPEPlanSuppMap = supMapLst;
        ext.startDate = system.today() - 200;
        ext.endDate = system.today() + 200;
        ext.idSPETemplate.add(speTemp.Id);
        ext.getSelected();       
        ext.runQuery();
        
        ext.runSearch();
        ext.runQuery();
        ext.CustomIterable(supMapLst);
        ext.getSelectedTracker();
        
        ext.removeTrackerValue();
        ext.redirectToSecondPg();
        ext.fetchData();
        ext.removeSupplierPlandata();
        ext.removedata();
        ext.checkValidation();
        ext.save();
        ext.submitAdhocScorecard();
        ext.SaveAdhocScoreCardData();
        ext.cancel();
        ext.CustomIterable(supMapLst);
        ext.checkValidation();
        ext.assignScoreCards(sc);
        
        Test.stopTest();
        }
}