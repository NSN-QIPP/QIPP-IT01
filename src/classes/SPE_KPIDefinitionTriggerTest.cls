@isTest(SeeAllData=false)
public class SPE_KPIDefinitionTriggerTest
{
    public static testMethod void testSPE_KPIDefinitionTriggerTest1()
    {
    Test.StartTest();
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition';
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,3,10);
        lstPIDefObj.add(PIDefObj);
                
        SPE_PIDefinition__c PIDefObj1 = new SPE_PIDefinition__c();
        PIDefObj1 = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj1.PI_Title__c = 'Test PI Definition';
        PIDefObj1.LifecycleStage__c = 'Draft';
        PIDefObj1.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj1.PIUploadDuedate__c = Date.newInstance(2018,10,10);
        lstPIDefObj.add(PIDefObj1);
        
        insert lstPIDefObj;
        
        for(SPE_PIDefinition__c pi : lstPIDefObj){
            pi.LifecycleStage__c= 'Pilot';
        }
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        kpiDefinition1.PI_Data__c = lstPIDefObj[0].Id;
        kpiDefinition1.Buffer_Days__c = null;
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.ActualCalculation__c='A';
       // kpiDefinition1.FrequencyinMonth__c = '2';
       // kpiDefinition1.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Aggregation__c = 'AVG';        
        kpiDefinition1.IsHighBetter__c=true;
        insert kpiDefinition1;
        
     //   kpiDefinition1.LifecycleStage__c = 'Pilot';
     //   update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        kpiDefinition2.PI_Data__c = lstPIDefObj[1].Id;
        kpiDefinition2.Buffer_Days__c = null;
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
       // kpiDefinition2.FrequencyinMonth__c = '2';
      //  kpiDefinition2.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
     //   kpiDefinition1.
      //  update kpiDefinition2;
      
       SPE_KPIDefinition__c kpiDefinition3 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition3.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
       // kpiDefinition3.PI_Data__c = lstPIDefObj[1].Id;
        kpiDefinition3.Buffer_Days__c = 3;
        kpiDefinition3.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition3.Level__c = '1';
        kpiDefinition3.LifecycleStage__c = 'Pilot';
        kpiDefinition3.Description__c = 'Test';
        kpiDefinition3.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition3.OperationalType__c = 'Leading PI';
        kpiDefinition3.GeoScope__c = 'All Markets';
        kpiDefinition3.categoryscope__c = 'All Categories';
        kpiDefinition3.BUScope__c = 'All Products';
        kpiDefinition3.UoM__c = 'max';
        kpiDefinition3.Group1__c = 'Cost';
        kpiDefinition3.Group2__c = 'Hard';
        kpiDefinition3.Type__c = 'Operational';
        kpiDefinition3.ActualCalculation__c='A';
        kpiDefinition3.FrequencyinMonth__c = '2';
        kpiDefinition3.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition3.VerNumber__c = 0;
        kpiDefinition3.Aggregation__c = 'AVG';        
        kpiDefinition3.IsHighBetter__c=true;
        insert kpiDefinition3;
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=lstPIDefObj[0].id;
        kpical.kpidefinition__c=kpiDefinition1.id;
        insert kpiCal;
        
        list<SPE_KPIDefinition__c>  lstKPI=[Select Id,ScheduledDate__c,PI_Data__c,Buffer_Days__c,PI_Data__r.PIUploadDuedate__c From SPE_KPIDefinition__c 
                  Where PI_Data__c != null And PI_Data__r.PIUploadDuedate__c != null];
        
