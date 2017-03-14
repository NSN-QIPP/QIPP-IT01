public class qippStandardProjectBenefitCtrl{

    public List<QIPP_Benefit__c> Benefits_RelatedList {get;set;}//Benefits_RelatedList is to store the list of benefits of the project
    
    public List<QIPP_Project__c> activityList{get;set;}//activityList is used to store the business activity which is mapped to the project in alist format
    public List<Business_Activity__c> bamDetails{get;set;}//bamDetails is to store the business activity mapping details for the project in a list format based on activityList
    //public String activity{get;set;}//activity is used to store the activity name of the project
    //public String valueStream{get;set;}//valueStream is used to store the value stream of the activity
    //public String businessFunction{get;set;}//businessFunction is used to store business Function of the activity
    
    public List<QIPP_Project__c> projBBGAddList{get;set;}
    public List<QIPP_Project__c> projBBGDelList{get;set;}
    
    public Integer bgRowNum {get;set;}
    
    //public List<Benefiting_Business_Group__c> projMultipleBBGAddList{get;set;}
    //public List<Benefiting_Business_Group__c> projMultipleBBGDelList{get;set;}
    //public Benefiting_Business_Group__c mulBBG;
    public Integer index{get;set;}
    //public Integer mulBGRowNum {get;set;}
    //public boolean displayPopupBBG{get;set;}
    
    public List<QIPP_Benefit__c> Benefits_GrandTotalsList{get;set;}    
    public List<benefitGrandTotals> benefitGrandTotalsList{get;set;}    
    public List<BAMWrapper> BAMWrapperList{get;set;}
    public String projID{get;set;}
    public QIPP_Project__c proj; 
    public Decimal benefitAmount{get;set;}
    
    public Boolean recIsLocked{get;set;}
    public String projState{get;set;}
    public string rolename {get;set;} 
    public string profilename {get;set;}

    public qippStandardProjectBenefitCtrl(ApexPages.StandardController stdController){
        
        this.proj= (QIPP_Project__c)stdController.getRecord();                
        projID = proj.id;
        benefitAmount = proj.Total_Project_Validation_Amount__c;
        projState = proj.Project_State__c;
        recordIsLocked(projID);
        system.debug('@@proj:'+proj);
        
        profile profilena =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        profilename = profilena.Name;
        
        if(UserInfo.getUserRoleId() != null){
            userrole rolenames = [SELECT Id, Name FROM userrole WHERE Id=:UserInfo.getUserRoleId() LIMIT 1];
            rolename = rolenames.Name;
        }

        projBBGAddList = new List<QIPP_Project__c>();
        projBBGDelList = new List<QIPP_Project__c>();
        
        projBBGAddList = [SELECT Id, Name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c,Distribution__c FROM QIPP_Project__c WHERE Id =: projID];
        System.Debug('projBBGAddList Size : '+projBBGAddList.size());
        if(projBBGAddList.size() > 0 ){
            bgRowNum= projBBGAddList.size();
        }else{
            projBBGAddList.add(new QIPP_Project__c(Id=projID,Portfolio_BU__c='None', Project_BL__c='None', Benefitting_Project_BL_Level_4_Org__c='None',Distribution__c=0));
            bgRowNum=1;
        }
        
        getBenefits();
    }

  public List<BAMWrapper> getBAMDetailsMap(){
        BAMWrapperList = new List<BAMWrapper>();

        activityList = [select id,Business_Activity_Mapping__c,Business_Activity_Mapping__r.name,Business_Activity_Mapping_ValueStream__c,Business_Activity_Mapping_BusinessFunc__c,
                        Business_Activity_Mapping2__c,Business_Activity_Mapping2__r.name,Business_Activity_Mapping2_ValueStream__c,Business_Activity_Mapping2_BusinessFunc__c,
                        Business_Activity_Mapping3__c,Business_Activity_Mapping3__r.name,Business_Activity_Mapping3_ValueStream__c,Business_Activity_Mapping3_BusinessFunc__c from QIPP_Project__c where id=:projid];
        
        if(activityList != null && activityList.size() > 0){
            if(activityList[0].Business_Activity_Mapping__c != null){
                BAMWrapperList.add(new BAMWrapper(activityList[0].Business_Activity_Mapping__r.Name, activityList[0].Business_Activity_Mapping_BusinessFunc__c, activityList[0].Business_Activity_Mapping_ValueStream__c));
            }
            if(activityList[0].Business_Activity_Mapping2__c != null){
                BAMWrapperList.add(new BAMWrapper(activityList[0].Business_Activity_Mapping2__r.Name, activityList[0].Business_Activity_Mapping2_BusinessFunc__c, activityList[0].Business_Activity_Mapping2_ValueStream__c));
            }
            if(activityList[0].Business_Activity_Mapping3__c != null){
                BAMWrapperList.add(new BAMWrapper(activityList[0].Business_Activity_Mapping3__r.Name, activityList[0].Business_Activity_Mapping3_BusinessFunc__c, activityList[0].Business_Activity_Mapping3_ValueStream__c));
            }
        }
        system.debug('@@BAMWrapperList:'+BAMWrapperList);
        return BAMWrapperList;
    }
    
     public void getBenefits(){
         try{
            //this.proj= (QIPP_Project__c)projstdController.getRecord();
            //String projectid = proj.id;
            //projectinfo = [select Name , Project_Number__c , Project_Name_Succinct__c ,  Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c ,CoPQ_Benefits_Validation_State__c ,TriggerForDI3ApprovalProcess__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c , DI_State__c, Belt_Project_Phase__c , FieldForControlVerifyPhase__c ,Check_DI_Approval_State__c, Belt_Project_Type__c from QIPP_Project__c where id = :Proj.id];
            Benefits_RelatedList = [select ID , Name ,Improvement_Measure_KPI__c ,
                                         Improvement_Measure_KPI__r.Name,
                                         Benefit_Type__c, 
                                         Project_ID__c,
                                         Unit_of_Measure__c,
                                         Improvement_Measure_Name__c,
                                         Planned_Financial_Savings_Total__c,
                                         Planned_Operational_Savings_Total__c,
                                         Planned_Projected_Savings_Total__c,
                                         Planned_Realized_Savings_Total__c,
                                         Achieved_Financial_Savings_Total__c,
                                         Achieved_Operational_Savings_Total__c,
                                         Achieved_Projected_Savings_Total__c,
                                         Achieved_Realized_Savings_Total__c,
                                         Future_Financial_Savings_Total__c,
                                         Future_Operational_Savings_Total__c,
                                         Future_Projected_Savings_Total__c,
                                         Future_Realized_Savings_Total__c,
                                         Benefit_Amount_Achieved_Future_k__c, 
                                         Benefit_Operational_Achieved_Future_k__c,
                                         Benefit_Projected_Achieved_Future_k__c,
                                         Benefit_Realized_Achieved_Future_k__c,
                                         Total_Benefit_Validation_Amount__c
                                         from QIPP_Benefit__c 
                                         where  Project_ID__c =:projID];
            //return Benefits_RelatedList;
            System.Debug('Benefits_RelatedList.size() : '+Benefits_RelatedList.size());
            System.Debug('Benefits_RelatedList : '+Benefits_RelatedList);
            benefitGrandTotalsList = new List<benefitGrandTotals>();
            benefitGrandTotals bgt = new benefitGrandTotals();
            for(integer i=0;i<=Benefits_RelatedList.size()-1;i++){
                if(i==0 && Benefits_RelatedList[i].Benefit_Type__c == 'Financial Savings'){
                    bgt.plannedGTotal = Benefits_RelatedList[i].Planned_Financial_Savings_Total__c;
                    bgt.achievedGTotal = Benefits_RelatedList[i].Achieved_Financial_Savings_Total__c;
                    bgt.futureGTotal = Benefits_RelatedList[i].Future_Financial_Savings_Total__c;
                    bgt.validationAmount = Benefits_RelatedList[i].Benefit_Amount_Achieved_Future_k__c;
                }else if(i==0 && Benefits_RelatedList[i].Benefit_Type__c == 'Operational Savings'){
                    bgt.plannedGTotal = Benefits_RelatedList[i].Planned_Operational_Savings_Total__c;
                    bgt.achievedGTotal = Benefits_RelatedList[i].Achieved_Operational_Savings_Total__c;
                    bgt.futureGTotal = Benefits_RelatedList[i].Future_Operational_Savings_Total__c;
                    bgt.validationAmount = Benefits_RelatedList[i].Benefit_Operational_Achieved_Future_k__c;
                }else if(i==0 && Benefits_RelatedList[i].Benefit_Type__c == 'Projected Revenue'){
                    bgt.plannedGTotal = Benefits_RelatedList[i].Planned_Projected_Savings_Total__c;
                    bgt.achievedGTotal = Benefits_RelatedList[i].Achieved_Projected_Savings_Total__c;
                    bgt.futureGTotal = Benefits_RelatedList[i].Future_Projected_Savings_Total__c;
                    bgt.validationAmount = Benefits_RelatedList[i].Benefit_Projected_Achieved_Future_k__c;
                }else if(i==0 && Benefits_RelatedList[i].Benefit_Type__c == 'Realized Revenue'){
                    bgt.plannedGTotal = Benefits_RelatedList[i].Planned_Realized_Savings_Total__c;
                    bgt.achievedGTotal = Benefits_RelatedList[i].Achieved_Realized_Savings_Total__c;
                    bgt.futureGTotal = Benefits_RelatedList[i].Future_Realized_Savings_Total__c;
                    bgt.validationAmount = Benefits_RelatedList[i].Benefit_Realized_Achieved_Future_k__c;
                }
                if(i!=0 && Benefits_RelatedList[i].Benefit_Type__c == 'Financial Savings'){
                    bgt.plannedGTotal = bgt.plannedGTotal + Benefits_RelatedList[i].Planned_Financial_Savings_Total__c;
                    bgt.achievedGTotal = bgt.achievedGTotal + Benefits_RelatedList[i].Achieved_Financial_Savings_Total__c;
                    bgt.futureGTotal = bgt.futureGTotal + Benefits_RelatedList[i].Future_Financial_Savings_Total__c;
                    bgt.validationAmount = bgt.validationAmount + Benefits_RelatedList[i].Benefit_Amount_Achieved_Future_k__c;
                }else if(i!=0 && Benefits_RelatedList[i].Benefit_Type__c == 'Operational Savings'){
                    bgt.plannedGTotal = bgt.plannedGTotal + Benefits_RelatedList[i].Planned_Operational_Savings_Total__c;
                    bgt.achievedGTotal = bgt.achievedGTotal + Benefits_RelatedList[i].Achieved_Operational_Savings_Total__c;
                    bgt.futureGTotal = bgt.futureGTotal + Benefits_RelatedList[i].Future_Operational_Savings_Total__c;
                    bgt.validationAmount = bgt.validationAmount + Benefits_RelatedList[i].Benefit_Operational_Achieved_Future_k__c;
                }else if(i!=0 && Benefits_RelatedList[i].Benefit_Type__c == 'Projected Revenue'){
                    bgt.plannedGTotal = bgt.plannedGTotal + Benefits_RelatedList[i].Planned_Projected_Savings_Total__c;
                    bgt.achievedGTotal = bgt.achievedGTotal + Benefits_RelatedList[i].Achieved_Projected_Savings_Total__c;
                    bgt.futureGTotal = bgt.futureGTotal + Benefits_RelatedList[i].Future_Projected_Savings_Total__c;
                    bgt.validationAmount = bgt.validationAmount + Benefits_RelatedList[i].Benefit_Projected_Achieved_Future_k__c;
                }else if(i!=0 && Benefits_RelatedList[i].Benefit_Type__c == 'Realized Revenue'){
                    System.Debug('Benefits_RelatedList[i].Planned_Realized_Savings_Total__c : '+Benefits_RelatedList[i].Planned_Realized_Savings_Total__c);
                    bgt.plannedGTotal = bgt.plannedGTotal + Benefits_RelatedList[i].Planned_Realized_Savings_Total__c;
                    bgt.achievedGTotal = bgt.achievedGTotal + Benefits_RelatedList[i].Achieved_Realized_Savings_Total__c;
                    bgt.futureGTotal = bgt.futureGTotal + Benefits_RelatedList[i].Future_Realized_Savings_Total__c;
                    bgt.validationAmount = bgt.validationAmount + Benefits_RelatedList[i].Benefit_Realized_Achieved_Future_k__c;
                }
                    if(bgt.plannedGTotal>0){
                        bgt.plannedGTotalEuro = bgt.plannedGTotal + ' (k€)';
                    }else if(bgt.plannedGTotal==0){
                        bgt.plannedGTotalEuro = '-';
                    }
                    
                    if(bgt.achievedGTotal>0){
                        bgt.achievedGTotalEuro = bgt.achievedGTotal + ' (k€)';
                    }else if(bgt.achievedGTotal==0){
                        bgt.achievedGTotalEuro = '-';
                    }
                    
                    if(bgt.futureGTotal>0){
                        bgt.futureGTotalEuro = bgt.futureGTotal + ' (k€)';
                    }else if(bgt.futureGTotal==0){
                        bgt.futureGTotalEuro = '-';
                    }
                    
                    if(bgt.validationAmount>0){
                        bgt.validationAmountEuro = bgt.validationAmount + ' (k€)';
                    }else if(bgt.validationAmount==0){
                        bgt.validationAmountEuro = '-';
                    }
            }
            
            benefitGrandTotalsList.add(bgt);
        }catch(Exception exe){
            System.Debug(' ****************************EXCEPTION OCCURES in QIPP_Benefit_View ****************************' + exe.getMessage());
            System.Debug(' ****************************EXCEPTION OCCURES @ Line Number in QIPP_Benefit_View****************************' + exe.getLineNumber());
            //return null;
        }
    }
    
    public PageReference callDummy(){
        return null;
    }

/*
    public void mulBBGDistribution(){
        mulBBG = new Benefiting_Business_Group__c();
        
        mulBBG.Project_ID__c=projID;
        mulBBG.Benefitting_Business_Grp_Functional_Grp__c = 'Applications & Analytics';
        mulBBG.Benefitting_Business_Unit__c = 'A&A Finance';
        mulBBG.Benefitting_Business_Line__c = 'A&A Business Development';
        mulBBG.Distribution__c = 0;
        
        insert mulBBG;
        
        projMultipleBBGAddList = new List<Benefiting_Business_Group__c>();  
        projMultipleBBGDelList = new List<Benefiting_Business_Group__c>();
        
        projMultipleBBGAddList.add(new Benefiting_Business_Group__c(Id=mulBBG.id,Project_ID__c=projID,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c='A&A Finance', Benefitting_Business_Line__c='A&A Business Development',Distribution__c=0));
        mulBGRowNum=1;
        
        displayPopupBBG= true;
    }

    
    public void addBGRow(){
        projMultipleBBGAddList.add(new Benefiting_Business_Group__c(Id=mulBBG.id,Project_ID__c=projID,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c='A&A Finance', Benefitting_Business_Line__c='A&A Business Development',Distribution__c=0));
    }

    public void delBGRow(){
        mulBGRowNum = 0;//Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        projMultipleBBGDelList.add(projMultipleBBGAddList.get(mulBGRowNum));
        projMultipleBBGAddList.remove(mulBGRowNum);   
    }
*/    
    public class benefitGrandTotals{
        public Decimal plannedGTotal{get;set;}
        public Decimal achievedGTotal{get;set;}
        public Decimal futureGTotal{get;set;}
        public Decimal validationAmount{get;set;}
        
        public String plannedGTotalEuro{get;set;}
        public String achievedGTotalEuro{get;set;}
        public String futureGTotalEuro{get;set;}
        public String validationAmountEuro{get;set;}        
    }
    
    public class BAMWrapper{
        public String activityName{get;set;}
        public String businessFunc{get;set;}
        public String valueStream{get;set;}     
        
        public BAMWrapper(){}
        public BAMWrapper(String activityName_val, String businessFunc_val, String valueStream_val){
            activityName = activityName_val;
            businessFunc = businessFunc_val;
            valueStream = valueStream_val;
        }        
    }
    
     public Boolean recordIsLocked(ID projId){
        ID recId = projId;
        recIsLocked = Approval.isLocked(recId);
        System.Debug('recIsLocked : '+recIsLocked );
        return recIsLocked;
    }

}