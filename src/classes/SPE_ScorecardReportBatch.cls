global class SPE_ScorecardReportBatch implements Database.Batchable<sObject>{

    global String query;
    global Id reportParamId;
    global String aggregationFlag;
    global Set<String> spetrackerIds;
    global List<SPE_SPETracker__c> speTrackerList;
    global SPE_Report_Parameter__c reportParam = new SPE_Report_Parameter__c();
    global Map<String,List<decimal>> speTrackerToWeigtage = new Map<String,List<decimal>>();
    global Map<String,decimal> trackerToWeightageSum = new Map<String,decimal>();
  
    global SPE_ScorecardReportBatch(SPE_Report_Parameter__c reportParamObj){
   
       if(reportParamObj.Aggregation_Type__c==Label.SPE_SimpleAverage){
           aggregationFlag = 'simpleavg';
       }    
       if( reportParamObj.Aggregation_Type__c==Label.SPE_SpendAverage){
             aggregationFlag = 'spend';
       }
       if( reportParamObj.Aggregation_Type__c==Label.SPE_SpendVolume){
             aggregationFlag = 'volume';
       }
       if( reportParamObj.Aggregation_Type__c==Label.SPE_RulesDriven){
             aggregationFlag = 'rulesDriven';
       }
        reportParam = reportParamObj;
    reportParamId = reportParamObj.Id;
    query='SELECT Score__c,SPEScore__c,Supplier__c,SPETracker__c FROM SPE_TrackerScore__c';
 
    if(!query.contains( ' where' ) && reportParamObj.Region__c!='All Markets'){
        query +=' where ' + ' SPETracker__r.Region__c='+'\''+reportParamObj.Region__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Region__c!='All Markets'){
        query +=' AND' + ' SPETracker__r.Region__c='+'\''+reportParamObj.Region__c+'\'';
    }
    //-------Market ends----
    
    if(!query.contains( ' where' ) && reportParamObj.SubRegion__c!='All Market Units'){
        query +=' where ' + ' SPETracker__r.SubRegion__c='+'\''+reportParamObj.Region__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.SubRegion__c!='All Market Units'){
        query +=' AND' + ' SPETracker__r.SubRegion__c='+'\''+reportParamObj.SubRegion__c+'\'';
    }
    //------Market unit ends-----
    
     if(!query.contains( ' where' ) && reportParamObj.Country__c!='All Countries'){
        query +=' where ' + ' SPETracker__r.Country__c='+'\''+reportParamObj.Region__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Country__c!='All Countries'){
        query +=' AND' + ' SPETracker__r.Country__c='+'\''+reportParamObj.Country__c+'\'';
    }
    
    //------Country ends------
    
     if(!query.contains( ' where' ) && reportParamObj.Project__c!='All Projects'){
        query +=' where ' + ' SPETracker__r.Project__c='+'\''+reportParamObj.Project__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Project__c!='All Projects'){
        query +=' AND' + ' SPETracker__r.Project__c='+'\''+reportParamObj.Project__c+'\'';
    }
    
    //----------Project Ends-----
    
     if(!query.contains( ' where' ) && reportParamObj.CategoryCluster__c!='All Category Areas'){
        query +=' where ' + ' SPETracker__r.CategoryCluster__c='+'\''+reportParamObj.CategoryCluster__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.CategoryCluster__c!='All Category Areas'){
        query +=' AND' + ' SPETracker__r.CategoryCluster__c='+'\''+reportParamObj.CategoryCluster__c+'\'';
    }
    
    //-----------category area ends-----------
    
    if(!query.contains( ' where' ) && reportParamObj.Category_Group__c!='All Category Groups'){
        query +=' where ' + ' SPETracker__r.CategoryGroup__c='+'\''+reportParamObj.Category_Group__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Category_Group__c!='All Category Groups'){
        query +=' AND' + ' SPETracker__r.CategoryGroup__c='+'\''+reportParamObj.Category_Group__c+'\'';
    }
    
    //------------category group ends----
    
     
    if(!query.contains( ' where' ) && reportParamObj.Category__c!='All Categories'){
        query +=' where ' + ' SPETracker__r.Category__c='+'\''+reportParamObj.Category__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Category__c!='All Categories'){
        query +=' AND' + ' SPETracker__r.Category__c='+'\''+reportParamObj.Category__c+'\'';
    }
    
    //--------category ends-----
    
     if(!query.contains( ' where' ) && reportParamObj.Business_Unit__c!='All Business Units'){
        query +=' where ' + ' SPETracker__r.BusinessUnit__c='+'\''+reportParamObj.Business_Unit__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Business_Unit__c!='All Business Units'){
        query +=' AND' + ' SPETracker__r.BusinessUnit__c='+'\''+reportParamObj.Business_Unit__c+'\'';
    }
    
    //-----business unit ends-----
     if(!query.contains( ' where' ) && reportParamObj.Business_Line__c!='All Business Lines'){
        query +=' where ' + ' SPETracker__r.BusinessLine__c='+'\''+reportParamObj.Business_Line__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Business_Line__c!='All Business Lines'){
        query +=' AND' + ' SPETracker__r.BusinessLine__c='+'\''+reportParamObj.Business_Line__c+'\'';
    }
    
    //-------business line ends-----
    
    if(!query.contains( ' where' ) && reportParamObj.Product__c!='All Products'){
        query +=' where ' + ' SPETracker__r.Product__c='+'\''+reportParamObj.Product__c+'\'';
    }
    else if(query.contains( ' where' ) && reportParamObj.Product__c!='All Products'){
        query +=' AND' + ' SPETracker__r.Product__c='+'\''+reportParamObj.Product__c+'\'';
    }
    
    
    
    //-------product ends----
    if(!query.contains( ' where' )){ 
        query += ' where '+ 'SPEScore__c=true';
    }
    else if(query.contains( ' where' )){
         query += ' And '+ 'SPEScore__c=true';
    }
    
     if(!query.contains( ' where' )){ 
        query += ' where '+' Supplier__c!=null';
     }
     else if(query.contains( ' where' )){
          query += ' AND'+' Supplier__c!=null';
     }
    
     // period starts here
     Date startDate =  reportParamObj.Start_Date__c.addMonths(1);
     Date endDate =  reportParamObj.end_Date__c.addMonths(1);
     if(!query.contains( ' where' ) && startDate != null && endDate != null){ 
        query += ' where '+' SPETracker__r.DateOfExecution__c >='+string.valueOf(startDate) + ' AND SPETracker__r.DateOfExecution__c <='+string.valueOf(endDate);
     }
     else if(query.contains( ' where' ) && startDate != null && endDate != null){
          //query += ' AND'+' Supplier__c!=null';
          query += ' AND'+' SPETracker__r.DateOfExecution__c >='+string.valueOf(startDate) + ' AND SPETracker__r.DateOfExecution__c <='+string.valueOf(endDate);
     } 
     
   }
   

    global Database.QueryLocator start(Database.BatchableContext BC){
    
    system.debug('query is'+query);
    system.debug('result is--'+Database.getQueryLocator(query));
      return Database.getQueryLocator(query);

    }     

     global void execute(Database.BatchableContext BC, List<sObject>scope){   
         System.debug('speTrackerToWeigtage***');
         spetrackerIds  = new Set<String>();
         List<SPE_Scorecard_Report__c>  lstsc = new List<SPE_Scorecard_Report__c>();
         
         for(SObject obj:scope){
             SPE_TrackerScore__c ts = (SPE_TrackerScore__c)obj;
             
             lstsc.add(new SPE_Scorecard_Report__c(score__c=ts.Score__c,SPE_Score__c=ts.SPEScore__c,SPE_Report_Parameter__c=reportParamId,Supplier__c=ts.Supplier__c,
             Tracker_Score__c =ts.Id,SPE_Tracker__c = ts.SPETracker__c ));
             
             spetrackerIds.add(ts.SPETracker__c);
             
         }
         
         insert lstsc;
         
        
     }
 
 
      global void finish(Database.BatchableContext BC){
          if(aggregationFlag == 'spend'){
              SPE_SpendCalculateBatch spendbatch = new SPE_SpendCalculateBatch(reportParamId);
              database.executebatch(spendbatch,90); 
          }  
          
          if(aggregationFlag == 'volume'){
              SPE_VolumeCalculateBatch volumeBatch = new SPE_VolumeCalculateBatch(reportParamId);
              database.executebatch(volumeBatch,90); 
          }
          if(aggregationFlag == 'simpleavg'){
              SPE_SimpleAverageCalculateBatch simpleavgBatch = new SPE_SimpleAverageCalculateBatch (reportParamId);
              database.executebatch(simpleavgBatch,90); 
          }
          if(aggregationFlag == 'rulesDriven'){
              List<SPE_BWRuleConfigurator__c> BWconfigs = new List<SPE_BWRuleConfigurator__c>();
              BWconfigs = [Select Id,AveragingLogic__c,Category__c,CategoryArea__c,CategoryGroup__c,Nego_Responsible__c,
                           Market__c,Market_Unit__c,Project__c,Country__c 
                          From SPE_BWRuleConfigurator__c
                          Where CategoryArea__c =: reportParam.CategoryCluster__c AND CategoryGroup__c =: reportParam.Category_Group__c
                          AND Category__c =: reportParam.Category__c AND Market__c =: reportParam.Region__c AND Market_Unit__c =: reportParam.SubRegion__c
                          AND Project__c =: reportParam.Project__c AND Country__c =: reportParam.Country__c];
                          
              if(BWconfigs[0].CategoryArea__c == reportParam.CategoryCluster__c && BWconfigs[0].CategoryGroup__c == reportParam.Category_Group__c 
                 && BWconfigs[0].Category__c == reportParam.Category__c && BWconfigs[0].Market__c == reportParam.Region__c && BWconfigs[0].Market_Unit__c == reportParam.SubRegion__c
                 && BWconfigs[0].Project__c == reportParam.Project__c && BWconfigs[0].Country__c == reportParam.Country__c){
                  
                  calculateWeight(BWconfigs[0].AveragingLogic__c,BWconfigs[0].Nego_Responsible__c);
              
              }
              else{  
                    
                    calculateWeight('Simple Average',BWconfigs[0].Nego_Responsible__c);
              }
              
          }
          
      }
       global void calculateWeight(String avgLogic, String negoResponsible){
          if(avgLogic == Label.SPE_SimpleAverage){
              system.debug('enter at simple');
              SPE_SimpleAverageCalculateBatch simpleavgBatch = new SPE_SimpleAverageCalculateBatch (reportParamId);
              database.executebatch(simpleavgBatch,90);
          }
          if(avgLogic == Label.SPE_SpendAverage){
              system.debug('enter at spend');
              SPE_SpendCalculateBatch spendbatch = new SPE_SpendCalculateBatch(reportParamId);
              database.executebatch(spendbatch,90);
          }
          if(avgLogic == Label.SPE_SpendVolume){
              system.debug('enter at volume');
              SPE_VolumeCalculateBatch volumeBatch = new SPE_VolumeCalculateBatch(reportParamId);
              database.executebatch(volumeBatch,90); 
          }
          if(avgLogic == Label.SPE_HybridLogic){
              system.debug('enter at hybrid::'+negoResponsible);
              SPEReportHybridLogic hbridLogic = new SPEReportHybridLogic();
              hbridLogic.hybridLogicCalc(reportParamId,negoResponsible);
              
          }
          
       }
       
 }