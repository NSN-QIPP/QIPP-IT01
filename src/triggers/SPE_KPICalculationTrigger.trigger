trigger SPE_KPICalculationTrigger on SPE_KPICalculation__c (before insert, after insert, after update) 
{
    if (Trigger.isInsert && Trigger.isbefore) 
    { 
        SPE_KPICalculationTrigger.reOrderIndex(trigger.new);
    }
    
    if (Trigger.isDelete)
    {
       // SPE_KPICalculationTrigger.DeletePITempValues(trigger.old);
    }
    
    
    if (Trigger.isAfter && trigger.isUpdate)
    {
        for(SPE_KPICalculation__c kCal: trigger.new)
        {
          //  SPE_AdhocCalculations.DoAdhocCalc(kCal.KPIDefinition__c , System.today());
        }
    }
    /*if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate))
    {
        List<SPE_KPICalculation__c> kpiCals = [Select Id,PIDefination__c,PIDefination__r.DataAcquisitionMethod__c,
                                              PIDefination__r.PIUploadDuedate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                                              KPIDefinition__r.FrequencyinMonth__c,PIDefination__r.Frequency__c,
                                              PrevKPIDefination__c,PrevKPIDefination__r.ScheduledDate__c,PrevKPIDefination__r.FrequencyinMonth__c
                                              From SPE_KPICalculation__c 
                                              Where Id IN: Trigger.New];
        
        
        List<SPE_KPIDefinition__c> kpiDefList = new List<SPE_KPIDefinition__c>();
        Set<String> kpiIds = new Set<String>();
        for(SPE_KPICalculation__c kpical :kpiCals){
            kpiIds.add(kpical.KPIDefinition__c);
        }
        system.debug('kpiIds::'+kpiIds.size());
        List<SPE_KPICalculation__c> kpiCals1 = [Select Id,PIDefination__c,PIDefination__r.DataAcquisitionMethod__c,
                                                PIDefination__r.PIUploadDuedate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                                                KPIDefinition__r.FrequencyinMonth__c,PIDefination__r.Frequency__c,
                                                PrevKPIDefination__c,PrevKPIDefination__r.ScheduledDate__c,PrevKPIDefination__r.FrequencyinMonth__c
                                                From SPE_KPICalculation__c 
                                                Where KPIDefinition__c IN: kpiIds];
                                                 
        system.debug('kpiCals1 ::'+kpiCals1.size());
        List<SPE_KPIDefinition__c> kpidefs = [Select Id,ScheduledDate__c,Buffer_Days__c,FrequencyinMonth__c From SPE_KPIDefinition__c Where Id IN: kpiIds];
        system.debug('kpidefs ::'+kpidefs.size());
        
        Date comparingDate = Date.newInstance(1800, 1, 1);
        Date kpiDate = Date.newInstance(1800, 1, 1);
        Integer comparingFrequency = 1000000;
        Set<ID> pids = new Set<ID>();
        Map<String,String> frequencyMap = new Map<String,String>();
        
        system.debug('kpiCals1::'+kpiCals1.size());
        for(SPE_KPICalculation__c cal :kpiCals1){                                                       
           if(cal.PIDefination__c != null){
               if(cal.PIDefination__r.PIUploadDuedate__c != null && (cal.PIDefination__r.DataAcquisitionMethod__c == 'Data Load' || cal.PIDefination__r.DataAcquisitionMethod__c == 'Standalone Survey')){
                   frequencyMap.put(cal.PIDefination__c,cal.PIDefination__r.Frequency__c+'~'+cal.PIDefination__r.PIUploadDuedate__c+'~'+cal.KPIDefinition__c);
               }else{
                   //frequencyMap.put(cal.PIDefination__c,cal.PIDefination__r.Frequency__c+'~'+System.today()+'~'+cal.KPIDefinition__c);
               }
               if(cal.PIDefination__r.DataAcquisitionMethod__c == 'Survey'){
                   pids.add(cal.PIDefination__c);
                   System.Debug('****pids***'+pids);                                       
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
            if(kpiCals2.size() > 0){
                for(SPE_KPICalculation__c skal: kpiCals2){
                   kpids.add(skal.KPIDefinition__c); 
                }
            }
            System.Debug('****kpids***'+kpids); 
            List<SPE_KPIDefinition__c> kpilist = [Select ID,KPI_Title__c,PI_Data__c from SPE_KPIDefinition__c where PI_Data__c IN: pids];
            if(kpilist.size() > 0){
                for(SPE_KPIDefinition__c kpi: kpilist){
                   kpids.add(kpi.ID); 
                }
                System.Debug('****kpids11***'+kpids); 
            }
        }
        
        if(kpids.size() > 0){
            List<SPE_SPEKPIMap__c> speKPIlist = [SELECT Id,KPIDefinition__c,SPETemplate__c FROM SPE_SPEKPIMap__c WHERE KPIDefinition__c IN:kpids];
            System.Debug('****speKPIlist ***'+speKPIlist);
            if(speKPIlist.size() > 0){
                for (SPE_SPEKPIMap__c speKPI : speKPIlist)
                {
                    stempids.add(speKPI.SPETemplate__c);
                }
            }
        }
        
        List<SPE_SPEPlan__c> splanlist = new List<SPE_SPEPlan__c>();
        if(stempids.size() > 0){
            splanlist = [Select ID,Name,FrequencyInMonths__c,StartDate__c,SPETemplate__c from SPE_SPEPlan__c 
                                              where SPETemplate__c IN: stempids];
        }                                  
                                          
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
        for(SPE_KPIDefinition__c kpi :kpidefs){
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
        try{
            system.debug('kpiDefList::'+kpiDefList);
            update kpiDefList; 
        }catch(exception e){
            system.debug('Error:::::::::::'+e.getmessage());
        }     
    }*/
    
}