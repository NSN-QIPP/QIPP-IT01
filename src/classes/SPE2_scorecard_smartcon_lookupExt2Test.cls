@isTest(seeAllData=false)
public class SPE2_scorecard_smartcon_lookupExt2Test{
    static testmethod void SPE2_scorecard_smartcontact_lookupExt2_test1(){
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
            con.FirstName = '';
            con.LastName = 'Atos Test Contact'+i;
            con.AccountId = acc1.Id;
            con.Email = 'Test.Mail'+i+'@atos.net';
            con.isInternal__c =true;
            conlist.add(con);
        }
        insert conlist;
        system.debug('conlist ::'+conlist[0]);
        Contact con1 = new Contact();
        con1.LastName = 'Atos Test Contact';
        con1.AccountId = acc1.Id;
        con1.Email = 'Test.Mail@atos.net';
        con1.isInternal__c =true;
      
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
      // kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = system.today();
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Buffer_Days__c = 2;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
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
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Scorecard Generator';
        businessystrole.Object_Name__c = 'Scorecard Generator';
        businessystrole.Business_Role__c ='Supplier Quality Manager (SQM);Category Manager;Supplier Manager;Country Manager;Project Manager;Regional Category Manager';
        businessystrole.System_Role__c ='Scorecard Approver';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
        system.debug('Businessrole::'+BusinessroleList);
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
         system.debug('score template::'+st);
       
        List<SPE_ScorecardGenerator__c> lstscg= new list<SPE_ScorecardGenerator__c>();
      //  for(integer i = 0; i< 5; i++ ){ 
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
        scg.Country__c = 'IND C';
        scg.Project__c = 'INDP';              
        scg.CategoryCluster__c = 'IP';
        scg.CategoryGroup__c = 'IP GP';
        scg.Category__c = 'IP CG';                
        scg.BusinessLine__c ='PROD PROC';
        scg.BusinessUnit__c ='PROD BL';
        scg.Product__c = 'PROD RT';
        scg.isAdhoc__c = true;
        scg.Aggregation_Period_Adhoc__c = 'Monthly'; 
        insert scg;       
        lstscg.add(scg);
       // }
       // insert lstscg;
        system.debug('score Generatorid::'+scg.id);
         system.debug('score Generator::'+scg);
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<= 51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Scorecard Approver';
            catInfo.Contact__c = conlist[i].id;
            catInfo.CategoryScopeCombination__c = 'IND'+';'+'IND MX'+';'+'IND C'+';'+'INDP'+';'+'IP'+';'+'IP GP'+';'+'IP CG'+';'+'PROD PROC'+';'+'PROD BL'+';'+'PROD RT';
           //  sp.Region__c+';'+sp.SubRegion__c+';'+sp.Country__c+';'+sp.Project__c+';'+sp.CategoryCluster__c+';'+sp.CategoryGroup__c+';'+sp.Category__c+';'+sp.BusinessUnit__c+';'+sp.BusinessLine__c+';'+sp.Product__c;
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
        system.debug('catInfoList ::'+catInfoList);
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
        
        List<SPE_Respondent__c> lsRresp = new List<SPE_Respondent__c>();
        for(SPE_SPEPlan__c plan :lstPlan){      
            SPE_Respondent__c respondent = new SPE_Respondent__c();
            respondent.SPEPlan__c= plan.Id;
            respondent.Contact__c = conlist[0].id;
            lsRresp .add(respondent); 
        }
        insert lsRresp;
                       
        List<SPE_ScorecardSupplierMap__c> listSupplier = new List<SPE_ScorecardSupplierMap__c>();
        for(SPE_ScorecardGenerator__c sg : lstscg){
            SPE_ScorecardSupplierMap__c ss = new SPE_ScorecardSupplierMap__c();
            ss.ScorecardGenerator__c = sg.Id;
            ss.Supplier__c = acc1.Id;
            ss.SupplierContact__c = conlist[0].id;
            ss.Approver__c = u.Id;
            listSupplier.add(ss);
        }        
        insert listSupplier;                       
        system.debug('score supplier::'+listSupplier);
       // try{        
            PageReference pg = Page.SPE2_scorecard_smartcontact_lookup;
            system.Test.setCurrentPage(pg);
            ApexPages.currentPage().getParameters().put('uIdParameter',scg.id);
            ApexPages.currentPage().getParameters().put('supplierParam',acc1.id);
            ApexPages.currentPage().getParameters().put('idSGID',scg.id);
            SPE2_scorecard_smartcontact_lookupExt2 controller= new SPE2_scorecard_smartcontact_lookupExt2();
            controller.getBusinessList();
            controller.getSystemList();
            controller.closePopup();
            controller.showPopup();
            controller.savecontact();
            controller.closePopup2();
            controller.showPopup2();
           // controller.savecontact2();
            controller.con = con1;
            controller.savecontact();
            controller.savecontact2();
            controller.showInternalContactOnly();
            controller.DEFAULT_PAGE_SIZE = 1;       
            controller.lastBtnClick();
            controller.nextBtnClick();      
            controller.previousBtnClick();
            controller.firstBtnClick();
            ApexPages.currentPage().getParameters().put('crntPageNum','0');
            controller.goToPage();
            ApexPages.currentPage().getParameters().put('crntPageNum','1');
            controller.goToPage();
            ApexPages.currentPage().getParameters().put('crntPageNum','4');
            controller.goToPage(); 
            ApexPages.currentPage().getParameters().put('crntPageNum','100');
            controller.goToPage();         
            if(controller.maxPages != null){
              controller.pageNumber = controller.maxPages-1;
              controller.nextBtnClick();
              controller.goToPage(); 
            }
            controller.firstBtnClick();
            controller.goToSearchPage();
            
            controller.contactName='Test Contact';
            controller.searchSuppliers();
            controller.contactName='*Test*';
            controller.searchSuppliers();
            controller.contactName='*Test';
            controller.searchSuppliers();
            controller.contactName='Test*';
            controller.searchSuppliers();
            
            controller.returnbackToPlan();
            controller.searchInternalContact();
            controller.contactName='Test Contact';
            controller.searchInternalContact();
            controller.contactName='*Test';
            controller.searchInternalContact();
            controller.contactName='*Test*'; 
            controller.searchInternalContact();
            controller.DEFAULT_PAGE_SIZE2 = 5;
            controller.lastBtnClick2();
            controller.nextBtnClick2();      
            controller.previousBtnClick2();
            controller.firstBtnClick2();
            ApexPages.currentPage().getParameters().put('crntPageNum','0');
            controller.goToPage2();
            ApexPages.currentPage().getParameters().put('crntPageNum','1');
            controller.goToPage2();
            ApexPages.currentPage().getParameters().put('crntPageNum','4');
            controller.goToPage2(); 
            ApexPages.currentPage().getParameters().put('crntPageNum','100');
            controller.goToPage();         
            if(controller.maxPages2 != null){
              controller.pageNumber2 = controller.maxPages2-1;
              controller.nextBtnClick2();
            }
            controller.firstBtnClick2();
           // controller.AddToPlans();
          //  controller.AddToPlans2();
     // }catch(Exception e){}
      
      Test.stopTest();   
      }
    }
}