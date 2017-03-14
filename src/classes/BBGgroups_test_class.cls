@isTest
private class BBGgroups_test_class {

    static testmethod void BBGgroups_trigger(){
    
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
            
            Business_Activity__c ba = new Business_Activity__c();
            ba.name = 'Test Business Activity';
            ba.Business_Function__c = 'Marketing & communications';
            ba.Value_Stream__c = 'Features';
            insert ba;            
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
            project.Project_Completion_Date_Target__c = Date.Today();
            project.Project_Completion_Date_Forecast__c = Date.Today();
            project.Project_Description_Detailed__c = 'asdasd';
            project.Project_Name_Succinct__c = 'Test Project1';
            project.Portfolio_BU__c = 'Human Resources';
            project.Project_BL__c = 'Nokia EDU';
            project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            project.CEMT_ID__c = 'sda';
            project.Primary_QLT_Function__c = 'CO';
            project.Last_Review_Type__c = 'Final';
            project.Project_Lead__c = con.id;
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'In Progress';
            project.Finance_Approver__c = con.Id;
            project.Business_Activity_Mapping__c = ba.id;
            insert project;
            
            test.startTest();
            Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
            insert ts;

            Project_Redeployed__c projredp = new Project_Redeployed__c(Benefitting_Business_Grp_Functional_Grp__c = 'Human Resources',
                                                Benefitting_Business_Unit__c = 'Nokia EDU',
                                                project__C = project.Id);
            //Project_Redeployed__c projredp = new Project_Redeployed__c(Name = 'a1C17000001RjzZ',project__C = 'a183B000000DNM2QAO');
            insert projredp;
            test.stopTest(); 
        
        }
               
    }
}