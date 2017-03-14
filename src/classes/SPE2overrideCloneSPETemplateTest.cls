@isTest (seeAllData=false)
private class SPE2overrideCloneSPETemplateTest{
  static testMethod void createSPE2overrideCloneSPETemplatePositive(){
    
    Test.StartTest();
    Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
    User u = new User(Alias = 'library', Email='libraryuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Test', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testinguser@testinguser.com.spe2');
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
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(u); 
    SPE2overrideCloneSPETemplate speoverride = new SPE2overrideCloneSPETemplate(sc);
    speoverride.populateCloneSPETemplate();  
    PageReference newScoringTempPage =  Page.SPE_NewSPETemplate;
    Test.setCurrentPage(newScoringTempPage); 
    ApexPages.currentPage().getParameters().put('speTempId','speTempId');
    ApexPages.currentPage().getParameters().put('isClone','isClone');
    }
    Test.StopTest();
  }
  
  static testMethod void createSPE2overrideCloneSPETemplatePositive2(){
    
    Test.StartTest();
    Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
    User u = new User(Alias = 'library', Email='libraryuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Test', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testinguser@testinguser.com.spe2');
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
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(u); 
    SPE2overrideCloneSPETemplate speoverride = new SPE2overrideCloneSPETemplate(sc);
    speoverride.populateCloneSPETemplate();  
    PageReference newScoringTempPage =  Page.SPE2_NewSPETemplate;
    Test.setCurrentPage(newScoringTempPage); 
    ApexPages.currentPage().getParameters().put('speTempId','speTempId');
    ApexPages.currentPage().getParameters().put('isClone','isClone');
    }
    Test.StopTest();
  }
  
  
  static testMethod void createSPE2overrideCloneSPETemplatePositive3(){
    
    Test.StartTest();
    Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
    User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
    insert u;      
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(u); 
    SPE2overrideCloneSPETemplate speoverride = new SPE2overrideCloneSPETemplate();
    speoverride.populateCloneSPETemplate();  
   /* PageReference newSPETempPage =  Page.SPE2_NewSPETemplate;
    Test.setCurrentPage(newSPETempPage); */
    
    Test.StopTest();
  }
}