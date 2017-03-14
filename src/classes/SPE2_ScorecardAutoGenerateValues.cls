global class SPE2_ScorecardAutoGenerateValues implements Database.Batchable<sObject> 
{
    global String ScorecardId;
    global String scIdentifier;
    global String scGenRecordId; 
    global  List<SPE_ScorecardValues__c> overAllScoreValsToUpdate;
    public SPE2_ScorecardAutoGenerateValues (String scIdentifier){
        this.scIdentifier = scIdentifier;
    }
    

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        String query = '';        
        query = 'SELECT Id,ScoreCard__c,ScoreCard__r.ScorecardTracker__r.ScorecardGenerator__c,ScoreCard__r.Nego_Responsible__c,ScoreCard__r.Identifier__c,Supplier__c,SPE_Plan__c ,DateOfExecution__c,ScoreCard__r.AggregationRule__c,ScoreCard__r.StartDate__c,ScoreCard__r.endDate__c, Tracker_Score__c,Weight__c,CrunchedScores__c,country__c,categoryarea__c,categorygroup__c,category__c FROM SPE_ScorecardTempValues__c WHERE ScoreCard__r.Identifier__c=: scIdentifier ';
        system.debug('query123::'+query);
        system.debug('scIdentifier::'+scIdentifier);        
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_ScorecardTempValues__c > scope) 
    {
         overAllScoreValsToUpdate = new List<SPE_ScorecardValues__c>();
        
         //scGenRecordId = scope[0].ScoreCard__r.ScorecardTracker__r.ScorecardGenerator__c;
         ScorecardId = scope[0].ScoreCard__c; 
         system.debug('ScorecardId1::'+ScorecardId); 
         for(SPE_ScorecardTempValues__c scp :scope){
          
             /*if(ScorecardId == '' || ScorecardId == null){
                 ScorecardId = scp.ScoreCard__c;  
                 system.debug('ScorecardId1::'+ScorecardId); 
             }  */     
     // Simple average
     if(scp.ScoreCard__r.AggregationRule__c=='Simple Average'){
      scp.Weight__c=1;
     }
     
     
     // Spend Calculations
     if(scp.ScoreCard__r.AggregationRule__c=='Weighted Average by Spend'){
         list<SPE_SPEPlan__c> plans=new list<SPE_SPEPlan__c>();
            plans=[select id from SPE_SPEPlan__c];
            String project;
            String Country;
            String SubRegion;
            String Region;
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scp.Supplier__c;
            Date dd=scp.DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= Date.newInstance( dd.year(), dd.month(), noOfDays);
            Date startDate= Date.newInstance( dd.year(), dd.month(), 1);
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,AggregationDuration__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scp.SPE_Plan__c ] ;      
            
            
            if(integer.valueOf(planDetail.AggregationDuration__c)>1)
            {
            Date ddd=scp.DateOfExecution__c.addMonths(-integer.valueOf(planDetail.AggregationDuration__c));
            startDate= Date.newInstance( ddd.year(), ddd.month(), 1);  
            }
            
           
            String nego='';
            string nego1='';
            string q='SELECT Spend__c FROM SPE_Spend__c where EnterpriseId__c=:SupplierId and Period__c>=:startDate and Period__c<=:EndDate';
            
            if(!(planDetail.project__c).containsIgnoreCase('All')){
                project=planDetail.project__c;
                q=q+' and Project__c=:project';
                }
            if(!(planDetail.Country__c).containsIgnoreCase('All')){
                Country=planDetail.Country__c;
                q=q+' and Country__c=:Country';
                }
            if(!(planDetail.SubRegion__c).containsIgnoreCase('All')){
                SubRegion=planDetail.SubRegion__c;
                q=q+' and Sub_Region__c=:SubRegion';
                }
            if(!(planDetail.Region__c).containsIgnoreCase('All')){
                Region=planDetail.Region__c;
                 q=q+' and Region__c=:Region';
                }
            if(!(planDetail.CategoryCluster__c).containsIgnoreCase('All')){
                CategoryArea=planDetail.CategoryCluster__c;
                q=q+' and CategoryArea__c=:CategoryArea';
                }
            if(!(planDetail.CategoryGroup__c).containsIgnoreCase('All')){
                CategoryGroup=planDetail.CategoryGroup__c;
                q=q+' and CategoryGroup__c=:CategoryGroup';
                }
            if(!(planDetail.Category__c ).containsIgnoreCase('All')){
                Category=planDetail.Category__c ;
                q=q+' and Category__c=:Category';
                }    
            
            /*
            if(scp.ScoreCard__r.Nego_Responsible__c==Null || scp.ScoreCard__r.Nego_Responsible__c=='R')
                 {   nego='R';
                     q=q+' and Nego_Responsible__c=:nego';
                 }
            if(scp.ScoreCard__r.Nego_Responsible__c=='G') {
                 nego='G';
                 q=q+' and Nego_Responsible__c=:nego';            
                 }
                 
            if(scp.ScoreCard__r.Nego_Responsible__c=='R+G') {
                 nego='R';
                 nego1='G';
                 q=q+' and (Nego_Responsible__c=:nego OR Nego_Responsible__c=:nego1)'; 
                 }
            */
            system.debug('*******************'+q+','+startDate +','+enddate);
            decimal Spend=0.0;
            for(SPE_Spend__c s:Database.query(q)){
            spend=spend+ s.spend__c;
            }
            
            if(spend!=0.0)
            scp.Weight__c=spend;
            if(scp.Weight__c == null)
              scp.Weight__c=1.0;
        }
        
        
        
        
        
        
     // Spend Calculations
     if(scp.ScoreCard__r.AggregationRule__c=='Weighted Average by Volume'){
                  
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scp.Supplier__c;
            Date dd=scp.DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= Date.newInstance( dd.year(), dd.month(), noOfDays);
            Date startDate= Date.newInstance( dd.year(), dd.month(), 1);
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,AggregationDuration__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scp.SPE_Plan__c ] ;      
          
            if(integer.valueOf(planDetail.AggregationDuration__c)>1)
            {
            Date ddd=scp.DateOfExecution__c.addMonths(-integer.valueOf(planDetail.AggregationDuration__c));
            startDate= Date.newInstance( ddd.year(), ddd.month(), 1);  
            } 
            
            string q='SELECT Volume__c FROM SPE_Volume__c where EnterpriseId__c=:SupplierId and Period__c>=:startDate and Period__c<=:EndDate';
            
            if(!(planDetail.CategoryCluster__c).containsIgnoreCase('All')){
                CategoryArea=planDetail.CategoryCluster__c;
                q=q+' and CategoryCluster__c=:CategoryArea';
                }
            if(!(planDetail.CategoryGroup__c).containsIgnoreCase('All')){
                CategoryGroup=planDetail.CategoryGroup__c;
                q=q+' and Category_Group__c=:CategoryGroup';
                }
            if(!(planDetail.Category__c ).containsIgnoreCase('All')){
                Category=planDetail.Category__c ;
                q=q+' and Category__c=:Category';
                }    
            
            
            
            decimal volume=0.0;
            for(SPE_Volume__c  s:Database.query(q)){
            volume=volume+ s.Volume__c ;
            }
            
            if(volume!=0.0)
            scp.Weight__c=volume;
            if(scp.Weight__c == null)
                scp.Weight__c= 1.0;
        }
        
        
        
        // logic 4
        if(scp.ScoreCard__r.AggregationRule__c=='BW with Project Simple Average') {
            if(scp.CrunchedScores__c!=Null){
            list<SPE_SPEPlan__c> plans=new list<SPE_SPEPlan__c>();
            plans=[select id from SPE_SPEPlan__c];
            String project;
            String Country;
            String SubRegion;
            String Region;
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scp.Supplier__c;
            Date dd=scp.DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= Date.newInstance( dd.year(), dd.month(), noOfDays);
            Date startDate= Date.newInstance( dd.year(), dd.month(), 1);
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scp.SPE_Plan__c ] ;      
          
            
            string q='SELECT Spend__c FROM SPE_Spend__c where EnterpriseId__c=:SupplierId and Period__c>=:startDate and Period__c<=:EndDate';
            
            
           
            if(!(planDetail.Country__c).containsIgnoreCase('All')){
                Country=planDetail.Country__c;
                q=q+' and Country__c=:Country';
                }
            if(!(planDetail.SubRegion__c).containsIgnoreCase('All')){
                SubRegion=planDetail.SubRegion__c;
                q=q+' and Sub_Region__c=:SubRegion';
                }
            if(!(planDetail.Region__c).containsIgnoreCase('All')){
                Region=planDetail.Region__c;
                q=q+' and Region__c=:Region';            
                }
            if(!(planDetail.CategoryCluster__c).containsIgnoreCase('All')){
                CategoryArea=planDetail.CategoryCluster__c;
                q=q+' and CategoryArea__c=:CategoryArea';
                }
            if(!(planDetail.CategoryGroup__c).containsIgnoreCase('All')){
                CategoryGroup=planDetail.CategoryGroup__c;
                q=q+' and CategoryGroup__c=:CategoryGroup';
                }
            if(!(planDetail.Category__c ).containsIgnoreCase('All')){
                Category=planDetail.Category__c ;
                q=q+' and Category__c=:Category';
                }    
            
            
            system.debug('&&&&&&&'+q+startdate+enddate);
            decimal Spend=0.0;
            for(SPE_Spend__c s:Database.query(q)){
            spend=spend+ s.spend__c;
            }
            
            if(spend!=0.0){
            scp.Weight__c=spend;
            }
            if(scp.Weight__c == null)
              scp.Weight__c=1.0;
           
        }
        else {
        
                /*****else **/
            list<SPE_SPEPlan__c> plans=new list<SPE_SPEPlan__c>();
            plans=[select id from SPE_SPEPlan__c];
            String project;
            String Country;
            String SubRegion;
            String Region;
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scp.Supplier__c;
            Date dd=scp.DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= scp.ScoreCard__r.enddate__c;
            Date startDate=scp.ScoreCard__r.startdate__c; 
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scp.SPE_Plan__c ] ;      
          
            
            string q='SELECT Spend__c FROM SPE_Spend__c where EnterpriseId__c=:SupplierId and Period__c>=:startDate and Period__c<=:EndDate';
            
            
                
            
                Country=scp.Country__c;
                q=q+' and Country__c=:Country';
           
            if(!(scp.Categoryarea__c).containsIgnoreCase('All')){
                CategoryArea=scp.Categoryarea__c;
                q=q+' and CategoryArea__c=:CategoryArea';
                }
            if(!(scp.CategoryGroup__c).containsIgnoreCase('All')){
                CategoryGroup=scp.CategoryGroup__c;
                q=q+' and CategoryGroup__c=:CategoryGroup';
                }
            if(!(scp.Category__c ).containsIgnoreCase('All')){
                Category=scp.Category__c ;
                q=q+' and Category__c=:Category';
                }    
            
            
            
            decimal Spend=0.0;
            for(SPE_Spend__c s:Database.query(q)){
            spend=spend+ s.spend__c;
            }
            
            if(spend!=0.0){
            scp.Weight__c=spend;
            }
            if(scp.Weight__c == null)
              scp.Weight__c=1.0;
            /*** end else **/
        
        }
        }
     update scp;   
     Set<String> insertedScoreIds = new Set<String>();
     // generate scorecard values here
     list<SPE_ScorecardTempValues__c> temp=new list<SPE_ScorecardTempValues__c>();
      system.debug('****IN Finish**123***');
      temp=[select id from SPE_ScorecardTempValues__c where ScoreCard__c=:scp.ScoreCard__c and Weight__c=Null];  
      system.debug('****IN Finish**124***');      
                                 
      if (temp.size()==0){
      list<SPE_ScorecardValues__c> tobeinserted= new list<SPE_ScorecardValues__c >();
   
    AggregateResult[] groupedResults =new List<AggregateResult>(); 
    system.debug('****groupedResults *****');
    groupedResults =[SELECT SPE_TemplateName__c,KPI__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight,AVG(KPI_Value__c) kpiTot FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scp.ScoreCard__c and KPI__c!=Null and Score1__c!=Null GROUP BY SPE_TemplateName__c,KPI__c ];    
    system.debug('****groupedResults *****' + groupedResults );
    for (AggregateResult ar : groupedResults){
        SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
        s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        if(ar.get('weight') != null)      
            s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
        else
            s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')));
        s.scorecard__c=scp.ScoreCard__c;
        s.kpi__c=String.valueOf(ar.get('KPI__c'));
        s.TotalKPIValue__c = Decimal.valueOf(String.valueOf(ar.get('kpiTot')));
        tobeinserted.add(s);
        }
    system.debug('tobeinserted---' + tobeinserted);

    groupedResults = [SELECT SPE_TemplateName__c,Group__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scp.ScoreCard__c and KPI__c=Null and Group__c!=Null and Score1__c!=Null GROUP BY SPE_TemplateName__c,Group__c ];    
   
    for(AggregateResult ar : groupedResults){
        SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
        s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
        s.scorecard__c=scp.ScoreCard__c;
        s.Group__c=String.valueOf(ar.get('Group__c'));
        tobeinserted.add(s);
    }
    
        
    groupedResults = [SELECT SPE_TemplateName__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scp.ScoreCard__c and KPI__c=Null and Group__c=Null and Score1__c!=Null GROUP BY SPE_TemplateName__c ];    
    
    for(AggregateResult ar : groupedResults){
        SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
        s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
        s.scorecard__c=scp.ScoreCard__c;
        tobeinserted.add(s);
        system.debug('tobeinserted--' + tobeinserted);
    }
       
       
           if(tobeinserted.size()>0){
               delete [select id from SPE_ScorecardValues__c where ScoreCard__c=:scp.ScoreCard__c];
               insert tobeinserted;
               for(SPE_ScorecardValues__c sv :tobeinserted){
                   insertedScoreIds.add(sv.Id);
               }
           }else{
               for(SPE_ScorecardValues__c sv :[select id from SPE_ScorecardValues__c where ScoreCard__c=:scp.ScoreCard__c]){
                   insertedScoreIds.add(sv.Id);
               }
           }
        }
        // PB-0154 implementation
        overAllScoreValsToUpdate = [Select Id,Score__c,KPI__c,ScoreCard__c,TotalKPIValue__c,KPI__r.IsHighBetter__c,Group__c 
                                    From SPE_ScorecardValues__c
                                    Where KPI__c = null AND Group__c = Null AND scorecard__c =:scp.ScoreCard__c];
        system.debug('::1'+overAllScoreValsToUpdate+'::'+scp.ScoreCard__c);
        SPE_ScoreCard__c scard = [Select Id,IsAdhoc__c,ScorecardTracker__c,ScorecardTracker__r.ScorecardGenerator__r.DisplayValues__c, 
                                  ScorecardTracker__r.ScorecardGenerator__c,Aggregation_Period__c From SPE_ScoreCard__c 
                                  Where Id =:scp.ScoreCard__c];
        
        List<SPE_Scorecard_Plan__c> scorePlans = new List<SPE_Scorecard_Plan__c>();
        scorePlans = [Select Id,Scorecard_Generator__c,SPE_Plan__c,SPE_Plan__r.SPEScoringTemplate__c 
                      From SPE_Scorecard_Plan__c Where Scorecard_Generator__c =: scard.ScorecardTracker__r.ScorecardGenerator__c];
                      
        if(scard.ScorecardTracker__r.ScorecardGenerator__r.DisplayValues__c && scard.IsAdhoc__c 
           && scorePlans.size() == 1 && scard.Aggregation_Period__c != 'Monthly'){
            
            String scoringTempId = scorePlans[0].SPE_Plan__r.SPEScoringTemplate__c;        
            List<SPE_ScorecardValues__c> scoreValsToUpdate = new List<SPE_ScorecardValues__c>();
            scoreValsToUpdate = [Select Id,Score__c,KPI__c,ScoreCard__c,TotalKPIValue__c,KPI__r.IsHighBetter__c From SPE_ScorecardValues__c
                                 Where KPI__c != null AND Id IN :insertedScoreIds];
            if(!scoreValsToUpdate.isEmpty()){
                Map<String,String> kpiToVal = new Map<String,String>();
                for(SPE_ScorecardValues__c sv :scoreValsToUpdate){
                    kpiToVal.put(sv.KPI__c,sv.TotalKPIValue__c+'~'+sv.KPI__r.IsHighBetter__c);
                }
                
                List<SPE_KPIDefinition__c> kpiDefList = new List<SPE_KPIDefinition__c>();
                
                List<SPE_ScoringCalculation__c> scoringCalculationList = new List<SPE_ScoringCalculation__c>();
                scoringCalculationList = [SELECT Lower__c, LowerTo__c, Upper__c, UpperTo__c, Score__c, KPIDefinition__c 
                                          FROM SPE_ScoringCalculation__c Where KPIDefinition__c IN :kpiToVal.keySet()
                                          AND ScoringTemplate__c =:scoringTempId];
                
                Map<Id, List<SPE_ScoringCalculation__c>> kpiScoringCalculationMap = new Map<Id, List<SPE_ScoringCalculation__c>>();
                for (SPE_ScoringCalculation__c sc: scoringCalculationList){   
                    List<SPE_ScoringCalculation__c> newScoringList = new List<SPE_ScoringCalculation__c>();            
                    if (kpiScoringCalculationMap.get(sc.KPIDefinition__c) != null){
                        newScoringList = kpiScoringCalculationMap.get(sc.KPIDefinition__c);
                    }
                    newScoringList.add(sc);           
                    kpiScoringCalculationMap.put(sc.KPIDefinition__c, newScoringList);             
                }
                system.debug('kpiScoringCalculationMap::'+kpiScoringCalculationMap);
                for(SPE_ScorecardValues__c sv :scoreValsToUpdate){
                    sv.Score__c = scoreCalculation(decimal.valueOf(kpiToVal.get(sv.KPI__c).split('~')[0]),kpiScoringCalculationMap.get(sv.KPI__c),boolean.valueOf(kpiToVal.get(sv.KPI__c).split('~')[1]));
                    system.debug('sv.Score__c::'+sv.Score__c);
                }
            }
            Set<String> updatedScorevalIds = new Set<String>();
            try{
                update scoreValsToUpdate;                
                for(SPE_ScorecardValues__c sv1 :scoreValsToUpdate){
                    updatedScorevalIds.add(sv1.Id);
                }
            }catch(exception e){
                system.debug('exception::'+e.getMessage());
            }
            
            // updating pillar weights
            List<SPE_ScorecardValues__c> pillarScoreValsToUpdate = new List<SPE_ScorecardValues__c>();
            pillarScoreValsToUpdate = [Select Id,Score__c,KPI__c,ScoreCard__c,TotalKPIValue__c,KPI__r.IsHighBetter__c,Group__c From SPE_ScorecardValues__c
                                       Where KPI__c = null AND Group__c!= Null AND Id IN :insertedScoreIds];
            String scopePlanId = scope[0].SPE_Plan__c;
            String speTemplateId = [Select Id,SPETemplate__c From SPE_SPEPlan__c Where Id =:scopePlanId].SPETemplate__c;
            List<SPE_SPEKPIMap__c> kpiMapList = [Select KPIDefinition__c,KPIGroup1__c,Weight__c,KPIGroup2__c From SPE_SPEKPIMap__c 
                                                Where SPETemplate__c =:speTemplateId]; 
            Map<String,List<String>> pillarToKPIWeight = new Map<String,List<String>>();
            for(SPE_SPEKPIMap__c km :kpiMapList){
                if(!pillarToKPIWeight.containskey(km.KPIGroup1__c)){
                    pillarToKPIWeight.put(km.KPIGroup1__c,new list<String>{});
                }
                pillarToKPIWeight.get(km.KPIGroup1__c).add(km.KPIDefinition__c+'~'+km.Weight__c);
            }
            Map<String,decimal> kpiToScoreMap = new Map<String,decimal>();
            for(SPE_ScorecardValues__c sv2 :[Select Id,Score__c,KPI__c From SPE_ScorecardValues__c Where Id IN :updatedScorevalIds]){
                kpiToScoreMap.put(sv2.KPI__c,sv2.Score__c);                                                                                                       
            }
            system.debug('kpiToScoreMap::'+kpiToScoreMap);
            system.debug('updatedScorevalIds1::'+updatedScorevalIds);
            for(SPE_ScorecardValues__c sv1 :pillarScoreValsToUpdate){
                decimal pillarScore = 0;
                decimal pillarWeight = 0;
                for(String s :pillarToKPIWeight.get(sv1.Group__c)){
                    pillarScore += kpiToScoreMap.get(s.split('~')[0])*(decimal.valueOf(s.split('~')[1])*0.01);
                    pillarWeight += (decimal.valueOf(s.split('~')[1])*0.01);
                }
                if(pillarWeight != 0 && pillarWeight != null){
                    sv1.Score__c = pillarScore/pillarWeight;
                }
            }
            try{
                update pillarScoreValsToUpdate;                                
            }catch(exception e){
                system.debug('exception1::'+e.getMessage());
            }
            // calculate overall update
            try{
                system.debug('scp.ScoreCard__c::'+scp.ScoreCard__c);
                system.debug('overAllScoreValsToUpdate **'+overAllScoreValsToUpdate);                           
                String scopePlanId1 = scp.SPE_Plan__c;
                String speTemplateId1 = [Select Id,SPETemplate__c From SPE_SPEPlan__c Where Id =:scopePlanId1].SPETemplate__c;
                List<SPE_SPEKPIMap__c> kpiMapList1 = [Select KPIDefinition__c,KPIGroup1__c,Weight__c,KPIGroup2__c From SPE_SPEKPIMap__c 
                                                      Where SPETemplate__c =:speTemplateId1]; 
                system.debug('speTemplateId1::'+speTemplateId1);
                system.debug('kpiMapList1::'+kpiMapList1);
                Map<String,List<String>> pillarToKPIWeight1 = new Map<String,List<String>>();
                for(SPE_SPEKPIMap__c km1 :kpiMapList1){
                    if(!pillarToKPIWeight1.containskey(km1.KPIGroup1__c)){
                        pillarToKPIWeight1.put(km1.KPIGroup1__c,new list<String>{});
                    }
                    pillarToKPIWeight1.get(km1.KPIGroup1__c).add(km1.KPIDefinition__c+'~'+km1.Weight__c);
                }
                Map<String,decimal> kpiToScoreMap1 = new Map<String,decimal>();
                for(SPE_ScorecardValues__c sv2 :[Select Id,Score__c,KPI__c,ScoreCard__c From SPE_ScorecardValues__c Where ScoreCard__c =:scp.ScoreCard__c AND Kpi__c!= Null]){
                    kpiToScoreMap1.put(sv2.KPI__c,sv2.Score__c);                                                                                                       
                }
                system.debug('kpiToScoreMap1 ::'+kpiToScoreMap1);
                system.debug('overAllScoreValsToUpdate::'+overAllScoreValsToUpdate);
                decimal overAllScore = 0;
                decimal overAllweight = 0;
                system.debug('pillarToKPIWeight1::'+pillarToKPIWeight1);
                for(SPE_ScorecardValues__c sv :overAllScoreValsToUpdate){
                    for(String s :pillarToKPIWeight1.keySet()){
                        for(String s1 :pillarToKPIWeight1.get(s)){
                            overAllScore += kpiToScoreMap1.get(s1.split('~')[0])*(decimal.valueOf(s1.split('~')[1])*0.01);
                            //overAllweight += (decimal.valueOf(s.split('~')[1])*0.01);
                            sv.Score__c = overAllScore;
                        }                
                    }
                }
                                
                try{
                    update overAllScoreValsToUpdate;                                
                }catch(exception e){
                    system.debug('exception2::'+e.getMessage());
                }
            }catch(exception e){
                system.debug('exception2::'+e.getMessage());
            }
            
        }
      }
      
        Set<String> scorecardtrackerid = new Set<String>();
        for(SPE_ScorecardTempValues__c sc1 :scope){
            scorecardtrackerid.add(sc1.ScoreCard__r.ScorecardTracker__c);
      
             //veera
          list<AggregateResult> score = new list<AggregateResult>();
           list<SPE_ScorecardValues__c> plist = new list<SPE_ScorecardValues__c>();
          plist = [select ScoreCard__c,score__C,group__C from SPE_ScorecardValues__c where ScoreCard__r.ScorecardTracker__c=:scorecardtrackerid];
          for(SPE_ScorecardValues__c s :  plist){
              score = [select ScoreCard__c, sum(Score__c) sum  from SPE_ScorecardValues__c where scorecard__C=:s.ScoreCard__c and group__C=:s.Group__c and group__c!=null group by ScoreCard__c ];
              Decimal sum;
              for(AggregateResult agr : score){
                  sum = (Decimal)agr.get('sum')/score.size();
                  s.score1__C=sum;
                  update s;
              }
          }
          list<SPE_ScorecardValues__c> slist = new list<SPE_ScorecardValues__c>();
          slist =[select ScoreCard__c,score__C,kpi__c,group__C  from SPE_ScorecardValues__c where ScoreCard__r.ScorecardTracker__c=:scorecardtrackerid and group__C =null and kpi__c=null];
          for(SPE_ScorecardValues__c s :  slist){
              score = [select ScoreCard__c, sum(Score__c) sum  from SPE_ScorecardValues__c where scorecard__C=:s.ScoreCard__c and group__C =null and kpi__c=null group by ScoreCard__c ];
              system.debug('test test' +score);
              Decimal sum;
              for(AggregateResult agr : score){
                  sum = (Decimal)agr.get('sum')/score.size();
                  s.score1__C=sum;
                  update s;
              }
          }
          //ranks
          list<SPE_ScorecardValues__c> speresult = new list<SPE_ScorecardValues__c>();
          speresult = [select Score1__c,Group__c,   KPI__c,ScoreCard__c,SPE_Template_Name__c from SPE_ScorecardValues__c where  ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid and group__C =null and KPI__c=null order by score1__C DESC];
          for(SPE_ScorecardValues__c sr : speresult){
              
              if(!speresult.isEmpty()){
            decimal temp1 = 0;
            integer count1 = 0;
            for(integer i =0; i<speresult.size();i++){
                decimal val1 = speresult[i].score1__C;
                if(Val1!=0){
                if(temp1==0){
                    count1 = count1+1;
               speresult[i].Scorecard_Ranka__c = count1;  
                   temp1 = speresult[i].score1__C;
                }else if(temp1==val1){
                   speresult[i].Scorecard_Ranka__c = count1;  
                   temp1 = speresult[i].score1__C; 
                }else{
                    count1 = count1+1;
               speresult[i].Scorecard_Ranka__c = count1;  
               temp1 = speresult[i].score1__C;
                }
                }
            }}
             update speresult; 
          }
           list<SPE_ScorecardValues__c> pillarscore = new list<SPE_ScorecardValues__c>();
           list<SPE_ScorecardValues__c> pillarrank = new list<SPE_ScorecardValues__c>();
           pillarscore = [select Score1__c,Group__c,KPI__c,ScoreCard__c,SPE_Template_Name__c from SPE_ScorecardValues__c where  ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid];
          for(SPE_ScorecardValues__c prank : pillarscore){
              pillarrank =[select Score1__c from SPE_ScorecardValues__c where  ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid and group__C=:prank.Group__c and group__c!=null order by Score__c DESC];
            if(!pillarrank.isEmpty()){
            decimal temp1 = 0;
            integer count1 = 0;
            for(integer i =0; i<pillarrank.size();i++){
                decimal val1 = pillarrank[i].score1__C;
                if(Val1!=0){
                if(temp1==0){
                    count1 = count1+1;
               pillarrank[i].Pillar_Rank__c = count1;  
                   temp1 = pillarrank[i].score1__C;
                }else if(temp1==val1){
                   pillarrank[i].Pillar_Rank__c = count1;  
                   temp1 = pillarrank[i].score1__C; 
                }else{
                    count1 = count1+1;
               pillarrank[i].Pillar_Rank__c = count1;  
               temp1 = pillarrank[i].score1__C;
                }
                }
            }
          }
            update pillarrank;  
          }
          
          //max,min,avg
          list<AggregateResult> result = new  list<AggregateResult>();
          list<SPE_ScorecardValues__c> scrloistupdate = new list<SPE_ScorecardValues__c>();
          scrloistupdate = [select Status__c,score1__C from SPE_ScorecardValues__c where ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid and group__C =null and KPI__c=null ] ;
          for(SPE_ScorecardValues__c sc : scrloistupdate){
               result = [select Status__c, MIN(Score1__c) ScoreminVal, MAX(Score1__c) ScoremaxVal, AVG(Score1__c) ScoreavgScore from SPE_ScorecardValues__c where ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid and group__C =null and KPI__c=null group by Status__c] ;
              if(result.size()>0){
              for(AggregateResult ag : result){                  
                SPE_ScorecardValues__c Scorecard = new SPE_ScorecardValues__c();
                Scorecard.id = sc.id;
                Scorecard.Status__c = String.valueOf(ag.get('Status__c'));                               
                Scorecard.Scorecard_Avg__c = (Decimal)ag.get('ScoreavgScore');
                Scorecard.Scorecard_Max__c = (Decimal)ag.get('ScoremaxVal');
                Scorecard.Scorecard_Min__c = (Decimal)ag.get('ScoreminVal');
                system.debug('testtest1');
                update Scorecard;
          }
          }
              
          }
          list<AggregateResult> pillagg = new  list<AggregateResult>();
          list<SPE_ScorecardValues__c> pillupdate = new list<SPE_ScorecardValues__c>();
          pillupdate = [select Status__c, Score1__c,group__C from SPE_ScorecardValues__c  where ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid  and group__C!=null];
          for(SPE_ScorecardValues__c pillarsagg : pillupdate){
             pillagg = [select Status__c, MAX(Score1__c) pillmax, MIN(Score1__c) Pillmin, AVG(Score1__c) Pillavg from SPE_ScorecardValues__c  where ScoreCard__r.ScorecardTracker__c =:scorecardtrackerid and group__C =:pillarsagg.Group__c and group__C!=null  group by Status__c]; 
             for(AggregateResult ag1 : pillagg){
                  
                SPE_ScorecardValues__c pill = new SPE_ScorecardValues__c();
                pill.id = pillarsagg.id;
                pill.Status__c = String.valueOf(ag1.get('Status__c'));                               
                pill.Avg_Pillar__c = (Decimal)ag1.get('Pillavg');
                pill.Max_Pillar__c = (Decimal)ag1.get('pillmax');
                pill.Min_Pillar__c = (Decimal)ag1.get('Pillmin');
                update pill;
             
          }
           
          }
            
        }
        
    }
    public static decimal scoreCalculation(decimal trackerValue, List<SPE_ScoringCalculation__c> scoringCalculationList, Boolean isHighBetter)
    {
        decimal score1 ;
        for (SPE_ScoringCalculation__c sc : scoringCalculationList)
        {
            Decimal score = SPE_MathsUtil.textToArithmeticOperator(sc.Lower__c, sc.LowerTo__c, sc.Upper__c, sc.UpperTo__c, sc.Score__c, trackerValue);
            score1 = 0;
            if (score != null)
            {
                
                //trackerValue.Score__c = score.setscale(4);
                
                Decimal sc1 = trackerValue - sc.Lower__c;
                
                Decimal scoreValues = 0;
                 
                if (isHighBetter)
                {
                    if (sc.UpperTo__c == '<=')
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : (sc1/(sc.Upper__c - sc.Lower__c + 0.0001) + score);
                    }
                    else
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : (sc1/(sc.Upper__c - sc.Lower__c) + score);
                    }
                }
                else
                {
                    if (sc.LowerTo__c == '>=')
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : score - (sc1/(sc.Upper__c - sc.Lower__c + 0.0001)) + 1;
                    }
                    else
                    {
                        scoreValues = (sc.Upper__c - sc.Lower__c) == 0 ? score : score - (sc1/(sc.Upper__c - sc.Lower__c)) + 1;
                    }
                }
                
                scoreValues  = scoreValues > 4 ? 4 : (scoreValues < 1 ? 1 : scoreValues);
                
                Score1 = scoreValues;
                break;
            }
        }
        return score1;
    }
   
    global void finish(Database.BatchableContext BC){
          
         List <SPE_ScorecardTempValues__c > scTemp = [SELECT Id,ScoreCard__c FROM SPE_ScorecardTempValues__c 
                                                     WHERE ScoreCard__r.Identifier__c=: scIdentifier AND ScoreCard__c != null limit 1];
         SPE_ScoreCard__c scardTemp = new SPE_ScoreCard__c();
         try{
             ScorecardId = scTemp[0].ScoreCard__c;
             system.debug('ScorecardId::'+ScorecardId);
             scardTemp = [Select id,ScorecardTracker__r.ScorecardGenerator__c From SPE_ScoreCard__c Where Id =:ScorecardId];
             scGenRecordId = scardTemp.ScorecardTracker__r.ScorecardGenerator__c;
             system.debug('scGenRecordId::'+scGenRecordId);
             List<SPE_ScoreCard__c> scardList = new List<SPE_ScoreCard__c>();         
             scardList =[Select id,ScorecardTracker__r.ScorecardGenerator__c,ScorecardTracker__r.Status__c,Contact__c,Approver__c,
                         ScorecardTracker__r.ScorecardGenerator__r.IsAutoApproved__c,ScorecardTracker__r.ScorecardGenerator__r.isAutoDistributionON__c
                         from SPE_ScoreCard__c Where ScorecardTracker__r.ScorecardGenerator__c =:scGenRecordId
                         AND ScorecardTracker__r.Status__c = 'Completed'];
             system.debug('scardList ::'+scardList);                                        
             Set<String> scardIds = new Set<String>();
             for(SPE_ScoreCard__c sc :scardList){
                 if(sc.Contact__c !=null && sc.Approver__c !=null && sc.ScorecardTracker__r.ScorecardGenerator__r.IsAutoApproved__c && sc.ScorecardTracker__r.ScorecardGenerator__r.isAutoDistributionON__c){
                     SPE_SendScorecard.SendScorecard(sc.Id);
                 }
             }
         }catch(exception e){}
         
         
    }
 }