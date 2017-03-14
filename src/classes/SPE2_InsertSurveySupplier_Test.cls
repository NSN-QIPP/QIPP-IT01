@isTest(seeAllData=false)
public class SPE2_InsertSurveySupplier_Test{
    static testmethod void SPE2_InsertSurveySupplier_test1(){    
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
        
        Account acc = new Account();
        acc.Name = 'UNITEL';
        acc.EnterpriseId__c = 'UNITEL';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Test1@gmail.com';
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
        for(Integer i=0;i<1;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;  
        
        List<SPE_Spend__c> spendList = new List<SPE_Spend__c>();
        for(integer i=0;i<1;i++){
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
            
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<1;i++){                 
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
         
         List<SPE2_SurveySupplierMap__c > suppliermapList = new List<SPE2_SurveySupplierMap__c>();
         for(integer i=0;i<10;i++){
             SPE2_SurveySupplierMap__c suppmap =new SPE2_SurveySupplierMap__c();
             suppmap.Supplier__c =acc1.id;
             suppmap.SPE2_Survey__c =lstsurvey[0].id;
             suppliermapList.add(suppmap);
         }
        insert suppliermapList;
        
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = lstsurvey[0].Id;
        insert surResp; 
        
        List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
        for(Integer i=0;i<10;i++){        
            SPE2_Question_Survey_Association__c quesAssoc = new SPE2_Question_Survey_Association__c();
            quesAssoc.AnswerType__c = 'FreeText';
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
                      
        
        PageReference pg = Page.SPE2_Survey_AddSupplier;
        system.Test.setCurrentPage(pg);
        Apexpages.currentpage().getparameters().put('alpha','All');
        ApexPages.StandardController sc = new ApexPages.StandardController(lstsurvey[0]);
        SPE2_InsertSurveySupplier.SupplierWrapper wrapp = new SPE2_InsertSurveySupplier.SupplierWrapper();
        wrapp.isChecked =true;
        wrapp.isSelected=true;
        // obj.SupplierWrapperList = wrapp;
        SPE2_InsertSurveySupplier obj = new SPE2_InsertSurveySupplier(sc);
      //  Apexpages.currentpage().getparameters().put('alpha','u');
      //  obj.alphasortname();
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
        
        Apexpages.currentpage().getparameters().put('alpha2','All');
        obj.alphasortname2();
     /*   Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        Apexpages.currentpage().getparameters().put('sortname2','All');
        Apexpages.currentpage().getparameters().put('sortname','All');
        obj.sortname2 ='All';
        obj.pageNumber =1;        
     */
        if(obj.subwrapperList2.size() != Null){
            for(SPE2_InsertSurveySupplier.SupplierWrapper suppWrp : obj.subwrapperList2){
                suppWrp.isChecked = true;
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
          obj.goToPage2(); 
        }
        obj.firstBtnClick2();        
        obj.selectwrappsupp();        
        //obj.contactName='test';                  
        obj.addToMainList();
        obj.gotoDetailPage();
                
      Test.stopTest(); 
        }
    } 
    static testmethod void SPE2_InsertSurveySupplier_test2(){

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
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
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
         
         List<SPE2_SurveySupplierMap__c > suppliermapList = new List<SPE2_SurveySupplierMap__c>();
         for(integer i=0;i<10;i++){
             SPE2_SurveySupplierMap__c suppmap =new SPE2_SurveySupplierMap__c();
             suppmap.Supplier__c =acc.id;
             suppmap.SPE2_Survey__c =lstsurvey[0].id;
             suppliermapList.add(suppmap);
         }
         insert suppliermapList;
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
        
        List<SPE_Spend__c> spendList = new List<SPE_Spend__c>();
        for(integer i=0;i<10;i++){
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
                      
        Test.startTest();
        
        
        PageReference pg = Page.SPE2_Survey_AddSupplier;
        system.Test.setCurrentPage(pg);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lstsurvey[0]);
        SPE2_InsertSurveySupplier obj = new SPE2_InsertSurveySupplier(sc);
        SPE2_InsertSurveySupplier.SupplierWrapper wrapp = new SPE2_InsertSurveySupplier.SupplierWrapper();
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
        obj.DEFAULT_PAGE_SIZE = 15;
        obj.DEFAULT_PAGE_SIZE2 =15;
        
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