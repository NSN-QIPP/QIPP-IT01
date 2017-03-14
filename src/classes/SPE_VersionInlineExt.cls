public class SPE_VersionInlineExt 
{
    
    public SPE_KPIDefinition__c KPI{get;set;}
    public Id KPIid{get;set;}
    public List<SPE_KPIDefinition__c> KPIList{get;set;}
    public List<SPE_KPIDefinition__c> KPIDraftList{get;set;}
    public List<SPE_KPIDefinition__c> KPIPilotList{get;set;}
    public List<SPE_KPIDefinition__c> KPIPublishedList{get;set;}
    public List<SPE_KPIDefinition__c> KPIObsoleteList{get;set;}
    public integer draft{get;set;}
    public integer pilot{get;set;}
    public integer published{get;set;}
    public integer obsolete{get;set;}
    public string pilotReport{get;set;}
    public string publishedReport{get;set;}
    public string AllReport{get;set;}
    
    public SPE_VersionInlineExt(ApexPages.StandardController con) 
    {
        
        KPI = new SPE_KPIDefinition__c();
        KPIList = new List<SPE_KPIDefinition__c>();
        KPIDraftList = new List<SPE_KPIDefinition__c>();
        KPIPilotList = new List<SPE_KPIDefinition__c>();
        KPIPublishedList = new List<SPE_KPIDefinition__c>();
        KPIObsoleteList = new List<SPE_KPIDefinition__c>();
        KPIid=con.getId();
        KPI = [select id,Master_KPI__c,version__c from SPE_KPIDefinition__c where id=: con.getId()];
        
        
        
        if(KPI.id != null && kpi.Master_KPI__c != null)
        {
            KPIList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (Master_KPI__c =: kpi.Master_KPI__c OR id=: kpi.Master_KPI__c) and LifecycleStage__c =:'Draft' order by VerNumber__c];
            
            KPIPilotList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (Master_KPI__c =: kpi.Master_KPI__c OR id=: kpi.Master_KPI__c) and LifecycleStage__c =:'Pilot' order by VerNumber__c];
            
            KPIPublishedList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (Master_KPI__c =: kpi.Master_KPI__c OR id=: kpi.Master_KPI__c) and LifecycleStage__c =:'Published' order by VerNumber__c];
            
            KPIObsoleteList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (Master_KPI__c =: kpi.Master_KPI__c OR id=: kpi.Master_KPI__c) and LifecycleStage__c =:'Obsolete' order by VerNumber__c];
            
        }
        if(KPI.id != null && kpi.Master_KPI__c == null)
        {
            KPIList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (id =: con.getId() OR Master_KPI__c =: con.getId()) and LifecycleStage__c =:'Draft' order by VerNumber__c];
            
            KPIPilotList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (id =: con.getId() OR Master_KPI__c =: con.getId()) and LifecycleStage__c =:'Pilot' order by VerNumber__c];
            
            KPIPublishedList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (id =: con.getId() OR Master_KPI__c =: con.getId())  and LifecycleStage__c =:'Published' order by VerNumber__c];
            
            KPIObsoleteList = [select id,LifecycleStage__c,Version__c,Owner.name,VerNumber__c from SPE_KPIDefinition__c where (id =: con.getId() OR Master_KPI__c =: con.getId()) and LifecycleStage__c =:'Obsolete' order by VerNumber__c];
        }
        
        draft=KPIList.size();
        pilot=KPIPilotList.size();
        published=KPIPublishedList.size();
        obsolete=KPIObsoleteList.size();
        
        if(pilot>0)
        pilotReport=String.valueOf(KPIPilotList[pilot-1].Id).substring(0, 15);
        
        if(published>0)
        publishedReport=String.valueOf(KPIPublishedList[published-1].Id).substring(0, 15);
        
        AllReport='';
        for(SPE_KPIDefinition__c k:KPIPilotList)
        AllReport=AllReport+String.valueOf(k.Id).substring(0, 15)+',';
        
        for(SPE_KPIDefinition__c k: KPIPublishedList)
        AllReport=AllReport+String.valueOf(k.Id).substring(0, 15)+',';
        
    }
    
    

}