@isTest
public class QIPPCDTTestClass 
{
    public static testMethod void testController() 
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
        
        RecordType rt = [Select Id from RecordType where Name = 'Methodology: DMAIC / DMADV'];
        RecordType rt_lean = [Select Id from RecordType where Name = 'Methodology: Lean (including Kaizen)'];        
        RecordType rt_8d = [Select Id from RecordType where Name = 'Methodology: 8D'];        
        RecordType rt_a3 = [Select Id from RecordType where Name = 'Methodology: A3'];        
        RecordType rt_cdt = [Select Id from RecordType where Name = 'Methodology: CDT'];        
        RecordType rt_di = [Select Id from RecordType where Name = 'Methodology: DI Logic'];        
        RecordType rt_rca = [Select Id from RecordType where Name = 'Methodology: RCA/EDA'];                                                
        RecordType rt_other = [Select Id from RecordType where Name = 'Methodology: Other Methodology'];   
    
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek Jagtap';
        con.Email__c = 'abhishek.jagtap1@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '123415';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.CPVi_Composite__c = 25.0;
        portfolio.CPVi_Past__c = 29.0;
        portfolio.CPVi_Future__c = 55.0;
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true; 
        portfolio.DI_CoPQ__c = true;
        portfolio.RCA_EDA__c = true;  
        portfolio.Other__c = true; 
        portfolio.X8D__c = true;
        portfolio.A3__c = true;  
        portfolio.CDT__c = true;   
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On Hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Project_Type__c = 'DMAIC';
        project.RecordTypeId = rt.id;
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
      
        QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project2';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'Closed';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        project1.ownerid = DummyUser.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        project1.Project_Type__c = 'Lean (including Kaizen)';
        project1.Ergonomics__c = true;
        project1.RecordTypeId = rt_lean.id;
        insert project1;        
        
        QIPP_Project__c project6 = new QIPP_Project__c();
        project6.Portfolio_Name__c = portfolio.id;
        project6.Project_Completion_Date_Target__c = Date.Today();
        project6.Project_Name_Succinct__c = 'Test Project2';
        project6.Primary_QLT_Function__c = 'CO';
        project6.Project_State__c = 'Complete';
        project6.Last_Review_Type__c = 'Final';
        project6.Project_Lead__c = con.id;
        project6.ownerid = DummyUser.Id;
        project6.Report_Name__c = 'Executive Dashboards';
        project.Project_Type__c = 'DI (CoPQ)';
        project6.RecordTypeId = rt_di.id;
        insert project6;   
        
        QIPP_Project__c project7 = new QIPP_Project__c();
        project7.Portfolio_Name__c = portfolio.id;
        project7.Project_Completion_Date_Target__c = Date.Today();
        project7.Project_Name_Succinct__c = 'Test Project2';
        project7.Primary_QLT_Function__c = 'CO';
        project7.Project_State__c = 'Canceled';
        project7.Last_Review_Type__c = 'Final';
        project7.Project_Lead__c = con.id;
        project7.ownerid = DummyUser.Id;
        project7.Report_Name__c = 'Executive Dashboards';
        project.Project_Type__c = 'RCA/EDA';
        project7.RecordTypeId = rt_rca.id;
        insert project7;   
        
        QIPP_Project__c project8 = new QIPP_Project__c();
        project8.Portfolio_Name__c = portfolio.id;
        project8.Project_Completion_Date_Target__c = Date.Today();
        project8.Project_Name_Succinct__c = 'Test Project2';
        project8.Primary_QLT_Function__c = 'CO';
        project8.Project_State__c = 'On Hold';
        project8.Last_Review_Type__c = 'Final';
        project8.Project_Lead__c = con.id;
        project8.ownerid = DummyUser.Id;
        project8.Report_Name__c = 'Executive Dashboards';
        project.Project_Type__c = 'Other';
        project8.RecordTypeId = rt_other.id;
        insert project8;          
        
        QIPP_Project__c project2 = new QIPP_Project__c();
        project2.Portfolio_Name__c = portfolio.id;
        project2.Project_Completion_Date_Target__c = Date.Today();
        project2.Project_Name_Succinct__c = 'Test Project2';
        project2.Primary_QLT_Function__c = 'CO';
        project2.Project_State__c = 'In Progress';
        project2.Last_Review_Type__c = 'Final';
        project2.Project_Lead__c = con.id;
        project2.ownerid = DummyUser.Id;
        project2.Report_Name__c = 'Executive Dashboards';
        project.Project_Type__c = '8D';
        project2.RecordTypeId = rt_8d.id;
        insert project2;   
        
        QIPP_Project__c project3 = new QIPP_Project__c();
        project3.Portfolio_Name__c = portfolio.id;
        project3.Project_Completion_Date_Target__c = Date.Today();
        project3.Project_Name_Succinct__c = 'Test Project2';
        project3.Primary_QLT_Function__c = 'CO';
        project3.Project_State__c = 'In Progress';
        project3.Last_Review_Type__c = 'Final';
        project3.Project_Lead__c = con.id;
        project3.ownerid = DummyUser.Id;
        project3.Report_Name__c = 'Executive Dashboards';
        project.Project_Type__c = 'A3';
        project3.RecordTypeId = rt_a3.id;
        insert project3;   
        
        QIPP_Project__c project4 = new QIPP_Project__c();
        project4.Portfolio_Name__c = portfolio.id;
        project4.Project_Completion_Date_Target__c = Date.Today();
        project4.Project_Name_Succinct__c = 'Test Project2';
        project4.Primary_QLT_Function__c = 'CO';
        project4.Project_State__c = 'In Progress';
        project4.Last_Review_Type__c = 'Final';
        project4.Project_Lead__c = con.id;
        project4.ownerid = DummyUser.Id;
        project4.Report_Name__c = 'Executive Dashboards';
        project.Project_Type__c = 'CDT';
        project4.RecordTypeId = rt_cdt.id;
        insert project4;                   
        
        QIPP_Project__c project5 = new QIPP_Project__c();
        project5.Portfolio_Name__c = portfolio.id;
        project5.Project_Completion_Date_Target__c = Date.Today();
        project5.Project_Name_Succinct__c = 'Test Project 3';
        project5.Primary_QLT_Function__c = 'CO';
        project5.Project_State__c = 'Canceled';
        project5.Last_Review_Type__c = 'Final';
        project5.Project_Lead__c = con.id;
        project5.ownerid = DummyUser.Id;
        project5.Report_Name__c = 'Executive Dashboards';
        project5.Report_Type__c = 'Summary of Projects by Project Type ';
        project5.Project_Type__c = 'DMAIC';
        project5.RecordTypeId = rt.id;
        insert project5;
        
        QIPPCDTReport q = new QIPPCDTReport();
        test.stopTest();
        
     }   
}