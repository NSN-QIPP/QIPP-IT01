@isTest
private with sharing class QIPPProjectViewRedirectcntr_testclass{

/*private QIPP_Project_Edit_Redirect_cntr(ApexPages.StandardController controller){

}*/

    private static testmethod void test(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
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
            qProj.Project_Document__c = 'google.com';
            //qProj.CreatedById
            //qProj.CreatedDate
            //qProj.LastModifiedById
            //qProj.LastModifiedDate
            
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            
            
            PageReference pgref2 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref2);
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
            /*
            QIPP_Project__c qProj2 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj1.Id];
            qProj2.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Define').getRecordTypeId();
            update qProj2;
            
            ApexPages.StandardController stdCon1 = new ApexPages.StandardController(qProj2);
            QIPP_Project_View_Redirect_cntr qProjEditTest1 = new QIPP_Project_View_Redirect_cntr(stdCon1);
            
            PageReference pgref3 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref3);
            ApexPages.currentPage().getParameters().put('Id', qProj2.Id);
            
            qProjEditTest1.refererStr = 'test';
            qProjEditTest1.Redirect();
            
            QIPP_Project__c qProj3 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj2.Id];
            qProj3.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After DMAIC Improve').getRecordTypeId();
            update qProj3;
            
            ApexPages.StandardController stdCon2 = new ApexPages.StandardController(qProj3);
            QIPP_Project_View_Redirect_cntr qProjEditTest2 = new QIPP_Project_View_Redirect_cntr(stdCon2);
            
            PageReference pgref4 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref4);
            ApexPages.currentPage().getParameters().put('Id', qProj3.Id);
            
            qProjEditTest2.refererStr = 'test';
            qProjEditTest2.Redirect();
            
            QIPP_Project__c qProj4 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj3.Id];
            qProj4.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After DMAIC Measure').getRecordTypeId();
            update qProj4;
            
            ApexPages.StandardController stdCon3 = new ApexPages.StandardController(qProj4);
            QIPP_Project_View_Redirect_cntr qProjEditTest3 = new QIPP_Project_View_Redirect_cntr(stdCon3);
            
            PageReference pgref5 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref5);
            ApexPages.currentPage().getParameters().put('Id', qProj4.Id);
            
            qProjEditTest3.refererStr = 'test';
            qProjEditTest3.Redirect();
            
            
            QIPP_Project__c qProj5 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj4.Id];
            qProj5.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Analyze').getRecordTypeId();
            update qProj5;
            
            ApexPages.StandardController stdCon4 = new ApexPages.StandardController(qProj5);
            QIPP_Project_View_Redirect_cntr qProjEditTest4 = new QIPP_Project_View_Redirect_cntr(stdCon4);
            
            PageReference pgref6 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref6);
            ApexPages.currentPage().getParameters().put('Id', qProj5.Id);
            
            qProjEditTest4.refererStr = 'test';
            qProjEditTest4.Redirect();
            
            
            QIPP_Project__c qProj6 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj5.Id];
            qProj6.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Control / Verify').getRecordTypeId();
            update qProj6;
            
            ApexPages.StandardController stdCon5 = new ApexPages.StandardController(qProj6);
            QIPP_Project_View_Redirect_cntr qProjEditTest5 = new QIPP_Project_View_Redirect_cntr(stdCon5);
            
            PageReference pgref7 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref7);
            ApexPages.currentPage().getParameters().put('Id', qProj6.Id);
            
            qProjEditTest5.refererStr = 'test';
            qProjEditTest5.Redirect();
            
            
            QIPP_Project__c qProj7 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj6.Id];
            qProj7.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After DMAIC Project Initiation').getRecordTypeId();
            update qProj7;
            
            ApexPages.StandardController stdCon6 = new ApexPages.StandardController(qProj7);
            QIPP_Project_View_Redirect_cntr qProjEditTest6 = new QIPP_Project_View_Redirect_cntr(stdCon6);
            
            PageReference pgref8 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref8);
            ApexPages.currentPage().getParameters().put('Id', qProj7.Id);
            
            qProjEditTest6.refererStr = 'test';
            qProjEditTest6.Redirect();
            
            
            QIPP_Project__c qProj8 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj7.Id];
            qProj8.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
            update qProj8;
            
            ApexPages.StandardController stdCon7 = new ApexPages.StandardController(qProj8);
            QIPP_Project_View_Redirect_cntr qProjEditTest7 = new QIPP_Project_View_Redirect_cntr(stdCon7);
            
            PageReference pgref9 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref9);
            ApexPages.currentPage().getParameters().put('Id', qProj8.Id);
            
            qProjEditTest7.refererStr = 'test';
            qProjEditTest7.Redirect();
            
            
            QIPP_Portfolio__c qPortfolio1 = [Select id,name,A3__c,DMAIC_DMADV__c from QIPP_Portfolio__c where id = :qPortfolio.Id];
            qPortfolio1.A3__c = true;
            //qPortfolio1.DMAIC_DMADV__c = false;
            update qPortfolio1; 
            
            QIPP_Project__c qProj9 = [select id,RecordTypeId from QIPP_Project__c where id =:qProj8.Id];
            qProj9.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
            update qProj9;
            
            ApexPages.StandardController stdCon8 = new ApexPages.StandardController(qProj9);
            QIPP_Project_View_Redirect_cntr qProjEditTest8 = new QIPP_Project_View_Redirect_cntr(stdCon8);
            
            PageReference pgref10 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref10);
            ApexPages.currentPage().getParameters().put('Id', qProj9.Id);
            
            qProjEditTest8.refererStr = 'test';
            qProjEditTest8.Redirect();
            
            QIPP_Project__c qProj10 = new QIPP_Project__c();
            
            
            ApexPages.StandardController stdCon9 = new ApexPages.StandardController(qProj10);
            QIPP_Project_View_Redirect_cntr qProjEditTest9 = new QIPP_Project_View_Redirect_cntr(stdCon9);
            
            PageReference pgref11 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref11);
            ApexPages.currentPage().getParameters().put('Id', qProj10.Id);
            
            qProjEditTest9.refererStr = 'test';
            qProjEditTest9.Redirect();
        */
        }
    }
    
    private static testmethod void test1(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
       
        }
        system.runas(u){
        
            system.debug('INSERTTTTT'+qCont);
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            qPortfolio.X8D__c = true;
            qPortfolio.DI_CoPQ__c = true;
            qPortfolio.A3__c = true;
            qPortfolio.Other__c = true;
            qPortfolio.RCA_EDA__c = true;
            qPortfolio.CIF__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
            qProj.CEMT_ID__c = 'testAmol';
            qProj.Project_Name_Succinct__c = 'testAmol123';
            qProj.Portfolio_BU__c = 'Human Resources';
            qProj.Project_Lead__c = qCont.Id;
            qProj.Project_BL__c = 'Nokia EDU';
            qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            qProj.Portfolio_Name__c = qPortfolio.Id;
            qProj.Project_State__c = 'In Progress';
            qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
            qProj.Project_Type__c = 'CIF';
           
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
                   
        }
    }    
    
    private static testmethod void test2(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
       
        }
        system.runas(u){
        
            system.debug('INSERTTTTT'+qCont);
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            qPortfolio.X8D__c = true;
            qPortfolio.DI_CoPQ__c = true;
            qPortfolio.A3__c = true;
            qPortfolio.Other__c = true;
            qPortfolio.RCA_EDA__c = true;
            qPortfolio.CIF__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: 8D').getRecordTypeId();
            qProj.CEMT_ID__c = 'testAmol';
            qProj.Project_Name_Succinct__c = 'testAmol123';
            qProj.Portfolio_BU__c = 'Human Resources';
            qProj.Project_Lead__c = qCont.Id;
            qProj.Project_BL__c = 'Nokia EDU';
            qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            qProj.Portfolio_Name__c = qPortfolio.Id;
            qProj.Project_State__c = 'In Progress';
            qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
            qProj.Project_Type__c = '8D';
           
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
                   
        }
    }   
    
    private static testmethod void test3(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
       
        }
        system.runas(u){
        
            system.debug('INSERTTTTT'+qCont);
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            qPortfolio.X8D__c = true;
            qPortfolio.DI_CoPQ__c = true;
            qPortfolio.A3__c = true;
            qPortfolio.Other__c = true;
            qPortfolio.RCA_EDA__c = true;
            qPortfolio.CIF__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
            qProj.CEMT_ID__c = 'testAmol';
            qProj.Project_Name_Succinct__c = 'testAmol123';
            qProj.Portfolio_BU__c = 'Human Resources';
            qProj.Project_Lead__c = qCont.Id;
            qProj.Project_BL__c = 'Nokia EDU';
            qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            qProj.Portfolio_Name__c = qPortfolio.Id;
            qProj.Project_State__c = 'In Progress';
            qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
            qProj.Project_Type__c = 'A3';
           
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
                   
        }
    }   
    
    private static testmethod void test4(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
       
        }
        system.runas(u){
        
            system.debug('INSERTTTTT'+qCont);
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            qPortfolio.X8D__c = true;
            qPortfolio.DI_CoPQ__c = true;
            qPortfolio.A3__c = true;
            qPortfolio.Other__c = true;
            qPortfolio.RCA_EDA__c = true;
            qPortfolio.CIF__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: RCA/EDA').getRecordTypeId();
            qProj.CEMT_ID__c = 'testAmol';
            qProj.Project_Name_Succinct__c = 'testAmol123';
            qProj.Portfolio_BU__c = 'Human Resources';
            qProj.Project_Lead__c = qCont.Id;
            qProj.Project_BL__c = 'Nokia EDU';
            qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            qProj.Portfolio_Name__c = qPortfolio.Id;
            qProj.Project_State__c = 'In Progress';
            qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
            qProj.Project_Type__c = 'RCA/EDA';
           
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
                   
        }
    }   
    
    private static testmethod void test5(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
       
        }
        system.runas(u){
        
            system.debug('INSERTTTTT'+qCont);
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            qPortfolio.X8D__c = true;
            qPortfolio.DI_CoPQ__c = true;
            qPortfolio.A3__c = true;
            qPortfolio.Other__c = true;
            qPortfolio.RCA_EDA__c = true;
            qPortfolio.CIF__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: Other Methodology').getRecordTypeId();
            qProj.CEMT_ID__c = 'testAmol';
            qProj.Project_Name_Succinct__c = 'testAmol123';
            qProj.Portfolio_BU__c = 'Human Resources';
            qProj.Project_Lead__c = qCont.Id;
            qProj.Project_BL__c = 'Nokia EDU';
            qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            qProj.Portfolio_Name__c = qPortfolio.Id;
            qProj.Project_State__c = 'In Progress';
            qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
            qProj.Project_Type__c = 'Other Methodology';
           
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
                   
        }
    }       
    
    private static testmethod void test6(){
    
        QIPP_Contacts__c qCont;
              User u;
        
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
        
        insert u;
        
        
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
       
        }
        system.runas(u){
        
            system.debug('INSERTTTTT'+qCont);
            insert qCont;
            
            
            
            QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
            
            qPortfolio.Name = 'testAmol';
            qPortfolio.Portfolio_Owner__c = qCont.Id;
            qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
            qPortfolio.Portfolio_Status__c = 'Active';
            qPortfolio.DMAIC_DMADV__c = true;
            qPortfolio.X8D__c = true;
            qPortfolio.DI_CoPQ__c = true;
            qPortfolio.A3__c = true;
            qPortfolio.Other__c = true;
            qPortfolio.RCA_EDA__c = true;
            qPortfolio.CIF__c = true;
            
            insert qPortfolio;
            
            QIPP_Project__c qProj = new QIPP_Project__c();
            qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DI Logic').getRecordTypeId();
            qProj.CEMT_ID__c = 'testAmol';
            qProj.Project_Name_Succinct__c = 'testAmol123';
            qProj.Portfolio_BU__c = 'Human Resources';
            qProj.Project_Lead__c = qCont.Id;
            qProj.Project_BL__c = 'Nokia EDU';
            qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            qProj.Portfolio_Name__c = qPortfolio.Id;
            qProj.Project_State__c = 'In Progress';
            qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
            qProj.Project_Type__c = 'DI Logic';
           
            insert qProj;
            
             QIPP_Benefit__c benifit = new QIPP_Benefit__c();
            benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
            benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
            benifit.Benefit_Type__c = 'Projected Revenue';
            benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
            benifit.Project_ID__c = qProj.id;
            insert benifit;
            
            ApexPages.currentPage().getParameters().put('Referer', 'test');
            
            QIPP_Project__c qProj1 = [select id,name from QIPP_Project__c where id =:qProj.Id];
            
            ApexPages.StandardController stdCon = new ApexPages.StandardController(qProj1);
            QIPP_Project_View_Redirect_cntr qProjEditTest = new QIPP_Project_View_Redirect_cntr(stdCon);
            
            PageReference pgref1 = Page.QIPP_Project_Edit_Redirect;
            Test.setCurrentPage(pgref1);
            ApexPages.currentPage().getParameters().put('Id', qProj1.Id);
            
            qProjEditTest.refererStr = 'test';
            qProjEditTest.Redirect();
            ApexPages.currentPage().getParameters().put('id', benifit.id);
            qProjEditTest.BenfitRedirect();
                   
        }
    } 
    
}