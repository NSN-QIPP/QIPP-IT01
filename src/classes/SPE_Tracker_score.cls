public Class SPE_Tracker_score {

    public static void speTeackerPillerScores(List<SPE_TrackerValues__c> TrackerValues){
      
        //score ranges 
        
      list<SPE_TrackerValues__c> spetrackvalliat = new list<SPE_TrackerValues__c>();
      list<SPE_TrackerValues__c> spetrackvalliat1 = new list<SPE_TrackerValues__c>();
      list<SPE_SPETracker__c> spetraclist = new list<SPE_SPETracker__c>();
      list<SPE_SPEPlan__c> speplanlist = new list<SPE_SPEPlan__c>();
      list<SPE_ScoringCalculation__c> Thresholdscore = new list<SPE_ScoringCalculation__c>();
        system.debug('testtets');
        
        set<id> temptrackerValId = new set<id>();
        for(SPE_TrackerValues__c newSpeTrackerValue : TrackerValues){
           //spetraclist = [select name,SPEPlan__c from SPE_SPETracker__c where id=:newSpeTrackerValue.SPETracker__c]; 
           temptrackerValId.add(newSpeTrackerValue.SPETracker__c);
        }
        spetraclist = [select name,SPEPlan__c from SPE_SPETracker__c where id IN:temptrackerValId]; 
        
        set<id> temptrackerId = new set<id>();
        for(SPE_SPETracker__c spetracker : spetraclist)
        {
         	//speplanlist = [select name,SPEScoringTemplate__c from SPE_SPEPlan__c where id=:spetracker.SPEPlan__c];   
         	temptrackerId.add(spetracker.SPEPlan__c);
        }
       	speplanlist = [select name,SPEScoringTemplate__c from SPE_SPEPlan__c where id IN:temptrackerId];   
        
            
        //-------------------------------------------Block 1------------------------------------------------------//
        /*
        for(integer j=0;j<speplanlist.size();j++)           
        {
                 for(integer i =0;i<TrackerValues.size();i++)
                 {                     
           
                     Thresholdscore = [select name,Lower__c,Upper__c,Score__c from SPE_ScoringCalculation__c where KPIDefinition__c=:TrackerValues[i].KPIDefinition__c and ScoringTemplate__c=:speplanlist[j].SPEScoringTemplate__c];    
            }
        }
		*/
        ///-------------------------------------------------------------------------------------------////
        set<String> tempvalList = new set<string>();
        set<string> planlist = new set<string>();
        for(integer j=0;j<speplanlist.size();j++)           
        {                
            for(integer i =0;i<TrackerValues.size();i++)                
            {                                	
                tempvalList.add(TrackerValues[i].KPIDefinition__c);
                planlist.add(speplanlist[j].SPEScoringTemplate__c);
                     //Thresholdscore = [select name,Lower__c,Upper__c,Score__c from SPE_ScoringCalculation__c where KPIDefinition__c=:TrackerValues[i].KPIDefinition__c and ScoringTemplate__c=:speplanlist[j].SPEScoringTemplate__c];    
            }
        }        
        
        List<SPE_ScoringCalculation__c> Thresholdscore_temp = new List<SPE_ScoringCalculation__c>();
        Thresholdscore_temp = [select name,Lower__c,Upper__c,Score__c,KPIDefinition__c,ScoringTemplate__c from SPE_ScoringCalculation__c where KPIDefinition__c In:tempvalList or ScoringTemplate__c In:planlist];            
              
        for(integer j=0;j<speplanlist.size();j++)           
        {                
            for(integer i =0;i<TrackerValues.size();i++)                
            {
                for(SPE_ScoringCalculation__c ssc : Thresholdscore_temp)
                {
                    if(ssc.KPIDefinition__c==TrackerValues[i].KPIDefinition__c && ssc.ScoringTemplate__c==speplanlist[j].SPEScoringTemplate__c)
                        Thresholdscore.add(ssc);
                }
            }
        }        
        //-------------------------------------------End Block 1---------------------------------------------------//
        
        set<id> uniqIds = new set<id>();
        for(SPE_TrackerValues__c spetval : TrackerValues){
              
        for(SPE_ScoringCalculation__c score : Thresholdscore)
        {
        
            if(score.score__c==1){
               
               spetval.Score_1_Lower_Bound__c = score.Lower__c;
               spetval.Score_1_Upper_Bound__c = score.Upper__c;
                
                if(uniqIds.add(spetval.id))
               spetrackvalliat.add(spetval);
               //update spetval;
            }
            else if(score.Score__c==2)
           {
               
              spetval.Score_2_Lower_Bound__c = score.Lower__c;
              spetval.Score_2_Upper_Bound__c = score.Upper__c;  
               if(uniqIds.add(spetval.id))
               spetrackvalliat.add(spetval);
               //update spetval;
           }
            else if(score.Score__c==3)
            {
              SPE_TrackerValues__c spetrac = new SPE_TrackerValues__c();
              spetval.Score_3_Loewr_Bound__c = score.Lower__c;
              spetval.Score_3_Upper_Bound__c = score.Upper__c;    
                if(uniqIds.add(spetval.id))
               spetrackvalliat.add(spetval);
                //update spetval;
            }
            else if(score.Score__c==4)
            {
            
              spetval.Score_4_Lower_Bound__c = score.Lower__c;
              spetval.Score_4_Upper_Bound__c = score.Upper__c;
                if(uniqIds.add(spetval.id))
                spetrackvalliat.add(spetval);
                //update spetval;
            }
            else{
              
               spetval.Score_4_Lower_Bound__c = null;
               spetval.Score_4_Upper_Bound__c = null;
                if(uniqIds.add(spetval.id))
                spetrackvalliat.add(spetval);
                //update spetval;
            }
        }
           
    }
        update spetrackvalliat;
        
        //ranks
       list<SPE_TrackerValues__c> spetrackervalues = new list<SPE_TrackerValues__c>();
       list<SPE_TrackerValues__c> pillersaggregate = new list<SPE_TrackerValues__c>();
       list<SPE_TrackerValues__c> pilleraggresult = new list<SPE_TrackerValues__c>();
        
		              
        //-------------------------------------------------------------Block 2-------------------------------------
        /*                       
        for(SPE_TrackerValues__c  spetrack :  TrackerValues)       
        {
           spetrackervalues =  [select value1__C,piller__C,supplier__C,Weight__c,SPETracker__c from SPE_TrackerValues__c where  SPETracker__c=:spetrack.SPETracker__c and supplier__C=:spetrack.Supplier__c];              
        }
		*/
       //-------------------------------------------------------------------------------------------------------------       
        set<string> block2temp1 = new set<string>();
        set<string> block2temp2 = new set<string>();
        for(SPE_TrackerValues__c  spetrack :  TrackerValues)       
        {
            block2temp1.add(spetrack.SPETracker__c);
            block2temp2.add(spetrack.Supplier__c);
           //spetrackervalues =  [select value1__C,piller__C,supplier__C,Weight__c,SPETracker__c from SPE_TrackerValues__c where  SPETracker__c=:spetrack.SPETracker__c and supplier__C=:spetrack.Supplier__c];              
        } 
        List<SPE_TrackerValues__c> spetrackervalues_temp = new List<SPE_TrackerValues__c>();
        spetrackervalues =  [select value1__C,piller__C,supplier__C,Weight__c,SPETracker__c from SPE_TrackerValues__c where  SPETracker__c IN:block2temp1 and supplier__C In:block2temp2];              
 
        /*
        for(SPE_TrackerValues__c  spetrack :  TrackerValues)
        {
            for(SPE_TrackerValues__c sst : spetrackervalues_temp)
            {
				if(sst.SPETracker__c ==spetrack.SPETracker__c && sst.Supplier__c ==spetrack.Supplier__c)
                {
                    spetrackervalues.add(sst);
                }
            }
        }*/
       //--------------------------------------------------------End Block 2-----------------------------------------------------
        
        //-----------------------------------------------------Block 3-----------------------------------------------//
        set<string> block3temp1 = new set<string>();
        set<string> block3temp2 = new set<string>();
        set<string> block3temp3 = new set<string>();
        for(SPE_TrackerValues__c  spetrack1 :  spetrackervalues)
        {
            	block3temp1.add(spetrack1.SPETracker__c);
                block3temp2.add(spetrack1.Supplier__c);
                block3temp3.add(spetrack1.piller__C);
        }
        List<SPE_TrackerValues__c> pillersaggregate_temp = new List<SPE_TrackerValues__c>();
        pillersaggregate = [select value1__C, Weight__c,SPETracker__c,supplier__C,piller__c from SPE_TrackerValues__c where  SPETracker__c In:block3temp1 and supplier__C in:block3temp2 and piller__c In:block3temp3];            
        /*for(SPE_TrackerValues__c  spetrack1 :  spetrackervalues)
        {
            for(SPE_TrackerValues__c stv : pillersaggregate_temp)
            {
				if(stv.SPETracker__c==spetrack1.SPETracker__c && stv.Supplier__c ==spetrack1.Supplier__c && stv.Piller__c ==spetrack1.Piller__c)
                    pillersaggregate.add(stv);
            }
        }   */
        //------------------------------------------------------------------------------------------------------------//
        for(SPE_TrackerValues__c  spetrack1 :  spetrackervalues){
           //pillersaggregate =  [select value1__C, Weight__c from SPE_TrackerValues__c where  SPETracker__c=:spetrack1.SPETracker__c and supplier__C=:spetrack1.Supplier__c and piller__c=:spetrack1.piller__C];
            //system.debug('test test' + test4);
            Decimal Sum;
            Decimal Sum1;
            sum =0;
            sum1=0;
        for(SPE_TrackerValues__c tracker : pillersaggregate){
           sum+= tracker.value1__C;
           sum1+= tracker.Weight__c;          
           }
            spetrack1.Vlauecalculation__c = sum;
            spetrack1.Sumofpillerweight__c = sum1;
            pilleraggresult.add(spetrack1);
            }        
          update pilleraggresult;
       list<SPE_TrackerValues__c> spetrackervalues1 = new list<SPE_TrackerValues__c>();
        
        //--------------------------------------------------Block 4----------------------------------------------
        /*
        for(SPE_TrackerValues__c t : spetrackervalues)
        {
        	spetrackervalues1 = [select value1__C,piller__C,supplier__C,Weight__c,SPETracker__c from SPE_TrackerValues__c where  SPETracker__c=:t.SPETracker__c];
        }
        */
        //--------------------------------------------------------------------------------------------------------
        List<string> block4temp1 = new List<string>();
        for(SPE_TrackerValues__c t : spetrackervalues)
        {
            block4temp1.add(t.SPETracker__c);
        }
        spetrackervalues1 = [select value1__C,piller__C,supplier__C,Weight__c,SPETracker__c from SPE_TrackerValues__c where  SPETracker__c In:block4temp1];  
        //-----------------------------------------------------End Block 4-----------------------------------------------------
       List<AggregateResult> result = new List<AggregateResult>();
        
        //--------------------------------------------------Block 5 (Need check)----------------------------------------------------
        set<string> block5temp1 = new set<string>();
        set<string> block5temp2 = new set<string>();        
        List<AggregateResult> result_temp = new List<AggregateResult>();
        
        for(SPE_TrackerValues__c  spetrackavg : spetrackervalues1)
        {
            block5temp1.add(spetrackavg.SPETracker__c);
            block5temp2.add(spetrackavg.Piller__c);           
        }
        result = [select SPETracker__c,AVG(Piller_score__c) avgval,MIN(Piller_score__c) minval, MAX(Piller_score__c) maxval from SPE_TrackerValues__c where SPETracker__c in:block5temp1 and Piller__c in:block5temp2 group by SPETracker__c];
         
        //----------------------------------------------------end block 5 for below soql in loop---------------------------------------------------------

		        List<SPE_TrackerValues__c> spetrackavg_ls = new List<SPE_TrackerValues__c>();
        for(SPE_TrackerValues__c  spetrackavg : spetrackervalues1){
         //result  = [select SPETracker__c,AVG(Piller_score__c) avgval,MIN(Piller_score__c) minval, MAX(Piller_score__c) maxval from SPE_TrackerValues__c where SPETracker__c =:spetrackavg.SPETracker__c and Piller__c=:spetrackavg.Piller__c group by SPETracker__c];
            Decimal avg;
            Decimal min;
            Decimal max;	
            
      for(AggregateResult ag : result){
   
           avg = (Decimal)ag.get('avgval');
           max = (Decimal)ag.get('maxval');
           min = (Decimal)ag.get('minval');
         }
          spetrackavg.MAX_Piller_score__c = max;
          spetrackavg.min_Piller_score__c = min;
          spetrackavg.avg_Piller_score__c = avg;
          //update spetrackavg;
          spetrackavg_ls.add(spetrackavg);
        }
       update spetrackavg_ls;
        //-----------------------------------------------------------Block 6----------------------------------------------
        set<string> block6temp1 = new set<string>();
        set<string> block6temp2 = new set<string>();
        List<AggregateResult> speresult = new List<AggregateResult>();
        for(SPE_TrackerValues__c  spescore : spetrackervalues)
        {
            block6temp1.add(spescore.SPETracker__c);
            block6temp1.add(spescore.supplier__C);
        }
        speresult = [select SPETracker__c,SUM(value1__c) sum from SPE_TrackerValues__c where SPETracker__c In: block6temp1 and supplier__C In:block6temp1 group by SPETracker__c];
        //--------------------------------------------------------------------------------------------------------------
       List<SPE_TrackerValues__c> spescore_ls = new List<SPE_TrackerValues__c>();
        set<Id> spescore_Ids = new set<id>();
        
        for(SPE_TrackerValues__c  spescore : spetrackervalues)
       {
			system.debug('My flag..');
       //List<AggregateResult> speresult = [select SPETracker__c,SUM(value1__c) sum from SPE_TrackerValues__c where SPETracker__c =: spescore.SPETracker__c and supplier__C=:spescore.supplier__C group by SPETracker__c];
          //system.debug('result1'+result);
            Decimal sum;
           	
            
      for(AggregateResult ag : speresult){
   
           sum = (Decimal)ag.get('sum');
          
         }
          spescore.SPE_Score__c = sum;
           
           if(spescore_Ids.add(spescore.id))
               spescore_ls.add(spescore);
         //update spescore;
        }
        update spescore_ls;
        //-------------------------------------------------Block 7--------------------------------------------------------
        set<string> block7temp1 = new set<string>();
        for(SPE_TrackerValues__c tra : TrackerValues)
        {
            block7temp1.add(tra.SPETracker__c);
        }
        list<AggregateResult> spresult = new  list<AggregateResult>();
        spresult = [select  SPETracker__c,MIN(Score1__c) speminVal, MAX(Score1__c) spemaxVal, AVG(Score1__c) speavgScore from SPE_TrackerValues__c where SPETracker__c In: block7temp1 group by SPETracker__c] ;
        //---------------------------------------------------------------------------------------------------------------
        
        set<Id> spetracker1_Ids = new set<id>();
        list<SPE_SPETracker__c> spetracker1_ls = new list<SPE_SPETracker__c>();
        for(SPE_TrackerValues__c tra : TrackerValues){
             //spresult = [select  SPETracker__c,MIN(Score1__c) speminVal, MAX(Score1__c) spemaxVal, AVG(Score1__c) speavgScore from SPE_TrackerValues__c where SPETracker__c =: tra.SPETracker__c group by SPETracker__c] ;
            system.debug('spresult'+spresult);
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
            
          list<SPE_TrackerValues__c> pillarranks = new list<SPE_TrackerValues__c>();
          set<SPE_TrackerValues__c> pillarranks1 = new set<SPE_TrackerValues__c>();
        
        //--------------------------------------------------------------Block 8------------------------------------//
        set<string> block8temp1 = new set<string>();
        set<string> block8temp2 = new set<string>();
        for(SPE_TrackerValues__c  traval : spetrackervalues)
        {
            block8temp1.add(traval.SPETracker__c);
            block8temp2.add(traval.Piller__c);
        }
        pillarranks = [select Piller_score__c,Pillar_rank__C from SPE_TrackerValues__c where SPETracker__c in:block8temp1 and Piller__c in:block8temp2 order by Piller_score__c DESC];
        //------------------------------------------------------------------------------------------------------------

        List<SPE_TrackerValues__c> pillarranks_temp = new list<SPE_TrackerValues__c>();
        for(SPE_TrackerValues__c  traval : spetrackervalues)
       {
           system.debug('test--test');
     //pillarranks = [select Piller_score__c,Pillar_rank__C from SPE_TrackerValues__c where SPETracker__c=:traval.SPETracker__c and Piller__c =:traval.Piller__c order by Piller_score__c DESC];
           
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
           //update pillarranks;            
            
           }
           
       }
        update pillarranks;
        
        //SPE Ranks
        //------------------------------------------------Block 9-------------------------------------------------------
          list<SPE_TrackerValues__c> speranks = new list<SPE_TrackerValues__c>();
         list<SPE_TrackerValues__c> speranks1 = new list<SPE_TrackerValues__c>();
        
        set<string> block9temp1 = new set<string>();        
        
       for(SPE_TrackerValues__c  spescore : TrackerValues)
         {
             block9temp1.add(spescore.SPETracker__c);             
        //speranks = [select SPE_Score__c,SPE_Rank__c from SPE_TrackerValues__c where SPETracker__c=:spescore.SPETracker__c and SPE_Score__c!=null order by SPE_Score__c DESC];
        }
        speranks = [select SPE_Score__c,SPE_Rank__c from SPE_TrackerValues__c where SPETracker__c In:block9temp1 and SPE_Score__c!=null order by SPE_Score__c DESC];
        if(!speranks.isEmpty()){
            decimal temp1 = 0;
            integer count1 = 0;
            for(integer i =0; i<speranks.size();i++){
                decimal val1 = speranks[i].SPE_Score__c;
                if(Val1!=0){
                if(temp1==0){
                    count1 = count1+1;
               speranks[i].spe_rank__C = count1;  
                   temp1 = speranks[i].SPE_Score__c;
                }else if(temp1==val1){
                   speranks[i].spe_rank__C = count1;  
                   temp1 = speranks[i].SPE_Score__c; 
                }else{
                    count1 = count1+1;
               speranks[i].spe_rank__c = count1;  
               temp1 = speranks[i].SPE_Score__c;
                }
                }
            }
            update speranks;
           
        }
       //update  speranks1;
    }
}