@isTest(SeeAllData=False)
public class SPE2_PlanChangeDateTest{
    static testmethod void SPE2_PlanChangeDateTest1(){
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
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
        System.RunAs(u){ 
        Account acc1 = new Account();
        acc1.Name = 'COSCOM';
        acc1.EnterpriseId__c = 'COSCOM';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna.shaw@atos.net';
        con.isInternal__c =true;
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'sudeshna.shaw1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'sudeshna.shaw2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'sudeshna.shaw3@atos.net';
        insert CCcon3;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
       
       //**********************Changes For Encryption******************// 
        //PIDefObj.Name = 'Test PI Definition'+i;
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
       //**********************END******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2016,07,15);
        lstPIDefObj[i].DataAcquisitionMethod__c  = 'Data Load';
        lstPIDefObj[i].Frequency__c = '1';
        }
        
        update lstPIDefObj;     
        
      /*  SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[0].id,acc1.id,acc1.enterpriseId__c);
        piVal.PIDefination__c =lstPIDefObj[0].id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.NumberValue__c =10;
        insert piVal;*/
        
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2016,07,16);
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
        
        
       /* KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiDefinition1.id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>=';
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;          */  
        
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
         for(Integer i=0;i<=11;i++){
             SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
                spePlan.SPEPlanName__c='aAtos11';
                spePlan.FrequencyInMonths__c = '1';
                spePlan.AggregationDuration__c = '1';
                spePlan.SPETemplate__c = speTemp.Id;
                spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
                spePlan.Stage__c = 'Draft';
                spePlan.BusinessLine__c='PROD PROC';
                spePlan.BusinessUnit__c='PROD BL';
                spePlan.Category__c='IP CG';
                spePlan.CategoryCluster__c= 'IP';
                spePlan.CategoryGroup__c= 'IP GP';
                spePlan.CM__c= con.id;
               // spePlan.CompletedTracker__c= 2;
                spePlan.Country__c='IND C';
                spePlan.EndDate__c= Date.newinstance(2020,06,20);
                spePlan.FrequencyInMonths__c='1';
                spePlan.Region__c='IND';
                spePlan.SubRegion__c= 'IND MX';
                spePlan.Organization_Group__c='Indirect Procurement';
                spePlan.PPM1__c= CCcon1.id;
                spePlan.Product__c='PROD RT';
                spePlan.Project__c='All Project';
                spePlan.StartDate__c= Date.newinstance(1960,1,1);
                spePlan.SurveyReminderBeforeExecutionDate__c=1;
                spePlan.Start_Month__c = 'July';
                spePlan.Start_Year__c= '2016';
                spePlan.End_Month__c = 'February';
                spePlan.End_Year__c = '2017';
                spePlan.Additional_Days__c = 1;
                spePlan.Next_Computed_Day__c =Date.newinstance(2016,8,5);
             lstPlan.add(spePlan);
           }
        insert lstPlan;
        
        lstPlan[0].Stage__c = 'Published';
        update lstPlan;
        
