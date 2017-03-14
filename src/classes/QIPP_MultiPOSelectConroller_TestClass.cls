@isTest
private class QIPP_MultiPOSelectConroller_TestClass {
    public testMethod static void MPOTest(){
    List<QIPP_Project__c> proj;
    QIPP_Contacts__c qCont;
    QIPP_Contacts__c qCont2;    
    User u;
	User u2;
    string msg;
        Portfolios_Owner__c qport;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
          System.runAs ( thisUser ) {
          Profile p = [SELECT Id,UserLicense.Name FROM Profile WHERE Name='System Administrator' and UserLicense.Name != '']; 
          UserRole r = [SELECT Id FROM UserRole WHERE Name='QIPP Portfolio Owner'];  
          u = new User();
          u.Alias = 'standt';
          u.Email='manish@manish.com';
          u.EmailEncodingKey='UTF-8';
          u.LastName='Testing';
          u.LanguageLocaleKey='en_US';
          u.LocaleSidKey='en_US';
          u.ProfileId = p.Id;
          u.UserRoleId = r.Id;
          u.TimeZoneSidKey='America/Los_Angeles'; 
          u.UserName='standarduser_manish@testorg.com';
          u.IsActive=true;    
          insert u; 
              
        
          u2 = new User();
          u2.Alias = 'standt1';
          u2.Email='manish21@manish.com';
          u2.EmailEncodingKey='UTF-8';
          u2.LastName='Testing2';
          u2.LanguageLocaleKey='en_US';
          u2.LocaleSidKey='en_US';
          u2.ProfileId = p.Id;
          u2.UserRoleId = r.Id;
          u2.TimeZoneSidKey='America/Los_Angeles'; 
          u2.UserName='standarduser21_manish@testorg.com';
          u2.IsActive=true;    
          insert u2;      
    		
            User u1 = [Select id, User_License_Type__c from User where id = :u.id];
    
            qCont = new QIPP_Contacts__c();
            qCont.Name = 'testManish';
            qCont.Email__c = 'manish@manish.com';
            qCont.Contact_State__c = 'Active';
            qCont.Contact_BU__c = 'CFO Functions';
            qCont.Contact_BL__c = 'test7894656';
            qCont.Contact_L4_Org__c = 'testmanish1234';
            qCont.Belt_Certification__c = 'Nokia-Black Belt';
            qCont.User_License__c = u.Id;
            qCont.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
            
            qCont2 = new QIPP_Contacts__c();
            qCont2.Name = 'testManish21';
            qCont2.Email__c = 'manish21@manish.com';
            qCont2.Contact_State__c = 'Active';
            qCont2.Contact_BU__c = 'CFO Functions';
            qCont2.Contact_BL__c = 'test7894656';
            qCont2.Contact_L4_Org__c = 'testmanish1234';
            qCont2.Belt_Certification__c = 'Nokia-Black Belt';
            qCont2.User_License__c = u2.Id;
            qCont2.CoPQ_Role_1__c = 'Business Unit Master Black Belt';

    }
      Portfolios_Owner__c qPortowner = new Portfolios_Owner__c();
	  system.runas(u){
      insert qCont;
      insert qCont2;   
      system.debug('qCont  :'+qCont);    
        QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
        qPortfolio.Name = 'testManish';
        //qPortfolio.Portfolio_Owner__c = qCont.Id;
        qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
        qPortfolio.Portfolio_Status__c = 'Active';
        qPortfolio.DMAIC_DMADV__c = true;
        insert qPortfolio;
     system.debug('qPortfolio  :'+qPortfolio);      
    Portfolios_Owner__c POwnerIns = new Portfolios_Owner__c();
    POwnerIns.Name = 'testManish';
    POwnerIns.Email__c = 'manish@manish.com';
    POwnerIns.QIPP_Contact__c = qCont.id;
    POwnerIns.QIPP_Portfolio__c = qPortfolio.id;
    POwnerIns.DMAIC_DMADV__c = true;
    insert POwnerIns;
    
          
    system.debug('POwnerIns  :'+POwnerIns);       
         ApexPages.StandardController sc = new ApexPages.StandardController(POwnerIns);
         System.currentPageReference().getParameters().put('theId', POwnerIns.id);
         QIPP_MultiPOSelectConroller Powner = new QIPP_MultiPOSelectConroller(sc);
         Test.setCurrentPageReference(new PageReference('Page.qipp_multiposelectpage')); 
          System.currentPageReference().getParameters().put('poId', qPortfolio.id);
          
         QIPP_MultiPOSelectConroller Powner1 = new QIPP_MultiPOSelectConroller();
         Powner1.powner = POwnerIns;
         Powner1.getPortfolioOwnerlist();
         Powner1.MPOSelect[0].Lean_including_Kaizen__c = true; 
         Powner1.addPO();
         Powner1.MPOSelect[0].Lean_including_Kaizen__c = true;  
         Powner1.updatePo(); 
    	}
	}
}