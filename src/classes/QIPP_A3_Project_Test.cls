@istest
private class QIPP_A3_Project_Test{
  private static testmethod void insertdata(){
    QIPP_Contacts__c qCont;
    User u;
    String msg;
    
    User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
    System.runAs ( thisUser ) {
      Profile p = [SELECT Id,UserLicense.Name FROM Profile WHERE Name='System Administrator' and UserLicense.Name != '']; 
      UserRole r = [SELECT Id FROM UserRole WHERE Name='QIPP Project Lead'];  
      u = new User();
      u.Alias = 'standt';
      u.Email='sreeni@sfdc.com';
      u.EmailEncodingKey='UTF-8';
      u.LastName='Testing';
      u.LanguageLocaleKey='en_US';
      u.LocaleSidKey='en_US';
      u.ProfileId = p.Id;
      u.UserRoleId = r.Id;
      u.TimeZoneSidKey='America/Los_Angeles'; 
      u.UserName='standarduser_sreeni@testorg.com';
  
      if (Schema.SObjectType.User.isCreateable()){
        insert u;
      }
             
      User u1 = [Select id, User_License_Type__c from User where id = :u.id];

      qCont = new QIPP_Contacts__c();
      qCont.Name = 'test';
      qCont.Email__c = 'sreeni@sfdc.com';
      qCont.Contact_State__c = 'Active';
      qCont.Contact_BU__c = 'CFO Functions';
      qCont.Contact_BL__c = 'test7894656';
      qCont.Contact_L4_Org__c = 'testsreeni1234';
      qCont.Belt_Certification__c = 'Nokia-Black Belt';
      qCont.User_License__c = u.Id;
      qCont.CoPQ_Role_1__c = 'Business Unit Master Black Belt';
             
      system.debug('@@@@@@@@@@@@'+p);
      system.debug('@@@@@@@@@@@@'+u.User_License_Type__c);
      system.debug('@@@@@@@@@@@@'+u1);
      system.debug('#############'+qCont);
    }
    system.runas(u){
      system.debug('INSERT'+qCont);
      if (Schema.SObjectType.QIPP_Contacts__c.isCreateable()){
        insert qCont;
      }
    }
    
    QIPP_Portfolio__c qPortfolio = new QIPP_Portfolio__c();
    
    qPortfolio.Name = 'testsreeni';
    qPortfolio.Portfolio_Owner__c = qCont.Id;
    qPortfolio.Portfolio_Business_Unit__c = 'Human Resources';
    qPortfolio.Portfolio_Status__c = 'Active';
    qPortfolio.A3__C = true;
    
    if(Schema.SObjectType.QIPP_Portfolio__c.isCreateable()){
      insert qPortfolio;
    }
    
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

    List<QIPP_A3_Project.BAMWrapper> bamWraplist = new List<QIPP_A3_Project.BAMWrapper>();
    
    bamWraplist.add(new QIPP_A3_Project.BAMWrapper(ba.name,ba.Business_Function__c,ba.Value_Stream__c));
    
    QIPP_A3_Project.BAMWrapper bamWrap = new QIPP_A3_Project.BAMWrapper();
    bamWrap.activityName = ba.name;
    bamWrap.businessFunc = ba.Business_Function__c;
    bamWrap.valueStream = ba.Value_Stream__c;           
    bamWraplist.add(bamWrap);            
    
    QIPP_A3_Project.BAMWrapper bamWrap1 = new QIPP_A3_Project.BAMWrapper();
    bamWrap1.activityName = ba1.name;
    bamWrap1.businessFunc = ba1.Business_Function__c;
    bamWrap1.valueStream = ba1.Value_Stream__c;
    bamWraplist.add(bamWrap1);
            
    QIPP_A3_Project.BAMWrapper bamWrap2 = new QIPP_A3_Project.BAMWrapper();
    bamWrap2.activityName = ba2.name;
    bamWrap2.businessFunc = ba2.Business_Function__c;
    bamWrap2.valueStream = ba2.Value_Stream__c;
    bamWraplist.add(bamWrap2);
    
    List<QIPP_Project__c> projectList = new List<QIPP_Project__c>();
    List<QIPP_Benefit__c> Benefits_RelatedList = new List<QIPP_Benefit__c>();
    List<QIPP_A3_Project.benefitGrandTotals> benefitGrandTotalsList = new List<QIPP_A3_Project.benefitGrandTotals>();
    list<Benefiting_Business_Group__c> deleteChildBBG = new list<Benefiting_Business_Group__c>();
    List<Benefiting_Business_Group__c> updateChildBBG = new list<Benefiting_Business_Group__c>();
    List<QIPP_Project__c> activityList = new List<QIPP_Project__c>();
  
    
    QIPP_Project__c qProj = new QIPP_Project__c();
      
    qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();

    qProj.CEMT_ID__c = 'testsreeni';
    qProj.Project_Name_Succinct__c = 'testsreeni123';
    qProj.Project_Lead__c = qCont.Id;
    qProj.Portfolio_BU__c = 'Human Resources';
    qProj.Project_BL__c = 'Nokia EDU';
    qProj.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
    qProj.Portfolio_Name__c = qPortfolio.Id;
    qProj.Project_State__c = 'In Progress';
    qProj.Project_Description_Detailed__c = 'testtesttesttesttesttest';
    qProj.Belt_Project_Sponsor__c = qCont.Id;
    qProj.Finance_Approver__c = qCont.Id;
    qProj.Project_Start_Date__c = date.today();
    qProj.Project_Completion_Date_Forecast__c = date.today();
    qProj.Project_Created_Date__c = date.today();
    qProj.Project_Completion_Date_Actual__c = date.today();
    qProj.Quality_Award_Project__c = 'Yes';
    qProj.Project_Document__c = 'https://sharenet.com';
    qProj.Business_Activity_Mapping__c = ba.id; 
 
    if(Schema.SObjectType.QIPP_Project__c.isCreateable()){
      insert qProj;
    }   
    projectList.add(qProj);
    
    QIPP_Project__c project1 = new QIPP_Project__c();
      
    project1.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();

    project1.CEMT_ID__c = 'testsreeni';
    project1.Project_Name_Succinct__c = 'testsreeni123';
    project1.Project_Lead__c = qCont.Id;
    project1.Portfolio_BU__c = 'Human Resources';
    project1.Project_BL__c = 'Nokia EDU';
    project1.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
    project1.Portfolio_Name__c = qPortfolio.Id;
    project1.Project_State__c = 'In Progress';
    project1.Project_Description_Detailed__c = 'testtesttesttesttesttest';
    project1.Belt_Project_Sponsor__c = qCont.Id;
    project1.Finance_Approver__c = qCont.Id;
    project1.Project_Start_Date__c = date.today();
    project1.Project_Completion_Date_Forecast__c = date.today();
    project1.Project_Created_Date__c = date.today();
    project1.Project_Completion_Date_Actual__c = date.today();
    project1.Quality_Award_Project__c = 'Yes';
    project1.Project_Document__c = 'https://sharenet.com';
    project1.Business_Activity_Mapping__c = ba.id; 
    project1.Business_Activity_Mapping__c = ba1.Id;
    project1.Business_Activity_Mapping2__c = ba2.Id;
    insert project1;        
    projectList.add(project1);
    QIPP_Project__c activity = new QIPP_Project__c();
    activity.id=qProj.id;
    
    activity.Business_Activity_Mapping__c=ba.id;
    activity.Business_Activity_Mapping_ValueStream__c=ba.Value_Stream__c ;
    activity.Business_Activity_Mapping_BusinessFunc__c=ba.Business_Function__c ;
    
    activity.Business_Activity_Mapping2__c=ba1.id;
    activity.Business_Activity_Mapping2_ValueStream__c=ba1.Value_Stream__c ;
    activity.Business_Activity_Mapping2_BusinessFunc__c=ba1.Business_Function__c ;
    
    activity.Business_Activity_Mapping3__c=ba2.id;
    activity.Business_Activity_Mapping3_ValueStream__c=ba2.Value_Stream__c;
    activity.Business_Activity_Mapping3_BusinessFunc__c=ba2.Business_Function__c;
    upsert activity;
    
    activityList.add(activity);
    
    QIPP_Benefit_Conversion_Table__c im = new QIPP_Benefit_Conversion_Table__c();
    im.Active__c = true;
    im.Name = 'test';
    insert im;
            


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
    qb1.Improvement_Measure_KPI__c= im.id;
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
    qb2.Improvement_Measure_KPI__c= im.id;
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
    qb3.Improvement_Measure_KPI__c= im.id;
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
    
    Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
    bbg1.Distribution__c=2.0;
    bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
    bbg1.Benefitting_Business_Unit__c='BHR FN';
    bbg1.Benefitting_Business_Line__c='Project Management';
    bbg1.Financial_Validation_Amount__c=100.0;
    bbg1.Operational_Validation_Amount__c=100.0;
    bbg1.Projected_Validation_Amount__c=100.0;
    bbg1.Realized_Validation_Amount__c=100.0;
    bbg1.Project_ID__c = project1.id;
    bbg1.Project_BG__c = true;
    insert bbg1;
        
    
    
    Benefiting_Business_Group__c bbg = new Benefiting_Business_Group__c();
        
    bbg.Distribution__c=2.0;
    bbg.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
    bbg.Benefitting_Business_Unit__c='BHR FN';
    bbg.Benefitting_Business_Line__c='Project Management';
    bbg.Financial_Validation_Amount__c=100.0;
    bbg.Operational_Validation_Amount__c=100.0;
    bbg.Projected_Validation_Amount__c=100.0;
    bbg.Realized_Validation_Amount__c=100.0;
    bbg.Project_ID__c = qProj.id;
    bbg.Project_BG__c = true;
    insert bbg;
    
    test.starttest();
    
    ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);
    
