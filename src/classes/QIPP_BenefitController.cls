/*
    Class/Triger Name : QIPP_BenefitController
    Test Class Name   : 
    Author            : XXXX-XXXXXX
    Created Date      : 05.NOV.2014 
    Purpose/Overview  : 
                ********************************************************************************************************************         
                01) Create/updateing Benefit...
                02) 
                ********************************************************************************************************************  
    Change History    : 
                ********************************************************************************************************************         
                SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
                ********************************************************************************************************************  
                01  : 05.NOV.2014   :  XXXX-XXXXXX        :   Class Created  :
                02  : 08.JULY.2015  :  Srikanth V(IGATE)  :   Class Modified : Added Improvement Measure 'Brief Description' 
                03  : 
    Notes :
                ********************************************************************************************************************         
                01) 
                02)
*/
public class QIPP_BenefitController
{
    public QIPP_Benefit__c benifit {get;set;}
    public boolean ConversionIDFound {get;set;}
    //public decimal totalsavings{Set;get;}
    //public decimal totalamountvalidation{Set;get;}
    //public decimal currentbenifitamount{Set;get;}
    public boolean errorflag{set;get;}
    public boolean pageredirect{set;get;}
    
    public Boolean DI3DI5rule1{get;set;}
    public Boolean DI3DI5rule2{get;set;} 
    public Boolean callBusinesslinelist;
    public integer pcount1 = 0;
    public integer afcount1 = 0;
    public integer pcount2 = 0;
    public integer afcount2 = 0;
    
    public QIPP_Project__c projectinfo{get;set;}
    public boolean hideedit {get;set;}
    String projectid ;
    public String strBenifitType {get;set;}
    public List<QIPP_Benefit_Conversion_Table__c> con {get;set;}
    public List<QIPP_Benefit_Conversion_Table__c> businesslinelist {get;set;}
    public boolean isDirectedFromView = false;
    public String strDirectionalIndicator {get;set;}
    public String ReferURL = NULL;
    public String CurrentPage = null;
    public Boolean callQIMFunction {get;set;}
    public Boolean isManual {get;set;}
    public Boolean isOperational {get;set;}
    public Boolean isNoteDisplay {get;set;}
    public String ImprovementName{get;set;}
    public String strBusinessLineFromConversionRate {get;set;}
    public List<QIPP_Benefit_Conversion_Rate__c> BusinessLineFromConversionRate {get;set;} 
    public string selectedValue { get;set; }
    public List<SelectOption> statusOptions { get;set; }
    Boolean flag = false;
    public String Benefit_Type {get;set;}
    public String TypeOfPlannedSaving {get;set;}
    public String TypeOfAchievedSaving {get;set;}
    public String TypeOfFutureSaving {get;set;}
    public String ConversionId {get;set;}
    public String IMPDescription {get;set;}
    
    public List<QIPP_BU_Reporting__c> Bn_rep_AddList {get;set;}
    public List<QIPP_BU_Reporting__c> Bn_rep_DelList;
    public Integer rowNum  {Set;get;}
    
    public Decimal PlannedAmount;
    public Decimal AchievedAmount;
    public Decimal FutureAmount; 
    
    Map<String,String> hMapMonth; 
    
