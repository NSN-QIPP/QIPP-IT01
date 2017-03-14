/*
    Class/Triger Name : QIPP_BenefitDetailPage
    Test Class Name   : QIPP_BenefitDetailPage_test
    Author            : XXXX-XXXXXX
    Created Date      : 05.NOV.2014 
    Purpose/Overview  : 
                ********************************************************************************************************************         
                01) 
                02) 
                ********************************************************************************************************************  
    Change History    : 
                ********************************************************************************************************************         
                SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
                ********************************************************************************************************************  
                01  : 05.NOV.2014   :  XXXX-XXXXXX        :   Class Created  :
                02  : 
                03  : 
    Notes :
                ********************************************************************************************************************         
                01) 
                02)
*/
public class QIPP_BenefitDetailPage
{
    public QIPP_Benefit__c benifit {get;set;}   
    String BenefitId = null;
    public String BusinessLine {get;set;}
    public String ImprovmentMeasure {get;set;}    
    public Date PlannedBenefitStart {get;set;}
    public Date PlannedBenefitEnd {get;set;}
    public Date AchievedBenefitStart {get;set;}
    public Date AchievedBenefitEnd {get;set;}
    public Date RemainingBenefitStart {get;set;}
    public Date RemainingBenefitEnd {get;set;}
    public Boolean DisplayEditDeleteButton {get;set;}
    public Boolean DisplayDeleteButton {get;set;}
    public string UserRolename {get;set;}
       
    public Boolean isManual {get;set;}
    public String LastUpdatedTime {get;set;}
    public String CreatedTime {get;set;}
    public List<QIPP_Benefit_Conversion_Table__c> con {get;set;}
    public Boolean isNoteDisplay {get;set;}
    public String Benefit_Type {get;set;}
    public String TypeOfPlannedSaving {get;set;}
    public String TypeOfAchievedSaving {get;set;}
    public String TypeOfFutureSaving {get;set;}
    public Decimal PlannedSavingRate {get;set;}
    public Decimal AchievedSavingRate {get;set;}
    public Decimal FutureSavingRate {get;set;}    
    public Decimal PlannedSavingRate_RoundedUp {get;set;}
    public Decimal AchievedSavingRate_RoundedUp {get;set;}
    public Decimal FutureSavingRate_RoundedUp {get;set;}     
    public Decimal BaselineRate {get;set;}
    public Decimal PlannedSavingAmount {get;set;}
    public Decimal AchievedSavingAmount {get;set;}
    public Decimal FutureSavingAmount {get;set;}    
    public String SavingAmount {get;set;}
    Boolean flagForOverride = false;
    public Boolean plannedAvailable {get;set;}  
    public Boolean achievedAvailable{get;set;}   
    public Boolean futureAvailable {get;set;}
    public String BenefitPeriodWeekly {get;set;}
    public Boolean totalsaveings{get;set;}
    
    public List<QIPP_BU_Reporting__c> Bn_rep_AddList {get;set;}
    public Integer rowNum  {Set;get;}
    public Decimal PlannedAmount{get;set;}
    public Decimal AchievedAmount{get;set;}
    public Decimal FutureAmount{get;set;}   
    public list<string> BURids {get;set;}
    public List<String> listOfStrings {get; set;}
    public String textdata{get;set;}
    public Id projectMeasureId{get;set;}
    public List<QIPP_Benefit_Conversion_Rate__c> BusinessLineFromConversionRate {get;set;}
    public String strBusinessLineFromConversionRate {get;set;}
    public String ImprovementName{get;set;}
    public String IMPDescription {get;set;}
    
    public List<QIPP_Benefit__c> listOfBenefitsAssociaed_with_project;
    
    public boolean recIsLocked{get;set;}
    public String projState{get;set;}
    
    public QIPP_BenefitDetailPage() 
    {
    }

 

