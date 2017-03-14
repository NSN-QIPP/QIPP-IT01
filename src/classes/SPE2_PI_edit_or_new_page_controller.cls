public with sharing class SPE2_PI_edit_or_new_page_controller {
    public String var {get;set;}
    public date uploadDate;
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
    public Boolean isDisablePublished{get;set;}
    
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
    public Boolean StandaloneSUrveyType  {get;set;}
    public Boolean cloneStage {get;set;}
   
/***************************** PI Definition Fields ***********************************/
Public String Id{get;set;}
public boolean chkThis{get;set;}
public date mydate;
public Map<String,Date> weekdatecombination;

/************************General Recurrence variables ******************************************/
public string selectedFrequency{get;set;}
public boolean RenderRecurrence{get;set;}

/*************************Monthly variables ******************************************/
public string ChildRadio{get;set;}
public string DayCount{get;set;}
public string MonthFrequency1{get;set;}
public string MonthFrequency2{get;set;}
public string WeekNumber{get;set;}
public string DayOfTheWeek{get;set;}


/**************************Yearly variables ******************************************/
public string YearFrequency{get;set;}
public string MonthName{get;set;}
public string DayOftheMonth{get;set;}
/************Range of Recurrence variables ******************************************/
public string RecurrencePattern{get;set;}
public string RangeRadioVal{get;set;}
public string EndAfterOccurence{get;set;}
public string RecurStartDate{get;set;}
public string PageId{get;set;}
public SPE_PIDefinition__c customerObj{get;set;}
private SPE_PIDefinition__c PIdefinitionCloned;  
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
public Boolean isError9{get;set;}

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
   
    public SPE2_PI_edit_or_new_page_controller(ApexPages.StandardController controller) {
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
         isError9 = false;
         cloneStage = false;
         StandaloneSUrveyType  = false;
         displayDataAcSection = 'false';
         isDisablePublished = false;
         RenderRecurrence = false;
         message = '';
         PageId = ApexPages.currentPage().getParameters().get('Id');         
         
         displayContinueButton = false;
         this.StandardController =controller;                            
           if(PageId != NULL){
               
             customerObj = new SPE_PIDefinition__c();
             customerObj = [SELECT Id,PICode__c,PIUploadDuedate__c,ownerid,PI_Title__c,LifecycleStage__c,PIAbbreviation__c,Business__c,
                                     Type__c,DataAcquisitionMethod__c,ValuesType__c,SurveyQuestion__c,OperationalType__c,UoM__c,
                                     PurposeAndObjective__c,Day_name_of_upload_week__c,End_Date__c,Recurrence_frequency_type__c,
                                     Recurrence_Pattern__c,Week_Count__c,Additional_Days_for_week__c,Frequency__c,
                                     GeoScope__c,CategoryScope__c,BUScope__c,Upload_Day__c,Additional_Days__c,
                                     Yearly_Day_Name_of_Upload_Week__c,Yearly_Week_Count__c,Month_Upload_Day__c,Month_Value__c
                                     
                                     FROM SPE_PIDefinition__c WHERE id=:PageId];
                                     
             if(ApexPages.currentPage().getParameters().get('isClone') == null){
                CurrentUserId = UserInfo.getUserId();
                RecordOwnerId = [Select Id, ownerId from SPE_PIDefinition__c 
                               WHERE Id =: controller.getId()].ownerId;
                }
              if(customerObj.LifecycleStage__c == 'Published' && Apexpages.currentPage().getParameters().get('isClone') == null){
                 isDisablePublished = true; 
              }  
              selectedFrequency = customerObj.Recurrence_frequency_type__c;
              displaySaveButton = true;
              displayButton = false;
              
              if(customerObj.Recurrence_Pattern__c == 'DayPerMonth'){
                  RecurrencePattern = 'DayPerMonth';
                  MonthFrequency1 = customerObj.Frequency__c;
              }
              else if(customerObj.Recurrence_Pattern__c == 'WeekPerMonth'){
                  RecurrencePattern = 'WeekPerMonth';
                  MonthFrequency2 = customerObj.Frequency__c;
              }
              else if(customerObj.Recurrence_Pattern__c == 'DayPerYear'){
                  RecurrencePattern = 'DayPerYear';
                  YearFrequency = String.ValueOf(Integer.ValueOf(customerObj.Frequency__c)/12);
                  selectedMonthinYear = customerObj.Month_Value__c;
              }
              else if(customerObj.Recurrence_Pattern__c == 'WeekPerYear'){
                  RecurrencePattern = 'WeekPerYear';
                  YearFrequency = String.ValueOf(Integer.ValueOf(customerObj.Frequency__c)/12);
                  selectedMonthinYear2 = customerObj.Month_Value__c;
              }
              
              selectedWeekInMonth = customerObj.Week_Count__c;
              selectedDayInMonth = customerObj.Day_name_of_upload_week__c;             
              selectedWeekInYear = customerObj.Yearly_Week_Count__c;
              selectedDayInYear = customerObj.Yearly_Day_Name_of_Upload_Week__c;
              
              if(customerObj.DataAcquisitionMethod__c == 'Data Load'){
                  RenderRecurrence = true;
                  StandaloneSUrveyType = false;
              }
              else if(customerObj.DataAcquisitionMethod__c == 'Survey'){
                  RenderRecurrence = false;
                  StandaloneSUrveyType = false;
              }
              else if(customerObj.DataAcquisitionMethod__c == 'Standalone Survey'){
                  RenderRecurrence = false;
                  StandaloneSUrveyType = true;
              }
              PIdefId =controller.getId();
              system.debug('PIdefId ::'+PIdefId );
              PIdefinitionCloned = new SPE_PIDefinition__c();
              if(Apexpages.currentPage().getParameters().get('isClone')!= null){
              customerObj = [SELECT Id,PICode__c,PIUploadDuedate__c,ownerid,PI_Title__c,LifecycleStage__c,PIAbbreviation__c,Business__c,
                                     Type__c,DataAcquisitionMethod__c,ValuesType__c,SurveyQuestion__c,OperationalType__c,UoM__c,
                                     PurposeAndObjective__c,Day_name_of_upload_week__c,End_Date__c,Recurrence_frequency_type__c,
                                     Recurrence_Pattern__c,Week_Count__c,Additional_Days_for_week__c,Frequency__c,
                                     GeoScope__c,CategoryScope__c,BUScope__c,Upload_Day__c,Month_Upload_Day__c,Additional_Days__c
                                     FROM SPE_PIDefinition__c WHERE id=:PIdefId];
              cloneStage = true;
              customerObj.LifecycleStage__c = 'Draft';
              }                       
             system.debug('customerObj ::'+customerObj);                                                       
          } 
          
          else{
              displaySaveButton = false;
              displayButton = true; 
              customerObj = new SPE_PIDefinition__c(ownerid= userinfo.getUserId(),Recurrence_frequency_type__c='Monthly',Recurrence_Pattern__c = 'DayPerMonth',LifecycleStage__c='Draft');
              RecurrencePattern = 'DayPerMonth';
          }           
                
    }
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
     public Pagereference pageredir(){
        var= ApexPages.currentPage().getParameters().get('Id'); 
        if(var!=null)
            {
            Pagereference newpage = new Pagereference ('/apex/SPE2_PI_edit_or_new_page?'+var+'&action=edit');
            return newpage;
            }
        else
            {
            Pagereference newpage =Page.SPE2_PI_edit_or_new_page; 
            return newpage;
            }
     }
     
   public pageReference displayRecurrence(){
       system.debug('enter here');       
        RenderRecurrence = true; 
       if(customerObj.DataAcquisitionMethod__c == 'Data Load'){          
           RenderRecurrence = true;
           StandaloneSUrveyType = false;
           selectedFrequency = customerObj.Recurrence_frequency_type__c;
           RecurrencePattern = customerObj.Recurrence_Pattern__c;
           selectedWeekInMonth = customerObj.Week_Count__c;
           selectedDayInMonth = customerObj.Day_name_of_upload_week__c;  
       }
       else if(customerObj.DataAcquisitionMethod__c == 'Survey'){
           RenderRecurrence = false;
           StandaloneSUrveyType = false;
       }   
       else{
           RenderRecurrence = false;
           StandaloneSUrveyType = true;
       }
          
       return null;
   }
/*****apex actions methods*****/
public PageReference CountinueCustom(){
    Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
    if(customerObj.DataAcquisitionMethod__c == 'Data Load'){
        customerObj.Recurrence_frequency_type__c = selectedFrequency;
        customerObj.Recurrence_Pattern__c = RecurrencePattern;
        customerObj.Week_Count__c = selectedWeekInMonth;
        customerObj.Day_name_of_upload_week__c = selectedDayInMonth;
              
        customerObj.Yearly_Week_Count__c = selectedWeekInYear;
        customerObj.Yearly_Day_Name_of_Upload_Week__c = selectedDayInYear;
         
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
         
        if(customerObj.Recurrence_Pattern__c == 'DayPerMonth'){
            if(customerObj.Upload_Day__c != Null){
                Integer dayvalue = Integer.ValueOf(customerObj.Upload_Day__c);
                Integer monthvalue = Integer.ValueOf(mydate.Month());
                Integer yearvalue = Integer.ValueOf(mydate.Year());
                 
                Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                system.debug('the new PIUploadDuedate__c is: '+new_pi_upload_date);
                system.debug('the new PIUploadDuedate__c is: '+mydate);
                                           
                if(customerObj.Additional_Days__c != Null){
                     Integer additional_days = Integer.ValueOf(customerObj.Additional_Days__c);
                     new_pi_upload_date = new_pi_upload_date.addDays(additional_days);
                }
                if(new_pi_upload_date < mydate){     
                    customerObj.PIUploadDuedate__c =  new_pi_upload_date.addMonths(1);
                }
                else if(new_pi_upload_date > mydate){
                   customerObj.PIUploadDuedate__c =  new_pi_upload_date;
                }    
                
                customerObj.Additional_Days_for_week__c = Null;    
                customerObj.Frequency__c = MonthFrequency1;
                customerObj.Week_Count__c = '';
                customerObj.Day_name_of_upload_week__c = '';
                customerObj.Month_Value__c = '';
                customerObj.Yearly_Week_Count__c = '';
                customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
                customerObj.Month_Upload_Day__c = Null;
            }
            else if(customerObj.Upload_Day__c == Null){
                isError = true;
                return null;
            }           
         }
         else if(customerObj.Recurrence_Pattern__c == 'WeekPerMonth'){
            DatePattern();
            Date initialdays = weekdatecombination.get(customerObj.Week_Count__c+';'+customerObj.Day_name_of_upload_week__c);
            
            if(customerObj.Additional_Days_for_week__c != Null){
                 Integer additional_days = Integer.ValueOf(customerObj.Additional_Days_for_week__c);
                 initialdays = initialdays.addDays(additional_days);
             }
              
             if(initialdays > mydate){
                 customerObj.PIUploadDuedate__c =  initialdays;                           
                 system.debug('the new PIUploadDuedate__c is: '+customerObj.PIUploadDuedate__c);
             }
             else if(initialdays < mydate){
                //*********First,Second,Third,Fourth Sunday Calculation*********//        
                Date firstSunday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek();
                
                if(firstSunday < mydate.addMonths(1).toStartOfmonth()){
                    firstSunday = firstSunday.addDays(7);    
                }
                
                Date secondSunday = firstSunday.addDays(7);
                Date thirdSunday = firstSunday.addDays(14);
                Date fourthSunday = firstSunday.addDays(21);
                
             //*********First,Second,Third,Fourth Monday Calculation*********//
                Date firstMonday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek().addDays(1);
                
                if(firstMonday < mydate.addMonths(1).toStartOfmonth()){
                    firstMonday = firstMonday.addDays(7);    
                }
                
                Date secondMonday = firstMonday.addDays(7);
                Date thirdMonday = firstMonday.addDays(14);
                Date fourthMonday = firstMonday.addDays(21);
              
             //*********First,Second,Third,Fourth Tuesday Calculation*********//  
                Date firstTuesday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek().addDays(2);
                
                if(firstTuesday < mydate.addMonths(1).toStartOfmonth()){
                    firstTuesday = firstTuesday.addDays(7);    
                }
                
                Date secondTuesday = firstTuesday.addDays(7);
                Date thirdTuesday = firstTuesday.addDays(14);
                Date fourthTuesday = firstTuesday.addDays(21);
                
              //*********First,Second,Third,Fourth Wednesday Calculation*********//  
                Date firstWednesday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek().addDays(3);
                
                if(firstWednesday < mydate.addMonths(1).toStartOfmonth()){
                    firstWednesday = firstWednesday.addDays(7);    
                }
                
                Date secondWednesday = firstWednesday.addDays(7);
                Date thirdWednesday = firstWednesday.addDays(14);
                Date fourthWednesday = firstWednesday.addDays(21);
              
              //*********First,Second,Third,Fourth Thursday Calculation*********//  
                Date firstThursday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek().addDays(4);
                
                if(firstThursday < mydate.addMonths(1).toStartOfmonth()){
                    firstThursday = firstThursday.addDays(7);    
                }
                
                Date secondThursday = firstThursday.addDays(7);
                Date thirdThursday = firstThursday.addDays(14);
                Date fourthThursday = firstThursday.addDays(21);
               
              //*********First,Second,Third,Fourth Friday Calculation*********//  
                Date firstFriday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek().addDays(5);
                
                if(firstFriday < mydate.addMonths(1).toStartOfmonth()){
                    firstFriday = firstFriday.addDays(7);    
                }
                
                Date secondFriday = firstFriday.addDays(7);
                Date thirdFriday = firstFriday.addDays(14);
                Date fourthFriday = firstFriday.addDays(21);
              
              //*********First,Second,Third,Fourth Saturday Calculation*********//  
                Date firstSaturday = mydate.addMonths(1).toStartOfMonth().toStartOfWeek().addDays(6);
                
                if(firstSaturday < mydate.addMonths(1).toStartOfmonth()){
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
                
                if(customerObj.Week_Count__c != '' && customerObj.Day_name_of_upload_week__c != ''){
                     
                 initialdays = weekdatecombination.get(customerObj.Week_Count__c+';'+customerObj.Day_name_of_upload_week__c);
                 
                 if(customerObj.Additional_Days_for_week__c != Null){
                     Integer additional_days = Integer.ValueOf(customerObj.Additional_Days_for_week__c);
                     initialdays = initialdays.addDays(additional_days);
                 }
                                  
                 customerObj.PIUploadDuedate__c =  initialdays;                           
                 system.debug('the new PIUploadDuedate__c is: '+customerObj.PIUploadDuedate__c);
                 }
             }
             customerObj.Additional_Days__c = Null;
             customerObj.Upload_Day__c = Null;
             customerObj.Frequency__c = MonthFrequency2;
             customerObj.Month_Value__c = '';
             customerObj.Yearly_Week_Count__c = '';
             customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
             customerObj.Month_Upload_Day__c = Null;
         }
             
         else if(customerObj.Recurrence_Pattern__c == 'DayPerYear'){
             customerObj.Month_Value__c = selectedMonthinYear;
             if(customerObj.Month_Upload_Day__c != Null && customerObj.Month_Value__c != ''){
                 Integer dayvalue = Integer.ValueOf(customerObj.Month_Upload_Day__c);
                 Integer monthvalue = Integer.ValueOf(mapMonthName.get(customerObj.Month_Value__c));
                 Integer yearvalue = Integer.ValueOf(mydate.Year());
                 
                 Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                 
                 if(new_pi_upload_date < mydate){
                     customerObj.PIUploadDuedate__c = new_pi_upload_date.addYears(1);
                 }
                 else if(new_pi_upload_date > mydate){
                     customerObj.PIUploadDuedate__c = new_pi_upload_date;
                 }
                 
                 customerObj.Additional_Days_for_week__c = Null;                        
                 customerObj.Week_Count__c = '';
                 customerObj.Day_name_of_upload_week__c = '';
                 customerObj.Upload_Day__c = Null;
                 customerObj.Additional_Days__c = Null;    
                 
                 customerObj.Yearly_Week_Count__c = '';
                 customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
                 customerObj.Frequency__c = String.ValueOf(Integer.ValueOf(YearFrequency)*12);                
             }
             else if(customerObj.Month_Upload_Day__c == Null){
                 isError = true;
                 return null;
             }
         }
         else if(customerObj.Recurrence_Pattern__c == 'WeekPerYear'){
             customerObj.Month_Value__c = selectedMonthinYear2;
             if(customerObj.Yearly_Week_Count__c != Null && customerObj.Month_Value__c != ''){
                 
                Map<String,Date>  weekdatecombination  = new Map<String,Date>();
                
                Integer monthvalue = Integer.ValueOf(mapMonthName.get(customerObj.Month_Value__c));
                Integer yearvalue = Integer.ValueOf(mydate.Year());
                 
                Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,1);
                Integer monthsBetween = mydate.monthsBetween(new_pi_upload_date);
                
                if(monthsBetween < 0){ 
                  //*********First,Second,Third,Fourth Sunday Calculation*********//        
                    Date firstSunday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek();
                    
                    if(firstSunday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                        firstSunday = firstSunday.addDays(7);    
                    }
                    
                    Date secondSunday = firstSunday.addDays(7);
                    Date thirdSunday = firstSunday.addDays(14);
                    Date fourthSunday = firstSunday.addDays(21);
                    
                 //*********First,Second,Third,Fourth Monday Calculation*********//
                    Date firstMonday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(1);
                    
                    if(firstMonday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                        firstMonday = firstMonday.addDays(7);    
                    }
                    
                    Date secondMonday = firstMonday.addDays(7);
                    Date thirdMonday = firstMonday.addDays(14);
                    Date fourthMonday = firstMonday.addDays(21);
                  
                 //*********First,Second,Third,Fourth Tuesday Calculation*********//  
                    Date firstTuesday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(2);
                    
                    if(firstTuesday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                        firstTuesday = firstTuesday.addDays(7);    
                    }
                    
                    Date secondTuesday = firstTuesday.addDays(7);
                    Date thirdTuesday = firstTuesday.addDays(14);
                    Date fourthTuesday = firstTuesday.addDays(21);
                    
                  //*********First,Second,Third,Fourth Wednesday Calculation*********//  
                    Date firstWednesday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(3);
                    
                    if(firstWednesday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                        firstWednesday = firstWednesday.addDays(7);    
                    }
                    
                    Date secondWednesday = firstWednesday.addDays(7);
                    Date thirdWednesday = firstWednesday.addDays(14);
                    Date fourthWednesday = firstWednesday.addDays(21);
                  
                  //*********First,Second,Third,Fourth Thursday Calculation*********//  
                    Date firstThursday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(4);
                    
                    if(firstThursday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                        firstThursday = firstThursday.addDays(7);    
                    }
                    
                    Date secondThursday = firstThursday.addDays(7);
                    Date thirdThursday = firstThursday.addDays(14);
                    Date fourthThursday = firstThursday.addDays(21);
                   
                  //*********First,Second,Third,Fourth Friday Calculation*********//  
                    Date firstFriday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(5);
                    
                    if(firstFriday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                        firstFriday = firstFriday.addDays(7);    
                    }
                    
                    Date secondFriday = firstFriday.addDays(7);
                    Date thirdFriday = firstFriday.addDays(14);
                    Date fourthFriday = firstFriday.addDays(21);
                  
                  //*********First,Second,Third,Fourth Saturday Calculation*********//  
                    Date firstSaturday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(6);
                    
                    if(firstSaturday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
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
                
                    customerObj.PIUploadDuedate__c = weekdatecombination.get(customerObj.Yearly_Week_Count__c+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c);
                }
                else if(monthsBetween >= 0){
                
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
                    
                    weekdatecombination.put('First'+'1'+';'+'Sunday',firstSunday);
                    weekdatecombination.put('Second'+'1'+';'+'Sunday',secondSunday);
                    weekdatecombination.put('Third'+'1'+';'+'Sunday',thirdSunday);
                    weekdatecombination.put('Fourth'+'1'+';'+'Sunday',fourthSunday);
                    
                    weekdatecombination.put('First'+'1'+';'+'Monday',firstMonday);
                    weekdatecombination.put('Second'+'1'+';'+'Monday',secondMonday);
                    weekdatecombination.put('Third'+'1'+';'+'Monday',thirdMonday);
                    weekdatecombination.put('Fourth'+'1'+';'+'Monday',fourthMonday);
                    
                    weekdatecombination.put('First'+'1'+';'+'Tuesday',firstTuesday);
                    weekdatecombination.put('Second'+'1'+';'+'Tuesday',secondTuesday);
                    weekdatecombination.put('Third'+';'+'Tuesday',thirdTuesday);
                    weekdatecombination.put('Fourth'+';'+'Tuesday',fourthTuesday);
                    
                    weekdatecombination.put('First'+'1'+';'+'Wednesday',firstWednesday);
                    weekdatecombination.put('Second'+'1'+';'+'Wednesday',secondWednesday);
                    weekdatecombination.put('Third'+'1'+';'+'Wednesday',thirdWednesday);
                    weekdatecombination.put('Fourth'+'1'+';'+'Wednesday',fourthWednesday);
                    
                    weekdatecombination.put('First'+'1'+';'+'Thursday',firstThursday);
                    weekdatecombination.put('Second'+'1'+';'+'Thursday',secondThursday);
                    weekdatecombination.put('Third'+'1'+';'+'Thursday',thirdThursday);
                    weekdatecombination.put('Fourth'+'1'+';'+'Thursday',fourthThursday);
                    
                    weekdatecombination.put('First'+'1'+';'+'Friday',firstFriday);
                    weekdatecombination.put('Second'+'1'+';'+'Friday',secondFriday);
                    weekdatecombination.put('Third'+'1'+';'+'Friday',thirdFriday);
                    weekdatecombination.put('Fourth'+'1'+';'+'Friday',fourthFriday);
                    
                    weekdatecombination.put('First'+'1'+';'+'Saturday',firstSaturday);
                    weekdatecombination.put('Second'+'1'+';'+'Saturday',secondSaturday);
                    weekdatecombination.put('Third'+'1'+';'+'Saturday',thirdSaturday);
                    weekdatecombination.put('Fourth'+'1'+';'+'Saturday',fourthSaturday);
                
                    if(weekdatecombination.get(customerObj.Yearly_Week_Count__c+'1'+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c) > mydate){
                        customerObj.PIUploadDuedate__c = weekdatecombination.get(customerObj.Yearly_Week_Count__c+'1'+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c);
                    }
                    else if(weekdatecombination.get(customerObj.Yearly_Week_Count__c+'1'+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c) < mydate){
                        //*********First,Second,Third,Fourth Sunday Calculation*********//        
                        firstSunday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek();
                        
                        if(firstSunday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstSunday = firstSunday.addDays(7);    
                        }
                        
                        secondSunday = firstSunday.addDays(7);
                        thirdSunday = firstSunday.addDays(14);
                        fourthSunday = firstSunday.addDays(21);
                        
                     //*********First,Second,Third,Fourth Monday Calculation*********//
                        firstMonday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(1);
                        
                        if(firstMonday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstMonday = firstMonday.addDays(7);    
                        }
                        
                        secondMonday = firstMonday.addDays(7);
                        thirdMonday = firstMonday.addDays(14);
                        fourthMonday = firstMonday.addDays(21);
                      
                     //*********First,Second,Third,Fourth Tuesday Calculation*********//  
                        firstTuesday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(2);
                        
                        if(firstTuesday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstTuesday = firstTuesday.addDays(7);    
                        }
                        
                        secondTuesday = firstTuesday.addDays(7);
                        thirdTuesday = firstTuesday.addDays(14);
                        fourthTuesday = firstTuesday.addDays(21);
                        
                      //*********First,Second,Third,Fourth Wednesday Calculation*********//  
                        firstWednesday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(3);
                        
                        if(firstWednesday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstWednesday = firstWednesday.addDays(7);    
                        }
                        
                        secondWednesday = firstWednesday.addDays(7);
                        thirdWednesday = firstWednesday.addDays(14);
                        fourthWednesday = firstWednesday.addDays(21);
                      
                      //*********First,Second,Third,Fourth Thursday Calculation*********//  
                        firstThursday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(4);
                        
                        if(firstThursday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstThursday = firstThursday.addDays(7);    
                        }
                        
                        secondThursday = firstThursday.addDays(7);
                        thirdThursday = firstThursday.addDays(14);
                        fourthThursday = firstThursday.addDays(21);
                       
                      //*********First,Second,Third,Fourth Friday Calculation*********//  
                        firstFriday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(5);
                        
                        if(firstFriday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstFriday = firstFriday.addDays(7);    
                        }
                        
                        secondFriday = firstFriday.addDays(7);
                        thirdFriday = firstFriday.addDays(14);
                        fourthFriday = firstFriday.addDays(21);
                      
                      //*********First,Second,Third,Fourth Saturday Calculation*********//  
                        firstSaturday = mydate.addMonths(monthsBetween).addYears(1).toStartOfMonth().toStartOfWeek().addDays(6);
                        
                        if(firstSaturday < mydate.addMonths(monthsBetween).addYears(1).toStartOfmonth()){
                            firstSaturday = firstSaturday.addDays(7);    
                        }
                        
                        secondSaturday = firstSaturday.addDays(7);
                        thirdSaturday = firstSaturday.addDays(14);
                        fourthSaturday = firstSaturday.addDays(21);
                        
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
                        
                        customerObj.PIUploadDuedate__c = weekdatecombination.get(customerObj.Yearly_Week_Count__c+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c);
                    }
                }
                customerObj.Additional_Days_for_week__c = Null;
                customerObj.Frequency__c = String.ValueOf(Integer.ValueOf(YearFrequency)*12);                                     
                customerObj.Week_Count__c = '';
                customerObj.Upload_Day__c = Null;
                customerObj.Additional_Days__c = Null;    
                customerObj.Day_name_of_upload_week__c = '';
                customerObj.Month_Upload_Day__c = Null;               
            } 
         }
     }
     else if(customerObj.DataAcquisitionMethod__c == 'Survey'){
        customerObj.PIUploadDuedate__c = Null;
        customerObj.Additional_Days_for_week__c = Null;
        customerObj.Frequency__c = '0';                        
        customerObj.Week_Count__c = '';
        customerObj.Upload_Day__c = Null;
        customerObj.Additional_Days__c = Null;    
        customerObj.Day_name_of_upload_week__c = '';
        customerObj.Month_Upload_Day__c = Null;
        customerObj.Additional_Days_for_week__c = Null;    
        customerObj.Month_Value__c = '';
        customerObj.Yearly_Week_Count__c = '';
        customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
        customerObj.Recurrence_Pattern__c = '';
        customerObj.Recurrence_frequency_type__c = '';
     }
     try{ 
        if (!UrlParameterMap.containsKey('isClone')){
            upsert customerObj;
            PageReference nextpage= new PageReference('/'+customerObj.id);
            return nextpage;
        }
        else{
            customerObj.ownerid= userinfo.getUserId();
            PIdefinitionCloned = customerObj.clone(false,true,false,false);
            if(PIdefinitionCloned != null){
               insert PIdefinitionCloned;
            }
        system.debug('PIdefinitionCloned ::'+PIdefinitionCloned);
        } 
      }
     catch(Exception e){
       message='Data Base error during saving...';
       ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, message));
       return null;
     }
    Pagereference pr;
    if (!UrlParameterMap.containsKey('isClone'))
       pr = new Pagereference('/'+ customerObj.Id);
    else
       pr = new Pagereference('/'+ PIdefinitionCloned.Id);
    return pr;
}

