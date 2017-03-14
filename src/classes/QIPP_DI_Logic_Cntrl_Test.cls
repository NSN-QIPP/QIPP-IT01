@isTest
private with sharing class QIPP_DI_Logic_Cntrl_Test{
 static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DI Logic' and SobjectType = 'QIPP_Project__c'].Id;  
    private static testmethod void test(){
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
        portfolio.DI_CoPQ__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        
        List<QIPP_Project__c> projectList = new List<QIPP_Project__c>();
     
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'In Process';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
         project.Project_State__c = 'Complete';
        insert project;
        projectList.add(project);
        
        QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.RecordTypeId = RTID_DMAIC;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project2';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'In Process';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        project1.ownerid = DummyUser.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
         project1.Project_State__c = 'On Hold';
        insert project1;
        projectList.add(project1);
            
         ApexPages.StandardController sc = new ApexPages.StandardController(project);
          PageReference pageRef2 = Page.QIPP_DI_Logic_Detail_View;
          Test.setCurrentPage(pageRef2);         
        QIPP_DI_Logic_Cntrl CIFprj = new QIPP_DI_Logic_Cntrl(sc);
             CIFprj.currentView='DIDetailpage';
            CIFprj.portfolioName= portfolio.name;
            CIFprj.genericError = 'VIPT';

            CIFprj.profileName = 'Each';
            CIFprj.roleName = 'CoPQ Reduction';
            CIFprj.phasecompleted = 'Indirect Financial';
            CIFprj.projectId = project.id;
            CIFprj.projState = 'Lower is Favorable';
            CIFprj.recIsLocked = false;
            CIFprj.benefitAmount = 20.2;
            CIFprj.currPortfolioId = portfolio.id;
            CIFprj.cloneid = project1.id;
            CIFprj.portfolioName = 'test';
             CIFprj.issaveandnew = true;
             
            CIFprj.getPortfolioBBGValue();
            CIFprj.getPortfolioValues();
            CIFprj.save();
            CIFprj.cancel();
            CIFprj.ValidationCancel();
            PageReference pageRef = Page.QIPPCIFProjectDetailView;
            Test.setCurrentPage(pageRef);
            CIFprj.unlockRecord();
            
            CIFprj.edit();
            CIFprj.deleteRecord();
            CIFprj.cloneProject();
            CIFprj.reqApproval();
            CIFprj.submitapprove();
            CIFprj.BBGUpdated();
            
             ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
             ApexPages.StandardController sc1 = new ApexPages.StandardController(project1);
                QIPP_DI_Logic_Cntrl CIFprj1 = new QIPP_DI_Logic_Cntrl(sc1);
        
                CIFprj1.recIsLocked = true;
                CIFprj1.edit();
                CIFprj1.deleteRecord();
                CIFprj1.cloneProject();
                
                PageReference pageRef1 = Page.QIPPCIFProjectDetailView;
        Test.setCurrentPage(pageRef1);
                           ApexPages.StandardController sc2 = new ApexPages.StandardController(project1);
                QIPP_DI_Logic_Cntrl CIFprj2 = new QIPP_DI_Logic_Cntrl(sc2);
        ApexPages.currentPage().getParameters().put('CloneID',project.id);
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        CIFprj2.recordIsLocked(project.id);
        
        CIFprj2.currentView = 'QIPP_DI_Logic_Edit_View';
        CIFprj2.save();
        
        ApexPages.currentPage().getParameters().put('cancelURL','test');
        CIFprj2.cancel();
        
        ApexPages.StandardController sc3 = new ApexPages.StandardController(project1);
                QIPP_DI_Logic_Cntrl CIFprj3 = new QIPP_DI_Logic_Cntrl(sc3);
        ApexPages.currentPage().getParameters().put('retURL','test');
        CIFprj3.recIsLocked = true;
        CIFprj3.reqApproval();
        CIFprj3.cancel();
        
        
         project1.Project_State__c = 'On Hold';
        update project1;
        
        ApexPages.StandardController sc4 = new ApexPages.StandardController(project1);
                QIPP_DI_Logic_Cntrl CIFprj4 = new QIPP_DI_Logic_Cntrl(sc4);
                CIFprj4.proj.Project_Document__c = 'sadfsadf';
               CIFprj4.issaveandnew = true;
               CIFprj4.save();
                //CIFprj4.reqApproval();
               CIFprj4.callDummy();
               CIFprj4.closedelPopup();
               CIFprj4.closePopup();
               CIFprj4.ApproverConfirmed();
               CIFprj4.getqtyAwardProjectValues();
               CIFprj4.updateDIteam();
               CIFprj4.displaycloseDIteamPopup();
        }
        
        
    private static testmethod void test1(){
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
        portfolio.DI_CoPQ__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        
        Business_Activity__c ba = new Business_Activity__c();
        ba.Name = 'test';
        ba.Business_Function__c = 'Account management';
        ba.Description__c   = 'test';
        ba.Value_Stream__c = 'Quality';        
        insert ba;
        
        Business_Activity__c ba1 = new Business_Activity__c();        
        ba1.Name = 'test';
        ba1.Business_Function__c = 'Services & support';
        ba1.Description__c   = 'test';
        ba1.Value_Stream__c = 'Time';        
        insert ba1;
        
        Business_Activity__c ba2 = new Business_Activity__c();        
        ba2.Name = 'test';
        ba2.Business_Function__c = 'Strategy & vision';
        ba2.Description__c   = 'test';
        ba2.Value_Stream__c = 'Price';        
        insert ba2;        
        
        
        QIPP_Benefit_Conversion_Table__c im = new QIPP_Benefit_Conversion_Table__c();
        im.Active__c = true;
        im.Name = 'test';
        insert im;        
        
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Completion_Date_Forecast__c = Date.Today();
        project.Project_Description_Detailed__c = 'asdasd';
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Portfolio_BU__c = 'Human Resources';
        project.Project_BL__c = 'Nokia EDU';
        project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project.CEMT_ID__c = 'sda';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'In Process';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.Project_Sponsor__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Business_Activity_Mapping__c = ba.id;
        project.Business_Activity_Mapping2__c = ba1.id;
        project.Business_Activity_Mapping3__c = ba2.id;                
        insert project;
        
        List<QIPP_Benefit__c> Benefits_RelatedList = new List<QIPP_Benefit__c>();
          QIPP_Benefit__c qb = new QIPP_Benefit__c();
       // qb.Name= 'test'; 
        qb.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb.Benefit_Type__c= 'Financial Savings';
        qb.Project_ID__c= project.Id;
        qb.Unit_of_Measure__c= 'Dollars';
        qb.Improvement_Measure_Name__c= 'test';
        qb.Planned_Financial_Savings_Total__c=1000.0;
        qb.Planned_Operational_Savings_Total__c=1000.0;
        qb.Planned_Projected_Savings_Total__c=1000.0;
        qb.Planned_Realized_Savings_Total__c=1000.0;
        qb.Achieved_Financial_Savings_Total__c=1000.0;
        qb.Achieved_Operational_Savings_Total__c=1000.0;
        qb.Achieved_Projected_Savings_Total__c=1000.0;
        qb.Achieved_Realized_Savings_Total__c=1000.0;
        qb.Future_Financial_Savings_Total__c=1000.0;
        qb.Future_Operational_Savings_Total__c=1000.0;
        qb.Future_Projected_Savings_Total__c=1000.0;
        qb.Future_Realized_Savings_Total__c=1000.0;
        qb.Benefit_Amount_Achieved_Future_k__c=1000.0;
        qb.Benefit_Operational_Achieved_Future_k__c=1000.0;
        qb.Benefit_Projected_Achieved_Future_k__c=1000.0;
        qb.Benefit_Realized_Achieved_Future_k__c=1000.0;

        insert qb;
        Benefits_RelatedList.add(qb);
        
        QIPP_Benefit__c qb1 = new QIPP_Benefit__c();
       // qb.Name= 'test'; 
        qb1.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb1.Benefit_Type__c= 'Operational Savings';
        //qb1.Project_ID__c= project1.Id;
        qb1.Project_ID__c= project.Id;
        qb1.Unit_of_Measure__c= 'Dollars';
        qb1.Improvement_Measure_Name__c= 'test';
        qb1.Planned_Financial_Savings_Total__c=1000.0;
        qb1.Planned_Operational_Savings_Total__c=1000.0;
        qb1.Planned_Projected_Savings_Total__c=1000.0;
        qb1.Planned_Realized_Savings_Total__c=1000.0;
        qb1.Achieved_Financial_Savings_Total__c=1000.0;
        qb1.Achieved_Operational_Savings_Total__c=1000.0;
        qb1.Achieved_Projected_Savings_Total__c=1000.0;
        qb1.Achieved_Realized_Savings_Total__c=1000.0;
        qb1.Future_Financial_Savings_Total__c=1000.0;
        qb1.Future_Operational_Savings_Total__c=1000.0;
        qb1.Future_Projected_Savings_Total__c=1000.0;
        qb1.Future_Realized_Savings_Total__c=1000.0;
        qb1.Benefit_Amount_Achieved_Future_k__c=1000.0;
        qb1.Benefit_Operational_Achieved_Future_k__c=1000.0;
        qb1.Benefit_Projected_Achieved_Future_k__c=1000.0;
        qb1.Benefit_Realized_Achieved_Future_k__c=1000.0;

        insert qb1;
        Benefits_RelatedList.add(qb1);
        
        
         QIPP_Benefit__c qb2 = new QIPP_Benefit__c();
       // qb.Name= 'test'; 
        qb2.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb2.Benefit_Type__c= 'Projected Revenue';
        //qb2.Project_ID__c= project2.Id;
        qb2.Project_ID__c= project.Id;
        qb2.Unit_of_Measure__c= 'Dollars';
        qb2.Improvement_Measure_Name__c= 'test';
        qb2.Planned_Financial_Savings_Total__c=1000.0;
        qb2.Planned_Operational_Savings_Total__c=1000.0;
        qb2.Planned_Projected_Savings_Total__c=1000.0;
        qb2.Planned_Realized_Savings_Total__c=1000.0;
        qb2.Achieved_Financial_Savings_Total__c=1000.0;
        qb2.Achieved_Operational_Savings_Total__c=1000.0;
        qb2.Achieved_Projected_Savings_Total__c=1000.0;
        qb2.Achieved_Realized_Savings_Total__c=1000.0;
        qb2.Future_Financial_Savings_Total__c=1000.0;
        qb2.Future_Operational_Savings_Total__c=1000.0;
        qb2.Future_Projected_Savings_Total__c=1000.0;
        qb2.Future_Realized_Savings_Total__c=1000.0;
        qb2.Benefit_Amount_Achieved_Future_k__c=1000.0;
        qb2.Benefit_Operational_Achieved_Future_k__c=1000.0;
        qb2.Benefit_Projected_Achieved_Future_k__c=1000.0;
        qb2.Benefit_Realized_Achieved_Future_k__c=1000.0;

        insert qb2;
        Benefits_RelatedList.add(qb2);
        
        
        QIPP_Benefit__c qb3 = new QIPP_Benefit__c();
       // qb.Name= 'test'; 
        qb3.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb3.Benefit_Type__c= 'Realized Revenue';
        //qb3.Project_ID__c= project3.Id;
        qb3.Project_ID__c= project.Id;
        qb3.Unit_of_Measure__c= 'Dollars';
        qb3.Improvement_Measure_Name__c= 'test';
        qb3.Planned_Financial_Savings_Total__c=1000.0;
        qb3.Planned_Operational_Savings_Total__c=1000.0;
        qb3.Planned_Projected_Savings_Total__c=1000.0;
        qb3.Planned_Realized_Savings_Total__c=1000.0;
        qb3.Achieved_Financial_Savings_Total__c=1000.0;
        qb3.Achieved_Operational_Savings_Total__c=1000.0;
        qb3.Achieved_Projected_Savings_Total__c=1000.0;
        qb3.Achieved_Realized_Savings_Total__c=1000.0;
        qb3.Future_Financial_Savings_Total__c=1000.0;
        qb3.Future_Operational_Savings_Total__c=1000.0;
        qb3.Future_Projected_Savings_Total__c=1000.0;
        qb3.Future_Realized_Savings_Total__c=1000.0;
        qb3.Benefit_Amount_Achieved_Future_k__c=0.0;
        qb3.Benefit_Operational_Achieved_Future_k__c=0.0;
        qb3.Benefit_Projected_Achieved_Future_k__c=1000.0;
        qb3.Benefit_Realized_Achieved_Future_k__c=1000.0;

        insert qb3;
        Benefits_RelatedList.add(qb3);

        
        PageReference pageRef2 = Page.QIPP_DI_Logic_Edit_View;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_DI_Logic_Cntrl CIFprj = new QIPP_DI_Logic_Cntrl(sc);
        CIFprj.issaveandnew = true;
        CIFprj.getPortfolioBBGValue();
        CIFprj.getBenefits();
        CIFprj.getBAMDetailsMap();
        CIFprj.save();


    }        
    
    
    private static testmethod void test2(){
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
        portfolio.DI_CoPQ__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Completion_Date_Forecast__c = Date.Today();
        project.Project_Description_Detailed__c = 'asdasd';
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Portfolio_BU__c = 'Human Resources';
        project.Project_BL__c = 'Nokia EDU';
        project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project.CEMT_ID__c = 'sda';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'In Process';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.Project_Sponsor__c = con.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project;
        
        PageReference pageRef2 = Page.QIPP_DI_Logic_Edit_View;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_DI_Logic_Cntrl CIFprj = new QIPP_DI_Logic_Cntrl(sc);
        CIFprj.issaveandnew = false;
        CIFprj.getPortfolioBBGValue();
        CIFprj.save();

        ApexPages.currentPage().getParameters().put('retURL', 'retURL');  
        CIFprj.cancel();
                
        ApexPages.currentPage().getParameters().put('id',project.Id);  
        CIFprj.cancel();
    }          
    
    private static testmethod void test3(){
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
        QIPP_Contacts__c con2 = new QIPP_Contacts__c();
        con2.Name = 'Sriaknth';
        con2.Email__c = 'Srikanth@igate.com';
        con2.Contact_State__c = 'Active';
        con2.NSN_ID_Text__c = '122343445';
        insert con2;
        
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
        portfolio.DI_CoPQ__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Completion_Date_Forecast__c = Date.Today();
        project.Project_Description_Detailed__c = 'asdasd';
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Portfolio_BU__c = 'Human Resources';
        project.Project_BL__c = 'Nokia EDU';
        project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project.CEMT_ID__c = 'sda';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'In Process';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.Project_Sponsor__c = con2.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        //insert project;
        
        QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.RecordTypeId = RTID_DMAIC;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Completion_Date_Forecast__c = Date.Today();
        project1.Project_Description_Detailed__c = 'asdasd';
        project1.Project_Name_Succinct__c = 'Test Project1';
        project1.Portfolio_BU__c = 'Human Resources';
        project1.Project_BL__c = 'Nokia EDU';
        project1.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project1.CEMT_ID__c = 'sda';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'In Process';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        project1.Project_Sponsor__c = con2.id;
        project1.ownerid = DummyUser.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project1;
        
        Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
        bbg1.Distribution__c=2.0;
        bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg1.Benefitting_Business_Unit__c='BHR FN';
        bbg1.Benefitting_Business_Line__c='Project Management';
        bbg1.Financial_Validation_Amount__c=1.0;
        bbg1.Operational_Validation_Amount__c=1.0;
        bbg1.Projected_Validation_Amount__c=1.0;
        bbg1.Realized_Validation_Amount__c=1.0;
        bbg1.Project_ID__c = project1.id;
        bbg1.Project_BG__c = false;
        insert bbg1; 
        Benefiting_Business_Group__c bbg2 = new Benefiting_Business_Group__c();        
        bbg2.Distribution__c=2.0;
        bbg2.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg2.Benefitting_Business_Unit__c='BHR FN';
        bbg2.Benefitting_Business_Line__c='Project Management';
        bbg2.Financial_Validation_Amount__c=1.0;
        bbg2.Operational_Validation_Amount__c=1.0;
        bbg2.Projected_Validation_Amount__c=1.0;
        bbg2.Realized_Validation_Amount__c=1.0;
        bbg2.Project_ID__c = project1.id;
        bbg2.Project_BG__c = true;
        insert bbg2; 
        
        
        PageReference pageRef2 = Page.QIPP_DI_Logic_Edit_View;
        Test.setCurrentPage(pageRef2);  
        //ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        ApexPages.currentPage().getParameters().put('referer', 'https://salesforce.com/');
        QIPP_DI_Logic_Cntrl CIFprj = new QIPP_DI_Logic_Cntrl(sc);       
        CIFprj.proj = project1;
        CIFprj.issaveandnew = true;
        CIFprj.portfolioName='1';
        CIFprj.getPortfolioBBGValue();
        CIFprj.updateDIteam();
        CIFprj.closeLeadSponsorEqualPopup();
        CIFprj.displayDIteamPopup =true;
        //CIFprj.displaycloseDIteamPopup();
        CIFprj.prjLeadSponsorEqual =true;
        CIFprj.BBGUpdated();
        CIFprj.portfolioName='Srikanth';        
        CIFprj.save();
        ApexPages.currentPage().getParameters().put('retURL', 'retURL');  
        CIFprj.cancel();
        ApexPages.currentPage().getParameters().put('id',project1.Id);  
        CIFprj.cancel();              
    }          
     private static testmethod void test4(){
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
        QIPP_Contacts__c con2 = new QIPP_Contacts__c();
        con2.Name = 'Sriaknth';
        con2.Email__c = 'Srikanth@igate.com';
        con2.Contact_State__c = 'Active';
        con2.NSN_ID_Text__c = '122343445';
        insert con2;
        
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
        portfolio.DI_CoPQ__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = RTID_DMAIC;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Completion_Date_Forecast__c = Date.Today();
        project.Project_Description_Detailed__c = 'asdasd';
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Portfolio_BU__c = 'Human Resources';
        project.Project_BL__c = 'Nokia EDU';
        project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project.CEMT_ID__c = 'sda';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'In Process';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.Project_Sponsor__c = con2.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        //insert project;
        
        QIPP_Project__c project1 = new QIPP_Project__c();
        project1.Portfolio_Name__c = portfolio.id;
        project1.RecordTypeId = RTID_DMAIC;
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Completion_Date_Forecast__c = Date.Today();
        project1.Project_Description_Detailed__c = 'asdasd';
        project1.Project_Name_Succinct__c = 'Test Project1';
        project1.Portfolio_BU__c = 'Human Resources';
        project1.Project_BL__c = 'Nokia EDU';
        project1.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        project1.CEMT_ID__c = 'sda';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'In Process';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con.id;
        project1.Project_Sponsor__c = con2.id;
        project1.ownerid = DummyUser.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        insert project1;
        
        Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
        bbg1.Distribution__c=2.0;
        bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg1.Benefitting_Business_Unit__c='BHR FN';
        bbg1.Benefitting_Business_Line__c='Project Management';
        bbg1.Financial_Validation_Amount__c=1.0;
        bbg1.Operational_Validation_Amount__c=1.0;
        bbg1.Projected_Validation_Amount__c=1.0;
        bbg1.Realized_Validation_Amount__c=1.0;
        bbg1.Project_ID__c = project1.id;
        bbg1.Project_BG__c = false;
        insert bbg1; 
        Benefiting_Business_Group__c bbg2 = new Benefiting_Business_Group__c();        
        bbg2.Distribution__c=2.0;
        bbg2.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg2.Benefitting_Business_Unit__c='BHR FN';
        bbg2.Benefitting_Business_Line__c='Project Management';
        bbg2.Financial_Validation_Amount__c=1.0;
        bbg2.Operational_Validation_Amount__c=1.0;
        bbg2.Projected_Validation_Amount__c=1.0;
        bbg2.Realized_Validation_Amount__c=1.0;
        bbg2.Project_ID__c = project1.id;
        bbg2.Project_BG__c = true;
        insert bbg2; 
        
        project.Project_Completion_Date_Forecast__c =Date.Today().addDays(-1);
        project.Finance_Approver__c = con.id ;
        project.DI_Business_Owner_Delegate__c= con.id ;
        project.DI_Business_Owner__c= con.id ;
        
        PageReference pageRef2 = Page.QIPP_DI_logic_Detail_View;
        Test.setCurrentPage(pageRef2);  
        //ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        ApexPages.currentPage().getParameters().put('referer', 'https://salesforce.com/');
        QIPP_DI_Logic_Cntrl CIFprj = new QIPP_DI_Logic_Cntrl(sc);
        CIFprj.validatediteam();
      }
    
    private static testmethod void test5(){
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
                Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Project Lead%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;
    
            QIPP_Contacts__c con = new QIPP_Contacts__c();
            con.Name = 'Abhishek';
            con.Email__c = 'a@a.a';
            con.Contact_State__c = 'Active';
            con.NSN_ID_Text__c = '12234345';
            con.Belt_Certification__c='Nokia-Green Belt';
            con.Contact_BU__c='CFOO346';
            con.Contact_BL__c='CFOO3';
            con.Contact_L4_Org__c='CFOO5';
            con.User_License__c = DummyUser.id;
            con.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con.CoPQ_Role_2__c='BL Transformation Lead';
            con.CoPQ_Role_3__c='Measure Creator';
            con.CoPQ_Role_4__c='Business Owner Delegate';
            insert con;
            
            User DummyUser1 = new User(LastName = 'adcd',FirstName = 'adcd',Alias = 'adcd',Email = 'ab@a.a',
                Username = 'ab@a.a.adc',CommunityNickname = 'ab',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Project Lead%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser1;
            
            QIPP_Contacts__c con1 = new QIPP_Contacts__c();
            con1.Name = 'abcd';
            con1.Email__c = 'ab@a.a';
            con1.Contact_State__c = 'Active';
            con1.NSN_ID_Text__c = '12234345678';
            con1.Belt_Certification__c='Nokia-Green Belt';
            con1.Contact_BU__c='CFOO346';
            con1.Contact_BL__c='CFOO3';
            con1.Contact_L4_Org__c='CFOO5';
            con1.User_License__c = DummyUser1.id;
            con1.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con1.CoPQ_Role_2__c='BL Transformation Lead';
            con1.CoPQ_Role_3__c='Finance Approver';
            con1.CoPQ_Role_4__c='Business Owner Delegate';
            insert con1;
            
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
            portfolio.DI_CoPQ__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            test.starttest();

            Business_Activity__c ba = new Business_Activity__c();
            ba.name = 'Test Business Activity';
            ba.Business_Function__c = 'Marketing & communications';
            ba.Value_Stream__c = 'Features';
            insert ba;            
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = RTID_DMAIC;
            project.Project_Completion_Date_Target__c = Date.Today();
            project.Project_Completion_Date_Forecast__c = Date.Today();
            project.Project_Description_Detailed__c = 'asdasd';
            project.Project_Name_Succinct__c = 'Test Project1';
            project.Portfolio_BU__c = 'Human Resources';
            project.Project_BL__c = 'Nokia EDU';
            project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            project.CEMT_ID__c = 'sda';
            project.Primary_QLT_Function__c = 'CO';
            project.Last_Review_Type__c = 'Final';
            project.Project_Lead__c = con.id;
            project.Project_Sponsor__c = con1.id;
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'In Progress';
            project.Finance_Approver__c = con1.Id;
            project.Improvement_Owner__c = con1.Id;
            project.Business_Activity_Mapping__c = ba.id;
            insert project;

            QIPP_Benefit__c bn = new QIPP_Benefit__c();
            bn.Project_ID__c = project.Id;
            bn.Benefit_Type__c = 'Operational Savings';
            bn.Planned_Operational_Savings_Total__c = 20;
            bn.Achieved_Operational_Savings_Total__c = 0;
            bn.Future_Operational_Savings_Total__c = 20;
            bn.Benefit_Operational_Achieved_Future_k__c = 20;
            insert bn;
            
            QIPP_Benefit__c bn1 = new QIPP_Benefit__c();
            bn1.Project_ID__c = project.Id;
            bn1.Benefit_Type__c = 'Financial Savings';
            bn1.Planned_Financial_Savings_Total__c = 20;
            bn1.Achieved_Financial_Savings_Total__c = 20;
            bn1.Future_Financial_Savings_Total__c = 20;
            bn1.Benefit_Amount_Achieved_Future_k__c = 20;
            insert bn1;
            
            PageReference pageRef2 = Page.QIPP_DI_logic_Edit_View;
            Test.setCurrentPage(pageRef2);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            ApexPages.currentPage().getParameters().put('referer', 'https://salesforce.com/');
            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            QIPP_DI_Logic_Cntrl obj = new QIPP_DI_Logic_Cntrl(sc);
            obj.issaveandnew = true;
            obj.displayDIteamPopup = true;
            //obj.displaycloseDIteamPopup();
            obj.cancel();
            obj.save();
            obj.getBenefits();

            bn.Benefit_Type__c = 'Projected Revenue';
            bn.Planned_Projected_Savings_Total__c = 20;
            bn.Achieved_Projected_Savings_Total__c = 0;
            bn.Future_Projected_Savings_Total__c = 20;
            bn.Benefit_Projected_Achieved_Future_k__c = 20;
            update bn;
            ApexPages.currentPage().getParameters().put('id', project.Id);
            sc = new ApexPages.StandardController(project);
            obj = new QIPP_DI_Logic_Cntrl(sc);
            obj.issaveandnew = false;
            obj.save();
            obj.getBenefits();

            test.stoptest();
         }
    }    
    
    private static testmethod void test6(){
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
                Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Project Lead%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;
    
            QIPP_Contacts__c con = new QIPP_Contacts__c();
            con.Name = 'Abhishek';
            con.Email__c = 'a@a.a';
            con.Contact_State__c = 'Active';
            con.NSN_ID_Text__c = '12234345';
            con.Belt_Certification__c='Nokia-Green Belt';
            con.Contact_BU__c='CFOO346';
            con.Contact_BL__c='CFOO3';
            con.Contact_L4_Org__c='CFOO5';
            con.User_License__c = DummyUser.id;
            con.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con.CoPQ_Role_2__c='BL Transformation Lead';
            con.CoPQ_Role_3__c='Measure Creator';
            //con.CoPQ_Role_4__c='Business Owner Delegate';
            insert con;
            
            User DummyUser1 = new User(LastName = 'adcd',FirstName = 'adcd',Alias = 'adcd',Email = 'ab@a.a',
                Username = 'ab@a.a.adc',CommunityNickname = 'ab',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Project Lead%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser1;
            
            QIPP_Contacts__c con1 = new QIPP_Contacts__c();
            con1.Name = 'abcd';
            con1.Email__c = 'ab@a.a';
            con1.Contact_State__c = 'Active';
            con1.NSN_ID_Text__c = '12234345678';
            con1.Belt_Certification__c='Nokia-Green Belt';
            con1.Contact_BU__c='CFOO346';
            con1.Contact_BL__c='CFOO3';
            con1.Contact_L4_Org__c='CFOO5';
            con1.User_License__c = DummyUser1.id;
            con1.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con1.CoPQ_Role_2__c='BL Transformation Lead';
            con1.CoPQ_Role_3__c='Finance Approver';
            con1.CoPQ_Role_4__c='Business Owner Delegate';
            insert con1;
            
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
            portfolio.DI_CoPQ__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            test.starttest();

            Business_Activity__c ba = new Business_Activity__c();
            ba.name = 'Test Business Activity';
            ba.Business_Function__c = 'Marketing & communications';
            ba.Value_Stream__c = 'Features';
            insert ba;            
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = RTID_DMAIC;
            project.Project_Completion_Date_Target__c = Date.Today();
            project.Project_Completion_Date_Forecast__c = Date.Today().addDays(-2);
            project.Project_Description_Detailed__c = 'asdasd';
            project.Project_Name_Succinct__c = 'Test Project1';
            project.Portfolio_BU__c = 'Human Resources';
            project.Project_BL__c = 'Nokia EDU';
            project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
            project.CEMT_ID__c = 'sda';
            project.Primary_QLT_Function__c = 'CO';
            project.Last_Review_Type__c = 'Final';
            project.Project_Lead__c = con.id;
            project.Project_Sponsor__c = con1.id;
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'On Hold';
            project.Finance_Approver__c = con.Id;
            project.DI_Business_Owner__c = con.Id;
            project.DI_Business_Owner_Delegate__c = con.Id;
            project.Business_Activity_Mapping__c = ba.id;
            insert project;

            QIPP_Benefit__c bn = new QIPP_Benefit__c();
            bn.Project_ID__c = project.Id;
            bn.Benefit_Type__c = 'Realized Revenue';
            bn.Planned_Realized_Savings_Total__c = 20;
            bn.Achieved_Realized_Savings_Total__c = 0;
            bn.Future_Realized_Savings_Total__c = 0;
            bn.Benefit_Realized_Achieved_Future_k__c = 0;
            insert bn;

            PageReference pageRef2 = Page.QIPP_DI_logic_Edit_View;
            Test.setCurrentPage(pageRef2);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            ApexPages.currentPage().getParameters().put('referer', 'https://salesforce.com/');
            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            QIPP_DI_Logic_Cntrl obj = new QIPP_DI_Logic_Cntrl(sc);
            obj.getBenefits();
            
            obj.benefitAmount = 20;
            obj.reqApproval();

            test.stoptest();
         }
    }    
}