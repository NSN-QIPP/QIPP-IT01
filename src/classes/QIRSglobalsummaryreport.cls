public class QIRSglobalsummaryreport{
    
 public list<QIRS__c> nsn;
 Public String Business{ get; set;}
 Public String BusinessGroup{ get; set;}
 Public String Site{ get; set;}
 Public String AlertType{ get; set;}
 Public String Status{ get; set;} 
 Public String Year{ get; set;}
 
 public String CurrentMonth;
 public String CurrentMonthLess1;
 public String CurrentMonthLess2;
 public String CurrentMonthLess3;
 public String CurrentMonthLess4;
 public String CurrentMonthLess5;
 public String CurrentMonthLess6;
 public String CurrentMonthLess7;
 public String CurrentMonthLess8;
 public String CurrentMonthLess9;
 public String CurrentMonthLess10;
 public String CurrentMonthLess11;
 public String CurrentMonthLess12;
 
 public Integer tempCurrentMonth;
 public Integer tempCurrentMonthLess1;
 public Integer tempCurrentMonthLess2;
 public Integer tempCurrentMonthLess3;
 public Integer tempCurrentMonthLess4;
 public Integer tempCurrentMonthLess5;
 public Integer tempCurrentMonthLess6;
 public Integer tempCurrentMonthLess7;
 public Integer tempCurrentMonthLess8;
 public Integer tempCurrentMonthLess9;
 public Integer tempCurrentMonthLess10;
 public Integer tempCurrentMonthLess11;
 public Integer tempCurrentMonthLess12;
 
 public Integer YearForCurrentMonth;
 public Integer YearForCurrentMonthLess1;
 public Integer YearForCurrentMonthLess2;
 public Integer YearForCurrentMonthLess3;
 public Integer YearForCurrentMonthLess4;
 public Integer YearForCurrentMonthLess5;
 public Integer YearForCurrentMonthLess6;
 public Integer YearForCurrentMonthLess7;
 public Integer YearForCurrentMonthLess8;
 public Integer YearForCurrentMonthLess9;
 public Integer YearForCurrentMonthLess10;
 public Integer YearForCurrentMonthLess11;
 public Integer YearForCurrentMonthLess12;
 
 
  
 
     public QIRSglobalsummaryreport()
     {
         Date TodayDate = date.Today();
         Date DtCurrentMonthLess1 = TodayDate.addMonths(-1);
         Date DtCurrentMonthLess2 = TodayDate.addMonths(-2);
         Date DtCurrentMonthLess3 = TodayDate.addMonths(-3);
         Date DtCurrentMonthLess4 = TodayDate.addMonths(-4);
         Date DtCurrentMonthLess5 = TodayDate.addMonths(-5);
         Date DtCurrentMonthLess6 = TodayDate.addMonths(-6);
         Date DtCurrentMonthLess7 = TodayDate.addMonths(-7);
         Date DtCurrentMonthLess8 = TodayDate.addMonths(-8);
         Date DtCurrentMonthLess9 = TodayDate.addMonths(-9);
         Date DtCurrentMonthLess10 = TodayDate.addMonths(-10);
         Date DtCurrentMonthLess11 = TodayDate.addMonths(-11);
         Date DtCurrentMonthLess12 = TodayDate.addMonths(-12);
         
         tempCurrentMonth = TodayDate.month();
         tempCurrentMonthLess1 = DtCurrentMonthLess1.month();
         tempCurrentMonthLess2 = DtCurrentMonthLess2.month(); 
         tempCurrentMonthLess3 = DtCurrentMonthLess3.month(); 
         tempCurrentMonthLess4 = DtCurrentMonthLess4.month(); 
         tempCurrentMonthLess5 = DtCurrentMonthLess5.month(); 
         tempCurrentMonthLess6 = DtCurrentMonthLess6.month(); 
         tempCurrentMonthLess7 = DtCurrentMonthLess7.month();
         tempCurrentMonthLess8 = DtCurrentMonthLess8.month(); 
         tempCurrentMonthLess9 = DtCurrentMonthLess9.month(); 
         tempCurrentMonthLess10 = DtCurrentMonthLess10.month(); 
         tempCurrentMonthLess11 = DtCurrentMonthLess11.month(); 
         tempCurrentMonthLess12 = DtCurrentMonthLess12.month();
         
         if(tempCurrentMonth == 1) CurrentMonth = 'Jan';if(tempCurrentMonth == 2) CurrentMonth = 'Feb';if(tempCurrentMonth == 3) CurrentMonth = 'Mar';if(tempCurrentMonth == 4) CurrentMonth = 'Apr';if(tempCurrentMonth == 5) CurrentMonth = 'May';if(tempCurrentMonth == 6) CurrentMonth = 'Jun';if(tempCurrentMonth == 7) CurrentMonth = 'Jul';if(tempCurrentMonth == 8) CurrentMonth = 'Aug';if(tempCurrentMonth == 9) CurrentMonth = 'Sep';if(tempCurrentMonth == 10) CurrentMonth = 'Oct';if(tempCurrentMonth == 11) CurrentMonth = 'Nov';if(tempCurrentMonth == 12) CurrentMonth = 'Dec'; 
         if(tempCurrentMonthLess1 == 1) CurrentMonthLess1 = 'Jan';if(tempCurrentMonthLess1 == 2) CurrentMonthLess1 = 'Feb';if(tempCurrentMonthLess1 == 3) CurrentMonthLess1 = 'Mar';if(tempCurrentMonthLess1 == 4) CurrentMonthLess1 = 'Apr';if(tempCurrentMonthLess1 == 5) CurrentMonthLess1 = 'May';if(tempCurrentMonthLess1 == 6) CurrentMonthLess1 = 'Jun';if(tempCurrentMonthLess1 == 7) CurrentMonthLess1 = 'Jul';if(tempCurrentMonthLess1 == 8) CurrentMonthLess1 = 'Aug';if(tempCurrentMonthLess1 == 9) CurrentMonthLess1 = 'Sep';if(tempCurrentMonthLess1 == 10) CurrentMonthLess1 = 'Oct';if(tempCurrentMonthLess1 == 11) CurrentMonthLess1 = 'Nov';if(tempCurrentMonthLess1 == 12) CurrentMonthLess1 = 'Dec';
         if(tempCurrentMonthLess2 == 1) CurrentMonthLess2 = 'Jan';if(tempCurrentMonthLess2 == 2) CurrentMonthLess2 = 'Feb';if(tempCurrentMonthLess2 == 3) CurrentMonthLess2 = 'Mar';if(tempCurrentMonthLess2 == 4) CurrentMonthLess2 = 'Apr';if(tempCurrentMonthLess2 == 5) CurrentMonthLess2 = 'May';if(tempCurrentMonthLess2 == 6) CurrentMonthLess2 = 'Jun';if(tempCurrentMonthLess2 == 7) CurrentMonthLess2 = 'Jul';if(tempCurrentMonthLess2 == 8) CurrentMonthLess2 = 'Aug';if(tempCurrentMonthLess2 == 9) CurrentMonthLess2 = 'Sep';if(tempCurrentMonthLess2 == 10) CurrentMonthLess2 = 'Oct';if(tempCurrentMonthLess2 == 11) CurrentMonthLess2 = 'Nov';if(tempCurrentMonthLess2 == 12) CurrentMonthLess2 = 'Dec';
         if(tempCurrentMonthLess3 == 1) CurrentMonthLess3 = 'Jan';if(tempCurrentMonthLess3 == 2) CurrentMonthLess3 = 'Feb';if(tempCurrentMonthLess3 == 3) CurrentMonthLess3 = 'Mar';if(tempCurrentMonthLess3 == 4) CurrentMonthLess3 = 'Apr';if(tempCurrentMonthLess3 == 5) CurrentMonthLess3 = 'May';if(tempCurrentMonthLess3 == 6) CurrentMonthLess3 = 'Jun';if(tempCurrentMonthLess3 == 7) CurrentMonthLess3 = 'Jul';if(tempCurrentMonthLess3 == 8) CurrentMonthLess3 = 'Aug';if(tempCurrentMonthLess3 == 9) CurrentMonthLess3 = 'Sep';if(tempCurrentMonthLess3 == 10) CurrentMonthLess3 = 'Oct';if(tempCurrentMonthLess3 == 11) CurrentMonthLess3 = 'Nov';if(tempCurrentMonthLess3 == 12) CurrentMonthLess3 = 'Dec';
         if(tempCurrentMonthLess4 == 1) CurrentMonthLess4 = 'Jan';if(tempCurrentMonthLess4 == 2) CurrentMonthLess4 = 'Feb';if(tempCurrentMonthLess4 == 3) CurrentMonthLess4 = 'Mar';if(tempCurrentMonthLess4 == 4) CurrentMonthLess4 = 'Apr';if(tempCurrentMonthLess4 == 5) CurrentMonthLess4 = 'May';if(tempCurrentMonthLess4 == 6) CurrentMonthLess4 = 'Jun';if(tempCurrentMonthLess4 == 7) CurrentMonthLess4 = 'Jul';if(tempCurrentMonthLess4 == 8) CurrentMonthLess4 = 'Aug';if(tempCurrentMonthLess4 == 9) CurrentMonthLess4 = 'Sep';if(tempCurrentMonthLess4 == 10) CurrentMonthLess4 = 'Oct';if(tempCurrentMonthLess4 == 11) CurrentMonthLess4 = 'Nov';if(tempCurrentMonthLess4 == 12) CurrentMonthLess4 = 'Dec';
         if(tempCurrentMonthLess5 == 1) CurrentMonthLess5 = 'Jan';if(tempCurrentMonthLess5 == 2) CurrentMonthLess5 = 'Feb';if(tempCurrentMonthLess5 == 3) CurrentMonthLess5 = 'Mar';if(tempCurrentMonthLess5 == 4) CurrentMonthLess5 = 'Apr';if(tempCurrentMonthLess5 == 5) CurrentMonthLess5 = 'May';if(tempCurrentMonthLess5 == 6) CurrentMonthLess5 = 'Jun';if(tempCurrentMonthLess5 == 7) CurrentMonthLess5 = 'Jul';if(tempCurrentMonthLess5 == 8) CurrentMonthLess5 = 'Aug';if(tempCurrentMonthLess5 == 9) CurrentMonthLess5 = 'Sep';if(tempCurrentMonthLess5 == 10) CurrentMonthLess5 = 'Oct';if(tempCurrentMonthLess5 == 11) CurrentMonthLess5 = 'Nov';if(tempCurrentMonthLess5 == 12) CurrentMonthLess5 = 'Dec';
         if(tempCurrentMonthLess6 == 1) CurrentMonthLess6 = 'Jan';if(tempCurrentMonthLess6 == 2) CurrentMonthLess6 = 'Feb';if(tempCurrentMonthLess6 == 3) CurrentMonthLess6 = 'Mar';if(tempCurrentMonthLess6 == 4) CurrentMonthLess6 = 'Apr';if(tempCurrentMonthLess6 == 5) CurrentMonthLess6 = 'May';if(tempCurrentMonthLess6 == 6) CurrentMonthLess6 = 'Jun';if(tempCurrentMonthLess6 == 7) CurrentMonthLess6 = 'Jul';if(tempCurrentMonthLess6 == 8) CurrentMonthLess6 = 'Aug';if(tempCurrentMonthLess6 == 9) CurrentMonthLess6 = 'Sep';if(tempCurrentMonthLess6 == 10) CurrentMonthLess6 = 'Oct';if(tempCurrentMonthLess6 == 11) CurrentMonthLess6 = 'Nov';if(tempCurrentMonthLess6 == 12) CurrentMonthLess6 = 'Dec';
         if(tempCurrentMonthLess7 == 1) CurrentMonthLess7 = 'Jan';if(tempCurrentMonthLess7 == 2) CurrentMonthLess7 = 'Feb';if(tempCurrentMonthLess7 == 3) CurrentMonthLess7 = 'Mar';if(tempCurrentMonthLess7 == 4) CurrentMonthLess7 = 'Apr';if(tempCurrentMonthLess7 == 5) CurrentMonthLess7 = 'May';if(tempCurrentMonthLess7 == 6) CurrentMonthLess7 = 'Jun';if(tempCurrentMonthLess7 == 7) CurrentMonthLess7 = 'Jul';if(tempCurrentMonthLess7 == 8) CurrentMonthLess7 = 'Aug';if(tempCurrentMonthLess7 == 9) CurrentMonthLess7 = 'Sep';if(tempCurrentMonthLess7 == 10) CurrentMonthLess7 = 'Oct';if(tempCurrentMonthLess7 == 11) CurrentMonthLess7 = 'Nov';if(tempCurrentMonthLess7 == 12) CurrentMonthLess7 = 'Dec';
         if(tempCurrentMonthLess8 == 1) CurrentMonthLess8 = 'Jan';if(tempCurrentMonthLess8 == 2) CurrentMonthLess8 = 'Feb';if(tempCurrentMonthLess8 == 3) CurrentMonthLess8 = 'Mar';if(tempCurrentMonthLess8 == 4) CurrentMonthLess8 = 'Apr';if(tempCurrentMonthLess8 == 5) CurrentMonthLess8 = 'May';if(tempCurrentMonthLess8 == 6) CurrentMonthLess8 = 'Jun';if(tempCurrentMonthLess8 == 7) CurrentMonthLess8 = 'Jul';if(tempCurrentMonthLess8 == 8) CurrentMonthLess8 = 'Aug';if(tempCurrentMonthLess8 == 9) CurrentMonthLess8 = 'Sep';if(tempCurrentMonthLess8 == 10) CurrentMonthLess8 = 'Oct';if(tempCurrentMonthLess8 == 11) CurrentMonthLess8 = 'Nov';if(tempCurrentMonthLess8 == 12) CurrentMonthLess8 = 'Dec';
         if(tempCurrentMonthLess9 == 1) CurrentMonthLess9 = 'Jan';if(tempCurrentMonthLess9 == 2) CurrentMonthLess9 = 'Feb';if(tempCurrentMonthLess9 == 3) CurrentMonthLess9 = 'Mar';if(tempCurrentMonthLess9 == 4) CurrentMonthLess9 = 'Apr';if(tempCurrentMonthLess9 == 5) CurrentMonthLess9 = 'May';if(tempCurrentMonthLess9 == 6) CurrentMonthLess9 = 'Jun';if(tempCurrentMonthLess9 == 7) CurrentMonthLess9 = 'Jul';if(tempCurrentMonthLess9 == 8) CurrentMonthLess9 = 'Aug';if(tempCurrentMonthLess9 == 9) CurrentMonthLess9 = 'Sep';if(tempCurrentMonthLess9 == 10) CurrentMonthLess9 = 'Oct';if(tempCurrentMonthLess9 == 11) CurrentMonthLess9 = 'Nov';if(tempCurrentMonthLess9 == 12) CurrentMonthLess9 = 'Dec';
         if(tempCurrentMonthLess10 == 1) CurrentMonthLess10 = 'Jan';if(tempCurrentMonthLess10 == 2) CurrentMonthLess10 = 'Feb';if(tempCurrentMonthLess10 == 3) CurrentMonthLess10 = 'Mar';if(tempCurrentMonthLess10 == 4) CurrentMonthLess10 = 'Apr';if(tempCurrentMonthLess10 == 5) CurrentMonthLess10 = 'May';if(tempCurrentMonthLess10 == 6) CurrentMonthLess10 = 'Jun';if(tempCurrentMonthLess10 == 7) CurrentMonthLess10 = 'Jul';if(tempCurrentMonthLess10 == 8) CurrentMonthLess10 = 'Aug';if(tempCurrentMonthLess10 == 9) CurrentMonthLess10 = 'Sep';if(tempCurrentMonthLess10 == 10) CurrentMonthLess10 = 'Oct';if(tempCurrentMonthLess10 == 11) CurrentMonthLess10 = 'Nov';if(tempCurrentMonthLess10 == 12) CurrentMonthLess10 = 'Dec';
         if(tempCurrentMonthLess11 == 1) CurrentMonthLess11 = 'Jan';if(tempCurrentMonthLess11 == 2) CurrentMonthLess11 = 'Feb';if(tempCurrentMonthLess11 == 3) CurrentMonthLess11 = 'Mar';if(tempCurrentMonthLess11 == 4) CurrentMonthLess11 = 'Apr';if(tempCurrentMonthLess11 == 5) CurrentMonthLess11 = 'May';if(tempCurrentMonthLess11 == 6) CurrentMonthLess11 = 'Jun';if(tempCurrentMonthLess11 == 7) CurrentMonthLess11 = 'Jul';if(tempCurrentMonthLess11 == 8) CurrentMonthLess11 = 'Aug';if(tempCurrentMonthLess11 == 9) CurrentMonthLess11 = 'Sep';if(tempCurrentMonthLess11 == 10) CurrentMonthLess11 = 'Oct';if(tempCurrentMonthLess11 == 11) CurrentMonthLess11 = 'Nov';if(tempCurrentMonthLess11 == 12) CurrentMonthLess11 = 'Dec';
         if(tempCurrentMonthLess12 == 1) CurrentMonthLess12 = 'Jan';if(tempCurrentMonthLess12 == 2) CurrentMonthLess12 = 'Feb';if(tempCurrentMonthLess12 == 3) CurrentMonthLess12 = 'Mar';if(tempCurrentMonthLess12 == 4) CurrentMonthLess12 = 'Apr';if(tempCurrentMonthLess12 == 5) CurrentMonthLess12 = 'May';if(tempCurrentMonthLess12 == 6) CurrentMonthLess12 = 'Jun';if(tempCurrentMonthLess12 == 7) CurrentMonthLess12 = 'Jul';if(tempCurrentMonthLess12 == 8) CurrentMonthLess12 = 'Aug';if(tempCurrentMonthLess12 == 9) CurrentMonthLess12 = 'Sep';if(tempCurrentMonthLess12 == 10) CurrentMonthLess12 = 'Oct';if(tempCurrentMonthLess12 == 11) CurrentMonthLess12 = 'Nov';if(tempCurrentMonthLess12 == 12) CurrentMonthLess12 = 'Dec';
         
         YearForCurrentMonth = TodayDate.year();
         YearForCurrentMonthLess1 = DtCurrentMonthLess1.year();
         YearForCurrentMonthLess2 = DtCurrentMonthLess2.year(); 
         YearForCurrentMonthLess3 = DtCurrentMonthLess3.year(); 
         YearForCurrentMonthLess4 = DtCurrentMonthLess4.year(); 
         YearForCurrentMonthLess5 = DtCurrentMonthLess5.year(); 
         YearForCurrentMonthLess6 = DtCurrentMonthLess6.year(); 
         YearForCurrentMonthLess7 = DtCurrentMonthLess7.year(); 
         YearForCurrentMonthLess8 = DtCurrentMonthLess8.year(); 
         YearForCurrentMonthLess9 = DtCurrentMonthLess9.year(); 
         YearForCurrentMonthLess10 = DtCurrentMonthLess10.year(); 
         YearForCurrentMonthLess11 = DtCurrentMonthLess11.year(); 
         YearForCurrentMonthLess12 = DtCurrentMonthLess12.year();   
         
         Year = CurrentMonth+'/'+YearForCurrentMonth; 
     }
 
 
 
    public List<SelectOption> getitemsBusiness()
    {
        return QIRSBasecontroller.getBusinessList(true);        
    }

    public List<SelectOption> getItemsBG()
    {
        return QIRSBasecontroller.getBusinessGrpList();
    }
    public List<SelectOption> getitemsSite() 
    {
        return QIRSBasecontroller.getSitesList(true);
    }
    public List<SelectOption> getItemsAT() 
    {
        return QIRSBasecontroller.getAlertTypesList(true);      
    }

    public List<SelectOption> getItemsStatus() 
    {
        return QIRSBasecontroller.getStatusList(true);            
    }         
    public List<SelectOption> getItemsYear() 
    {
        List<SelectOption> options = new List<SelectOption>();        
        options.add(new SelectOption(CurrentMonth+'/'+YearForCurrentMonth ,CurrentMonth+'/'+YearForCurrentMonth));
        options.add(new SelectOption(CurrentMonthLess11 +'/'+YearForCurrentMonthLess11 ,CurrentMonthLess11 +'/'+YearForCurrentMonthLess11 ));
        options.add(new SelectOption(CurrentMonthLess10 +'/'+YearForCurrentMonthLess10 ,CurrentMonthLess10 +'/'+YearForCurrentMonthLess10 ));
        options.add(new SelectOption(CurrentMonthLess9 +'/'+YearForCurrentMonthLess9 ,CurrentMonthLess9 +'/'+YearForCurrentMonthLess9 ));
        options.add(new SelectOption(CurrentMonthLess8 +'/'+YearForCurrentMonthLess8 ,CurrentMonthLess8 +'/'+YearForCurrentMonthLess8 ));
        options.add(new SelectOption(CurrentMonthLess7 +'/'+YearForCurrentMonthLess7 ,CurrentMonthLess7 +'/'+YearForCurrentMonthLess7 ));
        options.add(new SelectOption(CurrentMonthLess6 +'/'+YearForCurrentMonthLess6 ,CurrentMonthLess6 +'/'+YearForCurrentMonthLess6 ));
        options.add(new SelectOption(CurrentMonthLess5 +'/'+YearForCurrentMonthLess5 ,CurrentMonthLess5 +'/'+YearForCurrentMonthLess5 ));
        options.add(new SelectOption(CurrentMonthLess4 +'/'+YearForCurrentMonthLess4 ,CurrentMonthLess4 +'/'+YearForCurrentMonthLess4 ));
        options.add(new SelectOption(CurrentMonthLess3 +'/'+YearForCurrentMonthLess3 ,CurrentMonthLess3 +'/'+YearForCurrentMonthLess3 ));
        options.add(new SelectOption(CurrentMonthLess2 +'/'+YearForCurrentMonthLess2 ,CurrentMonthLess2 +'/'+YearForCurrentMonthLess2 ));
        options.add(new SelectOption(CurrentMonthLess1 +'/'+YearForCurrentMonthLess1 ,CurrentMonthLess1 +'/'+YearForCurrentMonthLess1 ));        
                    
       //options.add(new SelectOption(CurrentMonthLess12 +'/'+YearForCurrentMonthLess12 ,CurrentMonthLess12 +'/'+YearForCurrentMonthLess12 ));
        return options;
    }       
  

    public list<QIRS__c> getQuery_Global_Report_Summary()
    { 
            string business = Business ;
            string businessgroup = BusinessGroup ;
            string site = Site ;
            string alerttype = Alerttype;
            string status = Status ; 
            string[] StrMonthYear= new list<string>();
            
            
            StrMonthYear = Year.split('/',0);
            //Integer mnt = Integer.valueOf(StrMonthYear[0]);
            Integer yr = Integer.valueOf(StrMonthYear[1]);
            System.debug('Year*********'+Year+'**********StrMonthYear***********'+StrMonthYear+'*********StrMonthYear[0]*******'+StrMonthYear[0]+'********StrMonthYear[1]*******'+StrMonthYear[1]);
            Integer mnt;
            //Integer yr;
            if(StrMonthYear[0] == 'Jan') mnt = 1; if(StrMonthYear[0] == 'Feb') mnt = 2; if(StrMonthYear[0] == 'Mar') mnt = 3; if(StrMonthYear[0] == 'Apr') mnt = 4; if(StrMonthYear[0] == 'May') mnt = 5; if(StrMonthYear[0] == 'Jun') mnt = 6; if(StrMonthYear[0] == 'Jul') mnt = 7; if(StrMonthYear[0] == 'Aug') mnt = 8; if(StrMonthYear[0] == 'Sep') mnt = 9; if(StrMonthYear[0] == 'Oct') mnt = 10; if(StrMonthYear[0] == 'Nov') mnt = 11; if(StrMonthYear[0] == 'Dec') mnt = 12;
      
        List<QIRS__c> Global_Report = new list<QIRS__c>();
         
         if(business != null)
        {    
            if(business == 'All')
            {
                if(businessgroup == 'All')
                {
                    if(site == 'All')
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c where Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Alert_Type__c =: alerttype AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Alert_Type__c =: alerttype AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                    else
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                               
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                }
                else
                {
                    if(site == 'All')
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Alert_Type__c =: alerttype AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Alert_Type__c =: alerttype AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                    else
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Status__c =: status AND Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                }
            }
            else
                {
                       if(businessgroup == 'All')
                {
                    if(site == 'All')
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Alert_Type__c =: alerttype AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Alert_Type__c =: alerttype AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                    else
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                }
                else
                {
                    if(site == 'All')
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Alert_Type__c =: alerttype AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Alert_Type__c =: alerttype AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                    else
                    {
                        if(alerttype == 'All')
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                 Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                        else
                        {
                            if(status == 'All')
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                            else
                            {
                                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c  where Business__c =: business AND Status__c =: status AND Alert_Type__c =: alerttype AND Site_Filter__c Like: '%'+site+'%' AND Business_Group__c =: businessgroup AND Status__c != 'Closed' AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
                                
                            }
                        }
                    }
                 }
              }
           }      
         else
            {
                businessgroup = 'All';
                site = 'All';
                alerttype = 'All';
                status = 'All';                
                business = 'All';
                    
                Global_Report = [SELECT Name,Status__c,Business__c,Business_Group__c,Site1__c,CreatedDate,Factory__c,Factory_DC__c,Customer__c,View_Product_Name__c,Alert_Type__c,Exposed_Base__c,Process_Owner1__r.Name,Expected_Number_of_return__c,Cost__c,Closed_Date1__c,Problem_Description1__c FROM QIRS__c where Status__c != 'Closed'AND CALENDAR_MONTH(CreatedDate) =: mnt AND CALENDAR_YEAR(CreatedDate) =: yr order by Name desc];
            }
        return Global_Report;           
     }
                        
    static testMethod void testQIRSglobalsummaryreport()
     {

      QIRSglobalsummaryreport controller = new QIRSglobalsummaryreport();
        
         controller.getitemsBusiness();
        controller.getItemsBG();
        controller.getitemsSite();
        controller.getItemsAT();
        controller.getItemsStatus();
        controller.getItemsYear();
         
        controller.Business = 'ALL';
        controller.BusinessGroup = 'ALL';
        controller.Site = 'ALL';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';      
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.Site = 'Alsdorf';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.BusinessGroup = 'CDMA';
        controller.Site = 'ALL';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.Site = 'Alsdorf';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.Business = 'Networks Systems';
        controller.BusinessGroup = 'ALL';
        controller.Site = 'ALL';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.Site = 'Alsdorf';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.BusinessGroup = 'CDMA';
        controller.Site = 'ALL';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.Site = 'Alsdorf';
        controller.AlertType = 'ALL';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.AlertType = 'NPI Launch Impact';
        controller.Status = 'ALL';
        controller.getQuery_Global_Report_Summary();
        
        controller.Status = 'Open';
        controller.getQuery_Global_Report_Summary();
        
        controller.Business = null;
        controller.getQuery_Global_Report_Summary();
        
     }

}