@istest 
public class TestUpdateNSNPartsData{

public static testmethod void UpdateNSNPartsDatatestmethod()
{

MCAR_Category_Cross_Reference__c   obj = new MCAR_Category_Cross_Reference__c();
obj.name= 'abc';
try {
insert obj;
}catch(exception ex){

system.debug('******ex*******' + ex);
}
}


public static testmethod void UpdateMEPSDatatestmethod(){

MCAR_Supplier_Data_Cross_Reference__c obj = new MCAR_Supplier_Data_Cross_Reference__c();
obj.name= 'abc';
try {
insert obj;
}catch(exception ex){

system.debug('******ex*******' + ex);
}
}



}