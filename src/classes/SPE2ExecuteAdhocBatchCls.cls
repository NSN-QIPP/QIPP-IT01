global class SPE2ExecuteAdhocBatchCls {
  WebService static void ExecuteAdhocBatch(){
      SPE2_PIUploadDateUpdateBatch piUDDate = new SPE2_PIUploadDateUpdateBatch();  
      database.executebatch(piUDDate,1);
  }
}