public with sharing class BenefitingBusinessGroupController{
    
    public Integer bggRowNum {get;set;}
    public List<Benefiting_Business_Group__c> projMultipleBBGDistAddList{get;set;}
    public List<Benefiting_Business_Group__c> projMultipleBBGDistDelList{get;set;}
    public Benefiting_Business_Group__c mulBBGDist;
    public Integer mulBGDistRowNum {get;set;}
    public boolean displayPopupBBGDist{get;set;}
    public boolean bbgErrorMessages{get;set;}
    public boolean projectErrorMessages{get;set;}
    public String projID{get;set;}
    public QIPP_Project__c proj;
    public List<QIPP_Project__c> projlist;
    public list<Benefiting_Business_Group__c> projectbbg;

    public BenefitingBusinessGroupController(ApexPages.StandardController stdController){ 
        this.proj= (QIPP_Project__c)stdController.getRecord();                
        projID = proj.id;
    }

    public List<Benefiting_Business_Group__c> getprojectbbglist(){
        string projectid1 = projID;    // ApexPages.currentPage().getParameters().get('id');
        //projectbbglist = new list<Benefiting_Business_Group__c>();
        projectbbg = [select id,name,Distribution__c ,Total_Validation_Amount__c,Total_Validation_Amount_percent__c,Financial_Validation_Amount__c,Operational_Validation_Amount__c,Projected_Validation_Amount__c,Realized_Validation_Amount__c,Project_ID__c,Amount__C,Project_BG__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c from Benefiting_Business_Group__c where Project_ID__c=:projectid1];
        bggRowNum = projectbbg.size();
        return projectbbg;
    }
     
    public void mulBBGDistribution(){
        //try{
        proj = [SELECT Id, Name, CEMT_ID__c, Belt_Candidate_Mentor__r.name,Belt_Project_Sponsor__r.name,Project_Lead__r.name,CreatedById,CreatedDate,Project_Lead_Business_Unit__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Line__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid,Project_Name_Succinct__c,Belt_Project_Type__c, Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Candidate_Mentor__c,Belt_Project_Sponsor__c,Belt_Project_Champion__c,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Project_Completion_Date_Forecast__c,Mentor_Certificate__c,DMAIC_Define__c,DMAIC_Analyze__c,Define_Date_Forecast__c,Analyze_Date_Forecast__c,Define_Status__c,Analyze_Status__c,DMAIC_Measure__c,DMAIC_Improve__c,Measure_Date_Forecast__c,Improve_Design_Date_Forecast__c,Measure_Status__c,Improve_Status__c,DMAIC_Control__c,Control_Verify_Date_Forecast__c,Control_Status__c,Progress_To_Date__c,Next_Steps__c,Project_Type__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Belt_Candidate_Location__c,Project_Created_Date__c,Belt_Project_Phase__c,Project_Duration__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,LastModifiedById,LastModifiedDate,Image_to_direct_for_right_button__c,Message_WF_Guidance__c   FROM QIPP_Project__c WHERE Id =: projID];
        
        projMultipleBBGDistAddList = new List<Benefiting_Business_Group__c>();  
        projMultipleBBGDistDelList = new List<Benefiting_Business_Group__c>();
        list<Benefiting_Business_Group__c> bbg = new list<Benefiting_Business_Group__c>();
        if(proj.Benefitting_Project_BL_Level_4_Org__c!='Global'){
        bbg = [select id,Distribution__c,Total_Validation_Amount__c,Total_Validation_Amount_percent__c,Financial_Validation_Amount__c,Operational_Validation_Amount__c,Projected_Validation_Amount__c,Realized_Validation_Amount__c,name,Project_ID__c,Project_ID__r.Old_Benefitting_Business_Grp__c,project_ID__r.Old_Benefitting_Business_Line__c,project_ID__r.Old_Benefitting_Business_Unit__c,Project_BG__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c from Benefiting_Business_Group__c where Project_ID__c=:projID];
        //bggRowNum = bbg.size();
        }
        else{ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the Global Business Group row.Global Business Group cannot be associated to other Business Groups'));}
        if(bbg.size() >0){
            System.Debug('bbg BG :'+bbg[0].Benefitting_Business_Grp_Functional_Grp__c);
            System.Debug('bbg BU :'+bbg[0].Benefitting_Business_Unit__c);
            System.Debug('bbg BL :'+bbg[0].Benefitting_Business_Line__c);
            System.Debug('bbg BL :'+bbg[0].Operational_Validation_Amount__c);
            //System.Debug('bbg BL :'+bbg[1].Operational_Validation_Amount__c);
            projMultipleBBGDistAddList.addall(bbg);
            mulBGDistRowNum = bbg.size();
        }
       
        //projMultipleBBGDistAddList.add(mulBBGDist);
        //mulBGDistRowNum=1;
        displayPopupBBGDist= true;
        
        //}catch(Exception exe){
        //        System.Debug('**************** Exception occured ***************** ' + exe.getMessage());
        //         System.Debug('**************** Exception occured ***************** ' + exe.getLineNumber());
        //}              
    }
    
    public void showPopupBBGDist() {       
        displayPopupBBGDist= true;
    }

    public void closePopupBBGDist(){       
        displayPopupBBGDist= false; //To hide confirmation popup for submitting approval process
        projMultipleBBGDistDelList.clear();
        projMultipleBBGDistAddList.clear();
    }
    
    public void addBGRowDist(){
        projMultipleBBGDistAddList.add(new Benefiting_Business_Group__c(Project_ID__c=proj.id));
    }
    
    public PageReference delBGRowDist(){
        try{
        mulBGDistRowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
       // system.debug('*** Index = '+mulBGDistRowNum);
       projMultipleBBGDistDelList.add(projMultipleBBGDistAddList.get(mulBGDistRowNum));
        projMultipleBBGDistAddList.remove(mulBGDistRowNum);
        }
        catch (Exception e){}
     return null;
       
    }
    
    public PageReference saveMulBBG(){
        bbgErrorMessages = false;
        boolean flag =false;
        Map<String,String> bbgmap = new Map<String,String>();
        Map<String,String> bbgmbu = new Map<String,String>();
        Map<String,String> bbgnmbu = new Map<String,String>();
        Map<String,String> bbgmbl = new Map<String,String>();
        Map<String,String> bbgnmbl = new Map<String,String>();
        Map<String,String> globalbbg = new Map<String,String>();
       
        String key_bbg = '';
        String key_bgnbu = '';
        String key_bgbu = '';
        String key_bgnbl = '';
        String key_bgbl = '';
        String key_glbl = '';
        
        // Start:Validations 
        try{
            decimal Distributionsum = 0;
            decimal remainDistribution = 0;
            System.Debug('projMultipleBBGDistAddList Size'+projMultipleBBGDistAddList.size());
            System.Debug('111 :'+projMultipleBBGDistAddList[0].Benefitting_Business_Grp_Functional_Grp__c);
                System.Debug('222 :'+projMultipleBBGDistAddList[0].Benefitting_Business_Unit__c);
                System.Debug('333 :'+projMultipleBBGDistAddList[0].Benefitting_Business_Line__c);
            	System.Debug('444 :'+projMultipleBBGDistAddList[0].Operational_Validation_Amount__c);
            	System.Debug('555 :'+projMultipleBBGDistAddList[0].Financial_Validation_Amount__c);
            	System.Debug('666 :'+projMultipleBBGDistAddList[0].Projected_Validation_Amount__c);
            	System.Debug('777 :'+projMultipleBBGDistAddList[0].Realized_Validation_Amount__c);
            For(Benefiting_Business_Group__c mulbbg :projMultipleBBGDistAddList){
            
                globalbbg.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c,'0');
               
            }
            key_glbl='Global';
            
            If(globalbbg.containsKey(key_glbl))
            {
                  For(Benefiting_Business_Group__c mulbbg :projMultipleBBGDistAddList){                  
                //Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c,
                System.Debug('mulbbg.Benefitting_Business_Grp_Functional_Grp__c :'+mulbbg.Benefitting_Business_Grp_Functional_Grp__c);
                System.Debug('mulbbg.Benefitting_Business_Unit__c :'+mulbbg.Benefitting_Business_Unit__c);
                System.Debug('mulbbg.Benefitting_Business_Line__c :'+mulbbg.Benefitting_Business_Line__c);
                
               
                if(mulbbg.Benefitting_Business_Grp_Functional_Grp__c != null &&( mulbbg.Benefitting_Business_Unit__c == null || mulbbg.Benefitting_Business_Line__c == null) ){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                    flag =true; 
                }
                if(mulbbg.Benefitting_Business_Unit__c != null &&( mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null || mulbbg.Benefitting_Business_Line__c == null) ){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                    flag =true; 
                }
                
                if((mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null || mulbbg.Benefitting_Business_Unit__c == null || mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null) ){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                    flag =true; 
                     } 
                   if( mulbbg.Benefitting_Business_Line__c == null && mulbbg.Benefitting_Business_Unit__c == null && mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null ){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Remove blank \'Benefitting Business Group\' row.')); 
                        flag =true; 
                        }
                        
                    if(mulbbg.Benefitting_Business_Unit__c!='Multiple BUs'){
                        key_bgnbu = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+'Multiple BUs';
                        if(bbgmbu.containsKey(key_bgnbu)){   
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to "Multiple Business Unit". You cannot Add "Business Unit" for the same Business Group associated to "Multiple Business Unit"')); 
                                flag =true; 
                            }
                        }
                        
                     key_bbg = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c;
                     if(bbgmap.containsKey(key_bbg)){
                           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the duplicate row.')); 
                           flag =true;
                      }    
                    if(mulbbg.Benefitting_Business_Unit__c=='Multiple BUs'){
                        key_bgbu = mulbbg.Benefitting_Business_Grp_Functional_Grp__c;
                           if(bbgnmbu.containsKey(key_bgbu)){
                             if(flag ==false) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to another Business Unit. You cannot Add "Multiple Business Unit" for the same Business Group')); 
                            flag =true; 
                             }
                        }
                    } 
                     if(mulbbg.Benefitting_Business_Line__c!='Multiple BLs'){
                        key_bgnbl = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+'Multiple BLs';
                        system.debug('key_bgnbl :'+key_bgnbl);
                        if(bbgmbl.containsKey(key_bgnbl)){
                                if(flag ==false) {
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to "Multiple Business Line". You cannot Add "Business Line" for the same Business Group associated to "Multiple Business Line".')); 
                                flag =true; 
                                }
                            }
                        }
                    if(mulbbg.Benefitting_Business_Line__c=='Multiple BLs'){
                        key_bgbl = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c;
                           system.debug('key_bgbl :'+key_bgbl);
                           if(bbgnmbl.containsKey(key_bgbl)){ 
                            if(flag ==false) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to another Business Line. You cannot Add "Multiple Business Line" for the same Business Group')); 
                            flag =true; 
                            }
                        }
                    } 
                    
                    
                   /*  key_bbg = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c;
                     if(bbgmap.containsKey(key_bbg)){
                           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the duplicate row.')); 
                           flag =true;
                      }*/
                    if(mulbbg.Operational_Validation_Amount__c<0 || mulbbg.Financial_Validation_Amount__c<0 || mulbbg.Projected_Validation_Amount__c<0|| mulbbg.Realized_Validation_Amount__c<0){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Validation Amount for the Project Benefitting Business Group Cannot be in Negative Values.')); 
                    flag =true; 
                     }
                     
                     if((projMultipleBBGDistAddList[0].Operational_Validation_Amount__c!=0 || projMultipleBBGDistAddList[0].Financial_Validation_Amount__c!=0 || projMultipleBBGDistAddList[0].Projected_Validation_Amount__c!=0 || projMultipleBBGDistAddList[0].Realized_Validation_Amount__c!=0) && (projMultipleBBGDistAddList[0].Benefitting_Business_Grp_Functional_Grp__c!='Global')){
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Global Benefitting Business Group is selected,Validation Amount for the  Defualt Benefitting Business Group Should Be 0 for all the Benfit types.'));
                        flag =true; 
                     }
                     
                     if((projMultipleBBGDistAddList[0].Benefitting_Business_Grp_Functional_Grp__c=='Global') && (projMultipleBBGDistAddList.size()>1)){
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Primary Business Group is Global, Cannot assign another Business Groups.'));
                        flag =true; 
                     }
                     
                     if((mulbbg.Operational_Validation_Amount__c==0 && mulbbg.Financial_Validation_Amount__c==0 && mulbbg.Projected_Validation_Amount__c==0 && mulbbg.Realized_Validation_Amount__c==0)&& (projMultipleBBGDistAddList.size()>2) && (projMultipleBBGDistAddList[0].Benefitting_Business_Grp_Functional_Grp__c!='Global')){
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'With "Global" as Business Group Only One row will be allowed i.e with the Default Business Group Only Global Business Group is allowed, Cannot be associated with Other Business Groups.'));
                        flag =true; 
                     }
                    System.Debug(mulbbg.Operational_Validation_Amount__c);
                     if(mulbbg.Operational_Validation_Amount__c==null && mulbbg.Financial_Validation_Amount__c==null && mulbbg.Projected_Validation_Amount__c==null && mulbbg.Realized_Validation_Amount__c==null){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Validation Amount for the Benefitting Business Group Cannot Be null for all the Benfit types.')); 
                    flag =true; 
                     }
                    else{
                        bbgmap.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c,'0');
                        bbgmbu.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                        bbgnmbu.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c,'0');
                        bbgmbl.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c,'0');
                        bbgnmbl.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                    }
               
               }  
                
            }
            
           If(!globalbbg.containsKey(key_glbl))
            {
                    For(Benefiting_Business_Group__c mulbbg :projMultipleBBGDistAddList){                  
                //Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c,
                System.Debug('mulbbg.Benefitting_Business_Grp_Functional_Grp__c :'+mulbbg.Benefitting_Business_Grp_Functional_Grp__c);
                System.Debug('mulbbg.Benefitting_Business_Unit__c :'+mulbbg.Benefitting_Business_Unit__c);
                System.Debug('mulbbg.Benefitting_Business_Line__c :'+mulbbg.Benefitting_Business_Line__c);
                
                if(mulbbg.Benefitting_Business_Grp_Functional_Grp__c !='Global'){
                if(mulbbg.Benefitting_Business_Grp_Functional_Grp__c != null &&( mulbbg.Benefitting_Business_Unit__c == null || mulbbg.Benefitting_Business_Line__c == null) ){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                    flag =true; 
                }
                if(mulbbg.Benefitting_Business_Unit__c != null &&( mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null || mulbbg.Benefitting_Business_Line__c == null) ){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                    flag =true; 
                }
                
                if((mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null || mulbbg.Benefitting_Business_Unit__c == null || mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null) ){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                    flag =true; 
                     } 
                   if( mulbbg.Benefitting_Business_Line__c == null && mulbbg.Benefitting_Business_Unit__c == null && mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null ){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Remove blank \'Benefitting Business Group\' row.')); 
                        flag =true; 
                        }
                        
                    if(mulbbg.Benefitting_Business_Unit__c!='Multiple BUs'){
                        key_bgnbu = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+'Multiple BUs';
                        if(bbgmbu.containsKey(key_bgnbu)){   
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to "Multiple Business Unit". You cannot Add "Business Unit" for the same Business Group associated to "Multiple Business Unit"')); 
                                flag =true; 
                            }
                        }
                        
                     key_bbg = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c;
                     if(bbgmap.containsKey(key_bbg)){
                           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the duplicate row.')); 
                           flag =true;
                      }    
                    if(mulbbg.Benefitting_Business_Unit__c=='Multiple BUs'){
                        key_bgbu = mulbbg.Benefitting_Business_Grp_Functional_Grp__c;
                           if(bbgnmbu.containsKey(key_bgbu)){
                             if(flag ==false) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to another Business Unit. You cannot Add "Multiple Business Unit" for the same Business Group')); 
                            flag =true; 
                             }
                        }
                    } 
                     if(mulbbg.Benefitting_Business_Line__c!='Multiple BLs'){
                        key_bgnbl = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+'Multiple BLs';
                        system.debug('key_bgnbl :'+key_bgnbl);
                        if(bbgmbl.containsKey(key_bgnbl)){
                                if(flag ==false) {
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to "Multiple Business Line". You cannot Add "Business Line" for the same Business Group associated to "Multiple Business Line".')); 
                                flag =true; 
                                }
                            }
                        }
                    if(mulbbg.Benefitting_Business_Line__c=='Multiple BLs'){
                        key_bgbl = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c;
                           system.debug('key_bgbl :'+key_bgbl);
                           if(bbgnmbl.containsKey(key_bgbl)){ 
                            if(flag ==false) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to another Business Line. You cannot Add "Multiple Business Line" for the same Business Group')); 
                            flag =true; 
                            }
                        }
                    } 
                    
                    
                   /*  key_bbg = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c;
                     if(bbgmap.containsKey(key_bbg)){
                           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the duplicate row.')); 
                           flag =true;
                      }*/
                    if(mulbbg.Operational_Validation_Amount__c<0 || mulbbg.Financial_Validation_Amount__c<0 || mulbbg.Projected_Validation_Amount__c<0|| mulbbg.Realized_Validation_Amount__c<0){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Validation Amount for the Project Benefitting Business Group cannot be in negative values.')); 
                    flag =true; 
                     }
                     
                     if(mulbbg.Operational_Validation_Amount__c==0 && mulbbg.Financial_Validation_Amount__c==0 && mulbbg.Projected_Validation_Amount__c==0 && mulbbg.Realized_Validation_Amount__c==0){
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Validation Amount for the Benefitting Business Group cannot Be 0 for all the Benfit types.'));
                        flag =true; 
                     }
                    System.Debug(mulbbg.Operational_Validation_Amount__c);
                     if(mulbbg.Operational_Validation_Amount__c==null && mulbbg.Financial_Validation_Amount__c==null && mulbbg.Projected_Validation_Amount__c==null && mulbbg.Realized_Validation_Amount__c==null){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Validation Amount for the Benefitting Business Group Cannot Be null for all the Benfit types.')); 
                    flag =true; 
                     }
                    else{
                        bbgmap.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c,'0');
                        bbgmbu.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                        bbgnmbu.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c,'0');
                        bbgmbl.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c+mulbbg.Benefitting_Business_Line__c,'0');
                        bbgnmbl.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                    }
                  }
                else
                {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the Global Business Group row.Global Business Group cannot be associated to Other Business Groups.')); 
                    flag =true;  
                }
            }
            }
            
           
            if(flag == true){
                
                projectErrorMessages= false;
                bbgErrorMessages = true;
               }   
          
            if(flag == false){
            
                //bbgErrorMessages = false;
                list<Benefiting_Business_Group__c> MultiBbgadd = new list<Benefiting_Business_Group__c>();
                list<Benefiting_Business_Group__c> MultiBbgdel = new list<Benefiting_Business_Group__c>();
                
                projlist = [select id from QIPP_Project__c where id=:projID];
                List<QIPP_Project__c> update_proj_BBG = new List<QIPP_Project__c>();
                for(QIPP_Project__c pj: projlist){
                     update_proj_BBG.add(pj);
                }
                if(projMultipleBBGDistAddList.size()>0){
                    for(Benefiting_Business_Group__c mulbbgfinal :projMultipleBBGDistAddList){
                        if(mulbbgfinal.Project_BG__c != false){
                            //mulbbgfinal.Distribution__c= remainDistribution;
                            break;
                        }
                    }
                }
                MultiBbgdel.addall(projMultipleBBGDistDelList);
                MultiBbgadd.addall(projMultipleBBGDistAddList);
               
                if(MultiBbgdel != null || MultiBbgdel.size() > 0){
                    try{
                        Delete MultiBbgdel;
                    }catch(Exception e){}
                    projMultipleBBGDistDelList.clear();                
                }
                if(MultiBbgadd != null || MultiBbgadd.size() > 0){
                    if(MultiBbgadd.size()<21){
                   // dontFire = true;
                   // Upsert update_proj_BBG;
                    Upsert MultiBbgadd;
                    projMultipleBBGDistAddList.clear();
                    }
                    else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Amount cannot be Distibuted to more than 20 Business Units.')); 
                    bbgErrorMessages = true;
                    return null;
                    }
                    
                } 
                PageReference obj = null;
                displayPopupBBGDist= false;
                //obj = new PageReference('/apex/QIPPProject_Sri?id='+proj.id);   
                //pageredirect = true;
                //return obj;
            }           
        }catch(Exception exe){ 
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Insufficient Privileges:Benefit Distribution cannot be saved.Please contact your Administrator.'));     
          bbgErrorMessages = true;
          return null;
        }  
        
        return null;
    }    
}