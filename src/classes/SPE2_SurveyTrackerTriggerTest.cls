@isTest(SeeAllData = false)

public class SPE2_SurveyTrackerTriggerTest{    
     static testmethod void Test_SPE2_SurveyTrackerTriggerTest1(){
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
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Deep.Banerjee@atos.net';
        con.DelegatedContact__c = con.Id;
        con.LeaveTo__c = Date.newinstance(2016,01,15);
        con.LeaveFrom__c = Date.newinstance(2020,01,15);
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
       
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2016, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1';
        SurDefObj.Is_One_Time_Survey__c = false; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = null;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerMonth';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2016, 1, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        SurDefObj.Stage__c = 'Published';
        update SurDefObj;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
      //  surQues.MaxScore__c = 1;
        surQues.OperationalType__c = 'Picklist';
      //  surQues.Question_Bank__c = 'Atos_123';
        surQues.Parent_Survey_Question__c = 'Atos_SurvQues123'; 
      //  surQues.PIData__c = lstPIDefObj[0].Id;
        surQues.PIDefinition__c = 'Atos_testPI';
        surQues.PIType__c = 'Atos_Test_PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
       // surQues.CreatedBy = 'u.Id';
       // surQues.LastModifiedBy = 'u.Id';
        insert surQues;  
        
        List<SPE2_SurveyTracker__c > lstsurvtrck = new  List<SPE2_SurveyTracker__c >();
        for(Integer i=0 ;i<=5;i++){  
        SPE2_SurveyTracker__c SurveyTracker = new SPE2_SurveyTracker__c();
        SurveyTracker.Name = 'January - 2016';
        SurveyTracker.Survey__c = SurDefObj.Id;
        SurveyTracker.DateOfExecution__c = System.Today();
    //  SurveyTracker.NewExecution__c = date.newInstance(2016, 8, 17);
        SurveyTracker.CategoryArea__c = 'All Category Areas';
        SurveyTracker.CategoryGroup__c = 'All Category Groups';
        SurveyTracker.Category__c = 'All Categories';
        SurveyTracker.Market__c = 'All Markets';
        SurveyTracker.MarketUnit__c = 'All Market Units';
        SurveyTracker.Country__c =  'All Countries';
        SurveyTracker.Project__c = 'All Projects';
        SurveyTracker.BusinessUnit__c = 'All Business Units';
        SurveyTracker.BusinessLine__c = 'All Business Lines';
        SurveyTracker.Product__c = 'All Products';
        SurveyTracker.SendSurveyLink__c = true;
        lstsurvtrck.add(SurveyTracker);
        }
        insert lstsurvtrck;
        
      
        List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
        for(Integer i=0 ;i<=5;i++){
          SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
          survmap.SPE2_Survey__c= SurDefObj.id;
          survmap.Supplier__c = acc1.id;
          survMaplst.add(survmap);
        }  
        insert survMaplst; 
      
        SPE2_SurveyTrackerRespondent__c surTrakResp = new SPE2_SurveyTrackerRespondent__c();
        surTrakResp.Contact__c =con.Id;
        surTrakResp.Survey__c = SurDefObj.Id;
        surTrakResp.Survey_Tracker__c = lstsurvtrck[0].Id;
        surTrakResp.IsResponseReceived__c = false;
        insert surTrakResp;
      
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = SurDefObj.Id;
        insert surResp;
        
        List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
        for(Integer i=0;i<10;i++){        
            SPE2_Question_Survey_Association__c quesAssoc = new SPE2_Question_Survey_Association__c();
            quesAssoc.AnswerType__c = 'Surveytest';
            quesAssoc.Is_Active__c = true;
            quesAssoc.Is_Required__c = true;
            quesAssoc.PIData__c = lstPIDefObj[0].Id;
            quesAssoc.PIFrequency__c = '1';
            quesAssoc.Question_Bank__c = surQues.Id;
            quesAssoc.QuestionID__c = 'Q-1234';
            quesAssoc.QuestionLabel__c = 'TestQuestion';
            quesAssoc.SurveyRespondent__c = surResp.Id;
            quesAssoc.Supplier__c = acc1.Id;
            quesAssoc.Survey__c = SurDefObj.Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
           }
        insert lstquesAssoc; 
      
        
        SPE2_SurveyTrackerTrigger trcakrObj = new SPE2_SurveyTrackerTrigger();
        SPE2_SurveyTrackerTrigger.UpdateTracker(lstsurvtrck[0]);
      //  SPE2_SurveyTrackerTrigger.isSurveyExecute(lstsurvtrck[0]);
        SPE2_SurveyTrackerTrigger.RespondentRecordGenerate(lstsurvtrck);
        }
        Test.stopTest();    
    }
    static testmethod void Test_SPE2_SurveyTrackerTriggerTest2(){
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
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        

       List<Contact> conList =new List<Contact>();
        for(Integer i=0;i<4;i++){
        Contact con = new Contact();
        con.LastName = 'Test Contact' +i;
        con.AccountId = acc1.Id;
        con.Email = 'Deep.Banerjee'+i+'@atos.net';
       // con.DelegatedContact__c = con.Id;
        con.LeaveTo__c = Date.newinstance(2016,01,15);
        con.LeaveFrom__c = Date.newinstance(2020,01,15);
        conList.add(con);
        }
        insert conList;
        
        
        
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
       
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2016, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1';
        SurDefObj.Is_One_Time_Survey__c = false; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = null;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerMonth';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2016, 1, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        SurDefObj.Stage__c = 'Published';
        update SurDefObj;
        
        System.debug('survey ::'+ SurDefObj);
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
      //  surQues.MaxScore__c = 1;
        surQues.OperationalType__c = 'Picklist';
      //  surQues.Question_Bank__c = 'Atos_123';
        surQues.Parent_Survey_Question__c = 'Atos_SurvQues123'; 
      //  surQues.PIData__c = lstPIDefObj[0].Id;
        surQues.PIDefinition__c = 'Atos_testPI';
        surQues.PIType__c = 'Atos_Test_PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
       // surQues.CreatedBy = 'u.Id';
       // surQues.LastModifiedBy = 'u.Id';
        insert surQues;  
        
        List<SPE2_SurveyTracker__c > lstsurvtrck = new  List<SPE2_SurveyTracker__c >();
        for(Integer i=0 ;i<=5;i++){  
        SPE2_SurveyTracker__c SurveyTracker = new SPE2_SurveyTracker__c();
        SurveyTracker.Name = 'January - 2016';
        SurveyTracker.Survey__c = SurDefObj.Id;
        SurveyTracker.DateOfExecution__c = Date.newInstance(2016,6,15);
    //  SurveyTracker.NewExecution__c = date.newInstance(2016, 8, 17);
        SurveyTracker.CategoryArea__c = 'All Category Areas';
        SurveyTracker.CategoryGroup__c = 'All Category Groups';
        SurveyTracker.Category__c = 'All Categories';
        SurveyTracker.Market__c = 'All Markets';
        SurveyTracker.MarketUnit__c = 'All Market Units';
        SurveyTracker.Country__c =  'All Countries';
        SurveyTracker.Project__c = 'All Projects';
        SurveyTracker.BusinessUnit__c = 'All Business Units';
        SurveyTracker.BusinessLine__c = 'All Business Lines';
        SurveyTracker.Product__c = 'All Products';
        SurveyTracker.SendSurveyLink__c = true;
        lstsurvtrck.add(SurveyTracker);
        }
        insert lstsurvtrck;
         system.debug('send survey link'+ lstsurvtrck) ;   
        List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
        for(Integer i=0 ;i<=5;i++){
          SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
          survmap.SPE2_Survey__c= SurDefObj.id;
          survmap.Supplier__c = acc1.id;
          survMaplst.add(survmap);
        }  
        insert survMaplst; 
      
        List<SPE2_SurveyTrackerRespondent__c> surTrakResplst =new List<SPE2_SurveyTrackerRespondent__c>();
         for (integer i =0 ; i<4; i++){
        SPE2_SurveyTrackerRespondent__c surTrakResp = new SPE2_SurveyTrackerRespondent__c();
        surTrakResp.Contact__c =conList[i].id;
        surTrakResp.Survey__c = SurDefObj.Id;
        surTrakResp.Survey_Tracker__c = lstsurvtrck[0].Id;
        surTrakResp.IsResponseReceived__c = false;
        surTrakResplst.add(surTrakResp);
        }
        insert surTrakResplst;
        
        
        List<SPE2_Survey_Respondents__c> surResList = new List<SPE2_Survey_Respondents__c>();
        for (integer i =0 ; i<4; i++){
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = conList[i].id;
        surResp.IsResponseReceived__c = true;
        surResp.Survey__c = SurDefObj.Id;
        surResList.add(surResp);
        }
        insert surResList;
        
        
        system.debug('surResList ::'+surResList);
        
        List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
        for(Integer i=0;i<10;i++){        
            SPE2_Question_Survey_Association__c quesAssoc = new SPE2_Question_Survey_Association__c();
            quesAssoc.AnswerType__c = 'Surveytest';
            quesAssoc.Is_Active__c = true;
            quesAssoc.Is_Required__c = true;
            quesAssoc.PIData__c = lstPIDefObj[0].Id;
            quesAssoc.PIFrequency__c = '1';
            quesAssoc.Question_Bank__c = surQues.Id;
            quesAssoc.QuestionID__c = 'Q-1234';
            quesAssoc.QuestionLabel__c = 'TestQuestion';
            quesAssoc.SurveyRespondent__c = surResList[0].Id;
            quesAssoc.Supplier__c = acc1.Id;
            quesAssoc.Survey__c = SurDefObj.Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
           }
        insert lstquesAssoc; 
      
        
        SPE2_SurveyTrackerTrigger trcakrObj = new SPE2_SurveyTrackerTrigger();
        SPE2_SurveyTrackerTrigger.UpdateTracker(lstsurvtrck[0]);
       // SPE2_SurveyTrackerTrigger.isSurveyExecute(lstsurvtrck[0]);
        SPE2_SurveyTrackerTrigger.RespondentRecordGenerate(lstsurvtrck);
        }
        Test.stopTest();    
    }
}