    QIPP_A3_Project testrca = new QIPP_A3_Project(stdController);
    testrca.currentView = 'QIPPA3ProjectEditView';
    testrca.issaveandnew = true;
    testrca.portfolioName = qPortfolio.Id;
    testrca.recIsLocked = false;
    testrca.proj.Project_Document__c = 'https://sharenet.com';
    testrca.phasecompleted = 'Indirect Financial';
    testrca.projectId = qProj.id;
    testrca.projState = 'Canceled';
    testrca.recIsLocked = false;
    testrca.benefitAmount = 20.2;
    testrca.reqApprovalMessage = 'test';
    testrca.displayPopup = true;
    testrca.isAlertType = true;
    testrca.currPortfolioId = qPortfolio.id;
    testrca.cloneid = qProj.id;
    testrca.genericError = 'VIPT';
    testrca.profileName = 'Each';
    testrca.roleName = u.userrole.name;
    
    testrca.recordIsLocked(qProj.Id);
    testrca.getPortfolioBBGValue();
    testrca.getPortfolioValues();
    testrca.getqtyAwardProjectValues();
    testrca.cancel();
    testrca.ValidationCancel();
    testrca.unlockRecord();
    testrca.saveProject();    
    try{testrca.edit();}catch(Exception e){}
    try{testrca.deleteRecord();}catch(Exception e){}
    testrca.cloneProject();
    testrca.closePopup();
    testrca.closeConfirmPopup();
    testrca.callDummy();
    testrca.getBAMDetailsMap();
    testrca.BBGUpdated();
    testrca.reqApproval(); 
    
