@isTest
public class ClaimContactDetilasConroller_test 
{        
    public static testmethod void sampletest1()
    {   
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ;        
        
        //------------MANUFACTURER CONTACT -----------------------
            List<MCAR_Manufacturer_Contact__c> contact = new List<MCAR_Manufacturer_Contact__c>();
            MCAR_Manufacturer_Site__c site = new MCAR_Manufacturer_Site__c();
            site.Name = 'No Site Assigned';
            site.Manufacturer_Name__c = manufacturer.Id;
                     
                MCAR_Manufacturer_Contact__c manCon = new MCAR_Manufacturer_Contact__c();
                manCon.Name = 'Test';
                manCon.Email__c = 'rajmca138@yahoo.com';
                manCon.Manufacturer_Name__c = manufacturer.id;        
                manCon.Manufacturer_Site__c = site.Id;  
                contact.add(manCon);
                                    
                MCAR_Manufacturer_Contact__c manCon1 = new MCAR_Manufacturer_Contact__c();
                manCon1.Name = 'Test';
                manCon1.Email__c = 'test@test.com';
                manCon1.Manufacturer_Name__c = manufacturer.id;
                manCon1.Manufacturer_Site__c = site.Id;                
                contact.add(manCon1);
                        
                insert contact;                     
                    
        //------------------------Facility Information--------------------------        
         
        MCAR_Facility__c facility = new MCAR_Facility__c();
        facility.Name = 'test';
        facility.MCAR_Facility_Company__c = 'test';
        facility.MCAR_Facility_Type__c = 'EMS';
        facility.MCAR_Facitily_City__c ='chennai';
        facility.MCAR_Facility_Country__c = 'India';
        insert facility;
        //---------------------------Facility Contact-----------------------------
        MCAR_Facility_Contact__c fc = new MCAR_Facility_Contact__c();                             
        fc.Name = 'raj FC';
        fc.Email__c = 'rajmex@mex.com';
        fc.Facility__c = facility.id;  
        insert fc;
        
        MCAR_Facility_Contact__c fc1 = new MCAR_Facility_Contact__c();                                
        fc1.Name = 'raj FC';
        fc1.Email__c = 'rajmex1@mex1.com';
        fc1.Facility__c = facility.id;  
        insert fc1;
                        
        MCAR_Facility_Contact__c fc2 = new MCAR_Facility_Contact__c();                                
        fc2.Name = 'test 4';
        fc2.Email__c = 'rajmex2@mex2.com';
        fc2.Facility__c = facility.id;  
        insert fc2;
        //--------------------------CLAIM MANAGEMENT----------------------------------
        MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
        claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
        claim.Facility__c = facility.Id;
        insert claim;  
        //------------------------CLAIM CONTACT--------------------------------                 
        Claim_Contact__c cc = new Claim_Contact__c();               
        cc.Name__c = 'raj kumar';               
        cc.Claims__c = claim.id;
        cc.Email__c = 'rajmca138@yahoo.com';               
        cc.Contact_Type__c = 'Manufacturer';
        insert cc;
                            
        Claim_Contact__c claimcontact2 = new Claim_Contact__c();
        claimcontact2.Contact_Type__c = 'MEX Buyer';
        claimcontact2.Name__c = 'test123';
        claimcontact2.Email__c='rajmex1@mex1.com';
        claimcontact2.Claims__c = claim.Id;
        insert claimcontact2;
        
        Claim_Contact__c claimcontact4 = new Claim_Contact__c();
        claimcontact4.Contact_Type__c = 'Factory SQE';
        claimcontact4.Name__c = 'test 345';
        claimcontact4.Email__c='rajmex2@mex2.com';
        claimcontact4.Claims__c = claim.Id;
        insert claimcontact4;
        
        Claim_Contact__c claimcontact1 = new Claim_Contact__c();
        claimcontact1.Contact_Type__c = 'MEX Buyer';
        claimcontact1.Name__c = 'rajkumar';
        claimcontact1.Email__c='rajmca138@gmail.com';
        claimcontact1.Claims__c = claim.Id;
        insert claimcontact1;
        
        Claim_Contact__c claimcontact = new Claim_Contact__c();
        claimcontact.Contact_Type__c = 'Category Manager';
        claimcontact.Name__c = 'saran';
        claimcontact.Email__c='rajCM1@Cmuser1.com';
        claimcontact.Claims__c = claim.Id;
        insert claimcontact;
                        
        Claim_Contact__c claimcontact3 = new Claim_Contact__c();
        claimcontact3.Contact_Type__c = 'Supplier Manager';
        claimcontact3.Name__c = 'saran';
        claimcontact3.Email__c='rajSM1@user1.com';
        claimcontact3.Claims__c = claim.Id;
        insert claimcontact3;
        //---------------------------------Supplier Contact------------------------------
        SupplierContacts__c supcon = new SupplierContacts__c();
        supcon.Name = 'raj sup con';
        supcon.Manufacturer_Name__c = manufacturer.Id;
        supcon.Supplier_Manager__c = 'raj Sup con';
        supcon.Email__c = 'rajSM@user.com';
        insert supcon;
                        
        SupplierContacts__c supcon1 = new SupplierContacts__c();
        supcon1.Name = 'raj sup con';
        supcon1.Manufacturer_Name__c = manufacturer.Id;
        supcon1.Supplier_Manager__c = 'raj Sup con';
        supcon1.Email__c = 'rajSM1@user1.com';
        insert supcon1;
                
        ///--------------------------------------NSN PARTS--------------------------------
        NSN_Part__c parts = new NSN_Part__c();
        parts.Name = 'P101';
        parts.COM__c = '101';
        parts.Description__c = 'test';
        insert parts;
        
        //-----------------------------------------MEPS------------------------------------
        MCAR_MEPS__c MEPS = NEW MCAR_MEPS__c();
        meps.MCAR_NSN_Part__c = parts.Id;
        meps.Manufacturer_Name__c = manufacturer.Id;
        meps.MCAR_Mfg_Part_Number__c = 'P101';
        meps.Name = 'P101';
        insert meps;
        ///---------------------------------------METERIAL DEVIATION------------------------
        Material_Deviation__c MD = new Material_Deviation__c();
        md.Code__c = meps.Id;
        md.MCAR_Claim_Management1__c = claim.Id;
        md.Quantity__c = 2;
        insert md;
        ///-----------------------------------PERFORMANCE DEVIATION-------------------------------
        Performance_Deviation_section__c pd = new Performance_Deviation_section__c();    
        
        pd.Claim__c = claim.Id;
        pd.Performance_Measure_Name__c = 'test';
        pd.Measurement_Standard__c = '2';
        pd.Associated_Part_Code__c = meps.id;
        pd.Actual_Measurement__c = '12';
        insert pd;
        ///--------------------------------------NSN CONTACTS----------------------------------
        MCAR_NSN_Contacts__c  nsn = new MCAR_NSN_Contacts__c();
        nsn.First_Name__c = 'raj';
        nsn.Last_Name__c = 'kumar';
        nsn.Role__c = 'Category Manager';
        nsn.Email__c = 'rajCM@Cmuser.com';
        nsn.Contact_External_Id__c =101.123;
        nsn.COM__c = '101';
        insert nsn; 
                         
        MCAR_NSN_Contacts__c  nsn1 = new MCAR_NSN_Contacts__c();
        nsn1.First_Name__c = 'raj';
        nsn1.Last_Name__c = 'kumar';
        nsn1.Role__c = 'Category Manager';
        nsn1.Email__c = 'rajCM1@Cmuser1.com';
        nsn1.Contact_External_Id__c =101.123;
        nsn1.COM__c = '101';
        insert nsn1;            
        ///-------------------------------------------------------------------------------
        
        test.startTest();
        ApexPages.CurrentPage().getparameters().put('claimId', claim.id);
        ClaimContactDetilasConroller claimcontact_controller= new ClaimContactDetilasConroller();
        claimcontact_controller.getSupplier();
        claimcontact_controller.getSupplierManager();
        claimcontact_controller.getNSNuser();
            claimcontact_controller.getMEXBuyer();
            claimcontact_controller.getFactory();        
            
        claimcontact_controller.claimContact.Claims__c = claim.Id;        
            claimcontact_controller.claimContact.Contact_Type__c = 'Manufacturer';
        
            claimcontact_controller.SaveChanges();       
        claimcontact_controller.SaveList(claimcontact_controller.getSupplier());
        test.stopTest();
    }  
     
