@isTest(SeeAllData=true)
public class ClaimMeterialDeviationEdit_Test {
    static testmethod void test1(){
        
        MCAR_MEPS__c mepsRec = new MCAR_MEPS__c();
        insert mepsRec;
        
        MCAR__c mcarRec = new MCAR__c();
        insert mcarRec;
               
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Part_Category__c = 'Indirect Procurement (IP)' ;
        claimRec.Claims_Business_Unit__c = 'Business Solutions';
        claimRec.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claimRec.Category_Manager_Name__c = 'saran';
        insert claimRec;
        
       Material_Deviation__c matDevRec = new Material_Deviation__c();
        matDevRec.Quantity__c=100;
        matDevRec.Code__c=mepsRec.id;
        matDevRec.Code__c=mepsRec.name;
        matDevRec.MCARs__c = mcarRec.id;
        matDevRec.MCARs__c = mcarRec.Name;
        matDevRec.MCAR_Claim_Management1__c = claimRec.id;
        insert matDevRec; 
        
        matDevRec.Defect_PPM__c=5;
        matDevRec.Code__c=mepsRec.id;
        matDevRec.Code__c=mepsRec.name;
        matDevRec.MCARs__c = mcarRec.id;
        matDevRec.MCARs__c = mcarRec.Name;
        update matDevRec;
        
  
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(matDevRec);
        ApexPages.CurrentPage().getparameters().put('id', matDevRec.id);
        ClaimMeterialDeviationEdit cmdEdit = new ClaimMeterialDeviationEdit(sc);
        try{
        cmdEdit.Updatematerial();
        }catch(Exception e){}
        
        try{
        ApexPages.StandardController sc1 = new ApexPages.standardController(matDevRec);
        ApexPages.CurrentPage().getparameters().put('id', '');
        ClaimMeterialDeviationEdit cmdEdit1 = new ClaimMeterialDeviationEdit(sc1);
        
        cmdEdit1.Updatematerial();
        }catch(Exception e){}
        test.stopTest();
        
      }
        
}