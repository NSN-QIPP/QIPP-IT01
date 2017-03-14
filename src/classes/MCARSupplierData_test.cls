@isTest
Public class MCARSupplierData_test
{
public static testmethod void UpdateNSNPartsDatatestmethod()
{

MCAR_Category_Cross_Reference__c   obj = new MCAR_Category_Cross_Reference__c();
obj.name= 'abc';
obj.Category_Area__c ='testarea';
obj.Category_Area_ID__c ='testareaid';
obj.Category_Group__c = 'testgroup';
obj.Category_Group_ID__c ='testgroupcid';
obj.Category_ID__c = 'catid';
obj.COM__c ='com';
obj.Sub_Category__c='sub';
obj.ESN__c='esn';
insert obj;

}

public static testmethod void UpdateMEPSDatatestmethod(){


MCAR_Manufacturer__c man = new MCAR_Manufacturer__c();
man.name = 'mtest';

insert man;

MCAR_Supplier_Data_Cross_Reference__c obj = new MCAR_Supplier_Data_Cross_Reference__c();
obj.name= 'abc';
obj.Enterprise_ID__c='testid';
obj.Manufacturer_Name__c = man.name;
obj.Supplier_Name__c='testname';


MCAR_MEPS__c mep = new MCAR_MEPS__c();
mep.Manufacturer_Name__c=man.id;
insert mep;
MCAR_MEPS__c mep1 = new MCAR_MEPS__c();
mep1 = [select id,name,Supplier_Name__c,Supplier_ID__c from MCAR_MEPS__c where id =:mep.id];
mep1.Supplier_ID__c = obj.name;
mep1.Supplier_Name__c = obj.Supplier_Name__c;
update mep1;
insert obj;


}

}