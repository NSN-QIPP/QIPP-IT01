@isTest
private class QIPPUpdateLineManagerEmail_Test
{
    
    static testmethod void test()
    {
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12345';
        insert con;
        
        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'Venkat2 Maddipati';
        con1.Email__c = 'venkat2.maddipati@igate.com';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '123456';
        insert con1;
        
          
               
    }
}