@isTest
public class SendEmailOnClaimOwnerChange_Test {
    static testmethod void test1(){
        MCAR_Claim_Management__c mcarClaim = new MCAR_Claim_Management__c();
        String cID;
        test.startTest();
        //mcarClaim.OwnerId='005U0000000GMgA';
        insert mcarClaim;
        mcarClaim.Claim_Type__c='sqm';
       // mcarClaim.OwnerId='00517000001Pk9i';
        cID = mcarClaim.Id;
        update mcarClaim;
        
        
        test.stopTest();
        
        
    }

}