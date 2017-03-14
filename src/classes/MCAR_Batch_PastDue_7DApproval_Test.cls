@isTest
private class MCAR_Batch_PastDue_7DApproval_Test{
static testmethod void MCAR_PastDue_7DApproval(){

User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        
        User DummyUserManufacturer = new User();
        DummyUserManufacturer .LastName = 'adcd';
        DummyUserManufacturer .FirstName = 'adcd';
        DummyUserManufacturer .Alias = 'adcd';
        DummyUserManufacturer .Email = 'ab@ab.ab';
        DummyUserManufacturer .Username = 'ab@ab.ab.adcb';
        DummyUserManufacturer .CommunityNickname = 'ab';
        DummyUserManufacturer .IsActive = TRUE;
        DummyUserManufacturer .ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia MCAR External Supplier%' LIMIT 1].Id;
        DummyUserManufacturer .TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUserManufacturer .LocaleSidKey = 'en_US';
        DummyUserManufacturer .EmailEncodingKey = 'ISO-8859-1';
        DummyUserManufacturer .LanguageLocaleKey = 'en_US';
        insert DummyUserManufacturer ;
        
        User owner = DummyUser;
     User manufacturerUser  =DummyUserManufacturer;
     
     RecordType rtDraftMCAR = [select Id from RecordType where SObjectType='MCAR__c' and Name='Draft MCAR' limit 1];
     RecordType rtOpenMCAR = [select Id from RecordType where SObjectType='MCAR__c' and Name='Open MCAR' limit 1];
    MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c (Name='Test Systems Inc.',ownerId=owner.Id, MCAR_Supplier_Admin__c=manufacturerUser.id );
    insert manufacturer;
    // Manufacturer is wrong here  
    MCAR_Manufacturer_Site__c testSite = new MCAR_Manufacturer_Site__c(name='Test',Manufacturer_Name__c=manufacturer.id, MCAR_Manufacturer_Site_Address__c='Test',Zip__c = '12345'  );
    
    insert testSite;
    
    //MCAR_Manufacturer_Site__c=testSite.id,  
    MCAR_Manufacturer_Contact__c manufacturerContact = new MCAR_Manufacturer_Contact__c(Manufacturer_Site__c=testSite.id, Name='First', Email__c='last@company.com', Manufacturer_Name__c=manufacturer.Id, ownerId=owner.Id, MCAR_User__c=manufacturerUser.id  );
    insert manufacturerContact;
    
    
     
    NSN_Part__c testNSNPart = new NSN_Part__c(Name='1234567', Description__c='t', NSN_Part_Lifecycle__c='t', NSN_Part_Type__c='t', NSN_Part_Family__c='t', NSN_Part_Recomendation__c='Y', Tec__c='TEC1',Com__c='COM1' ); 
    insert testNSNPart; 
    
    MCAR_MEPS__c testMCARMeps =new MCAR_MEPS__c(Name='1234567',MCAR_NSN_Part__c=testNSNPart.id , MCAR_Mfg_Part_Number__c='1234', MCAR_MEPS_Enterprise_ID__c='TESTEID', Manufacturer_Name__c=manufacturer.Id);
    insert testMCARMeps;
    
    MCAR_NSN_Contacts__c nsnContactPart = new MCAR_NSN_Contacts__c (Domain__c='COM', Com__c='COM1', Name='123', Contact_External_Id__c=1122223, First_Name__c='First', Last_Name__c='Last', email__c='last@company.com' );
    insert nsnContactPart; 

    MCAR_NSN_Contacts__c nsnContactPart2 = new MCAR_NSN_Contacts__c ( Domain__c='TEC', Tec__c='TEC1', Name='123', Contact_External_Id__c=1122222, First_Name__c='First', Last_Name__c='Last', email__c='last@company.com');
    insert nsnContactPart2; 

    MCAR_NSN_Contacts__c nsnContactPart3 = new MCAR_NSN_Contacts__c ( Domain__c='Supplier', Enterprise_ID__c='TESTEID', Name='123', Contact_External_Id__c=1122221, First_Name__c='First', Last_Name__c='Last', email__c='last@company.com');
    insert nsnContactPart3; 

    //MCAR_NSN_Part_Contacts__c testNSNPartContact= new MCAR_NSN_Part_Contacts__c(    MCAR_NSN_Id__c= nsnContactPart.id, MCAR_NSN_Part__c=testNSNPart.id, MCAR_Role__c='test', MCAR_Topic__c='test' ); 
    //insert testNSNPartContact;
    
    MCAR_Facility__c testFacility = new MCAR_Facility__c(Name ='Chennai', MCAR_Facility_Company__c='NSN');
    insert testFacility;
    // facility removed 
    MCAR_Facility_Contact__c nsnContactFacility = new MCAR_Facility_Contact__c( Facility__c=testFacility.id,  Name='First', email__c='last@company.com' );
    insert nsnContactFacility;
     
   MCAR__c testMCAR = new MCAR__c(MCAR_Factory_GM_Email__c='test@test.com', MCAR_CC_Email__c='test@test.com', MCAR_CC_Email2__c='test@test.com',MCAR_CC_Email3__c='test@test.com',MCAR_CC_Email4__c='test@test.com',MCAR_CC_Email5__c='test@test.com', MCAR_Facility__c=testFacility.id,  MCAR_Status__c='Draft', MCAR_Failure_Type__c='Visual', MCAR_NSN_Code__c=testMCARMeps.id,MCAR_Severity_Level__c='Low',MCAR_Defect_Location__c='Production',MCAR_Defect_Quantity__c=4,MCAR_Product_Name__c='Test',MCAR_2D_Prob_Desc__c='Test',MCAR_2D_Analysis_Findings__c='Test',MCAR_3D_Days_Allowed__c='2',MCAR_4D_Days_Allowed__c='15',MCAR_5D_Days_Allowed__c='30',MCAR_6D_Days_Allowed__c='35',MCAR_7D_Days_Allowed__c='45',MCAR_Current_8D_Step__c='2D=Problem/Analysis', RecordTypeId=rtDraftMCAR.id,MCAR_7D_Due_Date__c=date.today()-5, MCAR_7D_Approval__c=false );
    insert testMCAR;
    MCAR_Batch_PastDue_7DApproval MBP = new MCAR_Batch_PastDue_7DApproval();
    Database.BatchableContext DBC;
    List<MCAR__C> obj = new List<MCAR__c>();
    obj.add(testMCAR);
    try{MBP.execute(DBC,obj);}catch(exception e){}
    MBP.start(DBC);
    MBP.finish(DBC);
}
}