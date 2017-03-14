global class MCAR_Open_MoreThan_90Days_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_OpenMoreThan_90Days'
     MCAR_Batch_OpenMoreThan_90Days caseopen90days = new MCAR_Batch_OpenMoreThan_90Days();     
     Database.executeBatch(caseopen90days); 
  }
}