        List<SPE_SPEPlanSupplierMap__c> plansupMaplst = new List<SPE_SPEPlanSupplierMap__c>();
        for(Integer i=0 ;i<=11;i++){
            SPE_SPEPlanSupplierMap__c suppmap = new SPE_SPEPlanSupplierMap__c();
            suppmap.SPEPlan__c =lstPlan[i].id;
            suppmap.Supplier__c =acc1.id;
            plansupMaplst.add(suppmap);
        }
        insert plansupMaplst;
        
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c= lstPlan[0].Id;
        respondent.Contact__c = con.id;
        insert respondent;
         
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
        scg.Name = 'January - 2020';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2020,1,20);
        scg.EndDate__c = Date.newInstance(2020,12,15);
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
        scg.isAutoDistributionON__c= true;
        scg.IsAutoApproved__c= true;
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.Approver__c = u.Id;
        insert ss;
        
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
        SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'January - 2020';
        stt.DateOfExecution__c =Date.newInstance(2020,1,15);
        //stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'Pending';
        strack.add(stt);
        insert stt;
                
        Date d = System.Today();
                              
        SPE_ScoreCard__c score = new SPE_ScoreCard__c();
        score.Name = 'Test ScoreCard';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Pending';
        score.ScorecardTracker__c = stt.Id;
        score.StartDate__c = stt.ScorecardGenerator__r.StartDate__c;
        score.EndDate__c = stt.ScorecardGenerator__r.EndDate__c; 
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA-IND';
        score.Country__c = 'India';
        score.Project__c = 'All Project';
        score.CategoryCluster__c = 'All Category Area';
        score.CategoryGroup__c = 'All Category Group';
        score.Category__c = 'All Category';
        score.BusinessUnit__c = 'All Business Unit';
        score.BusinessLine__c = 'All Business Line';
        score.Product__c = 'Charging Gateway CG'; 
        score.CCContact1__c= CCcon1.id;
        score.CCContact2__c= CCcon2.id;
        score.CCContact3__c= CCcon3.id;
        score.AggregationRule__c='Simple Average';
        score.AggregationType__c='Simple Average';
        score.Aggregation_Duration__c=1;
        score.Algorithm__c='Simple Average';
        score.DisplaySpend__c= true;
        score.DisplayUnits__c = true;
        score.Distribute_Scorecard__c = 'DISTRIBUTED';
        score.Scorecard_Visual__c = 'Traditional Scorecard';
        score.IsAdhoc__c= true;

        insert score;        
                
        SPE_Report_Parameter__c screport = new SPE_Report_Parameter__c();
        screport.Region__c = 'INDIA';
        screport.SubRegion__c = 'INDIA-IND';
        screport.Country__c = 'India';
        screport.Project__c = 'All Project';
        screport.CategoryCluster__c = 'All Category Areas';
        screport.Category_Group__c = 'All Category Groups';
        screport.Category__c = 'All Categories';
        screport.Business_Unit__c ='All Business Units';
        screport.Business_Line__c ='All Business Lines';      
        screport.Product__c = 'All Products';
        screport.Aggregation_Type__c='Simple Average';
        screport.IsEmailSent__c= true;
        screport.useCacheReport__c= true;
        screport.Start_Date__c= Date.newInstance(2020,1,15);
        screport.End_Date__c= Date.newInstance(2020,12,15);
        insert screport;
                    
        List<Decimal> dcList = new  List<decimal>();
        Decimal dc =15.50;
        dcList.add(dc); 
               
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
        scRpt.SPE_Report_Parameter__c = screport.id;
        scRpt.SPE_Score__c = true;
        scRpt.SPE_Tracker__c = speTracker.id;
        scRpt.Supplier__c = acc1.id;
        scRpt.Weight__c = 2;
        insert scRpt;
        List<SPE_Scorecard_Report__c> scRptList = new List<SPE_Scorecard_Report__c>();
        scRptList.add(scRpt);
        
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
        
        SPE_TrackerScore__c tScore = new SPE_TrackerScore__c();
        tScore.Group__c = 'Test Group';
        tScore.KPIName__c= 'Test Kpi';
        tScore.Score__c = 2;
        tScore.SPEScore__c= true;
        tScore.SPETracker__c = speTracker.id;
        tScore.Supplier__c = acc1.id;
        insert tScore;
        
        List<SPE_TrackerScore__c> tsList = new  List<SPE_TrackerScore__c>();
        tsList.add(tScore);
        
        List<SPE_BWRuleConfigurator__c> bwrList = new List<SPE_BWRuleConfigurator__c>();
        SPE_BWRuleConfigurator__c bwr = new SPE_BWRuleConfigurator__c();
        bwr.AveragingLogic__c= 'Weighted Average by Volume';
        bwr.Category__c = screport.Category__c;
        bwr.CategoryArea__c = 'All Category Areas';
        bwr.CategoryGroup__c = 'All Category Groups';
        insert bwr;
        
        bwrList.add(bwr);
        
        List<SPE_ScorecardTempValues__c> sctvList= new List<SPE_ScorecardTempValues__c>();
        SPE_ScorecardTempValues__c sctv = new SPE_ScorecardTempValues__c();
        sctv.Group__c ='test group';
        sctv.KPI__c= kpiDefinition1.id;
        sctv.ScoreCard__c= score.id;
        sctv.SPE_Plan__c= lstPlan[0].id;
        sctv.SPE_TemplateName__c= 'Test SPE TEmplate 123';
        sctv.SPETracker__c= trackerValue.id;
        sctv.Supplier__c = acc1.id;
        sctv.Tracker_Score__c = tScore.id;
        sctv.Weight__c = 2;
        sctvList.add(sctv);
        insert sctv;
               
        Test.startTest();
        PageReference pg = Page.SPE2_PlanChangeDate;
        system.Test.setCurrentPage(pg);
      //  Apexpages.currentpage().getparameters().put('planIdentifier','planIdentifier'); 
        Apexpages.Standardcontroller sc1 =  new Apexpages.Standardcontroller(lstPlan[0]); 
        SPE2_PlanChangeDate plandate = new SPE2_PlanChangeDate(sc1);
        plandate.returnbackToPlan();
        plandate.updateSPEPlans();
        Test.stopTest();
        } 
    }
     static testmethod void SPE2_PlanChangeDateTest2(){
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
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
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
        con.Email = 'sudeshna.shaw@atos.net';
        con.isInternal__c =true;
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'sudeshna.shaw1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'sudeshna.shaw2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'sudeshna.shaw3@atos.net';
        insert CCcon3;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
       
       //**********************Changes For Encryption******************// 
        //PIDefObj.Name = 'Test PI Definition'+i;
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
       //**********************END******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2016,07,15);
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2016,07,16);
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
        
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiDefinition1.id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>=';
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;          
        
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
         for(Integer i=0;i<=11;i++){
             SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
                spePlan.SPEPlanName__c='aAtos11';
                spePlan.FrequencyInMonths__c = '1';
                spePlan.AggregationDuration__c = '1';
                spePlan.SPETemplate__c = speTemp.Id;
                spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
                spePlan.Stage__c = 'Draft';
                spePlan.BusinessLine__c='PROD PROC';
                spePlan.BusinessUnit__c='PROD BL';
                spePlan.Category__c='IP CG';
                spePlan.CategoryCluster__c= 'IP';
                spePlan.CategoryGroup__c= 'IP GP';
                spePlan.CM__c= con.id;
               // spePlan.CompletedTracker__c= 2;
                spePlan.Country__c='IND C';
                spePlan.EndDate__c= Date.newinstance(2020,06,20);
                spePlan.FrequencyInMonths__c='1';
                spePlan.Region__c='IND';
                spePlan.SubRegion__c= 'IND MX';
                spePlan.Organization_Group__c='Indirect Procurement';
                spePlan.PPM1__c= CCcon1.id;
                spePlan.Product__c='PROD RT';
                spePlan.Project__c='All Project';
                spePlan.StartDate__c= Date.newinstance(2020,01,20);
                spePlan.SurveyReminderBeforeExecutionDate__c=1;
                spePlan.Start_Month__c = 'July';
                spePlan.Start_Year__c= '2016';
                spePlan.End_Month__c = 'February';
                spePlan.End_Year__c = '2017';
                spePlan.Additional_Days__c = 1;
                spePlan.Next_Computed_Day__c =Date.newinstance(2016,7,1);
             lstPlan.add(spePlan);
           }
        insert lstPlan;
        
        lstPlan[0].Stage__c = 'Published';
        update lstPlan;
        
        Test.startTest();
        PageReference pg = Page.SPE2_PlanChangeDate;
        system.Test.setCurrentPage(pg);
        
        Apexpages.currentpage().getparameters().put('planIdentifier','planIdentifier');  
        Apexpages.Standardcontroller sc1 =  new Apexpages.Standardcontroller(lstPlan[0]); 
        SPE2_PlanChangeDate plandate = new SPE2_PlanChangeDate(sc1);
        plandate.returnbackToPlan();
        plandate.updateSPEPlans();
        Test.stopTest();
        }

    }
   
}