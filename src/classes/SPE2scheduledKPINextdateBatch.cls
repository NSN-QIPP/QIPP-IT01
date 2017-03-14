global class SPE2scheduledKPINextdateBatch implements Schedulable {
   global void execute(SchedulableContext SC) {
      SPE2KPINextScheduleUpdateBatch  kpinextDate = new SPE2KPINextScheduleUpdateBatch();  
      database.executebatch(kpinextDate,1);     
   }
}