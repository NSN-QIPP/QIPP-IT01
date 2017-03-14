@isTest
private with sharing class UnsubscripeProject_TestClass{
    private static testmethod void test(){
      QIPP_Contacts__c qCont;
      User u;
      string msg;
    
      User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs ( thisUser ) {
          Profile p = [SELECT Id,UserLicense.Name FROM Profile WHERE Name='System Administrator' and UserLicense.Name != '']; 
          UserRole r = [SELECT Id FROM UserRole WHERE Name='QIPP Project Lead'];  
          u = new User();
          
          u.Alias = 'standt';
          u.Email='amol@amol.com';
          u.EmailEncodingKey='UTF-8';
          u.LastName='Testing';
          u.LanguageLocaleKey='en_US';
          u.LocaleSidKey='en_US';
          u.ProfileId = p.Id;
          u.UserRoleId = r.Id;
          u.TimeZoneSidKey='America/Los_Angeles'; 
          u.UserName='standarduser_amol@testorg.com';
    if (Schema.SObjectType.User.isCreateable()){
        insert u;
    }


    User u1 = [Select id, User_License_Type__c from User where id = :u.id];

        qCont = new QIPP_Contacts__c();
        qCont.Name = 'test';
        qCont.Email__c = 'amol@amol.com';
        qCont.Contact_State__c = 'Active';
        qCont.Contact_BU__c = 'CFOO';
        qCont.Contact_BL__c = 'test7894656';
        qCont.Contact_L4_Org__c = 'testAmol1234';
        qCont.Belt_Certification__c = 'Nokia-Black Belt';
        qCont.User_License__c = u.Id;
        qCont.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        qCont.CoPQ_Role_2__c ='Finance Approver';
        qCont.CoPQ_Role_3__c ='Finance Approver Delegate';
        qCont.CoPQ_Role_4__c ='Measure Creator';
    
    
      system.debug('@@@@@@@@@@@@'+p);
      system.debug('@@@@@@@@@@@@'+u.User_License_Type__c);
      system.debug('@@@@@@@@@@@@'+u1);
      system.debug('#############'+qCont);
    
      }
      system.runas(u){
    
        system.debug('INSERTTTTT'+qCont);
        if (Schema.SObjectType.QIPP_Contacts__c.isCreateable()){
          insert qCont;
        }
    
      }
    
      QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
    
      qPortfolio.Name = 'testAmol';
      qPortfolio.Portfolio_Owner__c = qCont.Id;
      qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
      qPortfolio.Portfolio_Status__c = 'Active';
      qPortfolio.DMAIC_DMADV__c = true;
      if (Schema.SObjectType.QIPP_Portfolio__c.isCreateable()){
        insert qPortfolio;
      }
      Business_Activity__c bam = new Business_Activity__c();
        bam.name = 'Test Business Activity';
        bam.Business_Function__c = 'Marketing & communications';
        bam.Value_Stream__c = 'Features';
        insert bam;
       
        
      
      QIPP_Project__c qProj = new QIPP_Project__c();
      
      //qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
      qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Define').getRecordTypeId();

      qProj.CEMT_ID__c = 'testAmol';
      qProj.Project_Name_Succinct__c = 'testAmol123';
      qProj.Portfolio_BU__c = 'Human Resources';
      qProj.Project_Lead__c = qCont.Id;
      qProj.Project_BL__c = 'Nokia EDU';
      qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
      qProj.Portfolio_Name__c = qPortfolio.Id;
      qProj.Project_State__c = 'In Progress';
      qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
      //qProj.Project_Lead_BU__c = qCont.Contact_BU__c;
      //qProj.Project_Lead_BL_Level_3_Org__c = qCont.Contact_BL__c;
      //qProj.Project_Lead_BL_Level_4_Org__c = qCont.Contact_L4_Org__c;
      qProj.Belt_Candidate_Mentor__c = qCont.Id;
      qProj.Belt_Project_Sponsor__c = qCont.Id;
      qProj.Belt_Project_Type__c = 'GB Certification Project';
      qProj.Belt_Project_Champion__c = qCont.Id;
      qProj.Finance_Approver__c = qCont.Id;
      qProj.Mentor_Certificate__c = 'Nokia-Green Belt';
      qProj.Business_Unit_Master_Black_Belt__c = qCont.Id;
      qProj.Belt_Assigned__c = qCont.Id;
      qProj.Belt_Project_Phase__c = 'Define';
      qProj.DMAIC_Define__c = date.today();
      qProj.Define_Date_Forecast__c = date.today();
      qProj.Define_Status__c = 'In Progress';
      qProj.DMAIC_Measure__c = date.today();
      qProj.Measure_Date_Forecast__c = date.today();
      qProj.Measure_Status__c = 'In Progress';
      qProj.DMAIC_Analyze__c = date.today();
      qProj.Analyze_Date_Forecast__c = date.today();
      qProj.Analyze_Status__c = 'In Progress';
      qProj.DMAIC_Improve__c = date.today();
      qProj.Improve_Design_Date_Forecast__c = date.today();
      qProj.Improve_Status__c = 'In Progress';
      qProj.DMAIC_Control__c = date.today();
      qProj.Control_Verify_Date_Forecast__c = date.today();
      qProj.Control_Status__c = 'In Progress';
      qProj.Planned_Start_Date__c = date.today();
      qProj.Project_Completion_Date_Target__c = date.today();
      qProj.Project_Type__c = 'DMAIC';
      qProj.Project_Start_Date__c = date.today();
      qProj.Project_Completion_Date_Forecast__c = date.today();
      qProj.MO_Site__c = 'Beijing';
      qProj.Project_Created_Date__c = date.today();
      qProj.Project_Completion_Date_Actual__c = date.today();
      qProj.Quality_Award_Project__c = 'Yes';
      qProj.Project_Flex_Field_1__c = 'testAmol';
      qProj.DI_State__c = 'DI 2 - Concept existing, business case analyzed';
      qProj.Permission_to_use_Belt_Info__c = 'Yes';
      qProj.Progress_To_Date__c = 'testAMOLLLLLLLLLL';
      qProj.Next_Steps__c = 'testAMOLLLLLLLLLLLLLLLLLLLLLL';
      qProj.Project_Member1__c = qCont.Id;
      qProj.Project_Member2__c = qCont.Id;
      qProj.Project_Document__c = '';
      qProj.Business_Activity_Mapping__c = bam.id; 
      //qProj.CreatedById
      //qProj.CreatedDate
      //qProj.LastModifiedById
      //qProj.LastModifiedDate
      if (Schema.SObjectType.QIPP_Project__c.isCreateable()){
        insert qProj;
      }
      
        test.startTest();
        ApexPages.currentPage().getParameters().put('ObjectId', qProj.Id);
        UnsubscripeProject usub = new UnsubscripeProject();
        usub.unsubscripePage();
        test.stopTest();
    }
}