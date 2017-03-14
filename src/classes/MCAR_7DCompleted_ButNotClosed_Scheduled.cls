global class MCAR_7DCompleted_ButNotClosed_Scheduled implements Schedulable{ 
  global void execute(SchedulableContext SC) {
  // Executing Batch class named 'MCAR_Batch_7DCompleted_ButNotClosed'
     MCAR_Batch_7DCompleted_ButNotClosed pastApp7dAwaited = new MCAR_Batch_7DCompleted_ButNotClosed();     
     Database.executeBatch(pastApp7dAwaited);  
  }
}