trigger SPE2SupplierSurveyTrigger on SPE2_SurveySupplierMap__c (after insert,after update,before delete,after undelete) {

  if(Trigger.isBefore && Trigger.isDelete){
      Set<Id> oldsurveyId = new Set<Id>();
      Set<ID> deleteSuppID = new Set<ID>();
      for(SPE2_SurveySupplierMap__c sc :trigger.old){
            deleteSuppID.add(sc.ID);
            oldsurveyId.add(sc.SPE2_Survey__c);          
      }
      List<SPE2_Survey_Question_Mapping__c> lsttoDelSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
      lsttoDelSurveyQuesMap = [Select Id,Supplier__c,PI_Data__c,Question_Bank__c,Survey__c from SPE2_Survey_Question_Mapping__c
                                 where Survey__c IN :oldsurveyId];                                
     if(lsttoDelSurveyQuesMap.size()>0){
        delete lsttoDelSurveyQuesMap;
     } 
     List<SPE2_SurveySupplierMap__c> lstSurveySupp = new List<SPE2_SurveySupplierMap__c>();
     lstSurveySupp = [SELECT id,Supplier__c,SPE2_Survey__c from SPE2_SurveySupplierMap__c where SPE2_Survey__c IN :oldsurveyId];
     
     Map<String,SPE2_SurveySupplierMap__c> SuppMap =  new Map<String,SPE2_SurveySupplierMap__c>();
     for(SPE2_SurveySupplierMap__c supp: lstSurveySupp){
         if(!deleteSuppID.contains(supp.ID)){
             SuppMap.put(supp.ID,supp);
         }
     }
     
     if(SuppMap.size() > 0){     
         Map<Id,List<SPE2_SurveySupplierMap__c>>  mapSurveySupp= new Map<Id,List<SPE2_SurveySupplierMap__c>>();
            List<SPE2_SurveySupplierMap__c> lstTempsurveySupp;
            Set<Id> setSurveyId = new Set<Id>();
            //--------------Survey Assoc map------------
            for(SPE2_SurveySupplierMap__c supp : SuppMap.Values()){
                if(!setSurveyId.contains(supp.SPE2_Survey__c )){
                    lstTempsurveySupp = new List<SPE2_SurveySupplierMap__c>();
                    lstTempsurveySupp.add(supp);
                    mapSurveySupp.put(supp.SPE2_Survey__c ,lstTempsurveySupp);
                    setSurveyId.add(supp.SPE2_Survey__c);
                
                }
                else{
                lstTempsurveySupp = mapSurveySupp.get(supp.SPE2_Survey__c );
                lstTempsurveySupp.add(supp);
                mapSurveySupp.put(supp.SPE2_Survey__c,lstTempsurveySupp);
                
                }
               
            }
            
            //------------------------------------------------
            
            List<SPE2_Question_Survey_Association__c> lstQuesAss = new List<SPE2_Question_Survey_Association__c>();
            lstQuesAss = [Select Id,PIData__c,Question_Bank__c,Survey__c,Supplier__c,ordernumber__c from SPE2_Question_Survey_Association__c
                            where Survey__c in :oldsurveyId];
            
            if(lstQuesAss.size() > 0){
                system.debug('supplier is'+lstQuesAss);
                Map<Id,List<SPE2_Question_Survey_Association__c>> mapQuesAss = new Map<Id,List<SPE2_Question_Survey_Association__c>>();
                Set<Id> setSurveyIdSupp = new Set<Id>();
                List<SPE2_Question_Survey_Association__c> lstQuesAsstemp = new List<SPE2_Question_Survey_Association__c>();
                for(SPE2_Question_Survey_Association__c sqs : lstQuesAss){
                   if(!setSurveyIdSupp.contains(sqs.Survey__c)){
                        lstQuesAsstemp = new List<SPE2_Question_Survey_Association__c>();
                        lstQuesAsstemp.add(sqs);
                        mapQuesAss.put(sqs.Survey__c,lstQuesAsstemp);
                        setSurveyIdSupp.add(sqs.Survey__c);
                    
                    }
                    else{
                        lstQuesAsstemp = mapQuesAss.get(sqs.Survey__c);
                        lstQuesAsstemp.add(sqs);
                        mapQuesAss.put(sqs.Survey__c,lstQuesAsstemp);          
                    }
                }
                
                List<SPE2_Survey_Question_Mapping__c> lsttoInsertSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
                for(Id supp : mapQuesAss.keyset()){
                    for(SPE2_Question_Survey_Association__c  quesSurv : mapQuesAss.get(supp)){
                        for(SPE2_SurveySupplierMap__c  sc :mapSurveySupp.get(supp)){
                            SPE2_Survey_Question_Mapping__c quesMapObj = new SPE2_Survey_Question_Mapping__c();
                            quesMapObj.Supplier__c = sc.Supplier__c;
                            quesMapObj.Survey__c = supp;
                            quesMapObj.PI_Data__c = quesSurv.PIData__c;
                            quesMapObj.Question_Bank__c = quesSurv.Question_Bank__c;
                            quesMapObj.Is_Active__c = true;
                            quesMapObj.ordernumber__c = quesSurv.ordernumber__c;
                            lsttoInsertSurveyQuesMap.add(quesMapObj);
                        }
                    }
                }
                if(lsttoInsertSurveyQuesMap.size()>0)
                    insert lsttoInsertSurveyQuesMap;
            }    
      }                                   
 }
                 
  if(trigger.isInsert || trigger.isUpdate){
        Set<Id> surveyId = new Set<Id>();
        for(SPE2_SurveySupplierMap__c smap : trigger.new){
            surveyId.add(smap.SPE2_Survey__c);          
        }
        system.debug('survey Id'+surveyId);
            
        List<SPE2_Survey_Question_Mapping__c> lsttoDelSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
        lsttoDelSurveyQuesMap = [Select Id,Supplier__c,PI_Data__c,Question_Bank__c,Survey__c from SPE2_Survey_Question_Mapping__c
                                where Survey__c IN :surveyId];
                                
        system.debug('listto del --'+lsttoDelSurveyQuesMap);
        if(lsttoDelSurveyQuesMap.size()>0){
            delete lsttoDelSurveyQuesMap;
        }
        
        List<SPE2_SurveySupplierMap__c> lstSurveysuppMap = new List<SPE2_SurveySupplierMap__c>();
        lstSurveysuppMap = [SELECT id,Supplier__c,SPE2_Survey__c from SPE2_SurveySupplierMap__c where SPE2_Survey__c IN :surveyId];

        Map<Id,List<SPE2_SurveySupplierMap__c>>  mapSurveySupp= new Map<Id,List<SPE2_SurveySupplierMap__c>>();
        List<SPE2_SurveySupplierMap__c> lstTempsurveySupp;
        Set<Id> setSurveyId = new Set<Id>();
        //--------------Survey Assoc map------------
        for(SPE2_SurveySupplierMap__c supp : lstSurveysuppMap){
            if(!setSurveyId.contains(supp.SPE2_Survey__c )){
                lstTempsurveySupp = new List<SPE2_SurveySupplierMap__c>();
                lstTempsurveySupp.add(supp);
                mapSurveySupp.put(supp.SPE2_Survey__c ,lstTempsurveySupp);
                setSurveyId.add(supp.SPE2_Survey__c);
            
            }
            else{
            lstTempsurveySupp = mapSurveySupp.get(supp.SPE2_Survey__c );
            lstTempsurveySupp.add(supp);
            mapSurveySupp.put(supp.SPE2_Survey__c,lstTempsurveySupp);
            
            }
           
        }
        
        //------------------------------------------------
        
        List<SPE2_Question_Survey_Association__c> lstQuesAss = new List<SPE2_Question_Survey_Association__c>();
        lstQuesAss = [Select Id,PIData__c,Question_Bank__c,Survey__c,Supplier__c,ordernumber__c from SPE2_Question_Survey_Association__c
                        where Survey__c IN :surveyId];
        
        if(lstQuesAss.size() > 0){
            system.debug('supplier is'+lstQuesAss);
            Map<Id,List<SPE2_Question_Survey_Association__c>> mapQuesAss = new Map<Id,List<SPE2_Question_Survey_Association__c>>();
            Set<Id> setSurveyIdSupp = new Set<Id>();
            List<SPE2_Question_Survey_Association__c> lstQuesAsstemp = new List<SPE2_Question_Survey_Association__c>();
            for(SPE2_Question_Survey_Association__c sqs : lstQuesAss){
               if(!setSurveyIdSupp.contains(sqs.Survey__c)){
                    lstQuesAsstemp = new List<SPE2_Question_Survey_Association__c>();
                    lstQuesAsstemp.add(sqs);
                    mapQuesAss.put(sqs.Survey__c,lstQuesAsstemp);
                    setSurveyIdSupp.add(sqs.Survey__c);
                
                }
                else{
                    lstQuesAsstemp = mapQuesAss.get(sqs.Survey__c);
                    lstQuesAsstemp.add(sqs);
                    mapQuesAss.put(sqs.Survey__c,lstQuesAsstemp);          
                }
            }
            
            List<SPE2_Survey_Question_Mapping__c> lsttoInsertSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
            for(Id supp : mapQuesAss.keyset()){
                for(SPE2_Question_Survey_Association__c  quesSurv : mapQuesAss.get(supp)){
                    for(SPE2_SurveySupplierMap__c  sc :mapSurveySupp.get(supp)){
                        SPE2_Survey_Question_Mapping__c quesMapObj = new SPE2_Survey_Question_Mapping__c();
                        quesMapObj.Supplier__c = sc.Supplier__c;
                        quesMapObj.Survey__c = supp;
                        quesMapObj.PI_Data__c = quesSurv.PIData__c;
                        quesMapObj.Question_Bank__c = quesSurv.Question_Bank__c;
                        quesMapObj.Is_Active__c = true;
                        quesMapObj.ordernumber__c = quesSurv.ordernumber__c;
                        lsttoInsertSurveyQuesMap.add(quesMapObj);
                    }
                }
            }
            if(lsttoInsertSurveyQuesMap.size()>0)
                insert lsttoInsertSurveyQuesMap;
        }
    
    }
    
    

}