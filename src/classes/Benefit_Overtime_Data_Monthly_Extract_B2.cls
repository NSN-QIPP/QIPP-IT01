global class Benefit_Overtime_Data_Monthly_Extract_B2 implements Database.Batchable<sobject> ,Database.Stateful{
    //public string emailTo = 'srikanthreddy.vennapusa@igate.com';
    //public  list<QIPP_Benefit__c> Benifits = new list<QIPP_Benefit__c>();
    //public  list<QIPP_BU_Reporting__c> Benft_reps = new List<QIPP_BU_Reporting__c>();
    //public list<QIPP_Project__c> projects = new list<QIPP_Project__c>();
    public String query;
    public String response {get; set;}
    public datetime m=system.now(); 
    public string emailTo;
    public string csvFileHeader;
    public datetime fromdate;
    public datetime todate ;
    public list<string> years = new list<string>();
    public map<string, set<string> > monthrmap = new map<string, set<string>>();
    String csvFileValues;
    string projectvalues;
    String csvFile;
        
    global Benefit_Overtime_Data_Monthly_Extract_B2 (string emailto,string csvFileHeader,list<string> years, map<string,set<string>> monthrmap,datetime fdate,datetime tdate){
        this.emailTo = emailTo;    
        this.csvFileHeader = csvFileHeader;
        this.years = years;  
        this.monthrmap = monthrmap;  
        this.fromdate = fdate ;
        this.todate = tdate ; 
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
            System.debug('Email to snd : ' +emailTo);
            system.debug('years:: '+ years); 
            System.debug('keys in the map: ' + monthrmap.keySet());
            System.debug('list of values in the map : ' + monthrmap.values());
            System.debug('year values in the map : ' + monthrmap.get('2015'));
            system.debug('csvFileHeader:: '+ csvFileHeader); 
        return Database.getQueryLocator(query);     
    }
    
    global void execute(Database.BatchableContext BC,list<QIPP_Project__c> Lds){     
        Map<String,list<QIPP_Benefit__c>> benMap = new Map<String,list<QIPP_Benefit__c>>();
        Map<String,list<QIPP_BU_Reporting__c>> repMap = new Map<String,list<QIPP_BU_Reporting__c>>();
        list<id> prjids = new list<id>();
        Set<string> BenIds = new Set<string>();
        System.debug('Email to snd : ' +emailTo);
        
        for(QIPP_Project__c projt : Lds){
            prjids.add(projt.id);
        }
        
        for(QIPP_Benefit__c  BIds : [select ID , Name ,Benefit_Type__c,Project_ID__r.name,Project_ID__r.Project_Type__c,Project_ID__r.Project_Name_Succinct__c,Project_ID__r.Project_Description_Detailed__c,Project_ID__r.Portfolio_Name__r.Name,Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.name,Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.Email__c,Project_ID__r.Portfolio_BU__c,Project_ID__r.Project_BL__c,Project_ID__r.Benefitting_Project_BL_Level_4_Org__c,Project_ID__r.Project_Lead__r.name,Project_ID__r.Project_Lead__r.Email__c,Project_ID__r.Project_Lead__r.Contact_BU__c,Project_ID__r.Project_Lead__r.Contact_BL__c,Project_ID__r.Project_Lead__r.Contact_L4_Org__c,Project_ID__r.Project_State__c,Project_ID__r.Project_Created_Date__c,Project_ID__r.Planned_Start_Date__c,Project_ID__r.Project_Start_Date__c,Project_ID__r.Project_Completion_Date_Target__c,Project_ID__r.Project_Completion_Date_Forecast__c,Project_ID__r.Project_Completion_Date_Actual__c,Project_ID__r.Market__c,Project_ID__r.Region_GCBT__c,Project_ID__r.Sub_Region_CBT__c,Project_ID__r.CT__c,Project_ID__r.Country__c,Project_ID__r.Belt_Project_Type__c,Project_ID__r.Belt_Project_Phase__c,Project_ID__r.Belt_Project_Champion__r.name,Project_ID__r.Belt_Project_Champion__r.Email__c,Project_ID__r.Belt_Project_Sponsor__r.name,Project_ID__r.Belt_Project_Sponsor_Email__c,Project_ID__r.Business_Unit_Master_Black_Belt__r.name,Project_ID__r.Business_Unit_Master_Black_Belt_Email__c,Project_ID__r.Belt_Candidate_Mentor__r.name,Project_ID__r.Belt_Candidate_Mentor_Email__c,Project_ID__r.Finance_Approver__r.name,Project_ID__r.Finance_Approver_Email__c,Project_ID__r.Belt_Candidate_Location__c,Project_ID__r.DMAIC_Define__c,Project_ID__r.Define_Date_Forecast__c,Project_ID__r.Define_Date_Current__c,Project_ID__r.Define_Status__c,Project_ID__r.DMAIC_Measure__c,Project_ID__r.Measure_Date_Forecast__c,Project_ID__r.Measure_Date_Current__c,Project_ID__r.Measure_Status__c,Project_ID__r.DMAIC_Analyze__c,Project_ID__r.Analyze_Date_Forecast__c,Project_ID__r.Analyze_Date_Current__c,Project_ID__r.Analyze_Status__c,Project_ID__r.DMAIC_Improve__c,Project_ID__r.Improve_Design_Date_Forecast__c,Project_ID__r.Improve_Date_Current__c,Project_ID__r.Improve_Status__c,Project_ID__r.DMAIC_Control__c,Project_ID__r.Control_Verify_Date_Forecast__c,Project_ID__r.Control_Date_Current__c,Project_ID__r.Control_Status__c,Project_ID__r.Lean_Project_Type__c,Project_ID__r.Project_Owner__r.name,Project_ID__r.Project_Owner__r.Email__c,Project_ID__r.DI_State__c,Improvement_Measure_KPI__r.Name,Improvement_Measure_KPI__r.Improvement_Measure_Grouping__c,Project_ID__r.Progress_To_Date__c,Project_ID__r.Next_Steps__c,Project_ID__r.MO_Site__c,Project_ID__r.Lean_Project_Phase__c,Project_ID__r.Not_Started_Date__c,Project_ID__r.In_Progress_Date__c,Project_ID__r.On_Hold_Date__c,Project_ID__r.Canceled_Date__c,Project_ID__r.Closed_Date__c,Project_ID__r.Portfolio_Name__r.Portfolio_Status__c,Project_ID__r.Lean_Coach__r.name,Project_ID__r.Lean_Coach__r.email__c,Project_ID__r.Lean__c,Project_ID__r.Number_of_Kaizens__c,Project_ID__r.Project_Flex_Field_1__c,Project_ID__r.Project_Flex_Field_2__c,Project_ID__r.Project_Flex_Field_3__c,Project_ID__r.Sharenet_Link__c,Project_ID__r.Schedule_Status__c,Project_ID__r.Project_Lead_Location__c,Planned_Financial_Savings_Total__c,Achieved_Financial_Savings_Total__c,Future_Financial_Savings_Total__c,Benefit_Amount_Achieved_Future_k__c,Planned_Operational_Savings_Total__c,Achieved_Operational_Savings_Total__c,Future_Operational_Savings_Total__c,Benefit_Operational_Achieved_Future_k__c from QIPP_Benefit__c where Project_ID__c in :prjids]){
            if(!benMap.containsKey(BIds.Project_ID__c)){
                benMap.put(BIds.Project_ID__c, new list<QIPP_Benefit__c>{BIds});
            }else{
                benMap.get(BIds.Project_ID__c).add(BIds);
            }
            BenIds.add(BIds.id);
        }
        System.debug('BenIds = : '+BenIds.size());
        for(QIPP_BU_Reporting__c Benyr : [select ID,Project_ID__c,Benefit_ID__c,Benefit_Type__c,Benefit_Condition__c,Quarters__c,Years__c,Months__c,Improvment_Amount__c,Achieved_Amount__c,Future_Saving_Amount__c,Planned_Financial_Savings_k__c,Achieved_Financial_Savings_k__c,Future_Financial_Savings_k__c,Planned_Operational_Savings_k__c,Achieved_Operational_Savings_k__c,Future_Operational_Savings_k__c,Entry_Type__c from QIPP_BU_Reporting__c  where Project_ID__c in: prjids and Months__c != null ]){
            if(!repMap.containsKey(Benyr.Benefit_ID__c)){
                repMap.put(Benyr.Benefit_ID__c, new list<QIPP_BU_Reporting__c>{Benyr});
            }else{
                repMap.get(Benyr.Benefit_ID__c).add(Benyr);
            }
        }   
        //CSV values
        for(QIPP_Project__c projt : Lds){
            list<QIPP_Benefit__c> benRep1= benMap.get(projt.id);
            If(benRep1 == null){
                // Projects without Benefits
                if(projectvalues == null){
                    projectvalues  = '\n';
                    if(String.isNotBlank(projt.name)){
                        projectvalues  = projectvalues +projt.name.replaceAll(',', '');
                    }else{
                        projectvalues  = projectvalues +'';
                    }
                }else{
                    if(String.isNotBlank(projt.name)){
                        projectvalues  = projectvalues+'\n'+projt.name.replaceAll(',', '');
                    }else{
                        projectvalues  = projectvalues+'\n'+'';
                    }
                }
                if(String.isNotBlank(projt.Project_Type__c)){
                    projectvalues  = projectvalues +','+projt.Project_Type__c.replaceAll('null', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Name_Succinct__c)){
                    projectvalues  = projectvalues +','+projt.Project_Name_Succinct__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Description_Detailed__c)){
                    projectvalues  = projectvalues +','+projt.Project_Description_Detailed__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Portfolio_Name__r.Name)){
                    projectvalues  = projectvalues +','+projt.Portfolio_Name__r.Name.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Portfolio_Name__r.Portfolio_Status__c)){
                    projectvalues  = projectvalues +','+projt.Portfolio_Name__r.Portfolio_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }               
                if(String.isNotBlank(projt.Portfolio_Name__r.Portfolio_Owner__r.name)){
                projectvalues  = projectvalues +','+projt.Portfolio_Name__r.Portfolio_Owner__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                projectvalues  = projectvalues+','+projt.Portfolio_Name__r.Portfolio_Owner__r.Email__c;
                
                if(String.isNotBlank(projt.Portfolio_BU__c)){
                    projectvalues  = projectvalues +','+projt.Portfolio_BU__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_BL__c)){
                    projectvalues  = projectvalues +','+projt.Project_BL__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Benefitting_Project_BL_Level_4_Org__c)){
                    projectvalues  = projectvalues +','+projt.Benefitting_Project_BL_Level_4_Org__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Lead__r.name)){
                    projectvalues  = projectvalues +','+projt.Project_Lead__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Lead__r.Email__c)){
                    projectvalues  = projectvalues +','+projt.Project_Lead__r.Email__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                //projectvalues  = projectvalues+','+projt.Project_Lead__r.name+','+projt.Project_Lead__r.Email__c;
                if(String.isNotBlank(projt.Project_Lead__r.Contact_BU__c)){
                    projectvalues  = projectvalues +','+projt.Project_Lead__r.Contact_BU__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Lead__r.Contact_BL__c)){
                    projectvalues  = projectvalues +','+projt.Project_Lead__r.Contact_BL__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Lead__r.Contact_L4_Org__c)){
                    projectvalues  = projectvalues +','+projt.Project_Lead__r.Contact_L4_Org__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_State__c)){
                    projectvalues  = projectvalues +','+projt.Project_State__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Progress_To_Date__c)){
                    projectvalues  = projectvalues +','+projt.Progress_To_Date__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }               
                if(String.isNotBlank(projt.Next_Steps__c)){
                    projectvalues  = projectvalues +','+projt.Next_Steps__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Project_Created_Date__c != null){
                    projectvalues  = projectvalues +','+projt.Project_Created_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Planned_Start_Date__c != null){
                    projectvalues  = projectvalues +','+projt.Planned_Start_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Project_Start_Date__c != null){
                    projectvalues  = projectvalues +','+projt.Project_Start_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Project_Completion_Date_Target__c != null){
                    projectvalues  = projectvalues +','+projt.Project_Completion_Date_Target__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Project_Completion_Date_Forecast__c != null){
                    projectvalues  = projectvalues +','+projt.Project_Completion_Date_Forecast__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Project_Completion_Date_Actual__c != null){
                    projectvalues  = projectvalues +','+projt.Project_Completion_Date_Actual__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Closed_Date__c != null){
                    projectvalues  = projectvalues +','+projt.Closed_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Canceled_Date__c != null){
                    projectvalues  = projectvalues +','+projt.Canceled_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.On_Hold_Date__c != null){
                    projectvalues  = projectvalues +','+projt.On_Hold_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.In_Progress_Date__c != null){
                    projectvalues  = projectvalues +','+projt.In_Progress_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                /*if(projt.Not_Started_Date__c != null){
                    projectvalues  = projectvalues +','+projt.Not_Started_Date__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                */
                if(String.isNotBlank(projt.Market__c)){
                    projectvalues  = projectvalues +','+projt.Market__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Region_GCBT__c)){
                    projectvalues  = projectvalues +','+projt.Region_GCBT__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Sub_Region_CBT__c)){
                    projectvalues  = projectvalues +','+projt.Sub_Region_CBT__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.CT__c)){
                    projectvalues  = projectvalues +','+projt.CT__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Country__c)){
                    projectvalues  = projectvalues +','+projt.Country__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.MO_Site__c)){
                projectvalues  = projectvalues +','+projt.MO_Site__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }           
                if(String.isNotBlank(projt.Belt_Project_Type__c)){
                    projectvalues  = projectvalues +','+projt.Belt_Project_Type__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Project_Phase__c)){
                    projectvalues  = projectvalues +','+projt.Belt_Project_Phase__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Project_Champion__r.name)){
                    projectvalues  = projectvalues +','+projt.Belt_Project_Champion__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Project_Champion__r.Email__c)){
                    projectvalues  = projectvalues +','+projt.Belt_Project_Champion__r.Email__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Project_Sponsor__r.name)){
                    projectvalues  = projectvalues +','+projt.Belt_Project_Sponsor__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Project_Sponsor_Email__c)){
                    projectvalues  = projectvalues +','+projt.Belt_Project_Sponsor_Email__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Business_Unit_Master_Black_Belt__r.name)){
                    projectvalues  = projectvalues +','+projt.Business_Unit_Master_Black_Belt__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Business_Unit_Master_Black_Belt_Email__c)){
                    projectvalues  = projectvalues +','+projt.Business_Unit_Master_Black_Belt_Email__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Candidate_Mentor__r.name)){
                    projectvalues  = projectvalues +','+projt.Belt_Candidate_Mentor__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Candidate_Mentor_Email__c)){
                    projectvalues  = projectvalues +','+projt.Belt_Candidate_Mentor_Email__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Finance_Approver__r.name)){
                    projectvalues  = projectvalues +','+projt.Finance_Approver__r.name.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Finance_Approver_Email__c)){
                    projectvalues  = projectvalues +','+projt.Finance_Approver_Email__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Belt_Candidate_Location__c)){
                    projectvalues  = projectvalues +','+projt.Belt_Candidate_Location__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Flex_Field_1__c)){
                    projectvalues  = projectvalues +','+projt.Project_Flex_Field_1__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Flex_Field_2__c)){
                    projectvalues  = projectvalues +','+projt.Project_Flex_Field_2__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Flex_Field_3__c)){
                    projectvalues  = projectvalues +','+projt.Project_Flex_Field_3__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }           
                if(String.isNotBlank(projt.Project_Lead_Location__c)){
                    projectvalues  = projectvalues +','+projt.Project_Lead_Location__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Lean__c)){
                    projectvalues  = projectvalues +','+projt.Lean__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Lean_Project_Phase__c)){
                projectvalues  = projectvalues +','+projt.Lean_Project_Phase__c.replaceAll('null','');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }                                           
                if(String.isNotBlank(projt.Lean_Project_Type__c)){
                    projectvalues  = projectvalues +','+projt.Lean_Project_Type__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Number_of_Kaizens__c !=null){
                    projectvalues  = projectvalues +','+projt.Number_of_Kaizens__c;
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Sharenet_Link__c)){
                    projectvalues  = projectvalues +','+projt.Sharenet_Link__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Schedule_Status__c)){
                    projectvalues  = projectvalues +','+projt.Schedule_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                
                if(String.isNotBlank(projt.Lean_Coach__r.name)){
                    projectvalues  = projectvalues +','+projt.Lean_Coach__r.name.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Lean_Coach__r.email__c)){
                    projectvalues  = projectvalues +','+projt.Lean_Coach__r.email__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Owner__r.name)){
                    projectvalues  = projectvalues +','+projt.Project_Owner__r.name.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Project_Owner__r.Email__c)){
                    projectvalues  = projectvalues +','+projt.Project_Owner__r.Email__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                
                if(projt.DMAIC_Define__c != null){
                    projectvalues  = projectvalues +','+projt.DMAIC_Define__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Define_Date_Forecast__c != null){
                    projectvalues  = projectvalues +','+projt.Define_Date_Forecast__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Define_Date_Current__c != null){
                    projectvalues  = projectvalues +','+projt.Define_Date_Current__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Define_Status__c)){
                    projectvalues  = projectvalues +','+projt.Define_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.DMAIC_Measure__c != null){
                    projectvalues  = projectvalues +','+projt.DMAIC_Measure__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Measure_Date_Forecast__c != null){
                    projectvalues  = projectvalues +','+projt.Measure_Date_Forecast__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Measure_Date_Current__c != null){
                    projectvalues  = projectvalues +','+projt.Measure_Date_Current__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Measure_Status__c)){
                    projectvalues  = projectvalues +','+projt.Measure_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.DMAIC_Analyze__c != null){
                    projectvalues  = projectvalues +','+projt.DMAIC_Analyze__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Analyze_Date_Forecast__c != null){
                    projectvalues  = projectvalues +','+projt.Analyze_Date_Forecast__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Analyze_Date_Current__c != null){
                    projectvalues  = projectvalues +','+projt.Analyze_Date_Current__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Analyze_Status__c)){
                    projectvalues  = projectvalues +','+projt.Analyze_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.DMAIC_Improve__c != null){
                    projectvalues  = projectvalues +','+projt.DMAIC_Improve__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Improve_Design_Date_Forecast__c != null){
                    projectvalues  = projectvalues +','+projt.Improve_Design_Date_Forecast__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Improve_Date_Current__c != null){
                    projectvalues  = projectvalues +','+projt.Improve_Date_Current__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Improve_Status__c)){
                    projectvalues  = projectvalues +','+projt.Improve_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.DMAIC_Control__c != null){
                    projectvalues  = projectvalues +','+projt.DMAIC_Control__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Control_Verify_Date_Forecast__c != null){
                    projectvalues  = projectvalues +','+projt.Control_Verify_Date_Forecast__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(projt.Control_Date_Current__c != null){
                    projectvalues  = projectvalues +','+projt.Control_Date_Current__c.format();
                }else{
                    projectvalues  = projectvalues  +','+'';
                }
                if(String.isNotBlank(projt.Control_Status__c)){
                    projectvalues  = projectvalues +','+projt.Control_Status__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }               
                if(String.isNotBlank(projt.DI_State__c)){
                    projectvalues  = projectvalues +','+projt.DI_State__c.replaceAll(',', ':');
                }else{
                    projectvalues  = projectvalues  +','+'';
                }                
            }else{
                // Projects with Benefits
                for(QIPP_Benefit__c Benft : benRep1){
                    //list<QIPP_BU_Reporting__c> QIPPRep1= repMap.get(Benft.id);
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
                    if(String.isNotBlank(Benft.Project_ID__r.Project_Name_Succinct__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Name_Succinct__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Project_Description_Detailed__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Description_Detailed__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Portfolio_Name__r.Name)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Portfolio_Name__r.Name.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Status__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Status__c.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }               
                    if(String.isNotBlank(Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.name)){
                    csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.name.replaceAll('null','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    csvFileValues  = csvFileValues+','+Benft.Project_ID__r.Portfolio_Name__r.Portfolio_Owner__r.Email__c;

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
                    if(String.isNotBlank(Benft.Project_ID__r.Progress_To_Date__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Progress_To_Date__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }               
                    if(String.isNotBlank(Benft.Project_ID__r.Next_Steps__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Next_Steps__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
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
                    if(Benft.Project_ID__r.Closed_Date__c != null){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Closed_Date__c.format();
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(Benft.Project_ID__r.Canceled_Date__c != null){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Canceled_Date__c.format();
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(Benft.Project_ID__r.On_Hold_Date__c != null){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.On_Hold_Date__c.format();
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(Benft.Project_ID__r.In_Progress_Date__c != null){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.In_Progress_Date__c.format();
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    /*
                    if(Benft.Project_ID__r.Not_Started_Date__c != null){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Not_Started_Date__c.format();
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    */
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
                    if(String.isNotBlank(Benft.Project_ID__r.MO_Site__c)){
                    csvFileValues  = csvFileValues +','+Benft.Project_ID__r.MO_Site__c.replaceAll('null','');
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
                    if(String.isNotBlank(Benft.Project_ID__r.Project_Flex_Field_1__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Flex_Field_1__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Project_Flex_Field_2__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Flex_Field_2__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Project_Flex_Field_3__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Flex_Field_3__c.replaceAll('\r\n','').replaceAll('\n','').replaceAll('\r','').replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }           
                    if(String.isNotBlank(Benft.Project_ID__r.Project_Lead_Location__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Project_Lead_Location__c.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Lean__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Lean__c.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Lean_Project_Phase__c)){
                    csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Lean_Project_Phase__c.replaceAll('null','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }                                           
                    if(String.isNotBlank(Benft.Project_ID__r.Lean_Project_Type__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Lean_Project_Type__c.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(Benft.Project_ID__r.Number_of_Kaizens__c != null){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Number_of_Kaizens__c;
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Sharenet_Link__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Sharenet_Link__c.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Schedule_Status__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Schedule_Status__c.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }

                    if(String.isNotBlank(Benft.Project_ID__r.Lean_Coach__r.name)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Lean_Coach__r.name.replaceAll(',', ':');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    if(String.isNotBlank(Benft.Project_ID__r.Lean_Coach__r.email__c)){
                        csvFileValues  = csvFileValues +','+Benft.Project_ID__r.Lean_Coach__r.email__c.replaceAll(',', ':');
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
                    if(String.isNotBlank(Benft.Improvement_Measure_KPI__r.Improvement_Measure_Grouping__c)){
                        csvFileValues  = csvFileValues +','+Benft.Improvement_Measure_KPI__r.Improvement_Measure_Grouping__c.replaceAll(',', '');
                    }else{
                        csvFileValues  = csvFileValues  +','+'';
                    }
                    //csvFileValues  = csvFileValues+','+Benft.Improvement_Measure_KPI__r.Improvement_Measure_Grouping__c;
                    //Added Benefit total amounts.
                    if(Benft.Planned_Financial_Savings_Total__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Planned_Financial_Savings_Total__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Achieved_Financial_Savings_Total__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Achieved_Financial_Savings_Total__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Future_Financial_Savings_Total__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Future_Financial_Savings_Total__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Benefit_Amount_Achieved_Future_k__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Benefit_Amount_Achieved_Future_k__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Planned_Operational_Savings_Total__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Planned_Operational_Savings_Total__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Achieved_Operational_Savings_Total__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Achieved_Operational_Savings_Total__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Future_Operational_Savings_Total__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Future_Operational_Savings_Total__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    if(Benft.Benefit_Operational_Achieved_Future_k__c != null){
                        csvFileValues  = csvFileValues +','+String.valueOf(Benft.Benefit_Operational_Achieved_Future_k__c).replaceAll(',','');
                    }else{
                        csvFileValues  = csvFileValues  +','+'0.0';
                    }
                    
                    //Benefit monthly savings amount**
                    list<QIPP_BU_Reporting__c> QIPPRep1= repMap.get(Benft.id);
                    for(string yrs :years){
                        Decimal PFM1 = 0.0;
                        Decimal PFM2 = 0.0;
                        Decimal PFM3 = 0.0;
                        Decimal PFM4 = 0.0;
                        Decimal PFM5 = 0.0;
                        Decimal PFM6 = 0.0;
                        Decimal PFM7 = 0.0;
                        Decimal PFM8 = 0.0;
                        Decimal PFM9 = 0.0;
                        Decimal PFM10 = 0.0;
                        Decimal PFM11= 0.0;
                        Decimal PFM12 = 0.0;
                        
                        Decimal AFM1 = 0.0;
                        Decimal AFM2 = 0.0;
                        Decimal AFM3 = 0.0;
                        Decimal AFM4 = 0.0;
                        Decimal AFM5 = 0.0;
                        Decimal AFM6 = 0.0;
                        Decimal AFM7 = 0.0;
                        Decimal AFM8 = 0.0;
                        Decimal AFM9 = 0.0;
                        Decimal AFM10 = 0.0;
                        Decimal AFM11= 0.0;
                        Decimal AFM12 = 0.0;
                        
                        Decimal FFM1 = 0.0;
                        Decimal FFM2 = 0.0;
                        Decimal FFM3 = 0.0;
                        Decimal FFM4 = 0.0;
                        Decimal FFM5 = 0.0;
                        Decimal FFM6 = 0.0;
                        Decimal FFM7 = 0.0;
                        Decimal FFM8 = 0.0;
                        Decimal FFM9 = 0.0;
                        Decimal FFM10 = 0.0;
                        Decimal FFM11= 0.0;
                        Decimal FFM12 = 0.0;
                        
                        /*Decimal LEFM1 = 0.0;
                        Decimal LEFM2 = 0.0;
                        Decimal LEFM3 = 0.0;
                        Decimal LEFM4 = 0.0;
                        Decimal LEFM5 = 0.0;
                        Decimal LEFM6 = 0.0;
                        Decimal LEFM7 = 0.0;
                        Decimal LEFM8 = 0.0;
                        Decimal LEFM9 = 0.0;
                        Decimal LEFM10 = 0.0;
                        Decimal LEFM11= 0.0;
                        Decimal LEFM12 = 0.0; */
                        
                        Decimal POM1 = 0.0;
                        Decimal POM2 = 0.0;
                        Decimal POM3 = 0.0;
                        Decimal POM4 = 0.0;
                        Decimal POM5 = 0.0;
                        Decimal POM6 = 0.0;
                        Decimal POM7 = 0.0;
                        Decimal POM8 = 0.0;
                        Decimal POM9 = 0.0;
                        Decimal POM10 = 0.0;
                        Decimal POM11= 0.0;
                        Decimal POM12 = 0.0;
                        
                        Decimal AOM1 = 0.0;
                        Decimal AOM2 = 0.0;
                        Decimal AOM3 = 0.0;
                        Decimal AOM4 = 0.0;
                        Decimal AOM5 = 0.0;
                        Decimal AOM6 = 0.0;
                        Decimal AOM7 = 0.0;
                        Decimal AOM8 = 0.0;
                        Decimal AOM9 = 0.0;
                        Decimal AOM10 = 0.0;
                        Decimal AOM11= 0.0;
                        Decimal AOM12 = 0.0;
                        
                        Decimal FOM1 = 0.0;
                        Decimal FOM2 = 0.0;
                        Decimal FOM3 = 0.0;
                        Decimal FOM4 = 0.0;
                        Decimal FOM5 = 0.0;
                        Decimal FOM6 = 0.0;
                        Decimal FOM7 = 0.0;
                        Decimal FOM8 = 0.0;
                        Decimal FOM9 = 0.0;
                        Decimal FOM10 = 0.0;
                        Decimal FOM11= 0.0;
                        Decimal FOM12 = 0.0;
                        
                        /*Decimal LEOM1 = 0.0;
                        Decimal LEOM2 = 0.0;
                        Decimal LEOM3 = 0.0;
                        Decimal LEOM4 = 0.0;
                        Decimal LEOM5 = 0.0;
                        Decimal LEOM6 = 0.0;
                        Decimal LEOM7 = 0.0;
                        Decimal LEOM8 = 0.0;
                        Decimal LEOM9 = 0.0;
                        Decimal LEOM10 = 0.0;
                        Decimal LEOM11= 0.0;
                        Decimal LEOM12 = 0.0; */
                        
                        String TempSaveings = null;   
                        if(QIPPRep1 != null){    
                            list<integer> removeelements = new list<integer>();
                            for(integer i = 0; i < QIPPRep1.size(); i++){
                               boolean removei = false;
                               // For Financial Savings
                               if(QIPPRep1[i].Benefit_ID__c == Benft.id && QIPPRep1[i].Years__c == yrs && Benft.Benefit_Type__c == 'Financial Savings'){
                                    // Quarterly Financial Palnned savings
                                    if(QIPPRep1[i].Months__c == '01' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM1 = PFM1 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '02' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM2 = PFM2 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '03' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM3 = PFM3 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '04' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM4 = PFM4 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '05' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM5 = PFM5 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '06' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM6 = PFM6 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '07' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM7 = PFM7 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '08' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM8 = PFM8 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '09' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM9 = PFM9 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '10' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM10 = PFM10 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '11' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM11 = PFM11 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '12' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFM12 = PFM12 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    
                                    
                                    // Quarterly Financial Achieved savings
                                    if(QIPPRep1[i].Months__c == '01' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM1 = AFM1 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '02' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM2 = AFM2 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '03' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM3 = AFM3 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '04' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM4 = AFM4 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '05' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM5 = AFM5 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '06' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM6 = AFM6 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '07' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM7 = AFM7 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '08' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM8 = AFM8 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '09' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM9 = AFM9 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '10' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM10 = AFM10 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '11' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM11 = AFM11 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '12' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFM12 = AFM12 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }
                                    }
                                    // Quarterly Financial Future savings
                                    if(QIPPRep1[i].Months__c == '01' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM1 = FFM1 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '02' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM2 = FFM2 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '03' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM3 = FFM3 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '04' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM4 = FFM4 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '05' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM5 = FFM5 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '06' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM6 = FFM6 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '07' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM7 = FFM7 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '08' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM8 = FFM8 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '09' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM9 = FFM9 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '10' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM10 = FFM10 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '11' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM11 = FFM11 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '12' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFM12 = FFM12 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }
                                    }
                                    removei=true;
                                }
                                // For Operational Savings
                               if(QIPPRep1[i].Benefit_ID__c == Benft.id && QIPPRep1[i].Years__c == yrs && Benft.Benefit_Type__c == 'Operational Savings'){
                                    // Quarterly Operational Palnned savings
                                    if(QIPPRep1[i].Months__c == '01' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM1 = POM1 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '02' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM2 = POM2 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '03' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM3 = POM3 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '04' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM4 = POM4 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '05' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM5 = POM5 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '06' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM6 = POM6 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '07' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM7 = POM7 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '08' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM8 = POM8 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '09' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM9 = POM9 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '10' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM10 = POM10 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '11' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM11 = POM11 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '12' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c != null){
                                            POM12 = POM12 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    
                                    
                                    // Quarterly Operational Achieved savings
                                    if(QIPPRep1[i].Months__c == '01' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM1 = AOM1 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '02' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM2 = AOM2 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '03' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM3 = AOM3 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '04' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM4 = AOM4 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '05' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM5 = AOM5 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '06' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM6 = AOM6 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '07' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM7 = AOM7 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '08' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM8 = AOM8 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '09' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM9 = AOM9 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '10' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM10 = AOM10 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '11' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM11 = AOM11 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '12' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c != null){
                                            AOM12 = AOM12 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }
                                    }
                                    // Quarterly Operational Future savings
                                    if(QIPPRep1[i].Months__c == '01' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM1 = FOM1 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '02' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM2 = FOM2 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '03' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM3 = FOM3 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '04' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM4 = FOM4 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '05' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM5 = FOM5 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '06' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM6 = FOM6 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '07' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM7 = FOM7 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '08' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM8 = FOM8 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '09' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM9 = FOM9 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '10' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM10 = FOM10 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '11' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM11 = FOM11 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Months__c == '12' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c != null){
                                            FOM12 = FOM12 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }
                                    }
                                    removei=true;
                                }
                                
                                if(removei){
                                    removeelements.add(i);
                                }
                            }
                            //remove elements from QIPPRep1 list.
                            
                            if(removeelements.size()>0){
                                removeelements.sort();
                                for(Integer i=removeelements.size()-1;i>=0;i--){     
                                    if(removeelements[i]<QIPPRep1.size()){
                                       QIPPRep1.remove(removeelements[i]);
                                    }
                                }                               
                                removeelements.clear();
                            }
                        }
                        // Financial LE(Achieved + Future)
                        Decimal LEFM1 = AFM1 + FFM1;
                        Decimal LEFM2 = AFM2 + FFM2;
                        Decimal LEFM3 = AFM3 + FFM3;
                        Decimal LEFM4 = AFM4 + FFM4;
                        Decimal LEFM5 = AFM5 + FFM5;
                        Decimal LEFM6 = AFM6 + FFM6;
                        Decimal LEFM7 = AFM7 + FFM7;
                        Decimal LEFM8 = AFM8 + FFM8;
                        Decimal LEFM9 = AFM9 + FFM9;
                        Decimal LEFM10 = AFM10 + FFM10;
                        Decimal LEFM11 = AFM11 + FFM11;
                        Decimal LEFM12 = AFM12 + FFM12;
                        
                        // Operational LE(Achieved + Future)
                        Decimal LEOM1 = AOM1 + FOM1;
                        Decimal LEOM2 = AOM2 + FOM2;
                        Decimal LEOM3 = AOM3 + FOM3;
                        Decimal LEOM4 = AOM4 + FOM4;
                        Decimal LEOM5 = AOM5 + FOM5;
                        Decimal LEOM6 = AOM6 + FOM6;
                        Decimal LEOM7 = AOM7 + FOM7;
                        Decimal LEOM8 = AOM8 + FOM8;
                        Decimal LEOM9 = AOM9 + FOM9;
                        Decimal LEOM10 = AOM10 + FOM10;
                        Decimal LEOM11 = AOM11 + FOM11;
                        Decimal LEOM12 = AOM12 + FOM12;
                        
                        //Financial
                        String SPFM1 = String.valueOf(PFM1);
                        String SPFM2 = String.valueOf(PFM2);
                        String SPFM3 = String.valueOf(PFM3);
                        String SPFM4 = String.valueOf(PFM4);
                        String SPFM5 = String.valueOf(PFM5);
                        String SPFM6 = String.valueOf(PFM6);
                        String SPFM7 = String.valueOf(PFM7);
                        String SPFM8 = String.valueOf(PFM8);
                        String SPFM9 = String.valueOf(PFM9);
                        String SPFM10 = String.valueOf(PFM10);
                        String SPFM11 = String.valueOf(PFM11);
                        String SPFM12 = String.valueOf(PFM12);
                        String SAFM1 = String.valueOf(AFM1);
                        String SAFM2 = String.valueOf(AFM2);
                        String SAFM3 = String.valueOf(AFM3);
                        String SAFM4 = String.valueOf(AFM4);
                        String SAFM5 = String.valueOf(AFM5);
                        String SAFM6 = String.valueOf(AFM6);
                        String SAFM7 = String.valueOf(AFM7);
                        String SAFM8 = String.valueOf(AFM8);
                        String SAFM9 = String.valueOf(AFM9);
                        String SAFM10 = String.valueOf(AFM10);
                        String SAFM11 = String.valueOf(AFM11);
                        String SAFM12 = String.valueOf(AFM12);
                        String SFFM1 = String.valueOf(FFM1);
                        String SFFM2 = String.valueOf(FFM2);
                        String SFFM3 = String.valueOf(FFM3);
                        String SFFM4 = String.valueOf(FFM4);
                        String SFFM5 = String.valueOf(FFM5);
                        String SFFM6 = String.valueOf(FFM6);
                        String SFFM7 = String.valueOf(FFM7);
                        String SFFM8 = String.valueOf(FFM8);
                        String SFFM9 = String.valueOf(FFM9);
                        String SFFM10 = String.valueOf(FFM10);
                        String SFFM11 = String.valueOf(FFM11);
                        String SFFM12 = String.valueOf(FFM12);
                        // LE Financial
                        String SLEFM1 = String.valueOf(LEFM1.format());
                        String SLEFM2 = String.valueOf(LEFM2.format());
                        String SLEFM3 = String.valueOf(LEFM3.format());
                        String SLEFM4 = String.valueOf(LEFM4.format());
                        String SLEFM5 = String.valueOf(LEFM5.format());
                        String SLEFM6 = String.valueOf(LEFM6.format());
                        String SLEFM7 = String.valueOf(LEFM7.format());
                        String SLEFM8 = String.valueOf(LEFM8.format());
                        String SLEFM9 = String.valueOf(LEFM9.format());
                        String SLEFM10 = String.valueOf(LEFM10.format());
                        String SLEFM11 = String.valueOf(LEFM11.format());
                        String SLEFM12 = String.valueOf(LEFM12.format());
                        // Operational 
                        String SPOM1 = String.valueOf(POM1);
                        String SPOM2 = String.valueOf(POM2);
                        String SPOM3 = String.valueOf(POM3);
                        String SPOM4 = String.valueOf(POM4);
                        String SPOM5 = String.valueOf(POM5);
                        String SPOM6 = String.valueOf(POM6);
                        String SPOM7 = String.valueOf(POM7);
                        String SPOM8 = String.valueOf(POM8);
                        String SPOM9 = String.valueOf(POM9);
                        String SPOM10 = String.valueOf(POM10);
                        String SPOM11 = String.valueOf(POM11);
                        String SPOM12 = String.valueOf(POM12);
                        String SAOM1 = String.valueOf(AOM1);
                        String SAOM2 = String.valueOf(AOM2);
                        String SAOM3 = String.valueOf(AOM3);
                        String SAOM4 = String.valueOf(AOM4);
                        String SAOM5 = String.valueOf(AOM5);
                        String SAOM6 = String.valueOf(AOM6);
                        String SAOM7 = String.valueOf(AOM7);
                        String SAOM8 = String.valueOf(AOM8);
                        String SAOM9 = String.valueOf(AOM9);
                        String SAOM10 = String.valueOf(AOM10);
                        String SAOM11 = String.valueOf(AOM11);
                        String SAOM12 = String.valueOf(AOM12);
                        String SFOM1 = String.valueOf(FOM1);
                        String SFOM2 = String.valueOf(FOM2);
                        String SFOM3 = String.valueOf(FOM3);
                        String SFOM4 = String.valueOf(FOM4);
                        String SFOM5 = String.valueOf(FOM5);
                        String SFOM6 = String.valueOf(FOM6);
                        String SFOM7 = String.valueOf(FOM7);
                        String SFOM8 = String.valueOf(FOM8);
                        String SFOM9 = String.valueOf(FOM9);
                        String SFOM10 = String.valueOf(FOM10);
                        String SFOM11 = String.valueOf(FOM11);
                        String SFOM12 = String.valueOf(FOM12);
                        // LE Operational 
                        String SLEOM1 = String.valueOf(LEOM1.format());
                        String SLEOM2 = String.valueOf(LEOM2.format());
                        String SLEOM3 = String.valueOf(LEOM3.format());
                        String SLEOM4 = String.valueOf(LEOM4.format());
                        String SLEOM5 = String.valueOf(LEOM5.format());
                        String SLEOM6 = String.valueOf(LEOM6.format());
                        String SLEOM7 = String.valueOf(LEOM7.format());
                        String SLEOM8 = String.valueOf(LEOM8.format());
                        String SLEOM9 = String.valueOf(LEOM9.format());
                        String SLEOM10 = String.valueOf(LEOM10.format());
                        String SLEOM11 = String.valueOf(LEOM11.format());
                        String SLEOM12 = String.valueOf(LEOM12.format());
                     
                     // Temparely storing saveings values
                        Set<String> stringset2= monthrmap.get(yrs);
                        TempSaveings = ',';
                        // For Financial Savings
                        //Financial Palnned savings
                        if(stringset2.contains('Financial Savings:Planned:01')){
                            TempSaveings = TempSaveings +SPFM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:02')){
                            TempSaveings = TempSaveings +SPFM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:03')){
                            TempSaveings = TempSaveings +SPFM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:04')){
                            TempSaveings = TempSaveings +SPFM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:05')){
                            TempSaveings = TempSaveings +SPFM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:06')){
                            TempSaveings = TempSaveings +SPFM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:07')){
                            TempSaveings = TempSaveings +SPFM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:08')){
                            TempSaveings = TempSaveings +SPFM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:09')){
                            TempSaveings = TempSaveings +SPFM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:10')){
                            TempSaveings = TempSaveings +SPFM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:11')){
                            TempSaveings = TempSaveings +SPFM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Planned:12')){
                            TempSaveings = TempSaveings +SPFM12.replaceAll(',', '')+',';
                        }
                        //Financial Achieved savings
                        if(stringset2.contains('Financial Savings:Achieved:01')){
                            TempSaveings = TempSaveings +SAFM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:02')){
                            TempSaveings = TempSaveings +SAFM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:03')){
                            TempSaveings = TempSaveings +SAFM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:04')){
                            TempSaveings = TempSaveings +SAFM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:05')){
                            TempSaveings = TempSaveings +SAFM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:06')){
                            TempSaveings = TempSaveings +SAFM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:07')){
                            TempSaveings = TempSaveings +SAFM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:08')){
                            TempSaveings = TempSaveings +SAFM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:09')){
                            TempSaveings = TempSaveings +SAFM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:10')){
                            TempSaveings = TempSaveings +SAFM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:11')){
                            TempSaveings = TempSaveings +SAFM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:12')){
                            TempSaveings = TempSaveings +SAFM12.replaceAll(',', '')+',';
                        }
                        //Financial Future savings
                        if(stringset2.contains('Financial Savings:Future:01')){
                            TempSaveings = TempSaveings +SFFM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:02')){
                            TempSaveings = TempSaveings +SFFM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:03')){
                            TempSaveings = TempSaveings +SFFM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:04')){
                            TempSaveings = TempSaveings +SFFM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:05')){
                            TempSaveings = TempSaveings +SFFM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:06')){
                            TempSaveings = TempSaveings +SFFM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:07')){
                            TempSaveings = TempSaveings +SFFM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:08')){
                            TempSaveings = TempSaveings +SFFM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:09')){
                            TempSaveings = TempSaveings +SFFM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:10')){
                            TempSaveings = TempSaveings +SFFM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:11')){
                            TempSaveings = TempSaveings +SFFM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Future:12')){
                            TempSaveings = TempSaveings +SFFM12.replaceAll(',', '')+',';
                        }
                        //LE Financial Savings
                        if(stringset2.contains('Financial Savings:Achieved:01') || stringset2.contains('Financial Savings:Future:01')){
                            TempSaveings = TempSaveings +SLEFM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:02') || stringset2.contains('Financial Savings:Future:02')){
                            TempSaveings = TempSaveings +SLEFM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:03') || stringset2.contains('Financial Savings:Future:03')){
                            TempSaveings = TempSaveings +SLEFM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:04') || stringset2.contains('Financial Savings:Future:04')){
                            TempSaveings = TempSaveings +SLEFM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:05') || stringset2.contains('Financial Savings:Future:05')){
                            TempSaveings = TempSaveings +SLEFM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:06') || stringset2.contains('Financial Savings:Future:06')){
                            TempSaveings = TempSaveings +SLEFM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:07') || stringset2.contains('Financial Savings:Future:07')){
                            TempSaveings = TempSaveings +SLEFM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:08') || stringset2.contains('Financial Savings:Future:08')){
                            TempSaveings = TempSaveings +SLEFM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:09') || stringset2.contains('Financial Savings:Future:09')){
                            TempSaveings = TempSaveings +SLEFM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:10') || stringset2.contains('Financial Savings:Future:10')){
                            TempSaveings = TempSaveings +SLEFM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:11') || stringset2.contains('Financial Savings:Future:11')){
                            TempSaveings = TempSaveings +SLEFM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Financial Savings:Achieved:12') || stringset2.contains('Financial Savings:Future:12')){
                            TempSaveings = TempSaveings +SLEFM12.replaceAll(',', '')+',';
                        }
                        
                        // For Operational Savings
                        //Operational Palnned savings
                        if(stringset2.contains('Operational Savings:Planned:01')){
                            TempSaveings = TempSaveings +SPOM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:02')){
                            TempSaveings = TempSaveings +SPOM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:03')){
                            TempSaveings = TempSaveings +SPOM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:04')){
                            TempSaveings = TempSaveings +SPOM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:05')){
                            TempSaveings = TempSaveings +SPOM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:06')){
                            TempSaveings = TempSaveings +SPOM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:07')){
                            TempSaveings = TempSaveings +SPOM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:08')){
                            TempSaveings = TempSaveings +SPOM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:09')){
                            TempSaveings = TempSaveings +SPOM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:10')){
                            TempSaveings = TempSaveings +SPOM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:11')){
                            TempSaveings = TempSaveings +SPOM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Planned:12')){
                            TempSaveings = TempSaveings +SPOM12.replaceAll(',', '')+',';
                        }
                        //Operational Achieved savings
                        if(stringset2.contains('Operational Savings:Achieved:01')){
                            TempSaveings = TempSaveings +SAOM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:02')){
                            TempSaveings = TempSaveings +SAOM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:03')){
                            TempSaveings = TempSaveings +SAOM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:04')){
                            TempSaveings = TempSaveings +SAOM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:05')){
                            TempSaveings = TempSaveings +SAOM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:06')){
                            TempSaveings = TempSaveings +SAOM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:07')){
                            TempSaveings = TempSaveings +SAOM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:08')){
                            TempSaveings = TempSaveings +SAOM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:09')){
                            TempSaveings = TempSaveings +SAOM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:10')){
                            TempSaveings = TempSaveings +SAOM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:11')){
                            TempSaveings = TempSaveings +SAOM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:12')){
                            TempSaveings = TempSaveings +SAOM12.replaceAll(',', '')+',';
                        }
                        //Operational Future savings
                        if(stringset2.contains('Operational Savings:Future:01')){
                            TempSaveings = TempSaveings +SFOM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:02')){
                            TempSaveings = TempSaveings +SFOM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:03')){
                            TempSaveings = TempSaveings +SFOM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:04')){
                            TempSaveings = TempSaveings +SFOM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:05')){
                            TempSaveings = TempSaveings +SFOM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:06')){
                            TempSaveings = TempSaveings +SFOM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:07')){
                            TempSaveings = TempSaveings +SFOM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:08')){
                            TempSaveings = TempSaveings +SFOM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:09')){
                            TempSaveings = TempSaveings +SFOM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:10')){
                            TempSaveings = TempSaveings +SFOM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:11')){
                            TempSaveings = TempSaveings +SFOM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Future:12')){
                            TempSaveings = TempSaveings +SFOM12.replaceAll(',', '')+',';
                        }
                        //LE Operational Savings
                        if(stringset2.contains('Operational Savings:Achieved:01') || stringset2.contains('Operational Savings:Future:01')){
                            TempSaveings = TempSaveings +SLEOM1.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:02') || stringset2.contains('Operational Savings:Future:02')){
                            TempSaveings = TempSaveings +SLEOM2.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:03') || stringset2.contains('Operational Savings:Future:03')){
                            TempSaveings = TempSaveings +SLEOM3.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:04') || stringset2.contains('Operational Savings:Future:04')){
                            TempSaveings = TempSaveings +SLEOM4.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:05') || stringset2.contains('Operational Savings:Future:05')){
                            TempSaveings = TempSaveings +SLEOM5.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:06') || stringset2.contains('Operational Savings:Future:06')){
                            TempSaveings = TempSaveings +SLEOM6.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:07') || stringset2.contains('Operational Savings:Future:07')){
                            TempSaveings = TempSaveings +SLEOM7.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:08') || stringset2.contains('Operational Savings:Future:08')){
                            TempSaveings = TempSaveings +SLEOM8.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:09') || stringset2.contains('Operational Savings:Future:09')){
                            TempSaveings = TempSaveings +SLEOM9.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:10') || stringset2.contains('Operational Savings:Future:10')){
                            TempSaveings = TempSaveings +SLEOM10.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:11') || stringset2.contains('Operational Savings:Future:11')){
                            TempSaveings = TempSaveings +SLEOM11.replaceAll(',', '')+',';
                        }
                        if(stringset2.contains('Operational Savings:Achieved:12') || stringset2.contains('Operational Savings:Future:12')){
                            TempSaveings = TempSaveings +SLEOM12.replaceAll(',', '')+',';
                        }
                        TempSaveings  = TempSaveings.removeEnd(',');
                        csvFileValues = csvFileValues+TempSaveings;                        
                    }
                }

            }
        
        }
            system.debug('emailTo :: ' + emailTo );
            system.debug('emailTo leanth :: ' + emailTo.length() );
            system.debug('csvFileHeader :: ' + csvFileHeader);
            system.debug('csvFileValues :: ' + csvFileValues);    
    }  
    
    global void finish(Database.BatchableContext BC){ 
        id OWEA; 
        OrgWideEmailAddress[] owa = [select id, Address from OrgWideEmailAddress where Address = 'qippadmin.quality@nokia.com'];
        if(owa.size() > 0 ){OWEA = owa.get(0).Id;}
        System.debug('OWEA :'+OWEA); 
        
        csvFile = csvFileHeader + csvFileValues + projectvalues;
            System.debug(LoggingLevel.WARN,'Finished');
            system.debug('csvFile Final:: ' +csvFile ); 
            System.debug('Email to snd : ' +emailTo);
            //System.debug('All Benifits : ' +Benifits.size());
         try {
            Blob b =Blob.valueOf(csvFile );
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(m+' : Project & Benefit Short_Term_Report.csv');
            efa.setBody(b);
            
            List<Messaging.SingleEmailMessage> mailsList = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setToAddresses(new String[] {emailTo});        
            if(OWEA != null){
                    mail.setOrgWideEmailAddressId(OWEA); 
            }
            //mail.setSenderDisplayName('Report Processing ');
            mail.setSaveAsActivity(false); 
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
        } 
        catch(System.DMLException e){
            response = e.getMessage();
            system.debug('csvFile not sent:: '); 
        }
    }
}