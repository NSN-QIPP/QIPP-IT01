@isTest
public class Send_Email_Data_Collection_Test {
static testmethod void test1()
{
    test.startTest();
    
    MCAR_Claim_Management__c mcarClaim = new MCAR_Claim_Management__c();
    mcarClaim.Data_Collection_Notification_Send__c = True;
    mcarClaim.Claim_Status__c = 'Data Collection';
    insert mcarClaim;
     
    Claim_Contact__c cc = new Claim_Contact__c();
    cc.Claims__c =mcarClaim.Id;
    cc.Contact_Type__c='Technical';
    cc.Email__c ='priyaburghate@yahoo.in';
    insert cc; 
    
    
    mcarClaim.Claim_Status__c='Negotiation';
    update mcarClaim;
   
    
    test.stopTest();
}
    
    
}