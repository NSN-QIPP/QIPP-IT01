global class SPE2SGNewComputedDateUpdateBatch_new implements Database.Batchable<sObject>{
    global String query;
    global Date kpiDay;
    
    global SPE2SGNewComputedDateUpdateBatch_new(){
        query='SELECT Name,Additional_Days__c,Next_Computed_Day__c,StartDate__c,FrequencyInMonths__c,ScorecardTemplate__c,';
        query+='EndDate__c FROM SPE_ScorecardGenerator__c where ((Next_Computed_Day__c < today OR Next_Computed_Day__c = Null) AND EndDate__c > today AND FrequencyInMonths__c != Null)';      
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){
           
        List<SPE_ScorecardGenerator__c>  sptemp = new List<SPE_ScorecardGenerator__c>();
        Date mydate = System.Today();
        Integer monthvalue = mydate.Month();       
        kpiDay = System.Today();
        
        for(SObject obj:scope){  
           SPE_ScorecardGenerator__c sgdata = (SPE_ScorecardGenerator__c)obj;   
           Id templateId = sgdata.ScorecardTemplate__c;
           List<SPE_ScorecardSPETemplateMap__c> scorecardTemplatelist = [SELECT SPETemplate__c,ScorecardTemplate__c
                                                                         FROM SPE_ScorecardSPETemplateMap__c
                                                                         WHERE ScorecardTemplate__c =: templateId];
                                                         
            //sgdata.ScorecardTemplate__c = scorecardTemplates[0].ScorecardTemplate__c;
            List<Id> spetemplatesID = new List<ID>();
            for(SPE_ScorecardSPETemplateMap__c ssspe: scorecardTemplatelist){
                spetemplatesID.add(ssspe.SPETemplate__c);
            }
            
            List<SPE_SPEPlan__c> spePlanMapList = [SELECT Id,SPETemplate__c,Next_Computed_Day__c from SPE_SPEPlan__c where SPETemplate__c IN:spetemplatesID];
            List<ID> speplanID = new List<ID>();
            for(SPE_SPEPlan__c spp: spePlanMapList){
                speplanID.add(spp.ID);
            }
            
            //List<SPE_SPETracker__c> spetrackList = [Select ID,Name,DateOfExecution__c,SPEPlan__c,Period__c from SPE_SPETracker__c where SPEPlan__c IN:speplanID order by DateOfExecution__c asc];
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
       
            if(kpiDay == Date.newinstance(1960, 1, 1) || kpiDay < System.Today()){
               kpiDay = System.Today(); 
            }
             
            if(sgdata.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(sgdata.Additional_Days__c);
                kpiDay = kpiDay.addDays(additional_days);
            }
            
            if(kpiDay < System.Today()){
                if(sgdata.FrequencyInMonths__c != Null){
                   Integer additional_months = Integer.ValueOf(sgdata.FrequencyInMonths__c);
                   kpiDay = kpiDay.addMonths(additional_months); 
                }
            }
            
            if(kpiDay < sgdata.EndDate__c && kpiDay > sgdata.StartDate__c && kpiDay >= System.Today()){
                sgdata.Next_Computed_Day__c = kpiday;
            }
            else if(kpiDay < sgdata.EndDate__c && kpiDay < sgdata.StartDate__c && kpiDay >= System.Today()){
                //sgdata.Next_Computed_Day__c = sgdata.StartDate__c;
                Date calNCD = Date.NewInstance(sgdata.StartDate__c.Year(),sgdata.StartDate__c.Month(),kpiday.Day());
                if(calNCD >= sgdata.StartDate__c){
                    sgdata.Next_Computed_Day__c = calNCD;
                }
                else{            
                    sgdata.Next_Computed_Day__c = sgdata.StartDate__c;
                }
            }
            else if(kpiDay < sgdata.EndDate__c && kpiDay > sgdata.StartDate__c && kpiDay < System.Today()){
                Integer additional_days = Integer.ValueOf(sgdata.Additional_Days__c);
                sgdata.Next_Computed_Day__c = System.Today().addDays(additional_days);
            }
            else if(kpiDay < sgdata.EndDate__c && kpiDay < sgdata.StartDate__c && kpiDay < System.Today()){
                //sgdata.Next_Computed_Day__c = sgdata.StartDate__c;
                Date calNCD = Date.NewInstance(sgdata.StartDate__c.Year(),sgdata.StartDate__c.Month(),kpiday.Day());
                if(calNCD >= sgdata.StartDate__c){
                    sgdata.Next_Computed_Day__c = calNCD;
                }
                else{            
                    sgdata.Next_Computed_Day__c = sgdata.StartDate__c;
                }
            }
            
           sptemp.add(sgdata);    
            
         }   
        
        try{
            update sptemp;
        }catch(Exception e){}
  
    }
    
    global void finish(Database.BatchableContext BC){
    }
}