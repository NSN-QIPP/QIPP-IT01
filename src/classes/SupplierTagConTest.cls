@isTest
private class SupplierTagConTest {
	
    private static testmethod void testTag()
    {
        Profile p = [Select Id from profile where Name = 'System Administrator'];
    
        User Usr = new User(FirstName = 'test', LastName = 'user', Email = 'test.user@gmail.com', Alias = 'test', ProfileID = p.id , EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
        TimeZoneSidKey='America/Los_Angeles', UserName='testUser@SPEorg.com');
        insert Usr;
        
        System.runas(Usr){
            Account acc = new Account();
            acc.Name = 'Test Account';
          insert acc;
            
            ApexPages.currentPage().getParameters().put('id',acc.id);
        ApexPages.standardController stdCon = new ApexPages.standardController(acc);
        SupplierTagCon Controller = new SupplierTagCon (stdCon);
        Controller.checkUser();
       
        }
        
    }
}