@isTest
private class QIPP_BenefitController_Test
{
   static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
    
    static testmethod void ImprovementMeasure1()
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
        
        QIPP_Benefit_Conversion_Rate__c conrateobj = new QIPP_Benefit_Conversion_Rate__c();
        conrateobj.Conversion_Rate__c = 9.0;
        conrateobj.Fiscal_Quarter__c = 'Q1';
        conrateobj.Fiscal_Year__c = '2013';
        conrateobj.Improvement_Measure__c = conversions.id;
        conrateobj.Business_Line__c = 'GSM';
        insert conrateobj;
        
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
         benrep1.Benefit_Condition__c = 'Future';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;
        
        QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Benefit_Condition__c = 'Future';
         benrep2.Quarters__c = 'Q1';                           
         benrep2.Years__c = '2014';  
         benrep2.Benefit_Savings_Amount__c = 100;  
        benrep2.Months__c = null;
         insert benrep2; 
         QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Benefit_Condition__c = 'Future';
         benrep3.Quarters__c = 'Q1';                           
         benrep3.Years__c = '2014';  
         benrep3.Benefit_Savings_Amount__c = 100;  
        benrep3.Months__c = null;
         //insert benrep3;
         
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.Bn_rep_AddList = new list<QIPP_BU_Reporting__c>();
        cont2.Bn_rep_AddList.add(benrep1); 
        cont2.Bn_rep_AddList.add(benrep2); 
        cont2.SelectedValue = 'GSM';
        cont2.hideedit = false;
        cont2.getBusinesslinelist();
        //insert benrep2;
        cont2.Bn_rep_DelList = new list<QIPP_BU_Reporting__c>();
        cont2.Bn_rep_DelList.add(benrep2); 
        cont2.deletebenifit();
        cont2.save();

        cont2.cancel();

        //cont2.hideedit = false;
        //cont2.getBusinessLine();
        cont2.hideedit = true;
        cont2.getBusinesslinelist();
        //cont2.getBusinessLine();
        
