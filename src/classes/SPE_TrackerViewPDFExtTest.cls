@isTest
public class SPE_TrackerViewPDFExtTest
{
    public static testmethod void trackerPositive() 
    {
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
         insert speTemplate;
       speTemplate.Stage__c='Pilot';
       update speTemplate;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Stage__c = 'Draft';
       insert scoringTemplate;
       
        scoringTemplate.Stage__c = 'Pilot';
       update scoringTemplate;
        
        speTemplate.Stage__c = 'Published';
        update speTemplate;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
         spePlan.SPEPlanName__c='aAtos01';
         spePlan.Organization_Group__c = 'Services Procurement';
         spePlan.AggregationDuration__c = '1';
        insert spePlan;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c = 'All Business Units';
        speTracker.BusinessLine__c = 'All Business Lines';
        speTracker.Product__c = 'All Products';
        
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.SPETemplate__c = speTemplate.Id;
        speTracker.DateOfExecution__c = Date.today();
        
        insert speTracker;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('AtosUK');
        insert supplier;
        
        List<SPE_TrackerValues__c> trackerValues = new List<SPE_TrackerValues__c>();
        
        for(Integer i=0 ; i<=5 ; i++)
        {
            SPE_TrackerValues__c trackerValue = SPE_TestObjectCreator.createTrackerValue();
            trackerValue.Score1__c = i;
            trackerValue.SPETracker__c = speTracker.Id;
            trackerValue.Supplier__c = supplier.Id;
            
            trackerValues.add(trackerValue);
        }
        insert trackerValues;
        
        Apexpages.StandardController st = new Apexpages.StandardController(speTracker);
        
        SPE_TrackerViewPDFExt trackerPdfExt = new SPE_TrackerViewPDFExt(st);
        trackerPdfExt.PDFGen();
        trackerPdfExt.ExlGen();
    }
}