    PageReference pageRef12 = Page.QIPPA3ProjectDetailView;
    Test.setCurrentPage(pageRef12);
    
    ApexPages.currentPage().getParameters().put('cancelURL','test');
    ApexPages.currentPage().getParameters().put('retURL','test');
    ApexPages.currentPage().getParameters().put('id',qProj.id);
    ApexPages.currentPage().getParameters().put('currPortfolio',qPortfolio.id);                    
    testrca.ValidationCancel();
    testrca.edit();
    testrca.deleteRecord();
    testrca.cloneProject();

    PageReference pageRef = Page.QIPPA3ProjectDetailView;
    Test.setCurrentPage(pageRef);

    testrca.Benefits_RelatedList = Benefits_RelatedList;
    testrca.getBenefits();
    
    testrca.BAMWrapperList =  bamWraplist;

    QIPP_A3_Project.benefitGrandTotals bgt = new QIPP_A3_Project.benefitGrandTotals();
    bgt.plannedGTotal = 20.0;
    bgt.achievedGTotal = 200.0;
    bgt.futureGTotal = 850.0;
    bgt.validationAmount = 500.0;
    bgt.plannedGTotalEuro = 'test';
    bgt.achievedGTotalEuro = 'test1';
    bgt.futureGTotalEuro = 'test2';
    bgt.validationAmountEuro = 'test3';
    benefitGrandTotalsList.add(bgt); 
    
    QIPP_A3_Project.benefitGrandTotals bgt1 = new QIPP_A3_Project.benefitGrandTotals();
    bgt1.plannedGTotal = 20.0;
    bgt1.achievedGTotal = 200.0;
    bgt1.futureGTotal = 850.0;
    bgt1.validationAmount = 500.0;
    bgt1.plannedGTotalEuro = 'test';
    bgt1.achievedGTotalEuro = 'test1';
    bgt1.futureGTotalEuro = 'test2';
    bgt1.validationAmountEuro = 'test3';
    benefitGrandTotalsList.add(bgt1);
    
