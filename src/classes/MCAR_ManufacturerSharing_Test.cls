@isTest
public class MCAR_ManufacturerSharing_Test {
    public static MCAR_Manufacturer__c mcarManu1;
    public static MCAR_Manufacturer_Site__c manuFactSite1;
    public static testmethod void testsecenerion1(){
        MCAR_ManufacturerSharing_Test myref = new MCAR_ManufacturerSharing_Test();
        myref.shareManufacturerWithUserFromManufacturerContactCall1();
    }
    
    private void shareManufacturerWithUserFromManufacturerContactCall1(){
        insertManufacturerData();
        insertManufacturerSiteData(mcarManu1.ID);
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia MCAR External Supplier'];

        User u2 = new User(Alias = 'Usrats', Email='newuser@testorg.com',
                            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                            LocaleSidKey='en_US', ProfileId = p.Id,
                            TimeZoneSidKey='America/Los_Angeles', UserName='newuserats@testorgats.com');
        insert u2;
        MCAR_Manufacturer_Contact__c manuCon = new MCAR_Manufacturer_Contact__c();
        manuCon.Name = 'Test Con';
        manuCon.Email__c = 'test@test.com';
        manuCon.Manufacturer_Name__c = mcarManu1.ID;
        manuCon.Manufacturer_Site__c = manuFactSite1.ID;
        manuCon.MCAR_User__c = u2.ID;
        
        insert manuCon;
        
        MCAR_ManufacturerSharing manuShareObj = new MCAR_ManufacturerSharing();
        manuShareObj.shareManufacturerWithUserFromManufacturerContact(new list<MCAR_Manufacturer_Contact__c>{manuCon});
    }
    
    private void insertManufacturerData(){
        mcarManu1 = new MCAR_Manufacturer__c();
        mcarManu1.Name = 'Test Manu';
        insert mcarManu1;
    }
    
    private void insertManufacturerSiteData(ID manufaturerID){
        manuFactSite1 = new MCAR_Manufacturer_Site__c();
        manuFactSite1.Manufacturer_Name__c = manufaturerID;
        manuFactSite1.Zip__c = '123';
        insert manuFactSite1;
    }
}