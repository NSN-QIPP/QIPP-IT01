@isTest(SeeAllData=true)
public class ClaimMaterialDeviation_Test {
    static testmethod void test1(){
        
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
        
         MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c = manufacturer.Id;
        claimRec.Part_Category__c = 'Indirect Procurement (IP)' ;
        claimRec.Claims_Business_Unit__c = 'Business Solutions';
        claimRec.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claimRec.Category_Manager_Name__c = 'saran';
        insert claimRec;
        /*
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c='a0nU0000000NdT7';--
        insert claimRec;
         */       
        
        MCAR__c availMcar = new MCAR__c();
        availMcar.MCAR_Status__c='draft';
        availMcar.MCAR_Manufacturer__c = claimRec.Manufacturer__c;
        insert availMcar;
        
        MCAR_MEPS__c mepsRec = new MCAR_MEPS__c();
        insert mepsRec;
        
        Claim_Final_Payment__c claimFinPayRec = new Claim_Final_Payment__c();
        claimFinPayRec.Claim__c=claimRec.id;
        insert claimFinPayRec;
        
        Performance_Deviation_section__c perfDevSecRec = new Performance_Deviation_section__c();
        perfDevSecRec.Performance_Measure_Name__c = 'test';
        perfDevSecRec.Actual_Measurement__c='test';
        perfDevSecRec.Measurement_Standard__c='%';
        perfDevSecRec.Claim__c=claimRec.id;
        insert perfDevSecRec;
        
        Claim_Final_Payment__c claimFinPayLogRec = new Claim_Final_Payment__c();
        claimFinPayLogRec.Claim__c=claimRec.id;
        claimFinPayLogRec.Payment_Validated__c = False;
        insert claimFinPayLogRec;
        
        Material_Deviation__c matDevRec = new Material_Deviation__c();
        matDevRec.Quantity__c=100;
        matDevRec.MCAR_Claim_Management1__c=claimRec.id;
        matDevRec.Code__c=mepsRec.id;
        insert matDevRec;
        
        test.startTest();
     
        
        ApexPages.StandardController sc = new ApexPages.standardController(perfDevSecRec);
        //ApexPages.CurrentPage().getparameters().put('claimid', perfDevSecRec.id);
        ClaimMaterialDeviation cmd = new ClaimMaterialDeviation(sc);
        cmd.ClaimId=claimRec.id;
        cmd.mcarid=availMcar.id;
        cmd.PerDevId=perfDevSecRec.id;
        cmd.codeid=mepsRec.id;
        
       test.stoptest();
    }
    
    static testmethod void test123()
    {                
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
                
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c = manufacturer.Id;
        claimRec.Part_Category__c = 'Indirect Procurement (IP)' ;
        claimRec.Claims_Business_Unit__c = 'Business Solutions';
        claimRec.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claimRec.Category_Manager_Name__c = 'saran';        
        insert claimRec;
        
        test.startTest();            
        ApexPages.CurrentPage().getparameters().put('Claimid', claimRec.id);
        
        ClaimMaterialDeviation cmd = new ClaimMaterialDeviation();                
        test.stoptest();        
    }
    
     static testmethod void test111()
    {                
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;
                
        MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
        claimRec.Manufacturer__c = manufacturer.Id;
        claimRec.Part_Category__c = 'Indirect Procurement (IP)' ;
        claimRec.Claims_Business_Unit__c = 'Business Solutions';
        claimRec.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claimRec.Category_Manager_Name__c = 'saran';        
        insert claimRec;
        
        NSN_Part__c parts = new NSN_Part__c();
        insert parts;
        
        MCAR_MEPS__c meps = new MCAR_MEPS__c();
        meps.Name = 'test';
        meps.MCAR_NSN_Part__c =parts.Id; 
        meps.MCAR_Mfg_Part_Number__c= '123';
        meps.Manufacturer_Name__c = claimRec.Manufacturer__c;
        meps.MCAR_MEPS_Enterprise_ID__c ='123';
        insert meps;
        
        MCAR__c mcar = new MCAR__c();
        //mcar.LastModifiedDate =  system.today()-1; insert all mandetory fields of mcar
        
              
        mcar.MCAR_Status__c ='Draft';
        mcar.MCAR_Manufacturer__c = claimRec.Manufacturer__c;
        insert mcar;
       
        test.startTest();            
        ApexPages.CurrentPage().getparameters().put('Claimid', claimRec.id);
        ApexPages.CurrentPage().getparameters().put('SearchMeps', meps.name);
        ApexPages.CurrentPage().getparameters().put('SearchMcar', mcar.name);
      
        ClaimMaterialDeviation cmd = new ClaimMaterialDeviation();                
        test.stoptest();        
    }
    

}