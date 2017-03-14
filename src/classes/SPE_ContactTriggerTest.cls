@isTest(SeeAllData = False) 
private class SPE_ContactTriggerTest {
    
    static testMethod void generatePasswordPositive()
    {
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        List<Contact> lstContact = new List<Contact>();
        for(Integer i=0;i<2;i++)
        {
            Contact contact = new Contact();
            contact.LastName = 'Amit'+i;
            contact.Email = 'amit@kher.nokia.com'+i;
            contact.CurrencyIsoCode = 'EUR';
            lstContact.add(contact);
        }
        
        test.startTest();
        insert lstContact;
        test.stopTest();                
        
        Contact testContact = [Select Id, LastName, Password__c From Contact limit 1];
              
        System.assertEquals(testContact.Password__c.left(1).toUpperCase(), 'A');
       
        //  System.equals(testContact.Password__c.left(1).toUpperCase(), 'A');
        
    }
    
    static testMethod void generatePasswordNegative()
    {
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        List<Contact> lstContact = new List<Contact>();
        
        for(Integer i=0;i<2;i++)
        {
            Contact contact = new Contact();
            contact.FirstName = 'Kher'+i;
            contact.LastName = 'Amit'+i;
            contact.Email = 'amit@kher.nokia.com'+i;
            contact.CurrencyIsoCode = 'EUR';
            lstContact.add(contact);
        }
        Test.StartTest();
        
        insert lstContact;
        
        Test.StopTest();
    
        Contact testContact = [Select Id, LastName, Password__c From Contact Where LastName = 'Amit1'];
        
        System.assertEquals(testContact.Password__c.substring(0,2).toUpperCase(), 'KA');
        
        }
    

}