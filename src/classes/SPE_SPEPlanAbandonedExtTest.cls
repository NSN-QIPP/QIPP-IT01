@isTest(SeeAllData = False)
public class SPE_SPEPlanAbandonedExtTest 
{
    static TestMethod void sPEPlanAbandonedExtTest()
    {
        
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
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
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
        spePlan.SPEPlanName__c = 'Test 12345';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.AggregationDuration__c = '1';
        spePlan.Organization_Group__c = 'Services Procurement';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.FrequencyInMonths__c = '1';
        insert spePLan;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.SPEPlan__c = spePlan.Id;     
        speTracker.SPETemplate__c = speTemplate.Id;
        
        insert speTracker;
        
        test.startTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        
        SPE_SPEPlanAbandonedExt spePLanAbandoned = new SPE_SPEPlanAbandonedExt(stCon);
        
        spePLanAbandoned.abandoned();
        
        test.stopTest();
                
        //List<SPE_SPETracker__c> speTrackerList = new List<SPE_SPETracker__c>();
        
        //for(integer i=0;i<10;i++)
            
        //{
          //  SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
            
            //speTracker.Status__c='abandoned';
            
            //speTrackerList.add(speTracker);
        //}
       
       //insert speTrackerList;
        /*
        speTracker.Status__c='Abandoned';
        
        update speTracker;
          */  
        
    }
}