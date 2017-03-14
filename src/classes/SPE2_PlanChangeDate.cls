public with sharing class SPE2_PlanChangeDate{
    private ApexPages.StandardController standardController;
    public List<SPE_SPEPlan__c> spePlanList{get;set;}
    public List<SPE_SPEPlan__c> spePlanDate{get;set;}
    public String spePlanIdentifier{get;set;}
    public SPE_SPEPlan__c spePlan{get;set;}
    public Set<string> selectedPlanIds{get;set;}
    public Date new_st_date;
    public Date new_end_date;
    public List<SPE_KPICalculation__c> kpiCals;
    public Map<String,Integer> mapMonthName{get;set;}
    public SPE2_PlanChangeDate(ApexPages.StandardController standardController){
        
        spePlan = new SPE_SPEPlan__c();
        spePlanList = new List<SPE_SPEPlan__c>();
        selectedPlanIds = new Set<String>();
        
        mapMonthName = new Map<String,Integer>();
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
        
        new_st_date = Date.newinstance(1960, 1, 1);
        new_end_date = Date.newinstance(1960, 1, 1);
        
        spePlanIdentifier = apexpages.currentpage().getparameters().get('planIdentifier');           
        spePlanList = [Select Id,Name,SPEScoringTemplate__c,Start_Month__c,Start_Year__c,
                        End_Month__c,End_Year__c,Next_Computed_Day__c,Additional_Days__c From SPE_SPEPlan__c 
                      Where identifierParam__c =:spePlanIdentifier];
                      
        system.debug('spePlanList ::'+spePlanList);
        Set<ID> scortempID = new Set<ID>();
        
        if(spePlanList.size() > 0){
            for(SPE_SPEPlan__c sp: spePlanList){
                scortempID.add(sp.SPEScoringTemplate__c);
            }
        }
                      
        List<SPE_ScoringTemplate__c> scoringTemplates = [SELECT SPETemplate__c 
                                                         FROM SPE_ScoringTemplate__c
                                                         WHERE Id IN: scortempID]; 
                                                         
        system.debug('scoringTemplates ::'+scoringTemplates);
        Set<ID> spetempID = new Set<ID>();
        
        for(SPE_ScoringTemplate__c sc: scoringTemplates){
            spetempID.add(sc.SPETemplate__c);
        }
                                                                                         
        List<SPE_SPEKPIMap__c> speKPIMapList = [SELECT Id,SPETemplate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c 
                                                    from SPE_SPEKPIMap__c where SPETemplate__c IN: spetempID];
                                                    
        Set<ID> kpiID = new Set<ID>();        
        for (SPE_SPEKPIMap__c speKPIMap :speKPIMapList){  
            kpiID.add(speKPIMap.KPIDefinition__c);            
        } 
        
        system.debug('kpiID ::'+kpiID);
                                                                                                         
        kpiCals = [Select Id,PIDefination__c,PIDefination__r.DataAcquisitionMethod__c,
                   PIDefination__r.PIUploadDuedate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                   KPIDefinition__r.FrequencyinMonth__c,PIDefination__r.Frequency__c,
                   PrevKPIDefination__c,PrevKPIDefination__r.ScheduledDate__c,PrevKPIDefination__r.FrequencyinMonth__c
                   From SPE_KPICalculation__c Where KPIDefinition__c IN :kpiID 
                   AND PIDefination__r.DataAcquisitionMethod__c = 'Data Load'];
                   
        system.debug('kpiCals ::'+kpiCals); 
                                                               
    }
    public PageReference returnbackToPlan(){
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    public PageReference updateSPEPlans(){       
        for(SPE_KPICalculation__c kp: kpiCals){
           if(kp.PIDefination__r.PIUploadDuedate__c != null && mapMonthName.get(spePlan.Start_Month__c) == kp.PIDefination__r.PIUploadDuedate__c.Month() && Integer.ValueOf(spePlan.Start_Year__c) == kp.PIDefination__r.PIUploadDuedate__c.Year()){
               if(kp.PIDefination__r.PIUploadDuedate__c > new_st_date){
                   new_st_date = kp.PIDefination__r.PIUploadDuedate__c;
               }
            } 
        }
        
        system.debug('new_st_date ::'+new_st_date ); 
        if(kpiCals.size() == 0 || new_st_date == Date.newinstance(1960, 1, 1)){
            if(spePlan.Start_Year__c != null && spePlan.Start_Month__c != null){
                new_st_date = Date.NewInstance(Integer.ValueOf(spePlan.Start_Year__c),mapMonthName.get(spePlan.Start_Month__c),1);
            }
        }
        system.debug('new_st_date ::'+new_st_date );
        
        if(spePlan.End_Month__c != null && spePlan.End_Year__c != null){
            new_end_date = Date.NewInstance(Integer.ValueOf(spePlan.End_Year__c),mapMonthName.get(spePlan.End_Month__c),1);
            new_end_date = new_end_date.addMonths(1);
            new_end_date = new_end_date.addDays(-1);
        }
       
        for(SPE_SPEPlan__c pl :spePlanList){            
            if(pl.Additional_Days__c != Null && new_st_date != Date.newinstance(1960, 1, 1)){
                Integer additional_days = Integer.ValueOf(pl.Additional_Days__c);
                new_st_date = new_st_date.addDays(additional_days);
            }
            
            if(new_st_date != Date.newinstance(1960, 1, 1)){
                pl.StartDate__c = new_st_date;
                if(pl.Next_Computed_Day__c < new_st_date){
                  pl.Next_Computed_Day__c =  new_st_date; 
                }
            }
            
            if(spePlan.Start_Month__c != null && spePlan.Start_Year__c != null){
                pl.Start_Month__c = spePlan.Start_Month__c;
                pl.Start_Year__c = spePlan.Start_Year__c;
            }
            
            if(spePlan.End_Month__c != null && spePlan.End_Year__c != null){
                pl.End_Month__c = spePlan.End_Month__c;
                pl.End_Year__c  = spePlan.End_Year__c;
            }
            
            if(new_end_date != Date.newinstance(1960, 1, 1)){
                pl.EndDate__c = new_end_date;
            }
            
        }
        try{
            update spePlanList;
        }catch(Exception e){}
        
        if(new_st_date != Date.newinstance(1960, 1, 1) || new_end_date != Date.newinstance(1960, 1, 1)){
            SPE2_ChangeTrackerBatch dtBatch = new SPE2_ChangeTrackerBatch(spePlanIdentifier);
            database.executebatch(dtBatch,1);
        }
        
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
}