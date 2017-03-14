@isTest
public class supplierChartsTest{
    static testMethod void supplierTest() {
      
        User testUser = new User(FirstName = 'test', LastName = 'user', Email = 'test.user@gmail.com', Alias = 'test', ProfileID = '00eU0000000UGZX', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
             TimeZoneSidKey='America/Los_Angeles', UserName='test2.testUser@SPEorg.com');
        insert testUser;
        system.debug('User insersted !!!!!'+testUser);
        
        
        Account accTest = new Account();
        accTest.Name = 'Test Supplier';
        accTest.Actual_Spend__c = 1000;
        accTest.LE_Spend__c = 500;
        accTest.Enterprise_Id__c = 'SupplierTest123';
        accTest.CategoryAreaSIM__c= 'Delivery Operations (DO)';
        accTest.Supplier_Segmentation__c = 'Shop';
        accTest.Nokia_as_a_Customer__c = 'Core';
        accTest.LSM__c = testUser.id;
        
        insert accTest;
        System.debug('Account inserted!!!!!'+accTest);

        
       system.runAs(testUser)
    {
        Test.startTest();
        supplierSpendController.barGraphData barGraph = new supplierSpendController.barGraphData();
           List <supplierSpendController.barGraphData> bar = supplierSpendController.getChartData();
        Test.stopTest();
    }
       }
       }