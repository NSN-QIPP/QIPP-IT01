global class SPE2_SPEAutoTrackerBatch2 implements Database.Batchable<sObject>{
    
    global String query;
    global String identifierParam;
    //global List<SPE_SupplierTracker__c> supplist{get;set;}
    //global set<String> trackerids{get;set;}
    
    //global Id speTrackerIds;
    public SPE2_SPEAutoTrackerBatch2 (String identifierParam){
         this.identifierParam = identifierParam;
        List<SPE_SPETracker__c> trckrList = new List<SPE_SPETracker__c>();
        //supplist = [select id,SPE_Tracker__c,Identifier__c from SPE_SupplierTracker__c where Identifier__c =:identifierParam];
       
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){  
      
        query = 'SELECT Id, Identifier__c,Plan_Supplier__r.Supplier__c, Plan_Supplier__r.Supplier__r.EnterpriseId__c,Plan_Supplier__r.SPEPlan__c,SPE_Tracker__c FROM SPE_SupplierTracker__c WHERE Identifier__c =: identifierParam';        
        return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext BC, list<SPE_SupplierTracker__c> scope){
        for(SPE_SupplierTracker__c st :scope){
            SPE_TrackerExecutionExt.SPETrackerExecutionBatch(st.SPE_Tracker__c,st.Plan_Supplier__r.SPEPlan__c,st.Plan_Supplier__r.Supplier__r.EnterpriseId__c, st.Plan_Supplier__r.Supplier__c);
            Set<Id> trackerId = new Set<Id>();
            trackerId.add(st.SPE_Tracker__c);
            SPE_TrackerExecutionExt.aggregateScore(trackerId);
        }
         
    }
    
global void finish(Database.BatchableContext BC){
List<SPE_SupplierTracker__c> supplist = new List<SPE_SupplierTracker__c>();
supplist = [select id,SPE_Tracker__c,Identifier__c from SPE_SupplierTracker__c where Identifier__c =:identifierParam];

set<string> trid = new set<string>();
for(SPE_SupplierTracker__c s : supplist){
    
    trid.add(s.SPE_Tracker__c);
}

for(String t : trid ){
  
 SPE_SPETrackerBatch1 b1 = new SPE_SPETrackerBatch1(t);
   Database.executeBatch(b1, 1);   
}
        }
    

}