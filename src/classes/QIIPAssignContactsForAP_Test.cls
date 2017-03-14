@isTest
private class QIIPAssignContactsForAP_Test
{
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
    
    static testmethod void test()
    {
        
        User DummyUser = new User();
        DummyUser.LastName = 'Maddipati';
        DummyUser.FirstName = 'Venkateswara';
        DummyUser.Alias = 'vmadd';
        DummyUser.Email = 'venkateshwara.maddipati@igate.com';
        DummyUser.Username = 'venkat.maddipati@igate.com';
        DummyUser.CommunityNickname = 'venky';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Venkateswara Maddipati';
        con.Email__c = 'venkateshwara.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '1234';
        con.User_License__c = DummyUser.id;
        con.Contact_BU__c = 'CFOO';
        con.CoPQ_Role_1__c ='Business Unit Master Black Belt';
        con.CoPQ_Role_2__c ='Finance Approver';
        con.CoPQ_Role_3__c ='Finance Approver Delegate';
        con.CoPQ_Role_4__c ='Measure Creator';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
        Business_Activity__c bam = new Business_Activity__c();
        bam.name = 'Test Business Activity';
        bam.Business_Function__c = 'Marketing & communications';
        bam.Value_Stream__c = 'Features';
        insert bam;
        
        QIPP_Project__c project = new QIPP_Project__c();
        
        project.CEMT_ID__c = 'testAmol';
        project.Project_Name_Succinct__c = 'testAmol123';
        project.Portfolio_BU__c = 'Human Resources';
        project.Project_Lead__c = con.Id;
        project.Project_BL__c = 'Nokia EDU';
        project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project.Portfolio_Name__c = portfolio.Id;
        project.Project_State__c = 'In Progress';
        project.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
        project.Belt_Candidate_Mentor__c = con.Id;
        project.Belt_Project_Sponsor__c = con.Id;
        project.Belt_Project_Type__c = 'GB Certification Project';
        project.Belt_Project_Champion__c = con.Id;
        project.Finance_Approver__c = con.Id;
        project.Mentor_Certificate__c = 'Nokia-Green Belt';
        project.Business_Unit_Master_Black_Belt__c = con.Id;
        //project.Belt_Assigned__c = con.Id;
        project.Belt_Project_Phase__c = 'Define';
        project.DMAIC_Define__c = date.today();
        project.Define_Date_Forecast__c = date.today();
        project.Define_Status__c = 'In Progress';
        project.DMAIC_Measure__c = date.today();
        project.Measure_Date_Forecast__c = date.today();
        project.Measure_Status__c = 'In Progress';
        project.DMAIC_Analyze__c = date.today();
        project.Analyze_Date_Forecast__c = date.today();
        project.Analyze_Status__c = 'In Progress';
        project.DMAIC_Improve__c = date.today();
        project.Improve_Design_Date_Forecast__c = date.today();
        project.Improve_Status__c = 'In Progress';
        project.DMAIC_Control__c = date.today();
        project.Control_Verify_Date_Forecast__c = date.today();
        project.Control_Status__c = 'In Progress';
        project.Planned_Start_Date__c = date.today();
        project.Project_Completion_Date_Target__c = date.today();
        project.Project_Type__c='CDT';
        project.Project_Start_Date__c = date.today();
        project.Project_Completion_Date_Forecast__c = date.today();
        project.MO_Site__c = 'Beijing';
        project.Project_Created_Date__c = date.today();
        project.Project_Completion_Date_Actual__c = date.today();
        project.Quality_Award_Project__c = 'Yes';
        project.Project_Flex_Field_1__c = 'testAmol';
        project.DI_State__c = 'DI 2 - Concept existing, business case analyzed';
        project.Permission_to_use_Belt_Info__c = 'Yes';
        project.Progress_To_Date__c = 'testAMOLLLLLLLLLL';
        project.Next_Steps__c = 'testAMOLLLLLLLLLLLLLLLLLLLLLL';
        project.Project_Member1__c = con.Id;
        project.Project_Member2__c = con.Id;
        project.Project_Document__c = '';
        project.Business_Activity_Mapping__c = bam.id; 
        project.Lean__c = 'No';
        project.RecordTypeId = RTID_DMAIC;
        
        insert project; 
        
        //Define Phase
        project= [SELECT Belt_Project_Phase__c,Define_Date_Current__c,DMAIC_Define__c,Define_Status__c FROM QIPP_Project__c WHERE Id =:project.Id LIMIT 1];
        
        project.Belt_Project_Phase__c='Measure';
        project.Define_Date_Current__c=Date.Today()+1;
        project.DMAIC_Define__c=Date.Today();
        project.RecordTypeId = RTID_DMAIC;
        project.Define_Status__c = 'Delayed';
        
        update project;
        
        project= [SELECT Belt_Project_Phase__c,Define_Date_Current__c,DMAIC_Define__c,Define_Status__c FROM QIPP_Project__c WHERE Id =:project.Id LIMIT 1];
        
        project.Belt_Project_Phase__c='Measure';
        project.RecordTypeId = RTID_DMAIC;
        project.Define_Date_Current__c=Date.Today();
        project.DMAIC_Define__c=Date.Today();
        project.Define_Status__c = 'Completed';
        
        update project;
        
    }
    
