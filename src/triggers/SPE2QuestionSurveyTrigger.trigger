trigger SPE2QuestionSurveyTrigger on SPE2_Question_Survey_Association__c (after insert,after update,before delete,after undelete) {
  if(Trigger.isBefore && Trigger.isDelete){
      Set<Id> oldsurveyId = new Set<Id>();
      Set<ID> deleteQASID = new Set<ID>();
      for(SPE2_Question_Survey_Association__c sc :trigger.old){
            deleteQASID.add(sc.ID);
            oldsurveyId.add(sc.Survey__c);          
      }
      List<SPE2_Survey_Question_Mapping__c> lsttoDelSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
      lsttoDelSurveyQuesMap = [Select Id,Supplier__c,PI_Data__c,Question_Bank__c,Survey__c from SPE2_Survey_Question_Mapping__c
                                 where Survey__c IN :oldsurveyId];                                
     if(lsttoDelSurveyQuesMap.size()>0){
        delete lsttoDelSurveyQuesMap;
     } 
     List<SPE2_Question_Survey_Association__c> lstSurveyQuesAssoc = new List<SPE2_Question_Survey_Association__c>();
     lstSurveyQuesAssoc = [Select Id,PIData__c,Question_Bank__c,Survey__c,ordernumber__c from SPE2_Question_Survey_Association__c
                             where Survey__c IN :oldsurveyId];
     
     Map<String,SPE2_Question_Survey_Association__c> QASMap =  new Map<String,SPE2_Question_Survey_Association__c>();
     for(SPE2_Question_Survey_Association__c sqa: lstSurveyQuesAssoc){
         if(!deleteQASID.contains(sqa.ID)){
             QASMap.put(sqa.ID,sqa);
         }
     }
     if(QASMap.size() > 0){     
         Map<Id,List<SPE2_Question_Survey_Association__c>>  mapSurveyQues= new Map<Id,List<SPE2_Question_Survey_Association__c>>();
         List<SPE2_Question_Survey_Association__c> lstTempquesAss;
         Set<Id> setSurveyId = new Set<Id>();
        //--------------Survey Assoc map------------//
            for(SPE2_Question_Survey_Association__c sq : QASMap.values()){
                if(!setSurveyId.contains(sq.Survey__c)){
                    lstTempquesAss = new List<SPE2_Question_Survey_Association__c>();
                    lstTempquesAss.add(sq);
                    mapSurveyQues.put(sq.Survey__c,lstTempquesAss);
                    setSurveyId.add(sq.Survey__c);
                
                }
                else{
                lstTempquesAss = mapSurveyQues.get(sq.Survey__c);
                lstTempquesAss.add(sq);
                mapSurveyQues.put(sq.Survey__c,lstTempquesAss);
                
                }
               
            }
            
            //------------------------------------------------
            
            system.debug('map of survey ques assoc'+mapSurveyQues+'size'+mapSurveyQues.size());
            List<SPE2_SurveySupplierMap__c> lstsupplier = new List<SPE2_SurveySupplierMap__c>();
            lstsupplier = [SELECT id,Supplier__c,SPE2_Survey__c from SPE2_SurveySupplierMap__c where SPE2_Survey__c IN :oldsurveyId];
            
            if(lstsupplier.size() > 0){
                system.debug('supplier is'+lstsupplier );
                Map<Id,List<SPE2_SurveySupplierMap__c>> mapSupplierSurvey = new Map<Id,List<SPE2_SurveySupplierMap__c>>();
                Set<Id> setSurveyIdSupp = new Set<Id>();
                List<SPE2_SurveySupplierMap__c> lstsuppliertemp = new List<SPE2_SurveySupplierMap__c>();
                for(SPE2_SurveySupplierMap__c supp : lstsupplier){
                   if(!setSurveyIdSupp.contains(supp.SPE2_Survey__c)){
                        lstsuppliertemp = new List<SPE2_SurveySupplierMap__c>();
                        lstsuppliertemp.add(supp);
                        mapSupplierSurvey.put(supp.SPE2_Survey__c,lstsuppliertemp);
                        setSurveyIdSupp.add(supp.SPE2_Survey__c);
                    
                    }
                    else{
                    lstsuppliertemp = mapSupplierSurvey.get(supp.SPE2_Survey__c);
                    lstsuppliertemp.add(supp);
                    mapSupplierSurvey.put(supp.SPE2_Survey__c,lstsuppliertemp);
                    
                    }
                }
                
                List<SPE2_Survey_Question_Mapping__c> lsttoInsertSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
                for(Id supp : mapSupplierSurvey.keyset()){
                    for(SPE2_SurveySupplierMap__c quesSurv : mapSupplierSurvey.get(supp)){
                        for(SPE2_Question_Survey_Association__c sc : mapSurveyQues.get(supp) ){
                            SPE2_Survey_Question_Mapping__c quesMapObj = new SPE2_Survey_Question_Mapping__c();
                            quesMapObj.Supplier__c = quesSurv.Supplier__c;
                            quesMapObj.Survey__c = supp;
                            quesMapObj.PI_Data__c = sc.PIData__c;
                            quesMapObj.Question_Bank__c = sc.Question_Bank__c;
                            quesMapObj.Is_Active__c = true;
                            quesMapObj.ordernumber__c =sc.ordernumber__c;
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
        for(SPE2_Question_Survey_Association__c sc : trigger.new){
            surveyId.add(sc.Survey__c);          
        }
        system.debug('survey Id'+surveyId);
        List<SPE2_Survey_Question_Mapping__c> lsttoDelSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
        lsttoDelSurveyQuesMap = [Select Id,Supplier__c,PI_Data__c,Question_Bank__c,Survey__c from SPE2_Survey_Question_Mapping__c
                                where Survey__c in :surveyId];
                                
        system.debug('listto del --'+lsttoDelSurveyQuesMap);
        if(lsttoDelSurveyQuesMap.size()>0){
            delete lsttoDelSurveyQuesMap;
        }
        
        List<SPE2_Question_Survey_Association__c> lstSurveyQuesAssoc = new List<SPE2_Question_Survey_Association__c>();
        lstSurveyQuesAssoc = [Select Id,PIData__c,Question_Bank__c,Survey__c,ordernumber__c from SPE2_Question_Survey_Association__c
                             where Survey__c in :surveyId];
         List<Id> lstSurvey = new  List<Id>();                 
        if(lstSurveyQuesAssoc.size() == 0){
            for(SPE2_Question_Survey_Association__c sc : trigger.new)
            lstSurvey.add(sc.Survey__c);
            Integer i;
            for(Id surv : lstSurvey ){
             i = 0;
            for(SPE2_Question_Survey_Association__c sq : trigger.new){
                if(sq.Survey__c == surv){
                sq.ordernumber__c = i;
                i++;
                }
            }
           } 
        }                     
        Map<Id,List<SPE2_Question_Survey_Association__c>>  mapSurveyQues= new Map<Id,List<SPE2_Question_Survey_Association__c>>();
        Map<Id,List<Decimal>>  mapSurveyOrder = new Map<Id,List<Decimal>>();
        List<SPE2_Question_Survey_Association__c> lstTempquesAss;
        Set<Id> setSurveyId = new Set<Id>();
        List<Decimal> lstOrder;
        //--------------Survey Assoc map------------
        for(SPE2_Question_Survey_Association__c sq : lstSurveyQuesAssoc){
            if(!setSurveyId.contains(sq.Survey__c)){
                lstTempquesAss = new List<SPE2_Question_Survey_Association__c>();
                lstOrder = new List<Decimal>();
                lstOrder.add(sq.ordernumber__c);
                lstTempquesAss.add(sq);
                mapSurveyQues.put(sq.Survey__c,lstTempquesAss);
                mapSurveyOrder.put(sq.Survey__c,lstOrder);
                setSurveyId.add(sq.Survey__c);
            
            }
            else{
            lstTempquesAss = mapSurveyQues.get(sq.Survey__c);
            lstOrder =  mapSurveyOrder.get(sq.Survey__c);
            lstTempquesAss.add(sq);
            lstOrder.add(sq.ordernumber__c);
            mapSurveyQues.put(sq.Survey__c,lstTempquesAss);
            mapSurveyOrder.put(sq.Survey__c,lstOrder);
            
            }
           
        }
        
        //------------------------------------------------
        
        system.debug('map of survey ques assoc'+mapSurveyQues+'size'+mapSurveyQues.size());
        List<SPE2_SurveySupplierMap__c> lstsupplier = new List<SPE2_SurveySupplierMap__c>();
        lstsupplier = [SELECT id,Supplier__c,SPE2_Survey__c from SPE2_SurveySupplierMap__c where SPE2_Survey__c in :surveyId];
        
        if(lstsupplier.size() > 0){
            system.debug('supplier is'+lstsupplier );
            Map<Id,List<SPE2_SurveySupplierMap__c>> mapSupplierSurvey = new Map<Id,List<SPE2_SurveySupplierMap__c>>();
            Set<Id> setSurveyIdSupp = new Set<Id>();
            List<SPE2_SurveySupplierMap__c> lstsuppliertemp = new List<SPE2_SurveySupplierMap__c>();
            for(SPE2_SurveySupplierMap__c supp : lstsupplier){
               if(!setSurveyIdSupp.contains(supp.SPE2_Survey__c)){
                    lstsuppliertemp = new List<SPE2_SurveySupplierMap__c>();
                    lstsuppliertemp.add(supp);
                    mapSupplierSurvey.put(supp.SPE2_Survey__c,lstsuppliertemp);
                    setSurveyIdSupp.add(supp.SPE2_Survey__c);
                
                }
                else{
                lstsuppliertemp = mapSupplierSurvey.get(supp.SPE2_Survey__c);
                lstsuppliertemp.add(supp);
                mapSupplierSurvey.put(supp.SPE2_Survey__c,lstsuppliertemp);
                
                }
            }
            
            List<SPE2_Survey_Question_Mapping__c> lsttoInsertSurveyQuesMap = new List<SPE2_Survey_Question_Mapping__c>();
            for(Id supp : mapSupplierSurvey.keyset()){
                for(SPE2_SurveySupplierMap__c quesSurv : mapSupplierSurvey.get(supp)){
                    for(SPE2_Question_Survey_Association__c sc : mapSurveyQues.get(supp) ){
                        SPE2_Survey_Question_Mapping__c quesMapObj = new SPE2_Survey_Question_Mapping__c();
                        quesMapObj.Supplier__c = quesSurv.Supplier__c;
                        quesMapObj.Survey__c = supp;
                        quesMapObj.PI_Data__c = sc.PIData__c;
                        quesMapObj.Question_Bank__c = sc.Question_Bank__c;
                        quesMapObj.Is_Active__c = true;
                        quesMapObj.ordernumber__c =sc.ordernumber__c;
                        lsttoInsertSurveyQuesMap.add(quesMapObj);
                    }
                }
            }
            if(lsttoInsertSurveyQuesMap.size()>0)
                insert lsttoInsertSurveyQuesMap;
        }
    
    }
    
    

}