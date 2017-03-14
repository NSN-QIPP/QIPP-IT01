@isTest
public class QIPPRenderReportTestClass 
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
        con.NSN_ID_Text__c = '1234523';
        insert con;
        
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.Portfolio_Status__c = 'Active';
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type';
        insert project; 
        
        QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.RecordTypeId = RTID_DMAIC;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'On hold';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        project1.ownerid = DummyUser.Id;
        project1.Report_Name__c = NULL;
        project1.Report_Type__c = '--NONE--';
        insert project1; 
        
        QIPP_Project__c project2 = new QIPP_Project__c();
        project2.Portfolio_Name__c = portfolio.id;
        project2.RecordTypeId = RTID_DMAIC;
        project2.Project_Completion_Date_Target__c = Date.Today();
        project2.Project_Name_Succinct__c = 'Test Project';
        project2.Primary_QLT_Function__c = 'CO';
        project2.Project_State__c = 'On hold';
        project2.Last_Review_Type__c = 'Final';
        project2.Project_Lead__c = con.id;
        project2.ownerid = DummyUser.Id;
        project2.Report_Name__c = NULL;
        project2.Report_Type__c = NULL;
        insert project2; 
        
        
        QIPP_Project__c project3 = new QIPP_Project__c();
        project3.Portfolio_Name__c = portfolio.id;
        project3.RecordTypeId = RTID_DMAIC;
        project3.Project_Completion_Date_Target__c = Date.Today();
        project3.Project_Name_Succinct__c = 'Test Project';
        project3.Primary_QLT_Function__c = 'CO';
        project3.Project_State__c = 'On hold';
        project3.Last_Review_Type__c = 'Final';
        project3.Project_Lead__c = con.id;
        project3.ownerid = DummyUser.Id;
        project3.Report_Name__c = NULL;
        project3.Report_Type__c = 'Summary of Projects by Project Type';
        insert project3; 
        
        
        QIPP_Project__c project11 = [select Report_Name__c , Report_Type__c from QIPP_Project__c where Id =: Project.Id];
        

        String rName=project11.Report_Name__c;
        String rType=project11.Report_Type__c;
        

         QIPPRenderReport controller1 = new QIPPRenderReport();
               
         QIPPRenderReport controller2 = new QIPPRenderReport(new ApexPages.StandardController(project));
         ApexPages.currentPage().getParameters().put('F', 'CDT');
         controller2.test();
         
         QIPPRenderReport controller3 = new QIPPRenderReport(new ApexPages.StandardController(project1));
         ApexPages.currentPage().getParameters().put('F', 'SOI');
         controller3.test();
         
         QIPPRenderReport controller4 = new QIPPRenderReport(new ApexPages.StandardController(project2));
         ApexPages.currentPage().getParameters().put('F', 'QLT');
         controller4.test();
         
         QIPPRenderReport controller5 = new QIPPRenderReport(new ApexPages.StandardController(project2));
         ApexPages.currentPage().getParameters().put('F', 'PType');
         controller5.test();
         
         QIPPRenderReport controller6 = new QIPPRenderReport(new ApexPages.StandardController(project2));
         ApexPages.currentPage().getParameters().put('F', 'OIA');
         controller6.test();
         
         QIPPRenderReport controller7 = new QIPPRenderReport(new ApexPages.StandardController(project2));
         ApexPages.currentPage().getParameters().put('F', 'PortName');
         controller7.test();
         
         QIPPRenderReport controller8 = new QIPPRenderReport(new ApexPages.StandardController(project2));
         ApexPages.currentPage().getParameters().put('F', '');
         controller8.test();
         
         QIPPRenderReport controller9 = new QIPPRenderReport(new ApexPages.StandardController(project3));
         ApexPages.currentPage().getParameters().put('F', '');
         controller9.test();
        
        
        
        test.stopTest();
        
      
    }
}