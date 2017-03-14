trigger MCAR_Manufacturer_Validation  on MCAR_Claim__c (Before Insert, Before Update) {
    
    for(MCAR_Claim__c mc : Trigger.New)
    {
        MCAR_Claim_Management__c mcm = [SELECT Manufacturer__c FROM MCAR_Claim_Management__c WHERE ID =: mc.MCAR_Claim_Management__c];
        system.debug('anshul'+mcm);
        
        MCAR__c mmc = [SELECT MCAR_Manufacturer__c FROM MCAR__c WHERE ID =: mc.MCARs__c];
        system.debug('rakesh'+ mmc);
        
        if(mcm.Manufacturer__c  != mmc.MCAR_Manufacturer__c)
         mc.addError('Please enter the correct Manufacturer');
    }


 
}