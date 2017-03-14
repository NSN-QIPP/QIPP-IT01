@isTest(seeAllData=False)
public class SPE2ReorderQuestionExt_Test {
    static testMethod void SPE2ReorderQuestionExt_Test1(){
        
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
       // System.RunAs(u){ 
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
        surQues.AnswerType__c = 'Free Text';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQuestion__c = 'Share your experiences';
        insert surQues;  
 
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
            PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
            PIDefObj.PI_Title__c = 'Test PI Definition';
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.DataAcquisitionMethod__c = 'Survey';
            PIDefObj.LifecycleStage__c = 'Draft';            
            insert PIDefObj;

         PIDefObj.LifecycleStage__c = 'Pilot';
        
        update PIDefObj;
        
        surQues.PIData__c = PIDefObj.Id;
        update surQues;     
            
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
            speSurvey.BusinessLine__c = 'All Business Lines';
            speSurvey.BusinessUnit__c = 'All Business Units';
            speSurvey.Category__c = 'All Categories';
            speSurvey.CategoryArea__c =  'All Category Areas';
            speSurvey.CategoryGroup__c = 'All Category Groups';
            speSurvey.Country__c ='All Countries';
            speSurvey.Day_name_of_upload_week__c = 'Sunday';
            speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
            speSurvey.Market__c = 'All Markets';
            speSurvey.MarketUnit__c ='All Market Units';
            speSurvey.Month_Upload_Day__c = 7;
            speSurvey.Product__c = 'All Products';
            speSurvey.Project__c = 'All Projects';
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
         
         lstsurvey[0].Stage__c ='Published';
         update lstsurvey;

        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = lstsurvey[0].Id;
        insert surResp; 
        
        List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
        for(Integer i=0;i<4;i++){        
            SPE2_Question_Survey_Association__c quesAssoc = new SPE2_Question_Survey_Association__c();
            quesAssoc.AnswerType__c = 'Surveytest';
            quesAssoc.Is_Active__c = true;
            quesAssoc.Is_Required__c = true;
            quesAssoc.ordernumber__c = i;
            quesAssoc.PIData__c = PIDefObj.Id;
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
        system.debug('lstquesAssoc ::'+lstquesAssoc);
        system.debug('lstquesAssoc ::'+lstquesAssoc.size());
        
        Test.StartTest();
        PageReference pageRef = Page.SPE2ReorderQuestion;
        Test.setCurrentPage(pageRef); 
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(lstsurvey[0]);
        SPE2ReorderQuestionExt  recQue= new SPE2ReorderQuestionExt(stCon);      
        recQue.newOrderW = '';
        recQue.updateOrderList();
        for(integer i=0 ; i<2 ; i++){
            recQue.newOrderW += lstquesAssoc[i].Id +',' ;    
        }
        recQue.updateOrderList();
        SPE2ReorderQuestionExt.QuestionSurveyWrapper  QSW = new SPE2ReorderQuestionExt.QuestionSurveyWrapper(lstquesAssoc[0],true);
        QSW.compareTo(QSW);
        Test.StopTest();    
    }
}