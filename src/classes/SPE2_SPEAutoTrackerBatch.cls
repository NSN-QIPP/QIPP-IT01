global class SPE2_SPEAutoTrackerBatch implements Database.Batchable<sObject>{
    global String spePlanId;
    global List<SPE_SPETracker__c> trckrList;
    global String trkToPlanIdentifier;
    public SPE2_SPEAutoTrackerBatch (String identifier){
        trckrList = new List<SPE_SPETracker__c>();
        trckrList = [select Id,Name,SPEPlan__c FROM SPE_SPETracker__c Where Tracker_Identifier__c =: identifier];
        spePlanId = trckrList[0].SPEPlan__c;      
        trkToPlanIdentifier = system.Now()+';'+userInfo.getUserId();          
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){             
        String query = 'SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c,SPEPlan__c FROM SPE_SPEPlanSupplierMap__c WHERE SPEPlan__c =:spePlanId';        
        system.debug('query::'+query);
        return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext BC, list<SPE_SPEPlanSupplierMap__c> scope){
        List<SPE_SupplierTracker__c> suppToTrackers = new List<SPE_SupplierTracker__c>();
        for(SPE_SPEPlanSupplierMap__c s :scope){
            for(SPE_SPETracker__c tk :trckrList){
                suppToTrackers.add(new SPE_SupplierTracker__c(Plan_Supplier__c = s.Id,SPE_Tracker__c = tk.Id,Identifier__c = trkToPlanIdentifier));
            }            
        } 
        
        insert suppToTrackers;      
    }
    
    global void finish(Database.BatchableContext BC){
        SPE2_SPEAutoTrackerBatch2 autoBatch2 = new SPE2_SPEAutoTrackerBatch2(trkToPlanIdentifier);
        database.executebatch(autoBatch2,1);
    }
    

}