    public QIPP_BenefitDetailPage(ApexPages.StandardController controller) 
    {
    isNoteDisplay  = true;
    plannedAvailable = false;
    achievedAvailable = false;
    futureAvailable = false;
    totalsaveings = false;
    
    String  CurrentPage = ApexPages.currentPage().getUrl() ;
    DisplayEditDeleteButton  = true;
    DisplayDeleteButton = true;
    
     System.Debug('********* CurrentPage *********** ' + CurrentPage );
     
        
        listOfStrings = new List<String>();
        List<QIPP_Benefit_Conversion_Table__c> query =[SELECT id, Name From QIPP_Benefit_Conversion_Table__c LIMIT 10];
        for(QIPP_Benefit_Conversion_Table__c a: query)
        {
        listOfStrings.add(a.Name);
        }
        
     
       if(CurrentPage != null && CurrentPage.contains('detailpageFromOverride'))
       {
           BenefitId  = CurrentPage.substringAfterLast('=');
           flagForOverride = true;
       }
       else  if(CurrentPage != null && CurrentPage.contains('detailpage'))
       {
           BenefitId  = CurrentPage.substringAfterLast('=');
           flagForOverride = false;
       }
       
       System.Debug('********* BenefitId   *********** ' + BenefitId  );
       
       Id projectId = ApexPages.currentPage().getParameters().get('projId');
       //recordIsLocked(projectId);
       Set<ID> benid = new Set<Id>();
       System.Debug('projectId --- '+projectId);
       
        try
        {
            benifit = [select ID , 
                                     Improvement_Measure_KPI__c,
                                     Improvement_Measure_KPI__r.name,
                                     Improvement_Measure_KPI__r.Brief_Description__c,
                                     Business_Line__c,
                                     Unit_of_Measure__c,
                                     Benefit_Type__c,
                                     ImprovementMeasure_Brief_Description__c,
                                     Directional_Indicator__c,
                                     Financial_Type__c,
                                     Project_Charter_Goal_Statement__c,
                                     Basis__c ,

                                     Baseline_Quantity__c,
                                     Type_of_Measure__c, 
                                     Baseline_Period_weeks__c,
                                     Baseline_Rate_N__c ,
                                     
                                     Planned_Type_of_Measure__c,
                                     Revised_Forecast_Quanity__c,
                                     Revised_Forecast_Type_of_Measure__c,
                                     Revised_Forecast_Benefit_Period_Weeks__c,
                                     
                                     
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
                                     
                                     Invoke_Benefit_Override_Approve__c,
                                     
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
                                     Benefit_Override_Status__c ,
                                     
                                     Achieved_Benefit_Start__c,
                                     Achieved_Benefit_End__c,
                                     Planned_Benefit_End__c,
                                     Planned_Benefit_Start__c,
                                     Remaining_Benefit_End__c,
                                     Remaining_Benefit_Start__c

                                     from QIPP_Benefit__c where ID =: BenefitId  ];
                                     
          
           
        QIPP_Project__c projectinfo = [select TotalKPI__c,TotalCOPQ__c,Project_Lead_Email__c,CoPQ_Benefits_Validation_State__c ,Project_Type__c , DI_State__c, TriggerForDI3ApprovalProcess__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c  , Name , Project_Number__c ,Check_DI_Approval_State__c, Project_Name_Succinct__c , Belt_Project_Phase__c,FieldForControlVerifyPhase__c, Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c,RecordType.name,Check_Lean_Approval_State__c,Project_State__c,Check_Approval_Process_Status__c from QIPP_Project__c where Id =:  benifit.Project_ID__c] ;
        
        projState = projectinfo.Project_State__c; //added by Haripriya
        
        // validating for userroles
        Id userid = userinfo.getuserid();
        string rRolename =[select id,name,userrole.name from user where id = :userid].userrole.name; 
        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        
        if((projectinfo.TotalKPI__c + projectinfo.TotalCOPQ__c > 1000) && (projectinfo.Project_State__c == 'In Progress' || projectinfo.Project_State__c == 'Not Started'||projectinfo.Project_State__c == 'On Hold')) {
            totalsaveings = true;
        }
        
        if((projectinfo.Project_State__c == 'Complete' || projectinfo.Project_State__c == 'Closed') && (rRolename == 'QIPP Portfolio Manager' || rRolename == 'QIPP Admin' || profileName == 'System Administrator') && (projectinfo.Project_Type__c =='DMAIC' || projectinfo.Project_Type__c == 'Lean (including Kaizen)' || projectinfo.Project_Type__c =='CIF' || projectinfo.Project_Type__c =='A3' || projectinfo.Project_Type__c =='8D'|| projectinfo.Project_Type__c =='RCA/EDA' || projectinfo.Project_Type__c =='Other')){
                UserRolename = 'yes'; 
        }else UserRolename = 'no'; 
        
        System.debug('*************UserRolename***************** ' + UserRolename);

          
        Bn_rep_AddList = [select ID,                                 
                                    Project_ID__c,
                                    Benefit_ID__c,
                                    Benefit_Condition__c,
                                    Quarters__c,
                                    Years__c,
                                    Months__c,
                                    //Month_s__c,//new field
                                    Benefits_Saving_Amount_Planned__c,//new field
                                    Benefits_Saving_Amount_Achieved__c,//new field
                                    Benefit_Savings_Amount__c,
                                    History_Tracking_For_Line_Items__c,
                                    History_Tracking_For_Initial_Line_Items__c,
                                    Entry_Type__c
                                from QIPP_BU_Reporting__c  where Project_ID__c =:benifit.Project_ID__c and Benefit_ID__c =:benifit.id and Entry_Type__c != 'System Entry'];

      }
      catch(Exception exe)
      {
          System.Debug('********* Exception in Detail  *********** ' + exe.getMessage() );             
          System.Debug('********* Line Number in Detail *********** ' + exe.getLineNumber());             
      }  
    }
    
