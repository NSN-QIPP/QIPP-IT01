@isTest(seeAllData=false)
    private class SPE2_Aggregate_NowExt_bckup_test2{
      static testmethod void SPE2_Aggregate_NowExt_bckup_tst1(){
           
            List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
            PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
            picklistObj.Name = 'Picklist Default Values';
            picklistObj.Market__c = 'All Markets';
            picklistObj.Market_Unit__c = 'All Market Units';
            picklistObj.Country__c = 'All Countries';       
            picklistObj.Product__c = 'All Products';
            picklistObj.Category_Area__c = 'All Category Areas';
            picklistObj.Category_Group__c = 'All Category Groups';
            picklistObj.Category__c = 'All Categories';   
            picklistObj.Business_Unit__c = 'All Business Units';
            picklistObj.Business_Line__c = 'All Business Lines';        
            picklistObj.Project__c = 'All Projects';
            
            lstpicklistObj.add(picklistObj);
            
            insert lstpicklistObj;
            
            insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            
            SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
            Rconfig.Name= 'Test Report COnfig';
            Rconfig.Market_Filter_For_Volume__c = true;
            Rconfig.Product_Filter_For_Spend__c= true;
            Rconfig.Product_Filter_For_Volume__c= true;
            insert Rconfig;
            
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
            con.Email = 'Deep.Banerjee@atos.net';
            insert con;
            
            Contact CCcon1 = new Contact();
            CCcon1.LastName = 'Test Contact1';
            CCcon1.AccountId = acc1.Id;
            CCcon1.Email = 'Deep.Banerjee1@atos.net';
            insert CCcon1;
            
            Contact CCcon2 = new Contact();
            CCcon2.LastName = 'Test Contact2';
            CCcon2.AccountId = acc1.Id;
            CCcon2.Email = 'Deep.Banerjee2@atos.net';
            insert CCcon2;
            
            Contact CCcon3 = new Contact();
            CCcon3.LastName = 'Test Contact3';
            CCcon3.AccountId = acc1.Id;
            CCcon3.Email = 'Deep.Banerjee3@atos.net';
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
            
            for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2016,06,10);
            }
            
            update lstPIDefObj;
            
            SPE_PIValues__c  piVal = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[0].id,acc1.id,acc1.EnterpriseId__c);
            piVal.NumberValue__c = 10;
            piVal.Period__c = Date.newinstance(2016,06,05);
            piVal.PIDefination__c =lstPIDefObj[0].id;
            insert piVal;
            
            SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
            kpiDefinition1.ScheduledDate__c = Date.newinstance(2016,06,15);           
            insert kpiDefinition1;
            kpiDefinition1.Group1__c = 'Quality';
            kpiDefinition1.LifecycleStage__c = 'Pilot';
            kpiDefinition1.Confidential__c =True;
            update kpiDefinition1;
            
            SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
            kpiValue.KPIDefinition__c = kpiDefinition1.Id;
            kpiValue.KPIValue__c = 10;
            kpiValue.EnterpriseId__c='Test Enterprise1';
            kpiValue.ExecutionPeriod__c = 'June - 2016';            
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
                   
            
            SPE_SPETemplate__c speTemp = SPE_TestObjectCreator.CreateSPETemplate();           
            insert speTemp;
            
            speTemp.Stage__c ='Pilot';
            update speTemp;
            
            SPE_SPEKPIMap__c KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
            insert KPIMapobj;
            
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
            insert scoringTemplate;
            
            scoringTemplate.Stage__c = 'Pilot';
            update scoringTemplate;
             
            list<SPE_SPEPlan__c > spePlanlist = new list<SPE_SPEPlan__c >();
            for(integer i =0;i<=19;i++){
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
            spePlan.SPEPlanName__c='aAtos11';
            spePlan.Additional_Days__c  = 5;
            spePlan.Next_Computed_Day__c = Date.newinstance(2016,07,20);
            spePlan.FrequencyInMonths__c = '1';
            spePlan.AggregationDuration__c = '1';
            spePlan.SPETemplate__c = speTemp.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            spePlan.Stage__c = 'Draft';
            spePlan.CM__c= con.id;
            spePlan.CompletedTracker__c= 2;
            spePlan.EndDate__c= Date.newinstance(2016,07,30);
            spePlan.FrequencyInMonths__c='1';
            spePlan.Organization_Group__c='Indirect Procurement';
            spePlan.PPM1__c= CCcon1.id;
            spePlan.StartDate__c= Date.newinstance(2016,06,20);
            spePlan.SurveyReminderBeforeExecutionDate__c=1;
            spePlanlist.add(spePlan); 
            }
            insert spePlanlist;
            system.debug('spePlanlist ::'+spePlanlist.size());
            
            list<SPE_SPEPlanSupplierMap__c> spePlanSupMapList = new List<SPE_SPEPlanSupplierMap__c>();
            for(integer i =0;i<=19;i++){
                SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
                spePlanSupMap.SPEPlan__c = spePlanlist[i].Id;
                spePlanSupMap.Supplier__c = acc1.id;
                spePlanSupMapList.add(spePlanSupMap);
            }
            insert spePlanSupMapList;
            
            SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            speTracker.Name = 'May - 2016'; 
            speTracker.SPETemplate__c = speTemp.Id; 
            speTracker.SPEPlan__c = spePlanlist[0].Id;
            speTracker.DateOfExecution__c = Date.newinstance(2016,06,20);
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
            scg.Name = 'May - 2016';
            scg.Stage__c = 'Draft';
            scg.ScorecardTemplate__c = sc.Id;
            scg.StartDate__c = Date.newInstance(2016,1,15);
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
            scg.Aggregation_Period_Adhoc__c ='Quarterly';
            scg.AggregationType__c ='Simple Average';
            scg.AdhocScorecardName__c ='scorecardName';
            insert scg;
            
            scg.Stage__c = 'Published';
            update scg;
            
            SPE_Scorecard_Plan__c scoreplan = new SPE_Scorecard_Plan__c(Scorecard_Generator__c  =scg.id,SPE_Plan__c =spePlanlist[0].id);
            insert scoreplan;
            
            SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
            ss.ScorecardGenerator__c = scg.Id;
            ss.Supplier__c = acc1.Id;
            ss.SupplierContact__c = con.Id;
            ss.Approver__c = u.Id;
            insert ss;
            
            SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
            stt.ScorecardGenerator__c = scg.Id; 
            stt.Name = 'Q1 - 2020';
            stt.DateOfExecution__c =Date.newInstance(2020,1,15);
            stt.EndDate__c = Date.newInstance(2016,3,14);
            stt.Status__c = 'Pending';
            insert stt;

            Date d = System.Today();                                     
           
            SPE_ScoreCard__c score = new SPE_ScoreCard__c();
            score.Name = acc1.Name;
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
            score.Nego_Responsible__c= 'G';
            score.IsAdhoc__c= true;
            score.Comments__c ='Score Comments';
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
//            scRpt.Period_Text__c = 'January - 2020';
            //scRpt.
            insert scRpt;           
            
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
           
            List<SPE_TrackerScore__c> tsList = new  List<SPE_TrackerScore__c>();
            SPE_TrackerScore__c tScore = new SPE_TrackerScore__c();
            tScore.Group__c = 'Test Group';
            tScore.KPIName__c= 'Test Kpi';
            tScore.Score__c = 2;
            tScore.SPEScore__c= true;
            tScore.SPETracker__c = speTracker.id;
            tScore.Supplier__c = acc1.id;
            insert tScore;
            tsList.add(tScore);
            
            List<SPE_BWRuleConfigurator__c> bwrList = new List<SPE_BWRuleConfigurator__c>();
            SPE_BWRuleConfigurator__c bwr = new SPE_BWRuleConfigurator__c();
            bwr.AveragingLogic__c= 'Weighted Average by Volume';
            bwr.Category__c = screport.Category__c;
            bwr.CategoryArea__c = 'All Category Areas';
            bwr.CategoryGroup__c = 'All Category Groups';
           // bwr.Nego_Responsible__c= 'G';
            bwr.Country__c= 'India';
            bwr.Market__c= 'INDIA';
            bwr.Market_Unit__c ='INDIA-IND';
            bwr.Project__c= 'All Project';
            insert bwr;
            bwrList.add(bwr);
           
            SPE_ScorecardTempValues__c sctv1 = new SPE_ScorecardTempValues__c();
            sctv1.Group__c ='';
            sctv1.KPI__c= null;
            sctv1.ScoreCard__c= score.id;
            sctv1.SPE_Plan__c= spePlanlist[0].id;
            sctv1.SPE_TemplateName__c= 'Test SPE TEmplate 123';
            sctv1.SPETracker__c= trackerValue.id;
            sctv1.Supplier__c = acc1.id;
            sctv1.Tracker_Score__c = tScore.id;
            sctv1.Weight__c = 2;
            insert sctv1;
            
            SPE_ScorecardTempValues__c sctv2 = new SPE_ScorecardTempValues__c();
          //  sctv2.Group__c ='';
            sctv2.KPI__c= kpiDefinition1.id;
            sctv2.ScoreCard__c= score.id;
            sctv2.SPE_Plan__c= spePlanlist[0].id;
            sctv2.SPE_TemplateName__c= 'Test SPE TEmplate 123';
            sctv2.SPETracker__c= trackerValue.id;
            sctv2.Supplier__c = acc1.id;
            sctv2.Tracker_Score__c = tScore.id;
            sctv2.Weight__c = 2;
            insert sctv2;
            
            SPE_ScorecardTempValues__c sctv3 = new SPE_ScorecardTempValues__c();
            sctv3.Group__c ='test group';
            sctv3.KPI__c= null;
            sctv3.ScoreCard__c= score.id;
            sctv3.SPE_Plan__c= spePlanlist[0].id;
            sctv3.SPE_TemplateName__c= 'Test SPE TEmplate 123';
            sctv3.SPETracker__c= trackerValue.id;
            sctv3.Supplier__c = acc1.id;
            sctv3.Tracker_Score__c = tScore.id;
            sctv3.Weight__c = 2;
            insert sctv3;
            
            List<SPE2_LanguageList__c> languageList = new List<SPE2_LanguageList__c>();
            SPE2_LanguageList__c language = new SPE2_LanguageList__c();
            language.Name ='French';
            language.Language__c ='French';
            languageList.add(language);
            insert languageList;   
            
            SPE2_Language_KPI__c languagKpi = new SPE2_Language_KPI__c();
            languagKpi.Language__c ='French';
            languagKpi.Language_Version__c ='French';
            languagKpi.English_Version__c ='English';
            languagKpi.KPI__c =kpiDefinition1.id;
            insert languagKpi;
                   

            Test.startTest();
            
            decimal speScore =1;
            PageReference pageRef = Page.SPE2_Aggregate_Now_bckup;
            Test.setCurrentPage(pageRef);
            Apexpages.currentpage().getparameters().put('trckerid',stt.id);
            Apexpages.currentpage().getparameters().put('scrdid',score.id);
            ApexPages.Standardcontroller stdclr = new ApexPages.Standardcontroller(score);
            SPE2_Aggregate_NowExt_bckup obj = new SPE2_Aggregate_NowExt_bckup(stdclr);
            obj.selectedSupplier = acc1.id;
            SPE2_Aggregate_NowExt_bckup.spePlanWrapper Wrapvar = new SPE2_Aggregate_NowExt_bckup.spePlanWrapper(spePlanlist[0],speScore);
            obj.fetchAggregateScore();
            obj.refreshAggregation();
            obj.getValues();
            obj.generateScorecardPage();
            obj.pagination();
            obj.DEFAULT_PAGE_SIZE =10;
            obj.pageNumber =1;
            obj.firstBtnClick();
            obj.nextBtnClick();
            obj.previousBtnClick();
            obj.lastBtnClick();
            obj.getScorecardSuppliers();
            obj.getLanguageValues();
            obj.refreshLanguage();
            obj.createPDF();
            obj.scrdDynamicAggr();
            //obj.showScorecard();
            Test.stopTest();             
       }
}
  static testmethod void SPE2_Aggregate_NowExt_bckup_tst2(){
           
            List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
            PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
            picklistObj.Name = 'Picklist Default Values';
            picklistObj.Market__c = 'All Markets';
            picklistObj.Market_Unit__c = 'All Market Units';
            picklistObj.Country__c = 'All Countries';       
            picklistObj.Product__c = 'All Products';
            picklistObj.Category_Area__c = 'All Category Areas';
            picklistObj.Category_Group__c = 'All Category Groups';
            picklistObj.Category__c = 'All Categories';   
            picklistObj.Business_Unit__c = 'All Business Units';
            picklistObj.Business_Line__c = 'All Business Lines';        
            picklistObj.Project__c = 'All Projects';
            
            lstpicklistObj.add(picklistObj);
            
            insert lstpicklistObj;
            
            insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            
            SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
            Rconfig.Name= 'Test Report COnfig';
            Rconfig.Market_Filter_For_Volume__c = true;
            Rconfig.Product_Filter_For_Spend__c= true;
            Rconfig.Product_Filter_For_Volume__c= true;
            insert Rconfig;
            
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
            con.Email = 'Deep.Banerjee@atos.net';
            insert con;
            
            Contact CCcon1 = new Contact();
            CCcon1.LastName = 'Test Contact1';
            CCcon1.AccountId = acc1.Id;
            CCcon1.Email = 'Deep.Banerjee1@atos.net';
            insert CCcon1;
            
            Contact CCcon2 = new Contact();
            CCcon2.LastName = 'Test Contact2';
            CCcon2.AccountId = acc1.Id;
            CCcon2.Email = 'Deep.Banerjee2@atos.net';
            insert CCcon2;
            
            Contact CCcon3 = new Contact();
            CCcon3.LastName = 'Test Contact3';
            CCcon3.AccountId = acc1.Id;
            CCcon3.Email = 'Deep.Banerjee3@atos.net';
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
            
            for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2016,06,10);
            }
            
            update lstPIDefObj;
            
            SPE_PIValues__c  piVal = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[0].id,acc1.id,acc1.EnterpriseId__c);
            piVal.NumberValue__c = 10;
            piVal.Period__c = Date.newinstance(2016,06,05);
            piVal.PIDefination__c =lstPIDefObj[0].id;
            insert piVal;
            
            SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
            kpiDefinition1.ScheduledDate__c = Date.newinstance(2016,06,15);           
            insert kpiDefinition1;
            kpiDefinition1.Group1__c = 'Commercial';
            kpiDefinition1.LifecycleStage__c = 'Pilot';
            kpiDefinition1.Confidential__c =True;
            update kpiDefinition1;
            
            SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
            kpiValue.KPIDefinition__c = kpiDefinition1.Id;
            kpiValue.KPIValue__c = 10;
            kpiValue.EnterpriseId__c='Test Enterprise1';
            kpiValue.ExecutionPeriod__c = 'June - 2016';            
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
                   
            
            SPE_SPETemplate__c speTemp = SPE_TestObjectCreator.CreateSPETemplate();           
            insert speTemp;
            
            speTemp.Stage__c ='Pilot';
            update speTemp;
            
            SPE_SPEKPIMap__c KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
            insert KPIMapobj;
            
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
            insert scoringTemplate;
            
            scoringTemplate.Stage__c = 'Pilot';
            update scoringTemplate;
             
            list<SPE_SPEPlan__c > spePlanlist = new list<SPE_SPEPlan__c >();
            for(integer i =0;i<=19;i++){
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
            spePlan.SPEPlanName__c='aAtos11';
            spePlan.Additional_Days__c  = 5;
            spePlan.Next_Computed_Day__c = Date.newinstance(2016,07,20);
            spePlan.FrequencyInMonths__c = '1';
            spePlan.AggregationDuration__c = '1';
            spePlan.SPETemplate__c = speTemp.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            spePlan.Stage__c = 'Draft';
            spePlan.CM__c= con.id;
            spePlan.CompletedTracker__c= 2;
            spePlan.EndDate__c= Date.newinstance(2016,07,30);
            spePlan.FrequencyInMonths__c='1';
            spePlan.Organization_Group__c='Indirect Procurement';
            spePlan.PPM1__c= CCcon1.id;
            spePlan.StartDate__c= Date.newinstance(2016,06,20);
            spePlan.SurveyReminderBeforeExecutionDate__c=1;
            spePlanlist.add(spePlan); 
            }
            insert spePlanlist;
            system.debug('spePlanlist ::'+spePlanlist.size());
            
            list<SPE_SPEPlanSupplierMap__c> spePlanSupMapList = new List<SPE_SPEPlanSupplierMap__c>();
            for(integer i =0;i<=19;i++){
                SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
                spePlanSupMap.SPEPlan__c = spePlanlist[i].Id;
                spePlanSupMap.Supplier__c = acc1.id;
                spePlanSupMapList.add(spePlanSupMap);
            }
            insert spePlanSupMapList;
            
            SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            speTracker.Name = 'May - 2016'; 
            speTracker.SPETemplate__c = speTemp.Id; 
            speTracker.SPEPlan__c = spePlanlist[0].Id;
            speTracker.DateOfExecution__c = Date.newinstance(2016,06,20);
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
            scg.Name = 'May - 2016';
            scg.Stage__c = 'Draft';
            scg.ScorecardTemplate__c = sc.Id;
            scg.StartDate__c = Date.newInstance(2016,1,15);
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
            scg.Aggregation_Period_Adhoc__c ='Quarterly';
            scg.AggregationType__c ='Simple Average';
            scg.AdhocScorecardName__c ='scorecardName';
            insert scg;
            
            scg.Stage__c = 'Published';
            update scg;
            
            SPE_Scorecard_Plan__c scoreplan = new SPE_Scorecard_Plan__c(Scorecard_Generator__c  =scg.id,SPE_Plan__c =spePlanlist[0].id);
            insert scoreplan;
            
            SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
            ss.ScorecardGenerator__c = scg.Id;
            ss.Supplier__c = acc1.Id;
            ss.SupplierContact__c = con.Id;
            ss.Approver__c = u.Id;
            insert ss;
            
            SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
            stt.ScorecardGenerator__c = scg.Id; 
            stt.Name = 'Q1 - 2020';
            stt.DateOfExecution__c =Date.newInstance(2020,1,15);
            stt.EndDate__c = Date.newInstance(2016,3,14);
            stt.Status__c = 'Pending';
            insert stt;

            Date d = System.Today();                                     
           
            SPE_ScoreCard__c score = new SPE_ScoreCard__c();
            score.Name = acc1.Name;
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
            score.Nego_Responsible__c= 'G';
            score.IsAdhoc__c= true;
            score.Password__c ='nitish123';
            score.Comments__c ='Score Comments';
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
//            scRpt.Period_Text__c = 'January - 2020';
            //scRpt.
            insert scRpt;           
            
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
           
            List<SPE_TrackerScore__c> tsList = new  List<SPE_TrackerScore__c>();
            SPE_TrackerScore__c tScore = new SPE_TrackerScore__c();
            tScore.Group__c = 'Test Group';
            tScore.KPIName__c= 'Test Kpi';
            tScore.Score__c = 2;
            tScore.SPEScore__c= true;
            tScore.SPETracker__c = speTracker.id;
            tScore.Supplier__c = acc1.id;
            insert tScore;
            tsList.add(tScore);
            
            List<SPE_BWRuleConfigurator__c> bwrList = new List<SPE_BWRuleConfigurator__c>();
            SPE_BWRuleConfigurator__c bwr = new SPE_BWRuleConfigurator__c();
            bwr.AveragingLogic__c= 'Weighted Average by Volume';
            bwr.Category__c = screport.Category__c;
            bwr.CategoryArea__c = 'All Category Areas';
            bwr.CategoryGroup__c = 'All Category Groups';
           // bwr.Nego_Responsible__c= 'G';
            bwr.Country__c= 'India';
            bwr.Market__c= 'INDIA';
            bwr.Market_Unit__c ='INDIA-IND';
            bwr.Project__c= 'All Project';
            insert bwr;
            bwrList.add(bwr);
           
            SPE_ScorecardTempValues__c sctv1 = new SPE_ScorecardTempValues__c();
            sctv1.Group__c ='';
            sctv1.KPI__c= null;
            sctv1.ScoreCard__c= score.id;
            sctv1.SPE_Plan__c= spePlanlist[0].id;
            sctv1.SPE_TemplateName__c= 'Test SPE TEmplate 123';
            sctv1.SPETracker__c= trackerValue.id;
            sctv1.Supplier__c = acc1.id;
            sctv1.Tracker_Score__c = tScore.id;
            sctv1.Weight__c = 2;
            insert sctv1;
            
            SPE_ScorecardTempValues__c sctv2 = new SPE_ScorecardTempValues__c();
          //  sctv2.Group__c ='';
            sctv2.KPI__c= kpiDefinition1.id;
            sctv2.ScoreCard__c= score.id;
            sctv2.SPE_Plan__c= spePlanlist[0].id;
            sctv2.SPE_TemplateName__c= 'Test SPE TEmplate 123';
            sctv2.SPETracker__c= trackerValue.id;
            sctv2.Supplier__c = acc1.id;
            sctv2.Tracker_Score__c = tScore.id;
            sctv2.Weight__c = 2;
            insert sctv2;
            
            SPE_ScorecardTempValues__c sctv3 = new SPE_ScorecardTempValues__c();
            sctv3.Group__c ='test group';
            sctv3.KPI__c= null;
            sctv3.ScoreCard__c= score.id;
            sctv3.SPE_Plan__c= spePlanlist[0].id;
            sctv3.SPE_TemplateName__c= 'Test SPE TEmplate 123';
            sctv3.SPETracker__c= trackerValue.id;
            sctv3.Supplier__c = acc1.id;
            sctv3.Tracker_Score__c = tScore.id;
            sctv3.Weight__c = 2;
            insert sctv3;
            
            List<SPE2_LanguageList__c> languageList = new List<SPE2_LanguageList__c>();
            SPE2_LanguageList__c language = new SPE2_LanguageList__c();
            language.Name ='French';
            language.Language__c ='French';
            languageList.add(language);
            insert languageList;   
            
            SPE2_Language_KPI__c languagKpi = new SPE2_Language_KPI__c();
            languagKpi.Language__c ='French';
            languagKpi.Language_Version__c ='French';
            languagKpi.English_Version__c ='English';
            languagKpi.KPI__c =kpiDefinition1.id;
            insert languagKpi;
                   

            Test.startTest();
            
            decimal speScore =1;
            PageReference pageRef = Page.SPE2_Aggregate_Now_bckup;
            Test.setCurrentPage(pageRef);
            Apexpages.currentpage().getparameters().put('trckerid',stt.id);
            Apexpages.currentpage().getparameters().put('scrdid',score.id);
            ApexPages.Standardcontroller stdclr = new ApexPages.Standardcontroller(score);
            SPE2_Aggregate_NowExt_bckup obj = new SPE2_Aggregate_NowExt_bckup(stdclr);
            obj.selectedSupplier = acc1.id;
            obj.strMode ='internal';
            obj.providePassword ='nitish123';
            
            SPE2_Aggregate_NowExt_bckup.spePlanWrapper Wrapvar = new SPE2_Aggregate_NowExt_bckup.spePlanWrapper(spePlanlist[0],speScore);
            obj.fetchAggregateScore();
            obj.refreshAggregation();
            obj.getValues();
            obj.generateScorecardPage();
            obj.pagination();
            obj.DEFAULT_PAGE_SIZE =10;
            obj.pageNumber =1;
            obj.firstBtnClick();
            obj.nextBtnClick();
            obj.previousBtnClick();
            obj.lastBtnClick();
            obj.getScorecardSuppliers();
            obj.getLanguageValues();
            obj.refreshLanguage();
            obj.createPDF();
            obj.scrdDynamicAggr();
            obj.showScorecard();
            Test.stopTest();             
       }
}

}