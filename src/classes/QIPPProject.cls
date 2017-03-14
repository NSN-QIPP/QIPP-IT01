public with sharing class QIPPProject{
    public QIPP_Project__c proj{get;set;} // proj is used to store all the record values in it
    public QIPP_Portfolio__c portfolio{get;set;}//veera
    public QIPP_Contacts__c contact{get;set;}//veera
    public Id portowner{get;set;}//veera
    public string projectState{get;set;}
    public Id theId{get;set;} // theId is uded to hold the current record Id while editing
    public List<QIPP_Contacts__c> loggedInContact{get;set;} //loggedInContact is used to store the logged in user name and to default it in project Lead field
    public List<QIPP_Portfolio__c> portfolioList{get;set;} // portfolioList is used to store the list of portfolio names available in the tool
    public List<QIPP_Contacts__c> bumbbList{get;set;} // bumbbList is used to store the list of Business Group Mster Black Belt user names available in QIPP Contact object
    public String portfolioName{get;set;} // portfolioName is used to store the value of selected portfolio name from the picklist
    public String bumbbName{get;set;}// bumbbName is used to store the value of selected Business Group Master black belt name from the picklist
    public String projState{get;set;} // projState is used to store the values selected project state
    public String mcertName{get;set;}// mcertName is used to store the values selected Mentor Certificate
    public String methodology{get;set;} // methodolotgy is used to store the values selected Methodology
    public String projectype{get;set;} // projecttype is used to store the values selected projecttype
    public String diState{get;set;}// diState is used to store the values selected DI State
    public String beltProjPhase{get;set;}// beltProjPhase is used to store the values selected Belt Project Phase
    public QIPP_Portfolio__c portfolioRec{get;set;}// portfolioRec is used to store the portfolio record based on selected portfolio name from the picklist
    public String benefitingBG{get;set;}//benefitingBG is used to store the value based on selected portfolio name
    private ApexPages.StandardController projstdController; // Standard Controller variable to pass it to the constructor which hold the current record
    public boolean displayPopup{get; set;}// displayPopup is a boolean variable to enable the popup screen while initiating approval process for a project
    public boolean displaydelPopUp{get; set;}//displaydelPopUp is a boolean variable to enable the popup screen while deleting a project
    public String recordtypeName{get;set;}//recordtypeName is used to store the Record Type name of the current record
    public String recordtypeID{get;set;}//recordtypeID is used to store the Record Type id of the current record
    public String currentView{get;set;}//currentView is used to store the current view of the record
    public String refererStr{get;set;}//refererStr is used to store referer string of the current record
    public String approvalStatus{get;set;}//approvalStatus is used to store the approval status of the current record
    public Id Cloneid{get;set;}//Cloneid is used to store the value of record id while cloning
    public string phasecompleted{get;set;}//phasecompleted is used to store the name of the phase which completed its approval
    public Boolean recIsLocked{get;set;}//recIsLocked is used to store the boolean value based on record locked or not
    public String defineStatus{get;set;}//dStatus is used to store the value of Define status
    public String measureStatus{get;set;}//mStatus is used to store the value of Measure status
    public String analyzeStatus{get;set;}//aStatus is used to store the value of Analyze status
    public String improveStatus{get;set;}//iStatus is used to store the value of Improve status
    public String controlStatus{get;set;}//cStatus is used to store the value of Control status
    public String ProjectMentorCandidate {get;set;} // Used for ProjectMentorCandidate Validation rule error cancel button
    public String Projectchamp {get;set;} // Used for ProjectChampion Validation rule error cancel button
    public String ProjectSpons {get;set;} // Used for ProjectSponsor Validation rule error cancel button
    public String measurecemtid {get;set;} // Used for Mearsure-Id/Cemt-Id Validation rule error Cancel button
    public String ProjectDesc {get;set;} // Used for ProjectDescription Validation rule error cancel button
    public Date definedateplan{get;set;}//Define Date Planned Validation rule error Cancel button
    public Date measuredateplan{get;set;}//measure Date Planned Validation rule error Cancel button
    public Date analyzedateplan{get;set;}//analyze Date Planned Validation rule error Cancel button
    public Date improvedateplan{get;set;}//Improve Date Planned Validation rule error Cancel button
    public Date controldateplan{get;set;}//Control and Verify Date Planned Validation rule error Cancel button
    public String ProjName{get;set;}//project Name Validation rule error Cancel button
    public String portName{get;set;}//Portfolio Name Validation rule error Cancel button
    public String projLead{get;set;}//Project Lead Validation rule error Cancel button
    public String CEMT_MeasureId{get;set;}//CEMT-Measure ID validation rule error Cancel button
    public String PortBG{get;set;}//Portfolio business group validation rule error Cancel button
    public String PortBU{get;set;} //Portfolio business Unit Validation rule error Cancel button
    public String PortBL{get;set;} //Portfolio business Line Validation rule error Cancel button
    public String currPortfolioId{get;set;} //to store the value of Portfolio Id when project created from Portfolio object
    public String currPortfolioName{get;set;} //to store the value of Portfolio Name when project created from Portfolio object
    public String ProjNameError{get;set;}// Page Error Message for Project Name field
    public String PortfolioError{get;set;} //Page Error Message for portfolio Name field
    public String ProjDescError{get;set;} //Page Error Message for Project Description field
    public String qtyAwardProj{get;set;}// qtyAwardProj is used to store the values selected Qwality Award Projects
    public String permBeltInfo{get;set;}//permBeltInfo is used to store the values selected Permission to use belt info
   // public String ProjDescSpecCharError{get;set;} //Page Error Message for Project Description field
    public String ProjLeadError{get;set;} //Page Error Message for Project Lead field
    public String PBBGError{get;set;} //Page Error Message for portfolio business Group field
    public String CEMT_MeasureError{get;set;}//Page Error Message for CEMT-ID/Measure-Id field
    public String GenericError{get;set;} //Field Error Message for fields
    public String validPortfolioErrorMsg{get;set;}
    //public String specCharError{get;set;}//Special charector error message
    public String ProjMentError{get;set;}// Page Error Message for Project Mentor field
    public String ProjSponsError{get;set;} //Page Error Message for project Sponsor field
    public String ProjChampError{get;set;} //Page Error Message for Project Champion field
    public String BUMBBError{get;set;} //Page Error Message for BUMBB field
    public String DDPlanError{get;set;} //Page Error Message for Define Date - Planned field
    public String MDPlanError{get;set;}//Page Error Message for Measure Date - Planned field
    public String ADPlanError{get;set;} //Page Error Message for analyze Date - Planned field
    public String IDPlanError{get;set;} //Page Error Message for Improve Date - Planned field
    public String CDPlanError{get;set;} //page Error Message for Control Date - Planned field
    public String BBUError{get;set;}//page Error Message for Business Benefiting Unit
    public String BBLError{get;set;}//page Error Message for Business Benefiting line
    public String projDocumentError{get;set;}//page Error Message for Project Document field
    public String projtypeError{get;set;}//page Error Message for Project Type field
    public String MentorCertError{get;set;}//page Error Message for Mentor Certificate field
    public String validPortfolioError{get;set;}
    //public String regexFormatForProjectDescription{get;set;}
    public String regexFormatForProjectDocument{get;set;}//
    public Boolean isValidPortfolioName{get;set;}
    public Id projectId{get;set;}//projectId is used to store the Id of Project and used in the condition of Project state on VF page
    //public List<QIPPProjWrapper> projwrapper{get; set;}
   // public static Integer toDelrow {get; set;}
    //public static Integer addCount {get; set;}
   // private Integer nextrow=0;
    public boolean editBBG{get;set;}
    public boolean updateChild{get;set;}
    public Blob csvFileBody{get;set;}
    Public string csvAsString{get;set;}
    Public String[] csvfilelines{get;set;}
    Public String[] inputvalues{get;set;}
    Public List<string> fieldList{get;set;}
    Public List<QIPP_Project__c> sObjectList{get;set;}
    public date mydate{get;set;}
    public string profilename {get;set;}
    public string rolename {get;set;}
    public Decimal benefitAmount{get;set;}//benefitAmount is used to store the sum of totalKPI and totalCOPQ
    //public QIPP_Project__c Proj;
    public List<QIPP_Benefit__c> Benefits_RelatedList {get;set;}//Benefits_RelatedList is to store the list of benefits of the project
    
    public List<QIPP_Project__c> activityList{get;set;}//activityList is used to store the business activity which is mapped to the project in alist format
    public List<Business_Activity__c> bamDetails{get;set;}//bamDetails is to store the business activity mapping details for the project in a list format based on activityList
    public String activity{get;set;}//activity is used to store the activity name of the project
    public String valueStream{get;set;}//valueStream is used to store the value stream of the activity
    public String businessFunction{get;set;}//businessFunction is used to store business Function of the activity
    
    public List<QIPP_Project__c> projBBGAddList{get;set;}
    public List<QIPP_Project__c> projBBGDelList{get;set;}
    
    public boolean projLeadSponsorEqual{get;set;}
    public boolean prjLeadSponsorEqual;
    
    
    public Integer bgRowNum {get;set;}
    
    public List<Benefiting_Business_Group__c> projMultipleBBGAddList{get;set;}
    public List<Benefiting_Business_Group__c> projMultipleBBGDelList{get;set;}
    public Benefiting_Business_Group__c mulBBG;
    public Integer index{get;set;}
    public Integer mulBGRowNum {get;set;}
    public boolean displayPopupBBG{get;set;}
    public Benefiting_Business_Group__c mulBBGDist;
    public boolean createBBG{get;set;}
    public List<QIPP_Benefit__c> Benefits_GrandTotalsList{get;set;}
    
    public List<benefitGrandTotals> benefitGrandTotalsList{get;set;}
    public list<Benefiting_Business_Group__c> deleteChildBBG{get;set;}
    public list<Benefiting_Business_Group__c> updateChildBBG{get;set;}
    public List<QIPP_BU_Reporting__c> UpdateBU{get;set;}
    //--Added by Rahul(02-09-2016)--Start--//
    public List<BAMWrapper> BAMWrapperList{get;set;}
    //--Added by Rahul(02-09-2016)--End--//
    //--Added by Rahul(E086)(14-11-2016)--Start--//
    public QIPPCommonFuctionController cmnFunct;
    //--Added by Rahul(E086)(14-11-2016)--End--//
    //--Added by Rahul(E093)(14-11-2016)--Start--//
    public boolean enableInlineEdit{get;set;}
    //--Added by Rahul(E093)(14-11-2016)--End--//
    
    //--E036-Start--//
    public List<SelectOption> bGMBBOptions{get;set;}
    public String pageMode;
    //--E036-End--//

    public QIPPProject(ApexPages.StandardController stdController){
        //currPortfolioId = null;
        createBBG= false; 
        deleteChildBBG= new list<Benefiting_Business_Group__c>();
        updateChildBBG= new list<Benefiting_Business_Group__c>();
        UpdateBU = new  List<QIPP_BU_Reporting__c>();
        projLeadSponsorEqual = false;
        prjLeadSponsorEqual = false;
       
        profile profilena =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        profilename = profilena.Name;
        if(UserInfo.getUserRoleId() != null){
        userrole rolenames = [SELECT Id, Name FROM userrole WHERE Id=:UserInfo.getUserRoleId() LIMIT 1];
        rolename = rolenames.Name;}
        projstdController = stdController;
        proj = (QIPP_Project__c)projstdController.getRecord();
         //proj = new QIPP_Project__c();
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
       
        //Set Generic Error message
        GenericError = 'Error: You must enter a value';
        validPortfolioErrorMsg = 'Error: Business/Functional Group should be the same between Portfolio and Project. Please select the appropriate Business/Functional Group.';
        //specCharError = 'Error: Special characters are not allowed.';
        if(theId != null || Cloneid != null){
             recordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: DMAIC / DMADV').getRecordTypeId();
        }else if(recordtypeName != null){
             recordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get(recordtypeName).getRecordTypeId();
        }        
        
        System.Debug('recordtypeID :'+recordtypeID);
        
        if(theId != null){  
             editBBG= true;
             updateChild=false;  
             proj = [SELECT Id,Business_Unit_Master_Black_Belt__r.Name,Distribution__c, Name,TotalKPI__c,Total_Planned_Financial_Benefits_k__c,Total_Planned_Operational_Benefits_k__c,Total_Planned_Projected_Benefits_k__c,Total_Planned_Realized_Benefits_k__c,TotalCOPQ__c,Total_Project_Validation_Amount__c,Total_Validation_Amount_Projected_k__c,Total_Validation_Amount_Realized_k__c,Old_Benefitting_Business_Grp__c,CEMT_ID__c, Belt_Candidate_Mentor__r.name,Belt_Project_Sponsor__r.name,Project_Lead__r.name,CreatedById,CreatedDate,Project_Lead_Business_Unit__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Line__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid,Project_Name_Succinct__c,Belt_Project_Type__c, Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Candidate_Mentor__c,Belt_Project_Sponsor__c,Belt_Project_Champion__c,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Project_Completion_Date_Forecast__c,Mentor_Certificate__c,DMAIC_Define__c,DMAIC_Analyze__c,Define_Date_Forecast__c,Analyze_Date_Forecast__c,Define_Status__c,Analyze_Status__c,DMAIC_Measure__c,DMAIC_Improve__c,Measure_Date_Forecast__c,Improve_Design_Date_Forecast__c,Measure_Status__c,Improve_Status__c,DMAIC_Control__c,Control_Verify_Date_Forecast__c,Control_Status__c,Progress_To_Date__c,Next_Steps__c,Project_Type__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Belt_Candidate_Location__c,Project_Created_Date__c,Belt_Project_Phase__c,Project_Duration__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,LastModifiedById,LastModifiedDate,Image_to_direct_for_right_button__c,Message_WF_Guidance__c,BGMBB_Rejected__c    FROM QIPP_Project__c WHERE Id =: theId];
             //portfolio = [select id,name,Portfolio_Owner__c from QIPP_Portfolio__c  where id =:proj.Portfolio_Name__c];//veera
             //contact = [select id,User_License__c from QIPP_Contacts__c where id=:portfolio.Portfolio_Owner__c];//veera
             //portowner =[select id,User_License__c from QIPP_Contacts__c where id=:contact.id].User_License__c;//veera
             recordIsLocked(theId);
             portfolioName = proj.Portfolio_Name__c;
             projState = proj.Project_State__c;
             mcertName = proj.Mentor_Certificate__c;
             methodology = proj.Project_Type__c;
             diState=proj.DI_State__c;
             beltProjPhase=proj.Belt_Project_Phase__c;
             projectype=proj.Belt_Project_Type__c;
             system.debug('portfolioName'+ proj.Portfolio_Name__c);
             System.debug('portfolioName ====='+portfolioName);
             //system.debug('Lock status'+Approval.isLocked(proj.id));
             System.debug('theId ====='+theId);
             defineStatus = proj.Define_Status__c;
             measureStatus = proj.Measure_Status__c;
             analyzeStatus = proj.Analyze_Status__c;
             improveStatus = proj.Improve_Status__c;
             controlStatus = proj.Control_Status__c;
             ProjectMentorCandidate = proj.Belt_Candidate_Mentor__c;
             ProjectDesc = proj.Project_Description_Detailed__c;
             measurecemtid = proj.CEMT_ID__c;
             ProjectSpons = proj.Belt_Project_Sponsor__c;
             Projectchamp = proj.Belt_Project_Champion__c;
             bumbbName = Proj.Business_Unit_Master_Black_Belt__c;
             definedateplan = proj.DMAIC_Define__c;
             measuredateplan = proj.DMAIC_Measure__c;
             analyzedateplan = proj.DMAIC_Analyze__c;
             improvedateplan = proj.DMAIC_Analyze__c;
             controldateplan = proj.DMAIC_Control__c;
             ProjName = proj.Project_Name_Succinct__c;
             portName = Proj.Portfolio_Name__c;
             projLead = proj.Project_Lead__c;
             PortBG = proj.Portfolio_BU__c;
             PortBU = proj.Project_BL__c;
             portBL = proj.Benefitting_Project_BL_Level_4_Org__c;
             projectId=proj.Id;
             permBeltInfo = proj.Permission_to_use_Belt_Info__c;
             qtyAwardProj = proj.Quality_Award_Project__c;
             benefitAmount = proj.Total_Project_Validation_Amount__c;

        }else if(Cloneid != null){
            QIPP_Project__c cloneproj = [SELECT Id, Name,Business_Unit_Master_Black_Belt__r.Name,CEMT_ID__c,Belt_Candidate_Mentor__r.name,Belt_Project_Sponsor__r.name,Project_Lead__r.name,CreatedById,CreatedDate,Project_Lead_Business_Grp__c,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid, Project_Name_Succinct__c,Belt_Project_Type__c, Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Candidate_Mentor__c,Belt_Project_Sponsor__c,Belt_Project_Champion__c,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Project_Completion_Date_Forecast__c,Mentor_Certificate__c,DMAIC_Define__c,DMAIC_Analyze__c,Define_Date_Forecast__c,Analyze_Date_Forecast__c,Define_Status__c,Analyze_Status__c,DMAIC_Measure__c,DMAIC_Improve__c,Measure_Date_Forecast__c,Improve_Design_Date_Forecast__c,Measure_Status__c,Improve_Status__c,DMAIC_Control__c,Control_Verify_Date_Forecast__c,Control_Status__c,Progress_To_Date__c,Next_Steps__c,Project_Type__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Belt_Candidate_Location__c,Project_Created_Date__c,Belt_Project_Phase__c,Project_Duration__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,LastModifiedById,LastModifiedDate,Image_to_direct_for_right_button__c,Message_WF_Guidance__c     FROM QIPP_Project__c WHERE Id =: Cloneid];
            //System.Debug('recordtypeID c1 :'+recordtypeID+proj.RecordType.Name+'***proj.RecordTypeId'+proj.RecordTypeId);
            portfolioName = cloneproj.Portfolio_Name__c;
            proj = cloneproj.clone(false,true,false,false);
            proj.Belt_Project_Phase__c = 'Define';
            proj.RecordTypeId = recordtypeID;
            proj.RecordType.Name = '';
            proj.Define_Status__c = 'In Progress';
            proj.Measure_Status__c = 'Not Started';
            proj.Analyze_Status__c = 'Not Started';
            proj.Improve_Status__c = 'Not Started';
            proj.Control_Status__c = 'Not Started';
            proj.Project_Completion_Date_Forecast__c = null;
            proj.Project_Completion_Date_Actual__c = null;
            proj.Project_Completion_Date_Target__c = null;
            proj.Project_Created_Date__c = system.today();
            proj.Project_Start_Date__c = null;
            //diState=proj.DI_State__c;
            System.Debug('portfolioName456=='+cloneproj.Portfolio_Name__c);
            proj.DI_State__c = 'Not Specified';
            projectype=cloneproj.Belt_Project_Type__c;
            portfolioName = cloneproj.Portfolio_Name__c;
            System.Debug('portfolioName999=='+cloneproj.Portfolio_Name__c);
            //beltProjPhase= 'Define';
            mcertName = cloneproj.Mentor_Certificate__c;
            methodology = cloneproj.Project_Type__c;
            //projState = proj.Project_State__c;
            //proj.Project_State__c = 'Not Started';
            proj.Project_State__c = 'In Progress';
            ProjectMentorCandidate = cloneproj.Belt_Candidate_Mentor__c;
            ProjectDesc = cloneproj.Project_Description_Detailed__c;
            measurecemtid = cloneproj.CEMT_ID__c;
            ProjectSpons = cloneproj.Belt_Project_Sponsor__c;
            Projectchamp = cloneproj.Belt_Project_Champion__c;
            bumbbName = cloneproj.Business_Unit_Master_Black_Belt__c;
            definedateplan = cloneproj.DMAIC_Define__c;
            measuredateplan = cloneproj.DMAIC_Measure__c;
            analyzedateplan = cloneproj.DMAIC_Analyze__c;
            improvedateplan = cloneproj.DMAIC_Analyze__c;
            controldateplan = cloneproj.DMAIC_Control__c;
            ProjName = cloneproj.Project_Name_Succinct__c;
            portName = cloneproj.Portfolio_Name__c;
            projLead = cloneproj.Project_Lead__c;
            PortBG = cloneproj.Portfolio_BU__c;
            PortBU = cloneproj.Project_BL__c;
            portBL = cloneproj.Benefitting_Project_BL_Level_4_Org__c;
            permBeltInfo = proj.Permission_to_use_Belt_Info__c;
            qtyAwardProj = proj.Quality_Award_Project__c;
            System.Debug('recordtypeID c2 :'+recordtypeID+proj.RecordType.Name+'***proj.RecordTypeId'+proj.RecordTypeId+'**bumbbName:'+bumbbName);
        }else{
             proj = new QIPP_Project__c();
             //--E036-Start--//
             bumbbName = '--None--';
             //--E036-End--//
        }
         //projwrapper=new List<QIPPProjWrapper>();
        // projwrapper.add(new QIPPProjWrapper(nextrow++));
         //system.debug('projwrapper-->'+projwrapper);
        
         loggedInContact = [select id,name from QIPP_Contacts__c where User_License__c =: UserInfo.getUserId()  and Email__c =: UserInfo.getUserEmail()];
    
        system.debug('projRecordType-->'+proj.RecordType.Name);
        phasecompleted = '';
        if(proj.RecordType.Name == 'Methodology: After QIPP DMAIC Define'){
            phasecompleted = 'Define';
        }else if(proj.RecordType.Name == 'Methodology: After DMAIC Measure'){
            phasecompleted = 'Measure';
        }else if(proj.RecordType.Name == 'Methodology: After QIPP DMAIC Analyze'){
            phasecompleted = 'Analyze';
        }else if(proj.RecordType.Name == 'Methodology: After DMAIC Improve'){
            phasecompleted = 'Improve';
        }else if(proj.RecordType.Name == 'Methodology: After QIPP DMAIC Control / Verify'){
            phasecompleted = 'Control';
        }
       
        
        
        if(proj.Id == null){
             //projState = 'Not Started';
             projState = 'In Progress';
             beltProjPhase= 'Define';
             diState = 'Not Specified';
             methodology = 'DMAIC';
             permBeltInfo = 'Yes';
             qtyAwardProj ='No';
             proj.Project_Created_Date__c = system.today();
             //proj.Permission_to_use_Belt_Info__c = 'Yes';
             if(currPortfolioId != null){
                portfolioName = currPortfolioId;
                portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: currPortfolioId];
                proj.Portfolio_BU__c = portfolioRec.Portfolio_Business_Unit__c;
               
             }
             if(loggedInContact.size()>0){
                 proj.Project_Lead__c = loggedInContact[0].id;
             }
         }/*else if(proj.Id != null && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed')){
             projState = 'Complete';
             diState = 'DI 4 - Initiative is fully implemented';
         }else if(proj.Id != null){
             approvalStatus = 'Phase Complete';
         }*/
         if(currentView.contains('qippprojectdetailview') || currentView.contains('QIPPProjectDetailView')){
            //BAMDetails();
            getBenefits();
        }
        
        //benefiting business group section lineItems - below code added by Haripriya 23/08/2016
        //projID = ApexPages.currentPage().getParameters().get('id');
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
    
   /* public void saveMulBBG(){
        For( Benefiting_Business_Group__c mulbbg:Bn_rep_AddList) 
                        {    
                            QIPP_BU_Reporting__c test = new QIPP_BU_Reporting__c();
                            
    }*/
    
    //--Added by Rahul(02-09-2016)--Start--//    
    //getBAMDetails method is to get Business Activity Mapping details of the project
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

        activityList = [select id,Business_Activity_Mapping__c,Business_Activity_Mapping__r.name,Business_Activity_Mapping_ValueStream__c,Business_Activity_Mapping_BusinessFunc__c,
                        Business_Activity_Mapping2__c,Business_Activity_Mapping2__r.name,Business_Activity_Mapping2_ValueStream__c,Business_Activity_Mapping2_BusinessFunc__c,
                        Business_Activity_Mapping3__c,Business_Activity_Mapping3__r.name,Business_Activity_Mapping3_ValueStream__c,Business_Activity_Mapping3_BusinessFunc__c from QIPP_Project__c where id=:proj.id];
        
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
    
    public PageReference callDummy(){
        return null;
    }
    //--Added by Rahul(02-09-2016)--End--//
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
        //return null;
  //  }
    
    //Benefit method
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
                                         Benefit_Realized_Achieved_Future_k__c
                                         from QIPP_Benefit__c 
                                         where  Project_ID__c =:proj.id order by Improvement_Measure_Name__c];
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
   
    //getPortfolioValues method to get all the protfolios available in the tool limit 80
    public List<SelectOption> getPortfolioValues(){
        try{
            List<SelectOption> optns = new List<Selectoption>();
            portfolioList = [select id,name from QIPP_Portfolio__c where DMAIC_DMADV__c=:true and Portfolio_Status__c =:'Active' ORDER BY name];
            optns.add(new SelectOption('--None--','--Select One--'));
            for(QIPP_Portfolio__c pf : portfolioList){
               optns.add(new selectOption(pf.Id, pf.Name));
            }
            if(portfolioList.size()>0){
                return optns;
            }else
                return null;
         }catch(Exception e){return null;}
    }
       //getqtyAwardProjectValues method to get the picklist values of Quality Award for lean -- Added by Manish
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
         }catch(Exception exe){
             System.Debug(' ****************************EXCEPTION OCCURES in getschedulestatusvalues ****************************' + exe.getMessage());
             return null;
         }
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
         }catch(Exception exe){
                System.Debug(' ****************************EXCEPTION OCCURES in getinannualplanvalues ****************************' + exe.getMessage());
                return null;
            }
        }
        //getPortfolioBBGValue method to get the Portfoilio business unit associated with the selected portfolio
        public PageReference getPortfolioBBGValue(){
            try{
                if(portfolioName != '--None--'){
                    portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: portfolioName];
                    proj.Portfolio_BU__c = portfolioRec.Portfolio_Business_Unit__c;
                }else
                    proj.Portfolio_BU__c = '';

                //--E036-Start--//
                //bumbbName = '--None--';
                bGMBBList();
                //--E036-End--//
                return null;
            }catch(Exception e){return null;}
        }
   
   //getBumbbValues method to get all the protfolios available in the tool limit 80
    public List<SelectOption> getBumbbValues(){
        try{
            //--E036-Start--//
            system.debug('@@proj state:'+proj.Project_State__c+'**BG:'+bumbbName+'**currentView:'+currentView);
            if((proj.Project_State__c != null && proj.Project_State__c != '' && proj.Project_State__c != 'Complete' && proj.Project_State__c != 'Closed') && 
                    (proj.Id != null && !recordIsLocked(proj.Id)) &&
                     (currentView.containsIgnoreCase('qippprojecteditview') && pageMode != null && pageMode != '' && pageMode == 'edit')){
                bumbbName = '--None--';
            }
            system.debug('@@BG:'+bumbbName);
            //--E036-End--//
            
            List<SelectOption> bumbb_optns = new List<Selectoption>();
            bumbbList = [select id,name from QIPP_Contacts__c where User_License__c != null and User_License__r.Profile.Name = 'Nokia QIPP Project Lead' and User_License__r.isactive = true and (CoPQ_Role_1__c =: 'Business Unit Master Black Belt' or CoPQ_Role_2__c =: 'Business Unit Master Black Belt' or CoPQ_Role_3__c =: 'Business Unit Master Black Belt' or CoPQ_Role_4__c =: 'Business Unit Master Black Belt') and Contact_State__c =:'Active' ORDER BY name];
            bumbb_optns.add(new SelectOption('--None--','--Select One--'));
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
            system.debug('@@proj state:'+proj.Project_State__c+'**BG:'+bumbbName+'**currentView:'+currentView);
            //if(portfolioName != null && portfolioName != '--None--' && proj.Project_BL__c != null){
            if(portfolioName != null && portfolioName != '--None--'){
                //List<QIPP_BG_BU_BL_Contact_Mapping__c> bumbbList = [select id, Business_Group_Master_Black_Belt__c,Business_Group_Master_Black_Belt__r.Name from QIPP_BG_BU_BL_Contact_Mapping__c where Portfolio_Name__c =: portfolioName And Benefitting_Business_Group__c =: proj.Portfolio_BU__c And (Benefitting_Business_Unit__c =: proj.Project_BL__c Or Benefitting_Business_Unit__c = 'All Unit') ORDER BY name];
                List<QIPP_BG_BU_BL_Contact_Mapping__c> bumbbList = [select id, Business_Group_Master_Black_Belt__c,Business_Group_Master_Black_Belt__r.Name from QIPP_BG_BU_BL_Contact_Mapping__c where Portfolio_Name__c =: portfolioName ORDER BY name];
                if(bumbbList != null && bumbbList.size() > 0){

                    if((proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'Complete' || proj.Project_State__c == 'Closed') && (currentView.containsIgnoreCase('qippprojecteditview'))) || 
                            ((proj.Id != null && recordIsLocked(proj.Id)) && (currentView.containsIgnoreCase('qippprojecteditview')))){
                        if(bumbbName != null && bumbbName != '' && bumbbName != '--None--'){
                            mapBGContact.put(bumbbName, proj.Business_Unit_Master_Black_Belt__r.Name);
                        }
                    }
                    
                    for(QIPP_BG_BU_BL_Contact_Mapping__c bumbbUser : bumbbList){
                        mapBGContact.put(bumbbUser.Business_Group_Master_Black_Belt__c, bumbbUser.Business_Group_Master_Black_Belt__r.Name);
                    }

                    if(mapBGContact.size() > 1){
                        bGMBBOptions.add(new SelectOption('--None--','--Select One--'));
                    }
                    for(String con : mapBGContact.keySet()){
                        bGMBBOptions.add(new SelectOption(con, mapBGContact.get(con)));
                    }
                }else{
                    bGMBBOptions = getBumbbValues();
                }
            } else {
                bGMBBOptions.add(new SelectOption('--None--','--Select One--'));
            }
            system.debug('@@bGMBBOptions:'+bGMBBOptions);
            return null;
         }catch(Exception e){return null;}
    }
    //--E036-End--//    
    
    //getMentorCertificatValues method to get the picklist values of Mentor Certificate for DMAIC
    public List<SelectOption> getMentorCertificatValues(){
    try{
        List<SelectOption> MCert_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Mentor_Certificate__c.getDescribe();
               List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
           MCert_optns.add(new SelectOption('--None--','--None--'));
           for( Schema.PicklistEntry f : mc)
           {
              MCert_optns.add(new SelectOption(f.getLabel(), f.getValue()));
           }     
           return MCert_optns;
     }catch(Exception e){return null;}
    }
   
    //getProjectStateValues method to get the picklist values from the ProjectState Picklist for DMAIC, we ar using custom label instead of hardcoding
    public List<SelectOption> getProjectStateValues(){
    try{
        List<SelectOption> projState_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Project_State__c.getDescribe();
        List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
           for( Schema.PicklistEntry f : mc)
           {
                /*&& f.getValue()!='Not Started'){
                  projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));
                 }*/
             if(rolename=='QIPP Project Lead'){
                    if((f.getValue() != 'Not Started')){
                        if ((f.getValue() != 'Complete') ){
                            if ((f.getValue() != 'Closed')){
                                if(f.getValue()!=Label.Project_State_Complete || (f.getValue()==Label.Project_State_Complete && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed'))) {
                                    projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));
                                }    
                            }
                        }
                    }
               }
               else if(rolename=='QIPP Portfolio Owner'){
                  if((f.getValue() != 'Not Started') && (f.getValue() != 'Closed') && (f.getValue() != 'Complete') && projState != 'Complete'){
                        if(f.getValue()!=Label.Project_State_Complete || (f.getValue()==Label.Project_State_Complete && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed'))) {
                            projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                        }    
                   } 
                   else if ((f.getValue() != 'Not Started') && (f.getValue() != 'Closed') && projState == 'Complete'){
                        if(f.getValue()!=Label.Project_State_Complete || (f.getValue()==Label.Project_State_Complete && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed'))) {
                            projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                        }
                   } 
               }
               else if (rolename=='QIPP Portfolio Manager' || rolename=='QIPP Admin' || profilename=='System Administrator'){
                  if((f.getValue() != 'Not Started') && (f.getValue() != 'Complete') && projState != 'Complete'){
                        if(f.getValue()!=Label.Project_State_Complete || (f.getValue()==Label.Project_State_Complete && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed'))) {
                            projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                        }    
                   } 
                   else if ((f.getValue() != 'Not Started') && projState == 'Complete'){
                        if(f.getValue()!=Label.Project_State_Complete || (f.getValue()==Label.Project_State_Complete && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed'))) {
                            projState_optns.add(new SelectOption(f.getLabel(), f.getValue()));  
                        }
                   } 
               }
               else{
                   if((f.getValue() != 'Not Started')){
                        if(f.getValue()!=Label.Project_State_Complete || (f.getValue()==Label.Project_State_Complete && phasecompleted == 'Control' && (controlStatus == 'Completed' || controlStatus == 'Delayed'))) {
                            projState_optns.add(new SelectOption(f.getLabel(), f.getValue())); 
                        }    
                   }
               }     
           }     
           return projState_optns;
     }catch(Exception e){return null;}
    }
   
    //getMethodologyValues method to get the picklist values from Project Type picklist for DMAIC using custom labels
    public List<SelectOption> getMethodologyValues(){
    try{
        List<SelectOption> Methodology_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Project_Type__c.getDescribe();
        List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
           //Methodology_optns.add(new SelectOption('1','--None--'));
           for( Schema.PicklistEntry f : mc)
           {
              if(f.getValue()==Label.DMAICProject || f.getValue() == Label.DMADVProject){
                  Methodology_optns.add(new SelectOption(f.getLabel(), f.getValue()));
              }
           }     
           return Methodology_optns;
     }catch(Exception e){return null;}
    }
   
    //getDIStateValues method to get the values from DI State picklist from DI_State__c for DMAIC
    public List<SelectOption> getDIStateValues(){
    try{
        List<SelectOption> diState_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_Project__c.DI_State__c.getDescribe();
               List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
           diState_optns.add(new SelectOption('--None--','--None--'));
           for( Schema.PicklistEntry f : mc)
           {
              diState_optns.add(new SelectOption(f.getLabel(), f.getValue()));
           }     
           return diState_optns;
    }catch(Exception e){return null;}
    }
   
    //getbeltProjPhaseValues method to get the picklist values for Belt_Project_Phase__c for DMAIC
    public List<SelectOption> getbeltProjPhaseValues(){
    try{
        List<SelectOption> bprojphase_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Belt_Project_Phase__c.getDescribe();
               List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
           //bprojphase_optns.add(new SelectOption('1','--None--'));
           for( Schema.PicklistEntry f : mc)
           {
              if(f.getValue() != Label.Project_Phase_Initiation){
                  bprojphase_optns.add(new SelectOption(f.getLabel(), f.getValue()));
              }
           }     
           return bprojphase_optns;
     }catch(Exception e){return null;}
    }
   
    //getProjectTypeValues method to get the picklist values for Belt_Project_Type__c for DMAIC //Written by Manish
    public List<SelectOption> getProjectTypeValues(){
    try{
        List<SelectOption> bprojtype_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Belt_Project_Type__c.getDescribe();
               List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();
           bprojtype_optns.add(new SelectOption('--None--','--None--'));
           for( Schema.PicklistEntry f : mc)
           {
                  bprojtype_optns.add(new SelectOption(f.getLabel(), f.getValue()));
           }     
           return bprojtype_optns;
     }catch(Exception e){return null;}
    }
  /* 
    //Analysis inprogress for next release
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

    public void forecastDateValidation(){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Project Completion Date - Forecast should be equal or greater than Current Date'));
    }
        
        public void isValidPortfolioName(){
        if((currentView.contains('qippprojectdetailview') || currentView.contains('QIPPProjectDetailView')) && proj.Portfolio_Name__c != null){
            portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: proj.Portfolio_Name__c];
            if(proj.Portfolio_BU__c == portfolioRec.Portfolio_Business_Unit__c){
                isValidPortfolioName = true;
            }else
                isValidPortfolioName = false;
        }
    }
    public void initiateErrMsgVariables(){System.Debug('error variables declaration---');
        ProjNameError = null;
        ProjLeadError = null;
        PortfolioError = null;
        ProjDescError = null;
        PBBGError = null;
        CEMT_MeasureError = null;
        ProjMentError = null;
        ProjSponsError = null;
        ProjChampError = null;
        BUMBBError = null;
        DDPlanError = null;
        MDPlanError = null;
        ADPlanError = null;
        IDPlanError = null;
        CDPlanError = null;
        BBLError = null;
        BBUError = null;
        projDocumentError = null;
        projtypeError = null;
        MentorCertError = null;
        validPortfolioError = null;
        //ProjDescSpecCharError = null;
    }
   // errorMessages method is to findout whether the field is empty and if it is empty it will assign approriate error msg to respective variable and make it availble to dispaly a VF page message
   public void errorMessages(){
            isValidPortfolioName();
           if(proj.Project_Name_Succinct__c == null || proj.Project_Name_Succinct__c == ''){
               ProjNameError='Project Name: Please enter the value.';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjNameError));
           }//Project Name ERROR
           if(proj.Project_Lead__c == null){
               ProjLeadError = 'Project Lead: Please enter the value.';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjLeadError));
           }//Project Lead ERROR
           if((currentView.contains('qippprojecteditview') || currentView.contains('QIPPProjectEditView')) && portfolioName == '--None--'){
               PortfolioError = 'Portfolio Name: Please enter the value.';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,PortfolioError));               
           }
           if((currentView.contains('qippprojectdetailview') || currentView.contains('QIPPProjectDetailView')) && proj.Portfolio_Name__c == null ){
               PortfolioError = 'Portfolio Name: Please enter the value.';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,PortfolioError));               
            }
            /*if(isValidPortfolioName){
                    validPortfolioError = 'Portfolio Name: Business/Functional Group should be the same between Portfolio and Project. Please select the appropriate Business/Functional Group.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,validPortfolioError));
            }*///Portfolio Name ERROR
            if(proj.Project_Description_Detailed__c =='1800 Character Limit' || proj.Project_Description_Detailed__c == null || proj.Project_Description_Detailed__c == ''){
               ProjDescError = 'Project Description: Please enter the value.';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjDescError));              
            }
           if(proj.Portfolio_BU__c == null || proj.Portfolio_BU__c == ''){
                PBBGError = 'Benefitting Business Grp/Functional Grp: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,PBBGError));               
            }//Portfolio Name ERROR
           if (proj.CEMT_ID__c == null || proj.CEMT_ID__c == ''){
                CEMT_MeasureError = 'Measure-ID/CEMT-ID: Blank space not accepted, please use Not Applicable instead.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,CEMT_MeasureError));
            }
            if (proj.Belt_Candidate_Mentor__c == null){
                ProjMentError = 'Project Mentor: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjMentError));
            }
            if(proj.Belt_Project_Sponsor__c == null){
                ProjSponsError = 'Project Sponsor: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjSponsError));
            }
            if((currentView.contains('qippprojecteditview') || currentView.contains('QIPPProjectEditView')) && projectype == '--None--'){
                projtypeError = 'Project Type: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,projtypeError));
            }
            if((currentView.contains('qippprojectdetailview') || currentView.contains('QIPPProjectDetailView')) && proj.Belt_Project_Type__c == null){
                projtypeError = 'Project Type: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,projtypeError));
            }
            if(proj.Belt_Project_Champion__c ==null){
                ProjChampError = 'Project Champion: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ProjChampError));
            }
            if((currentView.contains('qippprojecteditview') || currentView.contains('QIPPProjectEditView')) && mcertName == '--None--'){
                MentorCertError = 'Mentor Certificate: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,MentorCertError));
            }
            if((currentView.contains('qippprojectdetailview') || currentView.contains('QIPPProjectDetailView')) && proj.Mentor_Certificate__c == null){
                MentorCertError = 'Mentor Certificate: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,MentorCertError));
            }
            system.debug('@@bumbbName:'+bumbbName);
            //--E036-Start--//
            if(bumbbName =='--None--' || bumbbName == null){
            //--E036-End--//
                BUMBBError = 'Business Group Master Black Belt: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,BUMBBError));
            }
            if (proj.DMAIC_Define__c == null) {
                DDPlanError = 'Define Date - Planned: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,DDPlanError));
            }
            if (proj.DMAIC_Measure__c == null) {
                MDPlanError = 'Measure Date - Planned: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,MDPlanError));
            }
            if (proj.DMAIC_Analyze__c == null) {
                ADPlanError = 'Analyze Date - Planned: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ADPlanError));
            }
            if (proj.DMAIC_Improve__c == null) {
                IDPlanError = 'Improve / Design Date – Planned: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,IDPlanError));
            }
            if (proj.DMAIC_Control__c == null) {
                CDPlanError = 'Control / Verify Date – Planned: - Planned: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,CDPlanError));
            }
            if(proj.Project_BL__c == null /*&& proj.Portfolio_BU__c != null*/ ){
                BBUError = 'Benefitting Business Unit: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,BBUError));
            }
            if(/*proj.Project_BL__c != null &&*/ proj.Benefitting_Project_BL_Level_4_Org__c == null ){
                BBLError = 'Benefitting Business Line: Please enter the value.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,BBLError));
            }
            //--Added by Rahul(E122)(14-11-2016)(25-11-2016)-- adding if condition --Start--//
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
                }
            }
            //--Added by Rahul(E122)(14-11-2016)-- adding if condition --End--//            
            //System.debug('portfolioName'+portfolioName+'===='+currPortfolioId);
            if((currentView.contains('QIPPProjectEditView') || currentView.contains('qippprojecteditview')) && (portfolioName != '--None--' || currPortfolioId != null)){//if (proj.Portfolio_Name__c != null && currPortfolioId == null){
                try{ 
                proj.Portfolio_Name__c = portfolioName;
                System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);
                   }catch(Exception e){System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);System.Debug('Portfolio_Name__c : '+proj.Portfolio_Name__c);}
                }
                System.Debug('ProjLeadError : '+ProjLeadError);
            if(bumbbName != '--None--'){     
                proj.Business_Unit_Master_Black_Belt__c = bumbbName;
            }

            //--Added by Rahul(E122)(14-11-2016)(25-11-2016)-- adding if condition --Start--//
            if(proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'In Progress')){
                if(proj.Control_Verify_Date_Forecast__c != null){
                        if((currentView.contains('QIPPProjectDetailView') || currentView.contains('qippprojectdetailview')) && proj.Control_Verify_Date_Forecast__c  < system.Today() && (proj.Project_State__c == 'In Progress'))
                        {
                                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Control/verify-forecast date should be equal or greater than current date'));
                        }
                        if((currentView.contains('QIPPProjectEditView') || currentView.contains('qippprojecteditview')) && proj.Control_Verify_Date_Forecast__c  < system.Today() && (projState == 'In Progress'))
                        {
                                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Control/verify-forecast date should be equal or greater than current date'));
                        }
                }
                if(proj.Control_Verify_Date_Forecast__c == null){
                        if((currentView.contains('QIPPProjectDetailView') || currentView.contains('qippprojectdetailview')) && proj.DMAIC_Control__c < system.Today()  && (proj.Project_State__c == 'In Progress'))
                        {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Control/verify-forecast date should be equal or greater than current date'));
                        }
                        if((currentView.contains('QIPPProjectEditView') || currentView.contains('qippprojecteditview')) && proj.DMAIC_Control__c < system.Today() && (projState == 'In Progress'))
                        {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Control/verify-forecast date should be equal or greater than current date'));
                        }
    
                }
                
                //--Added by Rahul(E086)(14-11-2016)-- --Start--//
                //validate project mentor is match contact BG with cunfiguration values at project creation
                if(proj.Id == null && proj.Belt_Candidate_Mentor__c != null && !cmnFunct.validContactBG(proj.Belt_Candidate_Mentor__c,'Project Mentor')){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Provided \'Project Mentor\' Contact does not exist or does not match filter criteria.'));
                }
    
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
        system.debug('@@BGMBB Before:'+bumbbName+'--'+Proj.Business_Unit_Master_Black_Belt__c);
        
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
            //prjLeadSponsorEqual = false;
        }
        
        
         
        if(currentView.contains('QIPPProjectEditView') && proj.id==null && Cloneid == null){// Save on creating a project
            System.Debug('projectype===='+projectype);
            proj.Project_State__c = projState;
            proj.Mentor_Certificate__c = mcertName;
            proj.Project_Type__c = methodology;
            proj.DI_State__c = diState;
            proj.Belt_Project_Type__c=projectype;
            proj.Belt_Project_Phase__c = beltProjPhase;
            proj.Permission_to_use_Belt_Info__c = permBeltInfo;
            proj.Quality_Award_Project__c = qtyAwardProj;
            errorMessages();
            if(ProjNameError != null || PBBGError != null || BBUError != null || BBLError != null || ProjLeadError != null || PortfolioError != null || validPortfolioError != null || ProjDescError != null || /*ProjDescSpecCharError != null || */CEMT_MeasureError != null || ProjMentError != null || ProjSponsError != null || ProjChampError != null || BUMBBError != null || DDPlanError != null || MDPlanError != null || ADPlanError != null || IDPlanError != null || CDPlanError != null || /*projtypeError != null || */MentorCertError != null || projDocumentError != null) {
                return null;
            }
                        
            /*if((proj.DMAIC_Control__c < system.Today() || proj.Control_Verify_Date_Forecast__c  < system.Today()) && (projState == 'In Progress'))
            {
                            errorMessages();    
                                return null; 
            }*/
        }else if((currentView.contains('qippprojecteditview') || currentView.contains('QIPPProjectEditView')) && proj.id!=null){// Save on Editing a project from edit view
            proj.Project_State__c = projState;
            proj.Mentor_Certificate__c = mcertName;
            proj.Project_Type__c = methodology;
            proj.DI_State__c = diState;
            proj.Belt_Project_Type__c=projectype;
            proj.Belt_Project_Phase__c = beltProjPhase;
            proj.Permission_to_use_Belt_Info__c = permBeltInfo;
            proj.Quality_Award_Project__c = qtyAwardProj;
            errorMessages();
            if(ProjNameError != null || PBBGError != null || BBUError != null || BBLError != null || ProjLeadError != null || PortfolioError != null || validPortfolioError != null|| ProjDescError != null || /*ProjDescSpecCharError != null || */CEMT_MeasureError != null || ProjMentError != null || ProjSponsError != null || ProjChampError != null || BUMBBError != null || DDPlanError != null || MDPlanError != null || ADPlanError != null || IDPlanError != null || CDPlanError != null || /*projtypeError != null || */MentorCertError != null || projDocumentError != null) {
                return null;
            }
            
            /*if((proj.DMAIC_Control__c < system.Today() || proj.Control_Verify_Date_Forecast__c  < system.Today()) && (projState == 'In Progress'))
            {
               errorMessages();
               return null; 
            }*/
        }else if((currentView.contains('qippprojectdetailview') || currentView.contains('QIPPProjectDetailView')) && proj.id!=null){// Save on Editing a project from detail view
            errorMessages();

           /*if((proj.DMAIC_Control__c < system.Today() || proj.Control_Verify_Date_Forecast__c  < system.Today()) && (proj.Project_State__c == 'In Progress'))
            {
                errorMessages();
                                //forecastDateValidation();
                return null; 
            }*/

            if(ProjNameError != null || PBBGError != null || BBUError != null || BBLError != null || ProjLeadError != null || PortfolioError != null || validPortfolioError != null|| ProjDescError != null || /*ProjDescSpecCharError != null || */CEMT_MeasureError != null || ProjMentError != null || ProjSponsError != null || ProjChampError != null || BUMBBError != null || DDPlanError != null || MDPlanError != null || ADPlanError != null || IDPlanError != null || CDPlanError != null || /*projtypeError != null || */MentorCertError != null || projDocumentError != null) {
                return null;
            }

        }else if(currentView.contains('qippprojecteditview') || currentView.contains('QIPPProjectEditView') && proj.id==null && Cloneid != null){
            errorMessages();
            if(ProjNameError != null || PBBGError != null || BBUError != null || BBLError != null || ProjLeadError != null || PortfolioError != null || validPortfolioError != null|| ProjDescError != null || /*ProjDescSpecCharError != null || */CEMT_MeasureError != null || ProjMentError != null || ProjSponsError != null || ProjChampError != null || BUMBBError != null || DDPlanError != null || MDPlanError != null || ADPlanError != null || IDPlanError != null || CDPlanError != null || /*projtypeError != null || */MentorCertError != null || projDocumentError != null) {
                return null;
            }
            /*if((proj.DMAIC_Control__c < system.Today() || proj.Control_Verify_Date_Forecast__c  < system.Today()) && (projState == 'In Progress'))
            {
               errorMessages();
               return null; 
            }*/
        }
        if(proj.id==null){           
            proj.RecordTypeId = recordtypeID;
          // proj.Distribution__c = 100;
           // createBBG = true;
        }
            system.debug('@@BGMBB:'+bumbbName+'--'+Proj.Business_Unit_Master_Black_Belt__c);
            System.Debug('proj.Project_Created_Date__c : '+proj.Project_Created_Date__c);
            System.Debug('proj.Belt_Project_Phase__c :'+proj.Belt_Project_Phase__c);
            System.Debug('ApexPages.getMessages().size()'+ApexPages.getMessages().size());
            try{
                ApexPages.StandardController newController = new ApexPages.StandardController(proj);
                QIPP_Project__c projbbg;
                if(ApexPages.getMessages().size() == 0){
                    PageReference pageRef = newController.save();
                    return PageRef;
                }
                else{return null;}
            }catch(Exception e){
                system.debug(e.getMessage()+'===='+e.getLineNumber());
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to create'));
                return null;
            }
    }
   
    //saveAndNew methos to save new/edited/cloned project and navigate to create layout
    public pagereference saveAndNew(){
        initiateErrMsgVariables();
        try{
            if(!prjLeadSponsorEqual){
                 if((proj.Project_Lead__c != null && proj.Belt_Project_Sponsor__c!= null) && (proj.Project_Lead__c == proj.Belt_Project_Sponsor__c)){
                     projLeadSponsorEqual = true;
                     prjLeadSponsorEqual = true;
                     return null;
                }
            }
            else{
                projLeadSponsorEqual = false;
                //prjLeadSponsorEqual = false;
            }
            if(currentView.contains('QIPPProjectEditView') && proj.id==null){ // saveAndNew on creating a project
                proj.Project_State__c = projState;
                proj.Mentor_Certificate__c = mcertName;
                proj.Project_Type__c = methodology;
                proj.Belt_Project_Type__c=projectype;
                proj.DI_State__c = diState;
                proj.Belt_Project_Phase__c = beltProjPhase;
                proj.Permission_to_use_Belt_Info__c = permBeltInfo;
                proj.Quality_Award_Project__c = qtyAwardProj;
                errorMessages();
                if(ProjNameError != null || PBBGError != null || BBUError != null || BBLError != null || ProjLeadError != null || PortfolioError != null || validPortfolioError != null|| ProjDescError != null || /*ProjDescSpecCharError != null || */CEMT_MeasureError != null || ProjMentError != null || ProjSponsError != null || ProjChampError != null || BUMBBError != null || DDPlanError != null || MDPlanError != null || ADPlanError != null || IDPlanError != null || CDPlanError != null || /*projtypeError != null ||*/ MentorCertError != null || projDocumentError != null) {
                    return null;
                }
            }else if(currentView.contains('qippprojecteditview') && proj.id!=null){//saveAndNew on editing a project
                proj.Project_State__c = projState;
                proj.Mentor_Certificate__c = mcertName;
                proj.Project_Type__c = methodology;
                proj.Belt_Project_Type__c=projectype;
                proj.DI_State__c = diState;
                proj.Belt_Project_Phase__c = beltProjPhase;
                proj.Permission_to_use_Belt_Info__c = permBeltInfo;
                errorMessages();
                if(ProjNameError != null || PBBGError != null || BBUError != null || BBLError != null || ProjLeadError != null || PortfolioError != null || validPortfolioError != null|| ProjDescError != null || /*ProjDescSpecCharError != null || */CEMT_MeasureError != null || ProjMentError != null || ProjSponsError != null || ProjChampError != null || BUMBBError != null || DDPlanError != null || MDPlanError != null || ADPlanError != null || IDPlanError != null || CDPlanError != null || /*projtypeError != null || */MentorCertError != null || projDocumentError != null) {
                    return null;
                }
            }
            if(proj.id==null){               
                proj.RecordTypeId = recordtypeID;
                //proj.Distribution__c = 100;
               // createBBG = true;
            }
                upsert proj;

            string cancelurl = ApexPages.currentPage().getParameters().get('cancelURL');
            //string calcelurl12 = '/apex/QIPPProjectDetailView?id='+proj.Id;
            Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
                string calcelurl12 = '/' + R.getKeyPrefix()+'/o';
            string s = '/apex/QIPPProjectEditView?cancelURL='+calcelurl12+'&RecordType=Methodology%3A+DMAIC+%2F+DMADV&retURL=%2Fa18%2Fo';       
            //string s = '/apex/QIPPProjectEditView?cancelURL=https%3A%2F%2Fcs22.salesforce.com%2Fa18%3Ffcf%3D00BU000000379CY';//%2Fapex%2FQIPP_project_home&RecordType=Methodology%3A+DMAIC+%2F+DMADV&retURL=%2Fa18%2Fo' ;
            Pagereference pageref = new Pagereference(s);
            pageref.setredirect(true);
            return pageref;
        }catch(Exception e){
            System.Debug('Exception --'+e.getMessage());
            ApexPages.StandardController newController = new ApexPages.StandardController(proj);
            //PageReference pageRef = newController.save();
            save();
            return null;
        }       
    }
   
    
    // edit method to restrict the user if the record is in Approval process "During phase "
    public pagereference edit(){
        if(recIsLocked){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Record Locked :'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'The record you are trying to edit has been locked. '));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please contact your administrator if access is necessary.'));
            return null;
        }else {//veera:based on this condition portfolio owner edit only under their projes only other portfolio owner project can not able to edit
            
            PageReference pageref = Page.QIPPProjectEditView;
            pageref.getParameters().put('id', proj.id);
            //--E036-Start--//
            pageref.getParameters().put('pgMode', 'edit');
            //--E036-End--//
            pageref.setredirect(true);
            
            return pageref;
        }
        //veera : if user not have edit permission we provide message
        /*else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Your not portfolio owner for this project :'));
            return null;
        }*/
        //veera
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
            //returnPage.setredirect(true);
        }else if(retURL != null){
            returnPage = new PageReference(retURL);
            //returnPage.setredirect(true);
        }else if(prjid != null ){
            returnPage = new PageReference('/apex/QIPPProjectDetailView?id='+prjid);
            returnPage.setredirect(true);
        }
        else if(CloneID != null ){
        System.Debug('CloneID ==='+CloneID);
            returnPage = new PageReference('/apex/QIPPProjectDetailView?id='+CloneID);
            returnPage.setredirect(true);
        }
        return returnPage;
    }
    
    public void closeLeadSponsorEqualPopup(){
        projLeadSponsorEqual = false;
        prjLeadSponsorEqual = false;
    }
    
   public void closeskipapprovalPopup(){
        proj.BGMBB_Rejected__c = false;
        proj.SkipMentor_Lean_Approval__c=false;
        update proj;
    }
    
     public void approveskipapprovalPopup(){
      proj.BGMBB_Rejected__c=false;
      proj.SkipMentor_Lean_Approval__c=true;
      update proj;
        
            }
    //Cancel for Validation Rule - Written By Manish
    public pagereference ValidationCancel(){
       string prjid = ApexPages.currentPage().getParameters().get('id');
       PageReference returnPage = new PageReference('/apex/QIPPProjectDetailView?id='+prjid);
       returnPage.setredirect(true);
       
        return returnPage;
    }
    //deleteRecord method to restrict the user if the record is in approval process
    public pagereference deleteRecord(){
        if(recIsLocked){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Record Locked :'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'The record you are trying to Delete has been locked. '));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please contact your administrator if access is necessary.'));
            return null;
        }else{
             displaydelPopup = true;
            return null;
        }
    }
   
    //cloneProject method is to navigate to the create layout to clone the DMAIC record
    public pagereference cloneProject(){
        PageReference pageref = Page.QIPPProjectEditView;
        pageref.getParameters().put('CloneID', proj.id);
        pageref.getParameters().put('RecordType', 'Methodology: DMAIC / DMADV');
        pageref.setredirect(true);
        return pageref;
    }
    
   
    //reqApproval method is to request the approval process for all DMAIC phases
    public pagereference reqApproval(){
        integer savingsAmt = QIPP_ApprovalsProcessNonSixSigma.DMAIC_Savings(proj.Id);
        string fa= proj.Finance_Approver__c;
        string proj_doc = proj.Project_Document__c;
        string Phase = proj.Belt_Project_Phase__c;
        system.debug('***savingsAmt**'+savingsAmt+'***fa**' +fa+'**proj_doc***' +proj_doc+'****Phase*'+Phase );
        string projectState = proj.Project_State__c;
        Decimal  benefitCount = proj.Countof_Benefits__c;
        Decimal  benefitOverrideCnt = proj.Ben_Override_Resp_From_BUMBB__c;
        string ptousebeltinfo=proj.Permission_to_use_Belt_Info__c;
        Date defineForcast = proj.Define_Date_Forecast__c;
        Date measureForcast = proj.Measure_Date_Forecast__c;
        Date analyseForcast = proj.Analyze_Date_Forecast__c;
        Date improveForcast = proj.Improve_Design_Date_Forecast__c;
        Date controlForcast = proj.Control_Verify_Date_Forecast__c;
        boolean Taskcheck = QIPP_ApprovalsProcessNonSixSigma.TasksCheck(proj.Id);
        boolean ImpMeasurecheck = QIPP_ApprovalsProcessNonSixSigma.ImpMeasurescheck(proj.Id);
        boolean businessActivityCheck = QIPP_ApprovalsProcessNonSixSigma.BusinessActivities(proj.Id); // added by Haripriya
        boolean projectredepCheck = QIPP_ApprovalsProcessNonSixSigma.ProjectRedeployments(proj.Id);
        // Define Phase Validations
        system.debug('ApprovalPro :');
        if(recIsLocked){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project is already under Approval Process'));
        }
        else if (Phase == 'Complete')
        {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Phase Completion Approval Request cannot be raise for \'Complete\' Project Phase'));
        }
        else if(Phase=='Define' && ((proj_doc==null || proj_doc == '')|| (fa==''||fa==null) || businessActivityCheck == false || savingsAmt == 0 ||(projectState == 'On Hold' || projectState == 'Canceled'))){
            system.debug('inelseIfDefine condition :');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,' Note :- The below items are required before submitting a project for \'Define\' phase approval'));
            if (projectState == 'On Hold' || projectState == 'Canceled'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));
            }
            if(proj_doc==null || proj_doc == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is mandatory during Define Phase.'));
            }
            if( fa=='' || fa==null ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Finance Approver is mandatory during Define Phase.'));
            }
            if(savingsAmt == 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Improvement Measure is attached to the Project and \'Benefit Savings Amount\'.'));
            }
            if(businessActivityCheck == false){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Business Activity was mapped to the Project.'));
            }
            if(proj.Project_Completion_Date_Forecast__c < system.Today())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
            }
        }
        else if(Phase=='Measure' && ((proj_doc==null || proj_doc == '') || benefitCount ==0 || measureForcast== null || analyseForcast== null || improveForcast == null || controlForcast== null ||(projectState == 'On Hold' || projectState == 'Canceled'))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Note :- The below items are required before submitting a project for \'Measure\' phase approval'));
            if (projectState == 'On Hold' || projectState == 'Canceled'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));
            }
            if(proj_doc==null || proj_doc == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is mandatory during Measure Phase'));
            }
            if(benefitCount ==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project should have at least one Benefit associated with it during Measure Phase.'));
            }
            if(measureForcast==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Measure Date – Forecast\' should be present'));
            }
            if(analyseForcast==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Analyze Date – Forecast\' should be present'));
            }
            if(improveForcast==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Improve / Design Date – Forecast\' should be present'));
            }
            if(controlForcast==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Control / Verify Date – Forecast\' should be present'));
            }
            if(proj.Project_Completion_Date_Forecast__c < system.Today())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
            }
        }
        else if(Phase=='Analyze' && ((proj_doc==null || proj_doc == '') || benefitCount ==0 || analyseForcast==null || improveForcast==null || controlForcast==null ||(projectState == 'On Hold' || projectState == 'Canceled'))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Note :- The below items are required before submitting a project for \'Analyze\' phase approval'));
            if (projectState == 'On Hold' || projectState == 'Canceled'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));
            }
            if(proj_doc==null || proj_doc == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is mandatory during Analyze Phase'));
            }
            if(benefitCount ==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project should have at least one Benefit associated with it during Analyze Phase'));
            }
            if(analyseForcast==null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Analyze Date – Forecast\' should be present'));
            }
            if(improveForcast==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Improve / Design Date – Forecast\' should be present'));
            }
            if(controlForcast==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Control / Verify Date – Forecast\' should be present'));
            }
            if(proj.Project_Completion_Date_Forecast__c < system.Today())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
            }
        } // Improve / Design Phase Validations
        else if(Phase=='Improve / Design' && ((proj_doc==null || proj_doc == '') || benefitCount ==0 || improveForcast==null || controlForcast==null ||(projectState == 'On Hold' || projectState == 'Canceled'))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Note :- The below items are required before submitting a project for \'Improve / Design phase\' approval'));
            if (projectState == 'On Hold' || projectState == 'Canceled'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));
            }
            if(proj_doc==null || proj_doc == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is mandatory during Analyze Phase'));
            }
            if(benefitCount ==0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project should have at least one Benefit associated with it during Improve / Design Phase Phase'));
            }
            if(improveForcast==null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Improve / Design Date – Forecast\' should be present')); 
            }
            if(controlForcast==null){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Control / Verify Date – Forecast\' should be present'));  }
            
            if(proj.Project_Completion_Date_Forecast__c < system.Today()){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));}
        } // Control / Verify Phase Validations
        else if(Phase=='Control / Verify' && ((proj_doc==null || proj_doc == '') || businessActivityCheck == false || ptousebeltinfo=='' || benefitOverrideCnt > 0 || controlForcast==null|| savingsAmt != 1 || (fa==''||fa==null) || Taskcheck == true || (Phase =='Control / Verify' && ImpMeasurecheck == true) ||(projectState == 'On Hold' || projectState == 'Canceled' || projectredepCheck == false))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Note :- The below items are required before submitting a project for \'Control / Verify\' phase approval'));
            if (projectState == 'On Hold' || projectState == 'Canceled'){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Projects in \"On Hold\" or \"Canceled\" project state must be changed to the \"In Progress\" state.  Also check that a future date is entered in the \"Completion Date - forecast\" field.'));
            }
            if(proj_doc==null || proj_doc == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project Document is mandatory during Control / Verify Phase'));
            }
            if(ptousebeltinfo==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Permission to Use Belt Info is mandatory during Control / Verify Phase'));
            }
            if(benefitOverrideCnt > 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Benefit override is in progress for one or more benefits associated with this project. This needs to be approved by the BU MBB before the Control / Verify phase can be submitted for approval'));
            }
            if(controlForcast==null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, '\'Control / Verify Date – Forecast\' should be present'));
            }
            if(savingsAmt != 1){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Improvement Measure is attached to the Project, and that ‘Planned’ and ‘Achieved’ Savings amounts are populated'));
            }
            if(fa==''||fa==null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Finance Approver is mandatory during Control / Verify Phase'));
            }
            if(Taskcheck == true){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'All Tasks must be either \'Complete\' or \'Canceled\' before the Control / Verify phase can be submitted for approval'));
            }
            // Checking for real Improvement Measure
            if(Phase =='Control / Verify' && ImpMeasurecheck == true){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'A project cannot be submitted for Control Phase approval with a Benefit that is using the “Generic KPI (Internal Use Only)” Improvement Measure. Please update this project’s benefit(s) to be using a defined KPI or PI'));
            }
            if(businessActivityCheck == false){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please ensure that at least one Business Activity was mapped to the Project.'));
            }
            if(proj.Project_Completion_Date_Forecast__c < system.Today())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
            }
            if(projectredepCheck == false){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please select project redeployment opportunity at ‘Project Re-Deployment Section’ below”'));
            }  
         }
          
            
        else if(proj.Project_Completion_Date_Forecast__c < system.Today()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Users can not initiate Phase Completion Approval Requests, if the \'Completion Date - forecast\' is in the past.'));
        }else{
            //--Added by Rahul(E086)(14-11-2016)-- --Start--//
            //validate project mentor is match contact BG with cunfiguration values at project creation
            if(proj.Belt_Candidate_Mentor__c != null && !cmnFunct.validContactBG(proj.Belt_Candidate_Mentor__c,'Project Mentor')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Provided Project Mentor Contact is not actual Salesforce User or not a configured as Project Mentor. Contact your Administrator to get QIPP Salesforce account.'));
                return null;
            }

            //validate project finance is match contact BG with cunfiguration values at project creation
            if(proj.Finance_Approver__c != null && !cmnFunct.validContactBG(proj.Finance_Approver__c,'Finance Approver')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Provided Finance Approver Contact is not actual Salesforce User or not a configured as F&C. Contact your Administrator to get QIPP Salesforce account.'));
                return null;
            }
            //--Added by Rahul(E086)(14-11-2016)-- --End--//

            displayPopup = true;
        }
        return null;
    }
   
    public void closePopup() {       
        displayPopup = false;   
    }
    public void closedelPopup() {       
        displaydelPopup = false;   
    }
   
    //deleteprj to delete the record and to navigate to project home page
    public pageReference deleteprj(){  
        PageReference pg = null;
        system.debug('************* inside approve*************** ::');
        displaydelPopup = false;
        //PageReference pageref = Page.QIPPProjectEditView;
        Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
       
        ApexPages.StandardController newController = new ApexPages.StandardController(proj);
        try{   
            PageReference pageRef1 = newController.delete();
            //pageRef1.getParameters().put('retURL','/a18?fcf=00BU000000379CY');
            return PageRef1;
        }catch(Exception e){ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to delete'));
            return null;
        }
      
    }
    //Subhash: actions to be done if Benfit override approved    
    public pageReference submitapprove(){  
        PageReference pg = null;
        system.debug('************* inside approve*************** ::');
        displayPopup = false;
        string msg = QIPP_ApprovalsProcessNonSixSigma.SubmitApproval(proj.Id);
        if(msg == '1'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Sucessfully submited for approval'));
            pg = new PageReference('/apex/QIPPProjectDetailView?id='+proj.Id);
            pg.setRedirect(true);
            return pg;
        }else
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please follow the guidance.'+ msg));
            return null;
       
    }
    

   
    public PageReference unlockRecord(){
        try{
            Approval.UnlockResult uResult = Approval.unlock(proj.Id);
            //System.Approval.unlock(theId);
            PageReference pgRef = new PageReference('/apex/QIPPProjectDetailView?id='+proj.Id);
            pgRef.setRedirect(true);
            return pgRef;
        }catch(Exception e){return null;}
    }
   
    public Boolean recordIsLocked(ID projId){
        ID recId = projId;
        recIsLocked = Approval.isLocked(recId);
        System.Debug('recIsLocked : '+recIsLocked );
        return recIsLocked;
    }
   
    Public void importCSVFile(){
        //System.Debug('prjObj:' +prjObj);
        try{
        csvAsString = csvFileBody.toString();
        csvfilelines = csvAsString.split('\n');
        inputvalues = new String[]{};
        for(string st:csvfilelines[0].split(','))
           fieldList.add(st); 
 
        System.Debug('csvAsString : '+csvAsString);
        System.Debug('csvfilelines : '+csvfilelines);
        System.Debug('fieldList : '+fieldList);
        for(Integer i=1;i<csvfilelines.size();i++){
           string[] csvRecordData = csvfilelines[i].split(',');
           proj.Project_Name_Succinct__c = csvRecordData[0];
           /*proj.Portfolio_Name__c portfolioName = csvRecordData[1];*/
           proj.Project_Description_Detailed__c = csvRecordData[1];
           proj.Project_State__c = csvRecordData[2];
           proj.Portfolio_BU__c = csvRecordData[3];
          /* String dt = csvRecordData[4];
           mydate = date.parse(dt);
           proj.Project_Completion_Date_Forecast__c = mydate;*/
 
           System.Debug('csvRecordData'+i+':' +csvRecordData);
           sObjectList.add(proj); 
           }
        }catch(Exception e){  }
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
        
        public BAMWrapper(){}
        public BAMWrapper(String activityName_val, String businessFunc_val, String valueStream_val){
            activityName = activityName_val;
            businessFunc = businessFunc_val;
            valueStream = valueStream_val;
        }        
    }
    //--Added by Rahul(02-09-2016)--End--//
    
}