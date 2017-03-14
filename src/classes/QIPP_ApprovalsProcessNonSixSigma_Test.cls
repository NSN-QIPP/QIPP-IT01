@isTest
private class QIPP_ApprovalsProcessNonSixSigma_Test
{
    static testmethod void QIPP_ApprovalsProcessNonSixSigma_1()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'abhishek.jagtap@igate.com';
        DummyUser.Username = 'abhishek.jagtap@igate.com.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        User DummyUser1 = new User();
        DummyUser1.LastName = 'adc';
        DummyUser1.FirstName = 'adc';
        DummyUser1.Alias = 'adc';
        DummyUser1.Email = 'abhishek.jagtap25@igate.com';
        DummyUser1.Username = 'abhishek.jagtap25@igate.com.adc';
        DummyUser1.CommunityNickname = 'a25';
        DummyUser1.IsActive = TRUE;
        DummyUser1.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser1.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser1.LocaleSidKey = 'en_US';
        DummyUser1.EmailEncodingKey = 'ISO-8859-1';
        DummyUser1.LanguageLocaleKey = 'en_US';
        insert DummyUser1;
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek.jagtap@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.CoPQ_Role_1__c = 'Business Owner';       
        con.CoPQ_Role_2__c = 'Business Owner Delegate';       
        con.CoPQ_Role_3__c = 'Finance Approver';       
        con.CoPQ_Role_4__c = 'Finance Approver Delegate';       
        insert con;
        
        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'Abhishek12';
        con1.Email__c = 'abhishek.jagtap25@igate.com';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '1223434525';
        con1.CoPQ_Role_1__c = 'Q PMO Team Member';       
        con1.CoPQ_Role_2__c = 'Measure Creator';       
        con1.CoPQ_Role_3__c = 'Project Contact';       
        insert con1;
               
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.RecordTypeId = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.CheckApprovalProcessActivation__c = 0;
        project.DI_Finance_Approver__c = DummyUser.id;
        project.DI_Approver_Q_PMO_Team_Member__c = DummyUser.id;
        project.DI_Approver_Project_Lead_Manager__c = DummyUser.id;
        project.DI_Approver_Finance_Approver_Delegate__c = DummyUser.id;
        project.DI_Approver_Business_Owner_Delegate__c = DummyUser.id;
        project.DI_Approver_Business_Owner__c = DummyUser.id;
        //project.BL_Transformation_Lead_Email__c = 'abhishek.jagtap@igate.com';
        //project.Measure_Creator_Email__c = 'abhishek.jagtap@igate.com';
        
