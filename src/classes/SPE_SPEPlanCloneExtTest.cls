@isTest(SeeAllData = False)

public class SPE_SPEPlanCloneExtTest
{
   public static testMethod void testSPE_SPEPlanCloneExt() 
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
        
        Contact objContact = SPE_TestObjectCreator.CreateContact('Test Contact');
        insert objContact;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('Test Account');
        supplier.SupplierManager__c = objContact.id;
        insert supplier;
        
        SPE_SPEPlanSupplierMap__c supplierPlanMap = new SPE_SPEPlanSupplierMap__c();
        supplierPlanMap.Supplier__c = supplier.Id ;
        supplierPlanMap.SPEPlan__c= spePlan.Id;
        insert supplierPlanMap;
        
        SPE_Respondent__c objRespondent = new SPE_Respondent__c();
        objRespondent.SPEPlan__c = spePlan.id;
        objRespondent.contact__c= objContact.id;
        insert objRespondent;
        
        test.startTest();
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        
        SPE_SPEPlanCloneExt objSPE_SPEPlanCloneExt = new SPE_SPEPlanCloneExt(stCon);
        objSPE_SPEPlanCloneExt.cloneSPEPlan();
        objSPE_SPEPlanCloneExt.backToSPE();
        
        test.stopTest();
    }
}