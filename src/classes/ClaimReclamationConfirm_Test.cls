@isTest
public class ClaimReclamationConfirm_Test 
{
    static testmethod void testInBoundEmail()
    {
        
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

       MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();        
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;        
        insert manufacturer ;
        
      MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
       claim.Manufacturer__c = manufacturer.Id;
       claim.Part_Category__c = 'Indirect Procurement (IP)' ;
       claim.Claims_Business_Unit__c = 'Business Solutions';
       claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
       claim.Category_Manager_Name__c = 'saran';
       claim.Sup_Confirmed_Re_ceipt_of_Reclamation__c = system.today();  
       claim.Supplier_Confirmation_Mail_Detail__c =' test supplier confermation mail detail';
       claim.Supplier_Confirmation_BY__c = 'someaddress@email.com';
       insert claim;
        
      email.subject = 'Claim-16152';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'email body\n2225256325\nTitle';
        

        
      List<Claim_Contact__c>  claimContList = new List<Claim_Contact__c>();
        for(integer i =0;i<10;i++){
        Claim_Contact__c claimCont = new Claim_Contact__c(Email__c= email.fromAddress,
        Contact_Type__c = 'Manufacturer',
        Claims__c = claim.Id ); 
        claimContList.add(claimCont);
    }
       insert claimContList;
        
        test.startTest();
        ClaimReclamationConfirm testInboundEmail = new ClaimReclamationConfirm();
        testInboundEmail.handleInboundEmail(email, env);
        test.stopTest();
}
    static testmethod void test2(){
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

      MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
      MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
       claim.Manufacturer__c = manufacturer.Id;
       claim.Part_Category__c = 'Indirect Procurement (IP)' ;
       claim.Claims_Business_Unit__c = 'Business Solutions';
       claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
       claim.Category_Manager_Name__c = 'saran';
       claim.Sup_Confirmed_Re_ceipt_of_Reclamation__c = system.today();  
       claim.Supplier_Confirmation_Mail_Detail__c =' test supplier confermation mail detail';
       claim.Supplier_Confirmation_BY__c = 'someaddress@email.com';
       insert claim;
        
      email.subject ='';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'email body\n2225256325\nTitle';
        

        
      List<Claim_Contact__c>  claimContList = new List<Claim_Contact__c>();
        for(integer i =0;i<10;i++){
        Claim_Contact__c claimCont = new Claim_Contact__c(Email__c= email.fromAddress,
        Contact_Type__c = 'Manufacturer',
        Claims__c = claim.Id ); 
        claimContList.add(claimCont);
    }
       insert claimContList;
        
        test.startTest();
        ClaimReclamationConfirm testInboundEmail = new ClaimReclamationConfirm();
        testInboundEmail.handleInboundEmail(email, env);
        test.stopTest();
}
    

}