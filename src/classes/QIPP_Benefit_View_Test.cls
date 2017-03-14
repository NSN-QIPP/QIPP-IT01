@isTest
private class QIPP_Benefit_View_Test
{   
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;

    static testmethod void viewpage1()
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         //benifit.Financial_Type__c = 'Financial Savings';
         benifit.Benefit_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;
         
         insert benifit;
         
        PageReference page = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_Benefit_View cont1= new QIPP_Benefit_View(con1);
        cont1.DeleteBenefit();
        cont1.moveToBenefitePage();
        cont1.BackToProjectDetailPage();
        //cont1.viewFSQ();
        cont1.viewFSM();
        cont1.viewOSQ();
        cont1.viewOSM();
        cont1.goToBenefitLookUp();
        cont1.searchText = 'ncdr';
        cont1.search();
        cont1.AlphaFilter = 'A';
        cont1.searchText = '';
        cont1.search();        
        cont1.addBenefit();        
        cont1.viewBenefitSummary();
        cont1.getctlist();

        cont1.searchText = '*test*';
        cont1.search();
        cont1.searchText = '*test';
        cont1.search();
        cont1.searchText = 'test*';
        cont1.search();
        cont1.AlphaFilter = 'All';
        cont1.searchText = '';
        cont1.search();      
        
