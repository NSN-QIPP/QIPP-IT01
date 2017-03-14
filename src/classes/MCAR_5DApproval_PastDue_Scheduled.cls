global class MCAR_5DApproval_PastDue_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_PastDue_5DApproval'
     MCAR_Batch_PastDue_5DApproval pastdue5d = new MCAR_Batch_PastDue_5DApproval();     
     Database.executeBatch(pastdue5d);  
  }
}