/*
    Class/Triger Name : QIPP_BenefitOverrideController
    Test Class Name   : 
    Author            : Subhash(IGATE)
    Created Date      : 23.May.2014 
    Purpose/Overview  : 
                ********************************************************************************************************************         
                01) 
                02) 
                ********************************************************************************************************************  
    Change History    : 
                ********************************************************************************************************************         
                SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
                ********************************************************************************************************************  
                01  : 23.May.2014   :  Subhash(IGATE)        :   Class Created  :
                02  : 
                03  : 
    Notes :
                ********************************************************************************************************************         
                01) 
                02)
*/
public without sharing class QIPP_BenefitOverrideController
{
    public QIPP_Benefit__c benifit {get;set;}   
    String BenefitId = null;
    public QIPP_Benefit_Conversion_Table__c con {get;set;}
    public QIPP_Project__c projectinfo {get;set;}
    public QIPP_Contacts__c contact {get;set;}
    public List<RecordType> rt {get;set;}
    public List<QIPP_BU_Reporting__c> BenRepList {get;set;}
    public List<QIPP_CoPQ_Project_Team__c> projTeam {get;set;}
    
    //Subhash: variables related to override
    public Boolean showoverridebenefitbutton {get;set;}
    public Boolean showapproverejectbutton {get;set;}
    public Boolean showbenefitoverridestatus {get;set;}
    public Boolean showresetbutton {get;set;}
    public Boolean triggerworkflow {get;set;} 
    public boolean displayPopup {get; set;}
    public String userName {get;set;}
    public boolean isContainRejectText {get; set;}
    public boolean isContainApproveText {get; set;}
    public boolean isContainResetText {get; set;}
    public String TypeOfPlannedSaving {get;set;}
    public String TypeOfAchievedSaving {get;set;}
    public String TypeOfFutureSaving {get;set;}     
    public String Benefit_Type {get;set;}
     
    public QIPP_BenefitOverrideController() 
    {
    }
    public QIPP_BenefitOverrideController(ApexPages.StandardController controller) 
    {
      String  CurrentPage = ApexPages.currentPage().getUrl() ;
      
       if(CurrentPage != null && CurrentPage.contains('detailpage'))
       {
           BenefitId  = CurrentPage.substringAfterLast('=');
       }
       try{ 
        benifit = [select ID, 
                          Improvement_Measure_KPI__c ,
                          Business_Line__c,
                          Unit_of_Measure__c,
                          Benefit_Type__c,
                          Directional_Indicator__c,
                          Financial_Type__c,
                          Project_Charter_Goal_Statement__c,
                          Basis__c ,

                          Baseline_Quantity__c,
                          Type_of_Measure__c, 
                          Baseline_Period_weeks__c,
                          Baseline_Rate_N__c ,
                                    
                          Planned_Quanity__c,
                          Planned_Start_Date__c,
                          Planned_End_Date__c,
                          Planned_Benefit_Period_Weeks__c,
                          Planned_Rate__c,
                          Planned_Financial_Manual_Amount__c,
                          Planned_Financial_Automatic_Amount__c,
                          Planned_Operational_Manual_Amount__c,
                          Planned_Operational_Automatic_Amount__c,
                                     
                          Achieved_Quantity__c,
                          Achieved_Start_Date__c,
                          Achieved_End_Date__c,
                          Achieved_Benefit_Period_Weeks__c,
                          Achieved_Rate__c,
                          Achieved_Financial_Automatic_Amount__c,
                          Achieved_Financial_Manual_Amount__c,
                          Achieved_Operational_Automatic_Amount__c,
                          Achieved_Operational_Manual_Amount__c,
                                     
                          Future_Quantity__c,
                          Future_Start_Date__c,
                          Future_End_Date__c,
                          Future_Benefit_Period_Weeks__c,
                          Future_Rate__c,
                          Future_Financial_Automatic_Amount__c,
                          Future_Financial_Manual_Amount__c,
                          Future_Operational_Automatic_Amount__c ,
                          Future_Operational_Manual_Amount__c,
                                      
                          Achieved_Conversion_Rate__c,
                          Future_Conversion_Rate__c,
                          Planned_Conversion_Rate__c, 
                                      
                          Selected_Business_Line__c ,
                          Project_ID__c,
                          Portfolio_Name__c,
                          Project_Lead__c,
                          Project_Name_Display__c,
                          Project_Number__c,
                          Improvement_Measure_Name__c,
                          LastModifiedDate,
                          CreatedDate,
                          LastModifiedBy.Name, 
                          CreatedBy.Name,
                                     
                          Email_BC_Mentor__c,
                          Email_BU_MBB__c,
                          Email_FinanceApprover__c,
                          Email_GlobalMBB__c,
                          Email_Project_Lead__c,
                          Email_Sponsor__c,
                          Benefit_Override_Status__c,Invoke_Benefit_Override__c,
                          Invoke_Benefit_Override_Approve__c, 
                          Invoke_Benefit_Override_Reject__c, 
                          Invoke_Benefit_Override_Reset__c,
                          
                          Planned_Financial_Savings_Total__c,
                          Planned_Operational_Savings_Total__c,
                          Achieved_Financial_Savings_Total__c,
                          Achieved_Operational_Savings_Total__c,
                          Future_Financial_Savings_Total__c,
                          Future_Operational_Savings_Total__c,
                          Benefit_Amount_Achieved_Future_k__c,
                          Benefit_Operational_Achieved_Future_k__c 

                          from QIPP_Benefit__c where ID =: BenefitId];
                                      
        projectinfo = [select CoPQ_Benefits_Validation_State__c,
                              KPI_Benefits_Validation_State__c,
                              Name,
                              Project_Number__c,
                              Project_Name_Succinct__c,
                              Project_Lead__r.Full_Name__c,
                              Project_Lead__r.Name,
                              Portfolio_Name__r.Portfolio_Name_Unique__c,
                              Finance_Approver__c,
                              Finance_Approver_Email__c,
                              Business_Unit_Master_Black_Belt__c,
                              Business_Unit_Master_Black_Belt_Email__c, 
                              Belt_Candidate_Mentor__c,
                              Belt_Candidate_Mentor_Email__c,
                              Project_Lead__c,
                              Project_Lead_Email__c,
                              Belt_Project_Sponsor__c,
                              Belt_Project_Sponsor_Email__c,
                              CABVM__c,
                              recordTypeId,
                              KABVM__c,
                              Belt_Project_Phase__c,
                              FieldForControlVerifyPhase__c,
                              DI_Finance_Approver__c,
                              Check_DI_Approval_State__c,
                              Check_Lean_Approval_State__c 
                              from QIPP_Project__c where Id =: benifit.Project_ID__c];
                              
                              rt = [SELECT Id,Name FROM RecordType WHERE id =:projectinfo.recordTypeId];
        
        projTeam = [SELECT Id,Name,Finance_Approver__c,Finance_Approver_Email__c FROM QIPP_CoPQ_Project_Team__c WHERE ProjectID__c =:projectinfo.id];                              
        
        String DIFinanceApproverEmail;
        DIFinanceApproverEmail = '';
        
        for(QIPP_CoPQ_Project_Team__c pt:projTeam){
        if(pt.Finance_Approver__c !=null)
        DIFinanceApproverEmail = pt.Finance_Approver_Email__c;
        }
                              
        con = [select Name,
                      Id,
                      Benefit_Type__c,
                      Monetization_Calculation_Method__c,
                      Benefit_Type_Override__c,
                      CoPQ_Type__c,
                      Financial_Type_Override__c,
                      Impacted_P_L_Line__c,
                      Impacted_P_L_Line_Override__c 
                      from QIPP_Benefit_Conversion_Table__c where Id =: benifit.Improvement_Measure_KPI__c limit 1];
                      
        BenRepList = [select ID ,                                 
                             Project_ID__c,
                             Benefit_ID__c,
                             Benefit_Condition__c,
                             Quarters__c,
                             Years__c,
                             Months__c,
                             Benefit_Savings_Amount__c,
                             Entry_Type__c
                             from QIPP_BU_Reporting__c  where Project_ID__c =:projectinfo.id and Benefit_ID__c =:benifit.id and Entry_Type__c !='System Entry'];                      

        //Subhash: retrieve the current user
        User usr = new User();
        usr = [SELECT name,id,email FROM User WHERE Id = : UserInfo.getUserId() limit 1];
        system.debug('user email::::::::'+usr.email);
        system.debug('user ID::::::::'+usr.ID);
        userName = usr.name;
        
        contact = [SELECT id,Email__c,User_License__c from QIPP_Contacts__c where Email__c=:usr.email limit 1];
        system.debug('Contact::::::::'+contact);        
        
        if(benifit.Benefit_Override_Status__c != null){
        isContainRejectText = benifit.Benefit_Override_Status__c.contains('Benefit Type override has been rejected by');
        isContainApproveText  = benifit.Benefit_Override_Status__c.contains('Benefit Type override has been approved by');
        isContainResetText = benifit.Benefit_Override_Status__c.contains('Benefit Type override has been reset by');
        }
        
        system.debug('isContainRejectText::'+isContainRejectText);
        system.debug('isContainApproveText::'+isContainApproveText);
        system.debug('con.Benefit_Type_Override__c:::'+con.Benefit_Type_Override__c);
        system.debug('projectinfo.Check_DI_Approval_State__c:::'+projectinfo.Check_DI_Approval_State__c);
        
        /*Subhash: If Benefit type is 'Operational Savings', display the Benefit Override button. AND
        If there is NO override defined in the Conversion Table – users should NOT be able to initiate the “Benefit Override”. AND  
        If Financial or Operational Savings validations in progress or approved - users should NOT be able to initiate the “Benefit Override”. 
        */
        if(benifit != null && benifit.Benefit_Type__c == 'Operational Savings' && (benifit.Benefit_Override_Status__c =='' || benifit.Benefit_Override_Status__c == null || isContainRejectText == true)
        &&(projectinfo.Belt_Candidate_Mentor_Email__c ==contact.email__c || projectinfo.Project_Lead_Email__c == contact.email__c)&&(con.Benefit_Type_Override__c !=null)
        &&(projectinfo.CABVM__c == 'Pending Achieved or Future Value' || projectinfo.CABVM__c == 'Requires Validation' || projectinfo.CABVM__c == null)
        &&(projectinfo.KABVM__c == 'Pending Achieved or Future Value' || projectinfo.KABVM__c == 'Requires Validation' || projectinfo.KABVM__c == 'No Validation Requirement'|| projectinfo.KABVM__c == null)
        &&(projectinfo.Check_DI_Approval_State__c == '' || projectinfo.Check_DI_Approval_State__c == null)
        &&(projectinfo.FieldForControlVerifyPhase__c !='RecordLock')
        &&(projectinfo.Check_Lean_Approval_State__c != 'During Lean' && projectinfo.Check_Lean_Approval_State__c != 'Lean Complete')){                            
        
        showoverridebenefitbutton= true;
        
        if(isContainRejectText == true) showbenefitoverridestatus = true;
        
        }
        else if(benifit.Benefit_Override_Status__c != null && benifit.Benefit_Override_Status__c =='Awaiting Approval')
        {
        showbenefitoverridestatus = true;        
        if(DIFinanceApproverEmail == contact.email__c || projectinfo.Finance_Approver_Email__c == contact.email__c || projectinfo.Business_Unit_Master_Black_Belt_Email__c == contact.email__c) showapproverejectbutton = true;
        }
        else if(isContainApproveText == true )
        {
        showbenefitoverridestatus = true;
        if((DIFinanceApproverEmail == contact.email__c || projectinfo.Finance_Approver_Email__c == contact.email__c || projectinfo.Business_Unit_Master_Black_Belt_Email__c == contact.email__c) 
        && (projectinfo.FieldForControlVerifyPhase__c !='RecordLock' && projectinfo.Check_Lean_Approval_State__c != 'During Lean' && projectinfo.Check_Lean_Approval_State__c != 'Lean Complete')) 
        showresetbutton = true;
        }
        else if(isContainResetText == true || isContainRejectText == true)
        {
        showbenefitoverridestatus = true;        
        if(projectinfo.Belt_Candidate_Mentor_Email__c ==contact.email__c || projectinfo.Project_Lead_Email__c == contact.email__c){
        showresetbutton = false;
        showoverridebenefitbutton= true;
        }
        }
        else{
        showoverridebenefitbutton= false;
        showapproverejectbutton = false;
        showresetbutton = false;
        showbenefitoverridestatus = false;
        }
        benifit.Invoke_Benefit_Override__c = 'No';
        benifit.Invoke_Benefit_Override_Approve__c = 'No';
        benifit.Invoke_Benefit_Override_Reject__c = 'No';
        benifit.Invoke_Benefit_Override_Reset__c = 'No';
      }
      catch(Exception exe)
      {
          System.Debug('::::Exception in Detail:::::' + exe.getMessage() );             
          System.Debug('::::Line Number in Detail:::::' + exe.getLineNumber());             
      }     
    }
    
    
    //Subhash: Override Benefit Type
    public PageReference overrideBenefitType()
    {
    
    if((rt[0].name.contains('DMAIC'))||(projectinfo.Finance_Approver__c != null 
        && (rt[0].name == 'Methodology: A3' || rt[0].name == 'Methodology: 8D' || rt[0].name == 'Methodology: CDT' 
        || rt[0].name == 'Methodology: Other Methodology' || rt[0].name == 'Methodology: RCA/EDA' || rt[0].name == 'Methodology: DI Logic' || rt[0].name == 'Methodology: Lean (including Kaizen)'))){
        system.debug('Block:::1');     
        showapproverejectbutton = true; 
        if(BenefitId != null)
        {
            PageReference pg = null;
            benifit.Benefit_Override_Status__c = 'Awaiting Approval';
            benifit.Invoke_Benefit_Override__c = 'Yes';
            if(projectinfo.Business_Unit_Master_Black_Belt_Email__c != null) benifit.Email_BU_MBB__c = projectinfo.Business_Unit_Master_Black_Belt_Email__c;
            if(projectinfo.Belt_Candidate_Mentor_Email__c != null) benifit.Email_BC_Mentor__c = projectinfo.Belt_Candidate_Mentor_Email__c;
            if(projectinfo.Project_Lead_Email__c != null) benifit.Email_Project_Lead__c = projectinfo.Project_Lead_Email__c;
            if(projectinfo.Finance_Approver_Email__c != null) benifit.Email_FinanceApprover__c = projectinfo.Finance_Approver_Email__c;                        
            system.debug('FA:::'+projectinfo.Finance_Approver_Email__c+'GMBB::'+projectinfo.Business_Unit_Master_Black_Belt_Email__c);
                system.debug('benifit.Benefit_Override_Status__c:::::'+benifit.Benefit_Override_Status__c);            
            upsert benifit;
                system.debug('benifit.Benefit_Override_Status__c:::::'+benifit.Benefit_Override_Status__c);            
            pg = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+benifit.Id); 
            pg.setRedirect(true);
            return pg;  
        }
        else
        {
             return null;  
        }
        }
        else if((projectinfo.Finance_Approver__c == null || projectinfo.Finance_Approver__c == '') 
        && (rt[0].name == 'Methodology: A3' || rt[0].name == 'Methodology: 8D' || rt[0].name == 'Methodology: CDT' 
        || rt[0].name == 'Methodology: Other Methodology' || rt[0].name == 'Methodology: RCA/EDA'||rt[0].name == 'Methodology: DI Logic' || rt[0].name == 'Methodology: Lean (including Kaizen)')){
        system.debug('Block:::2');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning, 'Benefit Override cannot be initiated as "Finance Approver" is NOT assigned for this project.  Please assign the Finance Approver before initiating the Benefit Override.'));
        return null;
        }
        else{
        system.debug('Block:::3');
        return null;
        }
    } 
    
    //Subahsh: output pannel rendering
    public void closePopup() {        
        displayPopup = false;    
    }
    
    //Subhash: actions to be done if Benfit override approved     
    public pageReference approve() 
    {   
        system.debug('************* inside approve*************** ::');
        displayPopup = false;
        PageReference pg = null;         
        benifit.Benefit_Type__c = con.Benefit_Type_Override__c;
        benifit.Financial_Type__c = con.Financial_Type_Override__c;
        benifit.Impacted_P_L_Line__c = con.Impacted_P_L_Line_Override__c;        
        benifit.Benefit_Override_Status__c = 'Benefit Type override has been approved by '+userName;
        benifit.Invoke_Benefit_Override_Approve__c = 'Yes';
        
        if(projectinfo.Belt_Candidate_Mentor_Email__c != null) benifit.Email_BC_Mentor__c = projectinfo.Belt_Candidate_Mentor_Email__c;
        if(projectinfo.Project_Lead_Email__c != null) benifit.Email_Project_Lead__c = projectinfo.Project_Lead_Email__c;
        if(projectinfo.Finance_Approver_Email__c != null) benifit.Email_FinanceApprover__c = projectinfo.Finance_Approver_Email__c;
        if(projectinfo.Belt_Project_Sponsor_Email__c != null) benifit.Email_Sponsor__c = projectinfo.Belt_Project_Sponsor_Email__c;
        
        system.debug('Planned_Financial_Savings_Total__c:::::'+benifit.Planned_Financial_Savings_Total__c);
        system.debug('Planned_Operational_Savings_Total__c:::::'+benifit.Planned_Operational_Savings_Total__c);        
        system.debug('Achieved_Financial_Savings_Total__c:::::'+benifit.Achieved_Financial_Savings_Total__c);                  
        system.debug('Achieved_Operational_Savings_Total__c:::::'+benifit.Achieved_Operational_Savings_Total__c);                  
        system.debug('Future_Financial_Savings_Total__c:::::'+benifit.Future_Financial_Savings_Total__c);                  
        system.debug('Future_Operational_Savings_Total__c:::::'+benifit.Future_Operational_Savings_Total__c);                                            
                           
        
        if(benifit.Planned_Operational_Manual_Amount__c != null)
        { 
            benifit.Planned_Financial_Manual_Amount__c = benifit.Planned_Operational_Manual_Amount__c;
            benifit.Planned_Operational_Manual_Amount__c = null;
        }    
        if(benifit.Planned_Operational_Automatic_Amount__c != null) 
        {
            benifit.Planned_Financial_Automatic_Amount__c = benifit.Planned_Operational_Automatic_Amount__c;
            benifit.Planned_Operational_Automatic_Amount__c = null;
        }    
        
        if(benifit.Achieved_Operational_Manual_Amount__c != null) 
        {
            benifit.Achieved_Financial_Manual_Amount__c = benifit.Achieved_Operational_Manual_Amount__c;
            benifit.Achieved_Operational_Manual_Amount__c = null;
        }    
            
        if(benifit.Achieved_Operational_Automatic_Amount__c != null) 
        {
            benifit.Achieved_Financial_Automatic_Amount__c = benifit.Achieved_Operational_Automatic_Amount__c;
            benifit.Achieved_Operational_Automatic_Amount__c = null;
        }    
        
        if(benifit.Future_Operational_Manual_Amount__c != null) 
        {
            benifit.Future_Financial_Manual_Amount__c = benifit.Future_Operational_Manual_Amount__c;
            benifit.Future_Operational_Manual_Amount__c = null;
        }    
        
        if(benifit.Future_Operational_Automatic_Amount__c != null) 
        {
            benifit.Future_Financial_Automatic_Amount__c = benifit.Future_Operational_Automatic_Amount__c;                                        
            benifit.Future_Operational_Automatic_Amount__c = null;
        }            
        
        if(benifit.Planned_Operational_Savings_Total__c != null)
        {
            benifit.Planned_Financial_Savings_Total__c = benifit.Planned_Operational_Savings_Total__c;
            benifit.Planned_Operational_Savings_Total__c = null;        
        }     
         
        if(benifit.Achieved_Operational_Savings_Total__c != null)
        {
            benifit.Achieved_Financial_Savings_Total__c = benifit.Achieved_Operational_Savings_Total__c;
            benifit.Achieved_Operational_Savings_Total__c = null;        
        }  
        
        if(benifit.Future_Operational_Savings_Total__c != null)
        {
            benifit.Future_Financial_Savings_Total__c = benifit.Future_Operational_Savings_Total__c;
            benifit.Future_Operational_Savings_Total__c = null;        
        }     
        
        if(benifit.Benefit_Operational_Achieved_Future_k__c != null)
        {
            benifit.Benefit_Amount_Achieved_Future_k__c = benifit.Benefit_Operational_Achieved_Future_k__c;
            benifit.Benefit_Operational_Achieved_Future_k__c = null;        
        }         
                      
        upsert benifit;
        
        for(QIPP_BU_Reporting__c benlineitem:BenRepList){
           benlineitem.Benefit_Type__c = con.Benefit_Type_Override__c;        
        }
        upsert BenRepList;
        
        pg = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpageFromOverride='+benifit.Id); 
        pg.setRedirect(true);
        
        return pg;
       
    }
    
    //Subhash: actions to be done if Benfit override rejected    
    public pageReference reject() 
    {        
        displayPopup = false;
        PageReference pg = null;       
        benifit.Benefit_Override_Status__c = 'Benefit Type override has been rejected by '+userName;
        benifit.Invoke_Benefit_Override_Reject__c = 'Yes';
        benifit.Invoke_Benefit_Override_Approve__c = 'No';
        if(projectinfo.Belt_Candidate_Mentor_Email__c != null) benifit.Email_BC_Mentor__c = projectinfo.Belt_Candidate_Mentor_Email__c;
        if(projectinfo.Project_Lead_Email__c != null) benifit.Email_Project_Lead__c = projectinfo.Project_Lead_Email__c;
        if(projectinfo.Finance_Approver_Email__c != null) benifit.Email_FinanceApprover__c = projectinfo.Finance_Approver_Email__c;
        if(projectinfo.Belt_Project_Sponsor_Email__c != null) benifit.Email_Sponsor__c = projectinfo.Belt_Project_Sponsor_Email__c;

        upsert benifit;
        pg = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+benifit.Id); 
        pg.setRedirect(true);
        return pg;            
    }
     
    public void showApproveRejectPopup() {        
        displayPopup = true;   
    }
    
    //Subhash: actions to be done if Benfit override resetted     
    public pageReference resetBenefitType()
     {
       PageReference pg = null;  
       benifit.Benefit_Type__c = con.Benefit_Type__c; 
       benifit.Financial_Type__c = con.CoPQ_Type__c;
       benifit.Impacted_P_L_Line__c = con.Impacted_P_L_Line__c;
       benifit.Benefit_Override_Status__c = 'Benefit Type override has been reset by '+userName;
       benifit.Invoke_Benefit_Override_Reset__c = 'Yes';
       benifit.Invoke_Benefit_Override_Approve__c = 'No';
       if(projectinfo.Belt_Candidate_Mentor_Email__c != null) benifit.Email_BC_Mentor__c = projectinfo.Belt_Candidate_Mentor_Email__c;
       if(projectinfo.Project_Lead_Email__c != null) benifit.Email_Project_Lead__c = projectinfo.Project_Lead_Email__c;
       if(projectinfo.Finance_Approver_Email__c != null) benifit.Email_FinanceApprover__c = projectinfo.Finance_Approver_Email__c;
       if(projectinfo.Belt_Project_Sponsor_Email__c != null) benifit.Email_Sponsor__c = projectinfo.Belt_Project_Sponsor_Email__c;
       
       if(benifit.Planned_Financial_Manual_Amount__c != null)
       {
           benifit.Planned_Operational_Manual_Amount__c = benifit.Planned_Financial_Manual_Amount__c;
           benifit.Planned_Financial_Manual_Amount__c = null;        
       }            
       if(benifit.Planned_Financial_Automatic_Amount__c != null) 
       {       
           benifit.Planned_Operational_Automatic_Amount__c = benifit.Planned_Financial_Automatic_Amount__c;
           benifit.Planned_Financial_Automatic_Amount__c =null;           
       } 
       if(benifit.Achieved_Financial_Manual_Amount__c != null) 
       {
           benifit.Achieved_Operational_Manual_Amount__c = benifit.Achieved_Financial_Manual_Amount__c;
           benifit.Achieved_Financial_Manual_Amount__c = null;            
       }    
       if(benifit.Achieved_Financial_Automatic_Amount__c != null) 
       {
           benifit.Achieved_Operational_Automatic_Amount__c = benifit.Achieved_Financial_Automatic_Amount__c;
           benifit.Achieved_Financial_Automatic_Amount__c = null;
       }         
       if(benifit.Future_Financial_Manual_Amount__c != null) 
       {
           benifit.Future_Operational_Manual_Amount__c = benifit.Future_Financial_Manual_Amount__c;
           benifit.Future_Financial_Manual_Amount__c = null;
       }
       if(benifit.Future_Financial_Automatic_Amount__c != null) 
       {
           benifit.Future_Operational_Automatic_Amount__c = benifit.Future_Financial_Automatic_Amount__c;                                                
           benifit.Future_Financial_Automatic_Amount__c = null;
       }
       
       if(benifit.Planned_Financial_Savings_Total__c != null)
       {
           benifit.Planned_Operational_Savings_Total__c = benifit.Planned_Financial_Savings_Total__c;
           benifit.Planned_Financial_Savings_Total__c = null;        
       }     
         
       if(benifit.Achieved_Financial_Savings_Total__c != null)
       {
           benifit.Achieved_Operational_Savings_Total__c = benifit.Achieved_Financial_Savings_Total__c;
           benifit.Achieved_Financial_Savings_Total__c = null;        
       }  
        
       if(benifit.Future_Financial_Savings_Total__c != null)
       {
           benifit.Future_Operational_Savings_Total__c = benifit.Future_Financial_Savings_Total__c;
           benifit.Future_Financial_Savings_Total__c = null;        
       } 
       
       if(benifit.Benefit_Amount_Achieved_Future_k__c != null)
       {
           benifit.Benefit_Operational_Achieved_Future_k__c = benifit.Benefit_Amount_Achieved_Future_k__c;
           benifit.Benefit_Amount_Achieved_Future_k__c = null;        
       }             

       upsert benifit;
       
       for(QIPP_BU_Reporting__c resetbenlineitem:BenRepList){
           resetbenlineitem.Benefit_Type__c = con.Benefit_Type__c;        
       }
       upsert BenRepList;
       
       
       pg = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+benifit.Id); 
       pg.setRedirect(true);
       return pg;    
    }
}