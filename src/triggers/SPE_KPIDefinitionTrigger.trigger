trigger SPE_KPIDefinitionTrigger on SPE_KPIDefinition__c (before update, after update,before insert) 
{
 
    //SPE_KPIDefinitionTrigger.UpdatePIDefinition(trigger.new, trigger.oldMap);
   
    public static boolean firstRun = true;
    if(Trigger.isAfter && trigger.isUpdate)
    {
        if(firstRun){
        SPE2_KPIDefinitionTrigger.ConvertKPIValues(trigger.new, trigger.oldMap);
        SPE2_KPIDefinitionTrigger.updateKPIinSPETemplate(trigger.new, trigger.oldMap);
        firstRun = false;
        }
    }
    
    if(Trigger.isBefore && trigger.isUpdate)
    {
        if(firstRun){
            SPE2_KPIDefinitionTrigger.DeleteKPICalculations(trigger.new);    
            SPE2_KPIDefinitionTrigger.scheduledDateValidation(Trigger.old, Trigger.new, Trigger.oldMap);
            firstRun = false;    
        }
    }
       
    if(Trigger.isBefore && trigger.isInsert)
    {
        if(firstRun){
        for(SPE_KPIDefinition__c k:trigger.new)
            k.lifecycleStage__c='Draft';
        
        SPE2_KPIDefinitionTrigger.UpdateVersion(trigger.new); 
        firstRun = false;   
        }    
     }
     if(Trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
         List<SPE_KPIDefinition__c> kpiDefList = new List<SPE_KPIDefinition__c>();
         Boolean isCal = false;
         ID pid;         
         for(SPE_KPIDefinition__c kpi:trigger.new){
             if(kpi.PI_Data__c != Null){
                 pid = kpi.PI_Data__c;                
             }
             if(trigger.isInsert){
                 if(kpi.PI_Data__c == Null){
                     isCal = true;
                 }
             }
             if(trigger.isUpdate){                 
                 if((kpi.PI_Data__c == Null && kpi.Buffer_Days__c != Null && kpi.Buffer_Days__c != Trigger.OldMap.get(kpi.ID).Buffer_Days__c) || (kpi.PI_Data__c == Null && kpi.KPICalulationUpdate__c != Trigger.OldMap.get(kpi.ID).KPICalulationUpdate__c)){
                     isCal = true;
                 }
             }             
         }
                          
         if(pid != Null){
             List<SPE_PIDefinition__c> pi = new List<SPE_PIDefinition__c>();
             pi = [Select ID,PIUploadDuedate__c from SPE_PIDefinition__c where ID =: pid AND PIUploadDuedate__c != Null];
             if(pi.size() > 0){   
                 for(SPE_KPIDefinition__c kpi1:trigger.new){
                     if(pi[0].PIUploadDuedate__c >= System.Today()){
                        kpi1.ScheduledDate__c = pi[0].PIUploadDuedate__c;                    
                     }
                     else if(pi[0].PIUploadDuedate__c < System.Today()){
                         kpi1.ScheduledDate__c = Date.newInstance(System.Today().Year(),System.Today().Month(),pi[0].PIUploadDuedate__c.Day());
                     }
                     kpiDefList.add(kpi1);
                 }
             }
             else if(pi.size() == 0){
                 for(SPE_KPIDefinition__c kpi1:trigger.new){
                     kpi1.ScheduledDate__c = null;
                     kpiDefList.add(kpi1);
                 } 
             }
             
         }
         
         if(isCal == true){                     
            List<SPE_KPICalculation__c> kpiCals1 = [Select Id,PIDefination__c,PIDefination__r.DataAcquisitionMethod__c,
                                                    PIDefination__r.PIUploadDuedate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                                                    KPIDefinition__r.FrequencyinMonth__c,PIDefination__r.Frequency__c,
                                                    PrevKPIDefination__c,PrevKPIDefination__r.ScheduledDate__c,PrevKPIDefination__r.FrequencyinMonth__c
                                                    From SPE_KPICalculation__c 
                                                    Where KPIDefinition__c IN: Trigger.New]; 
            
            //List<SPE_KPIDefinition__c> kpidefs = [Select Id,ScheduledDate__c,Buffer_Days__c,FrequencyinMonth__c From SPE_KPIDefinition__c Where Id IN:Trigger.New];
            if(kpiCals1.size() > 0){
                Date comparingDate = Date.newInstance(1800, 1, 1);
                Date kpiDate = Date.newInstance(1800, 1, 1);
                Integer comparingFrequency = 1000000;
                Set<ID> pids = new Set<ID>();
                Map<String,String> frequencyMap = new Map<String,String>();
                
                system.debug('kpiCals1::'+kpiCals1);
                for(SPE_KPICalculation__c cal :kpiCals1){                                                       
                   if(cal.PIDefination__c != null){
                       if(cal.PIDefination__r.PIUploadDuedate__c != null && (cal.PIDefination__r.DataAcquisitionMethod__c == 'Data Load' || cal.PIDefination__r.DataAcquisitionMethod__c == 'Standalone Survey')){
                           frequencyMap.put(cal.PIDefination__c,cal.PIDefination__r.Frequency__c+'~'+cal.PIDefination__r.PIUploadDuedate__c+'~'+cal.KPIDefinition__c);
                       }else{
                           //frequencyMap.put(cal.PIDefination__c,cal.PIDefination__r.Frequency__c+'~'+System.today()+'~'+cal.KPIDefinition__c);
                       }
                       if(cal.PIDefination__r.DataAcquisitionMethod__c == 'Survey'){
                           pids.add(cal.PIDefination__c);                                       
                       }               
                   }
                   if(cal.PrevKPIDefination__c != null){
                       if(cal.PrevKPIDefination__r.ScheduledDate__c != null){
                           frequencyMap.put(cal.PrevKPIDefination__c,cal.PrevKPIDefination__r.FrequencyinMonth__c+'~'+cal.PrevKPIDefination__r.ScheduledDate__c+'~'+cal.KPIDefinition__c);
                       }else{
                           frequencyMap.put(cal.PrevKPIDefination__c,cal.PrevKPIDefination__r.FrequencyinMonth__c+'~'+System.today()+'~'+cal.KPIDefinition__c);
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
                                                  
                System.Debug('****splanlist***'+splanlist);
                if(splanlist.size() > 0){                                  
                    for(SPE_SPEPlan__c splan: splanlist){
                        if(splan.StartDate__c.Month() == System.Today().Month() && splan.StartDate__c > kpiDate){
                            kpiDate = splan.StartDate__c;
                        }
                    }                                               
                }
                
                System.Debug('****kpiDate***'+kpiDate);
                
                List<String> uniqueKPIs = new List<String>();
                Set<Integer> uniqueFrequencies = new Set<Integer>();
                for(String frq :frequencyMap.values()){
                    uniqueKPIs.add(frq.split('~')[2]);
                    uniqueFrequencies.add(integer.valueOf(frq.split('~')[0]));
                }
                Map<String,Date> kpiSceduleDateVal = new Map<String,Date>();                
                for(String s :uniqueKPIs){
                 
                    for(String val :frequencyMap.keySet()){
                        if(date.valueOf(frequencyMap.get(val).split('~')[1]) > comparingDate){                        
                            comparingDate = date.valueOf(frequencyMap.get(val).split('~')[1]);                  
                        }
                    }           
                    kpiSceduleDateVal.put(s,comparingDate);    
                }    
                system.debug('frequencyMap::'+frequencyMap);
                system.debug('kpiSceduleDateVal::'+kpiSceduleDateVal);
                for(SPE_KPIDefinition__c kpi :Trigger.New){
                    if(kpi.Buffer_Days__c == null){
                        kpi.Buffer_Days__c = 0;
                    }
                    try{
                        System.Debug('****kpiSceduleDateVal.get(kpi.Id)***'+kpiSceduleDateVal.get(kpi.Id));
                        System.Debug('****kpiDate***'+kpiDate);
                        if(kpiSceduleDateVal.get(kpi.Id) != Null && kpiSceduleDateVal.get(kpi.Id).Month() == kpiSceduleDateVal.get(kpi.Id).addDays(Integer.ValueOf(kpi.Buffer_Days__c)).Month() && kpiSceduleDateVal.get(kpi.Id) >= kpiDate && kpiSceduleDateVal.get(kpi.Id) >= System.Today()){
                            kpi.ScheduledDate__c = kpiSceduleDateVal.get(kpi.Id).addDays(integer.valueOf(kpi.Buffer_Days__c));
                            System.Debug('****kpi.ScheduledDate__c***'+kpi.ScheduledDate__c);
                        }
                        else if(kpiSceduleDateVal.get(kpi.Id) != Null && kpiSceduleDateVal.get(kpi.Id).Month() < kpiSceduleDateVal.get(kpi.Id).addDays(integer.valueOf(kpi.Buffer_Days__c)).Month() && kpiSceduleDateVal.get(kpi.Id) >= kpiDate && kpiSceduleDateVal.get(kpi.Id) >= System.Today()){
                            kpi.ScheduledDate__c = Date.newInstance(Integer.ValueOf(kpiSceduleDateVal.get(kpi.Id).Year()),Integer.ValueOf(kpiSceduleDateVal.get(kpi.Id).Month()),27);
                            System.Debug('****kpi.ScheduledDate__c***'+kpi.ScheduledDate__c);
                        }
                        else if(kpiSceduleDateVal.get(kpi.Id) != Null && kpiSceduleDateVal.get(kpi.Id).Month() == kpiSceduleDateVal.get(kpi.Id).addDays(Integer.ValueOf(kpi.Buffer_Days__c)).Month() && kpiSceduleDateVal.get(kpi.Id) >= kpiDate && kpiSceduleDateVal.get(kpi.Id) < System.Today()){
                            kpi.ScheduledDate__c = Date.newInstance(System.Today().Year(),System.Today().Month(),kpiSceduleDateVal.get(kpi.Id).addDays(integer.valueOf(kpi.Buffer_Days__c)).Day());
                            System.Debug('****kpi.ScheduledDate__c***'+kpi.ScheduledDate__c);
                        }
                        else if(kpiSceduleDateVal.get(kpi.Id) != Null && kpiSceduleDateVal.get(kpi.Id).Month() < kpiSceduleDateVal.get(kpi.Id).addDays(integer.valueOf(kpi.Buffer_Days__c)).Month() && kpiSceduleDateVal.get(kpi.Id) >= kpiDate && kpiSceduleDateVal.get(kpi.Id) < System.Today()){
                            kpi.ScheduledDate__c = Date.newInstance(System.Today().Year(),System.Today().Month(),27);
                            System.Debug('****kpi.ScheduledDate__c***'+kpi.ScheduledDate__c);
                        }
                        else if((kpiSceduleDateVal.get(kpi.Id) < kpiDate || kpiSceduleDateVal.get(kpi.Id) == Null) && kpiDate.Month() == kpiDate.addDays(integer.valueOf(kpi.Buffer_Days__c)).Month() && kpiDate >= System.Today()){
                            kpi.ScheduledDate__c = kpiDate.addDays(integer.valueOf(kpi.Buffer_Days__c));
                            System.Debug('****kpi.ScheduledDate__c***'+kpi.ScheduledDate__c);
                        }
                        else if((kpiSceduleDateVal.get(kpi.Id) < kpiDate || kpiSceduleDateVal.get(kpi.Id) == Null) && kpiDate.Month() < kpiDate.addDays(integer.valueOf(kpi.Buffer_Days__c)).Month() && kpiDate >= System.Today()){
                            kpi.ScheduledDate__c = kpiDate;
                            System.Debug('****kpi.ScheduledDate__c***'+kpi.ScheduledDate__c);
                        }
                        kpiDefList.add(kpi);
                        system.debug('kpiDefList::'+kpiDefList.size());
                    }catch(Exception e){
                        system.debug('Error:::::::::::'+e.getmessage());
                    }
                }
            }
         }
         
         try{
             update kpiDefList;
         }catch(exception e){}
     }
     //SPE_KPIDefinitionTrigger.ConvertKPIValues(trigger.new, trigger.oldMap);
}