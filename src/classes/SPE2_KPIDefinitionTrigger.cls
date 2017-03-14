public class SPE2_KPIDefinitionTrigger 
{
   /* public static void UpdatePIDefinition(List<SPE_KPIDefinition__c> newKPIs, Map<Id, SPE_KPIDefinition__c> oldKPIMaps)
    {
        Set<Id> kpiIds = new Set<Id>();
        
        for (SPE_KPIDefinition__c kpi : newKPIs)
        {
            if (kpi.LifecycleStage__c == SPE_Constants.PUBLISHED_LIFECYCLESTAGE  && kpi.LifecycleStage__c != oldKPIMaps.get(kpi.Id).LifecycleStage__c )
            {
                kpiIds.add(kpi.Id);
            }
        }
        
        if (kpiIds.size() > 0)
        {
            List<SPE_PIDefinition__c> toBeUpdatedPiDefinition = new List<SPE_PIDefinition__c>();
            
            Set<Id> piIds = new Set<Id>();
            
            for (SPE_KPICalculation__c kpi : [SELECT PIDefination__c, KPIDefinition__c 
                                             FROM SPE_KPICalculation__c 
                                             WHERE KPIDefinition__c In: kpiIds 
                                             AND PIDefination__r.LifecycleStage__c = :SPE_Constants.DRAFT_LIFECYCLESTAGE])
            {
                if (piIds.contains(kpi.PIDefination__c) == false)
                {
                    SPE_PIDefinition__c pi = new SPE_PIDefinition__c();
                    pi.Id = kpi.PIDefination__c;
                    pi.LifecycleStage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
                    
                    toBeUpdatedPiDefinition.add(pi);
                    
                    piIds.add(kpi.PIDefination__c);
                }
            }
            
            update toBeUpdatedPiDefinition;
        }
    }*/


    public static void ConvertKPIValues(List<SPE_KPIDefinition__c> newKPIs, Map<Id,SPE_KPIDefinition__c> oldKPIMaps) 
    {
        
                
        Map<Id, Map<String, String>> kpiEnterpriseCommentsMap = new Map<Id, Map<String, String>>();
        
        List<SPE_KPIComments__c> toBeDeletedKPIComments = new List<SPE_KPIComments__c>();
        
        for (SPE_KPIComments__c kpiCom : [SELECT KPI__c, EnterpriseId__c, SurveyComments__c FROM SPE_KPIComments__c WHERE KPI__c In: oldKPIMaps.keySet()])
        {
            toBeDeletedKPIComments.add(kpiCom);
            
            Map<String, String> enterpriseCommentsMap = new Map<String, String>();
            
            if (kpiEnterpriseCommentsMap.get(kpiCom.KPI__c) != null)
            {
                enterpriseCommentsMap = kpiEnterpriseCommentsMap.get(kpiCom.KPI__c);
            }
            
            String surveyComments = '';
         if (enterpriseCommentsMap.get(kpiCom.EnterpriseId__c) != null)
         {
           surveyComments = enterpriseCommentsMap.get(kpiCom.EnterpriseId__c);
         }
         
         surveyComments = surveyComments == ''?  kpiCom.SurveyComments__c : surveyComments + ' | ' + kpiCom.SurveyComments__c;
            
            enterpriseCommentsMap.put(kpiCom.EnterpriseId__c, surveyComments);
            
            kpiEnterpriseCommentsMap.put(kpiCom.KPI__c, enterpriseCommentsMap);
            system.debug('KPI Comments MAP' + kpiEnterpriseCommentsMap);
        }
        
        //************Post SPE2.0 KPI Computation issue*****************//
        String identifierparam = System.Now()+';'+UserInfo.getuserID();
        
        for (SPE_KPIDefinition__c kpi : newKPIs){
           System.Debug('kpi.KPIValuesCalculation__c::'+kpi.KPIValuesCalculation__c);
           System.Debug('oldKPIMaps.get(kpi.Id).KPIValuesCalculation__c'+oldKPIMaps.get(kpi.Id).KPIValuesCalculation__c); 
           if (kpi.KPIValuesCalculation__c != oldKPIMaps.get(kpi.Id).KPIValuesCalculation__c)
            {               
                /*List<SPE_PITempValue__c> piTemplist = [SELECT Index__c, KPIDefinition__c, PIValue__c, MappingScope__c, IsConstant__c, ValueType__c 
                                                          FROM SPE_PITempValue__c 
                                                          WHERE KPIDefinition__c =: kpi.ID];
                system.debug('piTemplist ::'+piTemplist);                                          
                
                List<KPI_IntermediateComputation__c> kpiInterComlist = new List<KPI_IntermediateComputation__c>();
                Set<String> intermidateKPI = new Set<String>();
                for(SPE_PITempValue__c piTemp: piTemplist){
                    intermidateKPI.add(piTemp.MappingScope__c);             
                }
                
                system.debug('intermidateKPI::'+intermidateKPI);
                
                for(String scopeinter: intermidateKPI){
                    KPI_IntermediateComputation__c kpiIntCom = new KPI_IntermediateComputation__c();
                    kpiIntCom.IdentifierParam__c = identifierparam;
                    kpiIntCom.KPI_MappingScope__c = scopeinter;
                    kpiIntCom.KPI__c = kpi.ID;
                    kpiInterComlist.add(kpiIntCom);
                }                                         
                system.debug('kpiInterComlist ::'+kpiInterComlist);
                try{
                    if(!kpiInterComlist.isEmpty()){
                        insert kpiInterComlist;
                    }            
                }catch(Exception e){} 
                
                if(!Test.isRunningTest()){
                    SPE2_kpiIntermediateCompute dbatch = new SPE2_kpiIntermediateCompute(identifierparam,String.ValueOf(newKPIs[0].ID),kpiEnterpriseCommentsMap);
                    database.executebatch(dbatch,1);
                }*/
                
                if(!Test.isRunningTest()){
                    SPE2_createkpiIntermediateCompute dbatch = new SPE2_createkpiIntermediateCompute(identifierparam,String.ValueOf(newKPIs[0].ID),kpiEnterpriseCommentsMap);
                    database.executebatch(dbatch,2000);
                }                                                                    
           }
       }
  }
    public static void DeleteKPICalculations(List<SPE_KPIDefinition__c> lstKPIDef){
        List<SPE_KPICalculation__c> lstKPICalculationTBD = new List<SPE_KPICalculation__c>();
        Set<Id> setKPIIds = new Set<Id>();
        for(SPE_KPIDefinition__c objKPI : lstKPIDef){
            if(objKPI.PI_Data__c != null){
                setKPIIds.add(objKPI.id);
                objKPI.RPNCondition1Expression__c = '';
                objKPI.RPNCondition2Expression__c = '';
                objKPI.RPNExpression__c = '';
                objKPI.RPNExpressionElse__c = '';
            }
        }
        
        if(setKPIIds.size()>0){
            lstKPICalculationTBD = [select id from SPE_KPICalculation__c where KPIDefinition__c IN :setKPIIds];
        }
        if(!lstKPICalculationTBD.isEmpty()){
            delete lstKPICalculationTBD;
        }
    }
    
    //********** method added to update version in KPI****
    public static void UpdateVersion(List<SPE_KPIDefinition__c> lstKPIDef){
        List<SPE_KPIDefinition__c> tempList = new List<SPE_KPIDefinition__c>();
        if(lstKPIDef[0].Master_KPI__c!=null){
            system.debug('***lstKPIDef[0].Master_KPI__c****'+lstKPIDef[0].Master_KPI__c);
            tempList = [SELECT id,VerNumber__c from SPE_KPIDefinition__c where ( Master_KPI__c = :lstKPIDef[0].Master_KPI__c or  id=:lstKPIDef[0].Master_KPI__c) order by VerNumber__c DESC ];
            
            
           if(tempList.size()>0) 
           lstKPIDef[0].VerNumber__c =tempList[0].VerNumber__c+1;
           
           }
           
   
    }
    
    public static void scheduledDateValidation(List<SPE_KPIDefinition__c> oldKPIs,List<SPE_KPIDefinition__c> newKPIs, Map<Id, SPE_KPIDefinition__c> oldKPIMaps) {
        
        try{            
            Integer maxdayRelatedList;
            Integer dayKPINew;
            
            list<SPE_KPICalculation__c> piDefinitions = [Select Id,PIDefination__c, PIDefination__r.PIUploadDuedate__c,KPIDefinition__c From SPE_KPICalculation__c where KPIDefinition__c IN:  oldKPIMaps.keyset()];
            
            if( piDefinitions.size()>0 ){
                maxdayRelatedList = piDefinitions[0].PIDefination__r.PIUploadDuedate__c.day();
            }
            
            For (integer i =0;i<piDefinitions.size();i++){  
                if( piDefinitions[i].PIDefination__r.PIUploadDuedate__c.day() > maxdayRelatedList){
                    maxdayRelatedList = piDefinitions[i].PIDefination__r.PIUploadDuedate__c.day();
                }            
            }
            /*
            for (SPE_KPIDefinition__c kpiObjUpdated: newKPIs) {
                dayKPINew = kpiObjUpdated.ScheduledDate__c.day();
                if (kpiObjUpdated.ScheduledDate__c!=NULL && (maxdayRelatedList > dayKPINew)) {
                    kpiObjUpdated.addError('PI Upload Due date is greater than Next Scheduled Date');
                }
            } */     
        } catch (Exception e) {}   
    }
    
  //-------Method added to update SPE Template with the highest KPI when KPI stage is changed------
  public static void updateKPIinSPETemplate(List<SPE_KPIDefinition__c> newKPIs, Map<Id, SPE_KPIDefinition__c> oldKPIMaps){
     Set<ID> KPIId = new Set<Id>();
     Set<ID> PubKPIId = new Set<Id>();
     Set<String> senderAddr = new Set<String>();
     List<String> lstSenderAddr = new List<String>();
     SPE_KPIDefinition__c oldKPI = new  SPE_KPIDefinition__c ();
     SPE_KPIDefinition__c oldKPItoUpdate = new  SPE_KPIDefinition__c ();
     

    for(SPE_KPIDefinition__c s : newKPIs){
        oldKPI = oldKPIMaps.get(s.Id);
        
        if(s.LifecycleStage__c!=oldKPI.LifecycleStage__c)
        {
           oldKPItoUpdate = oldKPIMaps.get(s.Id);
             if(s.LifecycleStage__c=='Pilot'){
               if(s.Master_KPI__c == null)
                 KPIId.add(s.Id);
               else
                 KPIId.add(s.Master_KPI__c);
        }
        
        if(s.LifecycleStage__c=='Published'){
            if(s.Master_KPI__c == null)
                PubKPIId.add(s.Id);
             else
                PubKPIId.add(s.Master_KPI__c);
               
           }
    
       }
    
    }   
   
   
        if(KPIId.size()>0){
         Boolean flag = false;
            List<SPE_KPIDefinition__c>  lstKPItoUpdate = [Select id,VerNumber__c,LifecycleStage__c,ownerID,Owner.Email from SPE_KPIDefinition__c where (id in :KPIId OR Master_KPI__c IN :KPIId) AND (LifecycleStage__c ='Published' OR LifecycleStage__c='Pilot') order by VerNumber__c DESC ];
            Set<ID> setMAPKPI = new Set<Id>();
            for(SPE_KPIDefinition__c s : lstKPItoUpdate){
                setMAPKPI.add(s.Id);
                senderAddr.add(s.Owner.Email);
             }
   
       if(lstKPItoUpdate!=null){
         SPE_KPIDefinition__c highestKPI = lstKPItoUpdate[0];
         List<SPE_SPEKPIMap__c>  lstKPIMap = [Select id,KPIDefinition__c,SPETemplate__c,OwnerID,Owner.Email from SPE_SPEKPIMap__c where KPIDefinition__c in :setMAPKPI AND UseLatestKPIVersion__c=TRUE and SPETemplate__r.Stage__c='Pilot'];
            if(lstKPIMap!=null){
                Map<Id,Id> mappofKPIidss= new map<id,id>();
                for(SPE_SPEKPIMap__c MapObj : lstKPIMap){
                 if(MapObj.KPIDefinition__c!=highestKPI.Id)
                    flag = true;
                    mappofKPIidss.put(MapObj.KPIDefinition__c,highestKPI.Id);
                    senderAddr.add(MapObj.Owner.Email);
                    
                }
            }
            lstSenderAddr.addAll(senderAddr);
             system.debug('flag in pilot'+flag);
           if(flag)
            sendEmail(lstSenderAddr,newKPIs);
            
            update lstKPIMap;
         }
     }   
  /*******update published SPE Template*****/
     
       if(PubKPIId.size()>0){
       Boolean flag = false;
        List<SPE_KPIDefinition__c>  lstKPItoUpdatePub = [Select id,VerNumber__c,LifecycleStage__c,ownerId,Owner.Email from SPE_KPIDefinition__c where (id in :PubKPIId OR Master_KPI__c IN :PubKPIId) AND LifecycleStage__c ='Published' order by VerNumber__c DESC ];
        Set<ID> setMAPKPIPub = new Set<Id>();
        for(SPE_KPIDefinition__c s : lstKPItoUpdatePub){
            setMAPKPIPub.add(s.Id);
            senderAddr.add(s.Owner.Email);
        }
    
       if(lstKPItoUpdatePub!=null){
        SPE_KPIDefinition__c highestKPI = lstKPItoUpdatePub[0];
        List<SPE_SPEKPIMap__c>  lstKPIMapPub = [Select id,KPIDefinition__c,SPETemplate__c,ownerID,Owner.Email from SPE_SPEKPIMap__c where KPIDefinition__c in :setMAPKPIPub AND UseLatestKPIVersion__c=TRUE and SPETemplate__r.Stage__c='Published'];
        Map<Id,Id> mappofKPIids= new map<id,id>();
        if(lstKPIMapPub!=null){            
            for(SPE_SPEKPIMap__c MapObj : lstKPIMapPub){
                if(MapObj.KPIDefinition__c!=highestKPI.Id)
                 flag = true;               
                  mappofKPIids.put(MapObj.KPIDefinition__c,highestKPI.Id);
                //MapObj.KPIDefinition__c = highestKPI.Id;
                
                senderAddr.add(MapObj.Owner.Email);
                
        
            }
         }
            lstSenderAddr.addAll(senderAddr);
            system.debug('flag in pub'+flag);
            if(flag)
            sendEmail(lstSenderAddr,newKPIs);
            update lstKPIMapPub;
        }     
     }   
     
     }
     
     public static void sendEmail(List<String> str,List<SPE_KPIDefinition__c> newKPIs){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(str);
        mail.setSubject('SPE Template has been updated');
        
        //******************Changes for Encryption*******************//
        //String messageBody = '<html><body>Hi,<br/<br/>Your Scoring template is impacted by the introduction of new version '+ newKPIs[0].version__c+' of KPI titled '+ newKPIs[0].name+'  in stage '+newKPIs[0].LifecycleStage__c+' <br/><br/>Please check the correctness of the Scoring threshold as soon as possible to ensure zero breakage in PLAN execution<br/><br/>Note – <br/>If the New KPI has the same scoring levels, the old scoring threshold defined by you are re-used for the new KPI version<br/>In case the New KPI are having different Scoring levels, you will see a blank scoring threshold for your due inputs please<br/><br/>With Regards,<br/> SPE Team</body>  </html>';
        String messageBody = '<html><body>Hi,<br/<br/>Your Scoring template is impacted by the introduction of new version '+ newKPIs[0].version__c+' of KPI titled '+ newKPIs[0].KPI_Title__c+'  in stage '+newKPIs[0].LifecycleStage__c+' <br/><br/>Please check the correctness of the Scoring threshold as soon as possible to ensure zero breakage in PLAN execution<br/><br/>Note – <br/>If the New KPI has the same scoring levels, the old scoring threshold defined by you are re-used for the new KPI version<br/>In case the New KPI are having different Scoring levels, you will see a blank scoring threshold for your due inputs please<br/><br/>With Regards,<br/> SPE Team</body>  </html>';
        //***************************END**************************//
        
        mail.setHtmlBody(messageBody); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
     
     }
 }