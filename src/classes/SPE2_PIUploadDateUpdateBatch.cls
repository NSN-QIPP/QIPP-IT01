global class SPE2_PIUploadDateUpdateBatch implements Database.Batchable<sObject>{
    global String query;
    
    global SPE2_PIUploadDateUpdateBatch(){
        String dataaccu = 'Data Load';
        query='SELECT PI_Title__c,PIUploadDuedate__c,Additional_Days__c,Day_name_of_upload_week__c,Frequency__c,DataAcquisitionMethod__c,';
        query+='End_Date__c,Upload_Day__c,Week_Count__c,Recurrence_frequency_type__c,Additional_Days_for_week__c,';
        query+='Yearly_Day_Name_of_Upload_Week__c,Yearly_Week_Count__c,Month_Upload_Day__c,Month_Value__c,';
        query+='Recurrence_Pattern__c FROM SPE_PIDefinition__c where PIUploadDuedate__c <= today';      
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){
    
        date mydate = System.today();
        
        List<SPE_PIDefinition__c>  pitemp = new List<SPE_PIDefinition__c>();
        
        for(SObject obj:scope){
             SPE_PIDefinition__c pidata = (SPE_PIDefinition__c)obj;
             
             if(pidata.Recurrence_frequency_type__c != '' && pidata.Recurrence_frequency_type__c == 'Monthly'){
                 
                 if(pidata.Frequency__c != Null){
                     Integer additional_months = Integer.ValueOf(pidata.Frequency__c);
                     mydate = mydate.addMonths(additional_months);
                 }
             
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
                Map<String,Date>  weekdatecombination  = new Map<String,Date>();
                
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
             
             
                 if(pidata.Recurrence_Pattern__c == 'WeekPerMonth'){
                     if(pidata.Week_Count__c != '' && pidata.Day_name_of_upload_week__c != ''){
                     
                         Date initialdays = weekdatecombination.get(pidata.Week_Count__c+';'+pidata.Day_name_of_upload_week__c);
                         
                         if(pidata.Additional_Days_for_week__c != Null){
                             Integer additional_days = Integer.ValueOf(pidata.Additional_Days_for_week__c);
                             initialdays = initialdays.addDays(additional_days);
                         }
                                          
                         if(initialdays > System.Today()){
                             pidata.PIUploadDuedate__c =  initialdays;                           
                             //system.debug('the new PIUploadDuedate__c is: '+pidata.PIUploadDuedate__c);
                         }                                                    
                     }
                     
                     pitemp.add(pidata);
                 }
                 else if(pidata.Recurrence_Pattern__c == 'DayPerMonth'){
                     mydate = System.Today();
                     Integer dayvalue = Integer.ValueOf(pidata.Upload_Day__c);
                     Integer monthvalue = Integer.ValueOf(mydate.Month());
                     Integer yearvalue = Integer.ValueOf(mydate.Year());
                     
                     Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                     
                     if(pidata.Additional_Days__c != Null){
                         Integer additional_days = Integer.ValueOf(pidata.Additional_Days__c);
                         new_pi_upload_date = new_pi_upload_date.addDays(additional_days);
                     }
                     
                     if(pidata.Frequency__c != Null){
                        Integer additional_months = Integer.ValueOf(pidata.Frequency__c);
                        new_pi_upload_date = new_pi_upload_date.addMonths(additional_months);
                     }
                     
                     if(new_pi_upload_date > mydate){             
                         pidata.PIUploadDuedate__c = new_pi_upload_date;
                         //system.debug('the new PIUploadDuedate__c is: '+pidata.PIUploadDuedate__c);
                     }
                     
                     pitemp.add(pidata);
                 }                 
             }
             else if(pidata.Recurrence_frequency_type__c != '' && pidata.Recurrence_frequency_type__c == 'Yearly'){
                 
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
                 
                 if(pidata.Recurrence_Pattern__c == 'DayPerYear'){
                     if(pidata.Month_Upload_Day__c != Null && pidata.Month_Value__c != ''){
                         mydate = System.Today();
                         Integer dayvalue = Integer.ValueOf(pidata.Month_Upload_Day__c);
                         Integer monthvalue = Integer.ValueOf(mapMonthName.get(pidata.Month_Value__c));
                         Integer yearvalue = Integer.ValueOf(mydate.Year());
                         
                         Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,dayvalue);
                         
                         if(pidata.Frequency__c != Null){
                            Integer additional_months = Integer.ValueOf(pidata.Frequency__c);
                            new_pi_upload_date = new_pi_upload_date.addMonths(additional_months);
                         }
                        
                         if(new_pi_upload_date > mydate){
                             pidata.PIUploadDuedate__c = new_pi_upload_date;
                         }
                         
                         pitemp.add(pidata);                       
                     } 
                 }
                 else if(pidata.Recurrence_Pattern__c == 'WeekPerYear'){
                     if(pidata.Yearly_Week_Count__c != Null && pidata.Month_Value__c != ''){
                        
                        if(pidata.Frequency__c != Null){
                            Integer additional_months = Integer.ValueOf(pidata.Frequency__c);
                            mydate = mydate.addMonths(additional_months);
                        } 
                        
                        Map<String,Date>  weekdatecombination  = new Map<String,Date>();
                        
                        Integer monthvalue = Integer.ValueOf(mapMonthName.get(pidata.Month_Value__c));
                        Integer yearvalue = Integer.ValueOf(mydate.Year());
                         
                        Date new_pi_upload_date = Date.NewInstance(yearvalue,monthvalue,1);
                        Integer monthsBetween = mydate.monthsBetween(new_pi_upload_date);
                        
                        if(monthsBetween != Null){ 
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
                        
                            if(weekdatecombination.get(pidata.Yearly_Week_Count__c+';'+pidata.Yearly_Day_Name_of_Upload_Week__c) > System.Today()){
                                pidata.PIUploadDuedate__c = weekdatecombination.get(pidata.Yearly_Week_Count__c+';'+pidata.Yearly_Day_Name_of_Upload_Week__c);
                            }
                        } 
                        pitemp.add(pidata);                       
                     }                     
                 }                 
             }
             if(pidata.DataAcquisitionMethod__c == 'Standalone Survey'){
                 pidata.PIUploadDuedate__c = pidata.PIUploadDuedate__c.addMonths(Integer.ValueOf(pidata.Frequency__c));
                 pitemp.add(pidata); 
             }
        }
        
        try{
            update pitemp;
        }catch(Exception e){}
  
    }
    
    global void finish(Database.BatchableContext BC){
    }
}