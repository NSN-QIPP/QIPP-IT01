public class SPE2_AdhocScorecardPageNewClone{
    public SPE_ScorecardGenerator__c scoreCardgenerator{get;set;}
    Id scoregeneratorId;
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
    public Integer startDateYear {get;set;}
    public Integer startDateMonth {get;set;}
    public Integer EndDateYear {get;set;}
    public Integer EndDateMonth {get;set;}
    public Date kpiday{get;set;}
    public String displaydate{get;set;}
    public Boolean displayScorecardGenpage {get;set;}
    public boolean displaypopup{get;set;}
    public Boolean showmsg ;
    String isClone;
    Date strtDInitial;
    Date endDInitial;
    String strFreqInitial;
    List<SPE_Scorecard_Plan__c> lstScorecardPlans = new List<SPE_Scorecard_Plan__c>();
    List<SPE_ScorecardSupplierMap__c> lstScorecardSupplierMap = new List<SPE_ScorecardSupplierMap__c>();
    public SPE2_AdhocScorecardPageNewClone(Apexpages.Standardcontroller st){
        scoregeneratorId = st.getId();
        isClone = 'false';
        if(ApexPages.currentPage().getParameters().get('isClone') != null){
            isClone = 'true';
        }
        else{
            isClone = 'false';
        }
        scoreCardgenerator = new SPE_ScorecardGenerator__c();
        if(st.getId() != null){
            if(ApexPages.currentPage().getParameters().get('isClone') == null)
            {CurrentUserId = UserInfo.getUserId();
            RecordOwnerId = [Select Id, ownerId from SPE_ScorecardGenerator__c
                       WHERE Id =: st.getId()].ownerId;}
            scoreCardgenerator = [select id,Name,AdhocScorecardName__c,Description__c,TimeFrame__c,Aggregation_Period_Adhoc__c,AggregationType__c,
                                    Additional_Days__c,BusinessLine__c,BusinessUnit__c,Category__c,CategoryCluster__c,
                                    CategoryGroup__c,Country__c,EndDate__c,FrequencyInMonths__c,IsAutoApproved__c,isAutoDistributionON__c,
                                    Region__c,SubRegion__c,Product__c,Project__c,ScorecardTemplate__c,StartDate__c,DisplayValues__c
                                From SPE_ScorecardGenerator__c WHERE Id=: scoregeneratorId];
            strtDInitial = scoreCardgenerator.StartDate__c;
            endDInitial =  scoreCardgenerator.EndDate__c;
            strFreqInitial = scoreCardgenerator.FrequencyInMonths__c;
            scoreCardgenerator.Stage__c = 'Draft';
            lstScorecardPlans = [select id, name, Scorecard_Generator__c,SPE_Plan__c,SPE_Plan__r.Name,
                                    SPE_Plan__r.SPEPlanName__c,SPE_Plan__r.SPETemplate__c,SPE_Plan__r.SPETemplate__r.name,SPE_Plan__r.Region__c,
                                    SPE_Plan__r.SubRegion__c,SPE_Plan__r.Country__c,SPE_Plan__r.Project__c,SPE_Plan__r.BusinessUnit__c,
                                    SPE_Plan__r.BusinessLine__c,SPE_Plan__r.Product__c,SPE_Plan__r.CategoryCluster__c,SPE_Plan__r.CategoryGroup__c,
                                    SPE_Plan__r.Category__c,SPE_Plan__r.Active__c,SPE_Plan__r.Vintage__c
                                    from SPE_Scorecard_Plan__c where Scorecard_Generator__c=:scoregeneratorId];           
            
            lstScorecardSupplierMap = [select id,name,Approver__c,Earliest_Date__c,CC_Contact2__c,CC_Contact1__c,Latest_Data__c,
                                            ScorecardGenerator__c,Supplier__c,SupplierContact__c
                                            from SPE_ScorecardSupplierMap__c where ScorecardGenerator__c=:scoregeneratorId];
        startDateYear = scoreCardgenerator.StartDate__c.year();
        EndDateYear = scoreCardgenerator.EndDate__c.year();
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Monthly'){
            startDateMonth = scoreCardgenerator.StartDate__c.month();
            EndDateMonth = scoreCardgenerator.EndDate__c.month();
        }
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Quarterly'){
            if(scoreCardgenerator.StartDate__c.month() >= 1 && scoreCardgenerator.StartDate__c.month() < 4)
                startDateMonth = 1;
            else if(scoreCardgenerator.StartDate__c.month() >= 4 && scoreCardgenerator.StartDate__c.month() < 7)
                startDateMonth = 2;
            else if(scoreCardgenerator.StartDate__c.month() >= 7 && scoreCardgenerator.StartDate__c.month() < 10)
                startDateMonth = 3;
            else
                startDateMonth = 4;
            
            if(scoreCardgenerator.EndDate__c.month() >= 1 && scoreCardgenerator.EndDate__c.month() < 4)
                EndDateMonth = 1;
            else if(scoreCardgenerator.EndDate__c.month() >= 4 && scoreCardgenerator.EndDate__c.month() < 7)
                EndDateMonth = 2;
            else if(scoreCardgenerator.EndDate__c.month() >= 7 && scoreCardgenerator.EndDate__c.month() < 10)
                EndDateMonth = 3;
            else
                EndDateMonth = 4;
        }
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Half Yearly'){
            if(scoreCardgenerator.StartDate__c.month() >= 1 && scoreCardgenerator.StartDate__c.month() < 7)
                startDateMonth = 1;
            else
                startDateMonth = 2;
            
            if(scoreCardgenerator.EndDate__c.month() >= 1 && scoreCardgenerator.EndDate__c.month() < 7)
                EndDateMonth = 1;
            else
                EndDateMonth = 2;
        }
        }
        
    
    }
    public List<SelectOption> getpopulateYear(){
       List<SelectOption> yearOptions = new List<SelectOption>();
       for(Integer i=-1;i<5;i++){
          String year = String.valueOf(System.today().addYears(i).year());
          yearOptions.add(new SelectOption(year,year));
       }
         return yearOptions;
    
    }
    
    public List<SelectOption> getpopulateMonth(){
       List<SelectOption> monthOptions = new List<SelectOption>();
       for(Integer i=1;i<=12;i++){
          String month = String.valueOf(i);
          monthOptions.add(new SelectOption(month,month));
       }
         return monthOptions;
    
    }
     public List<SelectOption> getpopulateQuarter(){
       List<SelectOption> quarterOptions = new List<SelectOption>();
       for(Integer i=1;i<=4;i++){
          String quarter= String.valueOf(i);
          quarterOptions.add(new SelectOption(quarter,quarter));
       }
         return quarterOptions ;
    
    }
    
    public List<SelectOption> getpopulateHalfYearly(){
       List<SelectOption> halfYearlyOptions = new List<SelectOption>();
       for(Integer i=1;i<=2;i++){
          String halfyearly= String.valueOf(i);
          halfYearlyOptions.add(new SelectOption(halfyearly,halfyearly));
       }
         return halfYearlyOptions ;
    
    }
    public void blankMethod(){}
    public PageReference saveScorecardGen(){
        Date strtD;
        Date endD;
        
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Monthly'){
            scoreCardgenerator.FrequencyInMonths__c = '1';
            strtD = Date.newInstance(startDateYear,startDateMonth,1);
            endD = Date.newInstance(endDateYear,endDateMonth,1);
            system.debug('strtD::'+strtD);
          }   
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Quarterly'){
            Integer mon;
             Integer endmon;
            scoreCardgenerator.FrequencyInMonths__c = '3'; 
            if(startDateMonth == 1)
                mon = 1;
            if(startDateMonth == 2)
                mon = 4;
             if(startDateMonth == 3)
                mon = 8;   
             if(startDateMonth == 4)
                mon = 12;
             if(endDateMonth == 1)
                endmon = 1;
            if(endDateMonth == 2)
                endmon = 4;
             if(endDateMonth == 3)
                endmon = 8;   
             if(endDateMonth == 4)
                endmon = 12;   
            strtD = Date.newInstance(startDateYear,mon,1);
            endD = Date.newInstance(endDateYear,endmon,1);
         }   
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Half Yearly'){
             Integer mon;
             Integer endmon;
            scoreCardgenerator.FrequencyInMonths__c = '6';
            if(startDateMonth == 1)
                mon = 1;
           if(startDateMonth == 2)
                mon = 6;
           if(endDateMonth == 1)
              endmon = 1; 
           if(endDateMonth == 2)
              endmon = 12; 
          strtD = Date.newInstance(startDateYear,mon,1);
          endD = Date.newInstance(endDateYear,endmon,1);      
          }  
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Annual'){
            scoreCardgenerator.FrequencyInMonths__c = '12';   
         strtD = Date.newInstance(startDateYear,1,1);
         endD = Date.newInstance(endDateYear,1,1);
         }
         //-----------------Next computed day calculation-----
            kpiDay = Date.newinstance(1960, 1, 1);
            Integer monthvalue = System.Today().Month();
            
            List<SPE_Scorecard_Plan__c> spePlanMapList = [SELECT Id,Scorecard_Generator__c,SPE_Plan__c from SPE_Scorecard_Plan__c where Scorecard_Generator__c =: scoregeneratorId];
            List<ID> speplanID = new List<ID>();
            for(SPE_Scorecard_Plan__c spp: spePlanMapList){
                speplanID.add(spp.SPE_Plan__c);
            }
            
            //List<SPE_SPETracker__c> spetrackList = [Select ID,Name,DateOfExecution__c,SPEPlan__c,Period__c from SPE_SPETracker__c where SPEPlan__c IN:speplanID order by DateOfExecution__c];
            List<SPE_SPETracker__c> spetrackList = [Select ID,Name,DateOfExecution__c,SPEPlan__c,Period__c from SPE_SPETracker__c where SPEPlan__c IN:speplanID AND Status__c = 'Pending'];
            
            for(SPE_SPETracker__c speTrackMap : spetrackList)
            {  
                if (speTrackMap.DateOfExecution__c != null && monthvalue == speTrackMap.DateOfExecution__c.Month() && System.Today().Year() == speTrackMap.DateOfExecution__c.Year())
                {
                    if(speTrackMap.DateOfExecution__c > kpiDay){
                        kpiDay = speTrackMap.DateOfExecution__c;
                    }                               
                }
            }
            
            /*if(spetrackList[0].DateOfExecution__c != Null){
                kpiDay = spetrackList[0].DateOfExecution__c;
            }*/
            
            if(kpiDay == Date.newinstance(1960, 1, 1) || kpiDay < System.Today()){
               kpiDay = System.Today(); 
            }
                        
            if(scoreCardgenerator.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(scoreCardgenerator.Additional_Days__c);
                kpiDay = kpiDay.addDays(additional_days);
            }
            
            if(monthvalue < kpiDay.Month() && kpiDay < endD && kpiDay >= strtD){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                displaypopup = true;
                return null;
            }
            else if(monthvalue < kpiDay.Month() && kpiDay < endD && kpiDay < strtD){
                //kpiDay = strtD;
                Date calNCD = Date.NewInstance(strtD.Year(),strtD.Month(),kpiday.Day());
                if(calNCD >= strtD){
                    kpiday = calNCD;
                }
                else{            
                    kpiday = strtD;
                }
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                displaypopup = true;
                return null;
            }
            else if(monthvalue < kpiDay.Month() && kpiDay > endD){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;    
            }
            
            if(kpiDay < endD && kpiDay >= System.Today() && kpiDay >= strtD){
                scoreCardgenerator.Next_Computed_Day__c = kpiday;
            }
            else if(kpiDay < endD && kpiDay >= System.Today() && kpiDay < strtD){
                //scoreCardgenerator.Next_Computed_Day__c = strtD;
                Date calNCD = Date.NewInstance(strtD.Year(),strtD.Month(),kpiday.Day());
                if(calNCD >= strtD){
                    scoreCardgenerator.Next_Computed_Day__c = calNCD;
                }
                else{            
                    scoreCardgenerator.Next_Computed_Day__c = strtD;
                }
            }
            else if(kpiDay < endD && kpiDay < System.Today()){
                Integer additional_days = Integer.ValueOf(scoreCardgenerator.Additional_Days__c);
                scoreCardgenerator.Next_Computed_Day__c = System.Today().addDays(additional_days);
            }
            else if(kpiDay > endD && kpiDay >= System.Today()){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;
            }
         
         //--------------------        
         system.debug('start date is'+strtD);
         system.debug('end date is '+endD);
        if(isClone == 'true')
            scoreCardgenerator.Id = null;
        scoreCardgenerator.StartDate__c = strtD ;
        scoreCardgenerator.EndDate__c= endD;
        scoreCardgenerator.TimeFrame__c = scoreCardgenerator.FrequencyInMonths__c;
        scoreCardgenerator.isAdhoc__c = true;
        If (scoreCardgenerator.Stage__c != SPE_Constants.PUBLISHED_LIFECYCLESTAGE)
            scoreCardgenerator.Stage__c='Draft';
        if(scoreCardgenerator.Name =='' || scoreCardgenerator.Name == null){
          showmsg = true;
           ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please enter Scorecard Generator Name to continue');
           ApexPages.addMessage(myMsg); 
        } 
         try{
            pageReference pg;
            if(isClone == 'true'){
                insert scoreCardgenerator;
                if(scoreCardgenerator.Id != null){
                    for(SPE_Scorecard_Plan__c sp : lstScorecardPlans){
                        sp.id= null;
                        sp.Scorecard_Generator__c = scoreCardgenerator.Id;
                    }
                    for(SPE_ScorecardSupplierMap__c sp1: lstScorecardSupplierMap){
                        sp1.id= null;
                        sp1.ScorecardGenerator__c = scoreCardgenerator.Id;
                    }
                }
                if(!lstScorecardPlans.isEmpty())
                    insert lstScorecardPlans;
                if(!lstScorecardSupplierMap.isEmpty())
                    insert lstScorecardSupplierMap;
                       
                pg = new pageReference('/'+scoreCardgenerator.Id);
            }
            else{
                if(scoreCardgenerator != null)
                    update scoreCardgenerator;
                
                Boolean isAbended = false;

                if (strtDInitial != scoreCardgenerator.StartDate__c ||
                    endDInitial != scoreCardgenerator.EndDate__c ||
                    strFreqInitial != scoreCardgenerator.FrequencyInMonths__c)
                {
                    isAbended = true;
                }
                
                if (scoreCardgenerator.Stage__c == SPE_Constants.PUBLISHED_LIFECYCLESTAGE)
                {
                    
                    List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = CreateScorecardTracker(scoreCardgenerator,isAbended);
                    
                    upsert toBeInsertedScorecardTracker ;
                }
                pg = new pageReference('/'+scoreCardgenerator.Id);
            }
            return pg;
        }
        catch(Exception e){
            ApexPages.addMessages(e);
            system.debug('Exception is'+e);
            return null;
        }
    }
    @TestVisible private List<SPE_ScorecardTracker__c> CreateScorecardTracker (SPE_ScorecardGenerator__c scoreCardgenerate, Boolean isAbended)
    {
        List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = new List<SPE_ScorecardTracker__c>();
        SPE_ScorecardGenerator__c tempSCG = new SPE_ScorecardGenerator__c();
        tempSCG = [select id,isAdhoc__c,StartDate__c,EndDate__c,Aggregation_Period_Adhoc__c from SPE_ScorecardGenerator__c Where Id=: scoreCardgenerate.Id];
        if (isAbended) 
        {
            List<SPE_ScorecardTracker__c> toBeAbendedTracker = [SELECT Id, ScorecardGenerator__c, Status__c 
                                                                 FROM SPE_ScorecardTracker__c
                                                                WHERE Status__c =  'Pending' AND  ScorecardGenerator__c =: scoreCardgenerate.Id];
                                                          
            for (SPE_ScorecardTracker__c tracker : toBeAbendedTracker)
            {
                tracker.Status__c = 'Abandoned';
                toBeInsertedScorecardTracker.add(tracker);
            }
             
        Date strtDate = System.Today();
        
        if((tempSCG.isAdhoc__c == False) || (tempSCG.isAdhoc__c == True && tempSCG.StartDate__c >= System.Today())){    
            if(scoreCardgenerate.Next_Computed_Day__c == Null){
                strtDate = kpiDay;
            }
            else if(scoreCardgenerate.Next_Computed_Day__c != Null){
                strtDate = scoreCardgenerate.Next_Computed_Day__c;
            } 
        }
        else if(tempSCG.isAdhoc__c == True && tempSCG.StartDate__c < System.Today()){
            strtDate = tempSCG.StartDate__c;
        }
        
        List<Date> toBeStartTracker = new List<Date>();
        
        if (scoreCardgenerate.FrequencyInMonths__c == '0')
            {
                toBeStartTracker.add(strtDate);
            }
        else{
            
            while (strtDate <= scoreCardgenerate.EndDate__c )
            {
                toBeStartTracker.add(strtDate);
                
                strtDate = strtDate.addMonths(integer.ValueOf(scoreCardgenerate.FrequencyInMonths__c));
            }
         }
        Integer timeFrame = integer.ValueOf(scoreCardgenerate.TimeFrame__c);
        System.debug('toBeStartTracker-----' + toBeStartTracker);
        for  (Date sDate : toBeStartTracker)
        {
            SPE_ScorecardTracker__c scoreTrack = new SPE_ScorecardTracker__c();
            if(tempSCG.isAdhoc__c){
                if(tempSCG.Aggregation_Period_Adhoc__c == 'Monthly'){
                    if(sDate.month() > 9)
                        scoreTrack.Name = 'P - ' + sDate.month() + ' '+ String.valueOf(sDate.year());
                    else
                        scoreTrack.Name = 'P - 0' + sDate.month() + ' '+ String.valueOf(sDate.year());
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Quarterly'){
                    Integer quarter = sDate.month()/3;
                    if(quarter == 0)
                        scoreTrack.Name = 'Q1 - ' + String.valueOf(sDate.year());
                    else if(quarter == 1)
                        scoreTrack.Name = 'Q2 - ' + String.valueOf(sDate.year());
                    else if (quarter == 2)
                        scoreTrack.Name = 'Q3 - ' + String.valueOf(sDate.year());
                    else 
                        scoreTrack.Name = 'Q4 - ' + String.valueOf(sDate.year());
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Half Yearly'){
                    Integer halfYearly = sDate.month()/6;
                    if(halfYearly == 0)
                        scoreTrack.Name = 'H1 - ' + String.valueOf(sDate.year());
                    else if(halfYearly == 1)
                        scoreTrack.Name = 'H2 - ' + String.valueOf(sDate.year());
                    
                }
                else{
                    scoreTrack.Name = String.valueOf(sDate.year());
                }
            }
            else{
                scoreTrack.Name = SPE_Utility.monthsMap.get(sDate.month()) + ' - '+ String.valueOf(sDate.year());
            }
            scoreTrack.ScorecardGenerator__c = scoreCardgenerate.Id;
            //scoreTrack.DateOfExecution__c = sDate;
            if(kpiDay != Null){
                scoreTrack.DateOfExecution__c = Date.newinstance(sDate.year(),sDate.month(),kpiDay.day());
            }
            else{
                scoreTrack.DateOfExecution__c = Date.newinstance(sDate.year(),sDate.month(),scoreCardgenerator.Next_Computed_Day__c.day());
            }
            if(tempSCG.isAdhoc__c){
                if(tempSCG.Aggregation_Period_Adhoc__c == 'Monthly'){
                    Integer numberOfDays = Date.daysInMonth(sDate.year(), sDate.month());
                    Date lastDayOfMonth = Date.newInstance(sDate.year(), sDate.month(), numberOfDays);
                    scoreTrack.EndDate__c = lastDayOfMonth;
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Quarterly'){
                    if(scoreTrack.Name.startsWith('Q1')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),03,31);
                    }
                    else if(scoreTrack.Name.startsWith('Q2')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),06,30);
                    }
                    else if(scoreTrack.Name.startsWith('Q3')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),09,30);
                    }
                    else{
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),12,31);
                    }
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Half Yearly'){
                    if(scoreTrack.Name.startsWith('H1')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),06,30);
                    }
                    else{
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),12,31);
                    }
                }
                else{
                    scoreTrack.EndDate__c = Date.newInstance(sDate.year(),12,31);
                }
            }
            else{
                scoreTrack.EndDate__c = sDate.addMonths(integer.ValueOf(scoreCardgenerate.FrequencyInMonths__c)).addDays(-timeFrame);
            }
            scoreTrack.Status__c = 'Pending';
              
            toBeInsertedScorecardTracker.add(scoreTrack);
        }
       } 
        return toBeInsertedScorecardTracker;
    }
}