    public QIPP_BenefitController(ApexPages.StandardController controller) 
    {   
        //totalamountvalidation =0;
        //currentbenifitamount = 0;
        IMPDescription = '';
        try
        {
            benifit= new QIPP_Benefit__c();
            IMPDescription = '';
            /********************************* RETRIVING PROJECT ID START *********************************/            
            ReferURL =  ApexPages.currentPage().getHeaders().get('referer'); 
            CurrentPage = ApexPages.currentPage().getUrl() ;

            System.Debug('$$$$$$ ReferURL  : $$$$$$$ ' + ReferURL );
            System.Debug('$$$$$$ CurrentPage : $$$$$$$ ' + CurrentPage );
             
             ConversionIDFound = CurrentPage.contains('convId'); 
                
            if(CurrentPage!=null && CurrentPage.contains('convId'))
                {
                // RETRIVE BENEFIT ID AND PROJECT ID ....
                projectid = CurrentPage.substringAfterLast('%2F');
                projectid = projectid.substringBeforeLast('&');
                
                ConversionId = CurrentPage.substringAfterLast('convId=');
                ConversionId = ConversionId.substringBeforeLast('&retURL');
                System.Debug('$$$$$$ in convId : $$$$$$$ ' + projectid );
                System.Debug('$$$$$$ in convId  : $$$$$$$ ' + ConversionId );
                isDirectedFromView = true;
                }

            else if(CurrentPage!=null && CurrentPage.contains('override'))
            {
                projectid = CurrentPage.substringAfterLast('%2F');
                projectid = projectid.substringBeforeLast('&');
                projectid = projectid.substringBeforeLast('&');
                isDirectedFromView = true; 
                System.Debug('$$$$$$ in if  : $$$$$$$ ' + projectid );   
            }
           
            else if(ReferURL != null && ReferURL.contains('/'))
            {
                projectid = ReferURL.substringAfterLast('/');
                System.Debug('$$$$$$ Project Id : $$$$$$$ ' + projectid );
            }
            
            else if(projectid != null && ReferURL != null && projectid.contains('?') && projectid.contains('repeat'))
            {
                projectid = ReferURL.substringAfterLast('=');
                isDirectedFromView = true;
                System.Debug('$$$$$$ in case if : $$$$$$$ ' + projectid );
            }
            else if(projectid.contains('?') && ReferURL != null && !projectid.contains('repeat') && !projectid.contains('fm'))
            {
                projectid = ReferURL.substringAfterLast('?');
                isDirectedFromView = true;
                System.Debug('$$$$$$ in case else if 1 : $$$$$$$ ' + projectid );
            }
            else if(projectid.contains('?') && ReferURL != null && projectid.contains('fm'))
            {
                projectid = ReferURL.substringAfterLast('=');
                isDirectedFromView = true;   
                System.Debug('$$$$$$ in case else if 2 : $$$$$$$ ' + projectid );            
            }
            
            
           
            
            System.Debug('************* projectid  QIPP_BenefitController **************** ' + projectid );
            if(projectid != null)    
            {
                projectinfo = [select Name ,Project_Lead_Email__c,Project_State__c ,TotalKPI__c,TotalCOPQ__c, Project_Number__c , Project_Name_Succinct__c ,  Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c , 
                                CoPQ_Benefits_Validation_State__c,TriggerForDI3ApprovalProcess__c ,DI_State__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c,Recordtype.name,DI3_Action_Status__c,Check_DI_Approval_State__c,Project_BL__c,Benefitting_Project_BL_Level_4_Org__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c,Project_Lead_BU__c,Project_Type__c,Belt_Project_Type__c from QIPP_Project__c where id =: projectid];
                benifit.Project_ID__c = projectid ;
                benifit.Portfolio_Name__c = projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c ; 
                benifit.Project_Lead__c = projectinfo.Project_Lead__r.Full_Name__c ; 
                benifit.Project_Name_Display__c = projectinfo.Project_Name_Succinct__c ; 
                benifit.Project_Number__c =  projectinfo.Project_Number__c ;
                
                //totalsavings = projectinfo.TotalKPI__c + projectinfo.TotalCOPQ__c;              
            }  
            
            System.Debug('************* projectinfo.TriggerForDI3ApprovalProcess__c QIPP_BenefitController **************** ' + projectinfo.TriggerForDI3ApprovalProcess__c); 
            
            
            /********************************* RETRIVING PROJECT ID END*********************************/     
           
            
            hideedit = false;

            String benifitId = CurrentPage.substringAfter('?');

                // THIS CONDITION WILL WORK WHEN USER COME FROM BENIFIT_VIEW PAGE
                if(!benifitId.contains('&')) 
                {
                           benifit = [select ID ,
                                     name,                           
                                     Improvement_Measure_KPI__c ,
                                     Improvement_Measure_KPI__r.name,
                                     Improvement_Measure_KPI__r.Brief_Description__c,
                                     
                                     Business_Line__c,
                                     Unit_of_Measure__c,
                                     Benefit_Type__c,
                                     Improvement_Measure_Grouping__c,
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
                                     Benefit_Override_Status__c,
                                     
                                     Future_Quantity__c,
                                     Future_Start_Date__c,
                                     Future_End_Date__c,
                                     Future_Benefit_Period_Weeks__c,
                                     Future_Rate__c,
                                     Future_Financial_Automatic_Amount__c,
                                     Future_Financial_Manual_Amount__c,
                                     Future_Operational_Automatic_Amount__c ,
                                     Future_Operational_Manual_Amount__c,
                                      
                                     Benefit_Amount_Achieved_Future_k__c,  
                                     Benefit_Operational_Achieved_Future_k__c,
                                        
                                     Planned_Financial_Savings_Total__c,
                                     Planned_Operational_Savings_Total__c,
                                     Achieved_Financial_Savings_Total__c,
                                     Achieved_Operational_Savings_Total__c,
                                     Future_Financial_Savings_Total__c,
                                     Future_Operational_Savings_Total__c,
                                     
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
                                     

                                     Achieved_Benefit_Start__c,
                                     Achieved_Benefit_End__c,
                                     Planned_Benefit_End__c,
                                     Planned_Benefit_Start__c,
                                     Remaining_Benefit_End__c,
                                     Remaining_Benefit_Start__c
                                 

                                     from QIPP_Benefit__c where ID =: benifitId
                                     ];
                    System.Debug('********* Selected_Business 123 **************** ' + benifit.Selected_Business_Line__c ); 
                    System.Debug('********* SelectedValue 123**************** ' + SelectedValue );                                                  
                                     isDirectedFromView = true;     
                }

                else
                {
                    benifitId = benifitId.substringBefore('&') ;
                    if(benifitId.substringBefore('=') == 'id')
                    {
                        
                        ID EditBenifit = benifitId.substringAfter('=');
                        hideedit = true;
                        if(EditBenifit != null)
                        {
                           benifit = [select ID ,
                                     name, 
                                     Improvement_Measure_KPI__c ,
                                     Improvement_Measure_KPI__r.name,
                                     Improvement_Measure_KPI__r.Brief_Description__c,
                                     Business_Line__c,
                                     Unit_of_Measure__c,
                                     Benefit_Type__c,
                                     Improvement_Measure_Grouping__c,
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
                                     Benefit_Override_Status__c,
                                     
                                     Future_Quantity__c,
                                     Future_Start_Date__c,
                                     Future_End_Date__c,
                                     Future_Benefit_Period_Weeks__c,
                                     Future_Rate__c,
                                     Future_Financial_Automatic_Amount__c,
                                     Future_Financial_Manual_Amount__c,
                                     Future_Operational_Automatic_Amount__c ,
                                     Future_Operational_Manual_Amount__c,
                                      
                                     Benefit_Amount_Achieved_Future_k__c,  
                                     Benefit_Operational_Achieved_Future_k__c ,                                    
                                      
                                     Planned_Financial_Savings_Total__c,
                                     Planned_Operational_Savings_Total__c,
                                     Achieved_Financial_Savings_Total__c,
                                     Achieved_Operational_Savings_Total__c,
                                     Future_Financial_Savings_Total__c,
                                     Future_Operational_Savings_Total__c,
                                      
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
                                     CreatedBy.Name ,


                                     Achieved_Benefit_Start__c,
                                     Achieved_Benefit_End__c,
                                     Planned_Benefit_End__c,
                                     Planned_Benefit_Start__c,
                                     Remaining_Benefit_End__c,
                                     Remaining_Benefit_Start__c

                                     from QIPP_Benefit__c where ID =: EditBenifit];
                        }
                    System.Debug('********* Selected_Business 123 **************** ' + benifit.Selected_Business_Line__c ); 
                    System.Debug('********* SelectedValue 123**************** ' + SelectedValue );
                  }
              }
            
             System.Debug('************* benifit.Achieved_Start_Date__c **************** ' +    benifit.Achieved_Start_Date__c);
             
          
             System.Debug('************* Benifit ID**************** ' +benifit);
                   
            ConversionIDFound = CurrentPage.contains('convId'); 
            
            System.Debug('$$$$$$ CurrentPage : $$$$$$$ ' +ConversionIDFound);
            
//***********Start******* DI3DI5 Rules for doing readonly fields******************
            
            DI3DI5rule1 = false;
            DI3DI5rule2 = false;
            callBusinesslinelist = true;
            
           /* if( (projectinfo!= null && projectinfo.DI_State__c == 'DI 4 - Initiative is fully implemented')|| (projectinfo!= null && ConversionIDFound == False && projectinfo.TriggerForDI3ApprovalProcess__c == 'False' && projectinfo.DI_State__c == 'DI 5 - Initiative is implemented, impact visible') || (projectinfo!= null && projectinfo.DI_State__c == 'DI 3 - Measure Accepted for Implementation'  && projectinfo.TriggerForDI3ApprovalProcess__c == 'True'))
            {
                DI3DI5rule1 = true;
                callBusinesslinelist = false;
                SelectedValue = benifit.Selected_Business_Line__c;
            }
            else
            {
                DI3DI5rule1 = false;
                callBusinesslinelist = true;
            }
            */
            
            if(projectinfo.Check_DI_Approval_State__c == 'During DI3' || projectinfo.Check_DI_Approval_State__c == 'DI3 Complete' ||projectinfo.Check_DI_Approval_State__c == 'During DI4' ||projectinfo.Check_DI_Approval_State__c == 'DI4 Complete' ||projectinfo.Check_DI_Approval_State__c == 'During DI5' ||projectinfo.Check_DI_Approval_State__c == 'DI5 Complete')
            {
                DI3DI5rule1 = true;
                callBusinesslinelist = false;
                SelectedValue = benifit.Selected_Business_Line__c;
            }
            else
            {
                DI3DI5rule1 = false;
                callBusinesslinelist = true;
            }
            
            if(projectinfo.Check_DI_Approval_State__c == 'During DI5' ||projectinfo.Check_DI_Approval_State__c == 'DI5 Complete')
            {
                DI3DI5rule2 = true;
                
            }
            else
            {
                DI3DI5rule2 = false;
            }
            
            
            
//***********END******* DI3DI5 Rules for doing readonly fields******************


                if(ConversionId != null)  // ConversionID is requried for search page .....          
                {
                    con = [select Name , Id  , Impacted_P_L_Line__c , Monetization_Calculation_Method__c , Directional_Indicator__c , Benefit_Type__c, Improvement_Measure_Grouping__c,CoPQ_Type__c , Brief_Description__c, Unit_of_Measure__c from QIPP_Benefit_Conversion_Table__c
                                                    where Id  =: ConversionId ];
                     IMPDescription = con[0].Brief_Description__c;
                     benifit.Improvement_Measure_KPI__c = con[0].Id; 
                     benifit.Improvement_Measure_Grouping__c = con[0].Improvement_Measure_Grouping__c;
                     system.debug('ConversionId:::::'+ConversionId);
                     system.debug('benifit.Improvement_Measure_KPI__c:::::'+benifit.Improvement_Measure_KPI__c); 
                     
                    if(callBusinesslinelist == true)
                    {
                        getBusinesslinelist();  
                    }                     
                }
                else
                {
                    con = [select Name , Id  , Impacted_P_L_Line__c , Monetization_Calculation_Method__c , Directional_Indicator__c , Benefit_Type__c,Improvement_Measure_Grouping__c, CoPQ_Type__c ,Brief_Description__c,  Unit_of_Measure__c from QIPP_Benefit_Conversion_Table__c
                                                    where Id  =: benifit.Improvement_Measure_KPI__c];

                    if(con.size() > 0){
                        benifit.Improvement_Measure_Grouping__c = con[0].Improvement_Measure_Grouping__c; 
                        IMPDescription = con[0].Brief_Description__c;                       
                    }                                                   
                }                                                    
                              
                
                      if(con.size() > 0 && benifit.Invoke_Benefit_Override_Approve__c == 'No')
                      {
                        System.Debug('***********************  inside block 1 ********************** ');  
                        if(con[0].Benefit_Type__c == 'Operational Savings')
                        {
                           Benefit_Type = 'Operational Savings';
                           //TypeOfPlannedSaving =  'Planned Operational Savings';
                           //TypeOfAchievedSaving =  'Achieved Operational Savings';
                           //TypeOfFutureSaving =  'Future Operational Savings';    
                        }   
                        else
                        {
                            Benefit_Type = 'Financial Savings';
                            //TypeOfPlannedSaving =  'Planned Financial Savings';
                            //TypeOfAchievedSaving =  'Achieved Financial Savings';
                            //TypeOfFutureSaving =    'Future Financial Savings';  
                        }    
                        if(con[0].Monetization_Calculation_Method__c == 'Manual')
                            isManual = true;
                        else 
                            isManual = false;

                        isNoteDisplay = TRUE;
                        
                        if(callBusinesslinelist == true)
                        {
                            getBusinessLine();  
                        }  
                        
                            
                    System.Debug('********* Selected_Business 123 **************** ' + benifit.Selected_Business_Line__c ); 
                    System.Debug('********* SelectedValue 123**************** ' + SelectedValue );
                     }
                     
                     if(con.size() > 0 && benifit.Invoke_Benefit_Override_Approve__c == 'Yes')
                      {
                        System.Debug('***********************  inside block 2 ********************** ');  
                      
                            Benefit_Type = 'Financial Savings';
                            //TypeOfPlannedSaving =  'Planned Financial Savings';
                            //TypeOfAchievedSaving =  'Achieved Financial Savings';
                            //TypeOfFutureSaving =    'Future Financial Savings';  

                        if(con[0].Monetization_Calculation_Method__c == 'Manual')
                            isManual = true;
                        else 
                            isManual = false;

                        isNoteDisplay = TRUE;
                        
                        
                        if(callBusinesslinelist == true)
                        {
                            getBusinessLine();  
                        } 
                        
                        System.Debug('********* Selected_Business 123 **************** ' + benifit.Selected_Business_Line__c ); 
                    System.Debug('********* SelectedValue 123**************** ' + SelectedValue );
                     }
                     
                     
                     System.Debug('********* Selected_Business 123 **************** ' + benifit.Selected_Business_Line__c ); 
                    System.Debug('********* SelectedValue 123**************** ' + SelectedValue );
                    
                    
                   TypeOfPlannedSaving =  'Planned';
                   TypeOfAchievedSaving =  'Achieved';
                   TypeOfFutureSaving =    'Future'; 
        
        //************** Start Benefit line items ***********************************
        
        Bn_rep_AddList= new List<QIPP_BU_Reporting__c>();   
        
        Bn_rep_DelList= new List<QIPP_BU_Reporting__c>();
        
        if(projectinfo!= null && ConversionIDFound == False)  
        {
            Bn_rep_AddList = [select ID ,                                 
                                    Project_ID__c,
                                    Benefit_ID__c,
                                    Benefit_Condition__c,
                                    Quarters__c,
                                    Years__c,
                                    Months__c,
                                    DI3DI5_Flag__c,
                                    Benefit_Savings_Amount__c,
                                    History_Tracking_For_Line_Items__c,
                                    History_Tracking_For_Initial_Line_Items__c,
                                    Entry_Type__c
                                    
                                from QIPP_BU_Reporting__c  where Project_ID__c =:projectid and Benefit_ID__c =:benifit.id and Entry_Type__c !='System Entry'];
            if(Bn_rep_AddList.size() > 0 )
            {
            rowNum= Bn_rep_AddList.size();
            }
            else
            {
                Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_ID__c=benifit.id,Entry_Type__c ='User Entry'));
                rowNum=1;
            }
        }
        else
        {
            Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_ID__c=benifit.id));
            rowNum=1;
        }
        
        if(Bn_rep_AddList.size() > 0 )
        {
            
            for(QIPP_BU_Reporting__c di3p :Bn_rep_AddList)
            {
                if(di3p.Benefit_Condition__c == 'Planned')
                {
                    pcount1++;
                }
                /*if(di3p.Benefit_Condition__c == 'Achieved' || di3p.Benefit_Condition__c == 'Future')
                {
                    afcount1++;
                }
                */
            }
        }
        System.Debug('******Before*** PlannedCount **************** ' + pcount1);
        
        //************** End Benefit line items **********************************

        
    }
    catch(Exception exe)
    {
             System.Debug('**************** Exception occured ***************** ' + exe.getMessage());
             System.Debug('**************** Exception occured ***************** ' + exe.getLineNumber());
    }   
}

