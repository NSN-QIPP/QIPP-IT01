@isTest(seeAllData=false)
public class SPE_InsertScorecardSupplierExtNewTest{
    public static testMethod void InsertScorecardSupplierExtNew_Test1(){
      Test.startTest(); 
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
       System.RunAs(u){ 
        List<Account> lstAcc = new  List<Account>();
        Account acc1 = new Account();
        acc1.Name = 'COSCOM';
        acc1.EnterpriseId__c = 'COSCOM';
        insert acc1;
        lstAcc.add(acc1);
        
        Account acc = new Account();
        acc.Name = 'UNITEL';
        acc.EnterpriseId__c = 'UNITEL';
        insert acc;
        lstAcc.add(acc);
        
        List<Contact> conlist = new List<Contact>();
        for(Integer i=0;i<=51;i++){
            Contact con = new Contact();
            con.LastName = 'Test Contact'+i;
            con.AccountId = acc1.Id;
            con.Email = 'dharani.dhakineni'+i+'@atos.net';
            con.isInternal__c =true;
            conlist.add(con);
        }
        insert conlist;
        
        list<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
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
             spePlan.identifierParam__c=System.Today()+';'+u.Id;
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
            // insert spePlan;  
            lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);
       
        //-----------Supplier Creation--------------
        list<Account> lstSupplier=new List<Account>();
        integer j=1;
        for(SPE_SPEPlan__c plan : lstPlan){
            Account a1 = new Account();
            a1.Name = 'Supplier '+j;
            a1.EnterpriseId__c = 'ATOS INDIA '+j;
            lstSupplier.add(a1);
            j++;
          //  insert acc;
        } 
        insert lstSupplier;
        system.debug('lstSupplier ====='+lstSupplier.size()+'++++++++'+lstSupplier );
        
        //--------Supplier related Spends--------------
        list<SPE_Spend__c> spendlst = new list<SPE_Spend__c>();
        for(Account a :lstSupplier){        
           for(integer i=0; i<2; i++){
            SPE_Spend__c spend = new SPE_Spend__c();
            spend.Business_Line__c ='PROD PROC';
            spend.Business_Unit__c = 'PROD BL';
            spend.Category__c = 'IP CG';
            spend.CategoryArea__c = 'IP';
            spend.CategoryGroup__c  = 'IP GP';
            spend.Country__c = 'IND C';
            spend.EnterpriseId__c = a.Id;
            spend.Region__c = 'IND';
            spend.Sub_Region__c = 'IND MX';
            spend.Period__c = System.Today().addMonths(-6);
            spend.Product__c = 'PROD RT';
            spend.Project__c = 'INDP';
            spend.Spend__c = 10850.060 ;
            spend.SpendScopeCombination__c = ''; 
            spend.WBSElements__c = 'G-220081PD1-RWB-OP1-CD18';
            spendlst.add(spend);
           }                
        }
        insert spendlst; 
        for(SPE_Spend__c sp: spendlst){
            sp.SpendScopeCombination__c  = sp.Region__c+';'+sp.Sub_Region__c +';'+sp.Country__c+';'+sp.Project__c+';'+sp.CategoryArea__c +';'+sp.CategoryGroup__c+';'+sp.Category__c+';'+sp.Business_Unit__c +';'+sp.Business_Line__c +';'+sp.Product__c;         
        }
        update spendlst;
        System.debug('spendlst====='+spendlst.size()+'++++++++'+spendlst);
        
        //-------Supplier Plan Map creation-----------------        
        List<SPE_SPEPlanSupplierMap__c> plansupMaplst = new List<SPE_SPEPlanSupplierMap__c>();
        integer k=0;
        for(Account a : lstAcc){
            SPE_SPEPlanSupplierMap__c suppmap = new SPE_SPEPlanSupplierMap__c();
            suppmap.SPEPlan__c =lstPlan[k].id;
            suppmap.Supplier__c =a.id;
            plansupMaplst.add(suppmap);
            k++;
        }
        insert plansupMaplst;
        
        
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
            ss.SupplierContact__c = conlist[0].Id;
            ss.Approver__c = u.Id;
            listSupplier.add(ss);
        }        
        insert listSupplier;
        
        //------------SPEScorecard SPETemplateMap----------------------------
        SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
        scTempMap.ScorecardTemplate__c = st.ID;
        scTempMap.SPETemplate__c = speTemplate.ID;
        scTempMap.Weight__c = 100;  
        insert scTempMap;
        
      //  PageReference pg = Page.SPE_AddSupplier_New;
     //   system.Test.setCurrentPage(pg);
          
