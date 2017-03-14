@isTest

public class SPE_ScorecardTemplateLifecycleEXTTest{

public static  testMethod void  SPE_ScorecardTemplateLifecycleEXTTest(){

    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
  
    User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
    EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
    LocaleSidKey='en_US', ProfileId = p.Id, 
    TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
    insert u;   
     
    SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
    sc.Name = 'Test ScoreTemplate';
    sc.Stage__c = 'Draft';
    insert sc;
    
    
    Test.setCurrentPage(Page.SPE_ScorecardTemplateLifecycleButtons);
    ApexPages.StandardController stdController = new ApexPages.StandardController(sc);
    SPE_ScorecardTemplateLifecycleEXT ext = new SPE_ScorecardTemplateLifecycleEXT(stdController);
    sc.Stage__c = 'Published';
    update sc;
   
    ext.StagePublished();
    ext.StageObsolete();
    
    

 }
}