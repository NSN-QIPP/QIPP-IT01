@isTest(SeeAllData=true)
public class getClaimRecordForPDF_Test {

    public static testMethod void ClaimPdfGenerator()
    {
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        manufacturer.Name='supplier name';
        insert manufacturer ;
        
               
        MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
        claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claim.Amount__c=100;
        claim.Claim_Status__c='Data Collection'; 
        claim.Approvals_comments__c='test';
        claim.Cancel_Comments__c='cancel';
        claim.Category_Manager_Email__c='test@gmail.com';
        claim.Category_Manager_Name__c='manager';
        claim.Claim_Direction__c='Incoming';
        claim.Claim_Type__c='Global';
        claim.Claims_Business_Line__c='Operation Support Solutions';
        claim.Claims_Business_Unit__c='Global Services';
        claim.Claim_Status__c ='Payments';
        claim.Expected_Closing_Date__c=system.today();
        claim.Claim_Open_Date__c = system.today()-1;
        claim.Date_Problem_Was_First_Detected__c = system.today();
        claim.Sending_Settlement_letter__c=true;
        claim.Root_Cause_Summary__c = 'root cause summary';
        claim.Other_Information__c ='other information';
        claim.Corrective_Actions_Summary__c='corrective action summary' ;
        claim.Manufacturer_Accepts_Full_Responsibility__c= true;
        //claim.Total_Claim_Cost__c=10000;
        claim.Total_Cost_To_Be_Claimed__c = 10000;
        claim.Override_Claim_Type__c = true;
        claim.Services_Loss__c = 50;
        claim.Materials_Factory_Loss__c=50;
        claim.Materials_Field_Loss__c=50;
        claim.Materials_Hub_Loss__c=50;
        claim.Technical_Details_Review_Approval__c= true;
        claim.Nonconformance_Costs_Review_Approval__c= true;
        claim.Legal_Team_Review_Approval__c=true;
        claim.Commodity_Manager_Review_Approval__c=true;
        claim.Root_Cause_Analysis_Approved_Date__c= system.today();
        claim.Non_Conformance_Costs_Approved_Date__c= system.today();
        claim.Legal_Analysis_Approved_Date__c=system.today();
        claim.Commodity_Manager_Approved_Date__c = system.today();
        claim.Payment_Time_period__c='4 days';
        claim.Method_of_Payment__c='Credit Note';
        //claim.Validated_Payments_Total__c=500;
        //claim.Confirmed_Write_Offs__c=500;
       // claim.Confirmed_Payments__c=1000;
        insert claim;    
        
       
        MCAR_Facility__c facility = new MCAR_Facility__c();
        facility.Name = 'ss';
        facility.MCAR_Facility_Company__c = 'Atos';
        facility.MCAR_Facility_Country__c = 'India';
        facility.MCAR_Facility_Type__c = 'EMS';
        facility.MCAR_Facitily_City__c = 'vijayawada';
        
         insert facility;
        
        Claim_Contact__c claimcontact = new Claim_Contact__c();
        claimcontact.Contact_Type__c = 'Factory SQE';
        claimcontact.Name__c = 'saran';
        claimcontact.Email__c='test@gmail.com';
        claimcontact.Claims__c = claim.Id;
       insert claimcontact;
       
        Contact c= new Contact();
        c.LastName ='Saran';
        c.Email = 'test@gmail.com';
        c.CurrencyIsoCode = NULL;
        insert c;
        
        Attachment attach = new attachment();
        attach.Name ='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=claim.id;
        insert attach;
        
        //List<Attachment> attachments = [select id, name from Attachment where parent.id=:claim.id];
         
        getClaimRecordForPDF.MCARClaimNotesandAttchment wrap = new getClaimRecordForPDF.MCARClaimNotesandAttchment();
        wrap.title = 'test title';
        wrap.URL = 'https://cs22.salesforce.com/';
       
        
        test.startTest();
         
         ApexPages.StandardController sc = new ApexPages.standardController(Claim);
         ApexPages.CurrentPage().getparameters().put('id', claim.id);
         getClaimRecordForPDF objgetRecordForPDF = new getClaimRecordForPDF(sc);
         objgetRecordForPDF.getAllNotesandattachments();
         objgetRecordForPDF.colorStatus=claim.Colour_Status__c;
        
       
        test.stopTest();

    }
    
    
    
}