public with sharing class SPE_TreeViewEXT {
public String ParentId{get;set;}
public string Lifecycle{get;set;}
public boolean cascade{get;set;}
public boolean IsKPI{get;set;}
public boolean IsPI{get;set;}
public boolean IsSPETemp{get;set;}
public boolean IsScoringTemp{get;set;}
public String KPIname{get;set;}
public String PIname{get;set;}
public String SPETempName{get;set;} 
public string ObjectType;
public boolean msg{get;set;}
public String RecordName{get;set;}
public list<SPE_PIDefinition__c > PIDefinitionList{get;set;}
public List<SPE_KPIDefinition__c> KPIDefinitionList {get;set;}

public List<SPE_SPETemplate__c> SPETemplateList {get;set;}
public List<SPE_ScoringTemplate__c> ScoringTemplateList {get;set;}
public List<SPE_SPEPlan__c> SPEPlanList {get;set;}
public List<SPE_SPEKPIMap__c> SPEKPIMap{get;set;}
public list<SPE_KPICalculation__c> KPICal{get;set;}
public string OwnerName{get;set;}
List<SPE_KPIDefinition__c> KPIDefinitionListTemp;
List<SPE_SPEPlan__c> SPEPlanListTemp;
List<SPE_ScoringTemplate__c> ScoringTemplateListTemp;
List<SPE_SPEKPIMap__c> SPEKPIMapTemp;
List<SPE_PIDefinition__c > PIDefinitionListTemp;
List<SPE_SPETemplate__c> SPETemplateListTemp;
Set<Id> idUsers = new Set<Id>();
    public SPE_TreeViewEXT () {
        
        ParentId=apexpages.currentpage().getparameters().get('id');
        Lifecycle=apexpages.currentpage().getparameters().get('Lifecycle');
        PIDefinitionList= new list<SPE_PIDefinition__c >();
        SPETemplateList= new List<SPE_SPETemplate__c>();
        SPETemplateList= new List<SPE_SPETemplate__c> ();
        ScoringTemplateList= new List<SPE_ScoringTemplate__c> (); 
        SPEPlanList= new List<SPE_SPEPlan__c> ();
        SPEKPIMap= new List<SPE_SPEKPIMap__c> ();
        KPICal= new list<SPE_KPICalculation__c> (); 
        OwnerName=userinfo.getFirstname()+ ' '+ userinfo.getLastname();
        cascade=false;
        msg=false;
        if(lifecycle=='Published') {
        
             if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_KPIDefinition__c') {
                    ObjectType='KPI';
                    IsKPI=true;
                    Set<Id> SetOfPI= new set<Id>();
                    
                    //***************Changes for Encryption********************//
                    String query='select id,name, KPI_Title__c, PI_Data__c from SPE_KPIDefinition__c where id=: ParentId'; 
                    SPE_KPIDefinition__c currRecord=database.query(query);
                    
                    //KPIname=String.valueof(currRecord.get('Name'));
                    KPIname=String.valueof(currRecord.get('KPI_Title__c'));
                    
                    //RecordName=String.valueof(currRecord.get('Name'));
                    RecordName=String.valueof(currRecord.get('KPI_Title__c'));
                    //*************END******************//
                    
                    if(currRecord.get('PI_Data__c')!=Null) {
                       Id Id=String.valueOf(currRecord.get('PI_Data__c'));    
                       if([select LifecycleStage__c from SPE_PIDefinition__c where id=:Id].LifecycleStage__c!='Published')
                          SetOfPI.add(Id); 
                       }
                       else {
                       Id Id=String.valueOf(currRecord.get('Id'));
                       for(SPE_KPICalculation__c calc:[select PIDefination__c from SPE_KPICalculation__c where KPIDefinition__c=:Id and PIDefination__r.lifecyclestage__c!='Published'])
                           SetOfPI.add(calc.PIDefination__c );
                       }
                    
                    
                    //********************************Changes For Encryption**************************************//
                      for(SPE_PIDefinition__c p :[select id,name,PI_Title__c,lifecycleStage__c,OwnerId,Owner.Name from SPE_PIDefinition__c where id IN :SetOfPI]){
                    //******************************END*******************************//   
                      
                          PIDefinitionList.add(p); 
                          idUsers.add(p.OwnerId);    
                         }   
            }
            
            
            
            // SPE Template    
            if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_SPETemplate__c') {
                    ObjectType='SPE Template';
                    IsSPETemp=true;
                    Set<Id> SetOfKPI= new set<Id>();
                    KPIDefinitionList= new List<SPE_KPIDefinition__c>(); 
                    KPICal= new list<SPE_KPICalculation__c>();
                    PIDefinitionList= new list<SPE_PIDefinition__c > ();
                    String query='select id,name from SPE_SPETemplate__c where id=: ParentId'; 
                    SPE_SPETemplate__c currRecord=database.query(query);
                    SPETempName=String.valueof(currRecord.get('Name'));
                    RecordName=String.valueof(currRecord.get('Name'));
                    
                 //**********************************Changes For Encryption******************************//   
                    SPEKPIMap=[select SPETemplate__r.name,KPIDefinition__r.LifecycleStage__c,KPIDefinition__r.Owner.Name,KPIDefinition__r.OwnerId,KPIDefinition__c,KPIDefinition__r.name,KPIDefinition__r.KPI_Title__c from SPE_SPEKPIMap__c where SPETemplate__c=:parentId AND KPIDefinition__r.lifecycleStage__c='Pilot' ];
                 //**********************************END******************************//     
                                        
                     for(SPE_SPEKPIMap__c s:SPEKPIMap) {
                        SetOfKPI.add(s.KPIDefinition__c );
                        idUsers.add(s.KPIDefinition__r.OwnerId);
                        }
                    
                    set<id> PIset= new set<Id>();
                    
                    //*****************Changes For Encryption******************//
                    KPIDefinitionList= [select id,name, KPI_Title__c, pi_data__c,PI_Data__r.name,PI_Data__r.PI_Title__c,PI_Data__r.ownerId,PI_Data__r.owner.name,PI_Data__r.LifecycleStage__c  from SPE_KPIDefinition__c where id IN :SetOfKPI and PI_Data__r.LifecycleStage__c!='Published' ];
                    //***************END***********************//
                    
                    for(SPE_KPIDefinition__c K: KPIDefinitionList){       
                         idUsers.add(k.PI_Data__r.ownerId);
                       }   
                       system.debug('**********'+KPIDefinitionList);
                   
                   //*****************Changes For Encryption******************//
                   KPICal=[select PIDefination__c,KPIDefinition__c,PIDefination__r.owner.name,PIDefination__r.ownerId,PIDefination__r.name, PIDefination__r.PI_Title__c, PIDefination__r.lifecyclestage__c,KPIDefinition__r.name, KPIDefinition__r.KPI_Title__c from SPE_KPICalculation__c where KPIDefinition__c IN :SetOfKPI and PIDefination__r.lifecyclestage__c!='Published'];
                   //***************END***********************//
                   
                   for(SPE_KPICalculation__c calc:KPICal) {
                           idUsers.add(calc.PIDefination__r.OwnerId);
                           
                        }
                        system.debug('**********'+KPICal);   
            }
            
            
            // Scoring Template    
            if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_ScoringTemplate__c') {
                    ObjectType='Scoring Template';
                    IsScoringTemp=true;
                    
                    Set<Id> SetOfKPI= new set<Id>();
                    Set<Id> SetOfSPETemp= new set<Id>();
                    KPIDefinitionList= new List<SPE_KPIDefinition__c>(); 
                    KPICal= new list<SPE_KPICalculation__c>();
                    String query='select id,name,SPETemplate__c from SPE_ScoringTemplate__c where id=: ParentId'; 
                    SPE_ScoringTemplate__c currRecord=database.query(query);
                    RecordName=String.valueof(currRecord.get('Name'));
                    
                     
                    for(SPE_SPETemplate__c s:[select id,name,ownerId,owner.name,stage__c from SPE_SPETemplate__c where id=:String.valueOf(currRecord.get('SPETemplate__c')) and (stage__c='Pilot' or stage__c='Published')] ) {
                    idUsers.add(s.ownerId);
                    SPETemplateList.add(s);
                    SetOfSPETemp.add(s.id);
                    }
                    
                    //**********************Changes for Encryption************************//
                    SPEKPIMap=[select SPETemplate__r.name,SPETemplate__c,KPIDefinition__r.LifecycleStage__c,KPIDefinition__r.Owner.Name,KPIDefinition__r.OwnerId,KPIDefinition__c,KPIDefinition__r.name, KPIDefinition__r.KPI_Title__c from SPE_SPEKPIMap__c where SPETemplate__c IN:SetOfSPETemp AND (KPIDefinition__r.lifecycleStage__c='Pilot' OR KPIDefinition__r.lifecycleStage__c='Published')];
                    //*************************END*********************//   
                                        
                    for(SPE_SPEKPIMap__c s:SPEKPIMap) {
                        SetOfKPI.add(s.KPIDefinition__c );
                        idUsers.add(s.KPIDefinition__r.OwnerId);
                        }
                    
                    set<id> PIset= new set<Id>();
                    
                    //***********************Changes For Encryption**********************//
                    for(SPE_KPIDefinition__c K:  [select id,name, KPI_Title__c, pi_data__c,PI_Data__r.name, PI_Data__r.PI_Title__c, PI_Data__r.ownerId,PI_Data__r.owner.name,PI_Data__r.LifecycleStage__c  from SPE_KPIDefinition__c where id IN :SetOfKPI and PI_Data__r.LifecycleStage__c='Pilot' ]){       
                    //******************END********************//
                       KPIDefinitionList.add(k);    
                       idUsers.add(k.PI_Data__r.ownerId);
                       }   
                    
                    //***********************Changes For Encryption**********************//
                    for(SPE_KPICalculation__c calc:[select PIDefination__c,KPIDefinition__c,PIDefination__r.owner.name,PIDefination__r.ownerId,PIDefination__r.name, PIDefination__r.PI_Title__c, PIDefination__r.lifecyclestage__c,KPIDefinition__r.name, KPIDefinition__r.KPI_Title__c from SPE_KPICalculation__c where KPIDefinition__c IN :SetOfKPI  and PIDefination__r.lifecyclestage__c!='Published']) {
                    //******************END********************//
                           idUsers.add(calc.PIDefination__r.OwnerId);
                           KPICal.add(calc) ;
                        }
            } 
            
            
             
        }  
        
        
        
        
        if(lifecycle=='Obsolete') 
          {
        
             if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_PIDefinition__c') 
             {     IsPI=true; 
                   ObjectType='PI';
                   
                     
                   KPIDefinitionList= new List<SPE_KPIDefinition__c>();
                   SPETemplateList = new List<SPE_SPETemplate__c>();
                   ScoringTemplateList = new List<SPE_ScoringTemplate__c>();
                   SPEPlanList = new List<SPE_SPEPlan__c>();
                   SPEKPIMap= new List<SPE_SPEKPIMap__c>();
                   
                   //     Current Pi Information
                   
                   //******************Changes for Encryption*****************//
                   String query='select id,name, PI_Title__c from SPE_PIDefinition__c where id=: ParentId'; 
                   SPE_PIDefinition__c currRecord=database.query(query);
                   
                   //PIname=String.valueof(currRecord.get('Name'));
                   PIname=String.valueof(currRecord.get('PI_Title__c'));
                   
                   //RecordName=String.valueof(currRecord.get('Name'));
                   RecordName=String.valueof(currRecord.get('PI_Title__c'));
                   // Pi Information ends here
                   //*******************END********************//
                   
                   //Fetching KPI Information
                   
                   //******************Changes for Encryption*****************//
                   set<id> KPIDefSet = new set<Id>();
                   for(SPE_KPIDefinition__c k: [select id,LifecycleStage__c,name, KPI_Title__c, OwnerId,Owner.Name from SPE_KPIDefinition__c where PI_Data__c=: ParentId AND ( LifecycleStage__c='Published' OR LifecycleStage__c='Pilot')])
                       KPIDefSet .add(k.id);
                                  
                   
                   for(SPE_KPICalculation__c calc:[select id,PIDefination__c,OwnerId,KPIDefinition__c from SPE_KPICalculation__c where PIDefination__c = :ParentId AND (KPIDefinition__r.LifecycleStage__c='Published' OR KPIDefinition__r.LifecycleStage__c='Pilot') ])
                       KPIDefSet.add(calc.KPIDefinition__c );
                       
                           
                   for(SPE_KPIDefinition__c K:  [select id,LifecycleStage__c,name, KPI_Title__c, OwnerId,Owner.Name from SPE_KPIDefinition__c where Id IN: KPIDefSet AND ( LifecycleStage__c='Published' OR LifecycleStage__c='Pilot')]) {       
                       KPIDefinitionList.add(k);    
                       idUsers.add(k.OwnerId);
                       }
                  //Fetching KPI ends Here
                  
                  // Fetching SPE Templates
                  set<ID> SpeTemplateid= new set<Id>();
                  if(KPIDefSet .size()>0) {
                      
                      SPEKPIMap=[select SPETemplate__c,SPETemplate__r.name,SPETemplate__r.Owner.Name,SPETemplate__r.OwnerId,KPIDefinition__c,KPIDefinition__r.name, KPIDefinition__r.KPI_Title__c, SPETemplate__r.Stage__c from SPE_SPEKPIMap__c where KPIDefinition__c IN :KPIDefSet AND (SPETemplate__r.Stage__c='Published' OR SPETemplate__r.Stage__c='Pilot') ];
                      
                      for(SPE_SPEKPIMap__c s:SPEKPIMap) {
                              SpeTemplateid.add(s.SPETemplate__c);
                              idUsers.add(s.SPETemplate__r.OwnerId);
                      }
                  }
                  // Fetching SPE Templates end  
                  //*******************END********************//
                  
                  // Fetching Scoring Templates
                  set<ID> ScoringTemplateid= new set<Id>();
                  If(SpeTemplateid.size()>0) {
                      
                      for(SPE_ScoringTemplate__c  s:[select id,Name,SPETemplate__r.name,Owner.Name,stage__c,ownerid from SPE_ScoringTemplate__c where SPETemplate__c IN:SpeTemplateid and (stage__c='Published' or stage__c='Pilot')]) {
                          ScoringTemplateList.add(s);
                          ScoringTemplateid.add(s.id); 
                          idUsers.add(s.OwnerId);   
                      }
                      
                  } // Fetching Scoring Templates ends
                  
                  
                  // Fetching SPE Plan
                  If(ScoringTemplateid.size()>0) {
                      
                      for(SPE_SPEPlan__c s:[select id,Name,SPEScoringTemplate__r.name,stage__c,Owner.Name,OwnerId from SPE_SPEPlan__c where SPEScoringTemplate__c IN: ScoringTemplateid]){ 
                          SPEPlanList.add(s);
                          idUsers.add(s.OwnerId);
                          }
                  } 
                  
             }
             
             
             
             
             if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_KPIDefinition__c') 
             {     IsKPI=true; 
                   ObjectType='KPI';
                     
                   
                   SPETemplateList = new List<SPE_SPETemplate__c>();
                   ScoringTemplateList = new List<SPE_ScoringTemplate__c>();
                   SPEPlanList = new List<SPE_SPEPlan__c>();
                   SPEKPIMap= new List<SPE_SPEKPIMap__c>();
                   
                   //     Current KPi Information
                   //**************Changes For Encryption*************//
                   String query='select id,name, KPI_Title__c from SPE_KPIDefinition__c where id=: ParentId'; 
                   SPE_KPIDefinition__c currRecord=database.query(query);
                   
                   //KPIname=String.valueof(currRecord.get('Name'));
                   KPIname=String.valueof(currRecord.get('KPI_Title__c'));
                   
                   //RecordName=String.valueof(currRecord.get('Name'));
                   RecordName=String.valueof(currRecord.get('KPI_Title__c'));
                   // KPi Information ends here
                   
                   
                  // Fetching SPE Templates
                  set<ID> SpeTemplateid= new set<Id>();
                                       
                      SPEKPIMap=[select SPETemplate__c,SPETemplate__r.name,SPETemplate__r.Owner.Name,SPETemplate__r.OwnerId,KPIDefinition__c,KPIDefinition__r.name, KPIDefinition__r.KPI_Title__c, SPETemplate__r.Stage__c from SPE_SPEKPIMap__c where KPIDefinition__c =:ParentId AND (SPETemplate__r.Stage__c='Published' OR SPETemplate__r.Stage__c='Pilot') ];
                      
                      for(SPE_SPEKPIMap__c s:SPEKPIMap) {
                              SpeTemplateid.add(s.SPETemplate__c);
                              idUsers.add(s.SPETemplate__r.OwnerId);
                      }
                  
                  // Fetching SPE Templates end  
                  //***********************END********************//
                  
                  // Fetching Scoring Templates
                  set<ID> ScoringTemplateid= new set<Id>();
                  If(SpeTemplateid.size()>0) {
                      
                      for(SPE_ScoringTemplate__c  s:[select id,Name,SPETemplate__r.name,Owner.Name,ownerid,stage__c from SPE_ScoringTemplate__c where SPETemplate__c IN:SpeTemplateid]) {
                          ScoringTemplateList.add(s);
                          ScoringTemplateid.add(s.id); 
                          idUsers.add(s.OwnerId);   
                      }
                      
                  } // Fetching Scoring Templates ends
                  
                  
                  // Fetching SPE Plan
                  If(ScoringTemplateid.size()>0) {
                      
                      for(SPE_SPEPlan__c s:[select id,Name,SPEScoringTemplate__r.name,stage__c,Owner.Name,OwnerId from SPE_SPEPlan__c where SPEScoringTemplate__c IN: ScoringTemplateid]){ 
                          SPEPlanList.add(s);
                          idUsers.add(s.OwnerId);
                          }
                  } 
                  
             }
             
             
             
             
             // SPE Template
             if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_SPETemplate__c') {
                    ObjectType='SPE Template';
                    IsSPETemp=true;
                  
                  
                   ScoringTemplateList = new List<SPE_ScoringTemplate__c>();
                   SPEPlanList = new List<SPE_SPEPlan__c>();
                   SPEKPIMap= new List<SPE_SPEKPIMap__c>();
                   
                   //     Current SPE Template Information
                   String query='select id,name from SPE_SPETemplate__c where id=: ParentId'; 
                   SPE_SPETemplate__c currRecord=database.query(query);
                   RecordName=String.valueof(currRecord.get('Name'));
                   //     Current SPE Template ends here
                   
                  // Fetching Scoring Templates
                  set<ID> ScoringTemplateid= new set<Id>();
                      
                      for(SPE_ScoringTemplate__c  s:[select id,Name,SPETemplate__r.name,Owner.Name,ownerid,stage__c from SPE_ScoringTemplate__c where SPETemplate__c=:parentId and(stage__c='Published' or stage__c='Pilot')]) {
                          ScoringTemplateList.add(s);
                          ScoringTemplateid.add(s.id); 
                          idUsers.add(s.OwnerId);   
                      }// Fetching Scoring Templates ends
                  
                  
                  // Fetching SPE Plan
                  If(ScoringTemplateid.size()>0) {
                      
                      for(SPE_SPEPlan__c s:[select id,Name,SPEScoringTemplate__r.name,stage__c,Owner.Name,OwnerId from SPE_SPEPlan__c where SPEScoringTemplate__c IN: ScoringTemplateid]){ 
                          SPEPlanList.add(s);
                          idUsers.add(s.OwnerId);
                          }
                  } 
                   
                    
            }
            
            
            
            
            // Scoring Template
             if((Id.valueOf(ParentId)).getSObjectType().getDescribe().getName()=='SPE_ScoringTemplate__c') {
                    ObjectType='Scoring Template';
                    IsScoringTemp=true;
                  
                  
                  
                   SPEPlanList = new List<SPE_SPEPlan__c>();
                   
                   
                   //     Current Scoring Template Information
                   String query='select id,name from SPE_ScoringTemplate__c where id=: ParentId'; 
                   SPE_ScoringTemplate__c currRecord=database.query(query);
                   RecordName=String.valueof(currRecord.get('Name'));
                   //     Current SPE Template ends here
                   
                  // Fetching SPE Plan 
                  
                      
                      for(SPE_SPEPlan__c s:[select id,Name,SPEScoringTemplate__r.name,stage__c,Owner.Name,OwnerId from SPE_SPEPlan__c where SPEScoringTemplate__c=:parentId and stage__c!='Obsolete']){ 
                          SPEPlanList.add(s);
                          idUsers.add(s.OwnerId);
                          }
                  } 
                   
                    
            
             
          }
    }
    
    public PageReference sendMail(){
        
        Messaging.Singleemailmessage email = new Messaging.Singleemailmessage();
        String [] toaddress= new list<string>();
        for(user u:[select id,email from user where id IN: idUsers Limit 100])
           toaddress.add(string.valueOf(u.email));
           string ur=string.valueof(System.URL.getSalesforceBaseUrl().toExternalForm())+'/apex/SPE_TreeView?id='+ParentId+'&Lifecycle='+Lifecycle;
        email.setHtmlBody('Hi,<br/><br/>This is to inform you that <b>'+OwnerName+'</b> intends to modify the lifecycle of <b>'+ObjectType+'</b> Named <b>'+RecordName+'</b> ID <b>('+ParentId+')</b>; to <b>'+Lifecycle+'</b><br/><br/>'+
                                'The change impact can be viewed in the link here : <a href="'+ur+'"> Click here </a>'+
                                    '<br/><br/>You are requested to change your objects highlighted in green to <b><font color="green">'+lifecycle+'</font></b> or get in touch with '+OwnerName+' if any further input needed.'+
                                        '<br/><br/>Note:<br/>Your objects can only be changed by yourself or any member with whom you have shared the rights.<br/>Grey Boxes are Draft object which will be impacted with the requested changes & will need editing for future use.'+
                                            '<br/></br/> Thanks and Regards,<br/>SPE Scorecard Tool');
        email.setSaveAsActivity(false);
        email.setToAddresses(toaddress);
        email.setSubject('Lifecycle Change Request');
        Messaging.sendEmail(new Messaging.Singleemailmessage[] { email });
            
        return null;
    }
    
    
    
    
    public Pagereference cascade() {
       Id currentOwnerId= userInfo.getuserId();
       set<Id> scoringTempIds= new set<Id>();
       set<Id> SPETempIds= new set<Id>();
       msg=false;
       KPIDefinitionListTemp = new List<SPE_KPIDefinition__c>();
       SPEPlanListTemp = new List<SPE_SPEPlan__c>();
       ScoringTemplateListTemp = new List<SPE_ScoringTemplate__c>();
       SPEKPIMapTemp = new List<SPE_SPEKPIMap__c>();
       SPETemplateListTemp = new List<SPE_SPETemplate__c>();
       
       
       if(lifecycle=='Obsolete') {
           //----------------------------------------------------------------------
           // Cascade PI 
           if(ObjectType=='PI') {
               
                   for(integer k=0;k<SPEPlanList.size();k++) {
                       
                       if(SPEPlanList[k].ownerId==currentOwnerId && (SPEPlanList[k].stage__c=='Pilot' || SPEPlanList[k].stage__c=='Published')) {
                           SPEPlanList[k].stage__c='Obsolete';
                           update SPEPlanList[k];
                           msg=true;
                       //    SPEPlanList.remove(k);
                           }
                       else{
                           SPEPlanListTemp.add(SPEPlanList[k]);
                          if(SPEPlanList[k].stage__c!='Draft') 
                              scoringTempIds.add(SPEPlanList[k].SPEScoringTemplate__c);
                          
                       }    
                   }
                 SPEPlanList.clear();
                 SPEPlanList.addAll(SPEPlanListTemp);
                   
                   
                   for(integer k=0;k<ScoringTemplateList.size();k++) {
                      
                      if(ScoringTemplateList[k].ownerId==currentOwnerId && !scoringTempIds.contains(ScoringTemplateList[k].id)) {
                           ScoringTemplateList[k].stage__c='Obsolete';
                           update ScoringTemplateList[k];
                           msg=true;
                          // ScoringTemplateList.remove(k);
                           }
                       else {
                           ScoringTemplateListTemp.add(ScoringTemplateList[k]);
                       SPETempIds.add(ScoringTemplateList[k].SpeTemplate__c);
                       }                  
                       
                   }
                   ScoringTemplateList.clear();
                   ScoringTemplateList.addAll(ScoringTemplateListTemp);
                   
                   Set<id> canbeobsolete = new set<Id>();
                   set<id> kpiId= new set<id>();
                   for(integer k=0;k<SPEKPIMap.size();k++) {
                   
                       if(SPEKPIMap[k].SPETemplate__r.ownerId==currentOwnerId && !SPETempIds.contains(SPEKPIMap[k].SPETemplate__c)) {
                           canbeobsolete.add(SPEKPIMap[k].SPETemplate__c); 
                           //SPEKPIMap.remove(k);
                       }
                       else {
                           SPEKPIMapTemp.add(SPEKPIMap[k]);
                            kpiId.add(SPEKPIMap[k].kpidefinition__c);
                       }
                   
                   }// for(integer k=0;k<SPEKPIMap.size();k++)
                    
                    SPEKPIMap.clear();
                    SPEKPIMap.addAll(SPEKPIMapTemp);
                   
                  if(canbeobsolete.size()>0) {
                      list<SPE_SPETemplate__c> s=[select id,stage__c from SPE_SPETemplate__c where id IN: canbeobsolete];
                      for(SPE_SPETemplate__c ss:s) {
                          ss.stage__c='Obsolete';
                          msg=true;
                      }
                      update s;    
                  }
                 
                 for(integer k=0;k<KPIDefinitionList.size();k++) {
                     if(KPIDefinitionList[k].ownerId==currentOwnerId && !kpiId.contains(KPIDefinitionList[k].Id)) {
                           KPIDefinitionList[k].Lifecyclestage__c='Obsolete';
                           msg=true;
                           update KPIDefinitionList[k];
                           //KPIDefinitionList.remove(k);
                     }
                     else{
                         KPIDefinitionListTemp.add(KPIDefinitionList[k]);
                     }
                 }
                 KPIDefinitionList.clear();
                 KPIDefinitionList.addAll(KPIDefinitionListTemp);
           }
           //----------------------------------------------------------------------
           
           
           
           //-----------------------------------------------------------------------
           // KPI Obsolete Cascade
           if(ObjectType=='KPI') {
               
               for(integer k=0;k<SPEPlanList.size();k++) {
                       
                       if(SPEPlanList[k].Stage__c=='Draft' ) {
                            //  SPEPlanList.remove(k);
                           }
                        else{
                            SPEPlanListTemp.add(SPEPlanList[k]);
                        }   
               }
               
               SPEPlanList.clear();
               SPEPlanList.addAll(SPEPlanListTemp);
               
               Set<Id> ScoringId= new set<id>();
               for(integer k=0;k<SPEPlanList.size();k++) {
                       
                       if(SPEPlanList[k].ownerId==currentOwnerId ) {
                           SPEPlanList[k].stage__c='Obsolete';
                           update SPEPlanList[k];
                           msg=true;
                         //  SPEPlanList.remove(k);
                           }
                        else {
                        SPEPlanListTemp.add(SPEPlanList[k]);
                        ScoringId.add(SPEPlanList[k].SPEScoringTemplate__c );
                        
                        }   
                         
                   }
                   SPEPlanList.clear();
                   SPEPlanList.addAll(SPEPlanListTemp);
                   
                   set<id> SPETemplate = new set<id>();
                   for(integer k=0;k<ScoringTemplateList.size();k++) {
                     if(ScoringTemplateList[k].ownerId==currentOwnerId && !ScoringId.contains(ScoringTemplateList[k].Id)) {
                           ScoringTemplateList[k].stage__c='Obsolete';
                           msg=true;
                           update ScoringTemplateList[k];
                           msg=true;
                         //  ScoringTemplateList.remove(k);
                             
                     }
                     
                     else {
                          ScoringTemplateListTemp.add(ScoringTemplateList[k]);
                          SPETemplate.add(ScoringTemplateList[k].SPETemplate__c);
                     }
                 }
               ScoringTemplateList.clear();
               ScoringTemplateList.addAll(ScoringTemplateListTemp);
               
                set<id> canbeObsolete= new set<id>();
                   
                
                for(integer k=0;k<SPEKPIMap.size();k++) {
                       
                       if(SPEKPIMap[k].SPETemplate__r.ownerId==currentOwnerId && !SPETemplate.contains(SPEKPIMap[k].SPETemplate__c)) {
                           canbeObsolete.add(SPEKPIMap[k].SPETemplate__c);
                           }
                         
                   }
                   
                   
                   
                   if(canbeObsolete.size()>0)
                       {
                           list<SPE_SPeTemplate__c> s=[select id,stage__c from SPE_SPeTemplate__c where id IN:canbeObsolete];
                            for(SPE_SPeTemplate__c ss:s)
                                  ss.stage__c='Obsolete';
                             msg=true;     
                             update s;     
                       }
               
               
               
           }
           //------------------------------------------------------------------------
           
           
           //-----------------------------------------------------------------------
           // SPE Scoring Template Cascade
           if(ObjectType=='Scoring Template') {
               
               for(integer k=0;k<SPEPlanList.size();k++) {
                       
                       if(SPEPlanList[k].ownerId==currentOwnerId ) {
                           SPEPlanList[k].stage__c='Obsolete';
                           update SPEPlanList[k];
                           msg=true;
                         //  SPEPlanList.remove(k);
                           }
                         else{
                             SPEPlanListTemp.add(SPEPlanList[k]);
                         }  
                         
                   }
                    SPEPlanList.clear();
                    SPEPlanList.addAll(SPEPlanListTemp);
           
           }// if(ObjectType=='Scoring Template') ENDS
           //------------------------------------------------------------------------
           
           
           
           
             
           
           //-----------------------------------------------------------------------
           // SPE Template Cascade
           if(ObjectType=='SPE Template') {
               
               for(integer k=0;k<ScoringTemplateList.size();k++) {
                       
                       if(ScoringTemplateList[k].ownerId==currentOwnerId ) {
                           ScoringTemplateList[k].stage__c='Obsolete';
                           update ScoringTemplateList[k];
                           msg=true;
                         //  ScoringTemplateList.remove(k);
                           }
                           else{
                            ScoringTemplateListTemp.add(ScoringTemplateList[k]);   
                               
                           }
                         
                   }
                ScoringTemplateList.clear();
                ScoringTemplateList.addAll(ScoringTemplateListTemp);
           
           }// if(ObjectType=='SPE Template') ENDS
           //------------------------------------------------------------------------          
       }
       
       
       
       
       //----------------------------------------------------------------------
       // Publishing Workflows
       // Published Casscade
       if(lifecycle=='Published') {
           if(ObjectType=='KPI') {
                  
                   PIDefinitionListTemp=new list<SPE_Pidefinition__c>();
                   for(integer k=0;k<PIDefinitionList.size();k++) {
                       
                       if(PIDefinitionList[k].ownerId==currentOwnerId && (PIDefinitionList[k].Lifecyclestage__c=='Pilot')) {
                           PIDefinitionList[k].Lifecyclestage__c='Published';
                           update PIDefinitionList[k];
                           msg=true;
                          // PIDefinitionList.remove(k);
                           }
                           else{
                            PIDefinitionListTemp.add(PIDefinitionList[k]);   
                           }
                         
                   }
                   PIDefinitionList.clear();
                   if(PIDefinitionListTemp.size()>0)
                   PIDefinitionList.addAll(PIDefinitionListTemp);
                   
                   
            }
             //----------------------------------------------------------------------
             
           //----------------------------------------------------------------------
           // publishing Cascade SPE Template
              
           if(ObjectType=='SPE Template') {
               set<Id> tobechanged = new set<id>();
               set<id> kpiId= new set<id>();
               
               for(integer k=0;k<KPIDefinitionList.size();k++) {
                       
                       if(KPIDefinitionList[k].pi_data__r.ownerId==currentOwnerId && KPIDefinitionList[k].pi_data__c!=Null) {
                           tobechanged.add(KPIDefinitionList[k].pi_data__c);
                           msg=true;
                           }
                        else {
                            kpiId.add(KPIDefinitionList[k].id);
                        } 
                   }
                   
                   
                for(integer k=0;k<KPICal.size();k++) {
                       
                       if(KPICal[k].PIDefination__r.OwnerId==currentOwnerId) {
                           tobechanged.add(KPICal[k].PIDefination__c);
                           msg=true;
                           }
                        else {
                            kpiId.add(KPICal[k].KPIDefinition__c);
                        } 
                   }
                 
                list<SPE_piDefinition__c> p=[select id,lifecycleStage__c from SPE_piDefinition__c where id IN:tobechanged ];   
                
                for (SPE_piDefinition__c pp:p) {
                 pp.lifecycleStage__c='Published';
                
                } 
                if(p.size()>0)
                update p; 
                
                tobechanged.clear();
                set<Id> SPETemp= new set<id>();
                
                 for(integer k=0;k<SPEKPIMap.size();k++) {
                       
                       if(SPEKPIMap[k].KPIDefinition__r.ownerId==currentOwnerId && !kpiId.contains(SPEKPIMap[k].KPIDefinition__c)) {
                           tobechanged.add(SPEKPIMap[k].KPIDefinition__c);
                           msg=true;
                        //   SPEKPIMap.remove(k);
                        
                           }
                         else {
                          SPEKPIMapTemp.add(SPEKPIMap[k]);
                          tobechanged.add(SPEKPIMap[k].KPIDefinition__c);   
                          SPETemp.add(SPEKPIMap[k].SPETemplate__c);
                         
                         }
                   }
                SPEKPIMap.clear();
                SPEKPIMap.addAll(SPEKPIMapTemp);
                list<SPE_KpiDefinition__c> kk=[select id,lifecycleStage__c from SPE_KpiDefinition__c where id IN:tobechanged ];   
                
                for (SPE_KpiDefinition__c pp:kk) {
                 pp.lifecycleStage__c='Published';
                
                } 
                if(kk.size()>0)
                update kk; 
                  
               
                
           }   
              
            //----------------------------------------------------------------------
           
           
           //----------------------------------------------------------------------
           // publishing Cascade Scoring Template
              
           if(ObjectType=='Scoring Template') {
               set<Id> tobechanged = new set<id>();
               set<id> kpiId= new set<id>();
               
               for(integer k=0;k<KPIDefinitionList.size();k++) {
                       
                       if(KPIDefinitionList[k].pi_data__r.ownerId==currentOwnerId) {
                           tobechanged.add(KPIDefinitionList[k].pi_data__c);
                           msg=true;
                           }
                        else {
                            kpiId.add(KPIDefinitionList[k].id);
                        } 
                   }
                   
                   
                for(integer k=0;k<KPICal.size();k++) {
                       
                       if(KPICal[k].PIDefination__r.OwnerId==currentOwnerId) {
                           tobechanged.add(KPICal[k].PIDefination__c);
                           msg=true;
                           }
                        else {
                            kpiId.add(KPICal[k].KPIDefinition__c);
                        } 
                   }
                 
                list<SPE_piDefinition__c> p=[select id,lifecycleStage__c from SPE_piDefinition__c where id IN:tobechanged ];   
                
                for (SPE_piDefinition__c pp:p) {
                 pp.lifecycleStage__c='Published';
                
                } 
                if(p.size()>0)
                update p; 
                
                tobechanged.clear();
                set<Id> SPETemp= new set<id>();
                
                 for(integer k=0;k<SPEKPIMap.size();k++) {
                       
                       if(SPEKPIMap[k].KPIDefinition__r.ownerId==currentOwnerId && !kpiId.contains(SPEKPIMap[k].KPIDefinition__c)) {
                           tobechanged.add(SPEKPIMap[k].KPIDefinition__c);
                           msg=true;
                          // SPEKPIMap.remove(k);
                           }
                         else {
                          SPEKPIMapTemp.add(SPEKPIMap[k]);   
                          SPETemp.add(SPEKPIMap[k].SPETemplate__c);
                         
                         }
                   }
                   
                   SPEKPIMap.clear();
                   SPEKPIMap.addAll(SPEKPIMapTemp);
                
                list<SPE_KpiDefinition__c> kk=[select id,lifecycleStage__c from SPE_KpiDefinition__c where id IN:tobechanged ];   
                
                for (SPE_KpiDefinition__c pp:kk) {
                 pp.lifecycleStage__c='Published';
                
                } 
                if(kk.size()>0)
                update kk; 
                  
               
               for(integer k=0;k<SPETemplateList.size();k++) {
                       
                       if(SPETemplateList[k].ownerId==currentOwnerId && !SPETemp.contains(SPETemplateList[k].id)) {
                           SPETemplateList[k].stage__c='Published';
                           update SPETemplateList[k];
                           msg=true;
                        //   SPETemplateList.remove(k);
                           }
                           else{
                              SPETemplateListTemp.add(SPETemplateList[k]);  
                           }
                         
                   }
                   
                   SPETemplateList.clear();
                   SPETemplateList.addAll(SPETemplateListTemp);
                
           }   
              
            //----------------------------------------------------------------------        
       }
       
       return null;
    }

}