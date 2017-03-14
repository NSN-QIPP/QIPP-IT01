global class SPE_SPETrackerBatch1 implements Database.Batchable<sObject>
{

    global Id speTrackerIds;
    
     public SPE_SPETrackerBatch1 (String speTrackerId)
    {
        speTrackerIds = speTrackerId;
        
    }   

    global Database.QueryLocator start(Database.BatchableContext bc ){
    
     Id speTrackerIds = this.speTrackerIds;
     system.debug('speTrackerIdsspeTrackerIds '+speTrackerIds );
    
    String query1 = 'select id, Avg_Piller_Score__c,DataLogic__c,DateOfExecution__c,EncryptedEnterpriseId__c,EnterpriseId__c,Group__c,KPIGroup__c,KPIDefinition__c,LogicAnnotation__c,MAX_Piller_score__c,Min_Piller_Score__c,MissingDatalogic__c,Percentile__c,Piller__c,Pillar_Rank__c, Piller_score__c,Product__c,Project__c, Region__c,salesforceid__c,Score__c,Score1__c,Score_1_Lower_Bound__c,Score_1_Upper_Bound__c,Score_2_Lower_Bound__c,Score_2_Upper_Bound__c,Score_3_Loewr_Bound__c,Score_3_Upper_Bound__c,Score_4_Lower_Bound__c,Score_4_Upper_Bound__c,ScoreResult__c,Spend__c,SpendWeightageScore__c,SPEPlanId__c,SPE_Rank__c,SPE_Score__c,SPETemplate__c,SPE_TemplateName__c,SPETracker__c,SubRegion__c,Sumofpillerweight__c,Weight__c,Supplier__c,SurveyComments__c,Value__c,value1__c,Vlauecalculation__c,WeightageScore__c from SPE_TrackerValues__c WHERE SPETracker__c	 =:speTrackerIds';
    
    return Database.getQueryLocator(query1);
      }
    global void execute(Database.BatchableContext be, list<SPE_TrackerValues__c> trackvallist)
    {
    list<SPE_TrackerValues__c> pillersaggregate = new list<SPE_TrackerValues__c>();
    list<SPE_TrackerValues__c> pilleraggresult1 = new list<SPE_TrackerValues__c>();
    list<SPE_TrackerValues__c> pilleraggresult2 = new list<SPE_TrackerValues__c>();
    for(SPE_TrackerValues__c  spetrack1 :  trackvallist){
          pillersaggregate =  [select value1__C, Weight__c from SPE_TrackerValues__c where  SPETracker__c=:spetrack1.SPETracker__c and supplier__C=:spetrack1.Supplier__c and piller__c=:spetrack1.piller__C];
          pilleraggresult2 =  [select value1__C, Weight__c from SPE_TrackerValues__c where  SPETracker__c=:spetrack1.SPETracker__c and supplier__C=:spetrack1.Supplier__c and piller__c=:spetrack1.piller__C and value1__C!=0 and value1__C!=null];
            //system.debug('test test' + test4);
            Decimal Sum;
            Decimal Sum1;
            sum =0;
            sum1=0;
        if(pillersaggregate.size()==pilleraggresult2.size()){
        for(SPE_TrackerValues__c tracker : pillersaggregate){
           sum+= tracker.value1__C;
           sum1+= tracker.Weight__c;          
           }
            spetrack1.Vlauecalculation__c = sum;
            spetrack1.Sumofpillerweight__c = sum1;
            pilleraggresult1.add(spetrack1);
            } 
        else{
            spetrack1.Vlauecalculation__c = 0;
            spetrack1.Sumofpillerweight__c = 0;
            pilleraggresult1.add(spetrack1);
        }
    }
        try{
            update pilleraggresult1;
        }catch(Exception e){}
        //-------------------------------update pillar max, min, avg-----------------------------------------------------------------
        //--------------------------------spe score for supplier wise----------------------------------------------------------
           for(SPE_TrackerValues__c  spescore : trackvallist)
       {
			system.debug('My flag..');
           List<AggregateResult> speresult = [select SPETracker__c,SUM(value1__c) sum from SPE_TrackerValues__c where SPETracker__c =: spescore.SPETracker__c and supplier__C=:spescore.supplier__C group by SPETracker__c];
          
            Decimal sum;
           	
           if(speresult.size()!=0){
      for(AggregateResult ag : speresult){
   
           sum = (Decimal)ag.get('sum');
          
         }
          spescore.SPE_Score__c = sum; 
          update spescore;
        }
       }
        
        //------------------------------------------
        list<SPE_TrackerScore__c> spelist = new list<SPE_TrackerScore__c>();
        spelist = [select id, SPETracker__c from SPE_TrackerScore__c where SPEScore__c = true and SPETracker__c =:speTrackerIds ];
        list<AggregateResult> spresult = new  list<AggregateResult>();
        spresult = [select  SPETracker__c,MIN(Score__c) speminVal, MAX(Score__c) spemaxVal, AVG(Score__c) speavgScore from SPE_TrackerScore__c where SPEScore__c = true and SPETracker__c =:speTrackerIds  group by SPETracker__c];
 
        set<Id> spetracker1_Ids = new set<id>();
        list<SPE_SPETracker__c> spetracker1_ls = new list<SPE_SPETracker__c>();
        for(SPE_TrackerScore__c tra : spelist){
              for(AggregateResult ag : spresult){
                SPE_SPETracker__c spetracker1 = new SPE_SPETracker__c();
                spetracker1.id = (id)ag.get('SPETracker__c');                               
                spetracker1.Avg_SPE_Score__c = (Decimal)ag.get('speavgScore');
                spetracker1.MAX_Score__c = (Decimal)ag.get('spemaxVal');
                spetracker1.Min_SPE_Score__c = (Decimal)ag.get('speminVal');
                  //update spetracker1;
                  if(spetracker1_Ids.add(spetracker1.id))
                  spetracker1_ls.add(spetracker1);
               }       
          }
        update spetracker1_ls;
        
        //-----------------------------SPE Ranks-------------------------------
        list<SPE_TrackerScore__c> speranks = new list<SPE_TrackerScore__c>();
               
        set<string> block9temp1 = new set<string>();        
        
        speranks = [select Score__c,SPE_Rank__c from SPE_TrackerScore__c where SPETracker__c=:speTrackerIds  and Score__c!=0 and SPEScore__c = true and Score__c != null order by Score__c DESC];
        if(!speranks.isEmpty()){
            decimal temp1 = 0;
            integer count1 = 0;
            for(integer i =0; i<speranks.size();i++){
                decimal val1 = speranks[i].Score__c;
                if(Val1!=0){
                if(temp1==0){
                    count1 = count1+1;
               speranks[i].spe_rank__C = count1;  
                   temp1 = speranks[i].Score__c;
                }else if(temp1==val1){
                   speranks[i].spe_rank__C = count1;  
                   temp1 = speranks[i].Score__c; 
                }else{
                    count1 = count1+1;
               speranks[i].spe_rank__c = count1;  
               temp1 = speranks[i].Score__c;
                }
                }
            }
            update speranks;
           
        }
        
        
        //------------------------------------------
    }  
      
    global void finish(Database.BatchableContext bc){
    SPE_SPETrackerBatch2 b2 = new SPE_SPETrackerBatch2(speTrackerIds);
        Database.executeBatch(b2, 1);
    }  
}