//*********************Start Benefit line items Add row,del row, Clone row **************************


    public void AddRow()
    {
        Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_ID__c=benifit.id,Entry_Type__c ='User Entry'));
    }
    
    public void delRow()
    {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        Bn_rep_DelList.add(Bn_rep_AddList.get(rowNum));
        Bn_rep_AddList.remove(rowNum);   
    }    
    public void cloneRow()
    {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_Condition__c=Bn_rep_AddList[rowNum].Benefit_Condition__c,Years__c=Bn_rep_AddList[rowNum].Years__c,Quarters__c=Bn_rep_AddList[rowNum].Quarters__c,Months__c=Bn_rep_AddList[rowNum].Months__c,Benefit_Savings_Amount__c=Bn_rep_AddList[rowNum].Benefit_Savings_Amount__c,Benefit_ID__c=benifit.id,Entry_Type__c ='User Entry'));
    }    



//*********************End Benefit line items Add row,del row, Clone row********************************
   
    public PageReference save()
    {
		PageReference obj = null;
        
		/*errorflag = false;       
        pageredirect = false;
        totalamountvalidation = 0;
        currentbenifitamount =0;
        decimal toatlcheck = 0;
        if(benifit.id != null){
            toatlcheck = totalsavings - (benifit.Benefit_Amount_Achieved_Future_k__c  + benifit.Benefit_Operational_Achieved_Future_k__c );
        }else{
            toatlcheck = totalsavings;
        }
        */
        
        //List<QIPP_BU_Reporting__c> list1 = [select Id from QIPP_BU_Reporting__c];
        //delete list1;
        try
        {
            pcount2 = 0;
            afcount2 = 0;
            flag = false;
                // Start::Validations
                /*********************** VALIDATION FOR Quality Improvment Measure SECTION ************************/
                
               if(benifit.Improvement_Measure_KPI__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select an Improvement Measure')); 
                    flag =true;
                    System.Debug('********* 1 **************** ' + flag);
                }
                
                /**************** VALIDATION FOR Baseline (Baseline And Forecast)  Condition SECTION ***************/
                

                if( benifit.Baseline_Quantity__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Baseline Quantity')); 
                    flag =true;   
                    System.Debug('********* 5 **************** ' + flag);                             
                }
                if( benifit.Type_of_Measure__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select a Baseline Type of Measure')); 
                    flag =true;    
                    System.Debug('********* 4 **************** ' + flag);
                }
                
                if((benifit.Type_of_Measure__c != null && benifit.Type_of_Measure__c == 'Distributed Amount') &&   benifit.Baseline_Period_weeks__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value for Baseline Period (weeks) in Baseline Condition section')); 
                    flag =true;   
                    System.Debug('********* 6 **************** ' + flag);
                }
                if((benifit.Type_of_Measure__c != null && benifit.Type_of_Measure__c == 'Distributed Amount') &&   benifit.Baseline_Period_weeks__c == 0)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value greater than 0 for Baseline Period (weeks) in Baseline And Forecast Condition section')); 
                    flag =true;   
                    System.Debug('********* 6i **************** ' + flag);
                }
                
              /***************VALIDATION FOR  Planned (Baseline And Forecast) Condition SECTION **************/
                
                if(benifit.Planned_Quanity__c != null && benifit.Planned_Type_of_Measure__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select a Planned Type of Measure')); 
                    flag =true;    
                    System.Debug('********* 4 **************** ' + flag);
                            
                }
                if(benifit.Planned_Type_of_Measure__c != null &&  benifit.Planned_Quanity__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Planned Quantity')); 
                    flag =true;   
                    System.Debug('********* 5 **************** ' + flag);
                             
                }
                if((benifit.Planned_Type_of_Measure__c != null && benifit.Planned_Type_of_Measure__c == 'Distributed Amount') &&   benifit.Planned_Benefit_Period_Weeks__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value for Planned Period (weeks) in Baseline And Forecast Condition section')); 
                    flag =true;   
                    System.Debug('********* 6 **************** ' + flag);
                }
                if((benifit.Planned_Type_of_Measure__c != null && benifit.Planned_Type_of_Measure__c == 'Distributed Amount') &&   benifit.Planned_Benefit_Period_Weeks__c == 0)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value greater than 0 for Planned Period (weeks) in Baseline And Forecast Condition section')); 
                    flag =true;   
                    System.Debug('********* 6i **************** ' + flag);
                }
                
                /********** VALIDATION FOR  Revised_Forecast (Baseline And Forecast) Condition SECTION ************/
                
                if(benifit.Revised_Forecast_Quanity__c != null && benifit.Revised_Forecast_Type_of_Measure__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select a Revised_Forecast Type of Measure')); 
                    flag =true;    
                    System.Debug('********* 4 **************** ' + flag);
                            
                }
                if(benifit.Revised_Forecast_Type_of_Measure__c != null &&  benifit.Revised_Forecast_Quanity__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Revised_Forecast Quantity')); 
                    flag =true;   
                    System.Debug('********* 5 **************** ' + flag);
                             
                }
                if((benifit.Revised_Forecast_Type_of_Measure__c != null && benifit.Revised_Forecast_Type_of_Measure__c == 'Distributed Amount') &&   benifit.Revised_Forecast_Benefit_Period_Weeks__c == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value for Revised_Forecast Period (weeks) in Baseline And Forecast Condition section')); 
                    flag =true;   
                    System.Debug('********* 6 **************** ' + flag);
                }
                if((benifit.Revised_Forecast_Type_of_Measure__c != null && benifit.Revised_Forecast_Type_of_Measure__c == 'Distributed Amount') &&   benifit.Revised_Forecast_Benefit_Period_Weeks__c == 0)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value greater than 0 for Revised_Forecast Period (weeks) in Baseline And Forecast Condition section')); 
                    flag =true;   
                    System.Debug('********* 6i **************** ' + flag);
                }
                
            
                /*********************** VALIDATION FOR Improvement Plan SECTION ************************/


                
                /*********************** VALIDATION FOR Future Savings SECTION ************************/
     
            
            /*********************** VALIDATION FOR KPI Selection For All SECTION ************************/
          
         
        // System.Debug('********* in validation con[0].Benefit_Type__c **************** ' + con[0].Benefit_Type__c); */ 
             
          if(con[0].Benefit_Type__c == 'Financial Savings')  
          {
              if(projectinfo.CoPQ_Benefits_Validation_State__c != null &&  ( projectinfo.CoPQ_Benefits_Validation_State__c == 'With Finance Approver to Validate'))  
              {  
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Note: Financial Savings cannot be added at this point, as the approvals are pending')); 
                  flag =true; 
              }
                
             if(projectinfo.CoPQ_Benefits_Validation_State__c != null && projectinfo.CoPQ_Benefits_Validation_State__c == 'Validation Complete')  
             {
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Note: Financial Savings cannot be added at this point, as they are already approved')); 
                  flag =true; 
             }
          }   
         
         else if(con[0].Benefit_Type__c == 'Operational Savings')       
         {
             if(projectinfo.KPI_Benefits_Validation_State__c != null &&  ( projectinfo.KPI_Benefits_Validation_State__c == 'With Operational Savings Approver to Validate' || projectinfo.KPI_Benefits_Validation_State__c == 'With Finance Approver to Validate'))  
              {       
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Note: Operational Savings cannot be added at this point, as the approvals are pending')); 
                  flag =true; 
              }
                
             if(projectinfo.KPI_Benefits_Validation_State__c != null &&  projectinfo.KPI_Benefits_Validation_State__c == 'Validation Complete')  
             {
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Note: Operational Savings cannot be added at this point, as they are already approved')); 
                  flag =true; 
             }
         }    
            System.Debug('********* flag **************** ' + flag);
        
        /*********************** VALIDATIONS FOR Benefit - Line Items SECTION ************************/
            
            if(Bn_rep_AddList.size() > 0 )
            {
                System.Debug('*****Add list Size **************** ' + Bn_rep_AddList.size());
                
                for(QIPP_BU_Reporting__c di3p :Bn_rep_AddList)
                {
                
                    if(di3p.Benefit_Condition__c == 'Planned')
                    {
                        pcount2++;
                    }

                }
                
                if( (pcount2 > pcount1) && (projectinfo.Check_DI_Approval_State__c == 'During DI3' || projectinfo.Check_DI_Approval_State__c == 'DI3 Complete' ||projectinfo.Check_DI_Approval_State__c == 'During DI4' ||projectinfo.Check_DI_Approval_State__c == 'DI4 Complete'))
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Planned Savings cannot be entered at this time, as either DI 3 approval is in progress or DI 3 has already been approved.  Remove the entry from the "Benefit - Line Items" section.')); 
                    flag =true;
                    pcount2 = 0;
                }
                
            }      
                        
            
            hMapMonth = new Map<String,String>();

            String key_month = '';
         
            
            for(QIPP_BU_Reporting__c Benrepv:Bn_rep_AddList)
            {
            key_month = Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+Benrepv.Months__c;
                if(Benrepv.Benefit_Condition__c != null &&( Benrepv.Years__c == null || Benrepv.Quarters__c == null || Benrepv.Benefit_Savings_Amount__c == null) )
                {
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'“Please populate missing data for the Benefit Line – Condition, Year, Quarter and Savings Amount(k€) are required to save a line item.”')); 
                System.Debug('********* PIcklistyear **************** ' +Benrepv.Benefit_Condition__c);
                    flag =true; 
                }
                
                if(Benrepv.Years__c != null &&( Benrepv.Benefit_Condition__c == null || Benrepv.Quarters__c == null || Benrepv.Benefit_Savings_Amount__c == null) )
                {
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'“Please populate missing data for the Benefit Line – Condition, Year, Quarter and Savings Amount(k€) are required to save a line item.”')); 
                System.Debug('********* PIcklistyear **************** ' +Benrepv.Benefit_Condition__c);
                    flag =true; 
                }
                
                if(Benrepv.Quarters__c != null &&( Benrepv.Years__c == null || Benrepv.Benefit_Condition__c == null || Benrepv.Benefit_Savings_Amount__c == null) )
                {
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'“Please populate missing data for the Benefit Line – Condition, Year, Quarter and Savings Amount(k€) are required to save a line item.”')); 
                System.Debug('********* PIcklistyear **************** ' +Benrepv.Benefit_Condition__c);
                    flag =true; 
                }
                
                if(Benrepv.Benefit_Savings_Amount__c != null &&( Benrepv.Years__c == null || Benrepv.Quarters__c == null || Benrepv.Benefit_Condition__c == null) )
                {
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'“Please populate missing data for the Benefit Line – Condition, Year, Quarter and Savings Amount(k€) are required to save a line item.”')); 
                System.Debug('********* PIcklistyear **************** ' +Benrepv.Benefit_Condition__c);
                    flag =true; 
                }
                if(hMapMonth.containsKey(key_month))
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'“Please remove the duplicate row for the same quarter and month in "Benefit - Line Items" section.”')); 
                    flag =true;
                }
                else{
                    if(Benrepv.Months__c == null && Benrepv.Quarters__c == 'Q1'){
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+Benrepv.Months__c,'0');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'01','1');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'02','2');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'03','3');
                    }
                    else if(Benrepv.Months__c == null && Benrepv.Quarters__c == 'Q2'){
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+Benrepv.Months__c,'0');                    
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'04','4');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'05','5');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'06','6');
                    }
                    else if(Benrepv.Months__c == null && Benrepv.Quarters__c == 'Q3'){
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+Benrepv.Months__c,'0');                    
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'07','7');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'08','8');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'09','9');
                    }
                    else if(Benrepv.Months__c == null && Benrepv.Quarters__c == 'Q4'){
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+Benrepv.Months__c,'0');                    
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'10','10');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'11','11');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'12','12');
                    }                                                            
                    else if(Benrepv.Months__c != null && Benrepv.Quarters__c == 'Q1'){
                    hMapMonth.put(key_month,'month');
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'null','0');
                    }
                    else if(Benrepv.Months__c != null && Benrepv.Quarters__c == 'Q2'){
                    hMapMonth.put(key_month,'month');                    
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'null','0');                    
                    }
                    else if(Benrepv.Months__c != null && Benrepv.Quarters__c == 'Q3'){
                    hMapMonth.put(key_month,'month');                    
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'null','0');                    
                    }
                    else if(Benrepv.Months__c != null && Benrepv.Quarters__c == 'Q4'){
                    hMapMonth.put(key_month,'month');                    
                    hMapMonth.put(Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+'null','0');                    
                    }                }
                System.Debug('*********key_month****************' +key_month );
            }
            
            if(flag){
                errorflag = true; 
            }else{
                errorflag = false; 
            }
                    
           // End::Validations     
            
           if(flag == false)
           {
            /************** FOR Baseline Condition SECTION START *********************/ 
                
            if((benifit.Baseline_Quantity__c != null && benifit.Baseline_Quantity__c > 0) && (benifit.Baseline_Period_weeks__c != null && benifit.Baseline_Period_weeks__c > 0)  && (  benifit.Type_of_Measure__c != null && benifit.Type_of_Measure__c == 'Distributed Amount'))
                 benifit.Baseline_Rate_N__c = benifit.Baseline_Quantity__c / benifit.Baseline_Period_weeks__c ;
            else if( (benifit.Baseline_Quantity__c != null && benifit.Baseline_Quantity__c > 0) && (benifit.Type_of_Measure__c != null && benifit.Type_of_Measure__c == 'Monthly Rate'))     
                 benifit.Baseline_Rate_N__c = benifit.Baseline_Quantity__c / 4.35;
            else if( (benifit.Baseline_Quantity__c != null && benifit.Baseline_Quantity__c > 0) && (benifit.Type_of_Measure__c != null && benifit.Type_of_Measure__c == 'Quarterly Rate'))     
                 benifit.Baseline_Rate_N__c = benifit.Baseline_Quantity__c / 13; 
            else
                 benifit.Baseline_Rate_N__c = benifit.Baseline_Quantity__c;
             
             IF(benifit.Baseline_Rate_N__c != null)
             {
                 benifit.Baseline_Rate_N__c = benifit.Baseline_Rate_N__c.setScale(2, RoundingMode.HALF_UP);    
                 System.Debug('********* benifit.Baseline_Rate_N__c **************** ' + benifit.Baseline_Rate_N__c);     
             }
            /******************************* FOR Baseline Condition SECTION END **************************************/
           
            
           if(benifit.Planned_Quanity__c != null && benifit.Planned_Quanity__c > 0.0 && benifit.Planned_Benefit_Period_Weeks__c > 0.0)
            {
                    benifit.Planned_Rate__c = benifit.Planned_Quanity__c / benifit.Planned_Benefit_Period_Weeks__c;
            }
            if(benifit.Planned_Rate__c != null)
            {
                 benifit.Planned_Rate__c = benifit.Planned_Rate__c.setScale(5, RoundingMode.HALF_UP); 
                 System.Debug('********* benifit.Planned_Rate__c **************** ' +  benifit.Planned_Rate__c);
                 System.Debug('********* benifit.Planned_Quanity__c **************** ' + benifit.Planned_Quanity__c);
            }
        
            Date startdate;
            Integer Month ,Year;
            String Quarter = null;
            Decimal ImprovedConversionRate = 0.0 , ImprovedConversionRateP = 0.0 , ImprovedConversionRatePP = 0.0 , ImprovedConversionRatePPP = 0.0;
            
            if(benifit.Planned_Start_Date__c != null)
            {
                startdate = benifit.Planned_Start_Date__c;
                Month = startdate.month();
                Year = startdate.Year();
                if(Month == 1 || Month == 2 || Month == 3)
                        Quarter = 'Q1';
                if(Month == 4 || Month == 5 || Month == 6)
                        Quarter = 'Q2';
                if(Month == 7 || Month == 8 || Month == 9)
                        Quarter = 'Q3';
                if(Month == 10 || Month == 11 || Month == 12)
                        Quarter = 'Q4';
            }

            QIPP_Benefit_Conversion_Table__c conversionrate = null;
           
           if(benifit.Unit_of_Measure__c == 'K Euro')
           {
               ImprovedConversionRate = 1.0 ;
               benifit.Planned_Conversion_Rate__c = ImprovedConversionRate ;
           }
           else
           {
              ImprovedConversionRate = returnConversionRate(String.valueOf(Year) , String.valueOf(Quarter) , benifit.Improvement_Measure_KPI__c ,   benifit.Selected_Business_Line__c) ;
                  
              if(ImprovedConversionRate == 0.0)
              {
                  if(Quarter == 'Q4')
                  {
                      ImprovedConversionRateP = returnConversionRate(String.valueOf(Year) , 'Q3' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePP = returnConversionRate(String.valueOf(Year) , 'Q2' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePPP = returnConversionRate(String.valueOf(Year) , 'Q1' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                  }
                  if(Quarter == 'Q3')
                  {
                      ImprovedConversionRateP = returnConversionRate(String.valueOf(Year) , 'Q2' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePP = returnConversionRate(String.valueOf(Year) , 'Q1' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePPP = returnConversionRate(String.valueOf(Year-1) , 'Q4' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                  }
                  if(Quarter == 'Q2')
                  {
                      ImprovedConversionRateP = returnConversionRate(String.valueOf(Year) , 'Q1' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePP = returnConversionRate(String.valueOf(Year-1) , 'Q4' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePPP = returnConversionRate(String.valueOf(Year-1) , 'Q3' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                  }
                  if(Quarter == 'Q1')
                  {
                      ImprovedConversionRateP = returnConversionRate(String.valueOf(Year-1) , 'Q4' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePP = returnConversionRate(String.valueOf(Year-1) , 'Q3' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                      ImprovedConversionRatePPP = returnConversionRate(String.valueOf(Year-1) , 'Q2' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                  }

                  IF(ImprovedConversionRateP != 0.0 && ImprovedConversionRatePP == 0.0 &&  ImprovedConversionRatePPP == 0.0 )
                      ImprovedConversionRate = ImprovedConversionRateP ;
                  else if(ImprovedConversionRateP == 0.0 && ImprovedConversionRatePP != 0.0 &&  ImprovedConversionRatePPP == 0.0 )    
                      ImprovedConversionRate = ImprovedConversionRatePP ;
                  else if(ImprovedConversionRateP == 0.0 && ImprovedConversionRatePP == 0.0 &&  ImprovedConversionRatePPP != 0.0 )    
                      ImprovedConversionRate = ImprovedConversionRatePPP ;
                  else if(ImprovedConversionRateP != 0.0 && ImprovedConversionRatePP != 0.0 &&  ImprovedConversionRatePPP != 0.0 )    
                      ImprovedConversionRate = ImprovedConversionRateP ;
                  else if(ImprovedConversionRateP == 0.0 && ImprovedConversionRatePP != 0.0 &&  ImprovedConversionRatePPP != 0.0 )    
                      ImprovedConversionRate = ImprovedConversionRatePP ;
                  else if(ImprovedConversionRateP != 0.0 && ImprovedConversionRatePP != 0.0 &&  ImprovedConversionRatePPP == 0.0 )    
                      ImprovedConversionRate = ImprovedConversionRateP ;
                  else if(ImprovedConversionRateP != 0.0 && ImprovedConversionRatePP == 0.0 &&  ImprovedConversionRatePPP != 0.0 )    
                      ImprovedConversionRate = ImprovedConversionRateP ;                    
                  else
                      ImprovedConversionRate = 0.0; 
              }
              benifit.Planned_Conversion_Rate__c = ImprovedConversionRate ;
              
           }
             System.Debug('*********Planned  ImprovedConversionRate **************** ' +  ImprovedConversionRate);
            
                       if(benifit.Directional_Indicator__c != null && benifit.Directional_Indicator__c == 'Lower is Favorable')
                        {
                            System.Debug('********* Inside one **************** ');
                            if(ImprovedConversionRate != null && benifit.Baseline_Rate_N__c != null && benifit.Planned_Rate__c != null && benifit.Benefit_Type__c != 'Operational Savings')
                            {
                                System.Debug('********* Inside one if **************** ');
                                Decimal val = (benifit.Baseline_Rate_N__c-benifit.Planned_Rate__c)*(benifit.Planned_Benefit_Period_Weeks__c)*ImprovedConversionRate;
                                benifit.Planned_Financial_Automatic_Amount__c = val.setScale(0, RoundingMode.HALF_UP);
                                benifit.Planned_Operational_Automatic_Amount__c = null;
                            } 
                            else if(ImprovedConversionRate != null && benifit.Baseline_Rate_N__c != null && benifit.Planned_Rate__c != null && benifit.Benefit_Type__c == 'Operational Savings')   
                            {
                                System.Debug('********* Inside one if else**************** ');
                                Decimal val = (benifit.Baseline_Rate_N__c-benifit.Planned_Rate__c)*(benifit.Planned_Benefit_Period_Weeks__c)*ImprovedConversionRate;
                                benifit.Planned_Operational_Automatic_Amount__c = val.setScale(0, RoundingMode.HALF_UP);
                                benifit.Planned_Financial_Automatic_Amount__c = null;
                            } 
                                
                        }
                        else if(benifit.Directional_Indicator__c != null && benifit.Directional_Indicator__c == 'Higher is Favorable')    
                        {
                             System.Debug('********* Inside two **************** ');
                            if(ImprovedConversionRate != null  && benifit.Baseline_Rate_N__c != null && benifit.Planned_Rate__c != null && benifit.Benefit_Type__c != 'Operational Savings')
                            {
                                 System.Debug('********* Inside one if case 1**************** ');
                                Decimal val = (benifit.Planned_Rate__c-benifit.Baseline_Rate_N__c)*(benifit.Planned_Benefit_Period_Weeks__c)*ImprovedConversionRate;
                                benifit.Planned_Financial_Automatic_Amount__c = val.setScale(0, RoundingMode.HALF_UP);
                                benifit.Planned_Operational_Automatic_Amount__c = null;
                            }
                            else if(ImprovedConversionRate != null  && benifit.Baseline_Rate_N__c != null && benifit.Planned_Rate__c != null && benifit.Benefit_Type__c == 'Operational Savings')                            
                            {
                                 System.Debug('********* Inside one if case 2**************** ');
                                Decimal val = (benifit.Planned_Rate__c-benifit.Baseline_Rate_N__c)*(benifit.Planned_Benefit_Period_Weeks__c)*ImprovedConversionRate;
                                benifit.Planned_Operational_Automatic_Amount__c = val.setScale(0, RoundingMode.HALF_UP);
                                benifit.Planned_Financial_Automatic_Amount__c = null;                        
                            }                        
                        }
                        

                        if(isManual == true)
                        {
                            System.Debug('********* Inside Manual 1 **************** ');
                            benifit.Planned_Operational_Automatic_Amount__c = null;
                            benifit.Planned_Financial_Automatic_Amount__c = null;
                        }
                        else
                        {
                            System.Debug('********* Inside Manual 2 **************** '); 
                            benifit.Planned_Operational_Manual_Amount__c = null;
                            benifit.Planned_Financial_Manual_Amount__c = null;
                        }
                        
                        
                        
                        System.Debug('********* benifit.Planned_Financial_Automatic_Amount__c **************** ' + benifit.Planned_Financial_Automatic_Amount__c);
                        System.Debug('********* benifit.Planned_Financial_Manual_Amount__c **************** ' + benifit.Planned_Financial_Manual_Amount__c);
                        System.Debug('********* benifit.Planned_Operational_Manual_Amount__c **************** ' + benifit.Planned_Operational_Manual_Amount__c);
                        System.Debug('********* benifit.Planned_Operational_Automatic_Amount__c **************** ' + benifit.Planned_Operational_Automatic_Amount__c);
                            

           /******************************* FOR Improvement Plan SECTION END**************************************/

           /******************************* FOR Achieved To-Date SECTION START**************************************/
           
           System.Debug('************** benifit.Achieved_Start_Date__c ************ ' + benifit.Achieved_Start_Date__c);
           System.Debug('************** benifit.Achieved_End_Date__c ************ ' + benifit.Achieved_End_Date__c);
                        if(benifit.Achieved_Start_Date__c != null && benifit.Achieved_End_Date__c != null)
                        {
                            if(benifit.Achieved_Start_Date__c.isSameDay(benifit.Achieved_End_Date__c))
                            {
                                decimal totalweeks = (1.0/7.0);
                                benifit.Achieved_Benefit_Period_Weeks__c = totalweeks.setScale(2, RoundingMode.HALF_UP);
                            }
                            else
                            {
                               Decimal totalweeks;
                               Decimal days = benifit.Achieved_Start_Date__c.daysBetween(benifit.Achieved_End_Date__c);
                               if(days > 0)
                               {
                                    totalweeks  = (days+1.0)/7.0;
                                    totalweeks  = totalweeks.setScale(2, RoundingMode.HALF_UP);
                                    benifit.Achieved_Benefit_Period_Weeks__c = totalweeks;    
                                }    
                            }
                        }
                        else
                        {
                            benifit.Achieved_Benefit_Period_Weeks__c = 0.0;
                        }
                        System.Debug('************** benifit.Achieved_Benefit_Period_Weeks__c ************ ' + benifit.Achieved_Benefit_Period_Weeks__c);

                         if(benifit.Achieved_Quantity__c != null && benifit.Achieved_Quantity__c > 0.0 && benifit.Achieved_Benefit_Period_Weeks__c > 0.0)
                          { 
                               benifit.Achieved_Rate__c = benifit.Achieved_Quantity__c / benifit.Achieved_Benefit_Period_Weeks__c; 
                          }
                        System.Debug('************** benifit.Type_of_Measure__c ************ ' + benifit.Type_of_Measure__c);
                        System.Debug('************** benifit.Achieved_Rate__c ************ ' + benifit.Achieved_Rate__c);
                        System.Debug('************** benifit.Achieved_Quantity__c ************ ' + benifit.Achieved_Quantity__c);
                        
                        Date actualstartdate;
                        Integer actualMonth , actualYear ;
                        String actualQuarter = null;
                        Decimal actualConversionRateValue = 0.0 , actualConversionRateValueP = 0.0 , actualConversionRateValuePP = 0.0 ,actualConversionRateValuePPP = 0.0  ;
                        
                        if(benifit.Achieved_Start_Date__c != null)
                        {
                            actualstartdate = benifit.Achieved_Start_Date__c;
                                actualMonth  = actualstartdate.month();
                                actualYear = actualstartdate.Year();
                           
                                if(actualMonth == 1 || actualMonth == 2 || actualMonth == 3)
                                    actualQuarter = 'Q1';
                                if(actualMonth == 4 || actualMonth == 5 || actualMonth == 6)
                                    actualQuarter = 'Q2';
                                if(actualMonth == 7 || actualMonth == 8 || actualMonth == 9)
                                    actualQuarter = 'Q3';
                                if(actualMonth == 10 || actualMonth == 11 || actualMonth == 12)
                                    actualQuarter = 'Q4';
                         }           
         
          /******************************* FOR Future SECTION START**************************************/
           
                       if(benifit.Future_Start_Date__c != null && benifit.Future_End_Date__c != null)
                        {
                            if(benifit.Future_Start_Date__c.isSameDay(benifit.Future_End_Date__c))
                            {
                                decimal totalweeks = (1.0/7.0);
                                benifit.Future_Benefit_Period_Weeks__c = totalweeks.setScale(2, RoundingMode.HALF_UP);
                            }
                            else  
                            {
                               Decimal totalweeks;
                               Decimal days = benifit.Future_Start_Date__c.daysBetween(benifit.Future_End_Date__c);
                               if(days > 0)
                               {
                                    totalweeks  = (days+1.0)/7.0;
                                    totalweeks  = totalweeks.setScale(2, RoundingMode.HALF_UP);
                                    benifit.Future_Benefit_Period_Weeks__c = totalweeks;    
                                }    
                            }
                        }
                        else
                        {
                            benifit.Future_Benefit_Period_Weeks__c = 0.0;
                        }
                        System.Debug('********* benifit.Future_Benefit_Period_Weeks__c **************** ' + benifit.Future_Benefit_Period_Weeks__c);
                    
                        if(benifit.Future_Quantity__c != null && benifit.Future_Quantity__c > 0.0 &&benifit.Future_Benefit_Period_Weeks__c > 0.0)
                        {
                              benifit.Future_Rate__c = benifit.Future_Quantity__c / benifit.Future_Benefit_Period_Weeks__c; 
                        }
                        System.Debug('********* benifit.Future_Rate__c **************** ' + benifit.Future_Rate__c);
                        System.Debug('********* benifit.Future_Quantity__c **************** ' + benifit.Future_Quantity__c);
                        System.Debug('********* benifit.Future_Benefit_Period_Weeks__c **************** ' + benifit.Future_Benefit_Period_Weeks__c);
                        
                        Date actualstartdateremaining ;
                        Integer actualMonthremaining , actualYearremaining ;
                        String actualQuarterremaining = null;
                        Decimal actualConversionRateValueRemaining = 0.0 , actualConversionRateValueRemainingP = 0.0 , actualConversionRateValueRemainingPP = 0.0 ,actualConversionRateValueRemainingPPP = 0.0  ;
                        
                        if(benifit.Future_Start_Date__c != null)
                        {
                                actualstartdateremaining = benifit.Future_Start_Date__c;
                                actualMonthremaining  = actualstartdateremaining.month();
                                actualYearremaining = actualstartdateremaining.Year();
                           
                                if(actualMonthremaining == 1 ||  actualMonthremaining == 2 || actualMonthremaining == 3)
                                    actualQuarterremaining = 'Q1';
                                if(actualMonthremaining == 4 || actualMonthremaining == 5 || actualMonthremaining == 6)
                                    actualQuarterremaining = 'Q2';
                                if(actualMonthremaining == 7 || actualMonthremaining == 8 || actualMonthremaining == 9)
                                    actualQuarterremaining = 'Q3';
                                if(actualMonthremaining == 10 || actualMonthremaining == 11 || actualMonthremaining == 12)
                                    actualQuarterremaining = 'Q4';
                         }           
                                    
                      QIPP_Benefit_Conversion_Table__c actualconversionrateR = null;    
                     
                       if(benifit.Unit_of_Measure__c == 'K Euro')
                       {
                           actualConversionRateValueRemaining = 1.0 ;
                           benifit.Future_Conversion_Rate__c = actualConversionRateValueRemaining ;
                       }
                       else
                       {
                           actualConversionRateValueRemaining = returnConversionRate(String.valueOf(actualYearremaining) , String.valueOf(actualQuarterremaining) , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                           if(actualConversionRateValueRemaining == 0.0)
                              {
                                  if(actualQuarterremaining== 'Q4')
                                  {
                                      actualConversionRateValueRemainingP = returnConversionRate(String.valueOf(actualYearremaining) , 'Q3' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPP= returnConversionRate(String.valueOf(actualYearremaining) , 'Q2' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPPP= returnConversionRate(String.valueOf(actualYearremaining) , 'Q1' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                                  }
                                  if(actualQuarterremaining== 'Q3')
                                  {
                                      actualConversionRateValueRemainingP= returnConversionRate(String.valueOf(actualYearremaining) , 'Q2' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPP= returnConversionRate(String.valueOf(actualYearremaining) , 'Q1' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPPP= returnConversionRate(String.valueOf(actualYearremaining-1) , 'Q4' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                                  }
                                  if(actualQuarterremaining== 'Q2')
                                  {
                                      actualConversionRateValueRemainingP= returnConversionRate(String.valueOf(actualYearremaining) , 'Q1' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPP= returnConversionRate(String.valueOf(actualYearremaining-1) , 'Q4' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPPP= returnConversionRate(String.valueOf(actualYearremaining-1) , 'Q3' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                                  }
                                  if(actualQuarterremaining== 'Q1')
                                  {
                                      actualConversionRateValueRemainingP= returnConversionRate(String.valueOf(actualYearremaining-1) , 'Q4' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPP= returnConversionRate(String.valueOf(actualYearremaining-1) , 'Q3' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;
                                      actualConversionRateValueRemainingPPP= returnConversionRate(String.valueOf(actualYearremaining-1) , 'Q2' , benifit.Improvement_Measure_KPI__c ,  benifit.Selected_Business_Line__c) ;                  
                                  }
                                  
                                  IF(actualConversionRateValueRemainingP != 0.0 && actualConversionRateValueRemainingPP == 0.0 &&  actualConversionRateValueRemainingPPP == 0.0 )
                                      actualConversionRateValueRemaining = actualConversionRateValueRemainingP ;
                                  else if(actualConversionRateValueRemainingP == 0.0 && actualConversionRateValueRemainingPP != 0.0 &&  actualConversionRateValueRemainingPPP == 0.0 )    
                                      actualConversionRateValueRemaining = actualConversionRateValueRemainingPP;
                                  else if(actualConversionRateValueRemainingP == 0.0 && actualConversionRateValueRemainingPP == 0.0 &&  actualConversionRateValueRemainingPPP != 0.0 )    
                                      actualConversionRateValueRemaining = actualConversionRateValueRemainingPPP ;
                                  else if(actualConversionRateValueRemainingP != 0.0 && actualConversionRateValueRemainingPP != 0.0 &&  actualConversionRateValueRemainingPPP != 0.0 )    
                                      actualConversionRateValueRemaining  = actualConversionRateValueRemainingP ;
                                  else if(actualConversionRateValueRemainingP == 0.0 && actualConversionRateValueRemainingPP != 0.0 &&  actualConversionRateValueRemainingPPP != 0.0 )    
                                      actualConversionRateValueRemaining = actualConversionRateValueRemainingPP ;
                                  else if(actualConversionRateValueRemainingP != 0.0 && actualConversionRateValueRemainingPP != 0.0 &&  actualConversionRateValueRemainingPPP == 0.0 )    
                                      actualConversionRateValueRemaining  = actualConversionRateValueRemainingP ;
                                  else if(actualConversionRateValueRemainingP != 0.0 && actualConversionRateValueRemainingPP == 0.0 &&  actualConversionRateValueRemainingPPP != 0.0 )    
                                      actualConversionRateValueRemaining = actualConversionRateValueRemainingP ;   
                                  else
                                      actualConversionRateValueRemaining = 0.0; 
                              }
                              benifit.Future_Conversion_Rate__c = actualConversionRateValueRemaining ;
                              System.Debug('********* benifit.Future_Conversion_Rate__c **************** ' + benifit.Future_Conversion_Rate__c);
                        }         

                        if(benifit.Directional_Indicator__c != null && benifit.Directional_Indicator__c == 'Lower is Favorable' && benifit.Directional_Indicator__c != null)
                         {
                             if(actualConversionRateValueRemaining != null && benifit.Baseline_Rate_N__c != null && benifit.Future_Rate__c != null && benifit.Benefit_Type__c != 'Operational Savings')
                             {
                                Decimal val =  (benifit.Baseline_Rate_N__c-benifit.Future_Rate__c)*(benifit.Future_Benefit_Period_Weeks__c)*actualConversionRateValueRemaining;
                                benifit.Future_Financial_Automatic_Amount__c =   val.setScale(0, RoundingMode.HALF_UP);                          
                                benifit.Future_Operational_Automatic_Amount__c  = null;
                             }
                             else if(actualConversionRateValueRemaining != null && benifit.Baseline_Rate_N__c != null && benifit.Future_Rate__c != null && benifit.Benefit_Type__c == 'Operational Savings')
                             {
                                Decimal val =  (benifit.Baseline_Rate_N__c-benifit.Future_Rate__c)*(benifit.Future_Benefit_Period_Weeks__c)*actualConversionRateValueRemaining;
                                benifit.Future_Operational_Automatic_Amount__c  =   val.setScale(0, RoundingMode.HALF_UP);                          
                                benifit.Future_Financial_Automatic_Amount__c = null; 
                             }                            
                         }
                       else if(benifit.Directional_Indicator__c != null && benifit.Directional_Indicator__c == 'Higher is Favorable'  && benifit.Directional_Indicator__c != null)    
                        {
                            if(actualConversionRateValueRemaining != null && benifit.Baseline_Rate_N__c != null && benifit.Future_Rate__c != null && benifit.Benefit_Type__c != 'Operational Savings') 
                            {
                                Decimal val =  (benifit.Future_Rate__c-benifit.Baseline_Rate_N__c)*(benifit.Future_Benefit_Period_Weeks__c)*actualConversionRateValueRemaining;
                                benifit.Future_Financial_Automatic_Amount__c =   val.setScale(0, RoundingMode.HALF_UP);                            
                                benifit.Future_Operational_Automatic_Amount__c  = null;
                            }
                            else if(actualConversionRateValueRemaining != null && benifit.Baseline_Rate_N__c != null && benifit.Future_Rate__c != null && benifit.Benefit_Type__c == 'Operational Savings') 
                            {
                                Decimal val =  (benifit.Future_Rate__c-benifit.Baseline_Rate_N__c)*(benifit.Future_Benefit_Period_Weeks__c)*actualConversionRateValueRemaining;
                                benifit.Future_Operational_Automatic_Amount__c  =   val.setScale(0, RoundingMode.HALF_UP);                            
                                benifit.Future_Financial_Automatic_Amount__c = null;
                            }                            
                        }
                   
                        if(isManual == true)
                        {
                            benifit.Future_Operational_Automatic_Amount__c  = null;
                            benifit.Future_Financial_Automatic_Amount__c = null;
                        }
                        else
                        {
                            benifit.Future_Financial_Manual_Amount__c = null;
                            benifit.Future_Operational_Manual_Amount__c = null;
                        }
                        System.Debug('********* benifit.Future_Financial_Automatic_Amount__c  **************** ' + benifit.Future_Financial_Automatic_Amount__c );
                        System.Debug('********* benifit.Future_Financial_Manual_Amount__c **************** ' + benifit.Future_Financial_Manual_Amount__c);
                        System.Debug('********* benifit.Future_Operational_Automatic_Amount__c **************** ' + benifit.Future_Operational_Automatic_Amount__c);
                        System.Debug('********* benifit.Future_Operational_Manual_Amount__c **************** ' + benifit.Future_Operational_Manual_Amount__c);
                   
                      /******************************* FOR Future SECTION END**************************************/ 
                    
                   Decimal POA , POM , PFA , PFM  ; 
                           
                   if(benifit.Planned_Operational_Automatic_Amount__c == null)
                       POA = 0.0;
                   else
                       POA = benifit.Planned_Operational_Automatic_Amount__c;    
                   if(benifit.Planned_Financial_Automatic_Amount__c == null)
                       PFA = 0.0;
                   else
                       PFA = benifit.Planned_Financial_Automatic_Amount__c;
                   if(benifit.Planned_Operational_Manual_Amount__c == null)
                       POM = 0.0;
                   else
                       POM = benifit.Planned_Operational_Manual_Amount__c;   
                   if(benifit.Planned_Financial_Manual_Amount__c == null)
                       PFM = 0.0;
                   else
                       PFM = benifit.Planned_Financial_Manual_Amount__c;
                           
                   benifit.Planned_Financial_Savings_Total__c =  PFA + PFM ;
                   benifit.Planned_Operational_Savings_Total__c = POA + POM ;

                   Decimal AOA , AOM , AFA , AFM ;

                   if(benifit.Achieved_Operational_Automatic_Amount__c == null)
                       AOA = 0.0;
                   else
                       AOA = benifit.Achieved_Operational_Automatic_Amount__c;    
                   if(benifit.Achieved_Financial_Automatic_Amount__c == null)
                       AFA = 0.0;
                   else
                       AFA = benifit.Achieved_Financial_Automatic_Amount__c;    
                   if(benifit.Achieved_Operational_Manual_Amount__c == null)
                       AOM = 0.0;
                   else
                       AOM = benifit.Achieved_Operational_Manual_Amount__c;     
                   if(benifit.Achieved_Financial_Manual_Amount__c == null)
                       AFM = 0.0;
                   else
                       AFM = benifit.Achieved_Financial_Manual_Amount__c ;  
                         
                   benifit.Achieved_Financial_Savings_Total__c = AFA + AFM;
                   benifit.Achieved_Operational_Savings_Total__c = AOA + AOM;
                   
                    System.Debug('************** benifit.Achieved_Financial_Savings_Total__c ****************** ' + benifit.Achieved_Financial_Savings_Total__c);
                    System.Debug('************** benifit.Achieved_Operational_Savings_Total__c ****************** ' + benifit.Achieved_Operational_Savings_Total__c);
                    
                   Decimal  FFA , FFM , FOA , FOM ; 

                   if(benifit.Future_Operational_Automatic_Amount__c == null)
                      FOA = 0.0;
                   else
                      FOA = benifit.Future_Operational_Automatic_Amount__c;    
                   if(benifit.Future_Financial_Automatic_Amount__c == null)
                       FFA = 0.0;
                   else
                       FFA = benifit.Future_Financial_Automatic_Amount__c;    
                   if(benifit.Future_Operational_Manual_Amount__c == null)
                       FOM = 0.0;
                   else
                       FOM = benifit.Future_Operational_Manual_Amount__c;
                   if(benifit.Future_Financial_Manual_Amount__c == null)
                       FFM = 0.0;
                   else
                       FFM = benifit.Future_Financial_Manual_Amount__c;    
                       
                   benifit.Future_Financial_Savings_Total__c = FFA  + FFM;
                   benifit.Future_Operational_Savings_Total__c = FOM + FOA;

                   benifit.Benefit_Amount_Achieved_Future_k__c = benifit.Achieved_Financial_Savings_Total__c + benifit.Future_Financial_Savings_Total__c ;    
                   benifit.Benefit_Operational_Achieved_Future_k__c = benifit.Achieved_Operational_Savings_Total__c + benifit.Future_Operational_Savings_Total__c;
                   
                   
                   upsert benifit;
                   
                  System.Debug('************** benifit ****************** ' + benifit);

                  //******* Starting Upsert and Delete conditions**For** Benefit Reporting Object(Benefit line Item)**
                   // System.Debug('************** PIcklistyear ****************** ' + Bn_rep_AddList[0].Years__c);
                   
                    list<QIPP_BU_Reporting__c> MultiBenrep = new list<QIPP_BU_Reporting__c>();
                    
                    list<QIPP_BU_Reporting__c> MultiBendel = new list<QIPP_BU_Reporting__c>();
                  
                    For( QIPP_BU_Reporting__c Bendel:Bn_rep_DelList) 
                    {    
                        QIPP_BU_Reporting__c testdel = new QIPP_BU_Reporting__c();
                        If(Bendel.id != null)
                        {
                            testdel.id =Bendel.id;
                            MultiBendel.add(testdel);
                        }

                    }
                    
                    System.Debug('*************** benifit.Improvement_Measure_Name__c*************** ' + benifit.Improvement_Measure_Name__c);
                    
                    System.Debug('*********************** con ********************** ' + con[0].Name);
                    
                    System.Debug('************* Improvement_Measure_KPI__c ********** ' + benifit.Improvement_Measure_KPI__c);
                    
                    System.Debug('************* Improvement_Measure_KPI__c 2********** ' + benifit.Improvement_Measure_KPI__r.name);
                    
                    if(Bn_rep_AddList != null || Bn_rep_AddList.size() > 0)
                    {
                        For( QIPP_BU_Reporting__c Benrep:Bn_rep_AddList) 
                        {    
                            QIPP_BU_Reporting__c test = new QIPP_BU_Reporting__c();
                            

                            if (Benrep.Benefit_Condition__c != null && Benrep.Years__c != null && Benrep.Quarters__c != null && Benrep.Benefit_Savings_Amount__c != null)
                            {
                                If(Benrep.id != null)
                                {
                                    test.id =Benrep.id;
                                }else{
                                    string initialhistorytrack;
                                    if(Benrep.Months__c != null   ){
                                        initialhistorytrack = Benrep.Quarters__c+' '+':'+' '+Benrep.Months__c+' '+':'+' '+Benrep.Years__c+' '+':'+' '+Benrep.Benefit_Condition__c+' '+'amount'+' '+Benrep.Benefit_Savings_Amount__c;
                                    }else{
                                        initialhistorytrack = Benrep.Quarters__c+' '+':'+' '+Benrep.Years__c+' '+':'+' '+Benrep.Benefit_Condition__c+' '+'amount'+' '+Benrep.Benefit_Savings_Amount__c;
                                    }
                                    test.History_Tracking_For_Initial_Line_Items__c = initialhistorytrack;
                                }
                                system.debug('Improvement_Measure_KPI__r.name::::'+benifit.Improvement_Measure_KPI__r.name);
                                test.Project_ID__c=projectid;
                                test.Project_Number__c = projectinfo.Project_Number__c;
                                test.Project_Name__c = projectinfo.Project_Name_Succinct__c;
                                test.Benefit_ID__c=benifit.id;
                                test.Improvement_Measure__c = benifit.Improvement_Measure_Name__c;
                                test.Benefit_Condition__c=Benrep.Benefit_Condition__c;
                                test.Years__c=Benrep.Years__c;
                                test.Quarters__c=Benrep.Quarters__c;
                                test.Months__c=Benrep.Months__c;
                                test.Benefit_Savings_Amount__c=Benrep.Benefit_Savings_Amount__c;
                                test.Benefit_Type__c = benifit.Benefit_Type__c;
                                test.Year__c = Benrep.Years__c;
                                test.Quarter__c = Benrep.Quarters__c;
                                test.Month__c = Benrep.Months__c;
                                test.DI3DI5_Flag__c = 'True';
                                test.Entry_Type__c ='User Entry';
                                
                                test.QIPP_Project_ID__c = projectinfo.name;
                                //test.Benefitting_BU__c = projectinfo.Portfolio_BU__c;
                                test.Benefitting_BL__c = projectinfo.Project_BL__c;
                                test.Benefit_Phase__c = Benrep.Benefit_Condition__c;
                                test.CoPQ_Type__c = benifit.Financial_Type__c;
                                test.Portfolio_Name__c = projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c ;
                                test.Benefitting_Project_BL_Level_4_Org__c = projectinfo.Benefitting_Project_BL_Level_4_Org__c;
                                test.Project_Lead_BL_Level_3_Org__c = projectinfo.Project_Lead_Business_Unit__c ;
                                test.Project_Lead_BL_Level_4_Org__c = projectinfo.Project_Lead_Business_Line__c ;
                                test.Project_Lead_BU__c = projectinfo.Project_Lead_Business_Grp__c;                                
                                /*
                                test.Project_Lead_BL_Level_3_Org__c = projectinfo.Project_Lead_BL_Level_3_Org__c ;
                                test.Project_Lead_BL_Level_4_Org__c = projectinfo.Project_Lead_BL_Level_4_Org__c ;
                                test.Project_Lead_BU__c = projectinfo.Project_Lead_BU__c;
                                */
                                test.DI_State__c = projectinfo.DI_State__c;
                                test.QI_Methodology__c = projectinfo.Project_Type__c;
                                //test.Business_Line__c = benefit.Business_Line__c ;
                                test.Belt_Project_Type__c = projectinfo.Belt_Project_Type__c;

                                if(Benrep.Benefit_Condition__c == 'Planned'){
                                    test.Improvment_Amount__c = string.valueof(Benrep.Benefit_Savings_Amount__c);
                                    test.Achieved_Amount__c = '0.0';
                                    test.Future_Saving_Amount__c = '0.0';
                                    }
                                if(Benrep.Benefit_Condition__c == 'Achieved'){
                                    test.Achieved_Amount__c = string.valueof(Benrep.Benefit_Savings_Amount__c);
                                    test.Improvment_Amount__c = '0.0';
                                    test.Future_Saving_Amount__c = '0.0';
                                    }
                                if(Benrep.Benefit_Condition__c == 'Future'){
                                    test.Future_Saving_Amount__c = string.valueof(Benrep.Benefit_Savings_Amount__c);
                                    test.Improvment_Amount__c = '0.0';
                                    test.Achieved_Amount__c = '0.0';
                                    }
                                string historytrack;
                                if(Benrep.Months__c != null   ){
                                    historytrack = Benrep.Quarters__c+' '+':'+' '+Benrep.Months__c+' '+':'+' '+Benrep.Years__c+' '+':'+' '+Benrep.Benefit_Condition__c+' '+'amount'+' '+Benrep.Benefit_Savings_Amount__c;
                                }else{
                                    historytrack = Benrep.Quarters__c+' '+':'+' '+Benrep.Years__c+' '+':'+' '+Benrep.Benefit_Condition__c+' '+'amount'+' '+Benrep.Benefit_Savings_Amount__c;
                                }
                                test.History_Tracking_For_Line_Items__c = historytrack;
                                
                                MultiBenrep.add(test);
                            }
                           
                        }

                    }
                    
                    if(MultiBendel != null || MultiBendel.size() > 0)
                    {
                        Delete MultiBendel;
                        Bn_rep_DelList.clear();                
                    }
                    
                    if(MultiBenrep != null || MultiBenrep.size() > 0)
                    {
                        Upsert MultiBenrep;
                    }
                //********** Ending Upsert and Delete conditions**For** Benefit Reporting Object********
            obj = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+benifit.Id) ;        
            System.Debug('************** benifit.Id ****************** ' + benifit.Id);
                
            //start::View Page Calculations
            if(MultiBenrep.size() > 0 )
            {
            System.Debug('*********MultiBenrep*********' + MultiBenrep);   
            PlannedAmount = 0.0;
            AchievedAmount = 0.0;
            FutureAmount = 0.0;    
            for(QIPP_BU_Reporting__c benlineItems:MultiBenrep){
                    if(benlineItems.Benefit_Condition__c == 'Planned'){
                        PlannedAmount = PlannedAmount + benlineItems.Benefit_Savings_Amount__c;
            System.Debug('*********PlannedAmount111**********' + PlannedAmount);}                           
                    if(benlineItems.Benefit_Condition__c == 'Achieved'){
                        AchievedAmount = AchievedAmount + benlineItems.Benefit_Savings_Amount__c;
            System.Debug('*********AchievedAmount111**********' + AchievedAmount);}                           
                    if(benlineItems.Benefit_Condition__c == 'Future'){
                        FutureAmount = FutureAmount + benlineItems.Benefit_Savings_Amount__c;
            System.Debug('*********FutureAmount111**********' + FutureAmount);}                           
                }
            if(benifit.Benefit_Type__c == 'Financial Savings'){    
            benifit.Planned_Financial_Savings_Total__c =  PlannedAmount;
            benifit.Achieved_Financial_Savings_Total__c = AchievedAmount;   
            benifit.Future_Financial_Savings_Total__c = FutureAmount;
            benifit.Benefit_Amount_Achieved_Future_k__c = AchievedAmount + FutureAmount;
            }    
            if(benifit.Benefit_Type__c == 'Operational Savings'){    
            benifit.Planned_Operational_Savings_Total__c =  PlannedAmount;
            benifit.Achieved_Operational_Savings_Total__c = AchievedAmount;   
            benifit.Future_Operational_Savings_Total__c = FutureAmount;
            benifit.Benefit_Operational_Achieved_Future_k__c = AchievedAmount + FutureAmount;
            }                                
            }
            upsert benifit;                
            //end::View Page Calculations
            //totalamountvalidation = toatlcheck + AchievedAmount +FutureAmount;
            //currentbenifitamount = PlannedAmount + AchievedAmount +FutureAmount;
            //pageredirect = true;
             
           }
           
        }
        catch(Exception exe)
        {
           System.Debug('************** inside Catch ****************** ' + exe.getLineNumber());
           System.Debug('************** inside Catch ****************** ' + exe.getMessage());
        }   
        return obj ;
    }
    
    public PageReference deletebenifit()
    {
        delete benifit;
        PageReference obj = null;
        if(isDirectedFromView  == true)
          obj  = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);        
        else
          obj = new PageReference('https://cs41.salesforce.com/'+projectid);
        return obj ;
    }
    
    public PageReference cancel()
    {
       PageReference obj = null;
        if(isDirectedFromView  == true)
          obj  = new PageReference('/apex/QIPP_Benefit_View?fm='+benifit.Project_ID__c);        
        else
          obj = new PageReference('https://cs41.salesforce.com/'+projectid);
        return obj ;
    }
    
    public PageReference getBusinesslinelist()
    {
        if(benifit.Benefit_Override_Status__c != 'Awaiting Approval')
        {
                isManual = false;
                isOperational = false;
                benifit.Benefit_Type__c = null;
                benifit.Financial_Type__c = null;
                benifit.Unit_of_Measure__c = null;
                benifit.Directional_Indicator__c = null;
                benifit.Business_Line__c = null;
                
                con = [select Name , Id  , Impacted_P_L_Line__c , Monetization_Calculation_Method__c , Directional_Indicator__c , Benefit_Type__c,Improvement_Measure_Grouping__c, CoPQ_Type__c ,Brief_Description__c,  Unit_of_Measure__c from QIPP_Benefit_Conversion_Table__c
                                                    where Id  =: benifit.Improvement_Measure_KPI__c];
                
                BusinessLineFromConversionRate = new List<QIPP_Benefit_Conversion_Rate__c>();
                
                try
                {
                BusinessLineFromConversionRate = [select Business_Line__c from QIPP_Benefit_Conversion_Rate__c where Improvement_Measure__c =: benifit.Improvement_Measure_KPI__c];
                
                if(BusinessLineFromConversionRate != null && BusinessLineFromConversionRate.size() > 0)
                    strBusinessLineFromConversionRate = BusinessLineFromConversionRate[0].Business_Line__c ;
                 
                else
                    strBusinessLineFromConversionRate = 'N/A';
                }
                catch(Exception exe)
                {
                    System.debug('***************** Exception Ocuured @ ' + exe.getLineNumber() );
                    System.debug('***************** Exception Ocuured caused ' + exe.getMessage() );
                    strBusinessLineFromConversionRate = 'N/A';
                }
                if(con.size() > 0 ){
                    ImprovementName = con[0].Name;
                }
                    
                   if(con.size() > 0 )
                      {
                        if(con[0].Benefit_Type__c == 'Operational Savings')
                        {
                           Benefit_Type = 'Operational Savings';
                           //TypeOfPlannedSaving =  'Planned Operational Savings';
                           //TypeOfAchievedSaving =  'Achieved Operational Savings';
                           //TypeOfFutureSaving =  'Future Operational Savings';    
                        }   
                        else
                        {
                            Benefit_Type = 'Financial Savings';
                            //TypeOfPlannedSaving =  'Planned Financial Savings';
                            //TypeOfAchievedSaving =  'Achieved Financial Savings';
                            //TypeOfFutureSaving =    'Future Financial Savings';  
                        }
                        TypeOfPlannedSaving =  'Planned';
                        TypeOfAchievedSaving =  'Achieved';
                        TypeOfFutureSaving =    'Future';     
                        
                        if(con[0].Monetization_Calculation_Method__c == 'Manual')
                            isManual = true;
                        else 
                            isManual = false;
                        IMPDescription = con[0].Brief_Description__c;
                        benifit.Benefit_Type__c = con[0].Benefit_Type__c;
                        benifit.Improvement_Measure_Grouping__c = con[0].Improvement_Measure_Grouping__c;
                        benifit.Financial_Type__c = con[0].CoPQ_Type__c;
                        benifit.Unit_of_Measure__c = con[0].Unit_of_Measure__c;
                        benifit.Directional_Indicator__c = con[0].Directional_Indicator__c;
                        benifit.Impacted_P_L_Line__c = con[0].Impacted_P_L_Line__c ;
                       }
                        else
                        {
                            isManual = false;
                            isOperational = false;
                            benifit.Benefit_Type__c = null;
                            benifit.Improvement_Measure_Grouping__c = null;
                            benifit.Financial_Type__c = null;
                            benifit.Unit_of_Measure__c = null;
                            benifit.Directional_Indicator__c = null;
                            //benifit.Business_Line__c = null;
                            benifit.Impacted_P_L_Line__c = null ;
                            benifit.Business_Line__c = null;
                        }
             
                if(con.size() > 0 ){
                    benifit.Improvement_Measure_Name__c =  con[0].Name;
                }
                
               System.Debug('*************** benifit.Improvement_Measure_Name__c*************** ' + benifit.Improvement_Measure_Name__c);
               //System.Debug('***************** con[0].Monetization_Calculation_Method__c ************  ' + con[0].Monetization_Calculation_Method__c );
               //System.Debug('***************** con[0].Benefit_Type__c ****************  ' +con[0].Benefit_Type__c );
                conversionTableLink();
                getBusinessLine();
                return null;
        }
        else{
             ApexPages.Message overrideMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Improvement Measure cannot be changed since benefit override stage in Awaiting Approval.');
             ApexPages.addMessage(overrideMsg); 
             return null; 
        }                     
    }
    

    public PageReference  getBusinessLine() 
    {
        statusOptions = new list<SelectOption>();
        List<QIPP_Benefit_Conversion_Rate__c> businesslist = [SELECT  Business_Line__c FROM QIPP_Benefit_Conversion_Rate__c WHERE Improvement_Measure__c =: benifit.Improvement_Measure_KPI__c ];
        Set<String> setBusinessLine = new Set<String>();
        
        for(QIPP_Benefit_Conversion_Rate__c BL : businesslist )
        {
            setBusinessLine.add(BL.Business_Line__c);
        }

        IF(setBusinessLine.SIZE() > 0 && setBusinessLine != NULL &&  hideedit == false)
        {    
            System.Debug('************** in side if ***************** ');
            statusOptions.add(new selectOption('-Select-','-Select-'));
            for (String business1 : setBusinessLine ) 
            { 
                statusOptions.add(new selectOption(business1,business1));
            }
         }
         else IF(setBusinessLine.SIZE() != null && setBusinessLine.SIZE() > 0 &&  hideedit == true)
         {
            System.Debug('************** in side else if 1***************** ');
            try
            { 
                statusOptions.add(new selectOption(benifit.Selected_Business_Line__c,benifit.Selected_Business_Line__c));
            }
            catch(Exception exe)
            {
                
            }
            statusOptions.add(new selectOption('-Select-','-Select-'));    
            for (String business1 : setBusinessLine ) 
            { 
                    statusOptions.add(new selectOption(business1,business1));
            }
         }
        
         else IF(setBusinessLine.SIZE() == 0 && setBusinessLine.SIZE() != NULL) // &&  hideedit == false
         {
             System.Debug('************** in side else if 2***************** ');
             statusOptions.add(new selectOption('-Select-','-Select-'));
             statusOptions.add(new selectOption('N/A','N/A'));
             benifit.Selected_Business_Line__c = 'N/A';
         }
         
         
         System.Debug('*************** SelectedValue  ******************' + SelectedValue );
        
         if(SelectedValue == '-Select-')
         {
             //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select correct Business Line'));
             //flag =true; 
         }    
         else
         {
             benifit.Selected_Business_Line__c = SelectedValue;
             flag =false;
         }
        
        
            benifit.Selected_Business_Line__c = SelectedValue;
        
        
       return null;
    }
    
     public PageReference conversionTableLink()
    {
        if(con.size() > 0 && con[0].Id != null)
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
    
    public Decimal returnConversionRate(String Year , String Quarter , String Measures , String BusinessLine)
    {
         System.Debug('************In returnConversionRate function Year  ************' + Year );
         System.Debug('************In returnConversionRate function Quarter ************' + Quarter );
         System.Debug('************In returnConversionRate function Measures ************' + Measures );
         System.Debug('************In returnConversionRate function BusinessLine ************'+ BusinessLine);

         
         QIPP_Benefit_Conversion_Rate__c rate = null;
         Decimal conversionrate = 0.0;
         try
         {
            rate = [select Improvement_Measure__c , Conversion_Rate__c from QIPP_Benefit_Conversion_Rate__c where Fiscal_Year__c =: Year and Fiscal_Quarter__c =: Quarter and Improvement_Measure__c =: Measures and Business_Line__c =: BusinessLine];
            conversionrate = rate.Conversion_Rate__c;
         }
         catch(QueryException exe)
         {
                            conversionrate = 0.0;
                            ApexPages.Message myMsg5 = new ApexPages.Message(ApexPages.Severity.ERROR,'Error. Conversion Rate is not present for added fiscal quarter');
                            ApexPages.addMessage(myMsg5);        
                            System.Debug('************************ QueryException ***************** ' + exe.getMessage());
         } 
         catch(Exception exe)
         {
                            conversionrate = 0.0;                             
                            ApexPages.Message myMsg6 = new ApexPages.Message(ApexPages.Severity.ERROR,'Some Error Occured');
                            ApexPages.addMessage(myMsg6);  
                            System.Debug('************************ QueryException ***************** ' + exe.getMessage());      
         }
         System.Debug('************In returnConversionRate function conversionrate ************'+ conversionrate );
         return conversionrate ;    
                                                                    
    }
    public PageReference GoBackToSearch()
    {
       PageReference obj = null;
       obj = new PageReference('/apex/QIPP_Benefit_lookup_Page?'+projectid);
       //obj = new PageReference('/apex/QIPP_Benefit_View?'+projectid);
       return obj ;
    }  
    
}

/* 


*/