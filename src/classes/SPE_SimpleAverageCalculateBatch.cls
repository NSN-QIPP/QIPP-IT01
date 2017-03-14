global class SPE_SimpleAverageCalculateBatch implements Database.Batchable<sObject>{
    global String query;
    global List<SPE_SPETracker__c> speTrackerList;
    global String aggrType;
    global Map<String,List<decimal>> speTrackerToWeigtage = new Map<String,List<decimal>>();
    global Map<String,decimal> trackerToWeightageSum;
    global Id ParamId;
    //global Set<String> spetrackers = new Set<String>();
    global SPE_SimpleAverageCalculateBatch(String reportparamId){
        paramId = reportparamId;
        query = 'SELECT Score__c,SPE_Report_Parameter__c,SPE_Tracker__c,SPE_Tracker__r.BusinessLine__c,SPE_Tracker__r.BusinessUnit__c,SPE_Tracker__r.Product__c,SPE_Tracker__r.Category__c,SPE_Tracker__r.CategoryGroup__c,SPE_Tracker__r.CategoryCluster__c,SPE_Tracker__r.Project__c,SPE_Tracker__r.Region__c,SPE_Tracker__r.SubRegion__c,SPE_Tracker__r.Country__c,Supplier__c,Tracker_Score__c,Weight__c FROM SPE_Scorecard_Report__c WHERE SPE_Report_Parameter__c ='+'\''+ParamId+'\''; 
        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator(query);        
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){ 
        Map<String,decimal> trackerToWeightage = new Map<String,decimal>();
        List <SPE_Scorecard_Report__c> sReportList = new list<SPE_Scorecard_Report__c>();
        for(sobject obj :scope){
            SPE_Scorecard_Report__c rObj = (SPE_Scorecard_Report__c)obj;
               
            rObj.Weight__c = 1;
            sReportList.add(rObj);
        }
        update sReportList;
        System.debug('ANVCD**'+trackerToWeightage);
    }
    
    global void finish(Database.BatchableContext BC){
       //SPE_ScorecardReportupdateFinalBatch finalbatch = new SPE_ScorecardReportupdateFinalBatch(trackerToWeightageSum,ParamId);
       //database.executeBatch(finalbatch,100);
    }
}