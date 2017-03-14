global class MCAR_4DApproval_PastDue_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_PastDue_4DApproval'
     MCAR_Batch_PastDue_4DApproval pastdue4d = new MCAR_Batch_PastDue_4DApproval();     
     Database.executeBatch(pastdue4d);  
  }
}