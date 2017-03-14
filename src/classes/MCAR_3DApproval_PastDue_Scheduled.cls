global class MCAR_3DApproval_PastDue_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_PastDue_3DApproval'
     MCAR_Batch_PastDue_3DApproval1 pastdue3d = new MCAR_Batch_PastDue_3DApproval1();     
     Database.executeBatch(pastdue3d);  
  }
}