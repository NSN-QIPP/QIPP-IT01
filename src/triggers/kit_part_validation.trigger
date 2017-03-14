trigger kit_part_validation on NQT_Eq_Detail__c (before insert, before update) {
    list<NQT_Eq_Detail__c> kpCheck = [SELECT NQT_Part_Number__c FROM NQT_Eq_Detail__c WHERE NQT_Equipment_List__c =: trigger.new[0].NQT_Equipment_List__c];
    //NQT_Equipment_List__c el = [SELECT Id, Duplication_Check__c FROM NQT_Equipment_List__c WHERE Id =: trigger.new[0].NQT_Equipment_List__c LIMIT 1];
    if(!kpCheck.isEmpty()){
        for(NQT_Eq_Detail__c kp : trigger.new){
            for(NQT_Eq_Detail__c kpTemp : kpCheck)
                if(kpTemp.NQT_Part_Number__c == kp.NQT_Part_Number__c){
                    
                        kp.NQT_Part_Number__c.addError('This Kit/Part Number has already been used. Kindly increase the quantity of Kit/Part in related record.');
                    
                }
        }
    }
}