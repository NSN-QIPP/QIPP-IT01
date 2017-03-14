@isTest
private class QIPP_Divide_Quarterly_To_Monthly_Test
{
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;

    static testmethod void monthlyDistributionInsert()
    {
        User usr = new User();
        usr.LastName = 'sreeramoju';
        usr.FirstName = 'subhash';
        usr.Alias = 'sreerasu';
        usr.Email = 'subhash.sreeramoju@igate.com';
        usr.Username = 'subhash.sreeramoju@igate.com.test';
        usr.CommunityNickname = 's';
        usr.IsActive = TRUE;
        usr.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        usr.TimeZoneSidKey = 'Asia/Kamchatka';
        usr.LocaleSidKey = 'en_US';
        usr.EmailEncodingKey = 'ISO-8859-1';
        usr.LanguageLocaleKey = 'en_US';
        insert usr;
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Subhash';
        con.Email__c = 'subhash.sreeramoju@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.Contact_BU__c = 'CFO Functions';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio1';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = usr.Id;
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
        project.Project_State__c = 'On hold';
        project.Project_Lead__c = con.id;
        project.ownerid = usr.Id;
        insert project;
        
        QIPP_Benefit_Conversion_Table__c convTable = new QIPP_Benefit_Conversion_Table__c();
        convTable.Benefit_Type__c = 'Operational Savings';
        convTable.Benefit_Type_Override__c = 'Financial Savings';
        convTable.Financial_Type_Override__c = 'Direct Financial';
        convTable.Impacted_P_L_Line__c = 'R&D Budget';
        convTable.Impacted_P_L_Line_Override__c = 'Cost of Sales';
        convTable.CoPQ_Type__c = 'Non-Financial';
        insert convTable;
        
        QIPP_Benefit__c benefit = new QIPP_Benefit__c();
        benefit.Baseline_Rate_N__c = 100;
        benefit.Benefit_Type__c = 'Operational Savings';
        benefit.Financial_Type__c = 'Non-Financial';       
        benefit.Business_Line__c = 'GSM';
        benefit.Unit_of_Measure__c = 'Each';
        benefit.Baseline_Period_weeks__c = 4.43;
        benefit.Directional_Indicator__c = 'Lower is Favorable' ;
        Date startdate = Date.newInstance(2013, 10, 01);   
        Date enddate = Date.newInstance(2013, 12, 31);
        benefit.Baseline_Quantity__c = 15;
        benefit.Type_of_Measure__c = 'Weekly Rate' ;
        benefit.Planned_Benefit_Period_Weeks__c = 4.33;
        benefit.Basis__c = '' ;
        benefit.Actual_Actual_Benefit_Start__c = startdate  ;
        benefit.Unit_of_Measure__c = 'Each';
        benefit.Project_ID__c = project.Id;
        benefit.Improvement_Measure_KPI__c = convTable.id;
        benefit.Invoke_Benefit_Override__c = 'No';
        benefit.Invoke_Benefit_Override_Approve__c = 'No';
        benefit.Invoke_Benefit_Override_Reject__c = 'No';
        benefit.Invoke_Benefit_Override_Reset__c = 'No';
        benefit.Planned_Operational_Manual_Amount__c = 90;
        benefit.Achieved_Operational_Manual_Amount__c = 90;
        benefit.Future_Operational_Manual_Amount__c = 90;
        benefit.Planned_Operational_Automatic_Amount__c = 90;
        benefit.Achieved_Operational_Automatic_Amount__c = 90;
        benefit.Future_Operational_Automatic_Amount__c = 90;
        benefit.Planned_Operational_Savings_Total__c = 90;
        benefit.Achieved_Operational_Savings_Total__c = 90;
        benefit.Future_Operational_Savings_Total__c = 90;
        benefit.Benefit_Override_Status__c = '';
        benefit.Benefit_Operational_Achieved_Future_k__c = 180;
        insert benefit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benefit.id;
        benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;    
        
        QIPP_BU_Reporting__c benrep2 = new QIPP_BU_Reporting__c ();
        benrep2.Project_ID__c = project.id;
        benrep2.Benefit_ID__c = benefit.id;
        benrep2.Benefit_Condition__c = 'Achieved';
        benrep2.Quarters__c = 'Q1';                           
        benrep2.Years__c = '2014';  
        benrep2.Benefit_Savings_Amount__c = 100;   
        insert benrep2; 
        
        QIPP_BU_Reporting__c benrep3 = new QIPP_BU_Reporting__c ();
        benrep3.Project_ID__c = project.id;
        benrep3.Benefit_ID__c = benefit.id;
        benrep3.Benefit_Condition__c = 'Future';
        benrep3.Quarters__c = 'Q1';                           
        benrep3.Years__c = '2014';  
        benrep3.Benefit_Savings_Amount__c = 100;   
        insert benrep3;
        
        QIPP_BU_Reporting__c benrep4 = new QIPP_BU_Reporting__c ();
        benrep4.Project_ID__c = project.id;
        benrep4.Benefit_ID__c = benefit.id;
        benrep4.Benefit_Condition__c = 'Future';
        benrep4.Quarters__c = 'Q2';                           
        benrep4.Years__c = '2014';  
        benrep4.Benefit_Savings_Amount__c = 100;   
        insert benrep4;
        
        QIPP_BU_Reporting__c benrep5 = new QIPP_BU_Reporting__c ();
        benrep5.Project_ID__c = project.id;
        benrep5.Benefit_ID__c = benefit.id;
        benrep5.Benefit_Condition__c = 'Future';
        benrep5.Quarters__c = 'Q3';                           
        benrep5.Years__c = '2014';  
        benrep5.Benefit_Savings_Amount__c = 100;   
        insert benrep5;
        
        QIPP_BU_Reporting__c benrep6 = new QIPP_BU_Reporting__c ();
        benrep6.Project_ID__c = project.id;
        benrep6.Benefit_ID__c = benefit.id;
        benrep6.Benefit_Condition__c = 'Future';
        benrep6.Quarters__c = 'Q4';                           
        benrep6.Years__c = '2014';  
        benrep6.Benefit_Savings_Amount__c = 100;   
        insert benrep6;                        
        
        benrep1.Benefit_Condition__c = 'Achieved';
        benrep1.Quarters__c = 'Q2';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 200;
        benrep1.Entry_Type__c = 'User Entry';   
        update benrep1; 
        
        benrep1.Benefit_Condition__c = 'Achieved';
        benrep1.Quarters__c = 'Q3';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 300;  
        benrep1.Entry_Type__c = 'User Entry';            
        update benrep1; 
        
        benrep1.Benefit_Condition__c = 'Achieved';
        benrep1.Quarters__c = 'Q4';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 400; 
        benrep1.Entry_Type__c = 'User Entry';             
        update benrep1;                 
        
        benrep2.Benefit_Condition__c = 'Achieved';
        benrep2.Quarters__c = 'Q1';                           
        benrep2.Years__c = '2015';  
        benrep2.Benefit_Savings_Amount__c = 400; 
        benrep2.Entry_Type__c = 'User Entry';             
        update benrep2;           
    }
}