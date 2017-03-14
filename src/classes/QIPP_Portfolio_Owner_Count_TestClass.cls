@isTest
private class QIPP_Portfolio_Owner_Count_TestClass {
    public testMethod static void POwnerCountTest(){
	List<QIPP_Project__c> proj;
    QIPP_Contacts__c qCont;    
    User u;
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
          }       
	Portfolios_Owner__c qPortowner = new Portfolios_Owner__c();
	  system.runas(u){
      insert qCont;
      //insert qCont2;   
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
          
        ApexPages.StandardController sc = new ApexPages.StandardController(qPortfolio);
        System.currentPageReference().getParameters().put('rec', qPortfolio.id);
        QIPP_Portfolio_Owner_Count ownercount = new QIPP_Portfolio_Owner_Count(sc);  
		}
    }
}