@isTest
private with sharing class qippStandardProjectBenefitCtrl_TestClass{
 private static testmethod void test3(){
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
    
    
      system.debug('@@@@@@@@@@@@'+p);
      system.debug('@@@@@@@@@@@@'+u.User_License_Type__c);
      system.debug('@@@@@@@@@@@@'+u1);
      system.debug('#############'+qCont);
    
      }
      system.runas(u){
    
        system.debug('INSERTTTTT'+qCont);
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
      
      qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
      //qProj.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: After QIPP DMAIC Define').getRecordTypeId();

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
      //qProj.CreatedById
      //qProj.CreatedDate
      //qProj.LastModifiedById
      //qProj.LastModifiedDate
      if (Schema.SObjectType.QIPP_Project__c.isCreateable()){
        insert qProj;
      }
      
    User u1 = [select id from user where Email='amol@amol.com' limit 1];
    system.runas(u1){

    Benefiting_Business_Group__c bg = new Benefiting_Business_Group__c(Project_ID__c=qProj.id,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c=NULL, Benefitting_Business_Line__c=NUll,Distribution__c=0);
    insert bg;
     
    Business_Activity__c bam1 = new Business_Activity__c();
    bam1.name = 'Test Business Activity';
    bam1.Business_Function__c = 'Account management';
    bam1.Value_Stream__c = 'Quality';
    insert bam1; 
    QIPP_Benefit_Conversion_Table__c imp1 = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 1',Active__c=True, Benefit_Type__c='Financial Savings');
    insert imp1; 
    QIPP_Benefit_Conversion_Table__c imp2 = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 2',Active__c=True, Benefit_Type__c='Operational Savings');
    insert imp2; 
    QIPP_Benefit_Conversion_Table__c imp3 = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 3',Active__c=True, Benefit_Type__c='Projected Revenue');
    insert imp3; 
    QIPP_Benefit_Conversion_Table__c imp4 = new QIPP_Benefit_Conversion_Table__c(name='improvement Measure 4',Active__c=True, Benefit_Type__c='Realized Revenue');
    insert imp4; 
    List<QIPP_Benefit__c> benifitList = new List<QIPP_Benefit__c>();
    
    benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp1.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=0,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=0,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp2.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp3.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp4.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    insert benifitList;  
    
    List<QIPP_Benefit__c> benifitList1 = new List<QIPP_Benefit__c>();
    
    benifitList1.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp1.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList1.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp2.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=0,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=0,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList1.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp3.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList1.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp4.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    insert benifitList1;  
    
    List<QIPP_Benefit__c> benifitList2 = new List<QIPP_Benefit__c>();
    
    benifitList2.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp1.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList2.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp2.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=0,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=0,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList2.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp3.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList2.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp4.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    insert benifitList2; 
    
    List<QIPP_Benefit__c> benifitList3 = new List<QIPP_Benefit__c>();
    
    benifitList3.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp1.id,Benefit_Type__c='Realized Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList3.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp2.id,Benefit_Type__c='Financial Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=0,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=0,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList3.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp3.id,Benefit_Type__c='Operational Savings',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    benifitList3.add(new QIPP_Benefit__c(Improvement_Measure_KPI__c =imp4.id,Benefit_Type__c='Projected Revenue',Project_ID__c=qProj.id,Unit_of_Measure__c='measure',Planned_Financial_Savings_Total__c=2,Planned_Operational_Savings_Total__c=2,Planned_Projected_Savings_Total__c=3,Planned_Realized_Savings_Total__c=4,Achieved_Financial_Savings_Total__c=5,Achieved_Operational_Savings_Total__c=6,Achieved_Projected_Savings_Total__c=7,Achieved_Realized_Savings_Total__c=8,Future_Financial_Savings_Total__c=9,Future_Operational_Savings_Total__c=10,Future_Projected_Savings_Total__c=11,Future_Realized_Savings_Total__c=12,Benefit_Amount_Achieved_Future_k__c=13,Benefit_Operational_Achieved_Future_k__c=14,Benefit_Projected_Achieved_Future_k__c=15,Benefit_Realized_Achieved_Future_k__c=16));
    insert benifitList3; 
    
    ApexPages.StandardController stdController = new ApexPages.StandardController(qProj);
    qippStandardProjectBenefitCtrl qProjTest = new qippStandardProjectBenefitCtrl(stdController);
    qProjTest.getBenefits();
    qProjTest.getBAMDetailsMap();
    qProjTest.callDummy();
    }     

  }  
}