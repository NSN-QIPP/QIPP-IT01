public with sharing class SPE_ScorecardTrackerExecutionExt 
{
    Public Id sprScorecardTrackerId;
    Public set<id> speTemplateIds;
    Public set<id> speTrackerIds;
    Public set<id> speKPIDefIds;
    Public SPE_ScorecardTracker__c spScorecardTracker;
    Public set<ID> speScoreCardIds = new set<Id>();
    Public list<SPE_ScoreCard__c> toBeInsertedscorecardTracker = new list<SPE_ScoreCard__c>();
    public SPE_ScorecardTrackerExecutionExt (Apexpages.Standardcontroller st)
    {
        SPE_ScorecardTracker__c spScorecardTracker = new SPE_ScorecardTracker__c ();
        sprScorecardTrackerId = st.getId();
        
    }
    public Pagereference TrackerExecution()
    {
        DeleteExistingScorecardTrackerValues(sprScorecardTrackerId);
        sprScorecardTrackerId=ApexPages.currentPage().getParameters().get('id'); 
       
        
        spScorecardTracker = [SELECT Id,ScorecardGenerator__r.StartDate__c,DateOfExecution__c,ScorecardGenerator__r.EndDate__c,ScorecardGenerator__r.id,ScorecardGenerator__r.Category__c,ScorecardGenerator__r.CategoryCluster__c,
                              ScorecardGenerator__r.isAutoDistributionON__c,ScorecardGenerator__r.IsAutoApproved__c,ScorecardGenerator__r.CategoryGroup__c,ScorecardGenerator__r.Country__c, ScorecardGenerator__c,ScorecardGenerator__r.ScorecardTemplate__c, Name, 
                              ScorecardGenerator__r.BusinessLine__c,ScorecardGenerator__r.BusinessUnit__c,ScorecardGenerator__r.Region__c,ScorecardGenerator__r.SubRegion__c,ScorecardGenerator__r.Product__c,ScorecardGenerator__r.Project__c
                              FROM SPE_ScorecardTracker__c WHERE Id =: sprScorecardTrackerId];
        
       
        list<SPE_ScorecardSupplierMap__c> SPScoreCardSupMapList=new list<SPE_ScorecardSupplierMap__c>([select id,name,Supplier__r.EnterpriseId__c,Supplier__r.id,Supplier__c,Supplier__r.name,ScorecardGenerator__c from SPE_ScorecardSupplierMap__c where ScorecardGenerator__c=:spScorecardTracker.ScorecardGenerator__c]);
        system.debug('####SPScoreCardSupMapList' + SPScoreCardSupMapList.size());
        toBeInsertedscorecardTracker = new list<SPE_ScoreCard__c>();
        speScoreCardIds = new set<Id>();
        for(SPE_ScorecardSupplierMap__c sc : SPScoreCardSupMapList)
        {
            SPE_ScoreCard__c Spscorecard=new SPE_ScoreCard__c();
            Spscorecard.Name=sc.Supplier__r.name;
            Spscorecard.ScorecardTracker__c=sprScorecardTrackerId;
            Spscorecard.Region__c=spScorecardTracker.ScorecardGenerator__r.Region__c;
            Spscorecard.SubRegion__c=spScorecardTracker.ScorecardGenerator__r.SubRegion__c;
            Spscorecard.Country__c=spScorecardTracker.ScorecardGenerator__r.Country__c;
            Spscorecard.Project__c=spScorecardTracker.ScorecardGenerator__r.Project__c;
            Spscorecard.BusinessUnit__c=spScorecardTracker.ScorecardGenerator__r.BusinessUnit__c;
            Spscorecard.BusinessLine__c=spScorecardTracker.ScorecardGenerator__r.BusinessLine__c;
            Spscorecard.Product__c=spScorecardTracker.ScorecardGenerator__r.Product__c;
            Spscorecard.CategoryCluster__c=spScorecardTracker.ScorecardGenerator__r.CategoryCluster__c;
            Spscorecard.CategoryGroup__c=spScorecardTracker.ScorecardGenerator__r.CategoryGroup__c;
            Spscorecard.Category__c=spScorecardTracker.ScorecardGenerator__r.Category__c;
            Spscorecard.ScorecardTemplate__c=spScorecardTracker.ScorecardGenerator__r.ScorecardTemplate__c;
            Spscorecard.isScoreGenerated__c = true;
            if(spScorecardTracker.ScorecardGenerator__r.IsAutoApproved__c){
                Spscorecard.Stage__c = 'Approved';
            }
            else{
                Spscorecard.Stage__c = 'Pending';
            }
            if(spScorecardTracker.ScorecardGenerator__r.isAutoDistributionON__c){
                Spscorecard.Distribute_Scorecard__c = 'DISTRIBUTED';
            }
            Spscorecard.Supplier__c=sc.Supplier__c;
            Spscorecard.StartDate__c=spScorecardTracker.ScorecardGenerator__r.StartDate__c;
            Spscorecard.EndDate__c=spScorecardTracker.ScorecardGenerator__r.EndDate__c;
            toBeInsertedscorecardTracker.add(Spscorecard);
        }
        
        insert toBeInsertedscorecardTracker;
        for(SPE_ScoreCard__c ScoreCard : toBeInsertedscorecardTracker){
            speScoreCardIds.add(ScoreCard.Supplier__c);
        }
        
        for(SPE_ScorecardSupplierMap__c scope : SPScoreCardSupMapList){
            SPETrackerExecutionBatch(sprScorecardTrackerId, spScorecardTracker.ScorecardGenerator__r.ScorecardTemplate__c,scope.Supplier__r.EnterpriseId__c, scope.Supplier__c);
        }
        
       // SPE_SPEScoreCardTrackerBatch b = new SPE_SPEScoreCardTrackerBatch(sprScorecardTrackerId, spScorecardTracker.ScorecardGenerator__r.ScorecardTemplate__c,spScorecardTracker.ScorecardGenerator__r.id);
       // database.executeBatch(b,1);
       if(SPScoreCardSupMapList.size() > 0)
       {
           spScorecardTracker.status__c = 'Completed';
           update spScorecardTracker; 
       }
        return new Pagereference('/'+sprScorecardTrackerId);
    }
    
    public static void DeleteExistingScorecardTrackerValues (Id sprScorecardTrackerId)
    {
        List<SPE_ScoreCard__c> toBeDeletedScorecardTracker = [SELECT Id FROM SPE_ScoreCard__c WHERE ScorecardTracker__c=:sprScorecardTrackerId];
        Database.delete(toBeDeletedScorecardTracker, false);
        
    }
    public static Decimal ListToAvg(List<Decimal> values)
    {
        Decimal sum = 0;
        Integer cnt = 0;
        
        for (Decimal d : values)
        {
            sum = sum + d;
            
            cnt ++;
        }
        
        return (cnt == 0 || sum ==0 ) ? 0 : sum/cnt;
    }
    public  void SPETrackerExecutionBatch (Id speScoreCardTrackerIds, Id speScorecardTempId, String enterpriseId, Id supplierId)
    {
        set<ID> speTemplateIds = new set<Id>();
        set<ID> speTrackerIds = new set<Id>();
        set<ID> speKPIIds = new set<Id>();
        List<SPE_ScorecardSPETemplateMap__c>    speScoreCardSPETempList = [Select Id,SPETemplate__c,Weight__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c =: speScorecardTempId];     
       
                                                     
        For(SPE_ScorecardSPETemplateMap__c speScorecardSPETemplate: speScoreCardSPETempList){
            speTemplateIds.add(speScorecardSPETemplate.SPETemplate__c);
        }       
       
        
        List<SPE_SPETracker__c> speTrackerList = [SELECT Id, Status__c, CategoryCluster__c, CategoryGroup__c, Category__c, Region__c, SubRegion__c, Country__c, Project__c, BusinessUnit__c, 
                                                   BusinessLine__c , Product__c, SPEPlan__c, DateOfExecution__c, SPETemplate__c, Name   
                                                   FROM SPE_SPETracker__c 
                                                   WHERE SPETemplate__c =: speTemplateIds];
        for(SPE_SPETracker__c tracker : speTrackerList){
            speTrackerIds.add(tracker.id);
        }                                       
        
        
        SPE_ScorecardGenerator__c speScoreCardGenerator = [SELECT Id,FrequencyInMonths__c,CategoryCluster__c,CategoryGroup__c,Category__c,Region__c,SubRegion__c ,Country__c ,Project__c, 
                                                           BusinessUnit__c,BusinessLine__c,Product__c  from SPE_ScorecardGenerator__c WHERE id=: spScorecardTracker.ScorecardGenerator__c];
                                                           
        List<SPE_SPEKPIMap__c> speTempKPIList = [SELECT id,SPETemplate__c,KPIDefinition__c from SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplateIds];
        
        for(SPE_SPEKPIMap__c speTempKPI : speTempKPIList ){
            speKPIIds.add(speTempKPI.KPIDefinition__c);
        }
        
        Integer toBeaddedMonths = speScoreCardGenerator.FrequencyInMonths__c == null ? 1 :  Integer.valueOf(speScoreCardGenerator.FrequencyInMonths__c);
        toBeaddedMonths = toBeaddedMonths == 0 ? 1 : toBeaddedMonths;
        
        Date toDate = spScorecardTracker.DateOfExecution__c.addMonths(-(toBeaddedMonths));
        Date fromDate = spScorecardTracker.DateOfExecution__c.addMonths(-1);
        
        Set<String> timeFrame = new Set<String>(); 
    
        List<Date> toBeInludedKPI = new List<Date>();
        
        toBeInludedKPI.add(toDate);
        
        while (toDate <= fromDate )
        {
            toBeInludedKPI.add(toDate);
            
            toDate = toDate.addMonths(1);
        }
        
        for  (Date newDate : toBeInludedKPI)
        {
            String toBeAdded = SPE_Utility.monthsMap.get(newDate.month()) + ' - '+ String.valueOf(newDate.year());
            timeFrame.add(toBeAdded);
        }
        
        System.debug('===============================timeFrame======>' + timeFrame);
        
        List<SPE_TrackerValues__c> toBeinsertedTrackerValuess = [SELECT Id,Region__c ,SubRegion__c,Country__c,Category__c,BusinessLine__c,BusinessUnit__c,categorygroup__c,Cluster__c,
                                                                    Product__c,DataLogic__c,Project__c, Score1__c,Value__c,KPIDefinition__c, SPETracker__c, Supplier__c, Supplier__r.EnterpriseId__c, 
                                                                 SPETracker__r.Region__c, SPETracker__r.SPETemplate__c,SPETracker__r.SubRegion__c, SPETracker__r.Country__c, SPETracker__r.Project__c  
                                                                 FROM SPE_TrackerValues__c   WHERE SPETracker__c IN: speTrackerIds 
                                                                 AND Supplier__c=: supplierId AND KPIDefinition__c IN: speKPIIds AND SPETracker__r.Name =:timeFrame ];
       
        System.debug('===============================toBeinsertedTrackerValuess ======>' + toBeinsertedTrackerValuess );
        Map<Id, List<Decimal>> kpiValuesMap = new Map<Id, List<Decimal>>();
        List<ScorecardKPIMap__c> toBeInsertedTrackerValues = new List<ScorecardKPIMap__c>();
        for(SPE_TrackerValues__c trackerVal : toBeinsertedTrackerValuess ){
            if ( trackerVal.Value__c != null &&
                ( (speScoreCardGenerator.CategoryCluster__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c || trackerVal.Cluster__c == speScoreCardGenerator.CategoryCluster__c) && 
                  (speScoreCardGenerator.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c || trackerVal.categorygroup__c == speScoreCardGenerator.CategoryGroup__c) &&
                  (speScoreCardGenerator.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c || trackerVal.Category__c == speScoreCardGenerator.Category__c)
                ) &&
                ( (speScoreCardGenerator.Region__c == PicklistDefaultValues__c.getall().values()[0].Market__c || trackerVal.Region__c == speScoreCardGenerator.Region__c) &&
                  (speScoreCardGenerator.SubRegion__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c || trackerVal.SubRegion__c == speScoreCardGenerator.SubRegion__c) &&
                  (speScoreCardGenerator.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c || trackerVal.Country__c == speScoreCardGenerator.Country__c) &&
                  (speScoreCardGenerator.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c || trackerVal.Project__c == speScoreCardGenerator.Project__c)
                ) &&
                ( (speScoreCardGenerator.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c || trackerVal.BusinessUnit__c == speScoreCardGenerator.BusinessUnit__c) &&
                  (speScoreCardGenerator.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c || trackerVal.BusinessLine__c == speScoreCardGenerator.BusinessLine__c) &&
                  (speScoreCardGenerator.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c || trackerVal.Product__c == speScoreCardGenerator.Product__c)
                )
               )
               {
                List<Decimal> kpiValuesList = new List<Decimal>();
                
                if (kpiValuesMap.get(trackerVal.KPIDefinition__c) != null )
                {
                    kpiValuesList = kpiValuesMap.get(trackerVal.KPIDefinition__c);
                }
                
                kpiValuesList.add(trackerVal.Value__c);
            
                kpiValuesMap.put(trackerVal.KPIDefinition__c, kpiValuesList);
              }
              
                Map<Id, Decimal> actualKPIValuesMap = new Map<Id, Decimal>();
        
                for (Id kpiId : kpiValuesMap.keySet())
                {
                    actualKPIValuesMap.put(kpiId, ListToAvg(kpiValuesMap.get(kpiId)));
                }
                for(SPE_ScoreCard__c speScoreCard : toBeInsertedscorecardTracker)
                    { 
                  
                  for(SPE_ScorecardSPETemplateMap__c scoreTemp : speScoreCardSPETempList){  
                  
                      if(trackerVal.Supplier__c == speScoreCard.Supplier__c && trackerVal.SPETracker__r.SPETemplate__c ==  scoreTemp.SPETemplate__c){
                       
                                ScorecardKPIMap__c ScorecardKPIMap = new ScorecardKPIMap__c();
                                ScorecardKPIMap.KPI__c= trackerVal.KPIDefinition__c;
                                ScorecardKPIMap.KPIValue__c = trackerVal.Value__c;
                                ScorecardKPIMap.Score__c = trackerVal.Score1__c;
                                ScorecardKPIMap.ScoreCard__c = speScoreCard.id;
                                ScorecardKPIMap.SPETemplate__c = scoreTemp.SPETemplate__c;
                                ScorecardKPIMap.SPETemplateWeight__c = scoreTemp.Weight__c;
                                toBeInsertedTrackerValues.add(ScorecardKPIMap);
                                
                        }  
                      } 
                    } 
         }
        insert toBeInsertedTrackerValues;
        
    } 
    
}