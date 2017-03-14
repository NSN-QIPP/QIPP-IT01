global class MCAR_Batch_Rejected_Reminder_JOBs implements Schedulable
{ 
  global void execute(SchedulableContext SC) 
  {
     // Executing Batch class named 'MCAR_Batch_Rejected_Reminder'
     try
      {
         System.Debug('^^^^^^^ Executing Batch Started ^^^^^^^^^^^^');
         MCAR_Batch_Rejected_Reminder reminder = new MCAR_Batch_Rejected_Reminder();     
         Database.executeBatch(reminder);  
         System.Debug('^^^^^^^ Executing Batch End ^^^^^^^^^^^^');
      }
      catch(Exception exe)
      {
          System.Debug('^^^^^^^ Exception Occures in Execute: ^^^^^^^^^^^^ : ' + exe.getMessage());
      }
   }   
}