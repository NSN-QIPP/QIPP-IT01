@isTest
public class QIPPCDTReportTestClass 
{
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;

    public static testMethod void testMyController() 
    {
        test.startTest();
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
        con.Name = 'Abhishek Jagtap';
        con.Email__c = 'abhishek.jagtap@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12342235';
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
        
        QIPP_Task__c task = new   QIPP_Task__c();
        task.Task_Name_Succinct__c = 'Let Do Report1';
        task.Task_Type__c = 'RCA';
        task.Task_State__c =  'On hold';
        task.Project_ID__c = project.Id;
        task.Task_Initiator__c = con.id;
        task.Task_Percent_Complete__c = 50.0;
        insert task;
        
        QIPP_Task__c task1 = new   QIPP_Task__c();
        task1.Task_Name_Succinct__c = 'Let Do Report2';
        task1.Task_Type__c = 'RCA';
        task1.Task_State__c =  'On hold';
        task1.Project_ID__c = project.Id;
        task1.Task_Initiator__c = con.id;
        task1.Task_Percent_Complete__c = 40.0;
        insert task1;
        
        QIPP_Task__c task2 = new   QIPP_Task__c();
        task2.Task_Name_Succinct__c = 'Let Do Report3';
        task2.Task_Type__c = 'RCA';
        task2.Task_State__c =  'On hold';
        task2.Project_ID__c = project.Id;
        task2.Task_Initiator__c = con.id;
        task2.Task_Percent_Complete__c = 40.0;
        insert task2;

        QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.RecordTypeId = RTID_DMAIC;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project2';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'On hold';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        project1.ownerid = DummyUser.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project1;

        QIPP_Task__c task5 = new   QIPP_Task__c();
        task5.Task_Name_Succinct__c = 'Let Do Report4';
        task5.Task_Type__c = 'RCA';
        task5.Task_State__c =  'On hold';
        task5.Project_ID__c = project1.Id;
        task5.Task_Initiator__c = con.id;
        task5.Task_Percent_Complete__c = 40.0;
        insert task5;
        
        QIPP_Task__c task3 = new   QIPP_Task__c();
        task3.Task_Name_Succinct__c = 'Let Do Report5';
        task3.Task_Type__c = 'RCA';
        task3.Task_State__c =  'On hold';
        task3.Project_ID__c = project1.Id;
        task3.Task_Initiator__c = con.id;
        task3.Task_Percent_Complete__c = 40.0;
        insert task3;

        QIPP_Task__c task4 = new   QIPP_Task__c();
        task4.Task_Name_Succinct__c = 'Let Do Report6';
        task4.Task_Type__c = 'RCA';
        task4.Task_State__c =  'On hold';
        task4.Project_ID__c = project1.Id;
        task4.Task_Initiator__c = con.id;
        task4.Task_Percent_Complete__c = 40.0;
        insert task4;
        
        
        QIPP_Portfolio__c portfolio3 = new QIPP_Portfolio__c();
        portfolio3.Name = 'Test Portfolio 2';
        portfolio3.Portfolio_Owner__c = con.id;
        portfolio3.ownerId = DummyUser.Id;
        portfolio3.CDT_Lead__c = con.id;
        portfolio3.CPVi_Composite__c = 25.0;
        portfolio3.CPVi_Past__c = 29.0;
        portfolio3.CPVi_Future__c = 55.0;  
        portfolio3.CPV_Trend__c  = 'Down'; 
        portfolio3.Portfolio_Status__c = 'Active';
        portfolio3.DMAIC_DMADV__c = true;
        portfolio3.Lean_including_Kaizen__c = true;
        insert portfolio3;
        
        
        QIPP_Project__c project5 = new QIPP_Project__c();
        project5.Portfolio_Name__c = portfolio3.id;
        project5.RecordTypeId = RTID_DMAIC;
        project5.Project_Completion_Date_Target__c = Date.Today();
        project5.Project_Name_Succinct__c = 'Test Project 3';
        project5.Primary_QLT_Function__c = 'CO';
        project5.Project_State__c = 'On hold';
        project5.Last_Review_Type__c = 'Final';
        project5.Project_Lead__c = con.id;
        project5.ownerid = DummyUser.Id;
        project5.Report_Name__c = 'Executive Dashboards';
        project5.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project5;

 QIPP_Project__c project6 = new QIPP_Project__c();
        project6.Portfolio_Name__c = portfolio3.id;
        project6.RecordTypeId = RTID_DMAIC;
        project6.Project_Completion_Date_Target__c = Date.Today();
        project6.Project_Name_Succinct__c = 'Test Project 4';
        project6.Primary_QLT_Function__c = 'CO';
        project6.Project_State__c = 'On hold';
        project6.Last_Review_Type__c = 'Final';
        project6.Project_Lead__c = con.id;
        project6.ownerid = DummyUser.Id;
        project6.Report_Name__c = 'Executive Dashboards';
        project6.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project6;

        /*QIPP_Task__c task6 = new   QIPP_Task__c();
        task6.Task_Name_Succinct__c = 'Let Do Report1';
        task6.Task_Type__c = 'RCA';
        task6.Task_State__c =  'On hold';
        task6.Project_ID__c = project5.Id;
        task6.Task_Initiator__c = con.id;
        task6.Task_Percent_Complete__c = 40.0;
        insert task6;
        
        QIPP_Task__c task7 = new   QIPP_Task__c();
        task7.Task_Name_Succinct__c = 'Let Do Report2';
        task7.Task_Type__c = 'RCA';
        task7.Task_State__c =  'On hold';
        task7.Project_ID__c = project5.Id;
        task7.Task_Initiator__c = con.id;
        task7.Task_Percent_Complete__c = 40.0;
        insert task7;*/

        
        QIPPCDTReport q = new QIPPCDTReport();
        test.stopTest();
     }   
}