    testrca.benefitGrandTotalsList = benefitGrandTotalsList;
    testrca.reqApproval();                        
    testrca.submitapprove();
    testrca.unlockRecord();
    
    ApexPages.StandardController sc16 = new ApexPages.StandardController(qProj);
    QIPP_A3_Project testrca16 = new QIPP_A3_Project(sc16);         
    testrca16.BBGUpdated();
    system.debug('sreeni'+testrca16.BBGUpdated());
                        
    ApexPages.StandardController sc1 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca1 = new QIPP_A3_Project(sc1);
    testrca1.Proj.Project_Document__c = 'https://www.nokia.com';
    testrca1.recIsLocked = true;
    testrca1.edit();
    testrca1.deleteRecord();
    testrca1.cloneProject();  
    testrca1.unlockRecord();
    PageReference pageRef1 = Page.QIPPA3ProjectDetailView;
    Test.setCurrentPage(pageRef1);
    
    ApexPages.StandardController sc2 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca2 = new QIPP_A3_Project(sc2);
    testrca2.currentView = 'QIPPA3ProjectDetailView';
    testrca2.saveProject();
    ApexPages.currentPage().getParameters().put('CloneID',project1.id);
    testrca2.cloneProject();
    testrca2.recordIsLocked(project1.id);
    ApexPages.currentPage().getParameters().put('cancelURL','test');
    testrca2.cancel();

    ApexPages.StandardController sc3 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca3 = new QIPP_A3_Project(sc3);
    ApexPages.currentPage().getParameters().put('retURL','test');
    ApexPages.currentPage().getParameters().put('id',project1.id);
    testrca3.recIsLocked = true;
    testrca3.reqApproval();
    testrca3.cancel();

    ApexPages.StandardController sc4 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca4 = new QIPP_A3_Project(sc4);
    testrca4.recordtypeName = ApexPages.currentPage().getParameters().put('RecordType','RCA/EDA');
    testrca4.issaveandnew = true;
    testrca4.saveProject();
    testrca4.reqApproval();
        
    ApexPages.StandardController sc5 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca5 = new QIPP_A3_Project(sc5);     
    testrca5.currPortfolioId= ApexPages.currentPage().getParameters().put('currPortfolio',qPortfolio.id);
    testrca5.portfolioName= 'qPortfolio.Id';
    testrca5.currPortfolioId = qPortfolio.Id;
    testrca5.currentView = 'QIPPA3ProjectEditView'; 
    testrca5.roleName = 'QIPP Project Lead';
    testrca5.getPortfolioBBGValue();
    testrca5.issaveandnew = false;
    testrca5.saveProject();
       
    ApexPages.StandardController sc6 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca6 = new QIPP_A3_Project(sc6);    
       
    testrca6.issaveandnew = true;
    testrca6.saveProject();
       
    ApexPages.StandardController sc66 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca66 = new QIPP_A3_Project(sc66);    
        
    testrca66.issaveandnew = false;
    testrca66.saveProject();
    testrca66.closePopup();
       
    PageReference pageRef2 = Page.QIPPA3ProjectDetailView;
    Test.setCurrentPage(pageRef2);

    ApexPages.StandardController sc7 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca7 = new QIPP_A3_Project(sc7);
    
    project1.Project_State__c = 'Complete';
    update project1;

    testrca7.reqApproval();
    QIPP_ApprovalsProcessNonSixSigma.TasksCheck(project1.id);

    ApexPages.StandardController sc8 = new ApexPages.StandardController(qProj);
    QIPP_A3_Project testrca8 = new QIPP_A3_Project(sc8);
    testrca8.portfolioName= '';
    testrca8.currentView='QIPPA3ProjectEditView';
    testrca8.errorMessages();
    testrca8.completeStatus();
        
    ApexPages.StandardController sc11 = new ApexPages.StandardController(project1);
    QIPP_A3_Project testrca11 = new QIPP_A3_Project(sc11); 
            
    test.stoptest();   
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
        portfolio.A3__C = true;
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
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
        project.Project_Document__c = 'https://www.tset.com';
 
