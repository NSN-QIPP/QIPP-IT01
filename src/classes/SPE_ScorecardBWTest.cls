@isTest(seeAllData=False)
public class SPE_ScorecardBWTest{

public static testmethod void SPE_ScorecardBWTest1(){

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
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
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
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
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
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';        
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
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.StartDate__c = Date.NewInstance(2015,12,01);
        spePlan.EndDate__c = Date.NewInstance(2016,12,01);
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
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
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        //trackerValue.SPE_TemplateName__c = speTemp.id;
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
        scg.Name = 'Test Scorecard Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2015,12,2);
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
        stt.Name = 'February - 2016';
        stt.DateOfExecution__c = System.Today();
        //stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'DISTRIBUTED';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        Date d = System.Today();
        
        //SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
        strack = [Select Id,DateOfExecution__c,Name,ScorecardGenerator__c from SPE_ScorecardTracker__c where ScorecardGenerator__c != Null AND Status__c = 'Pending' AND DateOfExecution__c =:d Limit 100];
        //strack.add(stt); 
                        
        
        SPE_ScoreCard__c score = new SPE_ScoreCard__c();
        score.Name = 'Test ScoreCard';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Approved';
        score.ScorecardTracker__c =stt.Id;
        score.StartDate__c = stt.ScorecardGenerator__r.StartDate__c;
        score.EndDate__c = stt.ScorecardGenerator__r.EndDate__c; 
        score.AggregationType__c='Rules Driven Averaging';
        score.AggregationRule__c= 'test rule2';
         score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
        score.Project__c = 'In Bharti 4G';        
        score.CategoryCluster__c = 'Indirect Procurement';
        score.CategoryGroup__c = 'Facility';
        score.Category__c = 'Facility Services';        
        score.BusinessUnit__c = 'Global Services';
        score.BusinessLine__c = 'Network Implementation';
        score.Product__c= 'Charging Gateway CG';
        insert score;
               
        SPE_ScorecardValues__c sCdval = new SPE_ScorecardValues__c();
        sCdval.KPI__c=  kpiDefinition1.Id;
        sCdval.Score__c= 20.50;
        sCdval.ScoreCard__c = score.id;
        sCdval.SPE_Template_Name__c='abc';
        insert  sCdval ;
        
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
        screport.Start_Date__c= Date.newInstance(2016,1,15);
        screport.End_Date__c= Date.newInstance(2016,12,15);
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
        
        SPE_BWRuleConfigurator__c bwr = new SPE_BWRuleConfigurator__c();
        bwr.AveragingLogic__c= 'Simple Average';
        bwr.Category__c = screport.Category__c;
        bwr.CategoryArea__c = 'All Category Areas';
        bwr.CategoryGroup__c = 'All Category Groups';
        bwr.Nego_Responsible__c= 'G';
        bwr.Country__c= 'India';
        bwr.Market__c= 'INDIA';
        bwr.Market_Unit__c ='INDIA-IND';
        bwr.Project__c= 'All Project';
        insert bwr;
        List<SPE_BWRuleConfigurator__c> bwrList = new List<SPE_BWRuleConfigurator__c>();
        bwrList.add(bwr);
       
        SPE_ScorecardTempValues__c sctv = new SPE_ScorecardTempValues__c();
        sctv.Group__c ='test group';
        sctv.KPI__c= kpiDefinition1.id;
        sctv.ScoreCard__c= score.id;
        sctv.SPE_Plan__c= spePlan.id;
        sctv.SPE_TemplateName__c= 'Test SPE TEmplate 123';
        sctv.SPETracker__c= trackerValue.id;
        sctv.Supplier__c = acc1.id;
        sctv.Tracker_Score__c = tScore.id;
        sctv.Weight__c = 2;
        insert sctv;
    
        List<SPE_ScorecardTempValues__c> sctvList= new List<SPE_ScorecardTempValues__c>();
        sctvList.add(sctv);

        SPE_Volume__c vol = new SPE_Volume__c();
        vol.Category__c='All Categories'; 
        vol.CategoryCluster__c= 'All Category Areas';
        vol.Category_Group__c ='All Category Groups';
        vol.Country__c ='India';
        vol.EnterpriseID__c = acc1.id;
        vol.Period__c = Date.newInstance(2016,10,20);
        vol.Project__c ='All Project';
        vol.Region__c ='INDIA';
        vol.SPEPeriod__c= 'Test';
        vol.SubRegion__c = 'INDIA-IND';
        vol.SupplierName__c = acc1.Name;
        vol.Volume__c =2;
        insert vol;   
        
        update score;
    } 
}
public static testmethod void SPE_ScorecardBWTest2(){

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
        System.RUnAs(u){
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
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
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
                        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
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
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
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
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Published';
        insert spePlan;
        
       /* spePlan.Stage__c = 'Published';
        update spePlan;*/
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
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
        speTracker.status__c ='Completed';
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        //trackerValue.SPE_TemplateName__c =speTemp.id;
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
        scg.Name = 'Test Scorecard Generator';
        scg.Stage__c = 'Published';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2015,12,1);
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
        insert scg;
        
       /* scg.Stage__c = 'Published';
        update scg;*/
        
        SPE_Scorecard_Plan__c scorecardPlan = new SPE_Scorecard_Plan__c();
        scorecardPlan.Scorecard_Generator__c =scg.id;
        scorecardPlan.SPE_Plan__c =spePlan.id;
        insert scorecardPlan;
        
        SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'February - 2016';
        stt.DateOfExecution__c = System.Today();
        //stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'Pending';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
       
        Date d = System.Today();
        
        //SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
        strack = [Select Id,DateOfExecution__c,Name,ScorecardGenerator__c from SPE_ScorecardTracker__c where ScorecardGenerator__c != Null AND Status__c = 'Pending' AND DateOfExecution__c =:d Limit 100];
        //strack.add(stt); 
                        
        
        SPE_ScoreCard__c score = new SPE_ScoreCard__c();
        score.Name = 'Test ScoreCard';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Approved';
        score.ScorecardTracker__c =stt.Id;
        score.StartDate__c = Date.newInstance(2015,12,1);
        score.EndDate__c = Date.newInstance(2016,12,15);
        score.AggregationType__c='Simple Average';
        score.AggregationRule__c= 'test rule1';
        score.IsAdhoc__c= true;
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
        score.Project__c = 'In Bharti 4G';        
        score.CategoryCluster__c = 'Indirect Procurement';
        score.CategoryGroup__c = 'Facility';
        score.Category__c = 'Facility Services';        
        score.BusinessUnit__c = 'Global Services';
        score.BusinessLine__c = 'Network Implementation';
        score.Product__c= 'Charging Gateway CG';
        score.IsAdhoc__c =True;
        insert score;
                       
        SPE_ScorecardValues__c sCdval = new SPE_ScorecardValues__c();
        sCdval.KPI__c=  kpiDefinition1.Id;
        sCdval.Score__c= 20.50;
        sCdval.ScoreCard__c = score.id;
        sCdval.SPE_Template_Name__c='abc';
        insert  sCdval ;
        
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
        screport.Start_Date__c= Date.newInstance(2016,1,15);
        screport.End_Date__c= Date.newInstance(2016,12,15);
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
        
        SPE_BWRuleConfigurator__c bwr = new SPE_BWRuleConfigurator__c();
        bwr.AveragingLogic__c= 'Simple Average';
        bwr.Category__c = 'Facility Services';
        bwr.CategoryArea__c = 'Indirect Procurement';
        bwr.CategoryGroup__c = 'Facility';
        bwr.Nego_Responsible__c= 'G';
        bwr.Country__c= 'INDIA';
        bwr.Market__c= 'INDIA';
        bwr.Market_Unit__c ='INDIA BHARTI';
        bwr.Project__c= 'In Bharti 4G';
        insert bwr;
        List<SPE_BWRuleConfigurator__c> bwrList = new List<SPE_BWRuleConfigurator__c>();
        bwrList.add(bwr);
       
        SPE_ScorecardTempValues__c sctv = new SPE_ScorecardTempValues__c();
        sctv.Group__c ='test group';
        sctv.KPI__c= kpiDefinition1.id;
        sctv.ScoreCard__c= score.id;
        sctv.SPE_Plan__c= spePlan.id;
        sctv.SPE_TemplateName__c= 'Test SPE TEmplate 123';
        sctv.SPETracker__c= trackerValue.id;
        sctv.Supplier__c = acc1.id;
        sctv.Tracker_Score__c = tScore.id;
        sctv.SPE_TemplateName__c ='ABCXYZ';
        sctv.Weight__c = 2;
        insert sctv;
    
        List<SPE_ScorecardTempValues__c> sctvList= new List<SPE_ScorecardTempValues__c>();
        sctvList.add(sctv);

        SPE_Volume__c vol = new SPE_Volume__c();
        vol.Category__c='All Categories'; 
        vol.CategoryCluster__c= 'All Category Areas';
        vol.Category_Group__c ='All Category Groups';
        vol.Country__c ='India';
        vol.EnterpriseID__c = acc1.id;
        vol.Period__c = Date.newInstance(2016,10,20);
        vol.Project__c ='All Project';
        vol.Region__c ='INDIA';
        vol.SPEPeriod__c= 'Test';
        vol.SubRegion__c = 'INDIA-IND';
        vol.SupplierName__c = acc1.Name;
        vol.Volume__c =2;
        insert vol;
        
         List<SPE_ScorecardTracker__c > scoretrackerList =[select id,ScorecardGenerator__c from SPE_ScorecardTracker__c where id=:score.ScorecardTracker__c];
         system.debug('scoretrackerList ::'+scoretrackerList);
         
         List<SPE_Scorecard_Plan__c > scorecardplanlist =[select id,SPE_Plan__c from SPE_Scorecard_Plan__c where Scorecard_Generator__c=:scoretrackerList[0].ScorecardGenerator__c];
         system.debug('scorecardplanlist:: '+scorecardplanlist);
         
          List<SPE_SPETracker__c> spetrackerList =[select id from SPE_SPETracker__c where SPEPlan__c =:scorecardplanlist[0].SPE_Plan__c 
                                                     and status__c='Completed' and DateOfExecution__c>=:score.StartDate__c 
                                                     and  DateOfExecution__c<=:score.EndDate__c];
          system.debug('spetrackerList ::'+spetrackerList);           
                
      //  update score;
    }
 }
 public static testmethod void SPE_ScorecardBWTest3(){

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
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
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
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
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
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';        
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
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.StartDate__c = Date.NewInstance(2015,12,01);
        spePlan.EndDate__c = Date.NewInstance(2016,12,01);
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
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
        speTracker.Status__c ='Completed';      
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
        //trackerValue.SPE_TemplateName__c = speTemp.id;
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
        scg.Name = 'Test Scorecard Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2015,12,2);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.isAdhoc__c =True;
        scg.IsAutoApproved__c =True;
        scg.isAutoDistributionON__c =True;
        scg.AggregationType__c ='Rules Driven Averaging';
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
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
    
        
        SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.CC_Contact1__c =con.id;
        ss.CC_Contact2__c =con.id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'February - 2016';
        stt.DateOfExecution__c = System.Today();
        //stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'DISTRIBUTED';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        Date d = System.Today();
        
        //SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
        strack = [Select Id,DateOfExecution__c,Name,ScorecardGenerator__c from SPE_ScorecardTracker__c where ScorecardGenerator__c != Null AND Status__c = 'Pending' AND DateOfExecution__c =:d Limit 100];
        //strack.add(stt); 
                        
        
        SPE_ScoreCard__c score = new SPE_ScoreCard__c();
        score.Name = 'Test ScoreCard';
        score.Approver__c = u.id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.Contact__c = ss.SupplierContact__c;
        score.CCContact1__c =ss.CC_Contact1__c;
        score.CCContact2__c =ss.CC_Contact2__c;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Approved';
        score.ScorecardTracker__c =stt.Id;
        score.StartDate__c = Date.newInstance(2015,12,2);
        score.EndDate__c = Date.newInstance(2016,12,15); 
        score.AggregationType__c='Rules Driven Averaging';
        score.AggregationRule__c= 'aggreagtion rule';
        score.Nego_Responsible__c ='nego responsible';
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
        score.Project__c = 'In Bharti 4G';        
        score.CategoryCluster__c = 'Indirect Procurement';
        score.CategoryGroup__c = 'Facility';
        score.Category__c = 'Facility Services';        
        score.BusinessUnit__c = 'Global Services';
        score.BusinessLine__c = 'Network Implementation';
        score.Product__c= 'Charging Gateway CG';
        insert score;
               
        SPE_ScorecardValues__c sCdval = new SPE_ScorecardValues__c();
        sCdval.KPI__c=  kpiDefinition1.Id;
        sCdval.Score__c= 20.50;
        sCdval.ScoreCard__c = score.id;
        sCdval.SPE_Template_Name__c='abc';
        insert  sCdval ;
        
        SPE_Report_Parameter__c screport = new SPE_Report_Parameter__c();
        screport.Region__c = 'INDIA';
        screport.SubRegion__c = 'INDIA BHARTI';
        screport.Country__c = 'INDIA';
        screport.Project__c = 'In Bharti 4G';        
        screport.CategoryCluster__c = 'Indirect Procurement';
        screport.Category_Group__c= 'Facility';
        screport.Category__c = 'Facility Services';        
        screport.Business_Unit__c = 'Global Services';
        screport.Business_Line__c= 'Network Implementation';
        screport.Product__c= 'Charging Gateway CG';
        screport.Aggregation_Type__c='Simple Average';
        screport.IsEmailSent__c= true;
        screport.useCacheReport__c= true;
        screport.Start_Date__c= Date.newInstance(2016,1,15);
        screport.End_Date__c= Date.newInstance(2016,12,15);
        insert screport;
                    
        List<Decimal> dcList = new  List<decimal>();
        Decimal dc =15.50;
        dcList.add(dc); 
               
        List<SPE_Scorecard_Report__c> scRptList = new List<SPE_Scorecard_Report__c>();
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
        scRptList.add(scRpt);
        insert scRptList;
        
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
        tsList.add(tScore);
        insert tsList;
        
        List<SPE_BWRuleConfigurator__c> bwrList = new List<SPE_BWRuleConfigurator__c>();
        SPE_BWRuleConfigurator__c bwr = new SPE_BWRuleConfigurator__c();
        bwr.AveragingLogic__c= 'Weighted Average by Spend';
        bwr.Market__c= 'INDIA';
        bwr.Market_Unit__c ='INDIA BHARTI';
        bwr.Country__c= 'INDIA';
        bwr.Project__c= 'In Bharti 4G';
        bwr.CategoryArea__c = 'Indirect Procurement';
        bwr.CategoryGroup__c = 'Facility';
        bwr.Category__c = 'Facility Services';       
        bwr.Nego_Responsible__c= 'G';                    
        bwrList.add(bwr);
        insert bwrList;
       
        List<SPE_ScorecardTempValues__c> sctvList= new List<SPE_ScorecardTempValues__c>();
        SPE_ScorecardTempValues__c sctv = new SPE_ScorecardTempValues__c();
        sctv.Group__c ='test group';
        sctv.KPI__c= kpiDefinition1.id;
        sctv.ScoreCard__c= score.id;
        sctv.SPE_Plan__c= spePlan.id;
        sctv.SPE_TemplateName__c= 'Test SPE TEmplate 123';
        sctv.SPETracker__c= trackerValue.id;
        sctv.Supplier__c = acc1.id;
        sctv.Tracker_Score__c = tScore.id;
        sctv.Weight__c = 2;         
        sctvList.add(sctv);
        insert sctvList;

        SPE_Volume__c vol = new SPE_Volume__c();
        vol.Category__c='All Categories'; 
        vol.CategoryCluster__c= 'All Category Areas';
        vol.Category_Group__c ='All Category Groups';
        vol.Country__c ='India';
        vol.EnterpriseID__c = acc1.id;
        vol.Period__c = Date.newInstance(2016,10,20);
        vol.Project__c ='All Project';
        vol.Region__c ='INDIA';
        vol.SPEPeriod__c= 'Test';
        vol.SubRegion__c = 'INDIA-IND';
        vol.SupplierName__c = acc1.Name;
        vol.Volume__c =2;
        insert vol;   
        
      //  insert score;
    } 
  }
  
  public static testmethod void SPE_ScorecardBWTest4()
    {
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
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
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
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 12334';
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
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';        
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
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.StartDate__c = Date.NewInstance(2015,12,01);
        spePlan.EndDate__c = Date.NewInstance(2016,12,01);
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
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
        speTracker.Status__c ='Completed';      
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
        //trackerValue.SPE_TemplateName__c = speTemp.id;
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
        scg.Name = 'Test Scorecard Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2015,12,2);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.isAdhoc__c =True;
        scg.IsAutoApproved__c =True;
        scg.isAutoDistributionON__c =True;
        scg.AggregationType__c ='Rules Driven Averaging';
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
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_Scorecard_Plan__c scorecardPlan = new SPE_Scorecard_Plan__c();
        scorecardPlan.Scorecard_Generator__c =scg.id;
        scorecardPlan.SPE_Plan__c =spePlan.id;
        insert scorecardPlan;
                    
        SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.CC_Contact1__c =con.id;
        ss.CC_Contact2__c =con.id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'February - 2016';
        stt.DateOfExecution__c = System.Today();
        //stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'DISTRIBUTED';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        Date d = System.Today();
        
        //SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
        strack = [Select Id,DateOfExecution__c,Name,ScorecardGenerator__c from SPE_ScorecardTracker__c where ScorecardGenerator__c != Null AND Status__c = 'Pending' AND DateOfExecution__c =:d Limit 100];
        //strack.add(stt); 
                        
        
        SPE_ScoreCard__c score = new SPE_ScoreCard__c();
        score.isAdhoc__c = false;
        score.Name = 'Test ScoreCard';
        score.Approver__c = u.id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.Contact__c = ss.SupplierContact__c;
        score.CCContact1__c =ss.CC_Contact1__c;
        score.CCContact2__c =ss.CC_Contact2__c;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Approved';
        score.ScorecardTracker__c =stt.Id;
        score.StartDate__c = System.Today().adddays(-160);
        score.EndDate__c = System.Today().adddays(160); 
        score.AggregationType__c='Rules Driven Averaging';
        score.AggregationRule__c= 'aggreagtion rule';
        score.Nego_Responsible__c ='nego responsible';
        score.Region__c = 'All Markets';
        score.SubRegion__c = 'All Market Units';
        score.Country__c = 'All Countries';
        score.Project__c = 'All Projects';        
        score.CategoryCluster__c = 'All Category Areas';
        score.CategoryGroup__c = 'All Category Groups';
        score.Category__c = 'All Categories';
        score.BusinessUnit__c = 'All Business Units';
        score.BusinessLine__c = 'All Business Lines';
        score.Product__c = 'All Products';  
        insert score;
      }    
    }
}