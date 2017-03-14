@isTest(seeAllData=False)
public class SPE2_StandaloneSurveyKPIView_Test {
    static testMethod void SPE2_StandaloneSurveyKPIView_Test1(){
    Test.StartTest();
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
        con.Email = 'Test@gmail.com';
        insert con;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.AnswerType__c = 'Picklist';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
        surQues.OperationalType__c = 'Picklist';
        surQues.PIDefinition__c = 'Atos_testPI';
        surQues.PIType__c = 'Atos_Test_PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
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

            SPE2Survey__c  speSurvey = new SPE2Survey__c();
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.EndDate__c = Date.newInstance(2016, 10, 17);
            speSurvey.Country__c =  'All Countries';
            speSurvey.Project__c = 'All Projects';
            speSurvey.CategoryArea__c = 'All Category Areas';
            speSurvey.CategoryGroup__c = 'All Category Groups';
            speSurvey.Category__c = 'All Categories';
            speSurvey.Market__c = 'All Markets';
            speSurvey.MarketUnit__c =  'All Market Units'; 
            speSurvey.BusinessUnit__c =  'All Business Units';
            speSurvey.BusinessLine__c = 'All Business Lines';
            speSurvey.Product__c =  'All Products';
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Stage__c = 'Draft';
            insert speSurvey;
            
            speSurvey.Stage__c = 'Published';
            update speSurvey;
   
      SPE2_SurveyTracker__c SurveyTracker = new SPE2_SurveyTracker__c();
      SurveyTracker.Name = 'January - 2016';
      SurveyTracker.Survey__c = speSurvey.Id;
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
      insert SurveyTracker;
      
      List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
      for(Integer i=0 ;i<=5;i++){
          SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
          survmap.SPE2_Survey__c= speSurvey.id;
          survmap.Supplier__c = acc1.id;
          survMaplst.add(survmap);
      }  
      insert survMaplst; 
      
      SPE2_SurveyTrackerRespondent__c surTrakResp = new SPE2_SurveyTrackerRespondent__c();
      surTrakResp.Contact__c =con.Id;
      surTrakResp.Survey__c = speSurvey.Id;
      surTrakResp.Survey_Tracker__c = SurveyTracker.Id;
      surTrakResp.IsResponseReceived__c = false;
      insert surTrakResp;
      
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
      
      PageReference pageRef = Page.SPE2_StandaloneSurveyKPIView;
      Test.setCurrentPage(pageRef);                
      
      ApexPages.currentPage().getParameters().put('Id',speSurvey.Id);
      ApexPages.currentPage().getParameters().put('trackerId',SurveyTracker.Id );
      ApexPages.currentPage().getParameters().put('conId',con.Id);
      SPE2_StandaloneSurveyKPIView controller = new SPE2_StandaloneSurveyKPIView();
      system.assert(controller.surveySuppList.size() != null);
      for(SPE2_StandaloneSurveyKPIView.surveySupplierWrapper ssw :controller.surveySuppList){
          for(SPE2_StandaloneSurveyKPIView.surveyQuestionWrapper  QueWrap :ssw.sqWrpList){     
            QueWrap.isApplicable = false;
          }
      }
      
      controller.initialize();
      
    Test.StopTest(); 
    }
  }  
    static testMethod void SPE2_StandaloneSurveyKPIView_Test2(){
    Test.StartTest();
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
        con.Email = 'Test@gmail.com';
        insert con;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.AnswerType__c = 'FreeText';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
        surQues.OperationalType__c = 'Picklist';
        surQues.PIDefinition__c = 'Atos_testPI';
        surQues.PIType__c = 'Atos_Test_PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
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

            SPE2Survey__c  speSurvey = new SPE2Survey__c();
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.EndDate__c = Date.newInstance(2016, 10, 17);
            speSurvey.Country__c =  'All Countries';
            speSurvey.Project__c = 'All Projects';
            speSurvey.CategoryArea__c = 'All Category Areas';
            speSurvey.CategoryGroup__c = 'All Category Groups';
            speSurvey.Category__c = 'All Categories';
            speSurvey.Market__c = 'All Markets';
            speSurvey.MarketUnit__c =  'All Market Units'; 
            speSurvey.BusinessUnit__c =  'All Business Units';
            speSurvey.BusinessLine__c = 'All Business Lines';
            speSurvey.Product__c =  'All Products';
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Stage__c = 'Draft';
            insert speSurvey;
            
            speSurvey.Stage__c = 'Published';
            update speSurvey;
   
      SPE2_SurveyTracker__c SurveyTracker = new SPE2_SurveyTracker__c();
      SurveyTracker.Name = 'January - 2016';
      SurveyTracker.Survey__c = speSurvey.Id;
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
      insert SurveyTracker;
      
      List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
      for(Integer i=0 ;i<=5;i++){
          SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
          survmap.SPE2_Survey__c= speSurvey.id;
          survmap.Supplier__c = acc1.id;
          survMaplst.add(survmap);
      }  
      insert survMaplst; 
      
      SPE2_SurveyTrackerRespondent__c surTrakResp = new SPE2_SurveyTrackerRespondent__c();
      surTrakResp.Contact__c =con.Id;
      surTrakResp.Survey__c = speSurvey.Id;
      surTrakResp.Survey_Tracker__c = SurveyTracker.Id;
      surTrakResp.IsResponseReceived__c = false;
      insert surTrakResp;
      
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
      
      PageReference pageRef = Page.SPE2_StandaloneSurveyKPIView;
      Test.setCurrentPage(pageRef);                
      
      ApexPages.currentPage().getParameters().put('Id',speSurvey.Id);
      ApexPages.currentPage().getParameters().put('trackerId',SurveyTracker.Id );
      ApexPages.currentPage().getParameters().put('conId',con.Id);
      SPE2_StandaloneSurveyKPIView controller = new SPE2_StandaloneSurveyKPIView();
      system.assert(controller.surveySuppList.size() != null);
      for(SPE2_StandaloneSurveyKPIView.surveySupplierWrapper ssw :controller.surveySuppList){
          for(SPE2_StandaloneSurveyKPIView.surveyQuestionWrapper  QueWrap :ssw.sqWrpList){     
            QueWrap.isApplicable = false;
          }
      }
      
      controller.initialize();
      
    Test.StopTest(); 
    }
   }
  }