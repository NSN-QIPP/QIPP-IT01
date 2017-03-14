public with sharing class QIPPLeanProject{
    public QIPP_Project__c proj{get;set;} // proj is used to store all the record values in it
    public Id theId{get;set;} // theId is uded to hold the current record Id while editing
    public String lcertName{get;set;}// lcertName is used to store the values selected Lean Certificate
    public List<QIPP_Contacts__c> loggedInContact{get;set;} //loggedInContact is used to store the logged in user name and to default it in project Lead field
    public List<QIPP_Portfolio__c> portfolioList{get;set;} // portfolioList is used to store the list of portfolio names available in the tool
    public String portfolioName{get;set;} // portfolioName is used to store the value of selected portfolio name from the picklist
    public List<QIPP_Contacts__c> bumbbList{get;set;} // bumbbList is used to store the list of Business Group Mster Black Belt user names available in QIPP Contact object
    public String bumbbName{get;set;}// bumbbName is used to store the value of selected Business Group Master black belt name from the picklist
    public String inAnnualPlan{get;set;}// InAnnualPlan is used to store the value of selected In Annual Plan from the picklist
    public String leanProjectPhase{get;set;}// LeanProjectPhase is used to store the value of selected lean Project Phase from the picklist
    public String projState{get;set;} // projState is used to store the values selected project state
    public String methodology{get;set;} // methodolotgy is used to store the values selected Methodology
    public String projectype{get;set;} // projecttype is used to store the values selected projecttype
    public String diState{get;set;}// diState is used to store the values selected DI State
    public String qtyAwardProj{get;set;}// qtyAwardProj is used to store the values selected Qwality Award Projects
    public String permBeltInfo{get;set;}//permBeltInfo is used to store the values selected Permission to use belt info
    public QIPP_Portfolio__c portfolioRec{get;set;}// portfolioRec is used to store the portfolio record based on selected portfolio name from the picklist
    public String benefitingBG{get;set;}//benefitingBG is used to store the value based on selected portfolio name
    private ApexPages.StandardController projstdController; // Standard Controller variable to pass it to the constructor which hold the current record
    public boolean displayPopup{get; set;}// displayPopup is a boolean variable to enable the popup screen while initiating approval process for a project
    public boolean displayMsgPopup{get; set;}// displayMsgPopup is a boolean variable to enable the popup screen while initiating approval process for a project
    public boolean displaydelPopUp{get; set;}//displaydelPopUp is a boolean variable to enable the popup screen while deleting a project 
    public boolean displayalertPopup{get; set;}//displayalertPopup is a boolean variable to enable the popup screen while deleting a project 
    public boolean displayhighimpactPopup{get; set;}//displayhighimpactPopup is a boolean variable to enable the popup screen while deleting a project 
    public boolean display15kto250kPopup{get; set;}//display15kto250kPopup is a boolean variable to enable the popup screen while deleting a project 
    public boolean displayzeroPopup{get; set;}//displayzeroPopup is a boolean variable to enable the popup screen while deleting a project
    public String recordtypeName{get;set;}//recordtypeName is used to store the Record Type name of the current record
    public String recordtypeID{get;set;}//recordtypeID is used to store the Record Type id of the current record
    public String currentView{get;set;}//currentView is used to store the current view of the record
    public String refererStr{get;set;}//refererStr is used to store referer string of the current record
    public String approvalStatus{get;set;}//approvalStatus is used to store the approval status of the current record
    public Id cloneid{get;set;}//Cloneid is used to store the value of record id while cloning
    public string phasecompleted{get;set;}//phasecompleted is used to store the name of the phase which completed its approval
    public Boolean recIsLocked{get;set;}//recIsLocked is used to store the boolean value based on record locked or not
    public String currPortfolioId{get;set;} //to store the value of Portfolio Id when project created from Portfolio object
    public String currPortfolioName{get;set;} //to store the value of Portfolio Name when project created from Portfolio object
    public String projNameError{get;set;}// Page Error Message for Project Name field
    public String portfolioError{get;set;} //Page Error Message for portfolio Name field
    public String projDescError{get;set;} //Page Error Message for Project Description field
    public String projLeadError{get;set;} //Page Error Message for Project Lead field
    public String pBBGError{get;set;} //Page Error Message for portfolio business Group field
    public String cEMT_MeasureError{get;set;}//Page Error Message for CEMT-ID/Measure-Id field
    public String genericError{get;set;} //Field Error Message for fields
    public String validPortfolioErrorMsg{get;set;}//ValidationErrorMessage check for Portfolio BG and Project Portfolio BG
    public String projSponsError{get;set;} //Page Error Message for project Sponsor field
    public String leanCoachError{get;set;} //Page Error Message for Lean Coach
    public String compDatePlanError{get;set;} //Page Error Message for Completed Date Planned field
    public String compDateForecastError{get;set;} //Page Error Message for Completed Date Forecast
    public String bBUError{get;set;}//page Error Message for Business Benefiting Unit
    public String bBLError{get;set;}//page Error Message for Business Benefiting line
    public String projDocumentError{get;set;}//page Error Message for Project Document field
    public String projtypeError{get;set;}//page Error Message for Project Type field
    public String leanCertError{get;set;}//page Error Message for Lean Certificate field
    public String validPortfolioError{get;set;}//ValidationError check for Portfolio BG and Project Portfolio BG
    public String leanMethodsAppError{get;set;}//page Error Message for Lean Methods Applied field
    public String regexFormatForProjectDocument{get;set;}//Regression Expression for Project Documents
    public Boolean isValidPortfolioName{get;set;}//Validation to check the Valid Portfolio Name
    public static Integer toDelrow {get; set;}
    public static Integer addCount {get; set;}
    private Integer nextrow=0;
    public string customBoReportid{get;set;}
    /*public Blob csvFileBody{get;set;}
Public string csvAsString{get;set;}
Public String[] csvfilelines{get;set;}
Public String[] inputvalues{get;set;}
Public List<string> fieldList{get;set;}*/
    Public List<QIPP_Project__c> sObjectList{get;set;}
    public string profilename {get;set;}//profilename is used to store the current login user profile
    public string rolename {get;set;}//rolename is used to store the current login user role
    public Date forecastDate {get;set;}
    public Decimal benefitAmount{get;set;}//benefitAmount is used to store the sum of totalKPI and totalCOPQ
    public Decimal benefitplanAmount{get;set;}//benefitAmount is used to store the sum of totalKPI and totalCOPQ
    public Decimal totalKPI{get;set;}//totalKPI is used to store the benefit savings value of Finance type
    public Decimal totalCOPQ{get;set;}//totalCOPQ is used to store the benefit savings value of operational type
    public Id projectId{get;set;}//projectId is used to store the Id of Project and used in the condition of Project state on VF page
    //Benefit Related Variables
    public List<QIPP_Benefit__c> Benefits_RelatedList {get;set;}//Benefits_RelatedList is to store the list of benefits of the project
    public List<QIPP_Project__c> activityList{get;set;}//activityList is used to store the business activity which is mapped to the project in alist format
    public List<Business_Activity__c> bamDetails{get;set;}//bamDetails is to store the business activity mapping details for the project in a list format based on activityList
    public String activity{get;set;}//activity is used to store the activity name of the project
    public String valueStream{get;set;}//valueStream is used to store the value stream of the activity
    public String businessFunction{get;set;}//businessFunction is used to store business Function of the activity
    public List<QIPP_Project__c> projBBGAddList{get;set;}
    public List<QIPP_Project__c> projBBGDelList{get;set;}
    public Integer bgRowNum {get;set;}
    public List<Benefiting_Business_Group__c> projMultipleBBGAddList{get;set;}
    public List<Benefiting_Business_Group__c> projMultipleBBGDelList{get;set;}
    public Benefiting_Business_Group__c mulBBG;
    public Integer index{get;set;}
    public Integer mulBGRowNum {get;set;}
    public boolean displayPopupBBG{get;set;}
    public List<QIPP_Benefit__c> Benefits_GrandTotalsList{get;set;}
    public List<benefitGrandTotals> benefitGrandTotalsList{get;set;}
    //--Added by Rahul(02-09-2016)--Start--//
    public List<BAMWrapper> BAMWrapperList{get;set;}
    public boolean editBBG{get;set;}
    public boolean updateChild{get;set;}
    public Benefiting_Business_Group__c mulBBGDist;
    //End of Benefit Related Variables
    public string BGValue{get;set;}
    public string BUValue {get;set;}
    public string BLValue {get;set;}
    public list<Benefiting_Business_Group__c> deleteChildBBG{get;set;}
    public list<Benefiting_Business_Group__c> updateChildBBG{get;set;}
    public List<QIPP_BU_Reporting__c> UpdateBU{get;set;}
    //--Added by Rahul(14-11-2016)--Start--//    
    public QIPPCommonFuctionController cmnFunct;
    //--Added by Rahul(14-11-2016)--End--//
    //--Added by Rahul(E093)(14-11-2016)--Start--//
    public boolean enableInlineEdit{get;set;}
    //--Added by Rahul(E093)(14-11-2016)--End--//
    public boolean projLeadSponsorEqual{get;set;}
    public boolean prjLeadSponsorEqual;
    
    public string LocaleSidKey {get;set;}
    //--E036-Start--//
    public List<SelectOption> bGMBBOptions{get;set;}
    public String pageMode;
    //--E036-End--//
    
    public QIPPLeanProject(ApexPages.StandardController stdController){
        deleteChildBBG= new list<Benefiting_Business_Group__c>();
        updateChildBBG= new list<Benefiting_Business_Group__c>();
        projLeadSponsorEqual = false;
        prjLeadSponsorEqual = false;
        UpdateBU = new  List<QIPP_BU_Reporting__c>();
        User localkey =  [SELECT Id,LocaleSidKey FROM User WHERE Id=:userinfo.getuserid() LIMIT 1];
        LocaleSidKey=localkey.LocaleSidKey;
        System.debug('LocalSideKey'+LocaleSidKey);
        profile profilena =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        profilename = profilena.Name;
        if(UserInfo.getUserRoleId()!= null){
            userrole rolenames = [SELECT Id, Name FROM userrole WHERE Id=:UserInfo.getUserRoleId() LIMIT 1];
            rolename = rolenames.Name;}
        projstdController = stdController;
        proj = (QIPP_Project__c)projstdController.getRecord();
        currPortfolioId = ApexPages.currentPage().getParameters().get('currPortfolio');
        Id theId = ApexPages.currentPage().getParameters().get('id');
        currentView = ApexPages.currentPage().getUrl();
        Cloneid = ApexPages.currentPage().getParameters().get('CloneID');
        recordtypeName = ApexPages.currentPage().getParameters().get('RecordType');
        System.Debug('recordtypeName :'+recordtypeName);
        
        //--Added by Rahul(14-11-2016)--Start--//    
        cmnFunct = new QIPPCommonFuctionController();
        //--Added by Rahul(14-11-2016)--End--//
        //--Added by Rahul(E093)(14-11-2016)--Start--//
        enableInlineEdit = true;
        //--Added by Rahul(E093)(14-11-2016)--End--//
        
        //--E036-Start--//
        bGMBBOptions = new List<SelectOption>();
        pageMode = ApexPages.currentPage().getParameters().get('pgMode');
        system.debug('@@pageMode:'+pageMode);
        //--E036-End--//        
        
        GenericError = 'Error: You must enter a value';//Set Generic Error message added by Manish
        validPortfolioErrorMsg = 'Error: Business/Functional Group should be the same between Portfolio and Project. Please select the appropriate Business/Functional Group.';
        if(theId != null || Cloneid != null){
            recordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: Lean (including Kaizen)').getRecordTypeId();
        }else if(recordtypeName != null){
            recordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get(recordtypeName).getRecordTypeId();
        }        
        
        System.Debug('recordtypeID :'+recordtypeID);
        
        if(theId != null){ 
            editBBG= true;
            updateChild=false;
            proj = [SELECT Id,Project_Sponsor__c,Name,Business_Unit_Master_Black_Belt__r.Name,Distribution__c,Project_Redeloy_Description__c,Total_Validation_Amount_Projected_k__c,Total_Validation_Amount_Realized_k__c, Total_Benefit_Planned_Amount__c, Approver_Financial_Approver__c,Portfolio_Owner_Id__c,Total_Project_Validation_Amount__c,TotalKPI__c,TotalCOPQ__c,Approver_Project_Owner__c, CEMT_ID__c, Belt_Project_Sponsor__r.name,Project_Completion_Date_Forecast__c,Project_Lead__r.name,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c,Project_Lead_Business_Grp__c,CreatedById,CreatedDate,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid,Project_Name_Succinct__c,Lean_Project_Type__c, Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Project_Sponsor__c,Lean_Coach__c,Lean_Coach__r.name,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Progress_To_Date__c,Next_Steps__c,Project_Type__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Owner__c,Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Project_Created_Date__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,Lean_Project_Phase__c,LastModifiedById,LastModifiedDate,Lean__c, In_Annual_Plan__c, Number_of_Kaizens__c, Schedule_Status__c,X5S__c, Root_Cause_Analysis_Fishbone_5_Whys__c, Autonomation__c, SMED__c, Ergonomics__c, Spaghetti_Diagrams__c, Inspections__c, standard_work__c, Kanban__c, Time_Study__c,Levelized_Production__c, Total_Productive_Maintenance_TPM__c,Poka_yoke__c,Visual_Management__c,Workload_Balancing__c,Yamazumi_Charts__c,One_Piece_Flow__c, Pull__c, Other__c,Benefit_Spread_Over_Year__c FROM QIPP_Project__c WHERE Id =: theId];
            recordIsLocked(theId);
            portfolioName = proj.Portfolio_Name__c;
            lcertName = proj.Lean__c;
            inAnnualPlan = proj.In_Annual_Plan__c;
            projState = proj.Project_State__c;
            methodology = proj.Project_Type__c;
            bumbbName = Proj.Business_Unit_Master_Black_Belt__c;
            diState=proj.DI_State__c;
            leanProjectPhase=proj.Lean_Project_Phase__c;
            //proj.Project_Created_Date__c = system.today();
            projectype=proj.Lean_Project_Type__c;
            forecastDate=proj.Project_Completion_Date_Forecast__c;
            totalKPI = proj.TotalKPI__c; //totalKPI is used to get the value of Financial type benefit from benefit object
            totalCOPQ = proj.TotalCOPQ__c; //totalCOPQ is used to get the value of Operational type benefit from benefit object
            benefitAmount = proj.Total_Project_Validation_Amount__c;
            benefitplanAmount = proj.Total_Benefit_Planned_Amount__c;
            projectId=proj.Id;
            permBeltInfo = proj.Permission_to_use_Belt_Info__c;
            qtyAwardProj = proj.Quality_Award_Project__c;
            
        }else if(cloneid != null){
            QIPP_Project__c cloneproj = [SELECT Id,Name,Business_Unit_Master_Black_Belt__r.Name,Lean_Project_Type__c,CEMT_ID__c,Portfolio_Owner_Id__c, Lean_Coach__c,TotalKPI__c,TotalCOPQ__c,Approver_Project_Owner__c,Approver_Financial_Approver__c,Belt_Project_Sponsor__r.name,Project_Completion_Date_Forecast__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Line__c,Project_Lead_Business_Unit__c,Project_Lead__r.name,CreatedById,CreatedDate,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid, Project_Name_Succinct__c,Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Project_Sponsor__c,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Progress_To_Date__c,Next_Steps__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Owner__c, Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Project_Created_Date__c,Lean_Project_Phase__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,LastModifiedById,LastModifiedDate,Lean__c, In_Annual_Plan__c, Number_of_Kaizens__c, Schedule_Status__c, X5S__c, Root_Cause_Analysis_Fishbone_5_Whys__c, Autonomation__c, SMED__c, Ergonomics__c, Spaghetti_Diagrams__c, Inspections__c, standard_work__c, Kanban__c, Time_Study__c,Levelized_Production__c, Total_Productive_Maintenance_TPM__c,Poka_yoke__c,Visual_Management__c,Workload_Balancing__c,Yamazumi_Charts__c,One_Piece_Flow__c, Pull__c, Other__c,Project_Sponsor__c,Benefit_Spread_Over_Year__c FROM QIPP_Project__c WHERE Id =: cloneid];
            System.Debug('recordtypeID c1 :'+recordtypeID+proj.RecordType.Name+'***proj.RecordTypeId'+proj.RecordTypeId);
            portfolioName = proj.Portfolio_Name__c;
            proj = cloneproj.clone(false,true,false,false);
            proj.RecordTypeId = recordtypeID;
            proj.RecordType.Name = '';
            lcertName = proj.Lean__c;
            leanProjectPhase=proj.Lean_Project_Phase__c;
            inAnnualPlan = proj.In_Annual_Plan__c;
            proj.Project_Completion_Date_Forecast__c = null;
            proj.Project_Completion_Date_Actual__c = null;
            proj.Project_Completion_Date_Target__c = null;
            proj.Project_Created_Date__c = system.today();
            bumbbName = Proj.Business_Unit_Master_Black_Belt__c;
            proj.Project_Start_Date__c = null;
            proj.DI_State__c = 'Not Specified';
            projectype=proj.Lean_Project_Type__c;
            portfolioName = proj.Portfolio_Name__c;
            methodology = proj.Project_Type__c;
            proj.Project_State__c = 'In Progress';
            permBeltInfo = proj.Permission_to_use_Belt_Info__c;
            qtyAwardProj = proj.Quality_Award_Project__c;
            //--R17.3 E061--Start--//
            proj.Benefit_Spread_Over_Year__c = false;
            //--R17.3 E061--End--//
        }else{
            proj = new QIPP_Project__c();
             //--E036-Start--//
             bumbbName = '1';
             //--E036-End--//
        }
        //projwrapper=new List<QIPPProjWrapper>();
        //projwrapper.add(new QIPPProjWrapper(nextrow++));
        //system.debug('projwrapper-->'+projwrapper);
        
        loggedInContact = [select id,name from QIPP_Contacts__c where User_License__c =: UserInfo.getUserId()  and Email__c =: UserInfo.getUserEmail()];
        
        if(proj.Id == null){
            projState = 'In Progress';
            diState = 'Not Specified';
            methodology = 'Lean (including Kaizen)';
            //proj.Permission_to_use_Belt_Info__c = 'Yes';
            proj.Project_Created_Date__c = system.today();
            permBeltInfo = 'Yes';
            qtyAwardProj ='No';
            if(currPortfolioId != null){
                portfolioName = currPortfolioId;
                portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: currPortfolioId];
                proj.Portfolio_BU__c = portfolioRec.Portfolio_Business_Unit__c;
                
            }
            if(loggedInContact.size()>0){
                proj.Project_Lead__c = loggedInContact[0].id;
            }
        }
        if(currentView.contains('qippleanprojectdetailview') || currentView.contains('QIPPLeanProjectDetailView')){
            getBenefits();
        }
        //benefiting business group section lineItems - below code added by Haripriya 23/08/2016
        projBBGAddList = new List<QIPP_Project__c>();
        projBBGDelList = new List<QIPP_Project__c>();
        
        projBBGAddList = [SELECT Id, Name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c,Distribution__c FROM QIPP_Project__c WHERE Id =: proj.id];
        System.Debug('projBBGAddList Size : '+projBBGAddList.size());
        if(projBBGAddList.size() > 0 )
        {
            bgRowNum= projBBGAddList.size();
        }
        else
        {
            projBBGAddList.add(new QIPP_Project__c(Id=proj.id,Portfolio_BU__c='None', Project_BL__c='None', Benefitting_Project_BL_Level_4_Org__c='None',Distribution__c=0));
            bgRowNum=1;
        }
        
        //check for inline edit enable for project
        if(proj.Id != null && proj.Project_State__c != null && proj.Project_State__c != '' && 
           (proj.Project_State__c == 'Complete' || proj.Project_State__c == 'Closed') && 
           (roleName != null && roleName != '' && roleName == 'QIPP Project Lead')){
               enableInlineEdit = false;
           }
        if(proj.Id != null && proj.Project_State__c != null && proj.Project_State__c != '' && proj.Project_State__c == 'Closed' && (roleName != null && roleName != '' && roleName == 'QIPP Portfolio Owner')){
            enableInlineEdit = false;
        }
        if(proj.Id != null && profilename == 'Nokia QIPP Project Viewer'){
            enableInlineEdit = false;
        }
        system.debug('@@bumbbName:'+bumbbName);
        //--E036-Start--//
        bGMBBList();
        //--E036-End--//
    }
    public void closePopupBBG() {       
        displayPopupBBG= false; //To hide confirmation popup for submitting approval process  
    }
    public void addBGRow(){
        projMultipleBBGAddList.add(new Benefiting_Business_Group__c(Id=mulBBG.id,Project_ID__c=proj.id,Benefitting_Business_Grp_Functional_Grp__c='Applications & Analytics', Benefitting_Business_Unit__c='A&A Finance', Benefitting_Business_Line__c='A&A Business Development',Distribution__c=0));
    }
    public void delBGRow()
    {
        mulBGRowNum = 0;//Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        projMultipleBBGDelList.add(projMultipleBBGAddList.get(mulBGRowNum));
        projMultipleBBGAddList.remove(mulBGRowNum);   
    }
    public void getBAMDetails_X(){
        activityList = [select id,Business_Activity_Mapping__c,Business_Activity_Mapping__r.name from QIPP_Project__c where id=:proj.id];
        bamDetails = [select id,name,Business_Function__c,Value_Stream__c from Business_Activity__c where name=:activityList[0].Business_Activity_Mapping__r.name];
        //System.debug('SIZE: '+bamDetails.size() +' ' +bamDetails[1].Value_Stream__c);
        if(bamDetails.size()>1){
            activity = bamDetails[0].name;
            valueStream='';
            businessFunction = '';
            for(integer i=0;i<bamDetails.size();i++){
                if(i==0){
                    valueStream = bamDetails[i].Value_Stream__c;
                    businessFunction = bamDetails[i].Business_Function__c;
                }
                if(!valueStream.contains(bamDetails[i].Value_Stream__c)){
                    valueStream = valueStream+', '+bamDetails[i].Value_Stream__c;
                }
                if(!businessFunction.contains(bamDetails[i].Business_Function__c))
                    businessFunction = businessFunction+', '+bamDetails[i].Business_Function__c; 
            }
        }else if(bamDetails.size()>0){
            activity = bamDetails[0].name;
            valueStream=bamDetails[0].Value_Stream__c;
            businessFunction = bamDetails[0].Business_Function__c;
        }
    }
    
    public List<BAMWrapper> getBAMDetailsMap(){
        BAMWrapperList = new List<BAMWrapper>();
        
        Set<String> selctedActivities = new Set<String>();
        activityList = [select id,Business_Activity_Mapping__c,Business_Activity_Mapping__r.name,Business_Activity_Mapping2__c,Business_Activity_Mapping2__r.name,Business_Activity_Mapping3__c,Business_Activity_Mapping3__r.name from QIPP_Project__c where id=:proj.id];
        if(activityList[0].Business_Activity_Mapping__c != null){
            selctedActivities.add(activityList[0].Business_Activity_Mapping__r.name);
        }
        if(activityList[0].Business_Activity_Mapping2__c != null){
            selctedActivities.add(activityList[0].Business_Activity_Mapping2__r.name);
        }
        if(activityList[0].Business_Activity_Mapping3__c != null){
            selctedActivities.add(activityList[0].Business_Activity_Mapping3__r.name);
        }
        system.debug('@@selctedActivities:'+selctedActivities);
        
        if(selctedActivities != null && selctedActivities.size() > 0){
            bamDetails = [select id,name,Business_Function__c,Value_Stream__c from Business_Activity__c where name in: selctedActivities];
            
            Map<String,String> mapNameToValue = new Map<String,String>();
            Map<String,String> mapNameToBusFunc = new Map<String,String>();            
            
            if(bamDetails != null && bamDetails.size() > 0){
                for(Business_Activity__c ba : bamDetails){
                    String valueStream = '';
                    String busFunction = '';
                    
                    if(mapNameToValue != null && mapNameToValue.containsKey(ba.Name)){
                        if(mapNameToValue.get(ba.Name) != ba.Value_Stream__c)
                            valueStream = mapNameToValue.get(ba.Name)+','+ba.Value_Stream__c;
                    }else{
                        valueStream = ba.Value_Stream__c;
                    }
                    if(valueStream != '')
                        mapNameToValue.put(ba.Name, valueStream);
                    
                    if(mapNameToBusFunc != null && mapNameToBusFunc.containsKey(ba.Name)){
                        if(mapNameToBusFunc.get(ba.Name) != ba.Business_Function__c)
                            busFunction = mapNameToBusFunc.get(ba.Name)+','+ba.Business_Function__c;
                    }else{
                        busFunction = ba.Business_Function__c;
                    }
                    if(busFunction != '')
                        mapNameToBusFunc.put(ba.Name, busFunction);
                }
                system.debug('@@mapNameToValue:'+mapNameToValue);
                system.debug('@@mapNameToBusFunc:'+mapNameToBusFunc);
                
                for(String activityName : selctedActivities){
                    BAMWrapperList.add(new BAMWrapper(activityName, mapNameToBusFunc.get(activityName), mapNameToValue.get(activityName)));
                }
                system.debug('@@BAMWrapperList:'+BAMWrapperList);
            }
        }
        return BAMWrapperList;
    }
    public PageReference callDummy(){
        return null;
    }
    public pageReference BBGUpdated(){
        // list<Benefiting_Business_Group__c> duplBBGcheck= [select Distribution__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c from Benefiting_Business_Group__c where Project_ID__c=:proj.id and Project_BG__c!=true];
        try{
            list<Benefiting_Business_Group__c> editBBGvalues= [select Distribution__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c,Financial_Validation_Amount__c,Operational_Validation_Amount__c,Projected_Validation_Amount__c,Realized_Validation_Amount__c from Benefiting_Business_Group__c where Project_ID__c=:proj.id and Project_BG__c=true];
            list<Benefiting_Business_Group__c> delBBGvalues= [select Distribution__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c,Benefitting_Business_Line__c,Financial_Validation_Amount__c,Operational_Validation_Amount__c,Projected_Validation_Amount__c,Realized_Validation_Amount__c from Benefiting_Business_Group__c where Project_ID__c=:proj.id and Project_BG__c=false];
            if(editBBGvalues.size()>0){
                for(Benefiting_Business_Group__c bbg : editBBGvalues){
                    bbg.Benefitting_Business_Grp_Functional_Grp__c = proj.Portfolio_BU__c;
                    bbg.Benefitting_Business_Unit__c = proj.Project_BL__c;
                    bbg.Benefitting_Business_Line__c = proj.Benefitting_Project_BL_Level_4_Org__c;
                    bbg.Operational_Validation_Amount__c=proj.TotalKPI__c;
                    bbg.Financial_Validation_Amount__c=proj.TotalCOPQ__c;
                    bbg.Projected_Validation_Amount__c=proj.Total_Validation_Amount_Projected_k__c;
                    bbg.Realized_Validation_Amount__c=proj.Total_Validation_Amount_Realized_k__c;
                    updateChildBBG.add(bbg);
                }
                upsert updateChildBBG;
            }
            
            if(delBBGvalues.size()>0){
                for(Benefiting_Business_Group__c delbbg : delBBGvalues){
                    deleteChildBBG.add(delbbg);
                }
                delete deleteChildBBG;
            }
        }
        catch(Exception e){
            System.debug('Exception in BBGUpdated method : '+e.getMessage());
            
        }
        return null;
    }       
    
    //getBenefits method to get all the Benefits associated with the Project -- Added by Manish
    public void getBenefits(){
        try{
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
                                    Benefit_Realized_Achieved_Future_k__c
                                    from QIPP_Benefit__c 
                                    where  Project_ID__c =:proj.id];
            //return Benefits_RelatedList;
            System.Debug('Benefits_RelatedList.size() : '+Benefits_RelatedList.size());
            
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
    
    //getPortfolioValues method to get all the protfolios available in the tool limit 80 -- Added by Manish
    public List<SelectOption> getPortfolioValues(){
        try{
            List<SelectOption> optns = new List<Selectoption>();
            portfolioList = [select id,name from QIPP_Portfolio__c where Lean_including_Kaizen__c=:true and Portfolio_Status__c =:'Active' ORDER BY name];
            optns.add(new SelectOption('1','--Select One--'));
            for(QIPP_Portfolio__c pf : portfolioList){
                optns.add(new selectOption(pf.Id, pf.Name));
            }
            if(portfolioList.size()>0){
                return optns;
            }else
                return null;
        }catch(Exception exe){
            System.Debug(' ****************************EXCEPTION OCCURES in getPortfolioValues ****************************' + exe.getMessage());
            return null;
        }
    }
    
    //getPortfolioBBGValue method to get the Portfoilio business unit associated with the selected portfolio -- Added by Manish
    public PageReference getPortfolioBBGValue(){
        try{
            if(portfolioName != '1'){
                portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: portfolioName];
                proj.Portfolio_BU__c = portfolioRec.Portfolio_Business_Unit__c;
            }else
                proj.Portfolio_BU__c = '';
                
            //--E036-Start--//
            //bumbbName = '1';
            bGMBBList();
            //--E036-End--//                
            return null;       
        }catch(Exception exe){
            System.Debug(' ****************************EXCEPTION OCCURES in getPortfolioBBGValue ****************************' + exe.getMessage());
            return null;
        }
    }
    
    //getleanCertificatValues method to get the picklist values of Lean Certificate for Lean -- Added by Manish
    public List<SelectOption> getleanCertificatValues(){
        try{
            List<SelectOption> lCert_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Lean__c.getDescribe();
            List<Schema.PicklistEntry> lc = fieldResult.getPicklistValues();
            //lCert_optns.add(new SelectOption('1','--None--'));
            for( Schema.PicklistEntry f : lc)
            {
                lCert_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return lCert_optns;
        }catch(Exception exe){return null;}
    }
    //getpermBeltInfoValues method to get the picklist values of Permission to use belt info for lean -- Added by Manish
    public List<SelectOption> getpermBeltInfoValues(){
        try{
            List<SelectOption> permBelt_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Permission_to_use_Belt_Info__c.getDescribe();
            List<Schema.PicklistEntry> ap = fieldResult.getPicklistValues();
            //inAnnPlan_optns.add(new SelectOption('1','--None--'));
            for( Schema.PicklistEntry f : ap)
            {
                permBelt_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return permBelt_optns;
        }catch(Exception exe){return null;}
    }
    
    //getleanAppliedMethods method to get the picklist values of Lean Method Applied for lean -- Added by Manish
    /*public List<SelectOption> getleanAppliedMethods(){
try{
List<SelectOption> appMethd_optns = new List<Selectoption>();
Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Lean_Methods_Applied__c.getDescribe();
List<Schema.PicklistEntry> lam = fieldResult.getPicklistValues();
for( Schema.PicklistEntry f : lam)
{
appMethd_optns.add(new SelectOption(f.getLabel(), f.getValue()));
}     
return appMethd_optns;
}catch(Exception exe){
System.Debug(' ****************************EXCEPTION OCCURES in getleanAppliedMethods ****************************' + exe.getMessage());
return null;
}
}*/
    
    //getschedulestatusvalues method to get the picklist values of Schedule Status for lean -- Added by Manish
    public List<SelectOption> getqtyAwardProjectValues(){
        try{
            List<SelectOption> qtyawdproj_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Quality_Award_Project__c.getDescribe();
            List<Schema.PicklistEntry> qap = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry f : qap)
            {
                qtyawdproj_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return qtyawdproj_optns;
        }catch(Exception exe){return null;}
    }
    
    //getleanprojectphasevalues method to get the picklist values of lean Project Phase for lean -- Added by Manish
    public List<SelectOption> getleanprojectphasevalues(){
        try{
            List<SelectOption> leanProjPhase_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Lean_Project_Phase__c.getDescribe();
            List<Schema.PicklistEntry> lpp = fieldResult.getPicklistValues();
            leanProjPhase_optns.add(new SelectOption('1','--None--'));
            for( Schema.PicklistEntry f : lpp)
            {
                leanProjPhase_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return leanProjPhase_optns;
        }catch(Exception exe){return null;}
    }
    
    //getProjectStateValues method to get the picklist values of Lean ProjectState for Lean  -- Added by Manish
    public List<SelectOption> getProjectStateValues(){
        System.Debug(' ***************************'+rolename);
        try{
            List<SelectOption> projState_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Project_State__c.getDescribe();
            List<Schema.PicklistEntry> ps = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry f : ps)
            {
                if(rolename=='QIPP Project Lead'){
                    if((f.getValue() != 'Not Started')){
                        if ((f.getValue() != 'Complete') ){
                            if ((f.getValue() != 'Closed')){
                                projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));
                            }
                        }
                    }
                }
                else if(rolename=='QIPP Portfolio Owner'){
                    if((f.getValue() != 'Not Started') && (f.getValue() != 'Closed') && (f.getValue() != 'Complete') && projState != 'Complete'){
                        projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                    } 
                    else if ((f.getValue() != 'Not Started') && (f.getValue() != 'Closed') && projState == 'Complete'){
                        projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                    } 
                }
                else if (rolename=='QIPP Portfolio Manager' || rolename=='QIPP Admin' || profilename=='System Administrator'){
                    if((f.getValue() != 'Not Started') && (f.getValue() != 'Complete') && projState != 'Complete'){
                        projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                    } 
                    else if ((f.getValue() != 'Not Started') && projState == 'Complete'){
                        projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                    }
                }
                else {
                    if((f.getValue() != 'Not Started')){
                        projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                    }
                }
            }     
            return projState_optns;
        }catch(Exception exe){return null;}
    }
    
    //getMethodologyValues method to get the picklist values from Project Type picklist for Lean using custom labels  -- Added by Manish
    public List<SelectOption> getMethodologyValues(){
        try{
            List<SelectOption> methodology_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Project_Type__c.getDescribe();
            List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry f : mc)
            {
                
                if(f.getValue()==Label.LEANProject){
                    methodology_optns.add(new SelectOption(f.getLabel(), f.getValue()));
                }
            }     
            return methodology_optns;
        }catch(Exception exe){return null;}
    }
    
    //getDIStateValues method to get the values from DI State picklist from DI_State__c for Lean -- Added by Manish
    public List<SelectOption> getDIStateValues(){
        try{
            List<SelectOption> diState_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.DI_State__c.getDescribe();
            List<Schema.PicklistEntry> dis = fieldResult.getPicklistValues();
            diState_optns.add(new SelectOption('--None--','--None--'));
            for( Schema.PicklistEntry f : dis)
            {
                diState_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return diState_optns;
        }catch(Exception exe){return null;}
    }
    
    //getProjectTypeValues method to get the picklist values for Lean_Project_Type__c for Lean //Written by Manish
    public List<SelectOption> getProjectTypeValues(){
        try{
            List<SelectOption> lprojtype_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Lean_Project_Type__c.getDescribe();
            List<Schema.PicklistEntry> ptyp = fieldResult.getPicklistValues();
            lprojtype_optns.add(new SelectOption('1','--None--'));
            for( Schema.PicklistEntry f : ptyp)
            {
                lprojtype_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return lprojtype_optns;
        }catch(Exception exe){return null;}
    }
    
    /*//Analysis inprogress for next release
public void addRows()
{
for (Integer row=0; row<addCount; row++)
{
projwrapper.add(new QIPPProjWrapper(nextrow++));
system.debug('projwrapper-->'+projwrapper);
}
}

//Analysis inprogress for next release
public void delRow()
{
Integer toDelPos=-1;
for (Integer row=0; row<projwrapper.size(); row++)
{   system.debug('projwrapper.size()-->'+projwrapper.size());
system.debug('toDelrow-->'+toDelrow);
if (projwrapper[row].addrows==toDelrow)
{
toDelPos=row;
}
}

if (-1!=toDelPos)
{
projwrapper.remove(toDelPos);
}
}

//Analysis inprogress for next release
public class QIPPProjWrapper{
public QIPP_Project__c QIPPProj{get; private set;}
public Integer addrows{get; private set;}

public QIPPProjWrapper(Integer addrow){
addrows =addrow;
QIPPProj = new QIPP_Project__c (Target__c='release ' + addrows);
system.debug('QIPPProj -->'+QIPPProj );
system.debug('addrows-->'+addrows);
}
}*/
    //isValidPortfolioName method to get the Portfolio Record from Portfolio Project -- Added by Manish
    public void isValidPortfolioName(){
        if((currentView.contains('qippleanprojectdetailview') || currentView.contains('QIPPLeanProjectDetailView')) && proj.Portfolio_Name__c != null){
            portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: proj.Portfolio_Name__c];
            if(proj.Portfolio_BU__c == portfolioRec.Portfolio_Business_Unit__c){
                isValidPortfolioName = true;
            }else
                isValidPortfolioName = false;
        }
    }
    //getBumbbValues method to get all the protfolios available in the tool limit 80
    public List<SelectOption> getBumbbValues(){
        try{
            //--E036-Start--//
            system.debug('@@proj state:'+proj.Project_State__c+'**BG:'+bumbbName+'**currentView:'+currentView);
            if((proj.Project_State__c != null && proj.Project_State__c != '' && proj.Project_State__c != 'Complete' && proj.Project_State__c != 'Closed') && 
                    (proj.Id != null && !recordIsLocked(proj.Id)) &&
                    (currentView.containsIgnoreCase('qippleanprojecteditview') && pageMode != null && pageMode != '' && pageMode == 'edit')){
                bumbbName = '1';
            }
            system.debug('@@BG:'+bumbbName);
            //--E036-End--//

            List<SelectOption> bumbb_optns = new List<Selectoption>();
            bumbbList = [select id,name from QIPP_Contacts__c where User_License__c != null and User_License__r.Profile.Name = 'Nokia QIPP Project Lead' and User_License__r.isactive = true and (CoPQ_Role_1__c =: 'Business Unit Master Black Belt' or CoPQ_Role_2__c =: 'Business Unit Master Black Belt' or CoPQ_Role_3__c =: 'Business Unit Master Black Belt' or CoPQ_Role_4__c =: 'Business Unit Master Black Belt') and Contact_State__c =:'Active' ORDER BY name];
            bumbb_optns.add(new SelectOption('1','--Select One--'));
            for(QIPP_Contacts__c bumbbUser : bumbbList){
                bumbb_optns.add(new selectOption(bumbbUser.Id, bumbbUser.Name));
            }
            if(bumbbList.size()>0){
                return bumbb_optns;
            }else
                return null;
        }catch(Exception e){return null;}
    }
    
    //--E036-Start--//
    public PageReference bGMBBList(){
        try{
            bGMBBOptions = new List<Selectoption>();
            Map<String, String> mapBGContact = new Map<String, String>();
            
            system.debug('@@BU:'+proj.Portfolio_BU__c);
            system.debug('@@Portfolio:'+portfolioName+'-Business Unit:'+proj.Project_BL__c+'-bumbbName:'+bumbbName+'-'+proj.Business_Unit_Master_Black_Belt__r.Name);
            //if(portfolioName != null && portfolioName != '--None--' && proj.Project_BL__c != null){
            if(portfolioName != null && portfolioName != '1'){
                //List<QIPP_BG_BU_BL_Contact_Mapping__c> bumbbList = [select id, Business_Group_Master_Black_Belt__c,Business_Group_Master_Black_Belt__r.Name from QIPP_BG_BU_BL_Contact_Mapping__c where Portfolio_Name__c =: portfolioName And Benefitting_Business_Group__c =: proj.Portfolio_BU__c And (Benefitting_Business_Unit__c =: proj.Project_BL__c Or Benefitting_Business_Unit__c = 'All Unit') ORDER BY name];
                List<QIPP_BG_BU_BL_Contact_Mapping__c> bumbbList = [select id, Business_Group_Master_Black_Belt__c,Business_Group_Master_Black_Belt__r.Name from QIPP_BG_BU_BL_Contact_Mapping__c where Portfolio_Name__c =: portfolioName ORDER BY name];
                if(bumbbList != null && bumbbList.size() > 0){

                    if((proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'Complete' || proj.Project_State__c == 'Closed') && (currentView.containsIgnoreCase('qippleanprojecteditview'))) || 
                            ((proj.Id != null && recordIsLocked(proj.Id)) && (currentView.containsIgnoreCase('qippleanprojecteditview')))){
                        if(bumbbName != null && bumbbName != '' && bumbbName != '1'){
                            mapBGContact.put(bumbbName, proj.Business_Unit_Master_Black_Belt__r.Name);
                        }
                    }
                    for(QIPP_BG_BU_BL_Contact_Mapping__c bumbbUser : bumbbList){
                        mapBGContact.put(bumbbUser.Business_Group_Master_Black_Belt__c, bumbbUser.Business_Group_Master_Black_Belt__r.Name);
                    }
                    
                    //if(mapBGContact.size() > 1){
                        bGMBBOptions.add(new SelectOption('1','--Select One--'));
                    //}
                    for(String con : mapBGContact.keySet()){
                        bGMBBOptions.add(new SelectOption(con, mapBGContact.get(con)));
                    }
                }else{
                    bGMBBOptions = getBumbbValues();
                }
            } else {
                bGMBBOptions.add(new SelectOption('1','--Select One--'));
            }
            system.debug('@@bGMBBOptions:'+bGMBBOptions);
            return null;
         }catch(Exception e){return null;}
    }
    //--E036-End--//        
    
    //initiateErrMsgVariables method to initiate all the Error Messages variables -- Added by Manish
    public void initiateErrMsgVariables(){
        projNameError = null;
        projLeadError = null;
        portfolioError = null;
        projDescError = null;
        pBBGError = null;
        cEMT_MeasureError = null;
        projSponsError = null;
        //bUMBBError = null;
        bBLError = null;
        bBUError = null;
        projDocumentError = null;
        projtypeError = null;
        validPortfolioError = null;
        leanCertError = null;
        leanMethodsAppError = null;
        compDatePlanError = null;
        compDateForecastError = null;
        //scheduleStatusError = null;
    }
    // errorMessages method is to findout whether the field is empty and if it is empty it will assign approriate error msg to respective variable and make it availble to dispaly a VF page message
    public void errorMessages(){
        isValidPortfolioName();
        if(proj.Project_Name_Succinct__c == null || proj.Project_Name_Succinct__c == ''){
            projNameError='Project Name: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjNameError));
        }//Project Name Error
        if(proj.Project_Lead__c == null){
            projLeadError = 'Project Lead: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjLeadError));
        }//Project Lead Error
        if((currentView.contains('qippleanprojecteditview') || currentView.contains('QIPPLeanProjectEditView')) && portfolioName == '1'){
            portfolioError = 'Portfolio Name: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,PortfolioError));               
        }//Portfolio Name Error
        if(proj.Project_Description_Detailed__c =='1800 Character Limit' || proj.Project_Description_Detailed__c == null || proj.Project_Description_Detailed__c == ''){
            projDescError = 'Project Description: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjDescError));              
        }//Project Description Error
        if(proj.Portfolio_BU__c == null || proj.Portfolio_BU__c == ''){
            pBBGError = 'Benefitting Business Grp/Functional Grp: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,PBBGError));               
        }//Portfolio Name Error
        if (proj.CEMT_ID__c == null || proj.CEMT_ID__c == ''){
            cEMT_MeasureError = 'Measure-ID/CEMT-ID: Blank space not accepted, please use Not Applicable instead.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,CEMT_MeasureError));
        }//Project CEMT-ID and MEASURE-ID Error
        if(proj.Belt_Project_Sponsor__c == null){
            projSponsError = 'Project Sponsor: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjSponsError));
        }//Project Sponsor Error
        if((currentView.contains('qippleanprojecteditview') || currentView.contains('QIPPLeanProjectEditView')) && projectype == '1'){
            projtypeError = 'Project Type: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,projtypeError));
        }//Project Type Error
        if((currentView.contains('qippleanprojectdetailview') || currentView.contains('QIPPLeanProjectDetailView')) && proj.Lean_Project_Type__c == null){
            projtypeError = 'Project Type: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,projtypeError));
        }//Project Type Error on Detail page
        if(proj.Project_BL__c == null){
            bBUError = 'Benefitting Business Unit: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,BBUError));
        }//Benefiting Business Unit Error
        if(proj.Benefitting_Project_BL_Level_4_Org__c == null ){
            bBLError = 'Benefitting Business Line: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,BBLError));
        }//Benefiting Business Line Error
        if(lcertName == null){
            leanCertError = 'Certificate Project?: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,leanCertError));
        }//LeanCertificateProject
        if(proj.Project_Completion_Date_Target__c == null){
            compDatePlanError = 'Completion Date - Planned: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,compDatePlanError));
        }//Completion Date Planned
        if(proj.Project_Completion_Date_Forecast__c == null){
            compDateForecastError = 'Completion Date - Forecast: Please enter the value.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,compDateForecastError));
        }//CompletionDate Forecast
        //--Added by Rahul(E122)(14-11-2016)(25-11-2016)-- adding if condition --Start--//
        system.debug('Project_Document__c check state *****'+proj.Project_State__c);
        system.debug('projState check state *****'+proj.Project_State__c);
        if(proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'In Progress')){
            if(proj.Project_Document__c != null){ 
                String pdoc = proj.Project_Document__c;
                regexFormatForProjectDocument ='(^((http|https|ftp)://)(www[.])?([a-zA-Z0-9]|-)+?([.][a-zA-Z0-9+&@#/%=~_|$(-|/|=|?)??]+?)+?$)';
                Pattern urlFormat = Pattern.Compile(regexFormatForProjectDocument);
                Matcher format_of_url = urlFormat.matcher(proj.Project_Document__c);
                if (!(format_of_url.Matches()) || (pdoc.length() < 10)){
                    projDocumentError = 'Project Document: Enter a valid url where project doc is stored.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,projDocumentError));
                }
            }//Project Document Error
        }
        //--Added by Rahul(E122)(14-11-2016)-- adding if condition --End--//            
        if((currentView.contains('QIPPLeanProjectEditView') || currentView.contains('qippleanprojecteditview')) && (portfolioName != '1' || currPortfolioId != null)){//if (proj.Portfolio_Name__c != null && currPortfolioId == null){
            try{
                proj.Portfolio_Name__c = portfolioName;
                System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);
            }catch(Exception e){System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);System.Debug('Portfolio_Name__c : '+proj.Portfolio_Name__c);}
        }
        System.Debug('ProjLeadError : '+ProjLeadError);
        if(bumbbName != '1'){    
            proj.Business_Unit_Master_Black_Belt__c = bumbbName;
            System.Debug('BumbbName !1 : '+bumbbName+'----'+proj.Business_Unit_Master_Black_Belt__c);
        }//Portfolio Name Validation
        
        //--Added by Rahul(E122)(14-11-2016)(25-11-2016)-- adding if condition --Start--//
        if(proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'In Progress')){
            
            if((currentView.contains('QIPPLeanProjectDetailView') || currentView.contains('qippleanprojectdetailview')) &&(proj.Project_Completion_Date_Forecast__c < system.Today()) && (proj.Project_State__c == 'In Progress'))
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Completion Date - Forecast should be equal or greater than Current Date'));
                //return null;
            }//Project Completion Date Validation Error on Detail Page
            if((currentView.contains('QIPPLeanProjectEditView') || currentView.contains('qippleanprojecteditview')) && (proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Completion Date - Forecast should be equal or greater than Current Date'));
                //return null;
            }//Project Completion Date Validation Error on Edit Page
            
            /*if((currentView.contains('QIPPLeanProjectDetailView') || currentView.contains('qippleanprojectdetailview')) &&(proj.Project_Completion_Date_Forecast__c < system.Today()) && ((proj.Project_State__c == 'On Hold') || (proj.Project_State__c == 'Canceled')))
{
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Completion Date - Forecast should be equal or greater than Current Date'));
//return null;
}//Project Completion Date Validation Error on Detail Page*/
            
            //--Added by Rahul(E086)(14-11-2016)-- --Start--//
            //validate project finance is match contact BG with cunfiguration values at project creation
            if(proj.Id == null && proj.Finance_Approver__c != null && !cmnFunct.validContactBG(proj.Finance_Approver__c,'Finance Approver')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Provided \'Finance Approver\' Contact does not exist or does not match filter criteria.'));
            }
            
            if(proj.Id == null && proj.Belt_Assigned__c != null && !cmnFunct.validContactBG(proj.Belt_Assigned__c,'L6S Belt Assigned')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Provided \'L6S Belt Assigned\' Contact does not exist or does not match filter criteria.'));
            }
            //--Added by Rahul(E086)(14-11-2016)-- --End--//
        }
        //--Added by Rahul(E122)(14-11-2016)-- adding if condition --End--//      
    }
    
    // save method to save the new project/ edited project/ cloned project
    public pagereference save(){
        System.Debug('BUMBB*** : '+ Proj.Business_Unit_Master_Black_Belt__c);
        system.debug('BUMBBList'+bumbbName);
        initiateErrMsgVariables();
        if(!prjLeadSponsorEqual){
                 if((proj.Project_Lead__c != null && proj.Belt_Project_Sponsor__c!= null) && (proj.Project_Lead__c == proj.Belt_Project_Sponsor__c)){
                     projLeadSponsorEqual = true;
                     prjLeadSponsorEqual = true;
                     return null;
                }
            }
        else{
            projLeadSponsorEqual = false;
            
        }
        if((currentView.contains('QIPPLeanProjectEditView') || currentView.contains('qippleanprojectdetailview')) && proj.id==null && cloneid == null){// Save on creating a project
            System.Debug('projectype===='+projectype);
            proj.Project_State__c = projState;
            proj.Project_Type__c = methodology;
            proj.DI_State__c = diState;
            proj.Lean_Project_Type__c=projectype;
            proj.Lean__c = lcertName;
            //proj.In_Annual_Plan__c = inAnnualPlan;
            proj.Permission_to_use_Belt_Info__c = permBeltInfo;
            proj.Quality_Award_Project__c = qtyAwardProj;
            errorMessages();
            /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                return null;
            }*/
            if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                return null;
            }
            if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
            {
                return null; 
            }
            
            System.Debug('projState : '+projState);
            System.Debug('leanProjPhase : '+leanProjectPhase);
        }else if((currentView.contains('qippleanprojecteditview') || currentView.contains('QIPPLeanProjectEditView')) && proj.id!=null){// Save on Editing a project from edit view
            proj.Project_State__c = projState;
            proj.Project_Type__c = methodology; 
            proj.DI_State__c = diState;
            proj.Lean_Project_Type__c=projectype;
            proj.Lean__c = lcertName;
            proj.In_Annual_Plan__c = inAnnualPlan;
            proj.Permission_to_use_Belt_Info__c = permBeltInfo;
            proj.Quality_Award_Project__c = qtyAwardProj;
            if(bumbbName == '1')
            { 
                
                Proj.Business_Unit_Master_Black_Belt__c = null;
                System.Debug('BumbbName == 1 : '+bumbbName+'----'+proj.Business_Unit_Master_Black_Belt__c);
            }
            else{       
                //bumbbName = Proj.Business_Unit_Master_Black_Belt__c;
                System.Debug('BumbbName Else : '+bumbbName+'----'+proj.Business_Unit_Master_Black_Belt__c);
                Proj.Business_Unit_Master_Black_Belt__c =bumbbName;
            }
            
            
            errorMessages();
            /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                return null;
            }*/
            if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                return null;
            }
            
            System.Debug('projStateinEditPage : '+projState);
            System.Debug('leanProjectPhaseinEditPage : '+leanProjectPhase);
            System.Debug('Project_Completion_Date_Forecast__c : '+proj.Project_Completion_Date_Forecast__c);
            
            if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
            {
                return null; 
            }
            
        }else if((currentView.contains('qippleanprojectdetailview') || currentView.contains('QIPPLeanProjectDetailView')) && proj.id!=null){// Save on Editing a project from detail view
            
            if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (proj.Project_State__c == 'In Progress'))
            {
                errorMessages();
                /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                    return null;
                }*/
            }
            errorMessages();
            /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
            }*/
            if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                return null;
            }
            
        }else if(currentView.contains('qippleanprojecteditview') || currentView.contains('QIPPLeanProjectEditView') && proj.id==null && Cloneid != null){
            proj.Lean__c = lcertName;
            proj.Project_State__c = projState;
            proj.Project_Type__c = methodology; 
            proj.DI_State__c = diState;
            proj.Lean_Project_Type__c=projectype;
            proj.Permission_to_use_Belt_Info__c = permBeltInfo;
            proj.Quality_Award_Project__c = qtyAwardProj;
            errorMessages();
            /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                return null;
            }*/
            
            if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                return null;
            }
            if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
            {
                return null; 
            }
        }
        if(proj.id==null){           
            System.Debug('recordtypeID'+recordtypeID);
            proj.RecordTypeId = recordtypeID;
            // proj.Distribution__c = 100;
            //createBBG = true; 
        }
        
        
        if((ApexPages.getMessages().size() != 0)){
            System.Debug('*********** ApexPages.getMessages().size() ************* '+ApexPages.getMessages().size());
            return null;
        }
        try{
            ApexPages.StandardController newController = new ApexPages.StandardController(proj); 
            QIPP_Project__c projbbg;
            if(ApexPages.getMessages().size() == 0){
                PageReference pageRef = newController.save();
                return pageRef;
            }
            else{return null;} 
        }catch(Exception e){
            system.debug('e.getMessage' +e.getMessage());
            system.debug('e.getMessage' +e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to create'));
            return null;
        }
    }
    
    //saveAndNew methos to save new/edited/cloned project and navigate to create layout
    public pagereference saveAndNew(){
        try{
            initiateErrMsgVariables();
            if(!prjLeadSponsorEqual){
                if((proj.Project_Lead__c != null && proj.Belt_Project_Sponsor__c!= null) && (proj.Project_Lead__c == proj.Belt_Project_Sponsor__c)){
                     projLeadSponsorEqual = true;
                     prjLeadSponsorEqual = true;
                     return null;
                }
                }
                else{
                    projLeadSponsorEqual = false;
                    
                }
            if(currentView.contains('QIPPLeanProjectEditView') && proj.id==null){ // saveAndNew on creating a project
                proj.Project_State__c = projState;
                proj.Project_Type__c = methodology;
                proj.Lean_Project_Type__c=projectype;
                proj.DI_State__c = diState;
                proj.Lean__c = lcertName;
                proj.In_Annual_Plan__c = inAnnualPlan;
                proj.Permission_to_use_Belt_Info__c = permBeltInfo;
                proj.Quality_Award_Project__c = qtyAwardProj;                
                
                errorMessages();
                /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                    return null;
                }*/
                system.debug('@@2:'+projDescError);
                if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                    return null;
                }
                if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
                {
                    return null; 
                }      

            }else if(currentView.contains('qippleanprojecteditview') && proj.id!=null){//saveAndNew on editing a project
                
                proj.Project_State__c = projState;
                proj.Project_Type__c = methodology;
                proj.Lean_Project_Type__c=projectype;
                proj.DI_State__c = diState;
                proj.Lean__c = lcertName;
                proj.In_Annual_Plan__c = inAnnualPlan;
                proj.Permission_to_use_Belt_Info__c = permBeltInfo;
                proj.Quality_Award_Project__c = qtyAwardProj;
                if(bumbbName == '1')
                { 
                    System.Debug('BumbbName ==1 2: '+bumbbName+'----'+proj.Business_Unit_Master_Black_Belt__c);
                    Proj.Business_Unit_Master_Black_Belt__c = null;
                }
                else{
                    System.Debug('BumbbName else2 : '+bumbbName+'----'+proj.Business_Unit_Master_Black_Belt__c);
                    //bumbbName = Proj.Business_Unit_Master_Black_Belt__c;
                    Proj.Business_Unit_Master_Black_Belt__c =bumbbName;
                }                
                
                errorMessages();
                /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                    return null;
                }*/
                if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                    return null;
                }
                if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
                {
                    return null; 
                }

            }
            else if(currentView.contains('qippleanprojecteditview') || currentView.contains('QIPPLeanProjectEditView') && proj.id==null && Cloneid != null){
                
                errorMessages();
                /*if(proj.X5S__c == false && proj.Autonomation__c == false && proj.Ergonomics__c == false && proj.Inspections__c == false && proj.Kanban__c == false && proj.Levelized_Production__c == false && proj.Poka_yoke__c == false && proj.One_Piece_Flow__c == false && proj.Point_of_Use__c == false && proj.Pull__c == false && proj.Root_Cause_Analysis_Fishbone_5_Whys__c == false && proj.SMED__c == false && proj.Spaghetti_Diagrams__c == false && proj.standard_work__c == false && proj.Time_Study__c == false && proj.Total_Productive_Maintenance_TPM__c == false && proj.Visual_Management__c == false && proj.Workload_Balancing__c == false && proj.Yamazumi_Charts__c == false && proj.Other__c == false)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least one selection is required from Lean Methods Applied section.'));
                    return null;
                }*/
                
                proj.Lean__c = lcertName;
                
                if(projNameError != null || pBBGError != null || bBUError != null || bBLError != null || projLeadError != null || projtypeError!= null || portfolioError != null || validPortfolioError != null || projDescError != null || cEMT_MeasureError != null || projSponsError != null || /*bUMBBError != null ||*/ projDocumentError != null || leanCertError!= null || compDatePlanError!= null || compDateForecastError!= null) {
                    return null;
                }
                if((proj.Project_Completion_Date_Forecast__c < system.Today()) && (projState == 'In Progress'))
                {
                    return null; 
                }
                
            }
            if(proj.id==null){               
                proj.RecordTypeId = recordtypeID;
                // proj.Distribution__c = 100;
                // createBBG = true;
            }
            system.debug('@@Before Save:'+proj);
            upsert proj;
            
            string cancelurl = ApexPages.currentPage().getParameters().get('cancelURL');
            //string calcelurl12 = '/apex/QIPPProjectDetailView?id='+proj.Id;
            Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
            string calcelurl12 = '/' + R.getKeyPrefix()+'/o';
            string s = '/apex/QIPPLeanProjectEditView?cancelURL='+calcelurl12+'&RecordType=Methodology%3A+Lean+%28including+Kaizen%29&retURL=%2Fa18%2Fo';
            //string s = '/apex/QIPPLeanProjectEditView?cancelURL=https%3A%2F%2Fcs2.salesforce.com%2Fa18%2Fo&RecordType=Methodology%3A+Lean+%28including+Kaizen%29&retURL=%2Fa18%2Fo' ;
            Pagereference pageref = new Pagereference(s);
            pageref.setredirect(true);
            return pageref;
        }catch(Exception e){
            System.Debug('Exception --'+e.getMessage());
            ApexPages.StandardController newController = new ApexPages.StandardController(proj);
            PageReference pageRef = newController.save();
            return PageRef;
        }       
    }
    
    
    // edit method to restrict the user if the record is in Approval process "During phase "
    public pagereference edit(){
        if(recIsLocked){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Record Locked :'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'The record you are trying to edit has been locked. '));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please contact your administrator if access is necessary.'));
            return null;
        }else{
            PageReference pageref = Page.QIPPLeanProjectEditView;
            system.debug('pageref :'+pageref);
            pageref.getParameters().put('id', proj.id);
            //--E036-Start--//
            pageref.getParameters().put('pgMode', 'edit');
            //--E036-End--//
            pageref.setredirect(true);
            return pageref;
        }
    }
    
    //cancel method to navigate back to specified location on click of Cancel button from the UI
    public pagereference cancel(){
        initiateErrMsgVariables();
        string cancelurl = ApexPages.currentPage().getParameters().get('cancelURL');
        string retURL = ApexPages.currentPage().getParameters().get('retURL');
        string prjid = ApexPages.currentPage().getParameters().get('id');
        PageReference returnPage = null;
        if(cancelurl != null ){
            returnPage = new PageReference(cancelurl);
        }else if(retURL != null){
            returnPage = new PageReference(retURL);
        }else if(prjid != null ){
            returnPage = new PageReference('/apex/QIPPLeanProjectDetailView?id='+prjid);
            returnPage.setredirect(true);
        }
        else if(cloneID != null ){
            System.Debug('CloneID ==='+cloneID);
            returnPage = new PageReference('/apex/QIPPLeanProjectDetailView?id='+cloneID);
            returnPage.setredirect(true);
        }
        return returnPage;
    }
    
    public void closeLeadSponsorEqualPopup(){
        projLeadSponsorEqual = false;
    }   
    
    //Cancel for Validation Rule - Written By Manish
    public pagereference ValidationCancel(){
        string prjid = ApexPages.currentPage().getParameters().get('id');
        PageReference returnPage = new PageReference('/apex/QIPPLeanProjectDetailView?id='+prjid);
        returnPage.setredirect(true);
        return returnPage;
    }
    //deleteRecord method to restrict the user if the record is in approval process
    public pagereference deleteRecord(){System.Debug('displaydelPopup1111'+displaydelPopup);
                                        if(recIsLocked){
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Record Locked :'));
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'The record you are trying to Delete has been locked. '));
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please contact your administrator if access is necessary.'));
                                            return null;
                                        }else{System.Debug('displaydelPopup2222'+displaydelPopup);
                                              displaydelPopup = true;
                                              System.Debug('displaydelPopup3333'+displaydelPopup);
                                              return null;
                                             }
                                       }
    
    //cloneProject method is to navigate to the create layout to clone the Lean record
    public pagereference cloneProject(){
        PageReference pageref = Page.QIPPLeanProjectEditView;
        pageref.getParameters().put('cloneID', proj.id);
        pageref.getParameters().put('RecordType', 'Methodology: Lean (including Kaizen)');
        pageref.setredirect(true);
        return pageref;
    }
    
    //reqApproval method is to request the approval process for all Lean phases (Non-Certification and Certification)
    public pagereference reqApproval(){System.Debug('Request for approval clickedddd....');
                           string FinApprover= proj.Approver_Financial_Approver__c;
                           string proj_doc = proj.Project_Document__c;
                           string leanPhase = proj.Lean_Project_Phase__c;
                           string projectState = proj.Project_State__c;
                           string projectOwner = proj.Approver_Project_Owner__c;
                           string leanCoach = proj.Lean_Coach__c;
                           string BU_MBB = proj.Business_Unit_Master_Black_Belt__c;
                           string leanCert = proj.Lean__c;
                           
                           Decimal  benefitCount = proj.Countof_Benefits__c;
                           Decimal  benefitOverrideCnt = proj.Ben_Override_Resp_From_BUMBB__c;
                           boolean Taskcheck = QIPP_ApprovalsProcessNonSixSigma.TasksCheck(proj.Id);
                           boolean ImpMeasurecheck = QIPP_ApprovalsProcessNonSixSigma.ImpMeasurescheck(proj.Id);
                           boolean businessActivityCheck = QIPP_ApprovalsProcessNonSixSigma.BusinessActivities(proj.Id);
                           boolean projectredepCheck = QIPP_ApprovalsProcessNonSixSigma.ProjectRedeployments(proj.Id);
                           Decimal opSavings = totalKPI;
                           Decimal fnSavings = totalCOPQ;
                           
                           if(recIsLocked){
                               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project is already under Approval Process'));
                               return null;
                           }
                           if(projectState == 'Complete' && leanCert == 'No'){
                               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\"Benefit Savings\" Validation is already Completed.'));
                               return null;
                           }
                           if(LeanCert == 'No'){
                               if(benefitAmount <= 15.0){
                                   if (projectState == 'On Hold' || projectState == 'Canceled'){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));}
                                   if (proj_doc==null || proj_doc == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is required.'));}
                                   if (ImpMeasurecheck == true){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'A project cannot be submitted for approval with a Benefit that is using the “Generic KPI (Internal Use Only)” Improvement Measure. Please update this project’s benefit(s) to be using a defined KPI or PI.'));}//ImpMeasurecheck == true and Lean Certificate ="Yes" OR Lean Certificate ="Yes" and Lean phase equals to "Post Action Workout"
                                   if(proj.Project_Completion_Date_Forecast__c < system.Today())
                                   {
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
                                   }
                                   if(Taskcheck == true){ 
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'All Tasks must be either \'Complete\' or \'Canceled\' before Lean form can be submitted for approval.')); 
                                   } //Task Status is not equal to "Complete or Cancelled"
                                   if(businessActivityCheck == false){
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Business Activity was mapped to the Project.'));
                                   }
                                  if(projectredepCheck == false){
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please select project redeployment opportunity at ‘Project Re-Deployment Section’ below”'));
                                   }
                               }
                               else{
                                   //--Added by Rahul(E086)(14-11-2016)-- --Start--//
                                   //validate project finance is match contact BG with cunfiguration values at project creation
                                   if(proj.Finance_Approver__c != null && !cmnFunct.validContactBG(proj.Finance_Approver__c,'Finance Approver')){
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Provided Finance Approver Contact is not actual Salesforce User or not a configured as F&C. Contact your Administrator to get QIPP Salesforce account.'));
                                       return null;
                                   }       
                                   //--Added by Rahul(E086)(14-11-2016)-- --End--//
                                   
                                   if (projectState == 'On Hold' || projectState == 'Canceled'){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));}
                                   if (proj_doc==null || proj_doc == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is required.'));}
                                   if (FinApprover == null || FinApprover == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Finance Approver is required.'));}
                                   if ( ImpMeasurecheck == true){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'A project cannot be submitted for approval with a Benefit that is using the “Generic KPI (Internal Use Only)” Improvement Measure. Please update this project’s benefit(s) to be using a defined KPI or PI.'));}//ImpMeasurecheck == true and Lean Certificate ="Yes" OR Lean Certificate ="Yes" and Lean phase equals to "Post Action Workout"
                                   if(proj.Project_Completion_Date_Forecast__c < system.Today())
                                   {
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
                                   }
                                   if(Taskcheck == true){ 
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'All Tasks must be either \'Complete\' or \'Canceled\' before Lean form can be submitted for approval.')); 
                                   } //Task Status is not equal to "Complete or Cancelled"
                                   if(businessActivityCheck == false){
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Business Activity was mapped to the Project.'));
                                   }
                                  if(projectredepCheck == false){
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please select project redeployment opportunity at ‘Project Re-Deployment Section’ below”'));
                                    }
                               }
                           }
                           else if (LeanCert == 'Yes'){
                               //--Added by Rahul(E086)(14-11-2016)-- --Start--//
                               //validate project finance is match contact BG with cunfiguration values at project creation
                               if(proj.Finance_Approver__c != null && !cmnFunct.validContactBG(proj.Finance_Approver__c,'Finance Approver')){
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Provided Finance Approver Contact is not actual Salesforce User or not a configured as F&C. Contact your Administrator to get QIPP Salesforce account.'));
                                   return null;
                               }       
                               //--Added by Rahul(E086)(14-11-2016)-- --End--//
                               
                               if (projectState == 'On Hold' || projectState == 'Canceled'){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));}
                               if (LeanCoach == null || LeanCoach == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Lean Coach is required.'));}
                               if (proj_doc==null || proj_doc == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is required.'));}
                               if (BU_MBB==null || BU_MBB == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Business Group Master Black Belt is required.'));}
                               if (FinApprover == null || FinApprover == ''){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Finance Approver is required.'));}
                               if (benefitplanAmount == 0.0){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Improvement Measure is attached to the Project and \'Planned Savings Amount\'.'));}
                               if(benefitOverrideCnt > 0){ 
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Benefit override is in progress for one or more benefits associated with this project. This needs to be approved by the Finance Approver before Lean form can be submitted for approval.')); 
                               }//Benefit Override Count >0
                               if(Taskcheck == true && (leanPhase != 'Action Workout' && leanPhase != 'Pre-Action Workout')){ 
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'All Tasks must be either \'Complete\' or \'Canceled\' before Lean form can be submitted for approval.')); 
                               } //Task Status is not equal to "Complete or Cancelled"
                               if( ImpMeasurecheck == true && (LeanCert != 'Yes' || (LeanCert == 'Yes' && leanPhase == 'Post-Action Workout' )) ){
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'A project cannot be submitted for approval with a Benefit that is using the “Generic KPI (Internal Use Only)” Improvement Measure. Please update this project’s benefit(s) to be using a defined KPI or PI.'));
                               }//ImpMeasurecheck == true and Lean Certificate ="Yes" OR Lean Certificate ="Yes" and Lean phase equals to "Post Action Workout"
                               if(proj.Project_Completion_Date_Forecast__c < system.Today())
                               {
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
                               }
                               if((benefitAmount == 0.00) && leanPhase == 'Post-Action Workout' ){ 
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'You cannot request approval of this Lean Certification project because the Achieved + Future Savings is 0 k€. Correct the savings amount in QIPP if it is not accurate, or consult with your Lean Coach if your project savings is 0 k€.'));
                               }//Lean Certificate ="Yes" and Savings =0.00 and Lean phase equals to "Post Action Workout"
                               if(businessActivityCheck == false){
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Business Activity was mapped to the Project.'));
                               }
                              if((projectredepCheck == false)&& leanPhase == 'Post-Action Workout'){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please select project redeployment opportunity at ‘Project Re-Deployment Section’ below”'));
                                }
                               
                           }
                           
                           if ((ApexPages.getMessages().size() == 0) && (LeanCert == 'No'))
                           { if((benefitAmount >= 15.0) && (benefitAmount < 250.0)){
                               system.debug('Inside BenefitAmountIf:'+benefitAmount);
                               display15kto250kPopup = true;
                           }
                            else if ((benefitAmount > 0.0) && (benefitAmount < 15.0)){
                                system.debug('Inside BenefitAmountelseif:' + benefitAmount);
                                displayalertPopup = true;
                            }  
                            else if (benefitAmount >= 250.0){
                                system.debug('elseif BenefitAmount:' + benefitAmount);
                                displayhighimpactPopup = true;}
                            else {
                                system.debug('ifelse BenefitAmount:' + benefitAmount);
                                //displayzeroPopup = true;
                                displayMsgPopup = true;
                                System.debug('displayMsgPopup ---- '+displayMsgPopup);
                            }
                           }
                           else if((ApexPages.getMessages().size() == 0) && (LeanCert == 'Yes')){
                               system.debug('else BenefitAmount:' + benefitAmount);
                               system.debug('else LeanCert:' + LeanCert);
                               displayPopup = true;
                           }
                           
                           return null;
                                      }
    public void closePopup() {       
        displayPopup = false; //To hide confirmation popup for submitting approval process  
    }
    public void closeMsgPopup() {       
        displayMsgPopup = false; //To hide confirmation popup for submitting approval process  
    }
    public void closedelPopup() {       
        displaydelPopup = false; //To hide confirmation popup to Delete the project 
    }
    public void closehighimpactPopup()
    {
        displayhighimpactPopup = false;
        displayPopup = true;
    }
    public void close15kto250kPopup()
    {
        display15kto250kPopup = false;
        displayPopup = true;
    }
    
    //deleteprj to delete the record and to navigate to project home page
    public pageReference deleteprj(){ 
        PageReference pg = null;
        system.debug('************* inside approve*************** ::');
        displaydelPopup = false;
        Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
        
        ApexPages.StandardController newController = new ApexPages.StandardController(proj);
        try{   
            PageReference pageRef1 = newController.delete();
            //pageRef1.getParameters().put('retURL','/apex/QIPP_project_home');
            return PageRef1;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to delete'));
            return null;
        }
        
    }
    //Subhash: actions to be done if Benfit override approved    
    public pageReference submitapprove(){  
        String projectid = proj.id;
        system.debug('totalKPI***'+totalKPI);
        system.debug('totalCOPQ***'+totalCOPQ);
        system.debug('benefitAmount****'+benefitAmount);
        PageReference pg = null;
        string msg;
        system.debug('************* inside approve*************** ::');
        displayPopup = false;
        displayMsgPopup = false;
        displayalertPopup = false;
        if((benefitAmount <= 15.0) && (lcertName == 'No')){
            msg = QIPP_ApprovalsProcessNonSixSigma.CompleteL6Sproject(projectid); 
            system.debug('msg<=15.0***'+msg);
            if(msg == '0'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Sucessfully submited for approval'));
                pg = new PageReference('/apex/QIPPLeanProjectDetailView?id='+proj.id);
                pg.setRedirect(true);
                return pg;
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please follow the guidance.'+ msg));
            }
        }
        else{
            msg = QIPP_ApprovalsProcessNonSixSigma.SubmitApproval(projectid);
            system.debug('msginelse***'+msg);
            if(msg == '1'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Sucessfully submited for approval'));
                pg = new PageReference('/apex/QIPPLeanProjectDetailView?id='+proj.id);
                pg.setRedirect(true);
                return pg;
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please follow the guidance.'+ msg));
            }
        }
        return null;
        
    }
    
    public PageReference unlockRecord(){
        try{
            Approval.UnlockResult uResult = Approval.unlock(proj.Id);
            PageReference pgRef = new PageReference('/apex/QIPPLeanProjectDetailView?id='+proj.Id);
            pgRef.setRedirect(true);
            return pgRef;
        }catch(Exception e){
            return null;
        }
    }
    
    public Boolean recordIsLocked(ID projId){
        ID recId = projId;
        recIsLocked = Approval.isLocked(recId);
        System.Debug('recIsLocked : '+recIsLocked );
        return recIsLocked;
    }
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
    
    //--Added by Rahul(02-09-2016)--Start--//
    public class BAMWrapper{
        public String activityName{get;set;}
        public String businessFunc{get;set;}
        public String valueStream{get;set;}     
        
        //public BAMWrapper(){
        
        //}
        public BAMWrapper(String activityName_val, String businessFunc_val, String valueStream_val){
            activityName = activityName_val;
            businessFunc = businessFunc_val;
            valueStream = valueStream_val;
        }        
    }
}