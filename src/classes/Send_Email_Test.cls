@istest
public class Send_Email_Test {
    static testmethod void test1(){
        
        test.startTest();
        MCAR_Claim_Management__c mcarClaim = new MCAR_Claim_Management__c();
        mcarClaim.I_Agree__c=true;
        mcarClaim.Claim_Status__c ='Draft';
        insert mcarClaim;
        
        Claim_Contact__c cc= new Claim_Contact__c();
        cc.Contact_Type__c='Manufacturer';
        cc.Claims__c=mcarClaim.id;
        cc.Email__c='priya.burghate@atos.net';
        insert cc;
        
      /*  List<Claim_Contact__c> c = new List<Claim_Contact__c>();
        c = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c 
             WHERE Claims__c =: mcarClaim.id AND Contact_Type__c != 'Manufacturer'];*/
        cc.Contact_Type__c='Technical';
        update cc;
        
        cc.Contact_Type__c='Nonconformance Cost';
        update cc;
        
        cc.Contact_Type__c='Legal';
        update cc;
        
        cc.Contact_Type__c='Category Manager';
        update cc;
        
        cc.Contact_Type__c='SQS';
        update cc;
        
        cc.Contact_Type__c='SQM';
        update cc;
        
        test.stopTest();
        
    }

}