        insert project;
        
        Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
        bbg1.Distribution__c=2.0;
        bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg1.Benefitting_Business_Unit__c='BHR FN';
        bbg1.Benefitting_Business_Line__c='Project Management';
        bbg1.Financial_Validation_Amount__c=1.0;
        bbg1.Operational_Validation_Amount__c=1.0;
        bbg1.Projected_Validation_Amount__c=1.0;
        bbg1.Realized_Validation_Amount__c=1.0;
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
        qb3.Planned_Financial_Savings_Total__c=1;
        qb3.Planned_Operational_Savings_Total__c=1;
        qb3.Planned_Projected_Savings_Total__c=1;
        qb3.Planned_Realized_Savings_Total__c=1;
        qb3.Achieved_Financial_Savings_Total__c=1;
        qb3.Achieved_Operational_Savings_Total__c=1;
        qb3.Achieved_Projected_Savings_Total__c=1;
        qb3.Achieved_Realized_Savings_Total__c=1;
        qb3.Future_Financial_Savings_Total__c=1;
        qb3.Future_Operational_Savings_Total__c=1;
        qb3.Future_Projected_Savings_Total__c=1;
        qb3.Future_Realized_Savings_Total__c=1;
        qb3.Benefit_Amount_Achieved_Future_k__c=1;
        qb3.Benefit_Operational_Achieved_Future_k__c=1;
        qb3.Benefit_Projected_Achieved_Future_k__c=1;
        qb3.Benefit_Realized_Achieved_Future_k__c=1;
    
        insert qb3;
        Benefits_RelatedList.add(qb3);        
        
        PageReference pageRef2 = Page.QIPPA3ProjectEditView;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_A3_Project obj = new QIPP_A3_Project(sc);
        obj.issaveandnew = true;
        obj.getBAMDetailsMap();
        obj.BBGUpdated();
        obj.saveProject();
        obj.reqApproval();        
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
        portfolio.A3__C = true;
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
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
        bbg1.Financial_Validation_Amount__c=1.0;
        bbg1.Operational_Validation_Amount__c=1.0;
        bbg1.Projected_Validation_Amount__c=1.0;
        bbg1.Realized_Validation_Amount__c=1.0;
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
        qb3.Planned_Financial_Savings_Total__c=1;
        qb3.Planned_Operational_Savings_Total__c=1;
        qb3.Planned_Projected_Savings_Total__c=1;
        qb3.Planned_Realized_Savings_Total__c=1;
        qb3.Achieved_Financial_Savings_Total__c=1;
        qb3.Achieved_Operational_Savings_Total__c=1;
        qb3.Achieved_Projected_Savings_Total__c=1;
        qb3.Achieved_Realized_Savings_Total__c=1;
        qb3.Future_Financial_Savings_Total__c=1;
        qb3.Future_Operational_Savings_Total__c=1;
        qb3.Future_Projected_Savings_Total__c=1;
        qb3.Future_Realized_Savings_Total__c=1;
        qb3.Benefit_Amount_Achieved_Future_k__c=1;
        qb3.Benefit_Operational_Achieved_Future_k__c=1;
        qb3.Benefit_Projected_Achieved_Future_k__c=1;
        qb3.Benefit_Realized_Achieved_Future_k__c=1;
    
        insert qb3;
        Benefits_RelatedList.add(qb3);        
        
        PageReference pageRef2 = Page.QIPPA3ProjectEditView;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_A3_Project obj = new QIPP_A3_Project(sc);
        obj.issaveandnew = true;
        obj.getBAMDetailsMap();
        obj.BBGUpdated();
        obj.saveProject();
        obj.reqApproval();        
        

             
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
        con2.Name = 'Srikanth';
        con2.Email__c = 'Srikanth@igate.com';
        con2.Contact_State__c = 'Active';
        con2.NSN_ID_Text__c = '44455454';        
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
        portfolio.A3__C = true;
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
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
        project.Project_Sponsor__c = con2.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Business_Activity_Mapping__c = ba.id;
        project.Business_Activity_Mapping2__c = ba1.id;
        project.Business_Activity_Mapping3__c = ba2.id;
        project.Project_Document__c = 'https://www.tset.com';
        project.Project_State__c = 'On Hold'; 
        insert project;
        
        Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
        bbg1.Distribution__c=2.0;
        bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg1.Benefitting_Business_Unit__c='BHR FN';
        bbg1.Benefitting_Business_Line__c='Project Management';
        bbg1.Financial_Validation_Amount__c=1.0;
        bbg1.Operational_Validation_Amount__c=1.0;
        bbg1.Projected_Validation_Amount__c=1.0;
        bbg1.Realized_Validation_Amount__c=1.0;
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
        qb3.Planned_Financial_Savings_Total__c=1;
        qb3.Planned_Operational_Savings_Total__c=1;
        qb3.Planned_Projected_Savings_Total__c=1;
        qb3.Planned_Realized_Savings_Total__c=1;
        qb3.Achieved_Financial_Savings_Total__c=1;
        qb3.Achieved_Operational_Savings_Total__c=1;
        qb3.Achieved_Projected_Savings_Total__c=1;
        qb3.Achieved_Realized_Savings_Total__c=1;
        qb3.Future_Financial_Savings_Total__c=1;
        qb3.Future_Operational_Savings_Total__c=1;
        qb3.Future_Projected_Savings_Total__c=1;
        qb3.Future_Realized_Savings_Total__c=1;
        qb3.Benefit_Amount_Achieved_Future_k__c=1;
        qb3.Benefit_Operational_Achieved_Future_k__c=1;
        qb3.Benefit_Projected_Achieved_Future_k__c=1;
        qb3.Benefit_Realized_Achieved_Future_k__c=1;
    
