global class SPE_SPETrackerBatch2 implements Database.Batchable<sObject>
{

    global Id speTrackerIds;
    
     public SPE_SPETrackerBatch2 (String speTrackerId)
    {
        speTrackerIds = speTrackerId;
        
    }   

    global Database.QueryLocator start(Database.BatchableContext bc ){
    
     Id speTrackerIds = this.speTrackerIds;
     system.debug('speTrackerIdsspeTrackerIds '+speTrackerIds );
    
    String query1 = 'select id, Score1__c,value1__C,piller__C,KPIDefinition__c,supplier__C,Weight__c,SPE_Score__c,SPE_Rank__c,SPETracker__c,Pillar_rank__C from SPE_TrackerValues__c WHERE SPETracker__c     =:speTrackerIds';
    
    return Database.getQueryLocator(query1);
      }
    global void execute(Database.BatchableContext be, list<SPE_TrackerValues__c> trackvallist)
    {
      
        List<AggregateResult> result  = new List<AggregateResult>();
        
        for(SPE_TrackerValues__c  spetrackavg : trackvallist){
         result  = [select SPETracker__c,MIN(value1__C) minval1, AVG(Piller_score__c) avgval,MIN(Piller_score__c) minval, MAX(Piller_score__c) maxval from SPE_TrackerValues__c where SPETracker__c =:spetrackavg.SPETracker__c and Piller__c=:spetrackavg.Piller__c and Piller_score__c!=0 group by SPETracker__c];
            Decimal avg;
            Decimal min;
            Decimal max;   
            Decimal minv1; 
            
      for(AggregateResult ag : result){
   
           avg = (Decimal)ag.get('avgval');
           max = (Decimal)ag.get('maxval');
           min = (Decimal)ag.get('minval');
          minv1 = (Decimal)ag.get('minval1');
         }
          
          spetrackavg.MAX_Piller_score__c = max;
          spetrackavg.min_Piller_score__c = min;
          spetrackavg.avg_Piller_score__c = avg;
          update spetrackavg;
          //spetrackavg_ls.add(spetrackavg);
        }
        
        
        //--------------------------------------pillar ranks
        list<SPE_TrackerValues__c> pillarranks = new list<SPE_TrackerValues__c>();
         for(SPE_TrackerValues__c  traval : trackvallist)
       {
           system.debug('test--test');
          pillarranks = [select Piller_score__c,Pillar_rank__C from SPE_TrackerValues__c where SPETracker__c=:traval.SPETracker__c and Piller__c =:traval.Piller__c and Piller_score__c!=null  order by Piller_score__c DESC];
           
          if(!pillarranks.isEmpty()){
           
                system.debug('test1-test1');
           decimal 	temp = 0;
           integer count = 0;
           for(integer i =0;i<pillarranks.size();i++){
            decimal  val   = pillarranks[i].piller_score__C;
               if(val!=0){
               if(temp==0){
                   count = count+1;
               pillarranks[i].pillar_rank__C = count;  
                   temp = pillarranks[i].piller_score__C;
               }else if(temp== val){
                 pillarranks[i].pillar_rank__C = count; 
                     temp = pillarranks[i].piller_score__C;
               }else{
                    count = count+1;
               pillarranks[i].pillar_rank__C = count;  
               temp = pillarranks[i].piller_score__C;
               }	
               }}
           update pillarranks;            
            
           }
           
       }  
        //----------------------------
         /*list<SPE_TrackerScore__c> speranks = new list<SPE_TrackerScore__c>();
         list<SPE_TrackerValues__c> tralist = new list<SPE_TrackerValues__c>();
        list<SPE_TrackerValues__c> tralist1 = new list<SPE_TrackerValues__c>();
         speranks = [select Score__c,SPE_Rank__c,supplier__C from SPE_TrackerScore__c where  SPE_Rank__c != null and SPETracker__c=:speTrackerIds ];
        
        for(SPE_TrackerScore__c spe : speranks){
            tralist = [select id,supplier__C,SPE_Rank__c from SPE_TrackerValues__c where supplier__C=:spe.Supplier__c and SPETracker__c=:speTrackerIds];
            for(SPE_TrackerValues__c tra : tralist){
                if(tra.supplier__C == spe.Supplier__c) {
                    tra.SPE_Rank__c = spe.SPE_Rank__c;
                    tralist1.add(tra);
                }               
            }
        }
        update tralist1;*/
        
        Set<Id> suppid = new Set<Id>();
        list<SPE_TrackerValues__c> tralist = new list<SPE_TrackerValues__c>();
         list<SPE_TrackerValues__c> tralist1 = new list<SPE_TrackerValues__c>();
        tralist = [select id,supplier__C,SPE_Rank__c from SPE_TrackerValues__c where  SPETracker__c=:speTrackerIds];
        for(SPE_TrackerValues__c t : tralist){
            suppid.add(t.supplier__C);
        }
        List<SPE_TrackerScore__c> traslist = [select Score__c,SPE_Rank__c,supplier__C from SPE_TrackerScore__c where  SPE_Rank__c != null and SPETracker__c=:speTrackerIds and supplier__C in :suppid];
        Map<Id,SPE_TrackerScore__c> trackerscoreMap = new Map<Id,SPE_TrackerScore__c>();
        for (SPE_TrackerScore__c tra: traslist) {
        trackerscoreMap.put(tra.supplier__C, tra);
        }
       
       for (SPE_TrackerValues__c t1: tralist) {
           
       SPE_TrackerScore__c tras = trackerscoreMap.get(t1.supplier__C);
           try{
           if (t1.supplier__C == tras.Supplier__c) {
          t1.SPE_Rank__c = tras.SPE_Rank__c;
          tralist1.add(t1);
       } 
           }catch(exception e){}
      }
      update tralist1;
        //threshold 
      list<SPE_SPETracker__c> spetraclist = new list<SPE_SPETracker__c>();
      list<SPE_SPEPlan__c> speplanlist = new list<SPE_SPEPlan__c>();
      list<SPE_ScoringCalculation__c> Thresholdscore = new list<SPE_ScoringCalculation__c>();
      spetraclist = [select name,SPEPlan__c from SPE_SPETracker__c where id =:speTrackerIds]; 
        
        set<id> temptrackerId = new set<id>();
        for(SPE_SPETracker__c spetracker : spetraclist)
        {
         	temptrackerId.add(spetracker.SPEPlan__c);
        }
       	speplanlist = [select name,SPEScoringTemplate__c from SPE_SPEPlan__c where id IN:temptrackerId];  
       system.debug('speplanlistspeplanlist'+speplanlist);
            for(integer j=0;j<speplanlist.size();j++){
                 for(integer i =0;i<trackvallist.size();i++){
           Thresholdscore = [select name,Lower__c,Upper__c,Score__c from SPE_ScoringCalculation__c where KPIDefinition__c=:trackvallist[i].KPIDefinition__c and ScoringTemplate__c=:speplanlist[j].SPEScoringTemplate__c];
    
            }
        }
        system.debug('ThresholdscoreThresholdscore'+Thresholdscore);
        for(SPE_TrackerValues__c spetval : trackvallist){
              system.debug('ThresholdscoreThresholdscore1'+Thresholdscore);
       
        for(SPE_ScoringCalculation__c score : Thresholdscore)
        {
           system.debug('ThresholdscoreThresholdscore1'+Thresholdscore);
            if(score.score__c==1){
                 system.debug('ThresholdscoreThresholdscore1'+Thresholdscore);
               spetval.Score_1_Lower_Bound__c = score.Lower__c;
               spetval.Score_1_Upper_Bound__c = score.Upper__c;
              
               update spetval;
            }
            else if(score.Score__c==2)
           {
              
              spetval.Score_2_Lower_Bound__c = score.Lower__c;
              spetval.Score_2_Upper_Bound__c = score.Upper__c;  
              
               update spetval;
           }
            else if(score.Score__c==3)
            {
              SPE_TrackerValues__c spetrac = new SPE_TrackerValues__c();
              spetval.Score_3_Loewr_Bound__c = score.Lower__c;
              spetval.Score_3_Upper_Bound__c = score.Upper__c;    
               
                update spetval;
            }
            else if(score.Score__c==4)
            {
            
              spetval.Score_4_Lower_Bound__c = score.Lower__c;
              spetval.Score_4_Upper_Bound__c = score.Upper__c;
               
                update spetval;
            }
            else{
              
               spetval.Score_4_Lower_Bound__c = null;
               spetval.Score_4_Upper_Bound__c = null;
              
                update spetval;
            }
        }
           
    }
        
        
        //threshold
    }  
      
    global void finish(Database.BatchableContext bc){
        
        String userEmail =String.valueof(Userinfo.getUserEmail()); 
        String trackerName= [select Name from SPE_SPETracker__c where Id=: speTrackerIds].name;
        String speplanid= [select SPEPlan__r.name,Name from SPE_SPETracker__c where Id=: speTrackerIds].SPEPlan__r.name;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        
        String[] toAddresses = new String[] {userEmail}; 
        mail.setToAddresses(toAddresses); 
        mail.setSubject(System.Label.SPE_MailSubjectBatch5); 
        String body = 'SPE Plan-'+speplanid+ 'and SPE Tracker-' +trackerName+' scheduled by '+String.valueof(UserInfo.getFirstName())+' '+String.valueof(UserInfo.getLastName())+ ' is completed successfully.'+ ''+'Please Find The Link:';
        body = body + '  '+URL.getSalesforceBaseUrl().toExternalForm() + '/'+speTrackerIds; 
        mail.setPlainTextBody(body); 
        Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
    
    }  
}