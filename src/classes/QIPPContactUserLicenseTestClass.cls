@isTest
public class QIPPContactUserLicenseTestClass 
{
    public static testMethod void testMyController() 
    {
        QIPP_Contacts__c con20 = new QIPP_Contacts__c();
        con20.Name = 'Abhishek Jagtap1';
        con20.Email__c = 'abhishek.jagtap@igate.com';
        con20.Contact_State__c = 'Active';
        con20.Business_Function__c = 'QIPP QLT Owner';
        con20.NSN_ID_Text__c = '12456';
        insert con20; 
        
        QIPP_Contacts__c con21 = new QIPP_Contacts__c();
        con21.Name = 'Abhishek Jagtap2';
        con21.Email__c = 'abhishek.jagtap1@igate.com';
        con21.Contact_State__c = 'Active';
        con21.Business_Function__c = 'QIPP QLT Owner';
        con21.NSN_ID_Text__c = '12457';
        insert con21; 
        
        QIPP_Contacts__c con22 = new QIPP_Contacts__c();
        con22.Name = 'Abhishek Jagtap3';
        con22.Email__c = 'abhishek.jagtap2@igate.com';
        con22.Contact_State__c = 'Active';
        con22.NSN_ID_Text__c = '12454';
        insert con22; 
    
        test.startTest();
        QIPPContactUserLicense.ApplyForUserLicense(con20.id);
        QIPPContactUserLicense.RemoveUserLicense(con20.id);
        
        QIPPContactUserLicense.ApplyForUserLicense(con21.id);
        QIPPContactUserLicense.RemoveUserLicense(con21.id);

        QIPPContactUserLicense.ApplyForUserLicense(con22.id);
        QIPPContactUserLicense.RemoveUserLicense(con22.id);

        test.stopTest();
    }
}