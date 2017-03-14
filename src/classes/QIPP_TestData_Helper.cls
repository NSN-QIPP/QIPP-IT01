/* Test data methods available for below objects.
    .User
    .QIPP Contact
    .QIPP Contact list
    .Portfolio 
    .Project 
    .Project with record type
    .Benefit
    .Benefit Line items (QIPP_BU_Reporting)
    .Improvement Measure KPI (QIPP Benefit Conversion Table)
    .QIPP Task
    .Trigger Control (Custom Settings)
    
*/

public class QIPP_TestData_Helper{

    //public id STATIC_RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;

    public QIPP_TestData_Helper(){
    
    }
    
    public static User create_DummyUser(){
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
        return DummyUser;
    }
    
    public static QIPP_Contacts__c create_QIPP_Contact(String contactEmail){
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = contactEmail;        //'abhishek23.jagtap2@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        return con;
    }
 
    public static list<QIPP_Contacts__c> create_QIPP_Contact_list(String contactEmail,integer count){
        list<QIPP_Contacts__c> cons = new list<QIPP_Contacts__c>();
        for(integer i=0; i<=count; i++){
            QIPP_Contacts__c con = new QIPP_Contacts__c();
            con.Name = 'contact'+i;
            con.Email__c = contactEmail;        //'abhishek23.jagtap2@igate.com';
            con.Contact_State__c = 'Active';
            con.NSN_ID_Text__c = '12234345';
            cons.add(con);
        }
        return cons;
    }
 
    public static QIPP_Portfolio__c create_QIPP_Portfolio(Id contactId, Id dummyUserId){
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio1';
        portfolio.Portfolio_Owner__c = contactId;
        portfolio.ownerId = dummyUserId;
        portfolio.CDT_Lead__c = contactId;
        portfolio.CPVi_Composite__c = 25.0;
        portfolio.CPVi_Past__c = 29.0;
        portfolio.CPVi_Future__c = 55.0; 
        portfolio.CPV_Trend__c  = 'Up';
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        return portfolio;
    }

    public static QIPP_Project__c create_QIPP_Project(Id portfolioId, Id contactId, Id dummyUserId){
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolioId;
        //project.RecordTypeId = STATIC_RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = contactId;
        project.ownerid = dummyUserId;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Project_State__c = 'Complete';
        return project;
    }

    public static QIPP_Project__c create_QIPP_Project_with_recordtype(Id portfolioId, Id contactId, Id dummyUserId,string pryid){
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolioId;
        project.RecordTypeId = QIPP_TestData_Helper.recordtypeid(pryid);
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = contactId;
        project.ownerid = dummyUserId;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Project_State__c = 'Complete';
        return project;
    }
    
    public static QIPP_Benefit_Conversion_Table__c create_QIPP_Benefit_Conversion_Table(){
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        return conversions;
    }
 
    public static QIPP_Benefit_Conversion_Rate__c create_QIPP_Benefit_Conversion_Rate(Id benefitConversionTableId){
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = benefitConversionTableId;
        return obj;    
    }

    public static QIPP_Benefit__c create_QIPP_Benefit(Id benefitConversionTableId, Id projectId){
        Date startdate = Date.newInstance(2013, 01, 01);   
        Date enddate = Date.newInstance(2013, 03, 31);
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Financial_Type__c = 'Operational Savings';
        benifit.Business_Line__c = 'GSM';
        benifit.Improvement_Measure_KPI__c = benefitConversionTableId;         
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.35;
        benifit.Directional_Indicator__c = 'Higher is Favorable' ;
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Quanity__c = 500;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Planned_Start_Date__c = startdate;
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
        benifit.Project_ID__c = projectId;
        return benifit;
    }
    
    public static QIPP_BU_Reporting__c create_QIPP_BU_Reporting(Id projectId, Id benefitId, String benefitConversionName){
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = projectId;
        benrep1.Benefit_ID__c = benefitId;
        benrep1.Improvement_Measure__c = benefitConversionName;
        benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Type__c = 'Financial Savings';
        benrep1.Benefit_Savings_Amount__c = 100;  
        benrep1.Entry_Type__c = 'User Entry' ;
        benrep1.Achieved_Amount__c = '23';
        benrep1.Future_Saving_Amount__c = '45';
        return benrep1;
    }
/*
    public static QIPP_Task__c create_QIPP_Task(Id projectId, Id contactId){
        QIPP_Task__c task = new QIPP_Task__c();
        task.Project_ID__c = projectId;
        task.Task_Name_Succinct__c = 'Test_task';
        task.Task_Type__c = 'Milestone';
        task.Task_Initiator__c = contactId;
        task.Task_State__c = 'In Progress';
        return task;    
    }
   */   
    
    public static  Trigger_Control__c Trigger_Control(boolean run){
        Trigger_Control__c ts = new Trigger_Control__c();
        ts.Run_Triggers__c = run;
        //insert ts;
        return ts;
    }
    
    public static id recordtypeid(string ryid){
        id RTID = [select Id from RecordType where Name =:ryid and SobjectType = 'QIPP_Project__c'].Id;
        return  RTID;
    }
}