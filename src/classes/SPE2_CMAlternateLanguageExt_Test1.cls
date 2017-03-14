@isTest(seeAllData=False)
public class SPE2_CMAlternateLanguageExt_Test1{
    
       public static testmethod void SPE2_CMAlternateLanguageExtTest(){
       
       //SPE_KPIDefinition__c  kpiObj = new SPE_KPIDefinition__c();
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
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
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG'; 
        kpiDefinition2.IsHighBetter__c=true;
        kpiDefinition2.CorrectiveActionInstructions__c = 'ABCXYZ';
        insert kpiDefinition2;

       
        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
       // SPEConMngmnt.CorrectiveActionInstructions__c = kpiDefinition2.Id;
     // SPEConMngmnt.KPIName__c =' kpiDefinition2.KPI_Title__c';
         SPEConMngmnt.KPITitle__c=' test SPEConseMangmnt 123';
         
         insert SPEConMngmnt;
         

   
        ApexPages.StandardController sc = new ApexPages.StandardController(SPEConMngmnt);
        SPE2_CMAlternateLanguageExt  controller = new SPE2_CMAlternateLanguageExt(sc);
        controller.refreshLanguage();
 }
    }