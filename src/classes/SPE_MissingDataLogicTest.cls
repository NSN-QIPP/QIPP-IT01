@isTest
public class SPE_MissingDataLogicTest
{
      static testMethod void LogicFirstPositive()
      {   
           Account acc = new Account();
           acc.Name ='Test Account';
           acc.EnterpriseId__c='COSCOM';
           insert acc;
       
           SPE_Stop__c speStop = new SPE_Stop__c();
           speStop.Stop_trigger__c = true;
           speStop.Name = 'Stop';
           insert speStop;

        
           SPE_KPIDefinition__c kpidefinition=SPE_TestObjectCreator.CreateKPIDefinition(1);
           insert kpidefinition;
       
        
            SPE_KPIValue__c kpiValues = new SPE_KPIValue__c();
            kpiValues.Region__c = 'All markets';
            kpiValues.SubRegion__c = 'All market Units';
            kpiValues.Country__c = 'All Countries';
            kpiValues.Project__c = 'All Projects';
            kpiValues.BusinessUnit__c = 'All Business Units';
            kpiValues.BusinessLine__c = 'All Business Lines';
            kpiValues.Product__c = 'All Products';
            kpiValues.Cluster__c = 'All Category Areas';
            kpiValues.CategoryGroup__c = 'All Category Groups';
            kpiValues.Category__c = 'All Categories';
            kpiValues.KPIValue__c = 5;
            
            kpiValues.EnterpriseId__c='COSCOM';
            kpiValues.KPIDefinition__c=kpidefinition.Id;
            kpiValues.ExecutionPeriod__c='October - 2015';
            insert kpiValues;
            
            /*speStop.Stop_trigger__c = false;
            update speStop;*/
       
            SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
            insert speTemplate;
            speTemplate.Stage__c='Pilot';
            update speTemplate;
       
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
            scoringTemplate.Stage__c = 'Draft';
            insert scoringTemplate;
            scoringTemplate.Stage__c = 'Pilot';
            update scoringTemplate;
       
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
            spePlan.SPEPlanName__c='aAtos1';
            spePlan.FrequencyInMonths__c = '1';
            spePlan.SPETemplate__c = speTemplate.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            insert spePlan;
            spePlan.Stage__c='Published';
            update spePlan;
        
            SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            speTracker.DateOfExecution__c=system.today();
            speTracker.SPETemplate__c = speTemplate.Id;
            speTracker.SPEPlan__c = spePlan.Id;
            insert speTracker;
        
            SPE_TrackerValues__c trackerValues =SPE_TestObjectCreator.createTrackerValue();
            insert trackerValues;
        
            PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
            default1.Name='Picklist';
            insert default1;
        
            SPE_MissingDataLogic.LogicFirst(kpidefinition.Id,2,system.today(),'COSCOM',speTracker,trackerValues );
    }
    