        delete conversions;
        cont2.getBusinesslinelist();
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    
    static testmethod void ImprovementMeasure2()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Monthly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;

         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;           
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.Bn_rep_AddList.add(benrep1); 
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }

    static testmethod void ImprovementMeasure3()
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
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 07, 01);   
         Date enddate = Date.newInstance(2013, 09, 30);
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
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;            
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.Bn_rep_AddList.add(benrep1);         
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    static testmethod void ImprovementMeasure4()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
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
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;            
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.Bn_rep_AddList.add(benrep1);         
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    
    static testmethod void ImprovementMeasure5()
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
        obj.Fiscal_Quarter__c = 'Q2';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
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
         benifit.Future_Start_Date__c = Date.newInstance(2013, 07, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 07, 31);         
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
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.Bn_rep_AddList.add(benrep1);         
        cont2.SelectedValue = 'GSM';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    
    static testmethod void ImprovementMeasure6()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q2';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Monthly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }

    static testmethod void ImprovementMeasure7()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q2';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.35 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.35 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    static testmethod void ImprovementMeasure8()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q2';
        obj.Fiscal_Year__c = '2014';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
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
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    
    static testmethod void ImprovementMeasure9()
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
        obj.Fiscal_Quarter__c = 'Q3';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 07, 01);   
         Date enddate = Date.newInstance(2013, 09, 31);
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
         benifit.Future_Start_Date__c = Date.newInstance(2013, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 10, 31);         
         benifit.Future_Operational_Manual_Amount__c = 500;
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = 'GSM';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    
    static testmethod void ImprovementMeasure10()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q3';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 07, 01);   
         Date enddate = Date.newInstance(2013, 09, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Monthly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 10, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }

    static testmethod void ImprovementMeasure11()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q3';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 07, 01);   
         Date enddate = Date.newInstance(2013, 09, 30);
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
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    static testmethod void ImprovementMeasure12()
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
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Check_DI_Approval_State__c = 'During DI5';
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
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
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    static testmethod void ImprovementMeasure13()
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
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Saving';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
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
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Future_Operational_Manual_Amount__c = 500;
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = 'GSM';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    
    static testmethod void ImprovementMeasure14()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Monthly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }

    static testmethod void ImprovementMeasure15()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 30);
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
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }
    static testmethod void ImprovementMeasure16()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
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
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }    
    static testmethod void ImprovementMeasure17()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 12, 31);
         benifit.Baseline_Quantity__c = NULL;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
         benifit.Planned_Quanity__c = NULL;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = NULL;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = NULL;
         benifit.Future_Start_Date__c = Date.newInstance(2014, 01, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2014, 01, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }    
    
    static testmethod void ImprovementMeasure18()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
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
         benifit.Planned_Start_Date__c = NULL;
         benifit.Planned_End_Date__c = NULL;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = NULL;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = NULL;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = NULL;
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = NULL;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }    
    static testmethod void ImprovementMeasure19()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 12, 01);   
         Date enddate = Date.newInstance(2013, 10, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = startdate ;
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = enddate ;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }         
    static testmethod void ImprovementMeasure20()
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
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 12, 01);   
         Date enddate = Date.newInstance(2013, 10, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
         
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Operational_Manual_Amount__c = null;
         
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate ;
         benifit.Achieved_Operational_Manual_Amount__c = null;
         
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 09, 20);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = enddate ; 
         benifit.Future_Operational_Manual_Amount__c = null;
                 
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'No' ;
         
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }    
    static testmethod void ImprovementMeasure21()
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
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 12, 01);   
         Date enddate = Date.newInstance(2013, 10, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
         
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Financial_Manual_Amount__c = null;
         
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate ;
         benifit.Achieved_Financial_Manual_Amount__c = null;
         
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 09, 20);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = enddate ; 
         benifit.Future_Financial_Manual_Amount__c = null;
                 
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    } 
    static testmethod void ImprovementMeasure22()
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
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Benefit_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 12, 01);   
         Date enddate = Date.newInstance(2013, 10, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
         
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Financial_Manual_Amount__c = null;
         
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate ;
         benifit.Achieved_Financial_Manual_Amount__c = null;
         
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 09, 20);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = enddate ; 
         benifit.Future_Financial_Manual_Amount__c = null;
                 
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }  
   
    static testmethod void ImprovementMeasure23()
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
        obj.Fiscal_Quarter__c = 'Q4';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Benefit_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.43;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 12, 01);   
         Date enddate = Date.newInstance(2013, 10, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Quarterly Rate' ;
         
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Financial_Manual_Amount__c = null;
         
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate ;
         benifit.Achieved_Financial_Manual_Amount__c = null;
         
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 09, 20);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = enddate ; 
         benifit.Future_Financial_Manual_Amount__c = null;
                 
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.ConversionId = conversions.id;
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        cont2.GoBackToSearch();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        //QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }             
    
    static testmethod void ImprovementMeasure24()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Distributed Amount' ;
         benifit.Baseline_Period_weeks__c = null;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        //cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }               
    
    static testmethod void ImprovementMeasure25()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = null;
         benifit.Baseline_Period_weeks__c = null;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        //cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }            
    static testmethod void ImprovementMeasure26()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = null;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }    
    
    static testmethod void ImprovementMeasure27()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = null;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        //cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    } 
    
        static testmethod void ImprovementMeasure28()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'K Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = null;
         benifit.Type_of_Measure__c = null;
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = null;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    } 
    
        static testmethod void ImprovementMeasure29()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = null;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 150;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }     
       
    static testmethod void ImprovementMeasure30()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = null;
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 150;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }        
       
    static testmethod void ImprovementMeasure31()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = null;
         benifit.Type_of_Measure__c = null;
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = null;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }           
    
    static testmethod void ImprovementMeasure32()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = null;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }              

       static testmethod void ImprovementMeasure33()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }       
    
   static testmethod void ImprovementMeasure34()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         insert benifit;
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }        
   static testmethod void ImprovementMeasure36()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();


        benifit.Planned_Financial_Manual_Amount__c = 500.0;

        
        benifit.Achieved_Financial_Manual_Amount__c = 780.0;

                
        benifit.Future_Financial_Manual_Amount__c =  780.0;

                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }       
       static testmethod void ImprovementMeasure37()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();



        benifit.Planned_Financial_Automatic_Amount__c = 500.0;
        benifit.Planned_Financial_Manual_Amount__c = 6000;
        benifit.Planned_Operational_Automatic_Amount__c = 7000;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = 500.0;
        benifit.Achieved_Financial_Manual_Amount__c = 500.0;
        benifit.Achieved_Operational_Automatic_Amount__c = 500.0;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = 500.0;
        benifit.Future_Financial_Manual_Amount__c = 500.0;
        benifit.Future_Operational_Automatic_Amount__c = 500.0;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  

                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }       
       static testmethod void ImprovementMeasure38()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();



        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = 6000;
        benifit.Planned_Operational_Automatic_Amount__c = 7000;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = 500.0;
        benifit.Achieved_Operational_Automatic_Amount__c = 500.0;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = 500.0;
        benifit.Future_Operational_Automatic_Amount__c = 500.0;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  

                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }       
   static testmethod void ImprovementMeasure39()
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
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;           
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        cont2.save();
        cont2.Bn_rep_AddList.add(benrep1); 

        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = 7000;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = 500.0;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = 500.0;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
         
        
        Test.stopTest();
       
    }     
    static testmethod void ImprovementMeasure40()
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
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = 'During DI3';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
          
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Automatic';
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
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         
         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;    
        
         QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Benefit_Condition__c = 'Achieved';
         benrep2.Quarters__c = 'Q1';                           
         benrep2.Years__c = '2014';  
         benrep2.Benefit_Savings_Amount__c = 100;   
         insert benrep2; 
        
         QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Benefit_Condition__c = 'Future';
         benrep3.Quarters__c = 'Q1';                           
         benrep3.Years__c = '2014';  
         benrep3.Benefit_Savings_Amount__c = 100;   
         insert benrep3; 
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        cont2.Bn_rep_AddList.add(benrep1);
        cont2.Bn_rep_AddList.add(benrep2);
        cont2.Bn_rep_AddList.add(benrep3);
        cont2.save();
        
        
        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = null;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = null;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = null;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        
        cont2.AddRow();
        //cont2.rowNum  = 1;
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();
        
        //cont2.getBusinesslinelist();
        
        QIPP_GenerateQuarterWiseReport.CreateRC(benifit.Id , 250000 , benifit.Achieved_Start_Date__c , benifit.Achieved_End_Date__c  , 'MBB' , 'Indirect Financial' , 'A3 Test1' , 'Portfolio # 1' , 'Test','','','','','','' , '' , '' , '' , '' , '' , '','');
        QIPP_GenerateQuarterWiseReport.getRemainDaysinMonths(benifit.Achieved_Start_Date__c,'Y');        
        
        
        PageReference pageRef1 = new PageReference('/apex/QIPP_Benefit?convId='+conversions.id+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
        Test.setCurrentPage(pageRef1);
        
        
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont3= new QIPP_BenefitController(con3);
        
        Test.stopTest();

    }  
    
    
    // new methods for Aug 14 work.....
    
    static testmethod void ImprovementMeasure1new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = null;
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;

    // insert Benefit Conversion Rate
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Weekly Rate';
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'No' ;
         
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
         
    // insert Benefit Reporting

         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;    
        
         QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Benefit_Condition__c = 'Achieved';
         benrep2.Quarters__c = 'Q1';                           
         benrep2.Years__c = '2014';  
         benrep2.Benefit_Savings_Amount__c = 100;   
         insert benrep2; 
        
         QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Benefit_Condition__c = 'Future';
         benrep3.Quarters__c = 'Q1';                           
         benrep3.Years__c = '2014';  
         benrep3.Benefit_Savings_Amount__c = 100;   
         insert benrep3; 
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        cont2.Bn_rep_AddList.add(benrep1);
        cont2.Bn_rep_AddList.add(benrep2);
        cont2.Bn_rep_AddList.add(benrep3);
        cont2.save();
        
        
        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = null;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = null;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = null;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        cont2.AddRow();
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();

        PageReference pageRef1 = new PageReference('/apex/QIPP_Benefit?convId='+conversions.id+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
        Test.setCurrentPage(pageRef1);
        cont2.ReferURL = 'https://cs11.salesforce.com/'+benifit.Project_ID__c+'';

        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont3= new QIPP_BenefitController(con3);
        
        
        
        Test.stopTest();

    }     
    
     static testmethod void ImprovementMeasure2new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
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
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;

    // insert Benefit Conversion Rate
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
    
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Financial Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         benifit.Baseline_Quantity__c = null;
         benifit.Type_of_Measure__c = null;
         benifit.Baseline_Period_weeks__c = 15;
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         
    
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        
            System.Debug('########## Benefit ############# ' + benifit);
            ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
            QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
            cont2.SelectedValue = '-Select-';
            
            
            cont2.save();
            
            
            benifit.Planned_Financial_Automatic_Amount__c = null;
            benifit.Planned_Financial_Manual_Amount__c = null;
            benifit.Planned_Operational_Automatic_Amount__c = null;
            benifit.Planned_Operational_Manual_Amount__c = 8000;        

            benifit.Achieved_Financial_Automatic_Amount__c = null;
            benifit.Achieved_Financial_Manual_Amount__c = null;
            benifit.Achieved_Operational_Automatic_Amount__c = null;
            benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

            benifit.Future_Financial_Automatic_Amount__c = null;
            benifit.Future_Financial_Manual_Amount__c = null;
            benifit.Future_Operational_Automatic_Amount__c = null;
            benifit.Future_Operational_Manual_Amount__c = 500.0;  
                    
            upsert benifit;

            cont2.deletebenifit();
            cont2.cancel();
            cont2.AddRow();
            Apexpages.currentpage().getParameters().put('index','1');       
            cont2.cloneRow();
            cont2.delRow();

            PageReference pageRef1 = new PageReference('/apex/QIPP_Benefit?convId='+conversions.id+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
            Test.setCurrentPage(pageRef1);
            cont2.ReferURL = 'https://cs11.salesforce.com/'+benifit.Project_ID__c+'';

            System.Debug('########## Benefit ############# ' + benifit);
            ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
            QIPP_BenefitController cont3= new QIPP_BenefitController(con3);
        
        Test.stopTest();

    }
    static testmethod void ImprovementMeasure3new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = 'During DI3';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;

    // insert Benefit Conversion Rate
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 06, 30);
         
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Distributed Amount';
         benifit.Baseline_Period_weeks__c = null;
         
         benifit.Planned_Quanity__c = 200;
         benifit.Planned_Type_of_Measure__c = null;
         benifit.Planned_Benefit_Period_Weeks__c = 4.35;
         
         benifit.Revised_Forecast_Quanity__c = 400;
         benifit.Revised_Forecast_Type_of_Measure__c = null;
         benifit.Revised_Forecast_Benefit_Period_Weeks__c = null;
         
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         
    // insert Benefit Reporting

         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Savings_Amount__c = 100;   
         insert benrep1;    
        
         QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Benefit_Condition__c = 'Achieved';
         benrep2.Quarters__c = 'Q1';                           
         benrep2.Years__c = '2014';  
         benrep2.Benefit_Savings_Amount__c = 100;   
         insert benrep2; 
        
         QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Benefit_Condition__c = 'Future';
         benrep3.Quarters__c = 'Q1';                           
         benrep3.Years__c = '2014';  
         benrep3.Benefit_Savings_Amount__c = 100;   
         insert benrep3; 
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        cont2.Bn_rep_AddList.add(benrep1);
        cont2.Bn_rep_AddList.add(benrep2);
        cont2.Bn_rep_AddList.add(benrep3);
        cont2.save();
        
        
        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = null;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = null;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = null;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        cont2.AddRow();
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();

        PageReference pageRef1 = new PageReference('/apex/QIPP_Benefit?convId='+conversions.id+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
        Test.setCurrentPage(pageRef1);
        cont2.ReferURL = 'https://cs11.salesforce.com/'+benifit.Project_ID__c+'';

        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont3= new QIPP_BenefitController(con3);
        
        
        
        Test.stopTest();

    }     
    
    static testmethod void ImprovementMeasure4new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = null;
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Financial Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;

    // insert Benefit Conversion Rate
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 10, 01);   
         Date enddate = Date.newInstance(2013, 11, 20);
         
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Distributed Amount';
         benifit.Baseline_Period_weeks__c = 0;
         
         benifit.Planned_Quanity__c = null;
         benifit.Planned_Type_of_Measure__c = 'Distributed Amount';
         benifit.Planned_Benefit_Period_Weeks__c = null;
         
         benifit.Revised_Forecast_Quanity__c = null;
         benifit.Revised_Forecast_Type_of_Measure__c = 'Distributed Amount';
         benifit.Revised_Forecast_Benefit_Period_Weeks__c = null;
         
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'No' ;
         
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
         
    // insert Benefit Reporting

         QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = null;                           
         benrep1.Years__c = null;
         benrep1.Months__c = null;
         benrep1.Benefit_Savings_Amount__c = null;   
         insert benrep1;    
        
         QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Benefit_Condition__c = null;
         benrep2.Quarters__c = 'Q1';                           
         benrep2.Years__c = null; 
         benrep2.Months__c = null;       
         benrep2.Benefit_Savings_Amount__c = null;   
         insert benrep2; 
        
         QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Benefit_Condition__c = null;
         benrep3.Quarters__c = null;                           
         benrep3.Years__c = '2014';  
         benrep3.Months__c = null;               
         benrep3.Benefit_Savings_Amount__c = null;   
         insert benrep3; 
         
         QIPP_BU_Reporting__c benrep33 = new QIPP_BU_Reporting__c ();
         benrep33.Project_ID__c = project.id;
         benrep33.Benefit_ID__c = benifit.id;
         benrep33.Benefit_Condition__c = null;
         benrep33.Quarters__c = null;                           
         benrep33.Years__c = null;  
         benrep33.Months__c = '01';              
         benrep33.Benefit_Savings_Amount__c = null;   
         insert benrep33; 
         
        QIPP_BU_Reporting__c benrep4 = new QIPP_BU_Reporting__c ();
         benrep4.Project_ID__c = project.id;
         benrep4.Benefit_ID__c = benifit.id;
         benrep4.Benefit_Condition__c = null;
         benrep4.Quarters__c = null;                           
         benrep4.Years__c = null; 
         benrep4.Months__c = null;       
         benrep4.Benefit_Savings_Amount__c = 500;   
         insert benrep4; 
        
        QIPP_BU_Reporting__c benrep5 = new QIPP_BU_Reporting__c ();
         benrep5.Project_ID__c = project.id;
         benrep5.Benefit_ID__c = benifit.id;
         benrep5.Benefit_Condition__c = 'Planned';
         benrep5.Quarters__c = 'Q1';                           
         benrep5.Years__c = '2014';  
         benrep5.Months__c = null;
         benrep5.Benefit_Savings_Amount__c = 500;   
         insert benrep5; 
         
        QIPP_BU_Reporting__c benrep6 = new QIPP_BU_Reporting__c ();
         benrep6.Project_ID__c = project.id;
         benrep6.Benefit_ID__c = benifit.id;
         benrep6.Benefit_Condition__c = 'Planned';
         benrep6.Quarters__c = 'Q1';                           
         benrep6.Years__c = '2014';  
         benrep6.Months__c = null;
         benrep6.Benefit_Savings_Amount__c = 678;    
         insert benrep6; 
         
        QIPP_BU_Reporting__c benrep7 = new QIPP_BU_Reporting__c ();
         benrep7.Project_ID__c = project.id;
         benrep7.Benefit_ID__c = benifit.id;
         benrep7.Benefit_Condition__c = 'Planned';
         benrep7.Quarters__c = 'Q1';                           
         benrep7.Years__c = '2014'; 
         benrep7.Months__c = '01';
         benrep7.Benefit_Savings_Amount__c = 56;   
         insert benrep7; 
         
        QIPP_BU_Reporting__c benrep8 = new QIPP_BU_Reporting__c ();
         benrep8.Project_ID__c = project.id;
         benrep8.Benefit_ID__c = benifit.id;
         benrep8.Benefit_Condition__c = 'Planned';
         benrep8.Quarters__c = 'Q1';                           
         benrep8.Years__c = '2014';  
         benrep8.Months__c = '01';
         benrep8.Benefit_Savings_Amount__c = 500;   
         insert benrep8;    
        
        QIPP_BU_Reporting__c benrep9 = new QIPP_BU_Reporting__c ();
         benrep9.Project_ID__c = project.id;
         benrep9.Benefit_ID__c = benifit.id;
         benrep9.Benefit_Condition__c = 'Planned';
         benrep9.Quarters__c = 'Q2';                           
         benrep9.Years__c = '2014';  
         benrep9.Months__c = null;
         benrep9.Benefit_Savings_Amount__c = 500;   
         insert benrep9; 
         
        QIPP_BU_Reporting__c benrep10 = new QIPP_BU_Reporting__c ();
         benrep10.Project_ID__c = project.id;
         benrep10.Benefit_ID__c = benifit.id;
         benrep10.Benefit_Condition__c = 'Planned';
         benrep10.Quarters__c = 'Q2';                           
         benrep10.Years__c = '2014';  
         benrep10.Months__c = null;
         benrep10.Benefit_Savings_Amount__c = 678;    
         insert benrep10; 
         
         QIPP_BU_Reporting__c benrep11 = new QIPP_BU_Reporting__c ();
         benrep11.Project_ID__c = project.id;
         benrep11.Benefit_ID__c = benifit.id;
         benrep11.Benefit_Condition__c = 'Planned';
         benrep11.Quarters__c = 'Q3';                           
         benrep11.Years__c = '2014';  
         benrep11.Months__c = null;
         benrep11.Benefit_Savings_Amount__c = 678;    
         insert benrep11; 
         
         QIPP_BU_Reporting__c benrep12 = new QIPP_BU_Reporting__c ();
         benrep12.Project_ID__c = project.id;
         benrep12.Benefit_ID__c = benifit.id;
         benrep12.Benefit_Condition__c = 'Planned';
         benrep12.Quarters__c = 'Q3';                           
         benrep12.Years__c = '2014';  
         benrep12.Months__c = null;
         benrep12.Benefit_Savings_Amount__c = 678;    
         insert benrep12; 
         
         QIPP_BU_Reporting__c benrep13 = new QIPP_BU_Reporting__c ();
         benrep13.Project_ID__c = project.id;
         benrep13.Benefit_ID__c = benifit.id;
         benrep13.Benefit_Condition__c = 'Planned';
         benrep13.Quarters__c = 'Q3';                           
         benrep13.Years__c = '2014';  
         benrep13.Months__c = null;
         benrep13.Benefit_Savings_Amount__c = 678;    
         insert benrep13; 
         
         QIPP_BU_Reporting__c benrep14 = new QIPP_BU_Reporting__c ();
         benrep14.Project_ID__c = project.id;
         benrep14.Benefit_ID__c = benifit.id;
         benrep14.Benefit_Condition__c = 'Planned';
         benrep14.Quarters__c = 'Q3';                           
         benrep14.Years__c = '2014';  
         benrep14.Months__c = null;
         benrep14.Benefit_Savings_Amount__c = 678;    
         insert benrep14;
         
         QIPP_BU_Reporting__c benrep15 = new QIPP_BU_Reporting__c ();
         benrep15.Project_ID__c = project.id;
         benrep15.Benefit_ID__c = benifit.id;
         benrep15.Benefit_Condition__c = 'Planned';
         benrep15.Quarters__c = 'Q4';                           
         benrep15.Years__c = '2014';  
         benrep15.Months__c = null;
         benrep15.Benefit_Savings_Amount__c = 678;    
         insert benrep15; 
         
         QIPP_BU_Reporting__c benrep16 = new QIPP_BU_Reporting__c ();
         benrep16.Project_ID__c = project.id;
         benrep16.Benefit_ID__c = benifit.id;
         benrep16.Benefit_Condition__c = 'Planned';
         benrep16.Quarters__c = 'Q4';                           
         benrep16.Years__c = '2014';  
         benrep16.Months__c = null;
         benrep16.Benefit_Savings_Amount__c = 678;    
         insert benrep16;
         
         
         
         
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        cont2.Bn_rep_AddList.add(benrep1);
        cont2.Bn_rep_AddList.add(benrep2);
        cont2.Bn_rep_AddList.add(benrep3);
        cont2.Bn_rep_AddList.add(benrep33);
        cont2.Bn_rep_AddList.add(benrep4);
        cont2.Bn_rep_AddList.add(benrep5);
        cont2.Bn_rep_AddList.add(benrep6);
        cont2.Bn_rep_AddList.add(benrep7);
        cont2.Bn_rep_AddList.add(benrep9);
        cont2.Bn_rep_AddList.add(benrep10);
        cont2.Bn_rep_AddList.add(benrep11);
        cont2.Bn_rep_AddList.add(benrep12);
        cont2.Bn_rep_AddList.add(benrep13);
        cont2.Bn_rep_AddList.add(benrep14);
        cont2.Bn_rep_AddList.add(benrep15);
        cont2.Bn_rep_AddList.add(benrep16);
        cont2.save();
        
        
        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = null;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = null;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = null;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        cont2.AddRow();
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();

        PageReference pageRef1 = new PageReference('/apex/QIPP_Benefit?convId='+conversions.id+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
        Test.setCurrentPage(pageRef1);
        cont2.ReferURL = 'https://cs11.salesforce.com/'+benifit.Project_ID__c+'';

        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont3= new QIPP_BenefitController(con3);
        
        
        
        Test.stopTest();

    } 
    
    static testmethod void ImprovementMeasure5new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = null;
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;

    // insert Benefit Conversion Rate
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 07, 01);   
         Date enddate = Date.newInstance(2013, 08, 20);
         
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Distributed Amount';
         benifit.Baseline_Period_weeks__c = 0;
         
         benifit.Planned_Quanity__c = 567;
         benifit.Planned_Type_of_Measure__c = 'Distributed Amount';
         benifit.Planned_Benefit_Period_Weeks__c = 0;
         
         benifit.Revised_Forecast_Quanity__c = 567;
         benifit.Revised_Forecast_Type_of_Measure__c = 'Distributed Amount';
         benifit.Revised_Forecast_Benefit_Period_Weeks__c = 0;
         
         
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 08, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 09, 31);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         
    
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        
        cont2.save();
        
        
        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = null;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = null;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = null;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;

        cont2.deletebenifit();
        cont2.cancel();
        cont2.AddRow();
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();

        PageReference pageRef1 = new PageReference('/apex/QIPP_Benefit?convId='+conversions.id+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
        Test.setCurrentPage(pageRef1);
        cont2.ReferURL = 'https://cs11.salesforce.com/'+benifit.Project_ID__c+'';

        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont3= new QIPP_BenefitController(con3);
        
        
        
        Test.stopTest();

    }
    
    static testmethod void ImprovementMeasure6new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = null;
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Automatic';
        INSERT conversions;

    // insert Benefit Conversion Rate
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Lower is Favorable' ;
         Date startdate = Date.newInstance(2013, 02, 01);   
         Date enddate = Date.newInstance(2013, 03, 20);
         
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Distributed Amount';
         benifit.Baseline_Period_weeks__c = 1;
         
         benifit.Planned_Quanity__c = 567;
         benifit.Planned_Type_of_Measure__c = 'Distributed Amount';
         benifit.Planned_Benefit_Period_Weeks__c = 1;
         
         benifit.Revised_Forecast_Quanity__c = 567;
         benifit.Revised_Forecast_Type_of_Measure__c = 'Distributed Amount';
         benifit.Revised_Forecast_Benefit_Period_Weeks__c = 1;
         
         
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 02, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 03, 21);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         //benifit.Benefit_Type__c = 'Operational Savings'
         insert benifit;
         
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2011';
         benrep1.Months__c = '02';
         benrep1.Benefit_Savings_Amount__c = 345;   
         insert benrep1;    
        
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
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        cont2.Bn_rep_AddList.clear();
        cont2.Bn_rep_AddList.add(benrep1);
        cont2.Bn_rep_AddList.add(benrep2);
        cont2.Bn_rep_AddList.add(benrep3);
        
        cont2.getBusinesslinelist();
        cont2.save();
        cont2.Bn_rep_DelList.add(benrep2);
        
        benifit.Planned_Financial_Automatic_Amount__c = null;
        benifit.Planned_Financial_Manual_Amount__c = null;
        benifit.Planned_Operational_Automatic_Amount__c = null;
        benifit.Planned_Operational_Manual_Amount__c = 8000;        

        benifit.Achieved_Financial_Automatic_Amount__c = null;
        benifit.Achieved_Financial_Manual_Amount__c = null;
        benifit.Achieved_Operational_Automatic_Amount__c = null;
        benifit.Achieved_Operational_Manual_Amount__c = 500.0;  

        benifit.Future_Financial_Automatic_Amount__c = null;
        benifit.Future_Financial_Manual_Amount__c = null;
        benifit.Future_Operational_Automatic_Amount__c = null;
        benifit.Future_Operational_Manual_Amount__c = 500.0;  
                
        upsert benifit;
        cont2.isDirectedFromView = false;
        cont2.deletebenifit();
        cont2.cancel();
        cont2.AddRow();
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();
        cont2.GoBackToSearch();

        Test.stopTest();

    }
    static testmethod void ImprovementMeasure7new()
    {
    
    // insert Dummy User
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

    // insert Contacts__c
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        insert con;

    // insert portfolio
        
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

    // insert project
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Check_DI_Approval_State__c = null;
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
    
    // insert Improvement_Measure
    
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
 		
        QIPP_Benefit_Conversion_Table__c conversions2 = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions2.Name = 'NCDR2';
        conversions2.Benefit_Type__c = 'Financial Savings';
        conversions2.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions2;
    // insert Benefit Conversion Rate
        
        
        
    // insert Benefit 
         QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Euro';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable';
         Date startdate = Date.newInstance(2013, 04, 01);   
         Date enddate = Date.newInstance(2013, 05, 22);
         
         benifit.Baseline_Quantity__c = 100;
         benifit.Type_of_Measure__c = 'Distributed Amount';
         benifit.Baseline_Period_weeks__c = 1;
         
         benifit.Planned_Quanity__c = 567;
         benifit.Planned_Type_of_Measure__c = 'Distributed Amount';
         benifit.Planned_Benefit_Period_Weeks__c = 1;
         
         benifit.Revised_Forecast_Quanity__c = 567;
         benifit.Revised_Forecast_Type_of_Measure__c = 'Distributed Amount';
         benifit.Revised_Forecast_Benefit_Period_Weeks__c = 1;
         
         
         benifit.Planned_Start_Date__c = startdate;
         benifit.Planned_End_Date__c = null ;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 10, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 11, 26);         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         benifit.Invoke_Benefit_Override_Approve__c = 'Yes' ;
         
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
         //benifit.Benefit_Type__c = 'Operational Savings'
         insert benifit;
         
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
         benrep1.Project_ID__c = project.id;
         benrep1.Benefit_ID__c = benifit.id;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';                           
         benrep1.Years__c = '2011';
         benrep1.Months__c = '02';
         benrep1.Benefit_Savings_Amount__c = 345;   
         insert benrep1;    
        
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
        
        PageReference pageRef = new PageReference('/apex/QIPP_Benefit?id='+benifit.id+'&id='+benifit.Project_ID__c+'&retURL=%2F'+benifit.Project_ID__c+'&scontrolCaching=1&sfdc.override=1');
        Test.setCurrentPage(pageRef);
     
        Test.startTest();   
        System.Debug('########## Benefit ############# ' + benifit);
        ApexPages.StandardController con2 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont2= new QIPP_BenefitController(con2);
        cont2.SelectedValue = '-Select-';
        
        cont2.Bn_rep_AddList.clear();
        cont2.Bn_rep_AddList.add(benrep1);
        cont2.Bn_rep_AddList.add(benrep2);
        cont2.Bn_rep_AddList.add(benrep3);
        
        cont2.getBusinesslinelist();
       	cont2.Bn_rep_DelList.add(benrep2);
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();
        cont2.save();
        upsert benifit;
        cont2.isDirectedFromView = false;
        //cont2.deletebenifit();
        cont2.cancel();
        cont2.AddRow();
        cont2.Bn_rep_DelList.add(benrep2);
        Apexpages.currentpage().getParameters().put('index','1');       
        cont2.cloneRow();
        cont2.delRow();
        cont2.GoBackToSearch();
		
        //benifit.Improvement_Measure_KPI__c = '';
        update benifit;
        ApexPages.StandardController con3 = new ApexPages.StandardController(benifit);
        QIPP_BenefitController cont3 = new QIPP_BenefitController(con3);
		project.KPI_Benefits_Validation_State__c = 'With Operational Savings Approver to Validate';
        project.KPI_Benefits_Validation_State__c = 'Validation Complete';
        update project;
        update benifit;
        cont3.save();
        
        benifit.Improvement_Measure_KPI__c = conversions2.id; 
        project.CoPQ_Benefits_Validation_State__c = 'With Finance Approver to Validate';
        project.CoPQ_Benefits_Validation_State__c = 'Validation Complete';

        update project;
        update benifit;
        cont3.save();
        benifit.Benefit_Override_Status__c = 'Awaiting Approval2';
        cont2.getBusinesslinelist();
        
        cont2.deletebenifit();
        Test.stopTest();

    }   

}