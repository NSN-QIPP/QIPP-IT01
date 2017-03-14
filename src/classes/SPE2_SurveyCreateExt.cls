public class SPE2_SurveyCreateExt 
{

//--------------Variables for Recurrence Start--------------------/
    public String var {get;set;}
    public date uploadDate;
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
    
    Integer frequency;
    public String selectedDayinMonth{get;set;}
    public String selectedMonthinYear{get;set;}
    public String selectedMonthinYear2{get;set;}
    public String selectedDayInYear{get;set;}
    public String selectedWeekInMonth{get;set;}
    public String selectedWeekInYear{get;set;}
    public Boolean displaySaveButton{get;set;}
    public Boolean displayContinueButton{get;set;}
     
    public String displaydate{get;set;}
    public String displayDataAcSection{get;set;}
    public Boolean displayButton{get;set;}
   
//-------------------------- PI Definition Fields--------------------------/
Public String Id{get;set;}
public boolean chkThis{get;set;}
public date mydate;
public Map<String,Date> weekdatecombination;

//----------------------------General Recurrence variables ---------------/
public string selectedFrequency{get;set;}
public boolean RenderRecurrence{get;set;}

//----------------------------Monthly variables ---------------------------------/
public string ChildRadio{get;set;}
public string DayCount{get;set;}
public string MonthFrequency1{get;set;}
public string MonthFrequency2{get;set;}
public string WeekNumber{get;set;}
public string DayOfTheWeek{get;set;}


//----------------------Yearly variables ------------------------------------------/
public string YearFrequency{get;set;}
public string MonthName{get;set;}
public string DayOftheMonth{get;set;}
//---------------------Range of Recurrence variables --------------------------------/
public string RecurrencePattern{get;set;}
public string RangeRadioVal{get;set;}
public string EndAfterOccurence{get;set;}
public string RecurStartDate{get;set;}
public string PageId{get;set;}
public SPE2Survey__c SurveyCloned;  
Id PIdefId;
public ApexPages.StandardController standardController{get;set;}


public Boolean isError{get;set;}
public Boolean isError1{get;set;}
public Boolean isError2{get;set;}
public Boolean isError3{get;set;}
public Boolean isError4{get;set;}
public Boolean isError5{get;set;}
public Boolean isError6{get;set;}
public Boolean isError7{get;set;}
public Boolean isError8{get;set;}

public String message{get;set;}
    public List<SelectOption> getFrequencyTypes() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Monthly','Monthly')); 
        options.add(new SelectOption('Yearly','Yearly')); 
        return options; 
    }
    public List<SelectOption> getWeekCountList() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('First','First')); 
        options.add(new SelectOption('Second','Second'));
        options.add(new SelectOption('Third','Third'));
        options.add(new SelectOption('Fourth','Fourth'));   
        return options; 
    }
    
    public List<SelectOption> getweekDays() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Sunday','Sunday')); 
        options.add(new SelectOption('Monday','Monday')); 
        options.add(new SelectOption('Tuesday','Tuesday'));
        options.add(new SelectOption('Wednesday','Wednesday')); 
        options.add(new SelectOption('Thursday','Thursday')); 
        options.add(new SelectOption('Friday','Friday')); 
        options.add(new SelectOption('Saturday','Saturday')); 
        return options; 
    }
    
     public List<SelectOption> getMonthList() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('January','January')); 
        options.add(new SelectOption('February','February')); 
        options.add(new SelectOption('March','March')); 
        options.add(new SelectOption('April','April')); 
        options.add(new SelectOption('May','May')); 
        options.add(new SelectOption('June','June')); 
        options.add(new SelectOption('July','July')); 
        options.add(new SelectOption('August','August')); 
        options.add(new SelectOption('September','September')); 
        options.add(new SelectOption('October','October')); 
        options.add(new SelectOption('November','November')); 
        options.add(new SelectOption('December','December')); 
        
        return options; 
    }
