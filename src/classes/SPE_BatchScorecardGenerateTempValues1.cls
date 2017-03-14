global class SPE_BatchScorecardGenerateTempValues1 implements Database.Batchable<sObject>,Schedulable  {


    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(1));
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Date dddd=system.today()-1;
        String query = 'SELECT Id,Supplier__c,ScorecardTemplate__c,ScorecardTracker__r.ScorecardGenerator__c,ScorecardTracker__c,country__c,Project__c,Region__c,SubRegion__c,Category__c ,CategoryGroup__c,CategoryCluster__c,BusinessUnit__c,BusinessLine__c,Product__c,isAdhoc__c,StartDate__c,EndDate__c FROM SPE_ScoreCard__c WHERE CreatedDate>=:dddd';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_ScoreCard__c > scope) 
    {
         set<id> SPETemplateIds =new set<id>();
        set<id> SPETrackerIds = new set<Id>();
        set<id> SPEPlans= new set<Id>();
        
        //
        if(!scope[0].isAdhoc__c)
        {
        for(SPE_ScorecardSPETemplateMap__c c:[select id,SPETemplate__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c=:scope[0].ScorecardTemplate__c])
        SPETemplateIds.add(c.SPETemplate__c);
        //list of SPE Template Id's
        
        Date Startdate=scope[0].StartDate__c;
        date endDate=scope[0].EndDate__c;
        string status='Completed';
        string q='select id from SPE_SPETracker__c where SPETemplate__c IN :SPETemplateIds and status__c=:status and DateOfExecution__c>=:Startdate and  DateOfExecution__c<=:endDate';
                        
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
                     if(!(scope[0].country__c).containsIgnoreCase('All')){
                        country=scope[0].country__c;
                        q=q+' and country__c=:country';
                        }
                    if(!(scope[0].Project__c).containsIgnoreCase('All')){
                        project=scope[0].Project__c;
                        q=q+' and Project__c=:project';
                        }
                    if(!(scope[0].SubRegion__c).containsIgnoreCase('All')){
                        SubMarket=scope[0].SubRegion__c;
                        q=q+' and SubRegion__c=:SubMarket';
                        }
                    if(!(scope[0].Region__c).containsIgnoreCase('All')){
                        market=scope[0].Region__c;
                        q=q+' and Region__c=:market';
                        } 
                        
                    if(!(scope[0].CategoryCluster__c).containsIgnoreCase('All')){
                        CategoryArea=scope[0].CategoryCluster__c;
                        q=q+' and CategoryCluster__c=:CategoryArea';
                        }
                    if(!(scope[0].CategoryGroup__c).containsIgnoreCase('All')){
                        CategoryGroup=scope[0].CategoryGroup__c;
                        q=q+' and CategoryGroup__c=:CategoryGroup';
                        }
                    if(!(scope[0].Category__c ).containsIgnoreCase('All')){
                        Category=scope[0].Category__c ;
                        q=q+' and Category__c=:Category';
                        } 
                        
                        
                     if(!(scope[0].Product__c).containsIgnoreCase('All')){
                        product=scope[0].Product__c;
                        q=q+' and Product__c=:product';
                        }
                    if(!(scope[0].BusinessLine__c).containsIgnoreCase('All')){
                        bl=scope[0].BusinessLine__c;
                        q=q+' and BusinessLine__c=:bl';
                        }
                    if(!(scope[0].BusinessUnit__c).containsIgnoreCase('All')){
                        bu=scope[0].BusinessUnit__c;
                        q=q+' and BusinessUnit__c=:bu';
                        }   
                        
        for(SPE_SPETracker__c s:Database.query(q))
        SPETrackerIds.add(s.id);
        
        }
        
        
        
        //Adhoc Scorecard
        if(scope[0].isAdhoc__c)
        {
        
        SPE_ScorecardTracker__c sss= new SPE_ScorecardTracker__c();
        sss=[select id,ScorecardGenerator__c from SPE_ScorecardTracker__c where id=:scope[0].ScorecardTracker__c];
        system.debug('******************'+scope[0].ScorecardTracker__r.ScorecardGenerator__c);
        for(SPE_Scorecard_Plan__c c:[select id,SPE_Plan__c from SPE_Scorecard_Plan__c where Scorecard_Generator__c=:sss.ScorecardGenerator__c ])
        SPEPlans.add(c.SPE_Plan__c );
        //list of SPE Plans Id's
        
        for(SPE_SPETracker__c s:[select id from SPE_SPETracker__c where SPEPlan__c IN :SPEPlans and status__c='Completed' and DateOfExecution__c>=:scope[0].StartDate__c and  DateOfExecution__c<=:scope[0].EndDate__c ])
        SPETrackerIds.add(s.id);
        }
        
        
        
        
        
        list<SPE_TrackerValues__c> trackerValues= new list<SPE_TrackerValues__c>();
        trackerValues=[select id,Supplier__c,KPIDefinition__c,SPE_TemplateName__c,SPETracker__r.SPEPlan__c from SPE_TrackerValues__c where SPETracker__c IN:SPETrackerIds and Supplier__c=:scope[0].Supplier__c];
        
        list<SPE_ScorecardTempValues__c> tobeinsert= new list<SPE_ScorecardTempValues__c>();
        
        for(SPE_TrackerValues__c i:trackerValues){
        SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c();
        s.SPETracker__c=i.id;
        s.SPE_Plan__c=i.SPETracker__r.SPEPlan__c;
        s.ScoreCard__c=scope[0].id;
        s.Supplier__c=i.Supplier__c;
        s.KPI__c=i.KPIDefinition__c;
        s.SPE_TemplateName__c=i.SPE_TemplateName__c;
        tobeinsert.add(s);
        }
        
        for(SPE_TrackerScore__c t:[select id,Supplier__c,SPE_TemplateName__c,group__c,SPETracker__r.SPEPlan__c from SPE_TrackerScore__c where SPETracker__c IN :SPETrackerIds AND Supplier__c=:scope[0].Supplier__c ]) {
        
        SPE_ScorecardTempValues__c s= new SPE_ScorecardTempValues__c();
        s.Tracker_Score__c=t.id;
        s.SPE_Plan__c=t.SPETracker__r.SPEPlan__c;
        s.ScoreCard__c=scope[0].id;
        s.Supplier__c=t.Supplier__c;
        s.Group__c=t.Group__c;
        s.SPE_TemplateName__c=t.SPE_TemplateName__c;
        tobeinsert.add(s);
        }
        
        
        if(tobeinsert.size()>0){
        delete [select id from SPE_ScorecardTempValues__c where ScoreCard__c=: scope[0].id];
        
        insert tobeinsert;
        
        }
           
    }
    
    
    
    
    
    
    
    
    
    
    
    
    global void finish(Database.BatchableContext BC) 
    {        
    SPE_BatchScorecardGenerateTempValues2 dt= new SPE_BatchScorecardGenerateTempValues2 ();
    database.executeBatch(dt,1);
    }
 }