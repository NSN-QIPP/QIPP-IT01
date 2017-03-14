@isTest(SeeAllData = False)

public class SPE_ScorecardTriggerTest{

public static testmethod void SPE_ScorecardTriggerTest(){
        
        Test.startTest();
                               
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Test Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'All Business Unit';
        picklistObj.Business_Line__c = 'All Business Line';        
        picklistObj.Project__c = 'All Project';
        
        picklistObj.Category_Area__c =  'All Category Area' ;
        picklistObj.Category_Group__c = 'All Category Group';
        picklistObj.Category__c =  'All Category';               
        
        picklistObj.Market__c = 'All CO Region';
        picklistObj.Market_Unit__c = 'All CO Subregion';
        picklistObj.Country__c = 'All CO Country' ;       
        picklistObj.Product__c = 'All Product' ;
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;        
             
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u; 
            
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
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
        
        SPE_WeightageLogic__c WtLogic = new SPE_WeightageLogic__c();
        WtLogic.Name= 'WeightLogic';
        WtLogic.Category__c='All Category'; 
        WtLogic.CategoryCluster__c= 'All Category Area' ;
        WtLogic.CategoryGroup__c = 'All Category Group';
        WtLogic.Logic__c= 'Logic-2' ;
        WtLogic.Index__c= 2;
        insert WtLogic;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        //**********************Changes For Encryption******************// 
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        //PIDefObj.Name = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
                
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 12334';
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition2.Level__c = '1';
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        kpiDefinition2.Description__c = 'Test';
        kpiDefinition2.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition2.OperationalType__c = 'Leading PI';
        kpiDefinition2.GeoScope__c = 'All CO Region';
        kpiDefinition2.categoryscope__c = 'All Category';
        kpiDefinition2.BUScope__c = 'All Product';
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
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic-2';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All CO Region';
        kpiDefinition1.categoryscope__c = 'All Category';
        kpiDefinition1.BUScope__c = 'All Product';
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
        
        kpiValue.Region__c = 'All CO Region';
        kpiValue.SubRegion__c = 'All CO Subregion';
        kpiValue.Country__c = 'All CO Country';
        kpiValue.Project__c = 'All Project';
        
        kpiValue.Cluster__c = 'All Category Area';
        kpiValue.CategoryGroup__c = 'All Category Group';
        kpiValue.Category__c = 'All Category' ;
        
        kpiValue.BusinessUnit__c ='All Business Unit';
        kpiValue.BusinessLine__c ='All Business Line';       
        kpiValue.Product__c = 'All Product';
        insert kpiValue;     
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'All CO Region';
        speTemp.SubRegion__c = 'All CO Subregion';
        speTemp.Country__c = 'All CO Country';
        speTemp.Project__c = 'All Project';
        
        speTemp.CategoryCluster__c = 'All Category Area';
        speTemp.CategoryGroup__c = 'All Category Group';
        speTemp.Category__c ='All Category';
        
        speTemp.BusinessUnit__c ='All Business Unit';
        speTemp.BusinessLine__c ='All Business Line';      
        speTemp.Product__c = 'All Product'; 
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
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'February - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All CO Region';
        speTracker.SubRegion__c ='All CO Subregion';
        speTracker.Country__c = 'All CO Country';
        speTracker.Project__c ='All Project' ;
        
        speTracker.CategoryCluster__c ='All Category Area';
        speTracker.CategoryGroup__c = 'All Category Group';
        speTracker.Category__c = 'All Category';
        
        speTracker.BusinessUnit__c = 'All Business Unit' ;
        speTracker.BusinessLine__c ='All Business Line';      
        speTracker.Product__c = 'All Product';
        
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic-2';
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
        scg.StartDate__c = Date.newInstance(2016,2,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'All CO Region';
        scg.SubRegion__c = 'All CO Subregion';
        scg.Country__c = 'All CO Country';
        scg.Project__c = 'All Project';
        
        scg.CategoryCluster__c = 'All Category Area';
        scg.CategoryGroup__c = 'All Category Group';
        scg.Category__c = 'All Category';
        
        scg.BusinessUnit__c = 'All Business Unit';
        scg.BusinessLine__c = 'All Business Line';
        scg.Product__c = 'All Product';
        
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
        stt.DateOfExecution__c = Date.newInstance(2016,2,15);
        stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'Pending';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        //SPE_ScorecardTracker__c stt = new SPE_ScorecardTracker__c();
        List<SPE_ScorecardTracker__c> strack = new List<SPE_ScorecardTracker__c>();
        //stt = [Select Id from SPE_ScorecardTracker__c where ScorecardGenerator__c =: scg.Id AND Status__c = 'Pending' Limit 1];
        strack.add(stt);
        List<SPE_ScoreCard__c> scoreCardLst = new   List<SPE_ScoreCard__c>();                                        
        SPE_ScoreCard__c score = new SPE_ScoreCard__c();
        score.Name = 'Test ScoreCard';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Pending';
        score.ScorecardTracker__c = stt.Id;
        score.StartDate__c= Date.newInstance(2016,2,15);
        score.EndDate__c= Date.newInstance(2016,3,14);
        
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
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
        insert score;
        
        try
        {
            score.Stage__c = 'Approved';
            update score; 
            
            
        }catch(Exception ex){}
        scoreCardLst.add(score);
        //insert scoreCardLst;       
                     
        ScorecardKPIMap__c scKpiM = new ScorecardKPIMap__c();
        scKpiM.KPI__c= kpiDefinition1.id;
        scKpiM.KPITarget__c= 1;
        scKpiM.KPIValue__c=1;
        scKpiM.Score__c=1;
        scKpiM.ScoreCard__c= score.id;
        scKpiM.SPETemplate__c= speTemp.id;
        scKpiM.SPETemplateWeight__c=1;
        
        insert scKpiM ;
   
        /*SPE_WeightageLogic__c wtt = new SPE_WeightageLogic__c();
        wtt = WtLogic;
        insert wtt;
        
        SPE_Comparableinterface scom = new SPE_Comparableinterface(WtLogic,'Index__c');*/
        
        SPE_ScorecardTrigger theClass = new SPE_ScorecardTrigger(scoreCardLst);
                        
        Test.stopTest(); 
}
}