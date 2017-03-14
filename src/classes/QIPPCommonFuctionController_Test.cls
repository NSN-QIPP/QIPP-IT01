@isTest
public class QIPPCommonFuctionController_Test{

    public testMethod static void testCase1(){

        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
            Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Project Lead%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;
                
            QIPP_Contacts__c con = new QIPP_Contacts__c();
            con.Name = 'Abhishek';
            con.Email__c = 'a@a.a';
            con.Contact_State__c = 'Active';
            con.NSN_ID_Text__c = '12234345';
            con.Belt_Certification__c='Nokia-Green Belt';
            con.Contact_BU__c='CFOO346';
            con.Contact_BL__c='CFOO3';
            con.Contact_L4_Org__c='CFOO5';
            con.User_License__c = DummyUser.id;
            con.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con.CoPQ_Role_2__c='BL Transformation Lead';
            con.CoPQ_Role_3__c='Measure Creator';
            con.CoPQ_Role_4__c='Business Owner Delegate';
            insert con;
                    
            QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
            portfolio.Name = 'Test Portfolio1';
            portfolio.Portfolio_Owner__c = con.id;
            portfolio.ownerId = DummyUser.Id;
            portfolio.CDT_Lead__c = con.id;
            portfolio.CPVi_Composite__c = 25.0;
            portfolio.CPVi_Past__c = 29.0;
            portfolio.CPVi_Future__c = 55.0; 
            portfolio.CPV_Trend__c  = 'Up';
            portfolio.Portfolio_Status__c = 'Active';
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            QIPPCommonFuctionController obj = new QIPPCommonFuctionController();
            obj.getObjectAllFieldsSOQL('QIPP_Project__c','Name = abc');
            obj.getObjectAllFieldsSOQL('QIPP_Project','Name = abc');
            
            obj.getFieldPickListToSelectOptionList('QIPP_Project__c','Project_State__c',true);
            obj.getFieldPickListToSelectOptionList('QIPP_Project','Project_State__c',true);
            
            obj.getProjectStateValues('QIPP Project Lead',true);
            
            obj.getProjectPortfolioValues('A3');
            obj.getProjectPortfolioFieldName('8D');
            obj.getProjectPortfolioFieldName('CIF');
            obj.getProjectPortfolioFieldName('DI (CoPQ)');
            obj.getProjectPortfolioFieldName('DMAIC');
            obj.getProjectPortfolioFieldName('Lean (including Kaizen)');
            obj.getProjectPortfolioFieldName('Other');
            obj.getProjectPortfolioFieldName('RCA/EDA');
            
            sObject prj = new QIPP_Project__c();
            Set<String> objMandatoryFields = new Set<String>();
            objMandatoryFields.add('Project_Name_Succinct__c');
            Set<String> excludeMandatoryFields = new Set<String>();
            objMandatoryFields.add('Project_State__c');
            obj.validateFieldMandatory(prj,objMandatoryFields,excludeMandatoryFields);
            
            obj.getObjectRecordTypeIdByName('QIPP_Project__c','Methodology: CIF');
            
            obj.validContactBG(con.id,'Finance Approver');
            obj.validContactBG(con.id,'Project Mentor');
            obj.validContactBG(con.id,'Improvement Owner');
            obj.validContactBG(con.id,'L6S Belt Assigned');                                    
        }
    }
}