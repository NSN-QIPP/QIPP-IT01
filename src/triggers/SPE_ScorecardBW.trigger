trigger SPE_ScorecardBW on SPE_ScoreCard__c (before insert, before update, After update) {
    set<id> scorecardtracker1 = new set<id>(); //veera
    for(SPE_ScoreCard__c s1:trigger.new ) //veera
        scorecardtracker1.add(s1.ScorecardTracker__c);//veera
if(trigger.isBefore && trigger.IsInsert) {
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
      for(SPE_ScoreCard__c s:trigger.new ) 
      scorecardtracker.add(s.ScorecardTracker__c); 
      
      Date D;
      for(SPE_ScorecardTracker__c s:[select id,DateOfExecution__c,ScorecardGenerator__r.IsAdhoc__c, ScorecardGenerator__c,ScorecardGenerator__r.IsAutoApproved__c,ScorecardGenerator__r.isAutoDistributionON__c,ScorecardGenerator__r.AggregationType__c,ScorecardGenerator__r.TimeFrame__c
                                     from SPE_ScorecardTracker__c where id IN:scorecardtracker ]){
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
      
      
      
      for(SPE_ScoreCard__c s:trigger.new){
      
          String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
          Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
          String hexDigest = EncodingUtil.convertToHex(hash);
          s.Approver__c=  ApproverMap.get(s.Supplier__c);
          s.Contact__c=SupplierCOntactMap.get(s.Supplier__c);
          s.CCContact1__c=SuppliercCOntactMap1.get(s.Supplier__c);
          s.CCContact2__c=SuppliercCOntactMap2.get(s.Supplier__c);
          if(GeneratorScoretempMap.get(s.ScorecardTracker__c))
              s.Stage__c='Approved';
          s.isAutoDistributionON__c = GeneratorScoreDistMap.get(s.ScorecardTracker__c);
          if(s.Password__c == null || s.Password__c == '')
          {
              s.Password__c = hexDigest;
          }
          if(GeneratorScoreDistMap.get(s.ScorecardTracker__c) == true && s.Stage__c=='Approved')
          {
              s.Distribute_Scorecard__c = 'DISTRIBUTED';
              
          }
          if(s.Stage__c=='Approved' && s.isInternalScorecard__c == false)
          {
              s.Distribute_Scorecard__c = 'DISTRIBUTED';
              
          }
          s.AggregationType__c=GeneratorScoreAgggregation.get(s.ScorecardTracker__c);
          s.Aggregation_Duration__c=Integer.ValueOf(GeneratorDurationAgggregation.get(s.ScorecardTracker__c)); 
          Date myDate = Date.newInstance(1960, 2, 17);
          
          if(GeneratorScoreAdhoc.get(s.ScorecardTracker__c) == false)
              s.StartDate__c=Date.newInstance(d.year(), integer.valueOf(d.month()-s.Aggregation_Duration__c), 1);
               
          Date dd=d.addMonths(-1);
          integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
          if(GeneratorScoreAdhoc.get(s.ScorecardTracker__c) == false)
              s.EndDate__c= Date.newInstance( dd.year(), dd.month(), noOfDays);
          s.isAdhoc__c=GeneratorScoreAdhoc.get(s.ScorecardTracker__c);    
          if(GeneratorScoreAdhoc.get(s.ScorecardTracker__c) == false){
              s.StartDate__c= s.StartDate__c.addMonths(1);
             
              s.EndDate__c= s.EndDate__c.addMonths(1);
          }
      
      }
        
        


if(trigger.new[0].AggregationType__c!='Rules Driven Averaging')
{
trigger.new[0].AggregationRule__c=trigger.new[0].AggregationType__c;
}
else {
list<SPE_BWRuleConfigurator__c> bw= new list<SPE_BWRuleConfigurator__c>();
bw=[select AveragingLogic__c,Nego_Responsible__c from SPE_BWRuleConfigurator__c where Category__c=:trigger.new[0].category__c and CategoryGroup__c=:trigger.new[0].CategoryGroup__c and CategoryArea__c=:trigger.new[0].CategoryCluster__c
                    and Market__c=:trigger.new[0].Region__c and Market_Unit__c=:trigger.new[0].subregion__c and country__c=:trigger.new[0].country__c and project__c=:trigger.new[0].project__c];
    if(bw.size()>0){
        trigger.new[0].AggregationRule__c=bw[0].AveragingLogic__c;
        trigger.new[0].Nego_Responsible__c=bw[0].Nego_Responsible__c;
    }
     else{
                trigger.new[0].AggregationRule__c='Simple Average';
         }
        
        }
    }


if(trigger.isBefore && trigger.IsUpdate) {
if(trigger.new[0].Stage__c=='Approved' && trigger.new[0].isInternalScorecard__c == false)
{
trigger.new[0].Distribute_Scorecard__c = 'DISTRIBUTED';
             
}


if(trigger.new[0].AggregationType__c!='Rules Driven Averaging')
{
trigger.new[0].AggregationRule__c=trigger.new[0].AggregationType__c;
}
else {
list<SPE_BWRuleConfigurator__c> bw= new list<SPE_BWRuleConfigurator__c>();
bw=[select AveragingLogic__c,Nego_Responsible__c from SPE_BWRuleConfigurator__c where Category__c=:trigger.new[0].category__c and CategoryGroup__c=:trigger.new[0].CategoryGroup__c and CategoryArea__c=:trigger.new[0].CategoryCluster__c];
    if(bw.size()>0){
        trigger.new[0].Nego_Responsible__c=bw[0].Nego_Responsible__c;
        trigger.new[0].AggregationRule__c=bw[0].AveragingLogic__c;
    }  else{
                trigger.new[0].AggregationRule__c='Simple Average';
            }
        
        }
    


//BW Calculations 



set<id> SPETemplateIds =new set<id>();
set<id> SPETrackerIds = new set<Id>();
set<id> SPEPlans= new set<Id>();

//
if(!trigger.new[0].isAdhoc__c)
{
for(SPE_ScorecardSPETemplateMap__c c:[select id,SPETemplate__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c=:trigger.new[0].ScorecardTemplate__c])
SPETemplateIds.add(c.SPETemplate__c);
//list of SPE Template Id's

Date Startdate=trigger.new[0].StartDate__c;
date endDate=trigger.new[0].EndDate__c;
string status='Completed';
string q='select id from SPE_SPETracker__c where SPETemplate__c IN :SPETemplateIds and status__c=:status and DateOfExecution__c>=:Startdate and  DateOfExecution__c<=:endDate';
            
            /**
            if(!(trigger.new[0].project__c).containsIgnoreCase('All')){
                project=trigger.new[0].project__c;
                q=q+' and Project__c=:project';
                }
            if(!(trigger.new[0].Country__c).containsIgnoreCase('All')){
                Country=trigger.new[0].Country__c;
                q=q+' and Country__c=:Country';
                }
            if(!(trigger.new[0].SubRegion__c).containsIgnoreCase('All')){
                SubRegion=trigger.new[0].SubRegion__c;
                q=q+' and Sub_Region__c=:SubRegion';
                }
            if(!(trigger.new[0].Region__c).containsIgnoreCase('All')){
                Region=trigger.new[0].Region__c;
                q=q+' and Region__c=:Region and Nego_Responsible__c=:nego';            
                }
                **/
                
             String CategoryArea;
             String CategoryGroup;
             String Category; 
             String country; 
             string project; 
             string SubMarket;
             string market;
             string product;
             string bl;
             string bu;
             if(!(trigger.new[0].country__c).containsIgnoreCase('All')){
                country=trigger.new[0].country__c;
                q=q+' and country__c=:country';
                }
            if(!(trigger.new[0].Project__c).containsIgnoreCase('All')){
                project=trigger.new[0].Project__c;
                q=q+' and Project__c=:project';
                }
            if(!(trigger.new[0].SubRegion__c).containsIgnoreCase('All')){
                SubMarket=trigger.new[0].SubRegion__c;
                q=q+' and SubRegion__c=:SubMarket';
                }
            if(!(trigger.new[0].Region__c).containsIgnoreCase('All')){
                market=trigger.new[0].Region__c;
                q=q+' and Region__c=:market';
                } 
                
            if(!(trigger.new[0].CategoryCluster__c).containsIgnoreCase('All')){
                CategoryArea=trigger.new[0].CategoryCluster__c;
                q=q+' and CategoryCluster__c=:CategoryArea';
                }
            if(!(trigger.new[0].CategoryGroup__c).containsIgnoreCase('All')){
                CategoryGroup=trigger.new[0].CategoryGroup__c;
                q=q+' and CategoryGroup__c=:CategoryGroup';
                }
            if(!(trigger.new[0].Category__c ).containsIgnoreCase('All')){
                Category=trigger.new[0].Category__c ;
                q=q+' and Category__c=:Category';
                } 
                
                
             if(!(trigger.new[0].Product__c).containsIgnoreCase('All')){
                product=trigger.new[0].Product__c;
                q=q+' and Product__c=:product';
                }
            if(!(trigger.new[0].BusinessLine__c).containsIgnoreCase('All')){
                bl=trigger.new[0].BusinessLine__c;
                q=q+' and BusinessLine__c=:bl';
                }
            if(!(trigger.new[0].BusinessUnit__c).containsIgnoreCase('All')){
                bu=trigger.new[0].BusinessUnit__c;
                q=q+' and BusinessUnit__c=:bu';
                }   

for(SPE_SPETracker__c s:Database.query(q))
SPETrackerIds.add(s.id);

}



//Adhoc Scorecard
if(trigger.new[0].isAdhoc__c)
{

SPE_ScorecardTracker__c sss= new SPE_ScorecardTracker__c();
sss=[select id,ScorecardGenerator__c from SPE_ScorecardTracker__c where id=:trigger.new[0].ScorecardTracker__c];
system.debug('******************'+trigger.new[0].ScorecardTracker__r.ScorecardGenerator__c);
for(SPE_Scorecard_Plan__c c:[select id,SPE_Plan__c from SPE_Scorecard_Plan__c where Scorecard_Generator__c=:sss.ScorecardGenerator__c ])
SPEPlans.add(c.SPE_Plan__c );
//list of SPE Plans Id's
system.debug('******************1'+SPEPlans);
for(SPE_SPETracker__c s:[select id from SPE_SPETracker__c where SPEPlan__c IN :SPEPlans and status__c='Completed' and DateOfExecution__c>=:trigger.new[0].StartDate__c and  DateOfExecution__c<=:trigger.new[0].EndDate__c ])
SPETrackerIds.add(s.id);
    system.debug('******************2'+SPETrackerIds);
}





list<SPE_TrackerValues__c> trackerValues= new list<SPE_TrackerValues__c>();
trackerValues=[select id,Supplier__c,KPIDefinition__c,SPE_TemplateName__c,SPETracker__r.SPEPlan__c from SPE_TrackerValues__c where SPETracker__c IN:SPETrackerIds and Supplier__c=:trigger.new[0].Supplier__c];

list<SPE_ScorecardTempValues__c> tobeinsert= new list<SPE_ScorecardTempValues__c>();

for(SPE_TrackerValues__c i:trackerValues){
SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c();
s.SPETracker__c=i.id;
s.SPE_Plan__c=i.SPETracker__r.SPEPlan__c;
s.ScoreCard__c=trigger.new[0].id;
s.Supplier__c=i.Supplier__c;
s.KPI__c=i.KPIDefinition__c;
s.SPE_TemplateName__c=i.SPE_TemplateName__c;
tobeinsert.add(s);
}

for(SPE_TrackerScore__c t:[select id,Supplier__c,SPE_TemplateName__c,group__c,SPETracker__r.SPEPlan__c from SPE_TrackerScore__c where SPETracker__c IN :SPETrackerIds AND Supplier__c=:trigger.new[0].Supplier__c ]) {

SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c();
s.Tracker_Score__c=t.id;
s.SPE_Plan__c=t.SPETracker__r.SPEPlan__c;
s.ScoreCard__c=trigger.new[0].id;
s.Supplier__c=t.Supplier__c;
s.Group__c=t.Group__c;
s.SPE_TemplateName__c=t.SPE_TemplateName__c;
tobeinsert.add(s);
}


if(tobeinsert.size()>0){
delete [select id from SPE_ScorecardTempValues__c where ScoreCard__c=: trigger.new[0].id];

insert tobeinsert;
system.debug('tobeinserttobeinsert'+tobeinsert);
if(trigger.new[0].AggregationRule__c=='BW with Project Simple Average') {
    list<SPE_ScorecardTempValues__c> newtemp= new list<SPE_ScorecardTempValues__c >();
    AggregateResult[] groupedResults =new List<AggregateResult>(); 
    groupedResults =[SELECT category__c,categoryArea__c,categoryGroup__c,market__c,marketunit__c,country__c,SPE_TemplateName__c,KPI__c,AVG(Score1__c) sum FROM SPE_ScorecardTempValues__c where ScoreCard__c=:trigger.new[0].id and IsProjectlevel__c=true GROUP BY SPE_TemplateName__c,KPI__c,category__c,categoryArea__c,categoryGroup__c,market__c,marketunit__c,country__c];    
    system.debug('newtempnewtemp'+groupedResults);
    for (AggregateResult ar : groupedResults)  {
        SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c ();
        s.SPE_TemplateName__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        s.CrunchedScores__c=Decimal.valueOf(String.valueOf(ar.get('sum'))); // Decimal.valueOf(String.valueOf(ar.get('weight')));
        s.scorecard__c=trigger.new[0].id;
        s.kpi__c=String.valueOf(ar.get('KPI__c'));
        s.category__c=String.valueOf(ar.get('category__c'));
        s.categoryArea__c=String.valueOf(ar.get('categoryArea__c'));
        s.categoryGroup__c=String.valueOf(ar.get('categoryGroup__c'));
        s.market__c=String.valueOf(ar.get('market__c'));
        s.marketunit__c=String.valueOf(ar.get('marketunit__c'));
        s.country__c=String.valueOf(ar.get('country__c'));
        newtemp.add(s);
         system.debug('newtempnewtemp'+newtemp);
    }
        
        system.debug('***********newtemp'+newtemp.size());
        if(newtemp.size()>0){
            delete [select id from SPE_ScorecardTempValues__c where ScoreCard__c=: trigger.new[0].id and IsProjectlevel__c=true];
            insert newtemp;
           
        }       
} 
        system.debug('trigger.new[0].isExecute__c::'+trigger.new[0].isExecute__c);
        if(trigger.new[0].isExecute__c){
            if(!Test.isRunningTest()){
                SPE_ScorecardGenerateValues dtbatch= new SPE_ScorecardGenerateValues (string.valueOf(trigger.new[0].id),scorecardtracker1);
                database.executebatch(dtBatch,1);
            }
        }    
    }

}

}