global class MCAR_7DApproval_PastDue_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_PastDue_7DApproval'
     MCAR_Batch_PastDue_7DApproval pastdue7d = new MCAR_Batch_PastDue_7DApproval();     
     Database.executeBatch(pastdue7d);  
  }
}