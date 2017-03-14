@isTest
public class ClaimEmailController_Test {
    
    static testmethod void positiveTest()
    {
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
        MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
        claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claim.Category_Manager_Name__c = 'saran';
        claim.Sending_Settlement_letter__c = true;
        
        insert claim;
       
       List<Claim_Contact__c> claimcontactList = new List<Claim_Contact__c>();
        for(integer i=1; i<10;i++){
        Claim_Contact__c c1 = new Claim_Contact__c(Contact_Type__c = 'SQM',
        Name__c = 'saran',
        Email__c='test@gmail.com',
        Claims__c = claim.Id);
        claimcontactList.add(c1);
        }
        insert claimcontactList;
        
       test.startTest();
       ApexPages.StandardController sc = new ApexPages.standardController(claim);          
       ApexPages.CurrentPage().getparameters().put('id', claim.id);          
       ClaimEmailController cEmailCon = new ClaimEmailController(sc);
       ClaimEmailController.sendMail(claim.id);
       test.stopTest();
    }
    
    static testmethod void NegativeTest()
    {
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
        MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
        claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claim.Category_Manager_Name__c = 'saran';
        claim.Sending_Settlement_letter__c = true;
        
        insert claim;
       
       List<Claim_Contact__c> claimcontactList = new List<Claim_Contact__c>();
        for(integer i=1; i<10;i++){
        Claim_Contact__c c1 = new Claim_Contact__c(Contact_Type__c = 'Category Manager',
        Name__c = 'saran',
        Email__c='test@gmail.com',
        Claims__c = claim.Id);
        claimcontactList.add(c1);
        }
       insert claimcontactList;

        
       test.startTest();
       ApexPages.StandardController sc = new ApexPages.standardController(claim);          
       ApexPages.CurrentPage().getparameters().put('id', claim.id);          
       ClaimEmailController cEmailCon = new ClaimEmailController(sc);
       ClaimEmailController cEmailCon1 = new ClaimEmailController();
       ClaimEmailController.sendMail(claim.id);
       test.stopTest();
    }
 }