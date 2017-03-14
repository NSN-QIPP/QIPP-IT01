global class SPE2KPINextScheduleUpdateBatch implements Database.Batchable<sObject>{
    global String query;
    global Date kpiDay;
    
    global SPE2KPINextScheduleUpdateBatch(){
        query = 'SELECT Id,Buffer_Days__c,ScheduledDate__c,FrequencyinMonth__c FROM SPE_KPIDefinition__c WHERE ScheduledDate__c = today OR (ScheduledDate__c = null AND PI_Data__c = null)';
        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<sObject>scope){
        List<SPE_KPIDefinition__c> kpiDefList = new List<SPE_KPIDefinition__c>();
        for(sobject obj :scope){
            SPE_KPIDefinition__c kpiDef = (SPE_KPIDefinition__c)obj;
            List<SPE_KPICalculation__c> kpiCals = [Select Id,PIDefination__c,PIDefination__r.DataAcquisitionMethod__c,
                                                  PIDefination__r.PIUploadDuedate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                                                  KPIDefinition__r.FrequencyinMonth__c,PIDefination__r.Frequency__c,
                                                  PrevKPIDefination__c,PrevKPIDefination__r.ScheduledDate__c,PrevKPIDefination__r.FrequencyinMonth__c
                                                  From SPE_KPICalculation__c 
                                                  Where KPIDefinition__c =: kpiDef.Id];
            
            Map<String,String> frequencyMap = new Map<String,String>();
            
            Date comparingDate = Date.newInstance(1800, 1, 1);
            Date kpiDate = Date.newInstance(1800, 1, 1);
            Integer comparingFrequency = 1000000;
            
            Set<ID> pids = new Set<ID>();
            
            for(SPE_KPICalculation__c cal :kpiCals){                                                       
               if(cal.PIDefination__c != null){
                   if(cal.PIDefination__r.PIUploadDuedate__c != null){
                       frequencyMap.put(cal.PIDefination__c,cal.PIDefination__r.Frequency__c+'~'+cal.PIDefination__r.PIUploadDuedate__c);
                   }else{
                       frequencyMap.put(cal.PIDefination__c,cal.PIDefination__r.Frequency__c+'~'+System.today());
                   }
                   
                   if(cal.PIDefination__r.DataAcquisitionMethod__c == 'Survey'){
                       pids.add(cal.PIDefination__c);                                       
                   }
               }
               if(cal.PrevKPIDefination__c != null){
                   if(cal.PrevKPIDefination__r.ScheduledDate__c != null){
                       frequencyMap.put(cal.PrevKPIDefination__c,cal.PrevKPIDefination__r.FrequencyinMonth__c+'~'+cal.KPIDefinition__r.ScheduledDate__c);
                   }else{
                       frequencyMap.put(cal.PrevKPIDefination__c,cal.PrevKPIDefination__r.FrequencyinMonth__c+'~'+System.today());
                   }
               }                        
            }
            
            
            Set<ID> kpids = new Set<ID>();
            Set<ID> stempids = new Set<ID>();
            if(pids.size() > 0){
                List<SPE_KPICalculation__c> kpiCals2 = [SELECT Id,KPIDefinition__c, PIDefination__c, TimeFrame__c FROM SPE_KPICalculation__c 
                                                               WHERE PIDefination__c != null 
                                                               AND PIDefination__c IN : pids
                                                               AND PIDefination__r.DataAcquisitionMethod__c = 'Survey'];                                                         
                for(SPE_KPICalculation__c skal: kpiCals2){
                   kpids.add(skal.KPIDefinition__c); 
                }
                
                List<SPE_KPIDefinition__c> kpilist = [Select ID,KPI_Title__c,PI_Data__c from SPE_KPIDefinition__c where PI_Data__c IN: pids];
                if(kpilist.size() > 0){
                    for(SPE_KPIDefinition__c kpi: kpilist){
                       kpids.add(kpi.ID); 
                    }
                }
            }
            
            if(kpids.size() > 0){
                for (SPE_SPEKPIMap__c speKPI : [SELECT Id, KPIDefinition__c,SPETemplate__c FROM SPE_SPEKPIMap__c WHERE SPE_SPEKPIMap__c.KPIDefinition__c IN:kpids])
                {
                    stempids.add(speKPI.SPETemplate__c);
                }
            }
            
            List<SPE_SPEPlan__c> splanlist = [Select ID,Name,FrequencyInMonths__c,StartDate__c,SPETemplate__c from SPE_SPEPlan__c 
                                              where SPETemplate__c IN: stempids];
                                              
            //System.Debug('****splanlist***'+splanlist);
            if(splanlist.size() > 0){                                  
                for(SPE_SPEPlan__c splan: splanlist){
                    if(splan.StartDate__c.Month() == System.Today().Month() && splan.StartDate__c > kpiDate){
                        kpiDate = splan.StartDate__c;
                    }
                }                                               
            }
            
            Set<Integer> uniqueFrequencies = new Set<Integer>();
            for(String frq :frequencyMap.values()){
                uniqueFrequencies.add(integer.valueOf(frq.split('~')[0]));
            }
            for(String val :frequencyMap.keySet()){
                if(date.valueOf(frequencyMap.get(val).split('~')[1]) > comparingDate){                        
                    comparingDate = date.valueOf(frequencyMap.get(val).split('~')[1]);                  
                }
            }
            
            if(comparingDate < kpiDate){
                comparingDate = kpiDate;
            }          
                         
            if(kpiDef.Buffer_Days__c == null){
                kpiDef.Buffer_Days__c = 0;
            }
            try{
                if(comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).addDays(integer.valueOf(kpiDef.Buffer_Days__c)).Month() == comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).Month() 
                   && comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).addDays(integer.valueOf(kpiDef.Buffer_Days__c)) >= System.Today()){                
                    kpiDef.ScheduledDate__c = comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).addDays(integer.valueOf(kpiDef.Buffer_Days__c));                          
                }
                else if(comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).addDays(integer.valueOf(kpiDef.Buffer_Days__c)).Month() == comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).Month() 
                   && comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).addDays(integer.valueOf(kpiDef.Buffer_Days__c)) < System.Today()){
                    kpiDef.ScheduledDate__c = Date.newinstance(System.Today().Year(),System.Today().Month(),27);
                }
                else if(comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).addDays(integer.valueOf(kpiDef.Buffer_Days__c)).Month() > comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).Month()
                        && comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)) >= System.Today()){
                    kpiDef.ScheduledDate__c = Date.newinstance(Integer.valueOf(comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).Year()),Integer.valueOf(comparingDate.addMonths(integer.valueOf(kpidef.FrequencyinMonth__c)).Month()),27);
                }
                kpiDefList.add(kpiDef);
            }catch(Exception e){
                system.debug(e.getmessage());
            }
            
        }
        for(SPE_KPIDefinition__c k1 :kpiDefList){
            if(k1.PI_Data__c != null){
                k1.Buffer_Days__c = null;
            }
        }
        update kpiDefList;
    }
    global void finish(Database.BatchableContext BC){
        if(!Test.isRunningTest()){
            SPE2SPNewComputedDateUpdateBatch_new spBatch= new SPE2SPNewComputedDateUpdateBatch_new();
            database.executebatch(spBatch,1);
        }
    }
}