        PageReference page3 = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        System.currentPageReference().getHeaders().put('alpha','All');
        ApexPages.currentPage().getHeaders().put('alpha','All');
        Test.setCurrentPageReference(page3);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_Benefit_View cont2= new QIPP_Benefit_View(con2); 
        cont2.FinancialErrorMessage = 'test msg';
        cont2.OperationalErrorMessage = 'test msg';

             
        Test.stopTest();
    }
    static testmethod void viewpage2()
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         //benifit.Financial_Type__c = 'Financial Savings';
         benifit.Benefit_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;         
         insert benifit;
         
        System.Debug('********************************* Project Id in phase 3 ********************** '  + project.id); 
        PageReference page = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_Benefit_View cont1= new QIPP_Benefit_View(con1);
        cont1.DeleteBenefit();
        //cont1.moveToBenefitePage();
        cont1.BackToProjectDetailPage();


        cont1.goToBenefitLookUp();
        cont1.searchText = 'kpi';
        //cont1.search();
        cont1.AlphaFilter = 'B';
        cont1.searchText = '';
        //cont1.search();        
        //cont1.addBenefit();                
        //cont1.viewBenefitSummary();        
        //cont1.getctlist();            
        Test.stopTest();
    }
    static testmethod void viewpage3()
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         benifit.Benefit_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;         
         insert benifit;
         
        PageReference page = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);

        Test.setCurrentPageReference(page);
        Test.startTest();   
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_Benefit_View cont1= new QIPP_Benefit_View(con1);
        cont1.DeleteBenefit();
        cont1.moveToBenefitePage();
        cont1.BackToProjectDetailPage();
                cont1.viewFSQ();
        cont1.viewFSM();
        cont1.viewOSQ();
        cont1.viewOSM();

        cont1.goToBenefitLookUp();
        cont1.searchText = 'kpi';
        cont1.search();
        cont1.AlphaFilter = 'N';
        cont1.searchText = '';
        cont1.search();        
        cont1.addBenefit();                
        cont1.viewBenefitSummary();        
        cont1.getctlist();            
        Test.stopTest();
    }

    static testmethod void viewpage4()
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         benifit.Benefit_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;         
         insert benifit;
         
        PageReference page = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);

        Test.setCurrentPageReference(page);
        Test.startTest();   
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_Benefit_View cont1= new QIPP_Benefit_View(con1);
        cont1.DeleteBenefit();
        cont1.moveToBenefitePage();
        cont1.BackToProjectDetailPage();
        cont1.viewFSQ();
        cont1.viewFSM();
        cont1.viewOSQ();
        cont1.viewOSM();

        cont1.goToBenefitLookUp();
        cont1.searchText = '';
        cont1.search();
        cont1.AlphaFilter = 'I';
        cont1.searchText = '';
        cont1.search();        
        cont1.addBenefit();                
        cont1.viewBenefitSummary();        
        cont1.getctlist();            
        Test.stopTest();

    }

    static testmethod void viewpage5(){
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'Complete';
        project.Project_Type__c = 'DMAIC';
        project.CoPQ_Benefits_Validation_State__c = 'Validation Complete';
        project.KPI_Benefits_Validation_State__c = 'Validation Complete';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         benifit.Benefit_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;
         benifit.Planned_Financial_Savings_Total__c = 100.0;
         benifit.Achieved_Financial_Savings_Total__c = 100.0;
         benifit.Future_Financial_Savings_Total__c = 100.0;
         insert benifit;
         
         QIPP_Benefit__c benifit1 = new QIPP_Benefit__c();
         benifit1.Baseline_Rate_N__c = 100.0;
         benifit1.Benefit_Type__c = 'Operational Savings';
         benifit1.Business_Line__c = 'GSM';
         benifit1.Improvement_Measure_KPI__c = conversions.id;         
         benifit1.Unit_of_Measure__c = 'Each';
         benifit1.Baseline_Period_weeks__c = 4.43;
         benifit1.Directional_Indicator__c = 'Lower is Favorable' ;
         benifit1.Baseline_Quantity__c = 15;
         benifit1.Type_of_Measure__c = 'Weekly Rate' ;
         benifit1.Planned_Quanity__c = 500;
         benifit1.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit1.Planned_Start_Date__c = startdate  ;
         benifit1.Planned_End_Date__c = enddate ;
         benifit1.Achieved_Quantity__c = 50;
         benifit1.Achieved_Start_Date__c = startdate  ;
         benifit1.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit1.Achieved_End_Date__c = enddate  ;
         benifit1.Future_Quantity__c = 50;
         benifit1.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit1.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit1.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit1.Unit_of_Measure__c = 'Each';
         benifit1.Project_ID__c = project.id;
         benifit1.Planned_Operational_Manual_Amount__c = 100.0;
         benifit1.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit1.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit1.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit1.Future_Operational_Manual_Amount__c = 100.0;
         benifit1.Future_Operational_Automatic_Amount__c = 200.0;
         benifit1.Benefit_Operational_Achieved_Future_k__c = 100.0;
         benifit1.Planned_Operational_Savings_Total__c = 100.0;
         benifit1.Achieved_Operational_Savings_Total__c = 100.0;
         benifit1.Future_Operational_Savings_Total__c = 100.0;
         insert benifit1;         
         
        PageReference page = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);

        Test.setCurrentPageReference(page);
        Test.startTest();   
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_Benefit_View cont1= new QIPP_Benefit_View(con1);
        cont1.DeleteBenefit();

        
        /*cont1.moveToBenefitePage();
        cont1.BackToProjectDetailPage();
        //cont1.ImportRecordInExcel();
        cont1.goToBenefitLookUp();
        cont1.AlphaFilter = 'K';
        cont1.searchText = '';
        cont1.search();
        cont1.AlphaFilter = 'All';
        cont1.searchText = '';
        cont1.search();
        cont1.searchText = 'imp';
        cont1.search();                  
        cont1.viewBenefitSummary();        
        cont1.getctlist();*/            
        Test.stopTest();
    }
    
    
    static testmethod void viewpage6(){
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         benifit.Benefit_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;         
         insert benifit;
         

        Test.startTest();  
            PageReference page = new PageReference('/apex/QIPP_Benefit_View?test='+benifit.Project_ID__c+'%3D'+benifit.Project_ID__c);
            Test.setCurrentPageReference(page);
            ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
            QIPP_Benefit_View cont1= new QIPP_Benefit_View(con1);
            //cont1.DeleteBenefit();
        Test.stopTest();
    }
    
    static testmethod void viewpage7(){
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         benifit.Benefit_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;         
         insert benifit;
         
        Test.startTest();  
            PageReference page3 = new PageReference('/apex/QIPP_Benefit_View?delete='+benifit.Project_ID__c+'%3D'+benifit.Project_ID__c);   
            String TestURL = '/apex/QIPP_Benefit_View?rf='+ project.Id + '?delete='+benifit.Project_ID__c;
            page3.getHeaders().put('Referer',TestURL);
            //page3.GetHeaders().Put('Referer', TestURL);
            Test.setCurrentPageReference(page3);            
            Test.setCurrentPageReference(page3);
            ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
            QIPP_Benefit_View cont3 = new QIPP_Benefit_View(con3);
            cont3.DeleteBenefit();
        Test.stopTest();
    }
    static testmethod void viewpage8(){
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
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100.0;
         benifit.Benefit_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Planned_Financial_Manual_Amount__c = 100.0;
         benifit.Planned_Financial_Automatic_Amount__c = 200.0;
         benifit.Achieved_Financial_Manual_Amount__c = 100.0;
         benifit.Achieved_Financial_Automatic_Amount__c = 200.0;
         benifit.Future_Financial_Manual_Amount__c = 100.0;
         benifit.Future_Financial_Automatic_Amount__c = 200.0;
         benifit.Benefit_Amount_Achieved_Future_k__c = 300.0;
         benifit.Planned_Operational_Manual_Amount__c = 100.0;
         benifit.Planned_Operational_Automatic_Amount__c = 200.0;
         benifit.Achieved_Operational_Manual_Amount__c = 100.0;
         benifit.Achieved_Operational_Automatic_Amount__c = 200.0;
         benifit.Future_Operational_Manual_Amount__c = 100.0;
         benifit.Future_Operational_Automatic_Amount__c = 200.0;
         benifit.Benefit_Operational_Achieved_Future_k__c = 100.0;         
         insert benifit;
         
        Test.startTest();  
            PageReference page3 = new PageReference('/apex/QIPP_Benefit_View?rf='+benifit.Project_ID__c+'%3D'+benifit.Project_ID__c);           
            String TestURL = 'https://c.cs11.visual.force.com/apex/QIPP_Benefit_View?delete='+benifit.Project_ID__c+'retURL='+benifit.Project_ID__c;
            System.currentPageReference().getHeaders().put('Referer',TestURL);
            //page3.GetHeaders().Put('Referer', TestURL);
            Test.setCurrentPageReference(page3);
            ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
            QIPP_Benefit_View cont3 = new QIPP_Benefit_View(con3);
        Test.stopTest();
    }
}