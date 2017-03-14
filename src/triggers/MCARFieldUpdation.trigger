trigger MCARFieldUpdation on MCAR_MEPS__c (before update, before insert) {
    for(MCAR_MEPS__c meps: trigger.new){
        if(meps.Manufacturer_Name__c != NULL){
            meps.MCAR_MEPS_Enterprise_ID__c = [SELECT Enterprise_ID__c FROM MCAR_Manufacturer__c WHERE Id =: meps.Manufacturer_Name__c].Enterprise_ID__c;
        }
    }
}