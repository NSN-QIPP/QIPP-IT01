@isTest
public class SupplierTrigger_Test {
   public static testMethod void ValidateSupplierTest(){
     Profile p = [Select Id from profile where Name = 'System Administrator'];
    
    User Usr = new User(FirstName = 'test', LastName = 'user', Email = 'test.user@gmail.com', Alias = 'test', ProfileID = p.id , EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
             TimeZoneSidKey='America/Los_Angeles', UserName='testUser@SPEorg.com');
    insert Usr;
    
     System.runas(Usr){
        test.starttest();
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Model__c='Integrate';
        acc.LSM__c = Usr.id; 
        acc.Supplier_Segmentation__c ='Leverage';
        acc.Nokia_as_a_Customer__c = 'Develop';
        insert acc;

        Account acc1 = new Account();
        acc1 .Name = 'Test Account1';
        acc1 .Model__c='Grow';
        acc1 .LSM__c = Usr.id; 
        acc1.Supplier_Segmentation__c ='Leverage';
        acc1.Nokia_as_a_Customer__c = 'Develop';
        insert acc1;

        
        Account acc2 = new Account();
        acc2.Name = 'Test Accoun2t';
        acc2.LSM__c = Usr.id; 
        acc2.Supplier_Segmentation__c ='Leverage';
        acc2.Nokia_as_a_Customer__c = 'Develop';
        insert acc2;
        
        Account acc3 = new Account();
        acc3.Name = 'Test Accoun3t';
        acc3.Model__c='Sustain';
        acc3.LSM__c = Usr.id; 
        acc3.Supplier_Segmentation__c ='Leverage';
        acc3.Nokia_as_a_Customer__c = 'Develop';
        insert acc3;

        
        Account acc4 = new Account();
        acc4.Name = 'Test Accou4nt';
        acc4.Model__c='Bail out / Develop';
        acc4.LSM__c = Usr.id; 
        acc4.Supplier_Segmentation__c ='Leverage';
        acc4.Nokia_as_a_Customer__c = 'Develop';
        insert acc4;
        
        Account acc5 = new Account();
        acc5.Name = 'Test Accou5nt';
        acc5.Model__c='Improve';
        acc5.LSM__c = Usr.id; 
        acc5.Supplier_Segmentation__c ='Leverage';
        acc5.Nokia_as_a_Customer__c = 'Develop';
        insert acc5;
        
        Account acc6 = new Account();
        acc6.Name = 'Test Acco6unt';
        acc6.Model__c='Harvest';
        acc6.LSM__c = Usr.id; 
        acc6.Supplier_Segmentation__c ='Leverage';
        acc6.Nokia_as_a_Customer__c = 'Develop';
        insert acc6;
        
       
       Account acc7 = new Account();
        acc7.Name = 'Test Accou7nt';
       acc7.Model__c='Mitigate';
        acc7.LSM__c=Usr.id;
        acc7.Supplier_Segmentation__c ='Leverage';
        acc7.Nokia_as_a_Customer__c = 'Develop';
        insert acc7;
        
       Account acc8 = new Account();
        acc8.Name = 'Test 8Account';
        acc8.Model__c='Replace';
        acc8.LSM__c=Usr.id;
        acc8.Supplier_Segmentation__c ='Leverage';
        acc8.Nokia_as_a_Customer__c = 'Develop';
        insert acc8;
       
       Account acc9 = new Account();
        acc9.Name = 'Test 9Account';
        acc9.Model__c='Influence';
        acc9.LSM__c=Usr.id;
        acc9.Supplier_Segmentation__c ='Leverage';
        acc9.Nokia_as_a_Customer__c = 'Develop';
        insert acc9;

       test.stoptest();
       }
   }
}