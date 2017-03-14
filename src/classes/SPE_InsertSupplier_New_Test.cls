@isTest(seeAllData=false)
public class SPE_InsertSupplier_New_Test{
    static testmethod void SPE_InsertSupplier_New_test1(){
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
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
                
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        
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
        kpiDefinition2.ScheduledDate__c = date.newInstance(2016,05,20);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        kpiDefinition2.Buffer_Days__c = 2;
        
        
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
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = system.today();
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Buffer_Days__c = 2;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        list<SPE_KPIDefinition__c> kpiList = new list<SPE_KPIDefinition__c>();
        kpiList.add(kpiDefinition2);
        
        insert kpiList;
        
        SPE_KPICalculation__c KpiCalc = new SPE_KPICalculation__c();
        KpiCalc.Aggregation__c = 'Max';
        KpiCalc.ConstantValue__c = 8;
        KpiCalc.Index__c = 'A';
        KpiCalc.IndexName__c = 'ABC';
        KpiCalc.TimeFrame__c = 4;
        KpiCalc.PIDefination__c = lstPIDefObj[0].id;
        insert KpiCalc;
        
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
        //insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        SPE_Spend__c spend = new SPE_Spend__c();
        spend.Region__c = 'IND';
        spend.Sub_Region__c= 'IND MX';
        spend.Country__c = 'IND C';
        spend.Project__c = 'INDP';             
        spend.CategoryArea__c= 'IP';
        spend.CategoryGroup__c = 'IP GP';
        spend.Category__c = 'IP CG';                
        spend.Business_Line__c ='PROD PROC';
        spend.Business_Unit__c='PROD BL';
        spend.Product__c = 'PROD RT';
        spend.Period__c=Date.newInstance(2016,10,20);
        spend.Spend__c= 2;
        spend.SPEPeriod__c= 'test';
        spend.EnterpriseId__c= acc.id;
        insert spend;
        
        SPE_Spend__c spend2 = new SPE_Spend__c();
        spend2.Region__c = 'IND';
        spend2.Sub_Region__c= 'IND MX';
        spend2.Country__c = 'IND C';
        spend2.Project__c = 'INDP';             
        spend2.CategoryArea__c= 'IP';
        spend2.CategoryGroup__c = 'IP GP';
        spend2.Category__c = 'IP CG';                
        spend2.Business_Line__c ='PROD PROC';
        spend2.Business_Unit__c='PROD BL';
        spend2.Product__c = 'PROD RT';
        spend2.Period__c=Date.newInstance(2016,10,20);
        spend2.Spend__c= 2;
        spend2.SPEPeriod__c= 'test';
        spend2.EnterpriseId__c= acc1.id;
        insert spend2;
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'SPE Plan';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = conlist[i].id;
            catInfo.CategoryScopeCombination__c = 'IND'+';'+'IND MX'+';'+'IND C'+';'+'INDP'+';'+'IP'+';'+'IP GP'+';'+'IP CG'+';'+'PROD PROC'+';'+'PROD BL'+';'+'PROD RT';
            catInfo.Supplier__c =acc1.id;
            catInfo.Region__c = 'IND';
            catInfo.SubRegion__c = 'IND MX';
            catInfo.Country__c = 'IND C';
            catInfo.Project__c = 'INDP';              
            catInfo.CategoryCluster__c = 'IP';
            catInfo.CategoryGroup__c = 'IP GP';
            catInfo.Category__c = 'IP CG';                
            catInfo.BusinessLine__c ='PROD PROC';
            catInfo.BusinessUnit__c ='PROD BL';
            catInfo.Product__c = 'PROD RT';
            catInfoList.add(catInfo);
        }
        insert catInfoList;
        