        insert qb3;
        Benefits_RelatedList.add(qb3);        
        
        PageReference pageRef2 = Page.QIPPA3ProjectEditView;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_A3_Project obj = new QIPP_A3_Project(sc);
        obj.issaveandnew = true;
        //obj.reqApproval();        
        obj.portfolioError='test';
        //project.Project_State__c = 'On Hold'; 
        //Update project;
        obj.issaveandnew = true;
        obj.getBAMDetailsMap();
        obj.BBGUpdated();
        obj.projState='In Progress';
        obj.saveProject();
        obj.errorMessages();
        obj.closeReasonPopup();
        //obj.reqApproval(); 
        project.Project_State__c = 'Canceled'; 
        Update project;
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc2 = new ApexPages.StandardController(project);
        QIPP_A3_Project obj2 = new QIPP_A3_Project(sc2);
        obj2.issaveandnew = true;
        //obj2.reqApproval();        
        obj2.portfolioError='test';
        //project.Project_State__c = 'On Hold'; 
        //Update project;
        obj2.issaveandnew = true;
        obj2.getBAMDetailsMap();
        obj2.BBGUpdated();
        obj2.projState='In Progress';
        obj2.saveProject();
        obj2.errorMessages();
        obj2.closeReasonPopup();
        //obj2.reqApproval();
        project.Project_State__c = 'Canceled'; 
        Update project;
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc3 = new ApexPages.StandardController(project);
        QIPP_A3_Project obj3 = new QIPP_A3_Project(sc3);
        obj3.issaveandnew = true;
        obj3.portfolioError='test';        
        obj3.issaveandnew = true;
        obj3.getBAMDetailsMap();
        obj3.BBGUpdated();
        obj3.projState='Canceled';
        obj3.saveProject();
        obj3.closeReasonPopup();
        obj3.projStateReason = false;
        obj3.errorMessages();
        obj3.closeReasonPopup();
        project.Project_State__c = 'On Hold'; 
        Update project;
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc4 = new ApexPages.StandardController(project);
        QIPP_A3_Project obj4 = new QIPP_A3_Project(sc4);
        obj4.issaveandnew = true;
        obj4.portfolioError='test';        
        obj4.issaveandnew = true;
        obj4.getBAMDetailsMap();
        obj4.BBGUpdated();
        obj4.projState='On Hold';
        obj4.saveProject();
        obj4.closeReasonPopup();
        obj4.projStateReason = false;
        obj4.errorMessages();
        obj4.closeReasonPopup();
        
        
        
        
        QIPP_Project__c dummyproject = new QIPP_Project__c();
        dummyproject.Portfolio_Name__c = portfolio.id;
        dummyproject.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
        dummyproject.Project_Completion_Date_Target__c = Date.Today();
        dummyproject.Project_Completion_Date_Forecast__c = Date.Today();
        dummyproject.Project_Description_Detailed__c = 'asdasd';
        dummyproject.Project_Name_Succinct__c = 'Test Project1';
        dummyproject.Portfolio_BU__c = 'Human Resources';
        dummyproject.Project_BL__c = 'Nokia EDU';
        dummyproject.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        dummyproject.CEMT_ID__c = 'sda';
        dummyproject.Primary_QLT_Function__c = 'CO';
        dummyproject.Last_Review_Type__c = 'Final';
        dummyproject.Project_Lead__c = con.id;
        dummyproject.Project_Sponsor__c = con2.id;
        dummyproject.ownerid = DummyUser.Id;
        dummyproject.Report_Name__c = 'Executive Dashboards';
        dummyproject.Report_Type__c = 'Summary of Projects by Project Type ';
        dummyproject.Business_Activity_Mapping__c = ba.id;
        dummyproject.Business_Activity_Mapping2__c = ba1.id;
        dummyproject.Business_Activity_Mapping3__c = ba2.id;
        dummyproject.Project_Document__c = 'https://www.tset.com';
        dummyproject.Project_State__c = 'On Hold'; 
        //insert dummyproject;
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc5 = new ApexPages.StandardController(dummyproject);
        QIPP_A3_Project obj5 = new QIPP_A3_Project(sc5);
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
        con2.Name = 'Srikanth';
        con2.Email__c = 'Srikanth@igate.com';
        con2.Contact_State__c = 'Active';
        con2.NSN_ID_Text__c = '44455454';        
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
        portfolio.A3__C = true;
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
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
        project.Project_Sponsor__c = con2.id;
        project.ownerid = DummyUser.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Business_Activity_Mapping__c = ba.id;
        project.Business_Activity_Mapping2__c = ba1.id;
        project.Business_Activity_Mapping3__c = ba2.id;
        project.Project_Document__c = 'https://www.tset.com';
        project.Project_State__c = 'Complete'; 
        insert project;
        
