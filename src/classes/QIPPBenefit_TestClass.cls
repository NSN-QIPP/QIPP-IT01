@isTest
private with sharing class QIPPBenefit_TestClass
{
    static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;    
    private static testmethod void QIPPBenefit_Test0(){
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c BeConTable = new QIPP_Benefit_Conversion_Table__c();
        BeConTable.name = 'TestHPImp meaure test1';
        
        insert BeConTable;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
        benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
        benifit.Benefit_Type__c = 'Projected Revenue';
        benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        //benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Months__c = '5';
        benrep1.Benefits_Saving_Amount_Planned__c = 45;
        benrep1.Benefits_Saving_Amount_Achieved__c = 25;
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.QIPPProjectDetailView;       
        pageRef.getParameters().put('id',project.id);
        pageRef.getParameters().put('benefitid', String.valueOf(benifit.id));
        pageRef.getHeaders().put('referer','test');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con1 = new ApexPages.StandardController(project);
        QIPPBenefit cont1= new QIPPBenefit(con1);
        cont1.getYearValues();        
        cont1.getBusinesslinelist();
        cont1.benifit= benifit;
        cont1.showPopupeditBenf();
        cont1.displayPopupBenf = false;
        cont1.displayPopupeditBenf = true;
        cont1.AddRow();
        cont1.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont1.Bn_rep_AddList[1].Years__c = '2015';  
        cont1.Bn_rep_AddList[1].Months__c = '06';
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[2].Quarters__c = 'Q3';                           
        cont1.Bn_rep_AddList[2].Years__c = '2015';  
        cont1.Bn_rep_AddList[2].Months__c = '08';
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[2].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[3].Quarters__c = 'Q4';                           
        cont1.Bn_rep_AddList[3].Years__c = '2015';  
        cont1.Bn_rep_AddList[3].Months__c = '12';
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[3].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.AddRow();
        cont1.Bn_rep_AddList[4].Quarters__c = 'Q1';                           
        cont1.Bn_rep_AddList[4].Years__c = '2015';  
        cont1.Bn_rep_AddList[4].Months__c = '01';
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[4].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.setimpBenefitType('Financial Savings');
        cont1.saveBenefit();    
    }    
    private static testmethod void QIPPBenefit_Test1(){
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c BeConTable = new QIPP_Benefit_Conversion_Table__c();
        BeConTable.name = 'TestHPImp meaure test';
        
        insert BeConTable;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
        benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
        benifit.Benefit_Type__c = 'Operational Savings';
        benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_Benefit__c benifit1 = new QIPP_Benefit__c();
        benifit1.Improvement_Measure_Name__c = 'TestHPImp meaure test1';
        benifit1.Unit_of_Measure__c = 'Testunitofmeasuretest1';
        benifit1.Benefit_Type__c = 'Operational Savings1';
        benifit1.ImprovementMeasure_Brief_Description__c = 'test desc1';
        benifit1.Project_ID__c = project.id;
        insert benifit1;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        //benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Months__c = '5';
        benrep1.Benefits_Saving_Amount_Planned__c = 45;
        benrep1.Benefits_Saving_Amount_Achieved__c = 25;
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.QIPPProjectDetailView;       
        pageRef.getParameters().put('id',project.id);
        pageRef.getParameters().put('benefitid', String.valueOf(benifit.id));
        pageRef.getHeaders().put('referer','test');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con1 = new ApexPages.StandardController(project);
        QIPPBenefit cont1= new QIPPBenefit(con1);
        cont1.getYearValues();        
        cont1.getBusinesslinelist();
        cont1.benifit= benifit;
        cont1.showPopupeditBenf();
        cont1.displayPopupBenf = false;
        cont1.displayPopupeditBenf = true;
        cont1.AddRow();
        cont1.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont1.Bn_rep_AddList[1].Years__c = '2015';  
        cont1.Bn_rep_AddList[1].Months__c = '06';
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[2].Quarters__c = 'Q3';                           
        cont1.Bn_rep_AddList[2].Years__c = '2015';  
        cont1.Bn_rep_AddList[2].Months__c = '08';
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[2].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[3].Quarters__c = 'Q4';                           
        cont1.Bn_rep_AddList[3].Years__c = '2015';  
        cont1.Bn_rep_AddList[3].Months__c = '12';
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[3].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.AddRow();
        cont1.Bn_rep_AddList[4].Quarters__c = 'Q1';                           
        cont1.Bn_rep_AddList[4].Years__c = '2015';  
        cont1.Bn_rep_AddList[4].Months__c = '01';
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[4].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.saveBenefit();
        //benifit.Benefit_Type__c = 'Financial Savings';
        //update benifit;
        // cont1.benifit= benifit;
        cont1.setimpBenefitType('Financial Savings');
        cont1.displayPopupBenf = true;
        cont1.displayPopupeditBenf = true;
        cont1.getBusinesslinelist();
        cont1.deletebenifit();
        Test.stopTest();
    }    
    private static testmethod void QIPPBenefit_Test2(){
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c BeConTable = new QIPP_Benefit_Conversion_Table__c();
        BeConTable.name = 'TestHPImp meaure test';
        
        insert BeConTable;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
        benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
        benifit.Benefit_Type__c = 'Financial Savings';
        benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_Benefit__c benifit1 = new QIPP_Benefit__c();
        benifit1.Improvement_Measure_Name__c = 'TestHPImp meaure test1';
        benifit1.Unit_of_Measure__c = 'Testunitofmeasuretest1';
        benifit1.Benefit_Type__c = 'Financial Savings';
        benifit1.ImprovementMeasure_Brief_Description__c = 'test desc1';
        benifit1.Project_ID__c = project.id;
        insert benifit1;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        //benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Months__c = '5';
        benrep1.Benefits_Saving_Amount_Planned__c = 45;
        benrep1.Benefits_Saving_Amount_Achieved__c = 25;
        benrep1.Benefit_Savings_Amount__c = 100;           
        insert benrep1;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.QIPPProjectDetailView;       
        pageRef.getParameters().put('id',project.id);
        pageRef.getParameters().put('benefitid', String.valueOf(benifit.id));
        pageRef.getHeaders().put('referer','test');
        pageRef.getparameters().put('index','1');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con1 = new ApexPages.StandardController(project);
        QIPPBenefit cont1= new QIPPBenefit(con1);
        
        cont1.getYearValues(); 
        cont1.getBusinesslinelist();
        cont1.benifit= benifit;
        cont1.showPopupeditBenf();
        cont1.displayPopupBenf = false;
        cont1.displayPopupeditBenf = true;
        cont1.AddRow();
        cont1.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont1.Bn_rep_AddList[1].Years__c = '2015';  
        cont1.Bn_rep_AddList[1].Months__c = '06';
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[2].Quarters__c = 'Q3';                           
        cont1.Bn_rep_AddList[2].Years__c = '2015';  
        cont1.Bn_rep_AddList[2].Months__c = '08';
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[2].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[3].Quarters__c = 'Q4';                           
        cont1.Bn_rep_AddList[3].Years__c = '2015';  
        cont1.Bn_rep_AddList[3].Months__c = '12';
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[3].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.AddRow();
        cont1.Bn_rep_AddList[4].Quarters__c = 'Q1';                           
        cont1.Bn_rep_AddList[4].Years__c = '2015';  
        cont1.Bn_rep_AddList[4].Months__c = '01';
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[4].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        
        cont1.cloneRow();
        pageRef.getparameters().put('index','2');
        Test.setCurrentPage(pageRef);
        cont1.cloneRow();
        pageRef.getparameters().put('index','3');
        Test.setCurrentPage(pageRef);
        cont1.cloneRow();
        pageRef.getparameters().put('index','4');
        Test.setCurrentPage(pageRef);
        cont1.cloneRow();
        pageRef.getparameters().put('index','5');
        Test.setCurrentPage(pageRef);
        cont1.displayPopupBenf=true;
        cont1.cloneRow();
        cont1.displayPopupBenf=false;
        pageRef.getparameters().put('index','4');
        Test.setCurrentPage(pageRef);
        cont1.delRow();
        cont1.saveBenefit();
        //benifit.Benefit_Type__c = 'Financial Savings';
        //update benifit;
        // cont1.benifit= benifit;        
        cont1.displayPopupBenf = true;
        cont1.displayPopupeditBenf = true;
        cont1.getBusinesslinelist();
        cont1.displayPopupBenf = false;
        cont1.textdata = 'TestHPImp meaure test';
        cont1.getBusinesslinelist();
        cont1.getBusinesslinelist1();
        cont1.setimpBenefitType('Financial Savings');
        cont1.getBenefitRedesign();
        cont1.closePopup();
        cont1.closePopupBBG();
        cont1.showPopupBBG();
        cont1.closePopupBAM();
        cont1.showPopupBAM();
        cont1.closePopupBenf();
        cont1.closeEditPopupBenf();
        cont1.showPopupviewBenf();
        cont1.closePopupviewBenf();
        cont1.closePopupeditBenf();
        cont1.closePopupviewonlyBenf();
        cont1.showPopupBenf();
        cont1.getimpMeasureDescription();
        cont1.setimpMeasureDescription('test desc1');
        cont1.getimpBenefitType();
        cont1.displayPopupBenf=true;
        cont1.addRow();
        //cont1.delRow();
        system.debug('Benefit'+ cont1.benifit);
        
        
        
        Test.stopTest();
    }    
    private static testmethod void QIPPBenefit_Test3(){
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c BeConTable = new QIPP_Benefit_Conversion_Table__c();
        BeConTable.name = 'TestHPImp meaure test1';
        
        insert BeConTable;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
        benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
        benifit.Benefit_Type__c = 'Projected Revenue';
        benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        //benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Months__c = '5';
        benrep1.Benefits_Saving_Amount_Planned__c = 45;
        benrep1.Benefits_Saving_Amount_Achieved__c = 25;
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.QIPPProjectDetailView;       
        pageRef.getParameters().put('id',project.id);
        pageRef.getParameters().put('benefitid', String.valueOf(benifit.id));
        pageRef.getHeaders().put('referer','test');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con1 = new ApexPages.StandardController(project);
        QIPPBenefit cont1= new QIPPBenefit(con1);
        cont1.getYearValues();        
        cont1.getBusinesslinelist();
        cont1.benifit= benifit;
        cont1.showPopupeditBenf();
        cont1.displayPopupBenf = false;
        cont1.displayPopupeditBenf = true;
        cont1.AddRow();
        cont1.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont1.Bn_rep_AddList[1].Years__c = '2015';  
        cont1.Bn_rep_AddList[1].Months__c = '06';
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[2].Quarters__c = 'Q3';                           
        cont1.Bn_rep_AddList[2].Years__c = '2015';  
        cont1.Bn_rep_AddList[2].Months__c = '08';
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[2].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[3].Quarters__c = 'Q4';                           
        cont1.Bn_rep_AddList[3].Years__c = '2015';  
        cont1.Bn_rep_AddList[3].Months__c = '12';
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[3].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.AddRow();
        cont1.Bn_rep_AddList[4].Quarters__c = 'Q1';                           
        cont1.Bn_rep_AddList[4].Years__c = '2015';  
        cont1.Bn_rep_AddList[4].Months__c = '01';
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[4].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.setimpBenefitType('Projected Revenue');
        cont1.saveBenefit();    
    }
    private static testmethod void QIPPBenefit_Test4(){
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c BeConTable = new QIPP_Benefit_Conversion_Table__c();
        BeConTable.name = 'TestHPImp meaure test1';
        
        insert BeConTable;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
        benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
        benifit.Benefit_Type__c = 'Projected Revenue';
        benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        //benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Months__c = '5';
        benrep1.Benefits_Saving_Amount_Planned__c = 45;
        benrep1.Benefits_Saving_Amount_Achieved__c = 25;
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.QIPPProjectDetailView;       
        pageRef.getParameters().put('id',project.id);
        pageRef.getParameters().put('benefitid', String.valueOf(benifit.id));
        pageRef.getHeaders().put('referer','test');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con1 = new ApexPages.StandardController(project);
        QIPPBenefit cont1= new QIPPBenefit(con1);
        cont1.getYearValues();        
        cont1.getBusinesslinelist();
        cont1.benifit= benifit;
        cont1.showPopupeditBenf();
        cont1.displayPopupBenf = false;
        cont1.displayPopupeditBenf = true;
        cont1.AddRow();
        cont1.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont1.Bn_rep_AddList[1].Years__c = '2015';  
        cont1.Bn_rep_AddList[1].Months__c = '06';
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[2].Quarters__c = 'Q3';                           
        cont1.Bn_rep_AddList[2].Years__c = '2015';  
        cont1.Bn_rep_AddList[2].Months__c = '08';
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[2].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[3].Quarters__c = 'Q4';                           
        cont1.Bn_rep_AddList[3].Years__c = '2015';  
        cont1.Bn_rep_AddList[3].Months__c = '12';
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[3].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.AddRow();
        cont1.Bn_rep_AddList[4].Quarters__c = 'Q1';                           
        cont1.Bn_rep_AddList[4].Years__c = '2015';  
        cont1.Bn_rep_AddList[4].Months__c = '01';
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[4].Benefit_Savings_Amount__c = 100; 
        system.debug('Bn_rep_AddList'+ cont1.Bn_rep_AddList);
        cont1.setimpBenefitType('Realized Revenue');
        cont1.saveBenefit();
        boolean Testbooolean = true;
        cont1.ConversionIDFound  = Testbooolean;
        System.assertEquals(Testbooolean,cont1.ConversionIDFound);
        cont1.targetField = '';
        cont1.DI3DI5rule1 = true;
        cont1.DI3DI5rule2 = true;
        cont1.hideedit = true;
        cont1.strDirectionalIndicator ='';
        cont1.callQIMFunction = true;
        cont1.isManual = true;
        cont1.isOperational = true;
        cont1.isNoteDisplay = true;
        cont1.ImprovementName  =  ''; 
        cont1.Benefit_Type =  ''; 
        cont1.TypeOfPlannedSaving =  ''; 
        cont1.TypeOfAchievedSaving =  ''; 
        cont1.TypeOfFutureSaving =  ''; 
        cont1.ConversionId =  ''; 
        cont1.IMPDescription =  ''; 
        cont1.selectedValue =  ''; 
        cont1.displayhighimpactPopupBAM = true;
        cont1.displayPopupBenfOverview = true;
        cont1.pltotal = 0.0;
        cont1.achietotal= 0.0;
        cont1.fututotal= 0.0;
        cont1.activity =  ''; 
        cont1.valueStream =  ''; 
        cont1.businessFunction=  ''; 
        cont1.index = 9;
        cont1.benYear =  ''; 
        cont1.impMeasUoMeasure =  ''; 
        cont1.strBenifitType = '';
        List<QIPP_Project__c> testprojBGList = cont1.projBGList ;
        List<QIPP_Project__c> testactivityList = cont1.activityList ;
        List<Business_Activity__c> testbamDetails =cont1.bamDetails ;
		List<SelectOption> teststatusOptions = cont1.statusOptions;
        List<QIPP_Benefit_Conversion_Table__c> testbusinesslinelist =cont1.businesslinelist ;        
    }
    private static testmethod void QIPPBenefit_Test5(){
        
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
        portfolio.DMAIC_DMADV__c = true;
        portfolio.Lean_including_Kaizen__c = true;
        insert portfolio;
        
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c BeConTable = new QIPP_Benefit_Conversion_Table__c();
        BeConTable.name = 'TestHPImp meaure test1';
        
        insert BeConTable;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Improvement_Measure_Name__c = 'TestHPImp meaure test';
        benifit.Unit_of_Measure__c = 'Testunitofmeasuretest';
        benifit.Benefit_Type__c = 'Projected Revenue';
        benifit.ImprovementMeasure_Brief_Description__c = 'test desc';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        //benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Months__c = '5';
        benrep1.Benefits_Saving_Amount_Planned__c = 45;
        benrep1.Benefits_Saving_Amount_Achieved__c = 25;
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.QIPPProjectDetailView;       
        pageRef.getParameters().put('id',project.id);
        pageRef.getParameters().put('benefitid', String.valueOf(benifit.id));
        pageRef.getHeaders().put('referer','test');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con1 = new ApexPages.StandardController(project);
        QIPPBenefit cont1= new QIPPBenefit(con1);
        cont1.getYearValues();        
        cont1.getBusinesslinelist();
        cont1.benifit= benifit;
        cont1.showPopupeditBenf();
        cont1.displayPopupBenf = false;
        cont1.displayPopupeditBenf = true;
		cont1.AddRow();
        cont1.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        //cont1.Bn_rep_AddList[1].Years__c = '2015';  
        cont1.Bn_rep_AddList[1].Months__c = '06';
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
         cont1.saveBenefit();
		
        ApexPages.StandardController con2 = new ApexPages.StandardController(project);
        QIPPBenefit cont2= new QIPPBenefit(con1);
        cont2.getYearValues();        
        cont2.getBusinesslinelist();
        cont2.benifit= benifit;
        cont2.showPopupeditBenf();
        cont2.displayPopupBenf = false;
        cont2.displayPopupeditBenf = true;
		cont2.AddRow();
        cont2.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont1.Bn_rep_AddList[1].Years__c = '2015';  
        //cont2.Bn_rep_AddList[1].Months__c = '06';
        cont2.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont2.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont2.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
         cont2.saveBenefit();
         ApexPages.StandardController con3 = new ApexPages.StandardController(project);
        QIPPBenefit cont3= new QIPPBenefit(con1);
        cont3.getYearValues();        
        cont3.getBusinesslinelist();
        cont3.benifit= benifit;
        cont3.showPopupeditBenf();
        cont3.displayPopupBenf = false;
        cont3.displayPopupeditBenf = true;
		cont3.AddRow();
        cont3.Bn_rep_AddList[1].Quarters__c = 'Q2';                           
        cont3.Bn_rep_AddList[1].Years__c = '2015';  
        //cont2.Bn_rep_AddList[1].Months__c = '06';
        cont3.Bn_rep_AddList[1].Benefits_Saving_Amount_Planned__c = 45;
        cont3.Bn_rep_AddList[1].Benefits_Saving_Amount_Achieved__c = 25;
        cont3.Bn_rep_AddList[1].Benefit_Savings_Amount__c = 100; 
         cont3.saveBenefit();
        
/*
        cont1.AddRow();
        cont1.Bn_rep_AddList[2].Quarters__c = 'Q3';                           
        cont1.Bn_rep_AddList[2].Years__c = '2015';  
        //cont1.Bn_rep_AddList[2].Months__c = '08';
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[2].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[2].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[3].Quarters__c = 'Q4';                           
        cont1.Bn_rep_AddList[3].Years__c = '2015';  
        cont1.Bn_rep_AddList[3].Months__c = '12';
        //cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Planned__c = 45;
       // cont1.Bn_rep_AddList[3].Benefits_Saving_Amount_Achieved__c = 25;
        //cont1.Bn_rep_AddList[3].Benefit_Savings_Amount__c = 100; 
        cont1.AddRow();
        cont1.Bn_rep_AddList[4].Quarters__c = 'Q1';                           
        //cont1.Bn_rep_AddList[4].Years__c = '2015';  
        //cont1.Bn_rep_AddList[4].Months__c = '01';
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Planned__c = 45;
        cont1.Bn_rep_AddList[4].Benefits_Saving_Amount_Achieved__c = 25;
        cont1.Bn_rep_AddList[4].Benefit_Savings_Amount__c = 100;         
        cont1.AddRow();
        cont1.Bn_rep_AddList[5].Quarters__c = 'Q1';                           
        //cont1.Bn_rep_AddList[5].Years__c = '2015';  
        cont1.Bn_rep_AddList[5].Months__c = '01';
        //cont1.Bn_rep_AddList[5].Benefits_Saving_Amount_Planned__c = 45;
        //cont1.Bn_rep_AddList[5].Benefits_Saving_Amount_Achieved__c = 25;
        //cont1.Bn_rep_AddList[5].Benefit_Savings_Amount__c = 100; 
		 cont1.saveBenefit();
*/
        
       
        
    }
    
    
}