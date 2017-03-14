@isTest(SeeAllData=False)
public class SPE2_PlanAddSupplierext_Test{
     public static testmethod void  PlanAddSupplierextTest1(){
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
        
        PageReference pageRef = Page.SPE2_PlanAddSupplier;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('planIdentifier',system.Now()+';'+u.Id);       
        ApexPages.StandardController sc = new ApexPages.StandardController(st);
        SPE2_PlanAddSupplierext addSupplier1 = new SPE2_PlanAddSupplierext(sc);
        
        addSupplier1.DEFAULT_PAGE_SIZE = 5;
        addSupplier1.fetchSupplier();
              
        System.assert(System.Today()+';'+u.Id == lstPlan[0].identifierParam__c);
        ApexPages.currentPage().getParameters().put('planIdentifier',lstPlan[0].identifierParam__c);
        ApexPages.StandardController controller = new ApexPages.StandardController(lstPlan[0]);
        SPE2_PlanAddSupplierext addSupplier = new SPE2_PlanAddSupplierext(controller);
        
        addSupplier.fetchSupplier(); 
        addSupplier.returnbackToPlan();         
        addSupplier.DEFAULT_PAGE_SIZE2 = 2;
        addSupplier.supplierName = 'INDIA *';
        addSupplier.searchSuppliers();
        addSupplier.returnbackToPlan(); 
         
        addSupplier.supplierName = '* INDIA *';
        addSupplier.searchSuppliers();       
        System.debug('addSupplier.supplierName '+ addSupplier.supplierName);
        System.debug('addSupplier.suppWrapperlist2.size() = '+addSupplier.suppWrapperlist2.size());
        System.assert(addSupplier.suppWrapperlist2.size() != null);
        addSupplier.DEFAULT_PAGE_SIZE2= 2; 
        addSupplier.firstBtnClick2();
        addSupplier.nextBtnClick2();
        addSupplier.previousBtnClick2();
        addSupplier.lastBtnClick2();
        
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        addSupplier.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        addSupplier.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        addSupplier.goToPage2(); 
        if(addSupplier.maxPages2 != null){
          addSupplier.pageNumber2 = addSupplier.maxPages2-1;
          addSupplier.nextBtnClick2();
        }     
        addSupplier.goToPage2();      
        //addSupplier.returnbackToPlan();
        
        for(SPE2_PlanAddSupplierext.SupplierWrapper suppliers :  addSupplier.suppWrapperlist2){
          suppliers.isSelected = true;
        }
        addSupplier.AddToPlans2();
      
       } 
     }
     public static testmethod void  PlanAddSupplierextTest2(){
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
            acc.EnterpriseId__c = 'COSCOM '+j;
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
        
        PageReference pageRef = Page.SPE2_PlanAddSupplier;
        Test.setCurrentPage(pageRef);
        
        System.assert(System.Today()+';'+u.Id == lstPlan[0].identifierParam__c);
        ApexPages.currentPage().getParameters().put('planIdentifier',lstPlan[0].identifierParam__c);
        ApexPages.StandardController sc = new ApexPages.StandardController(lstPlan[0]);
        SPE2_PlanAddSupplierext addSupplier = new SPE2_PlanAddSupplierext(sc);
        addSupplier.fetchSupplier();
        addSupplier.firstBtnClick();
       // addSupplier.nextBtnClick();
        //addSupplier.previousBtnClick();
       // addSupplier.lastBtnClick();
     //   addSupplier.goToSearchPage();   
       // addSupplier.firstBtnClick();     
        System.debug('addSupplier.speplanlist.size() = '+addSupplier.speplanlist.size());  
        System.debug('addSupplier.suppWrapperlist.size() = '+addSupplier.suppWrapperlist.size());
        System.assert(addSupplier.suppWrapperlist.size() != null);
        addSupplier.DEFAULT_PAGE_SIZE = 2;      
        addSupplier.firstBtnClick();
        addSupplier.nextBtnClick();
        addSupplier.previousBtnClick();
        addSupplier.lastBtnClick();
        System.debug('addSupplier.maxPages'+addSupplier.maxPages);
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        addSupplier.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        addSupplier.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        addSupplier.goToPage();          
        if(addSupplier.maxPages != null){
          addSupplier.pageNumber = addSupplier.maxPages-1;
          addSupplier.nextBtnClick();
        }
     
        addSupplier.goToPage();
        
        for(SPE2_PlanAddSupplierext.SupplierWrapper suppliers :  addSupplier.suppWrapperlist){
          suppliers.isSelected = true;
        }
        addSupplier.AddToPlans();
        addSupplier.goToSearchPage();
        addSupplier.DEFAULT_PAGE_SIZE2 = 2; 
        addSupplier.supplierName = 'COSCOM*';
        addSupplier.searchSuppliers();
        System.debug('addSupplier.supplierName '+ addSupplier.supplierName);
        System.debug('addSupplier.suppWrapperlist2.size() = '+addSupplier.suppWrapperlist2.size());
        System.assert(addSupplier.suppWrapperlist2.size() != null);
        addSupplier.DEFAULT_PAGE_SIZE2= 2; 
        addSupplier.firstBtnClick2();
        addSupplier.nextBtnClick2();
        addSupplier.previousBtnClick2();
        addSupplier.lastBtnClick2();
        
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        addSupplier.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        addSupplier.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        addSupplier.goToPage2();       
        //addSupplier.returnbackToPlan();
        
        addSupplier.returnbackToPlan();       
       } 
     }
}