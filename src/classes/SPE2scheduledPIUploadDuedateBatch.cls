global class SPE2scheduledPIUploadDuedateBatch implements Schedulable {
   global void execute(SchedulableContext SC) {
      SPE2_PIUploadDateUpdateBatch piUDDate = new SPE2_PIUploadDateUpdateBatch();  
      database.executebatch(piUDDate,1);     
   }
}