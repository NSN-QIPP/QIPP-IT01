/*
    Author - Sunanda Budati
    Developed on - 04/09/2015
*/

trigger UpdateNSNPartsData on MCAR_Category_Cross_Reference__c (before insert,before update) {
    if((trigger.isInsert && trigger.isBefore) || (trigger.isUpdate && trigger.isBefore)) { 
        set<String> ESNNameSet = new set<String>();
        for(MCAR_Category_Cross_Reference__c mcarCat : trigger.new){
            ESNNameSet.add(mcarCat.ESN__c);
        }
        MCARSupplierDataTriggerUtils.updateNSNParts(ESNNameSet);
    } 
}