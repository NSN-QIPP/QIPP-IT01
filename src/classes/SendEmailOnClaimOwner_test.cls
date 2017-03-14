@istest
public class SendEmailOnClaimOwner_test {
static testmethod void test(){
           MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
       MCAR_Claim_Management__c Claim = new MCAR_Claim_Management__c();
         claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
        insert claim;    
}
}