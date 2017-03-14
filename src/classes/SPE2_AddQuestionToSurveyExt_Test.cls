@isTest(SeeAllData=False)
private class SPE2_AddQuestionToSurveyExt_Test{
    static testmethod void SPE2_AddQuestionToSurveyExt_Test1(){
     
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
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna1@gmail.com';
        insert con;
        
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
                     
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;     
            
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Market__c = 'IND';
            speSurvey.MarketUnit__c = 'IND MX';
            speSurvey.Country__c = 'IND C';
            speSurvey.Project__c = 'INDP';             
            speSurvey.CategoryArea__c= 'IP';
            speSurvey.CategoryGroup__c = 'IP GP';
            speSurvey.Category__c = 'IP CG';                
            speSurvey.BusinessLine__c ='PROD PROC';
            speSurvey.BusinessUnit__c ='PROD BL';
            speSurvey.Product__c = 'PROD RT';
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
            speSurvey.Day_name_of_upload_week__c = 'Sunday';
            speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
            speSurvey.Month_Upload_Day__c = 7;
            speSurvey.Recurrence_frequency_type__c = 'Monthly';
            speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
            speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.Survey_Shut_Down__c = 1;
            speSurvey.Upload_Day__c = 2;
            speSurvey.Week_Count__c = 'First';
            speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
            speSurvey.Yearly_Week_Count__c = 'Second';  
            lstsurvey.add(speSurvey);   
           }  
         insert lstsurvey;

        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = lstsurvey[0].Id;
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
            quesAssoc.Survey__c = lstsurvey[0].Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
           }
        insert lstquesAssoc;
        
        PageReference pageRef = Page.SPE2_AddQuestionToSurvey;
        Test.setCurrentPage(pageRef); 
         
        Test.StartTest();
        Apexpages.currentpage().getparameters().put('alpha','All');       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(lstsurvey[0]);       
        SPE2_AddQuestionToSurveyExt.QuestionWrapper QW = new SPE2_AddQuestionToSurveyExt.QuestionWrapper();  
        QW.isChecked = true;
        QW.isSelected = true;
        SPE2_AddQuestionToSurveyExt obj = new SPE2_AddQuestionToSurveyExt (stCon);
      //  Apexpages.currentpage().getparameters().put('alpha','u');
      //  obj.alphasortname();
        obj.DEFAULT_PAGE_SIZE = 1;
      //  obj.alphasortname();
        obj.selectwrappsupp();
        obj.DEFAULT_PAGE_SIZE = 1; 
        obj.nextBtnClick();  
        obj.DEFAULT_PAGE_SIZE = 1;
        obj.previousBtnClick();
        obj.DEFAULT_PAGE_SIZE = 1;
        obj.lastBtnClick();
        obj.DEFAULT_PAGE_SIZE = 1;        
        obj.firstBtnClick();
        obj.DEFAULT_PAGE_SIZE = 1;
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        obj.goToPage();         
        if(obj.maxPages != null){
          obj.pageNumber = obj.maxPages-1;
          obj.nextBtnClick();
          obj.goToPage(); 
        }
        obj.firstBtnClick();
        
        Apexpages.currentpage().getparameters().put('alpha2','All');
        obj.alphasortname2();
        if(obj.subwrapperList2.size() != Null){
            for(SPE2_AddQuestionToSurveyExt.QuestionWrapper quesWrp : obj.subwrapperList2){
                quesWrp.isChecked = true;
            }
        }
        obj.supplierName = 'COSCOM*';        
        obj.searchSuppliers();
        obj.supplierName2 ='COSCOM*';
        obj.selectwrappsupp();
        obj.supplierName ='*COSCOM';
        obj.searchSuppliers();
        obj.supplierName2 ='*COSCOM';
        obj.selectwrappsupp();
        obj.supplierName ='*COSCOM*';
        obj.searchSuppliers();
        obj.supplierName2 ='*COSCOM*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','supplierName');
        obj.supplierName ='COSCOM';
        obj.searchSuppliers();
        obj.supplierName2 ='COSCOM';
        obj.selectwrappsupp();
        obj.DEFAULT_PAGE_SIZE2 = 10;
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
        if(obj.maxPages2 != null){
          obj.pageNumber2 = obj.maxPages2-1;
          obj.nextBtnClick2();
          obj.goToPage2(); 
        }
        obj.firstBtnClick2();        
        obj.selectwrappsupp();                      
        obj.addToMainList();
        obj.gotoDetailPage();
        
        Test.StopTest();
        }    
    }      
    static testmethod void SPE2_AddQuestionToSurveyExt_Test2(){
     
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
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna1@gmail.com';
        insert con;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = false;
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
                     
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;     
            
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Market__c = 'IND';
            speSurvey.MarketUnit__c = 'IND MX';
            speSurvey.Country__c = 'IND C';
            speSurvey.Project__c = 'INDP';             
            speSurvey.CategoryArea__c= 'IP';
            speSurvey.CategoryGroup__c = 'IP GP';
            speSurvey.Category__c = 'IP CG';                
            speSurvey.BusinessLine__c ='PROD PROC';
            speSurvey.BusinessUnit__c ='PROD BL';
            speSurvey.Product__c = 'PROD RT';
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
            speSurvey.Day_name_of_upload_week__c = 'Sunday';
            speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
            speSurvey.Month_Upload_Day__c = 7;
            speSurvey.Recurrence_frequency_type__c = 'Monthly';
            speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
            speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.Survey_Shut_Down__c = 1;
            speSurvey.Upload_Day__c = 2;
            speSurvey.Week_Count__c = 'First';
            speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
            speSurvey.Yearly_Week_Count__c = 'Second';  
            lstsurvey.add(speSurvey);   
           }  
         insert lstsurvey;

        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = lstsurvey[0].Id;
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
            quesAssoc.Survey__c = lstsurvey[0].Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
           }
        insert lstquesAssoc;
        
        PageReference pageRef = Page.SPE2_AddQuestionToSurvey;
        Test.setCurrentPage(pageRef); 
         
        Test.StartTest();
        Apexpages.currentpage().getparameters().put('alpha','All');       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(lstsurvey[0]);       
        SPE2_AddQuestionToSurveyExt.QuestionWrapper QW = new SPE2_AddQuestionToSurveyExt.QuestionWrapper(); 
        QW.compareTo(QW); 
        QW.isChecked = true;
        QW.isSelected = true;
        SPE2_AddQuestionToSurveyExt obj = new SPE2_AddQuestionToSurveyExt(stCon);        
        Apexpages.currentpage().getparameters().put('alpha2','alpha2');
        Apexpages.currentpage().getparameters().put('alpha','alpha');
        Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        Apexpages.currentpage().getparameters().put('sortname2','COSCOM');
        Apexpages.currentpage().getparameters().put('sortname','COSCOM');
        obj.sortname2 ='COSCOM';
        obj.sortname ='COSCOM';
      //  obj.alphasortname();
        obj.pageNumber =4;
        Apexpages.currentPage().getParameters().put('supplierName','supplierName*');
        obj.supplierName = 'surQues.QuestionLabel__c*';        
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*supplierName');
        obj.supplierName ='*supplierName';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*supplierName*');
        obj.supplierName ='*surQues.QuestionLabel__c*';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','supplierName');
        obj.supplierName ='surQues.QuestionLabel__c';
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('crntPageNum2','1'); 
        obj.pageNumber2 = 2;
        obj.DEFAULT_PAGE_SIZE = 15;
        obj.DEFAULT_PAGE_SIZE2 =15;
        obj.supplierName = surQues.QuestionLabel__c;
        obj.searchSuppliers();  
        obj.selectwrappsupp();        
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
        
        Test.StopTest();
        }
     
      }
      static testmethod void SPE2_AddQuestionToSurveyExt_Test3(){
     
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
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna1@gmail.com';
        insert con;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = false;
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
                     
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;     
            
        //List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
      //  for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Survey_Title__c ='New Survey';
            speSurvey.Market__c = 'All Markets';
            speSurvey.MarketUnit__c = 'All Market Units';
            speSurvey.Country__c = 'All Countries';
            speSurvey.Project__c = 'All Projects';             
            speSurvey.CategoryArea__c= 'All Category Areas';
            speSurvey.CategoryGroup__c = 'All Category Groups';
            speSurvey.Category__c = 'All Categories';                
            speSurvey.BusinessLine__c ='All Business Lines';
            speSurvey.BusinessUnit__c ='All Business Units';
            speSurvey.Product__c = 'All Products';
           // speSurvey.Additional_Days__c = 2;
         //   speSurvey.Additional_Days_for_week__c = 2;
           // speSurvey.Day_name_of_upload_week__c = 'Sunday';
          //  speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
          //  speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
           // speSurvey.Month_Upload_Day__c = 7;
          //  speSurvey.Recurrence_frequency_type__c = 'Monthly';
          //  speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
           // speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = system.today()+2;
            speSurvey.Survey_Shut_Down__c = 1;
           // speSurvey.Upload_Day__c = 2;
         //   speSurvey.Week_Count__c = 'First';
           // speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
           // speSurvey.Yearly_Week_Count__c = 'Second';  
          //  lstsurvey.add(speSurvey);   
          // }  
         insert speSurvey;
         system.debug('speSurvey ::'+speSurvey);
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = speSurvey.Id;
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
            quesAssoc.Survey__c = speSurvey.Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
           }
        insert lstquesAssoc;
        
        PageReference pageRef = Page.SPE2_AddQuestionToSurvey;
        Test.setCurrentPage(pageRef); 
         
        Test.StartTest();
        Apexpages.currentpage().getparameters().put('alpha','All');       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speSurvey);  
        SPE2_AddQuestionToSurveyExt obj = new SPE2_AddQuestionToSurveyExt(stCon);      
        SPE2_AddQuestionToSurveyExt.QuestionWrapper QW = new SPE2_AddQuestionToSurveyExt.QuestionWrapper(); 
        QW.compareTo(QW); 
        QW.isChecked = true;
        QW.idEntId =acc1.id;
        QW.isSelected = true;              
        Apexpages.currentpage().getparameters().put('alpha2',null);
        Apexpages.currentpage().getparameters().put('alpha', null);
        Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        Apexpages.currentpage().getparameters().put('sortname2',null);
        Apexpages.currentpage().getparameters().put('sortname','Atos*');
        obj.sortname2 =null;
        obj.DEFAULT_PAGE_SIZE2 =10;
        obj.alphasortname2();
        obj.sortname ='COSCOM';
      //  obj.alphasortname();
        obj.pageNumber =4;
        Apexpages.currentPage().getParameters().put('supplierName','Ato*');
        obj.supplierName = 'Ato*';        
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*Ato');
        obj.supplierName ='*os';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*Ato*');
        obj.supplierName ='*At*';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','Ato');
        obj.supplierName ='Ato';
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('crntPageNum2','1'); 
        
        obj.DEFAULT_PAGE_SIZE = 10;
        
        obj.supplierName = surQues.QuestionLabel__c;
        obj.searchSuppliers();  
        obj.selectwrappsupp();        
        //obj.contactName='test';   
        obj.firstBtnClick();      
        obj.nextBtnClick();
        obj.previousBtnClick();
     //   obj.lastBtnClick();
        obj.goToPage();
        obj.firstBtnClick2();
        obj.nextBtnClick2();
        obj.previousBtnClick2();
        
        obj.lastBtnClick2();
        obj.maxPages2 =1;
        obj.pageNumber2 = 1;
        obj.goToPage2();
     //   obj.searchSuppliers();
        
        obj.addToMainList();
        obj.gotoDetailPage();
        
        Test.StopTest();
        }    
      }
      static testmethod void SPE2_AddQuestionToSurveyExt_Test4(){
     
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
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna1@gmail.com';
        insert con;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = false;
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
                     
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<2;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;     
            
        //List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
      //  for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Survey_Title__c ='New Survey';
            speSurvey.Market__c = 'All Markets';
            speSurvey.MarketUnit__c = 'All Market Units';
            speSurvey.Country__c = 'All Countries';
            speSurvey.Project__c = 'All Projects';             
            speSurvey.CategoryArea__c= 'All Category Areas';
            speSurvey.CategoryGroup__c = 'All Category Groups';
            speSurvey.Category__c = 'All Categories';                
            speSurvey.BusinessLine__c ='All Business Lines';
            speSurvey.BusinessUnit__c ='All Business Units';
            speSurvey.Product__c = 'All Products';
           // speSurvey.Additional_Days__c = 2;
         //   speSurvey.Additional_Days_for_week__c = 2;
           // speSurvey.Day_name_of_upload_week__c = 'Sunday';
          //  speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
          //  speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
           // speSurvey.Month_Upload_Day__c = 7;
          //  speSurvey.Recurrence_frequency_type__c = 'Monthly';
          //  speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
           // speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = system.today()+2;
            speSurvey.Survey_Shut_Down__c = 1;
           // speSurvey.Upload_Day__c = 2;
         //   speSurvey.Week_Count__c = 'First';
           // speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
           // speSurvey.Yearly_Week_Count__c = 'Second';  
          //  lstsurvey.add(speSurvey);   
          // }  
         insert speSurvey;
         system.debug('speSurvey ::'+speSurvey);
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = speSurvey.Id;
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
            quesAssoc.Survey__c = speSurvey.Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
           }
        insert lstquesAssoc;
        
        PageReference pageRef = Page.SPE2_AddQuestionToSurvey;
        Test.setCurrentPage(pageRef); 
         
        Test.StartTest();
        Apexpages.currentpage().getparameters().put('alpha','All');       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speSurvey);  
        SPE2_AddQuestionToSurveyExt obj = new SPE2_AddQuestionToSurveyExt(stCon);      
        SPE2_AddQuestionToSurveyExt.QuestionWrapper QW = new SPE2_AddQuestionToSurveyExt.QuestionWrapper(); 
        QW.compareTo(QW); 
        QW.isChecked = true;
        QW.idEntId =acc1.id;
        QW.isSelected = true;              
        Apexpages.currentpage().getparameters().put('alpha2',null);
        Apexpages.currentpage().getparameters().put('alpha', null);
        Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        Apexpages.currentpage().getparameters().put('sortname2',null);
        Apexpages.currentpage().getparameters().put('sortname','Atos*');
        obj.sortname2 =null;
        obj.DEFAULT_PAGE_SIZE2 =10;
        obj.alphasortname2();
        obj.sortname ='COSCOM';
      //  obj.alphasortname();
        obj.pageNumber =4;
        Apexpages.currentPage().getParameters().put('supplierName','Ato*');
        obj.supplierName = 'Ato*';        
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*Ato');
        obj.supplierName ='*os';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','*Ato*');
        obj.supplierName ='*At*';
        obj.searchSuppliers();
        obj.supplierName2 ='*supplierName2*';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('supplierName','Ato');
        obj.supplierName ='Ato';
        obj.searchSuppliers();
        obj.supplierName2 ='supplierName2';
        obj.selectwrappsupp();
        Apexpages.currentPage().getParameters().put('crntPageNum2','4'); 
        
        obj.DEFAULT_PAGE_SIZE = 10;
        
        obj.supplierName = surQues.QuestionLabel__c;
        obj.searchSuppliers();  
        obj.selectwrappsupp();        
        //obj.contactName='test';   
        obj.firstBtnClick();      
        obj.nextBtnClick();
        obj.previousBtnClick();
     //   obj.lastBtnClick();
        obj.goToPage();
        obj.firstBtnClick2();
        obj.nextBtnClick2();
        obj.previousBtnClick2();
        
        obj.lastBtnClick2();
        obj.maxPages2 =1;
        obj.pageNumber2 = 4;
        obj.goToPage2();
     //   obj.searchSuppliers();
        
        obj.addToMainList();
        obj.gotoDetailPage();
        
        Test.StopTest();
        }
     
      }
  }