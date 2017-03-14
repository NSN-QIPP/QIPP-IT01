@isTest(SeeAllData=False)
public class SPE2_AdhocScorecardPageEXTNew_Test{
     public static testmethod void  AdhocScorecardPageEXTNewTest1(){
      Test.startTest(); 
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
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'dharani.dhakineni@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'dharani.dhakineni1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'dharani.dhakineni2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'dharani.dhakineni3@atos.net';
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
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
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
        kpiDefinition2.ScheduledDate__c = date.newInstance(2020,01,20);
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2018,10,12);
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
               
   
        //-----------------SPE Template Creation-------------
         SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
         insert speTemplate;
         speTemplate.Stage__c='Pilot';
         update speTemplate;      
         
         //---------------SPE KPIMap Creation------------
         SPE_SPEKPIMap__c kpiMap = new SPE_SPEKPIMap__c();
         kpiMap.KPIDefinition__c = kpiDefinition1.ID;
         kpiMap.SPETemplate__c = speTemplate.ID;
         insert kpiMap;
         //----------Scoring Template Creation-----------------------
         SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
         scoringTemplate.Stage__c = 'Draft';       
         insert scoringTemplate;
            
         scoringTemplate.Stage__c = 'Pilot';     
         update scoringTemplate;     
         
         //----------Scorecard Template---------------
         SPE_ScorecardTemplate__c st = new SPE_ScorecardTemplate__c();
         st.Name = 'Test ScoreTemplate';
         st.Region__c = 'All Markets';
         st.SubRegion__c = 'All Market Units';
         st.Country__c = 'All Countries';
         st.Project__c = 'All Projects';
    
         st.Category__c = 'All Category Areas';
         st.CategoryGroup__c = 'All Category Groups';
         st.Category__c = 'All Categories';
    
         st.BusinessUnit__c = 'All Business Units';
         st.BusinessLine__c = 'All Business Lines';
         st.Product__c = 'All Products';
         st.Stage__c = 'Draft';
         insert st;
          
