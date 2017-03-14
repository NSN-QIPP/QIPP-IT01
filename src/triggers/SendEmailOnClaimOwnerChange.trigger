trigger SendEmailOnClaimOwnerChange on MCAR_Claim_Management__c (after update) 
{        
    String oldOwner , newOwner,claimId;
    for(MCAR_Claim_Management__c c :Trigger.old )
    {  
        oldOwner = c.OwnerId;
    }        
    for(MCAR_Claim_Management__c c :Trigger.new )
    {  
        newOwner = c.OwnerId;
        claimId = c.Id;
    }
    system.debug('--------->'+oldOwner);
    system.debug('--------->'+newOwner);
    
    if(oldOwner!=newOwner)
    {
        SendEmailOnClaimOwnerChangeController.sendEmailToAll(claimId);
    }
    /*
    for(MCAR_Claim_Management__c c :Trigger.new)
    {        
        Strin oldOwnerId = 
        MCAR_Claim_Management__c c1 = c.trigger.old;
    if(c.Owner.Id!= c.trigger.old)  
    {
        system.debug('=======>'+c.Owner);
        system.debug('=======>'+c.Previous_Owner__c);
    }
        else
        {
            system.debug('----else part');
        }       
    }*/
}