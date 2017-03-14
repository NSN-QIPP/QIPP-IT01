global class SPE2_AutoScorecardGenerate implements Database.Batchable<sObject> 
{
    global Id ScorecardId;
    global String scIdentifier;
    global String query;
    
    public SPE2_AutoScorecardGenerate (String scIdentifier){
        this.scIdentifier = scIdentifier;
        //scIdentifier = system.now()+';'+userInfo.getUserId();        
    }
    

    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = '';        
        query = 'SELECT Id,Nego_Responsible__c,Identifier__c,AggregationRule__c,StartDate__c,endDate__c,ScorecardTracker__c,Supplier__c,isExecute__c FROM SPE_ScoreCard__c WHERE Identifier__c=: scIdentifier ';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List <SPE_ScoreCard__c > scope){
        for(SPE_ScoreCard__c  scp :scope){
            set<Id> GenratorSet = new set<id>();  
            set<id> scorecardtracker = new set<id>();  
            map<Id,Id> ApproverMap= new map<Id,Id>();
            map<Id,Id> SupplierCOntactMap= new map<Id,Id>();
            map<Id,Id> SuppliercCOntactMap1= new map<Id,Id>();
            map<Id,Id> SuppliercCOntactMap2= new map<Id,Id>();
            Map<Id,boolean> GeneratorScoretempMap= new Map<id,boolean>();
            Map<Id,boolean> GeneratorScoreDistMap= new Map<id,boolean>();
            Map<Id,string> GeneratorScoreAgggregation= new Map<Id,string>();    
            Map<Id,string> GeneratorDurationAgggregation= new Map<Id,string>();
            Map<Id,boolean> GeneratorScoreAdhoc= new Map<id,boolean>();
            scorecardtracker.add(scp.ScorecardTracker__c); 
            
              Date D;
              for(SPE_ScorecardTracker__c s:[select id,DateOfExecution__c,ScorecardGenerator__r.IsAdhoc__c, ScorecardGenerator__c,ScorecardGenerator__r.IsAutoApproved__c,ScorecardGenerator__r.isAutoDistributionON__c,ScorecardGenerator__r.AggregationType__c,ScorecardGenerator__r.TimeFrame__c
                                             from SPE_ScorecardTracker__c where id IN:scorecardtracker]){
                  GenratorSet.add(s.ScorecardGenerator__c);
                  GeneratorScoretempMap.put(s.id,s.ScorecardGenerator__r.IsAutoApproved__c);
                  GeneratorScoreDistMap.put(s.id,s.ScorecardGenerator__r.isAutoDistributionON__c); 
                  GeneratorScoreAgggregation.put(s.id,s.ScorecardGenerator__r.AggregationType__c); 
                  GeneratorDurationAgggregation.put(s.id,s.ScorecardGenerator__r.TimeFrame__c); 
                  GeneratorScoreAdhoc.put(s.id,s.ScorecardGenerator__r.IsAdhoc__c);
                  d= s.DateOfExecution__c;
              }
            list<SPE_ScorecardSupplierMap__c> ScSupplier= new list<SPE_ScorecardSupplierMap__c>();
        
          ScSupplier=[select id,Approver__c,SupplierContact__c,Supplier__c,CC_Contact2__c,CC_Contact1__c from SPE_ScorecardSupplierMap__c where ScorecardGenerator__c IN :GenratorSet ];
          
          for(SPE_ScorecardSupplierMap__c s:ScSupplier)  {
              ApproverMap.put(s.Supplier__c, s.Approver__c);
              SupplierCOntactMap.put(s.Supplier__c,s.SupplierContact__c);
              SuppliercCOntactMap2.put(s.Supplier__c,s.CC_Contact2__c);
              SuppliercCOntactMap1.put(s.Supplier__c,s.CC_Contact1__c );
          }  
          //for(SPE_ScoreCard__c s: scope[0]){
      
              String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
              Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
              String hexDigest = EncodingUtil.convertToHex(hash);
              scp.Approver__c=  ApproverMap.get(scp.Supplier__c);
              scp.Contact__c=SupplierCOntactMap.get(scp.Supplier__c);
              scp.CCContact1__c=SuppliercCOntactMap1.get(scp.Supplier__c);
              scp.CCContact2__c=SuppliercCOntactMap2.get(scp.Supplier__c);
              
              if(GeneratorScoretempMap.get(scp.ScorecardTracker__c))
                  scp.Stage__c='Approved';
              scp.isAutoDistributionON__c = GeneratorScoreDistMap.get(scp.ScorecardTracker__c);
              if(scp.Password__c == null || scp.Password__c == '')
              {
                  //scp.Password__c = hexDigest;
              }
              if(GeneratorScoreDistMap.get(scp.ScorecardTracker__c) == true && scp.Stage__c=='Approved')
              {
                  scp.Distribute_Scorecard__c = 'DISTRIBUTED';
                  
              }
              if(scp.Stage__c=='Approved' && scp.isInternalScorecard__c == false)
              {
                  scp.Distribute_Scorecard__c = 'DISTRIBUTED';
                  
              }
              scp.AggregationType__c=GeneratorScoreAgggregation.get(scp.ScorecardTracker__c);
              scp.AggregationRule__c=GeneratorScoreAgggregation.get(scp.ScorecardTracker__c);
              scp.Aggregation_Duration__c=Integer.ValueOf(GeneratorDurationAgggregation.get(scp.ScorecardTracker__c)); 
              Date myDate = Date.newInstance(1960, 2, 17);
              
              if(GeneratorScoreAdhoc.get(scp.ScorecardTracker__c) == false)
                  scp.StartDate__c=Date.newInstance(d.year(), integer.valueOf(d.month()-scp.Aggregation_Duration__c), 1);
              
              Date dd=d.addMonths(-1);
              integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
              if(GeneratorScoreAdhoc.get(scp.ScorecardTracker__c) == false)
                  scp.EndDate__c= Date.newInstance( dd.year(), dd.month(), noOfDays);
              scp.isAdhoc__c=GeneratorScoreAdhoc.get(scp.ScorecardTracker__c);    
              if(GeneratorScoreAdhoc.get(scp.ScorecardTracker__c) == false){
                  scp.StartDate__c= scp.StartDate__c.addMonths(1);
                  scp.EndDate__c= scp.EndDate__c.addMonths(1);
              }
      
          //}
              if(scp.AggregationType__c!='Rules Driven Averaging'){
                  scp.AggregationRule__c=scp.AggregationType__c;
              }
            else{
                list<SPE_BWRuleConfigurator__c> bw= new list<SPE_BWRuleConfigurator__c>();
                bw=[select AveragingLogic__c,Nego_Responsible__c from SPE_BWRuleConfigurator__c where Category__c=:scp.category__c and CategoryGroup__c=:scp.CategoryGroup__c and CategoryArea__c=:scp.CategoryCluster__c
                and Market__c=:scp.Region__c and Market_Unit__c=:scp.subregion__c and country__c=:scp.country__c and project__c=:scp.project__c];
                if(bw.size()>0){
                    scp.AggregationRule__c=bw[0].AveragingLogic__c;
                    scp.Nego_Responsible__c=bw[0].Nego_Responsible__c;
                }
                else{
                    scp.AggregationRule__c='Simple Average';
                 }
                
            }
            
            if(scp.Stage__c=='Approved' && scp.isInternalScorecard__c == false){
                scp.Distribute_Scorecard__c = 'DISTRIBUTED';             
            }
            try{
                update scp;
            }catch(Exception e){}
            set<id> SPETrackerIds = new set<Id>();
            SPE_ScorecardTracker__c sss= new SPE_ScorecardTracker__c();
            sss=[select id,ScorecardGenerator__c from SPE_ScorecardTracker__c where id=:scp.ScorecardTracker__c];
            set<id> SPEPlans= new set<Id>();
            for(SPE_Scorecard_Plan__c c:[select id,SPE_Plan__c from SPE_Scorecard_Plan__c where Scorecard_Generator__c=:sss.ScorecardGenerator__c ])
            SPEPlans.add(c.SPE_Plan__c );
            //list of SPE Plans Id's

            for(SPE_SPETracker__c s:[select id from SPE_SPETracker__c where SPEPlan__c IN :SPEPlans and status__c='Completed' and DateOfExecution__c>=:scp.StartDate__c and  DateOfExecution__c<=:scp.EndDate__c ])
            SPETrackerIds.add(s.id);
            
            list<SPE_TrackerValues__c> trackerValues= new list<SPE_TrackerValues__c>();
            trackerValues=[select id,Supplier__c,KPIDefinition__c,SPE_TemplateName__c,SPETracker__r.SPEPlan__c from SPE_TrackerValues__c where SPETracker__c IN:SPETrackerIds and Supplier__c=:scp.Supplier__c];

            list<SPE_ScorecardTempValues__c> tobeinsert= new list<SPE_ScorecardTempValues__c>();

            for(SPE_TrackerValues__c i:trackerValues){
            SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c();
            s.SPETracker__c=i.id;
            s.SPE_Plan__c=i.SPETracker__r.SPEPlan__c;
            s.ScoreCard__c=scp.id;
            s.Supplier__c=i.Supplier__c;
            s.KPI__c=i.KPIDefinition__c;
            s.SPE_TemplateName__c=i.SPE_TemplateName__c;
            
            tobeinsert.add(s);
            }

            for(SPE_TrackerScore__c t:[select id,Supplier__c,SPE_TemplateName__c,group__c,SPETracker__r.SPEPlan__c from SPE_TrackerScore__c where SPETracker__c IN :SPETrackerIds AND Supplier__c=:scp.Supplier__c ]) {

            SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c();
            s.Tracker_Score__c=t.id;
            s.SPE_Plan__c=t.SPETracker__r.SPEPlan__c;
            s.ScoreCard__c=scp.id;
            s.Supplier__c=t.Supplier__c;
            s.Group__c=t.Group__c;
            s.SPE_TemplateName__c=t.SPE_TemplateName__c;
            tobeinsert.add(s);
            }


            if(tobeinsert.size()>0){
            delete [select id from SPE_ScorecardTempValues__c where ScoreCard__c=: scp.id];

            insert tobeinsert;

            if(scp.AggregationRule__c=='BW with Project Simple Average') {
                list<SPE_ScorecardTempValues__c> newtemp= new list<SPE_ScorecardTempValues__c >();
                AggregateResult[] groupedResults =new List<AggregateResult>(); 
                groupedResults =[SELECT category__c,categoryArea__c,categoryGroup__c,market__c,marketunit__c,country__c,SPE_TemplateName__c,KPI__c,AVG(Score1__c) sum FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scp.id and IsProjectlevel__c=true GROUP BY SPE_TemplateName__c,KPI__c,category__c,categoryArea__c,categoryGroup__c,market__c,marketunit__c,country__c];    
               
                for (AggregateResult ar : groupedResults)  {
                    SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c ();
                    s.SPE_TemplateName__c=String.valueOf(ar.get('SPE_TemplateName__c'));
                    s.CrunchedScores__c=Decimal.valueOf(String.valueOf(ar.get('sum'))); // Decimal.valueOf(String.valueOf(ar.get('weight')));
                    s.scorecard__c=scp.id;
                    s.kpi__c=String.valueOf(ar.get('KPI__c'));
                    s.category__c=String.valueOf(ar.get('category__c'));
                    s.categoryArea__c=String.valueOf(ar.get('categoryArea__c'));
                    s.categoryGroup__c=String.valueOf(ar.get('categoryGroup__c'));
                    s.market__c=String.valueOf(ar.get('market__c'));
                    s.marketunit__c=String.valueOf(ar.get('marketunit__c'));
                    s.country__c=String.valueOf(ar.get('country__c'));
                    newtemp.add(s);
                }
                    
                    system.debug('***********newtemp'+newtemp.size());
                    if(newtemp.size()>0){
                        delete [select id from SPE_ScorecardTempValues__c where ScoreCard__c=: scp.id and IsProjectlevel__c=true];
                        insert newtemp;
                    }       
            } 
                      
    }
            
        }
    }
    global void finish(Database.BatchableContext BC){
        if(!Test.isRunningTest()){
            SPE2_ScorecardAutoGenerateValues dtbatch= new SPE2_ScorecardAutoGenerateValues(scIdentifier);
            database.executebatch(dtBatch,1);
        }
    }
 }