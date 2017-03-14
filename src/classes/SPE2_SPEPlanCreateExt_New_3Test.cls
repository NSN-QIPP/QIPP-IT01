@isTest(SeeAllData = false)
public class SPE2_SPEPlanCreateExt_New_3Test{       
     static testMethod void SPE2_SPEPlanCreateExt_New_3Test1() 
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

        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Filter for Spend and Volume';
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
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        lstPIDefObj[i].DataAcquisitionMethod__c ='Data Load';
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
       
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c= 'aAtos11';
        spePlan.AutoTicket__c= 'OFF';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c= 'All Business Lines';  
        spePlan.BusinessUnit__c= 'All Business Units';
        spePlan.Category__c='All Categories'; 
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c= 'All Category Groups';
        spePlan.CM__c= con.id;
        //spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='All Countries';  
        spePlan.EndDate__c= Date.newinstance(2025,01,20);
        spePlan.FrequencyInMonths__c='1';
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Organization_Group__c = 'Indirect Procurement';
        spePlan.PPM1__c= CCcon1.id;
        spePlan.Product__c='All Products';
        spePlan.Project__c='All Projects';
        spePlan.StartDate__c= Date.newinstance(2020,01,20);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        spePlan.Stage__c = 'Published';
        spePlan.SPEDomain__c= 'test spe Domain';   
        spePlan.Ad_Hoc_Plan__c = false;
        spePlan.End_Month__c = 'January';
        spePlan.End_Year__c = '2025'; 
        insert spePlan;  
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        speRespondent.SPEPlan__c = spePlan.id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
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
   
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);
        
        Apexpages.currentpage().getparameters().put('rerenderForm11','rerenderForm11');
        Apexpages.currentpage().getparameters().put('cgVal','cgVal');  
        Apexpages.currentpage().getparameters().put('caVal','caVal'); 
        Apexpages.currentpage().getparameters().put('marketVal','marketVal');  
        Apexpages.currentpage().getparameters().put('marketUnitVal','marketUnitVal');
        Apexpages.currentpage().getparameters().put('countryVal','countryVal');   
        Apexpages.currentpage().getparameters().put('buVal','buVal');   
        Apexpages.currentpage().getparameters().put('blVal','blVal'); 
               
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE2_SPEPlanCreateExt_New_3 scGen= new SPE2_SPEPlanCreateExt_New_3(stCon);
        scGen.closePopup();
        //scGen.startDate = Date.newInstance(2016,10,20);
        Apexpages.currentpage().getparameters().put('isClone','true');
        scGen.continueCustom();// scGen.checkValidation();
        //scGen.generateTracker();
        scGen.getMarketValues();
        //scGen.getMarketUnitValues();
        //scGen.fillMarketUnit();
        scGen.getCountryValues();
        scGen.getProjectValues();
        scGen.fillProject();
        scGen.getBusinessUnitValues();
        //scGen.getBusinesLineValues();
        //scGen.fillBusinessLine();
        scGen.getProductValues();
        scGen.fillProduct();
        scGen.showProdVals();
        scGen.getCategoryAreaValues();
        //scGen.getCategoryGroupValues();
        //scGen.fillCategoryGroup();
        scGen.getCategoryValues();
        scGen.fillCategory();
        scGen.blankMethod();
        scGen.save();
       // Apexpages.currentpage().getparameters().put('isClone','true');
        scGen.continueCustom();// scGen.checkValidation();
        scGen.createSPETracker(spePlan, true);
        scGen.scopeMatch();
        scGen.ScopeChange();
        scGen.DisplayRecurrence();
        Test.StopTest();              
       }
    } 
    
    static testmethod void SPE2_SPEPlanCreateExt_New_3_Test2(){
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

        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Filter for Spend and Volume';
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
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        lstPIDefObj[i].DataAcquisitionMethod__c ='Data Load';
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
       
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.AutoTicket__c= 'OFF';
        //spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c= 'All Business Lines';  
        spePlan.BusinessUnit__c= 'All Business Units';
        spePlan.Category__c='All Categories'; 
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c= 'All Category Groups';
        spePlan.CM__c= con.id;
        //spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='All Countries';  
        spePlan.EndDate__c= Date.newinstance(2025,01,20);
        spePlan.FrequencyInMonths__c='0';
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Organization_Group__c='Indirect Procurement';
        spePlan.PPM1__c= CCcon1.id;
        spePlan.Product__c='All Products';
        spePlan.Project__c='All Projects';
        spePlan.StartDate__c= Date.newinstance(2020,01,20);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        spePlan.Stage__c = 'Published';
        spePlan.SPEDomain__c= 'test spe Domain';   
        spePlan.Ad_Hoc_Plan__c = true;
       // spePlan.End_Month__c = 'January';
       // spePlan.End_Year__c = '2025'; 
        insert spePlan;  
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        //speRespondent.Email__c =
        speRespondent.SPEPlan__c = spePlan.id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
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
   
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('rerenderForm11','rerenderForm11');
        Apexpages.currentpage().getparameters().put('cgVal','cgVal');  
        Apexpages.currentpage().getparameters().put('caVal','caVal'); 
        Apexpages.currentpage().getparameters().put('marketVal','marketVal');  
        Apexpages.currentpage().getparameters().put('marketUnitVal','marketUnitVal');
        Apexpages.currentpage().getparameters().put('countryVal','countryVal');   
        Apexpages.currentpage().getparameters().put('buVal','buVal');   
        Apexpages.currentpage().getparameters().put('blVal','blVal'); 
               
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE2_SPEPlanCreateExt_New_3 scGen= new SPE2_SPEPlanCreateExt_New_3(stCon);
        scGen.closePopup();
        //scGen.startDate = Date.newInstance(2016,10,20);
        scGen.continueCustom();
        scGen.getMarketValues();
        //scGen.getMarketUnitValues();
        //scGen.fillMarketUnit();
        scGen.getCountryValues();
        scGen.getProjectValues();
        scGen.fillProject();
        scGen.getBusinessUnitValues();
        //scGen.getBusinesLineValues();
        //scGen.fillBusinessLine();
        scGen.getProductValues();
        scGen.fillProduct();
        scGen.showProdVals();
        scGen.getCategoryAreaValues();
        //scGen.getCategoryGroupValues();
        //scGen.fillCategoryGroup();
        scGen.getCategoryValues();
        scGen.fillCategory();
        scGen.blankMethod();
        scGen.save();
        scGen.checkValidation();
        //scGen.generateTracker();
        scGen.createSPETracker(spePlan, true);
        scGen.scopeMatch();
        scGen.ScopeChange();
        scGen.DisplayRecurrence();
        Test.StopTest();              
       }
    } 
    static testmethod void SPE2_SPEPlanCreateExt_New_3_Test3(){
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

        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Filter for Spend and Volume';
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
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        lstPIDefObj[i].DataAcquisitionMethod__c ='Data Load';
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
       
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c= 'aAtos11';
        spePlan.AutoTicket__c= 'OFF';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c= 'All Business Lines';  
        spePlan.BusinessUnit__c= 'All Business Units';
        spePlan.Category__c='All Categories'; 
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c= 'All Category Groups';
        spePlan.CM__c= con.id;
        //spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='All Countries';  
        spePlan.EndDate__c= Date.newinstance(2025,01,20);
        spePlan.FrequencyInMonths__c='1';
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Organization_Group__c = 'Indirect Procurement';
        spePlan.PPM1__c= CCcon1.id;
        spePlan.Product__c='All Products';
        spePlan.Project__c='All Projects';
        spePlan.StartDate__c= Date.newinstance(2020,01,20);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        spePlan.Stage__c = 'Published';
        spePlan.SPEDomain__c= 'test spe Domain';   
        spePlan.Ad_Hoc_Plan__c = false;
        spePlan.End_Month__c = 'January';
        spePlan.End_Year__c = '2025'; 
        insert spePlan;  
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        //speRespondent.Email__c =
        speRespondent.SPEPlan__c = spePlan.id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
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
   
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('isClone','abcd');
        Apexpages.currentpage().getparameters().put('rerenderForm11','rerenderForm11');
        Apexpages.currentpage().getparameters().put('cgVal','cgVal');  
        Apexpages.currentpage().getparameters().put('caVal','caVal'); 
        Apexpages.currentpage().getparameters().put('marketVal','marketVal');  
        Apexpages.currentpage().getparameters().put('marketUnitVal','marketUnitVal');
        Apexpages.currentpage().getparameters().put('countryVal','countryVal');   
        Apexpages.currentpage().getparameters().put('buVal','buVal');   
        Apexpages.currentpage().getparameters().put('blVal','blVal'); 
               
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(new SPE_SPEPlan__c());
        SPE2_SPEPlanCreateExt_New_3 scGen= new SPE2_SPEPlanCreateExt_New_3(stCon);
        scGen.closePopup();     
       // scGen.continueCustom();
        scGen.getMarketValues();
        //scGen.getMarketUnitValues();
        //scGen.fillMarketUnit();
        scGen.getCountryValues();
        scGen.getProjectValues();
        scGen.fillProject();
        scGen.getBusinessUnitValues();
        //scGen.getBusinesLineValues();
        //scGen.fillBusinessLine();
        scGen.getProductValues();
        scGen.fillProduct();
        scGen.showProdVals();
        scGen.getCategoryAreaValues();
        //scGen.getCategoryGroupValues();
        //scGen.fillCategoryGroup();
        scGen.getCategoryValues();
        scGen.fillCategory();
        scGen.blankMethod();
        scGen.save();
        //scGen.checkValidation();
        //scGen.generateTracker();
        scGen.createSPETracker(spePlan, true);
        scGen.scopeMatch();
        scGen.ScopeChange();
        scGen.DisplayRecurrence();
        Test.StopTest();              
       }
    }  
    static testmethod void SPE2_SPEPlanCreateExt_New_3_Test4(){
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

        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Filter for Spend and Volume';
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
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        lstPIDefObj[i].DataAcquisitionMethod__c ='Data Load';
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
       
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c= 'aAtos11';
        spePlan.AutoTicket__c= 'OFF';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c= 'All Business Lines';  
        spePlan.BusinessUnit__c= 'All Business Units';
        spePlan.Category__c='All Categories'; 
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c= 'All Category Groups';
        spePlan.CM__c= con.id;
        //spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='All Countries';  
        spePlan.EndDate__c= Date.newinstance(2025,01,20);
        spePlan.FrequencyInMonths__c='1';
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Organization_Group__c = 'Indirect Procurement';
        spePlan.PPM1__c= CCcon1.id;
        spePlan.Product__c='All Products';
        spePlan.Project__c='All Projects';
        spePlan.StartDate__c= Date.newinstance(2020,01,20);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        spePlan.Stage__c = 'Published';
        spePlan.SPEDomain__c= 'test spe Domain';   
        spePlan.Ad_Hoc_Plan__c = false;
        spePlan.End_Month__c = 'January';
        spePlan.End_Year__c = '2025'; 
        insert spePlan;  
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        speRespondent.SPEPlan__c = spePlan.id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
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
   
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('isClone','abcd');
        Apexpages.currentpage().getparameters().put('rerenderForm11','rerenderForm11');
        Apexpages.currentpage().getparameters().put('cgVal','cgVal');  
        Apexpages.currentpage().getparameters().put('caVal','caVal'); 
        Apexpages.currentpage().getparameters().put('marketVal','marketVal');  
        Apexpages.currentpage().getparameters().put('marketUnitVal','marketUnitVal');
        Apexpages.currentpage().getparameters().put('countryVal','countryVal');   
        Apexpages.currentpage().getparameters().put('buVal','buVal');   
        Apexpages.currentpage().getparameters().put('blVal','blVal'); 
               
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE2_SPEPlanCreateExt_New_3 scGen= new SPE2_SPEPlanCreateExt_New_3(stCon);
        scGen.closePopup();
        //scGen.startDate = Date.newInstance(2016,10,20);
        scGen.continueCustom();
        //scGen.generateTracker();
        scGen.getMarketValues();
        //scGen.getMarketUnitValues();
        //scGen.fillMarketUnit();
        scGen.getCountryValues();
        scGen.getProjectValues();
        scGen.fillProject();
        scGen.getBusinessUnitValues();
        //scGen.getBusinesLineValues();
        //scGen.fillBusinessLine();
        scGen.getProductValues();
        scGen.fillProduct();
        scGen.showProdVals();
        scGen.getCategoryAreaValues();
        //scGen.getCategoryGroupValues();
        //scGen.fillCategoryGroup();
        scGen.getCategoryValues();
        scGen.fillCategory();
        scGen.blankMethod();
        scGen.save();
        scGen.checkValidation();
        scGen.createSPETracker(spePlan, true);
        scGen.scopeMatch();
        scGen.ScopeChange();
        scGen.DisplayRecurrence();
        Test.StopTest();              
       }
    } 
     static testmethod void SPE2_SPEPlanCreateExt_New_3_Test5(){
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

        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Filter for Spend and Volume';
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
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        lstPIDefObj[i].DataAcquisitionMethod__c ='Data Load';
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
       
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c= 'aAtos11';
        spePlan.AutoTicket__c= 'OFF';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c= 'All Business Lines';  
        spePlan.BusinessUnit__c= 'All Business Units';
        spePlan.Category__c='All Categories'; 
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c= 'All Category Groups';
        spePlan.CM__c= con.id;
        //spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='All Countries';  
        spePlan.EndDate__c= Date.newinstance(2025,01,20);
        spePlan.FrequencyInMonths__c='1';
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Organization_Group__c = '';
        spePlan.PPM1__c= CCcon1.id;
        spePlan.Product__c='All Products';
        spePlan.Project__c='All Projects';
        spePlan.StartDate__c= Date.newinstance(2020,01,20);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        spePlan.Stage__c = 'Published';
        spePlan.SPEDomain__c= 'test spe Domain'; 
        spePlan.Next_Computed_Day__c = Date.newinstance(2020,01,21);
        spePlan.Additional_Days__c = 1 ; 
        spePlan.Ad_Hoc_Plan__c = false;
        spePlan.End_Month__c = '';
        spePlan.End_Year__c = ''; 
        insert spePlan;  
                      
        SPE_Respondent__c speRespondent = new SPE_Respondent__c();
        speRespondent.Contact__c = con.id;
        speRespondent.SPEPlan__c = spePlan.id;
        insert speRespondent;              
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'January - 2020'; 
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
   
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);
        //Apexpages.currentpage().getparameters().put('isClone','abcd');
        Apexpages.currentpage().getparameters().put('rerenderForm11','rerenderForm11');
        Apexpages.currentpage().getparameters().put('cgVal','cgVal');  
        Apexpages.currentpage().getparameters().put('caVal','caVal'); 
        Apexpages.currentpage().getparameters().put('marketVal','marketVal');  
        Apexpages.currentpage().getparameters().put('marketUnitVal','marketUnitVal');
        Apexpages.currentpage().getparameters().put('countryVal','countryVal');   
        Apexpages.currentpage().getparameters().put('buVal','buVal');   
        Apexpages.currentpage().getparameters().put('blVal','blVal'); 
               
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE2_SPEPlanCreateExt_New_3 scGen= new SPE2_SPEPlanCreateExt_New_3(stCon);
        scGen.closePopup();
        //scGen.startDate = Date.newInstance(2016,10,20);
       // scGen.continueCustom();
        //scGen.generateTracker();
        scGen.getMarketValues();
        //scGen.getMarketUnitValues();
        //scGen.fillMarketUnit();
        scGen.getCountryValues();
        scGen.getProjectValues();
        scGen.fillProject();
        scGen.getBusinessUnitValues();
        //scGen.getBusinesLineValues();
        //scGen.fillBusinessLine();
        scGen.getProductValues();
        scGen.fillProduct();
        scGen.showProdVals();
        scGen.getCategoryAreaValues();
        //scGen.getCategoryGroupValues();
        //scGen.fillCategoryGroup();
        scGen.getCategoryValues();
        scGen.fillCategory();
        scGen.blankMethod();
        scGen.save();
        scGen.checkValidation();
        scGen.createSPETracker(spePlan, true);
        scGen.scopeMatch();
        scGen.ScopeChange();
        scGen.DisplayRecurrence();
        Test.StopTest();              
       }
    }  
    
    static testMethod void SPE2_SPEPlanCreateExt_New_3Test8() 
      {
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'NA';
        picklistObj.Business_Unit__c = 'NA';
        picklistObj.Category_Area__c = 'NA';
        picklistObj.Category_Group__c = 'NA';
        picklistObj.Category__c = 'NA';
        picklistObj.Country__c = 'NA';
        picklistObj.Market_Unit__c = 'NA';
        picklistObj.Market__c = 'NA';
        picklistObj.Name = 'NA';
        picklistObj.Product__c = 'NA';
        picklistObj.Project__c = 'NA';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
    
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
     
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
        kpiDefinition1.ActualCalculation__c= 'A+B+C'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
              
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
   
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
                   
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c = 'NAM';
        sctemp.SubRegion__c = 'NAM US';
        sctemp.Country__c = 'United States of America';
        sctemp.Project__c = 'US Cellular';
        sctemp.CategoryCluster__c= 'Product Procurement';
        sctemp.CategoryGroup__c = 'Mechanics';
        sctemp.Category__c = 'Sheet Metal Parts';
        sctemp.BusinessUnit__c ='Global Service';
        sctemp.BusinessLine__c ='Care';      
        sctemp.Product__c = 'PTF';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
                     
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
        spePlan.EndDate__c = System.today().addMonths(1);   
      // spePlan.StartDate__c = System.today().addDays(1);
       
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
       // spePlan.Start_Month__c ='July';
       // spePlan.Start_Year__c ='2016';
        spePlan.End_Month__c ='December';
        spePlan.End_Year__c ='2016';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Additional_Days__c =1;
        spePlan.Stage__c ='Draft';
        spePlan.Ad_Hoc_Plan__c = true;
      //  spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlan;
        
        /*SPE_SPEPlan__c spePlanCloned = SPE_TestObjectCreator.CreateSPEPlan();
        spePlanCloned.SPEScoringTemplate__c= sctemp.Id;         
      //  spePlan.EndDate__c = System.today().addMonths(4);   
       // spePlan.StartDate__c = System.today().addDays(1);
      //  spePlanCloned.SPETemplate__c = speTemplate.Id;                
        spePlanCloned.Organization_Group__c = 'Services Procurement';         
        spePlanCloned.SurveyExecutionBeforeIndays__c = 5;        
        spePlanCloned.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlanCloned.FrequencyInMonths__c = '1';
        spePlanCloned.SPEPlanName__c = 'New Demo Plan 122 Clone';  
        spePlanCloned.Region__c = 'NAM';
        spePlanCloned.SubRegion__c = 'NAM US';
        spePlanCloned.Country__c = 'United States of America';
        spePlanCloned.Project__c = 'US Cellular';
        spePlanCloned.CategoryCluster__c = 'Product Procurement';
        spePlanCloned.CategoryGroup__c = 'Mechanics';
        spePlanCloned.Category__c = 'Sheet Metal Parts';
        spePlanCloned.BusinessUnit__c ='Global Service';
        spePlanCloned.BusinessLine__c ='Care';      
        spePlanCloned.Product__c = 'PTF';
        spePlanCloned.Start_Month__c ='July';
        spePlanCloned.Start_Year__c ='2016';
        spePlanCloned.End_Month__c ='December';
        spePlanCloned.End_Year__c ='2016';
        spePlanCloned.AggregationDuration__c  = '1'; 
        spePlanCloned.Additional_Days__c =1;
        spePlanCloned.Stage__c ='Draft';
        spePlan.Ad_Hoc_Plan__c = true;
       // spePlanCloned.Ad_Hoc_Plan__c =true;
      //  spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlanCloned;
        
        spePlanCloned.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlanCloned;*/
        
       /* SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'June - 2016'; 
        speTracker.SPETemplate__c = speTemplate.Id; 
        speTracker.SPEPlan__c = spePlanCloned.Id;
        speTracker.DateOfExecution__c = System.Today();
        speTracker.Region__c = 'NAM';
        speTracker.SubRegion__c = 'NAM US';
        speTracker.Country__c = 'United States of America';
        speTracker.Project__c = 'US Cellular';
        speTracker.CategoryCluster__c = 'Product Procurement';
        speTracker.CategoryGroup__c = 'Mechanics';
        speTracker.Category__c = 'Sheet Metal Parts';
        speTracker.BusinessUnit__c ='Global Service';
        speTracker.BusinessLine__c ='Care';      
        speTracker.Product__c = 'PTF';
        speTracker.Status__c='Pending';
       // speTracker.Contact__c= con.id;
      //  speTracker.ForceSurvey__c =true;
       // speTracker.isContainsSurveyBasedPI__c = true;
       // speTracker.PilotTestDataCheck__c = true;
       // speTracker.SendSurveyLink__c= true;
       // insert speTracker;
        
        SPE_SPEPlanSupplierMap__c suppliermap = new SPE_SPEPlanSupplierMap__c();
        suppliermap.SPEPlan__c =spePlanCloned.id;
        suppliermap.Supplier__c=acc1.id;
        insert suppliermap;
        
        SPE_Respondent__c respondent =new SPE_Respondent__c();
        respondent.SPEPlan__c =spePlanCloned.id;
        insert respondent;*/ 
        
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);  
        //pageRef.getParameters().put('isClone','true');
       // pageRef.getParameters().put('speTempId', speTemplate.Id);
       // pageRef.getParameters().put('Id', spePlanCloned.Id);
        pageRef.getParameters().put('cgVal','Mechanics');
        pageRef.getParameters().put('caVal','Product Procurement');
        pageRef.getParameters().put('buVal','Global Service');
        pageRef.getParameters().put('marketVal','NAM');
        pageRef.getParameters().put('marketUnitVal','NAM US');
        pageRef.getParameters().put('countryVal','United States of America');
        pageRef.getParameters().put('blVal','Care');
        pageRef.getParameters().put('ctVal','Sheet Metal Parts');
        pageRef.getParameters().put('projectVal','US Cellular');
        pageRef.getParameters().put('prdVal','PTF');
        pageRef.getParameters().put('rerenderForm11','test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New_3 spe2PlanExt = new SPE2_SPEPlanCreateExt_New_3(stCon);
        
        spe2PlanExt.getMarketValues();
      //  spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
      //  spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();   
        spe2PlanExt.ScopeChange();    
        spe2PlanExt.closePopup();
      //  spe2PlanExt.continueCustom();
       // spe2PlanExt.checkValidation();
        spe2PlanExt.save();
        //spe2PlanExt.scopeMatch();
         
        
        //spe2PlanExt.generateTracker();
       // spe2PlanExt.blankMethod();
        Test.StopTest();
    }  
    static testMethod void SPE2_SPEPlanCreateExt_New_3Test9() 
      {
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'NA';
        picklistObj.Business_Unit__c = 'NA';
        picklistObj.Category_Area__c = 'NA';
        picklistObj.Category_Group__c = 'NA';
        picklistObj.Category__c = 'NA';
        picklistObj.Country__c = 'NA';
        picklistObj.Market_Unit__c = 'NA';
        picklistObj.Market__c = 'NA';
        picklistObj.Name = 'NA';
        picklistObj.Product__c = 'NA';
        picklistObj.Project__c = 'NA';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
    
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
     
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2016,08,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A+B+C'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
              
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
   
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
                   
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c = 'NAM';
        sctemp.SubRegion__c = 'NAM US';
        sctemp.Country__c = 'United States of America';
        sctemp.Project__c = 'US Cellular';
        sctemp.CategoryCluster__c= 'Product Procurement';
        sctemp.CategoryGroup__c = 'Mechanics';
        sctemp.Category__c = 'Sheet Metal Parts';
        sctemp.BusinessUnit__c ='Global Service';
        sctemp.BusinessLine__c ='Care';      
        sctemp.Product__c = 'PTF';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
                     
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
       // spePlan.EndDate__c = System.today().addMonths(1);   
        spePlan.StartDate__c = System.today().addDays(1);       
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.Start_Month__c ='July';
        spePlan.Start_Year__c ='2016';
      //  spePlan.End_Month__c ='December';
       // spePlan.End_Year__c ='2016';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Additional_Days__c =1;
        spePlan.Stage__c ='Draft';
        spePlan.Ad_Hoc_Plan__c = true;
      //  spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlan;
        
        /*SPE_SPEPlan__c spePlanCloned = SPE_TestObjectCreator.CreateSPEPlan();
        spePlanCloned.SPEScoringTemplate__c= sctemp.Id;         
      //  spePlan.EndDate__c = System.today().addMonths(4);   
       // spePlan.StartDate__c = System.today().addDays(1);
      //  spePlanCloned.SPETemplate__c = speTemplate.Id;                
        spePlanCloned.Organization_Group__c = 'Services Procurement';         
        spePlanCloned.SurveyExecutionBeforeIndays__c = 5;        
        spePlanCloned.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlanCloned.FrequencyInMonths__c = '1';
        spePlanCloned.SPEPlanName__c = 'New Demo Plan 122 Clone';  
        spePlanCloned.Region__c = 'NAM';
        spePlanCloned.SubRegion__c = 'NAM US';
        spePlanCloned.Country__c = 'United States of America';
        spePlanCloned.Project__c = 'US Cellular';
        spePlanCloned.CategoryCluster__c = 'Product Procurement';
        spePlanCloned.CategoryGroup__c = 'Mechanics';
        spePlanCloned.Category__c = 'Sheet Metal Parts';
        spePlanCloned.BusinessUnit__c ='Global Service';
        spePlanCloned.BusinessLine__c ='Care';      
        spePlanCloned.Product__c = 'PTF';
        spePlanCloned.Start_Month__c ='July';
        spePlanCloned.Start_Year__c ='2016';
        spePlanCloned.End_Month__c ='December';
        spePlanCloned.End_Year__c ='2016';
        spePlanCloned.AggregationDuration__c  = '1'; 
        spePlanCloned.Additional_Days__c =1;
        spePlanCloned.Stage__c ='Draft';
        spePlan.Ad_Hoc_Plan__c = true;
       // spePlanCloned.Ad_Hoc_Plan__c =true;
      //  spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlanCloned;
        
        spePlanCloned.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlanCloned;*/
        
       /* SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'June - 2016'; 
        speTracker.SPETemplate__c = speTemplate.Id; 
        speTracker.SPEPlan__c = spePlanCloned.Id;
        speTracker.DateOfExecution__c = System.Today();
        speTracker.Region__c = 'NAM';
        speTracker.SubRegion__c = 'NAM US';
        speTracker.Country__c = 'United States of America';
        speTracker.Project__c = 'US Cellular';
        speTracker.CategoryCluster__c = 'Product Procurement';
        speTracker.CategoryGroup__c = 'Mechanics';
        speTracker.Category__c = 'Sheet Metal Parts';
        speTracker.BusinessUnit__c ='Global Service';
        speTracker.BusinessLine__c ='Care';      
        speTracker.Product__c = 'PTF';
        speTracker.Status__c='Pending';
       // speTracker.Contact__c= con.id;
      //  speTracker.ForceSurvey__c =true;
       // speTracker.isContainsSurveyBasedPI__c = true;
       // speTracker.PilotTestDataCheck__c = true;
       // speTracker.SendSurveyLink__c= true;
       // insert speTracker;
        
        SPE_SPEPlanSupplierMap__c suppliermap = new SPE_SPEPlanSupplierMap__c();
        suppliermap.SPEPlan__c =spePlanCloned.id;
        suppliermap.Supplier__c=acc1.id;
        insert suppliermap;
        
        SPE_Respondent__c respondent =new SPE_Respondent__c();
        respondent.SPEPlan__c =spePlanCloned.id;
        insert respondent;*/ 
        
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);  
        //pageRef.getParameters().put('isClone','true');
       // pageRef.getParameters().put('speTempId', speTemplate.Id);
       // pageRef.getParameters().put('Id', spePlanCloned.Id);
        pageRef.getParameters().put('cgVal','Mechanics');
        pageRef.getParameters().put('caVal','Product Procurement');
        pageRef.getParameters().put('buVal','Global Service');
        pageRef.getParameters().put('marketVal','NAM');
        pageRef.getParameters().put('marketUnitVal','NAM US');
        pageRef.getParameters().put('countryVal','United States of America');
        pageRef.getParameters().put('blVal','Care');
        pageRef.getParameters().put('ctVal','Sheet Metal Parts');
        pageRef.getParameters().put('projectVal','US Cellular');
        pageRef.getParameters().put('prdVal','PTF');
        pageRef.getParameters().put('rerenderForm11','test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New_3 spe2PlanExt = new SPE2_SPEPlanCreateExt_New_3(stCon);
        
        spe2PlanExt.getMarketValues();
      //  spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
      //  spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();   
        spe2PlanExt.ScopeChange();    
        spe2PlanExt.closePopup();
      //  spe2PlanExt.continueCustom();
       // spe2PlanExt.checkValidation();
        spe2PlanExt.save();
        //spe2PlanExt.scopeMatch();
         
        
        //spe2PlanExt.generateTracker();
       // spe2PlanExt.blankMethod();
        Test.StopTest();
    }  
    static testMethod void SPE2_SPEPlanCreateExt_New_3Test10() 
      {
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'NA';
        picklistObj.Business_Unit__c = 'NA';
        picklistObj.Category_Area__c = 'NA';
        picklistObj.Category_Group__c = 'NA';
        picklistObj.Category__c = 'NA';
        picklistObj.Country__c = 'NA';
        picklistObj.Market_Unit__c = 'NA';
        picklistObj.Market__c = 'NA';
        picklistObj.Name = 'NA';
        picklistObj.Product__c = 'NA';
        picklistObj.Project__c = 'NA';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
    
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
     
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2016,08,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A+B+C'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
              
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='All Business Lines';
        threshold.BusinessUnit__c= 'All Business Units';
        threshold.Category__c ='All Categories';
        threshold.CategoryCluster__c= 'All Category Areas';
        threshold.CategoryGroup__c ='All Category Groups';
        threshold.Country__c= 'All Countries';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='All Markets';
        threshold.SubRegion__c= 'All Market Units';
        threshold.Product__c= 'All Products';
        threshold.Project__c = 'All Projects';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 100;
        insert threshold;
   
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'All Markets';
        speTemplate.SubRegion__c= 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c= 'All Category Areas';
        speTemplate.CategoryGroup__c='All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessUnit__c = 'All Business Units';
        speTemplate.BusinessLine__c = 'All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Product1__c ='--None--';
        speTemplate.Product2__c ='--None--';
        speTemplate.Product3__c = '--None--';
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';            
        insert speTemplate; 
        speTemplate.Stage__c='Pilot';
        update speTemplate;   
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
                   
        SPE_ScoringTemplate__c sctemp = new SPE_ScoringTemplate__c();
        sctemp.Name = 'Atos_sctemp_test';
        sctemp.SPETemplate__c=speTemplate.Id;
        sctemp.Stage__c = 'Draft';
        sctemp.Region__c = 'NAM';
        sctemp.SubRegion__c = 'NAM US';
        sctemp.Country__c = 'United States of America';
        sctemp.Project__c = 'US Cellular';
        sctemp.CategoryCluster__c= 'Product Procurement';
        sctemp.CategoryGroup__c = 'Mechanics';
        sctemp.Category__c = 'Sheet Metal Parts';
        sctemp.BusinessUnit__c ='Global Service';
        sctemp.BusinessLine__c ='Care';      
        sctemp.Product__c = 'PTF';
        sctemp.Product1__c ='--None--';
        sctemp.Product2__c ='--None--';
        sctemp.Product3__c = '--None--';         
        insert sctemp;
        
        sctemp.Stage__c = 'Pilot';
        update sctemp;
                     
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = sctemp.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;   
      
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEScoringTemplate__c= sctemp.Id;         
       // spePlan.EndDate__c = System.today().addMonths(1);   
        spePlan.StartDate__c = System.today().addDays(1);       
        spePlan.SPETemplate__c = speTemplate.Id;                
        spePlan.Organization_Group__c = 'Services Procurement';         
        spePlan.SurveyExecutionBeforeIndays__c = 5;        
        spePlan.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPEPlanName__c = 'New Demo Plan 122';  
        spePlan.Region__c= 'All Markets';
        spePlan.SubRegion__c= 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        spePlan.CategoryCluster__c= 'All Category Areas';
        spePlan.CategoryGroup__c='All Category Groups';
        spePlan.Category__c = 'All Categories';
        spePlan.BusinessUnit__c = 'All Business Units';
        spePlan.BusinessLine__c = 'All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.Start_Month__c ='July';
        spePlan.Start_Year__c ='2016';
      //  spePlan.End_Month__c ='December';
       // spePlan.End_Year__c ='2016';
        spePlan.AggregationDuration__c  = '1'; 
        spePlan.Additional_Days__c =1;
        spePlan.Stage__c ='Draft';
        spePlan.Ad_Hoc_Plan__c = false;
      //  spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlan;
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlan;
        
        /*SPE_SPEPlan__c spePlanCloned = SPE_TestObjectCreator.CreateSPEPlan();
        spePlanCloned.SPEScoringTemplate__c= sctemp.Id;         
      //  spePlan.EndDate__c = System.today().addMonths(4);   
       // spePlan.StartDate__c = System.today().addDays(1);
      //  spePlanCloned.SPETemplate__c = speTemplate.Id;                
        spePlanCloned.Organization_Group__c = 'Services Procurement';         
        spePlanCloned.SurveyExecutionBeforeIndays__c = 5;        
        spePlanCloned.SurveyReminderBeforeExecutionDate__c = 3;        
        spePlanCloned.FrequencyInMonths__c = '1';
        spePlanCloned.SPEPlanName__c = 'New Demo Plan 122 Clone';  
        spePlanCloned.Region__c = 'NAM';
        spePlanCloned.SubRegion__c = 'NAM US';
        spePlanCloned.Country__c = 'United States of America';
        spePlanCloned.Project__c = 'US Cellular';
        spePlanCloned.CategoryCluster__c = 'Product Procurement';
        spePlanCloned.CategoryGroup__c = 'Mechanics';
        spePlanCloned.Category__c = 'Sheet Metal Parts';
        spePlanCloned.BusinessUnit__c ='Global Service';
        spePlanCloned.BusinessLine__c ='Care';      
        spePlanCloned.Product__c = 'PTF';
        spePlanCloned.Start_Month__c ='July';
        spePlanCloned.Start_Year__c ='2016';
        spePlanCloned.End_Month__c ='December';
        spePlanCloned.End_Year__c ='2016';
        spePlanCloned.AggregationDuration__c  = '1'; 
        spePlanCloned.Additional_Days__c =1;
        spePlanCloned.Stage__c ='Draft';
        spePlan.Ad_Hoc_Plan__c = true;
       // spePlanCloned.Ad_Hoc_Plan__c =true;
      //  spePlan.Next_Computed_Day__c = System.today().addDays(1);
        insert spePlanCloned;
        
        spePlanCloned.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlanCloned;*/
        
       /* SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'June - 2016'; 
        speTracker.SPETemplate__c = speTemplate.Id; 
        speTracker.SPEPlan__c = spePlanCloned.Id;
        speTracker.DateOfExecution__c = System.Today();
        speTracker.Region__c = 'NAM';
        speTracker.SubRegion__c = 'NAM US';
        speTracker.Country__c = 'United States of America';
        speTracker.Project__c = 'US Cellular';
        speTracker.CategoryCluster__c = 'Product Procurement';
        speTracker.CategoryGroup__c = 'Mechanics';
        speTracker.Category__c = 'Sheet Metal Parts';
        speTracker.BusinessUnit__c ='Global Service';
        speTracker.BusinessLine__c ='Care';      
        speTracker.Product__c = 'PTF';
        speTracker.Status__c='Pending';
       // speTracker.Contact__c= con.id;
      //  speTracker.ForceSurvey__c =true;
       // speTracker.isContainsSurveyBasedPI__c = true;
       // speTracker.PilotTestDataCheck__c = true;
       // speTracker.SendSurveyLink__c= true;
       // insert speTracker;
        
        SPE_SPEPlanSupplierMap__c suppliermap = new SPE_SPEPlanSupplierMap__c();
        suppliermap.SPEPlan__c =spePlanCloned.id;
        suppliermap.Supplier__c=acc1.id;
        insert suppliermap;
        
        SPE_Respondent__c respondent =new SPE_Respondent__c();
        respondent.SPEPlan__c =spePlanCloned.id;
        insert respondent;*/ 
        
        PageReference pageRef = Page.SPE2_SPEPlanCreate_New_3;
        Test.setCurrentPage(pageRef);  
        //pageRef.getParameters().put('isClone','true');
       // pageRef.getParameters().put('speTempId', speTemplate.Id);
       // pageRef.getParameters().put('Id', spePlanCloned.Id);
        pageRef.getParameters().put('cgVal','Mechanics');
        pageRef.getParameters().put('caVal','Product Procurement');
        pageRef.getParameters().put('buVal','Global Service');
        pageRef.getParameters().put('marketVal','NAM');
        pageRef.getParameters().put('marketUnitVal','NAM US');
        pageRef.getParameters().put('countryVal','United States of America');
        pageRef.getParameters().put('blVal','Care');
        pageRef.getParameters().put('ctVal','Sheet Metal Parts');
        pageRef.getParameters().put('projectVal','US Cellular');
        pageRef.getParameters().put('prdVal','PTF');
        pageRef.getParameters().put('rerenderForm11','test');
        
        
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);       
        SPE2_SPEPlanCreateExt_New_3 spe2PlanExt = new SPE2_SPEPlanCreateExt_New_3(stCon);
        
        spe2PlanExt.getMarketValues();
      //  spe2PlanExt.getMarketUnitValues();
        spe2PlanExt.getCountryValues();
        spe2PlanExt.getProjectValues();
        spe2PlanExt.getBusinessUnitValues();
      //  spe2PlanExt.getBusinesLineValues();
        spe2PlanExt.showProdVals();
        spe2PlanExt.fillProduct();
        spe2PlanExt.getCategoryAreaValues();        
      //  spe2PlanExt.getCategoryGroupValues();
        spe2PlanExt.getCategoryValues();   
        spe2PlanExt.ScopeChange();    
        spe2PlanExt.closePopup();
      //  spe2PlanExt.continueCustom();
       // spe2PlanExt.checkValidation();
        spe2PlanExt.save();
        //spe2PlanExt.scopeMatch();
         
        
        //spe2PlanExt.generateTracker();
       // spe2PlanExt.blankMethod();
        Test.StopTest();
    }  
 }