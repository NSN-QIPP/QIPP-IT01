trigger SPE2_UpdateKPIScheduleDateFromPI on SPE_PIDefinition__c (after update){
    Map<String,date> PiToUploadDueDateMap = new Map<string,date>();
    for(SPE_PIDefinition__c pi :trigger.New){
        PiToUploadDueDateMap.put(pi.Id,pi.PIUploadDuedate__c);
    }
    List<SPE_KPIDefinition__c> kpiDefList = new List<SPE_KPIDefinition__c>();
    kpiDefList = [Select Id,ScheduledDate__c,PI_Data__c,Buffer_Days__c,PI_Data__r.PIUploadDuedate__c From SPE_KPIDefinition__c 
                  Where PI_Data__c != null And PI_Data__r.PIUploadDuedate__c != null AND PI_Data__c IN :PiToUploadDueDateMap.keySet()];
    if(kpiDefList.size() > 0){
        for(SPE_KPIDefinition__c kpi :kpiDefList){
            if(PiToUploadDueDateMap.get(kpi.PI_Data__c) >= System.Today()){
                kpi.ScheduledDate__c = PiToUploadDueDateMap.get(kpi.PI_Data__c);
            }
            else if(PiToUploadDueDateMap.get(kpi.PI_Data__c) < System.Today()){
                kpi.ScheduledDate__c = Date.newInstance(System.Today().Year(),System.Today().Month(),PiToUploadDueDateMap.get(kpi.PI_Data__c).Day());
            }
        }
    }
    try{
        update kpiDefList;
    }catch(exception e){}
}