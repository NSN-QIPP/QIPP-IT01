@isTest
public class QIPPProjectsByPortfolioName_Test {
	static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;

    public static testMethod void testMyController() {
        
        User DummyUser = new User();
        DummyUser.LastName = 'maddipati';
        DummyUser.FirstName = 'venkat';
        DummyUser.Alias = 'venky';
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
        con.Name = 'Venkat Maddipati';
        con.Email__c = 'venkat.maddipati@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12345';
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
        insert project; 
        
        /*QIPP_Contacts__c cont=new QIPP_Contacts__c();
        cont.Name='tester';
        cont.Email__c='test@test.com';
        cont.Contact_State__c='Active';
        insert cont;
        
        QIPP_Portfolio__c portfolio=new QIPP_Portfolio__c();
        portfolio.Name='Test';
        portfolio.Portfolio_Owner__c=cont.Name;
        portfolio.CDT_Lead__c=cont.Name;
        portfolio.CDT_Sponsor__c=cont.Name;
        portfolio.Customer_Region__c='APAC';
        insert portfolio;
        
        QIPP_Project__c proj=new QIPP_Project__c();
        proj.Primary_QLT_Function__c='MBB';
        proj.Project_State__c='In Progress';
        proj.Project_Completion_Date_Forecast__c =System.today();
        proj.Project_Completion_Date_Target__c =System.today();
        proj.Portfolio_Owner_EmailID__c='test@test.com';
        proj.Portfolio_Name__c=portfolio.Name;
        insert proj;
        
        QIPP_Project__c proj2=new QIPP_Project__c();
        proj2.Primary_QLT_Function__c='MBB';
        proj2.Project_State__c='On Hold';
        proj2.Project_Completion_Date_Forecast__c =System.today();
        proj2.Project_Completion_Date_Target__c =System.today();
        insert proj2;
        */
        
        //PageReference pageRef = Page.QIPPProjectsByProjectTypePrint;
        //Test.setCurrentPage(pageRef);
      
        QIPPProjectsByPortfolioName controller = new QIPPProjectsByPortfolioName();
        controller.getFromPortfolioName();
        controller.ReturnFromPortfolioName();
        //controller.moveToExcel();
        
        List<QIPP_Project__c> groupedResults=new List<QIPP_Project__c>();
        groupedResults.add(project);
        
        QIPPProjectsByPortfolioName qltfun = new QIPPProjectsByPortfolioName();
        
        QIPPProjectsByPortfolioName.Data data1 = new QIPPProjectsByPortfolioName.Data('Test Portfolio',100,10,20,30,40,50,60,'50%','40%','30%','20%','25');
        QIPPProjectsByPortfolioName.Data data2 = new QIPPProjectsByPortfolioName.Data();
        
        qltfun.getTable();
        
        
        qltfun.getData();
        

       
      
    }
}