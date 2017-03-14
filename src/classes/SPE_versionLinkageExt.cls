public class SPE_versionLinkageExt 
{
    public String versionId{get;set;}
    public string Lifecycle{get;set;}
    public String SobjectName{get;set;}
    public List<SPE_SPEKPIMap__c> kpimap{get;set;}
    public SPE_KPIDefinition__c kdef{get;set;}
    public String msg{get;set;}
    public List<VersionLinkageWrapper> linkList{get;set;}
    
    
    public SPE_versionLinkageExt()
    {    
        
        linkList = new List<VersionLinkageWrapper>();
        versionId=apexpages.currentpage().getparameters().get('id');
        Lifecycle=apexpages.currentpage().getparameters().get('Lifecycle');
        
        SobjectName=(Id.valueOf(versionId).getSObjectType().getDescribe().getName());
        
        if(SobjectName=='SPE_KPIDefinition__c') { 
          
          kdef = new SPE_KPIDefinition__c();
          List<SPE_KPIDefinition__c> KpidefntList = new List<SPE_KPIDefinition__c>();
           kpimap = new List<SPE_SPEKPIMap__c>();
          
           kdef = [select id,Master_KPI__c,VerNumber__c,Version__c,LifecycleStage__c,Level__c from SPE_KPIDefinition__c where id =: versionId];
           
           if(Lifecycle=='Pilot'){
               if(kdef.Master_KPI__c != null)
               {
                   KpidefntList = [select id,Master_KPI__c,Version__c,VerNumber__c from SPE_KPIDefinition__c where Master_KPI__c =: kdef.Master_KPI__c and (LifecycleStage__c ='Pilot' or LifecycleStage__c ='Published') order by VerNumber__c DESC];
                   system.debug('*******KPILIST********' + KpidefntList );
               }
               
               if(KpidefntList.size() > 0 && KpidefntList[0].VerNumber__c < kdef.VerNumber__c)
               {
                   kpimap = [select id,SPETemplate__r.name,SPETemplate__c,Owner.name,SPETemplate__r.Stage__c,KPIDefinition__c  from SPE_SPEKPIMap__c where KPIDefinition__c =: KpidefntList[0].id and SPETemplate__r.Stage__c = 'Pilot'];
                   system.debug('*******SPETEMPLATE********' + kpimap);               
               }
               
           }
           
           if(Lifecycle=='Published'){
               if(kdef.Master_KPI__c != null)
               {
                   KpidefntList = [select id,Master_KPI__c,Version__c,VerNumber__c from SPE_KPIDefinition__c where Master_KPI__c =: kdef.Master_KPI__c and LifecycleStage__c ='Published' order by VerNumber__c DESC];
                   system.debug('*******KPILIST********' + KpidefntList );
               }
               
               if(KpidefntList.size() > 0 && KpidefntList[0].VerNumber__c < kdef.VerNumber__c)
               {
                   kpimap = [select id,SPETemplate__r.name,SPETemplate__c,Owner.name,SPETemplate__r.Stage__c,KPIDefinition__c from SPE_SPEKPIMap__c where KPIDefinition__c =: KpidefntList[0].id and SPETemplate__r.Stage__c = 'Published'];
                   system.debug('*******SPETEMPLATE********' + kpimap);               
               }
               
           }
           
           for(SPE_SPEKPIMap__c kmap : kpimap)
               {
                   linkList.add(new VersionLinkageWrapper(kmap.SPETemplate__c,kmap.SPETemplate__r.name,kmap.Owner.name,kmap.SPETemplate__r.Stage__c,kmap.KPIDefinition__c,kdef.Level__c));
               }
        }
    } 
    
    public void updateKPI()
    {        
               kdef.LifecycleStage__c =Lifecycle;
               update kdef;
             
    }
    
    
    public class VersionLinkageWrapper
    {
        public List<SPE_ScoringTemplate__c> ScorTmpList{get;set;}
        public string SPETempName{get;set;}
        public string SpeOwner{get;set;}
        public string Stage{get;set;}
        public Id sptemId{get;set;}
        public boolean Redcolor{get;set;}
        public VersionLinkageWrapper(Id SPETempId,String SPEName,String own,String Stg,Id KPIDef,string currlevels)
        {   
            integer cLevels=0;
            integer eleves=0;
            Redcolor=false;
            SPE_KPIDefinition__c ExistingKPIdef = new SPE_KPIDefinition__c();
            ExistingKPIdef =[select id,level__c from SPE_KPIDefinition__c where id=:KPIDef];
            Redcolor=false;
            list<string> ExisLevels=(ExistingKPIdef.level__c).split(';');
            list<string> currentLevels=(currlevels).split(';');
            if(currentLevels.size()!=ExisLevels.size()){
                Redcolor=true;
            }
            else{
            for(string s:currentLevels)
                cLevels=cLevels+integer.valueof(s);
             for(string s:ExisLevels)
                eleves=eleves+integer.valueof(s);    
            
            if(cLevels!=eleves)
                Redcolor=true;
            }
            
            SPETempName= SPEName;
            SpeOwner= own;
            Stage= stg;
            sptemId = SPETempId;
            ScorTmpList = new List<SPE_ScoringTemplate__c>();
            
            ScorTmpList = [select id,name,Stage__c,Owner.name from SPE_ScoringTemplate__c where SPETemplate__c =: SPETempId];
        }
    }
}