public class SPE_AdhocTrendingExt
{
   public date startDate {get;set;} 
   public date endDate {get;set;}
   private Id recId;
   
   public SPE_AdhocTrendingExt(ApexPages.StandardController st) 
   {
       recId = st.getId();
   }    
   
   public PageReference generateTrend()
   {
       SPE_KPITrendScoreBatchScheduler batch = new SPE_KPITrendScoreBatchScheduler(startDate , recId, false);
       Database.executeBatch(batch , 1);
       return new PageReference('/'+recId);
   }
}