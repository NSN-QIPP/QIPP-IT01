@istest
public class QIPP_Benefits_RelatedList_Cont_Test {
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
    static testmethod void QIPP_Benefits_RelatedList_Controller_1(){    	
        User usr = new User();
        usr.LastName = 'V';
        usr.FirstName = 'Srikanth';
        usr.Alias = 'Sreev';
        usr.Email = 'srikanth.v@igate.com';
        usr.Username = 'srikanth.v@igate.com.test';
        usr.CommunityNickname = 's';
        usr.IsActive = TRUE;
        usr.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        usr.TimeZoneSidKey = 'Asia/Kamchatka';
        usr.LocaleSidKey = 'en_US';
        usr.EmailEncodingKey = 'ISO-8859-1';
        usr.LanguageLocaleKey = 'en_US';
        insert usr;
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Srikanth';
        con.Email__c = 'srikanth.v@igate.com';
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
        //benefit.Project_ID__c =  [SELECT Id,name FROM QIPP_Project__c WHERE name like '%PRJ%' LIMIT 1].Id;
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
        
        Test.startTest();         
        System.runAs(usr)
        { 
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(project);
        QIPP_Benefits_RelatedList_Controller RelController= new QIPP_Benefits_RelatedList_Controller(stdcontroller);
        }
        Test.stopTest();        
    }
    
}