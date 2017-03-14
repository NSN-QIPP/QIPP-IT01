@isTest
public class riskSummaryTest{
    static testMethod void riskTest() {
      
        User testUser = new User(FirstName = 'test', LastName = 'user', Email = 'test.user@gmail.com', Alias = 'test', ProfileID = '00eU0000000UGZX', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
             TimeZoneSidKey='America/Los_Angeles', UserName='testUser@SPEorg.com');
        insert testUser;
        system.debug('User insersted !!!!!'+testUser);
        
        
        List<Account> accTestList = new List<Account>();
        for(integer i = 1;i<6;i++){
        Account accTest = new Account(Name = 'Test Supplier'+string.valueOf(i),Enterprise_Id__c = 'SupplierTest123'+string.valueOf(i), CategoryAreaSIM__c= 'Delivery Operations (DO)', LSM__c = testUser.id, Supplier_Segmentation__c = 'Shop', Nokia_as_a_Customer__c = 'Core',Total_Score__c = 100*i, Lead_Unit__c = 'PPO');
        accTestList.add(accTest);
        }
        for(integer i = 10;i<16;i++){
        Account accTest = new Account(Name = 'Test Supplier'+string.valueOf(i),Enterprise_Id__c = 'SupplierTest123'+string.valueOf(i), CategoryAreaSIM__c= 'Delivery Operations (DO)', LSM__c = testUser.id, Supplier_Segmentation__c = 'Shop', Nokia_as_a_Customer__c = 'Core',Total_Score__c = 20*i, Lead_Unit__c = 'SPO');
        accTestList.add(accTest);
        }
        for(integer i = 20;i<26;i++){
        Account accTest = new Account(Name = 'Test Supplier'+string.valueOf(i),Enterprise_Id__c = 'SupplierTest123'+string.valueOf(i), CategoryAreaSIM__c= 'Delivery Operations (DO)', LSM__c = testUser.id, Supplier_Segmentation__c = 'Shop', Nokia_as_a_Customer__c = 'Core',Total_Score__c = 10*i, Lead_Unit__c = 'IPO');
        accTestList.add(accTest);
        }                
        for(integer i = 31;i<35;i++){
        Account accTest = new Account(Name = 'Test Supplier'+string.valueOf(i),Enterprise_Id__c = 'SupplierTest123'+string.valueOf(i), CategoryAreaSIM__c= 'Delivery Operations (DO)', LSM__c = testUser.id, Supplier_Segmentation__c = 'Shop', Nokia_as_a_Customer__c = 'Core',Total_Score__c = 20*i, Lead_Unit__c = 'GSCM AMS PO');
        accTestList.add(accTest);
        }
        
        insert accTestList;
        System.debug('Account inserted!!!!!'+accTestList);

        
       system.runAs(testUser)
    {
        Test.startTest();
        riskSummaryController data1 = new riskSummaryController();
        riskSummaryController.summaryData data = new riskSummaryController.summaryData();
        
        List<riskSummaryController.summaryData> dataSummary = riskSummaryController.getSummaryData();
        Test.stopTest();
    }
       }
       }