        Apexpages.currentpage().getparameters().put('alpha','All');
        ApexPages.StandardController sc = new ApexPages.StandardController(scg);
        SPE_InsertScorecardSupplierExtNew ext = new SPE_InsertScorecardSupplierExtNew(sc);
        ext.firstBtnClick();
        ext.DEFAULT_PAGE_SIZE = 1;
        ext.lastBtnClick();
        ext.nextBtnClick();      
        ext.previousBtnClick();
        ext.firstBtnClick();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        ext.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        ext.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        ext.goToPage(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        ext.goToPage();         
        if(ext.maxPages != null){
          ext.pageNumber = ext.maxPages-1;
          ext.nextBtnClick();
          ext.goToPage(); 
        }
        ext.maxPages = 1;
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        ext.goToPage();
        ext.gotoDetailPage();
        
        ext.supplierName = 'COSCO*';        
        ext.searchSuppliers();
        ext.supplierName ='*OSCOM';
        ext.searchSuppliers();
        ext.supplierName ='*OSCO*';
        ext.searchSuppliers();
        ext.supplierName ='COSCOM';
//        ext.searchSuppliers();        
        Apexpages.currentpage().getparameters().put('alpha2','All');
        ext.alphasortname2();
        ext.firstBtnClick2();
        //Apexpages.currentPage().getParameters().put('supplierName','supplierName*');      
        ext.DEFAULT_PAGE_SIZE2 =1;
        ext.firstBtnClick2();
        ext.lastBtnClick2();
        ext.nextBtnClick2();      
        ext.previousBtnClick2();
        ext.firstBtnClick2();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        ext.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        ext.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        ext.goToPage2(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        ext.goToPage2();         
        if(ext.maxPages2 != null){
          ext.pageNumber2 = ext.maxPages2-1;
          ext.nextBtnClick2();
        }
        ext.maxPages2 = 1;
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        ext.goToPage2();
      //  ext.searchSuppliers();
      
        ext.displayScorecardSupplierWrapper();
        ext.DEFAULT_PAGE_SIZE3 =1;
        ext.firstBtnClick3();
        ext.lastBtnClick3();
        ext.nextBtnClick3();      
        ext.previousBtnClick3();
        ext.firstBtnClick3();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        ext.goToPage3();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        ext.goToPage3();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        ext.goToPage3(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        ext.goToPage3();         
        if(ext.maxPages3 != null){
          ext.pageNumber3 = ext.maxPages3-1;
          ext.nextBtnClick3();
        }
        ext.pageNumber3 = 1;
        ext.goToPage3();
        ext.maxPages3 = 1;
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        ext.goToPage3();
        
        ext.addToMainList();
        //ext.showNextPanel();
       // alphasortname2
        ext.gotoDetailPage();
        ext.gotoDetailPageforNoRecords();    
      }
      Test.stopTest();        
    }
    
    public static testMethod void InsertScorecardSupplierExtNew_Test2(){
      Test.startTest(); 
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
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.EnterpriseId__c = 'Test Enterprise2';
        insert acc2;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Test.Mail@atos.net';
        insert con;
        
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
             spePlan.identifierParam__c=System.Today()+';'+u.Id;
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
            // insert spePlan;  
            lstPlan.add(spePlan);
         }
         insert lstPlan;  
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        for(Integer i=0 ;i<10;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        System.assert(lstPlan != null);
       
        //-----------Supplier Creation--------------
        list<Account> lstSupplier=new List<Account>();
        integer j=1;
        for(SPE_SPEPlan__c plan : lstPlan){
            Account acc = new Account();
            acc.Name = 'Supplier '+j;
            acc.EnterpriseId__c = 'ATOS INDIA '+j;
            lstSupplier.add(acc);
            j++;
          //  insert acc;
        } 
        insert lstSupplier;
        system.debug('lstSupplier ====='+lstSupplier.size()+'++++++++'+lstSupplier );
        
        //--------Supplier related Spends--------------
        list<SPE_Spend__c> spendlst = new list<SPE_Spend__c>();
        for(Account acc :lstSupplier){        
           for(integer i=0; i<2; i++){
            SPE_Spend__c spend = new SPE_Spend__c();
            spend.Business_Line__c ='PROD PROC';
            spend.Business_Unit__c = 'PROD BL';
            spend.Category__c = 'IP CG';
            spend.CategoryArea__c = 'IP';
            spend.CategoryGroup__c  = 'IP GP';
            spend.Country__c = 'IND C';
            spend.EnterpriseId__c = acc.Id;
            spend.Region__c = 'IND';
            spend.Sub_Region__c = 'IND MX';
            spend.Period__c = System.Today().addMonths(-6);
            spend.Product__c = 'PROD RT';
            spend.Project__c = 'INDP';
            spend.Spend__c = 10850.060 ;
            spend.SpendScopeCombination__c = ''; 
            spend.WBSElements__c = 'G-220081PD1-RWB-OP1-CD18';
            spendlst.add(spend);
           }                
        }
        insert spendlst; 
        for(SPE_Spend__c sp: spendlst){
            sp.SpendScopeCombination__c  = sp.Region__c+';'+sp.Sub_Region__c +';'+sp.Country__c+';'+sp.Project__c+';'+sp.CategoryArea__c +';'+sp.CategoryGroup__c+';'+sp.Category__c+';'+sp.Business_Unit__c +';'+sp.Business_Line__c +';'+sp.Product__c;         
        }
        update spendlst;
        System.debug('spendlst====='+spendlst.size()+'++++++++'+spendlst);
        
        //-------Supplier Plan Map creation-----------------        
        for(SPE_SPEPlan__c plan : lstPlan){ 
            LIst<SPE_SPEPlanSupplierMap__c> lstplanmap = new List<SPE_SPEPlanSupplierMap__c>();
            for(Account splr : lstSupplier){
                SPE_SPEPlanSupplierMap__c planSuppMap = new SPE_SPEPlanSupplierMap__c();
                planSuppMap.SPEPlan__c = plan.ID;
                planSuppMap.Supplier__c = splr.ID;
                lstplanmap.add(planSuppMap);
            }
            insert lstplanmap;
        }
        
        
        SPE_ScorecardGenerator__c scg = new SPE_ScorecardGenerator__c();
        scg.Name = 'SC Generator';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = st.Id;
        scg.StartDate__c = Date.newInstance(2018,2,15);
        scg.EndDate__c = Date.newInstance(2019,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';        
        scg.Region__c = 'IND';
        scg.SubRegion__c = 'IND MX';
        scg.Country__c =  'IND C';
        scg.Project__c =  'INDP';        
        scg.CategoryCluster__c = 'IP';
        scg.CategoryGroup__c = 'IP GP';
        scg.Category__c = 'IP CG';          
        scg.BusinessUnit__c = 'PROD PROC';
        scg.BusinessLine__c = 'PROD BL';
        scg.Product__c =  'PROD RT';
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
        
        //------------SPEScorecard SPETemplateMap----------------------------
        SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
        scTempMap.ScorecardTemplate__c = st.ID;
        scTempMap.SPETemplate__c = speTemplate.ID;
        scTempMap.Weight__c = 100;  
        insert scTempMap;  
        
        PageReference pageRef = Page.SPE_InsertScorecardSupplier;
        Test.setCurrentPage(pageRef);
        
        Apexpages.currentpage().getparameters().put('alpha','A');
        ApexPages.StandardController sc = new ApexPages.StandardController(scg);
        SPE_InsertScorecardSupplierExtNew obj= new SPE_InsertScorecardSupplierExtNew(sc);
       // SPE_InsertScorecardSupplierExtNew.SupplierWrapper wrapp = new SPE_InsertScorecardSupplierExtNew.SupplierWrapper();
      //  wrapp.isChecked =true;
       
        
        Apexpages.currentpage().getparameters().put('alpha2','alpha2');
        Apexpages.currentpage().getparameters().put('alpha','alpha');
        Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        obj.sortname2 ='COSCOM';
        obj.sortname ='COSCOM';
       // obj.alphasortname();
        obj.pageNumber =1;
        Apexpages.currentPage().getParameters().put('supplierName','supplierName*');
        obj.supplierName = 'supplierName*';        
        obj.searchSuppliers();
       // obj.supplierName2 ='supplierName2*';
       // obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*supplierName');
        obj.supplierName ='*supplierName';
        obj.searchSuppliers();
        //obj.supplierName2 ='*supplierName2';
       // obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*supplierName*');
        obj.supplierName ='*supplierName*';
        obj.searchSuppliers();
       // obj.supplierName2 ='*supplierName2*';
       // obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','supplierName');
        obj.supplierName ='supplierName';
        obj.alphasortname2();
       // obj.supplierName2 ='supplierName2';
       // obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('crntPageNum2','1'); 
        obj.pageNumber2 =1;
        obj.DEFAULT_PAGE_SIZE = 1;
        obj.DEFAULT_PAGE_SIZE2 =1;
        
      //  obj.selectwrappsupp();        
        //obj.contactName='test';   
        obj.firstBtnClick();
        obj.nextBtnClick();
        obj.previousBtnClick();
       // obj.lastBtnClick();
        obj.goToPage();
        obj.firstBtnClick2();
        obj.nextBtnClick2();
        obj.previousBtnClick2();
        obj.maxPages2 =2;
        obj.lastBtnClick2();
        obj.goToPage2();
        obj.searchSuppliers();
        obj.alphasortname2();
        obj.addToMainList();
        obj.gotoDetailPage();
        //ext.showNextPanel();
        obj.displayScorecardSupplierWrapper();
        obj.gotoDetailPageforNoRecords();
        obj.addToMainList();
      }
      Test.stopTest();        
    }
}