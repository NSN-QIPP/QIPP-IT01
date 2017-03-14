@isTest(SeeAllData = True)
public class SPE_TrackerViewTest 
{
    static testMethod void positiveTest()
    {
         
         SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
         insert speTemplate;
         
         SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
         spePlan.SPEPlanName__c = 'Test SPE Plan 1234';
         spePlan.SPETemplate__c = speTemplate.Id;
         insert spePlan;
         
         SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
         speTracker.SPEPlan__c = spePlan.Id;
         speTracker.SPETemplate__c = speTemplate.Id;
         insert speTracker;
         
         SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
         insert kpiDefinition1;
         
         Account supplier = SPE_TestObjectCreator.CreateSupplier('Accenture2');
         try{
         insert supplier;
         }catch(Exception e){}
         SPE_TrackerValues__c trackerValue = SPE_TestObjectCreator.createTrackerValue();
         trackerValue.Supplier__c = supplier.Id;
         trackerValue.KPIDefinition__c = kpiDefinition1.Id;
         trackerValue.SPETracker__c = speTracker.Id;
         trackerValue.Weight__c = 30;
         trackerValue.Score1__c = 1.30;
         trackerValue.Score__c = 1;
         
         insert trackerValue;
         
        
         Apexpages.currentPage().getParameters().put('id', speTracker.Id);
         
         SPE_TrackerView trackerView = new SPE_TrackerView();
         
       
        
    }

}