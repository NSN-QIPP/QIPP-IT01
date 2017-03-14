@isTest(seeAllData= false)

public class SPEReportHybridLogicTest{

public static testmethod void SPEReportHybridLogicTest(){

        SPE_Report_Configs__c reportConfig = new SPE_Report_Configs__c(Name = 'Filter for Spend and Volume');
        reportConfig.Product_Filter_For_Spend__c = true;
        reportConfig.Market_Filter_For_Volume__c = false;
        reportConfig.Product_Filter_For_Volume__c = false;
        insert reportConfig;
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
        
        
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        //spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c='--None--';
        spePlan.BusinessUnit__c='--None--';
        spePlan.Category__c='--None--';
        spePlan.CategoryCluster__c= '--None--';
        spePlan.CategoryGroup__c= '--None--';
        spePlan.CM__c= con.id;
       // spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='--None--';
        spePlan.EndDate__c= Date.newinstance(2016,10,20);
        spePlan.FrequencyInMonths__c='1';
        spePlan.Region__c='--None--';
        spePlan.SubRegion__c= '--None--';
        spePlan.Organization_Group__c='Indirect Procurement';
        //spePlan.PPM1__c= CCcon1.id;
        spePlan.Product__c='All Product';
        spePlan.Project__c='All Project';
        spePlan.StartDate__c= Date.newinstance(2016,01,15);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        insert spePlan;
        spePlan.Stage__c = 'Published';
        update spePlan;
        
         System.debug('$$$$$$$$$ speplan id: '+spePlan.id);
        
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'NA';
        
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
        System.debug('$$$$$$$$$ speTracker name: '+speTracker.Name);
        
        SPE_TrackerScore__c TkScr = new SPE_TrackerScore__c();
        TkScr.KPIName__c='test tracker';
        TkScr.Group__c='All Groups';
        TkScr.Score__c= 2;
        TkScr.SPEScore__c= true;
        TkScr.SPETracker__c = speTracker.id;
        TkScr.Supplier__c= acc1.id;
        insert TkScr;
        
        
        SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        
        insert sc;
        
        
        
        Date d = System.Today();
        
             
        // load spend data
        SPE_Spend__c spend = new SPE_Spend__c();
        spend.Business_Line__c ='All Business Lines'; 
        spend.Business_Unit__c= 'All Business Units';
        spend.Category__c='All Categories'; 
        spend.CategoryArea__c='All Category Areas';
        spend.CategoryGroup__c='All Category Groups';
        spend.Country__c='All Countries'; 
        spend.Period__c=Date.newInstance(2016,10,20);
        spend.Product__c='All Products';
        spend.Project__c= 'All Projects';
        spend.Region__c='All Region';
        spend.Spend__c= 2;
        spend.SPEPeriod__c= 'test';
        spend.Sub_Region__c='All Sub Region'; 
        spend.EnterpriseId__c= acc1.id;
        insert spend;  
        
        SPE_Report_Parameter__c RepPm = new SPE_Report_Parameter__c();
        RepPm.Aggregation_Type__c='Simple Average';
        RepPm.Business_Line__c='All Business Lines'; 
        RepPm.Business_Unit__c='All Business Units';
        RepPm.Category__c='All Categories'; 
        RepPm.CategoryCluster__c='All Category Areas';
        RepPm.Category_Group__c = 'All Category Groups';
        RepPm.Country__c ='All Countries'; 
        RepPm.End_Date__c= System.Today() + 190 ;
        RepPm.IsEmailSent__c= false;
        RepPm.Product__c= 'All Products';
        RepPm.Project__c='All Projects';
        RepPm.Region__c='All Markets';
        RepPm.Start_Date__c= System.Today() - 90 ;
        RepPm.SubRegion__c='All Market Units'; 
        RepPm.useCacheReport__c= false;
        insert RepPm; 
        List<SPE_Report_Parameter__c> RpLst = new List<SPE_Report_Parameter__c>();
        RpLst.add(RepPm); 
        
        System.assertNotEquals(RepPm.id,null);
         
        System.Debug('$$$ scorecard report parameter name :'+ RepPm.Name);
        System.Debug('$$$ scorecard report parameter Id :'+ RepPm.ID);
        
        SPE_Scorecard_Report__c scRpt = new SPE_Scorecard_Report__c();
        scRpt.Business_Line__c='All Business Lines'; 
        scRpt.Business_Unit__c='All Business Units';
        scRpt.Category__c='All Categories'; 
        scRpt.Category_Area__c='All Category Areas';
        scRpt.Category_Group__c='All Category Groups';
        scRpt.Country__c='All Countries'; 
        scRpt.Market__c='All Markets';
        scRpt.Market_Unit__c= 'All Market Units';
        scRpt.Period__c= Date.newInstance(2016,10,20);
        scRpt.Product__c='All Products';
        scRpt.Project__c = 'All Projects';
        scRpt.Score__c = 10;
        scRpt.SPE_Report_Parameter__c = RepPm.id;
        scRpt.SPE_Score__c = true;
        scRpt.SPE_Tracker__c = speTracker.id;
        scRpt.Supplier__c = acc1.id;
        scRpt.Weight__c = 2;
        insert scRpt;
        List<SPE_Scorecard_Report__c> scRptList = new List<SPE_Scorecard_Report__c>();
        scRptList.add(scRpt);
        
        System.Debug('$$$ scorecard report Period_Text__c :'+ scRpt.Period_Text__c);
        System.Debug('$$$ scorecard report id :'+ scRpt.ID);        
        
       
         Test.startTest();
         SPEReportHybridLogic obj= new SPEReportHybridLogic();
         obj.hybridLogicCalc(RepPm.Id,'G');
        
       Test.stopTest();
 }
} 
}