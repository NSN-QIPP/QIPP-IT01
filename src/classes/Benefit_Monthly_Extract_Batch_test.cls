@istest(seealldata =true)
public class Benefit_Monthly_Extract_Batch_test{
    static testmethod void Benefit_Overtime_Data_Monthly_Extract_1(){        
        Benefit_Overtime_Data_Monthly_Extract_V2 data = new Benefit_Overtime_Data_Monthly_Extract_V2();
        //data.emailTo= 'srikanthreddy.vennapusa@igate.com';
        data.SendEmail();
        data.Backtopreviouspage();
    }
    static testmethod void Benefit_Overtime_Data_Monthly_Extract_2(){        
        Benefit_Overtime_Data_Monthly_Extract_V2 data = new Benefit_Overtime_Data_Monthly_Extract_V2();
        data.emailTo= 'srikanthreddy.vennapusa@igate.com';
        data.SendEmail();
        data.Backtopreviouspage();
    }
    static testmethod void Benefit_Monthly_Extract_Batch_B1(){
        String emailTo = 'srikanthreddy.vennapusa@igate.com';
        datetime  fromdate = DateTime.newInstanceGMT(2014,01,01,00,00,0); // From :: 2014
        datetime todate = DateTime.newInstanceGMT(2019,01,01,00,00,0); // To :: 2018
        Test.startTest();
            Benefit_Overtime_Data_Monthly_Extract_B1  ld = new Benefit_Overtime_Data_Monthly_Extract_B1 (emailto,fromdate,todate);
            ld.query = 'select ID,Name,Project_ID__r.name,Project_ID__r.createddate from QIPP_Benefit__c where Project_ID__r.name != null and Project_ID__r.createddate >= :fromdate and Project_ID__r.createddate < :todate limit 10' ;
            database.executebatch(ld,10);  
        Test.stopTest();
    }
    static testmethod void Benefit_Monthly_Extract_Batch_B2(){
        String emailTo = 'srikanthreddy.vennapusa@igate.com';
        String csvFileHeader;
        //list<string> years = new list<string>();
        map<string, set<string> > monthrmap = new map<string, set<string>>();
        Set<String> sortyears = new Set<String>();
        datetime  fromdate = DateTime.newInstanceGMT(2014,01,01,00,00,0); // From :: 2014
        datetime todate = DateTime.newInstanceGMT(2019,01,01,00,00,0); // To :: 2018
        String query;
        csvFileHeader = 'QIPP Project: Project ID'+','+'Methodology'+','+'Project Name - Succinct Project'+','+'Description'+','+'Portfolio Name'+','+'Portfolio Status'+','+'Portfolio Owner'+','+'Portfolio Owner Email'+','+'Benefitting Project BU'+','+'Benefitting Project BL (Level 3 Org)'+','+'Benefitting Project BL (Level 4 Org)'+','+'Project Lead: Contact Name'+','+'Project Lead: Email'+','+'Project Lead BU'+','+'Project Lead BL (Level 3 Org)'+','+'Project Lead BL (Level 4 Org)'+','+'Project State'+','+'Progress To Date'+','+'Next Steps'+','+'Project Created Date'+','+'Project Start Date - Planned'+','+'Project Start Date - Actual'+','+'Target Completion Date'+','+'Forecast'+','+'Actual'+','+'Closed Date'+','+'Cancelled Date'+','+'On Hold Date'+','+'In Progress Date'+','+'Market'+','+'Market Unit / GCBT'+','+'CBT'+','+'CT'+','+'Country'+','+'MO site'+','+'Belt Project Type'+','+'Belt Project Phase'+','+'Project Champion'+','+'Belt Project Champion Email'+','+'Belt Project Sponsor'+','+'Belt Project Sponsor Email'+','+'Business Unit Master Black Belt'+','+'Business Unit Master Black Belt Email'+','+'Belt Candidate Mentor'+','+'Belt Candidate Mentor Email'+','+'Finance Approver'+','+'Finance Approver Email'+','+'Belt Candidate Location'+','+'Project Flex Field #1'+','+'Project Flex Field #2'+','+'Project Flex Field #3'+','+'Lean Project Lead Location'+','+'Lean Certification Project'+','+'Lean Project Phase'+','+'Lean Project Type'+','+'Number of Kaizens'+','+'Lean Sharenet Link'+','+'Lean Schedule Status'+','+'Lean Coach'+','+'Lean Coach Email'+','+'Lean Project Sponsor'+','+'Lean Project Sponsor Email'+','+'Define Date ? Planned'+','+'Define Date - Forecast'+','+'Define Date ? Current'+','+'Define Status'+','+'Measure Date ? Planned'+','+'Measure Date - Forecast'+','+'Measure Date ? Current'+','+'Measure Status'+','+'Analyze Date ? Planned'+','+'Analyze Date - Forecast'+','+'Analyze Date ? Current'+','+'Analyze Status'+','+'Improve / Design Date ? Planned'+','+'Improve / Design Date ? Forecast'+','+'Improve / Design Date ? Current'+','+'Improve / Design Status'+','+'Control / Verify Date ? Planned'+','+'Control / Verify Date ? Forecast'+','+'Control / Verify Date ?'+','+'Current Control / Verify Status'+','+'DI State'+','+'Improvement Measure (KPI)'+','+'Improvement Measure Grouping'+','+'Planned Financial Savings (K Euro)'+','+'Achieved Financial Savings (K Euro)'+','+'Future Financial Savings (K Euro)'+','+'LE Financial Savings (K Euro)'+','+'Planned Operational Savings (K Euro)'+','+'Achieved Operational Savings (K Euro)'+','+'Future Operational Savings (K Euro)'+','+'LE Operational Savings (K Euro)' ;
        for(QIPP_BU_Reporting__c Benyr : [select ID,Project_ID__c,Benefit_ID__c,Benefit_Type__c,Benefit_Condition__c,Quarters__c,Years__c,Months__c from QIPP_BU_Reporting__c where  Months__c != null limit 100]){
            sortyears.add(Benyr.Years__c);
            string tyconqtr = Benyr.Benefit_Type__c+':'+Benyr.Benefit_Condition__c+':'+Benyr.Months__c;
            if(!monthrmap.containsKey(Benyr.Years__c)){
                monthrmap.put(Benyr.Years__c, new Set<String>{tyconqtr});
            }else{
                monthrmap.get(Benyr.Years__c).add(tyconqtr);
            }
        }
        list<String> years = new list<String>(sortyears);
        years.sort();
        system.debug('csvFileHeader :: '+ csvFileHeader); 

        //Dynamic Header Columns based on years n quaters
        for(string yr :years){
            Set<String> stringset1= monthrmap.get(yr);
            //For Financial Savings
            //Financial Planned savings
            if(stringset1.contains('Financial Savings:Planned:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Planned:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'Planned Financial Savings (K Euro)';
            }
            
            //Financial Achieved savings
            if(stringset1.contains('Financial Savings:Achieved:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'Achieved Financial Savings (K Euro)';
            }
            
            //Financial Future savings
            if(stringset1.contains('Financial Savings:Future:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Future:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'Future Financial Savings (K Euro)';
            }
            //LE Financial Savings
            if(stringset1.contains('Financial Savings:Achieved:01') || stringset1.contains('Financial Savings:Future:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:02') || stringset1.contains('Financial Savings:Future:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:03') || stringset1.contains('Financial Savings:Future:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:04') || stringset1.contains('Financial Savings:Future:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:05') || stringset1.contains('Financial Savings:Future:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:06') || stringset1.contains('Financial Savings:Future:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:07') || stringset1.contains('Financial Savings:Future:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:08') || stringset1.contains('Financial Savings:Future:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:09') || stringset1.contains('Financial Savings:Future:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:10') || stringset1.contains('Financial Savings:Future:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:11') || stringset1.contains('Financial Savings:Future:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }
            if(stringset1.contains('Financial Savings:Achieved:12') || stringset1.contains('Financial Savings:Future:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'LE Financial Savings (K Euro)';
            }

            // For Operational Savings
            //Operational Planned savings
            if(stringset1.contains('Operational Savings:Planned:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Planned:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'Planned Operational Savings (K Euro)';
            }
            //Operational Achieved savings
            if(stringset1.contains('Operational Savings:Achieved:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'Achieved Operational Savings (K Euro)';
            }
            //Operational Future savings
            if(stringset1.contains('Operational Savings:Future:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Future:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'Future Operational Savings (K Euro)';
            }
            //LE Operational Savings
            if(stringset1.contains('Operational Savings:Achieved:01') || stringset1.contains('Operational Savings:Future:01')){
                csvFileHeader = csvFileHeader + ','+'P1'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:02') || stringset1.contains('Operational Savings:Future:02')){
                csvFileHeader = csvFileHeader + ','+'P2'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:03') || stringset1.contains('Operational Savings:Future:03')){
                csvFileHeader = csvFileHeader + ','+'P3'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:04') || stringset1.contains('Operational Savings:Future:04')){
                csvFileHeader = csvFileHeader + ','+'P4'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:05') || stringset1.contains('Operational Savings:Future:05')){
                csvFileHeader = csvFileHeader + ','+'P5'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:06') || stringset1.contains('Operational Savings:Future:06')){
                csvFileHeader = csvFileHeader + ','+'P6'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:07') || stringset1.contains('Operational Savings:Future:07')){
                csvFileHeader = csvFileHeader + ','+'P7'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:08') || stringset1.contains('Operational Savings:Future:08')){
                csvFileHeader = csvFileHeader + ','+'P8'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:09') || stringset1.contains('Operational Savings:Future:09')){
                csvFileHeader = csvFileHeader + ','+'P9'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:10') || stringset1.contains('Operational Savings:Future:10')){
                csvFileHeader = csvFileHeader + ','+'P10'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:11') || stringset1.contains('Operational Savings:Future:11')){
                csvFileHeader = csvFileHeader + ','+'P11'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
            if(stringset1.contains('Operational Savings:Achieved:12') || stringset1.contains('Operational Savings:Future:12')){
                csvFileHeader = csvFileHeader + ','+'P12'+' '+yr+' '+'LE Operational Savings (K Euro)';
            }
        }
        Test.startTest();
            Benefit_Overtime_Data_Monthly_Extract_B2  ld = new Benefit_Overtime_Data_Monthly_Extract_B2 (emailto,csvFileHeader,years,monthrmap,fromdate,todate);
            ld.query ='select id, name,Project_Type__c,Project_Name_Succinct__c,Project_Description_Detailed__c,Portfolio_Name__r.Name,Portfolio_Name__r.Portfolio_Owner__r.name,Portfolio_Name__r.Portfolio_Owner__r.Email__c,Portfolio_BU__c,Project_BL__c,Benefitting_Project_BL_Level_4_Org__c,Project_Lead__r.name,Project_Lead__r.Email__c,Project_Lead__r.Contact_BU__c,Project_Lead__r.Contact_BL__c,Project_Lead__r.Contact_L4_Org__c,Project_State__c,Project_Created_Date__c,Planned_Start_Date__c,Project_Start_Date__c,Project_Completion_Date_Target__c,Project_Completion_Date_Forecast__c,Project_Completion_Date_Actual__c,Market__c,Region_GCBT__c,Sub_Region_CBT__c,CT__c,Country__c,Belt_Project_Type__c,Belt_Project_Phase__c,Belt_Project_Champion__r.name,Belt_Project_Champion__r.Email__c,Belt_Project_Sponsor__r.name,Belt_Project_Sponsor_Email__c,Business_Unit_Master_Black_Belt__r.name,Business_Unit_Master_Black_Belt_Email__c,Belt_Candidate_Mentor__r.name,Belt_Candidate_Mentor_Email__c,Finance_Approver__r.name,Finance_Approver_Email__c,Belt_Candidate_Location__c,DMAIC_Define__c,Define_Date_Forecast__c,Define_Date_Current__c,Define_Status__c,DMAIC_Measure__c,Measure_Date_Forecast__c,Measure_Date_Current__c,Measure_Status__c,DMAIC_Analyze__c,Analyze_Date_Forecast__c,Analyze_Date_Current__c,Analyze_Status__c,DMAIC_Improve__c,Improve_Design_Date_Forecast__c,Improve_Date_Current__c,Improve_Status__c,DMAIC_Control__c,Control_Verify_Date_Forecast__c,Control_Date_Current__c,Control_Status__c,Lean_Project_Type__c,Project_Owner__r.name,Project_Owner__r.Email__c,DI_State__c,Progress_To_Date__c,Next_Steps__c,MO_Site__c,Lean_Project_Phase__c,Not_Started_Date__c,In_Progress_Date__c,On_Hold_Date__c,Canceled_Date__c,Closed_Date__c,Portfolio_Name__r.Portfolio_Status__c,Lean_Coach__r.name,Lean__c,Number_of_Kaizens__c,Project_Flex_Field_1__c,Project_Flex_Field_2__c,Project_Flex_Field_3__c,Sharenet_Link__c,Schedule_Status__c,Lean_Coach__r.email__c,Project_Lead_Location__c  from QIPP_Project__c where createddate >= :fromdate and  createddate < :todate limit 10';
            database.executebatch(ld,10);   
        Test.stopTest();
        
    }
}