    static testmethod void test1(){
        test.startTest();
        //boolean runtrigger = true;
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'tulekaBum2';
        us2.FirstName = '';
        us2.Username = 'tulekaBumbb.test@igate.com'; 
        us2.Alias = 'tulek34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'tuleka';
        us2.Email = 'tulekaBumbb.test@igate.com';
        insert us2;
        string emailidbu = 'tulekaBumbb.test@igate.com';
        QIPP_Contacts__c conBUMMB  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        conBUMMB.Name = 'tulekaBum2';
        conBUMMB.User_License__c =us2.id;
        conBUMMB.NSN_ID_Text__c = '12563434';
        conBUMMB.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
        insert conBUMMB;
        
        string emailid = 'tuleka.test@igate.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');        
        project.Business_Unit_Master_Black_Belt__c = conBUMMB.id;
        project.Belt_Candidate_Mentor__c = conBUMMB.id;            
        insert project;
        
        /*project.Belt_Candidate_Mentor__c = us.id;            
try{
//Database.SaveResult SR = Database.update(project);
update project;
}catch(Exception e){
Boolean expectedExceptionThrown =  e.getMessage().contains('Provided Mentor Contact is not actual Salesforce User') ? false : true;
System.AssertEquals(expectedExceptionThrown, true);
//System.assert(e.getMessage().contains('Provided Mentor Contact is not actual Salesforce User'));
} 
*/
        QIPP_Benefit_Conversion_Table__c tb = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Table();
        insert tb;
        QIPP_Benefit__c benefit = QIPP_TestData_Helper.create_QIPP_Benefit(tb.id,project.Id);
        insert benefit;
        string benefitConversionName = 'On-Time Delivery to Requested';
        QIPP_TestData_Helper.create_QIPP_BU_Reporting(project.Id,benefit.id,benefitConversionName);
        
        
        
        
        