//--------------Variables for Recurrence End--------------------/
    public SPE_SPEPlan__c spePlan {get;set;}
    public SPE2Survey__c objSpeSurvey{get;set;}
    public List <SPE_SPEPlanSupplierMap__c> spePlanSuppliers{get;set;} 
    public List <SPE2_Question_Survey_Association__c> lstQuesSurveyAssoc{get;set;}   
    public List <SPE_SurveyQuestion__c> lstsurveyques{get;set;}
    public List <SPE2_SurveySupplierMap__c> lstsurveysupplier{get;set;}
    public List <SPE2_Survey_Respondents__c> lstsurveyrespondent{get;set;}
    public Boolean isScopeMatch {get;set;}
    public Boolean isValid {get;set;}
    public boolean isUserHaveAccessToRecord {get;set;}  
    
    public List<SelectOption> speTemplates {get;set;}
    
    public String speTemplateId {get;set;}

    private Date startDate;
    public Date endDate{get;set;}
    private Decimal frequencyInMonths;
    private Id prevSPETemplateIds;
    private List<SPE_ScoringTemplate__c> scoringTemplates;
    
    private Set<String> availableEterpriseIds = new Set<String>();
    
    private string errorMsg = '';
    
     //--------------------------Initialization of Variables for Custom Picklist Starts---------------------
    public Set<String> lstTemp{get;set;}
    public string marketVal{get;set;} 
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;} 
    public string projectVal{get;set;}
    public string buVal {get;set;}
    public string blVal{get;set;}
    public string prdVal{get;set;}
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    List<SelectOption>  mkoptions;
    List<SelectOption> countryOptions;
    List<SelectOption> projectOptions;
    List<SelectOption> BusinessLineOptions;
    List<SelectOption> ProductOptions;
    List<SelectOption> CatGroupOptions;
    List<SelectOption> CategoryOptions;
    Set<String> setMarkets;
    Set<String> setBusinessUnits;
    Set<String> setCategoryArea;
    Set<String> setMarketUnit;
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails  {get;set;}
    
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    public Boolean isTrackerCreated {get;set;}
     
    public SPE2_SurveyCreateExt(ApexPages.Standardcontroller st) 
    {
        //--------------------Recurrence part Start ----------------------/
         chkThis = false;
         isError = false;
         isError1 = false;
         isError2 = false;
         isError3 = false;
         isError4 = false;
         isError5 = false;
         isError6 = false;
         isError7 = false;
         isError8 = false;
        // displayDataAcSection = 'false';
       //  RenderRecurrence = true;
         message = '';
         isUserHaveAccessToRecord = true;
         PageId = ApexPages.currentPage().getParameters().get('Id');         
         
         
         this.StandardController =st;                            
        //--------------------Recurrence part End ------------------------/
        isTrackerCreated = false;
        system.debug('INSIDE---IF-1');
        speTemplates = new List<SelectOption>();
         //----------------Code for Custom picklist starts------------------------
        
            //--------------remove the separator ~Market,~BusinessUnit,~Category-----
        lstQuesSurveyAssoc = new List <SPE2_Question_Survey_Association__c>();
        lstsurveyques = new List<SPE_SurveyQuestion__c>();
        lstsurveysupplier = new List<SPE2_SurveySupplierMap__c>();
        lstsurveyrespondent = new List<SPE2_Survey_Respondents__c>();
        
        lstTemp = new Set<String>();
        setMarkets = new Set<String>();
        setBusinessUnits = new Set<String>();
        setCategoryArea = new Set<String>();
        
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
       
        system.debug('Market__c-----' + st.getId());
        for(String s : mapHierarchyDetails.keyset()){
            if(s.contains('~Market')){
                setMarkets.add(s.split('~')[0]);
                
            }
            if(s.contains('~BusinessUnit')){
                setBusinessUnits.add(s.split('~')[0]);
                system.debug('setBusinessUnits'+setBusinessUnits);
            }
            if(s.contains('~CategoryArea')){
                setCategoryArea.add(s.split('~')[0]);
            }
        }
        
                
        for(String s : mapHierarchyDetails.keyset()){
            if(s.contains('~Market')){
                String s1 = s.replace('~Market','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
            }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
            if(s.contains('~BusinessUnit')){
                String s1 = s.replace('~BusinessUnit','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
             }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
            if(s.contains('~CategoryArea')){
                String s1 = s.replace('~CategoryArea','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
            }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
        }
        
        system.debug('mapHierarchyDetails1 values---'+mapHierarchyDetails1);
        system.debug('mapHierarchyDetails1 same here--' + mapHierarchyDetails1.get('All MarketsAll Market Units'));
        //setMarketUnit = mapHierarchyDetails.get(marketVal);

        
        system.debug('setMarkets-----' + setMarkets);
        system.debug('setBusinessUnits-----' + setBusinessUnits);
        system.debug('setCategoryArea-----' + setCategoryArea);
        
          
           /*       if(objSpeSurvey.Is_One_Time_Survey__c== false){          
                       RenderRecurrence = true;
                       selectedFrequency = objSpeSurvey.Recurrence_frequency_type__c;
                       RecurrencePattern = objSpeSurvey.Recurrence_Pattern__c;
                       selectedWeekInMonth = objSpeSurvey.Week_Count__c;
                       selectedDayInMonth = objSpeSurvey.Day_name_of_upload_week__c;  
                   }
                   else{
                       RenderRecurrence = false;
                   }     */ 
                
        
        //----------------Code for Custom picklist ends------------------------
        if (st.getId() == null)
        {
            objSpeSurvey = new SPE2Survey__c(ownerid= userinfo.getUserId(),Recurrence_frequency_type__c='Monthly',Recurrence_Pattern__c = 'DayPerMonth');
            objSpeSurvey.Is_One_Time_Survey__c = true;
            system.debug('INSIDE---IF-');
            displaySaveButton = false;
            displayButton = true; 
            
            
             //----------------Code for Custom picklist starts------------------------
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            prdVal = PicklistDefaultValues__c.getall().values()[0].Product__c;
           //----------------Code for Custom picklist ends------------------------
        }
        else 
        {
            if(ApexPages.currentPage().getParameters().get('isClone') == null){
        CurrentUserId = UserInfo.getUserId();
        RecordOwnerId = [Select Id, ownerId from SPE2Survey__c
                       WHERE Id =: st.getId()].ownerId;
        }
        Map<String, String> UrlParameterMap1 = ApexPages.currentPage().getParameters();
        UserRecordAccess usrAcces = [SELECT RecordId, HasEditAccess FROM UserRecordAccess
                                            WHERE UserId =: UserInfo.getUserId() AND RecordId =: st.getId()];
             if (!UrlParameterMap1.containsKey('isClone'))
                isUserHaveAccessToRecord = usrAcces.HasEditAccess;
            system.debug('INSIDE----');
            objSpeSurvey = [SELECT Additional_Days_for_week__c,Additional_Days__c,BusinessLine__c,BusinessUnit__c,
                           CategoryGroup__c,CategoryArea__c,Category__c,Country__c,Day_name_of_upload_week__c,EndDate__c,
                           FrequencyInMonths__c,Id,Is_One_Time_Survey__c,MarketUnit__c,Market__c,Month_Upload_Day__c,Month_Value__c,Name,
                           OwnerId,Product__c,Project__c,Recurrence_frequency_type__c,Recurrence_Pattern__c,Stage__c,
                           StartDate__c,SurveyExecutionBeforeIndays__c,SurveyReminderBeforeExecutionDate__c,Survey_Code__c,
                           Survey_Shut_Down__c,Upload_Day__c,Week_Count__c,Yearly_Day_Name_of_Upload_Week__c,
                           Yearly_Week_Count__c FROM SPE2Survey__c
                           WHERE Id =: st.getId()];
           
            system.debug('objSpeSurvey----' + objSpeSurvey.EndDate__c);
            startDate = objSpeSurvey.StartDate__c;
            endDate = objSpeSurvey.EndDate__c; 
          
            frequencyInMonths = objSpeSurvey.FrequencyInMonths__c == null ? 1: Integer.valueOf(objSpeSurvey.FrequencyInMonths__c);
            //----------------Code for Custom picklist starts------------------------
            marketVal = objSpeSurvey.Market__c != null && objSpeSurvey.Market__c != '' ? objSpeSurvey.Market__c : '';
            marketUnitVal = objSpeSurvey.MarketUnit__c != null && objSpeSurvey.MarketUnit__c != '' ? objSpeSurvey.MarketUnit__c : '';
            countryVal = objSpeSurvey.Country__c != null && objSpeSurvey.Country__c != '' ? objSpeSurvey.Country__c : '';
            projectVal = objSpeSurvey.Project__c != null && objSpeSurvey.Project__c != '' ? objSpeSurvey.Project__c : '';
            
            buVal = objSpeSurvey.BusinessUnit__c != null && objSpeSurvey.BusinessUnit__c != '' ? objSpeSurvey.BusinessUnit__c : '';
            blVal = objSpeSurvey.BusinessLine__c != null && objSpeSurvey.BusinessLine__c != '' ? objSpeSurvey.BusinessLine__c : '';
            prdVal = objSpeSurvey.Product__c != null && objSpeSurvey.Product__c != '' ? objSpeSurvey.Product__c : '';
            
            caVal = objSpeSurvey.CategoryArea__c != null && objSpeSurvey.CategoryArea__c != '' ? objSpeSurvey.CategoryArea__c : '';
            cgVal = objSpeSurvey.CategoryGroup__c != null && objSpeSurvey.CategoryGroup__c != '' ? objSpeSurvey.CategoryGroup__c : '';
            ctVal = objSpeSurvey.Category__c != null && objSpeSurvey.Category__c != '' ? objSpeSurvey.Category__c : '';
            
    //----------------Code for Custom picklist Ends------------------------
   //--------------------Recurrence part Start ----------------------/
                    
             if(ApexPages.currentPage().getParameters().get('isClone') == null){
            CurrentUserId = UserInfo.getUserId();
            RecordOwnerId = [Select Id, ownerId from SPE2Survey__c
                           WHERE Id =: st.getId()].ownerId;
                      }
              selectedFrequency = objSpeSurvey.Recurrence_frequency_type__c;
              displaySaveButton = true;
         if(objSpeSurvey.Recurrence_Pattern__c == 'DayPerMonth'){
                  RecurrencePattern = 'DayPerMonth';
                  MonthFrequency1 = objSpeSurvey.FrequencyInMonths__c;
              }
              else if(objSpeSurvey.Recurrence_Pattern__c == 'WeekPerMonth'){
                  RecurrencePattern = 'WeekPerMonth';
                  MonthFrequency2 = objSpeSurvey.FrequencyInMonths__c;
              }
              else if(objSpeSurvey.Recurrence_Pattern__c == 'DayPerYear'){
                  RecurrencePattern = 'DayPerYear';
                  YearFrequency = String.ValueOf(Integer.ValueOf(objSpeSurvey.FrequencyInMonths__c)/12);
                  selectedMonthinYear = objSpeSurvey.Month_Value__c;
              }
              else if(objSpeSurvey.Recurrence_Pattern__c == 'WeekPerYear'){
                  RecurrencePattern = 'WeekPerYear';
                  YearFrequency = String.ValueOf(Integer.ValueOf(objSpeSurvey.FrequencyInMonths__c)/12);
                  selectedMonthinYear2 = objSpeSurvey.Month_Value__c;
              }
              
              selectedWeekInMonth = objSpeSurvey.Week_Count__c;
              selectedDayInMonth = objSpeSurvey.Day_name_of_upload_week__c;             
              selectedWeekInYear = objSpeSurvey.Yearly_Week_Count__c;
              selectedDayInYear = objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c;
              SurveyCloned = new SPE2Survey__c();
              
              if(Apexpages.currentPage().getParameters().get('isClone')!= null){
               objSpeSurvey = [SELECT Additional_Days_for_week__c,Additional_Days__c,BusinessLine__c,BusinessUnit__c,
                           CategoryGroup__c,CategoryArea__c ,Category__c,Country__c,Day_name_of_upload_week__c,EndDate__c,
                           FrequencyInMonths__c,Id,Is_One_Time_Survey__c,MarketUnit__c,Market__c,Month_Upload_Day__c,Name,
                           OwnerId,Product__c,Project__c,Recurrence_frequency_type__c,Recurrence_Pattern__c,Stage__c,
                           StartDate__c,SurveyExecutionBeforeIndays__c,SurveyReminderBeforeExecutionDate__c,Survey_Code__c,
                           Survey_Shut_Down__c,Upload_Day__c,Week_Count__c,Yearly_Day_Name_of_Upload_Week__c,Month_Value__c,
                           Yearly_Week_Count__c FROM SPE2Survey__c
                           WHERE Id =: st.getId()];
           
              }
              
              
             
   
   //--------------------Recurrence part End ------------------------/
            //SPE_MathsUtil.isEdit = true;
        
            /*if ([SELECT Id FROM SPE2_SurveyTracker__c WHERE Survey__c =: objSpeSurvey.Id] != null &&
                [SELECT Id FROM SPE2_SurveyTracker__c WHERE Survey__c =: objSpeSurvey.Id].size() > 0)
            {
                isTrackerCreated = true;
            }*/
             lstQuesSurveyAssoc = [select id,Name,PIData__c,QuestionLabel__c,Question_Bank__c,Survey__c,SurveyQuestion__c
                              FROM SPE2_Question_Survey_Association__c
                              WHERE Survey__c= : objSpeSurvey.Id];
             /*lstsurveyques = [select id,Name,PIData__c,QuestionLabel__c,Question_Bank__c,Parent_Survey_Question__c,SurveyQuestion__c
                              FROM SPE_SurveyQuestion__c
                              WHERE Question_Bank__c= : objSpeSurvey.Id];*/
             
             lstsurveysupplier = [select id,Supplier__c,SPE2_Survey__c
                              FROM SPE2_SurveySupplierMap__c
                              WHERE SPE2_Survey__c= : objSpeSurvey.Id];
                              
             lstsurveyrespondent = [select id,Contact__c,Email__c,Survey__c
                              FROM SPE2_Survey_Respondents__c
                              WHERE Survey__c= : objSpeSurvey.Id];
        
        }
        spePlanSuppliers = new List<SPE_SPEPlanSupplierMap__c>();
        
    }
    //----------------Code for Custom picklist starts------------------------
  
  //-----------------Fetch dropdown values of Market-------------
//--------------------Recurrence part Start ------------------------/  
   public void DatePattern(){
       mydate = System.today();
        
     //*********First,Second,Third,Fourth Sunday Calculation*********//        
        Date firstSunday = mydate.toStartOfMonth().toStartOfWeek();
        
        if(firstSunday < mydate.toStartOfmonth()){
            firstSunday = firstSunday.addDays(7);    
        }
        
        Date secondSunday = firstSunday.addDays(7);
        Date thirdSunday = firstSunday.addDays(14);
        Date fourthSunday = firstSunday.addDays(21);
        
     //*********First,Second,Third,Fourth Monday Calculation*********//
        Date firstMonday = mydate.toStartOfMonth().toStartOfWeek().addDays(1);
        
        if(firstMonday < mydate.toStartOfmonth()){
            firstMonday = firstMonday.addDays(7);    
        }
        
        Date secondMonday = firstMonday.addDays(7);
        Date thirdMonday = firstMonday.addDays(14);
        Date fourthMonday = firstMonday.addDays(21);
      
     //*********First,Second,Third,Fourth Tuesday Calculation*********//  
        Date firstTuesday = mydate.toStartOfMonth().toStartOfWeek().addDays(2);
        
        if(firstTuesday < mydate.toStartOfmonth()){
            firstTuesday = firstTuesday.addDays(7);    
        }
        
        Date secondTuesday = firstTuesday.addDays(7);
        Date thirdTuesday = firstTuesday.addDays(14);
        Date fourthTuesday = firstTuesday.addDays(21);
        
      //*********First,Second,Third,Fourth Wednesday Calculation*********//  
        Date firstWednesday = mydate.toStartOfMonth().toStartOfWeek().addDays(3);
        
        if(firstWednesday < mydate.toStartOfmonth()){
            firstWednesday = firstWednesday.addDays(7);    
        }
        
        Date secondWednesday = firstWednesday.addDays(7);
        Date thirdWednesday = firstWednesday.addDays(14);
        Date fourthWednesday = firstWednesday.addDays(21);
      
      //*********First,Second,Third,Fourth Thursday Calculation*********//  
        Date firstThursday = mydate.toStartOfMonth().toStartOfWeek().addDays(4);
        
        if(firstThursday < mydate.toStartOfmonth()){
            firstThursday = firstThursday.addDays(7);    
        }
        
        Date secondThursday = firstThursday.addDays(7);
        Date thirdThursday = firstThursday.addDays(14);
        Date fourthThursday = firstThursday.addDays(21);
       
      //*********First,Second,Third,Fourth Friday Calculation*********//  
        Date firstFriday = mydate.toStartOfMonth().toStartOfWeek().addDays(5);
        
        if(firstFriday < mydate.toStartOfmonth()){
            firstFriday = firstFriday.addDays(7);    
        }
        
        Date secondFriday = firstFriday.addDays(7);
        Date thirdFriday = firstFriday.addDays(14);
        Date fourthFriday = firstFriday.addDays(21);
      
      //*********First,Second,Third,Fourth Saturday Calculation*********//  
        Date firstSaturday = mydate.toStartOfMonth().toStartOfWeek().addDays(6);
        
        if(firstSaturday < mydate.toStartOfmonth()){
            firstSaturday = firstSaturday.addDays(7);    
        }
        
        Date secondSaturday = firstSaturday.addDays(7);
        Date thirdSaturday = firstSaturday.addDays(14);
        Date fourthSaturday = firstSaturday.addDays(21);
        
      //**********Map to store every combination of Date Value**************//  
        weekdatecombination  = new Map<String,Date>();
        
        weekdatecombination.put('First'+';'+'Sunday',firstSunday);
        weekdatecombination.put('Second'+';'+'Sunday',secondSunday);
        weekdatecombination.put('Third'+';'+'Sunday',thirdSunday);
        weekdatecombination.put('Fourth'+';'+'Sunday',fourthSunday);
        
        weekdatecombination.put('First'+';'+'Monday',firstMonday);
        weekdatecombination.put('Second'+';'+'Monday',secondMonday);
        weekdatecombination.put('Third'+';'+'Monday',thirdMonday);
        weekdatecombination.put('Fourth'+';'+'Monday',fourthMonday);
        
        weekdatecombination.put('First'+';'+'Tuesday',firstTuesday);
        weekdatecombination.put('Second'+';'+'Tuesday',secondTuesday);
        weekdatecombination.put('Third'+';'+'Tuesday',thirdTuesday);
        weekdatecombination.put('Fourth'+';'+'Tuesday',fourthTuesday);
        
        weekdatecombination.put('First'+';'+'Wednesday',firstWednesday);
        weekdatecombination.put('Second'+';'+'Wednesday',secondWednesday);
        weekdatecombination.put('Third'+';'+'Wednesday',thirdWednesday);
        weekdatecombination.put('Fourth'+';'+'Wednesday',fourthWednesday);
        
        weekdatecombination.put('First'+';'+'Thursday',firstThursday);
        weekdatecombination.put('Second'+';'+'Thursday',secondThursday);
        weekdatecombination.put('Third'+';'+'Thursday',thirdThursday);
        weekdatecombination.put('Fourth'+';'+'Thursday',fourthThursday);
        
        weekdatecombination.put('First'+';'+'Friday',firstFriday);
        weekdatecombination.put('Second'+';'+'Friday',secondFriday);
        weekdatecombination.put('Third'+';'+'Friday',thirdFriday);
        weekdatecombination.put('Fourth'+';'+'Friday',fourthFriday);
        
        weekdatecombination.put('First'+';'+'Saturday',firstSaturday);
        weekdatecombination.put('Second'+';'+'Saturday',secondSaturday);
        weekdatecombination.put('Third'+';'+'Saturday',thirdSaturday);
        weekdatecombination.put('Fourth'+';'+'Saturday',fourthSaturday);                 
    }
    
public pageReference displayRecurrence(){
                  system.debug('enter here');       
                  if(objSpeSurvey.Is_One_Time_Survey__c== false){          
                       RenderRecurrence = true;
                       selectedFrequency = objSpeSurvey.Recurrence_frequency_type__c;
                       RecurrencePattern = objSpeSurvey.Recurrence_Pattern__c;
                       selectedWeekInMonth = objSpeSurvey.Week_Count__c;
                       selectedDayInMonth = objSpeSurvey.Day_name_of_upload_week__c;  
                   }
                   else{
                       RenderRecurrence = false;
                   }      
                   return null;
               }  
   
public void closePopup() {        
    displayContinueButton = false;    
}

public void DisplaySaveCancelButton(){
    displaySaveButton = true;
}

public PageReference SaveCustom(){   
        objSpeSurvey.Market__c = marketVal;
        objSpeSurvey.BusinessUnit__c = buVal;
        objSpeSurvey.MarketUnit__c = marketUnitVal;
        objSpeSurvey.BusinessLine__c = blVal;
        objSpeSurvey.Country__c = countryVal;
        objSpeSurvey.Product__c = prdVal;
        objSpeSurvey.Project__c = projectVal;
        objSpeSurvey.CategoryArea__c = caVal;
        objSpeSurvey.CategoryGroup__c = cgVal;
        objSpeSurvey.Category__c = ctVal;
        objSpeSurvey.Stage__c = 'Draft';
 
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
        if(objSpeSurvey.Is_One_Time_Survey__c== false){
        
            system.debug('the first/second is: '+selectedWeekInMonth);
            system.debug('the dayname is: '+selectedDayInMonth);
            system.debug('the additional day is: '+ objSpeSurvey.Additional_Days_for_week__c);
            system.debug('the additional day is in days in week: '+objSpeSurvey.Additional_Days__c);
            system.debug('the RecurrencePattern is: '+RecurrencePattern);
                                 
             objSpeSurvey.Recurrence_frequency_type__c = selectedFrequency;
             objSpeSurvey.Recurrence_Pattern__c = RecurrencePattern;
             objSpeSurvey.Week_Count__c = selectedWeekInMonth;
             objSpeSurvey.Day_name_of_upload_week__c = selectedDayInMonth;
                  
             objSpeSurvey.Yearly_Week_Count__c = selectedWeekInYear;
             objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c = selectedDayInYear;
             
             isError = false;
             
             DatePattern();
             
             system.debug('the RecurrencePattern is: '+objSpeSurvey.Recurrence_Pattern__c);
             system.debug('the RecurrencePattern Frequency is: '+objSpeSurvey.Recurrence_frequency_type__c);
             system.debug('the first/second is: '+objSpeSurvey.Week_Count__c);
             system.debug('the dayname is: '+objSpeSurvey.Day_name_of_upload_week__c);
              
                  
             if(objSpeSurvey.Recurrence_frequency_type__c != '' && objSpeSurvey.Recurrence_frequency_type__c == 'Monthly'){
                 if(objSpeSurvey.Recurrence_Pattern__c == 'WeekPerMonth'){
                         if(objSpeSurvey.Week_Count__c != '' && objSpeSurvey.Day_name_of_upload_week__c != ''){
                             isError = false;
                             isError1 = false;
                             isError2 = false;
                             isError3 = false;
                             isError4 = false;
                             isError5 = false;
                             isError6 = false;
                             isError7 = false;
                             isError8 = false;
                         
                         Date initialdays = weekdatecombination.get(objSpeSurvey.Week_Count__c+';'+objSpeSurvey.Day_name_of_upload_week__c);
                         
                         if(objSpeSurvey.Additional_Days_for_week__c != Null){
                             Integer additional_days = Integer.ValueOf(objSpeSurvey.Additional_Days_for_week__c);
                             initialdays = initialdays.addDays(additional_days);
                         }
                         
                         if(MonthFrequency2 == Null || MonthFrequency2 == ''){
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));                         
                             isError4 = true;
                             return null;
                         }
                         
                         displaydate = initialdays.Day()+'/'+initialdays.Month()+'/'+initialdays.Year();
                                          
                        
                             objSpeSurvey.StartDate__c =  initialdays;                           
                             system.debug('the new StartDate__c is: '+objSpeSurvey.StartDate__c);
                         }
                                       
                          
                 
                 objSpeSurvey.Additional_Days__c = Null;
                 objSpeSurvey.Upload_Day__c = Null;
                 objSpeSurvey.FrequencyInMonths__c= MonthFrequency2;
                 objSpeSurvey.Month_Value__c = '';
                 objSpeSurvey.Yearly_Week_Count__c = '';
                 objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c = '';
                 objSpeSurvey.Month_Upload_Day__c = Null;             
             }            
             else if(objSpeSurvey.Recurrence_Pattern__c == 'DayPerMonth'){
                 if(objSpeSurvey.Upload_Day__c != Null){
                     Integer dayvalue = Integer.ValueOf(objSpeSurvey.Upload_Day__c);
                     Integer monthvalue = Integer.ValueOf(mydate.Month());
                     Integer yearvalue = Integer.ValueOf(mydate.Year());
                     isError = false;
                     isError1 = false;
                     isError2 = false;
                     isError3 = false;
                     isError4 = false;
                     isError5 = false;
                     isError6 = false;
                     isError7 = false;
                     isError8 = false;
                     
                     Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                     system.debug('the new StartDate__c is: '+new_pi_upload_date);
                     system.debug('the new StartDate__c is: '+mydate);
                     
                     Integer numberDays = Date.daysInMonth(yearvalue,monthvalue);
                     
                     if(dayvalue > numberDays){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Given Date should not be greater than of total days of Current Month'));
                        isError5 = true;
                        return null; 
                     }
                                                                    
                     if(objSpeSurvey.Additional_Days__c != Null){
                         Integer additional_days = Integer.ValueOf(objSpeSurvey.Additional_Days__c);
                         new_pi_upload_date = new_pi_upload_date.addDays(additional_days);
                     }
                     
                     if(MonthFrequency1 == Null || MonthFrequency1 == ''){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));
                         isError3 = true;
                         return null;
                     }
                     
                     displaydate = new_pi_upload_date.Day()+'/'+new_pi_upload_date.Month()+'/'+new_pi_upload_date.Year();
                     if(new_pi_upload_date >= mydate){             
                         objSpeSurvey.StartDate__c = new_pi_upload_date;
                         system.debug('the new StartDate__c is: '+objSpeSurvey.StartDate__c);
                     }
                     else if(new_pi_upload_date < mydate){
                         //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'The PI Upload Due Date "'+displaydate+'" is a past date. System will automatically change the date into future date on pressing Continue button'));
                         //displaySaveButton = false;
                         displayContinueButton = true;
                         return null; 
                     }
                                    
                     objSpeSurvey.Additional_Days_for_week__c = Null;    
                     objSpeSurvey.FrequencyInMonths__c = MonthFrequency1;
                     objSpeSurvey.Week_Count__c = '';
                     objSpeSurvey.Day_name_of_upload_week__c = '';
                     objSpeSurvey.Month_Value__c = '';
                     objSpeSurvey.Yearly_Week_Count__c = '';
                     objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c = '';
                     objSpeSurvey.Month_Upload_Day__c = Null;
                 }
                 else if(objSpeSurvey.Upload_Day__c == Null){
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Day value cannot be blank')); 
                     isError = true;
                     isError1 = false;
                     isError2 = false;
                     isError3 = false;
                     isError4 = false;
                     isError5 = false;
                     isError6 = false;
                     isError7 = false;
                     isError8 = false;
                     return null;
                 }
             }
             else if(objSpeSurvey.Recurrence_Pattern__c != 'WeekPerMonth' && objSpeSurvey.Recurrence_Pattern__c != 'DayPerMonth'){
                 //RecurrencePattern = '';
                 //objSpeSurvey.Recurrence_Pattern__c = '';
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select atleast one Recurrence Pattern')); 
                 isError = false;
                 isError1 = false;
                 isError2 = false;
                 isError3 = false;
                 isError4 = false;
                 isError5 = false;
                 isError6 = false;
                 isError7 = true;
                 isError8 = false;
                 return null;
             }
           }
           else if(objSpeSurvey.Recurrence_frequency_type__c != '' && objSpeSurvey.Recurrence_frequency_type__c == 'Yearly'){
                Map<String,Integer> mapMonthName = new Map<String,Integer>();
                     
                 mapMonthName.put('January',1);
                 mapMonthName.put('February',2);
                 mapMonthName.put('March',3);
                 mapMonthName.put('April',4);
                 mapMonthName.put('May',5);
                 mapMonthName.put('June',6);
                 mapMonthName.put('July',7);
                 mapMonthName.put('August',8);
                 mapMonthName.put('September',9);
                 mapMonthName.put('October',10);
                 mapMonthName.put('November',11);
                 mapMonthName.put('December',12);
                 
                 if(objSpeSurvey.Recurrence_Pattern__c == 'DayPerYear'){
                     objSpeSurvey.Month_Value__c = selectedMonthinYear;
                     if(objSpeSurvey.Month_Upload_Day__c != Null && objSpeSurvey.Month_Value__c != ''){
                         Integer dayvalue = Integer.ValueOf(objSpeSurvey.Month_Upload_Day__c);
                         Integer monthvalue = Integer.ValueOf(mapMonthName.get(objSpeSurvey.Month_Value__c));
                         Integer yearvalue = Integer.ValueOf(mydate.Year());
                         System.Debug('*********monthvalue*********'+monthvalue);
                         
                         isError = false;
                         isError1 = false;
                         isError2 = false;
                         isError3 = false;
                         isError4 = false;
                         isError5 = false;
                         isError6 = false;
                         isError7 = false;
                         isError8 = false;
                         
                         Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                         
                         Integer numberDays = Date.daysInMonth(yearvalue,monthvalue);
                         System.Debug('*********numberDays*********'+numberDays);
                         
                         if(dayvalue > numberDays){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Given Date should not be greater than of total days of Selected Month'));
                            isError6 = true;
                            return null; 
                         }
                         
                         if(YearFrequency == Null || YearFrequency == ''){
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));
                             isError1 = true;
                             return null;
                         }
                         
                         displaydate = new_pi_upload_date.Day()+'/'+new_pi_upload_date.Month()+'/'+new_pi_upload_date.Year();
                         objSpeSurvey.StartDate__c = new_pi_upload_date;            
                         objSpeSurvey.Additional_Days_for_week__c = Null;                        
                         objSpeSurvey.Week_Count__c = '';
                         objSpeSurvey.Day_name_of_upload_week__c = '';
                         objSpeSurvey.Upload_Day__c = Null;
                         objSpeSurvey.Additional_Days__c = Null;    
                         
                         objSpeSurvey.Yearly_Week_Count__c = '';
                         objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c = '';
                         objSpeSurvey.FrequencyInMonths__c = String.ValueOf(Integer.ValueOf(YearFrequency)*12);
                     }
                     else if(objSpeSurvey.Month_Upload_Day__c == Null){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Day value cannot be blank'));
                         isError2 = true;
                         isError = false;
                         isError1 = false;
                         isError3 = false;
                         isError4 = false;
                         isError5 = false;
                         isError6 = false;
                         isError7 = false;
                         isError8 = false;
                         return null;
                     } 
                 }
                 else if(objSpeSurvey.Recurrence_Pattern__c == 'WeekPerYear'){
                 objSpeSurvey.Month_Value__c = selectedMonthinYear2;
                 if(objSpeSurvey.Yearly_Week_Count__c != Null && objSpeSurvey.Month_Value__c != ''){
                     isError = false;
                     isError1 = false;
                     isError2 = false;
                     isError3 = false;
                     isError4 = false;
                     isError5 = false;
                     isError6 = false;
                     isError7 = false;
                     isError8 = false;
                     
                    if(YearFrequency == Null || YearFrequency == ''){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));
                         isError1 = true;
                         return null;
                     }
                     
                    Map<String,Date>  weekdatecombination  = new Map<String,Date>();
                    
                    Integer monthvalue = Integer.ValueOf(mapMonthName.get(objSpeSurvey.Month_Value__c));
                    Integer yearvalue = Integer.ValueOf(mydate.Year());
                     
                    Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,1);
                    Integer monthsBetween = mydate.monthsBetween(new_pi_upload_date);
                    
                     //*********First,Second,Third,Fourth Sunday Calculation*********//        
                    Date firstSunday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek();
                    
                    if(firstSunday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstSunday = firstSunday.addDays(7);    
                    }
                    
                    Date secondSunday = firstSunday.addDays(7);
                    Date thirdSunday = firstSunday.addDays(14);
                    Date fourthSunday = firstSunday.addDays(21);
                    
                 //*********First,Second,Third,Fourth Monday Calculation*********//
                    Date firstMonday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek().addDays(1);
                    
                    if(firstMonday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstMonday = firstMonday.addDays(7);    
                    }
                    
                    Date secondMonday = firstMonday.addDays(7);
                    Date thirdMonday = firstMonday.addDays(14);
                    Date fourthMonday = firstMonday.addDays(21);
                  
                 //*********First,Second,Third,Fourth Tuesday Calculation*********//  
                    Date firstTuesday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek().addDays(2);
                    
                    if(firstTuesday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstTuesday = firstTuesday.addDays(7);    
                    }
                    
                    Date secondTuesday = firstTuesday.addDays(7);
                    Date thirdTuesday = firstTuesday.addDays(14);
                    Date fourthTuesday = firstTuesday.addDays(21);
                    
                  //*********First,Second,Third,Fourth Wednesday Calculation*********//  
                    Date firstWednesday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek().addDays(3);
                    
                    if(firstWednesday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstWednesday = firstWednesday.addDays(7);    
                    }
                    
                    Date secondWednesday = firstWednesday.addDays(7);
                    Date thirdWednesday = firstWednesday.addDays(14);
                    Date fourthWednesday = firstWednesday.addDays(21);
                  
                  //*********First,Second,Third,Fourth Thursday Calculation*********//  
                    Date firstThursday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek().addDays(4);
                    
                    if(firstThursday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstThursday = firstThursday.addDays(7);    
                    }
                    
                    Date secondThursday = firstThursday.addDays(7);
                    Date thirdThursday = firstThursday.addDays(14);
                    Date fourthThursday = firstThursday.addDays(21);
                   
                  //*********First,Second,Third,Fourth Friday Calculation*********//  
                    Date firstFriday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek().addDays(5);
                    
                    if(firstFriday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstFriday = firstFriday.addDays(7);    
                    }
                    
                    Date secondFriday = firstFriday.addDays(7);
                    Date thirdFriday = firstFriday.addDays(14);
                    Date fourthFriday = firstFriday.addDays(21);
                  
                  //*********First,Second,Third,Fourth Saturday Calculation*********//  
                    Date firstSaturday = mydate.addMonths(monthsBetween).toStartOfMonth().toStartOfWeek().addDays(6);
                    
                    if(firstSaturday < mydate.addMonths(monthsBetween).toStartOfmonth()){
                        firstSaturday = firstSaturday.addDays(7);    
                    }
                    
                    Date secondSaturday = firstSaturday.addDays(7);
                    Date thirdSaturday = firstSaturday.addDays(14);
                    Date fourthSaturday = firstSaturday.addDays(21);
                    
                  //**********Map to store every combination of Date Value**************//                         
                    
                    weekdatecombination.put('First'+';'+'Sunday',firstSunday);
                    weekdatecombination.put('Second'+';'+'Sunday',secondSunday);
                    weekdatecombination.put('Third'+';'+'Sunday',thirdSunday);
                    weekdatecombination.put('Fourth'+';'+'Sunday',fourthSunday);
                    
                    weekdatecombination.put('First'+';'+'Monday',firstMonday);
                    weekdatecombination.put('Second'+';'+'Monday',secondMonday);
                    weekdatecombination.put('Third'+';'+'Monday',thirdMonday);
                    weekdatecombination.put('Fourth'+';'+'Monday',fourthMonday);
                    
                    weekdatecombination.put('First'+';'+'Tuesday',firstTuesday);
                    weekdatecombination.put('Second'+';'+'Tuesday',secondTuesday);
                    weekdatecombination.put('Third'+';'+'Tuesday',thirdTuesday);
                    weekdatecombination.put('Fourth'+';'+'Tuesday',fourthTuesday);
                    
                    weekdatecombination.put('First'+';'+'Wednesday',firstWednesday);
                    weekdatecombination.put('Second'+';'+'Wednesday',secondWednesday);
                    weekdatecombination.put('Third'+';'+'Wednesday',thirdWednesday);
                    weekdatecombination.put('Fourth'+';'+'Wednesday',fourthWednesday);
                    
                    weekdatecombination.put('First'+';'+'Thursday',firstThursday);
                    weekdatecombination.put('Second'+';'+'Thursday',secondThursday);
                    weekdatecombination.put('Third'+';'+'Thursday',thirdThursday);
                    weekdatecombination.put('Fourth'+';'+'Thursday',fourthThursday);
                    
                    weekdatecombination.put('First'+';'+'Friday',firstFriday);
                    weekdatecombination.put('Second'+';'+'Friday',secondFriday);
                    weekdatecombination.put('Third'+';'+'Friday',thirdFriday);
                    weekdatecombination.put('Fourth'+';'+'Friday',fourthFriday);
                    
                    weekdatecombination.put('First'+';'+'Saturday',firstSaturday);
                    weekdatecombination.put('Second'+';'+'Saturday',secondSaturday);
                    weekdatecombination.put('Third'+';'+'Saturday',thirdSaturday);
                    weekdatecombination.put('Fourth'+';'+'Saturday',fourthSaturday);
                    
                    new_pi_upload_date = weekdatecombination.get(objSpeSurvey.Yearly_Week_Count__c+';'+objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c);
                    displaydate = new_pi_upload_date.Day()+'/'+new_pi_upload_date.Month()+'/'+new_pi_upload_date.Year();                    
                    objSpeSurvey.StartDate__c = weekdatecombination.get(objSpeSurvey.Yearly_Week_Count__c+';'+objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c);              
                    objSpeSurvey.Additional_Days_for_week__c = Null;                                                          
                    objSpeSurvey.FrequencyInMonths__c = String.ValueOf(Integer.ValueOf(YearFrequency)*12);
                    objSpeSurvey.Week_Count__c = '';
                    objSpeSurvey.Upload_Day__c = Null;
                    objSpeSurvey.Additional_Days__c = Null;    
                    objSpeSurvey.Day_name_of_upload_week__c = '';
                    objSpeSurvey.Month_Upload_Day__c = Null;
                } 
              }
              else if(objSpeSurvey.Recurrence_Pattern__c != 'WeekPerYear' && objSpeSurvey.Recurrence_Pattern__c != 'DayPerYear'){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select atleast one Recurrence Pattern'));
                 isError = false;
                 isError1 = false;
                 isError2 = false;
                 isError3 = false;
                 isError4 = false;
                 isError5 = false;
                 isError6 = false;
                 isError7 = false;
                 isError8 = true;
                 return null; 
              }                                     
           }
         
        }
        
       
       else if(objSpeSurvey.Is_One_Time_Survey__c == true){
        isError = false;
        isError1 = false;
        isError2 = false;
        isError3 = false;
        isError4 = false;
        isError5 = false;
        isError6 = false;
        isError7 = false;
        isError8 = false;
        
        objSpeSurvey.Additional_Days_for_week__c = Null;
        objSpeSurvey.FrequencyInMonths__c= '0';                        
        objSpeSurvey.Week_Count__c = '';
        objSpeSurvey.Upload_Day__c = Null;
        objSpeSurvey.Additional_Days__c = Null;    
        objSpeSurvey.Day_name_of_upload_week__c = '';
        objSpeSurvey.Month_Upload_Day__c = Null;
        objSpeSurvey.Additional_Days_for_week__c = Null;    
        objSpeSurvey.Month_Value__c = '';
        objSpeSurvey.Yearly_Week_Count__c = '';
        objSpeSurvey.Yearly_Day_Name_of_Upload_Week__c = '';
        objSpeSurvey.Recurrence_Pattern__c = '';
        objSpeSurvey.Recurrence_frequency_type__c = '';
     }
       
   try{ 
        if (!UrlParameterMap.containsKey('isClone')){
            upsert objSpeSurvey;
            PageReference nextpage= new PageReference('/'+objSpeSurvey.id);
            return nextpage;
        }
        else{
            objSpeSurvey.ownerid= userinfo.getUserId(); 
            SurveyCloned = objSpeSurvey.clone(false,true,false,false);
            if(SurveyCloned!= null){
               SurveyCloned.Stage__c = 'Draft';
               insert SurveyCloned;
            }
             if(SurveyCloned.Id !=  null){
                    for(SPE2_Question_Survey_Association__c objSQ : lstQuesSurveyAssoc){
                         objSQ.Id = null;
                        objSQ.Survey__c= SurveyCloned.Id;
                    }
                    for(SPE2_SurveySupplierMap__c objSSM : lstsurveysupplier){
                        objSSM.Id = null;
                        objSSM.SPE2_Survey__c= SurveyCloned.Id;
                    }
                    for(SPE2_Survey_Respondents__c objSR : lstsurveyrespondent){
                        objSR.Id = null;
                        objSR.Survey__c= SurveyCloned.Id;
                    }
                    if(!lstQuesSurveyAssoc.isEmpty())
                        insert lstQuesSurveyAssoc;
                    if(!lstsurveysupplier.isEmpty())
                        insert lstsurveysupplier;
                    if(!lstsurveyrespondent.isEmpty())
                        insert lstsurveyrespondent;
                }
        system.debug('SurveyCloned::'+SurveyCloned);
        }   
      }
   catch(Exception e){
       message='Data Base error during saving...';
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
       return null;
   }
   Pagereference pr;
    if (!UrlParameterMap.containsKey('isClone'))
      pr = new Pagereference('/'+ objSpeSurvey.Id);
    else
      pr = new Pagereference('/'+ SurveyCloned.Id);
    return pr;



}
   