    public static testmethod void sampletest5()
    {                
        MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();
        manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;
        insert manufacturer ; 
                               
            List<MCAR_Manufacturer_Contact__c> contact = new List<MCAR_Manufacturer_Contact__c>();
            MCAR_Manufacturer_Site__c site = new MCAR_Manufacturer_Site__c();
            site.Name = 'No Site Assigned';
            site.Manufacturer_Name__c = manufacturer.Id;
        
        MCAR_Manufacturer_Contact__c manCon = new MCAR_Manufacturer_Contact__c();
        manCon.Name = 'Test';
        manCon.Email__c = 'rajmca138@yahoo.com';
        manCon.Manufacturer_Name__c = manufacturer.id;        
        manCon.Manufacturer_Site__c = site.Id;  
        insert manCon; 
        
        MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();
        claim.Manufacturer__c = manufacturer.Id;
        claim.Part_Category__c = 'Indirect Procurement (IP)' ;
        claim.Claims_Business_Unit__c = 'Business Solutions';
        claim.Claims_Product_Name__c = 'LTE 2.3GHZ';      
        claim.Manufacturer_Email__c = 'rajmca138@yahoo.com'; 
        insert claim;  
        
        Claim_Contact__c cc = new Claim_Contact__c();               
        cc.Name__c = 'raj kumar';               
        cc.Claims__c = claim.id;
        cc.Email__c = 'rajmca138@yahoo.com';               
        cc.Contact_Type__c = 'Manufacturer';
        insert cc;
        
                test.startTest();
        ApexPages.CurrentPage().getparameters().put('claimId', claim.id);
        ClaimContactDetilasConroller claimcontact_controller= new ClaimContactDetilasConroller();
        claimcontact_controller.getSupplier();
        claimcontact_controller.getSupplierManager();
        claimcontact_controller.getNSNuser();
            claimcontact_controller.getMEXBuyer();
            claimcontact_controller.getFactory();        
            
        claimcontact_controller.claimContact.Claims__c = claim.Id;        
            claimcontact_controller.claimContact.Contact_Type__c = 'Manufacturer';
        
            claimcontact_controller.SaveChanges();       
        claimcontact_controller.SaveList(claimcontact_controller.getSupplier());
        test.stopTest();
    }
      public static testmethod void sampletest2()
      {                  
          MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();            
          manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;             
          insert manufacturer ;
                 
          MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();              
          claim.Manufacturer__c = manufacturer.Id;          
          claim.Part_Category__c = 'Indirect Procurement (IP)' ;            
          claim.Claims_Business_Unit__c = 'Business Solutions';
          claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
          claim.Manufacturer_Email__c = 'rajmca138@yahoo.com';
          insert claim;        

            MCAR_Manufacturer_Site__c site = new MCAR_Manufacturer_Site__c();
            site.Name = 'No Site Assigned';
            site.Manufacturer_Name__c = manufacturer.Id;
                     
          
                MCAR_Manufacturer_Contact__c manCon = new MCAR_Manufacturer_Contact__c();
                manCon.Name = 'Test';
                manCon.Email__c = 'rajmca138@yahoo.com';
                manCon.Manufacturer_Name__c = manufacturer.id;        
                manCon.Manufacturer_Site__c = site.Id;  
                insert manCon;
                                    
                MCAR_Manufacturer_Contact__c manCon1 = new MCAR_Manufacturer_Contact__c();
                manCon1.Name = 'Test';
                manCon1.Email__c = 'test@test.com';
                manCon1.Manufacturer_Name__c = manufacturer.id;
                manCon1.Manufacturer_Site__c = site.Id;                
                insert manCon1;
          
        test.startTest();
        ApexPages.CurrentPage().getparameters().put('claimId', claim.id);
        ClaimContactDetilasConroller claimcontact_controller= new ClaimContactDetilasConroller();
        claimcontact_controller.getSupplier();
        claimcontact_controller.getSupplierManager();
        claimcontact_controller.getNSNuser();
            claimcontact_controller.getMEXBuyer();
            claimcontact_controller.getFactory();
        
          
          claimcontact_controller.claimContact.Claims__c = claim.id;
          claimcontact_controller.claimContact.Contact_Type__c = 'SQM';
                
          claimcontact_controller.claimContact.Name__c ='raj';
          
          claimcontact_controller.claimContact.Email__c = 'raj@user.com';
                   
          claimcontact_controller.SaveAndNew();               
        test.stopTest();          
      }
        
