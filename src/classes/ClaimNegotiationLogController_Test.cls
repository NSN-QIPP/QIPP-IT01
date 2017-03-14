@isTest(SeeAllData=true)
public class ClaimNegotiationLogController_Test {
    static testmethod void test1(){
     
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c =manufacturer.id; 
        insert claimRec;
        
        Negotiation_Log__c NegotiationLogRec = new Negotiation_Log__c();
        NegotiationLogRec.Claim__c=claimRec.id;
        NegotiationLogRec.Memo_Title__c='test title';
        NegotiationLogRec.Memo_Description__c='memo description';
        NegotiationLogRec.Date__c=system.today();
        insert NegotiationLogRec;
        
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(NegotiationLogRec);
        ApexPages.CurrentPage().getparameters().put('id', NegotiationLogRec.id);
        ClaimNegotiationLogController obj1= new ClaimNegotiationLogController(sc);                   
        obj1.NegotiationLog.Memo_Title__c=null;
        obj1.NegotiationLog.Memo_Description__c=null; 
        obj1.Save();                
        obj1.SaveandNew();
             
                ApexPages.StandardController sc1 = new ApexPages.standardController(NegotiationLogRec);
        ApexPages.CurrentPage().getparameters().put('id', NegotiationLogRec.id);
        ClaimNegotiationLogController obj2= new ClaimNegotiationLogController(sc1);        
        obj2.SaveNewRecord();
        obj2.Save();
        obj2.saveRecord();
        obj2.SaveandNew();
        
        test.stopTest();
       
     
    }
    
    static testmethod void test2(){
        
         MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c =manufacturer.id; 
        insert claimRec;
        
        Negotiation_Log__c NegotiationLogRec = new Negotiation_Log__c();
        NegotiationLogRec.Claim__c=claimRec.id;
        NegotiationLogRec.Memo_Title__c='test title';
        NegotiationLogRec.Memo_Description__c='test';
        NegotiationLogRec.Date__c=system.today();
        //insert NegotiationLogRec;
        
      /* Negotiation_Log__c NegotiationLogRec1 = new Negotiation_Log__c();
        NegotiationLogRec1.Claim__c=claimRec.id;
        NegotiationLogRec1.Memo_Title__c=null;
        NegotiationLogRec1.Memo_Description__c='test';
        NegotiationLogRec1.Date__c=system.today();
        //insert NegotiationLogRec1;
        */
        test.startTest();
        //ApexPages.StandardController sc = new ApexPages.standardController(claimRec);
       // ApexPages.CurrentPage().getparameters().put('claim', claimRec.id);
        
        ApexPages.CurrentPage().getparameters().put('claim', claimRec.id);
        ClaimNegotiationLogController obj1= new ClaimNegotiationLogController();
        obj1.NegotiationLog.Claim__c = claimRec.id;
        obj1.NegotiationLog.Memo_Title__c='test title';
            
        obj1.checkvalidation();
        obj1.Save();
       // obj1.saveRecord();
        obj1.SaveandNew();
        obj1.NegotiationLog.Memo_Description__c='test';
         obj1.Save();
        test.stopTest();
        
    }
    
   static testmethod void test3(){
        
      MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c =manufacturer.id; 
        insert claimRec;
        
        Negotiation_Log__c NegotiationLogRec = new Negotiation_Log__c();
        NegotiationLogRec.Claim__c=claimRec.id;
        NegotiationLogRec.Memo_Title__c='test';
        NegotiationLogRec.Memo_Description__c='test';
        NegotiationLogRec.Date__c=system.today();
        insert NegotiationLogRec;
        
        Negotiation_Log__c NegotiationLogRec1 = new Negotiation_Log__c();
        NegotiationLogRec1.Claim__c=claimRec.id;
        NegotiationLogRec1.Memo_Title__c=null;
        NegotiationLogRec1.Memo_Description__c=null;
        NegotiationLogRec1.Date__c=system.today();
        insert NegotiationLogRec1;
        
        test.startTest();
        //ApexPages.StandardController sc = new ApexPages.standardController(claimRec);
       // ApexPages.CurrentPage().getparameters().put('claim', claimRec.id);
        
        ApexPages.CurrentPage().getparameters().put('claim', claimRec.id);
        ClaimNegotiationLogController obj1= new ClaimNegotiationLogController();
       
       	        obj1.NegotiationLog.Claim__c = claimRec.id;
        obj1.NegotiationLog.Memo_Title__c='test title';
         obj1.NegotiationLog.Memo_Description__c='test';
       	obj1.SaveandNew();
        obj1.checkvalidation();       
        obj1.Save();                       
        
        test.stopTest();
       
     
    }
    
}