        test.stopTest();
        
        
    }
    static testmethod void test2(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c conFinanceApprover  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        conFinanceApprover.Name = 'gopal';
        conFinanceApprover.Email__c = 'gopal.test@capgemini.com';
        conFinanceApprover.User_License__c =us2.id;
        conFinanceApprover.NSN_ID_Text__c = '12563434';
        conFinanceApprover.CoPQ_Role_1__c = 'Finance Approver';
        conFinanceApprover.Contact_BU__c = 'CFOO';
        insert conFinanceApprover;
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');        
        project.Finance_Approver__c = conFinanceApprover.id;
        
        insert project;
        QIPP_Benefit_Conversion_Table__c tb = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Table();
        insert tb;
        QIPP_Benefit__c benefit = QIPP_TestData_Helper.create_QIPP_Benefit(tb.id,project.Id);
        insert benefit;
        string benefitConversionName = 'On-Time Delivery to Requested';
        QIPP_TestData_Helper.create_QIPP_BU_Reporting(project.Id,benefit.id,benefitConversionName);
        
        test.stopTest();
    }
    static testmethod void test3(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c conOperationalSavings  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        conOperationalSavings.Name = 'gopal';
        conOperationalSavings.User_License__c =us2.id;
        conOperationalSavings.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        conOperationalSavings.Email__c = 'gopal.test@capgemini.com';
        insert conOperationalSavings; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Operational_Savings_Approver_Email__c = 'gopal.test@capgemini.com';
        project.Operational_Savings_Approver__c = conOperationalSavings.id;
        insert project;           
        test.stopTest();
    }
    static testmethod void test4(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c leanCoach  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        leanCoach.Name = 'gopal';
        leanCoach.User_License__c =us2.id;
        leanCoach.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        leanCoach.Email__c = 'gopal.test@capgemini.com';
        insert leanCoach; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Lean_Coach_Email_ID__c = 'gopal.test@capgemini.com';
        project.Lean_Coach__c = leanCoach.id;
        insert project;           
        test.stopTest();
    }
    static testmethod void test5(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Improvement_Owner_Email__c = 'gopal.test@capgemini.com';
        project.Improvement_Owner__c = improvementOwner.id;
        insert project;           
        test.stopTest();
    }
    static testmethod void test6(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Project_State__c = 'Not Started';
        project.Project_Type__c = 'Methodology: 8D';
        
        insert project;           
        test.stopTest();
    }
    static testmethod void test7(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Measure';
        project.Define_Date_Current__c = date.newInstance(2016, 08, 17);
        project.DMAIC_Define__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test8(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Measure';
        project.Define_Date_Current__c = date.newInstance(2016, 08, 17);
        project.DMAIC_Define__c = date.newInstance(2016, 08, 17);
        insert project;           
        test.stopTest();
    }
    static testmethod void test9(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Analyze';
        project.Measure_Date_Current__c = date.newInstance(2016, 08, 17);
        project.DMAIC_Measure__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test10(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Analyze';
        project.Measure_Date_Current__c = date.newInstance(2016, 08, 15);
        project.DMAIC_Measure__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test11(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Improve / Design';
        project.Analyze_Date_Current__c = date.newInstance(2016, 08, 17);
        project.DMAIC_Analyze__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test12(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Improve / Design';
        project.Analyze_Date_Current__c = date.newInstance(2016, 08, 15);
        project.DMAIC_Analyze__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test13(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Control / Verify';
        project.Improve_Date_Current__c = date.newInstance(2016, 08, 17);
        project.DMAIC_Improve__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test14(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Control / Verify';
        project.Improve_Date_Current__c = date.newInstance(2016, 08, 15);
        project.DMAIC_Improve__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test15(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Complete';
        project.Control_Date_Current__c = date.newInstance(2016, 08, 17);
        project.DMAIC_Control__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    static testmethod void test16(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Complete';
        project.Control_Date_Current__c = date.newInstance(2016, 08, 15);
        project.DMAIC_Control__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
    
    static testmethod void test17(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;            
        User us2   = QIPP_TestData_Helper.create_DummyUser();
        us2.LastName = 'gopal';
        us2.FirstName = '';
        us2.Username = 'gopal.test@capgemini.com'; 
        us2.Alias = 'gopal34';
        us2.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Nokia QIPP Project Lead' LIMIT 1].Id;
        us2.CommunityNickname = 'gopalcap';
        us2.Email = 'gopal.test@capgemini.com';
        insert us2;
        string emailidbu = 'gopal.test@capgemini.com';
        QIPP_Contacts__c improvementOwner  =QIPP_TestData_Helper.create_QIPP_Contact(emailidbu);
        improvementOwner.Name = 'gopal';
        improvementOwner.User_License__c =us2.id;
        improvementOwner.NSN_ID_Text__c = '12563434';
        //conOperationalSavings.CoPQ_Role_1__c = 'Finance Approver';
        improvementOwner.Email__c = 'gopal.test@capgemini.com';
        insert improvementOwner; // id value is got through this line rest above values can be got without insert command also
        
        
        string emailid = 'gopal.a.kannan@abc.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');           
        project.Belt_Project_Phase__c = 'Complete';
        project.Control_Date_Current__c = date.newInstance(2016, 08, 15);
        project.DMAIC_Control__c = date.newInstance(2016, 08, 15);
        insert project;           
        test.stopTest();
    }
}