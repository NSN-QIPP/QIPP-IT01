@isTest
private class QIPP_BenefitDetailPage_Test{
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
    //static UserRole ur = new UserRole(Name = 'QIPP Admin');

    static testmethod void detailpage1(){
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
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Saving';
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
         
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;  
         
        string myParameterValue = 'detailpage';
        id myBenefitId = benifit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        
         QIPP_BenefitDetailPage cont1= new QIPP_BenefitDetailPage();
        
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
        
        PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        cont.Bn_rep_AddList.add(benrep1);                                
        cont.deletebenifit();
        cont.viewBenefit();
        cont.projectDetailspage();
        cont.editbenefit();
        //cont.changeDateFormat(Date.Today());
        try{cont.conversionTableLink();}catch(Exception e){}
        cont.editnewbenefit();
        cont.recordIsLocked(project.Id);
        cont.viewSRQ();
        cont.viewSRM();
        Test.stopTest();
       

    }
    static testmethod void detailpage2(){
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
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
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
         
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;           
        
        string myParameterValue = 'detailpage';
        id myBenefitId = benifit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        
         QIPP_BenefitDetailPage cont1= new QIPP_BenefitDetailPage();
        
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
        
        PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        cont.Bn_rep_AddList.add(benrep1);                                
        cont.deletebenifit();
        cont.viewBenefit();
        cont.projectDetailspage();
        cont.editbenefit();
        //cont.changeDateFormat(Date.Today());
        try{cont.conversionTableLink();}catch(Exception e){}
        cont.viewSRQ();
        cont.viewSRM();        
                
        Test.stopTest();
       

    }    
    static testmethod void detailpage3(){
    

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
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Monthly Rate' ;
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
         
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;           
        
        string myParameterValue = 'detailpage';
        id myBenefitId = benifit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        
         QIPP_BenefitDetailPage cont1= new QIPP_BenefitDetailPage();
        
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
        
        PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        cont.Bn_rep_AddList.add(benrep1);                                
        cont.deletebenifit();
        cont.viewBenefit();
        cont.projectDetailspage();
        cont.editbenefit();
        //cont.changeDateFormat(Date.Today());
        try{cont.conversionTableLink();}catch(Exception e){}
        cont.viewSRQ();
        cont.viewSRM();        
                
        Test.stopTest();
       

    }    
    static testmethod void detailpage4(){
    

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
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
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
         
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;           
        
        string myParameterValue = 'detailpage';
        id myBenefitId = benifit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        
         QIPP_BenefitDetailPage cont1= new QIPP_BenefitDetailPage();
        
        ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
        QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
        
        PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
        cont.Bn_rep_AddList.add(benrep1);                                
        cont.deletebenifit();
        cont.viewBenefit();
        cont.projectDetailspage();
        cont.editbenefit();
        //cont.changeDateFormat(Date.Today());
        try{cont.conversionTableLink();}catch(Exception e){}
        cont.viewSRQ();
        cont.viewSRM();        
                
        Test.stopTest();
       

    }    
    static testmethod void detailpage5(){
        UserRole ur = new UserRole(Name = 'QIPP Admin');
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
        DummyUser.userroleid = ur.id;
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
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'Complete';
        project.Last_Review_Type__c = 'Final';
        project.Project_Type__c ='DMAIC';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.CoPQ_Benefits_Validation_State__c = 'With Finance Approver to Validate';
        insert project;
        
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Distributed Amount' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 20;
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
         benifit.Benefit_Type__c = 'Financial Saving';
         
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;           
        
        string myParameterValue = 'detailpage';
        id myBenefitId = benifit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        System.runAs(DummyUser){
            QIPP_BenefitDetailPage cont1= new QIPP_BenefitDetailPage();
            ApexPages.StandardController con1 = new ApexPages.StandardController(benifit);
            QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
            
            PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);
            cont.benifit = benifit;
            cont.Bn_rep_AddList.add(benrep1);                                
            cont.deletebenifit();
            cont.viewBenefit();
            cont.projectDetailspage();
            cont.editbenefit();
            //cont.changeDateFormat(Date.Today());
            try{cont.conversionTableLink();}catch(Exception e){}
            cont.viewSRQ();
            cont.viewSRM();        
        }    
        Test.stopTest();
       

    }    
    
    static testmethod void detailpage6(){
        UserRole ur = new UserRole(Name = 'QIPP Admin');
        User dummyUser = QIPP_TestData_Helper.create_DummyUser();
        dummyUser.userroleid = ur.id;
        insert dummyUser;
        
        QIPP_Contacts__c contact = QIPP_TestData_Helper.create_QIPP_Contact('test@test.com');
        insert contact;
        
        QIPP_Portfolio__c portfolio = QIPP_TestData_Helper.create_QIPP_Portfolio(contact.Id, dummyUser.Id);
        // If you want to change or assign value of object, you can use as per below
        portfolio.Name = 'test portfolio Name';
        insert portfolio;
        
        QIPP_Project__c proj = QIPP_TestData_Helper.create_QIPP_Project(portfolio.Id, contact.Id, dummyUser.Id);
        proj.Project_State__c = 'Not Started';
        proj.RecordTypeId = RTID_DMAIC;
        insert proj;

        QIPP_Benefit_Conversion_Table__c conversion = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Table();
        insert conversion;
        
        QIPP_Benefit_Conversion_Rate__c conversionRate = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Rate(conversion.Id);
        insert conversionRate;
        
        QIPP_Benefit__c benefit =  QIPP_TestData_Helper.create_QIPP_Benefit(conversion.Id, proj.Id);
        benefit.Benefit_Type__c = 'Financial Savings';
        benefit.Benefit_Amount_Achieved_Future_k__c = 1200;
        //Benefit_Operational_Achieved_Future_k__c
        insert benefit;
        
        QIPP_BU_Reporting__c benefitLine1 = QIPP_TestData_Helper.create_QIPP_BU_Reporting(proj.Id, benefit.Id, conversion.Id);
        benefitLine1.Benefit_Condition__c = 'Future';
        benefitLine1.Benefit_Type__c = 'Financial Savings';
        benefitLine1.Benefit_Savings_Amount__c = 600; 
        insert benefitLine1;
        
        QIPP_BU_Reporting__c benefitLine2 = QIPP_TestData_Helper.create_QIPP_BU_Reporting(proj.Id, benefit.Id, conversion.Id);
        benefitLine2.Benefit_Condition__c = 'Achieved';
        benefitLine2.Benefit_Type__c = 'Financial Savings';
        benefitLine2.Benefit_Savings_Amount__c = 600;
        insert benefitLine2;        
         
        string myParameterValue = 'detailpage';
        id myBenefitId = benefit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        System.runAs(dummyUser){
            ApexPages.StandardController con1 = new ApexPages.StandardController(benefit);
            QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
            
            PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benefit.Project_ID__c);
        }    
        Test.stopTest();
    }
    
    static testmethod void detailpage7(){
        UserRole ur = new UserRole(Name = 'QIPP Admin');
        User dummyUser = QIPP_TestData_Helper.create_DummyUser();
        dummyUser.userroleid = ur.id;
        insert dummyUser;
        
        QIPP_Contacts__c contact = QIPP_TestData_Helper.create_QIPP_Contact('test@test.com');
        insert contact;
        
        QIPP_Portfolio__c portfolio = QIPP_TestData_Helper.create_QIPP_Portfolio(contact.Id, dummyUser.Id);
        // If you want to change or assign value of object, you can use as per below
        portfolio.Name = 'test portfolio Name';
        insert portfolio;
        
        QIPP_Project__c proj = QIPP_TestData_Helper.create_QIPP_Project(portfolio.Id, contact.Id, dummyUser.Id);
        proj.Project_State__c = 'Not Started';
        proj.RecordTypeId = RTID_DMAIC;
        insert proj;

        QIPP_Benefit_Conversion_Table__c conversion = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Table();
        insert conversion;
        
        QIPP_Benefit_Conversion_Rate__c conversionRate = QIPP_TestData_Helper.create_QIPP_Benefit_Conversion_Rate(conversion.Id);
        insert conversionRate;
        
        QIPP_Benefit__c benefit =  QIPP_TestData_Helper.create_QIPP_Benefit(conversion.Id, proj.Id);
        benefit.Benefit_Type__c = 'Operational Savings';
        benefit.Benefit_Amount_Achieved_Future_k__c = 1200;
        //Benefit_Operational_Achieved_Future_k__c
        insert benefit;
        
        QIPP_BU_Reporting__c benefitLine1 = QIPP_TestData_Helper.create_QIPP_BU_Reporting(proj.Id, benefit.Id, conversion.Id);
        benefitLine1.Benefit_Condition__c = 'Future';
        benefitLine1.Benefit_Type__c = 'Operational Savings';
        benefitLine1.Benefit_Savings_Amount__c = 600; 
        insert benefitLine1;
        
        QIPP_BU_Reporting__c benefitLine2 = QIPP_TestData_Helper.create_QIPP_BU_Reporting(proj.Id, benefit.Id, conversion.Id);
        benefitLine2.Benefit_Condition__c = 'Achieved';
        benefitLine2.Benefit_Type__c = 'Operational Savings';
        benefitLine2.Benefit_Savings_Amount__c = 600;
        insert benefitLine2;        
         
        string myParameterValue = 'detailpage';
        id myBenefitId = benefit.id;
        
        PageReference page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+myBenefitId);
        Test.setCurrentPageReference(page);
        Test.startTest();   
        System.runAs(dummyUser){
            ApexPages.StandardController con1 = new ApexPages.StandardController(benefit);
            QIPP_BenefitDetailPage cont= new QIPP_BenefitDetailPage(con1);
            
            PageReference page1 = new PageReference('/apex/QIPP_Benefit_View?fm='+benefit.Project_ID__c);
            cont.BusinessLine = 'text';
            cont.ImprovmentMeasure = 'text';
            cont.PlannedBenefitStart = Date.Today();
            cont.PlannedBenefitEnd = Date.Today();
            cont.AchievedBenefitStart = Date.Today();
            cont.AchievedBenefitEnd = Date.Today();
            cont.RemainingBenefitStart = Date.Today();
            cont.RemainingBenefitEnd = Date.Today();
            
            cont.PlannedSavingRate = 10.2;
            cont.AchievedSavingRate = 10.2;
            cont.FutureSavingRate = 10.2;
            cont.PlannedSavingRate_RoundedUp = 10.2;
            cont.AchievedSavingRate_RoundedUp = 10.2;
            cont.FutureSavingRate_RoundedUp = 10.2;
            cont.BaselineRate = 10.2;
            cont.PlannedSavingAmount = 10.2;
            cont.AchievedSavingAmount = 10.2;
            cont.FutureSavingAmount = 10.2;
            cont.SavingAmount = 'test';
            cont.BenefitPeriodWeekly = 'test';
            
            page = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpageFromOverride='+myBenefitId);
            Test.setCurrentPageReference(page);
            con1 = new ApexPages.StandardController(benefit);
            cont= new QIPP_BenefitDetailPage(con1);

        }    
        Test.stopTest();
    }
        
    
}