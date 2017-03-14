@isTest(SeeAllData = false)

public class SPE2_AddSurveyRespondentExtTest{

    
     static testmethod void Test_SPE2_AddSurveyRespondentExt1(){
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
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Test.Mail@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Test.Mail1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Test.Mail2@atos.net';
        insert CCcon2;
        
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
            spend.EnterpriseId__c= acc1.id;
            spendList.add(spend);
        }
        insert spendList;   
        
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Standalone Survey';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
       // CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Test.Mail3@atos.net';
        insert CCcon3;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = CCcon3.id;
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
        
        List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
        for(Integer i=0 ;i<=10;i++){
            SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
            survmap.SPE2_Survey__c= lstsurvey[0].id;
            survmap.Supplier__c = acc1.id;
            survMaplst.add(survmap);
          }  
        insert survMaplst; 
         
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
          
        List<PI_Survey_Association__c> surveyassList = new List<PI_Survey_Association__c>();
        for(Integer i=0;i<10;i++){ 
            PI_Survey_Association__c surveyass = new PI_Survey_Association__c();
            surveyass.PIData__c =lstPIDefObj[0].id;
            surveyass.SPE2_Survey__c =lstsurvey[0].id;
            surveyassList.add(surveyass);
        }
        insert surveyassList;  
  
        Test.startTest();
        PageReference pageRef = Page.SPE2_AddSurveyRespondent;
        Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(lstsurvey[0]);
        SPE2_AddSurveyRespondentExt surRes = new SPE2_AddSurveyRespondentExt(stCon);
        surRes.firstBtnClick2();
        surRes.nextBtnClick2();
        surRes.previousBtnClick2();
        surRes.lastBtnClick2();
        surRes.goToPage2();
        surRes.searchRespondent();
        surRes.DEFAULT_PAGE_SIZE = 2;
        surRes.nextBtnClick2(); 
        surRes.lastBtnClick2();           
        surRes.previousBtnClick2();
        surRes.firstBtnClick2();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        surRes.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        surRes.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        surRes.goToPage2();
        
        SPE2_Survey_Respondents__c Resp1 = new SPE2_Survey_Respondents__c();
        Resp1.Contact__c = con.Id;
        Resp1.Survey__c = lstsurvey[0].Id;
               
        SPE2_AddSurveyRespondentExt.RespondentWrapper wrap = new SPE2_AddSurveyRespondentExt.RespondentWrapper(Resp1,catInfoList);
        List<SPE2_AddSurveyRespondentExt.RespondentWrapper> wrapList = new List<SPE2_AddSurveyRespondentExt.RespondentWrapper>();
        wrapList.add(wrap);
        surRes.respondentWrapperList = wrapList;
        //wrapList.add(wrap);
      //surResp.respondentWrapperList.add(wrap);
      /*  if(surResp.respondentWrapperList.size() > 0 ){ 
            for(SPE2_AddSurveyRespondentExt.RespondentWrapper res : surResp.respondentWrapperList){
                system.debug('resssssss'+res);
            }   
        }  */      
        //    surResp.respondentWrapperList = wrapList;
        surRes.insertRespondent();
         
        //surRes.createRespondent(surResList);
        surRes.cancel();
        
            
        Test.stopTest();
    
        }
    }
}