        Benefiting_Business_Group__c bbg1 = new Benefiting_Business_Group__c();        
        bbg1.Distribution__c=2.0;
        bbg1.Benefitting_Business_Grp_Functional_Grp__c= 'Human Resources'; 
        bbg1.Benefitting_Business_Unit__c='BHR FN';
        bbg1.Benefitting_Business_Line__c='Project Management';
        bbg1.Financial_Validation_Amount__c=1.0;
        bbg1.Operational_Validation_Amount__c=1.0;
        bbg1.Projected_Validation_Amount__c=1.0;
        bbg1.Realized_Validation_Amount__c=1.0;
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
        qb3.Planned_Financial_Savings_Total__c=1;
        qb3.Planned_Operational_Savings_Total__c=1;
        qb3.Planned_Projected_Savings_Total__c=1;
        qb3.Planned_Realized_Savings_Total__c=1;
        qb3.Achieved_Financial_Savings_Total__c=1;
        qb3.Achieved_Operational_Savings_Total__c=1;
        qb3.Achieved_Projected_Savings_Total__c=1;
        qb3.Achieved_Realized_Savings_Total__c=1;
        qb3.Future_Financial_Savings_Total__c=1;
        qb3.Future_Operational_Savings_Total__c=1;
        qb3.Future_Projected_Savings_Total__c=1;
        qb3.Future_Realized_Savings_Total__c=1;
        qb3.Benefit_Amount_Achieved_Future_k__c=1;
        qb3.Benefit_Operational_Achieved_Future_k__c=1;
        qb3.Benefit_Projected_Achieved_Future_k__c=1;
        qb3.Benefit_Realized_Achieved_Future_k__c=1;
    
        insert qb3;
        Benefits_RelatedList.add(qb3);        
        