    public Boolean recordIsLocked(ID projId){
        ID recId = projId;
        recIsLocked = Approval.isLocked(recId);
        System.Debug('recIsLocked : '+recIsLocked );
        return recIsLocked;
    }

    public PageReference editbenefit()
    {
       PageReference obj = null;
  
       obj = new PageReference('/apex/QIPP_Benefit?id='+BenefitId+'&retURL=%2F'+benifit.Project_ID__c+'&sfdc.override=1');
     // obj= new PageReference('/apex/qippbenefiteditpage1?detailpage='+BenefitId);
    //  obj.setRedirect(true);
       return obj;
    }
    
    // added for new benefit Redesign editnewbenefit
     public PageReference editnewbenefit()
    {
       PageReference obj1 = null;
       obj1= new PageReference('/apex/qippbenefiteditpage1?detailpage='+BenefitId);
    //  obj.setRedirect(true);
       return obj1;
    }
    
    public PageReference viewBenefit()
    {
        PageReference obj =  new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c); 
        System.Debug('************ benifit.Project_ID__c 12 *********** ' + benifit.Project_ID__c);         
        return obj;
    }
    
    public PageReference projectDetailspage()
    {
        PageReference obj =  new PageReference('/'+benifit.Project_ID__c);  
        System.Debug('************ benifit.Project_ID__c 11 *********** ' + benifit.Project_ID__c);     
        return obj;
    }
    public PageReference deletebenifit()
    {
        delete benifit;
        PageReference obj = null;
        //if(isDirectedFromView  == true)
          obj  = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);        
        //else
         // obj = new PageReference('https://cs41.salesforce.com/'+benifit.Project_ID__c);
        return obj ;
    }
        public PageReference conversionTableLink()
    {
        if(con[0].Id != null)
        {
            PageReference obj =  new PageReference('/'+con[0].Id);  
            isNoteDisplay = true;
            return obj;        
        }
        else
        {
             isNoteDisplay = false;
             return null;  
        }     
    } 
    public PageReference viewSRQ()
    {
        System.Debug('*************BenifitReportPage ************** ' + benifit.id );  
        String str = benifit.id;
        String rpt = null;        
        
        if(benifit.Benefit_Type__c != null && benifit.Benefit_Type__c == 'Financial Savings')
            { 
                // QIPP-Summary Report (Financial Savings) - Quarterly
                rpt = '/00OU0000001x3hU?pv0='; 
            }
        if(benifit.Benefit_Type__c != null && benifit.Benefit_Type__c == 'Operational Savings')
            { 
                // QIPP-Summary Report (Operational Savings) - Quarterly
                rpt = '/00OU0000001x3hV?pv0='; 
            }
        
        PageReference obj = new PageReference(rpt+str); // Display Quarterly report dynamically
        
        System.Debug('************* obj************** ' +  obj);
        return obj;        
    }
    public PageReference viewSRM()
    {
        System.Debug('*************BenifitReportPage ************** ' + benifit.id );  
        String str = benifit.id;
        String rpt = null;
        
        if(benifit.Benefit_Type__c != null && benifit.Benefit_Type__c == 'Financial Savings')
            { 
                // QIPP-Summary Report (Financial Savings) - Monthly
                rpt = '/00OU0000001x87k?pv0='; 
            }
        if(benifit.Benefit_Type__c != null && benifit.Benefit_Type__c == 'Operational Savings')
            { 
                // QIPP-Summary Report (Operational Savings) - Monthly
                rpt = '/00OU0000001x87l?pv0='; 
            }
            
        PageReference obj = new PageReference(rpt+str); // Display Monthly report dynamically
        
        System.Debug('************* obj************** ' +  obj);
        return obj;        
    }
    
}