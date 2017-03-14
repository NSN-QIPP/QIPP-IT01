@isTest (seeAllData=false)
private class SPE2overrideSPETemplateTest{
   static testMethod void createSPE2overrideSPETemplatePositive(){
    
    Test.StartTest();
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
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(u); 
    SPE2overrideSPETemplate speoverride = new SPE2overrideSPETemplate(sc);
    speoverride.populateSPETemplate();  
    PageReference newSPETempPage =  Page.SPE2_NewSPETemplate;
    Test.setCurrentPage(newSPETempPage); 
    }
    Test.StopTest();
  }
  static testMethod void createSPE2overrideSPETemplatePositive2(){
    Test.StartTest();
    
    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
    User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe1');
    insert u;
    Group g = new Group(Name = 'SPE2.0 User Group',
                    DeveloperName = 'unit_test_group',
                    Type = 'Regular');
    insert g;  
    GroupMember gm= new GroupMember();
    gm.GroupId =g.id;
    gm.UserOrGroupId = u.id;  
    insert gm; 
    System.runAs(u){     
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(u); 
    SPE2overrideSPETemplate speoverride = new SPE2overrideSPETemplate(sc);
    speoverride.populateSPETemplate(); 
    PageReference existingSPETempPage =  Page.SPE_NewSPETemplate;
    Test.setCurrentPage(existingSPETempPage);
    }
    Test.StopTest();
  } 
   static testMethod void createSPE2overrideSPETemplatePositive3(){
    
    Test.StartTest();
    Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
    User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
    insert u;      
   Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(u); 
    SPE2overrideSPETemplate speoverride = new SPE2overrideSPETemplate();
    speoverride.populateSPETemplate();  
   /* PageReference newSPETempPage =  Page.SPE2_NewSPETemplate;
    Test.setCurrentPage(newSPETempPage); */
    
    Test.StopTest();
  } 
}