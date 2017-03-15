public with sharing class QIPP_Other_Project {
    public QIPP_Project__c proj{get;set;}

    public String portfolioName{get;set;}
    //public List<QIPP_Portfolio__c> portfolioList{get;set;}

    public String genericError{get;set;}
    public String portfolioError{get;set;}
    public String profileName{get;set;}
    public String roleName{get;set;}
    public String phasecompleted{get;set;}
    public Id projectId{get;set;}
    public String projState{get;set;}
    public Boolean recIsLocked{get;set;}
    public Decimal benefitAmount{get;set;}
    
    public String currPortfolioId;
    public String recordtypeName;
    public String recordtypeID;
    public Id cloneid{get;set;}
    public QIPP_Portfolio__c portfolioRec;
    
    public Map<String,String> errMessageMap{get;set;}
    public String reqApprovalMessage{get;set;}
    public boolean displayPopup{get;set;}
    public boolean isAlertType{get;set;}
    public boolean isSubmitProcess{get;set;}    
    
    public String currentView;
    public String qtyAwardProj{get;set;}
    
    public List<BAMWrapper> BAMWrapperList{get;set;}
    public List<QIPP_Project__c> activityList{get;set;}
    public List<QIPP_Benefit__c> Benefits_RelatedList {get;set;}
    public List<benefitGrandTotals> benefitGrandTotalsList{get;set;} 
    
    public boolean projLeadSponsorEqual{get;set;}
    public boolean prjLeadSponsorEqual;      
    
    public QIPPCommonFuctionController cmnFunct;
    public boolean hasSaveValidationError = false;
    public boolean enableInlineEdit{get;set;}
    
    public list<Benefiting_Business_Group__c> deleteChildBBG{get;set;}
    public list<Benefiting_Business_Group__c> updateChildBBG{get;set;}
    public boolean issaveandnew{get;set;}
    
    public QIPP_Other_Project(ApexPages.StandardController stdController){

        proj = new QIPP_Project__c();
        cmnFunct = new QIPPCommonFuctionController();
        portfolioRec = new QIPP_Portfolio__c();
        projectId = null;
        reqApprovalMessage = '';
        displayPopup = false;
        isAlertType = true;
        roleName = '';
        projLeadSponsorEqual = false;
        prjLeadSponsorEqual = false;
        enableInlineEdit = true;
        issaveandnew = false;
        
        deleteChildBBG= new list<Benefiting_Business_Group__c>();
        updateChildBBG= new list<Benefiting_Business_Group__c>();
        
        Id theId = ApexPages.currentPage().getParameters().get('id');        
        currPortfolioId = ApexPages.currentPage().getParameters().get('currPortfolio');
        currentView = ApexPages.currentPage().getUrl();
        Cloneid = ApexPages.currentPage().getParameters().get('CloneID');        
        recordtypeName = ApexPages.currentPage().getParameters().get('RecordType') != null && ApexPages.currentPage().getParameters().get('RecordType') != '' ? ApexPages.currentPage().getParameters().get('RecordType') :'Methodology: Other Methodology';
        GenericError = 'Error: You must enter a value';

        List<QIPP_Contacts__c> loggedInContact = [select id,name from QIPP_Contacts__c where User_License__c =: UserInfo.getUserId()  and Email__c =: UserInfo.getUserEmail()];
    
        Profile profilena =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        profilename = profilena.Name;
        if(UserInfo.getUserRoleId()!= null){
            UserRole rolenames = [SELECT Id, Name FROM userrole WHERE Id=:UserInfo.getUserRoleId() LIMIT 1];
            roleName = rolenames.Name;
        }        
        /*
        if(theId != null || Cloneid != null){
             recordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: Other Methodology').getRecordTypeId();
        }else if(recordtypeName != null){
             recordtypeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get(recordtypeName).getRecordTypeId();
        }
        */
        recordtypeID = cmnFunct.getObjectRecordTypeIdByName('QIPP_Project__c',recordtypeName);
        if(recordtypeID == null || recordtypeID == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Invalid Record type.'));
            return;
        }            

        if(theId != null){
            proj = [SELECT Id, Name, Approver_Improvement_Owner__c, CIF_Phase__c,Total_Project_Validation_Amount__c ,Distribution__c,Impacted_Quality_BGs__c ,Impacted_Mobile_Networks_BGs__c,Impacted_MCA_BGs__c ,Impacted_Legal_Compliance_BGs__c ,Impacted_IP_Optical_Networks_BGs__c ,Impacted_Human_Resources_BGs__c ,Impacted_Global_BGs__c ,Impacted_Fixed_Networks_BGs__c ,Impacted_Customer_Operations_BGs__c , Impacted_CSD_BGs__c , Impacted_CIOO_BGs__c , Impacted_Chief_Financial_Office_BGs__c , Impacted_Applications_Analytics_BGs__c, Reason_for_no_Financial_Impact__c, Institutionalize_Date__c , Deployment_Date__c, Improvement_Owner__c , Project_Sponsor__c, Approver_Financial_Approver__c,Portfolio_Owner_Id__c,TotalKPI__c,TotalCOPQ__c,Approver_Project_Owner__c, CEMT_ID__c, Belt_Project_Sponsor__r.name,Project_Completion_Date_Forecast__c,Project_Lead__r.name,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c,Project_Lead_Business_Grp__c,CreatedById,CreatedDate,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid,Project_Name_Succinct__c,Lean_Project_Type__c, Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Project_Sponsor__c,Lean_Coach__c,Lean_Coach__r.name,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Progress_To_Date__c,Next_Steps__c,Project_Type__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Owner__c,Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Project_Created_Date__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,Lean_Project_Phase__c,LastModifiedById,LastModifiedDate,Lean__c, In_Annual_Plan__c, Number_of_Kaizens__c, Schedule_Status__c,X5S__c, Root_Cause_Analysis_Fishbone_5_Whys__c, Autonomation__c, SMED__c, Ergonomics__c, Spaghetti_Diagrams__c, Inspections__c, standard_work__c, Kanban__c, Time_Study__c,Levelized_Production__c, Total_Productive_Maintenance_TPM__c,Poka_yoke__c,Visual_Management__c,Workload_Balancing__c,Yamazumi_Charts__c,One_Piece_Flow__c, Pull__c, Other__c,Benefit_Spread_Over_Year__c FROM QIPP_Project__c WHERE Id =: theId];
            recordIsLocked(proj.Id);
            portfolioName = proj.Portfolio_Name__c;
            //proj.Project_Created_Date__c = system.today();//Commented by Manish: Causing issue on Detail page
            qtyAwardProj = proj.Quality_Award_Project__c;
        
        }else if(cloneid != null){
            QIPP_Project__c cloneproj = [SELECT Id, Name, Approver_Improvement_Owner__c,Total_Project_Validation_Amount__c ,Impacted_Quality_BGs__c ,Impacted_Mobile_Networks_BGs__c,Impacted_MCA_BGs__c ,Impacted_Legal_Compliance_BGs__c ,Impacted_IP_Optical_Networks_BGs__c ,Impacted_Human_Resources_BGs__c ,Impacted_Global_BGs__c ,Impacted_Fixed_Networks_BGs__c ,Impacted_Customer_Operations_BGs__c , Impacted_CSD_BGs__c , Impacted_CIOO_BGs__c , Impacted_Chief_Financial_Office_BGs__c , Impacted_Applications_Analytics_BGs__c, Reason_for_no_Financial_Impact__c, Institutionalize_Date__c , CIF_Phase__c, Deployment_Date__c, Improvement_Owner__c , Project_Sponsor__c, Lean_Project_Type__c,CEMT_ID__c,Portfolio_Owner_Id__c, Lean_Coach__c,TotalKPI__c,TotalCOPQ__c,Approver_Project_Owner__c,Approver_Financial_Approver__c,Belt_Project_Sponsor__r.name,Project_Completion_Date_Forecast__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Line__c,Project_Lead_Business_Unit__c,Project_Lead__r.name,CreatedById,CreatedDate,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,RecordType.Name,recordtypeid, Project_Name_Succinct__c,Project_Number__c, Project_Lead__c, Portfolio_Name__c,Portfolio_Name__r.name, Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c, Project_Description_Detailed__c,Project_State__c,Belt_Project_Sponsor__c,Finance_Approver__c,Business_Unit_Master_Black_Belt__c,Progress_To_Date__c,Next_Steps__c,Belt_Assigned__c,Quality_Award_Project__c,Project_Document__c,Project_Schedule_Status__c,MO_Site__c,DI_State__c,Planned_Start_Date__c,Project_Owner__c, Project_Completion_Date_Target__c,Project_Start_Date__c,Project_Completion_Date_Actual__c,Project_Created_Date__c,Lean_Project_Phase__c,Permission_to_use_Belt_Info__c,Project_Flex_Field_1__c,Project_Member1__c,Project_Member2__c,Countof_Benefits__c,Ben_Override_Resp_From_BUMBB__c,LastModifiedById,LastModifiedDate,Lean__c, In_Annual_Plan__c, Number_of_Kaizens__c, Schedule_Status__c, X5S__c, Root_Cause_Analysis_Fishbone_5_Whys__c, Autonomation__c, SMED__c, Ergonomics__c, Spaghetti_Diagrams__c, Inspections__c, standard_work__c, Kanban__c, Time_Study__c,Levelized_Production__c, Total_Productive_Maintenance_TPM__c,Poka_yoke__c,Visual_Management__c,Workload_Balancing__c,Yamazumi_Charts__c,One_Piece_Flow__c, Pull__c, Other__c,Benefit_Spread_Over_Year__c FROM QIPP_Project__c WHERE Id =: cloneid];
            System.Debug('recordtypeID c1 :'+recordtypeID+proj.RecordType.Name+'***proj.RecordTypeId'+proj.RecordTypeId);

            proj = cloneproj.clone(false,true,false,false);
            proj.RecordTypeId = recordtypeID;
            proj.Project_Completion_Date_Forecast__c = null;
            proj.Project_Completion_Date_Actual__c = null;
            proj.Project_Completion_Date_Target__c = null;
            proj.Project_Created_Date__c = system.today();
            proj.Project_Start_Date__c = null;
            proj.DI_State__c = 'Not Specified';
            proj.Project_State__c = 'In Progress';
            qtyAwardProj = proj.Quality_Award_Project__c;
            portfolioName = proj.Portfolio_Name__c;
            //--R17.3 E061--Start--//
            proj.Benefit_Spread_Over_Year__c = false;
            //--R17.3 E061--End--//
        }else{
        
        }
        
        if(proj.Id == null){
             proj.Project_State__c  = 'In Progress';
             proj.DI_State__c = 'Not Specified';
             proj.Project_Type__c = 'Other';
             qtyAwardProj ='No';             
             proj.RecordTypeId = recordtypeID;
             if(currPortfolioId != null){
                portfolioName = currPortfolioId;
                portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: currPortfolioId];
                proj.Portfolio_BU__c = portfolioRec.Portfolio_Business_Unit__c;
             }
             if(loggedInContact.size()>0){
                 proj.Project_Lead__c = loggedInContact[0].id;
             }
        }
        projectId = proj.Id;
        projState = proj.Project_State__c;
        benefitAmount = proj.Total_Project_Validation_Amount__c;
        
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

        getBenefits();

    }
    
    public Boolean recordIsLocked(ID projId){
        ID recId = projId;
        recIsLocked = Approval.isLocked(recId);
        System.Debug('recIsLocked : '+recIsLocked );
        return recIsLocked;
    }
    
    public PageReference getPortfolioBBGValue(){
        try{
            if(portfolioName != '1'){
                portfolioRec = [select id,name,Portfolio_Business_Unit__c from QIPP_Portfolio__c where id =: portfolioName];
                proj.Portfolio_BU__c = portfolioRec.Portfolio_Business_Unit__c;
                proj.Portfolio_Name__c = portfolioRec.Id;
            }else{
                proj.Portfolio_BU__c = '';
                proj.Portfolio_Name__c = null;
            }
            return null;
        }catch(Exception e){
            System.Debug('@@Error:'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,e.getMessage()));
            return null;
        }
    }
    
    //getPortfolioValues method to get all the protfolios available in the tool
    public List<SelectOption> getPortfolioValues(){
        return cmnFunct.getProjectPortfolioValues('Other');
    }
    
    public List<SelectOption> getqtyAwardProjectValues(){
       return cmnFunct.getFieldPickListToSelectOptionList('QIPP_Project__c','Quality_Award_Project__c',false);
    }    
    
    public pagereference saveProject(){
        try{
            //proj.Project_State__c = projState;
            if(!prjLeadSponsorEqual){
                 if((proj.Project_Lead__c != null && proj.Project_Sponsor__c!= null) && (proj.Project_Lead__c == proj.Project_Sponsor__c)){
                     projLeadSponsorEqual = true;
                     prjLeadSponsorEqual = true;
                     return null;
                }
            }
            else{
                projLeadSponsorEqual = false;
            }
            hasSaveValidationError = false;
            proj.Quality_Award_Project__c =qtyAwardProj;
            if(currentView.containsIgnoreCase('QIPPOtherProjectEditView') && (portfolioName != '1' || currPortfolioId != null)){
                try{ 
                    proj.Portfolio_Name__c = portfolioName;
                    System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);
                }catch(Exception e){
                    System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);
                    System.Debug('Portfolio_Name__c : '+proj.Portfolio_Name__c);
                }
            }
            system.debug('@@Before Save:'+proj);

            errorMessages();

            system.Debug('**issaveandnew**'+issaveandnew);
             system.Debug('**hasSaveValidationError**'+hasSaveValidationError);
            if((errMessageMap != null && errMessageMap.size() > 0) || hasSaveValidationError){
                return null;
            }
            
            system.Debug('**issaveandnew**'+issaveandnew);
            if(issaveandnew){//Save and New
                ApexPages.StandardController newController = new ApexPages.StandardController(proj);   
                Pagereference pagerefn = newController.save();
                system.Debug('**Save and New pagerefn**'+pagerefn); 
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
                if((ApexPages.getMessages().size() != 0)){
                  System.Debug('*********** ApexPages.getMessages().size() ************* '+ApexPages.getMessages().size());
                  return null;
                }
                issaveandnew = false;
                System.Debug('**Save and New condition**'); 
                //string calcelurl = '/apex/QIPPOtherProjectDetailView?id='+proj.Id;
                Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
                string calcelurl = '/' + R.getKeyPrefix()+'/o';
                string newprojectRedirectpage = '/apex/QIPPOtherProjectEditView?cancelURL='+calcelurl+'&RecordType=Methodology%3A+Other+Methodology&retURL=%2Fa18%2Fo';  
                //String newprojectRedirectpage = '/apex/QIPPOtherProjectEditView?cancelURL=https%3A%2F%2Fcs2.salesforce.com%2Fa18%2Fo&RecordType=Methodology%3A+Other+Methodology&retURL=%2Fa18%2Fo';
                Pagereference pageref = new PageReference(newprojectRedirectpage);
                pageref.setredirect(true);
                return pageref;                
            }else{
                ApexPages.StandardController newController = new ApexPages.StandardController(proj);   
                PageReference pageRef = newController.save();
                return PageRef;
            }
                        
            /*
            upsert proj;
            String strPageRef = '/apex/QIPPOtherProjectDetailView?id='+proj.Id;
            PageReference pageRef = new PageReference(strPageRef);
            pageRef.setredirect(true);
            system.debug('@@pageRef:'+pageRef);
            return pageRef;
            */
        }catch(Exception e){
            System.Debug('@@Error:'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,e.getMessage()));            
            return null;
        }
    }
    
    public pagereference cancel(){
        String cancelurl = ApexPages.currentPage().getParameters().get('cancelURL');
        String retURL = ApexPages.currentPage().getParameters().get('retURL');
        System.debug('@@cancelurl:'+cancelurl+' @@retURL:'+retURL);

        PageReference returnPage = null;
        if(cancelurl != null ){
            returnPage = new PageReference(cancelurl);
        }else if(retURL != null){
            returnPage = new PageReference(retURL);
        }else if(proj.Id != null ){
            returnPage = new PageReference('/apex/QIPPOtherProjectDetailView?id='+proj.Id);
            returnPage.setredirect(true);
        }else if(cloneID != null ){
            System.Debug('CloneID ==='+cloneID);
            returnPage = new PageReference('/apex/QIPPOtherProjectDetailView?id='+cloneID);
            returnPage.setredirect(true);
        }
        return returnPage;
    }
    public void closeLeadSponsorEqualPopup(){
        projLeadSponsorEqual = false;
        prjLeadSponsorEqual = false;
    }
    public pagereference ValidationCancel(){
       PageReference returnPage = new PageReference('/apex/QIPPOtherProjectDetailView?id='+proj.Id);
       returnPage.setredirect(true);
       return returnPage;
    }
    
    public PageReference unlockRecord(){
        try{
            Approval.UnlockResult uResult = Approval.unlock(proj.Id);
            PageReference pgRef = new PageReference('/apex/QIPPOtherProjectDetailView?id='+proj.Id);
            pgRef.setRedirect(true);
            return pgRef;
        }catch(Exception e){
            System.Debug('@@Error:'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,e.getMessage()));        
            return null;
        }
    }
    
    public pagereference edit(){
        if(recIsLocked){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Record Locked :'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'The record you are trying to edit has been locked. '));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please contact your administrator if access is necessary.'));
            return null;
        }else{
            PageReference pageref = Page.QIPPOtherProjectEditView;
            pageref.getParameters().put('id', proj.id);
            pageref.setredirect(true);
            return pageref;
        }
    }    
    
    public pagereference deleteRecord(){
        if(recIsLocked){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Record Locked :'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'The record you are trying to Delete has been locked. '));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Please contact your administrator if access is necessary.'));
            return null;
        }else{
            try{
                //delete proj;
                ApexPages.StandardController newController = new ApexPages.StandardController(proj);
                PageReference pageRef1 = newController.delete();
                if((ApexPages.getMessages().size() != 0)){
                    System.Debug('***********Delete ApexPages.getMessages().size() ************* '+ApexPages.getMessages().size());
                    return null;
                }
                return pageRef1;
                /*
                String strPageRef = '/a18/o';
                PageReference pageRef = new PageReference(strPageRef);
                pageRef.setredirect(true);
                system.debug('@@pageRef:'+pageRef);
                return pageRef;                
                */
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,e.getMessage()));        
                return null;
            }            
            return null;
        }
    }
    
    public pagereference cloneProject(){
        PageReference pageref = Page.QIPPOtherProjectEditView;
        pageref.getParameters().put('cloneID', proj.id);
        pageref.getParameters().put('RecordType', 'Methodology: Other Methodology');
        pageref.setredirect(true);
        return pageref;
    }
    
    public void errorMessages(){
        errMessageMap = new Map<String,String>();

        Set<String> fieldMandatorySet = new Set<String>();
        fieldMandatorySet.add('Project_Name_Succinct__c');
        fieldMandatorySet.add('Portfolio_BU__c');
        fieldMandatorySet.add('Project_Lead__c');
        fieldMandatorySet.add('Portfolio_Name__c');
        fieldMandatorySet.add('Project_BL__c');
        fieldMandatorySet.add('Benefitting_Project_BL_Level_4_Org__c');
        fieldMandatorySet.add('CEMT_ID__c');
        fieldMandatorySet.add('Project_Completion_Date_Target__c');
        fieldMandatorySet.add('Project_Completion_Date_Forecast__c');
        fieldMandatorySet.add('Project_Description_Detailed__c');
        fieldMandatorySet.add('Project_Sponsor__c');


        Set<String> excludeFieldMandatorySet = new Set<String>();
        excludeFieldMandatorySet.add('Portfolio_Name__c');
        
        errMessageMap.putall(cmnFunct.validateFieldMandatory(proj, fieldMandatorySet, excludeFieldMandatorySet));

        if((currentView.containsIgnoreCase('QIPPOtherProjectEditView')) && portfolioName == '1'){
            errMessageMap.put('Portfolio_Name__c','Portfolio Name: Please enter the value.');
        }else{
            errMessageMap.remove('Portfolio_Name__c');
        }
        if(errMessageMap != null && errMessageMap.size() > 0 && errMessageMap.containsKey('CEMT_ID__c')){
            errMessageMap.put('CEMT_ID__c','Measure-ID/CEMT-ID: Blank space not accepted, please use Not Applicable instead.');
        }

        //--Added by Rahul(E122)(14-11-2016)(25-11-2016)-- adding if condition --Start--//
        if(proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'In Progress')){
            if(proj.Project_Document__c != null){ 
                String pdoc = proj.Project_Document__c;
                String regexFormatForProjectDocument = '(^((http|https|ftp)://)(www[.])?([a-zA-Z0-9]|-)+?([.][a-zA-Z0-9+&@#/%=~_|$(-|/|=|?)??]+?)+?$)';
                Pattern urlFormat = Pattern.Compile(regexFormatForProjectDocument);
                Matcher format_of_url = urlFormat.matcher(proj.Project_Document__c);
                if (!(format_of_url.Matches()) || (pdoc.length() < 10)){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Project Document: Enter a valid url where project doc is stored.'));
                    errMessageMap.put('Project_Document__c','Project Document: Enter a valid url where project doc is stored.');
                }
            }
        }
        //--Added by Rahul(E122)(14-11-2016)-- adding if condition --End--//    
        
        if(errMessageMap != null && errMessageMap.size() > 0){
            hasSaveValidationError = true;
            for(String errMsg : errMessageMap.values()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,errMsg));
            }
        }

        /*
        if((currentView.containsIgnoreCase('QIPPCIFProjectEditView')) && (portfolioName != '1' || currPortfolioId != null)){
            try{
                proj.Portfolio_Name__c = portfolioName;
                System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);
            }catch(Exception e){
                System.Debug('proj.Portfolio_Name__c : '+proj.Portfolio_Name__c);
                System.Debug('Portfolio_Name__c : '+proj.Portfolio_Name__c);
            }
        }
        */
        
        //--Added by Rahul(E122)(14-11-2016)(25-11-2016)-- adding if condition --Start--//
        if(proj.Project_State__c != null && proj.Project_State__c != '' && (proj.Project_State__c == 'In Progress')){
            if((currentView.containsIgnoreCase('QIPPOtherProjectEditView')) && (proj.Project_Completion_Date_Forecast__c < system.Today()) && (proj.Project_State__c == 'In Progress')){
                hasSaveValidationError = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Completion Date - Forecast should be equal or greater than Current Date'));
            }
            
            if((currentView.containsIgnoreCase('QIPPOtherProjectDetailView')) &&(proj.Project_Completion_Date_Forecast__c < system.Today()) && ((proj.Project_State__c == 'In Progress'))){
                hasSaveValidationError = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Completion Date - Forecast should be equal or greater than Current Date'));
            }
    
            //validate project finance approver at project creation
            if(proj.Id == null && proj.Finance_Approver__c != null && !cmnFunct.validContactBG(proj.Finance_Approver__c,'Finance Approver')){
                hasSaveValidationError = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Provided \'Finance Approver\' Contact does not exist or does not match filter criteria.'));
            }
            
            if(proj.Id == null && proj.Belt_Assigned__c != null && !cmnFunct.validContactBG(proj.Belt_Assigned__c,'L6S Belt Assigned')){
                hasSaveValidationError = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Provided \'L6S Belt Assigned\' Contact does not exist or does not match filter criteria.'));
            }
        }
        //--Added by Rahul(E122)(14-11-2016)-- adding if condition --End--//                
    }
    
    /* approval phase section - start - */
    public pagereference reqApproval(){
        try{
            reqApprovalMessage = '';
            boolean hasValidationError = false;

            if(recIsLocked){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info, 'Project is already under Approval Process'));
                return null;
            }

            if((proj.Total_Project_Validation_Amount__c <= 15.00))    {

                if(proj.Project_State__c != 'Complete' && proj.Project_State__c != 'Canceled' && proj.Project_State__c != 'Closed' && proj.Project_State__c != 'On Hold'){
                    if(proj.Project_Document__c==null || proj.Project_Document__c==''){ 
                        reqApprovalMessage += '• Project Document field requires an entry. Please add the location (URL) where the document is stored.<br>'; 
                    } 
                    if(!QIPP_ApprovalsProcessNonSixSigma.BusinessActivities(proj.Id)){ 
                        reqApprovalMessage += '• Please ensure that at least one Business Activity was mapped to the Project.<br>';
                    } 
                    if(QIPP_ApprovalsProcessNonSixSigma.ImpMeasurescheck(proj.Id)){ 
                        reqApprovalMessage += '• A project cannot be request for Completion approval with a Benefit that is using the “Generic KPI (Internal Use Only)” Improvement Measure. Please update this project’s benefit(s) to be using a defined KPI or PI.<br><br>'; 
                    } 
                    if(reqApprovalMessage != null && reqApprovalMessage != ''){ 
                        reqApprovalMessage = 'The below items are required before submitting this project for Completion approval:<br>' + reqApprovalMessage; 
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,reqApprovalMessage));
                        return null;
                    }else{
                        if(proj.Total_Project_Validation_Amount__c == 0.00){ 
                            displayPopup = true;
                            isAlertType = false;
                            isSubmitProcess = false;
                            reqApprovalMessage = 'Please note that approval by the Project Sponsor must be documented for verification by the project closing authority. Include the approval document (email, memo, etc.) as part of the project documentation.<br><br>• ATTENTION: Are you certain want to record this project without indicating any Savings? Click the \'Cancel\' button to edit the project record again. Or, click \'Submit\' to submit this project for approval.';
                        }else{
                            //completeStatus();
                            String completestatus = QIPP_ApprovalsProcessNonSixSigma.CompleteL6Sproject(proj.Id);
                            System.debug('completestatus '+completestatus );
                            if(completestatus != '0'){ 
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,completestatus));
                                displayPopup = false; 
                                return null;
                            }
                            else{ 
                                displayPopup = false;
                                pageReference tempPage = new pageReference('/apex/QIPPOtherProjectDetailView?id='+proj.Id);
                                System.debug('tempPage'+tempPage);
                                tempPage.setRedirect(true);
                                return tempPage ;
                            } 
                        }
                    }
                }else if(proj.Project_State__c == 'Canceled' || proj.Project_State__c == 'Closed' || proj.Project_State__c == 'On Hold'){   
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Can\'t request this project for Completion approval, if the project is in \'Canceled\' or \'Closed\' or \'On Hold\' state.'));
                    return null;
                }else if(proj.Project_State__c == 'Complete'){ 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'"Benefit Savings" validation is already Completed.'));
                    return null;                        
                }
            }else if(proj.Total_Project_Validation_Amount__c > 15.00){
                //validate project finance approver
                if(proj.Finance_Approver__c != null && !cmnFunct.validContactBG(proj.Finance_Approver__c,'Finance Approver')){
                    reqApprovalMessage += '• Provided \'Finance Approver\' Contact is not actual Salesforce User or not a configured as F&C. Contact your Administrator to get QIPP Salesforce account.<br>';
                }
                if(proj.Finance_Approver__c == null){ 
                    reqApprovalMessage += '• \'Finance Approver\' is required.<br>';
                }
                /*if(proj.Approver_Financial_Approver__c == null){ 
                    reqApprovalMessage += '• \'Finance Approver\' is required.<br>';
                }*/ 
                if(proj.Project_Document__c ==''|| proj.Project_Document__c == null){ 
                    reqApprovalMessage += '• Project Document field requires an entry. Please add the location (URL) where the document is stored.<br>'; 
                } 
                if(!QIPP_ApprovalsProcessNonSixSigma.BusinessActivities(proj.Id)){ 
                    reqApprovalMessage += '• Please ensure that at least one Business Activity was mapped to the Project.<br>';
                } 
                if(QIPP_ApprovalsProcessNonSixSigma.ImpMeasurescheck(proj.Id)){ 
                    reqApprovalMessage += '• A project cannot be request for Completion approval with a Benefit that is using the “Generic KPI (Internal Use Only)” Improvement Measure. Please update this project’s benefit(s) to be using a defined KPI or PI.<br><br>';
                } 

                if(reqApprovalMessage != null && reqApprovalMessage != ''){ 
                    reqApprovalMessage = 'The below items are required before submitting this project for Completion approval:<br>' + reqApprovalMessage; 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,reqApprovalMessage));
                    return null;
                } else if(proj.Project_State__c != 'Complete' && proj.Project_State__c != 'Canceled' && proj.Project_State__c != 'Closed' && proj.Project_State__c != 'On Hold' && (proj.Total_Project_Validation_Amount__c > 15.00) ){ 
                    reqApprovalMessage = '';
                    if(proj.Total_Project_Validation_Amount__c > 15.00){ 
                        reqApprovalMessage += '• Please note that approval by the Project Sponsor must be documented for verification by the project closing authority. Include the approval document (email, memo, etc.) as part of the project documentation.<br><br>'; 
                    } 
                    if(proj.Total_Project_Validation_Amount__c > 250.00){ 
                        reqApprovalMessage ='• As the project saving is 250k€ or more, Produce a High Impacting approval as part of the Project document, Contact your Portfolio Owner for further details.<br><br>' + reqApprovalMessage; 
                    } 
                    if(reqApprovalMessage != null && reqApprovalMessage != ''){ 
                        displayPopup = true;
                        isAlertType = true;
                        return null;
                    }
                    displayPopup = true;
                    isAlertType = false;
                    isSubmitProcess = true;
                    reqApprovalMessage = 'Are you sure you want to submit this project for Completion Approval? Once the approval process is initiated, you will not be able to make any changes to this project records until its completed.';
                } else if(proj.Project_State__c == 'Canceled' || proj.Project_State__c == 'Closed' || proj.Project_State__c == 'On Hold'){ 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Can\'t request this project for Completion approval, if the project is in \'Canceled\' or \'Closed\' or \'On Hold\' state.'));
                    return null;
                } else if(proj.Project_State__c== 'Complete'){ 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'"Benefit Savings" validation is already Completed.'));
                    return null;
                }
            }
        }Catch(Exception e){
            System.Debug('@@Error:'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,e.getMessage()));        
            return null;
        }
        return null;
    }
    public pageReference submitApprove(){
        String alertmsg1 = '';
        String submitApproval = QIPP_ApprovalsProcessNonSixSigma.SubmitApproval(proj.id);
        if(submitApproval == '1'){ 
            displayPopup = false; 
            pageReference tempPage = new pageReference('/apex/QIPPOtherProjectDetailView?id='+proj.Id);
            tempPage.setRedirect(true);
            return tempPage ;
        }else {
            alertmsg1 = 'Please follow the guidance. <br> • '+submitApproval; 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,alertmsg1));
            return null;            
        }
    }
    
    public pageReference completeStatus(){
      String completestatus = QIPP_ApprovalsProcessNonSixSigma.CompleteL6Sproject(proj.Id);
      system.debug('Complete Statusssss:'+completeStatus);
      if(completestatus != '0'){ 
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,completestatus));
        displayPopup = false; 
        return null;
      }
      else{ 
        displayPopup = false;
            pageReference tempPage = new pageReference('/apex/QIPPOtherProjectDetailView?id='+proj.Id);
        tempPage.setRedirect(true);
        return tempPage ;
      } 
    }
    
    public void closePopup() {
        displayPopup = true;
        isAlertType = false;
        isSubmitProcess = true;
        reqApprovalMessage = 'Are you sure you want to submit this project for Completion Approval? Once the validation process is initiated, you will not be able to edit or add benefits.';
                
        //displayPopup = false; //To hide confirmation popup for submitting approval process  
    }
    
    public void closeConfirmPopup(){
        displayPopup = false;
    }
    /* approval phase section - end - */
        
    public PageReference callDummy(){
        return null;
    }
    
    public List<BAMWrapper> getBAMDetailsMap(){
        BAMWrapperList = new List<BAMWrapper>();
    
        activityList = [select id,Business_Activity_Mapping__c,Business_Activity_Mapping__r.name,Business_Activity_Mapping_ValueStream__c,Business_Activity_Mapping_BusinessFunc__c,
                        Business_Activity_Mapping2__c,Business_Activity_Mapping2__r.name,Business_Activity_Mapping2_ValueStream__c,Business_Activity_Mapping2_BusinessFunc__c,
                        Business_Activity_Mapping3__c,Business_Activity_Mapping3__r.name,Business_Activity_Mapping3_ValueStream__c,Business_Activity_Mapping3_BusinessFunc__c from QIPP_Project__c where id=:proj.Id];
        
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
    //BBGUpdated method is to update the associated BBG values and to delete the multiple BBG's added - Added by Haripriya Nov 21 2016
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
    //added by Haripriya - END
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
                                         where  Project_ID__c =:proj.Id];
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
}