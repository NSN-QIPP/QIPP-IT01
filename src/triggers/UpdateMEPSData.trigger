/*
    Author - Sunanda Budati
    Developed on - 05/07/2015
*/

trigger UpdateMEPSData on MCAR_Supplier_Data_Cross_Reference__c (before insert,before update) {
    if((trigger.isInsert && trigger.isBefore) || (trigger.isUpdate && trigger.isBefore)) { 
     
     
        MCARSupplierDataTriggerUtils.updateMEPSData(Trigger.new);
    } 
}