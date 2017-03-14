@isTest
private class DMAICProjectCompleted_test{
     static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
     public static testMethod void testMyController() {
     
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
         benrep1.Improvement_Measure__c = conversions.name;
         benrep1.Benefit_Condition__c = 'Planned';
         benrep1.Quarters__c = 'Q1';  
         benrep1.month__c='1';
         benrep1.Years__c = '2014';  
         benrep1.Benefit_Type__c = 'Financial Savings';
         benrep1.Benefit_Savings_Amount__c = 100;  
         benrep1.Entry_Type__c = 'User Entry' ;
         benrep1.Achieved_Amount__c = '23';
         benrep1.Future_Saving_Amount__c = '45';
         insert benrep1;  
         
         QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
         benrep2.Project_ID__c = project.id;
         benrep2.Benefit_ID__c = benifit.id;
         benrep2.Improvement_Measure__c = conversions.name + '2';
         benrep2.Benefit_Condition__c = 'Planned';
         benrep2.Quarters__c = 'Q1';
         benrep2.month__c='1';
         benrep2.Years__c = '2014';  
         benrep2.Benefit_Type__c = 'Operational Savings';
         benrep2.Benefit_Savings_Amount__c = 100;  
         benrep2.Entry_Type__c = 'User Entry' ;
         benrep2.Achieved_Amount__c = '23';
         benrep2.Future_Saving_Amount__c = '45';
         insert benrep2;

		 QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
         benrep3.Project_ID__c = project.id;
         benrep3.Benefit_ID__c = benifit.id;
         benrep3.Improvement_Measure__c = conversions.name + '2';
         benrep3.Benefit_Condition__c = 'Planned';
         benrep3.Quarters__c = 'Q1';
         benrep3.month__c='1';
         benrep3.Years__c = '2014';  
         benrep3.Benefit_Type__c = 'Projected Revenue';
         benrep3.Benefit_Savings_Amount__c = 100;  
         benrep3.Entry_Type__c = 'User Entry' ;
         benrep3.Achieved_Amount__c = '23';
         benrep3.Future_Saving_Amount__c = '45';
         insert benrep3;

		 QIPP_BU_Reporting__c benrep4 = new QIPP_BU_Reporting__c ();
         benrep4.Project_ID__c = project.id;
         benrep4.Benefit_ID__c = benifit.id;
         benrep4.Improvement_Measure__c = conversions.name + '2';
         benrep4.Benefit_Condition__c = 'Planned';
         benrep4.Quarters__c = 'Q1';
         benrep4.month__c='1';
         benrep4.Years__c = '2014';  
         benrep4.Benefit_Type__c = 'Realized Revenue';
         benrep4.Benefit_Savings_Amount__c = 100;  
         benrep4.Entry_Type__c = 'User Entry' ;
         benrep4.Achieved_Amount__c = '23';
         benrep4.Future_Saving_Amount__c = '45';
         insert benrep4;		 
     
          
          DMAICProjectCompleted  controller1 = new DMAICProjectCompleted ();
          
          string id = project.id;
          controller1.projectId = id ;
          controller1.getBenftreps();
     
     }
    
    
}