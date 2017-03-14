@isTest
private with sharing class QIPPLeanProject_TestClass{
    private static void insertTestData(){
        QIPP_Contacts__c qCont;
        User u;
        string msg;

        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs ( thisUser ) {
            Profile p = [SELECT Id,UserLicense.Name FROM Profile WHERE Name='System Administrator' and UserLicense.Name != '']; 
            UserRole r = [SELECT Id FROM UserRole WHERE Name='QIPP Project Lead'];  
            u = new User();

            u.Alias = 'standt';
            u.Email='amol@amol.com';
            u.EmailEncodingKey='UTF-8';
            u.LastName='Testing';
            u.LanguageLocaleKey='en_US';
            u.LocaleSidKey='en_US';
            u.ProfileId = p.Id;
            u.UserRoleId = r.Id;
            u.TimeZoneSidKey='America/Los_Angeles'; 
            u.UserName='standarduser_amol@testorg.com';
            if (Schema.SObjectType.User.isCreateable()){
                insert u;
            }

            User u1 = [Select id, User_License_Type__c from User where id = :u.id];

            qCont = new QIPP_Contacts__c();
            qCont.Name = 'test';
            qCont.Email__c = 'amol@amol.com';
            qCont.Contact_State__c = 'Active';
            qCont.Contact_BU__c = 'CFOO';
            qCont.Contact_BL__c = 'test7894656';
            qCont.Contact_L4_Org__c = 'testAmol1234';
            qCont.Belt_Certification__c = 'Nokia-Black Belt';
            qCont.User_License__c = u.Id;
            qCont.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
            qCont.CoPQ_Role_2__c ='Finance Approver';
            qCont.CoPQ_Role_3__c ='Finance Approver Delegate';
            qCont.CoPQ_Role_4__c ='Measure Creator';

        }
        system.runas(u){
            if (Schema.SObjectType.QIPP_Contacts__c.isCreateable()){
                insert qCont;
            }
        }
        
        QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
        qPortfolio.Name = 'testAmol';
        qPortfolio.Portfolio_Owner__c = qCont.Id;
        qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
        qPortfolio.Portfolio_Status__c = 'Active';
        qPortfolio.DMAIC_DMADV__c = true;
        if (Schema.SObjectType.QIPP_Portfolio__c.isCreateable()){
            insert qPortfolio;
        }
        Business_Activity__c bam = new Business_Activity__c();
        bam.name = 'Test Business Activity';
        bam.Business_Function__c = 'Marketing & communications';
        bam.Value_Stream__c = 'Features';
        insert bam;

        QIPP_Project__c qProj = new QIPP_Project__c();
        //qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
        qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Define').getRecordTypeId();
        qProj.CEMT_ID__c = 'testAmol';
        qProj.Project_Name_Succinct__c = 'testAmol123';
        qProj.Portfolio_BU__c = 'Human Resources';
        qProj.Project_Lead__c = qCont.Id;
        qProj.Project_BL__c = 'Nokia EDU';
        qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        qProj.Portfolio_Name__c = qPortfolio.Id;
        qProj.Project_State__c = 'In Progress';
        qProj.Project_Description_Detailed__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttest';
        //qProj.Project_Lead_BU__c = qCont.Contact_BU__c;
        //qProj.Project_Lead_BL_Level_3_Org__c = qCont.Contact_BL__c;
        //qProj.Project_Lead_BL_Level_4_Org__c = qCont.Contact_L4_Org__c;
        qProj.Belt_Candidate_Mentor__c = qCont.Id;
        qProj.Belt_Project_Sponsor__c = qCont.Id;
        qProj.Belt_Project_Type__c = 'GB Certification Project';
        qProj.Belt_Project_Champion__c = qCont.Id;
        qProj.Finance_Approver__c = qCont.Id;
        qProj.Mentor_Certificate__c = 'Nokia-Green Belt';
        qProj.Business_Unit_Master_Black_Belt__c = qCont.Id;
        qProj.Belt_Assigned__c = qCont.Id;
        qProj.Belt_Project_Phase__c = 'Define';
        qProj.DMAIC_Define__c = date.today();
        qProj.Define_Date_Forecast__c = date.today();
        qProj.Define_Status__c = 'In Progress';
        qProj.DMAIC_Measure__c = date.today();
        qProj.Measure_Date_Forecast__c = date.today();
        qProj.Measure_Status__c = 'In Progress';
        qProj.DMAIC_Analyze__c = date.today();
        qProj.Analyze_Date_Forecast__c = date.today();
        qProj.Analyze_Status__c = 'In Progress';
        qProj.DMAIC_Improve__c = date.today();
        qProj.Improve_Design_Date_Forecast__c = date.today();
        qProj.Improve_Status__c = 'In Progress';
        qProj.DMAIC_Control__c = date.today();
        qProj.Control_Verify_Date_Forecast__c = date.today();
        qProj.Control_Status__c = 'In Progress';
        qProj.Planned_Start_Date__c = date.today();
        qProj.Project_Completion_Date_Target__c = date.today();
        qProj.Project_Type__c = 'DMAIC';
        qProj.Project_Start_Date__c = date.today();
        qProj.Project_Completion_Date_Forecast__c = date.today();
        qProj.MO_Site__c = 'Beijing';
        qProj.Project_Created_Date__c = date.today();
        qProj.Project_Completion_Date_Actual__c = date.today();
        qProj.Quality_Award_Project__c = 'Yes';
        qProj.Project_Flex_Field_1__c = 'testAmol';
        qProj.DI_State__c = 'DI 2 - Concept existing, business case analyzed';
        qProj.Permission_to_use_Belt_Info__c = 'Yes';
        qProj.Progress_To_Date__c = 'testAMOLLLLLLLLLL';
        qProj.Next_Steps__c = 'testAMOLLLLLLLLLLLLLLLLLLLLLL';
        qProj.Project_Member1__c = qCont.Id;
        qProj.Project_Member2__c = qCont.Id;
        qProj.Project_Document__c = '';
        qProj.Business_Activity_Mapping__c = bam.id; 
        qProj.Lean__c = 'No';
        //qProj.CreatedById
        //qProj.CreatedDate
        //qProj.LastModifiedById
        //qProj.LastModifiedDate
        if (Schema.SObjectType.QIPP_Project__c.isCreateable()){
            insert qProj;
        }
    }

    private static testmethod void test(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id from QIPP_Project__c limit 1];

            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);

            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);


            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);
            //qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.recordIsLocked(qProj.Id);

            qProjTest.save();

            qProj.Progress_To_Date__c = 'QIPP';
            qProj.Next_Steps__c = 'QIPPLeanProject';
            qProjTest.cancel();
        }
    }
    
    private static testmethod void test1(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){

            QIPP_Project__c qProj = [select id from QIPP_Project__c limit 1];

            qProj.RecordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After DMAIC Measure').getRecordTypeId();
            update qProj;
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);
            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('RecordType', 'Methodology: DMAIC / DMADV');
            ApexPages.currentPage().getParameters().put('retURL', 'apex/QIPPLeanProjectEditView');
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);
            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);

            qProjTest.recIsLocked = true;
            qProjTest.deleteRecord();
            qProjTest.cancel();
            qProjTest.edit();
            qProjTest.proj = new QIPP_Project__c();
            qProjTest.proj.CEMT_ID__c = 'testAmol';
            qProjTest.currentView = 'QIPPLeanProjectDetailView';
            qProjTest.editBBG=true;
            qProjTest.lcertName =null;
            qProjTest.saveAndNew();
            qProjTest.proj =  qProj;
            qProjTest.getBAMDetails_X();
            qProjTest.getleanCertificatValues();
            qProjTest.getleanprojectphasevalues();
        }
    }

    private static testmethod void test3(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            Business_Activity__c bam1 = new Business_Activity__c();
            bam1.name = 'Test Business Activity';
            bam1.Business_Function__c = 'Account management';
            bam1.Value_Stream__c = 'Quality';
            insert bam1; 
            QIPP_Project__c qProj = [select id from QIPP_Project__c limit 1];
            qProj.RecordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Analyze').getRecordTypeId();
            qProj.Lean__c = 'Yes';
            qProj.Business_Activity_Mapping2__c = bam1.id;
            qProj.Business_Activity_Mapping3__c = bam1.id;
            update qProj;

            Benefiting_Business_Group__c bg = new Benefiting_Business_Group__c(Project_ID__c=qProj.id,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c=NULL, Benefitting_Business_Line__c=NUll,Distribution__c=0);
            insert bg;


            QIPP_Benefit_Conversion_Table__c imp = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 1',Active__c=True,    Benefit_Type__c='Financial Savings');
            insert imp;        
            List<QIPP_Benefit__c> benifitList = new List<QIPP_Benefit__c>();

            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            insert benifitList;    
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);
            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('CloneID', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);
            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);

            qProjTest.proj =  qProj;
            qProjTest.mulBBG =new Benefiting_Business_Group__c();
            qProjTest.mulBBG = bg;
            qProjTest.projMultipleBBGAddList = new List<Benefiting_Business_Group__c>();
            qProjTest.projMultipleBBGDelList = new List<Benefiting_Business_Group__c>();    
            qProjTest.callDummy();
            qProjTest.getBAMDetailsMap();
            qProjTest.getBAMDetails_X();
            qProjTest.addBGRow();    
            qProjTest.delBGRow();

            qProjTest.closePopupBBG();
            qProjTest.recordIsLocked(qProj.Id);
            String blobCreator = 'A' + '\r\n' + 'B' + '\r\n' + 'csvLine3' + '\r\n' + 'csvLine4' + '\r\n' + 'csvLine5' + '\r\n' + 'csvLine6' + '\r\n' + 'csvLine7' + '\r\n' + 'csvLine8' + '\r\n' + 'csvLine9' + '\r\n' + 'csvLine10' + '\r\n' + 'csvLine11' + '\r\n' + 'csvLine12';      

            qProjTest.unlockRecord(); 
            qProjTest.submitapprove();
            qProjTest.deleteprj();
            qProjTest.closedelPopup();
            qProjTest.closePopup();
            qProjTest.reqApproval();
            qProjTest.cloneProject();
            qProjTest.deleteRecord();
            qProjTest.ValidationCancel();
            qProjTest.cancel();
            qProjTest.edit();
            qProjTest.saveAndNew();
            qProjTest.save();
            qProjTest.errorMessages();
            qProjTest.initiateErrMsgVariables();
            qProjTest.isValidPortfolioName();
            qProjTest.getDIStateValues();
            qProjTest.getMethodologyValues();
            qProjTest.getProjectStateValues();
            qProjTest.getBumbbValues();
            qProjTest.getPortfolioBBGValue();
            qProjTest.getpermBeltInfoValues();
            qProjTest.getqtyAwardProjectValues();
            qProjTest.getPortfolioValues();
            qProjTest.getBenefits();
            qProjTest.getBAMDetailsMap();
            qProjTest.recIsLocked = true;
            qProjTest.benefitAmount = 15.00;
            qProjTest.reqApproval();  
        }
    }
    private static testmethod void test4(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id from QIPP_Project__c limit 1];
            qProj.RecordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Analyze').getRecordTypeId();
            update qProj;
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);
            PageReference pageRef = Page.QIPPLeanProjectDetailView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);
            ApexPages.currentPage().getParameters().put('cancelURL', 'apex/QIPPLeanProjectEditView');  
            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);
            qProjTest.cancel();

            qProj.Belt_Project_Phase__c ='Complete';
            qProj.Project_State__c ='On Hold';
            qProj.Finance_Approver__c =null;
            qProj.Business_Activity_Mapping2__c =null;
            qProj.Project_Completion_Date_Forecast__c  =Date.Today().addDays(-1);  
            update qProj;
            qProjTest.benefitAmount = 260.00;
            qProjTest.reqApproval();
            qProjTest.proj = new QIPP_Project__c();
            qProjTest.proj.CEMT_ID__c = 'testAmol';
            qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.proj.Project_Name_Succinct__c ='';
            qProjTest.proj.Portfolio_Name__c=null;    
            qProjTest.portfolioName ='1';
            qProjTest.proj.Project_Document__c ='wdwefwefwefwefwefefwefwefwfe';
            qProjTest.bumbbName ='1';   
            qProjTest.saveAndNew();
            qProjTest.save();
            qProjTest.proj.Belt_Project_Phase__c='Measure';
            qProjTest.reqApproval();   
        }
    }

    private static testmethod void test5(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id,Benefitting_Project_BL_Level_4_Org__c,Portfolio_BU__c,Project_BL__c from QIPP_Project__c limit 1];
            qProj.Project_BL__c = 'Multiple BUs';
            qProj.Belt_Project_Phase__c='Analyze';
            qProj.Lean__c = 'Yes';
            update qProj;    
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);

            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);


            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);
            //qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.recordIsLocked(qProj.Id);


            Benefiting_Business_Group__c bg1 = new Benefiting_Business_Group__c(Project_ID__c=qProj.id,Benefitting_Business_Line__c=qProj.Benefitting_Project_BL_Level_4_Org__c,Benefitting_Business_Grp_Functional_Grp__c=qProj.Portfolio_BU__c, Benefitting_Business_Unit__c=qProj.Project_BL__c,Distribution__c=0,Project_BG__c=true);
            insert bg1;

            qProjTest.save();    

            qProjTest.benefitAmount = 260.00;
            qProjTest.reqApproval();
        }
    }  

    private static testmethod void test6(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id,Benefitting_Project_BL_Level_4_Org__c,Portfolio_BU__c,Project_BL__c from QIPP_Project__c limit 1];
            qProj.Project_BL__c = 'Multiple BUs';
            //newly added
            qProj.Belt_Project_Phase__c='Measure';
            qProj.Lean__c = 'No';
            update qProj;
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);

            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);


            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);
            //qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.recordIsLocked(qProj.Id);



            Benefiting_Business_Group__c bg = new Benefiting_Business_Group__c(Project_ID__c=qProj.id,Benefitting_Business_Line__c=qProj.Benefitting_Project_BL_Level_4_Org__c,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c=qProj.Project_BL__c,Distribution__c=0,Project_BG__c=false);
            insert bg;
            qProjTest.save();
            qProjTest.editBBG=true;    
            qProjTest.saveAndNew();
            qProjTest.reqApproval();

            QIPP_Benefit_Conversion_Table__c imp = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 1',Active__c=True,  Benefit_Type__c='Financial Savings');
            insert imp;  
            List<QIPP_Benefit__c> benifitList = new List<QIPP_Benefit__c>();
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));

            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            insert benifitList;      
            qProjTest.getBenefits();
            qProjTest.getProjectTypeValues();   
        }
    }

    private static testmethod void test7(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id,Benefitting_Project_BL_Level_4_Org__c,Portfolio_BU__c,Project_BL__c from QIPP_Project__c limit 1];
            qProj.Project_BL__c = 'Multiple BUs';
            //newly added
            qProj.Belt_Project_Phase__c='Improve / Design';
            update qProj;
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);

            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);

            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);
            //qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.recordIsLocked(qProj.Id);

            Benefiting_Business_Group__c bg = new Benefiting_Business_Group__c(Project_ID__c=qProj.id,Benefitting_Business_Line__c=qProj.Benefitting_Project_BL_Level_4_Org__c,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c=qProj.Project_BL__c,Distribution__c=0,Project_BG__c=false);
            insert bg;

            qProjTest.save();
            qProjTest.editBBG=true;    
            qProjTest.saveAndNew();    
            qProjTest.reqApproval();
            QIPP_Benefit_Conversion_Table__c imp = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 1',Active__c=True, Benefit_Type__c='Financial Savings');
            insert imp;  
            List<QIPP_Benefit__c> benifitList = new List<QIPP_Benefit__c>();
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            insert benifitList;      
            qProjTest.getBenefits();
            qProjTest.lcertName ='No';
            qProjTest.benefitAmount=260.0;   
            qProjTest.submitapprove();
        }
    }

    private static testmethod void test8(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id,Benefitting_Project_BL_Level_4_Org__c,Portfolio_BU__c,Project_BL__c from QIPP_Project__c limit 1];
            qProj.Project_BL__c = 'Multiple BUs';
            //newly added
            qProj.Belt_Project_Phase__c='Control / Verify';
            update qProj;
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);

            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);

            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);
            //qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.recordIsLocked(qProj.Id);

            Benefiting_Business_Group__c bg = new Benefiting_Business_Group__c(Project_ID__c=qProj.id,Benefitting_Business_Line__c=qProj.Benefitting_Project_BL_Level_4_Org__c,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c=qProj.Project_BL__c,Distribution__c=0,Project_BG__c=false);
            insert bg;
            qProjTest.save();
            qProjTest.editBBG=true;    
            qProjTest.saveAndNew();    
            qProjTest.reqApproval();
            QIPP_Benefit_Conversion_Table__c imp = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 1',Active__c=True,  Benefit_Type__c='Financial Savings');
            insert imp;  
            List<QIPP_Benefit__c> benifitList = new List<QIPP_Benefit__c>();
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
            insert benifitList;      
            qProjTest.getBenefits();
            qProjTest.proj=NULL;
            qProjTest.unlockRecord();
            qProjTest.lcertName ='No';
            qProjTest.benefitAmount=15.0;
            qProjTest.proj =qProj;        
            qProjTest.submitapprove();
            qProjTest.closehighimpactPopup();
            qProjTest.close15kto250kPopup();
            qProjTest.closeMsgPopup();    
        }
    }

    private static testmethod void test9(){
        insertTestData();
        User u = [select id from user where Email='amol@amol.com' limit 1];
        system.runas(u){
            QIPP_Project__c qProj = [select id from QIPP_Project__c limit 1];
            qProj.RecordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Analyze').getRecordTypeId();
            update qProj;
            ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);
            PageReference pageRef = Page.QIPPLeanProjectDetailView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', qProj.Id);
            QIPP_Portfolio__c protfolio = [select id from QIPP_Portfolio__c limit 1];
            ApexPages.currentPage().getParameters().put('currPortfolio', protfolio.Id);
            ApexPages.currentPage().getParameters().put('cancelURL', 'apex/QIPPLeanProjectEditView');  
            QIPPLeanProject qProjTest = new QIPPLeanProject(stdController);

            qProj.Belt_Project_Phase__c ='Complete';
            qProj.Project_State__c ='On Hold';
            qProj.Finance_Approver__c =null;
            qProj.Business_Activity_Mapping2__c =null;
            qProj.Project_Completion_Date_Forecast__c  =Date.Today().addDays(-1);  
            qProj.X5S__c=True;
            update qProj;
            qProjTest.benefitAmount = 260.00;
            qProjTest.reqApproval();
            qProjTest.proj = new QIPP_Project__c();
            qProjTest.proj.CEMT_ID__c = 'testAmol';
            qProjTest.currentView = 'QIPPLeanProjectEditView';
            qProjTest.proj.Project_Name_Succinct__c ='';
            qProjTest.proj.Portfolio_Name__c=null;    
            qProjTest.portfolioName ='1';
            qProjTest.proj.Project_Document__c ='wdwefwefwefwefwefefwefwefwfe';
            qProjTest.bumbbName ='1'; 
            qProjTest.proj.X5S__c=True;    
            qProjTest.saveAndNew();
            qProjTest.currentView='QIPPLeanProjectDetailView';
            qProjTest.proj.Portfolio_Name__c = protfolio.id;    
            qProjTest.isValidPortfolioName();
            qProjTest.theId =protfolio.id;
            qProjTest.benefitingBG='test';
            qProjTest.displayzeroPopup = true;
            qProjTest.refererStr='test';
            qProjTest.approvalStatus='test';
            qProjTest.phasecompleted='test';
            qProjTest.currPortfolioName='test';
            qProjTest.leanCoachError='test';
            QIPPLeanProject.toDelrow =1;
            QIPPLeanProject.addCount =2;
            qProjTest.index=1;
            qProjTest.Benefits_GrandTotalsList = new List<QIPP_Benefit__c>();   
            qProjTest.BGValue='test';
            qProjTest.BUValue='test';
            qProjTest.BLValue ='test'; 
        }
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
            portfolio.Lean_including_Kaizen__c = true;
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
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: Lean (including Kaizen)').getRecordTypeId();
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
            project.Project_State__c = 'Complete';
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

            Benefiting_Business_Group__c editBBG = new Benefiting_Business_Group__c();
            editBBG.Project_ID__c = project.id;
            editBBG.Project_BG__c = true;
            insert editBBG;

            Benefiting_Business_Group__c delBBG = new Benefiting_Business_Group__c();
            delBBG.Project_ID__c = project.id;
            delBBG.Project_BG__c = false;            
            insert delBBG;

            QIPP_BG_BU_BL_Contact_Mapping__c bgMap = new QIPP_BG_BU_BL_Contact_Mapping__c();
            bgMap.Business_Group_Master_Black_Belt__c = con1.Id;
            bgMap.Portfolio_Name__c = portfolio.id;
            insert bgMap;

            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            PageReference pageRef = Page.QIPPLeanProjectEditView;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            QIPPLeanProject obj = new QIPPLeanProject(sc);
            obj.BBGUpdated();
            obj.closeLeadSponsorEqualPopup();

            obj.rolename = 'QIPP Portfolio Owner';
            obj.getProjectStateValues();

            obj.rolename = 'QIPP Portfolio Manager';
            obj.getProjectStateValues();            

            test.stoptest();
        }
    }

}