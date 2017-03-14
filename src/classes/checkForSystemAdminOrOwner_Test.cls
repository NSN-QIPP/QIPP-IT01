@isTest
private class checkForSystemAdminOrOwner_Test {
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
    public static testMethod void test1() {
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
        
        insert new Trigger_Control__c(Run_Triggers__c = True);
        
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
        project.Project_State__c = 'Not Started';
        project.Project_Type__c ='DMAIC';
        insert project;
        
        con.NSN_ID_Text__c = '122343456';
        update con;    
        
                  
}
    public static testMethod void test2() {
            
        UserRole ur = new UserRole(Name = 'Project Lead');
            
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
       
          insert new Trigger_Control__c(Run_Triggers__c = True);
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
            project.Project_State__c = 'Not Started';
            project.Project_Type__c= '8D';
                
            
            insert project;
            
            con.NSN_ID_Text__c = '122343456';
            update con; 
            
            
        } 
    /*    public static testMethod void test3() {
            
        UserRole ur = new UserRole(Name = 'Project Lead');
            
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Standard User%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        DummyUser.userroleid = ur.id;
        insert DummyUser;
         System.runAs(DummyUser)
         {
          insert new Trigger_Control__c(Run_Triggers__c = True);
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
            project.Project_State__c = 'Not Started';
            project.Project_Type__c= '8D';
                
            
            insert project;
            
           
            
    
} */
    
        
    
}