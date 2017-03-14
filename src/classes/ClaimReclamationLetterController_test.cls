@istest
public class ClaimReclamationLetterController_test {

    static testmethod void test(){
        
        List<String> myList = new List<String>{'priya.burghate@yahoo.com', 'saran.golagani@yahoo.com'};
    
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c = manufacturer.Id;
        claimRec.Part_Category__c = 'Indirect Procurement (IP)' ;
        claimRec.Claims_Business_Unit__c = 'Business Solutions';
        claimRec.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claimRec.Category_Manager_Name__c = 'saran';
        claimRec.Manufacturer_Email__c = 'priyabirghate@yahoo.com';
        insert claimRec;
        
        MCAR_Claim_Management__c claimRec1 = new MCAR_Claim_Management__c();
        claimRec1.Manufacturer__c = manufacturer.Id;
        claimRec1.Part_Category__c = 'Indirect Procurement (IP)' ;
        claimRec1.Claims_Business_Unit__c = 'Business Solutions';
        claimRec1.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claimRec1.Category_Manager_Name__c = 'saran';
        insert claimRec1;
        
        Claim_Contact__c cliamCont = new Claim_Contact__c();
        cliamCont.Email__c='priyabirghate@yahoo.com';
        cliamCont.Name__c = 'raj';
        cliamCont.Contact_Type__c = 'Manufacturer';
        cliamCont.Claims__c = claimRec.Id;
        insert cliamCont;
        
        Claim_Contact__c ManufacturerContactRec = new Claim_Contact__c();
        ManufacturerContactRec.Contact_Type__c = 'Manufacturer';
        ManufacturerContactRec.Name__c = 'saran';
        ManufacturerContactRec.Email__c='test@gmail.com';        
        ManufacturerContactRec.Claims__c = claimRec1.Id;
        insert ManufacturerContactRec;
        
        Claim_Contact__c ManufacturerContactRec1 = new Claim_Contact__c();
        ManufacturerContactRec1.Contact_Type__c = 'Category Manager';
        ManufacturerContactRec1.Name__c = 'saran';
        ManufacturerContactRec1.Email__c='test123@gmail.com';        
        ManufacturerContactRec1.Claims__c = claimRec1.Id;
        insert ManufacturerContactRec1;
        
        MCAR_Manufacturer_Contact__c supplierContactRec = new MCAR_Manufacturer_Contact__c();
        supplierContactRec.MCAR_Street__c ='Embessy Techzone';
        supplierContactRec.MCAR_City__c = 'Pune';
        supplierContactRec.MCAR_Country__c ='India';
        supplierContactRec.State__c = 'Maharashtra' ;
        supplierContactRec.Zip__c = 123456;
        supplierContactRec.Manufacturer_Name__c = manufacturer.Id;
        supplierContactRec.Email__c = claimRec.Manufacturer_Email__c;
        insert supplierContactRec;
        
        MCAR_Manufacturer_Contact__c query = [select id,name,MCAR_Street__c,MCAR_City__c,MCAR_Country__c,State__c,Zip__c from MCAR_Manufacturer_Contact__c where Manufacturer_Name__c =: claimRec.Manufacturer__c and Email__c =:claimRec.Manufacturer_Email__c ];
        QIPP_Contacts__c qippCont = new QIPP_Contacts__c();
        qippCont.Title__c = 'jobtitle';
        qippCont.Email__c = 'priya.burghate@atos.net';
        insert qippCont;
        
        Attachment attach = new attachment();
        attach.Name ='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=claimRec.id;
        insert attach;
        
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.standardController(claimRec);
        ApexPages.CurrentPage().getparameters().put('id', claimRec.id);
        ClaimReclamationLetterController claimRecLetCont = new ClaimReclamationLetterController(sc);
        //claimRecLetCont.JobTitle  = qippCont.Title__c ;
        //claimRecLetCont.ClaimName = claimRec.Name ;
        //claimRecLetCont.toAddresses =[priya.burghate@yahoo.com ,saran.golagani@gmail.com];
        ClaimReclamationLetterController.sendReclamationLetter(claimRec1.id);
        ClaimReclamationLetterController.isSentAlready(claimRec1.id);
        ClaimReclamationLetterController.isfoundManufacturer(claimRec.id);
        ClaimReclamationLetterController.ClaimName = claimRec1.Name ;
        test.stopTest();
        
        
        
    }
}