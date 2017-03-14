global class SPE2SPNewComputedDateUpdateBatch_new implements Database.Batchable<sObject>{
    global String query;
    global Date kpiDay;
    
    global SPE2SPNewComputedDateUpdateBatch_new(){
        query='SELECT Name,Additional_Days__c,Next_Computed_Day__c,StartDate__c,FrequencyInMonths__c,SPEScoringTemplate__c,';
        query+='EndDate__c FROM SPE_SPEPlan__c where (Next_Computed_Day__c < today OR Next_Computed_Day__c = Null) AND EndDate__c > today';      
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){
           
        List<SPE_SPEPlan__c>  sptemp = new List<SPE_SPEPlan__c>();
        Date mydate = System.Today();
        Integer monthvalue = mydate.Month();
        
        kpiDay = System.Today();
        
        for(SObject obj:scope){
            SPE_SPEPlan__c spdata = (SPE_SPEPlan__c)obj;
            Id templateId = [SELECT Id, SPETemplate__c from SPE_ScoringTemplate__c WHERE Id =: spdata.SPEScoringTemplate__c].SPETemplate__c;
            Id speKPIMapId = [SELECT Id, SPETemplate__c,SPEKPIMap__c from SPE_ScoringTemplate__c WHERE Id =: spdata.SPEScoringTemplate__c].SPEKPIMap__c;              
            List<SPE_SPEKPIMap__c> speKPIMapList = [SELECT Id,SPETemplate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c from SPE_SPEKPIMap__c where SPETemplate__c =:templateId ];
            for (SPE_SPEKPIMap__c speKPIMap : speKPIMapList )
            {  
                if (speKPIMap.KPIDefinition__r.ScheduledDate__c != null && monthvalue == speKPIMap.KPIDefinition__r.ScheduledDate__c.Month())
                {
                    if(speKPIMap.KPIDefinition__r.ScheduledDate__c > kpiDay){
                        kpiDay = speKPIMap.KPIDefinition__r.ScheduledDate__c;
                    }   
                     
                }                
            } 
                        
            if(kpiDay == System.Today()){
               for (SPE_SPEKPIMap__c speKPIMap : speKPIMapList )
                {  
                    if (speKPIMap.KPIDefinition__r.ScheduledDate__c != null && monthvalue < speKPIMap.KPIDefinition__r.ScheduledDate__c.Month())
                    {
                        if(speKPIMap.KPIDefinition__r.ScheduledDate__c > kpiDay){
                            kpiDay = speKPIMap.KPIDefinition__r.ScheduledDate__c;
                        }                                   
                    }
                }
            }
            
            if(spdata.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(spdata.Additional_Days__c);
                kpiDay = kpiDay.addDays(additional_days);
            }
            
            if(kpiDay < System.Today()){
                if(spdata.FrequencyInMonths__c != Null){
                   Integer additional_months = Integer.ValueOf(spdata.FrequencyInMonths__c);
                   kpiDay = kpiDay.addMonths(additional_months); 
                }
            }
            
            if(kpiDay < spdata.EndDate__c && kpiDay > spdata.StartDate__c && kpiDay >= System.Today()){
                spdata.Next_Computed_Day__c = kpiday;
            }
            else if(kpiDay < spdata.EndDate__c && kpiDay < spdata.StartDate__c && kpiDay >= System.Today()){
                //spdata.Next_Computed_Day__c = spdata.StartDate__c;
                Date calNCD = Date.NewInstance(spdata.StartDate__c.Year(),spdata.StartDate__c.Month(),kpiday.Day());
                if(calNCD >= spdata.StartDate__c){
                   spdata.Next_Computed_Day__c = calNCD;
               }
               else{            
                   spdata.Next_Computed_Day__c = spdata.StartDate__c;
               }
            }
            else if(kpiDay < spdata.EndDate__c && kpiDay < System.Today()){
                //spdata.Next_Computed_Day__c = spdata.StartDate__c;
                Date calNCD = Date.NewInstance(spdata.StartDate__c.Year(),spdata.StartDate__c.Month(),kpiday.Day());
                if(calNCD >= spdata.StartDate__c){
                   spdata.Next_Computed_Day__c = calNCD;
               }
               else{            
                   spdata.Next_Computed_Day__c = spdata.StartDate__c;
               }
            }
            sptemp.add(spdata);      
        }
        
        try{
            update sptemp;
        }catch(Exception e){}
  
    }
    
    global void finish(Database.BatchableContext BC){
        if(!Test.isRunningTest()){
            SPE2SGNewComputedDateUpdateBatch_new sgBatch= new SPE2SGNewComputedDateUpdateBatch_new();
            database.executebatch(sgBatch,1);
        }
    }
}