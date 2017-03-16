/*
    Class/Triger Name : QIPPBenefit
    Test Class Name   : 
    Author            : Haripriya Maturi
    Created Date      : 28.JUL.2016 
    Purpose/Overview  : 
                ********************************************************************************************************************         
                01) Create/updateing Benefit...
                02) 
                ********************************************************************************************************************  
    Change History    : 
                ********************************************************************************************************************         
                SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
                ********************************************************************************************************************  
                01  : 28.JUL.2016   :  Haripriya Maturi        :   Class Created  : To redesign the benefits page
                02  :  
                03  : 
    Notes :
                ********************************************************************************************************************         
                01) 
                02)
*/
public with sharing class QIPPBenefit
{
   // public static boolean isFired = false;
    public QIPP_Benefit__c benifit {get;set;}
    public List<QIPP_Benefit__c> listOfBenefitsOfProject{get;set;}
    public List<QIPP_Benefit__c> listOfBenefitsOfProject_exceptThis{get;set;}
    public boolean ConversionIDFound {get;set;}
    public decimal totalsavings{Set;get;}
    public decimal totalamountvalidation{Set;get;}
    public decimal currentbenifitamount{Set;get;}
    public boolean errorflag{set;get;}
    public boolean pageredirect{set;get;}
    public String targetField { get; set; }
    
    public Boolean DI3DI5rule1{get;set;}
    public Boolean DI3DI5rule2{get;set;} 
    public Boolean callBusinesslinelist;
    public integer pcount1 = 0;
    public integer afcount1 = 0;
    public integer pcount2 = 0;
    public integer afcount2 = 0;
    
    public QIPP_Project__c projectinfo{get;set;}
    public boolean hideedit {get;set;}
    public String projectid{get;set;}
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
    public boolean displayPopupBBG{get; set;}
    public boolean displayPopupBAM{get; set;}
    public boolean displayhighimpactPopupBAM {get; set;}
    public boolean displayPopupBenf{get;set;}
    public boolean displayPopupviewBenf{get;set;}
    public boolean displayPopupBenfOverview{get;set;}
    public boolean displayPopupeditBenf{get;set;}
    public String benefitid{get;set;}
    public QIPP_Benefit__c benifit2 {get;set;}
    public QIPP_Project__c bbgvalamount {get;set;}
    public decimal  bbgopvalamount{get;set;}
    public decimal  bbgfivalamount{get;set;} 
    public decimal  bbgprvalamount{get;set;}
    public decimal  bbgrelvalamount{get;set;}
    public List<String> listOfStrings {get; set;}
    public String textdata{get;set;}
    public decimal  pltotal{get;set;}
    public decimal  achietotal{get;set;}
    public decimal  fututotal{get;set;}
    public businessActivityMapping BAMObj;
    
    
    public List<String> listOfUoM{get;set;}
    public String UoMeasure{get;set;}
    public String UoMeasureEdit{get;set;}
    
    public List<QIPP_BU_Reporting__c> Bn_rep_AddList {get;set;}
     public List<QIPP_BU_Reporting__c> Bn_rep_AddList1 {get;set;}
    public List<QIPP_BU_Reporting__c> Bn_rep_DelList;
    
    public List<QIPP_Project__c> projBGList{get;set;} // need to remove this declaration
    
    public List<QIPP_Project__c> activityList{get;set;}//activityList is used to store the business activity which is mapped to the project in alist format
    public List<Business_Activity__c> bamDetails{get;set;}//bamDetails is to store the business activity mapping details for the project in a list format based on activityList
    public String activity{get;set;}//activity is used to store the activity name of the project
    public String valueStream{get;set;}//valueStream is used to store the value stream of the activity
    public String businessFunction{get;set;}//businessFunction is used to store business Function of the activity
    
    public List<QIPP_Project__c> projBBGAddList{get;set;}
    public List<QIPP_Project__c> projBBGDelList{get;set;}
    public Integer bgRowNum {get;set;}
    
    public string str{get;set;}
    public Integer rowNum  {Set;get;}
    public Integer index{get;set;}
    
    public Decimal PlannedAmount;
    public Decimal AchievedAmount;
    public Decimal FutureAmount;
    
    public Id projectMeasureId{get;set;}
    
    public QIPP_Benefit_Conversion_Table__c impMeasure{get;set;}
    
    Map<String,String> hMapMonth;
    Map<String,String> impMeasureBenefitTypeMap;
    Map<String,String> impMeasureBenefitTypeMap_exceptThis;
    Map<String,String> idMap;
    
    public boolean createNewImprovementMeasure;
    public String impMeasUoMeasure{get;set;}
    public String impMeasureDescription{get;set;}
    public String regexFormatForImpMeasureDescription{get;set;}
    public String impMeasureError{get;set;}
    public static boolean insertWhenchanged;//added for trigger benefitreportnew
    public String getimpMeasureDescription(){
    
        return impMeasureDescription;
    }
 
    public void setimpMeasureDescription(String impMeasureDescription){
        this.impMeasureDescription = impMeasureDescription;
    }
    
    
    public String impBenefitType{get;set;}
    {
        impBenefitType='Financial Savings';
        }
    

    public String getimpBenefitType(){
    
        return impBenefitType;
    }
 
    public void setimpBenefitType(String impBenefitType){
        this.impBenefitType = impBenefitType;
    }
    //public List<HeaderList> projectMeasureHeaderList{get;set;}
    //public List<VerticalHeaderList> projectMeasureVerticalHeaderList{get;set;}
    public boolean projectErrorMessages{get;set;}
    public boolean benifitsErrorMessages{get;set;}
    public boolean editBenifitsErrorMessages{get;set;}
    public boolean benefitSaveButton{get;set;}
    public boolean errorChecked{get;set;}
    public boolean isDisabled{get;set;}
    public PageReference redirectUrl{get;set;}
    public string imp_bentype;
    public list<QIPP_BU_Reporting__c> MultiBenrep;
    public boolean atleastOneRow;
    public List<QIPP_BU_Reporting__c> benefitTotalsList{get;set;}
    public String benYear{get;set;}
    
    public QIPPBenefit(ApexPages.StandardController controller) 
    {   
        Bn_rep_AddList= new List<QIPP_BU_Reporting__c>();
        Bn_rep_DelList= new List<QIPP_BU_Reporting__c>();
        
        projectErrorMessages=true;
        benifitsErrorMessages=false;
        editBenifitsErrorMessages=false;
        listOfStrings = new List<String>();
        listOfUoM = new List<String>();
        
        //-- R17.3 E061 - start --//
        /*
        //List<QIPP_Benefit_Conversion_Table__c> query =[SELECT id, Name From QIPP_Benefit_Conversion_Table__c ];  commented by Haripriya 
        List<QIPP_Benefit__c> query = [Select Id, Name, Improvement_Measure_Name__c,Unit_of_Measure__c  from QIPP_Benefit__c order by LastModifiedDate desc];
        for(QIPP_Benefit__c a: query)
        {
        listOfStrings.add(a.Improvement_Measure_Name__c);
        listOfUoM.add(a.Unit_of_Measure__c);
        }
        */
        
        List<QIPP_Benefit_Conversion_Table__c> query = [Select Id, Name, Benefit_Type__c, Unit_of_Measure__c, Brief_Description__c,Active__c from QIPP_Benefit_Conversion_Table__c Where Active__c = true Order By LastModifiedDate desc];
        for(QIPP_Benefit_Conversion_Table__c a: query){
            listOfStrings.add(a.Name);
            listOfUoM.add(a.Unit_of_Measure__c);
        }
        //-- R17.3 E061 - end --//
        
        projectid = ApexPages.currentPage().getParameters().get('id');
        //benefitid = ApexPages.currentPage().getParameters().get('detailpage');
        benefitid = Apexpages.currentpage().getparameters().get('benefitid');
        impMeasureBenefitTypeMap = new Map<String,String>();
        impMeasureBenefitTypeMap_exceptThis = new Map<String,String>();
        idMap = new Map<String,String>();
        
        projBBGAddList = new List<QIPP_Project__c>();
        projBBGDelList = new List<QIPP_Project__c>();

        try{
        projBBGAddList = [SELECT Id, Name, Project_Number__c,Portfolio_BU__c, Project_BL__c, Benefitting_Project_BL_Level_4_Org__c FROM QIPP_Project__c WHERE Id =: projectid];
        str = projBBGAddList[0].Project_Number__c ;
        if(projBBGAddList.size() > 0 )
            {
            bgRowNum= projBBGAddList.size();
            }
            else
            {
                projBBGAddList.add(new QIPP_Project__c(Id=projectid,Portfolio_BU__c='None', Project_BL__c='None', Benefitting_Project_BL_Level_4_Org__c='None'));
                bgRowNum=1;
            }
            
        }catch(Exception e){}
        BBGValidationamount();
    }

    //getYearValues method to get the picklist values for Years__c for Benefit line items, to maintain the year list for + or – 3 from current year always, as per Business request.
    public List<SelectOption> getYearValues(){
    try{
        List<SelectOption> year_optns = new List<Selectoption>();
        Schema.DescribeFieldResult fieldResult = QIPP_BU_Reporting__c.Years__c.getDescribe();
        List<Schema.PicklistEntry> mc = fieldResult.getPicklistValues();

           Integer currYear = Date.Today().Year();
           Integer back1year = currYear - 1;
           Integer back2years = currYear - 2;
           Integer back3years = currYear - 3;
           Integer back4years = currYear - 4;
           Integer back5years = currYear - 5;
           
           Integer front1year = currYear + 1;
           Integer front2years = currYear + 2;
           Integer front3years = currYear + 3;
           Integer front4years = currYear + 4;
           Integer front5years = currYear + 5;
           
           year_optns.add(new SelectOption('--None--','--None--'));
           for( Schema.PicklistEntry f : mc)
           {
              if( Integer.valueOf(f.getValue()) == back1year || Integer.valueOf(f.getValue()) == back2years || Integer.valueOf(f.getValue()) == back3years || Integer.valueOf(f.getValue()) == back4years || Integer.valueOf(f.getValue()) == back5years || Integer.valueOf(f.getValue()) == curryear || Integer.valueOf(f.getValue()) == front1year || Integer.valueOf(f.getValue()) == front2years || Integer.valueOf(f.getValue()) == front3years || Integer.valueOf(f.getValue()) == front4years || Integer.valueOf(f.getValue()) == front5years){
                  year_optns.add(new SelectOption(f.getLabel(), f.getValue()));
              }
           }     
           return year_optns;
     }catch(Exception e){return null;}
    }

    public pageReference AddRow()
    {try{
        if(displayPopupBenf==true){
            atleastOneRow = false;
            Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_ID__c=benifit.id,Entry_Type__c ='User Entry'));
        }else if(displayPopupeditBenf==true){
            atleastOneRow = false;
            Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_ID__c=benefitid,Entry_Type__c ='User Entry'));
        }
     }catch(Exception e){}
        return null;
    }
    
    public pageReference delRow()
    {
        try{
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        //rowNum = index;
        Bn_rep_DelList.add(Bn_rep_AddList.get(rowNum));
        if(Bn_rep_AddList.size()>1){
            Bn_rep_AddList.remove(rowNum);
        }
        else{
            Bn_rep_AddList.remove(rowNum);
            atleastOneRow = true;           
        }
        }catch(Exception e){}
        return null;
    }    
    public void cloneRow()
    {
        try{
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));

        Integer year;
        String y;
        String q;
        Integer mnt = Integer.valueOf(Bn_rep_AddList[rowNum].Months__c)+1;
        String m;
        if(mnt<=9)
            m = '0'+String.valueOf(mnt);
        else
            m = String.valueOf(mnt);
        if(mnt > 12){
            year = Integer.valueOf(Bn_rep_AddList[rowNum].Years__c)+1;
            y = String.valueOf(year);
            m = '01';
        }else{
            y = Bn_rep_AddList[rowNum].Years__c;
        }
        if(1 >= mnt || mnt <= 3){
            q = 'Q1';
        }else if (4 >= mnt || mnt <= 6){
            q = 'Q2';
        }else if(7 >= mnt || mnt <= 9){
            q = 'Q3';
        }else if(10 >= mnt || mnt <= 12){
            q = 'Q4';
        }
        if(displayPopupBenf==true){
            Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_Condition__c=Bn_rep_AddList[rowNum].Benefit_Condition__c,Years__c=y,Quarters__c=q,Months__c=m,Benefits_Saving_Amount_Planned__c=Bn_rep_AddList[rowNum].Benefits_Saving_Amount_Planned__c,Benefits_Saving_Amount_Achieved__c=Bn_rep_AddList[rowNum].Benefits_Saving_Amount_Achieved__c,Benefit_Savings_Amount__c=Bn_rep_AddList[rowNum].Benefit_Savings_Amount__c,Benefit_ID__c=benifit.id,Entry_Type__c ='User Entry'));
        }else if(displayPopupeditBenf==true){
            Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_Condition__c=Bn_rep_AddList[rowNum].Benefit_Condition__c,Years__c=y,Quarters__c=q,Months__c=m,Benefits_Saving_Amount_Planned__c=Bn_rep_AddList[rowNum].Benefits_Saving_Amount_Planned__c,Benefits_Saving_Amount_Achieved__c=Bn_rep_AddList[rowNum].Benefits_Saving_Amount_Achieved__c,Benefit_Savings_Amount__c=Bn_rep_AddList[rowNum].Benefit_Savings_Amount__c,Benefit_ID__c=benefitid,Entry_Type__c ='User Entry'));
        }
        }catch(Exception e){}
    }

    public PageReference saveBenefit()
    {
        PageReference obj = null;
        pageredirect = false;
        totalamountvalidation = 0;
        currentbenifitamount =0;
        decimal toatlcheck = 0;
        impMeasureError = null;
        benifitsErrorMessages=false;
        editBenifitsErrorMessages=false;
        errorChecked = false;
        try{
            flag = false;
            // following code to create Improvement Measure - Haripriya - sep 6 2016
            system.debug('@@textdata:'+textdata+'--'+benifit.Improvement_Measure_Name__c);
            if(displayPopupeditBenf==true){
                textdata = benifit.Improvement_Measure_Name__c;
            }

            List<QIPP_Benefit_Conversion_Table__c> newIMPMeas = [SELECT id,Name,Brief_Description__c,Benefit_Type__c,Unit_of_Measure__c From QIPP_Benefit_Conversion_Table__c where name= :textdata];
            if(newIMPMeas.size()>0){
                projectMeasureId = newIMPMeas[0].id;
                createNewImprovementMeasure = false;
                impMeasure = newIMPMeas.get(0);        //-- E061 -- added --//
            }else{
                createNewImprovementMeasure = true;
                impMeasure = new QIPP_Benefit_Conversion_Table__c();    //-- E061 -- added --//
            }

            // Below code is to create new Improvement Measure
            if(createNewImprovementMeasure == true){
            	//-- R17.3 E061 -- Start --//
	            impMeasure.Name = textdata;
	            impMeasure.Brief_Description__c = benifit.ImprovementMeasure_Brief_Description__c;
                impMeasure.Benefit_Type__c = impBenefitType;
                impMeasure.Unit_of_Measure__c = UoMeasure;
	            insert impMeasure;
	            //-- R17.3 E061 -- End --//
                /*
                impMeasure = new QIPP_Benefit_Conversion_Table__c();
                impMeasure.Name = textdata;
                impMeasure.Brief_Description__c = benifit.ImprovementMeasure_Brief_Description__c;
                impMeasure.Benefit_Type__c = impBenefitType;
                impMeasure.Unit_of_Measure__c = UoMeasure;
                upsert impMeasure;
                system.debug('@@impMeasure:'+impMeasure);
                */
                /*if(displayPopupBenf==true){
                    if(textdata != null || textdata != '' || textdata != ' '){
                        regexFormatForImpMeasureDescription = '^[a-zA-Z0-9 \\\']*$';
                        Pattern descFormat = Pattern.Compile(regexFormatForImpMeasureDescription);
                        Matcher format_of_desc = descFormat.matcher(textdata);
                        System.Debug('impMeasure==='+textdata);
                        System.Debug('format_of_desc --'+format_of_desc);
                        System.Debug('format_of_desc.Matches() ==='+format_of_desc.Matches());
                        if (format_of_desc.Matches()){
                             upsert impMeasure;
                             projectMeasureId = impMeasure.Id;
                        } 
                        else{
                            impMeasureError = 'Improvement Measure: Special characters are not allowed.';
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,impMeasureError));
                            flag =true;
                            return null;
                        }
                    }
                }else if(displayPopupeditBenf==true){
                    if(benifit.Improvement_Measure_Name__c != null){
                        regexFormatForImpMeasureDescription = '^[a-zA-Z0-9 \\\']*$';
                        Pattern descFormat = Pattern.Compile(regexFormatForImpMeasureDescription);
                        Matcher format_of_desc = descFormat.matcher(benifit.Improvement_Measure_Name__c);
                        System.Debug('impMeasure==='+benifit.Improvement_Measure_Name__c);
                        System.Debug('format_of_desc --'+format_of_desc);
                        System.Debug('format_of_desc.Matches() ==='+format_of_desc.Matches());
                        if (!format_of_desc.Matches()){
                            impMeasureError = 'Improvement Measure: Special characters are not allowed.';
                            projectErrorMessages = false;
                            benifitsErrorMessages = false;
                            editBenifitsErrorMessages = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,impMeasureError));
                            flag =true;
                            return null;
                        }
                    }
                }*/
                
                //upsert impMeasure;
                
                // Below code is to map the improvement details with benefit
                
                projectMeasureId = impMeasure.Id;
                benifit.Improvement_Measure_Name__c = textdata; 
                if(displayPopupBenf==true){
                    benifit.ImprovementMeasure_Brief_Description__c = impMeasure.Brief_Description__c;
                }
                benifit.Benefit_Type__c = impMeasure.Benefit_Type__c;
                if(displayPopupBenf==true){
                    benifit.Unit_of_Measure__c = impMeasure.Unit_of_Measure__c;
                }
                UoMeasure = impMeasure.Unit_of_Measure__c;
            }
            if(displayPopupBenf==true){
                benifit.Benefit_Type__c = impBenefitType;
                UoMeasure = UoMeasure.replaceAll('\\s+',' ');
                benifit.Unit_of_Measure__c = UoMeasure;
            }else if(displayPopupeditBenf==true){
                impBenefitType = benifit.Benefit_Type__c;
                UoMeasureEdit = benifit.Unit_of_Measure__c;
                UoMeasureEdit = UoMeasureEdit.replaceAll('\\s+',' ');
                benifit.Unit_of_Measure__c = UoMeasureEdit;
                //System.Debug('benifit.Unit_of_Measure__c-------'+benifit.Unit_of_Measure__c);
            }
            //-- R17.3 E061 -- Start --//
			if(!createNewImprovementMeasure){
				system.debug('@@Benefit type:'+benifit.Benefit_Type__c+'-UOM-'+benifit.Unit_of_Measure__c+'-Descr-'+benifit.ImprovementMeasure_Brief_Description__c);
				//impMeasure.Name = textdata; 
				impMeasure.Brief_Description__c = benifit.ImprovementMeasure_Brief_Description__c;
				impMeasure.Benefit_Type__c = benifit.Benefit_Type__c;
				impMeasure.Unit_of_Measure__c = benifit.Unit_of_Measure__c;
				update impMeasure;
			}
			//-- R17.3 E061 -- End --//
            
            imp_bentype = benifit.Improvement_Measure_Name__c+benifit.Unit_of_Measure__c+benifit.Benefit_Type__c;
            
            listOfBenefitsOfProject = [select id, Improvement_Measure_Name__c, Unit_of_Measure__c, Benefit_Type__c from QIPP_Benefit__c where Project_ID__c =:projectid];
            if(listOfBenefitsOfProject.size()>0){
                for(QIPP_Benefit__c ben : listOfBenefitsOfProject){
                    //System.Debug('ben.Unit_of_Measure__c ------'+ben.Unit_of_Measure__c);
                    impMeasureBenefitTypeMap.put(ben.Improvement_Measure_Name__c+ben.Unit_of_Measure__c+ben.Benefit_Type__c,'0');
                    idMap.put(ben.Id,'0');
                }
            }
            
            listOfBenefitsOfProject_exceptThis = [select id, Improvement_Measure_Name__c, Unit_of_Measure__c, Benefit_Type__c from QIPP_Benefit__c where Project_ID__c =:projectid and Id !=:benifit.id];
            if(listOfBenefitsOfProject_exceptThis.size()>0){
                for(QIPP_Benefit__c ben : listOfBenefitsOfProject_exceptThis){
                    impMeasureBenefitTypeMap_exceptThis.put(ben.Improvement_Measure_Name__c+ben.Unit_of_Measure__c+ben.Benefit_Type__c,'0');
                    idMap.put(ben.Id,'0');
                }
            }
        }catch(Exception e){}

        try{
            pcount2 = 0;
            afcount2 = 0;
            
                // Start::Validations
                /*********************** VALIDATION FOR Quality Improvment Measure SECTION ************************/
                
              /* if(textdata == null || textdata == ' ')
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select an Improvement Measure')); 
                    flag =true;
                }*/

            hMapMonth = new Map<String,String>();
            
            
            String key_month = '';
            if(atleastOneRow == true){
                projectErrorMessages = false;
                benifitsErrorMessages = true;
                editBenifitsErrorMessages = true;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter one Benefit line item in order to Save a Benefit.')); 
                flag =true;
            }
            if(displayPopupBenf==true){
                if(errorChecked == false){
                    if((textdata == '' || textdata == null || textdata == ' ') && (UoMeasure == '' || UoMeasure == null || UoMeasure == ' ')){
                        errorChecked = true;
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter responses in the required fields in order to Save a Benefit.')); 
                        flag =true;
                    }
                }
                if(errorChecked == false){
                    if((textdata == '' || textdata == null || textdata == ' ')){
                        errorChecked = true;
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter an Improvement Measure in order to Save a Benefit.')); 
                        flag =true;
                    }
                }
                if(errorChecked == false){
                    if((UoMeasure == '' || UoMeasure == null || UoMeasure == ' ')){
                        errorChecked = true;
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter a Unit of Measure in order to Save a Benefit.'));
                        flag =true;
                    }
                }
            }else if(displayPopupeditBenf==true){
                if(errorChecked == false){
                    if((benifit.Improvement_Measure_Name__c == '' || benifit.Improvement_Measure_Name__c == null) && (UoMeasureEdit == '' || UoMeasureEdit == null|| UoMeasureEdit == ' ')){
                        errorChecked = true;
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter responses in the required fields in order to Save a Benefit.')); 
                        flag =true;
                    }
                }
                if(errorChecked == false){
                    if((benifit.Improvement_Measure_Name__c == '' || benifit.Improvement_Measure_Name__c == null)){
                        errorChecked = true;
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter an Improvement Measure in order to Save a Benefit.')); 
                        flag =true;
                    }
                }
                if(errorChecked == false){
                    if((UoMeasureEdit == '' || UoMeasureEdit == null || UoMeasureEdit == ' ')){
                        errorChecked = true;
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter a Unit of Measure in order to Save a Benefit.')); 
                        flag =true;
                    }
                }
            }
            if(displayPopupBenf==true && impMeasureBenefitTypeMap.containsKey(imp_bentype)){
                projectErrorMessages = false;
                benifitsErrorMessages = true;
                editBenifitsErrorMessages = true;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Duplicate Improvement Measures (same Unit of Measure and Benefit Type) are not allowed.  You must modify this Improvement Measure (with different Unit of Measure / Benefit Type combination) or Cancel this entry and modify the existing Improvement Measure.')); 
                flag =true;
            }
            if(displayPopupeditBenf==true && impMeasureBenefitTypeMap_exceptThis.containsKey(imp_bentype)){
                //if(idMap.containskey(benifit.Id)){                    
                    projectErrorMessages = false;
                    benifitsErrorMessages = true;
                    editBenifitsErrorMessages = true;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Duplicate Improvement Measures (same Unit of Measure and Benefit Type) are not allowed.  You must modify this Improvement Measure (with different Unit of Measure / Benefit Type combination) or Cancel this entry and modify the existing Improvement Measure.')); 
                    flag =true;
                //}
            }
            try{
                for(QIPP_BU_Reporting__c Benrepv:Bn_rep_AddList){
                    //key_month = Benrepv.Benefit_Condition__c+Benrepv.Years__c+Benrepv.Quarters__c+Benrepv.Months__c;
                    key_month = Benrepv.Years__c+Benrepv.Months__c;
                    if( (Benrepv.Years__c == null || Benrepv.Years__c == '--None--') && (Benrepv.Months__c == null || Benrepv.Months__c == '--None--') && (Benrepv.Benefits_Saving_Amount_Planned__c == null || Benrepv.Benefits_Saving_Amount_Planned__c == 0) && (Benrepv.Benefits_Saving_Amount_Achieved__c == null ||  Benrepv.Benefits_Saving_Amount_Achieved__c == 0) && (Benrepv.Benefit_Savings_Amount__c == null || Benrepv.Benefit_Savings_Amount__c == 0) ){
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        errorChecked = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Year, Month and Savings Amounts(k€) are required fields in order to Save a Benefit.')); 
                        flag =true; 
                    }
                    if(errorChecked == false){
                        if((Benrepv.Years__c == null || Benrepv.Years__c == '--None--') && (Benrepv.Months__c != null) && ( (Benrepv.Benefits_Saving_Amount_Planned__c != null && Benrepv.Benefits_Saving_Amount_Planned__c != 0) || (Benrepv.Benefits_Saving_Amount_Achieved__c != null && Benrepv.Benefits_Saving_Amount_Achieved__c != 0) || (Benrepv.Benefit_Savings_Amount__c != null && Benrepv.Benefit_Savings_Amount__c != 0)) ){
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            editBenifitsErrorMessages = true;
                            errorChecked = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Year is required field in order to Save a Benefit.')); 
                            flag =true; 
                        }
                    }
                    if(errorChecked == false){
                        if((Benrepv.Years__c == null || Benrepv.Years__c == '--None--') && (Benrepv.Months__c == null || Benrepv.Months__c == '--None--') && ( (Benrepv.Benefits_Saving_Amount_Planned__c != null || Benrepv.Benefits_Saving_Amount_Planned__c != 0) || (Benrepv.Benefits_Saving_Amount_Achieved__c != null || Benrepv.Benefits_Saving_Amount_Achieved__c != 0) || (Benrepv.Benefit_Savings_Amount__c != null || Benrepv.Benefit_Savings_Amount__c != 0)) ){
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            editBenifitsErrorMessages = true;
                            errorChecked = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Year and Month are required fields in order to Save a Benefit.')); 
                            flag =true; 
                        }
                    }
                    if(errorChecked == false){
                        if((Benrepv.Years__c == null || Benrepv.Years__c == '--None--') && (Benrepv.Months__c != null || Benrepv.Months__c != '--None--') && (Benrepv.Benefits_Saving_Amount_Planned__c == null || Benrepv.Benefits_Saving_Amount_Planned__c == 0) && (Benrepv.Benefits_Saving_Amount_Achieved__c == null || Benrepv.Benefits_Saving_Amount_Achieved__c == 0) && (Benrepv.Benefit_Savings_Amount__c == null || Benrepv.Benefit_Savings_Amount__c == 0) ){
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            editBenifitsErrorMessages = true;
                            errorChecked = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Year and Savings Amounts(k€) are required fields in order to Save a Benefit.')); 
                            flag =true; 
                        }
                    }
                    if(errorChecked == false){
                        if((Benrepv.Months__c == null || Benrepv.Months__c == '--None--') && (Benrepv.Years__c != null || Benrepv.Years__c != '--None--') && (Benrepv.Benefits_Saving_Amount_Planned__c == null || Benrepv.Benefits_Saving_Amount_Planned__c == 0) && (Benrepv.Benefits_Saving_Amount_Achieved__c == null || Benrepv.Benefits_Saving_Amount_Achieved__c == 0) && (Benrepv.Benefit_Savings_Amount__c == null || Benrepv.Benefit_Savings_Amount__c == 0)){
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            editBenifitsErrorMessages = true;
                            errorChecked = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Month and Savings Amounts(k€) are required fields in order to Save a Benefit.')); 
                            flag =true; 
                        }
                    }
                    if(errorChecked == false){
                        if((Benrepv.Months__c == null || Benrepv.Months__c == '--None--') && (Benrepv.Years__c != null || Benrepv.Years__c != '--None--') && ( (Benrepv.Benefits_Saving_Amount_Planned__c != null || Benrepv.Benefits_Saving_Amount_Planned__c != 0) || (Benrepv.Benefits_Saving_Amount_Achieved__c != null || Benrepv.Benefits_Saving_Amount_Achieved__c != 0) || (Benrepv.Benefit_Savings_Amount__c != null || Benrepv.Benefit_Savings_Amount__c != 0))){
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            editBenifitsErrorMessages = true;
                            errorChecked = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Month is required field in order to Save a Benefit.')); 
                            flag =true; 
                        }
                    }
                    if(errorChecked == false){
                        if((Benrepv.Benefits_Saving_Amount_Planned__c == null || Benrepv.Benefits_Saving_Amount_Planned__c == 0) && (Benrepv.Benefits_Saving_Amount_Achieved__c == null || Benrepv.Benefits_Saving_Amount_Achieved__c == 0) && (Benrepv.Benefit_Savings_Amount__c == null || Benrepv.Benefit_Savings_Amount__c == 0)){
                            projectErrorMessages = false;
                            benifitsErrorMessages = true;
                            editBenifitsErrorMessages = true;
                            errorChecked = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Savings Amounts(k€) cannot be Blank/Zero in order to Save a Benefit.')); 
                            flag =true; 
                        }
                    }
                        
                    if(hMapMonth.containsKey(key_month)){
                        projectErrorMessages = false;
                        benifitsErrorMessages = true;
                        editBenifitsErrorMessages = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Duplicate Month is not allowed. Please modify Month or Delete the Row.')); 
                        flag =true;
                    }else{
                        if(Benrepv.Months__c != null /*&& Benrepv.Quarters__c == 'Q1'*/){
                            hMapMonth.put(key_month,'month');
                            hMapMonth.put(Benrepv.Years__c+Benrepv.Months__c+'null','0');
                        }
                    }
                }
            }catch(Exception e){}
            
            if(flag){
                errorflag = true; 
            }else{
                errorflag = false; 
            }
                    
            // End::Validations     
            
            if(flag == false){
                upsert benifit;

                MultiBenrep = new list<QIPP_BU_Reporting__c>();
                list<QIPP_BU_Reporting__c> MultiBendel = new list<QIPP_BU_Reporting__c>();                  
                For( QIPP_BU_Reporting__c Bendel:Bn_rep_DelList){
                    QIPP_BU_Reporting__c testdel = new QIPP_BU_Reporting__c();
                    If(Bendel.id != null){
                        testdel.id =Bendel.id;
                        MultiBendel.add(testdel);
                    }
                }
            
                if(Bn_rep_AddList != null || Bn_rep_AddList.size() > 0){
                    For( QIPP_BU_Reporting__c Benrep:Bn_rep_AddList){
                        QIPP_BU_Reporting__c test = new QIPP_BU_Reporting__c();                            

                        if(Benrep.Years__c != null && Benrep.Months__c != null && ( (Benrep.Benefits_Saving_Amount_Planned__c != null || Benrep.Benefits_Saving_Amount_Planned__c != 0) || (Benrep.Benefits_Saving_Amount_Achieved__c != null || Benrep.Benefits_Saving_Amount_Achieved__c != 0) || (Benrep.Benefit_Savings_Amount__c != null || Benrep.Benefit_Savings_Amount__c != 0))){
                            If(Benrep.id != null){
                                test.id =Benrep.id;
                            }
                            Integer Month;
                            String Quarter = null;
                            Month = Integer.valueOf(Benrep.Months__c);    
                            if(1 >= Month || Month <= 3){
                                Quarter = 'Q1';
                            }else if (4 >= Month || Month <= 6){
                                Quarter = 'Q2';
                            }else if(7 >= Month || Month <= 9){
                                Quarter = 'Q3';
                            }else if(10 >= Month || Month <= 12){
                                Quarter = 'Q4';
                            }
                            test.Project_ID__c=projectid;
                            test.Project_Number__c = projectinfo.Project_Number__c;
                            test.Project_Name__c = projectinfo.Project_Name_Succinct__c;
                            test.Benefit_ID__c=benifit.id;
                            test.Improvement_Measure__c = benifit.Improvement_Measure_Name__c;
                            test.Benefit_Condition__c=Benrep.Benefit_Condition__c;
                            test.Years__c=Benrep.Years__c;
                            test.Quarters__c=Quarter;//Benrep.Quarters__c;
                            test.Months__c=Benrep.Months__c;
                            test.Benefits_Saving_Amount_Planned__c=Benrep.Benefits_Saving_Amount_Planned__c;
                            //if(Benrep.Benefits_Saving_Amount_Achieved__c != null)
                                test.Benefits_Saving_Amount_Achieved__c=Benrep.Benefits_Saving_Amount_Achieved__c;
                            //if(Benrep.Benefit_Savings_Amount__c != null)    
                                test.Benefit_Savings_Amount__c=Benrep.Benefit_Savings_Amount__c;
                            test.Benefit_Type__c = impBenefitType;//benifit.Benefit_Type__c;
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

                            //if(Benrep.Benefit_Condition__c == 'Planned'){
                                test.Improvment_Amount__c = string.valueof(Benrep.Benefits_Saving_Amount_Planned__c);
                                //test.Achieved_Amount__c = '0.0';
                                //test.Future_Saving_Amount__c = '0.0';
                             //   }
                            //if(Benrep.Benefit_Condition__c == 'Achieved'){commented by Haripriya
                            //if(Benrep.Benefits_Saving_Amount_Achieved__c != null)
                                test.Achieved_Amount__c = string.valueof(Benrep.Benefits_Saving_Amount_Achieved__c);
                                //test.Improvment_Amount__c = '0.0';
                                //test.Future_Saving_Amount__c = '0.0';
                              //  }
                            //if(Benrep.Benefit_Condition__c == 'Future'){commented by Haripriya
                            //if(Benrep.Benefit_Savings_Amount__c != null)
                                test.Future_Saving_Amount__c = string.valueof(Benrep.Benefit_Savings_Amount__c);
                                //test.Improvment_Amount__c = '0.0';
                                //test.Achieved_Amount__c = '0.0';
                                //}
                            string historytrack;

                            MultiBenrep.add(test);
                        }
                    }
                }
                    
                if(MultiBendel != null || MultiBendel.size() > 0){
                    Delete MultiBendel;
                    Bn_rep_DelList.clear();
                }
                    
                if(MultiBenrep != null || MultiBenrep.size() > 0){
                    Upsert MultiBenrep;
                }
                //********** Ending Upsert and Delete conditions**For** Benefit Reporting Object********
                // obj = new PageReference('/apex/QIPP_Benefit_Detail_Page?detailpage='+benifit.Id) ;           
                //start::View Page Calculations
                if(MultiBenrep.size() != 0){
                    PlannedAmount = 0.0;
                    AchievedAmount = 0.0;
                    FutureAmount = 0.0; 
            
                    for(QIPP_BU_Reporting__c benlineItems:MultiBenrep){
                        //if(benlineItems.Benefit_Condition__c == 'Planned')
                        if(benlineItems.Benefits_Saving_Amount_Planned__c != null){
                            PlannedAmount = PlannedAmount + benlineItems.Benefits_Saving_Amount_Planned__c;
                            //System.Debug('*********PlannedAmount111**********' + PlannedAmount);
                        }else{
                            PlannedAmount = PlannedAmount;
                        }                           
                        //if(benlineItems.Benefit_Condition__c == 'Achieved'){commented by Haripriya
                        if(benlineItems.Benefits_Saving_Amount_Achieved__c != null){
                            AchievedAmount = AchievedAmount + benlineItems.Benefits_Saving_Amount_Achieved__c;
                        }
                        // System.Debug('*********AchievedAmount111**********' + AchievedAmount);}                           
                        //if(benlineItems.Benefit_Condition__c == 'Future'){
                        if(benlineItems.Benefit_Savings_Amount__c != null){
                            FutureAmount = FutureAmount + benlineItems.Benefit_Savings_Amount__c;
                        }
                       // System.Debug('*********FutureAmount111**********' + FutureAmount);}                           
                    }
                    if(impBenefitType == 'Financial Savings'){    
                        benifit.Planned_Financial_Savings_Total__c =  PlannedAmount;
                        benifit.Achieved_Financial_Savings_Total__c = AchievedAmount;   
                        benifit.Future_Financial_Savings_Total__c = FutureAmount;
                        benifit.Benefit_Amount_Achieved_Future_k__c = AchievedAmount + FutureAmount;
                        // if(displayPopupeditBenf == true){
                            benifit.Planned_Operational_Savings_Total__c =  0.0;
                            benifit.Achieved_Operational_Savings_Total__c = 0.0;   
                            benifit.Future_Operational_Savings_Total__c = 0.0;
                            
                            benifit.Planned_Projected_Savings_Total__c =  0.0;
                            benifit.Achieved_Projected_Savings_Total__c = 0.0;   
                            benifit.Future_Projected_Savings_Total__c = 0.0;
                            
                            benifit.Planned_Realized_Savings_Total__c =  0.0;
                            benifit.Achieved_Realized_Savings_Total__c = 0.0;   
                            benifit.Future_Realized_Savings_Total__c = 0.0;
                        
                            benifit.Benefit_Operational_Achieved_Future_k__c = 0.0;
                            benifit.Benefit_Projected_Achieved_Future_k__c = 0.0;
                            benifit.Benefit_Realized_Achieved_Future_k__c = 0.0;
                       // }
                    }    
                    else if(impBenefitType == 'Operational Savings'){    
                        benifit.Planned_Operational_Savings_Total__c =  PlannedAmount;
                        benifit.Achieved_Operational_Savings_Total__c = AchievedAmount;   
                        benifit.Future_Operational_Savings_Total__c = FutureAmount;
                        benifit.Benefit_Operational_Achieved_Future_k__c = AchievedAmount + FutureAmount;
                        //  if(displayPopupeditBenf == true){
                            benifit.Planned_Financial_Savings_Total__c =  0.0;
                            benifit.Achieved_Financial_Savings_Total__c = 0.0;   
                            benifit.Future_Financial_Savings_Total__c = 0.0;
                        
                            benifit.Planned_Projected_Savings_Total__c =  0.0;
                            benifit.Achieved_Projected_Savings_Total__c = 0.0;   
                            benifit.Future_Projected_Savings_Total__c = 0.0;
                            
                            benifit.Planned_Realized_Savings_Total__c =  0.0;
                            benifit.Achieved_Realized_Savings_Total__c = 0.0;   
                            benifit.Future_Realized_Savings_Total__c = 0.0;
                            
                            benifit.Benefit_Amount_Achieved_Future_k__c = 0.0;            
                            benifit.Benefit_Projected_Achieved_Future_k__c = 0.0;
                            benifit.Benefit_Realized_Achieved_Future_k__c = 0.0;
                        //  }
                    }
                    else if(impBenefitType == 'Projected Revenue'){
                        benifit.Planned_Projected_Savings_Total__c =  PlannedAmount;
                        benifit.Achieved_Projected_Savings_Total__c = AchievedAmount;   
                        benifit.Future_Projected_Savings_Total__c = FutureAmount;
                        benifit.Benefit_Projected_Achieved_Future_k__c = AchievedAmount + FutureAmount;
                        // if(displayPopupeditBenf == true){
                            benifit.Planned_Financial_Savings_Total__c =  0.0;
                            benifit.Achieved_Financial_Savings_Total__c = 0.0;   
                            benifit.Future_Financial_Savings_Total__c = 0.0;
                        
                            benifit.Planned_Operational_Savings_Total__c =  0.0;
                            benifit.Achieved_Operational_Savings_Total__c = 0.0;   
                            benifit.Future_Operational_Savings_Total__c = 0.0;
                            
                            benifit.Planned_Realized_Savings_Total__c =  0.0;
                            benifit.Achieved_Realized_Savings_Total__c = 0.0;   
                            benifit.Future_Realized_Savings_Total__c = 0.0;
                            
                            benifit.Benefit_Amount_Achieved_Future_k__c = 0.0;
                            benifit.Benefit_Operational_Achieved_Future_k__c = 0.0;            
                            benifit.Benefit_Realized_Achieved_Future_k__c = 0.0;  
                        //  }  
                    }
                    else if(impBenefitType == 'Realized Revenue'){
                        benifit.Planned_Realized_Savings_Total__c =  PlannedAmount;
                        benifit.Achieved_Realized_Savings_Total__c = AchievedAmount;   
                        benifit.Future_Realized_Savings_Total__c = FutureAmount;
                        benifit.Benefit_Realized_Achieved_Future_k__c = AchievedAmount + FutureAmount;
                        //if(displayPopupeditBenf == true){
                            benifit.Planned_Financial_Savings_Total__c =  0.0;
                            benifit.Achieved_Financial_Savings_Total__c = 0.0;   
                            benifit.Future_Financial_Savings_Total__c = 0.0;
                        
                            benifit.Planned_Operational_Savings_Total__c =  0.0;
                            benifit.Achieved_Operational_Savings_Total__c = 0.0;   
                            benifit.Future_Operational_Savings_Total__c = 0.0;
                            
                            benifit.Planned_Projected_Savings_Total__c =  0.0;
                            benifit.Achieved_Projected_Savings_Total__c = 0.0;   
                            benifit.Future_Projected_Savings_Total__c = 0.0;
                            
                            benifit.Benefit_Amount_Achieved_Future_k__c = 0.0;
                            benifit.Benefit_Operational_Achieved_Future_k__c = 0.0;
                            benifit.Benefit_Projected_Achieved_Future_k__c = 0.0;
                        // }
                    }
                }
                upsert benifit;
            }
        }catch(Exception exe){
            string errMsg = exe.getMessage( );
            system.debug('errMsg::::::: '+errMsg);
            if(errMsg.contains('INSUFFICIENT_ACCESS')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient Privileges'));
            }
            else if(!errMsg.contains('INSUFFICIENT_ACCESS')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Benefit Cannot be Saved, Please contact your Administrator.'));
            }
            benifitsErrorMessages=true;
            editBenifitsErrorMessages = true;
            return null;
        }
        if(benifitsErrorMessages == false){
            displayPopupBenf= false; //To hide create Benefit popup window  
            displayPopupeditBenf = false;//To hide edit Benefit popup window
            redirectUrl = new PageReference(ApexPages.currentPage().getHeaders().get('referer'));
            try{
                textdata = '';
                impBenefitType = '';
                UoMeasure = '';
                benifit.ImprovementMeasure_Brief_Description__c = '';           
                Bn_rep_AddList = new List<QIPP_BU_Reporting__c>();
            }catch(Exception e){}
            return redirectUrl;
        }else if(editBenifitsErrorMessages == false){
            displayPopupBenf= false; //To hide create Benefit popup window  
            displayPopupeditBenf = false;//To hide edit Benefit popup window
            redirectUrl = new PageReference(ApexPages.currentPage().getHeaders().get('referer'));
            try{
                textdata = '';
                impBenefitType = '';
                UoMeasure = '';
                benifit.ImprovementMeasure_Brief_Description__c = '';           
                Bn_rep_AddList = new List<QIPP_BU_Reporting__c>();
            }catch(Exception e){}
            return redirectUrl;
        }
        return null;
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
    
    public PageReference getBusinesslinelist(){
        List<QIPP_Benefit_Conversion_Table__c> selectedkpi;
        selectedkpi = [SELECT id, Name From QIPP_Benefit_Conversion_Table__c where name= :textdata];
        try{
        if(selectedkpi.size()==0){
            if(displayPopupBenf == true){
                UoMeasure = '';
                benifit.ImprovementMeasure_Brief_Description__c = '';
                impBenefitType = 'Financial Savings';
            }
            if(displayPopupeditBenf == true){
                benifit.Unit_of_Measure__c = '';
                benifit.ImprovementMeasure_Brief_Description__c = '';
                benifit.Benefit_Type__c = 'Financial Savings';
            }            
            return null;
        }
        }catch(Exception e){}
        if(selectedkpi.size()>0){
            projectMeasureId = selectedkpi[0].id;
            createNewImprovementMeasure = false;
        }else{
            createNewImprovementMeasure = true;
        }
        if((displayPopupeditBenf==true && createNewImprovementMeasure == false) || (displayPopupBenf==true)/*benifit.Benefit_Override_Status__c != 'Awaiting Approval'*/) // we dont have any Benefit override concept now - Haripriya
        {
                try{
                con = [select Name , Id  , Impacted_P_L_Line__c , Monetization_Calculation_Method__c , Directional_Indicator__c , Benefit_Type__c,Improvement_Measure_Grouping__c, CoPQ_Type__c ,Brief_Description__c,  Unit_of_Measure__c from QIPP_Benefit_Conversion_Table__c
                                    where id=: projectMeasureId];
                                    
                
                BusinessLineFromConversionRate = new List<QIPP_Benefit_Conversion_Rate__c>();
                
                try
                {
                BusinessLineFromConversionRate = [select Business_Line__c from QIPP_Benefit_Conversion_Rate__c where Improvement_Measure__c =: projectMeasureId];
                
                if(BusinessLineFromConversionRate != null && BusinessLineFromConversionRate.size() > 0)
                    strBusinessLineFromConversionRate = BusinessLineFromConversionRate[0].Business_Line__c ;
                 
                else
                    strBusinessLineFromConversionRate = 'N/A';
                }
                catch(Exception exe)
                {
                    strBusinessLineFromConversionRate = 'N/A';
                }

                        if(con.size()>0){
                            benifit.ImprovementMeasure_Brief_Description__c = con[0].Brief_Description__c;// added by Haripriya
                            benifit.Benefit_Type__c = con[0].Benefit_Type__c;
                            impBenefitType = con[0].Benefit_Type__c;// added by Haripriya
                            benifit.Improvement_Measure_Grouping__c = con[0].Improvement_Measure_Grouping__c;
                            benifit.Financial_Type__c = con[0].CoPQ_Type__c;
                            benifit.Unit_of_Measure__c = con[0].Unit_of_Measure__c;
                            UoMeasure = con[0].Unit_of_Measure__c;// added by Haripriya
                            benifit.Directional_Indicator__c = con[0].Directional_Indicator__c;
                            benifit.Impacted_P_L_Line__c = con[0].Impacted_P_L_Line__c ;
                            benifit.Improvement_Measure_Name__c =  con[0].Name;
                        }
                }catch(Exception e){}
                //return null;
        }

        return null; 
        
    }
    public void getBenefitRedesign(){
        benefitSaveButton = false;
        totalamountvalidation =0;
        currentbenifitamount = 0;
        //IMPDescription = '';
        try
        {
            benifit= new QIPP_Benefit__c();
            
            if(projectid != null)    
            {
                projectinfo = [select Name ,Project_Lead_Email__c,Project_State__c ,TotalKPI__c,TotalCOPQ__c, Project_Number__c , Project_Name_Succinct__c ,  Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c , 
                                CoPQ_Benefits_Validation_State__c,TriggerForDI3ApprovalProcess__c ,DI_State__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c,Recordtype.name,DI3_Action_Status__c,Check_DI_Approval_State__c,Project_BL__c,Benefitting_Project_BL_Level_4_Org__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c,Project_Lead_BU__c,Project_Type__c,Belt_Project_Type__c from QIPP_Project__c where id =: projectid];
                benifit.Project_ID__c = projectid ;
                benifit.Portfolio_Name__c = projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c ; 
                benifit.Project_Lead__c = projectinfo.Project_Lead__r.Full_Name__c ; 
                benifit.Project_Name_Display__c = projectinfo.Project_Name_Succinct__c ; 
                benifit.Project_Number__c =  projectinfo.Project_Number__c ;
                benifit.Improvement_Measure_KPI__c = projectMeasureId; // added Haripriya
                totalsavings = projectinfo.TotalKPI__c + projectinfo.TotalCOPQ__c;              
            }
    }
    catch(Exception exe)
    {

    }
    }
    
   
 public void closePopup() {
        displayPopupBBG= false; //To hide confirmation popup for submitting approval process  
    }
 public void closePopupBBG() {       
        displayPopupBBG= false; //To hide confirmation popup for submitting approval process  
    }
     
    public void showPopupBBG() {       
        displayPopupBBG= true;
    }
    
    public void closePopupBAM() {
        displayPopupBAM= false; //To hide confirmation popup for submitting approval process  
    }
    public void showPopupBAM() {       
        displayPopupBAM= true;
    }

    public pageReference closePopupBenf() {    
        try{
            redirectUrl = new PageReference(ApexPages.currentPage().getHeaders().get('referer'));
            textdata = '';
            impBenefitType = '';
            UoMeasure = '';
            benifit.ImprovementMeasure_Brief_Description__c = '';           
            Bn_rep_AddList = new List<QIPP_BU_Reporting__c>();
        }catch(Exception e){}
        return redirectUrl;
    }
    public pageReference closeEditPopupBenf(){
        try{
            displayPopupeditBenf= false; //To hide confirmation popup for submitting approval process
            redirectUrl = new PageReference(ApexPages.currentPage().getHeaders().get('referer'));
            textdata = '';
            impBenefitType = '';
            UoMeasure = '';
            benifit.ImprovementMeasure_Brief_Description__c = '';           
            Bn_rep_AddList = new List<QIPP_BU_Reporting__c>();
        }catch(Exception e){}
        return redirectUrl;
    }
    public void showPopupBenf() {   
        Bn_rep_AddList = new List<QIPP_BU_Reporting__c>();
        getBenefitRedesign();
        Bn_rep_AddList.add(new QIPP_BU_Reporting__c(Project_ID__c=projectid,Benefit_ID__c=benifit.id));
        rowNum=1;
        displayPopupBenf= true;
        atleastOneRow = false;
    }
     public void showPopupviewBenf() {   
         if(benefitid!=null && benefitid!= '')
            {
                benifit2 = [select ID , 
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
                                     Remaining_Benefit_Start__c,
                                     
                                     Total_Benefit_Planned_Amount__c,
                                     Total_Benefit_Achieved_Amount__c,
                                     Total_Benefit_Future_Amount__c

                                     from QIPP_Benefit__c where ID =: benefitid];
                                     
                                     }
                                    Bn_rep_AddList1 = [select ID,                                 
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
                                from QIPP_BU_Reporting__c  where Benefit_ID__c =:benefitid and Months__c != null /* and Entry_Type__c != 'System Entry'*/];
            if(Bn_rep_AddList1.size()>0){
                benefitTotalsList = [select ID,                                 
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
                                from QIPP_BU_Reporting__c  where Benefit_ID__c =:benefitid and Months__c != null limit 1];
            }
                      
        displayPopupviewBenf= true;
      
    }
     public void closePopupviewBenf() {       
        displayPopupviewBenf= false;
        showPopupeditBenf();
        
    }
    public void closePopupviewonlyBenf() {       
       
        displayPopupviewBenf= false;
        
    }
    public void BBGValidationamount(){
      bbgvalamount=[SELECT TotalCOPQ__c,TotalKPI__c,Total_Validation_Amount_Projected_k__c,Total_Validation_Amount_Realized_k__c FROM QIPP_Project__c where id=:projectid];  
      bbgopvalamount=bbgvalamount.TotalKPI__c;
      bbgfivalamount=bbgvalamount.TotalCOPQ__c;
      bbgprvalamount=bbgvalamount.Total_Validation_Amount_Projected_k__c;
      bbgrelvalamount=bbgvalamount.Total_Validation_Amount_Realized_k__c;
    }

    public void showPopupeditBenf() {
        try{
            if(projectid != null){
                projectinfo = [select Name ,Project_Lead_Email__c,Project_State__c ,TotalKPI__c,TotalCOPQ__c, Project_Number__c , Project_Name_Succinct__c ,  Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c , 
                                        CoPQ_Benefits_Validation_State__c,TriggerForDI3ApprovalProcess__c ,DI_State__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c,Recordtype.name,DI3_Action_Status__c,Check_DI_Approval_State__c,Project_BL__c,Benefitting_Project_BL_Level_4_Org__c,Project_Lead_BL_Level_3_Org__c,Project_Lead_BL_Level_4_Org__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c,Project_Lead_BU__c,Project_Type__c,Belt_Project_Type__c from QIPP_Project__c where id =: projectid];
            }            
        if(benefitid!=null && benefitid!= '')
            {
                Bn_rep_AddList = new List<QIPP_BU_Reporting__c>();
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

                                     Achieved_Quantity__c,
                                     Achieved_Start_Date__c,
                                     Achieved_End_Date__c,
                                     Achieved_Benefit_Period_Weeks__c,
                                     Achieved_Rate__c,

                                     Invoke_Benefit_Override_Approve__c,
                                     
                                     Future_Quantity__c,
                                     Future_Start_Date__c,
                                     Future_End_Date__c,
                                     Future_Benefit_Period_Weeks__c,
                                     Future_Rate__c,

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
                                     Remaining_Benefit_Start__c,
                             Planned_Financial_Savings_Total__c,
                             Achieved_Financial_Savings_Total__c,
                             Future_Financial_Savings_Total__c,
                             Planned_Operational_Savings_Total__c,
                             Achieved_Operational_Savings_Total__c,
                             Future_Operational_Savings_Total__c,
                             Planned_Projected_Savings_Total__c,
                             Achieved_Projected_Savings_Total__c,
                             Future_Projected_Savings_Total__c,
                             Planned_Realized_Savings_Total__c,
                             Achieved_Realized_Savings_Total__c,
                             Future_Realized_Savings_Total__c,
                             Benefit_Amount_Achieved_Future_k__c,
                             Benefit_Operational_Achieved_Future_k__c,
                             Benefit_Projected_Achieved_Future_k__c,
                             Benefit_Realized_Achieved_Future_k__c
                                     from QIPP_Benefit__c where ID =: benefitid];
                                     
                                     }
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
                                from QIPP_BU_Reporting__c  where Benefit_ID__c =:benefitid and Months__c != null/* and Entry_Type__c != 'System Entry'*/];
        displayPopupeditBenf= true;
        if(Bn_rep_AddList.size()>0){
            atleastOneRow = false;
        }else{
            atleastOneRow = true;
        }
        }catch(Exception e){}
    }
     public void closePopupeditBenf() {       
        displayPopupeditBenf= false;
    }

  /*  public PageReference newBenefitsOverview()
  {
      System.Debug('*************ProjectReportPage ************** ' + projectid );  
      String str = projBBGAddList[0].Project_Number__c ;
      //PageReference obj = new PageReference('/00OU0000001wMzJ?pv0='+str); // QIPP-FINANCIAL Savings- Monthly
      PageReference obj1 = new PageReference('/00OR0000001B8Md?pv0='+str); // QIPP-FINANCIAL Savings- Monthly
      System.Debug('************* obj************** ' +  obj1);
      obj1.setRedirect(true);
      return obj1;        
  }*/

public void getBusinesslinelist1()
     {
         try{
      textdata=benifit.Improvement_Measure_Name__c;
      benifit = [select ID , 
                             Improvement_Measure_KPI__c,
                             Improvement_Measure_KPI__r.name,
                             Improvement_Measure_KPI__r.Brief_Description__c,
                             ImprovementMeasure_Brief_Description__c,
                             Improvement_Measure_Name__c,
                             Business_Line__c,
                             Unit_of_Measure__c,
                             Benefit_Type__c
                             from QIPP_Benefit__c where id=:benefitid];
        List<QIPP_Benefit_Conversion_Table__c> selectedkpi = [SELECT id, Name From QIPP_Benefit_Conversion_Table__c where name= :textdata];
        getBusinesslinelist();
         }catch(Exception e){}
   }
}