trigger MCARFieldUpdation1 on MCAR__c (before update, before insert) {
    for(MCAR__c mcar: trigger.new){
        if(mcar.MCAR_Manufacturer__c != NULL){
            mcar.MCAR_Part_Enterprise_ID__c = [SELECT Enterprise_ID__c FROM MCAR_Manufacturer__c WHERE Id =: mcar.MCAR_Manufacturer__c].Enterprise_ID__c;
        }
    }
}