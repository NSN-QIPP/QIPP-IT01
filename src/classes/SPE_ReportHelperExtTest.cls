@isTest(SeeAllData = true)

public class SPE_ReportHelperExtTest{

public static testmethod void SPE_ReportHelperExtTest1(){
   
        
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
        con.Email = 'Deep.Banerjee@atos1.net';
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
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
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
        insert spePlan;
        spePlan.Stage__c = 'Published';
        update spePlan;
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        
        insert speTracker;
        
        
        Date d = System.Today();
        
        
        List<SPE_Report_Parameter__c> RpLst = new List<SPE_Report_Parameter__c>();
        SPE_Report_Parameter__c RepPm = new SPE_Report_Parameter__c();
        RepPm.Aggregation_Type__c='Simple Average';
        RepPm.Business_Line__c='All Business Lines'; 
        RepPm.Business_Unit__c='All Business Units';
        RepPm.Category__c='All Categories';  
        RepPm.CategoryCluster__c='All Category Areas';
        RepPm.Category_Group__c = 'All Category Groups';
        RepPm.Country__c ='All Countries'; 
        RepPm.End_Date__c= Date.newinstance(2016,10,15);
        RepPm.IsEmailSent__c= true;
        RepPm.Product__c= 'All Products';
        RepPm.Project__c='All Projects';
        RepPm.Region__c='All Region';
        RepPm.Start_Date__c= Date.newinstance(2016,4,15);
        RepPm.SubRegion__c='All Sub Region'; 
        RepPm.useCacheReport__c= false;
        //insert RepPm; 
        RpLst.add(RepPm); 
        
        
     
        Test.startTest();
        PageReference pageRef = Page.SPE_Report_Helper;
        pageRef.getParameters().put('id',RepPm.id);
        pageRef.getParameters().put('marketVal','All Markets');
        pageRef.getParameters().put('buVal','All Business Units');
        pageRef.getParameters().put('marketUnitVal','All Market Units');
        pageRef.getParameters().put('blVal','All Business Lines');
        pageRef.getParameters().put('countryVal','All Countries');
        pageRef.getParameters().put('prdVal','All Products');
        pageRef.getParameters().put('projectVal','All Projects');
        pageRef.getParameters().put('caVal','All Category Areas');
        pageRef.getParameters().put('cgVal','All Category Groups');
        pageRef.getParameters().put('ctVal','All Categories');
        
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sctrl = new ApexPages.StandardController(RepPm);
        SPE_ReportHelperExt extCon = new SPE_ReportHelperExt(sctrl);
        extCon.SPEParameter.useCacheReport__c  = true;
        extCon.batchProcessed = true;
        extCon.getMarketValues();
        extCon.getMarketUnitValues(); 
        extCon.getCountryValues();
        extCon.getProjectValues();
        extCon.getBusinessUnitValues() ;
        extCon.getBusinesLineValues();
        extCon.getProductValues() ;
        extCon.showProdVals();
        extCon.getCategoryAreaValues() ;
        extCon.fillCategoryGroup();
        extCon.getCategoryValues() ;
        extCon.getCategoryGroupValues();
        extCon.blankMethod();
        extCon.getMessage();
        //extCon.process();
        extCon.cancel();
        extCon.mainPage();
        extCon.save();
        extCon.speCountryReport();
        extCon.speRegionReport();
        extCon.speRegionCatReport();
        extCon.speGlobalReport();
        extCon.speGlobalCatReport();
        extCon.speGlobalDashboard();
        extCon.speCatGroupDashboard();
        extCon.speMarketUnitDashboard();
        extCon.speMarketDashboard();
        extCon.speRegionCatGroupDashboard();
        extCon.speSubRegionCatGroupDashboard();
        extCon.speSupplierCoverageDashboard();
        extCon.speSupplierIndexDashboard();
        Test.stopTest();
       
        }
    }
    public static testmethod void SPE_ReportHelperExtTest2(){
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
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
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
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
        insert spePlan;
        spePlan.Stage__c = 'Published';
        update spePlan;
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        
        insert speTracker;
        
        SPE_TrackerScore__c trScore = new SPE_TrackerScore__c();
        trScore.KPIName__c='Test KPI Definition 12334';
        trScore.Group__c='test trackerscore';
        trScore.Score__c=10;
        trScore.SPEScore__c= true;
        trScore.SPETracker__c= speTracker.id;
        trScore.Supplier__c= acc1.id;
        insert trScore;
        
        Test.startTest();
        PageReference pageRef = Page.SPE_Report_Helper;
        //pageRef.getParameters().put('id',RepPm.id);
        pageRef.getParameters().put('marketVal','All Markets');
        pageRef.getParameters().put('buVal','All Business Units');
        pageRef.getParameters().put('marketUnitVal','All Market Units');
        pageRef.getParameters().put('blVal','All Business Lines');
        pageRef.getParameters().put('countryVal','All Countries');
        pageRef.getParameters().put('prdVal','All Products');
        pageRef.getParameters().put('projectVal','All Projects');
        pageRef.getParameters().put('caVal','All Category Areas');
        pageRef.getParameters().put('cgVal','All Category Groups');
        pageRef.getParameters().put('ctVal','All Categories');
        
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sctrl = new ApexPages.StandardController(new SPE_Report_Parameter__c());
        SPE_ReportHelperExt extCon = new SPE_ReportHelperExt(sctrl);
        extCon.SPEParameter.Start_date__c = System.Today() - 90 ;
        extCon.SPEParameter.End_Date__c = System.Today() + 190 ;
        extCon.SPEParameter.Aggregation_Type__c = 'Simple Average';
        extCon.save();    
    }
}