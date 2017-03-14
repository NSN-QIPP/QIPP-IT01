@isTest
public class SendEmailOnClaimOwnerChangeCont_Test {
    static  testmethod void sendEmailToAll_test(){ 
    
    User user1 = [select id , name , Email from user where id =: userInfo.getUserId()];
        
        
    MCAR_Claim_Management__c claimRec1 = new MCAR_Claim_Management__c();
    claimRec1.Previous_Owner__c= user1.Id;
    //claimRec1.Previous_Owner__c ='priya burghate';
    //claimRec1.Owner = user1.Name; 
    claimRec1.Category_Manager_Email__c='saran.golagani@atos.net';
    insert claimRec1;
        
        
    MCAR_Claim_Management__c claimRec2 = new MCAR_Claim_Management__c();
    //claimRec2.Previous_Owner__c='priya.burghate@yahoo.com';
    claimRec2.Previous_Owner__c = claimRec1.Previous_Owner__c;
    //claimRec2.Owner = claimRec1.OwnerId; 
    claimRec2.Category_Manager_Email__c='saran.golagani@atos.net';
    insert claimRec2;
     
    
   // User u = claimRec.Owner;
    //u.email='test@sfdc.com';
    //u.Name='test user';
   // insert u;
      
    //claimRec.Previous_Owner__r.Email = u.Email;
    //claimRec.Previous_Owner__r.name = u.Name;
    //claimRec.Owner.Email= u.Email ;
    //update claimRec;
        
     Claim_Contact__c ccCont= new Claim_Contact__c();
     ccCont.Contact_Type__c = 'SQS';
     ccCont.Email__c ='priya.burghate@atos.net';
     ccCont.Claims__c=claimRec1.id;
     insert ccCont;
    
     test.startTest();
     SendEmailOnClaimOwnerChangeController.sendEmailToAll(claimRec2.id);
     test.stopTest();
        
        
        
        
    }

}