trigger OnClaimOwnerChanged  on MCAR_Claim_Management__c (before update) {

for( MCAR_Claim_Management__c claim : Trigger.new ) {
        MCAR_Claim_Management__c ClaimBeforeUpdate = Trigger.oldMap.get( claim.Id );

        if( ClaimBeforeUpdate.OwnerId != claim.OwnerId)
               
            claim.Previous_Owner__c = ClaimBeforeUpdate.OwnerId;
    }

}