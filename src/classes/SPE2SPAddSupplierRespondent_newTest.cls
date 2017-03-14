@isTest(SeeAllData = false)
Public class SPE2SPAddSupplierRespondent_newTest{
      
    static testmethod void SPE2SPAddSupplierRespondent_newTest1(){      
       
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
             spePlan.Region__c = 'All Region';
             spePlan.SubRegion__c = 'All Sub Region';
             spePlan.Country__c = 'All Countries'; 
             spePlan.Project__c = 'All Projects';
             spePlan.Stage__c = 'Draft';
             spePlan.Plan_Identifier__c = System.today()+';'+u.Id;   
             spePlan.CategoryCluster__c = 'All Category Areas';
             spePlan.CategoryGroup__c = 'All Category Groups';
             spePlan.Category__c = 'All Categories';
                
             spePlan.BusinessLine__c ='All Business Lines';
             spePlan.BusinessUnit__c ='All Business Units';
             spePlan.Product__c = 'All Products';
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
        
        list<SPE_Spend__c> ListSpend = new List<SPE_Spend__c>();
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
        ListSpend.add(spend);
        
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
        
        SPE2SPAddSupplierRespondent_new obj = new SPE2SPAddSupplierRespondent_new(System.today()+';');
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPlan);
        obj.finish(bcb);
      }
     Test.stopTest();   
   }
}