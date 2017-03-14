@isTest
public with sharing class ManufacturerAccessSharingTestClass
{
/*
 * @ Last Modified By: Vivek Singh
 * @ Description: Hard Coded value is used which causes failure of test class.
 *                Functionality of Manufacturer Sharing have changed and New Test class is written for that.
 * @ Last Modified Date: 15 June 2015
 *
static testmethod void newUserShr1(){

   test.startTest();  
 MCAR_Manufacturer_Contact__c mcon= new MCAR_Manufacturer_Contact__c();
  
    mcon.Manufacturer_Name__c='a0nU0000000NcpD';
    mcon.MCAR_User__c='005U0000001KXVS';

    insert mcon;
    
    List<MCAR_Manufacturer__c> mcar =[SELECT Id,Name from MCAR_Manufacturer__c WHERE Id=:mcon.Manufacturer_Name__c];
    insert mcar;
    
    MCAR_Manufacturer__c manufacturer = new  MCAR_Manufacturer__c();
        manufacturer.Name = 'Test2';
        manufacturer.Enterprise_ID__c = 'Test3'; 
        
    
    test.stopTest();  
    
    }

*/
}