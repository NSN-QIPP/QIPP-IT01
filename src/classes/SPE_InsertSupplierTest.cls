@isTest(SeeAllData = False)
private class SPE_InsertSupplierTest {
    
   // private static SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
   // private static Account supplier =new Account() ;
  //  private static SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();

    static testMethod void addSupplierTestPositive() {
    
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
        
       Account acc = new Account();
       acc.Name ='Test Account';
       //acc.ParentId = Null;
       acc.EnterpriseId__c='FCI';
       acc.SupplierId__c='Test1';
       insert acc;
       
       SPE_CategoryInfo__c scinfo = new SPE_CategoryInfo__c();       
       scinfo.Supplier__c = acc.Id;
       insert scinfo;
        
       SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
       insert speTemplate;
       
       speTemplate.Stage__c='Pilot';
       update speTemplate;
       
       system.debug('==>speTemplate'+speTemplate);
        
       SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
       scoringTemplate.Stage__c = 'Draft';
       insert scoringTemplate;
       
       scoringTemplate.Stage__c = 'Published';
       update scoringTemplate;
       
       speTemplate.Stage__c='Published';
       update speTemplate;
       
       system.debug('==>speTemplate'+speTemplate);
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos1';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.SPETemplate__c = speTemplate.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        insert spePlan;
        
        
        SPE_SPEPlanSupplierMap__c supplierMap =new SPE_SPEPlanSupplierMap__c();
        supplierMap.SPEPlan__c=spePlan.Id;
        supplierMap.Supplier__c =acc.Id;
        
        insert supplierMap;
        
        system.debug(supplierMap.id+'==========');
        system.debug(spePlan.id);
        
        PageReference pageRef = Page.SPE_AddSupplier;
        Test.setCurrentPage(pageRef);
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(spePlan);
        SPE_InsertSupplier insertSupplier1 = new SPE_InsertSupplier(stCon);
        insertSupplier1.addSupplier();
        
        pageRef.getParameters().put('searchString',acc.EnterpriseId__c);
        insertSupplier1.supplierName = '*FCI';        
        insertSupplier1.searchSupplier();
        
        insertSupplier1.supplierName = 'FCI*';
        insertSupplier1.searchSupplier();
        
        insertSupplier1.supplierName = '*FCI*';
        insertSupplier1.searchSupplier();
        
        insertSupplier1.supplierName = 'FCI';
        insertSupplier1.searchSupplier();
        
        insertSupplier1.insertSupplierForPlan();
        insertSupplier1.cancelforPlan();
        //insertSupplier1.cancel();
       /* SPE_InsertSupplier.SupplierWrapper swrap = new SPE_InsertSupplier.SupplierWrapper(insertSupplier1);
        swrap.isChecked=true;
        insertSupplier1.SupplierWrapperList.add(swrap);*/
        
    }
    
}