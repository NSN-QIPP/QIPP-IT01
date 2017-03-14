@isTest(seeAllData=False)
public class SPE2_SPETemplateScopeInlineExt_Test {
    static testMethod void SPE2_SPETemplateScopeInlineExtTest1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
        User u = new User(Alias ='standt', Email='standarduser@testorg.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
        insert u; 
        Group g = new Group(Name ='SPE1.0 User Group',
                        DeveloperName = 'unit_test_group',
                        Type = 'Regular');
        insert g;  
        GroupMember gm= new GroupMember();
        gm.GroupId =g.id;
        gm.UserOrGroupId = u.id;  
        insert gm;   
        System.runAs(u){              
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';       
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPETemplateScopeInline;
        Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemp);
        SPE2_SPETemplateScopeInlineExt ncAudit = new SPE2_SPETemplateScopeInlineExt(stCon);        
     }
    Test.StopTest();
   }
   static testMethod void SPE2_SPETemplateScopeInlineExtTest2(){
        Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
        User u = new User(Alias ='standt', Email='standarduser@testorg.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
        insert u; 
        Group g = new Group(Name ='SPE2.0 User Group',
                        DeveloperName = 'unit_test_group',
                        Type = 'Regular');
        insert g;  
        GroupMember gm= new GroupMember();
        gm.GroupId =g.id;
        gm.UserOrGroupId = u.id;  
        insert gm;   
        System.runAs(u){              
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';       
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        Test.startTest();
        PageReference pageRef = Page.SPE2_SPETemplateScopeInline;
        Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemp);
        SPE2_SPETemplateScopeInlineExt ncAudit = new SPE2_SPETemplateScopeInlineExt(stCon);        
     }
    Test.StopTest();
   }
}