public with sharing class SPE_KPIDefinitionTrigger 
{
    public static void UpdatePIDefinition(List<SPE_KPIDefinition__c> newKPIs, Map<Id, SPE_KPIDefinition__c> oldKPIMaps)
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
    }


    public static void ConvertKPIValues(List<SPE_KPIDefinition__c> newKPIs, Map<Id, SPE_KPIDefinition__c> oldKPIMaps) 
    {
        List<SPE_KPIValue__c> toBeInsertedKPIValues = new List<SPE_KPIValue__c>();
        List<String> toBeDeletedKPIValues = new List<String>();
        
        String exec;
        
        Map<Id, Map<String, String>> kpiEnterpriseCommentsMap = new Map<Id, Map<String, String>>();
        
        List<SPE_KPIComments__c> toBeDeletedKPIComments = new List<SPE_KPIComments__c>();
        
        for (SPE_KPIComments__c kpiCom : [SELECT KPI__c, EnterpriseId__c, SurveyComments__c FROM SPE_KPIComments__c WHERE KPI__c In: oldKPIMaps.keySet() limit 9999])
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
        

        for (SPE_KPIDefinition__c kpi : newKPIs)
        {
            
            if ( (kpi.ScheduledDate__c != null && 
                  (kpi.ScheduledDate__c != oldKPIMaps.get(kpi.Id).ScheduledDate__c)
                 ) ||
                 (kpi.SchedulePeriod__c != null && 
                  (kpi.SchedulePeriod__c != oldKPIMaps.get(kpi.Id).SchedulePeriod__c)
                 )
                )
            {
            
                Map<String, Map<String, Decimal>> enterpriseScopeIndexValuesMap = new Map<String, Map<String, Decimal>>();
                
                Map<String, Decimal> indexConstantMap = new Map<String, Decimal>();
                
                // ******************** //
                
                Map<String, Map<String, Date>> enterpriseScopeIndexValuesDateMap = new Map<String, Map<String, Date>>();
                
                for (SPE_PITempValue__c piTemp : [SELECT Index__c, KPIDefinition__c, PIValue__c, MappingScope__c, IsConstant__c, ValueType__c 
                                                  FROM SPE_PITempValue__c 
                                                  WHERE KPIDefinition__c =: kpi.Id AND ValueType__c = :SPE_Constants.PI_DATEVALUETYPE limit 9999])
                {
                    Map<String, Date> indexValuesMap = new Map<String, Date>();
                        
                    if (enterpriseScopeIndexValuesDateMap.get(piTemp.MappingScope__c) != null )
                    {
                        indexValuesMap = enterpriseScopeIndexValuesDateMap.get(piTemp.MappingScope__c);
                    }
                    
                    indexValuesMap.put(piTemp.Index__c, Date.valueOf(piTemp.PIValue__c));
                    
                    enterpriseScopeIndexValuesDateMap.put(piTemp.MappingScope__c, indexValuesMap);
                }
                
                for (String scope : enterpriseScopeIndexValuesDateMap.keyset())
                {
                    List<Object> objectListActual = new List<Object>();
                    
                    Decimal valueActual = null;
                    
                    if (kpi.RPNExpression__c != null)
                    {
                        for (String exp: kpi.RPNExpression__c.split(','))
                        {
                            if (SPE_Utility.indexList.contains(exp))
                            {
                                Date piAggregate = null;
                                
                                if (enterpriseScopeIndexValuesDateMap.get(scope).get(exp) != null)
                                {
                                    piAggregate = enterpriseScopeIndexValuesDateMap.get(scope).get(exp);    
                                }
                                
                                objectListActual.add((Object) piAggregate);
                            }
                            if (SPE_Utility.operatorList.contains(exp))
                            {
                                objectListActual.add(exp);
                            } 
                        }
                        
                        valueActual = objectListActual.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculationDate(objectListActual);
                        
                        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c ();
                        kpiValue.KPIDefinition__c = kpi.Id;
                        
                        //**********Changes Done As Part of Encryption************************//
                            //kpiValue.EnterpriseId__c = scope.split(';')[0] == null ? null : scope.split(';')[0];
                            kpiValue.EnterpriseIDEncrypted__c = scope.split(';')[0] == null ? null : scope.split(';')[0];
                        //*************************End*****************************************//
                        kpiValue.BusinessLine__c  = scope.split(';')[1] == null ? null : scope.split(';')[1];
                        kpiValue.BusinessUnit__c = scope.split(';')[2] == null ? null : scope.split(';')[2];
                        kpiValue.Category__c = scope.split(';')[3] == null ? null : scope.split(';')[3];
                        kpiValue.CategoryGroup__c = scope.split(';')[4] == null ? null : scope.split(';')[4];
                        kpiValue.Cluster__c = scope.split(';')[5] == null ? null : scope.split(';')[5];
                        kpiValue.Country__c = scope.split(';')[6] == null ? null : scope.split(';')[6];
                        kpiValue.Region__c = scope.split(';')[7] == null ? null : scope.split(';')[7];
                        kpiValue.SubRegion__c = scope.split(';')[8] == null ? null : scope.split(';')[8];
                        kpiValue.Project__c = scope.split(';')[9] == null ? null : scope.split(';')[9];
                        kpiValue.Product__c = scope.split(';')[10] == null ? null : scope.split(';')[10];
                        kpiValue.ExecutionPeriod__c = scope.split(';')[11] == null ? null : scope.split(';')[11]; //(scope.split(';')[8] == null && Date.valueOf(scope.split(';')[8]) == null)  ? null : Date.valueOf(scope.split(';')[8]);
                        KpiValue.Period__c= kpi.Adhoc_Date__c;
                        kpiValue.KPIValue__c = valueActual;
                        kpiValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpi.Id) != null && kpiEnterpriseCommentsMap.get(kpi.Id).get(kpiValue.EnterpriseIDEncrypted__c) != null) ? kpiEnterpriseCommentsMap.get(kpi.Id).get(kpiValue.EnterpriseIDEncrypted__c) : '';
                       
                        toBeInsertedKPIValues.add (kpiValue);
                        
                        
                        toBeDeletedKPIValues.add(kpiValue.ExecutionPeriod__c);
                
                    }
                }
                
                
                for (SPE_PITempValue__c piTemp : [SELECT Index__c, KPIDefinition__c, PIValue__c, MappingScope__c, IsConstant__c, ValueType__c 
                                                  FROM SPE_PITempValue__c 
                                                  WHERE KPIDefinition__c =: kpi.Id AND
                                                        ValueType__c != :SPE_Constants.PI_DATEVALUETYPE limit 9999])
                {
                    if (piTemp.PIValue__c == null)
                    {
                        continue;
                    }
                    
                    if (piTemp.IsConstant__c)
                    {
                        indexConstantMap.put(piTemp.Index__c, Decimal.valueOf(piTemp.PIValue__c));
                    }
                    else
                    {
                        Map<String, Decimal> indexValuesMap = new Map<String, Decimal>();
                        
                        if (enterpriseScopeIndexValuesMap.get(piTemp.MappingScope__c) != null )
                        {
                            indexValuesMap = enterpriseScopeIndexValuesMap.get(piTemp.MappingScope__c);
                        }
                        
                        indexValuesMap.put(piTemp.Index__c, Decimal.valueOf(piTemp.PIValue__c));
                        
                        enterpriseScopeIndexValuesMap.put(piTemp.MappingScope__c, indexValuesMap);
                    }   
                    
                }
                
                for (String scope : enterpriseScopeIndexValuesMap.keyset())
                {
                    Boolean elseCriteriaWorks = false;
                    
                    // actual expression
                    List<Object> objectListActual = new List<Object>();
                    
                    Decimal valueActual = null;
                    Decimal valueElse = null;
                    
                    System.debug('-------------->'+kpi.RPNExpression__c);
                    
                    if (kpi.RPNExpression__c != null)
                    {
                        for (String exp: kpi.RPNExpression__c.split(','))
                        {
                            if (SPE_Utility.indexList.contains(exp))
                            { 
                                Decimal piAggregate = null;
                                
                                if (enterpriseScopeIndexValuesMap.get(scope).get(exp) != null)
                                {
                                    piAggregate = enterpriseScopeIndexValuesMap.get(scope).get(exp);    
                                }
                                if (indexConstantMap.get(exp) != null)
                                {
                                    piAggregate =  indexConstantMap.get(exp);
                                }
                                
                                objectListActual.add((Object) piAggregate);
                            }
                            
                            if (SPE_Utility.operatorList.contains(exp))
                            {
                                objectListActual.add(exp);
                            }
                        }
                    
                        valueActual = objectListActual.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual);
                    }
                    
                    if (kpi.RPNCondition1Expression__c != null &&
                        /*kpi.RPNCondition2Expression__c != null && */
                        kpi.RPNExpressionElse__c != null)
                    {
                        // condition 1 expression
                        List<Object> objectListCriteria1 = new List<Object>();
                        
                        Decimal valueCriteria1 = null;
                        
                        for (String exp: kpi.RPNCondition1Expression__c.split(','))
                        {
                            if (SPE_Utility.indexList.contains(exp))
                            { 
                                Decimal piAggregate = null;
                                
                                if (enterpriseScopeIndexValuesMap.get(scope).get(exp) != null)
                                {
                                    piAggregate = enterpriseScopeIndexValuesMap.get(scope).get(exp);    
                                }
                                if (indexConstantMap.get(exp) != null)
                                {
                                    piAggregate = indexConstantMap.get(exp);
                                }
                                
                                objectListCriteria1.add((Object) piAggregate);
                            }
                            else
                            {
                                objectListCriteria1.add(exp);
                            }
                        }
                    
                        valueCriteria1 = objectListCriteria1.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListCriteria1);
                        
                        // condition 2 expression
                        List<Object> objectListCriteria2 = new List<Object>();
                        
                        Decimal valueCriteria2 = null;
                        
                        if (kpi.RPNCondition2Expression__c != null)
                        {
                            for (String exp: kpi.RPNCondition2Expression__c.split(','))
                            {
                                if (SPE_Utility.indexList.contains(exp))
                                { 
                                    Decimal piAggregate = null;
                                    
                                    if (enterpriseScopeIndexValuesMap.get(scope).get(exp) != null)
                                    {
                                        piAggregate = enterpriseScopeIndexValuesMap.get(scope).get(exp);    
                                    }
                                    if (indexConstantMap.get(exp) != null)
                                    {
                                        piAggregate = indexConstantMap.get(exp);
                                    }
                                    
                                    objectListCriteria2.add((Object) piAggregate);
                                }
                                else
                                {
                                    objectListCriteria2.add(exp);
                                }
                            }
                        }
                    
                        valueCriteria2 = objectListCriteria2.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListCriteria2);
                        
                        // condition else expression
                        List<Object> objectListElse = new List<Object>();
                        
                        for (String exp: kpi.RPNExpressionElse__c.split(','))
                        {
                            if (SPE_Utility.indexList.contains(exp))
                            { 
                                Decimal piAggregate = null;
                                
                                if (enterpriseScopeIndexValuesMap.get(scope).get(exp) != null)
                                {
                                    piAggregate = enterpriseScopeIndexValuesMap.get(scope).get(exp);    
                                }
                                if (indexConstantMap.get(exp) != null)
                                {
                                    piAggregate = indexConstantMap.get(exp);
                                }
                                
                                objectListElse.add((Object) piAggregate);
                            }
                            else
                            {
                                objectListElse.add(exp);
                            }
                        }
                    
                        valueElse = objectListElse.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListElse);
                        
                        elseCriteriaWorks = SPE_ReversePolishAlgorithm.conditionComparision(valueCriteria1, valueCriteria2, kpi.RPNCondition__c);
                        
                    }
                    
                    
                    SPE_KPIValue__c kpiValue = new SPE_KPIValue__c ();
                    
                    kpiValue.KPIDefinition__c = kpi.Id;
                    //**********Changes Done As Part of Encryption************************//
                        //kpiValue.EnterpriseId__c = scope.split(';')[0] == null ? null : scope.split(';')[0];
                        kpiValue.EnterpriseIDEncrypted__c = scope.split(';')[0] == null ? null : scope.split(';')[0];
                    //*************************End*****************************************//
                    kpiValue.BusinessLine__c  = scope.split(';')[1] == null ? null : scope.split(';')[1];
                    kpiValue.BusinessUnit__c = scope.split(';')[2] == null ? null : scope.split(';')[2];
                    kpiValue.Category__c = scope.split(';')[3] == null ? null : scope.split(';')[3];
                    kpiValue.CategoryGroup__c = scope.split(';')[4] == null ? null : scope.split(';')[4];
                    kpiValue.Cluster__c = scope.split(';')[5] == null ? null : scope.split(';')[5];
                    kpiValue.Country__c = scope.split(';')[6] == null ? null : scope.split(';')[6];
                    kpiValue.Region__c = scope.split(';')[7] == null ? null : scope.split(';')[7];
                    kpiValue.SubRegion__c = scope.split(';')[8] == null ? null : scope.split(';')[8];
                    kpiValue.Project__c = scope.split(';')[9] == null ? null : scope.split(';')[9];
                    kpiValue.Product__c = scope.split(';')[10] == null ? null : scope.split(';')[10];
                    kpiValue.ExecutionPeriod__c = scope.split(';')[11] == null ? null : scope.split(';')[11]; //(scope.split(';')[8] == null && Date.valueOf(scope.split(';')[8]) == null)  ? null : Date.valueOf(scope.split(';')[8]);
                    KpiValue.Period__c= kpi.Adhoc_Date__c;
                    kpiValue.KPIValue__c = elseCriteriaWorks ? valueElse : valueActual;
                    kpiValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpi.Id) != null && kpiEnterpriseCommentsMap.get(kpi.Id).get(kpiValue.EnterpriseIDEncrypted__c) != null) ? kpiEnterpriseCommentsMap.get(kpi.Id).get(kpiValue.EnterpriseIDEncrypted__c) : '';


                    toBeInsertedKPIValues.add (kpiValue);
                    
                    
                    toBeDeletedKPIValues.add(kpiValue.ExecutionPeriod__c);
                    exec = kpiValue.ExecutionPeriod__c;
                }
            }
            
            delete [SELECT Id FROM SPE_KPIValue__c WHERE ExecutionPeriod__c In: toBeDeletedKPIValues AND KPIDefinition__c =: kpi.Id limit 9999];
            
           

            insert toBeInsertedKPIValues;
            
            if(toBeInsertedKPIValues.size()>0)
            {
            SPE_KPIStats__c stats= new SPE_KPIStats__c();
            stats.kpi__c = kpi.ID;
            stats.ExecutionPeriod__c=exec;
            stats.Records__c=toBeInsertedKPIValues.size();
            insert stats;
            }               
        }
        
       //  delete toBeDeletedKPIComments;

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
            
            for (SPE_KPIDefinition__c kpiObjUpdated: newKPIs) {
                dayKPINew = kpiObjUpdated.ScheduledDate__c.day();
                if (kpiObjUpdated.ScheduledDate__c!=NULL && (maxdayRelatedList > dayKPINew)) {
                    kpiObjUpdated.addError('PI Upload Due date is greater than Next Scheduled Date');
                }
            }      
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