@isTest(SeeAllData = False)
public class SPE_SPEPlanTriggerTest
{
     static testMethod void DeleteValidationPositive()
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
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.SPEPlanName__c='aAtos001';
        spePlan.Organization_Group__c = 'Services Procurement';
        spePlan.AggregationDuration__c = '1';
        insert spePlan;
         
        SPE_SPETracker__c  speTracker = new SPE_SPETracker__c();
        speTracker.Status__c='Completed';
        speTracker.SPEPlan__c=spePlan.Id;
        insert speTracker;
         
        try 
         {
            delete spePlan;
         } 
         catch (DMLException e){} 
     }
     
     static testMethod void UpdateSPETemplatePositive()
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
           
    Set<Id> speTempIds = new Set<Id>();
    List<SPE_SPEPlan__c>  splan = new List<SPE_SPEPlan__c>();
    Map<Id, SPE_SPEPlan__c> oldSPEPlanMaps = new Map<Id, SPE_SPEPlan__c>();
    
    //List<SPE_SPETracker__c> toBeUpdatedTracker = new List<SPE_SPETracker__c>();
    //List<SPE_SPETemplate__c> toBeUpdatedSPETemplate = new List<SPE_SPETemplate__c>();
    //List<SPE_SPETemplate__c> speTemplates = new List<SPE_SPETemplate__c>(); 
    
    SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
    spePlan.SPEPlanName__c = 'New Demo Plan 1222';
    insert spePlan;
    
    spePlan.Stage__c='Published'; 
    update spePlan; 
    
    spePlan.Stage__c='Obsolete';
    update spePlan;
    
    SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
    speTracker.Status__c='Pending';
    speTracker.SPEPlan__c = spePlan.Id;
    insert speTracker;
    
    speTracker.Status__c='Abandoned';
    update speTracker;
    
    //toBeUpdatedTracker.add(speTracker);
    
    SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
    speTemp.Name = 'Test 12';
    //speTemp.Id = speTemplates.Id;
    speTemp.Stage__c = 'Published';
    insert speTemp;
    
    speTempIds.add(speTemp.Id); 
    splan.add(spePlan);
    

    oldSPEPlanMaps.put(spePlan.ID,spePlan);
    
    SPE_SPEPlanTrigger sptr = new SPE_SPEPlanTrigger();
    //sptr.UpdateSPETemplate(splan,oldSPEPlanMaps);
           
       }
  }