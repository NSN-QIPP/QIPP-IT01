@isTest

public class SPE_KPIScheduleFinalbatchAdhocTest {
    
    //--- TO TEST THE CASE Expression != null && Expression != 'Constant' && PIDefID != null------
    static testmethod void testSPE_KPIScheduleFinalbatchAdhoc() {
    
    
    //insert Account data
    List<Account> lstAcc = new List<Account>();
    
    Account acc1 = new Account();
    acc1.Name = 'Test Account1';
    acc1.EnterpriseId__c = 'Test Enterprise1';
    lstAcc.add(acc1);
    
    Account acc2 = new Account();
    acc2.Name = 'Test Account2';
    acc2.EnterpriseId__c = 'Test Enterprise2';
    
    lstAcc.add(acc2);
    insert lstAcc;
    
    //---Account data insert ends---
    
    //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    //---insert KPI Data----- 
    
    
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
   /* KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.FrequencyinMonth__c = '1';
    
    KPI.LifecycleStage__c = 'Published';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category'; */
    KPI.ActualCalculation__c = 'A'; 
    KPI.Adhoc_Date__c = Date.Today().addMonths(2);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02);
    
    insert KPI;
    
    /*KPI.LifecycleStage__c = 'Published';
    
    update KPI;*/
       
    //---KPI data ends----
    //-- PI definition data ---
    
    
    
    //----SPE_SurveyQuestion__c  data starts----
    
    SPE_SurveyQuestion__c surveyQuesObj = SPE_TestObjectCreator.CreateSurveyQuestion();
    surveyQuesObj.Name = 'AtosQuestion';
    surveyQuesObj.QuestionAbbreviation__c = 'AtosQ1';
   // surveyQuesObj.PIDefinition__c = 'TestPIdef1';
    insert surveyQuesObj;
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.SurveyQuestion__c = surveyQuesObj.id;
    insert PIDefObj;
   
    
    PIDefObj.LifecycleStage__c= 'Published';
    
    update PIDefObj;
    
    //--- KPI calculation data preparation starts ---
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    
    KPIcalc.PIDefination__c = PIDefObj.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.Aggregation__c = 'SUM';
    //KPIcalc.SurveyQuestion__c = surveyQuesObj.Id;
    KPIcalc.Index__c = 'A';
    KPIcalc.Filter1__c = '1';
    KPIcalc.Filter2__c = '1';
    KPIcalc.Filter3__c = '1';
    KPIcalc.Filter4__c = '1';
    KPIcalc.Filter5__c = '1';
    KPIcalc.Filter6__c = '1';
    KPIcalc.Filter7__c = '1';
    KPIcalc.Filter8__c = '1';
   // KPIcalc.Filter9__c = '1';
    KPIcalc.Filter10__c = '1';
    
    
    
    insert KPIcalc;
      
    
    
