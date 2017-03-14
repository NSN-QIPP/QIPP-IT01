@isTest
public with sharing class MCARTiggerTestClass  {

    static testmethod void fieldUpdation(){
        MCAR_Manufacturer__c manufacturer = new  MCAR_Manufacturer__c();
        manufacturer.Name = 'Test';
        manufacturer.Enterprise_ID__c = 'Test1'; 
        insert manufacturer;
        
        MCAR__c MCAR = new MCAR__c();
        MCAR.MCAR_Manufacturer__c = manufacturer.Id;
        insert MCAR;
        
        MCAR_MEPS__c MEPS = new MCAR_MEPS__c();
        MEPS.Name = 'test';
        MEPS.Manufacturer_Name__c = manufacturer.Id;
        insert MEPS;
    }
}