public void closePopup() {        
    displayContinueButton = false;    
}
public void DisplaySaveCancelButton(){
    displaySaveButton = true;
}
public PageReference SaveCustom(){   
    Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
    if(customerObj.DataAcquisitionMethod__c == 'Data Load'){
        system.debug('the first/second is: '+selectedWeekInMonth);
        system.debug('the dayname is: '+selectedDayInMonth);
        system.debug('the additional day is: '+ customerObj.Additional_Days_for_week__c);
        system.debug('the additional day is in days in week: '+customerObj.Additional_Days__c);
        system.debug('the RecurrencePattern is: '+RecurrencePattern);
                             
         customerObj.Recurrence_frequency_type__c = selectedFrequency;
         customerObj.Recurrence_Pattern__c = RecurrencePattern;
         customerObj.Week_Count__c = selectedWeekInMonth;
         customerObj.Day_name_of_upload_week__c = selectedDayInMonth;
              
         customerObj.Yearly_Week_Count__c = selectedWeekInYear;
         customerObj.Yearly_Day_Name_of_Upload_Week__c = selectedDayInYear;
         
         isError = false;
         isError9 = false;
         
         DatePattern();
         
         system.debug('the RecurrencePattern is: '+customerObj.Recurrence_Pattern__c);
         system.debug('the RecurrencePattern Frequency is: '+customerObj.Recurrence_frequency_type__c);
         system.debug('the first/second is: '+customerObj.Week_Count__c);
         system.debug('the dayname is: '+customerObj.Day_name_of_upload_week__c);
              
         if(customerObj.Recurrence_frequency_type__c != '' && customerObj.Recurrence_frequency_type__c == 'Monthly'){
             if(customerObj.Recurrence_Pattern__c == 'WeekPerMonth'){
                     if(customerObj.Week_Count__c != '' && customerObj.Day_name_of_upload_week__c != ''){
                         isError = false;
                         isError1 = false;
                         isError2 = false;
                         isError3 = false;
                         isError4 = false;
                         isError5 = false;
                         isError6 = false;
                         isError7 = false;
                         isError8 = false;
                         isError9 = false;
                         
                         Date initialdays = weekdatecombination.get(customerObj.Week_Count__c+';'+customerObj.Day_name_of_upload_week__c);
                         
                         if(customerObj.Additional_Days_for_week__c != Null){
                             Integer additional_days = Integer.ValueOf(customerObj.Additional_Days_for_week__c);
                             initialdays = initialdays.addDays(additional_days);
                         }
                         
                         if(MonthFrequency2 == Null || MonthFrequency2 == ''){
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));                         
                             isError4 = true;
                             return null;
                         }
                         
                         displaydate = initialdays.Day()+'/'+initialdays.Month()+'/'+initialdays.Year();
                                          
                         if(initialdays >= mydate){
                             customerObj.PIUploadDuedate__c =  initialdays;                           
                             system.debug('the new PIUploadDuedate__c is: '+customerObj.PIUploadDuedate__c);
                         }
                         else if(initialdays < mydate){
                              //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'The PI Upload Due Date "'+displaydate+'" is a past date. System will automatically change the date into future date on pressing Continue button'));
                              //displaySaveButton = false;
                              displayContinueButton = true;                              
                              return null; 
                         }                 
                 }         
                 
                 customerObj.Additional_Days__c = Null;
                 customerObj.Upload_Day__c = Null;
                 customerObj.Frequency__c = MonthFrequency2;
                 customerObj.Month_Value__c = '';
                 customerObj.Yearly_Week_Count__c = '';
                 customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
                 customerObj.Month_Upload_Day__c = Null;             
             }            
             else if(customerObj.Recurrence_Pattern__c == 'DayPerMonth'){
                 if(customerObj.Upload_Day__c != Null){
                     Integer dayvalue = Integer.ValueOf(customerObj.Upload_Day__c);
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
                     isError9 = false;
                     
                     Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                     system.debug('the new PIUploadDuedate__c is: '+new_pi_upload_date);
                     system.debug('the new PIUploadDuedate__c is: '+mydate);
                     
                     Integer numberDays = Date.daysInMonth(yearvalue,monthvalue);
                     
                     if(dayvalue > numberDays){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Given Date should not be greater than of total days of Current Month'));
                        isError5 = true;
                        return null; 
                     }
                                                                    
                     if(customerObj.Additional_Days__c != Null){
                         Integer additional_days = Integer.ValueOf(customerObj.Additional_Days__c);
                         new_pi_upload_date = new_pi_upload_date.addDays(additional_days);
                     }
                     
                     if(MonthFrequency1 == Null || MonthFrequency1 == ''){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));
                         isError3 = true;
                         return null;
                     }
                     
                     displaydate = new_pi_upload_date.Day()+'/'+new_pi_upload_date.Month()+'/'+new_pi_upload_date.Year();
                     if(new_pi_upload_date >= mydate){             
                         customerObj.PIUploadDuedate__c = new_pi_upload_date;
                         system.debug('the new PIUploadDuedate__c is: '+customerObj.PIUploadDuedate__c);
                     }
                     else if(new_pi_upload_date < mydate){
                         //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'The PI Upload Due Date "'+displaydate+'" is a past date. System will automatically change the date into future date on pressing Continue button'));
                         //displaySaveButton = false;
                         displayContinueButton = true;
                         return null; 
                     }
                                    
                     customerObj.Additional_Days_for_week__c = Null;    
                     customerObj.Frequency__c = MonthFrequency1;
                     customerObj.Week_Count__c = '';
                     customerObj.Day_name_of_upload_week__c = '';
                     customerObj.Month_Value__c = '';
                     customerObj.Yearly_Week_Count__c = '';
                     customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
                     customerObj.Month_Upload_Day__c = Null;
                 }
                 else if(customerObj.Upload_Day__c == Null){
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
                     isError9 = false;
                     return null;
                 }
             }
             else if(customerObj.Recurrence_Pattern__c != 'WeekPerMonth' && customerObj.Recurrence_Pattern__c != 'DayPerMonth'){
                 //RecurrencePattern = '';
                 //customerObj.Recurrence_Pattern__c = '';
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
                 isError9 = false;
                 return null;
             }
           }
           else if(customerObj.Recurrence_frequency_type__c != '' && customerObj.Recurrence_frequency_type__c == 'Yearly'){
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
                 
                 if(customerObj.Recurrence_Pattern__c == 'DayPerYear'){
                     customerObj.Month_Value__c = selectedMonthinYear;
                     if(customerObj.Month_Upload_Day__c != Null && customerObj.Month_Value__c != ''){
                         Integer dayvalue = Integer.ValueOf(customerObj.Month_Upload_Day__c);
                         Integer monthvalue = Integer.ValueOf(mapMonthName.get(customerObj.Month_Value__c));
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
                         isError9 = false;
                         
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
                         if(new_pi_upload_date >= mydate){
                             customerObj.PIUploadDuedate__c = new_pi_upload_date;
                         }
                         else if(new_pi_upload_date < mydate){
                             //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'The PI Upload Due Date "'+displaydate+'" is a past date. System will automatically change the date into future date on pressing Continue button'));
                             //displaySaveButton = false;
                             displayContinueButton = true;                     
                             return null;
                         }    
                         customerObj.Additional_Days_for_week__c = Null;                        
                         customerObj.Week_Count__c = '';
                         customerObj.Day_name_of_upload_week__c = '';
                         customerObj.Upload_Day__c = Null;
                         customerObj.Additional_Days__c = Null;    
                         
                         customerObj.Yearly_Week_Count__c = '';
                         customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
                         customerObj.Frequency__c = String.ValueOf(Integer.ValueOf(YearFrequency)*12);
                     }
                     else if(customerObj.Month_Upload_Day__c == Null){
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
                         isError9 = false;
                         return null;
                     } 
                 }
                 else if(customerObj.Recurrence_Pattern__c == 'WeekPerYear'){
                 customerObj.Month_Value__c = selectedMonthinYear2;
                 if(customerObj.Yearly_Week_Count__c != Null && customerObj.Month_Value__c != ''){
                     isError = false;
                     isError1 = false;
                     isError2 = false;
                     isError3 = false;
                     isError4 = false;
                     isError5 = false;
                     isError6 = false;
                     isError7 = false;
                     isError8 = false;
                     isError9 = false;
                     
                    if(YearFrequency == Null || YearFrequency == ''){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Frequency cannot be blank'));
                         isError1 = true;
                         return null;
                     }
                     
                    Map<String,Date>  weekdatecombination  = new Map<String,Date>();
                    
                    Integer monthvalue = Integer.ValueOf(mapMonthName.get(customerObj.Month_Value__c));
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
                    
                    new_pi_upload_date = weekdatecombination.get(customerObj.Yearly_Week_Count__c+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c);
                    displaydate = new_pi_upload_date.Day()+'/'+new_pi_upload_date.Month()+'/'+new_pi_upload_date.Year();
                    if(weekdatecombination.get(customerObj.Yearly_Week_Count__c+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c) >= mydate){
                        customerObj.PIUploadDuedate__c = weekdatecombination.get(customerObj.Yearly_Week_Count__c+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c);
                    }
                    else if(weekdatecombination.get(customerObj.Yearly_Week_Count__c+';'+customerObj.Yearly_Day_Name_of_Upload_Week__c) < mydate){
                         //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'The PI Upload Due Date "'+displaydate+'" is a past date. System will automatically change the date into future date on pressing Continue button'));                     
                         //displaySaveButton = false;
                         displayContinueButton = true;
                         return null;
                    }
                    customerObj.Additional_Days_for_week__c = Null;                                                          
                    customerObj.Frequency__c = String.ValueOf(Integer.ValueOf(YearFrequency)*12);
                    customerObj.Week_Count__c = '';
                    customerObj.Upload_Day__c = Null;
                    customerObj.Additional_Days__c = Null;    
                    customerObj.Day_name_of_upload_week__c = '';
                    customerObj.Month_Upload_Day__c = Null;
                } 
              }
              else if(customerObj.Recurrence_Pattern__c != 'WeekPerYear' && customerObj.Recurrence_Pattern__c != 'DayPerYear'){
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
                 isError9 = false;
                 return null; 
              }                                     
           }
           else if((customerObj.Recurrence_frequency_type__c != 'Monthly') ||(customerObj.Recurrence_frequency_type__c != 'Yearly')){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select atleast one Recurrence Frequency type'));
                 isError = false;
                 isError1 = false;
                 isError2 = false;
                 isError3 = false;
                 isError4 = false;
                 isError5 = false;
                 isError6 = false;
                 isError7 = false;
                 isError8 = false;
                 isError9 = true;
                 return null; 
              }
       }
       else if(customerObj.DataAcquisitionMethod__c == 'Survey'){
        isError = false;
        isError1 = false;
        isError2 = false;
        isError3 = false;
        isError4 = false;
        isError5 = false;
        isError6 = false;
        isError7 = false;
        isError8 = false;
        isError9 = false;
        customerObj.PIUploadDuedate__c = Null;
        customerObj.Additional_Days_for_week__c = Null;
        customerObj.Frequency__c = '0';                        
        customerObj.Week_Count__c = '';
        customerObj.Upload_Day__c = Null;
        customerObj.Additional_Days__c = Null;    
        customerObj.Day_name_of_upload_week__c = '';
        customerObj.Month_Upload_Day__c = Null;
        customerObj.Additional_Days_for_week__c = Null;    
        customerObj.Month_Value__c = '';
        customerObj.Yearly_Week_Count__c = '';
        customerObj.Yearly_Day_Name_of_Upload_Week__c = '';
        customerObj.Recurrence_Pattern__c = '';
        customerObj.Recurrence_frequency_type__c = '';
     }
       
   try{ 
        if (!UrlParameterMap.containsKey('isClone')){
            upsert customerObj;
            PageReference nextpage= new PageReference('/'+customerObj.id);
            return nextpage;
        }
        else{
            customerObj.ownerid= userinfo.getUserId(); 
            PIdefinitionCloned = customerObj.clone(false,true,false,false);
            if(PIdefinitionCloned != null){
               insert PIdefinitionCloned;
            }
        system.debug('PIdefinitionCloned ::'+PIdefinitionCloned);
        }   
      }
   catch(Exception e){
       message='Data Base error during saving...';
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
       return null;
   }
   Pagereference pr;
    if (!UrlParameterMap.containsKey('isClone'))
      pr = new Pagereference('/'+ customerObj.Id);
    else
      pr = new Pagereference('/'+ PIdefinitionCloned.Id);
    return pr;

}

}