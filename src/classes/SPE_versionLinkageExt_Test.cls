@isTest(SeeAllData=False)
public class SPE_versionLinkageExt_Test{
    
    public static testmethod void testSPE_versionLinkageExt1(){
    
    test.startTest();
    
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
    picklistObj.Name = 'Test Picklist Default Values 1234';
    picklistObj.Product__c = 'All Products';
    picklistObj.Project__c = 'All Projects';
    
    lstpicklistObj.add(picklistObj);
    
    insert lstpicklistObj;
    
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
    SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
    kpidef.ActualCalculation__c= 'a';
    insert kpidef;
    
    kpidef.LifecycleStage__c = 'Pilot';
    update kpidef;
    
    SPE_KPIDefinition__c kpidef2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
    kpidef.ActualCalculation__c= 'a2';
    insert kpidef2;
    
    SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
    system.assert(resultObj!=null);
    
    SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        speTemp.BusinessLine__c ='All Business Units';
        speTemp.BusinessUnit__c ='All Business Lines';
        speTemp.Product__c = 'All Products';   
    insert speTemp;
    
    speTemp.Stage__c ='Pilot';
    update speTemp;
       
    PageReference pageRef = Page.SPE_VersionLinkage;
    Test.setCurrentPage(pageRef);
    ApexPages.currentPage().getParameters().put('id', kpidef.Id);
    ApexPages.currentPage().getParameters().put('Lifecycle','Pilot');
    
    SPE_versionLinkageExt testObj = new SPE_versionLinkageExt();
    SPE_versionLinkageExt.VersionLinkageWrapper wrap = new SPE_versionLinkageExt.VersionLinkageWrapper(speTemp.Id,'Test','Test','Pilot',kpidef.Id,'1');

    test.stopTest();
    
    }
    
    //
    
    public static testmethod void testSPE_versionLinkageExt2(){
    
    test.startTest();
    
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
    picklistObj.Name = 'Test Picklist Default Values 12';
    picklistObj.Product__c = 'All Products';
    picklistObj.Project__c = 'All Projects';
    
    lstpicklistObj.add(picklistObj);
    
    insert lstpicklistObj;
    
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
    SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
    kpidef.ActualCalculation__c= 'a';
    insert kpidef;
    
    kpidef.LifecycleStage__c = 'Pilot';
    update kpidef;
    
    SPE_KPIDefinition__c kpidef2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
    kpidef.ActualCalculation__c= 'a2';
    insert kpidef2;
    
    SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
    system.assert(resultObj!=null);
       
    PageReference pageRef = Page.SPE_VersionLinkage;
    Test.setCurrentPage(pageRef);
    ApexPages.currentPage().getParameters().put('id', kpidef.Id);
    ApexPages.currentPage().getParameters().put('Lifecycle','Pilot');
    
    SPE_versionLinkageExt testObj = new SPE_versionLinkageExt();

    testObj.updateKPI();
    //testObj.replaceKPI();
    
    test.stopTest();
    
    }
    
}