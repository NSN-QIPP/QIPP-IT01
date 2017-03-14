public class riskSummaryController{
  
    public static String id;
    public riskSummaryController() {
        id=UserInfo.getUserId();
    }
    
       public class summaryData {       
       public String leadType{ get; set; }
       public Decimal avgScore { get; set; }
       public Decimal minScore { get; set;}
       public Decimal maxScore { get; set;}
       public summaryData() {
       }
   }

  public static List<summaryData> getSummaryData() {    
    List<Account> acc = new list<Account>();
      List<summaryData> data = new List<summaryData>();
      summaryData a = new summaryData();
      summaryData b = new summaryData();
      summaryData c = new summaryData();
      summaryData d = new summaryData();
      summaryData e = new summaryData();
    acc = [select id, Name, Lead_Unit__c, Total_Score__c from account where Unique_Id__c != NULL AND Total_Score__c != NULL ];
     
      Decimal scoreDO =0;
      Decimal scoreIPO =0;
      Decimal scorePPO =0;
      Decimal scoreSPO =0;
      Decimal scorePO =0;
      
      Decimal minScoreDO =99990;
      Decimal minScoreIPO =99990;
      Decimal minScorePPO =99990;
      Decimal minScoreSPO =99990;
      Decimal minScorePO =99990;
      
      Decimal maxScoreDO =0;
      Decimal maxScoreIPO =0;
      Decimal maxScorePPO =0;
      Decimal maxScoreSPO =0;
      Decimal maxScorePO =0;
    
      
      Decimal avgScoreDO =0;
      Decimal avgScoreIPO =0;
      Decimal avgScorePPO =0;
      Decimal avgScoreSPO =0;
      Decimal avgScorePO =0;
      
      Decimal sumScoreDO =0;
      Decimal sumScoreIPO =0;
      Decimal sumScorePPO =0;
      Decimal sumScoreSPO =0;
      Decimal sumScorePO =0;
      
      Integer countDO = 0;
      Integer countIPO = 0;
      Integer countPPO = 0;
      Integer countSPO = 0;
      Integer countPO = 0;
    
         
    if(!acc.isEmpty()){
    
     for(account act :acc){  
      Decimal score;
      if (act.Total_Score__c != 0 && act.Total_Score__c != Null)
        score = (decimal)act.Total_Score__c;
      else 
        score =0;
        
       if(act.Lead_Unit__c == 'DO'){
           if (maxScoreDO < score){
               maxScoreDO = score;
               }
           if(minScoreDO > score){
               minScoreDO = score;
               } 
           
           scoreDO = score;
           countDO ++;
           sumScoreDO =sumScoreDO + scoreDO;
                  
         }
       
       if(act.Lead_Unit__c == 'IPO'){
           if (maxScoreIPO < score){
               maxScoreIPO = score;
               }
            if(minScoreIPO > score){
               minScoreIPO = score;
               } 
           scoreIPO = score;
           countIPO ++;
           sumScoreIPO =sumScoreIPO + scoreIPO;
         }
         
         
         if(act.Lead_Unit__c == 'PPO'){
           if (maxScorePPO < score){
               maxScorePPO = score;
               }
            if(minScorePPO > score){
               minScorePPO = score;
               } 
           scorePPO = score;
           countPPO ++;
           sumScorePPO = sumScorePPO + scorePPO;
         }
         
         if(act.Lead_Unit__c == 'SPO'){
           if (maxScoreSPO < score){
               maxScoreSPO = score;
               }
            if(minScoreSPO > score){
               minScoreSPO = score;
               } 
           scoreSPO = score;
           countSPO ++;
           sumScoreSPO = sumScoreSPO + scoreSPO;
         }
         if(act.Lead_Unit__c == 'GSCM AMS PO'){
           if (maxScorePO < score){
               maxScorePO = score;
               }
            if(minScorePPO > score){
               minScorePO = score;
               } 
           scorePO = score;
           countPO ++;
           sumScorePO =sumScorePO+ scorePO;
         }
     }
        system.debug('max out: '+maxScoreIPO );
     if (countDO != 0) 
     avgScoreDO = sumScoreDO/countDO;
     else 
     avgScoreDO = 0;
     
     if (countIPO != 0) 
     avgScoreIPO = sumScoreIPO/countIPO;
     else 
     avgScoreIPO = 0;
     
     if (countPPO != 0) 
     avgScorePPO = sumScorePPO/countPPO;
     else 
     avgScorePPO = 0;
     
     if (countSPO != 0) 
     avgScoreSPO = sumScoreSPO/countSPO;
     else 
     avgScoreSPO = 0;
     
     if (countPO != 0) 
     avgScorePO = sumScorePO/countPO;
     else 
     avgScorePO = 0;
     
     if(countDO==0)
     {minScoreDO = 0;}
     
     if(countIPO==0)
     {minScoreIPO = 0;}
     
     if(countPPO==0)
     {minScorePPO = 0;}
     
     if(countSPO==0)
     {minScoreSPO = 0;}
     
     if(countPO==0)
     {minScorePO = 0;}
    }
  
  else{
    ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.INFO, 'No Risk data available' );
    ApexPages.addMessage(msg);  
  }
      a.leadType = 'DO';
      a.avgScore = avgScoreDO.setScale(2);
      a.minScore = minScoreDO.setScale(2);
      a.maxScore = maxScoreDO.setScale(2);  
      data.add(a);
      
      b.leadType = 'IPO';
      b.avgScore = avgScoreIPO.setScale(2);
      b.minScore = minScoreIPO.setScale(2);
      b.maxScore = maxScoreIPO.setScale(2);  
      data.add(b);    
      
      c.leadType = 'SPO';
      c.avgScore = avgScoreSPO.setScale(2);
      c.minScore = minScoreSPO.setScale(2);
      c.maxScore = maxScoreSPO.setScale(2);  
      data.add(c);
      
      d.leadType = 'PPO';
      d.avgScore = avgScorePPO.setScale(2);
      d.minScore = minScorePPO.setScale(2);
      d.maxScore = maxScorePPO.setScale(2);  
      data.add(d);
      
      e.leadType = 'GSCM AMS PO';
      e.avgScore = avgScorePO.setScale(2);
      e.minScore = minScorePO.setScale(2);
      e.maxScore = maxScorePO.setScale(2);  
      data.add(e);
      
    system.debug('@@@@@@@@@'+data);  
  return data;
   }

 }