global class MCAR_6DApproval_PastDue_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_PastDue_6DApproval'
     MCAR_Batch_PastDue_6DApproval pastdue6d = new MCAR_Batch_PastDue_6DApproval();     
     Database.executeBatch(pastdue6d);  
  }
}