@isTest(SeeAllData = False)
public class SPE2_ConvertQuestionToPIDataExtTest{     
        static testmethod void SPE2_ConvertQuestionToPIDataExtTest1(){
            //---Custom Setting data ---
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
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
       // surQues.PIData__c = lstPIDefObj[0].Id;
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
               
         SPE2Survey__c speSurvey = new SPE2Survey__c(); 
         speSurvey.BusinessLine__c = 'All Business Lines';
         speSurvey.BusinessUnit__c = 'All Business Units';
         speSurvey.Category__c = 'All Categories';
         speSurvey.CategoryArea__c =  'All Category Areas';
         speSurvey.CategoryGroup__c = 'All Category Groups';
         speSurvey.Country__c ='All Countries';           
         speSurvey.Market__c = 'All Markets';
         speSurvey.MarketUnit__c ='All Market Units';          
         speSurvey.Product__c = 'All Products';
         speSurvey.Project__c = 'All Projects';            
         speSurvey.Stage__c = 'Draft';             
         insert speSurvey;  
         
         SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
         surResp.Contact__c = con.Id;
         surResp.Survey__c = speSurvey.Id;
         insert surResp; 
         
         List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
         for(Integer i=0;i<1;i++){        
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
         
         PageReference pageRef = Page.SPE2_ConvertQuestionToPIData;
         Test.setCurrentPage(pageRef); 
         Test.StartTest();
         ApexPages.CurrentPage().getparameters().put('QID', surQues.id);
         ApexPages.CurrentPage().getparameters().put('sid', speSurvey.id);
         ApexPages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQues);
         SPE2_ConvertQuestionToPIDataExt conQuesPI= new SPE2_ConvertQuestionToPIDataExt(stCon);
         conQuesPI.PICancel();
         conQuesPI.PISave();
         
         Test.StopTest();
      }
      
     static testmethod void SPE2_ConvertQuestionToPIDataExtTest2(){
            //---Custom Setting data ---
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
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
       // surQues.PIData__c = lstPIDefObj[0].Id;
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
               
         SPE2Survey__c speSurvey = new SPE2Survey__c(); 
         speSurvey.BusinessLine__c = 'Single RAN';
         speSurvey.BusinessUnit__c = 'Mobile Broadband';
         speSurvey.Category__c = 'Sheet Metal Parts';
         speSurvey.CategoryArea__c =  'Product Procurement';
         speSurvey.CategoryGroup__c = 'Mechanics';
         speSurvey.Country__c ='India';           
         speSurvey.Market__c = 'INDIA';
         speSurvey.MarketUnit__c ='INDIA BHARTI';          
         speSurvey.Product__c = 'WCDMA RNC';
         speSurvey.Project__c = 'IN Bharti 4G';            
         speSurvey.Stage__c = 'Draft';             
         insert speSurvey;  
         
         SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
         surResp.Contact__c = con.Id;
         surResp.Survey__c = speSurvey.Id;
         insert surResp; 
         
         List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
         for(Integer i=0;i<1;i++){        
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
         
         PageReference pageRef = Page.SPE2_ConvertQuestionToPIData;
         Test.setCurrentPage(pageRef); 
         Test.StartTest();
         ApexPages.CurrentPage().getparameters().put('QID', surQues.id);
         ApexPages.CurrentPage().getparameters().put('sid', speSurvey.id);
         ApexPages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQues);
         SPE2_ConvertQuestionToPIDataExt conQuesPI= new SPE2_ConvertQuestionToPIDataExt(stCon);
         conQuesPI.PICancel();
         conQuesPI.PISave();
         
         Test.StopTest();
      }
}