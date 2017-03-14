@isTest
public class leadSupplierManager_Test{
    static testMethod void leadSupplierManagerTest() {
      
        user us = new user();
        us.FirstName = 'test';
         us.LastName = 'user';
         us.Email = 'test.user@gmail.com';
         us.Alias = 'test';
        us.ProfileID = '00eU0000000UGZX';
        us.EmailEncodingKey='UTF-8';
        us.LanguageLocaleKey='en_US';
        us.LocaleSidKey='en_US';
        us.Username ='test.john1234@gmail.com';
        us.CommunityNickname = 'test';
        us.TimeZoneSidKey ='America/Denver';
        insert us;
        
         Account accTest = new Account();
        accTest.Name = 'Test Supplier';
        accTest.Actual_Spend__c = 1000;
        accTest.LE_Spend__c = 500;
        accTest.Enterprise_Id__c = 'SupplierTest123';
        accTest.CategoryAreaSIM__c= 'Delivery Operations (DO)';
        accTest.Supplier_Segmentation__c = 'Shop';
        accTest.Nokia_as_a_Customer__c = 'Core';
        accTest.LSM__c = us.id;
        insert accTest;
        
        SPE_Spend__c spe = new SPE_Spend__c();
        spe.CategoryArea__c ='Services Procurement Operations (SPO)';
        spe.Period__c = date.today();
        spe.Spend__c = 56 ;
        insert spe;
                        
        SPE_Spend__c spe1 = new SPE_Spend__c();
        spe1.CategoryArea__c ='Indirect Procurement Operations (INPO)';
        spe1.Period__c = date.today();
        spe1.Spend__c = 56 ;
        insert spe1;
        
        leadSupplierManager.barGraphData bargraph = new leadSupplierManager.barGraphData();
         Apexpages.StandardController stdController = new Apexpages.StandardController(accTest);
      leadSupplierManager leadsup = new leadSupplierManager(stdController);
        leadSupplierManager.getChartData();
        
        }
        }