global class SPE2PastTrckrExecBatch implements Database.Batchable<sObject>{
    global String query;
    global String scIdentifier;
    global SPE2PastTrckrExecBatch(String identifier){
        query = 'select Id,ScorecardGenerator__r.isAdhoc__c,Name,ScorecardGenerator__r.Aggregation_Period_Adhoc__c,Tracker_Identifier__c, DateOfExecution__c FROM SPE_ScorecardTracker__c Where Tracker_Identifier__c ='+'\''+identifier+'\'';
        scIdentifier = identifier;
        //system.now()+';'+userInfo.getUserId();                                                                        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        system.debug('query:12:'+query);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<sObject>scope){
        for(sobject obj :scope){
            SPE_ScorecardTracker__c trkr = (SPE_ScorecardTracker__c)obj;
            ApexPages.StandardController sc = new ApexPages.StandardController(trkr);
            SPE2_ScorecardTrackerExecutionExt trck = new SPE2_ScorecardTrackerExecutionExt(sc); 
            trck.fetchTrackers(scIdentifier,false);
        }        
    }
    global void finish(Database.BatchableContext BC){
        if(!Test.isRunningTest()){
            SPE2_AutoScorecardGenerate dtbatch= new SPE2_AutoScorecardGenerate(scIdentifier);
            database.executebatch(dtBatch,1);
        }
        //SPE2_ScorecardAutoGenerateValues dtbatch= new SPE2_ScorecardAutoGenerateValues(scIdentifier);
        //database.executebatch(dtBatch,1);
    }
}