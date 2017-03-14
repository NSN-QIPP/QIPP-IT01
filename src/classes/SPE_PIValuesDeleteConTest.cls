@isTest(SeeAllData = False)
private class SPE_PIValuesDeleteConTest 
{
    static testMethod void DeletePIValuesPositive() 
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
        
        Account supp = SPE_TestObjectCreator.CreateSupplier('Enterprise1');
        
        insert supp;
        
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.LifecycleStage__c ='Draft';
        
        insert piDef;
        
        SPE_PIValues__c piValues = SPE_TestObjectCreator.CreatePIValues(piDef.Id, supp.Id, supp.EnterpriseId__c);
        
        try{
            insert piValues;
            }
        Catch(Exception e)
        {
        }
        Test.startTest();
        
        Apexpages.currentPage().getParameters().put('Id', piDef.Id);
        
        SPE_PIValuesDeleteCon piValuesRecord = new SPE_PIValuesDeleteCon();
        
        
        piValuesRecord.deletePIValues();
        
        List<SPE_PIValues__c> piValuesList = [SELECT Id 
                                              FROM SPE_PIValues__c
                                              WHERE PIDefination__c =: piDef.Id];
                                              
        System.assert(piValuesList.size() == 0);
        
        Test.stopTest();
    }

}