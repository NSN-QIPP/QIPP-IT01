public with sharing class SPE_ScorecardTemplateLifecycleEXT{
public boolean draft{get;set;}
public boolean published{get;set;}
public boolean obsolete{get;set;}
public boolean pilot{get;set;}
public boolean IsAccess{get;set;}
Public Id RecordId{get;set;}
public string stage{get;set;}
public String SobjectName{get;set;}
public boolean isSuccess{get;set;}
public Sobject CurrRecord{get;set;}
public List<SPE_ScorecardSPETemplateMap__c> lstScoreSPETempMap;
public String alertflag {get;set;}

public SPE_ScorecardTemplateLifecycleEXT(ApexPages.StandardController controller) {
       
       lstScoreSPETempMap = new List<SPE_ScorecardSPETemplateMap__c>();
       
       published=true;
       draft=true;
       obsolete=true;
       pilot=true;
       isSuccess=false;
       alertflag = 'false';
       
       
       if(controller.getid()!=Null || controller.getid()!='')
       IsAccess=[SELECT recordId,HasEditAccess FROM UserRecordAccess WHERE UserId =:UserInfo.getUserId() AND RecordId =:controller.getid()].HasEditAccess ; 
       SobjectName=(Id.valueOf(controller.getid()).getSObjectType().getDescribe().getName());
       system.debug('******SobjectName'+SobjectName);
      

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
              
              //##################
         lstScoreSPETempMap = [select SPETemplate__c,SPETemplate__r.Stage__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c = :RecordId];

       Map<String,Id> maptempSPEMap = new Map<String,Id> ();
      if(lstScoreSPETempMap.size()>0){
          for(SPE_ScorecardSPETemplateMap__c temp :lstScoreSPETempMap){
              maptempSPEMap.put(temp.SPETemplate__r.Stage__c,temp.SPETemplate__c);
                 
              }
              system.debug('map is'+maptempSPEMap);
         if(maptempSPEMap.containskey('Draft'))
         alertflag = 'true';
      }
/////////////////////////////
              
                     
              if(currRecord.get(stage)=='Draft') {
              draft=false;
              Published=false;
              obsolete=false;
              Pilot=true;
              
              }
              if(currRecord.get(stage)=='Pilot') {
              draft=false;
              pilot=false;
              Published=true;
              obsolete=true;
              
              }
              if(currRecord.get(stage)=='Published') {
              draft=false;
              pilot=false;
              Published=false;
              obsolete=true;
              
              }
              if(currRecord.get(stage)=='obsolete') {
              draft=false;
              pilot=false;
              Published=false;
              obsolete=false;
              
              }
              

                }


        }
        
      public void StagePublished() {
      
      if(alertflag=='false'){
      currRecord.put(stage,'Published');
      update currRecord;    
      } 
      }
      
       public void StageObsolete() {
       currRecord.put(stage,'obsolete');
       update currRecord; 
      }
      
      public void StagePilot() {
       currRecord.put(stage,'Pilot');
       update currRecord; 
      }
}