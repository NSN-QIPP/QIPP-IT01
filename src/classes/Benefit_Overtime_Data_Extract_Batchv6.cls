global class Benefit_Overtime_Data_Extract_Batchv6 implements Database.Batchable<sobject> ,Database.Stateful{
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
    public map<string, set<string> > qtryrmap = new map<string, set<string>>();
    String csvFileValues;
    string projectvalues;
    String csvFile;
        
    global Benefit_Overtime_Data_Extract_batchv6 (string emailto,string csvFileHeader,list<string> years,map<string, set<string> > qtryrmap,datetime fdate){
        this.emailTo = emailTo;    
        this.csvFileHeader = csvFileHeader;
        this.years = years;  
        this.qtryrmap = qtryrmap;  
        this.fromdate = fdate ; 
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
            System.debug('Email to snd : ' +emailTo);
            system.debug('years:: '+ years); 
            System.debug('keys in the map: ' + qtryrmap.keySet());
            System.debug('list of values in the map : ' + qtryrmap.values());
            System.debug('year values in the map : ' + qtryrmap.get('2015'));
            system.debug('csvFileHeader:: '+ csvFileHeader); 
        return Database.getQueryLocator(query);     
    }
    
    global void execute(Database.BatchableContext BC,list<QIPP_Project__c> Lds){     
        System.debug('Email to snd : ' +emailTo);
        Map<String,list<QIPP_Benefit__c>> benMap = new Map<String,list<QIPP_Benefit__c>>();
        Map<String,list<QIPP_BU_Reporting__c>> repMap = new Map<String,list<QIPP_BU_Reporting__c>>();
        list<id> prjids = new list<id>();
        Set<string> BenIds = new Set<string>();
        
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
                        from QIPP_BU_Reporting__c  where Benefit_ID__c in: BenIds and Entry_Type__c = 'User Entry' ]){
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
                   
                    list<QIPP_BU_Reporting__c> QIPPRep1= repMap.get(Benft.id);
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
                            list<integer> removeelements = new list<integer>();
                            for(integer i = 0; i < QIPPRep1.size(); i++){
                               boolean removei = false;
                               // For Financial Savings
                               if(QIPPRep1[i].Benefit_ID__c == Benft.id && QIPPRep1[i].Years__c == yrs && Benft.Benefit_Type__c == 'Financial Savings'){
                                    // Quarterly Financial Palnned savings
                                    if(QIPPRep1[i].Quarters__c == 'Q1' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFQ1 = PFQ1 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q2' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFQ2 = PFQ2 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q3' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFQ3 = PFQ3 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q4' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Financial_Savings_k__c != null){
                                            PFQ4 = PFQ4 + QIPPRep1[i].Planned_Financial_Savings_k__c;
                                        }
                                    }
                                    // Quarterly Financial Achieved savings
                                    if(QIPPRep1[i].Quarters__c == 'Q1' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFQ1 = AFQ1 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q2' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFQ2 = AFQ2 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q3' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFQ3 = AFQ3 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q4' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Financial_Savings_k__c != null){
                                            AFQ4 = AFQ4 + QIPPRep1[i].Achieved_Financial_Savings_k__c;
                                        }  
                                    }
                                    // Quarterly Financial Future savings
                                    if(QIPPRep1[i].Quarters__c == 'Q1' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFQ1 = FFQ1 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }     
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q2' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFQ2 = FFQ2 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q3' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFQ3 = FFQ3 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q4' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Financial_Savings_k__c != null){
                                            FFQ4 = FFQ4 + QIPPRep1[i].Future_Financial_Savings_k__c;
                                        }  
                                    }
                                    removei=true;
                                }
                                //For Operational Savings
                                if(QIPPRep1[i].Benefit_ID__c == Benft.id && QIPPRep1[i].Years__c == yrs && Benft.Benefit_Type__c == 'Operational Savings'){
                                    // Quarterly Operational Palnned savings
                                    if(QIPPRep1[i].Quarters__c == 'Q1' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c!= null){
                                            POQ1 = POQ1 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q2' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c!= null){
                                            POQ2 = POQ2 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q3' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c!= null){
                                            POQ3 = POQ3 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q4' && QIPPRep1[i].Benefit_Condition__c == 'Planned'){
                                        if(QIPPRep1[i].Planned_Operational_Savings_k__c!= null){
                                            POQ4 = POQ4 + QIPPRep1[i].Planned_Operational_Savings_k__c;
                                        }
                                    }
                                    // Quarterly Operational Achieved savings
                                    if(QIPPRep1[i].Quarters__c == 'Q1' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c!= null){
                                            AOQ1 = AOQ1 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q2' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c!= null){
                                            AOQ2 = AOQ2 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q3' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c!= null){
                                            AOQ3 = AOQ3 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q4' && QIPPRep1[i].Benefit_Condition__c == 'Achieved'){
                                        if(QIPPRep1[i].Achieved_Operational_Savings_k__c!= null){
                                            AOQ4 = AOQ4 + QIPPRep1[i].Achieved_Operational_Savings_k__c;
                                        }  
                                    }
                                    // Quarterly Operational Future savings
                                    if(QIPPRep1[i].Quarters__c == 'Q1' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c!= null){
                                            FOQ1 = FOQ1 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q2' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c!= null){
                                            FOQ2 = FOQ2 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q3' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c!= null){
                                            FOQ3 = FOQ3 + QIPPRep1[i].Future_Operational_Savings_k__c;
                                        }  
                                    }
                                    if(QIPPRep1[i].Quarters__c == 'Q4' && QIPPRep1[i].Benefit_Condition__c == 'Future'){
                                        if(QIPPRep1[i].Future_Operational_Savings_k__c!= null){
                                            FOQ4 = FOQ4 + QIPPRep1[i].Future_Operational_Savings_k__c;
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
                        LEFQ1 = AFQ1 + FFQ1;
                        LEFQ2 = AFQ2 + FFQ2;
                        LEFQ3 = AFQ3 + FFQ3;
                        LEFQ4 = AFQ4 + FFQ4;
                        // Operational LE(Achieved + Future)
                        LEOQ1 = AOQ1 + FOQ1;
                        LEOQ2 = AOQ2 + FOQ2;
                        LEOQ3 = AOQ3 + FOQ3;
                        LEOQ4 = AOQ4 + FOQ4;
                        
                        string sPFQ1 = String.valueOf(PFQ1);
                        string sPFQ2 = String.valueOf(PFQ2);
                        string sPFQ3 = String.valueOf(PFQ3);
                        string sPFQ4 = String.valueOf(PFQ4);
                        string sAFQ1 = String.valueOf(AFQ1);
                        string sAFQ2 = String.valueOf(AFQ2);
                        string sAFQ3 = String.valueOf(AFQ3);
                        string sAFQ4 = String.valueOf(AFQ4);
                        string sFFQ1 = String.valueOf(FFQ1);
                        string sFFQ2 = String.valueOf(FFQ2);
                        string sFFQ3 = String.valueOf(FFQ3);
                        string sFFQ4 = String.valueOf(FFQ4);
                        string sLEFQ1 = String.valueOf(LEFQ1.format());
                        string sLEFQ2 = String.valueOf(LEFQ2.format());
                        string sLEFQ3 = String.valueOf(LEFQ3.format());
                        string sLEFQ4 = String.valueOf(LEFQ4.format());

                        string sPOQ1 = String.valueOf(POQ1);
                        string sPOQ2 = String.valueOf(POQ2);
                        string sPOQ3 = String.valueOf(POQ3);
                        string sPOQ4 = String.valueOf(POQ4);
                        string sAOQ1 = String.valueOf(AOQ1);
                        string sAOQ2 = String.valueOf(AOQ2);
                        string sAOQ3 = String.valueOf(AOQ3);
                        string sAOQ4 = String.valueOf(AOQ4);
                        string sFOQ1 = String.valueOf(FOQ1);
                        string sFOQ2 = String.valueOf(FOQ2);
                        string sFOQ3 = String.valueOf(FOQ3);
                        string sFOQ4 = String.valueOf(FOQ4);
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
                        csvFileValues = csvFileValues+TempSaveings;
                        
                        /*
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
                        csvFileValues = csvFileValues+TempSaveings;
                        */
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