@istest
public class QIPP_Project_Record_Types_Test{
    static testmethod void Record_Types_Page_Test1(){  
        User DummyUser = new User();
        DummyUser.LastName = 'Vennapusa';
        DummyUser.FirstName = 'srikanth';
        DummyUser.Alias = 'srvvv';
        DummyUser.Email = 'venkat.maddipati@igate.com';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.Contact_BU__c = 'CFOO';
        con.Contact_BL__c = 'test7894656';
        con.Contact_L4_Org__c = 'test878234';
        con.Belt_Certification__c = 'Nokia-Black Belt';
        con.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        con.CoPQ_Role_2__c ='Finance Approver';
        con.CoPQ_Role_3__c ='Finance Approver Delegate';
        con.CoPQ_Role_4__c ='Measure Creator';
        con.User_License__c = DummyUser.Id;
        con.NSN_ID_Text__c = '12345';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;      
        portfolio.CDT__c = true;
        portfolio.X8D__c = true;
        portfolio.DI_CoPQ__c = true;
        portfolio.A3__c = true;
        portfolio.Other__c = true;
        portfolio.RCA_EDA__c = true;
        portfolio.CIF__c = true;
        insert portfolio;
        
        QIPP_Project__c qProj = new QIPP_Project__c();
        qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
        qProj.CEMT_ID__c = 'testAmol';
        qProj.Project_Name_Succinct__c = 'testAmol123';
        qProj.Portfolio_BU__c = 'Human Resources';
        qProj.Project_Lead__c = con.Id;
        qProj.Project_BL__c = 'Nokia EDU';
        qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        qProj.Portfolio_Name__c = portfolio.Id;
        qProj.Project_State__c = 'In Progress';
        qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
        //qProj.Project_Lead_BU__c = con.Contact_BU__c;
        //qProj.Project_Lead_BL_Level_3_Org__c = con.Contact_BL__c;
        //qProj.Project_Lead_BL_Level_4_Org__c = con.Contact_L4_Org__c;
        qProj.Belt_Candidate_Mentor__c = con.Id;
        qProj.Belt_Project_Sponsor__c = con.Id;
        qProj.Belt_Project_Type__c = 'GB Certification Project';
        qProj.Belt_Project_Champion__c = con.Id;
        qProj.Finance_Approver__c = con.Id;
        qProj.Mentor_Certificate__c = 'Nokia-Green Belt';
        qProj.Business_Unit_Master_Black_Belt__c = con.Id;
        qProj.Belt_Assigned__c = con.Id;
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
        qProj.Project_Member1__c = con.Id;
        qProj.Project_Member2__c = con.Id;
        qProj.Project_Document__c = 'google.com';
        
        
        insert qProj;
        RecordType rt = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj.RecordTypeId];
        
        QIPP_Project__c qProj1 = [Select id,recordtypeid from QIPP_Project__c where id = :qProj.id];
        qProj1.recordtypeid = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
        update qProj1;