        List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<2;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;                    
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2020,06,20);       
             spePlan.StartDate__c = Date.newinstance(2020,01,20);
             spePlan.Additional_Days__c  = 5;
             spePlan.SPETemplate__c = speTemp.Id; 
             spePlan.identifierParam__c='planIdentifier';
             spePlan.SurveyExecutionBeforeIndays__c = 5;       
             spePlan.SurveyReminderBeforeExecutionDate__c = 3;
             spePlan.Organization_Group__c = 'Services Procurement';       
             spePlan.FrequencyInMonths__c = '1';
             spePlan.SPEPlanName__c = 'New Demo Plan 122';
             spePlan.AggregationDuration__c = '1';
             spePlan.Next_Computed_Day__c = Date.newinstance(2016,01,01);
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
             spePlan.Stage__c = 'Draft';
             spePlan.OwnerId = u.ID;
             lstPlan.add(spePlan);
           }
        insert lstPlan;
        
        /*for(Integer i=0 ;i<=11;i++){
            lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;*/
        //System.assert(lstPlan != null);
        
        List<SPE_SPEPlanSupplierMap__c> plansupMaplst = new List<SPE_SPEPlanSupplierMap__c>();
        integer i=0;
        for(Account a : lstAcc){
            SPE_SPEPlanSupplierMap__c suppmap = new SPE_SPEPlanSupplierMap__c();
            suppmap.SPEPlan__c =lstPlan[i].id;
            suppmap.Supplier__c =a.id;
            plansupMaplst.add(suppmap);
            i++;
        }
        insert plansupMaplst;
               
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c= lstPlan[0].Id;
        respondent.Contact__c = conlist[0].id;
        insert respondent; 
                      
        PageReference pg = Page.SPE_AddSupplier_New;
        system.Test.setCurrentPage(pg);

        Apexpages.currentpage().getparameters().put('alpha','All');
        ApexPages.StandardController sc = new ApexPages.StandardController(lstPlan[0]);
        for(Account a : lstAcc){
            SPE_InsertSupplier_New.SupplierWrapper wrapp = new SPE_InsertSupplier_New.SupplierWrapper();
            wrapp.isChecked =true;        
            wrapp.isSelected=true;
        }
        SPE_InsertSupplier_New obj = new SPE_InsertSupplier_New(sc);

        obj.DEFAULT_PAGE_SIZE = 1;
        obj.lastBtnClick();
        obj.nextBtnClick();      
        obj.previousBtnClick();
        obj.firstBtnClick();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        obj.goToPage(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        obj.goToPage();         
        if(obj.maxPages != null){
          obj.pageNumber = obj.maxPages-1;
          obj.nextBtnClick();
          obj.goToPage(); 
        }
        obj.firstBtnClick();
        obj.gotoDetailPage();
                
        Apexpages.currentpage().getparameters().put('alpha2','All');
        obj.alphasortname2();
        //Apexpages.currentPage().getParameters().put('supplierName','supplierName*');      
       
        obj.supplierName = 'COSCO*';        
        obj.searchSuppliers();
        obj.supplierName ='*OSCOM';
        obj.searchSuppliers();
        obj.supplierName ='*OSCO*';
        obj.searchSuppliers();
        obj.supplierName ='COSCOM';
        obj.searchSuppliers();
        
        obj.supplierName2 ='COSCOM*';
        obj.selectwrappsupp();
        obj.supplierName2 ='*COSCOM';
        obj.selectwrappsupp();
        obj.supplierName2 ='*COSCOM*';
        obj.selectwrappsupp();
        obj.supplierName2 ='COSCOM';
        obj.selectwrappsupp();
        
         obj.DEFAULT_PAGE_SIZE2 =1;
        obj.lastBtnClick2();
        obj.nextBtnClick2();      
        obj.previousBtnClick2();
        obj.firstBtnClick2();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        obj.goToPage2(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        obj.goToPage2();         
        if(obj.maxPages2 != null){
          obj.pageNumber2 = obj.maxPages2-1;
          obj.nextBtnClick2();
        
        }
      //    obj.goToPage2(); 
       /*  if(obj.subwrapperList2.size() != Null){
            for(SPE_InsertSupplier_New.SupplierWrapper suppWrp : obj.subwrapperList2){
                suppWrp.isChecked = true;
            }
        }  */
        obj.addToMainList();
       
        Test.stopTest(); 
        }
    } 
    static testmethod void SPE_InsertSupplier_New_test2(){
           
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
        
        Account acc = new Account();
        acc.Name = 'UNITEL';
        acc.EnterpriseId__c = 'UNITEL';
        insert acc;
        
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
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
                
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        
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
        kpiDefinition2.ScheduledDate__c = date.newInstance(2016,05,20);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        kpiDefinition2.Buffer_Days__c = 2;
        
        
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
        kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = system.today();
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Buffer_Days__c = 2;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        list<SPE_KPIDefinition__c> kpiList = new list<SPE_KPIDefinition__c>();
        kpiList.add(kpiDefinition2);
        
        insert kpiList;
        
        SPE_KPICalculation__c KpiCalc = new SPE_KPICalculation__c();
        KpiCalc.Aggregation__c = 'Max';
        KpiCalc.ConstantValue__c = 8;
        KpiCalc.Index__c = 'A';
        KpiCalc.IndexName__c = 'ABC';
        KpiCalc.TimeFrame__c = 4;
        KpiCalc.PIDefination__c = lstPIDefObj[0].id;
        insert KpiCalc;
        
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
        //insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        List<SPE_Spend__c> spendList = new List<SPE_Spend__c>();
        for(integer i=0;i<=51;i++){
            SPE_Spend__c spend =new SPE_Spend__c();
            spend.Region__c = 'IND';
            spend.Sub_Region__c= 'IND MX';
            spend.Country__c = 'IND C';
            spend.Project__c = 'INDP';             
            spend.CategoryArea__c= 'IP';
            spend.CategoryGroup__c = 'IP GP';
            spend.Category__c = 'IP CG';                
            spend.Business_Line__c ='PROD PROC';
            spend.Business_Unit__c='PROD BL';
            spend.Product__c = 'PROD RT';
            spend.Period__c=Date.newInstance(2016,10,20);
            spend.Spend__c= 2;
            spend.SPEPeriod__c= 'test';
            spend.EnterpriseId__c= acc.id;
            spendList.add(spend);
        }
        insert spendList;
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'SPE Plan';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = conlist[i].id;
            catInfo.CategoryScopeCombination__c = 'IND'+';'+'IND MX'+';'+'IND C'+';'+'INDP'+';'+'IP'+';'+'IP GP'+';'+'IP CG'+';'+'PROD PROC'+';'+'PROD BL'+';'+'PROD RT';
            catInfo.Supplier__c =acc1.id;
            catInfo.Region__c = 'IND';
            catInfo.SubRegion__c = 'IND MX';
            catInfo.Country__c = 'IND C';
            catInfo.Project__c = 'INDP';              
            catInfo.CategoryCluster__c = 'IP';
            catInfo.CategoryGroup__c = 'IP GP';
            catInfo.Category__c = 'IP CG';                
            catInfo.BusinessLine__c ='PROD PROC';
            catInfo.BusinessUnit__c ='PROD BL';
            catInfo.Product__c = 'PROD RT';
            catInfoList.add(catInfo);
        }
        insert catInfoList;
        
        List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<=51;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c= 'Atos Plan'+i;                    
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.EndDate__c = Date.newinstance(2020,06,20);       
             spePlan.StartDate__c = Date.newinstance(2020,01,20);
             spePlan.Additional_Days__c  = 5;
             spePlan.SPETemplate__c = speTemp.Id; 
             spePlan.identifierParam__c='planIdentifier';
             spePlan.SurveyExecutionBeforeIndays__c = 5;       
             spePlan.SurveyReminderBeforeExecutionDate__c = 3;
             spePlan.Organization_Group__c = 'Services Procurement';       
             spePlan.FrequencyInMonths__c = '1';
             spePlan.SPEPlanName__c = 'New Demo Plan 122';
             spePlan.AggregationDuration__c = '1';
             spePlan.Next_Computed_Day__c = Date.newinstance(2016,01,01);
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
             spePlan.Stage__c = 'Draft';
             spePlan.OwnerId = u.ID;
             lstPlan.add(spePlan);
           }
        insert lstPlan;
        
        /*for(Integer i=0 ;i<=11;i++){
            lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;*/
        //System.assert(lstPlan != null);
        
        List<SPE_SPEPlanSupplierMap__c> plansupMaplst = new List<SPE_SPEPlanSupplierMap__c>();
        for(Integer i=0 ;i<=51;i++){
            SPE_SPEPlanSupplierMap__c suppmap = new SPE_SPEPlanSupplierMap__c();
            suppmap.SPEPlan__c =lstPlan[i].id;
            suppmap.Supplier__c =acc1.id;
            plansupMaplst.add(suppmap);
        }
        insert plansupMaplst;
               
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c= lstPlan[0].Id;
        respondent.Contact__c = conlist[0].id;
        insert respondent; 
                      
        Test.startTest();
        
        PageReference pg = Page.SPE_AddSupplier_New;
        system.Test.setCurrentPage(pg);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lstPlan[0]);
        SPE_InsertSupplier_New obj = new SPE_InsertSupplier_New(sc);
        SPE_InsertSupplier_New.SupplierWrapper wrapp = new SPE_InsertSupplier_New.SupplierWrapper();
        wrapp.isChecked =true;
        Apexpages.currentpage().getparameters().put('alpha2','alpha2');
        Apexpages.currentpage().getparameters().put('alpha','alpha');
        Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        Apexpages.currentpage().getparameters().put('sortname2','COSCOM');
        Apexpages.currentpage().getparameters().put('sortname','COSCOM');
        obj.sortname2 ='COSCOM';
        obj.sortname ='COSCOM';
        obj.alphasortname();
        obj.pageNumber =1;
        Apexpages.currentPage().getParameters().put('supplierName','supplierName*');
        obj.supplierName = 'supplierName*';        
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*supplierName');
        obj.supplierName ='*supplierName';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*supplierName*');
        obj.supplierName ='*supplierName*';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','supplierName');
        obj.supplierName ='supplierName';
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('crntPageNum2','1'); 
        obj.pageNumber2 =1;
        obj.DEFAULT_PAGE_SIZE = 10;
        obj.DEFAULT_PAGE_SIZE2 =10;
        
        obj.selectwrappsupp();        
        //obj.contactName='test';   
        obj.firstBtnClick();
        obj.nextBtnClick();
        obj.previousBtnClick();
        obj.lastBtnClick();
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
                
        Test.stopTest(); 
        }
    } 
}