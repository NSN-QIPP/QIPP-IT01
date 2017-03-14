global class SPE2PastSPETrckrExecBatch implements Database.Batchable<sObject>{
    global String query;
    global String trkIdentifier;      
    global SPE2PastSPETrckrExecBatch(String identifier){
        this.trkIdentifier = identifier;
        query = 'select Id,Name,Tracker_Identifier__c, DateOfExecution__c FROM SPE_SPETracker__c Where Tracker_Identifier__c ='+'\''+identifier+'\'';
                                                                                
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<sObject>scope){
        for(sobject obj :scope){
            SPE_SPETracker__c trkr = (SPE_SPETracker__c)obj;
            ApexPages.StandardController sc = new ApexPages.StandardController(trkr);
            SPE_TrackerExecutionExt trck = new SPE_TrackerExecutionExt(sc); 
            SPE_TrackerExecutionExt.DeleteExistingTrackerValues(obj.Id);
            SPE_TrackerExecutionExt.DeleteExistingTrackerScores(obj.Id);
        }
        
    }
    global void finish(Database.BatchableContext BC){
        if(!Test.isRunningTest()){
            SPE2_SPEAutoTrackerBatch b = new SPE2_SPEAutoTrackerBatch(trkIdentifier);
            database.executeBatch(b,1);
        }
    }
}