        for(SPE_KPIDefinition__c kpi : lstKPI ){
            kpi.LifecycleStage__c = 'Pilot';           
        }
        update lstKPI;
        
          
    Test.StopTest();
    } 
    
    public static testMethod void SPE_KPIDefinitionTriggerTest2()
    {
    Test.StartTest();
       
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
       // kpiDefinition1.PI_Data__c = lstPIDefObj[0].Id;
        kpiDefinition1.Buffer_Days__c = 2;
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.ActualCalculation__c='A';
        kpiDefinition1.FrequencyinMonth__c = '2';
       // kpiDefinition1.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Aggregation__c = 'AVG';        
        kpiDefinition1.IsHighBetter__c=true;
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition';
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,10,10);
        insert PIDefObj;
        
        PIDefObj.LifecycleStage__c = 'Published';
        update PIDefObj; 
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=PIDefObj.id;
        kpical.kpidefinition__c=kpiDefinition1.id;
        kpiCal.ConstantValue__c=8;
        kpiCal.TimeFrame__c = 4;
        kpiCal.Aggregation__c = 'Sum';
        kpiCal.Index__c = 'A';
        kpiCal.IndexName__c='Test Index';
        kpiCal.Filter1__c = '1';
        kpiCal.Filter2__c = '1';
        kpiCal.Filter3__c = '1';
        kpiCal.Filter4__c = '1';
        kpiCal.Filter5__c = '1';
        kpiCal.Filter6__c = '1';
        kpiCal.Filter7__c = '1';
        kpiCal.Filter8__c = '1';
        kpiCal.Filter9__c = '1';
        kpiCal.Filter10__c = '1';
     //   kpical.PrevKPIDefination__c = kpiDefinition2.Id;
        insert kpiCal;
        
        
        
        kpiDefinition1.Buffer_Days__c = 10;
        update kpiDefinition1;
    
    Test.StopTest();
    } 
    
    public static testMethod void SPE_KPIDefinitionTriggerTest3()
    {
    Test.StartTest();
       
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
       // kpiDefinition1.PI_Data__c = lstPIDefObj[0].Id;
        kpiDefinition1.Buffer_Days__c = 1;
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.ActualCalculation__c='A';
        kpiDefinition1.FrequencyinMonth__c = '2';
       // kpiDefinition1.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Aggregation__c = 'AVG';        
        kpiDefinition1.IsHighBetter__c=true;
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_SurveyQuestion__c surQue=SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surQue;
        
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition';
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.SurveyQuestion__c = surQue.Id; 
        PIDefObj.DataAcquisitionMethod__c = 'Survey';
       // PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,10,10);
        insert PIDefObj;
        
        PIDefObj.LifecycleStage__c = 'Published';
        update PIDefObj; 
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        kpiDefinition2.PI_Data__c = PIDefObj.Id;
        kpiDefinition2.Buffer_Days__c = null;
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition2.Level__c = '1';
        kpiDefinition2.LifecycleStage__c = 'Draft';
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
       // kpiDefinition2.FrequencyinMonth__c = '2';
       // kpiDefinition2.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
     //   kpiDefinition1.
      //  update kpiDefinition2;
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=PIDefObj.id;
        kpical.kpidefinition__c=kpiDefinition1.id;
        kpiCal.ConstantValue__c=8;
        kpiCal.TimeFrame__c = 4;
        kpiCal.Aggregation__c = 'Sum';
        kpiCal.Index__c = 'A';
        kpiCal.IndexName__c='Test Index';
        kpiCal.Filter1__c = '1';
        kpiCal.Filter2__c = '1';
        kpiCal.Filter3__c = '1';
        kpiCal.Filter4__c = '1';
        kpiCal.Filter5__c = '1';
        kpiCal.Filter6__c = '1';
        kpiCal.Filter7__c = '1';
        kpiCal.Filter8__c = '1';
        kpiCal.Filter9__c = '1';
        kpiCal.Filter10__c = '1';
     //   kpical.PrevKPIDefination__c = kpiDefinition2.Id;
        insert kpiCal;
        
        kpiDefinition1.Buffer_Days__c = 10;
        update kpiDefinition1;
        
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
         
         SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
         spePlan.SPEPlanName__c= 'Atos Plan';
         spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
         spePlan.SPETemplate__c = speTemplate.Id; 
         spePlan.StartDate__c = Date.newinstance(2018,10,01);
        // spePlan.identifierParam__c=System.Today()+';'+u.Id;
         spePlan.SurveyExecutionBeforeIndays__c = 5;       
         spePlan.SurveyReminderBeforeExecutionDate__c = 3;
         spePlan.Organization_Group__c = 'Services Procurement';       
         spePlan.FrequencyInMonths__c = '1';
         spePlan.SPEPlanName__c = 'New Demo Plan 122';
         spePlan.AggregationDuration__c = '1';
         spePlan.Next_Computed_Day__c = Date.newinstance(2018,11,15);
         spePlan.Region__c = 'IND';
         spePlan.SubRegion__c = 'IND MX';
         spePlan.Country__c = 'IND C';
         spePlan.Project__c = 'INDP';
         spePlan.Stage__c = 'Draft';
         spePlan.CategoryCluster__c = 'IP';
         spePlan.CategoryGroup__c = 'IP GP';
         spePlan.Category__c = 'IP CG';
         spePlan.BusinessLine__c ='PROD PROC';
         spePlan.BusinessUnit__c ='PROD BL';
         spePlan.Product__c = 'PROD RT';
         spePlan.Vintage__c = '2015P01';     
     //    spePlan.OwnerId = u.ID;
         insert spePlan;      
    
    Test.StopTest();
    } 
    
    public static testMethod void SPE_KPIDefinitionTriggerTest4()
    {
    Test.StartTest();
       SPE_SurveyQuestion__c surQue=SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surQue;
        
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition';
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.SurveyQuestion__c = surQue.Id; 
        PIDefObj.DataAcquisitionMethod__c = 'Survey';
       // PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,10,10);
        insert PIDefObj;
        
        PIDefObj.LifecycleStage__c = 'Published';
        update PIDefObj;  
        
       SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        kpiDefinition1.PI_Data__c = PIDefObj.Id;
        kpiDefinition1.Buffer_Days__c = null;
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.ActualCalculation__c='A';
        //kpiDefinition1.FrequencyinMonth__c = '2';
       // kpiDefinition1.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Aggregation__c = 'AVG';        
        kpiDefinition1.IsHighBetter__c=true;
        insert kpiDefinition1;
      
    Test.StopTest();
    }     
          
}