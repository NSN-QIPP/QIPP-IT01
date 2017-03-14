@isTest
private with sharing class QIPP_CIF_Project_Test{
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: CIF' and SobjectType = 'QIPP_Project__c'].Id;  
    private static testmethod void test(){
        User DummyUser;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];

        System.runAs (thisUser) {        
            DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
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
            con.CoPQ_Role_1__c='Business Unit Master Balck Belt';
            con.CoPQ_Role_2__c='BL Transformation Lead';
            con.CoPQ_Role_3__c='Measure Creator';
            con.CoPQ_Role_4__c='Business Owner Delegate';
            
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
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            List<QIPP_Project__c> projectList = new List<QIPP_Project__c>();
            List<QIPP_Benefit__c> Benefits_RelatedList = new List<QIPP_Benefit__c>();
            List<QIPP_CIF_Project.benefitGrandTotals> benefitGrandTotalsList = new List<QIPP_CIF_Project.benefitGrandTotals>();
            list<Benefiting_Business_Group__c> deleteChildBBG = new list<Benefiting_Business_Group__c>();
            list<Benefiting_Business_Group__c> updateChildBBG = new list<Benefiting_Business_Group__c>();
            List<QIPP_Project__c> activityList = new List<QIPP_Project__c>();
                
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
                
            List<QIPP_CIF_Project.BAMWrapper> bamWraplist = new List<QIPP_CIF_Project.BAMWrapper>();
            QIPP_CIF_Project.BAMWrapper bamWrap = new QIPP_CIF_Project.BAMWrapper();
            bamWrap.activityName = ba.name;
            bamWrap.businessFunc = ba.Business_Function__c;
            bamWrap.valueStream = ba.Value_Stream__c;
            // bamWrap();
            bamWraplist.add(bamWrap);
                    
            bamWraplist.add(new QIPP_CIF_Project.BAMWrapper(ba.name,ba.Business_Function__c,ba.Value_Stream__c));

            QIPP_CIF_Project.BAMWrapper bamWrap1 = new QIPP_CIF_Project.BAMWrapper();
            bamWrap1.activityName = ba1.name;
            bamWrap1.businessFunc = ba1.Business_Function__c;
            bamWrap1.valueStream = ba1.Value_Stream__c;
            bamWraplist.add(bamWrap1);

            QIPP_CIF_Project.BAMWrapper bamWrap2 = new QIPP_CIF_Project.BAMWrapper();
            bamWrap2.activityName = ba2.name;
            bamWrap2.businessFunc = ba2.Business_Function__c;
            bamWrap2.valueStream = ba2.Value_Stream__c;
            bamWraplist.add(bamWrap2);

            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.Portfolio_BU__c='Human Resources';
            project.Project_BL__c = 'BHR FN';
            project.Benefitting_Project_BL_Level_4_Org__c = 'Project Management';
            project.CEMT_ID__c = 'test123';
            project.Project_Completion_Date_Forecast__c=Date.Today();
            project.Project_Description_Detailed__c='testtesttesttesttesttesttesttesttesttest';
            project.Project_Sponsor__c=con.id;
            project.CIF_Phase__c = 'Define';
            project.Deployment_Date__c=Date.Today();
            project.Institutionalize_Date__c=Date.Today();
            project.RecordTypeId = RTID_DMAIC;
            project.Project_Completion_Date_Target__c = Date.Today();
            project.Project_Name_Succinct__c = 'Test Project1';
            project.Primary_QLT_Function__c = 'CO';
            //project.Project_State__c = 'In Progress';
            project.Last_Review_Type__c = 'Final';
            project.Project_Lead__c = con.id;
            project.ownerid = DummyUser.Id;
            project.Project_Document__c = 'https://www.google.com';
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_State__c = 'In Progress';
            project.Finance_Approver__c = con.Id;
            project.Improvement_Owner__c = con.id;
            insert project;
            projectList.add(project);
                
                
            QIPP_Project__c project1 = new QIPP_Project__c();
            project1.Portfolio_Name__c = portfolio.id;
            project1.Portfolio_BU__c='Human Resources'; 
            project1.Project_BL__c = 'BHR FN';
            project1.Benefitting_Project_BL_Level_4_Org__c = 'Project Management';
            project1.CEMT_ID__c = 'test123';
            project1.Project_Completion_Date_Forecast__c=Date.Today();
            project1.Project_Description_Detailed__c='testtesttesttesttesttesttesttesttesttest';
            project1.Project_Sponsor__c=con.id;
            project1.CIF_Phase__c = 'Define';
            project1.Deployment_Date__c=Date.Today();
            project1.Institutionalize_Date__c=Date.Today();
            project1.RecordTypeId = RTID_DMAIC;
            project1.Project_Completion_Date_Target__c = Date.Today();
            project1.Project_Name_Succinct__c = 'Test Project2';
            project1.Primary_QLT_Function__c = 'CO';
            project1.Project_State__c = 'In Progress';
            project1.Last_Review_Type__c = 'Final';
            project1.Project_Lead__c = con.id;
            project1.ownerid = DummyUser.Id;
            project1.Report_Name__c = 'Executive Dashboards';
            project1.Report_Type__c = 'Summary of Projects by Project Type ';
            project1.Project_Document__c = 'https://www.google.com';
            //project1.Project_State__c = 'Complete';
            project1.Finance_Approver__c = con.id;
            project1.Improvement_Owner__c = con.id;
            insert project1;
            projectList.add(project1);
            //activityList.add(project1);
                    
            QIPP_Project__c activity = new QIPP_Project__c();
            activity.id=project.id;
            activity.Business_Activity_Mapping__c=ba.id;
            //activity.Business_Activity_Mapping__r.name=ba.name;
            activity.Business_Activity_Mapping_ValueStream__c=ba.Value_Stream__c ;
            activity.Business_Activity_Mapping_BusinessFunc__c=ba.Business_Function__c ;
            activity.Business_Activity_Mapping2__c=ba1.id;
            //activity.Business_Activity_Mapping2__r.name=ba1.name;
            activity.Business_Activity_Mapping2_ValueStream__c=ba1.Value_Stream__c ;
            activity.Business_Activity_Mapping2_BusinessFunc__c=ba1.Business_Function__c ;
            activity.Business_Activity_Mapping3__c=ba2.id;
            //activity.Business_Activity_Mapping3__r.name=ba2.name;
            activity.Business_Activity_Mapping3_ValueStream__c=ba2.Value_Stream__c;
            activity.Business_Activity_Mapping3_BusinessFunc__c=ba2.Business_Function__c;
            upsert activity;
            activityList.add(activity);
             
            QIPP_Benefit_Conversion_Table__c im = new QIPP_Benefit_Conversion_Table__c();
            im.Active__c = true;
            im.Name = 'test';
            insert im;
                    
            QIPP_Benefit_Conversion_Table__c im1 = new QIPP_Benefit_Conversion_Table__c();
            im1.Active__c = true;
            im1.Name = 'test1';
            insert im1;
                    
            QIPP_Benefit__c qb = new QIPP_Benefit__c();
            // qb.Name= 'test'; 
            qb.Improvement_Measure_KPI__c= im.id;
            //qb.Improvement_Measure_KPI__r.Name= im.Name;
            qb.Benefit_Type__c= 'Financial Savings';
            qb.Project_ID__c= project1.Id;
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
            qb1.Improvement_Measure_KPI__c= im1.id;
            //qb.Improvement_Measure_KPI__r.Name= im.Name;
            qb1.Benefit_Type__c= 'Operational Savings';
            qb1.Project_ID__c= project1.Id;
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
            qb2.Improvement_Measure_KPI__c= im1.id;
            //qb.Improvement_Measure_KPI__r.Name= im.Name;
            qb2.Benefit_Type__c= 'Projected Revenue';
            qb2.Project_ID__c= project1.Id;
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
            qb3.Improvement_Measure_KPI__c= im1.id;
            //qb.Improvement_Measure_KPI__r.Name= im.Name;
            qb3.Benefit_Type__c= 'Realized Revenue';
            qb3.Project_ID__c= project1.Id;
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
            qb3.Benefit_Amount_Achieved_Future_k__c=1000.0;
            qb3.Benefit_Operational_Achieved_Future_k__c=1000.0;
            qb3.Benefit_Projected_Achieved_Future_k__c=1000.0;
            qb3.Benefit_Realized_Achieved_Future_k__c=1000.0;
            insert qb3;
            Benefits_RelatedList.add(qb3);
                                
            Benefiting_Business_Group__c bbg = new Benefiting_Business_Group__c();                
            bbg.Distribution__c=2.0;
            bbg.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
            bbg.Benefitting_Business_Unit__c='BHR FN';
            bbg.Benefitting_Business_Line__c='Project Management';
            bbg.Financial_Validation_Amount__c=100.0;
            bbg.Operational_Validation_Amount__c=100.0;
            bbg.Projected_Validation_Amount__c=100.0;
            bbg.Realized_Validation_Amount__c=100.0;
            bbg.Project_ID__c = project.id;
            bbg.Project_BG__c = true;
            insert bbg;

            Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();
            bbg1.Distribution__c=2.0;
            bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Global'; 
            bbg1.Benefitting_Business_Unit__c='Multiple BUs';
            bbg1.Benefitting_Business_Line__c='Not Yet Known';
            bbg1.Financial_Validation_Amount__c=100.0;
            bbg1.Operational_Validation_Amount__c=100.0;
            bbg1.Projected_Validation_Amount__c=100.0;
            bbg1.Realized_Validation_Amount__c=100.0;
            bbg1.Project_ID__c = project.id;
            bbg1.Project_BG__c = true;          
            insert bbg1;
        
            Benefiting_Business_Group__c bbg2 = new Benefiting_Business_Group__c();                
            bbg2.Distribution__c=2.0;
            bbg2.Benefitting_Business_Grp_Functional_Grp__c= 'Quality'; 
            bbg2.Benefitting_Business_Unit__c='Multiple BUs';
            bbg2.Benefitting_Business_Line__c='Multiple BLs';
            bbg2.Financial_Validation_Amount__c=100.0;
            bbg2.Operational_Validation_Amount__c=100.0;
            bbg2.Projected_Validation_Amount__c=100.0;
            bbg2.Realized_Validation_Amount__c=100.0;
            bbg2.Project_ID__c = project.id;
            bbg2.Project_BG__c = true;                
            insert bbg2;
        
            test.starttest();     
            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            QIPP_CIF_Project CIFprj = new QIPP_CIF_Project(sc);
            CIFprj.portfolioName= portfolio.id;
            CIFprj.genericError = 'VIPT';
            //CIFprj.activityList = activityList;
            CIFprj.profileName = 'Each';
            CIFprj.roleName = DummyUser.userrole.name;
            CIFprj.phasecompleted = 'Indirect Financial';
            CIFprj.projectId = project.id;
            CIFprj.projState = 'Lower is Favorable';
            CIFprj.recIsLocked = false;
            CIFprj.benefitAmount = 20.2;
            CIFprj.reqApprovalMessage = 'test';
            CIFprj.displayPopup = true;
            CIFprj.isAlertType = true;
            CIFprj.currPortfolioId = portfolio.id;
            CIFprj.cloneid = project.id;
            //CIFprj.portfolioName = 'test';
            CIFprj.issaveandnew = true;
            CIFprj.Proj.Project_Document__c = 'https://www.google.com';
            CIFprj.getPortfolioBBGValue();
            CIFprj.getPortfolioValues();
            CIFprj.saveProject();
            PageReference pageRef12 = Page.QIPPCIFProjectDetailView;
            Test.setCurrentPage(pageRef12);
            CIFprj.cancel();
            CIFprj.ValidationCancel();
            CIFprj.edit();
            CIFprj.deleteRecord();
            CIFprj.cloneProject();

            PageReference pageRef = Page.QIPPCIFProjectDetailView;
            Test.setCurrentPage(pageRef);

            CIFprj.Benefits_RelatedList = Benefits_RelatedList;
            CIFprj.getBenefits();
            CIFprj.BAMWrapperList =  bamWraplist;

            QIPP_CIF_Project.benefitGrandTotals bgt = new QIPP_CIF_Project.benefitGrandTotals();
            bgt.plannedGTotal = 20.0;
            bgt.achievedGTotal = 200.0;
            bgt.futureGTotal = 850.0;
            bgt.validationAmount = 500.0;
            bgt.plannedGTotalEuro = 'test';
            bgt.achievedGTotalEuro = 'test1';
            bgt.futureGTotalEuro = 'test2';
            bgt.validationAmountEuro = 'test3';
            benefitGrandTotalsList.add(bgt);            

            QIPP_CIF_Project.benefitGrandTotals bgt1 = new QIPP_CIF_Project.benefitGrandTotals();
            bgt1.plannedGTotal = 20.0;
            bgt1.achievedGTotal = 200.0;
            bgt1.futureGTotal = 850.0;
            bgt1.validationAmount = 500.0;
            bgt1.plannedGTotalEuro = 'test';
            bgt1.achievedGTotalEuro = 'test1';
            bgt1.futureGTotalEuro = 'test2';
            bgt1.validationAmountEuro = 'test3';
            benefitGrandTotalsList.add(bgt1);

            CIFprj.benefitGrandTotalsList = benefitGrandTotalsList;
            CIFprj.reqApproval();
            CIFprj.submitapprove();
            CIFprj.unlockRecord();


            ApexPages.StandardController sc1 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj1 = new QIPP_CIF_Project(sc1);
            CIFprj1.proj.Project_Document__c = 'https://www.nokia.com';
            CIFprj1.recIsLocked = true;
            CIFprj1.edit();
            //        CIFprj1.recIsLocked = false;
            CIFprj1.deleteRecord();
            CIFprj1.cloneProject();
            CIFprj1.unlockRecord();

            PageReference pageRef1 = Page.QIPPCIFProjectDetailView;
            Test.setCurrentPage(pageRef1);
            ApexPages.StandardController sc2 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj2 = new QIPP_CIF_Project(sc2);
            ApexPages.currentPage().getParameters().put('CloneID',project1.id);
            CIFprj2.cloneProject();
            CIFprj2.recordIsLocked(project1.id);
            //CIFprj.getBAMDetailsMap();
            CIFprj2.currentView = 'QIPPCIFProjectEditView';
            CIFprj2.saveProject();

            ApexPages.currentPage().getParameters().put('cancelURL','test');
            CIFprj2.cancel();

            ApexPages.StandardController sc3 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj3 = new QIPP_CIF_Project(sc3);
            ApexPages.currentPage().getParameters().put('retURL','test');
            ApexPages.currentPage().getParameters().put('id',project1.id);
            CIFprj3.recIsLocked = true;
            CIFprj3.reqApproval();
            CIFprj3.cancel();

            ApexPages.StandardController sc4 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj4 = new QIPP_CIF_Project(sc4);
            CIFprj4.recordtypeName = ApexPages.currentPage().getParameters().put('RecordType','CIF');
            //CIFprj4.currPortfolioId= ApexPages.currentPage().getParameters().put('currPortfolio',portfolio.id);
            CIFprj4.issaveandnew = true;
            CIFprj4.saveProject();
            CIFprj4.reqApproval();

            ApexPages.StandardController sc5 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj5 = new QIPP_CIF_Project(sc5);     
            //CIFprj5.proj.id= ApexPages.currentPage().getParameters().put('id',null);
            CIFprj5.currPortfolioId= ApexPages.currentPage().getParameters().put('currPortfolio',portfolio.id);
            CIFprj5.portfolioName= portfolio.id;
            CIFprj5.currPortfolioId = portfolio.Id;
            CIFprj5.currentView = 'QIPPCIFProjectEditView'; 
            CIFprj5.roleName = 'QIPP Project Lead';
            CIFprj5.getPortfolioBBGValue();
            CIFprj5.issaveandnew = false;
            CIFprj5.saveProject();

            ApexPages.StandardController sc6 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj6 = new QIPP_CIF_Project(sc6);
            CIFprj6.issaveandnew = true;
            CIFprj6.saveProject();

            ApexPages.StandardController sc66 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj66 = new QIPP_CIF_Project(sc66);
            CIFprj66.issaveandnew = false;
            CIFprj66.saveProject();
            CIFprj66.closePopup();

            PageReference pageRef2 = Page.QIPPCIFProjectDetailView;
            Test.setCurrentPage(pageRef2);

            ApexPages.StandardController sc7 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj7 = new QIPP_CIF_Project(sc7);
            project1.Project_State__c = 'Complete';
            update project1;

            CIFprj7.reqApproval();
            QIPP_ApprovalsProcessNonSixSigma.TasksCheck(project1.id);


            ApexPages.StandardController sc8 = new ApexPages.StandardController(project);
            QIPP_CIF_Project CIFprj8 = new QIPP_CIF_Project(sc8);
            CIFprj8.portfolioName= '';
            CIFprj8.currentView='QIPPCIFProjectEditView';
            CIFprj8.errorMessages();

            ApexPages.StandardController sc11 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj11 = new QIPP_CIF_Project(sc11); 
                
            test.stoptest();                
        }
    }
        
    private static testmethod void test1(){
        User DummyUser;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser){
            DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
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
            
            QIPP_Contacts__c con1 = new QIPP_Contacts__c();
            con1.Name = 'Abhishek';
            con1.Email__c = 'a@b.a';
            con1.Contact_State__c = 'Active';
            con1.NSN_ID_Text__c = '1223434665';
            con1.Belt_Certification__c='Nokia-Green Belt';
            con1.Contact_BU__c='CFOO346';
            con1.Contact_BL__c='CFOO3';
            con1.Contact_L4_Org__c='CFOO5';
           // con1.User_License__c = DummyUser.id;
            con1.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con1.CoPQ_Role_2__c='BL Transformation Lead';
            con1.CoPQ_Role_3__c='Measure Creator';
            con1.CoPQ_Role_4__c='Business Owner Delegate';        
            insert con1;
            
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
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            List<QIPP_Project__c> projectList = new List<QIPP_Project__c>();
            List<QIPP_Benefit__c> Benefits_RelatedList = new List<QIPP_Benefit__c>();
            List<QIPP_Benefit__c> Benefits_RelatedList1 = new List<QIPP_Benefit__c>();
            List<QIPP_Benefit__c> Benefits_RelatedList2 = new List<QIPP_Benefit__c>();
            List<QIPP_Benefit__c> Benefits_RelatedList3 = new List<QIPP_Benefit__c>();
         
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.Portfolio_BU__c='Human Resources';
            project.Project_BL__c = 'BHR FN';
            project.Benefitting_Project_BL_Level_4_Org__c = 'Project Management';
            project.CEMT_ID__c = 'test123';
            project.Project_Completion_Date_Forecast__c= Date.Today();
            project.Project_Description_Detailed__c='testtesttesttesttesttesttesttesttesttest';
            project.Project_Sponsor__c=con.id;
            project.CIF_Phase__c = 'Define';
            project.Deployment_Date__c=Date.Today();
            project.Institutionalize_Date__c=Date.Today();
            project.RecordTypeId = RTID_DMAIC;
            project.Project_Completion_Date_Target__c = Date.Today();
            project.Project_Name_Succinct__c = 'Test Project1';
            project.Primary_QLT_Function__c = 'CO';
            project.Project_State__c = 'In Progress';
            project.Last_Review_Type__c = 'Final';
            project.Project_Lead__c = con.id;
            project.ownerid = DummyUser.Id;
            project.Project_Document__c = 'https://www.google.com';
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            //project.Project_State__c = 'Complete';
            project.Finance_Approver__c = con.Id;
            project.Improvement_Owner__c = con.id;
            insert project;
            projectList.add(project);
            
            QIPP_Project__c project1 = new QIPP_Project__c();
            project1.Portfolio_Name__c = portfolio.id;
            project1.Portfolio_BU__c='Human Resources';

            project1.Project_BL__c = 'BHR FN';
            project1.Benefitting_Project_BL_Level_4_Org__c = 'Project Management';
            project1.CEMT_ID__c = 'test123';
            project1.Project_Completion_Date_Forecast__c=Date.Today().addDays(-2);
            project1.Project_Description_Detailed__c='testtesttesttesttesttesttesttesttesttest';
            project1.Project_Sponsor__c=con.id;
            project1.CIF_Phase__c = 'Define';
            project1.Deployment_Date__c=Date.Today();
            project1.Institutionalize_Date__c=Date.Today();
            project1.RecordTypeId = RTID_DMAIC;
            project1.Project_Completion_Date_Target__c = Date.Today();
            project1.Project_Name_Succinct__c = 'Test Project2';
            project1.Primary_QLT_Function__c = 'CO';
            project1.Project_State__c = 'In Progress';
            project1.Last_Review_Type__c = 'Final';
            project1.Project_Lead__c = con.id;
            project1.ownerid = DummyUser.Id;
            project1.Report_Name__c = 'Executive Dashboards';
            project1.Report_Type__c = 'Summary of Projects by Project Type ';
            // project1.Project_State__c = 'Complete';
            project1.Finance_Approver__c = con.id;
            project1.Improvement_Owner__c = con.id;
            project1.Business_Activity_Mapping__c = ba1.Id;
            project1.Business_Activity_Mapping2__c = ba2.Id;
            insert project1;
            projectList.add(project1);
                
            QIPP_Project__c project2 = new QIPP_Project__c();
            project2.Portfolio_Name__c = portfolio.id;
            project2.Portfolio_BU__c='Human Resources';
            project2.Project_BL__c = 'BHR FN';
            project2.Benefitting_Project_BL_Level_4_Org__c = 'Project Management';
            project2.CEMT_ID__c = 'test123';
            project2.Project_Completion_Date_Forecast__c=Date.Today();
            project2.Project_Description_Detailed__c='testtesttesttesttesttesttesttesttesttest';
            project2.Project_Sponsor__c=con.id;
            project2.CIF_Phase__c = 'Define';
            project2.Deployment_Date__c=Date.Today();
            project2.Institutionalize_Date__c=Date.Today();
            project2.RecordTypeId = RTID_DMAIC;
            project2.Project_Completion_Date_Target__c = Date.Today();
            project2.Project_Name_Succinct__c = 'Test Project2';
            project2.Primary_QLT_Function__c = 'CO';
            project2.Project_State__c = 'In Progress';
            project2.Last_Review_Type__c = 'Final';
            project2.Project_Lead__c = con.id;
            project2.ownerid = DummyUser.Id;
            project2.Report_Name__c = 'Executive Dashboards';
            project2.Report_Type__c = 'Summary of Projects by Project Type ';
            // project1.Project_State__c = 'Complete';
            project2.Finance_Approver__c = con.id;
            project2.Improvement_Owner__c = con.id;
            insert project2;
            projectList.add(project2);
                
            QIPP_Project__c project3 = new QIPP_Project__c();
            project3.Portfolio_Name__c = portfolio.id;
            project3.Portfolio_BU__c='Human Resources';
            project3.Project_BL__c = 'BHR FN';
            project3.Benefitting_Project_BL_Level_4_Org__c = 'Project Management';
            project3.CEMT_ID__c = 'test123';
            project3.Project_Completion_Date_Forecast__c=Date.Today();
            project3.Project_Description_Detailed__c='testtesttesttesttesttesttesttesttesttest';
            project3.Project_Sponsor__c=con.id;
            project3.CIF_Phase__c = 'Define';
            project3.Deployment_Date__c=Date.Today();
            project3.Institutionalize_Date__c=Date.Today();
            project3.RecordTypeId = RTID_DMAIC;
            project3.Project_Completion_Date_Target__c = Date.Today();
            project3.Project_Name_Succinct__c = 'Test Project2';
            project3.Primary_QLT_Function__c = 'CO';
            project3.Project_State__c = 'In Progress';
            project3.Last_Review_Type__c = 'Final';
            project3.Project_Lead__c = con.id;
            project3.ownerid = DummyUser.Id;
            project3.Report_Name__c = 'Executive Dashboards';
            project3.Report_Type__c = 'Summary of Projects by Project Type ';
            // project1.Project_State__c = 'Complete';
            project3.Finance_Approver__c = con.id;
            project3.Improvement_Owner__c = con.id;
            project3.Project_Document__c = 'https://www.google.com';
            insert project3;
            projectList.add(project3);
        
            List<QIPP_CIF_Project.BAMWrapper> bamWraplist = new List<QIPP_CIF_Project.BAMWrapper>();
            QIPP_CIF_Project.BAMWrapper bamWrap = new QIPP_CIF_Project.BAMWrapper();
            bamWrap.activityName = ba.name;
            bamWrap.businessFunc = ba.Business_Function__c;
            bamWrap.valueStream = ba.Value_Stream__c;
            // bamWrap();
            bamWraplist.add(bamWrap);
            
            bamWraplist.add(new QIPP_CIF_Project.BAMWrapper(ba.name,ba.Business_Function__c,ba.Value_Stream__c));
            
            QIPP_CIF_Project.BAMWrapper bamWrap1 = new QIPP_CIF_Project.BAMWrapper();
            bamWrap1.activityName = ba1.name;
            bamWrap1.businessFunc = ba1.Business_Function__c;
            bamWrap1.valueStream = ba1.Value_Stream__c;
            bamWraplist.add(bamWrap1);
            
            QIPP_CIF_Project.BAMWrapper bamWrap2 = new QIPP_CIF_Project.BAMWrapper();
            bamWrap2.activityName = ba2.name;
            bamWrap2.businessFunc = ba2.Business_Function__c;
            bamWrap2.valueStream = ba2.Value_Stream__c;
            bamWraplist.add(bamWrap2);
            
            List<QIPP_Project__c> activityList = new List<QIPP_Project__c>();
            
            QIPP_Project__c activity = new QIPP_Project__c();
            activity.id=project.id;
            activity.Business_Activity_Mapping__c=ba.id;
            //activity.Business_Activity_Mapping__r.name=ba.name;
            activity.Business_Activity_Mapping_ValueStream__c=ba.Value_Stream__c ;
            activity.Business_Activity_Mapping_BusinessFunc__c=ba.Business_Function__c ;
            activity.Business_Activity_Mapping2__c=ba1.id;
            //activity.Business_Activity_Mapping2__r.name=ba1.name;
            activity.Business_Activity_Mapping2_ValueStream__c=ba1.Value_Stream__c ;
            activity.Business_Activity_Mapping2_BusinessFunc__c=ba1.Business_Function__c ;
            activity.Business_Activity_Mapping3__c=ba2.id;
            //activity.Business_Activity_Mapping3__r.name=ba2.name;
            activity.Business_Activity_Mapping3_ValueStream__c=ba2.Value_Stream__c;
            activity.Business_Activity_Mapping3_BusinessFunc__c=ba2.Business_Function__c;
            upsert activity;
            activityList.add(activity);
            
            QIPP_Benefit_Conversion_Table__c im = new QIPP_Benefit_Conversion_Table__c();
            im.Active__c = true;
            im.Name = 'test';
            insert im;
            
            QIPP_Benefit_Conversion_Table__c im1 = new QIPP_Benefit_Conversion_Table__c();
            im1.Active__c = true;
            im1.Name = 'test1';
            insert im1;
            
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
            Benefits_RelatedList1.add(qb);
            Benefits_RelatedList2.add(qb);
            Benefits_RelatedList3.add(qb);

            QIPP_Benefit__c qb1 = new QIPP_Benefit__c();
            // qb.Name= 'test'; 
            qb1.Improvement_Measure_KPI__c= im1.id;
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
            Benefits_RelatedList1.add(qb1);
            Benefits_RelatedList2.add(qb1);
            Benefits_RelatedList3.add(qb1);


            QIPP_Benefit__c qb2 = new QIPP_Benefit__c();
            // qb.Name= 'test'; 
            qb2.Improvement_Measure_KPI__c= im1.id;
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
            Benefits_RelatedList1.add(qb2);
            Benefits_RelatedList2.add(qb2);
            Benefits_RelatedList3.add(qb2);

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
            Benefits_RelatedList1.add(qb3);
            Benefits_RelatedList2.add(qb3);
            Benefits_RelatedList3.add(qb3);

            test.starttest();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            QIPP_CIF_Project CIFprj = new QIPP_CIF_Project(sc);
             
            CIFprj.portfolioName= portfolio.id;
            CIFprj.genericError = 'VIPT';
            CIFprj.proj.Project_Document__c = 'https://www.nokia.com';
            CIFprj.profileName = 'Each';
            CIFprj.roleName = 'QIPP Project Lead';
            CIFprj.phasecompleted = 'Indirect Financial';
            CIFprj.projectId = project.id;
            CIFprj.projState = 'Lower is Favorable';
            CIFprj.recIsLocked = false;
            CIFprj.benefitAmount = 20.2;
            CIFprj.reqApprovalMessage = 'test';
            CIFprj.displayPopup = true;
            CIFprj.isAlertType = true;
            CIFprj.currPortfolioId = portfolio.id;
            CIFprj.cloneid = project1.id;
            CIFprj.currentView= 'QIPPCIFProjectEditView';
            CIFprj.issaveandnew = false;
            CIFprj.hasSaveValidationError = false;
            CIFprj.saveProject();
            CIFprj.Benefits_RelatedList = Benefits_RelatedList;
            CIFprj.getBenefits();

            ApexPages.StandardController sc7 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj7 = new QIPP_CIF_Project(sc7);
            //project1.Project_State__c = 'Complete';
            CIFprj7.portfolioName= '';
            CIFprj7.currentView='QIPPCIFProjectEditView';
            project1.Project_Document__c = 'https://www.google.com';
            // project1.TotalKPI__c = 20;
            // project1.TotalCOPQ__c = 23;
            //project1.Portfolio_Name__c = null;
            project1.Improvement_Owner__c = con1.id;
            project1.Belt_Assigned__c=con1.id;

            update project1;
            CIFprj7.reqApprovalMessage = 'test';
            CIFprj7.recIsLocked = false;
            CIFprj7.errorMessages();

            ApexPages.StandardController sc8 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj8 = new QIPP_CIF_Project(sc8);

            project1.Project_State__c = 'Complete';
            update project1;
            CIFprj8.reqApproval();

            ApexPages.StandardController sc11 = new ApexPages.StandardController(project1);
            QIPP_CIF_Project CIFprj11 = new QIPP_CIF_Project(sc11);

            Benefits_RelatedList1[0].Benefit_Type__c = 'Projected Revenue';
            Benefits_RelatedList1[1].Benefit_Type__c = 'Realized Revenue';
            Benefits_RelatedList1[2].Benefit_Type__c = 'Operational Savings';
            Benefits_RelatedList1[3].Benefit_Type__c = 'Financial Savings';
            update Benefits_RelatedList1;

            CIFprj11.Benefits_RelatedList = Benefits_RelatedList1;
            CIFprj11.getBenefits();
            
            ApexPages.StandardController sc12 = new ApexPages.StandardController(project2);
            QIPP_CIF_Project CIFprj12 = new QIPP_CIF_Project(sc12);

            Benefits_RelatedList2[0].Benefit_Type__c = 'Realized Revenue';
            Benefits_RelatedList2[1].Benefit_Type__c = 'Operational Savings';
            Benefits_RelatedList2[2].Benefit_Type__c = 'Financial Savings';
            Benefits_RelatedList2[3].Benefit_Type__c = 'Projected Revenue';
            update Benefits_RelatedList2;

            CIFprj11.Benefits_RelatedList = Benefits_RelatedList2;
            CIFprj12.getBenefits();

            ApexPages.StandardController sc13 = new ApexPages.StandardController(project3);
            QIPP_CIF_Project CIFprj13 = new QIPP_CIF_Project(sc13);

            Benefits_RelatedList3[0].Benefit_Type__c = 'Operational Savings';
            Benefits_RelatedList3[1].Benefit_Type__c = 'Financial Savings';
            Benefits_RelatedList3[2].Benefit_Type__c = 'Projected Revenue';
            Benefits_RelatedList3[3].Benefit_Type__c = 'Realized Revenue';
            update Benefits_RelatedList3;
            CIFprj13.getBenefits();
            CIFprj13.Benefits_RelatedList = Benefits_RelatedList3;
            CIFprj13.portfolioName = '1';
            CIFprj13.currentview = 'QIPPCIFProjectEditView';
            CIFprj13.errorMessages();

            project3.Project_Document__c = 'https://www.salesforce.com';
            project3.Project_Completion_Date_Forecast__c=Date.Today()-1;
            update project3;

            ApexPages.StandardController sc14 = new ApexPages.StandardController(project3);
            QIPP_CIF_Project CIFprj14 = new QIPP_CIF_Project(sc14);

            //CIFprj13.portfolioName = '1';
            CIFprj14.currentview = 'QIPPCIFProjectEditView';
            CIFprj14.errorMessages();
            CIFprj14.callDummy();

            ApexPages.StandardController sc15 = new ApexPages.StandardController(project);
            QIPP_CIF_Project CIFprj15 = new QIPP_CIF_Project(sc15);  
            CIFprj15.activityList = activityList;

            ApexPages.StandardController sc16 = new ApexPages.StandardController(project3);
            QIPP_CIF_Project CIFprj16 = new QIPP_CIF_Project(sc16);
            CIFprj16.submitapprove();
            CIFprj16.reqApproval();
            test.stoptest();
        }
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
        portfolio.CIF__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        
        Business_Activity__c ba = new Business_Activity__c();
        ba.name = 'Test Business Activity';
        ba.Business_Function__c = 'Marketing & communications';
        ba.Value_Stream__c = 'Features';
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
    
        QIPP_Project__c project = new QIPP_Project__c();
        project.Portfolio_Name__c = portfolio.id;
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
        project.Project_Sponsor__c = con.id;
        project.CIF_Phase__c = 'ASA';
        project.Deployment_Date__c = Date.Today();
        project.Institutionalize_Date__c = Date.Today();
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Business_Activity_Mapping__c = ba.id;
        project.Business_Activity_Mapping2__c = ba1.id;
        project.Business_Activity_Mapping3__c = ba2.id;
        project.Project_Document__c = 'https://www.tset.com';
        project.Project_State__c = 'Canceled'; 
        insert project;
        
        Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
        bbg1.Distribution__c=2.0;
        bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg1.Benefitting_Business_Unit__c='BHR FN';
        bbg1.Benefitting_Business_Line__c='Project Management';
        bbg1.Financial_Validation_Amount__c=100.0;
        bbg1.Operational_Validation_Amount__c=100.0;
        bbg1.Projected_Validation_Amount__c=100.0;
        bbg1.Realized_Validation_Amount__c=100.0;
        bbg1.Project_ID__c = project.id;
        bbg1.Project_BG__c = false;
        insert bbg1;                
        
        QIPP_Benefit_Conversion_Table__c im = new QIPP_Benefit_Conversion_Table__c();
        im.Active__c = true;
        im.Name = 'test';
        insert im;
                
        List<QIPP_Benefit__c> Benefits_RelatedList = new List<QIPP_Benefit__c>();
    
        QIPP_Benefit__c qb = new QIPP_Benefit__c();
        // qb.Name= 'test'; 
        qb.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb.Benefit_Type__c= 'Financial Savings';
        qb.Project_ID__c= project.Id;
        qb.Unit_of_Measure__c= 'Dollars';
        qb.Improvement_Measure_Name__c= 'test';
        qb.Planned_Financial_Savings_Total__c=0.1;
        qb.Planned_Operational_Savings_Total__c=0.1;
        qb.Planned_Projected_Savings_Total__c=0.1;
        qb.Planned_Realized_Savings_Total__c=0.1;
        qb.Achieved_Financial_Savings_Total__c=0.1;
        qb.Achieved_Operational_Savings_Total__c=0.1;
        qb.Achieved_Projected_Savings_Total__c=0.1;
        qb.Achieved_Realized_Savings_Total__c=0.1;
        qb.Future_Financial_Savings_Total__c=0.1;
        qb.Future_Operational_Savings_Total__c=0.1;
        qb.Future_Projected_Savings_Total__c=0.1;
        qb.Future_Realized_Savings_Total__c=0.1;
        qb.Benefit_Amount_Achieved_Future_k__c=0.1;
        qb.Benefit_Operational_Achieved_Future_k__c=0.1;
        qb.Benefit_Projected_Achieved_Future_k__c=0.1;
        qb.Benefit_Realized_Achieved_Future_k__c=0.1;
    
        insert qb;
        Benefits_RelatedList.add(qb);
        
        QIPP_Benefit__c qb1 = new QIPP_Benefit__c();
        // qb.Name= 'test'; 
        qb1.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb1.Benefit_Type__c= 'Operational Savings';
        qb1.Project_ID__c= project.Id;
        qb1.Unit_of_Measure__c= 'Dollars';
        qb1.Improvement_Measure_Name__c= 'test';
        qb1.Planned_Financial_Savings_Total__c=0.1;
        qb1.Planned_Operational_Savings_Total__c=0.1;
        qb1.Planned_Projected_Savings_Total__c=0.1;
        qb1.Planned_Realized_Savings_Total__c=0.1;
        qb1.Achieved_Financial_Savings_Total__c=0.1;
        qb1.Achieved_Operational_Savings_Total__c=0.1;
        qb1.Achieved_Projected_Savings_Total__c=0.1;
        qb1.Achieved_Realized_Savings_Total__c=0.1;
        qb1.Future_Financial_Savings_Total__c=0.1;
        qb1.Future_Operational_Savings_Total__c=0.1;
        qb1.Future_Projected_Savings_Total__c=0.1;
        qb1.Future_Realized_Savings_Total__c=0.1;
        qb1.Benefit_Amount_Achieved_Future_k__c=0.1;
        qb1.Benefit_Operational_Achieved_Future_k__c=0.1;
        qb1.Benefit_Projected_Achieved_Future_k__c=0.1;
        qb1.Benefit_Realized_Achieved_Future_k__c=0.1;    
        insert qb1;
        Benefits_RelatedList.add(qb1);
        
        QIPP_Benefit__c qb2 = new QIPP_Benefit__c();
        // qb.Name= 'test'; 
        qb2.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb2.Benefit_Type__c= 'Projected Revenue';
        qb2.Project_ID__c= project.Id;
        qb2.Unit_of_Measure__c= 'Dollars';
        qb2.Improvement_Measure_Name__c= 'test';
        qb2.Planned_Financial_Savings_Total__c=0.1;
        qb2.Planned_Operational_Savings_Total__c=0.1;
        qb2.Planned_Projected_Savings_Total__c=0.1;
        qb2.Planned_Realized_Savings_Total__c=0.1;
        qb2.Achieved_Financial_Savings_Total__c=0.1;
        qb2.Achieved_Operational_Savings_Total__c=0.1;
        qb2.Achieved_Projected_Savings_Total__c=0.1;
        qb2.Achieved_Realized_Savings_Total__c=0.1;
        qb2.Future_Financial_Savings_Total__c=0.1;
        qb2.Future_Operational_Savings_Total__c=0.1;
        qb2.Future_Projected_Savings_Total__c=0.1;
        qb2.Future_Realized_Savings_Total__c=0.1;
        qb2.Benefit_Amount_Achieved_Future_k__c=0.1;
        qb2.Benefit_Operational_Achieved_Future_k__c=0.1;
        qb2.Benefit_Projected_Achieved_Future_k__c=0.1;
        qb2.Benefit_Realized_Achieved_Future_k__c=0.1;    
        insert qb2;
        Benefits_RelatedList.add(qb2);        
        
        QIPP_Benefit__c qb3 = new QIPP_Benefit__c();
        // qb.Name= 'test'; 
        qb3.Improvement_Measure_KPI__c= im.id;
        //qb.Improvement_Measure_KPI__r.Name= im.Name;
        qb3.Benefit_Type__c= 'Realized Revenue';
        qb3.Project_ID__c= project.Id;
        qb3.Unit_of_Measure__c= 'Dollars';
        qb3.Improvement_Measure_Name__c= 'test';
        qb3.Planned_Financial_Savings_Total__c=100;
        qb3.Planned_Operational_Savings_Total__c=100;
        qb3.Planned_Projected_Savings_Total__c=100;
        qb3.Planned_Realized_Savings_Total__c=100;
        qb3.Achieved_Financial_Savings_Total__c=100;
        qb3.Achieved_Operational_Savings_Total__c=100;
        qb3.Achieved_Projected_Savings_Total__c=100;
        qb3.Achieved_Realized_Savings_Total__c=100;
        qb3.Future_Financial_Savings_Total__c=100;
        qb3.Future_Operational_Savings_Total__c=100;
        qb3.Future_Projected_Savings_Total__c=100;
        qb3.Future_Realized_Savings_Total__c=100;
        qb3.Benefit_Amount_Achieved_Future_k__c=100;
        qb3.Benefit_Operational_Achieved_Future_k__c=100;
        qb3.Benefit_Projected_Achieved_Future_k__c=100;
        qb3.Benefit_Realized_Achieved_Future_k__c=100;    
        insert qb3;
        Benefits_RelatedList.add(qb3);        
        
        PageReference pageRef2 = Page.QIPP_DI_Logic_Edit_View;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_CIF_Project obj = new QIPP_CIF_Project(sc);
        obj.issaveandnew = true;
        obj.saveProject();
        obj.reqApproval();
        obj.closeLeadSponsorEqualPopup();
        obj.getBAMDetailsMap();
        
        ApexPages.currentPage().getParameters().put('retURL','asd');
        obj.Cancel();
        
        ApexPages.currentPage().getParameters().put('retURL','');
        ApexPages.currentPage().getParameters().put('cancelURL','');
        ApexPages.currentPage().getParameters().put('id','asd');                
        obj.Cancel();        
    }
    
    private static testmethod void test2(){
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
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
            project.Project_Sponsor__c = con.id;
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'Canceled'; 
            insert project;
            
            QIPP_Benefit__c bn = new QIPP_Benefit__c();
            bn.Project_ID__c = project.Id;
            bn.Benefit_Type__c = 'Operational Savings';
            bn.Planned_Operational_Savings_Total__c = 20;
            bn.Achieved_Operational_Savings_Total__c = 20;
            bn.Future_Operational_Savings_Total__c = 0;

            bn.Planned_Financial_Savings_Total__c = 20;
            bn.Achieved_Financial_Savings_Total__c = 20;
            bn.Future_Financial_Savings_Total__c = 20;
            
            bn.Planned_Projected_Savings_Total__c = 20;
            bn.Achieved_Projected_Savings_Total__c = 20;
            bn.Future_Projected_Savings_Total__c = 20;
            
            bn.Planned_Realized_Savings_Total__c = 20;
            bn.Achieved_Realized_Savings_Total__c = 20;
            bn.Future_Realized_Savings_Total__c = 20;            
            
            bn.Benefit_Projected_Achieved_Future_k__c = 20.1;
            bn.Benefit_Operational_Achieved_Future_k__c = 0;
            bn.Benefit_Realized_Achieved_Future_k__c = 20.1;
            bn.Benefit_Projected_Achieved_Future_k__c = 20.1;
            insert bn;

            Benefiting_Business_Group__c editBBG = new Benefiting_Business_Group__c();
            editBBG.Project_ID__c = project.id;
            editBBG.Project_BG__c = true;
            insert editBBG;
            
            Benefiting_Business_Group__c delBBG = new Benefiting_Business_Group__c();
            delBBG.Project_ID__c = project.id;
            delBBG.Project_BG__c = false;            
            insert delBBG;

            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            QIPP_CIF_Project obj = new QIPP_CIF_Project(sc);
            obj.BBGUpdated();
            
            bn.Planned_Financial_Savings_Total__c = 0;
            bn.Achieved_Financial_Savings_Total__c = 0;
            bn.Future_Financial_Savings_Total__c = 0;
            bn.Benefit_Amount_Achieved_Future_k__c = 0;
            update bn;
            sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            obj = new QIPP_CIF_Project(sc);
        }
    }
    
    private static testmethod void test4(){
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
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
            insert portfolio;
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
            project.Project_Sponsor__c = con.id;
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'Canceled'; 
            insert project;
            
            QIPP_Benefit__c bn = new QIPP_Benefit__c();
            bn.Project_ID__c = project.Id;
            bn.Benefit_Type__c = 'Projected Revenue';
            bn.Planned_Projected_Savings_Total__c = 0;
            bn.Achieved_Projected_Savings_Total__c = 20;
            bn.Future_Projected_Savings_Total__c = 20;
            bn.Benefit_Projected_Achieved_Future_k__c = 20;
            insert bn;

            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            QIPP_CIF_Project obj = new QIPP_CIF_Project(sc);
            
            bn.Planned_Financial_Savings_Total__c = 0;
            bn.Achieved_Financial_Savings_Total__c = 0;
            bn.Future_Financial_Savings_Total__c = 0;
            bn.Benefit_Amount_Achieved_Future_k__c = 0;
            update bn;
            sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            obj = new QIPP_CIF_Project(sc);            
         }
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
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
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
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
            bn.Benefit_Type__c = 'Realized Revenue';
            bn.Planned_Realized_Savings_Total__c = 20;
            bn.Achieved_Realized_Savings_Total__c = 0;
            bn.Future_Realized_Savings_Total__c = 20;
            bn.Benefit_Realized_Achieved_Future_k__c = 20;
            insert bn;
            
            QIPP_Benefit__c bn1 = new QIPP_Benefit__c();
            bn1.Project_ID__c = project.Id;
            bn1.Benefit_Type__c = 'Financial Savings';
            bn1.Planned_Financial_Savings_Total__c = 20;
            bn1.Achieved_Financial_Savings_Total__c = 20;
            bn1.Future_Financial_Savings_Total__c = 20;
            bn1.Benefit_Amount_Achieved_Future_k__c = 20;
            insert bn1;

            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            QIPP_CIF_Project obj = new QIPP_CIF_Project(sc);
            obj.currentView='QIPPCIFProjectEditView';
            obj.issaveandnew = true;
            obj.saveProject();
            
            bn.Planned_Financial_Savings_Total__c = 0;
            bn.Achieved_Financial_Savings_Total__c = 0;
            bn.Future_Financial_Savings_Total__c = 0;
            bn.Benefit_Amount_Achieved_Future_k__c = 0;
            update bn;
            sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            obj = new QIPP_CIF_Project(sc);
            obj.currentView='QIPPCIFProjectEditView';
            obj.issaveandnew = false;
            obj.saveProject();
            obj.reqApproval();
            
            test.stoptest();
        }
    }        
        
}