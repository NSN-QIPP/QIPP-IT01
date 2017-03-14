@isTest
public with sharing class TestClass_MCARClaims_Trigger
{

           static TestMethod void Test_InsertWithValue_Trigger_Send_Email_Data_Collection()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.Data_Collection_Notification_Send__c = True; 
                testObj.Claim_Status__c = 'Data Collection';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                /*************Testing_Trigger_Send_Email_Data_Collection************/
                MCAR_Claim_Management__c inserted_testObj = [select Claim_Status__c,RecordTypeId from MCAR_Claim_Management__c where ID =: testObj.ID];
                RecordType Rec = [SELECT Id FROM RecordType WHERE Name = 'MCAR Claim Negotiation layout'limit 1];
                System.assertEquals('Negotiation',inserted_testObj.Claim_Status__c);
                System.assertEquals (Rec.Id,inserted_testObj.RecordTypeId);

        }


          static TestMethod void Test_InsertWithValue_Trigger_Send_Email_Closed()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.Data_claim_Notification_Send__c  = True; 
                testObj.Claim_Status__c = 'Closed';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                /*************Testing_Trigger_Send_Email_Data_Collection*****
                MCAR_Claim_Management__c inserted_testObj = [select Claim_Status__c,RecordTypeId from MCAR_Claim_Management__c where ID =: testObj.ID];
                RecordType Rec = [SELECT Id FROM RecordType WHERE Name = 'MCAR Claim close layout'limit 1];
                System.assertEquals (Rec.Id,inserted_testObj.RecordTypeId);*/
        }

         static TestMethod void Test_InsertWithValue_Trigger_Send_Email()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
                Claim_Contact__c  Technical = new Claim_Contact__c ();
                Technical.Email__c ='test@nokia.com';
                Technical.Contact_Type__c='Technical';
                Technical.Claims__c =testObj.ID;
                cc.add(Technical);                
                insert cc;   
               
                Claim_Contact__c Technicalcon = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: testObj.ID AND Contact_Type__c != 'Manufacturer'];
                System.assertEquals('Technical',Technicalcon.Contact_Type__c);
                System.assertEquals(Technical.Email__c,Technicalcon.Email__c); 
          

                /*************Testing_Trigger_Send_Email_Data_Collection*****/
                MCAR_Claim_Management__c inserted_testObj = [select Claim_Status__c,RecordTypeId from MCAR_Claim_Management__c where ID =: testObj.ID];
                //System.assertEquals('Data Collection',inserted_testObj.Claim_Status__c);
            
        }
        
        static TestMethod void Test_Hub_Worksheet_Trigger()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                Materials_Hub_Worksheet__c childtestObj = new Materials_Hub_Worksheet__c();
                childtestObj.Category__c='Test';
                childtestObj.Description__c='Test';
                childtestObj.Qty_Hours__c=5;
                childtestObj.Unit_Price__c=400;
                childtestObj.Claim__c=testObj.ID;
                insert childtestObj; 
            
                System.assertEquals(childtestObj.Amount__c,testObj.Materials_Hub_Loss__c);             
                delete childtestObj; 

                System.assertEquals(childtestObj.Amount__c,testObj.Materials_Hub_Loss__c);
               

            
        }



        static TestMethod void Test_Services_Worksheet_Trigger()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                Claim_NCC_Services_Worksheet__c childtestObj = new Claim_NCC_Services_Worksheet__c();
                childtestObj.NCC_Category__c='Test';
                childtestObj.Description__c='Test';
                childtestObj.Qty_Hours__c=5;
                childtestObj.Unit_Price__c=400;
                childtestObj.Claim__c=testObj.ID;
                
                insert childtestObj; 
            
                System.assertEquals(childtestObj.Amount__c,testObj.Services_Loss__c);             
                
                delete childtestObj; 

                System.assertEquals(childtestObj.Amount__c,testObj.Services_Loss__c);
               

            
        }


        static TestMethod void Test_Field_Worksheet_Trigger()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                Materials_Field_Worksheet__c childtestObj = new Materials_Field_Worksheet__c();
                childtestObj.Category__c='Test';
                childtestObj.Description__c='Test';
                childtestObj.Qty_Hours__c=5;
                childtestObj.Unit_Price__c=400;
                childtestObj.Claim__c=testObj.ID;
                insert childtestObj; 
            
                System.assertEquals(childtestObj.Amount__c,testObj.Materials_Field_Loss__c );             
                delete childtestObj; 

                System.assertEquals(childtestObj.Amount__c,testObj.Materials_Field_Loss__c );
               

            
        }


        static TestMethod void Test_Factory_Worksheet_Trigger()
        {
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                insert testObj; 

                NCC_Materials_Factory_Worksheet__c    childtestObj = new NCC_Materials_Factory_Worksheet__c  ();
                childtestObj.Category__c='Test';
                childtestObj.Description__c='Test';
                childtestObj.Qty_Hours__c=5;
                childtestObj.Unit_Price__c=400;
                childtestObj.Claim__c=testObj.ID;
                insert childtestObj; 
            
                System.assertEquals(childtestObj.Amount__c,testObj.Materials_Factory_Loss__c);             
                delete childtestObj; 

                System.assertEquals(childtestObj.Amount__c,testObj.Materials_Factory_Loss__c);
               

            
        }
        
        static TestMethod void Test_Claim_Type_Update_Trigger()
        {

                Date cDT = Date.today();
                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                testObj.Technical_Details_Review_Approval__c = true;
                testObj.Legal_Team_Review_Approval__c =  true;
                testObj.Commodity_Manager_Review_Approval__c = true;
                testObj.Nonconformance_Costs_Review_Approval__c = true; 
                testObj.Claim_Type__c = 'Local';
                insert testObj; 
                
                NCC_Materials_Factory_Worksheet__c    childtestObj = new NCC_Materials_Factory_Worksheet__c  ();
                childtestObj.Category__c='Test';
                childtestObj.Description__c='Test';
                childtestObj.Qty_Hours__c=5;
                childtestObj.Unit_Price__c=400;
                childtestObj.Claim__c=testObj.ID;
                insert childtestObj; 
               
                MCAR_Claim_Management__c result = [Select Claim_Type__c,Root_Cause_Analysis_Approved_Date__c,Legal_Analysis_Approved_Date__c,Commodity_Manager_Approved_Date__c,Non_Conformance_Costs_Approved_Date__c from MCAR_Claim_Management__c where ID=:testObj.ID];
               
                System.assertEquals(cDT,result.Root_Cause_Analysis_Approved_Date__c);             
                System.assertEquals(cDT,result.Legal_Analysis_Approved_Date__c);             
                System.assertEquals(cDT,result.Commodity_Manager_Approved_Date__c);             
                System.assertEquals(cDT,result.Non_Conformance_Costs_Approved_Date__c);             
                //System.assertEquals('Local',result.Claim_Type__c);
                
                childtestObj.Qty_Hours__c=5000;
                update childtestObj;
                
                MCAR_Claim_Management__c update_result = [Select Claim_Type__c,Root_Cause_Analysis_Approved_Date__c,Legal_Analysis_Approved_Date__c,Commodity_Manager_Approved_Date__c,Non_Conformance_Costs_Approved_Date__c from MCAR_Claim_Management__c where ID=:testObj.ID];
                //System.assertEquals('Global',update_result.Claim_Type__c);

              
            
        }
         static TestMethod void Test_Claim_Contact_Trigger()
        {

                MCAR_Claim_Management__c testObj = new MCAR_Claim_Management__c();
                testObj.I_Agree__c  = True; 
                testObj.Claim_Status__c = 'Draft';
                testObj.CreatedDate= Datetime.now(); 
                testObj.Technical_Details_Review_Approval__c = true;
                testObj.Legal_Team_Review_Approval__c =  true;
                testObj.Commodity_Manager_Review_Approval__c = true;
                testObj.Nonconformance_Costs_Review_Approval__c = true; 
                testobj.Manufacturer_Email__c = 'test@gmail.com';
                testobj.Category_Manager_Email__c = 'test@gmail.com';
                insert testObj; 

            Claim_Contact__c childObj = new Claim_Contact__c();
            childObj.Contact_Type__c = 'Manufacturer';
            childObj.Email__c='test@gmail.com';
            childObj.Claims__c=testObj.ID;
            insert childObj;
            
           
            Claim_Contact__c childObj1 = new Claim_Contact__c();
            childObj1.Contact_Type__c = 'Category Manager';
            childObj1.Email__c='test@gmail.com';
           childObj1.Claims__c=testObj.ID;
            insert childObj1;
            
             MCAR_Claim_Management__c parent_obj = [select Manufacturer_Email__c,Category_Manager_Email__c from MCAR_Claim_Management__c WHERE id =:testObj.ID]; 
             System.assertEquals('test@gmail.com',parent_obj.Manufacturer_Email__c);             
             System.assertEquals('test@gmail.com',parent_obj.Category_Manager_Email__c); 
       
             

        }

}