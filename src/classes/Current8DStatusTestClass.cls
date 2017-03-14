@isTest
public class Current8DStatusTestClass {
    public static testMethod void StatusTestMethod()
    {
        MCAR__c m= new MCAR__c();
        m.X3D_Status__c ='approve';
        m.X4D_Owner_Approve_Reject__c='rejected';
m.X4D_Owner_Approve_Reject__c='approve';
m.X5D_Status__c='rejected';
m.X5D_Status__c='approve';
m.X6D_Status__c='rejected';
m.X6D_Status__c='approve';
m.X7D_Status__c='rejected';

m.X3D_Owner_Response__c='test';
m.X4D_Owner_Response__c='test';
m.X5D_Reason__c='test';
m.X6D_Reason__c='test';
m.X7D_Reason__c='test';

m.X3D_Manufacturer_Response_Complete__c=true;
m.X4D_Manufacturer_Response_Complete__c=true;
m.X5D_Manufacturer_Response_Complete__c=true;
m.X6D_Manufacturer_Response_Complete__c=true;
m.X7D_Manufacturer_Response_Complete__c=true;


        insert m;
    } // end of method
}