        RecordType rt1 = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj1.RecordTypeId];
        
        Test.startTest();         
            System.runAs(DummyUser){ 
                PageReference tpageRef = Page.QIPP_Project_Record_Types_Page;
                Test.setCurrentPage(tpageRef);
                ApexPages.currentPage().getParameters().put('Portfolioid', portfolio.Id);
                ApexPages.currentPage().getHeaders().put('Referer', 'testreference');
                ApexPages.StandardController stdcontroller = new ApexPages.StandardController(qProj);
                QIPP_Project_Record_Types_Page_cntr RYController= new QIPP_Project_Record_Types_Page_cntr(stdcontroller);
                RYController.RecordTypeID = rt.Name;
                RYController.Createpage();
                //RYController.Cancle();
            }
            
            System.runAs(DummyUser){ 
                PageReference tpageRef1 = Page.QIPP_Project_Record_Types_Page;
                Test.setCurrentPage(tpageRef1);
                //ApexPages.currentPage().getParameters().put('Portfolioid', 'null');
                ApexPages.currentPage().getHeaders().put('Referer', 'testreference');
                ApexPages.StandardController stdcontroller1 = new ApexPages.StandardController(qProj1);
                QIPP_Project_Record_Types_Page_cntr RYController1 = new QIPP_Project_Record_Types_Page_cntr(stdcontroller1);
                RYController1.RecordTypeID = rt1.Name;
                RYController1.Createpage();
                //RYController1.Cancle();
            }
        Test.stopTest();        
    }
    
    static testmethod void Record_Types_Page_Test2(){  
        User DummyUser = new User();
        DummyUser.LastName = 'Vennapusa';
        DummyUser.FirstName = 'srikanth';
        DummyUser.Alias = 'srvvv';
        DummyUser.Email = 'venkat.maddipati@igate.com';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.Contact_BU__c = 'CFOO';
        con.Contact_BL__c = 'test7894656';
        con.Contact_L4_Org__c = 'test878234';
        con.Belt_Certification__c = 'Nokia-Black Belt';
        con.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        con.CoPQ_Role_2__c ='Finance Approver';
        con.CoPQ_Role_3__c ='Finance Approver Delegate';
        con.CoPQ_Role_4__c ='Measure Creator';
        con.User_License__c = DummyUser.Id;
        con.NSN_ID_Text__c = '12345';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;      
        portfolio.CDT__c = true;
        portfolio.X8D__c = true;
        portfolio.DI_CoPQ__c = true;
        portfolio.A3__c = true;
        portfolio.Other__c = true;
        portfolio.RCA_EDA__c = true;
        portfolio.CIF__c = true;
        insert portfolio;
        
        QIPP_Project__c qProj = new QIPP_Project__c();
        qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: RCA/EDA').getRecordTypeId();
        qProj.CEMT_ID__c = 'testAmol';
        qProj.Project_Name_Succinct__c = 'testAmol123';
        qProj.Portfolio_BU__c = 'Human Resources';
        qProj.Project_Lead__c = con.Id;
        qProj.Project_BL__c = 'Nokia EDU';
        qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        qProj.Portfolio_Name__c = portfolio.Id;
        qProj.Project_State__c = 'In Progress';
        qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
        qProj.Project_Type__c = 'RCA/EDA';

        insert qProj;
        RecordType rt = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj.RecordTypeId];
        
        QIPP_Project__c qProj1 = [Select id,recordtypeid from QIPP_Project__c where id = :qProj.id];
        qProj1.recordtypeid = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: RCA/EDA').getRecordTypeId();
        update qProj1;


        RecordType rt1 = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj1.RecordTypeId];
        
        Test.startTest();         
            System.runAs(DummyUser){ 
                PageReference tpageRef = Page.QIPP_Project_Record_Types_Page;
                Test.setCurrentPage(tpageRef);
                ApexPages.currentPage().getParameters().put('Portfolioid', portfolio.Id);
                ApexPages.currentPage().getHeaders().put('Referer', 'testreference');
                ApexPages.StandardController stdcontroller = new ApexPages.StandardController(qProj);
                QIPP_Project_Record_Types_Page_cntr RYController= new QIPP_Project_Record_Types_Page_cntr(stdcontroller);
                RYController.RecordTypeID = rt.Name;
                RYController.Createpage();
                //RYController.Cancle();
            }

        Test.stopTest();        
    }
    
    static testmethod void Record_Types_Page_Test3(){  
        User DummyUser = new User();
        DummyUser.LastName = 'Vennapusa';
        DummyUser.FirstName = 'srikanth';
        DummyUser.Alias = 'srvvv';
        DummyUser.Email = 'venkat.maddipati@igate.com';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.Contact_BU__c = 'CFOO';
        con.Contact_BL__c = 'test7894656';
        con.Contact_L4_Org__c = 'test878234';
        con.Belt_Certification__c = 'Nokia-Black Belt';
        con.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        con.CoPQ_Role_2__c ='Finance Approver';
        con.CoPQ_Role_3__c ='Finance Approver Delegate';
        con.CoPQ_Role_4__c ='Measure Creator';
        con.User_License__c = DummyUser.Id;
        con.NSN_ID_Text__c = '12345';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;      
        portfolio.CDT__c = true;
        portfolio.X8D__c = true;
        portfolio.DI_CoPQ__c = true;
        portfolio.A3__c = true;
        portfolio.Other__c = true;
        portfolio.RCA_EDA__c = true;
        portfolio.CIF__c = true;
        insert portfolio;
        
        QIPP_Project__c qProj = new QIPP_Project__c();
        qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: Other Methodology').getRecordTypeId();
        qProj.CEMT_ID__c = 'testAmol';
        qProj.Project_Name_Succinct__c = 'testAmol123';
        qProj.Portfolio_BU__c = 'Human Resources';
        qProj.Project_Lead__c = con.Id;
        qProj.Project_BL__c = 'Nokia EDU';
        qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        qProj.Portfolio_Name__c = portfolio.Id;
        qProj.Project_State__c = 'In Progress';
        qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';

        qProj.Project_Type__c = 'Other Methodology';
       
        
        insert qProj;
        RecordType rt = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj.RecordTypeId];
        
        QIPP_Project__c qProj1 = [Select id,recordtypeid from QIPP_Project__c where id = :qProj.id];
        qProj1.recordtypeid = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: Other Methodology').getRecordTypeId();
        update qProj1;


        RecordType rt1 = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj1.RecordTypeId];
        
        Test.startTest();         
            System.runAs(DummyUser){ 
                PageReference tpageRef = Page.QIPP_Project_Record_Types_Page;
                Test.setCurrentPage(tpageRef);
                ApexPages.currentPage().getParameters().put('Portfolioid', portfolio.Id);
                ApexPages.currentPage().getHeaders().put('Referer', 'testreference');
                ApexPages.StandardController stdcontroller = new ApexPages.StandardController(qProj);
                QIPP_Project_Record_Types_Page_cntr RYController= new QIPP_Project_Record_Types_Page_cntr(stdcontroller);
                RYController.RecordTypeID = rt.Name;
                RYController.Createpage();
                //RYController.Cancle();
            }
        Test.stopTest();        
    }
    
    static testmethod void Record_Types_Page_Test4(){  
        User DummyUser = new User();
        DummyUser.LastName = 'Vennapusa';
        DummyUser.FirstName = 'srikanth';
        DummyUser.Alias = 'srvvv';
        DummyUser.Email = 'venkat.maddipati@igate.com';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.Contact_BU__c = 'CFOO';
        con.Contact_BL__c = 'test7894656';
        con.Contact_L4_Org__c = 'test878234';
        con.Belt_Certification__c = 'Nokia-Black Belt';
        con.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        con.CoPQ_Role_2__c ='Finance Approver';
        con.CoPQ_Role_3__c ='Finance Approver Delegate';
        con.CoPQ_Role_4__c ='Measure Creator';
        con.User_License__c = DummyUser.Id;
        con.NSN_ID_Text__c = '12345';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;      
        portfolio.CDT__c = true;
        portfolio.X8D__c = true;
        portfolio.DI_CoPQ__c = true;
        portfolio.A3__c = true;
        portfolio.Other__c = true;
        portfolio.RCA_EDA__c = true;
        portfolio.CIF__c = true;
        insert portfolio;
        
        QIPP_Project__c qProj = new QIPP_Project__c();
        qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: 8D').getRecordTypeId();
        qProj.CEMT_ID__c = 'testAmol';
        qProj.Project_Name_Succinct__c = 'testAmol123';
        qProj.Portfolio_BU__c = 'Human Resources';
        qProj.Project_Lead__c = con.Id;
        qProj.Project_BL__c = 'Nokia EDU';
        qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        qProj.Portfolio_Name__c = portfolio.Id;
        qProj.Project_State__c = 'In Progress';
        qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
        qProj.Project_Type__c = '8D';
        
        insert qProj;
        RecordType rt = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj.RecordTypeId];
        
        QIPP_Project__c qProj1 = [Select id,recordtypeid from QIPP_Project__c where id = :qProj.id];
        qProj1.recordtypeid = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: 8D').getRecordTypeId();
        update qProj1;


        RecordType rt1 = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj1.RecordTypeId];
        
        Test.startTest();         
            System.runAs(DummyUser){ 
                PageReference tpageRef = Page.QIPP_Project_Record_Types_Page;
                Test.setCurrentPage(tpageRef);
                ApexPages.currentPage().getParameters().put('Portfolioid', portfolio.Id);
                ApexPages.currentPage().getHeaders().put('Referer', 'testreference');
                ApexPages.StandardController stdcontroller = new ApexPages.StandardController(qProj);
                QIPP_Project_Record_Types_Page_cntr RYController= new QIPP_Project_Record_Types_Page_cntr(stdcontroller);
                RYController.RecordTypeID = rt.Name;
                RYController.Createpage();
                //RYController.Cancle();
            }
        Test.stopTest();        
    }
    
    static testmethod void Record_Types_Page_Test5(){  
        User DummyUser = new User();
        DummyUser.LastName = 'Vennapusa';
        DummyUser.FirstName = 'srikanth';
        DummyUser.Alias = 'srvvv';
        DummyUser.Email = 'venkat.maddipati@igate.com';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.Contact_BU__c = 'CFOO';
        con.Contact_BL__c = 'test7894656';
        con.Contact_L4_Org__c = 'test878234';
        con.Belt_Certification__c = 'Nokia-Black Belt';
        con.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        con.CoPQ_Role_2__c ='Finance Approver';
        con.CoPQ_Role_3__c ='Finance Approver Delegate';
        con.CoPQ_Role_4__c ='Measure Creator';
        con.User_License__c = DummyUser.Id;
        con.NSN_ID_Text__c = '12345';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;      
        portfolio.CDT__c = true;
        portfolio.X8D__c = true;
        portfolio.DI_CoPQ__c = true;
        portfolio.A3__c = true;
        portfolio.Other__c = true;
        portfolio.RCA_EDA__c = true;
        portfolio.CIF__c = true;
        insert portfolio;
        
        QIPP_Project__c qProj = new QIPP_Project__c();
        qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
        qProj.CEMT_ID__c = 'testAmol';
        qProj.Project_Name_Succinct__c = 'testAmol123';
        qProj.Portfolio_BU__c = 'Human Resources';
        qProj.Project_Lead__c = con.Id;
        qProj.Project_BL__c = 'Nokia EDU';
        qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        qProj.Portfolio_Name__c = portfolio.Id;
        qProj.Project_State__c = 'In Progress';
        qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
        qProj.Project_Type__c = 'CIF';
        
        insert qProj;
        RecordType rt = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj.RecordTypeId];
        
        QIPP_Project__c qProj1 = [Select id,recordtypeid from QIPP_Project__c where id = :qProj.id];
        qProj1.recordtypeid = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
        update qProj1;


        RecordType rt1 = [SELECT Id, Name,Description FROM RecordType WHERE id = :qProj1.RecordTypeId];
        
        Test.startTest();         
            System.runAs(DummyUser){ 
                PageReference tpageRef = Page.QIPP_Project_Record_Types_Page;
                Test.setCurrentPage(tpageRef);
                ApexPages.currentPage().getParameters().put('Portfolioid', portfolio.Id);
                ApexPages.currentPage().getHeaders().put('Referer', 'testreference');
                ApexPages.StandardController stdcontroller = new ApexPages.StandardController(qProj);
                QIPP_Project_Record_Types_Page_cntr RYController= new QIPP_Project_Record_Types_Page_cntr(stdcontroller);
                RYController.RecordTypeID = rt.Name;
                RYController.Createpage();
                //RYController.Cancle();
            }
        Test.stopTest();        
    }    
}