        PageReference pageRef2 = Page.QIPPA3ProjectEditView;
        Test.setCurrentPage(pageRef2);  
        ApexPages.currentPage().getParameters().put('id', project.Id);        
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(project);
        QIPP_A3_Project obj = new QIPP_A3_Project(sc);
        obj.issaveandnew = true;
        obj.reqApproval();
        obj.closeReasonPopup();
        obj.portfolioError='test'; 
    }         
    
    
     private static testmethod void test5(){
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
        portfolio.A3__C = true;
        portfolio.Lean_including_Kaizen__c = true;
        portfolio.Portfolio_Business_Unit__c = 'test';
        insert portfolio;
        QIPP_Project__c dummyproject = new QIPP_Project__c();
        dummyproject.Portfolio_Name__c = portfolio.id;
        dummyproject.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
        dummyproject.Project_Completion_Date_Target__c = Date.Today();
        dummyproject.Project_Completion_Date_Forecast__c = Date.Today();
        dummyproject.Project_Description_Detailed__c = 'asdasd';
        dummyproject.Project_Name_Succinct__c = 'Test Project1';
        dummyproject.Portfolio_BU__c = 'Human Resources';
        dummyproject.Project_BL__c = 'Nokia EDU';
        dummyproject.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
        dummyproject.CEMT_ID__c = 'sda';
        dummyproject.Primary_QLT_Function__c = 'CO';
        dummyproject.Last_Review_Type__c = 'Final';
        //dummyproject.Project_Lead__c = con.id;
        //dummyproject.Project_Sponsor__c = con2.id;
        //dummyproject.ownerid = DummyUser.Id;
        dummyproject.Report_Name__c = 'Executive Dashboards';
        dummyproject.Report_Type__c = 'Summary of Projects by Project Type ';
        //dummyproject.Business_Activity_Mapping__c = ba.id;
        //dummyproject.Business_Activity_Mapping2__c = ba1.id;
        //dummyproject.Business_Activity_Mapping3__c = ba2.id;
        dummyproject.Project_Document__c = 'https://www.tset.com';
        dummyproject.Project_State__c = 'On Hold'; 
        //insert dummyproject;
        ApexPages.currentPage().getParameters().put('currPortfolio', portfolio.Id);
        ApexPages.StandardController sc5 = new ApexPages.StandardController(dummyproject);
        QIPP_A3_Project obj5 = new QIPP_A3_Project(sc5);
        obj5.portfolioName = '1';
        obj5.getPortfolioBBGValue();
        obj5.closeLeadSponsorEqualPopup();
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
            portfolio.A3__c = true;
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
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
            bn.Benefit_Type__c = 'Projected Revenue';
            bn.Planned_Realized_Savings_Total__c = 20;
            bn.Achieved_Realized_Savings_Total__c = 0;
            bn.Future_Realized_Savings_Total__c = 20;
            bn.Benefit_Realized_Achieved_Future_k__c = 20;
            insert bn;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            QIPP_A3_Project obj = new QIPP_A3_Project(sc);
            obj.reqApproval();

            bn.Benefit_Type__c = 'Operational Savings';
            update bn;
            
            project.Project_State__c = 'Canceled';
            update project;
            sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            obj = new QIPP_A3_Project(sc);
            obj.reqApproval();
            
            test.stoptest();
        }
    }    
    
    private static testmethod void test7(){
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
            portfolio.A3__c = true;
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
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
            QIPP_A3_Project obj = new QIPP_A3_Project(sc);
            obj.currentView='QIPPA3ProjectEditView';
            obj.issaveandnew = true;
            obj.saveProject();
            obj.closeLeadSponsorEqualPopup();

            obj.cancel();
            ApexPages.currentPage().getParameters().put('retURL', 'testurl');
            //ApexPages.currentPage().getParameters().put('cancelURL', '');
            obj.cancel();
            
            bn.Planned_Financial_Savings_Total__c = 0;
            bn.Achieved_Financial_Savings_Total__c = 0;
            bn.Future_Financial_Savings_Total__c = 0;
            bn.Benefit_Amount_Achieved_Future_k__c = 0;
            update bn;
            
            project.Project_State__c = 'Complete';
            update project;
                        
            sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            obj = new QIPP_A3_Project(sc);
            obj.currentView='QIPPA3ProjectEditView';
            obj.issaveandnew = false;
            obj.saveProject();
            obj.reqApproval();
            
            test.stoptest();
        }
    }
    
    private static testmethod void test8(){
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
            portfolio.A3__c = true;
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
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
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
            //project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'In Progress';
            project.Finance_Approver__c = con1.Id;
            project.Improvement_Owner__c = con1.Id;
            //project.Business_Activity_Mapping__c = ba.id;
            insert project;

            QIPP_Benefit__c bn = new QIPP_Benefit__c();
            bn.Project_ID__c = project.Id;
            bn.Benefit_Type__c = 'Realized Revenue';
            bn.Planned_Realized_Savings_Total__c = 20;
            bn.Achieved_Realized_Savings_Total__c = 0;
            bn.Future_Realized_Savings_Total__c = 0;
            bn.Benefit_Realized_Achieved_Future_k__c = 0;
            bn.Benefit_Amount_Achieved_Future_k__c = 0;
            bn.Benefit_Operational_Achieved_Future_k__c = 0;
            bn.Benefit_Projected_Achieved_Future_k__c = 0;
            insert bn;

            ApexPages.StandardController sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            QIPP_A3_Project obj = new QIPP_A3_Project(sc);
            obj.currentView='QIPPA3ProjectEditView';
            obj.reqApproval();
            
            project.Project_Document__c = 'https://www.tset.com';
            project.Business_Activity_Mapping__c = ba.id;
            update project;
            
            sc = new ApexPages.StandardController(project);
            ApexPages.currentPage().getParameters().put('id', project.Id);
            obj = new QIPP_A3_Project(sc);
            obj.reqApproval();

            test.stoptest();
        }
    }            
    
}