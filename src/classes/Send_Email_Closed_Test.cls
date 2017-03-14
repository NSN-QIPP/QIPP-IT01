@isTest
public class Send_Email_Closed_Test {
    static testmethod void test1 (){
        test.startTest();
        MCAR_Claim_Management__c mclaim = new MCAR_Claim_Management__c();
        mclaim.Data_claim_Notification_Send__c=true;
        mclaim.Claim_Status__c='Closed';
        insert mclaim;
        
        Claim_Contact__c cont= new Claim_Contact__c();
        cont.Email__c='priyaburghate@yahoo.in';
        cont.Claims__c=mclaim.id;
        cont.Contact_Type__c ='Manufacturer';  
        insert cont;
        
        cont.Contact_Type__c ='Category Manager';  
        update cont;
        
        cont.Contact_Type__c ='SQM';  
        update cont;
        
        test.stopTest();
        
    }

}