//--------------------Recurrence part End ------------------------/
    
     public List<SelectOption> getMarketValues() 
    {
        List<SelectOption> options = new List<SelectOption>();
        if(!setMarkets.contains(PicklistDefaultValues__c.getall().values()[0].Market__c))
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market__c,PicklistDefaultValues__c.getall().values()[0].Market__c));
        for(String s : setMarkets){
            options.add(new SelectOption(s,s));
        }
        system.debug('market is'+marketVal);
        
        return options;
    }
 
  
   
    //------- Fetch dropdown values of Market Unit ---------------
    
      public List<SelectOption> getMarketUnitValues() 
        {   
            fillMarketUnit();
            return mkoptions;
        }
    
        public void fillMarketUnit()
        {
            if(Apexpages.currentPage().getParameters().get('marketVal')!= null)
                marketVal = Apexpages.currentPage().getParameters().get('marketVal');
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            setMUVal = mapHierarchyDetails1.get(marketVal);
            
            if(!setMUVal.contains(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c))
                mkoptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,PicklistDefaultValues__c.getall().values()[0].Market_Unit__c));
            system.debug('marketVal---' + marketVal); 
            for(String s : mapHierarchyDetails1.get(marketVal)){
                mkoptions.add(new SelectOption(s,s));
              }
   
        }
       //----------------Fetch Dropdown Values for Country -----------------
        
        public List<SelectOption> getCountryValues() 
        {   
            fillCountry();
            return countryOptions;
        }
        
        public void fillCountry()
        {
            if(Apexpages.currentPage().getParameters().get('marketUnitVal')!= null)
                marketUnitVal = Apexpages.currentPage().getParameters().get('marketUnitVal');
            countryOptions = new List<SelectOption>();
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal)))
            {
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
    
            }
          else if(marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal);
                
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Country__c))
                    countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
                
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal)){
                    countryOptions.add(new SelectOption(s,s));
                }
            }
            
            else{
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
            }
            
        }
        
     //------------------Fetch dropdown values of Project------------------
    
        public List<SelectOption> getProjectValues() 
        {   
            fillProject();
            return projectOptions;
        }
        
        public void fillProject()
        {
            if(Apexpages.currentPage().getParameters().get('countryVal')!= null)
                countryVal = Apexpages.currentPage().getParameters().get('countryVal');
            projectOptions = new List<SelectOption>();
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || (marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c) || (countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal+countryVal)) )
            {
                 projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
            
            else if(countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal);
                
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Project__c))
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
                
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal)){
                    projectOptions.add(new SelectOption(s,s));
                }
            }
            else{
                projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
            
        }
        
        //--------------Fetch dropdown values of Business Units------------------------------
        
       public List<SelectOption> getBusinessUnitValues() 
        {
            List<SelectOption> options = new List<SelectOption>();
            if(!setBusinessUnits.contains(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c,PicklistDefaultValues__c.getall().values()[0].Business_Unit__c));
            for(String s : setBusinessUnits){
                options.add(new SelectOption(s,s));
            }
            
            return options;
        }
     
     //--------------------Fetch dropdown values for Business Line-------------------
         
          public List<SelectOption> getBusinesLineValues() 
        {   
            fillBusinessLine();
            return BusinessLineOptions;
        }
        
       public void fillBusinessLine()
        {
            if(Apexpages.currentPage().getParameters().get('buVal')!= null)
                buVal= Apexpages.currentPage().getParameters().get('buVal');
            BusinessLineOptions= new List<SelectOption>();
            Set<String> setBUVal = new Set<String>();
            setBUVal = mapHierarchyDetails1.get(buVal);
            if(!setBUVal.contains(PicklistDefaultValues__c.getall().values()[0].Business_Line__c))
                BusinessLineOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Line__c,PicklistDefaultValues__c.getall().values()[0].Business_Line__c));
           
            for(String s : mapHierarchyDetails1.get(buVal)){
                BusinessLineOptions.add(new SelectOption(s,s));
            }
        }
    
    
    //----------------Fetch dropdown values for Product------------------------------
    
          public List<SelectOption> getProductValues() 
        {   
            fillProduct();
            return ProductOptions;
        }
       public void showProdVals(){
           fillProduct();
       } 
       public void fillProduct()
        {
            
            if(Apexpages.currentPage().getParameters().get('blVal')!= null)
                blVal= Apexpages.currentPage().getParameters().get('blVal');
            
            system.debug('I am here-blVal--' + blVal);
            system.debug('I am here-buVal--' + buVal);
            ProductOptions= new List<SelectOption>();
            lstTemp = new Set<String>();
            Set<String> setProductVal = new Set<String>();
            setProductVal = mapHierarchyDetails1.get(buVal+blVal);
            
             if((buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) || !(mapHierarchyDetails1.containsKey(buVal+blVal)))
            {
              system.debug('I am here---');
              ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
              lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
            
            else if(!setProductVal .contains(PicklistDefaultValues__c.getall().values()[0].Product__c)){
                ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
                lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);  
                for(String s : mapHierarchyDetails1.get(buVal+blVal)){
                    ProductOptions.add(new SelectOption(s,s));
                    lstTemp.add(s);  
                }
            }
            else{
             ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
             lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
        }
        
  
    //--------------Fetch dropdown values for Category Area--------------------
    
      
       public List<SelectOption> getCategoryAreaValues() 
        {
            List<SelectOption> options = new List<SelectOption>();
            if(!setCategoryArea.contains(PicklistDefaultValues__c.getall().values()[0].Category_Area__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Area__c,PicklistDefaultValues__c.getall().values()[0].Category_Area__c));
            for(String s : setCategoryArea ){
                options.add(new SelectOption(s,s));
            }
            
            return options;
        }
     
    //-----------------Fetch dropdown values for Category Group---------------------------
    
        public List<SelectOption> getCategoryGroupValues() 
        {   
            fillCategoryGroup();
            return CatGroupOptions;
        }
        
       public void fillCategoryGroup()
        {
            if(Apexpages.currentPage().getParameters().get('caVal')!= null)
                caVal = Apexpages.currentPage().getParameters().get('caVal');
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            if(!setCatGroupVal.contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c))
                CatGroupOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Group__c,PicklistDefaultValues__c.getall().values()[0].Category_Group__c));
           
            for(String s : mapHierarchyDetails1.get(caVal)){
                CatGroupOptions.add(new SelectOption(s,s));
            }
        }
    
    //----------------------Fetch drop down values for Category----------------------------
    
         public List<SelectOption> getCategoryValues() 
        {   
            fillCategory();
            return CategoryOptions;
        }
        
       public void fillCategory()
        {
            if(Apexpages.currentPage().getParameters().get('cgVal')!= null)
                cgVal = Apexpages.currentPage().getParameters().get('cgVal');
            CategoryOptions= new List<SelectOption>();
            Set<String> setCatVal = new Set<String>();
            setCatVal = mapHierarchyDetails1.get(caVal+cgVal);
            
             if((caVal== PicklistDefaultValues__c.getall().values()[0].Category_Area__c) || !(mapHierarchyDetails1.containsKey(caVal+cgVal)))
            {
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
           
            }
            
         else  if(!setCatVal .contains(PicklistDefaultValues__c.getall().values()[0].Category__c)){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
           
            for(String s : mapHierarchyDetails1.get(caVal+cgVal)){
                CategoryOptions.add(new SelectOption(s,s));
            }
          }
          
          else
          
           CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
      
        }
        
        public void blankMethod(){}
              
    
 //----------------Code for Custom picklist ends------------------------
    public Pagereference save() 
    {
        
        //system.debug();
        objSpeSurvey.Market__c = marketVal;
        objSpeSurvey.BusinessUnit__c = buVal;
        objSpeSurvey.MarketUnit__c = marketUnitVal;
        objSpeSurvey.BusinessLine__c = blVal;
        objSpeSurvey.Country__c = countryVal;
        objSpeSurvey.Product__c = prdVal;
        objSpeSurvey.Project__c = projectVal;
        objSpeSurvey.CategoryArea__c = caVal;
        objSpeSurvey.CategoryGroup__c = cgVal;
        objSpeSurvey.Category__c = ctVal;
                
        try
        {
            //if (checkValidation())
            //{
                upsert objSpeSurvey;
            //}
            /*else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
                return null;
            }*/
            
        }
        catch(Exception ex)
        {
           ApexPages.addMessages(ex);
           return null;
        }
    
        Boolean isAbended = false;
        
        if (startDate != objSpeSurvey.StartDate__c ||
            endDate != objSpeSurvey.EndDate__c ||
            Decimal.valueOf(objSpeSurvey.FrequencyInMonths__c) != frequencyInMonths
           ) 
        {
            isAbended = true;
        }
        
         
        if (objSpeSurvey.Stage__c == 'Published')
        {
            
            List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = createSPETracker(objSpeSurvey, isAbended);
            
            upsert toBeInsertedSPETracker;
        }  
      Pagereference pr = new Pagereference('/' + objSpeSurvey.Id);
        
        return pr;  
       
    }
    
    /*private Boolean checkValidation()
    {
        
        if (objSpeSurvey.StartDate__c > objSpeSurvey.EndDate__c )
        {   
            errorMsg = 'Survey: Start date should always be lesser than Survey End Date';
            return false; 
        }
        
        if (objSpeSurvey.StartDate__c <= system.today())
        {   
            errorMsg = 'Survey: Start date should be future Date';
            return false; 
        }
        
        if (objSpeSurvey.EndDate__c > objSpeSurvey.StartDate__c.addYears(5))
        {
            errorMsg = 'Survey: End date should not be more than 5 years of Survey Start Date';
            return false; 
        }
        
        if (objSpeSurvey.SurveyExecutionBeforeIndays__c < objSpeSurvey.SurveyReminderBeforeExecutionDate__c )
        {
            errorMsg = 'Survey: Survey Reminder before Day should always be lesser than survey execution';
            return false; 
        }
        return true;
    }*/
    
    private List<SPE2_SurveyTracker__c> createSPETracker (SPE2Survey__c objSpeSurvey, Boolean isAbended)
    {
        List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = new List<SPE2_SurveyTracker__c>();
        
        if (isAbended)
        {
            List<SPE2_SurveyTracker__c> toBeAbendedTracker = [SELECT Id, Survey__c, Status__c 
                                                          FROM SPE2_SurveyTracker__c
                                                          WHERE Status__c =  'Pending' AND  Survey__c =: objSpeSurvey.Id];
                                                          
            for (SPE2_SurveyTracker__c tracker : toBeAbendedTracker)
            {
                tracker.Status__c = 'Abandoned';
                toBeInsertedSPETracker.add(tracker);
            }
        
            Date strtDate = objSpeSurvey.StartDate__c;
            
            List<Date> toBeStartTracker = new List<Date>();///
            
            /*
            while (strtDate <= objSpeSurvey.EndDate__c )
            {
                toBeStartTracker.add(strtDate);
                
                if(objSpeSurvey.FrequencyInMonths__c != '0'){
                    strtDate = strtDate.addMonths(Integer.valueOf(objSpeSurvey.FrequencyInMonths__c));
                    
                }
                else{
                    break;
                }
            }*/
            
            if (objSpeSurvey.FrequencyInMonths__c == '0')
            {
                toBeStartTracker.add(strtDate);
            }
            else
            {
                while (strtDate <= objSpeSurvey.EndDate__c )
                {
                    toBeStartTracker.add(strtDate);
                    
                    strtDate = strtDate.addMonths(Integer.valueOf(objSpeSurvey.FrequencyInMonths__c));
                }
            }
            
            for  (Date sDate : toBeStartTracker)
            {
                SPE2_SurveyTracker__c surveyTracker = new SPE2_SurveyTracker__c();
                surveyTracker.Name = SPE_Utility.monthsMap.get(sDate.addMonths(-1).month()) + ' - '+ String.valueOf(sDate.addMonths(-1).year());
                surveyTracker.Survey__c = objSpeSurvey.Id;
                //surveyTracker.SPETemplate__c = objSpeSurvey.SPETemplate__c;
                surveyTracker.DateOfExecution__c = sDate;
                surveyTracker.Status__c = 'Pending';
                
                surveyTracker.Market__c = objSpeSurvey.Market__c;
                surveyTracker.MarketUnit__c = objSpeSurvey.MarketUnit__c;
                surveyTracker.Country__c = objSpeSurvey.Country__c;
                surveyTracker.Project__c = objSpeSurvey.Project__c;
                
                surveyTracker.BusinessLine__c = objSpeSurvey.BusinessLine__c;
                surveyTracker.BusinessUnit__c = objSpeSurvey.BusinessUnit__c;
                surveyTracker.Product__c = objSpeSurvey.Product__c;
                
                surveyTracker.Category__c = objSpeSurvey.Category__c;
                surveyTracker.CategoryGroup__c = objSpeSurvey.CategoryGroup__c;
                surveyTracker.CategoryArea__c = objSpeSurvey.CategoryArea__c;
                
                toBeInsertedSPETracker.add(surveyTracker);
            }
        } 
        return toBeInsertedSPETracker;
    }
    
    public Pagereference generateTracker()
    {
        objSpeSurvey.Stage__c = 'Published';
        update objSpeSurvey;
    
        List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = createSPETracker(objSpeSurvey, true);
            
        insert toBeInsertedSPETracker;  
        
        Pagereference pr = new Pagereference('/' + objSpeSurvey.Id);
        
        return pr;
    } 
}