        insert project;
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        insert obj;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Benefit_Type__c = 'Financial Savings';
        benifit.Improvement_Measure__c = 'Internal Failures';
        benifit.Improvement_Measure_KPI__c = conversions.id;
        benifit.Business_Line__c = 'GSM';
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.43;
        benifit.Directional_Indicator__c = 'Lower is Favorable' ;
        Date startdate = Date.newInstance(2013, 10, 01);   
        Date enddate = Date.newInstance(2013, 12, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Basis__c = '' ;
        benifit.Actual_Actual_Benefit_Start__c = startdate  ;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_CoPQ_Project_Team__c team = new QIPP_CoPQ_Project_Team__c();
        team.BL_Transformation_Lead__c = con.id;
        //team.Measure_Creator__c = con1.id;
        team.Business_Owner_Delegate__c = con.id; 
        team.Finance_Approver_Delegate__c = con.id;  
        team.ProjectID__c =   project.id;
        team.Business_Owner__c =  con.id;  
        team.Finance_Approver__c = con.id;
        team.Q_PMO_Team_Member__c =  con1.id;           
        insert team;             
        
        Test.startTest();   
        QIPP_ApprovalsProcessNonSixSigma.UpdateInitialValueForCoPQ(project.id);
        QIPP_ApprovalsProcessNonSixSigma.UpdateInitialValueForKPI(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DI3ApprovalProcessVaildation(project.id);
        QIPP_ApprovalsProcessNonSixSigma.InitiateDI3ApprovalProcess(project.id , 'True');
        QIPP_ApprovalsProcessNonSixSigma.DI4ApprovalProcessVaildation(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DI3AllBusinessRoleValidation(project.id);        
        QIPP_ApprovalsProcessNonSixSigma.DI4AllBusinessRoleValidation(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DI5AllBusinessRoleValidation(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DI3BenefitOverrideStatusCheck(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DI3ToDI2(project.id, 'True');
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2011';
         benrep1.Months__c = '02';
         benrep1.Benefit_Savings_Amount__c = 345;   
         insert benrep1; 
        QIPP_ApprovalsProcessNonSixSigma.Lean_Savings(project.id);
        
        QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Benefit_Condition__c = 'Achieved';
         benrep2.Quarters__c = 'Q2';                           
         benrep2.Years__c = '2010'; 
         benrep2.Months__c = '04';       
         benrep2.Benefit_Savings_Amount__c = 467;   
         insert benrep2;
        QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Benefit_Condition__c = 'Future';
         benrep3.Quarters__c = 'Q2';                           
         benrep3.Years__c = '2010'; 
         benrep3.Months__c = '04';       
         benrep3.Benefit_Savings_Amount__c = 467;   
         insert benrep3;
        QIPP_ApprovalsProcessNonSixSigma.Lean_Savings(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DMAIC_Savings(project.id);
        QIPP_ApprovalsProcessNonSixSigma.TasksCheck(project.id);
        benifit.Planned_Financial_Savings_Total__c = 33;
        benifit.Achieved_Financial_Savings_Total__c = 33;
        benifit.Future_Financial_Savings_Total__c  = 33;
        benifit.Benefit_Override_Status__c = 'Awaiting Approval';
        Update benifit;
        QIPP_ApprovalsProcessNonSixSigma.DI4AllBusinessRoleValidation(project.id);
        QIPP_ApprovalsProcessNonSixSigma.DI3BenefitOverrideStatusCheck(project.id);

        Test.stopTest();
    }
    static testmethod void QIPP_ApprovalsProcessNonSixSigma_2()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
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
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.RecordTypeId = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.CheckApprovalProcessActivation__c = 0;
        
        
        insert project;
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        insert obj;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Benefit_Type__c = 'Operational Saving';
        benifit.Improvement_Measure__c = 'Internal Failures';
        benifit.Improvement_Measure_KPI__c = conversions.id;
        benifit.Planned_Financial_Manual_Amount__c = 100.0 ;
        benifit.Planned_Financial_Automatic_Amount__c = 100.0 ;
        benifit.Future_Financial_Automatic_Amount__c = 100.0 ;
        benifit.Future_Financial_Manual_Amount__c = 100.0 ;
        benifit.Achieved_Financial_Automatic_Amount__c = 100.0 ;
        benifit.Achieved_Financial_Manual_Amount__c = 100.0 ;
        
        benifit.Business_Line__c = 'GSM';
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.43;
        benifit.Directional_Indicator__c = 'Lower is Favorable' ;
        Date startdate = Date.newInstance(2013, 10, 01);   
        Date enddate = Date.newInstance(2013, 12, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Basis__c = '' ;
        benifit.Actual_Actual_Benefit_Start__c = startdate  ;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;        
        
        Test.startTest();   
        QIPP_ApprovalsProcessNonSixSigma.UpdateInitialValueForCoPQ(project.id);
        QIPP_ApprovalsProcessNonSixSigma.UpdateInitialValueForKPI(project.id);
        QIPP_ApprovalsProcessNonSixSigma.ImpMeasurescheck(project.id);
        Test.stopTest();
    }
    static testmethod void QIPP_ApprovalsProcessNonSixSigma_3()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
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
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.CheckApprovalProcessActivation__c = 0;
        insert project;
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'Generic PI (Interim Use Only)';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        insert obj;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Benefit_Type__c = 'Operational Saving';
        benifit.Improvement_Measure_KPI__c = conversions.id;
        benifit.Business_Line__c = 'GSM';
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.43;
        benifit.Directional_Indicator__c = 'Lower is Favorable' ;
        Date startdate = Date.newInstance(2013, 10, 01);   
        Date enddate = Date.newInstance(2013, 12, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Basis__c = '' ;
        benifit.Actual_Actual_Benefit_Start__c = startdate  ;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;        
        
        Test.startTest();   
        QIPP_ApprovalsProcessNonSixSigma.UpdateInitialValueForCoPQ(project.id);
        QIPP_ApprovalsProcessNonSixSigma.UpdateInitialValueForKPI(project.id);
        QIPP_ApprovalsProcessNonSixSigma.ImpMeasurescheck(project.id);
        QIPP_ApprovalsProcessNonSixSigma.BusinessActivities(project.id);
        QIPP_ApprovalsProcessNonSixSigma.SubmitApproval(project.id);
        Test.stopTest();
    }
    
    static testmethod void QIPP_ApprovalsProcessNonSixSigma_4()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'abhishek.jagtap@igate.com';
        DummyUser.Username = 'abhishek.jagtap@igate.com.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek.jagtap@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.CoPQ_Role_1__c = 'Business Owner';       
        con.CoPQ_Role_2__c = 'Business Owner Delegate';       
        con.CoPQ_Role_3__c = 'Finance Approver';       
        con.CoPQ_Role_4__c = 'Finance Approver Delegate';       
        insert con;
        
        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'Abhishek12';
        con1.Email__c = 'abhishek.jagtap25@igate.com';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '1223434525';
        con1.CoPQ_Role_1__c = 'Q PMO Team Member';       
        con1.CoPQ_Role_2__c = 'Measure Creator';       
        con1.CoPQ_Role_3__c = 'Project Contact';       
        insert con1;
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.RecordTypeId = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.CheckApprovalProcessActivation__c = 0;
        project.Next_Approver__c = DummyUser.id;
        //project.Next_Approver__c = '';
        project.Project_Type__c = 'DMAIC';
        project.Belt_Project_Phase__c = 'Define';
        insert project;
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        insert obj;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Benefit_Type__c = 'Financial Saving';
        benifit.Improvement_Measure__c = 'Internal Failures';
        benifit.Improvement_Measure_KPI__c = conversions.id;
        benifit.Business_Line__c = 'GSM';
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.43;
        benifit.Directional_Indicator__c = 'Lower is Favorable' ;
        Date startdate = Date.newInstance(2013, 10, 01);   
        Date enddate = Date.newInstance(2013, 12, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Basis__c = '' ;
        benifit.Actual_Actual_Benefit_Start__c = startdate  ;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_CoPQ_Project_Team__c   team = new QIPP_CoPQ_Project_Team__c();
        team.BL_Transformation_Lead__c = con.id;
        //team.Measure_Creator__c = con1.id;
        team.Business_Owner_Delegate__c = con.id; 
        team.Finance_Approver_Delegate__c = con.id;  
        team.ProjectID__c =   project.id;
        team.Business_Owner__c =  con.id;  
        team.Finance_Approver__c = con.id;
        team.Q_PMO_Team_Member__c =  con1.id;           
        insert team;             
        
        Test.startTest();   
        QIPP_ApprovalsProcessNonSixSigma.SubmitApproval(project.id);
        Test.stopTest();
    }
    static testmethod void CompleteL6Sproject(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        User us   = QIPP_TestData_Helper.create_DummyUser();
        insert us;
        string emailid = 'tuleka.test@igate.com';
        QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
        insert con;
        QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
        insert port;
        QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');                
        insert project;
        QIPP_Benefit_Conversion_Table__c tb = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Table();
        insert tb;
        QIPP_Benefit__c benefit = QIPP_TestData_Helper.create_QIPP_Benefit(tb.id,project.Id);
        insert benefit;
        string benefitConversionName = 'On-Time Delivery to Requested';
        QIPP_TestData_Helper.create_QIPP_BU_Reporting(project.Id,benefit.id,benefitConversionName);
        
        QIPP_ApprovalsProcessNonSixSigma.CompleteL6Sproject(project.id);
        QIPP_ApprovalsProcessNonSixSigma.CompleteDIproject(project.id);
        test.stopTest();
    }
    
    
}