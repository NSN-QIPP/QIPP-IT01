@isTest(seeAllData=False)
public with sharing class SPE_KPIValueTriggerTest{

public static  testmethod void SPE_KPIValueTriggerTest(){

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

     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
     
     //********************Changes For Encryption********************//
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
     //********************END********************//   
    
    kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
    kpiDefinition1.Level__c = '1';
    kpiDefinition1.LifecycleStage__c = 'Draft';
    kpiDefinition1.Description__c = 'Test';
    kpiDefinition1.MissingDatalogic__c = 'Logic1';
    kpiDefinition1.OperationalType__c = 'Leading PI';
    kpiDefinition1.GeoScope__c = 'All Markets';
    kpiDefinition1.categoryscope__c = 'All Categories';
    kpiDefinition1.BUScope__c = 'All Products';
    kpiDefinition1.UoM__c = 'max';
    kpiDefinition1.Group1__c = 'Cost';
    kpiDefinition1.Group2__c = 'Hard';
    kpiDefinition1.Type__c = 'Operational';
    kpiDefinition1.FrequencyinMonth__c = '2';
    kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
    kpiDefinition1.VerNumber__c = 0;
    insert kpiDefinition1;
        


System.AssertNotEquals(kpiDefinition1.id,null);     
  SPE_KPIValue__c kpv = new SPE_KPIValue__c();
  kpv.KPIDefinition__c=  kpiDefinition1.id;
  kpv.ExecutionPeriod__c='25';
  insert kpv;   
System.AssertNotEquals(kpv.id,null);   
  
  kpv.ExecutionPeriod__c='20';
  Update kpv;      
}
}