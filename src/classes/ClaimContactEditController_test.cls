@isTest
public class ClaimContactEditController_test {

   static testmethod void test1(){
       
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        insert claimRec;
       
        Claim_Contact__c claimContRec = new Claim_Contact__c();
        claimContRec.Claims__c= claimRec.id;
        claimContRec.Email__c = 'priyaburghate@yahoo.com';
        insert claimContRec;
       
       
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(claimContRec);
        ApexPages.CurrentPage().getparameters().put('id', claimContRec.id);
        ClaimContactEditController claimContEditCont = new ClaimContactEditController(sc);
        claimContEditCont.SaveAndNew();
        claimContEditCont.updateMyRecord();
        test.stopTest();
       
   } 
}