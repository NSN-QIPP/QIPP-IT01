public with sharing class SPE_LifecycleEXT {
public boolean pilot{get;set;}
public boolean published{get;set;}
public boolean obsolete{get;set;}
public boolean del{get;set;}
public boolean delval{get;set;}
public boolean IsAccess{get;set;}
Public Id RecordId{get;set;}
public Map<String, Schema.SObjectField> M{get;set;}
public string stage{get;set;}
public String SobjectName{get;set;}
public boolean isSuccess{get;set;}
public String msg{get;set;}
public Sobject CurrRecord{get;set;}
public boolean Proceed{get;set;}
public boolean versionCheck{get;set;}
//code updated
public List<SPE_KPIDefinition__c> KPIList;
public List<SPE_PIDefinition__c> PIList;
public Set<ID> idKPIcal;
public List<SPE_ScoringTemplate__c> SPEScoringTempList;



    public SPE_LifecycleEXT(ApexPages.StandardController controller) {
       
       published=true;
       pilot=true;
       obsolete=true;
       del=true;
       delval=true;
       Proceed=false;
       isSuccess=false;
       versionCheck=false;
       
       if(controller.getid()!=Null || controller.getid()!='')
       IsAccess=[SELECT recordId,HasEditAccess FROM UserRecordAccess WHERE UserId =:UserInfo.getUserId() AND RecordId =:controller.getid()].HasEditAccess ; 
       SobjectName=(Id.valueOf(controller.getid()).getSObjectType().getDescribe().getName());
       if(IsAccess) {
            map<String,String> n= new Map<string,string>();   
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();  
            Map<String, Schema.SObjectField> M = (gd.get(Id.valueOf(controller.getid()).getSObjectType().getDescribe().getName())).getDescribe().fields.getMap();
               for (Schema.SObjectField field : m.values())
                {
                    n.put(field.getDescribe().getLabel(), field.getDescribe().getName());
                    
                }
              RecordId = Id.valueOf(controller.getId());
              stage=n.get('Stage');
              String query='select id,'+stage+' from '+SobjectName+' where id=: RecordId '; 
              currRecord=database.query(query);
                       
              if(currRecord.get(stage)=='Draft') {
              pilot=false;
              del=false;
              
              }
              
              
              if(currRecord.get(stage) =='Pilot') {
              Published=false;
              obsolete=false;
              delval=false;
              }
              
              if(currRecord.get(stage)=='Published') {
              Obsolete=false;
              }
              
                  
        }
    }
    
    public void StagePilot() {
       
       
      if(SobjectName=='SPE_KPIDefinition__c') { 
          
          SPE_KPIDefinition__c kdef = new SPE_KPIDefinition__c();
          List<SPE_KPIDefinition__c> KpidefntList = new List<SPE_KPIDefinition__c>();
          List<SPE_SPEKPIMap__c> kpimap = new List<SPE_SPEKPIMap__c>();
          
           kdef = [select id,Master_KPI__c,VerNumber__c,Version__c from SPE_KPIDefinition__c where id =: RecordId];
           
           if(kdef.Master_KPI__c != null)
           {
               KpidefntList = [select id,Master_KPI__c,Version__c,VerNumber__c from SPE_KPIDefinition__c where Master_KPI__c =: kdef.Master_KPI__c and (LifecycleStage__c ='Pilot' or LifecycleStage__c ='Published') order by VerNumber__c DESC];
               system.debug('*******KPILIST********' + KpidefntList );
           }
           
       if(KpidefntList.size() > 0 && KpidefntList[0].VerNumber__c < kdef.VerNumber__c)
       {
           kpimap = [select id,SPETemplate__r.name from SPE_SPEKPIMap__c where KPIDefinition__c =: KpidefntList[0].id and SPETemplate__r.Stage__c = 'Pilot'];
           system.debug('*******SPETEMPLATE********' + kpimap);
       }
       if(kpimap.size()>0){
           versionCheck=true;        
       }
       else {
           try { 
       
               currRecord.put(stage,'Pilot');
               update currRecord;    
               isSuccess =true;
              }  
     
       catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               isSuccess = false;
               system.debug('**********'+msg);
           }
       
       }
           
       }
       else {
       
           try { 
       
               currRecord.put(stage,'Pilot');
               update currRecord;    
               isSuccess =true;
              }  
     
       catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               isSuccess = false;
               system.debug('**********'+msg);
           }
           
       }
       
    }
    
    public pagereference StagePublished() {
    
      if(SobjectName=='SPE_PIDefinition__c') {
      
          try{ 
               currRecord.put(stage,'Published');
               update currRecord;
               isSuccess=true;
               Proceed=true;
               executeTestBatch();
               return null;
           } 
            
           catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               Proceed=true;
               isSuccess = false;
               system.debug('**********'+msg);
               return null;
           }
       }
       
       if(SobjectName=='SPE_SurveyQuestion__c') {
      
          try{ 
               currRecord.put(stage,'Published');
               update currRecord;
               isSuccess=true;
               Proceed=true;
               executeTestBatch();
               return null;
           } 
            
           catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               Proceed=true;
               isSuccess = false;
               system.debug('**********'+msg);
               return null;
           }
       }
       
       if(SobjectName=='SPE_KPIDefinition__c') {
           system.debug('******SobjectName'+SobjectName);
           String query='select id,ActualCalculation__c,PI_Data__c,Formula_Count__c,'+stage+' from '+SobjectName+' where id=: RecordId '; 
           currRecord=database.query(query);
           if(currRecord.get('PI_Data__c')!=Null) {
               Id Id=String.valueOf(currRecord.get('PI_Data__c'));    
               if([select LifecycleStage__c from SPE_PIDefinition__c where id=:Id].LifecycleStage__c=='Published')
                   Proceed=true;
           }
          else {
               Id Id=String.valueOf(currRecord.get('Id'));
               set<id> PISet = new set<Id>();
               for(SPE_KPICalculation__c calc:[select PIDefination__c from SPE_KPICalculation__c where KPIDefinition__c=:Id])
                   PISet.add(calc.PIDefination__c );
               
               if(PISet.size()>0)
               {
               integer i=0;
                 for(SPE_PIDefinition__c p: [select id,LifecycleStage__c from SPE_PIDefinition__c where id IN:PISet])
                     if(p.LifecycleStage__c !='Published')
                          i=1; 
               if(i==0)
                   proceed=true;
               }     
               
           }
           
         
         
           
          system.debug('******Proceed'+Proceed);
          if(Proceed) {
              SPE_KPIDefinition__c kdef = new SPE_KPIDefinition__c();
              List<SPE_KPIDefinition__c> KpidefntList = new List<SPE_KPIDefinition__c>();
              List<SPE_SPEKPIMap__c> kpimap = new List<SPE_SPEKPIMap__c>();
              
               kdef = [select id,Master_KPI__c,VerNumber__c,Version__c from SPE_KPIDefinition__c where id =: RecordId];
               
               if(kdef.Master_KPI__c != null)
               {
                   KpidefntList = [select id,Master_KPI__c,Version__c,VerNumber__c from SPE_KPIDefinition__c where Master_KPI__c =: kdef.Master_KPI__c and LifecycleStage__c ='Published' order by VerNumber__c DESC];
                   system.debug('*******KPILIST********' + KpidefntList );
               }
               
               if(KpidefntList.size() > 0 && KpidefntList[0].VerNumber__c < kdef.VerNumber__c)
               {
                   kpimap = [select id,SPETemplate__r.name from SPE_SPEKPIMap__c where KPIDefinition__c =: KpidefntList[0].id and SPETemplate__r.Stage__c = 'Published'];
                   system.debug('*******SPETEMPLATE********' + kpimap);
               }
               if(kpimap.size()>0){
                   versionCheck=true;
                   Proceed=false;
               }
               else{              
                  try{ 
                       currRecord.put(stage,'Published');
                       update currRecord;
                       isSuccess=true;
                       executeTestBatch();
                       return null;
                       system.debug('******isSuccess'+isSuccess);
                   } 
                    
                   catch(Exception ex){
                       msg= ex.getMessage();
                       list<string> s=msg.split(':');
                       msg=s[1];
                       isSuccess = false;
                       system.debug('**********'+msg);
                       return null;
                   }
              } 
       }
       
         list<SPE_KPICalculation__c> k= new list<SPE_KPICalculation__c>();
          k=[select name from SPE_KPICalculation__c where kpidefinition__c=:RecordId ];
                   
                   if((currRecord.get('Formula_Count__c')==Null || k.size()==0) && currRecord.get('PI_Data__c')==Null) {
                       proceed=true;
                       isSuccess=false;
                       msg='Complete KPI before Publishing';
                    }
       }
      
      
      
      
      if(SobjectName=='SPE_SPETemplate__c') {
           system.debug('******SobjectName'+SobjectName);
           String query='select id, '+stage+' from '+SobjectName+' where id=: RecordId '; 
           currRecord=database.query(query);
           integer i=0;
           for(SPE_SPEKPIMap__c objKPIMap :[select KPIDefinition__c,KPIDefinition__r.LifecycleStage__c from SPE_SPEKPIMap__c where SPETemplate__c =: RecordId])
           {
               if(objKPIMap.KPIDefinition__r.LifecycleStage__c !='Published')
                  i=1; 
               if(i==0)
                  proceed=true;
           }
           
           if(Proceed) {
              try{ 
                   currRecord.put(stage,'Published');
                   update currRecord;
                   isSuccess=true;
                   return null;
                   system.debug('******isSuccess'+isSuccess);
               } 
                
               catch(Exception ex){
                   msg= ex.getMessage();
                   list<string> s=msg.split(':');
                   msg=s[1];
                   isSuccess = false;
                   system.debug('**********'+msg);
                   return null;
               }
           }
       }
      
       
    return null;
    }
    
    public void StageObsolete() {
       
       //For Question
       PIList = new List<SPE_PIDefinition__c>();
       if(SobjectName=='SPE_SurveyQuestion__c') 
       {
            for(SPE_PIDefinition__c pi : [SELECT id,LifecycleStage__c from SPE_PIDefinition__c Where SurveyQuestion__c=:RecordId AND (LifecycleStage__c='Published' OR LifecycleStage__c='Pilot')])
            {
                PIList.add(pi);
            } 
            if(PIList.size()==0)
            {
                 proceed=true;
                       try
                       { 
                           currRecord.put(stage,'obsolete');
                           update currRecord;
                           isSuccess=true;
                       } 
                        
                       catch(Exception ex)
                       {
                               msg= ex.getMessage();
                               list<string> s=msg.split(':');
                               msg=s[1];
                               isSuccess = false;
                       }
            }       
       }
       
       if(SobjectName=='SPE_PIDefinition__c') 
       {    
           KPIList = new List<SPE_KPIDefinition__c>();
           for(SPE_KPIDefinition__c k: [select id,LifecycleStage__c from SPE_KPIDefinition__c where PI_Data__c=: RecordId AND ( LifecycleStage__c='Published' OR LifecycleStage__c='Pilot')])
           {
               KPIList.add(k);
           }
           
           if(KPIList.size()== 0)
           {
               set<id> KPICalSet = new set<Id>();
               for(SPE_KPICalculation__c calc:[select id,PIDefination__c from SPE_KPICalculation__c where PIDefination__c = :RecordId AND (KPIDefinition__r.LifecycleStage__c='Published' OR KPIDefinition__r.LifecycleStage__c='Pilot') ])
                   KPICalSet.add(calc.id);
                   
                   if(KPICalSet.size() == 0)
                   {
                        proceed=true;
                            try{ 
                           currRecord.put(stage,'obsolete');
                           update currRecord;
                           isSuccess=true;
                       } 
                        
                       catch(Exception ex){
                           msg= ex.getMessage();
                           list<string> s=msg.split(':');
                           msg=s[1];
                           isSuccess = false;
                           
                       }
                   }  
           }
           
       }
       
       
       
       // for KPI
       if(SobjectName=='SPE_KPIDefinition__c') 
       {    
           set<Id> SPETempSet =  new set<id>();
            for(SPE_SPEKPIMap__c SPEtemp:[select SPETemplate__c,SPETemplate__r.name,SPETemplate__r.Owner.Name,SPETemplate__r.OwnerId,KPIDefinition__c,KPIDefinition__r.name,SPETemplate__r.Stage__c from SPE_SPEKPIMap__c where KPIDefinition__c =:RecordId AND (SPETemplate__r.Stage__c='Published' OR SPETemplate__r.Stage__c='Pilot') ])
                   SPETempSet .add(SPEtemp.SPETemplate__c);
                   
                   if(SPETempSet.size() == 0)
                   {
                        proceed=true;
                            try{ 
                           currRecord.put(stage,'obsolete');
                           update currRecord;
                           isSuccess=true;
                       } 
                        
                       catch(Exception ex){
                           msg= ex.getMessage();
                           list<string> s=msg.split(':');
                           msg=s[1];
                           isSuccess = false;
                           
                       }
                   }          
       }
              
       if(SobjectName=='SPE_SPETemplate__c') 
       {    
           SPEScoringTempList = new List<SPE_ScoringTemplate__c>();
           for(SPE_ScoringTemplate__c k: [select id,Stage__c from SPE_ScoringTemplate__c where SPETemplate__c=: RecordId AND ( Stage__c='Published' OR Stage__c='Pilot')])
           {
               SPEScoringTempList.add(k);
           }
           
           if(SPEScoringTempList.size()== 0)
           {
                proceed=true;
                    try{ 
                   currRecord.put(stage,'obsolete');
                   update currRecord;
                   isSuccess=true;
               } 
                
               catch(Exception ex){
                   msg= ex.getMessage();
                   list<string> s=msg.split(':');
                   msg=s[1];
                   isSuccess = false;
                   
               }
           }
           
       }
    
    }
    
    
    public void StageDelete() {
    
       
       Delete currRecord;
    
    
    }
    
    public void executeTestBatch(){
           
      SPE_DeleteTestDataBatch objBatch= new SPE_DeleteTestDataBatch(RecordId);
        String CronExp= Datetime.now().addMinutes(1).format('ss mm HH dd MM ? yyyy');
        System.schedule('DeleteTestDataJob'+system.now(),CronExp,objBatch);
    }
}