         st.Stage__c = 'Published';
         update st;
         
         
         //-----------SPEPLan Creation--------------------
         List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<10;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;
                     
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2019,10,01);       
             spePlan.StartDate__c = Date.newinstance(2018,10,01);
             spePlan.SPETemplate__c = speTemplate.Id; 
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
             lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);  
        
        System.debug('plan size !!!!!!!!!!!!!!!!'+lstPlan.size());
        
        //-----------Supplier Creation--------------
        Account acc = new Account();
        acc.Name = 'COSCOM';
        insert acc;
        
        //-------Supplier Plan Map creation-----------------
        LIst<SPE_SPEPlanSupplierMap__c> lstplanmap = new List<SPE_SPEPlanSupplierMap__c>();
        for(SPE_SPEPlan__c plan : lstPlan){ 
            SPE_SPEPlanSupplierMap__c planSuppMap = new SPE_SPEPlanSupplierMap__c();
            planSuppMap.SPEPlan__c = plan.ID;
            planSuppMap.Supplier__c = acc.ID;
            lstplanmap.add(planSuppMap);
        }
        insert lstplanmap;
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'SC Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = st.Id;
        scg.StartDate__c = Date.newInstance(2018,2,15);
        scg.EndDate__c = Date.newInstance(2019,12,15);
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
        scg.isAdhoc__c = true;
        scg.Aggregation_Period_Adhoc__c = 'Monthly';        
        insert scg;
        
        List<SPE_ScorecardSupplierMap__c> listSupplier = new List<SPE_ScorecardSupplierMap__c>();
        for(Integer i=0;i<20;i++){
            SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
            ss.ScorecardGenerator__c = scg.Id;
            ss.Supplier__c = acc1.Id;
            ss.SupplierContact__c = con.Id;
            ss.Approver__c = u.Id;
            listSupplier.add(ss);
        }        
        insert listSupplier;

                  
          //------------SPE Tracker Creation----------------------
         List<SPE_SPETracker__c> lstTracker = new List<SPE_SPETracker__c>();
         for(SPE_SPEPlan__c spePln : lstPlan){
                SPE_SPETracker__c  trackerObj = new SPE_SPETracker__c();
                trackerObj  = SPE_TestObjectCreator.createSPETracker();
                trackerObj.SPEPlan__c = spePln.ID;
                trackerObj.DateOfExecution__c = date.newinstance(2018,12,10);
                trackerObj.Status__c = 'Completed';
                trackerObj.Name = 'December - 2018';
               lstTracker.add(trackerObj);
           }  insert lstTracker; 
           
           insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
       System.debug('@@@@@@@@@lstTracker size='+lstTracker.size()); 
       System.assert(lstTracker != null);
      
       //--------Tracker Score---------------
      List<SPE_TrackerScore__c> lstTrackerScore = new List<SPE_TrackerScore__c>();
       for(SPE_SPETracker__c  tracker : lstTracker){
               SPE_TrackerScore__c trackerSc = new SPE_TrackerScore__c ();
               trackerSc.Score__c = 1.4000;
               trackerSc.Supplier__c = acc.ID;
               trackerSc.KPIName__c = 'Test PKI';
               trackerSc.Group__c = 'Operational';
               trackerSc.SPETracker__c = tracker.ID;
               trackerSc.SPEScore__c = true;
              // insert trackerSc;
               lstTrackerScore.add(trackerSc);
        }   insert lstTrackerScore;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        System.debug('@@@@@@@@@lstTrackerScore size='+lstTrackerScore.size()); 
        System.assert(lstTrackerScore != null);
       //------------Tracker Value----------------------------
     
 /*      for(SPE_SPETracker__c  tracker :lstTracker){
        List<SPE_TrackerValues__c> lsttrackerValues = new List<SPE_TrackerValues__c>();
       for(Integer i=0;i<2;i++){ 
           SPE_TrackerValues__c trackervAL = SPE_TestObjectCreator.createTrackerValue();
           trackervAL.SPETracker__c = tracker.ID; 
           trackervAL.Supplier__c = acc.ID;
           trackervAL.KPIDefinition__c = kpidefinition1.ID;
           trackervAL.DataLogic__c = 'Assumed';
           trackervAL.Value__c = 2.00;
           trackervAL.Score__c = 1.00;
           trackervAL.Score1__c = 1.4000;
           trackervAL.MissingDatalogic__c = 'Past Data or Category Average';
           lsttrackerValues.add(trackervAL);
       }insert  lsttrackerValues;
       }
 */      //------------SPEScorecard SPETemplateMap----------------------------
         SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
         scTempMap.ScorecardTemplate__c = st.ID;
         scTempMap.SPETemplate__c = speTemplate.ID;
         scTempMap.Weight__c = 100;  
         insert scTempMap;
        
        PageReference pageRef = Page.SPE2_AdhocScorecardPageNew;
        Test.setCurrentPage(pageRef);  
        
      ApexPages.StandardController sc = new ApexPages.StandardController(st);
      SPE2_AdhocScorecardPageEXTNew adhoc = new SPE2_AdhocScorecardPageEXTNew(sc);
      adhoc.scorecardSupplierList = listSupplier;
       adhoc.DEFAULT_PAGE_SIZE = 2;
      adhoc.spePlanforDate.StartDate__c  = Date.newinstance(2018,10,01); 
      adhoc.spePlanforDate.EndDate__c = Date.newinstance(2019,10,01);
      adhoc.geoScope = 'Project';
      adhoc.catScope = 'Category';
      adhoc.prodScope = 'Product';  
      adhoc.getGeographyScope();
      adhoc.getCategoryScope();
      adhoc.getProductScope();
      adhoc.getPlanStage();
      adhoc.getPlanSupplier();
      adhoc.showScopePlans(); //Proceed btn
      adhoc.nextBtnClick2(); 
      adhoc.lastBtnClick2();           
      adhoc.previousBtnClick2();
      adhoc.firstBtnClick2();
      ApexPages.currentPage().getParameters().put('crntPageNum','0');
      adhoc.goToPage2();
      ApexPages.currentPage().getParameters().put('crntPageNum','1');
      adhoc.goToPage2();
      ApexPages.currentPage().getParameters().put('crntPageNum','2');
      adhoc.goToPage2();
      
      adhoc.DEFAULT_PAGE_SIZE = adhoc.scopeplanwraperList.size()+1 ;
      adhoc.pagination2();
      
    /*   if(adhoc.maxPages2 != null){
          string s= ''+adhoc.maxPages2;
          ApexPages.currentPage().getParameters().put('crntPageNum',s);
          adhoc.goToPage2();
      }
          */
     // for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.scopeplanwraperList){
       //   sPlan.selected = true;
     // } 
      system.debug('adhoc.scopeplanwraperList'+adhoc.scopeplanwraperList);
      system.assert(adhoc.scopeplanwraperList != null);
      
      adhoc.organization = 'Services Procurement';
      adhoc.projectVal = 'INDP';
      adhoc.stage = 'Published';
      adhoc.blVal = 'PROD PROC';
      adhoc.active= 'true' ;
      adhoc.marketVal = 'IND';      
      adhoc.buVal = 'PROD BL';
      adhoc.caVal ='IP';
      adhoc.cgVal = 'IP GP';
      adhoc.countryVal = 'IND C';
      adhoc.ctVal = 'IP CG';
      adhoc.prdVal = 'PROD RT';
      
      if(adhoc.scopeplanwraperList.size() > 1){
          for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.scopeplanwraperList){
              sPlan.selected = false;
          } 
       }  
       adhoc.scopeplanwraperList[0].selected = true;
      adhoc.applyValidation = false;
      adhoc.showPlans();
      adhoc.lastBtnClick();
      adhoc.nextBtnClick();    
      adhoc.previousBtnClick();
      adhoc.firstBtnClick();
          
      adhoc.DEFAULT_PAGE_SIZE = adhoc.wrapperPlanList.size()+1 ;
      adhoc.pagination(adhoc.wrapperPlanList);
      
     adhoc.DEFAULT_PAGE_SIZE = 1;
   //   ApexPages.currentPage().getParameters().put('crntPageNum','1');            
      adhoc.showScope = true;
      adhoc.applyValidation = true;
      adhoc.nextfunction();
      adhoc.goToPage3();
      adhoc.goToPage4();
      
      adhoc.DEFAULT_PAGE_SIZE = adhoc.containerList.size()+1 ;
      adhoc.pagination3();

      adhoc.DEFAULT_PAGE_SIZE = 1;          
      adhoc.getPlanSupplier();     
      adhoc.scoreCardgenerator.Aggregation_Period_Adhoc__c = 'Half Yearly';
      adhoc.startDateYear = 2015;
      adhoc.startDateMonth = 01;
      adhoc.EndDateYear = 2018;
      adhoc.EndDateMonth = 2;
      adhoc.scoreCardgenerator.Name= 'Test SC Generator';

  //    system.debug('adhoc.spePlanIds'+adhoc.spePlanIds);
   //   system.debug('adhoc.supplierIds'+adhoc.supplierIds);
   //   system.assert(adhoc.spePlanIds != null); 
   //   system.assert(adhoc.supplierIds != null);     
      
      adhoc.nextBtnClick3();
      adhoc.previousBtnClick3();
      adhoc.lastBtnClick3();
      adhoc.firstBtnClick3();
     adhoc.firstBtnClick4();
      adhoc.nextBtnClick4();
      adhoc.previousBtnClick4();
      adhoc.lastBtnClick4();
      adhoc.goToPage4();
      for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan :  adhoc.containerList){
          sPlan.selected = true;
      }
      adhoc.ContinueScorecardGen();
      adhoc.getpopulateYear();
      adhoc.getpopulateMonth();
      adhoc.getpopulateQuarter();
      adhoc.getpopulateHalfYearly();
     
    
      adhoc.deletePlan();
     adhoc.saveScorecardGen();  
   Test.stopTest();
               
     }
    }
    public static testmethod void  AdhocScorecardPageEXTNewTest2(){
      Test.startTest(); 
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
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'dharani.dhakineni@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'dharani.dhakineni1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'dharani.dhakineni2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'dharani.dhakineni3@atos.net';
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
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
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
        kpiDefinition2.ScheduledDate__c = date.newInstance(2020,01,20);
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2018,10,12);
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
               
   
        //-----------------SPE Template Creation-------------
         SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
         insert speTemplate;
         speTemplate.Stage__c='Pilot';
         update speTemplate;      
         
         //---------------SPE KPIMap Creation------------
         SPE_SPEKPIMap__c kpiMap = new SPE_SPEKPIMap__c();
         kpiMap.KPIDefinition__c = kpiDefinition1.ID;
         kpiMap.SPETemplate__c = speTemplate.ID;
         insert kpiMap;
         //----------Scoring Template Creation-----------------------
         SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
         scoringTemplate.Stage__c = 'Draft';       
         insert scoringTemplate;
            
         scoringTemplate.Stage__c = 'Pilot';     
         update scoringTemplate;     
         
         //----------Scorecard Template---------------
         SPE_ScorecardTemplate__c st = new SPE_ScorecardTemplate__c();
         st.Name = 'Test ScoreTemplate';
         st.Region__c = 'All Markets';
         st.SubRegion__c = 'All Market Units';
         st.Country__c = 'All Countries';
         st.Project__c = 'All Projects';
    
         st.Category__c = 'All Category Areas';
         st.CategoryGroup__c = 'All Category Groups';
         st.Category__c = 'All Categories';
    
         st.BusinessUnit__c = 'All Business Units';
         st.BusinessLine__c = 'All Business Lines';
         st.Product__c = 'All Products';
         st.Stage__c = 'Draft';
         insert st;
          
         st.Stage__c = 'Published';
         update st;
         
         
         //-----------SPEPLan Creation--------------------
         List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<10;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;
                     
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2019,10,01);       
             spePlan.StartDate__c = Date.newinstance(2018,10,01);
             spePlan.SPETemplate__c = speTemplate.Id; 
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
             lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);  
        
        System.debug('plan size !!!!!!!!!!!!!!!!'+lstPlan.size());
        
        //-----------Supplier Creation--------------
        Account acc = new Account();
        acc.Name = 'COSCOM';
        insert acc;
        
        //-------Supplier Plan Map creation-----------------
        LIst<SPE_SPEPlanSupplierMap__c> lstplanmap = new List<SPE_SPEPlanSupplierMap__c>();
        for(SPE_SPEPlan__c plan : lstPlan){ 
            SPE_SPEPlanSupplierMap__c planSuppMap = new SPE_SPEPlanSupplierMap__c();
            planSuppMap.SPEPlan__c = plan.ID;
            planSuppMap.Supplier__c = acc.ID;
            lstplanmap.add(planSuppMap);
        }
        insert lstplanmap;
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'SC Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = st.Id;
        scg.StartDate__c = Date.newInstance(2018,2,15);
        scg.EndDate__c = Date.newInstance(2019,12,15);
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
        scg.isAdhoc__c = true;
        scg.Aggregation_Period_Adhoc__c = 'Monthly';        
        insert scg;
        
        List<SPE_ScorecardSupplierMap__c> listSupplier = new List<SPE_ScorecardSupplierMap__c>();
        for(Integer i=0;i<20;i++){
            SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
            ss.ScorecardGenerator__c = scg.Id;
            ss.Supplier__c = acc1.Id;
            ss.SupplierContact__c = con.Id;
            ss.Approver__c = u.Id;
            listSupplier.add(ss);
        }        
        insert listSupplier;

                  
          //------------SPE Tracker Creation----------------------
         List<SPE_SPETracker__c> lstTracker = new List<SPE_SPETracker__c>();
         for(SPE_SPEPlan__c spePln : lstPlan){
         //   for(Integer i=0;i<2;i++){ 
                SPE_SPETracker__c  trackerObj = new SPE_SPETracker__c();
                trackerObj  = SPE_TestObjectCreator.createSPETracker();
                trackerObj.SPEPlan__c = spePln.ID;
                trackerObj.DateOfExecution__c = date.newinstance(2018,12,10);
                trackerObj.Status__c = 'Completed';
                trackerObj.Name = 'December - 2018';
               lstTracker.add(trackerObj);
            // insert trackerObj;
           }  insert lstTracker; 
           
           insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
         // lstTracker.addAll(lstTracker1);
       //}
       System.debug('@@@@@@@@@lstTracker size='+lstTracker.size()); 
       System.assert(lstTracker != null);
       //--------Tracker Score---------------
      List<SPE_TrackerScore__c> lstTrackerScore = new List<SPE_TrackerScore__c>();
       for(SPE_SPETracker__c  tracker : lstTracker){
               SPE_TrackerScore__c trackerSc = new SPE_TrackerScore__c ();
               trackerSc.Score__c = 1.4000;
               trackerSc.Supplier__c = acc.ID;
               trackerSc.KPIName__c = 'Test PKI';
               trackerSc.Group__c = 'Operational';
               trackerSc.SPETracker__c = tracker.ID;
               trackerSc.SPEScore__c = true;
              // insert trackerSc;
               lstTrackerScore.add(trackerSc);
        }   insert lstTrackerScore;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        System.debug('@@@@@@@@@lstTrackerScore size='+lstTrackerScore.size()); 
        System.assert(lstTrackerScore != null);
       //------------Tracker Value----------------------------
     
 /*      for(SPE_SPETracker__c  tracker :lstTracker){
        List<SPE_TrackerValues__c> lsttrackerValues = new List<SPE_TrackerValues__c>();
       for(Integer i=0;i<2;i++){ 
           SPE_TrackerValues__c trackervAL = SPE_TestObjectCreator.createTrackerValue();
           trackervAL.SPETracker__c = tracker.ID; 
           trackervAL.Supplier__c = acc.ID;
           trackervAL.KPIDefinition__c = kpidefinition1.ID;
           trackervAL.DataLogic__c = 'Assumed';
           trackervAL.Value__c = 2.00;
           trackervAL.Score__c = 1.00;
           trackervAL.Score1__c = 1.4000;
           trackervAL.MissingDatalogic__c = 'Past Data or Category Average';
           lsttrackerValues.add(trackervAL);
       }insert  lsttrackerValues;
       }
 */      //------------SPEScorecard SPETemplateMap----------------------------
         SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
         scTempMap.ScorecardTemplate__c = st.ID;
         scTempMap.SPETemplate__c = speTemplate.ID;
         scTempMap.Weight__c = 100;  
         insert scTempMap;
        
      PageReference pageRef = Page.SPE2_AdhocScorecardPageNew;
      Test.setCurrentPage(pageRef);  
        
      ApexPages.StandardController sc1 = new ApexPages.StandardController(st);
      SPE2_AdhocScorecardPageEXTNew adhoc1 = new SPE2_AdhocScorecardPageEXTNew(sc1);
      adhoc1.scorecardSupplierList = listSupplier;
      adhoc1.DEFAULT_PAGE_SIZE = 2;
      adhoc1.geoScope = 'Country';
      adhoc1.catScope = 'Category Group';
      adhoc1.prodScope = 'Product'; 
      adhoc1.getGeographyScope();
      adhoc1.getCategoryScope();
      adhoc1.getProductScope();
      adhoc1.getPlanStage();
      adhoc1.getPlanSupplier();
      adhoc1.showScopePlans(); //Proceed btn
      adhoc1.pagination2();
      
