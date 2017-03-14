@istest
public class UpdatePortfolioOwnerEmail_Test {
    
    static testmethod void UpdatePortfolioOwnerEmail_1(){
        Test.startTest(); 
        
        Trigger_Control__c ts = new Trigger_Control__c();
        ts.Run_Triggers__c = true;
        insert ts;
        
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
        con.Full_Name__c = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.Belt_Certification__c = 'External-Green Belt';
        insert con;
        
        QIPP_Contacts__c con2 = new QIPP_Contacts__c();
        con2.Name = 'Srikanth';
        con2.Full_Name__c = 'Srikanth';
        con2.Email__c = 'Srikanth1234@igate.com';
        con2.Contact_State__c = 'Active';
        con2.NSN_ID_Text__c = '122343456';
        con2.Belt_Certification__c = 'External-Green Belt';
        insert con2;
        
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
        //project.RecordType.Name = 'Methodology: DMAIC / DMADV';
        project.RecordTypeId = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.Belt_Assigned__c = con.id;
        project.Project_Member1__c = con.id;
        project.Project_Member2__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Financial_Type__c = 'Operational Savings';
        benifit.Business_Line__c = 'GSM';
        benifit.Improvement_Measure_KPI__c = conversions.id;         
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_Lead__c = 'Subhash';
        benifit.Baseline_Period_weeks__c = 4.35;
        benifit.Directional_Indicator__c = 'Higher is Favorable' ;
        Date startdate = Date.newInstance(2013, 01, 01);   
        Date enddate = Date.newInstance(2013, 03, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Quanity__c = 500;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Planned_Start_Date__c = startdate  ;
        benifit.Planned_End_Date__c = enddate ;
        benifit.Planned_Operational_Manual_Amount__c = 500;
        benifit.Achieved_Quantity__c = 50;
        benifit.Achieved_Start_Date__c = startdate  ;
        benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
        benifit.Achieved_End_Date__c = enddate  ;
        benifit.Achieved_Operational_Manual_Amount__c = 500;
        benifit.Future_Quantity__c = 50;
        benifit.Future_Start_Date__c = Date.newInstance(2013, 04, 01);
        benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
        benifit.Future_End_Date__c = Date.newInstance(2013, 04, 31);         
        benifit.Future_Operational_Manual_Amount__c = 500;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;  
        
        project.Project_Lead__c = con2.id;
        update project;
        
        Test.stopTest();
       
    }
    /*static testmethod void UpdatePortfolioOwnerEmail_2(){

        Test.startTest(); 
        
        Trigger_Control__c ts = new Trigger_Control__c();
        ts.Run_Triggers__c = true;
        insert ts;
        
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
        
        QIPP_Contacts__c qcon1 = new QIPP_Contacts__c();
        qcon1.Name = 'Venkateswara Maddipati';
        qcon1.Email__c = 'venkateshwara.maddipati@igate.com';
        qcon1.Contact_State__c = 'Active';
        qcon1.NSN_ID_Text__c = '1234';
        qcon1.User_License__c = DummyUser.id;
        qcon1.Contact_BU__c = 'CFOO';
        qcon1.CoPQ_Role_1__c ='Business Unit Master Black Belt';
        qcon1.CoPQ_Role_2__c ='Finance Approver';
        qcon1.CoPQ_Role_3__c ='Finance Approver Delegate';
        qcon1.CoPQ_Role_4__c ='Measure Creator';
        insert qcon1;*/
        
        /*QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio1';
        portfolio.Portfolio_Owner__c = qcon1.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = qcon1.id;
        portfolio.CPVi_Composite__c = 25.0;
        portfolio.CPVi_Past__c = 29.0;
        portfolio.CPVi_Future__c = 55.0; 
        portfolio.CPV_Trend__c  = 'Up';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;*/
        
        /*QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = qcon1.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.Portfolio_Business_Unit__c = 'Human Resources';
        portfolio.CDT_Lead__c = qcon1.id;
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
      project.RecordTypeId = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
      project.CEMT_ID__c = 'testAmol';
      project.Project_Name_Succinct__c = 'testAmol123';
      project.Portfolio_BU__c = 'Multiple BUs';
      project.Project_Lead__c = qcon1.Id;
      project.Project_BL__c = 'Nokia EDU';
      project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
      project.Portfolio_Name__c = portfolio.Id;
      project.Project_State__c = 'In Progress';
      project.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
      //project.Belt_Candidate_Mentor__c = qcon1.Id;
      project.Belt_Project_Sponsor__c = qcon1.Id;
      project.Belt_Project_Type__c = 'GB Certification Project';
      project.Belt_Project_Champion__c = qcon1.Id;
      //project.Finance_Approver__c = qcon1.Id;
      project.Mentor_Certificate__c = 'Nokia-Green Belt';
      //project.Business_Unit_Master_Black_Belt__c = qcon1.Id;
      //project.Belt_Assigned__c = qcon1.Id;
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
      project.Project_Member1__c = qcon1.Id;
      project.Project_Member2__c = qcon1.Id;
      project.Project_Document__c = '';
      project.Business_Activity_Mapping__c = bam.id; 
      project.Lean__c = 'No';
      //project.RecordTypeId = RTID_DMAIC;
        insert project;
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Financial_Type__c = 'Operational Savings';
        benifit.Business_Line__c = 'GSM';
        benifit.Improvement_Measure_KPI__c = conversions.id;         
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.35;
        benifit.Directional_Indicator__c = 'Higher is Favorable' ;
        Date startdate = Date.newInstance(2013, 01, 01);   
        Date enddate = Date.newInstance(2013, 03, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Quanity__c = 500;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Planned_Start_Date__c = startdate  ;
        benifit.Planned_End_Date__c = enddate ;
        benifit.Planned_Operational_Manual_Amount__c = 500;
        benifit.Achieved_Quantity__c = 50;
        benifit.Achieved_Start_Date__c = startdate  ;
        benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
        benifit.Achieved_End_Date__c = enddate  ;
        benifit.Achieved_Operational_Manual_Amount__c = 500;
        benifit.Future_Quantity__c = 50;
        benifit.Future_Start_Date__c = Date.newInstance(2013, 04, 01);
        benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
        benifit.Future_End_Date__c = Date.newInstance(2013, 04, 31);         
        benifit.Future_Operational_Manual_Amount__c = 500;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;  
        
        Test.stopTest();
       
    }*/
    
     static testmethod void UpdatePortfolioOwnerEmail_3(){
        test.startTest();
            Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
            insert ts;
            User us   = QIPP_TestData_Helper.create_DummyUser();
            insert us;            
            /*
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
            */
            string emailid = 'tuleka.test@igate.com';
            QIPP_Contacts__c con  =QIPP_TestData_Helper.create_QIPP_Contact(emailid);
            insert con;
            QIPP_Portfolio__c port = QIPP_TestData_Helper.create_QIPP_Portfolio(con.id,us.id);
            insert port;
            QIPP_Project__c project = QIPP_TestData_Helper.create_QIPP_Project_with_recordtype(port.id,con.id,us.id,'Methodology: DMAIC / DMADV');        
            //project.Business_Unit_Master_Black_Belt__c = conBUMMB.id;  
            insert project;
            QIPP_Benefit_Conversion_Table__c tb = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Table();
            insert tb;
            QIPP_Benefit__c benefit = QIPP_TestData_Helper.create_QIPP_Benefit(tb.id,project.Id);
            insert benefit;
            string benefitConversionName = 'On-Time Delivery to Requested';
            QIPP_BU_Reporting__c  beli = QIPP_TestData_Helper.create_QIPP_BU_Reporting(project.Id,benefit.id,benefitConversionName);
            insert beli;
            project.Project_State__c = 'On hold';
            TriggerHelper.alreadyModified2 = true;
            update project;
       test.stopTest();
    }
    
    
}