    public static testmethod void sampletest3()
    {
          MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c();            
          manufacturer.Manufacturer_Name_Ext_Id__c = '1ST LABEL' ;             
          insert manufacturer ;
                 
          MCAR_Claim_Management__c claim = new MCAR_Claim_Management__c();              
          claim.Manufacturer__c = manufacturer.Id;          
          claim.Part_Category__c = 'Indirect Procurement (IP)' ;            
          claim.Claims_Business_Unit__c = 'Business Solutions';
          claim.Claims_Product_Name__c = 'LTE 2.3GHZ';
          claim.Manufacturer_Email__c = 'rajmca138@yahoo.com';
          insert claim;       
                
        test.startTest();
        ApexPages.CurrentPage().getparameters().put('claimId', claim.id);
        ClaimContactDetilasConroller claimcontact_controller= new ClaimContactDetilasConroller();
          claimcontact_controller.claimContact.Claims__c = claim.id;
          claimcontact_controller.claimContact.Contact_Type__c = 'SQM';
         claimcontact_controller.SaveContact();          
          claimcontact_controller.claimContact.Name__c ='raj';
          claimcontact_controller.SaveContact();          
          claimcontact_controller.claimContact.Email__c = 'raj@user.com';
          claimcontact_controller.SaveContact();        
        test.stopTest();
    }
}