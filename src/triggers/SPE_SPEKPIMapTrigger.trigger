trigger SPE_SPEKPIMapTrigger on SPE_SPEKPIMap__c (before insert,before update,after update) {

if(trigger.isBefore){
set<ID> SPEMAPSet= new set<ID>();
id tempId;
set<Id> SpeTemp= new set<id>();
set<Id> KPidefSet= new set<Id>();
Set<Id> MasterId= new set<Id>();
map<Id,Id> highestVersionMap= new Map<Id,Id>();
boolean ISPublished=false;
list<SPE_KPIDefinition__c> ListOfKPI= new list<SPE_KPIDefinition__c>();
for(SPE_SPEKPIMap__c s: trigger.new){
    if(s.UseLatestKPIVersion__c && s.SPETemplate__r.stage__c!='Obsolete'){
         SPEMAPSet.add(s.Id);
        }
    system.debug('*********Stage '+s.SPETemplate__r.stage__c);
    system.debug('*********Stage2 '+s.SPETemplate__c);  
    if(s.SPETemplate__r.stage__c=='Published')
        ISPublished=true; 
     
}


for(SPE_SPEKPIMap__c listOfSPE:[select id,KPIDefinition__c,SPETemplate__c,KPIDefinition__r.VerNumber__c from SPE_SPEKPIMap__c where id IN: SPEMAPSet]) {
    KPidefSet.add(listOfSPE.KPIDefinition__c);
}


if(ISPublished){
ListOfKPI=[select id,VerNumber__c,Master_KPI__c from SPE_KPIDefinition__c where id IN: KPidefSet and lifecycleStage__c='Published']; 
       



for(SPE_KPIDefinition__c k:ListOfKPI)
      if(k.Master_KPI__c!=Null) {
           MasterId.add(k.Master_KPI__c);
       }else {
            
            MasterId.add(k.Id);
       }


list<SPE_KPIDefinition__c> ComplList=[select id,VerNumber__c,Master_KPI__c from SPE_KPIDefinition__c where (id IN:MasterId or Master_KPI__c IN:MasterId) and lifecyclestage__c='Published'];
integer ver=0;
for(SPE_KPIDefinition__c i:ListOfKPI){
    ver=0;
    for(SPE_KPIDefinition__c k:ComplList) {
        //system.debug('*******'+k.name+'-'+k.VerNumber__c);
        if(k.Master_KPI__c==i.Master_KPI__c || k.Master_KPI__c==i.id) {
            if(ver<integer.valueOf(k.VerNumber__c)) {
               
               ver=integer.valueOf(k.VerNumber__c);
               tempId=k.id;
               }    
                
       }   
       system.debug('*********Ver-'+ver);    
    }
highestVersionMap.put(i.id,tempId);
}
}

else {

ListOfKPI=[select id,VerNumber__c,Master_KPI__c from SPE_KPIDefinition__c where id IN: KPidefSet and (lifecycleStage__c='Published' OR lifecycleStage__c='Pilot')]; 
       


for(SPE_KPIDefinition__c k:ListOfKPI)
      if(k.Master_KPI__c!=Null) {
           MasterId.add(k.Master_KPI__c);
       }else {
            MasterId.add(k.Id);
       }

list<SPE_KPIDefinition__c> ComplList=[select id,name,VerNumber__c,Master_KPI__c from SPE_KPIDefinition__c where (id IN:MasterId or Master_KPI__c IN:MasterId) and (lifecyclestage__c='Published' OR lifecycleStage__c='Pilot')];
integer ver=0;

for(SPE_KPIDefinition__c i:ListOfKPI){
    ver=0;
    for(SPE_KPIDefinition__c k:ComplList) {
        system.debug('******* Name and Version'+k.name+'-'+k.VerNumber__c);
        if(k.Master_KPI__c==i.Master_KPI__c || k.Master_KPI__c==i.id) {
            if(ver<integer.valueOf(k.VerNumber__c)) {
               
               ver=integer.valueOf(k.VerNumber__c);
               tempId=k.id;
               }    
                
       }   
       system.debug('*********Ver-'+ver);    
    }
highestVersionMap.put(i.id,tempId);
}



}

system.debug('************ highestVersionMap'+highestVersionMap);
set<Id> tobechanged= new set<id>();

for(SPE_SPEKPIMap__c s: trigger.new){
if(highestVersionMap.get(s.KPIDefinition__c)!=Null){
    if(s.KPIDefinition__c!=highestVersionMap.get(s.KPIDefinition__c)) {
        tobechanged.add(s.KPIDefinition__c);
        s.KPIDefinition__c=highestVersionMap.get(s.KPIDefinition__c);
        SpeTemp.add(s.SPETemplate__c);
        }
    }
}

}

if(trigger.isAfter) {
set<Id> kpiIds= new set<id>();
map<id,id> replacemaps= new map<id,id>();
set<id> SpeTemp=new set<id>();

for(SPE_SPEKPIMap__c k:trigger.new) {
if((Trigger.oldMap.get(k.Id)).KPIDefinition__c!=k.KPIDefinition__c){
replacemaps.put((Trigger.oldMap.get(k.Id)).KPIDefinition__c,k.KPIDefinition__c);
kpiIds.add((Trigger.oldMap.get(k.Id)).KPIDefinition__c);
SpeTemp.add(k.SPETemplate__c);
}
}
 
 set<Id> scId= new set<Id>();
 for(SPE_ScoringTemplate__c st:[select id,SPETemplate__c from SPE_ScoringTemplate__c where SPETemplate__c=:SpeTemp])
        scId.add(st.id);
list<SPE_ScoringCalculation__c> sc=[select id,KPIDefinition__c from SPE_ScoringCalculation__c where ScoringTemplate__c IN :scId and KPIDefinition__c IN:kpiIds];
for(SPE_ScoringCalculation__c ss:sc) {
        ss.KPIDefinition__c=replacemaps.get(ss.KPIDefinition__c);

update ss;        
}
}
}