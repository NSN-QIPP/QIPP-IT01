global class SPE2_ChangeTrackerBatch implements Database.Batchable<sObject>{
    global String query;

    global SPE2_ChangeTrackerBatch(String PlanIdentifier){
        query='SELECT Id,Name,Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c,BusinessUnit__c,BusinessLine__c,Product__c,SPETemplate__c,SPEScoringTemplate__c,Start_Month__c,Start_Year__c,End_Month__c,StartDate__c,EndDate__c,FrequencyInMonths__c,';
        query+='End_Year__c,Additional_Days__c,Stage__c,Next_Computed_Day__c,Ad_Hoc_Plan__c  FROM SPE_SPEPlan__c where identifierParam__c = \''+PlanIdentifier+'\'';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC,List<sObject>scope){        
       for(SObject obj:scope){
            SPE_SPEPlan__c spdata = (SPE_SPEPlan__c)obj;
            
            Boolean isAbended = true;
            
            if (spdata.Stage__c == SPE_Constants.PUBLISHED_LIFECYCLESTAGE){               
                List<SPE_SPETracker__c> toBeInsertedSPETracker = createSPETracker(spdata,isAbended);
                upsert toBeInsertedSPETracker;
            }
        }                  
    }         
    global List<SPE_SPETracker__c> createSPETracker(SPE_SPEPlan__c spePlan, Boolean isAbended)
    {
        List<SPE_SPETracker__c> toBeInsertedSPETracker = new List<SPE_SPETracker__c>();
        
        if (isAbended)
        {
            List<SPE_SPETracker__c> toBeAbendedTracker = [SELECT Id,Name, SPEPlan__c, Status__c 
                                                          FROM SPE_SPETracker__c
                                                          WHERE Status__c =:SPE_Constants.STATUS_PENDING AND  SPEPlan__c =: spePlan.Id];                                                            
             
            List<SPE_SPETracker__c> completedtracker = [SELECT Id,Name, SPEPlan__c, Status__c 
                                                          FROM SPE_SPETracker__c
                                                          WHERE Status__c = 'Completed' AND  SPEPlan__c =: spePlan.Id];
                                                          
            Map<String,String> trackernameMap = new  Map<String,String>();
            for(SPE_SPETracker__c spt: completedtracker){
                trackernameMap.put(spt.Name,spt.Name);
            }                                              
                                                                                                      
            for (SPE_SPETracker__c tracker : toBeAbendedTracker)
            {
                tracker.Status__c = SPE_Constants.STATUS_ABANDONED;
                toBeInsertedSPETracker.add(tracker);
            }
            
            Date strtDate = System.Today();
            
            Date trakergenerationdate = spePlan.StartDate__c;
            System.Debug('*******trakergenerationdate*******'+trakergenerationdate);
            
            if(spePlan.Next_Computed_Day__c != Null){
                strtDate = spePlan.Next_Computed_Day__c;
            }    
            
            List<Date> toBeStartTracker = new List<Date>();

            if (spePlan.FrequencyInMonths__c == '0')
            {
                if(spePlan.Ad_Hoc_Plan__c == false){
                    toBeStartTracker.add(strtDate);
                }
                else if(spePlan.Ad_Hoc_Plan__c == true){
                    toBeStartTracker.add(trakergenerationdate);
                }
            }
            else
            {
                if(spePlan.Ad_Hoc_Plan__c == false){
                    while (strtDate <= spePlan.EndDate__c )
                    {
                        toBeStartTracker.add(strtDate);                    
                        strtDate = strtDate.addMonths(Integer.valueOf(spePlan.FrequencyInMonths__c));
                    }
                }
                else if(spePlan.Ad_Hoc_Plan__c == true){
                    while (trakergenerationdate <= spePlan.EndDate__c )
                    {
                        toBeStartTracker.add(trakergenerationdate);                    
                        trakergenerationdate = trakergenerationdate.addMonths(Integer.valueOf(spePlan.FrequencyInMonths__c));
                    }
                }
            }
            if(spePlan.Ad_Hoc_Plan__c == false){
                for(Date sDate : toBeStartTracker){
                    if(!trackernameMap.containsKey(SPE_Utility.monthsMap.get(sDate.addMonths(-1).month()) + ' - '+ String.valueOf(sDate.addMonths(-1).year()))){               
                        SPE_SPETracker__c speTrack = new SPE_SPETracker__c();
                        speTrack.Name = SPE_Utility.monthsMap.get(sDate.addMonths(-1).month()) + ' - '+ String.valueOf(sDate.addMonths(-1).year());
                        speTrack.SPEPlan__c = spePlan.Id;
                        speTrack.SPETemplate__c = spePlan.SPETemplate__c;
                        speTRack.DateOfExecution__c = sDate;
                        speTRack.Status__c = SPE_Constants.STATUS_PENDING ;
                        
                        speTrack.Region__c = spePlan.Region__c;
                        speTrack.SubRegion__c = spePlan.SubRegion__c;
                        speTrack.Country__c = spePlan.Country__c;
                        speTrack.Project__c = spePlan.Project__c;
                        
                        speTrack.BusinessLine__c = spePlan.BusinessLine__c;
                        speTrack.BusinessUnit__c = spePlan.BusinessUnit__c;
                        speTrack.Product__c = spePlan.Product__c;
                        
                        speTrack.Category__c = spePlan.Category__c;
                        speTrack.CategoryGroup__c = spePlan.CategoryGroup__c;
                        speTrack.CategoryCluster__c = spePlan.CategoryCluster__c;
                    
                        toBeInsertedSPETracker.add(speTrack);
                    }
                }
            }
            else if(spePlan.Ad_Hoc_Plan__c == true){
                for(Date sDate : toBeStartTracker){
                    if(!trackernameMap.containsKey(SPE_Utility.monthsMap.get(sDate.addMonths(-1).month()) + ' - '+ String.valueOf(sDate.addMonths(-1).year()))){
                        SPE_SPETracker__c speTrack = new SPE_SPETracker__c();
                        speTrack.Name = SPE_Utility.monthsMap.get(sDate.addMonths(-1).month()) + ' - '+ String.valueOf(sDate.addMonths(-1).year());
                        speTrack.SPEPlan__c = spePlan.Id;
                        speTrack.SPETemplate__c = spePlan.SPETemplate__c;
                        speTRack.DateOfExecution__c = sDate;
                        speTRack.Status__c = SPE_Constants.STATUS_PENDING ;
                        
                        speTrack.Region__c = spePlan.Region__c;
                        speTrack.SubRegion__c = spePlan.SubRegion__c;
                        speTrack.Country__c = spePlan.Country__c;
                        speTrack.Project__c = spePlan.Project__c;
                        
                        speTrack.BusinessLine__c = spePlan.BusinessLine__c;
                        speTrack.BusinessUnit__c = spePlan.BusinessUnit__c;
                        speTrack.Product__c = spePlan.Product__c;
                        
                        speTrack.Category__c = spePlan.Category__c;
                        speTrack.CategoryGroup__c = spePlan.CategoryGroup__c;
                        speTrack.CategoryCluster__c = spePlan.CategoryCluster__c;
                        
                       
                        toBeInsertedSPETracker.add(speTrack);
                    }
                }
            }
        }
        System.Debug('**********toBeInsertedSPETracker************'+toBeInsertedSPETracker); 
        return toBeInsertedSPETracker;
    } 
    global void finish(Database.BatchableContext BC){
    }
}