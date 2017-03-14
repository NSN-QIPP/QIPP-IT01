@istest(seealldata =true)
public class Benefit_Overtime_Data_Extract_Test{
    //For Benefit_Overtime_Data_Extract Class
    static testmethod void Benefit_Overtime_Data_Extract_1(){        
        Benefit_Overtime_Data_Extractv6 data = new Benefit_Overtime_Data_Extractv6();
        //data.emailTo= 'srikanthreddy.vennapusa@igate.com';
        data.todate = DateTime.newInstanceGMT(2014,01,01,00,00,0); // From :: 2014
        data.SendEmail();
        data.Backtopreviouspage();
    }
    static testmethod void Benefit_Overtime_Data_Extract_2(){        
        Benefit_Overtime_Data_Extractv6 data = new Benefit_Overtime_Data_Extractv6();
        data.emailTo= 'srikanthreddy.vennapusa@igate.com';
        data.SendEmail();
        data.Backtopreviouspage();
    }
    //For Benefit_Overtime_Data_Extract_Batch Class
    static testmethod void Benefit_Overtime_Data_Extract_Batch_1(){
        String emailTo = 'srikanthreddy.vennapusa@igate.com';
        String csvFileHeader;
        datetime  fromdate = DateTime.newInstanceGMT(2014,01,01,00,00,0);
       
        Set<id> BenIds = new Set<id>();            
        Set<id> ProjectIds = new Set<id>();
        /*
        Map<Id, QIPP_Project__c> projectById = new Map<Id, QIPP_Project__c>([select id,createddate from QIPP_Project__c where createddate >= :fromdate]);
        ProjectIds.addall(projectById.keyset());
        for(QIPP_Project__c Pid : [select id,createddate from QIPP_Project__c where createddate >= :fromdate]){
            ProjectIds.add(Pid.id);
        }*/
        Map<Id, QIPP_Benefit__c> benefitById = new Map<Id, QIPP_Benefit__c>([select ID,Name,Project_ID__r.name,Project_ID__r.createddate from QIPP_Benefit__c where Project_ID__r.name != null and Project_ID__r.createddate >= :fromdate]);
        BenIds.addall(benefitById.keyset());
        /*for(QIPP_Benefit__c  BIds : [select ID,Name,Project_ID__r.name from QIPP_Benefit__c where Project_ID__r.name != null and Project_ID__c in :ProjectIds]){
           BenIds.add(BIds.id);
           //ProjectIds.add(BIds.Project_ID__c);
        }*/
        System.debug('BenIds = : '+BenIds.size());
        // Fixed Header Columns 
        csvFileHeader = 'QIPP Project: Project ID'+','+'Methodology'+','+'Project Name - Succinct Project'+','+'Description'+','+'Portfolio Name'+','+'Portfolio Owner'+','+'Portfolio Owner Email'+','+'Benefitting Project BU'+','+'Benefitting Project BL (Level 3 Org)'+','+'Benefitting Project BL (Level 4 Org)'+','+'Project Lead: Contact Name'+','+'Project Lead: Email'+','+'Project Lead BU'+','+'Project Lead BL (Level 3 Org)'+','+'Project Lead BL (Level 4 Org)'+','+'Project State'+','+'Project Created Date'+','+'Project Start Date - Planned'+','+'Project Start Date - Actual'+','+'Target Completion Date'+','+'Forecast'+','+'Actual'+','+'Market'+','+'Region / GCBT'+','+'Sub-Region / CBT'+','+'CT'+','+'Country'+','+'Belt Project Type'+','+'Belt Project Phase'+','+'Project Champion'+','+'Belt Project Champion Email'+','+'Belt Project Sponsor'+','+'Belt Project Sponsor Email'+','+'Business Unit Master Black Belt'+','+'Business Unit Master Black Belt Email'+','+'Belt Candidate Mentor'+','+'Belt Candidate Mentor Email'+','+'Finance Approver'+','+'Finance Approver Email'+','+'Belt Candidate Location'+','+'Define Date ? Planned'+','+'Define Date - Forecast'+','+'Define Date ? Current'+','+'Define Status'+','+'Measure Date ? Planned'+','+'Measure Date - Forecast'+','+'Measure Date ? Current'+','+'Measure Status'+','+'Analyze Date ? Planned'+','+'Analyze Date - Forecast'+','+'Analyze Date ? Current'+','+'Analyze Status'+','+'Improve / Design Date ? Planned'+','+'Improve / Design Date ? Forecast'+','+'Improve / Design Date ? Current'+','+'Improve / Design Status'+','+'Control / Verify Date ? Planned'+','+'Control / Verify Date ? Forecast'+','+'Control / Verify Date ?'+','+'Current Control / Verify Status'+','+'Project Type'+','+'Project Owner'+','+'Project Owner Email'+','+'DI State'+','+'Improvement Measure (KPI)'+','+'Improvement Measure Grouping';
        //list<String> years = new list<String>(sortyears);
        Set<String> sortyears = new Set<String>();
        map<string, set<string> > qtryrmap = new map<string, set<string>>();
        Map<String,list<QIPP_BU_Reporting__c>> repMap = new Map<String,list<QIPP_BU_Reporting__c>>();
        for(QIPP_BU_Reporting__c Benyr : [select ID,Benefit_ID__c,Benefit_Type__c,Benefit_Condition__c,Quarters__c,Years__c,Months__c from QIPP_BU_Reporting__c where Benefit_ID__c in: BenIds and Entry_Type__c = 'User Entry']){
            if(!repMap.containsKey(Benyr.Benefit_ID__c)){
                repMap.put(Benyr.Benefit_ID__c, new list<QIPP_BU_Reporting__c>{Benyr});
            }else{
                repMap.get(Benyr.Benefit_ID__c).add(Benyr);
            }
            sortyears.add(Benyr.Years__c);
            string tyconqtr = Benyr.Benefit_Type__c+':'+Benyr.Benefit_Condition__c+':'+Benyr.Quarters__c;
            if(!qtryrmap.containsKey(Benyr.Years__c)){
                qtryrmap.put(Benyr.Years__c, new Set<String>{tyconqtr});
            }else{
                qtryrmap.get(Benyr.Years__c).add(tyconqtr);
            }
        }
        list<String> years = new list<String>(sortyears);
        years.sort();
            system.debug('years:: '+ years); 
            System.debug('keys in the map: ' + qtryrmap.keySet());
            System.debug('list of values in the map : ' + qtryrmap.values());
            System.debug('year values in the map : ' + qtryrmap.get('2015'));
        //Dynamic Header Columns based on years n quaters
        for(string yr :years){
            Set<String> stringset1= qtryrmap.get(yr);
                    // stringset2.addall(stringset1);
            // For Financial Savings
            //Financial Palnned savings
            if(stringset1.contains('Financial Savings:Planned:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            //Financial Achieved savings
            if(stringset1.contains('Financial Savings:Achieved:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            //Financial Future savings
            if(stringset1.contains('Financial Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            //LE Financial Savings
            if(stringset1.contains('Financial Savings:Achieved:Q1') || stringset1.contains('Financial Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q2') || stringset1.contains('Financial Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q3') || stringset1.contains('Financial Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q4') || stringset1.contains('Financial Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            // For Operational Savings
            //Operational Planned savings
            if(stringset1.contains('Operational Savings:Planned:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            //Operational Achieved savings
            if(stringset1.contains('Operational Savings:Achieved:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            //Operational Future savings
            if(stringset1.contains('Operational Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            //LE Financial Savings
            if(stringset1.contains('Operational Savings:Achieved:Q1') || stringset1.contains('Operational Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q2') || stringset1.contains('Operational Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q3') || stringset1.contains('Operational Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q4') || stringset1.contains('Operational Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
        }
        
        Test.startTest();
           Benefit_Overtime_Data_Extract_batchv6 c = new Benefit_Overtime_Data_Extract_batchv6(emailto,csvFileHeader,years,qtryrmap,fromdate);
           c.query ='select id, name,Project_Type__c,Project_Name_Succinct__c,Project_Description_Detailed__c,Portfolio_Name__r.Name,Portfolio_Name__r.Portfolio_Owner__r.name,Portfolio_Name__r.Portfolio_Owner__r.Email__c,Portfolio_BU__c,Project_BL__c,Benefitting_Project_BL_Level_4_Org__c,Project_Lead__r.name,Project_Lead__r.Email__c,Project_Lead__r.Contact_BU__c,Project_Lead__r.Contact_BL__c,Project_Lead__r.Contact_L4_Org__c,Project_State__c,Project_Created_Date__c,Planned_Start_Date__c,Project_Start_Date__c,Project_Completion_Date_Target__c,Project_Completion_Date_Forecast__c,Project_Completion_Date_Actual__c,Market__c,Region_GCBT__c,Sub_Region_CBT__c,CT__c,Country__c,Belt_Project_Type__c,Belt_Project_Phase__c,Belt_Project_Champion__r.name,Belt_Project_Champion__r.Email__c,Belt_Project_Sponsor__r.name,Belt_Project_Sponsor_Email__c,Business_Unit_Master_Black_Belt__r.name,Business_Unit_Master_Black_Belt_Email__c,Belt_Candidate_Mentor__r.name,Belt_Candidate_Mentor_Email__c,Finance_Approver__r.name,Finance_Approver_Email__c,Belt_Candidate_Location__c,DMAIC_Define__c,Define_Date_Forecast__c,Define_Date_Current__c,Define_Status__c,DMAIC_Measure__c,Measure_Date_Forecast__c,Measure_Date_Current__c,Measure_Status__c,DMAIC_Analyze__c,Analyze_Date_Forecast__c,Analyze_Date_Current__c,Analyze_Status__c,DMAIC_Improve__c,Improve_Design_Date_Forecast__c,Improve_Date_Current__c,Improve_Status__c,DMAIC_Control__c,Control_Verify_Date_Forecast__c,Control_Date_Current__c,Control_Status__c,Lean_Project_Type__c,Project_Owner__r.name,Project_Owner__r.Email__c,DI_State__c,Progress_To_Date__c,Next_Steps__c,MO_Site__c,Lean_Project_Phase__c,Not_Started_Date__c,In_Progress_Date__c,On_Hold_Date__c,Canceled_Date__c,Closed_Date__c,Portfolio_Name__r.Portfolio_Status__c,Lean_Coach__r.name,Lean__c,Number_of_Kaizens__c,Project_Flex_Field_1__c,Project_Flex_Field_2__c,Project_Flex_Field_3__c,Sharenet_Link__c,Schedule_Status__c,Lean_Coach__r.email__c,Project_Lead_Location__c  from QIPP_Project__c where createddate >= :fromdate limit 10'  ;
           database.executebatch(c,10); 
        Test.stopTest();
    }
}