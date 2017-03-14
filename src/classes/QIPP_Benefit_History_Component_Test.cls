@istest(seealldata =true)
public class QIPP_Benefit_History_Component_Test {
   // static id RTID_DMAIC = [select Id from RecordType where Name = 'Methodology: DMAIC / DMADV' and SobjectType = 'QIPP_Project__c'].Id;
    
   /* static testmethod void GenericHistoryComponentController_1(){  
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
        con.Name = 'Srikanth';
        con.Email__c = 'Srikanth.sree@igate.com';
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
        insert project;
        
        QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'KPI1';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Table__c conversions2 = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions2.Name = 'KPI2';
        conversions2.Benefit_Type__c = 'Financial Savings';
        conversions2.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions2;
        
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
        benifit.Baseline_Rate_N__c = 100;
        benifit.Financial_Type__c = 'Operational Savings';
        benifit.Business_Line__c = 'GSM';
        benifit.Improvement_Measure_KPI__c = conversions.id;         
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Baseline_Period_weeks__c = 4.35;
        benifit.Directional_Indicator__c = 'Higher is Favorable' ;
        Date startdate = Date.newInstance(2013, 01, 01);   
        Date enddate = Date.newInstance(2013, 03, 31);
        benifit.Baseline_Quantity__c = 15;
        benifit.Type_of_Measure__c = 'Weekly Rate' ;
        benifit.Planned_Quanity__c = 500;
        benifit.Planned_Benefit_Period_Weeks__c = 4.33;
        benifit.Planned_Start_Date__c = startdate  ;
        benifit.Planned_End_Date__c = enddate ;
        benifit.Planned_Operational_Manual_Amount__c = 500;
        benifit.Achieved_Quantity__c = 50;
        benifit.Achieved_Start_Date__c = startdate  ;
        benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
        benifit.Achieved_End_Date__c = enddate  ;
        benifit.Achieved_Operational_Manual_Amount__c = 500;
        benifit.Future_Quantity__c = 50;
        benifit.Future_Start_Date__c = Date.newInstance(2013, 04, 01);
        benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
        benifit.Future_End_Date__c = Date.newInstance(2013, 04, 31);         
        benifit.Future_Operational_Manual_Amount__c = 500;
        benifit.Unit_of_Measure__c = 'Each';
        benifit.Project_ID__c = project.id;
        insert benifit;
        
        QIPP_BU_Reporting__c benrep1 = new QIPP_BU_Reporting__c ();
        benrep1.Project_ID__c = project.id;
        benrep1.Benefit_ID__c = benifit.id;
        benrep1.Benefit_Condition__c = 'Planned';
        benrep1.Quarters__c = 'Q1';                           
        benrep1.Years__c = '2014';  
        benrep1.Benefit_Savings_Amount__c = 100;   
        insert benrep1; 
        
        GenericHistoryComponentController ghcc = new GenericHistoryComponentController();        
        ghcc.myObject = benifit;
        ghcc.recordLimit = 5;
        ghcc.getObjectHistory();
        ghcc.gotolist();
    } */
    
    static testmethod void GenericHistoryComponentController_2(){ 
    	QIPP_Benefit__c[] benifit ;
        QIPP_Project__c[] projectinfo;
        projectinfo = [select id, Name,Project_Name_Succinct__c from QIPP_Project__c where Project_Name_Succinct__c ='qipp history test' limit 1];          
        if(projectinfo.size()>0){
       		benifit = [select ID ,Project_ID__c,Improvement_Measure_KPI__c,Benefit_Type__c,Improvement_Measure_Name__c from QIPP_Benefit__c where Project_ID__c = :projectinfo[0].id limit 1];
    	}
        if(benifit == null){
            benifit = [select ID ,Improvement_Measure_KPI__c,Benefit_Type__c,Improvement_Measure_Name__c from QIPP_Benefit__c limit 1];
        }
        GenericHistoryComponentController ghcc = new GenericHistoryComponentController();        
        ghcc.myObject = benifit[0];
        ghcc.recordLimit = 5;
        ghcc.getObjectHistory();
        ghcc.gotolist();
    }
    
    static testmethod void QIPP_Benefit_Report_History_Cntr_v2_1(){ 
    	QIPP_BU_Reporting__c[] benifitrep ;
        QIPP_Project__c[] projectinfo;
        list<id> ids = new list<id>();
        projectinfo = [select id, Name,Project_Name_Succinct__c from QIPP_Project__c where Project_Name_Succinct__c ='qipp history test' limit 1];          
        system.debug('projectinfo'+projectinfo);
        if(projectinfo.size()>0){
       		benifitrep = [select id ,Project_ID__c,History_Tracking_For_Initial_Line_Items__c from QIPP_BU_Reporting__c  where Project_ID__c =:projectinfo[0].id limit 5]; 
            system.debug('benifitrep 1 :'+benifitrep);
    	}
        if(benifitrep == null){
            benifitrep = [select id ,Project_ID__c,History_Tracking_For_Initial_Line_Items__c from QIPP_BU_Reporting__c limit 5]; 
            system.debug('benifitrep 2 :'+benifitrep);
        }
        if(benifitrep.size()>0){
            for(QIPP_BU_Reporting__c qbu :benifitrep){
                ids.add(qbu.id);
            }
        }
        QIPP_Benefit_Report_History_Cntr_v2 ghcc = new QIPP_Benefit_Report_History_Cntr_v2();        
        ghcc.myObjectids = ids;
        ghcc.QBR = benifitrep;
        ghcc.recordLimit = 10;
        ghcc.getObjectHistory();
        ghcc.Beginning();
        ghcc.Previous();
        ghcc.next();
        ghcc.end();
        ghcc.getDisablePrevious();
        ghcc.getDisableNext();
        ghcc.getTotal_size();
        ghcc.getPageNumber();
        ghcc.getTotalPages();
    }
}