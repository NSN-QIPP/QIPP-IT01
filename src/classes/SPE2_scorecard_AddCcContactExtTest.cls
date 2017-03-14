@isTest(seeAllData=false)
public class SPE2_scorecard_AddCcContactExtTest{
    static testmethod void SPE2_scorecard_AddCcContactExttest1(){
      Test.startTest();
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
        
        List<Contact> conlist = new List<Contact>();
        for(Integer i=0;i<=51;i++){
            Contact con = new Contact();
            con.LastName = 'Atos Test Contact'+i;
            con.AccountId = acc1.Id;
            con.Email = 'Test.Mail'+i+'@atos.net';
            con.isInternal__c =true;
            conlist.add(con);
        }
        insert conlist;
        
        Contact CCcon4 = new Contact();
        CCcon4.LastName = 'Test Contact123456';
        CCcon4.AccountId = acc1.Id;
        CCcon4.Email = 'Testmail@atos.net';
        CCcon4.isInternal__c =true;
           
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
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Scorecard cs';
        businessystrole.Object_Name__c = 'Scorecard cs';
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
         for(Integer i=0;i<=11;i++){
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
        
        list<SPE2_PlanHolder__c> lstPH = new list<SPE2_PlanHolder__c>();
        for(SPE_SPEPlan__c plan :lstPlan){
           SPE2_PlanHolder__c ph = new SPE2_PlanHolder__c();
           ph.SPE_Plan__c = plan.Id;
           ph.UID__c = u.Id;
           lstPH.add(ph);    
        }
        insert lstPH;
        
        List<SPE_SPEPlanSupplierMap__c> plansupMaplst = new List<SPE_SPEPlanSupplierMap__c>();
        for(Integer i=0 ;i<=11;i++){
            SPE_SPEPlanSupplierMap__c suppmap = new SPE_SPEPlanSupplierMap__c();
            suppmap.SPEPlan__c =lstPlan[i].id;
            suppmap.Supplier__c =acc1.id;
            plansupMaplst.add(suppmap);
        }
        insert plansupMaplst;
        
        Contact con = new Contact();
        con.LastName = 'Atos Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'TestMail'+'@atos.net';
        con.isInternal__c =true;
        insert con;         
              
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c= lstPlan[0].Id;
        respondent.Contact__c = con.id;
        insert respondent; 
                      
        PageReference pg = Page.SPE2_PlanAddRespondent2;
        system.Test.setCurrentPage(pg);
        ApexPages.currentPage().getParameters().put('uIdParameter2',u.Id );
        ApexPages.currentPage().getParameters().put('supplierParam2',acc1.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(lstPlan[0]);
        SPE2_scorecard_AddCcContactExt obj = new SPE2_scorecard_AddCcContactExt(sc);  
        obj.getBusinessList();
        obj.getSystemList();
        obj.closePopup();
        obj.showPopup();
        obj.savecontact();
        obj.con = CCcon4;
        obj.savecontact();     
        obj.showInternalContactOnly();  
        obj.DEFAULT_PAGE_SIZE = 1;     
        obj.lastBtnClick();
        obj.nextBtnClick();      
        obj.previousBtnClick();
        obj.firstBtnClick();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','4');
        obj.goToPage(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        obj.goToPage();         
        if(obj.maxPages != null){
          obj.pageNumber = obj.maxPages-1;
          obj.nextBtnClick();
          obj.goToPage(); 
        }
        obj.firstBtnClick();
        obj.goToSearchPage();
        
        obj.contactName='Test Contact';
        obj.searchSuppliers();
        obj.contactName='*Test*';
        obj.searchSuppliers();
        obj.contactName='*Test';
        obj.searchSuppliers();
        obj.contactName='Test*';
        obj.searchSuppliers();
        
        obj.returnbackToPlan();
        obj.searchInternalContact();
        obj.contactName='Test Contact';
        obj.searchInternalContact();
        obj.contactName='*Test';
        obj.searchInternalContact();
        obj.contactName='*Test*'; 
        obj.searchInternalContact();
        obj.DEFAULT_PAGE_SIZE2 = 5;
        obj.lastBtnClick2();
        obj.nextBtnClick2();      
        obj.previousBtnClick2();
        obj.firstBtnClick2();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','4');
        obj.goToPage2(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        obj.goToPage();         
        if(obj.maxPages2 != null){
          obj.pageNumber2 = obj.maxPages2-1;
          obj.nextBtnClick2();
        }
        obj.firstBtnClick2();
        obj.AddToPlans();
        obj.AddRespondent();
                
        Test.stopTest(); 
        }
    }
    static testmethod void SPE2_scorecard_AddCcContactExttest2(){
    
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
        acc1.Name = 'COSCOM';
        acc1.EnterpriseId__c = 'COSCOM';
        insert acc1;
        
       // List<Contact> conlist = new List<Contact>();
       // for(Integer i=0;i<=51;i++){
            Contact con = new Contact();
            con.LastName = 'Test Contact';
            con.AccountId = acc1.Id;
            con.Email = 'dharani.dhakineni@atos.net';
            con.isInternal__c =true;
            insert con;
       // }
       // insert conlist;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1234';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'dharaniMail1@atos.net';
        CCcon1.isInternal__c =true;
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact12345';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'dharaniMail2@atos.net';
        CCcon2.isInternal__c =true;
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact123456';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'dharaniMail3@atos.net';
        CCcon3.isInternal__c =true;
        insert CCcon3;
        
        Contact CCcon4 = new Contact();
        CCcon4.LastName = 'Test Contact123456';
        CCcon4.AccountId = acc1.Id;
        CCcon4.Email = 'Testmail@atos.net';
        CCcon4.isInternal__c =true;
        
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
        
             
       List<SPE_SPEPlanSupplierMap__c> plansupMaplst = new List<SPE_SPEPlanSupplierMap__c>();
          for(Integer i=0 ;i<=51;i++){
            SPE_SPEPlanSupplierMap__c suppmap = new SPE_SPEPlanSupplierMap__c();
            suppmap.SPEPlan__c =lstPlan[0].id;
            suppmap.Supplier__c =acc1.id;
            plansupMaplst.add(suppmap);
          }
       insert plansupMaplst;
       system.debug('plansupMaplst ::'+plansupMaplst[0]);
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'May - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = lstPlan[0].Id;
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
        scg.Region__c = 'IND';
        scg.SubRegion__c = 'IND MX';
        scg.Country__c = 'IND C';
        scg.Project__c = 'INDP';              
        scg.CategoryCluster__c = 'IP';
        scg.CategoryGroup__c = 'IP GP';
        scg.Category__c = 'IP CG';                
        scg.BusinessLine__c ='PROD PROC';
        scg.BusinessUnit__c ='PROD BL';
        scg.Product__c = 'PROD RT';
        scg.isAutoDistributionON__c= true;
        scg.IsAutoApproved__c= true;
        scg.Aggregation_Period_Adhoc__c ='Quarterly';
        scg.AggregationType__c ='Simple Average';
        scg.AdhocScorecardName__c ='scorecardName';
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_Scorecard_Plan__c scoreplan = new SPE_Scorecard_Plan__c(Scorecard_Generator__c  =scg.id,SPE_Plan__c =lstPlan[0].id);
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
        
        SPE2_CC_Contact_Details__c ccContact = new SPE2_CC_Contact_Details__c();
        ccContact.Contact__c =con.id;
        ccContact.Identifier_Param__c = ''+u.Id+acc1.id+u.Id ;
        ccContact.ScoreCard__c =score.id;
        ccContact.Scorecard_Supplier_Map__c =ss.id;
        insert ccContact;
        
        SPE2_PlanHolder__c planhold = new SPE2_PlanHolder__c();
        planhold.SPE_Plan__c =lstPlan[0].id;
        planhold.UID__c = system.today()+';'+u.Id ;
        insert planhold;
        system.debug('planhold ::'+planhold);
        
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c= lstPlan[0].Id;
        respondent.Contact__c = con.id;
        insert respondent; 
        
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
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Scorecard cs';
        businessystrole.Object_Name__c = 'Scorecard cs';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = con.id;
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
                      
        Test.startTest();
              
        PageReference pg = Page.SPE2_PlanAddRespondent2;
        system.Test.setCurrentPage(pg);
        
        ApexPages.currentPage().getParameters().put('uIdParameter2', system.today()+';'+u.Id );
        ApexPages.currentPage().getParameters().put('supplierParam2',acc1.id);
//        apexpages.currentpage().getparameters().put('supplierParam2','COSCOM') ;
        apexpages.currentpage().getparameters().put('scSuppMapIdParam',ss.id) ; 
        ApexPages.StandardController std = new ApexPages.StandardController(lstPlan[0]);
        SPE2_scorecard_AddCcContactExt obj = new SPE2_scorecard_AddCcContactExt(std);
        
      //   Apexpages.currentPage().getParameters().put('crntPageNum','1');      
      // Apexpages.currentPage().getParameters().put('contactName','Test');    
        obj.getBusinessList();
        obj.getSystemList();
        obj.closePopup();
        obj.showPopup();
        obj.savecontact();
        obj.con = CCcon4;
        obj.savecontact(); 
        obj.DEFAULT_PAGE_SIZE = 10;
        obj.showInternalContactOnly();        
        obj.contactName=con.lastname;   
        obj.firstBtnClick();
        obj.nextBtnClick();
        obj.previousBtnClick();
        obj.lastBtnClick();
        obj.goToPage();
        obj.goToSearchPage();
        obj.searchSuppliers();
        obj.searchInternalContact();
        obj.returnbackToPlan();
        obj.firstBtnClick2();
        obj.nextBtnClick2();
        obj.previousBtnClick2();
       // obj.lastBtnClick2();
        obj.goToPage2();
        obj.AddToPlans();
       // obj.AddToPlans2();
                
        Test.stopTest(); 
        }
    }           
}