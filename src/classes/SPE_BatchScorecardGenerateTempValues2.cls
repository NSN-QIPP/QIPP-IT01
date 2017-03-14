global class SPE_BatchScorecardGenerateTempValues2 implements Database.Batchable<sObject>,Schedulable  {


    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(1));
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        set<id> scorecardId= new set<id>();
         Date dddd=system.today()-1;
        for(SPE_ScoreCard__c s:[select id from SPE_ScoreCard__c where createdDate>=:dddd]) {
           scorecardId.add(s.id);  
        } 
        
        String query = 'SELECT Id,ScoreCard__r.Nego_Responsible__c,Supplier__c,SPE_Plan__c ,DateOfExecution__c,ScoreCard__r.AggregationRule__c, Tracker_Score__c,Weight__c FROM SPE_ScorecardTempValues__c WHERE ScoreCard__c IN: scorecardId ';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_ScorecardTempValues__c > scope) 
    {
         // Simple average
     if(scope[0].ScoreCard__r.AggregationRule__c=='Simple Average'){
      scope[0].Weight__c=1;
     }
     
     
     // Spend Calculations
     if(scope[0].ScoreCard__r.AggregationRule__c=='Weighted Average by Spend'){
         list<SPE_SPEPlan__c> plans=new list<SPE_SPEPlan__c>();
            plans=[select id from SPE_SPEPlan__c];
            String project;
            String Country;
            String SubRegion;
            String Region;
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scope[0].Supplier__c;
            Date dd=scope[0].DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= Date.newInstance( dd.year(), dd.month(), noOfDays);
            Date startDate= Date.newInstance( dd.year(), dd.month(), 1);
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,AggregationDuration__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scope[0].SPE_Plan__c ] ;      
            if(integer.valueOf(planDetail.AggregationDuration__c)>1)
            {
            Date ddd=scope[0].DateOfExecution__c.addMonths(-integer.valueOf(planDetail.AggregationDuration__c));
            startDate= Date.newInstance( ddd.year(), ddd.month(), 1);  
            }
            string nego='';
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
                if(Scope[0].ScoreCard__r.Nego_Responsible__c=='' || Scope[0].ScoreCard__r.Nego_Responsible__c=='R')
                 {nego='R';
                     q=q+' and Region__c=:Region and Nego_Responsible__c=:nego';
                 }
                 else if(Scope[0].ScoreCard__r.Nego_Responsible__c=='G') {
                 nego='R';
                 q=q+' and Region__c=:Region and Nego_Responsible__c=:nego';            
                 }
                 
                 else if(Scope[0].ScoreCard__r.Nego_Responsible__c=='R+G') {
                 nego='R';
                 nego1='G';
                 q=q+' and Region__c=:Region and (Nego_Responsible__c=:nego OR Nego_Responsible__c=:nego1)'; 
                 }            
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
            
            
            
            decimal Spend=0.0;
            for(SPE_Spend__c s:Database.query(q)){
            spend=spend+ s.spend__c;
            }
            
            if(spend!=0.0)
            scope[0].Weight__c=spend;
        }
        
        
        
        
        
        
     // Spend Calculations
     if(scope[0].ScoreCard__r.AggregationRule__c=='Weighted Average by Volume'){
                  
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scope[0].Supplier__c;
            Date dd=scope[0].DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= Date.newInstance( dd.year(), dd.month(), noOfDays);
            Date startDate= Date.newInstance( dd.year(), dd.month(), 1);
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,AggregationDuration__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scope[0].SPE_Plan__c ] ;      
          
            if(integer.valueOf(planDetail.AggregationDuration__c)>1)
            {
            Date ddd=scope[0].DateOfExecution__c.addMonths(-integer.valueOf(planDetail.AggregationDuration__c));
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
            scope[0].Weight__c=volume;
        }
        
        
        
        // logic 4
        if(scope[0].ScoreCard__r.AggregationRule__c=='BW with Project Simple Average') {
            list<SPE_SPEPlan__c> plans=new list<SPE_SPEPlan__c>();
            plans=[select id from SPE_SPEPlan__c];
            String project;
            String Country;
            String SubRegion;
            String Region;
            String CategoryArea;
            String CategoryGroup;
            String Category;
              
              
            id SupplierId=scope[0].Supplier__c;
            Date dd=scope[0].DateOfExecution__c.addMonths(-1);
            integer noOfDays = Date.daysInMonth(dd.year(), dd.month());
            Date EndDate= Date.newInstance( dd.year(), dd.month(), noOfDays);
            Date startDate= Date.newInstance( dd.year(), dd.month(), 1);
            SPE_SPEPlan__c planDetail= new SPE_SPEPlan__c ();
            planDetail=[select Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c from SPE_SPEPlan__c where id=:scope[0].SPE_Plan__c ] ;      
          
            
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
            
            
            
            decimal Spend=0.0;
            for(SPE_Spend__c s:Database.query(q)){
            spend=spend+ s.spend__c;
            }
            
            if(spend!=0.0){
            scope[0].Weight__c=spend;
            }
           
        }
     
     update scope[0];   
           
    }
    
    
    
    
    
    
    
    
    
    
    
    
    global void finish(Database.BatchableContext BC) 
    {
    SPE_BatchScorecardGenerateTempValues3 dt= new SPE_BatchScorecardGenerateTempValues3 ();
    database.executebatch(dt,1);        
    }
 }