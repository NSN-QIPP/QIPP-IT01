@isTest
public with sharing class TestClass_Claims_Worksheet
{

    
    
    static TestMethod void TestClass_Factory_Worksheet()
        {

             MCAR_Claim_Management__c  testParentObj = new MCAR_Claim_Management__c();
            testParentObj.Data_Collection_Notification_Send__c = True; 
            testParentObj.Claim_Status__c = 'Data Collection';
            testParentObj.Materials_Factory_Loss__c=null;
            testParentObj.CreatedDate= Datetime.now(); 
            insert testParentObj; 

             List<NCC_Materials_Factory_Worksheet__c>   listTestobj = new List<NCC_Materials_Factory_Worksheet__c> ();
             NCC_Materials_Factory_Worksheet__c   Testobj = new NCC_Materials_Factory_Worksheet__c();
            Testobj.Category__c='Test';
            Testobj.Description__c='Test';
            Testobj.Qty_Hours__c=5;
            Testobj.Unit_Price__c=400;
            Testobj.Claim__c=testParentObj.ID;
            listTestobj.add(Testobj);
            insert listTestobj; 

                ApexPages.StandardSetController con = new ApexPages.StandardSetController(listTestobj);
                Claim_Materials_Factory_Worksheet testclass_object = new Claim_Materials_Factory_Worksheet (con);

                Test.startTest();
                PageReference pg = Page.MCAR_Claim_Materials_Factory_Worksheet; 
                Test.setCurrentPage(pg);

                ApexPages.currentPage().getParameters().put('id', testParentObj.id);
                ApexPages.currentPage().getParameters().get('id');

                testclass_object.on_load();
                //MCAR_Claim_Management__c claim_obj = [select Materials_Factory_Loss__c from MCAR_Claim_Management__c where ID =:testParentObj.id];
                System.assertEquals(testclass_object.total_loss,testParentObj.Materials_Factory_Loss__c);

                //testclass_object.addrows();
                Claim_Materials_Factory_Worksheet.cContact inner_class =new Claim_Materials_Factory_Worksheet.cContact(new NCC_Materials_Factory_Worksheet__c(Category__c='Test'));
                inner_class.selected=true;

                testclass_object.getContacts();

                testclass_object.updatedrows();
                testclass_object.selecteditems = new List<NCC_Materials_Factory_Worksheet__c>();
                
                testclass_object.save();
                testclass_object.selecteditems = new List<NCC_Materials_Factory_Worksheet__c>();
                
                testclass_object.deletedrows();


                 String strnull=testclass_object.getdynamictextvalue();
                 System.assertEquals('',strnull);
                
                testclass_object.prd = new List<NCC_Materials_Factory_Worksheet__c>();
                testclass_object.addrows();                
             
                Test.stopTest();
       }


       

        static TestMethod void TestClass_Field_Worksheet()
        {

            MCAR_Claim_Management__c  testParentObj = new MCAR_Claim_Management__c();
            testParentObj.Data_Collection_Notification_Send__c = True; 
            testParentObj.Claim_Status__c = 'Data Collection';
            testParentObj.Materials_Factory_Loss__c=null;
            testParentObj.CreatedDate= Datetime.now(); 
            insert testParentObj; 

            List<Materials_Field_Worksheet__c>   listTestobj = new List<Materials_Field_Worksheet__c> ();
            Materials_Field_Worksheet__c   Testobj = new Materials_Field_Worksheet__c();
            Testobj.Category__c='Test';
            Testobj.Description__c='Test';
            Testobj.Qty_Hours__c=5;
            Testobj.Unit_Price__c=400;
            Testobj.Claim__c=testParentObj.ID;
            listTestobj.add(Testobj);
            insert listTestobj; 

                ApexPages.StandardSetController con = new ApexPages.StandardSetController(listTestobj);
                Claim_Materials_Field_Worksheet testclass_object = new Claim_Materials_Field_Worksheet (con);

                Test.startTest();
                PageReference pg = Page.MCAR_Claim_Materials_Field_Worksheet; 
                Test.setCurrentPage(pg);

                ApexPages.currentPage().getParameters().put('id', testParentObj.id);
                ApexPages.currentPage().getParameters().get('id');

                testclass_object.on_load();
                //MCAR_Claim_Management__c claim_obj = [select Materials_Factory_Loss__c from MCAR_Claim_Management__c where ID =:testParentObj.id];
                System.assertEquals(testclass_object.total_loss,testParentObj.Materials_Factory_Loss__c);

                //testclass_object.addrows();
                Claim_Materials_Field_Worksheet.cContact inner_class =new Claim_Materials_Field_Worksheet.cContact(new Materials_Field_Worksheet__c(Category__c='Test'));
                inner_class.selected=true;

                testclass_object.getContacts();

                testclass_object.updatedrows();
                testclass_object.selecteditems = new List<Materials_Field_Worksheet__c>();
                
                testclass_object.save();
                testclass_object.selecteditems = new List<Materials_Field_Worksheet__c>();
                
                testclass_object.deletedrows();


                 String strnull=testclass_object.getdynamictextvalue();
                 System.assertEquals('',strnull);
                
                testclass_object.prd = new List<Materials_Field_Worksheet__c>();
                testclass_object.addrows();
              
            
               Test.stopTest();

       }
      
        

        static TestMethod void TestClass_Hub_Worksheet()
        {

            MCAR_Claim_Management__c  testParentObj = new MCAR_Claim_Management__c();
            testParentObj.Data_Collection_Notification_Send__c = True; 
            testParentObj.Claim_Status__c = 'Data Collection';
            testParentObj.Materials_Factory_Loss__c=null;
            testParentObj.CreatedDate= Datetime.now(); 
            insert testParentObj; 

            List<Materials_Hub_Worksheet__c>   listTestobj = new List<Materials_Hub_Worksheet__c> ();
            Materials_Hub_Worksheet__c   Testobj = new Materials_Hub_Worksheet__c();
            Testobj.Category__c='Test';
            Testobj.Description__c='Test';
            Testobj.Qty_Hours__c=5;
            Testobj.Unit_Price__c=400;
            Testobj.Claim__c=testParentObj.ID;
            listTestobj.add(Testobj);
            insert listTestobj; 

                ApexPages.StandardSetController con = new ApexPages.StandardSetController(listTestobj);
                Claim_Materials_Hub_Worksheet testclass_object = new Claim_Materials_Hub_Worksheet (con);

                Test.startTest();
                PageReference pg = Page.MCAR_Claim_Materials_Hub_Worksheet; 
                Test.setCurrentPage(pg);

                ApexPages.currentPage().getParameters().put('id', testParentObj.id);
                ApexPages.currentPage().getParameters().get('id');

                testclass_object.on_load();
                //MCAR_Claim_Management__c claim_obj = [select Materials_Factory_Loss__c from MCAR_Claim_Management__c where ID =:testParentObj.id];
                System.assertEquals(testclass_object.total_loss,testParentObj.Materials_Factory_Loss__c);

                //testclass_object.addrows();
                Claim_Materials_Hub_Worksheet.cContact inner_class =new Claim_Materials_Hub_Worksheet.cContact(new Materials_Hub_Worksheet__c(Category__c='Test'));
                inner_class.selected=true;

                testclass_object.getContacts();

                testclass_object.updatedrows();
                testclass_object.selecteditems = new List<Materials_Hub_Worksheet__c>();
                
                testclass_object.save();
                testclass_object.selecteditems = new List<Materials_Hub_Worksheet__c>();
                
                testclass_object.deletedrows();


                 String strnull=testclass_object.getdynamictextvalue();
                 System.assertEquals('',strnull);
                
                testclass_object.prd = new List<Materials_Hub_Worksheet__c>();
                testclass_object.addrows();
              
            
               Test.stopTest();

       }
       

       static TestMethod void TestClass_Services_Worksheet()
        {

            MCAR_Claim_Management__c  testParentObj = new MCAR_Claim_Management__c();
            testParentObj.Data_Collection_Notification_Send__c = True; 
            testParentObj.Claim_Status__c = 'Data Collection';
            testParentObj.Materials_Factory_Loss__c=null;
            testParentObj.CreatedDate= Datetime.now(); 
            insert testParentObj; 

            List<Claim_NCC_Services_Worksheet__c>   listTestobj = new List<Claim_NCC_Services_Worksheet__c> ();
            Claim_NCC_Services_Worksheet__c   Testobj = new Claim_NCC_Services_Worksheet__c();
            Testobj.NCC_Category__c='Test';
            Testobj.Description__c='Test';
            Testobj.Qty_Hours__c=5;
            Testobj.Unit_Price__c=400;
            Testobj.Claim__c=testParentObj.ID;
            listTestobj.add(Testobj);
            insert listTestobj; 

                ApexPages.StandardSetController con = new ApexPages.StandardSetController(listTestobj);
                Claim_NCC_Services testclass_object = new Claim_NCC_Services (con);

                Test.startTest();
                PageReference pg = Page.MCAR_Claim_NCC_Services_Worksheet; 
                Test.setCurrentPage(pg);

                ApexPages.currentPage().getParameters().put('id', testParentObj.id);
                ApexPages.currentPage().getParameters().get('id');

                testclass_object.on_load();
                //MCAR_Claim_Management__c claim_obj = [select Materials_Factory_Loss__c from MCAR_Claim_Management__c where ID =:testParentObj.id];
                System.assertEquals(testclass_object.total_loss,testParentObj.Materials_Factory_Loss__c);

                //testclass_object.addrows();
                Claim_NCC_Services.cContact inner_class =new Claim_NCC_Services.cContact(new Claim_NCC_Services_Worksheet__c(NCC_Category__c='Test'));
                inner_class.selected=true;

                testclass_object.getContacts();

                testclass_object.updatedrows();
                testclass_object.selecteditems = new List<Claim_NCC_Services_Worksheet__c>();
                
                testclass_object.save();
                testclass_object.selecteditems = new List<Claim_NCC_Services_Worksheet__c>();
                
                testclass_object.deletedrows();


                 String strnull=testclass_object.getdynamictextvalue();
                 System.assertEquals('',strnull);
                
                testclass_object.prd = new List<Claim_NCC_Services_Worksheet__c>();
                testclass_object.addrows();
              
            
               Test.stopTest();

       }


       
        
}