@isTest
private class getRecordForPDFTestClass
{
    public static testMethod void PDFGeneration()
    {
        // Create Dummy USER object and pass Id to Dummy MCAR_Manufacturer__c
        User DummyUser = new User();        
        DummyUser.LastName = 'adc';        
        DummyUser.FirstName = 'adc';       
        DummyUser.Alias = 'adc';        
        DummyUser.Email = 'a@a.a';        
        DummyUser.Username = 'a@a.a.adc';        
        DummyUser.CommunityNickname = 'a';        
        DummyUser.IsActive = TRUE;        
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIRS%' LIMIT 1].Id;        
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';        
        DummyUser.LocaleSidKey = 'en_US';        
        DummyUser.EmailEncodingKey = 'ISO-8859-1';        
        DummyUser.LanguageLocaleKey = 'en_US';        
        insert DummyUser;

        // Create Dummy USER object and pass Id to Dummy MCAR_Manufacturer__c
        User DummyUserManu = new User();        
        DummyUserManu.LastName = 'bbb';        
        DummyUserManu.FirstName = 'bbb';       
        DummyUserManu.Alias = 'bbb';        
        DummyUserManu.Email = 'b@b.b';        
        DummyUserManu.Username = 'b@b.b.adc';        
        DummyUserManu.CommunityNickname = 'b';        
        DummyUserManu.IsActive = TRUE;        
        DummyUserManu.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia MCAR External Supplier%' LIMIT 1].Id;        
        DummyUserManu.TimeZoneSidKey = 'Asia/Kamchatka';        
        DummyUserManu.LocaleSidKey = 'en_US';        
        DummyUserManu.EmailEncodingKey = 'ISO-8859-1';        
        DummyUserManu.LanguageLocaleKey = 'en_US';        
        insert DummyUserManu;



        // Create Dummy record for MCAR_Manufacturer__c
        MCAR_Manufacturer__c DummyManufacture = new MCAR_Manufacturer__c();
        DummyManufacture.MCAR_HQ_City__c = 'Pune';
        DummyManufacture.MCAR_HQ_Country__c = 'India';
        DummyManufacture.Enterprise_ID__c = '123456789';
        DummyManufacture.Legacy_Supplier_Id__c = '123456';
        DummyManufacture.Manufacturer_Name_Ext_Id__c = 'NOKIA';
        DummyManufacture.MCAR_HQ_State__c = 'MAHARASHTRA';
        DummyManufacture.MCAR_HQ_Street__c = 'HIGHWAY';
        DummyManufacture.MCAR_HQ_Zip_Postal_Code__c = '411548';
        DummyManufacture.MCAR_Supplier_Admin__c = DummyUserManu.Id;
        insert DummyManufacture;

               
                                
        // Create Dummy NSN Part
        NSN_Part__c DummyNSNPart = new NSN_Part__c();
        DummyNSNPart.NSN_CODE__c = 'AAWES2109';
        DummyNSNPart.Description__c = 'This is description';
        insert DummyNSNPart;

        
        // Create Dummy MEPS record ----------- MCAR_MEP_ID__c  ---------- Unique and need to regenarate again ...
        MCAR_MEPS__c DummyMCARMEPS = new MCAR_MEPS__c();
        DummyMCARMEPS.Purchasing__c = 'xyz';
        DummyMCARMEPS.MCAR_MEPS_Enterprise_ID__c = '111';
        DummyMCARMEPS.Lifecycle__c = 'LifeCycle';
        DummyMCARMEPS.Manufacturer_Name__c = DummyManufacture.Id;
        DummyMCARMEPS.MCAR_MEP_ID__c = 'sdf123XYZ';
        DummyMCARMEPS.MCAR_NSN_Part__c = DummyNSNPart.Id;
        DummyMCARMEPS.MCAR_Mfg_Part_Number__c = '988959597465';
        insert DummyMCARMEPS;
        
        
        
        
                
        // Create Dummy QIRS record 
        QIRS__c DummnyQIRS = new QIRS__c();
        DummnyQIRS.Site1__c = 'Chennai Hub';
        DummnyQIRS.Process_Owner1__c = DummyUser.Id;
        DummnyQIRS.Business__c = 'Global Services';
        DummnyQIRS.Business_Group__c = 'BBA';
        DummnyQIRS.Alert_Type__c = 'Quality Alert';
        DummnyQIRS.Issue_Level__c = 'Launch Delay';
        DummnyQIRS.Impacted_Region__c = 'ALL';
        DummnyQIRS.Factory__c = 'APW India';
        DummnyQIRS.Problem_Description1__c = 'Issue is important';
        DummnyQIRS.Projected_Lift_Date__c = Date.Today();        
        DummnyQIRS.Defective_Part__c = 'Design';
        DummnyQIRS.Symptom__c = 'Design';
        DummnyQIRS.Customer__c = 'abhishek';
        insert DummnyQIRS;

         // Create Dummy Facility record
        MCAR_Facility__c DummyFacility = new MCAR_Facility__c();
        DummyFacility.MCAR_Facitily_City__c = 'Chennai';
        DummyFacility.MCAR_Facility_Company__c = 'Sanmina';
        DummyFacility.MCAR_Facility_Country__c = 'India';
        DummyFacility.MCAR_Facility_Type__c = 'EMS';
        insert DummyFacility;


        // Create Dummy MCAR record....
        MCAR__c DummyMCAR = new MCAR__c();
        DummyMCAR.MCAR_Facility__c = DummyFacility.Id;
        DummyMCAR.MCAR_Failure_Type__c  = 'Visual';
        DummyMCAR.H_Facility_Name__c = 'Chennai';
        DummyMCAR.MCAR_Status__c = 'Closed';
        DummyMCAR.MCAR_Current_8D_Step__c = '2D=Problem/Analysis';
        DummyMCAR.MCAR_Product_Name__c = 'Tarce Viewer';
        DummyMCAR.Product_Family__c = 'Operation Support Solutions';
        DummyMCAR.Product_Technology__c = 'Business Solutions';
        DummyMCAR.MCAR_Creation_Date_Status_Open__c = Date.Today();
        DummyMCAR.MCAR_RMA_Sent_Date__c = Date.Today();
        DummyMCAR.MCAR_2D_failure_date__c = Date.Today();
        DummyMCAR.MCAR_3D_Due_Date__c = Date.Today();
        DummyMCAR.MCAR_4D_Due_Date__c = Date.Today();
        DummyMCAR.MCAR_5D_Due_Date__c = Date.Today();
        DummyMCAR.MCAR_6D_Due_Date__c = Date.Today();
        DummyMCAR.MCAR_7D_Due_Date__c = Date.Today();
        //DummyMCAR.MCAR_Days_MCAR_Open__c = Date.Today();
        DummyMCAR.QIRS_ID__c = DummnyQIRS.Id;
        DummyMCAR.MCAR_NSN_Code__c = DummyMCARMEPS.id;
        DummyMCAR.MCAR_Manufacturer__c = DummyManufacture.Id;
        insert DummyMCAR;
        
        test.startTest();    
        PageReference pageRef = new PageReference('/apex/MCAR_PDF_Display_Page?Id='+ DummyMCAR.Id);
        System.Debug('$$$$$$$$$$$$$$$$$$$$$ ID $$$$$$$$$$$$$$$$$$$ ' +  DummyMCAR.Id);
        test.setCurrentPage(pageRef); 
        
        getRecordForPDF objgetRecordForPDF = new getRecordForPDF(null);

        test.stopTest();
    }
    
    public static testmethod void allContactTest()
    {
         
        
    }
}