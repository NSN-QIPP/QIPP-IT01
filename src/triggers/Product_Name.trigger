trigger Product_Name on NQT_Product__c (before update, before insert) {
    for(NQT_Product__c pr : Trigger.new){
        pr.Name = pr.Product_Name__c;
        if(pr.Legacy_Group__c == 'ANE')
            pr.NQT_In_Group__c = 'Ancillary';
        if(pr.Legacy_Group__c == 'FNE')
            pr.NQT_In_Group__c = 'Hardware';
        if(pr.Legacy_Group__c == 'SPARES')
            pr.NQT_In_Group__c = 'Spares';
    }
}