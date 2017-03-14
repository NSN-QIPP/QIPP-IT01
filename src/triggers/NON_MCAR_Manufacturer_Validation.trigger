trigger NON_MCAR_Manufacturer_Validation on Non_Mcar__c (Before Insert, Before Update) {

    
    for(Non_Mcar__c nmc : Trigger.New)
    {
        MCAR_Claim_Management__c mcm = [SELECT Manufacturer__c FROM MCAR_Claim_Management__c WHERE ID =: nmc.Claim__c];
        system.debug('anshul'+mcm);
        
        MCAR_MEPS__c mp = [SELECT Manufacturer_Name__c FROM MCAR_MEPS__c WHERE Id =: nmc.Code__c];
        
        if(mcm.Manufacturer__c  != mp.Manufacturer_Name__c)
         nmc.addError('Please enter the correct Manufacturer');
     }
    

}