/*      adhoc1.DEFAULT_PAGE_SIZE = 1;
      adhoc1.spePlanforDate.StartDate__c  = Date.newinstance(2018,10,01); 
      adhoc1.spePlanforDate.EndDate__c = Date.newinstance(2019,10,01);
      adhoc1.geoScope = 'Project';
      adhoc1.catScope = 'Category';
      adhoc1.prodScope = 'Product'; 
      adhoc1.getGeographyScope();
      adhoc1.getCategoryScope();
      adhoc1.getProductScope();
      adhoc1.getPlanStage();
      adhoc1.getPlanSupplier();
      adhoc1.showScopePlans(); //Proceed btn      
      if(adhoc1.scopeplanwraperList.size() > 1){
          SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan= adhoc1.scopeplanwraperList[0];
          sPlan.selected = true;
          adhoc1.scopeplanwraperList.clear();
          adhoc1.scopeplanwraperList.add(sPlan);          
      }
      adhoc1.maxPages2 = 1;
      adhoc1.pageNumber2 =1;
      adhoc1.goToPage2();
 */     
      
     ApexPages.StandardController sc = new ApexPages.StandardController(st);
      SPE2_AdhocScorecardPageEXTNew adhoc = new SPE2_AdhocScorecardPageEXTNew(sc);
      adhoc.scorecardSupplierList = listSupplier;
      adhoc.DEFAULT_PAGE_SIZE = 2;
      adhoc.spePlanforDate.StartDate__c  = Date.newinstance(2018,10,01); 
      adhoc.spePlanforDate.EndDate__c = Date.newinstance(2019,10,01);
      adhoc.geoScope = 'Project';
      adhoc.catScope = 'Category';
      adhoc.prodScope = 'Product'; 
      adhoc.getGeographyScope();
      adhoc.getCategoryScope();
      adhoc.getProductScope();
      adhoc.getPlanStage();
      adhoc.getPlanSupplier();
      adhoc.showScopePlans(); //Proceed btn
      adhoc.lastBtnClick2();
      adhoc.nextBtnClick2();      
      adhoc.previousBtnClick2();
      adhoc.firstBtnClick2();
      ApexPages.currentPage().getParameters().put('crntPageNum','2');
      adhoc.goToPage2();
    
      if(adhoc.scopeplanwraperList.size() > 1){
          for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.scopeplanwraperList){
              sPlan.selected = true;
          } 
      }
      
      system.debug('adhoc.scopeplanwraperList'+adhoc.scopeplanwraperList);
      system.assert(adhoc.scopeplanwraperList != null);
      
      adhoc.organization = 'Services Procurement';
      adhoc.projectVal = 'INDP';
      adhoc.stage = 'Published';
      adhoc.blVal = 'PROD PROC';
      adhoc.active= 'true' ;
      adhoc.marketVal = 'IND';      
      adhoc.buVal = 'PROD BL';
      adhoc.caVal ='IP';
      adhoc.cgVal = 'IP GP';
      adhoc.countryVal = 'IND C';
      adhoc.ctVal = 'IP CG';
      
      adhoc.applyValidation = false;      
      adhoc.showPlans();
      adhoc.lastBtnClick();
      adhoc.nextBtnClick();    
      adhoc.previousBtnClick();
      adhoc.firstBtnClick();
      
      if(adhoc.scopeplanwraperList.size() > 1){
          for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.scopeplanwraperList){
              sPlan.selected = true;
          } 
      }   
      adhoc.containerlist.clear();  
      adhoc.showScope = false;
      adhoc.applyValidation = true;
      adhoc.nextfunction(); 
      
      if(adhoc.scopeplanwraperList.size() > 1){
          for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.scopeplanwraperList){
              sPlan.selected = true;
          } 
      }
      if(adhoc.wrapperPlanList.size() > 1){
       for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.wrapperPlanList){
          sPlan.selected = true;
       } 
      }
      
      adhoc.showScope = true;
      adhoc.applyValidation = false;
      adhoc.nextfunction(); 
     // system.debug('adhoc.spePlanIds'+adhoc.wrapperPlanList);
     // system.assert(adhoc.spePlanIds != null);
      adhoc.goToPage3();
      
      adhoc.getGeographyScope();
      adhoc.getCategoryScope();
      adhoc.getProductScope();
      adhoc.getPlanStage();
      adhoc.getPlanSupplier();
      adhoc.scoreCardgenerator.Aggregation_Period_Adhoc__c = 'Quarterly';
      adhoc.startDateYear = 2015;
      adhoc.startDateMonth = 01;
      adhoc.EndDateYear = 2016;
      adhoc.EndDateMonth = 4;
      adhoc.scoreCardgenerator.Name= 'Test SC Generator';
            
      ApexPages.currentPage().getParameters().put('crntPageNum','1');
  //    system.debug('adhoc.spePlanIds'+adhoc.spePlanIds);
   //   system.debug('adhoc.supplierIds'+adhoc.supplierIds);
   //   system.assert(adhoc.spePlanIds != null); 
   //   system.assert(adhoc.supplierIds != null);     
      adhoc.firstBtnClick3();
      adhoc.nextBtnClick3();
      adhoc.previousBtnClick3();
     // adhoc.lastBtnClick3();
     adhoc.firstBtnClick4();
      adhoc.nextBtnClick4();
      adhoc.previousBtnClick4();
    //  adhoc.lastBtnClick4();
      
      adhoc.ContinueScorecardGen();
      adhoc.getpopulateYear();
      adhoc.getpopulateMonth();
      adhoc.getpopulateQuarter();
      adhoc.getpopulateHalfYearly();
      adhoc.closePopup();    
      adhoc.goToPage4();
      
      adhoc.scoreCardgenerator.Aggregation_Period_Adhoc__c = 'Annual';
      adhoc.startDateYear = 2015;
      adhoc.startDateMonth = 01;
      adhoc.EndDateYear = 2019;
      adhoc.EndDateMonth = 12;
      adhoc.scoreCardgenerator.Name= 'Test SC Generator';
      adhoc.DEFAULT_PAGE_SIZE = 1;
      adhoc.deletePlan();
     adhoc.saveScorecardGen();  
    Test.stopTest();
               
     }
    }    
        
     public static testmethod void  AdhocScorecardPageEXTNewTest3(){
      Test.startTest(); 
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
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'dharani.dhakineni@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'dharani.dhakineni1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'dharani.dhakineni2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'dharani.dhakineni3@atos.net';
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
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
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
        kpiDefinition2.ScheduledDate__c = date.newInstance(2020,01,20);
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
        kpiDefinition1.ScheduledDate__c = Date.newinstance(2018,10,12);
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
               
   
        //-----------------SPE Template Creation-------------
         SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
         insert speTemplate;
         speTemplate.Stage__c='Pilot';
         update speTemplate;      
         
         //---------------SPE KPIMap Creation------------
         SPE_SPEKPIMap__c kpiMap = new SPE_SPEKPIMap__c();
         kpiMap.KPIDefinition__c = kpiDefinition1.ID;
         kpiMap.SPETemplate__c = speTemplate.ID;
         insert kpiMap;
         //----------Scoring Template Creation-----------------------
         SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
         scoringTemplate.Stage__c = 'Draft';       
         insert scoringTemplate;
            
         scoringTemplate.Stage__c = 'Pilot';     
         update scoringTemplate;     
         
         //----------Scorecard Template---------------
         SPE_ScorecardTemplate__c st = new SPE_ScorecardTemplate__c();
         st.Name = 'Test ScoreTemplate';
         st.Region__c = 'All Markets';
         st.SubRegion__c = 'All Market Units';
         st.Country__c = 'All Countries';
         st.Project__c = 'All Projects';
    
         st.Category__c = 'All Category Areas';
         st.CategoryGroup__c = 'All Category Groups';
         st.Category__c = 'All Categories';
    
         st.BusinessUnit__c = 'All Business Units';
         st.BusinessLine__c = 'All Business Lines';
         st.Product__c = 'All Products';
         st.Stage__c = 'Draft';
         insert st;
          
         st.Stage__c = 'Published';
         update st;
         
         
         //-----------SPEPLan Creation--------------------
         List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<10;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;
                     
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2019,10,01);       
             spePlan.StartDate__c = Date.newinstance(2018,10,01);
             spePlan.SPETemplate__c = speTemplate.Id; 
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
             lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);  
        
        System.debug('plan size !!!!!!!!!!!!!!!!'+lstPlan.size());
        
        //-----------Supplier Creation--------------
        Account acc = new Account();
        acc.Name = 'COSCOM';
        insert acc;
        
        //-------Supplier Plan Map creation-----------------
        LIst<SPE_SPEPlanSupplierMap__c> lstplanmap = new List<SPE_SPEPlanSupplierMap__c>();
        for(SPE_SPEPlan__c plan : lstPlan){ 
            SPE_SPEPlanSupplierMap__c planSuppMap = new SPE_SPEPlanSupplierMap__c();
            planSuppMap.SPEPlan__c = plan.ID;
            planSuppMap.Supplier__c = acc.ID;
            lstplanmap.add(planSuppMap);
        }
        insert lstplanmap;
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'SC Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = st.Id;
        scg.StartDate__c = Date.newInstance(2018,2,15);
        scg.EndDate__c = Date.newInstance(2019,12,15);
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
        scg.isAdhoc__c = true;
        scg.Aggregation_Period_Adhoc__c = 'Monthly';        
        insert scg;
        
        List<SPE_ScorecardSupplierMap__c> listSupplier = new List<SPE_ScorecardSupplierMap__c>();
        for(Integer i=0;i<20;i++){
            SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
            ss.ScorecardGenerator__c = scg.Id;
            ss.Supplier__c = acc1.Id;
            ss.SupplierContact__c = con.Id;
            ss.Approver__c = u.Id;
            listSupplier.add(ss);
        }        
        insert listSupplier;

                  
          //------------SPE Tracker Creation----------------------
         List<SPE_SPETracker__c> lstTracker = new List<SPE_SPETracker__c>();
         for(SPE_SPEPlan__c spePln : lstPlan){
         //   for(Integer i=0;i<2;i++){ 
                SPE_SPETracker__c  trackerObj = new SPE_SPETracker__c();
                trackerObj  = SPE_TestObjectCreator.createSPETracker();
                trackerObj.SPEPlan__c = spePln.ID;
                trackerObj.DateOfExecution__c = date.newinstance(2018,12,10);
                trackerObj.Status__c = 'Completed';
                trackerObj.Name = 'December - 2018';
               lstTracker.add(trackerObj);
            // insert trackerObj;
           }  insert lstTracker; 
           
           insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
         // lstTracker.addAll(lstTracker1);
       //}
       System.debug('@@@@@@@@@lstTracker size='+lstTracker.size()); 
       System.assert(lstTracker != null);
       //--------Tracker Score---------------
      List<SPE_TrackerScore__c> lstTrackerScore = new List<SPE_TrackerScore__c>();
       for(SPE_SPETracker__c  tracker : lstTracker){
               SPE_TrackerScore__c trackerSc = new SPE_TrackerScore__c ();
               trackerSc.Score__c = 1.4000;
               trackerSc.Supplier__c = acc.ID;
               trackerSc.KPIName__c = 'Test PKI';
               trackerSc.Group__c = 'Operational';
               trackerSc.SPETracker__c = tracker.ID;
               trackerSc.SPEScore__c = true;
              // insert trackerSc;
               lstTrackerScore.add(trackerSc);
        }   insert lstTrackerScore;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        System.debug('@@@@@@@@@lstTrackerScore size='+lstTrackerScore.size()); 
        System.assert(lstTrackerScore != null);
       //------------Tracker Value----------------------------
     
 /*      for(SPE_SPETracker__c  tracker :lstTracker){
        List<SPE_TrackerValues__c> lsttrackerValues = new List<SPE_TrackerValues__c>();
       for(Integer i=0;i<2;i++){ 
           SPE_TrackerValues__c trackervAL = SPE_TestObjectCreator.createTrackerValue();
           trackervAL.SPETracker__c = tracker.ID; 
           trackervAL.Supplier__c = acc.ID;
           trackervAL.KPIDefinition__c = kpidefinition1.ID;
           trackervAL.DataLogic__c = 'Assumed';
           trackervAL.Value__c = 2.00;
           trackervAL.Score__c = 1.00;
           trackervAL.Score1__c = 1.4000;
           trackervAL.MissingDatalogic__c = 'Past Data or Category Average';
           lsttrackerValues.add(trackervAL);
       }insert  lsttrackerValues;
       }
 */      //------------SPEScorecard SPETemplateMap----------------------------
         SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
         scTempMap.ScorecardTemplate__c = st.ID;
         scTempMap.SPETemplate__c = speTemplate.ID;
         scTempMap.Weight__c = 100;  
         insert scTempMap;
        
        PageReference pageRef = Page.SPE2_AdhocScorecardPageNew;
        Test.setCurrentPage(pageRef);  
        
      ApexPages.StandardController sc = new ApexPages.StandardController(st);
      SPE2_AdhocScorecardPageEXTNew adhoc = new SPE2_AdhocScorecardPageEXTNew(sc);
     // adhoc.scorecardSupplierList = listSupplier; subwrapperSupplier
      adhoc.DEFAULT_PAGE_SIZE = 2;
      adhoc.spePlanforDate.StartDate__c  = Date.newinstance(2018,10,01); 
      adhoc.spePlanforDate.EndDate__c = Date.newinstance(2019,10,01);
      adhoc.geoScope = 'Project';
      adhoc.catScope = 'Category';
      adhoc.prodScope = 'Product'; 
      adhoc.getGeographyScope();
      adhoc.getCategoryScope();
      adhoc.getProductScope();
      adhoc.getPlanStage();
      adhoc.getPlanSupplier();
      adhoc.showScopePlans(); //Proceed btn
      adhoc.lastBtnClick2();
      adhoc.nextBtnClick2();      
      adhoc.previousBtnClick2();
      adhoc.firstBtnClick2();

      ApexPages.currentPage().getParameters().put('crntPageNum','0');
      adhoc.goToPage2();
      ApexPages.currentPage().getParameters().put('crntPageNum','1');
      adhoc.goToPage2();
      ApexPages.currentPage().getParameters().put('crntPageNum','2');
      adhoc.goToPage2();          
      if(adhoc.maxPages2 != null){
          adhoc.pageNumber2 = adhoc.maxPages2-1;
          adhoc.nextBtnClick2();
      }
     // ApexPages.currentPage().getParameters().put('crntPageNum','100');
     // adhoc.goToPage2();
      adhoc.pageNumber2 =2;
      adhoc.previousBtnClick2();   
      
       for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan : adhoc.scopeplanwraperList){
          sPlan.selected = true;
      } 
      system.debug('adhoc.scopeplanwraperList'+adhoc.scopeplanwraperList);
      system.assert(adhoc.scopeplanwraperList != null);
      
     // adhoc.applyValidation = true;
     // adhoc.wrapperPlanList[0].selected = true;
      
      adhoc.Stage ='All'; 
      adhoc.showPlans();
      adhoc.lastBtnClick();
      adhoc.nextBtnClick();    
      adhoc.previousBtnClick();
      adhoc.firstBtnClick();
      adhoc.pageNumber=2;
      adhoc.previousBtnClick();
      if(adhoc.maxPages != null){
          adhoc.pageNumber = adhoc.maxPages-1;
          adhoc.nextBtnClick();
      }
      
      for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan :  adhoc.wrapperPlanList){
          sPlan.selected = true;
      } 
     
   //  adhoc.showScope = true;
      adhoc.applyValidation = false;
      adhoc.nextfunction(); // Next
    //  system.debug('adhoc.spePlanIds'+adhoc.wrapperPlanList);
    //  system.assert(adhoc.spePlanIds != null);
      adhoc.goToPage3();
      
      adhoc.getPlanSupplier();
      adhoc.scoreCardgenerator.Aggregation_Period_Adhoc__c = 'Monthly';
      adhoc.startDateYear = 2015;
      adhoc.startDateMonth = 01;
      adhoc.EndDateYear = 2016;
      adhoc.EndDateMonth = 12;
      adhoc.scoreCardgenerator.Name= 'Test SC Generator';
      
  //    system.debug('adhoc.spePlanIds'+adhoc.spePlanIds);
   //   system.debug('adhoc.supplierIds'+adhoc.supplierIds);
   //   system.assert(adhoc.spePlanIds != null); 
   //   system.assert(adhoc.supplierIds != null);     
      adhoc.lastBtnClick3();
      adhoc.previousBtnClick3();
      adhoc.firstBtnClick3();
     
      
      ApexPages.currentPage().getParameters().put('crntPageNum','100');
      adhoc.goToPage3();
      adhoc.nextBtnClick3();
      ApexPages.currentPage().getParameters().put('crntPageNum','0');
      adhoc.goToPage3();
      ApexPages.currentPage().getParameters().put('crntPageNum','1');
      adhoc.goToPage3();
      ApexPages.currentPage().getParameters().put('crntPageNum','2');
      adhoc.goToPage3();
      adhoc.pageNumber3 =2;
      adhoc.previousBtnClick3();
      if(adhoc.maxPages3 != null){
          adhoc.pageNumber3 = adhoc.maxPages3-1;
          adhoc.nextBtnClick3();
      }
   /*   if(adhoc.maxPages2 != null){
          string s= ''+adhoc.maxPages2;
          ApexPages.currentPage().getParameters().put('crntPageNum',s);
         adhoc.goToPage2();
     } */
      adhoc.firstBtnClick4();
      adhoc.nextBtnClick4();
      adhoc.previousBtnClick4();
      adhoc.lastBtnClick4();
      ApexPages.currentPage().getParameters().put('crntPageNum','100');
      adhoc.goToPage4();
      ApexPages.currentPage().getParameters().put('crntPageNum','0');
      adhoc.goToPage4();
      ApexPages.currentPage().getParameters().put('crntPageNum','1');
      adhoc.goToPage4();
      ApexPages.currentPage().getParameters().put('crntPageNum','2');
      adhoc.goToPage4();
      adhoc.pageNumber4 = 1;
      adhoc.previousBtnClick4();
      if(adhoc.maxPages4 != null){
          adhoc.pageNumber4 = adhoc.maxPages4-1;
          adhoc.nextBtnClick4();
          
      }
      
      for(SPE2_AdhocScorecardPageEXTNew.wrapperPlan sPlan :  adhoc.containerList){
          sPlan.selected = true;
      }
      
      adhoc.ContinueScorecardGen();
      adhoc.getpopulateYear();
      adhoc.getpopulateMonth();
      adhoc.getpopulateQuarter();
      adhoc.getpopulateHalfYearly();
     
      adhoc.deletePlan();
     adhoc.saveScorecardGen();   
    Test.stopTest();
               
     }
    }    
}