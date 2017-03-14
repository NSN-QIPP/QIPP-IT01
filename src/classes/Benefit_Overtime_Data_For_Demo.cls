Global class Benefit_Overtime_Data_For_Demo{
 
    public String emailTo {get; set;}
    public String response {get; set;}
    public datetime m=system.now(); 
    public String emailError{get; set;}
    
    public Transient  list<QIPP_Benefit__c> Benifits = new list<QIPP_Benefit__c>();
    public Transient list<QIPP_BU_Reporting__c> Benft_reps = new List<QIPP_BU_Reporting__c>();
    
    String csvFileHeader; 
    String csvFileValues;
    String csvFile;
    
    public Benefit_Overtime_Data_For_Demo() {

    }
        
    public PageReference SendEmail(){
    
        Benifits = [select ID , Name ,Benefit_Type__c,
                      Project_ID__r.name,
                      Project_ID__r.Project_Type__c,
                      Project_ID__r.Project_Name_Succinct__c,
                      Project_ID__r.Project_Description_Detailed__c,
                      Project_ID__r.Portfolio_Name__r.Name,
                      Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.name,
                      Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.Email__c,
                      Project_ID__r.Portfolio_BU__c,
                      Project_ID__r.Project_BL__c,
                      Project_ID__r.Benefitting_Project_BL_Level_4_Org__c,
                      Project_ID__r.Project_Lead__r.name,
                      Project_ID__r.Project_Lead__r.Email__c,
                      Project_ID__r.Project_Lead__r.Contact_BU__c,
                      Project_ID__r.Project_Lead__r.Contact_BL__c,
                      Project_ID__r.Project_Lead__r.Contact_L4_Org__c,
                      Project_ID__r.Project_State__c,
                      Project_ID__r.Project_Created_Date__c,
                      Project_ID__r.Planned_Start_Date__c,
                      Project_ID__r.Project_Start_Date__c,
                      Project_ID__r.Project_Completion_Date_Target__c,
                      Project_ID__r.Project_Completion_Date_Forecast__c,
                      Project_ID__r.Project_Completion_Date_Actual__c,
                      Project_ID__r.Market__c,
                      Project_ID__r.Region_GCBT__c,
                      Project_ID__r.Sub_Region_CBT__c,
                      Project_ID__r.CT__c,
                      Project_ID__r.Country__c,
                      Project_ID__r.Belt_Project_Type__c,
                      Project_ID__r.Belt_Project_Phase__c,
                      Project_ID__r.Belt_Project_Champion__r.name,
                      Project_ID__r.Belt_Project_Champion__r.Email__c,
                      Project_ID__r.Belt_Project_Sponsor__r.name,
                      Project_ID__r.Belt_Project_Sponsor_Email__c,
                      Project_ID__r.Business_Unit_Master_Black_Belt__r.name,
                      Project_ID__r.Business_Unit_Master_Black_Belt_Email__c,
                      Project_ID__r.Belt_Candidate_Mentor__r.name,
                      Project_ID__r.Belt_Candidate_Mentor_Email__c,
                      Project_ID__r.Finance_Approver__r.name,
                      Project_ID__r.Finance_Approver_Email__c,
                      Project_ID__r.Belt_Candidate_Location__c,
                      Project_ID__r.DMAIC_Define__c,
                      Project_ID__r.Define_Date_Forecast__c,
                      Project_ID__r.Define_Date_Current__c,
                      Project_ID__r.Define_Status__c,
                      Project_ID__r.DMAIC_Measure__c,
                      Project_ID__r.Measure_Date_Forecast__c,
                      Project_ID__r.Measure_Date_Current__c,
                      Project_ID__r.Measure_Status__c,
                      Project_ID__r.DMAIC_Analyze__c,
                      Project_ID__r.Analyze_Date_Forecast__c,
                      Project_ID__r.Analyze_Date_Current__c,
                      Project_ID__r.Analyze_Status__c,
                      Project_ID__r.DMAIC_Improve__c,
                      Project_ID__r.Improve_Design_Date_Forecast__c,
                      Project_ID__r.Improve_Date_Current__c,
                      Project_ID__r.Improve_Status__c,
                      Project_ID__r.DMAIC_Control__c,
                      Project_ID__r.Control_Verify_Date_Forecast__c,
                      Project_ID__r.Control_Date_Current__c,
                      Project_ID__r.Control_Status__c,
                      Project_ID__r.Lean_Project_Type__c,
                      Project_ID__r.Project_Owner__r.name,
                      Project_ID__r.Project_Owner__r.Email__c,
                      Project_ID__r.DI_State__c,
                      Improvement_Measure_KPI__r.Name,
                      Improvement_Measure_KPI__r.Improvement_Measure_Grouping__c 
                   from QIPP_Benefit__c where Project_ID__r.name != null ];
      //where Project_ID__c = 'a18q0000000APU9'
       system.debug('Benifits size :: '+ Benifits.size()); 
       Set<string> BenIds = new Set<string>();
       for(QIPP_Benefit__c  BIds : Benifits  ){
           BenIds.add(BIds.id);
       }

        // Fixed Header Columns 
        csvFileHeader = 'QIPP Project: Project ID'+','+'Methodology'+','+'Project Name - Succinct Project'+','+'Description'+','+'Portfolio Name'+','+'Portfolio Owner'+','+'Portfolio Owner Email'+','+'Benefitting Project BU'+','+'Benefitting Project BL (Level 3 Org)'+','+'Benefitting Project BL (Level 4 Org)'+','+'Project Lead: Contact Name'+','+'Project Lead: Email'+','+'Project Lead BU'+','+'Project Lead BL (Level 3 Org)'+','+'Project Lead BL (Level 4 Org)'+','+'Project State'+','+'Project Created Date'+','+'Project Start Date - Planned'+','+'Project Start Date - Actual'+','+'Target Completion Date'+','+'Forecast'+','+'Actual'+','+'Market'+','+'Region / GCBT'+','+'Sub-Region / CBT'+','+'CT'+','+'Country'+','+'Belt Project Type'+','+'Belt Project Phase'+','+'Project Champion'+','+'Belt Project Champion Email'+','+'Belt Project Sponsor'+','+'Belt Project Sponsor Email'+','+'Business Unit Master Black Belt'+','+'Business Unit Master Black Belt Email'+','+'Belt Candidate Mentor'+','+'Belt Candidate Mentor Email'+','+'Finance Approver'+','+'Finance Approver Email'+','+'Belt Candidate Location'+','+'Define Date ? Planned'+','+'Define Date - Forecast'+','+'Define Date ? Current'+','+'Define Status'+','+'Measure Date ? Planned'+','+'Measure Date - Forecast'+','+'Measure Date ? Current'+','+'Measure Status'+','+'Analyze Date ? Planned'+','+'Analyze Date - Forecast'+','+'Analyze Date ? Current'+','+'Analyze Status'+','+'Improve / Design Date ? Planned'+','+'Improve / Design Date ? Forecast'+','+'Improve / Design Date ? Current'+','+'Improve / Design Status'+','+'Control / Verify Date ? Planned'+','+'Control / Verify Date ? Forecast'+','+'Control / Verify Date ?'+','+'Current Control / Verify Status'+','+'Project Type'+','+'Project Owner'+','+'Project Owner Email'+','+'DI State'+','+'Improvement Measure (KPI)'+','+'Improvement Measure Grouping';
        system.debug('csvFileValues :: '+ csvFileValues);
        
                
        //list<String> years = new list<String>(sortyears);
        Set<String> sortyears = new Set<String>();
        map<string, set<string> > qtryrmap = new map<string, set<string>>();
        
        Map<String,list<QIPP_BU_Reporting__c>> repMap = new Map<String,list<QIPP_BU_Reporting__c>>();

        for(QIPP_BU_Reporting__c Benyr : [select ID,                                 
                            Project_ID__c,
                            Benefit_ID__c,
                            Benefit_Type__c,
                            Benefit_Condition__c,
                            Quarters__c,
                            Years__c,
                            Months__c,
                            Improvment_Amount__c,
                            Achieved_Amount__c,
                            Future_Saving_Amount__c,
                            Planned_Financial_Savings_k__c,
                            Achieved_Financial_Savings_k__c,
                            Future_Financial_Savings_k__c,
                            Planned_Operational_Savings_k__c,
                            Achieved_Operational_Savings_k__c,
                            Future_Operational_Savings_k__c,
                            Entry_Type__c
                        from QIPP_BU_Reporting__c  where Benefit_ID__c in: BenIds and Quarters__c != null and Months__c != null]){
                        
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
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Planned Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Planned:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Planned Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Planned:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Planned Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Planned:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Planned Financial Savings (k€)';
            }
            //Financial Achieved savings
            if(stringset1.contains('Financial Savings:Achieved:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Achieved Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Achieved Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Achieved Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Achieved Financial Savings (k€)';
            }
            //Financial Future savings
            if(stringset1.contains('Financial Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Future Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Future Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Future Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Future Financial Savings (k€)';
            }
            //LE Financial Savings
            if(stringset1.contains('Financial Savings:Achieved:Q1') || stringset1.contains('Financial Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'LE Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q2') || stringset1.contains('Financial Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'LE Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q3') || stringset1.contains('Financial Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'LE Financial Savings (k€)';
            }
            if(stringset1.contains('Financial Savings:Achieved:Q4') || stringset1.contains('Financial Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'LE Financial Savings (k€)';
            }
            
            // For Operational Savings
            
            //Operational Planned savings
            if(stringset1.contains('Operational Savings:Planned:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Planned Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Planned:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Planned Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Planned:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Planned Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Planned:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Planned Operational Savings (k€)';
            }
            //Operational Achieved savings
            if(stringset1.contains('Operational Savings:Achieved:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Achieved Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Achieved Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Achieved Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Achieved Operational Savings (k€)';
            }
            //Operational Future savings
            if(stringset1.contains('Operational Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'Future Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'Future Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'Future Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'Future Operational Savings (k€)';
            }
            //LE Financial Savings
            if(stringset1.contains('Operational Savings:Achieved:Q1') || stringset1.contains('Operational Savings:Future:Q1')){
                csvFileHeader = csvFileHeader + ','+'Q1'+' '+yr+' '+'LE Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q2') || stringset1.contains('Operational Savings:Future:Q2')){
                csvFileHeader = csvFileHeader + ','+'Q2'+' '+yr+' '+'LE Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q3') || stringset1.contains('Operational Savings:Future:Q3')){
                csvFileHeader = csvFileHeader + ','+'Q3'+' '+yr+' '+'LE Operational Savings (k€)';
            }
            if(stringset1.contains('Operational Savings:Achieved:Q4') || stringset1.contains('Operational Savings:Future:Q4')){
                csvFileHeader = csvFileHeader + ','+'Q4'+' '+yr+' '+'LE Operational Savings (k€)';
            }
        }
        system.debug('csvFileHeader :: '+ csvFileHeader); 

        for(QIPP_Benefit__c Benft : Benifits){
        
            list<QIPP_BU_Reporting__c> QIPPRep1= repMap.get(Benft.id);
            
            if(csvFileValues == null){

                csvFileValues  = '\n';
                if(String.isNotBlank(Benft.Project_ID__r.name)){
                    csvFileValues  = csvFileValues +Benft.Project_ID__r.name.replaceAll(',', '');
                }else{
                    csvFileValues  = csvFileValues +'';
                }
            }else{
                if(String.isNotBlank(Benft.Project_ID__r.name)){
                    csvFileValues  = csvFileValues+'\n'+Benft.Project_ID__r.name.replaceAll(',', '');
                }else{
                    csvFileValues  = csvFileValues+'\n'+'';
                }
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Type__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Type__c.replaceAll('null', '');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            //csvFileValues = csvFileValues+','+Benft.Project_ID__r.Project_Type__c;
                
            if(String.isNotBlank(Benft.Project_ID__r.Project_Name_Succinct__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Name_Succinct__c.replaceAll(',', '');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }

            if(String.isNotBlank(Benft.Project_ID__r.Project_Description_Detailed__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Description_Detailed__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Portfolio_Name__r.Name+','+Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.name+','+Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.Email__c;
            
            if(String.isNotBlank(Benft.Project_ID__r.Portfolio_BU__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Portfolio_BU__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_BL__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_BL__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Benefitting_Project_BL_Level_4_Org__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Benefitting_Project_BL_Level_4_Org__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Lead__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Lead__r.name.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Lead__r.Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Lead__r.Email__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            //csvFileValues  = csvFileValues+','+Benft.Project_ID__r.Project_Lead__r.name+','+Benft.Project_ID__r.Project_Lead__r.Email__c;
            if(String.isNotBlank(Benft.Project_ID__r.Project_Lead__r.Contact_BU__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Lead__r.Contact_BU__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Lead__r.Contact_BL__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Lead__r.Contact_BL__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Lead__r.Contact_L4_Org__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Lead__r.Contact_L4_Org__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_State__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_State__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            //csvFileValues  = csvFileValues+','+Benft.Project_ID__r.Project_State__c;

            if(Benft.Project_ID__r.Project_Created_Date__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Created_Date__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }

            if(Benft.Project_ID__r.Planned_Start_Date__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Planned_Start_Date__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Project_Start_Date__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Start_Date__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }

            if(Benft.Project_ID__r.Project_Completion_Date_Target__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Completion_Date_Target__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Project_Completion_Date_Forecast__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Completion_Date_Forecast__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Project_Completion_Date_Actual__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Completion_Date_Actual__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Market__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Market__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Region_GCBT__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Region_GCBT__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Sub_Region_CBT__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Sub_Region_CBT__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.CT__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.CT__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Country__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Country__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Project_Type__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Project_Type__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Project_Phase__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Project_Phase__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Project_Champion__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Project_Champion__r.name.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Project_Champion__r.Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Project_Champion__r.Email__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Project_Sponsor__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Project_Sponsor__r.name.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Project_Sponsor_Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Project_Sponsor_Email__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Business_Unit_Master_Black_Belt__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Business_Unit_Master_Black_Belt__r.name.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Business_Unit_Master_Black_Belt_Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Business_Unit_Master_Black_Belt_Email__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Candidate_Mentor__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Candidate_Mentor__r.name.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Candidate_Mentor_Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Candidate_Mentor_Email__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Finance_Approver__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Finance_Approver__r.name.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Finance_Approver_Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Finance_Approver_Email__c.replaceAll('null','');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Belt_Candidate_Location__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Belt_Candidate_Location__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.DMAIC_Define__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.DMAIC_Define__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Define_Date_Forecast__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Define_Date_Forecast__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Define_Date_Current__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Define_Date_Current__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Define_Status__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Define_Status__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }

            //csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Define_Status__c;

            if(Benft.Project_ID__r.DMAIC_Measure__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.DMAIC_Measure__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Measure_Date_Forecast__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Measure_Date_Forecast__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Measure_Date_Current__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Measure_Date_Current__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Measure_Status__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Measure_Status__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
           // csvFileValues  = csvFileValues  +','+Benft.Project_ID__r.Measure_Status__c;

            if(Benft.Project_ID__r.DMAIC_Analyze__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.DMAIC_Analyze__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Analyze_Date_Forecast__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Analyze_Date_Forecast__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Analyze_Date_Current__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Analyze_Date_Current__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Analyze_Status__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Analyze_Status__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
           // csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Analyze_Status__c;

            if(Benft.Project_ID__r.DMAIC_Improve__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.DMAIC_Improve__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Improve_Design_Date_Forecast__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Improve_Design_Date_Forecast__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Improve_Date_Current__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Improve_Date_Current__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }

            if(String.isNotBlank(Benft.Project_ID__r.Improve_Status__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Improve_Status__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            //csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Improve_Status__c;

            if(Benft.Project_ID__r.DMAIC_Control__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.DMAIC_Control__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Control_Verify_Date_Forecast__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Control_Verify_Date_Forecast__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(Benft.Project_ID__r.Control_Date_Current__c != null){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Control_Date_Current__c.format();
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Control_Status__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Control_Status__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Lean_Project_Type__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Lean_Project_Type__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Owner__r.name)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Owner__r.name.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Project_ID__r.Project_Owner__r.Email__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Owner__r.Email__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            //csvFileValues  = csvFileValues  +','+Benft.Project_ID__r.Control_Status__c+','+Benft.Project_ID__r.Lean_Project_Type__c+','+Benft.Project_ID__r.Project_Owner__r.name+','+Benft.Project_ID__r.Project_Owner__r.Email__c;
            
            if(String.isNotBlank(Benft.Project_ID__r.DI_State__c)){
                csvFileValues  = csvFileValues +','+Benft.Project_ID__r.DI_State__c.replaceAll(',', ':');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            if(String.isNotBlank(Benft.Improvement_Measure_KPI__r.Name)){
                csvFileValues  = csvFileValues +','+Benft.Improvement_Measure_KPI__r.Name.replaceAll(',', '');
            }else{
                csvFileValues  = csvFileValues  +','+'';
            }
            csvFileValues  = csvFileValues+','+Benft.Improvement_Measure_KPI__r.Improvement_Measure_Grouping__c;

            for(string yrs :years){
                Decimal PFQ1 = 0.0;
                Decimal PFQ2 = 0.0;
                Decimal PFQ3 = 0.0;
                Decimal PFQ4 = 0.0;
                Decimal AFQ1 = 0.0;
                Decimal AFQ2 = 0.0;
                Decimal AFQ3 = 0.0;
                Decimal AFQ4 = 0.0;
                Decimal FFQ1 = 0.0;
                Decimal FFQ2 = 0.0;
                Decimal FFQ3 = 0.0;
                Decimal FFQ4 = 0.0;
                Decimal LEFQ1 = 0.0;
                Decimal LEFQ2 = 0.0;
                Decimal LEFQ3 = 0.0;
                Decimal LEFQ4 = 0.0;
                
                Decimal POQ1 = 0.0;
                Decimal POQ2 = 0.0;
                Decimal POQ3 = 0.0;
                Decimal POQ4 = 0.0;
                Decimal AOQ1 = 0.0;
                Decimal AOQ2 = 0.0;
                Decimal AOQ3 = 0.0;
                Decimal AOQ4 = 0.0;
                Decimal FOQ1 = 0.0;
                Decimal FOQ2 = 0.0;
                Decimal FOQ3 = 0.0;
                Decimal FOQ4 = 0.0;
                Decimal LEOQ1 = 0.0;
                Decimal LEOQ2 = 0.0;
                Decimal LEOQ3 = 0.0;
                Decimal LEOQ4 = 0.0;  
                
                String TempSaveings = null;   
                if(QIPPRep1 != null){    
                    for(QIPP_BU_Reporting__c  Bensav : QIPPRep1){
                    
                       // For Financial Savings
                       if(Bensav.Benefit_ID__c == Benft.id && Bensav.Years__c == yrs && Benft.Benefit_Type__c == 'Financial Savings'){
                            
                            // Quarterly Financial Palnned savings
                            if(Bensav.Quarters__c == 'Q1' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Financial_Savings_k__c != null){
                                    PFQ1 = PFQ1 + Bensav.Planned_Financial_Savings_k__c;
                                }
                            }
                            if(Bensav.Quarters__c == 'Q2' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Financial_Savings_k__c != null){
                                    PFQ2 = PFQ2 + Bensav.Planned_Financial_Savings_k__c;
                                }
                            }
                            if(Bensav.Quarters__c == 'Q3' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Financial_Savings_k__c != null){
                                    PFQ3 = PFQ3 + Bensav.Planned_Financial_Savings_k__c;
                                }
                            }
                            if(Bensav.Quarters__c == 'Q4' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Financial_Savings_k__c != null){
                                    PFQ4 = PFQ4 + Bensav.Planned_Financial_Savings_k__c;
                                }
                            }
                            // Quarterly Financial Achieved savings
                            if(Bensav.Quarters__c == 'Q1' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Financial_Savings_k__c != null){
                                    AFQ1 = AFQ1 + Bensav.Achieved_Financial_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q2' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Financial_Savings_k__c != null){
                                    AFQ2 = AFQ2 + Bensav.Achieved_Financial_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q3' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Financial_Savings_k__c != null){
                                    AFQ3 = AFQ3 + Bensav.Achieved_Financial_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q4' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Financial_Savings_k__c != null){
                                    AFQ4 = AFQ4 + Bensav.Achieved_Financial_Savings_k__c;
                                }  
                            }
                                                    
                            // Quarterly Financial Future savings
                            if(Bensav.Quarters__c == 'Q1' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Financial_Savings_k__c != null){
                                    FFQ1 = FFQ1 + Bensav.Future_Financial_Savings_k__c;
                                }     
                            }
                            if(Bensav.Quarters__c == 'Q2' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Financial_Savings_k__c != null){
                                    FFQ2 = FFQ2 + Bensav.Future_Financial_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q3' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Financial_Savings_k__c != null){
                                    FFQ3 = FFQ3 + Bensav.Future_Financial_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q4' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Financial_Savings_k__c != null){
                                    FFQ4 = FFQ4 + Bensav.Future_Financial_Savings_k__c;
                                }  
                            }
                                                   
                        }
                        //For Operational Savings
                        if(Bensav.Benefit_ID__c == Benft.id && Bensav.Years__c == yrs && Benft.Benefit_Type__c == 'Operational Savings'){
                            // Quarterly Operational Palnned savings
                            if(Bensav.Quarters__c == 'Q1' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Operational_Savings_k__c!= null){
                                    POQ1 = POQ1 + Bensav.Planned_Operational_Savings_k__c;
                                }
                            }
                            if(Bensav.Quarters__c == 'Q2' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Operational_Savings_k__c!= null){
                                    POQ2 = POQ2 + Bensav.Planned_Operational_Savings_k__c;
                                }
                            }
                            if(Bensav.Quarters__c == 'Q3' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Operational_Savings_k__c!= null){
                                    POQ3 = POQ3 + Bensav.Planned_Operational_Savings_k__c;
                                }
                            }
                            if(Bensav.Quarters__c == 'Q4' && Bensav.Benefit_Condition__c == 'Planned'){
                                if(Bensav.Planned_Operational_Savings_k__c!= null){
                                    POQ4 = POQ4 + Bensav.Planned_Operational_Savings_k__c;
                                }
                            }
                            // Quarterly Operational Achieved savings
                            if(Bensav.Quarters__c == 'Q1' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Operational_Savings_k__c!= null){
                                    AOQ1 = AOQ1 + Bensav.Achieved_Operational_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q2' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Operational_Savings_k__c!= null){
                                    AOQ2 = AOQ2 + Bensav.Achieved_Operational_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q3' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Operational_Savings_k__c!= null){
                                    AOQ3 = AOQ3 + Bensav.Achieved_Operational_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q4' && Bensav.Benefit_Condition__c == 'Achieved'){
                                if(Bensav.Achieved_Operational_Savings_k__c!= null){
                                    AOQ4 = AOQ4 + Bensav.Achieved_Operational_Savings_k__c;
                                }  
                            }
                            // Quarterly Operational Future savings
                            if(Bensav.Quarters__c == 'Q1' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Operational_Savings_k__c!= null){
                                    FOQ1 = FOQ1 + Bensav.Future_Operational_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q2' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Operational_Savings_k__c!= null){
                                    FOQ2 = FOQ2 + Bensav.Future_Operational_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q3' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Operational_Savings_k__c!= null){
                                    FOQ3 = FOQ3 + Bensav.Future_Operational_Savings_k__c;
                                }  
                            }
                            if(Bensav.Quarters__c == 'Q4' && Bensav.Benefit_Condition__c == 'Future'){
                                if(Bensav.Future_Operational_Savings_k__c!= null){
                                    FOQ4 = FOQ4 + Bensav.Future_Operational_Savings_k__c;
                                }  
                            }
                        }
                    }
                    
                }
                
                // Financial LE(Achieved + Future)
                LEFQ1 = AFQ1.round(roundingMode.DOWN) + FFQ1.round(roundingMode.DOWN);
                LEFQ2 = AFQ2.round(roundingMode.DOWN) + FFQ2.round(roundingMode.DOWN);
                LEFQ3 = AFQ3.round(roundingMode.DOWN) + FFQ3.round(roundingMode.DOWN);
                LEFQ4 = AFQ4.round(roundingMode.DOWN) + FFQ4.round(roundingMode.DOWN);
                // Operational LE(Achieved + Future)
                LEOQ1 = AOQ1.round(roundingMode.DOWN) + FOQ1.round(roundingMode.DOWN);
                LEOQ2 = AOQ2.round(roundingMode.DOWN) + FOQ2.round(roundingMode.DOWN);
                LEOQ3 = AOQ3.round(roundingMode.DOWN) + FOQ3.round(roundingMode.DOWN);
                LEOQ4 = AOQ4.round(roundingMode.DOWN) + FOQ4.round(roundingMode.DOWN);
                
                string sPFQ1 = String.valueOf(PFQ1.round(roundingMode.DOWN));
                string sPFQ2 = String.valueOf(PFQ2.round(roundingMode.DOWN));
                string sPFQ3 = String.valueOf(PFQ3.round(roundingMode.DOWN));
                string sPFQ4 = String.valueOf(PFQ4.round(roundingMode.DOWN));
                string sAFQ1 = String.valueOf(AFQ1.round(roundingMode.DOWN));
                string sAFQ2 = String.valueOf(AFQ2.round(roundingMode.DOWN));
                string sAFQ3 = String.valueOf(AFQ3.round(roundingMode.DOWN));
                string sAFQ4 = String.valueOf(AFQ4.round(roundingMode.DOWN));
                string sFFQ1 = String.valueOf(FFQ1.round(roundingMode.DOWN));
                string sFFQ2 = String.valueOf(FFQ2.round(roundingMode.DOWN));
                string sFFQ3 = String.valueOf(FFQ3.round(roundingMode.DOWN));
                string sFFQ4 = String.valueOf(FFQ4.round(roundingMode.DOWN));
                string sLEFQ1 = String.valueOf(LEFQ1.format());
                string sLEFQ2 = String.valueOf(LEFQ2.format());
                string sLEFQ3 = String.valueOf(LEFQ3.format());
                string sLEFQ4 = String.valueOf(LEFQ4.format());

                string sPOQ1 = String.valueOf(POQ1.round(roundingMode.DOWN));
                string sPOQ2 = String.valueOf(POQ2.round(roundingMode.DOWN));
                string sPOQ3 = String.valueOf(POQ3.round(roundingMode.DOWN));
                string sPOQ4 = String.valueOf(POQ4.round(roundingMode.DOWN));
                string sAOQ1 = String.valueOf(AOQ1.round(roundingMode.DOWN));
                string sAOQ2 = String.valueOf(AOQ2.round(roundingMode.DOWN));
                string sAOQ3 = String.valueOf(AOQ3.round(roundingMode.DOWN));
                string sAOQ4 = String.valueOf(AOQ4.round(roundingMode.DOWN));
                string sFOQ1 = String.valueOf(FOQ1.round(roundingMode.DOWN));
                string sFOQ2 = String.valueOf(FOQ2.round(roundingMode.DOWN));
                string sFOQ3 = String.valueOf(FOQ3.round(roundingMode.DOWN));
                string sFOQ4 = String.valueOf(FOQ4.round(roundingMode.DOWN));
                string sLEOQ1 = String.valueOf(LEOQ1.format());
                string sLEOQ2 = String.valueOf(LEOQ2.format());
                string sLEOQ3 = String.valueOf(LEOQ3.format());
                string sLEOQ4 = String.valueOf(LEOQ4.format());  
                    
              // Temparely storing saveings values
              
                Set<String> stringset2= qtryrmap.get(yrs);
                TempSaveings = ',';
                // For Financial Savings
                //Financial Palnned savings
                if(stringset2.contains('Financial Savings:Planned:Q1')){
                    TempSaveings = TempSaveings +sPFQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Planned:Q2')){
                    TempSaveings = TempSaveings +sPFQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Planned:Q3')){
                    TempSaveings = TempSaveings +sPFQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Planned:Q4')){
                    TempSaveings = TempSaveings +sPFQ4.replaceAll(',', '')+',';
                }
                //Financial Achieved savings
                if(stringset2.contains('Financial Savings:Achieved:Q1')){
                    TempSaveings = TempSaveings +sAFQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Achieved:Q2')){
                    TempSaveings = TempSaveings +sAFQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Achieved:Q3')){
                    TempSaveings = TempSaveings +sAFQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Achieved:Q4')){
                    TempSaveings = TempSaveings +sAFQ4.replaceAll(',', '')+',';
                }
                //Financial Future savings
                if(stringset2.contains('Financial Savings:Future:Q1')){
                    TempSaveings = TempSaveings +sFFQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Future:Q2')){
                    TempSaveings = TempSaveings +sFFQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Future:Q3')){
                    TempSaveings = TempSaveings +sFFQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Future:Q4')){
                    TempSaveings = TempSaveings +sFFQ4.replaceAll(',', '')+',';
                }
                //LE Financial Savings
                if(stringset2.contains('Financial Savings:Achieved:Q1') || stringset2.contains('Financial Savings:Future:Q1')){
                    TempSaveings = TempSaveings +sLEFQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Achieved:Q2') || stringset2.contains('Financial Savings:Future:Q2')){
                    TempSaveings = TempSaveings +sLEFQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Achieved:Q3') || stringset2.contains('Financial Savings:Future:Q3')){
                    TempSaveings = TempSaveings +sLEFQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Financial Savings:Achieved:Q4') || stringset2.contains('Financial Savings:Future:Q4')){
                    TempSaveings = TempSaveings +sLEFQ4.replaceAll(',', '')+',';
                }
            
                // For Operational Savings
                //Operational Planned savings
                if(stringset2.contains('Operational Savings:Planned:Q1')){
                    TempSaveings = TempSaveings +sPOQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Planned:Q2')){
                    TempSaveings = TempSaveings +sPOQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Planned:Q3')){
                    TempSaveings = TempSaveings +sPOQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Planned:Q4')){
                    TempSaveings = TempSaveings +sPOQ4.replaceAll(',', '')+',';
                }
                //Operational Achieved savings
                if(stringset2.contains('Operational Savings:Achieved:Q1')){
                    TempSaveings = TempSaveings +sAOQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Achieved:Q2')){
                    TempSaveings = TempSaveings +sAOQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Achieved:Q3')){
                    TempSaveings = TempSaveings +sAOQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Achieved:Q4')){
                    TempSaveings = TempSaveings +sAOQ4.replaceAll(',', '')+',';
                }
                //Operational Future savings
                if(stringset2.contains('Operational Savings:Future:Q1')){
                    TempSaveings = TempSaveings +sFOQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Future:Q2')){
                    TempSaveings = TempSaveings +sFOQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Future:Q3')){
                    TempSaveings = TempSaveings +sFOQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Future:Q4')){
                    TempSaveings = TempSaveings +sFOQ4.replaceAll(',', '')+',';
                }
                //LE Financial Savings
                if(stringset2.contains('Operational Savings:Achieved:Q1') || stringset2.contains('Operational Savings:Future:Q1')){
                    TempSaveings = TempSaveings +sLEOQ1.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Achieved:Q2') || stringset2.contains('Operational Savings:Future:Q2')){
                    TempSaveings = TempSaveings +sLEOQ2.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Achieved:Q3') || stringset2.contains('Operational Savings:Future:Q3')){
                    TempSaveings = TempSaveings +sLEOQ3.replaceAll(',', '')+',';
                }
                if(stringset2.contains('Operational Savings:Achieved:Q4') || stringset2.contains('Operational Savings:Future:Q4')){
                    TempSaveings = TempSaveings +sLEOQ4.replaceAll(',', '');
                }
                TempSaveings  = TempSaveings.removeEnd(',');
               // TempSaveings  = TempSaveings.replaceAll('null',' ');
                //Main CSV File Values
               // .replaceAll(',', ':');
                csvFileValues = csvFileValues+TempSaveings ;
            }
        }
        
        system.debug('csvFileHeader :: ' + csvFileHeader);
        system.debug('csvFileValues :: ' + csvFileValues);
    
     //*******************************************Email Send ***************************
       /* if(emailTo== '' || emailTo== null || emailTo.length() == 0 ){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address'));
           system.debug('enter Valide Email :: ' + emailTo );
        }
        if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', emailTo) ){
             emailError ='Either first name or middle name must be defined';
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Check your email and Enter Valid Email Address')); 
             system.debug('Check your email :: ' + emailTo );
        }
        */
        system.debug('emailTo :: ' + emailTo );
        system.debug('emailTo :: ' + emailTo.length() );
        system.debug('csvFileHeader :: ' + csvFileHeader);
        system.debug('csvFileValues :: ' + csvFileValues);    
        
        system.debug('csvFile Before:: '+ csvFile ); 
        
        csvFile = csvFileHeader + csvFileValues;
        
        system.debug('csvFile after :: ' +csvFile );         
        
        try {
            Blob b =Blob.valueOf(csvFile );
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(m+' : Project & Benefit Short_Term_Report.csv');
            efa.setBody(b);
            
            List<Messaging.SingleEmailMessage> mailsList = new List<Messaging.SingleEmailMessage>();
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setToAddresses(new String[] {emailTo });        
            mail.setSenderDisplayName('Report Processing');
            mail.setSubject('Project & Benefit Process Completed');
            mail.setPlainTextBody('Please find the attachment of Project & Benefit Records');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});     
            
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            if(resultMail[0].isSuccess())       
                response = 'ok sent!';
            else{
                response = resultMail[0].getErrors().get(0).getMessage();
            }
            System.debug('-------------------------------------- Email sent status : ' + resultMail[0].isSuccess());
            system.debug('csvFile Sent :: ');     
             system.debug('Benifits size :: '+ Benifits.size());
        } 
        catch(System.DMLException e){
            response = e.getMessage();
            ApexPages.addMessages(e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error'+e));
        }
        return null;
    }
}