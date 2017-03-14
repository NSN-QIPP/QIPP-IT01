@isTest(SeeAllData = false)

public class SPE2_BulkPlanCreateExt_Test{    
    public static testmethod void Test_SPE2_BulkPlanCreateExt_Test1(){
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c= 'NAM';
        picklistObj.Market_Unit__c = 'NAM US';
        picklistObj.Country__c = 'United States of America';
        picklistObj.Project__c = 'US Cellular';
        picklistObj.Category_Area__c = 'Product Procurement';
        picklistObj.Category_Group__c ='Mechanics';
        picklistObj.Category__c = 'Sheet Metal Parts';
        picklistObj.Business_Unit__c = 'Global Services';
        picklistObj.Business_Line__c = 'Care';
        picklistObj.Product__c = 'PTF';
        picklistObj.Name = 'Picklist Default Values';
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
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
        scoringTemplate.Region__c = 'NAM';
        scoringTemplate.SubRegion__c = 'NAM US';
        scoringTemplate.Country__c = 'United States of America';
        scoringTemplate.Project__c = 'US Cellular';
        scoringTemplate.CategoryCluster__c= 'Product Procurement';
        scoringTemplate.CategoryGroup__c = 'Mechanics';
        scoringTemplate.Category__c = 'Sheet Metal Parts';
        scoringTemplate.BusinessUnit__c ='Global Services';
        scoringTemplate.BusinessLine__c ='Care';      
        scoringTemplate.Product__c = 'PTF';
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        
        
        list<SPE_SPEPlan__c> planList = new list<SPE_SPEPlan__c>();
        for(integer i=0; i<=11 ; i++){
            SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
            spePlan.SPEPlanName__c='aAtos11' + i;
            spePlan.Region__c = 'NAM';
            spePlan.SubRegion__c = 'NAM US';
            spePlan.Country__c = 'United States of America';
            spePlan.Project__c = 'US Cellular';
            spePlan.CategoryCluster__c = 'Product Procurement';
            spePlan.CategoryGroup__c = 'Mechanics';
            spePlan.Category__c = 'Sheet Metal Parts';
            spePlan.BusinessUnit__c ='Global Services';
            spePlan.BusinessLine__c ='Care';      
            spePlan.Product__c = 'PTF';
            spePlan.AutoTicket__c= 'OFF';
            spePlan.FrequencyInMonths__c = '1';
            spePlan.AggregationDuration__c = '1';
           // spePlan.SPETemplate__c = speTemp.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            spePlan.Stage__c = 'Draft';         
            spePlan.CM__c= con.id;
            //spePlan.CompletedTracker__c= 2;
            spePlan.EndDate__c= Date.newinstance(2020,06,20);
            spePlan.FrequencyInMonths__c='1';            
            spePlan.Organization_Group__c='Indirect Procurement';
            spePlan.PPM1__c= CCcon1.id;           
            spePlan.StartDate__c= Date.newinstance(2020,01,20);
            spePlan.SurveyReminderBeforeExecutionDate__c=1;
            spePlan.Stage__c = 'Draft';
            spePlan.SPEDomain__c= 'test spe Domain';  
            
            insert spePlan;
            spePlan.Stage__c  = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
            update spePlan;
            planList.add(spePlan); 
        } 
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = planList[0].Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;

        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'Care';
        bubl.BusinessUnit__c = 'Global Services';
        bubl.Product__c = 'PTF';
        insert bubl;
        
        SPE_CategoryMaster__c catMas = new SPE_CategoryMaster__c();
        catMas.Category__c= 'All Categories';  
        catMas.Cluster__c = 'All Category Areas';
        catMas.Group__c ='All Category Groups';
        insert catMas;
        
        SPE_ProjectMaster__c projMas = new SPE_ProjectMaster__c();
        projMas.name ='projMas';
        projMas.Country__c ='All Countries'; 
        projMas.Market__c ='All Markets';
        projMas.MarketUnit__c = 'All Market Units';
        projMas.Project__c ='All Projects';
        projMas.Region__c = 'All Region';
        insert projMas;       
        
        Test.startTest();
        PageReference pageRef = Page.SPE2_BulkPlanCreate;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('scoringtempId',scoringTemplate.id);
        pageRef.getParameters().put('cgVal','Mechanics');
        pageRef.getParameters().put('caVal','Product Procurement');
        pageRef.getParameters().put('buVal','Global Services');
        pageRef.getParameters().put('marketVal','NAM');
        pageRef.getParameters().put('marketUnitVal','NAM US');
        pageRef.getParameters().put('countryVal','United States of America');
        pageRef.getParameters().put('blVal','Care');
        pageRef.getParameters().put('ctVal','Sheet Metal Parts');
        pageRef.getParameters().put('projectVal','US Cellular');
        pageRef.getParameters().put('prdVal','PTF');
        Apexpages.currentpage().getparameters().put('crntPageNum','2');
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(planList[0]);
        SPE2_BulkPlanCreateExt bulkPlan = new SPE2_BulkPlanCreateExt(stCon);  
        List<PicklistDefaultValues__c> tmpList = bulkPlan.defalultPicklist;
    //    bulkPlan.disableScopeAttributes();
        bulkPlan.Mktchk = true;
        bulkPlan.MktUnitchk = true;
        bulkPlan.Countchk = true;
        bulkPlan.Prjchk = true;
        bulkPlan.CatAreachk = true;
        bulkPlan.CatGrpchk = true;     
        bulkPlan.Catchk = true;
        bulkPlan.BUchk = true;
        bulkPlan.BLchk = true;
        bulkPlan.Prodchk = true;
       
        bulkPlan.DEFAULT_PAGE_SIZE = 10;
        bulkPlan.getMarketValues();
        bulkPlan.getMarketUnitValues();
        bulkPlan.getCountryValues();
        bulkPlan.getProjectValues();
        bulkPlan.getCategoryAreaValues();
        bulkPlan.getCategoryGroupValues();
        bulkPlan.getCategoryValues();
        bulkPlan.getBusinessUnitValues();
        bulkPlan.getBusinesLineValues();
        bulkPlan.getProductValues();
        bulkPlan.createSPEPlan();
        bulkPlan.StartEndDateCalculation();
        bulkPlan.finalSPEPlan();
        bulkPlan.Mktchk = false;
        bulkPlan.MktUnitchk = false;
        bulkPlan.Countchk = false;
        bulkPlan.Prjchk = false;
        bulkPlan.CatAreachk = false;
        bulkPlan.CatGrpchk = false;     
        bulkPlan.Catchk = false;
        bulkPlan.BUchk = false;
        bulkPlan.BLchk = false;
        bulkPlan.Prodchk = false;
        //----3D
                //--Catchk = true;
        bulkPlan.Catchk= true;
        bulkPlan.BUchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.BUchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.MktUnitchk= false;
         
        bulkPlan.Countchk= true;
        bulkPlan.BUchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Countchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Countchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Countchk= false; 
        
        bulkPlan.Prodchk= true;
        bulkPlan.Countchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Countchk= false;
        
        bulkPlan.BUchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Prjchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Prjchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Prjchk= false; 
        
        bulkPlan.displayAllSPEPlan();
        bulkPlan.firstBtnClick();
        bulkPlan.nextBtnClick();
        bulkPlan.previousBtnClick();      
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        bulkPlan.pageNumber =1;
        bulkPlan.maxPages =2;
        bulkPlan.goToPage();
        if(bulkPlan.maxPages != null){
          bulkPlan.pageNumber = bulkPlan.maxPages-1;
          bulkPlan.nextBtnClick();
          bulkPlan.goToPage(); 
        }
        bulkPlan.lastBtnClick();
        bulkPlan.save();
        bulkPlan.cancel();
        
        bulkPlan.ScopeChange();
        Test.stopTest();

        }    
    } 
    public static testmethod void Test_SPE2_BulkPlanCreateExt_Test2(){
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c= 'NAM';
        picklistObj.Market_Unit__c = 'NAM US';
        picklistObj.Country__c = 'United States of America';
        picklistObj.Project__c = 'US Cellular';
        picklistObj.Category_Area__c = 'Product Procurement';
        picklistObj.Category_Group__c ='Mechanics';
        picklistObj.Category__c = 'Sheet Metal Parts';
        picklistObj.Business_Unit__c = 'Global Services';
        picklistObj.Business_Line__c = 'Care';
        picklistObj.Product__c = 'PTF';
        picklistObj.Name = 'Picklist Default Values';
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
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
        scoringTemplate.Region__c = 'NAM';
        scoringTemplate.SubRegion__c = 'NAM US';
        scoringTemplate.Country__c = 'United States of America';
        scoringTemplate.Project__c = 'US Cellular';
        scoringTemplate.CategoryCluster__c= 'Product Procurement';
        scoringTemplate.CategoryGroup__c = 'Mechanics';
        scoringTemplate.Category__c = 'Sheet Metal Parts';
        scoringTemplate.BusinessUnit__c ='Global Services';
        scoringTemplate.BusinessLine__c ='Care';      
        scoringTemplate.Product__c = 'PTF';
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        
        
        list<SPE_SPEPlan__c> planList = new list<SPE_SPEPlan__c>();
        for(integer i=0; i<=11 ; i++){
            SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
            spePlan.SPEPlanName__c='aAtos11' + i;
            spePlan.Region__c = 'NAM';
            spePlan.SubRegion__c = 'NAM US';
            spePlan.Country__c = 'United States of America';
            spePlan.Project__c = 'US Cellular';
            spePlan.CategoryCluster__c = 'Product Procurement';
            spePlan.CategoryGroup__c = 'Mechanics';
            spePlan.Category__c = 'Sheet Metal Parts';
            spePlan.BusinessUnit__c ='Global Services';
            spePlan.BusinessLine__c ='Care';      
            spePlan.Product__c = 'PTF';
            spePlan.AutoTicket__c= 'OFF';
            spePlan.FrequencyInMonths__c = '1';
            spePlan.AggregationDuration__c = '1';
           // spePlan.SPETemplate__c = speTemp.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            spePlan.Stage__c = 'Draft';         
            spePlan.CM__c= con.id;
            //spePlan.CompletedTracker__c= 2;
            spePlan.EndDate__c= Date.newinstance(2020,06,20);
            spePlan.FrequencyInMonths__c='1';            
            spePlan.Organization_Group__c='Indirect Procurement';
            spePlan.PPM1__c= CCcon1.id;           
            spePlan.StartDate__c= Date.newinstance(2020,01,20);
            spePlan.SurveyReminderBeforeExecutionDate__c=1;
            spePlan.Stage__c = 'Draft';
            spePlan.SPEDomain__c= 'test spe Domain';  
            
            insert spePlan;
            spePlan.Stage__c  = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
            update spePlan;
            planList.add(spePlan); 
        } 
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = planList[0].Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;

        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'Care';
        bubl.BusinessUnit__c = 'Global Services';
        bubl.Product__c = 'PTF';
        insert bubl;
        
        SPE_CategoryMaster__c catMas = new SPE_CategoryMaster__c();
        catMas.Category__c= 'All Categories';  
        catMas.Cluster__c = 'All Category Areas';
        catMas.Group__c ='All Category Groups';
        insert catMas;
        
        SPE_ProjectMaster__c projMas = new SPE_ProjectMaster__c();
        projMas.name ='projMas';
        projMas.Country__c ='All Countries'; 
        projMas.Market__c ='All Markets';
        projMas.MarketUnit__c = 'All Market Units';
        projMas.Project__c ='All Projects';
        projMas.Region__c = 'All Region';
        insert projMas;       
        
        Test.startTest();
        PageReference pageRef = Page.SPE2_BulkPlanCreate;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('scoringtempId',scoringTemplate.id);
        pageRef.getParameters().put('cgVal','Mechanics');
        pageRef.getParameters().put('caVal','Product Procurement');
        pageRef.getParameters().put('buVal','Global Services');
        pageRef.getParameters().put('marketVal','NAM');
        pageRef.getParameters().put('marketUnitVal','NAM US');
        pageRef.getParameters().put('countryVal','United States of America');
        pageRef.getParameters().put('blVal','Care');
        pageRef.getParameters().put('ctVal','Sheet Metal Parts');
        pageRef.getParameters().put('projectVal','US Cellular');
        pageRef.getParameters().put('prdVal','PTF');
        Apexpages.currentpage().getparameters().put('crntPageNum','2');
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(planList[0]);
        SPE2_BulkPlanCreateExt bulkPlan = new SPE2_BulkPlanCreateExt(stCon);  
        List<PicklistDefaultValues__c> tmpList = bulkPlan.defalultPicklist;

  /*      bulkPlan.DEFAULT_PAGE_SIZE = 10;
        bulkPlan.getMarketValues();
        bulkPlan.getMarketUnitValues();
        bulkPlan.getCountryValues();
        bulkPlan.getProjectValues();
        bulkPlan.getCategoryAreaValues();
        bulkPlan.getCategoryGroupValues();
        bulkPlan.getCategoryValues();
        bulkPlan.getBusinessUnitValues();
        bulkPlan.getBusinesLineValues();
        bulkPlan.getProductValues();
   */  
        //--- 2D---
        bulkPlan.BUchk = true;
        bulkPlan.Mktchk = true;       
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk = false;
        bulkPlan.Mktchk = false; 
               
        bulkPlan.BLchk = true;
        bulkPlan.Mktchk = true;       
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk = false;
        bulkPlan.Mktchk = false;
                
        bulkPlan.Prodchk = true;
        bulkPlan.Mktchk = true;       
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Mktchk = false;
        bulkPlan.Prodchk = false;
        
        bulkPlan.Prodchk = true;
        bulkPlan.MktUnitchk= true;       
        bulkPlan.displayAllSPEPlan();
        bulkPlan.MktUnitchk= false;
        bulkPlan.Prodchk = false;
        bulkPlan.BUchk = true;
        bulkPlan.MktUnitchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk = false;
        bulkPlan.MktUnitchk = false;        
        bulkPlan.BLchk = true;
        bulkPlan.MktUnitchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk = false;
        bulkPlan.MktUnitchk = false;
        
        bulkPlan.Countchk = true;
        bulkPlan.BUchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk = false;
        
        bulkPlan.BLchk = true;
        bulkPlan.Countchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk = false;
        
        bulkPlan.Prodchk = true;
        bulkPlan.Countchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk = false;
        bulkPlan.Countchk = false;
        
        bulkPlan.BUchk = true;
        bulkPlan.Prjchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk = false;
        
        bulkPlan.BLchk = true;
        bulkPlan.Prjchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk = false;
        
        bulkPlan.Prodchk = true;
        bulkPlan.Prjchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk = false;
        bulkPlan.Prjchk = false;
        
        bulkPlan.Mktchk= true;
        bulkPlan.CatAreachk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatAreachk= false;
        
        bulkPlan.CatGrpchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatGrpchk= false;
        
        bulkPlan.Catchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Catchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.MktUnitchk= true;
        bulkPlan.CatAreachk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatAreachk= false;
        
        bulkPlan.CatGrpchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatGrpchk = false;
        
        bulkPlan.Catchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Catchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.CatAreachk= true;
        bulkPlan.Countchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatAreachk= false;
        
        bulkPlan.Catchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Catchk= false;
        
        bulkPlan.CatGrpchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatGrpchk= false;
        bulkPlan.Countchk = false;
        
        bulkPlan.Prjchk = True;
        bulkPlan.CatAreachk = True;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatAreachk= false;
        
        bulkPlan.CatGrpchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatGrpchk= false;
        
        bulkPlan.Catchk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Catchk = false;
        bulkPlan.Prjchk = false;
        
        bulkPlan.BUchk= true;
        bulkPlan.CatAreachk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.CatAreachk= false;
        
        bulkPlan.CatGrpchk= true;
        bulkPlan.BUchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.CatGrpchk= false;
        
        bulkPlan.Catchk= true;
        bulkPlan.BUchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Catchk= false;
        
        bulkPlan.firstBtnClick();
        bulkPlan.nextBtnClick();
        bulkPlan.previousBtnClick();      
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        bulkPlan.pageNumber =1;
        bulkPlan.maxPages =2;
        bulkPlan.goToPage();
        if(bulkPlan.maxPages != null){
          bulkPlan.pageNumber = bulkPlan.maxPages-1;
          bulkPlan.nextBtnClick();
          bulkPlan.goToPage(); 
        }
        bulkPlan.lastBtnClick();
        bulkPlan.save();
        bulkPlan.cancel();
        
        bulkPlan.ScopeChange();
        Test.stopTest();

        }    
    }   
    public static testmethod void Test_SPE2_BulkPlanCreateExt_Test3(){
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c= 'NAM';
        picklistObj.Market_Unit__c = 'NAM US';
        picklistObj.Country__c = 'United States of America';
        picklistObj.Project__c = 'US Cellular';
        picklistObj.Category_Area__c = 'Product Procurement';
        picklistObj.Category_Group__c ='Mechanics';
        picklistObj.Category__c = 'Sheet Metal Parts';
        picklistObj.Business_Unit__c = 'Global Services';
        picklistObj.Business_Line__c = 'Care';
        picklistObj.Product__c = 'PTF';
        picklistObj.Name = 'Picklist Default Values';
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
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
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Deep.Banerjee1@atos.net';
        insert CCcon1;
        
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
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                
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
        scoringTemplate.Region__c = 'NAM';
        scoringTemplate.SubRegion__c = 'NAM US';
        scoringTemplate.Country__c = 'United States of America';
        scoringTemplate.Project__c = 'US Cellular';
        scoringTemplate.CategoryCluster__c= 'Product Procurement';
        scoringTemplate.CategoryGroup__c = 'Mechanics';
        scoringTemplate.Category__c = 'Sheet Metal Parts';
        scoringTemplate.BusinessUnit__c ='Global Services';
        scoringTemplate.BusinessLine__c ='Care';      
        scoringTemplate.Product__c = 'PTF';
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        list<SPE_SPEPlan__c> planList = new list<SPE_SPEPlan__c>();
        for(integer i=0; i<=11 ; i++){
            SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
            spePlan.SPEPlanName__c='aAtos11' + i;
            spePlan.Region__c = 'NAM';
            spePlan.SubRegion__c = 'NAM US';
            spePlan.Country__c = 'United States of America';
            spePlan.Project__c = 'US Cellular';
            spePlan.CategoryCluster__c = 'Product Procurement';
            spePlan.CategoryGroup__c = 'Mechanics';
            spePlan.Category__c = 'Sheet Metal Parts';
            spePlan.BusinessUnit__c ='Global Services';
            spePlan.BusinessLine__c ='Care';      
            spePlan.Product__c = 'PTF';
            spePlan.AutoTicket__c= 'OFF';
            spePlan.FrequencyInMonths__c = '1';
            spePlan.AggregationDuration__c = '1';
           // spePlan.SPETemplate__c = speTemp.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            spePlan.Stage__c = 'Draft';         
            spePlan.CM__c= con.id;
            //spePlan.CompletedTracker__c= 2;
            spePlan.EndDate__c= Date.newinstance(2020,06,20);
            spePlan.FrequencyInMonths__c='1';            
            spePlan.Organization_Group__c='Indirect Procurement';
            spePlan.PPM1__c= CCcon1.id;           
            spePlan.StartDate__c= Date.newinstance(2020,01,20);
            spePlan.SurveyReminderBeforeExecutionDate__c=1;
            spePlan.Stage__c = 'Draft';
            spePlan.SPEDomain__c= 'test spe Domain';  
            
            insert spePlan;
            spePlan.Stage__c  = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
            update spePlan;
            planList.add(spePlan); 
        } 
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = planList[0].Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;

        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'Care';
        bubl.BusinessUnit__c = 'Global Services';
        bubl.Product__c = 'PTF';
        insert bubl;
        
        SPE_CategoryMaster__c catMas = new SPE_CategoryMaster__c();
        catMas.Category__c= 'All Categories';  
        catMas.Cluster__c = 'All Category Areas';
        catMas.Group__c ='All Category Groups';
        insert catMas;
        
        SPE_ProjectMaster__c projMas = new SPE_ProjectMaster__c();
        projMas.name ='projMas';
        projMas.Country__c ='All Countries'; 
        projMas.Market__c ='All Markets';
        projMas.MarketUnit__c = 'All Market Units';
        projMas.Project__c ='All Projects';
        projMas.Region__c = 'All Region';
        insert projMas;       
        
        Test.startTest();
        PageReference pageRef = Page.SPE2_BulkPlanCreate;
        Test.setCurrentPage(pageRef);
        Apexpages.currentpage().getparameters().put('scoringtempId',scoringTemplate.id);
        pageRef.getParameters().put('cgVal','Mechanics');
        pageRef.getParameters().put('caVal','Product Procurement');
        pageRef.getParameters().put('buVal','Global Services');
        pageRef.getParameters().put('marketVal','NAM');
        pageRef.getParameters().put('marketUnitVal','NAM US');
        pageRef.getParameters().put('countryVal','United States of America');
        pageRef.getParameters().put('blVal','Care');
        pageRef.getParameters().put('ctVal','Sheet Metal Parts');
        pageRef.getParameters().put('projectVal','US Cellular');
        pageRef.getParameters().put('prdVal','PTF');
        Apexpages.currentpage().getparameters().put('crntPageNum','2');
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(planList[0]);
        SPE2_BulkPlanCreateExt bulkPlan = new SPE2_BulkPlanCreateExt(stCon);  
        List<PicklistDefaultValues__c> tmpList = bulkPlan.defalultPicklist;
        
     //----1D------
             //-----CatAreaMap != null
        bulkPlan.CatAreachk = true;
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatAreachk = false;
        
        bulkPlan.CatGrpchk = true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.CatGrpchk = false;
        
        bulkPlan.Catchk = true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Catchk = false;
            //----MktMap != null    
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Mktchk= false;
        
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Countchk = true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Countchk= false;
        
        bulkPlan.Prjchk = true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prjchk= false;
            //---BUMap != null
        bulkPlan.BUchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        
        bulkPlan.BLchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        
        bulkPlan.Prodchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk = false;
        
     //----3D------ 
             //---CatAreachk= true;
        bulkPlan.CatAreachk= true;
        bulkPlan.BUchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.BUchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.MktUnitchk= false;
         
        bulkPlan.Countchk= true;
        bulkPlan.BUchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Countchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Countchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Countchk= false; 
        
        bulkPlan.Prodchk= true;
        bulkPlan.Countchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Countchk= false;
        
        bulkPlan.BUchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Prjchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Prjchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Prjchk= false;
        bulkPlan.CatAreachk= false;
                //---CatGrpchk= true;
        bulkPlan.CatGrpchk= true;
        bulkPlan.BUchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.Mktchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Mktchk= false;
        
        bulkPlan.BUchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.MktUnitchk= false;
         
        bulkPlan.Countchk= true;
        bulkPlan.BUchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Countchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Countchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Countchk= false; 
        
        bulkPlan.Prodchk= true;
        bulkPlan.Countchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Countchk= false;
        
        bulkPlan.BUchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BUchk= false;
        bulkPlan.Prjchk= false;
        
        bulkPlan.BLchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.BLchk= false;
        bulkPlan.Prjchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.MktUnitchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.MktUnitchk= false;
        
        bulkPlan.Prodchk= true;
        bulkPlan.Prjchk= true; 
        bulkPlan.displayAllSPEPlan();
        bulkPlan.Prodchk= false;
        bulkPlan.Prjchk= false;                
                        
        bulkPlan.firstBtnClick();
        bulkPlan.nextBtnClick();
        bulkPlan.previousBtnClick();      
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        bulkPlan.pageNumber =1;
        bulkPlan.maxPages =2;
        bulkPlan.goToPage();
        if(bulkPlan.maxPages != null){
          bulkPlan.pageNumber = bulkPlan.maxPages-1;
          bulkPlan.nextBtnClick();
          bulkPlan.goToPage(); 
        }
        bulkPlan.lastBtnClick();
        bulkPlan.save();
        bulkPlan.cancel();
        
        bulkPlan.ScopeChange();
        Test.stopTest();

        }    
    }     
}