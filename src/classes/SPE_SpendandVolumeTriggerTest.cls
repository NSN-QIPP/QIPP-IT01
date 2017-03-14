@isTest(SeeAllData=false)

public class SPE_SpendandVolumeTriggerTest{
public static testmethod void SPE_SpendandVolumeTriggerTest(){

List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';        
        picklistObj.Project__c = 'All Projects';
        
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';               
        
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';       
        picklistObj.Product__c = 'All Products';
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');

        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Filter for Spend and Volume';
        Rconfig.Market_Filter_For_Volume__c = true;
        Rconfig.Product_Filter_For_Spend__c= true;
        Rconfig.Product_Filter_For_Volume__c= true;
        insert Rconfig;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
        System.RunAs(u){ 
        
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        SPE_SpendandVolume__c sp = new SPE_SpendandVolume__c();
        sp.Supplier__c= acc1.Id;
        sp.Period__c= Date.newinstance(2016,01,25);
       
        insert sp;
        }
}
}