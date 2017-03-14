@isTest
private class TaskTestClass
{
    static testmethod void testfunction()
    {
        /*User DummyUser = new User();
        DummyUser.LastName = 'Jagtap';
        DummyUser.FirstName = 'Abhishek';
        DummyUser.Alias = 'abhishek';
        DummyUser.Email = 'abhishekj25@gmail.com';
        DummyUser.Username = 'abhi@igate.com';
        DummyUser.CommunityNickname = 'Technology';
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
        con.NSN_ID_Text__c = '122465';        
        insert con;

        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'Abhishek Sharma';
        con1.Email__c = 'abhishek.jagtap1@igate.com';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '4122465';  
        insert con1;

        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        insert project; 
        
         QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project';
        project1.Primary_QLT_Function__c = 'Comms';
        project1.Project_State__c = 'On hold';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        insert project1; 
        
        QIPP_Project__c project2 = new QIPP_Project__c();
        project2.Portfolio_Name__c = portfolio.id;
        project2.Project_Completion_Date_Target__c = Date.Today();
        project2.Project_Name_Succinct__c = 'Test Project';
        project2.Primary_QLT_Function__c = 'F&C';
        project2.Project_State__c = 'On hold';
        project2.Last_Review_Type__c = 'Final';
        project2.Project_Lead__c = con.id;
        insert project2; 
        
         QIPP_Project__c project3 = new QIPP_Project__c();
        project3.Portfolio_Name__c = portfolio.id;
        project3.Project_Completion_Date_Target__c = Date.Today();
        project3.Project_Name_Succinct__c = 'Test Project';
        project3.Primary_QLT_Function__c = 'GS';
        project3.Project_State__c = 'On hold';
        project3.Last_Review_Type__c = 'Final';
        project3.Project_Lead__c = con.id;
        insert project3;  
        
          QIPP_Project__c project4 = new QIPP_Project__c();
        project4.Portfolio_Name__c = portfolio.id;
        project4.Project_Completion_Date_Target__c = Date.Today();
        project4.Project_Name_Succinct__c = 'Test Project';
        project4.Primary_QLT_Function__c = 'HR';
        project4.Project_State__c = 'On hold';
        project4.Last_Review_Type__c = 'Final';
        project4.Project_Lead__c = con.id;
        insert project4;  
        
         QIPP_Project__c project5 = new QIPP_Project__c();
        project5.Portfolio_Name__c = portfolio.id;
        project5.Project_Completion_Date_Target__c = Date.Today();
        project5.Project_Name_Succinct__c = 'Test Project';
        project5.Primary_QLT_Function__c = 'IT';
        project5.Project_State__c = 'On hold';
        project5.Last_Review_Type__c = 'Final';
        project5.Project_Lead__c = con.id;
        insert project5;  
        
        /*  QIPP_Project__c project6 = new QIPP_Project__c();
        project6.Portfolio_Name__c = portfolio.id;
        project6.Project_Completion_Date_Target__c = Date.Today();
        project6.Project_Name_Succinct__c = 'Test Project';
        project6.Primary_QLT_Function__c = 'MBB';
        project6.Project_State__c = 'On hold';
        project6.Last_Review_Type__c = 'Final';
        project6.Project_Lead__c = con.id;
        insert project6;  
        
          QIPP_Project__c project7 = new QIPP_Project__c();
        project7.Portfolio_Name__c = portfolio.id;
        project7.Project_Completion_Date_Target__c = Date.Today();
        project7.Project_Name_Succinct__c = 'Test Project';
        project7.Primary_QLT_Function__c = 'Ops';
        project7.Project_State__c = 'On hold';
        project7.Last_Review_Type__c = 'Final';
        project7.Project_Lead__c = con.id;
        insert project7; */
        
       /* QIPP_Task__c task = new QIPP_Task__c();
        task.Task_Name_Succinct__c = 'Test Task';
        task.Task_Type__c = 'RCA';
        task.ownerId = DummyUser.id;
        task.Task_State__c = 'On hold';
        task.Project_ID__c = project.id;
        task.Task_Initiator__c = con.id;
        task.Task_Implementer__c = con.id;
        task.Target_Completion_Date__c = Date.Today();
        insert task; 
        
        QIPP_Task__c Taskselect = [select Task_Name_Succinct__c , Task_Type__c  , Task_State__c , Project_ID__c , Task_Initiator__c , 
                                  Task_Implementer__c, Target_Completion_Date__c from QIPP_Task__c where Id =: task.id];
        update Taskselect;                          
        
        QIPP_Project__c projectselect = [select Portfolio_Name__c  , Project_Completion_Date_Target__c , Project_Name_Succinct__c ,
                                         Primary_QLT_Function__c , Project_State__c , Last_Review_Type__c , Project_Lead__c
                                          from QIPP_Project__c where id =: project.Id];
        update projectselect;*/
    }
}