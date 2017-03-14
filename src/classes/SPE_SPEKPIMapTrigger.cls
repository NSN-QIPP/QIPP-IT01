public with Sharing class SPE_SPEKPIMapTrigger {

    public static void updateKPI(List<SPE_SPEKPIMap__c> KPIMap){
    
        List<SPE_KPIDefinition__c> lstKPIDef = new List<SPE_KPIDefinition__c>();
        List<SPE_KPIDefinition__c> lstKPIDefMaster = new List<SPE_KPIDefinition__c>();
        
        Map<Id,SPE_KPIDefinition__c> mapKPIID = new Map<Id,SPE_KPIDefinition__c>();
        Map<Id,Id> masterMap = new Map<Id,Id>();
     //   Map<Id,SPE_KPIDefinition__c> mapKPIID = new Map<Id,SPE_KPIDefinition__c>();
        Set<Id> KPIDefIDSet = new Set<Id>(); //Set to hold KPI Map ID
        Set<Id> masterKPIIdSet = new Set<Id>(); 
     
     
      for(SPE_SPEKPIMap__c s:KPIMap){
            KPIDefIDSet.add(s.KPIDefinition__c);
        }
        
     lstKPIDef = [Select id,VerNumber__c,Master_KPI__c from SPE_KPIDefinition__c where id in :KPIDefIDSet];
     system.debug('list value is'+lstKPIDef);
     
     for(SPE_KPIDefinition__c s : lstKPIDef){
          mapKPIID.put(s.Id,s);   
     
     }
        
    system.debug('values in map is'+mapKPIID);
    
    lstKPIDefMaster = [SELECT Master_KPI__c from SPE_KPIDefinition__c where id in :KPIDefIDSet];
    
    for(Integer i=0;i<lstKPIDefMaster.size();i++)
    {
        if(lstKPIDefMaster[i].Master_KPI__c!=null){
            masterKPIIdSet.add(lstKPIDefMaster[i].Master_KPI__c);
        }
        else{
            masterKPIIdSet.add(lstKPIDefMaster[i].Id);
        }
    
    }
    system.debug('masterKPI values'+masterKPIIdSet);
    
    List<SPE_KPIDefinition__c> lstKPIAll = [Select id,VerNumber__c,Master_KPI__c from SPE_KPIDefinition__c where Master_KPI__c in :masterKPIIdSet and (LifecycleStage__c='Pilot' Or LifecycleStage__c='Published')];
    
    system.debug('All KPI List**'+lstKPIAll);
    
    for(ID ob : masterKPIIdSet){
        Decimal latestver = 0;
        Id latestverID;
        for(SPE_KPIDefinition__c s : lstKPIAll){
            if(s.Master_KPI__c == ob){
                if(s.VerNumber__c > latestver){
                    latestver = s.VerNumber__c;
                    latestverID = s.Id;
                }
                
            }
            
        }
        
        masterMap.put(ob,latestverID);
    }
    
    system.debug('masterMap value is'+masterMap);
    
    for(SPE_SPEKPIMap__c sobj : KPIMap){
        if(sobj.UseLatestKPIVersion__c==true){
        for(Id testId : KPIDefIDSet){
            if(masterMap.containsKey(mapKPIID.get(testId).Master_KPI__c))
                sobj.KPIDefinition__c = masterMap.get(mapKPIID.get(testId).Master_KPI__c);
            else
                sobj.KPIDefinition__c = masterMap.get(mapKPIID.get(testId).Id);
        system.debug('final value is'+masterMap.get(sobj.KPIDefinition__r.Master_KPI__c));
        
        
        }
    }
   }
    
    }
}