trigger MaterialDeviation_Validation on Material_Deviation__c (Before Insert, Before Update) {

    
    for(Material_Deviation__c nmc : Trigger.New)
    {
        MCAR_Claim_Management__c mcm = [SELECT Manufacturer__c FROM MCAR_Claim_Management__c WHERE ID =: nmc.MCAR_Claim_Management1__c];
        system.debug('anshul'+mcm);
        
        MCAR_MEPS__c mp = [SELECT Manufacturer_Name__c FROM MCAR_MEPS__c WHERE Id =: nmc.Code__c];
        
        if(mcm.Manufacturer__c  != mp.Manufacturer_Name__c)
         nmc.addError('Please enter the correct Manufacturer');
     }
    

}