    static testMethod void LogicSecondPositive()
      {   
           Account acc = new Account();
           acc.Name ='Test Account';
           acc.EnterpriseId__c='COSCOM';
           insert acc;
       
           SPE_Stop__c speStop = new SPE_Stop__c();
           speStop.Stop_trigger__c = true;
           speStop.Name = 'Stop';
           insert speStop;

        
           SPE_KPIDefinition__c kpidefinition=SPE_TestObjectCreator.CreateKPIDefinition(1);
           insert kpidefinition;
       
        
            SPE_KPIValue__c kpiValues = new SPE_KPIValue__c();
            kpiValues.Region__c = 'All markets';
            kpiValues.SubRegion__c = 'All market Units';
            kpiValues.Country__c = 'All Countries';
            kpiValues.Project__c = 'All Projects';
            kpiValues.BusinessUnit__c = 'All Business Units';
            kpiValues.BusinessLine__c = 'All Business Lines';
            kpiValues.Product__c = 'All Products';
            kpiValues.Cluster__c = 'All Category Areas';
            kpiValues.CategoryGroup__c = 'All Category Groups';
            kpiValues.Category__c = 'All Categories';
            kpiValues.KPIValue__c = 5;
            
            kpiValues.EnterpriseId__c='COSCOM';
            kpiValues.KPIDefinition__c=kpidefinition.Id;
            kpiValues.ExecutionPeriod__c='June - 2015';
            insert kpiValues;
            
            /*speStop.Stop_trigger__c = false;
            update speStop;*/
       
            SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
            insert speTemplate;
            speTemplate.Stage__c='Pilot';
            update speTemplate;
       
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
            scoringTemplate.Stage__c = 'Draft';
            insert scoringTemplate;
            scoringTemplate.Stage__c = 'Pilot';
            update scoringTemplate;
       
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
            spePlan.SPEPlanName__c='aAtos1';
            spePlan.FrequencyInMonths__c = '1';
            spePlan.SPETemplate__c = speTemplate.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            insert spePlan;
            spePlan.Stage__c='Published';
            update spePlan;
        
            SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            speTracker.DateOfExecution__c=system.today();
            speTracker.SPETemplate__c = speTemplate.Id;
            speTracker.SPEPlan__c = spePlan.Id;
            insert speTracker;
        
            SPE_TrackerValues__c trackerValues =SPE_TestObjectCreator.createTrackerValue();
            insert trackerValues;
        
            PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
            default1.Name='Picklist';
            insert default1;
        
            SPE_MissingDataLogic.LogicFirst(kpidefinition.Id,2,system.today(),'COSCOM',speTracker,trackerValues );
    }
    
    static testMethod void LogicThirdPositive()
      {   
           Account acc = new Account();
           acc.Name ='Test Account';
           acc.EnterpriseId__c='COSCOM';
           insert acc;
       
           SPE_Stop__c speStop = new SPE_Stop__c();
           speStop.Stop_trigger__c = true;
           speStop.Name = 'Stop';
           insert speStop;

        
           SPE_KPIDefinition__c kpidefinition=SPE_TestObjectCreator.CreateKPIDefinition(1);
           insert kpidefinition;
       
        
            SPE_KPIValue__c kpiValues = new SPE_KPIValue__c();
            kpiValues.Region__c = 'All markets';
            kpiValues.SubRegion__c = 'All market Units';
            kpiValues.Country__c = 'All Countries';
            kpiValues.Project__c = 'All Projects';
            kpiValues.BusinessUnit__c = 'All Business Units';
            kpiValues.BusinessLine__c = 'All Business Lines';
            kpiValues.Product__c = 'All Products';
            kpiValues.Cluster__c = 'All Category Areas';
            kpiValues.CategoryGroup__c = 'All Category Groups';
            kpiValues.Category__c = 'All Categories';
            kpiValues.KPIValue__c = 5;
            
            kpiValues.EnterpriseId__c='COSCOM';
            kpiValues.KPIDefinition__c=kpidefinition.Id;
            kpiValues.ExecutionPeriod__c='April - 2015';
            insert kpiValues;
            
            /*speStop.Stop_trigger__c = false;
            update speStop;*/
       
            SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
            insert speTemplate;
            speTemplate.Stage__c='Pilot';
            update speTemplate;
       
            SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
            scoringTemplate.Stage__c = 'Draft';
            insert scoringTemplate;
            scoringTemplate.Stage__c = 'Pilot';
            update scoringTemplate;
       
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
            spePlan.SPEPlanName__c='aAtos1';
            spePlan.FrequencyInMonths__c = '1';
            spePlan.SPETemplate__c = speTemplate.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            insert spePlan;
            spePlan.Stage__c='Published';
            update spePlan;
        
            SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            speTracker.DateOfExecution__c=system.today();
            speTracker.SPETemplate__c = speTemplate.Id;
            speTracker.SPEPlan__c = spePlan.Id;
            insert speTracker;
        
            SPE_TrackerValues__c trackerValues =SPE_TestObjectCreator.createTrackerValue();
            insert trackerValues;
        
            PicklistDefaultValues__c default1 = SPE_TestObjectCreator.CreateDefaultPicklist();
            default1.Name='Picklist';
            insert default1;
        
            SPE_MissingDataLogic.LogicFirst(kpidefinition.Id,2,system.today(),'COSCOM',speTracker,trackerValues );
    } 
}