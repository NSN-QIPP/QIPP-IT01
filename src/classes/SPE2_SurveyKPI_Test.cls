@isTest(seeAllData=False)

/***************************************************************************************************
Apex Class Name      :  SPE2_SurveyKPI_Test
Version              :  1.0 
Created Date         :  10/06/2016
Function             :  This class covers the test method for SPE2_SurveyKPI class.
              
Modification Log     :
* ------------------------------------------------------------------------------------
* Developer                   Date                   Description
* ------------------------------------------------------------------------------------                  
* Vishal Verma              10/06/2016                     Original Version
* Vishal Verma              02/10/2016                     Modifications in the method
*****************************************************************************************************/   

public class SPE2_SurveyKPI_Test {
    static testMethod void SPE2_SurveyKPI_Test1(){        
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
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Test@gmail.com';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'sudeshna.shaw1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'sudeshna.shaw2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'sudeshna.shaw3@atos.net';
        insert CCcon3;
        
        
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
        surQues.PIDefinition__c = 'Test PI Definition';
        surQues.PIType__c = 'Survey PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
        insert surQues;  
        
        SPE_SurveyAnswer__c surveyAnswer = SPE_TestObjectCreator.CreateSurveyAnswer();
        surveyAnswer.SurveyQuestion__c = surQues.Id;
        insert surveyAnswer;
            
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();         
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            PIDefObj.SourceDataOwner__c = 'testing';
            PIDefObj.ValuesType__c = 'Number';
            PIDefObj.OperationalType__c = 'Leading KPI';
            PIDefObj.Type__c = 'Operational';
            PIDefObj.DataAcquisitionMethod__c = 'Survey';
            PIDefObj.UoM__c = 'max';
           // PIDefObj.Business__c = 'NPP';
            PIDefObj.GeoScope__c = 'All Markets';
            PIDefObj.CategoryScope__c = 'All Categories';
            PIDefObj.BUScope__c = 'All Products';
            PIDefObj.Frequency__c = '0';
            PIDefObj.ValuesType__c='Number';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
           // lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;     
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        //SPE_KPIDefinition__c kpiDefinition = new SPE_KPIDefinition__c();
        
        //************Changes Done for Encryption***********//
        //kpiDefinition.Name = 'Test KPI Definition' + i;
        KPI.KPI_Title__c = 'Test KPI Definition';
        //************Changes End***********//
        KPI.PI_Data__c = lstPIDefObj[0].Id;
        KPI.AbbreviatedName__c = 'TKPIDef';
        KPI.Level__c = '1';
        KPI.LifecycleStage__c = 'Draft';
        KPI.Description__c = 'Test';
        KPI.MissingDatalogic__c = 'Past Data or Category Average';
        KPI.OperationalType__c = 'Leading PI';
        KPI.GeoScope__c = 'All Markets';
        KPI.categoryscope__c = 'All Categories';
        KPI.BUScope__c = 'All Products';
        KPI.UoM__c = 'max';
        KPI.Group1__c = 'Cost';
        KPI.Group2__c = 'Hard';
        KPI.Type__c = 'Operational';
        KPI.Buffer_Days__c= null;
        KPI.FrequencyinMonth__c = '2';
        KPI.SurveyBased__c = true;
        KPI.ScheduledDate__c = system.today().addDays(5);
        KPI.FromDate__c = Date.today();
        KPI.ToDate__c = Date.today().addDays(5);
     //   KPI.ActualCalculation__c = 'A+B+C';
        insert KPI;
        
        KPI.LifecycleStage__c = 'Pilot';
        update KPI;
        
        SPE_KPICalculation__c objKPICalc = new SPE_KPICalculation__c();
        objKPICalc.ConstantValue__c=8;
        objKPICalc.TimeFrame__c = 4;
        objKPICalc.Aggregation__c = 'Sum';
        objKPICalc.Index__c = 'A';
        objKPICalc.IndexName__c='Test Index';
        objKPICalc.Filter1__c = '1';
        objKPICalc.Filter2__c = '1';
        objKPICalc.Filter3__c = '1';
        objKPICalc.Filter4__c = '1';
        objKPICalc.Filter5__c = '1';
        objKPICalc.Filter6__c = '1';
        objKPICalc.Filter7__c = '1';
        objKPICalc.Filter8__c = '1';
        objKPICalc.Filter9__c = '1';
        objKPICalc.Filter10__c = '1';
        objKPICalc.PIDefination__c = lstPIDefObj[0].id;
        objKPICalc.KPIDefinition__c = KPI.id;       
        insert objKPICalc;
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = KPI.Id;
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
        
        SPE2_Language_KPI__c langKPI = new SPE2_Language_KPI__c();
        langKPI.Language__c = 'French';
        langKPI.Alternate_Language_Corrective_Action_Ins__c = 'Alt Lang CAI';
        langKPI.Alternate_Language_Description__c = 'Alt Lang Desc';
        langKPI.Language_Version__c = 'French-vers';
        langKPI.Alternate_Language_Preventive_Action_Ins__c = 'Alt LangPAI';
        langKPI.Alternate_Language_RCA_Instructions__c = 'Alt Lang RCA Inst';
        langKPI.English_Language_Corrective_Action_Ins__c = 'Eng Lang CAI';
        langKPI.English_Language_Description__c ='Eng Lang Desc';
        langKPI.English_Language_Preventive_Action_Ins__c ='Eng LangPAI';
        langKPI.English_Language_RCA_Instructions__c ='Eng Lang RCA Inst';
        langKPI.English_Version__c = 'English-vers';
        langKPI.KPI__c = KPI.Id;
        insert langKPI;
                      
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
       // KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(KPI,speTemp);
        KPIMapobj .KPIDefinition__c = KPI.Id;
        KPIMapobj .SPETemplate__c = speTemp.Id;
        KPIMapobj .Weight__c = 100;
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
         for(Integer i=0;i<=11;i++){
             SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
                spePlan.SPEPlanName__c='aAtos11';
                spePlan.FrequencyInMonths__c = '1';
                spePlan.AggregationDuration__c = '1';
                spePlan.SPETemplate__c = speTemp.Id;
                spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
                spePlan.Stage__c = 'Draft';
                spePlan.BusinessLine__c='All Business Lines';
                spePlan.BusinessUnit__c='All Business Units';
                spePlan.Category__c='All Categories';
                spePlan.CategoryCluster__c= 'All Category Areas';
                spePlan.CategoryGroup__c= 'All Category Groups';
                spePlan.CM__c= con.id;
               // spePlan.CompletedTracker__c= 2;
                spePlan.Country__c='All Countries';
                spePlan.EndDate__c= Date.newinstance(2020,06,20);
                spePlan.FrequencyInMonths__c='1';
                spePlan.Region__c='All Markets';
                spePlan.SubRegion__c= 'All Market Units';
                spePlan.Organization_Group__c='Indirect Procurement';
                spePlan.PPM1__c= CCcon1.id;
                spePlan.Product__c='All Products';
                spePlan.Project__c='All Projects';
                spePlan.StartDate__c= Date.newinstance(1960,1,1);
                spePlan.SurveyReminderBeforeExecutionDate__c=1;
                spePlan.Start_Month__c = 'July';
                spePlan.Start_Year__c= '2016';
                spePlan.End_Month__c = 'February';
                spePlan.End_Year__c = '2017';
                spePlan.Additional_Days__c = 1;
                spePlan.Next_Computed_Day__c =Date.newinstance(2016,8,5);
             lstPlan.add(spePlan);
           }
        insert lstPlan;
        
        lstPlan[0].Stage__c = 'Published';
        update lstPlan;
               
        SPE_SPEPlanSupplierMap__c spePlanSupplier = new SPE_SPEPlanSupplierMap__c();
        spePlanSupplier.SPEPlan__c = lstPlan[0].Id;
        spePlanSupplier.Supplier__c = acc1.Id;
        insert spePlanSupplier;
         
        SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
        speTracker.Name = 'August-2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = lstPlan[0].Id;
        speTracker.DateOfExecution__c = System.Today();
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        speTracker.Status__c='Pending';
        speTracker.Contact__c= con.id;
        speTracker.ForceSurvey__c =true;
        speTracker.isContainsSurveyBasedPI__c = true;
        speTracker.PilotTestDataCheck__c = true;
        speTracker.SendSurveyLink__c= true;
        insert speTracker;
        
        SPE_TrackerRespondent__c tres= new SPE_TrackerRespondent__c();
        tres.Contact__c = con.Id;
        tres.SPE_Tracker__c =speTracker.Id;
        insert tres;
        
        SPE_Respondent__c respondent = new SPE_Respondent__c();
        respondent.SPEPlan__c= lstPlan[0].Id;
        respondent.Contact__c = con.id;
        insert respondent;
        
        SPE_SurveyResponse__c surveyResponse = new SPE_SurveyResponse__c();
        surveyResponse.KPIDefinition__c = KPI.Id;  
        surveyResponse.Respondent__c = con.Id; 
        surveyResponse.SPEPlan__c = lstPlan[0].id; 
        surveyResponse.SPETracker__c = speTracker.Id;
        surveyResponse.Supplier__c = acc1.Id;
        surveyResponse.Questions__c = surQues.Id;
        surveyResponse.Answers__c = surveyAnswer.Id;
        surveyResponse.ChoiceForFreeText__c =2;
        surveyResponse.BooleanChoice__c = true; 
        surveyResponse.Invisible__c = False;
        surveyResponse.NA__c = true; 
        insert surveyResponse;
      
       Test.StartTest();
       PageReference pageRef = Page.SPE2_SurveyKPI;
       Test.setCurrentPage(pageRef);                
      
       ApexPages.currentPage().getParameters().put('id',lstPlan[0].id);
       ApexPages.currentPage().getParameters().put('trackerId', speTracker.id);
       ApexPages.currentPage().getParameters().put('conId',con.id);     
       ApexPages.currentPage().getParameters().put('language','French');
      
       SPE2_SurveyKPI.ResponseWrapper rw = new SPE2_SurveyKPI.ResponseWrapper();
       
       SPE2_SurveyKPI surKpi = new SPE2_SurveyKPI();
       surKpi.initialize();
       
       //surKpi.isSuveyFilled();
       surKpi.submit();
       
      Test.StopTest(); 
   }
 }
}