    //--- SPE_PIValues__c  data preparation----
    
    
    
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(PIDefObj.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Period__c = Date.today();
    piValueObj.Filter1__c = '1';
    piValueObj.Filter2__c = '1';
    piValueObj.Filter3__c = '1';
    piValueObj.Filter4__c = '1';
    piValueObj.Filter5__c = '1';
    piValueObj.Filter6__c = '1';
    piValueObj.Filter7__c = '1';
    piValueObj.Filter8__c = '1';
   // piValueObj.Filter9_del__c = '1';
    piValueObj.Filter10__c = '1';
    try{
        insert piValueObj;
    }
    Catch(Exception e){
    }
    
    
    
    
    //----Supplier_KPI_Calculation_adhoc__c data starts----
    
    Supplier_KPI_Calculation_adhoc__c  supKPIAdhoc = new Supplier_KPI_Calculation_adhoc__c();
    supKPIAdhoc.KPI__c = KPI.Id;
    supKPIAdhoc.KPI_Calculation__c = KPIcalc.Id;
    
    insert supKPIAdhoc;
    
    //data ends------
    
    

        test.startTest();
        
        SPE_KPIScheduleFinalbatchAdhoc batchTest = new SPE_KPIScheduleFinalbatchAdhoc(KPI.Id);
               
        Database.executeBatch(batchTest,200);
        test.stopTest();
        List<SPE_KPICalculation__c> lstResult =[select id,PIDefination__c,KPIDefinition__c from SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
    
    }
   

//------ TO TEST THE CASE  PIDefID != null------------
   
    static testmethod void testSPE_KPIScheduleFinalbatchAdhoc2() {
    
    
    //insert Account data
    List<Account> lstAcc = new List<Account>();
    
    Account acc1 = new Account();
    acc1.Name = 'Test Account1';
    acc1.EnterpriseId__c = 'Test Enterprise1';
    lstAcc.add(acc1);
    
    Account acc2 = new Account();
    acc2.Name = 'Test Account2';
    acc2.EnterpriseId__c = 'Test Enterprise2';
    
    lstAcc.add(acc2);
    insert lstAcc;
    
    //---Account data insert ends---
    
    //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    //---insert KPI Data----- 
    
    
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(22);
   /* KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.FrequencyinMonth__c = '1';
    KPI.Adhoc_Date__c = Date.today().addMonths(2);
    KPI.LifecycleStage__c = 'Published';
    KPI.GeoScope__c = 'Market';
    KPI.BUScope__c = 'Business Unit';
    KPI.categoryscope__c = 'Category Group'; */
    KPI.ActualCalculation__c = 'A'; 
    KPI.Adhoc_Date__c = Date.Today().addMonths(2);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    insert KPI;
    
    /*KPI.LifecycleStage__c = 'Published';
    
    update KPI;*/
       
    //---KPI data ends----
    //-- PI definition data ---
    
    
    
    //----SPE_SurveyQuestion__c  data starts----
    
    SPE_SurveyQuestion__c surveyQuesObj = SPE_TestObjectCreator.CreateSurveyQuestion();
    
    surveyQuesObj.Name = 'AtosQuestionn';
    surveyQuesObj.QuestionAbbreviation__c = 'AtosQ2';
    insert surveyQuesObj;
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    PIDefObj.LifecycleStage__c = 'Draft';
   // PIDefObj.GeoScope__c = 'Market';
   // PIDefObj.BUScope__c = 'Business Unit';
   // PIDefObj.categoryscope__c = 'Category Group';
   // PIDefObj.SurveyQuestion__c = surveyQuesObj.id;
    insert PIDefObj;
   
    
    PIDefObj.LifecycleStage__c= 'Published';
    
    update PIDefObj;
    
    //--- KPI calculation data preparation starts ---
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = PIDefObj.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.Aggregation__c = 'SUM';
   // KPIcalc.SurveyQuestion__c = surveyQuesObj.Id;
    KPIcalc.Index__c = 'A';
    KPIcalc.Filter1__c = '1';
    KPIcalc.Filter2__c = '1';
    KPIcalc.Filter3__c = '1';
    KPIcalc.Filter4__c = '1';
    KPIcalc.Filter5__c = '1';
    KPIcalc.Filter6__c = '1';
    KPIcalc.Filter7__c = '1';
    KPIcalc.Filter8__c = '1';
   // KPIcalc.Filter9__c = '1';
    KPIcalc.Filter10__c = '1';
    
    insert KPIcalc;
      
    
    
    //--- SPE_PIValues__c  data preparation----
    
    
    
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(PIDefObj.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Period__c = Date.today();
    piValueObj.BusinessUnit__c = 'Test BU';
    piValueObj.Cluster__c = 'Test Cluster';
    piValueObj.CategoryGroup__c = 'Test CG';
    piValueObj.Region__c = 'Test Region';
    piValueObj.Filter1__c = '1';
    piValueObj.Filter2__c = '1';
    piValueObj.Filter3__c = '1';
    piValueObj.Filter4__c = '1';
    piValueObj.Filter5__c = '1';
    piValueObj.Filter6__c = '1';
    piValueObj.Filter7__c = '1';
    piValueObj.Filter8__c = '1';
 //   piValueObj.Filter9_del__c = '1';
    piValueObj.Filter10__c = '1';
    
    try{
        insert piValueObj;
    }
    Catch(Exception e)
    {
    }
    
    
    
    
    //----Supplier_KPI_Calculation_adhoc__c data starts----
    
    Supplier_KPI_Calculation_adhoc__c  supKPIAdhoc = new Supplier_KPI_Calculation_adhoc__c();
    supKPIAdhoc.KPI__c = KPI.Id;
    supKPIAdhoc.KPI_Calculation__c = KPIcalc.Id;
    
    insert supKPIAdhoc;
    
    //data ends------
    
    

        test.startTest();
        
        SPE_KPIScheduleFinalbatchAdhoc batchTest = new SPE_KPIScheduleFinalbatchAdhoc(KPI.Id);
        Database.executeBatch(batchTest,200);
        test.stopTest();
        List<SPE_KPICalculation__c> lstResult =[select id,PIDefination__c,KPIDefinition__c from SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
    
    
    }
    
 //--------------TO TEST THE CASE Expression != null && Expression != 'Constant' && PrevKPiID != null-------------  
    static testmethod void testSPE_KPIScheduleFinalbatchAdhoc3() {
    
    
    //insert Account data
    List<Account> lstAcc = new List<Account>();
    
    Account acc1 = new Account();
    acc1.Name = 'Test Account1';
    acc1.EnterpriseId__c = 'Test Enterprise1';
    lstAcc.add(acc1);
    
    Account acc2 = new Account();
    acc2.Name = 'Test Account2';
    acc2.EnterpriseId__c = 'Test Enterprise2';
    
    lstAcc.add(acc2);
    insert lstAcc;
    
    //---Account data insert ends---
    
    //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    //---insert KPI Data----- 
    
    
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(32);
  /*  KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.FrequencyinMonth__c = '1';
    KPI.Adhoc_Date__c = Date.today().addMonths(2);
    KPI.LifecycleStage__c = 'Published';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category'; */
    KPI.ActualCalculation__c = 'A'; 
    KPI.Adhoc_Date__c = Date.Today().addMonths(2);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    insert KPI;
    
     /*KPI.LifecycleStage__c = 'Published';
     
     update KPI;*/
       
    //---KPI data ends----
    //-- PI definition data ---
    
   
    
    //----SPE_SurveyQuestion__c  data starts----
    
    SPE_SurveyQuestion__c surveyQuesObj = SPE_TestObjectCreator.CreateSurveyQuestion();
    surveyQuesObj.Name = 'AtossQuestion';
    surveyQuesObj.QuestionAbbreviation__c = 'AtosQ3';
    insert surveyQuesObj;
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.SurveyQuestion__c = surveyQuesObj.id;
    insert PIDefObj;
   
    
    PIDefObj.LifecycleStage__c= 'Published';
    
    update PIDefObj;
    
    //--- KPI calculation data preparation starts ---
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    //KPIcalc.PIDefination__c = PIDefObj.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.Aggregation__c = 'SUM';
   // KPIcalc.SurveyQuestion__c = surveyQuesObj.Id;
    KPIcalc.Index__c = 'A';
    KPIcalc.Filter1__c = '1';
    KPIcalc.Filter2__c = '1';
    KPIcalc.Filter3__c = '1';
    KPIcalc.Filter4__c = '1';
    KPIcalc.Filter5__c = '1';
    KPIcalc.Filter6__c = '1';
    KPIcalc.Filter7__c = '1';
    KPIcalc.Filter8__c = '1';
   // KPIcalc.Filter9__c = '1';
    KPIcalc.Filter10__c = '1';
    
    insert KPIcalc;
      
    
    
    //--- SPE_PIValues__c  data preparation----
    
    
    
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(PIDefObj.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Period__c = Date.today();
    piValueObj.Filter1__c = '1';
    piValueObj.Filter2__c = '1';
    piValueObj.Filter3__c = '1';
    piValueObj.Filter4__c = '1';
    piValueObj.Filter5__c = '1';
    piValueObj.Filter6__c = '1';
    piValueObj.Filter7__c = '1';
    piValueObj.Filter8__c = '1';
    //piValueObj.Filter9_del__c = '1';
    piValueObj.Filter10__c = '1';
    
    try{
        insert piValueObj;
    }
    Catch(Exception e){
    }
    
    
    SPE_KPIValue__c  KPIValueObj = new SPE_KPIValue__c();
    
    KPIValueObj.KPIValue__c = 150.0;
    KPIValueObj.Period__c = Date.Today();
    KPIValueObj.Category__c = 'Category';
    KPIValueObj.CategoryGroup__c = 'All Business Lines';
    KPIValueObj.BusinessLine__c = 'BL1';
    KPIValueObj.BusinessUnit__c = 'BU2';
    KPIValueObj.Region__c = 'APAC';
    KPIValueObj.SubRegion__c = 'Eastern Asia';
    KPIValueObj.Country__c = 'Country';
    KPIValueObj.Project__c = 'Project';
    KPIValueObj.Product__c = 'Product';
    KPIValueObj.EnterpriseID__c = 'Test Enterprise1';
    KPIValueObj.KPIDefinition__c = KPI.Id;
    KPIValueObj.ExecutionPeriod__c = SPE_Utility.monthsMap.get(KPIValueObj.Period__c.month()) + ' - '+ String.valueOf(KPIValueObj.Period__c.year());
    
    insert KPIValueObj;
    
    //----Supplier_KPI_Calculation_adhoc__c data starts----
    
    Supplier_KPI_Calculation_adhoc__c  supKPIAdhoc = new Supplier_KPI_Calculation_adhoc__c();
    supKPIAdhoc.KPI__c = KPI.Id;
    supKPIAdhoc.KPI_Calculation__c = KPIcalc.Id;
    
    insert supKPIAdhoc;
    
    //data ends------
    
    

        test.startTest();
        
        SPE_KPIScheduleFinalbatchAdhoc batchTest = new SPE_KPIScheduleFinalbatchAdhoc(KPI.Id);
                 
        Database.executeBatch(batchTest,200);
        test.stopTest();
   
        List<SPE_KPICalculation__c> lstResult =[select id,PIDefination__c,KPIDefinition__c from SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
    
    }
    
    
    static testmethod void testSPE_KPIScheduleFinalbatchAdhoc4() {
    
    
    //insert Account data
    List<Account> lstAcc = new List<Account>();
    
    Account acc1 = new Account();
    acc1.Name = 'Test Account1';
    acc1.EnterpriseId__c = 'Test Enterprise1';
    lstAcc.add(acc1);
    
    Account acc2 = new Account();
    acc2.Name = 'Test Account2';
    acc2.EnterpriseId__c = 'Test Enterprise2';
    
    lstAcc.add(acc2);
    insert lstAcc;
    
    //---Account data insert ends---
    
    //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    //---insert KPI Data----- 
    
    
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(43);
   /* KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.FrequencyinMonth__c = '1';
    KPI.Adhoc_Date__c = Date.Today().addMonths(2);
    KPI.LifecycleStage__c = 'Published';
    KPI.GeoScope__c = 'Project';
    KPI.BUScope__c = 'Business Unit';
    KPI.categoryscope__c = 'Category Group'; */
    KPI.ActualCalculation__c = 'A'; 
    KPI.Adhoc_Date__c = Date.Today().addMonths(2);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    
    insert KPI;
    /*KPI.LifecycleStage__c = 'Published';
    update KPI; */
       
    //---KPI data ends----
    //-- PI definition data ---
    
    
    
    SPE_ProjectMaster__c projMasterObj = new SPE_ProjectMaster__c();
    projMasterObj.Country__c = 'Country';
    projMasterObj.MarketUnit__c ='Market Unit';
    projMasterObj.Market__c = 'Market';
    projMasterObj.Project__c = 'Project';
    
    insert projMasterObj;
    
    
    //----SPE_SurveyQuestion__c  data starts----
    
    SPE_SurveyQuestion__c surveyQuesObj =  SPE_TestObjectCreator.CreateSurveyQuestion();
    surveyQuesObj.Name = 'AAtosQuestion';
    surveyQuesObj.QuestionAbbreviation__c = 'AtosQ4';
    insert surveyQuesObj;
    
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.SurveyQuestion__c = surveyQuesObj.id;
    insert PIDefObj;
   
    
    PIDefObj.LifecycleStage__c= 'Published';
    
    update PIDefObj;
    
    //--- KPI calculation data preparation starts ---
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    
    KPIcalc.PIDefination__c = PIDefObj.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.Aggregation__c = 'MIN';
  //  KPIcalc.SurveyQuestion__c = surveyQuesObj.Id;
    KPIcalc.Index__c = 'A';
    KPIcalc.Filter1__c = '1';
    KPIcalc.Filter2__c = '1';
    KPIcalc.Filter3__c = '1';
    KPIcalc.Filter4__c = '1';
    KPIcalc.Filter5__c = '1';
    KPIcalc.Filter6__c = '1';
    KPIcalc.Filter7__c = '1';
    KPIcalc.Filter8__c = '1';
   // KPIcalc.Filter9__c = '1';
    KPIcalc.Filter10__c = '1';
    
    
    
    insert KPIcalc;
      
    
    
    //--- SPE_PIValues__c  data preparation----
    
    
    
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(PIDefObj.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Period__c = Date.today();
    piValueObj.BooleanValue__c = true;
    piValueObj.Filter1__c = '1';
    piValueObj.Filter2__c = '1';
    piValueObj.Filter3__c = '1';
    piValueObj.Filter4__c = '1';
    piValueObj.Filter5__c = '1';
    piValueObj.Filter6__c = '1';
    piValueObj.Filter7__c = '1';
    piValueObj.Filter8__c = '1';
   // piValueObj.Filter9_del__c = '1';
    piValueObj.Filter10__c = '1';
    try{
    insert piValueObj;
    }
    Catch(Exception e){
    }
    
    
    //----Supplier_KPI_Calculation_adhoc__c data starts----
    
    Supplier_KPI_Calculation_adhoc__c  supKPIAdhoc = new Supplier_KPI_Calculation_adhoc__c();
    supKPIAdhoc.KPI__c = KPI.Id;
    supKPIAdhoc.KPI_Calculation__c = KPIcalc.Id;
    
    insert supKPIAdhoc;
    
    //data ends------
    
    

        test.startTest();
        
        SPE_KPIScheduleFinalbatchAdhoc batchTest = new SPE_KPIScheduleFinalbatchAdhoc(KPI.Id);
               
        Database.executeBatch(batchTest,200);
        test.stopTest();
        List<SPE_KPICalculation__c> lstResult =[select id,PIDefination__c,KPIDefinition__c from SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
    
    }
   
 }