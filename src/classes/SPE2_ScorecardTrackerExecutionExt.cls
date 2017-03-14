public with sharing class SPE2_ScorecardTrackerExecutionExt 
{
    Transient  Id sprScorecardTrackerId;
    Transient  set<id> speTemplateIds;
    Transient  set<id> speTrackerIds;
    Transient  set<id> speKPIDefIds;
    Transient  set<id> spesupplierMapId;
    Transient  SPE_ScorecardTracker__c spScorecardTracker;
    Transient  set<ID> speScoreCardIds = new set<Id>();
    Transient  list<SPE_ScoreCard__c> toBeInsertedscorecardTracker = new list<SPE_ScoreCard__c>();
    Transient  List<SPE2_CC_Contact_Details__c> ccContactList;
    public SPE2_ScorecardTrackerExecutionExt (Apexpages.Standardcontroller st)
    {
        SPE_ScorecardTracker__c spScorecardTracker = new SPE_ScorecardTracker__c ();
        sprScorecardTrackerId = st.getId();
        
    }
    public void fetchTrackers(String scIdentifier, boolean isExecute){
        DeleteExistingScorecardTrackerValues(sprScorecardTrackerId);
        //sprScorecardTrackerId=ApexPages.currentPage().getParameters().get('id'); 
        spesupplierMapId = new Set<Id>();
        ccContactList = new List<SPE2_CC_Contact_Details__c>(); 
        spScorecardTracker = [SELECT Id,ScorecardGenerator__r.StartDate__c,DateOfExecution__c,ScorecardGenerator__r.EndDate__c,ScorecardGenerator__r.id,ScorecardGenerator__r.Category__c,ScorecardGenerator__r.CategoryCluster__c,EndDate__c,
                              ScorecardGenerator__r.isAutoDistributionON__c,ScorecardGenerator__r.IsAutoApproved__c,ScorecardGenerator__r.CategoryGroup__c,ScorecardGenerator__r.Country__c, ScorecardGenerator__c,ScorecardGenerator__r.ScorecardTemplate__c, Name, 
                              ScorecardGenerator__r.BusinessLine__c,ScorecardGenerator__r.BusinessUnit__c,ScorecardGenerator__r.Region__c,ScorecardGenerator__r.SubRegion__c,ScorecardGenerator__r.Product__c,ScorecardGenerator__r.Project__c,ScorecardGenerator__r.isAdhoc__c,ScorecardGenerator__r.Aggregation_Period_Adhoc__c
                              FROM SPE_ScorecardTracker__c WHERE Id =: sprScorecardTrackerId];
        
       
        list<SPE_ScorecardSupplierMap__c> SPScoreCardSupMapList=new list<SPE_ScorecardSupplierMap__c>([select id,name,Supplier__r.EnterpriseId__c,Supplier__r.id,Supplier__c,Supplier__r.name,ScorecardGenerator__c from SPE_ScorecardSupplierMap__c where ScorecardGenerator__c=:spScorecardTracker.ScorecardGenerator__c]);
        system.debug('####SPScoreCardSupMapList' + SPScoreCardSupMapList.size());
    /**    //---------------Code for cc Contacts-------
        for(SPE_ScorecardSupplierMap__c scm : SPScoreCardSupMapList){
            spesupplierMapId.add(scm.Id);
        }  
        
        ccContactList = [SELECT Contact__c,ScoreCard__c,Scorecard_Supplier_Map__c,Scorecard_Supplier_Map__r.Supplier__c from SPE2_CC_Contact_Details__c where Scorecard_Supplier_Map__c IN : spesupplierMapId];
        system.debug('cc contact list'+ccContactList);  
        //--------------------------------------------
       **/ 
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
            Spscorecard.Identifier__c = scIdentifier;
            Spscorecard.isExecute__c = isExecute;
            system.debug('isExecute::'+isExecute);
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
            
            if(!spScorecardTracker.ScorecardGenerator__r.isAdhoc__c){
                Spscorecard.StartDate__c=spScorecardTracker.ScorecardGenerator__r.StartDate__c;
                Spscorecard.EndDate__c=spScorecardTracker.ScorecardGenerator__r.EndDate__c;
            }
            else{
                if(spScorecardTracker.ScorecardGenerator__r.Aggregation_Period_Adhoc__c == 'Quarterly'){
                    if(spScorecardTracker.Name.startsWith('Q1')){
                        Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.year(),04,30);
                        Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),02,1);
                    }
                    else if(spScorecardTracker.Name.startsWith('Q2')){
                        Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.year(),07,31);
                        Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),05,1);
                    }
                    else if(spScorecardTracker.Name.startsWith('Q3')){
                        Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.year(),10,31);
                        Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),08,1);
                    }
                    else{
                        //Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.addyears(1).year(),01,31);
                        Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.year(),01,31);
                        Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year()-1,11,1);
                        system.debug('Spscorecard.EndDate__c--------' + Spscorecard.EndDate__c);
                        system.debug('spScorecardTracker.EndDa--------' + spScorecardTracker.EndDate__c.year());
                    }
                }
                else if(spScorecardTracker.ScorecardGenerator__r.Aggregation_Period_Adhoc__c == 'Half Yearly'){
                    if(spScorecardTracker.Name.startsWith('H1')){
                        Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.year(),07,30);
                        Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),02,1);
                    }
                    else{
                        //Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.addyears(1).year(),01,31);
                        Spscorecard.EndDate__c = Date.newInstance(spScorecardTracker.EndDate__c.year(),01,31);
                        Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year()-1,08,1);
                    }
                }
                else if(spScorecardTracker.ScorecardGenerator__r.Aggregation_Period_Adhoc__c == 'Monthly'){
                    if(spScorecardTracker.Name.startsWith('P - 01')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 2);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 2, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),02,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 02')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 3);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 3, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),03,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 03')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 4);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 4, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),04,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 04')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 5);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 5, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),05,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 05')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 6);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 6, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),06,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 06')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 7);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 7, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),07,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 07')){
                         System.debug('spScorecardTracker.EndDate__c----' + spScorecardTracker.EndDate__c);
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 8);
                         System.debug('numberOfDays----' + numberOfDays);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 8, numberOfDays);
                         System.debug('lastDayOfMonth----' + lastDayOfMonth);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         System.debug('Spscorecard.EndDate__c----' + Spscorecard.EndDate__c);
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),08,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 08')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 9);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 9, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),09,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 09')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 10);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 10, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),10,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 10')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 11);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 11, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),11,01);
                    }
                    else if(spScorecardTracker.Name.startsWith('P - 11')){
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.year(), 12);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.year(), 12, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.year(),12,01);
                    }
                    else{
                         Integer numberOfDays = Date.daysInMonth(spScorecardTracker.EndDate__c.addYears(1).year(), 1);
                         Date lastDayOfMonth = Date.newInstance(spScorecardTracker.EndDate__c.addYears(1).year(), 1, numberOfDays);
                         Spscorecard.EndDate__c = lastDayOfMonth;
                         Spscorecard.StartDate__c= Date.newInstance(spScorecardTracker.EndDate__c.addYears(1).year(),1,01);
                    }
                }
                else{
                    Spscorecard.EndDate__c = spScorecardTracker.EndDate__c;
                    Spscorecard.StartDate__c=spScorecardTracker.EndDate__c.addYears(-1).addMonths(1); 
                }
            }
            
            toBeInsertedscorecardTracker.add(Spscorecard);
        }
        
        insert toBeInsertedscorecardTracker;
        
        if(toBeInsertedscorecardTracker.size()>0){
        Set<Id> scId = new Set<Id>();
        system.debug('inserted data size'+toBeInsertedscorecardTracker.size());
        for(SPE_ScoreCard__c sc : toBeInsertedscorecardTracker){
            scId.add(sc.Id);
        }
        
       List<SPE_ScoreCard__c> scList=[select id from SPE_ScoreCard__c where id =:scId];
       try{
           update scList;
       }catch(exception e){}
       for(Id i : scId ){
           //SPE_SendScorecard.UpdateScorecard(i);
       }
       }
       
    /**   //---------------Code for cc Contacts-------
        Map<String,String> scorecardIdNameMap = new Map<String,String>();
         for(SPE_ScoreCard__c scorecard : toBeInsertedscorecardTracker){
            scorecardIdNameMap.put(scorecard.Supplier__c,scorecard.Id);
        }
        system.debug('map value is'+scorecardIdNameMap);
        if(ccContactList!=null){
        system.debug('contact list inside0---'+ccContactList);
        
        for(SPE2_CC_Contact_Details__c ccCon : ccContactList ){
            system.debug('val of supplier'+ccCon.Scorecard_Supplier_Map__r.Supplier__c);
            ccCon.ScoreCard__c = scorecardIdNameMap.get(ccCon.Scorecard_Supplier_Map__r.Supplier__c);
           }
        update ccContactList;
        }
    //----------------------------------------------------    
      **/  
        for(SPE_ScoreCard__c ScoreCard : toBeInsertedscorecardTracker){
            speScoreCardIds.add(ScoreCard.Supplier__c);
        }
        
        system.debug('***   1 ');
        set<string> supplierSet = new set<String>();        
        for(SPE_ScorecardSupplierMap__c scope : SPScoreCardSupMapList)
        {
            supplierSet.add(scope.Supplier__c);
            //SPETrackerExecutionBatch(sprScorecardTrackerId, spScorecardTracker.ScorecardGenerator__r.ScorecardTemplate__c,scope.Supplier__r.EnterpriseId__c, scope.Supplier__c);
        }
        system.debug('***outside function');
        SPETrackerExecutionBatch(sprScorecardTrackerId, spScorecardTracker.ScorecardGenerator__r.ScorecardTemplate__c,supplierSet);
        
       // SPE_SPEScoreCardTrackerBatch b = new SPE_SPEScoreCardTrackerBatch(sprScorecardTrackerId, spScorecardTracker.ScorecardGenerator__r.ScorecardTemplate__c,spScorecardTracker.ScorecardGenerator__r.id);
       // database.executeBatch(b,1);
       if(SPScoreCardSupMapList.size() > 0)
       {
           spScorecardTracker.status__c = 'Completed';
           update spScorecardTracker; 
       }
    }
    public Pagereference TrackerExecution(){
        fetchTrackers(system.Now()+';'+userInfo.getuserId(),true);
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
    
    //public  void SPETrackerExecutionBatch (Id speScoreCardTrackerIds, Id speScorecardTempId, String enterpriseId, Id supplierId)
    public  void SPETrackerExecutionBatch (Id speScoreCardTrackerIds, Id speScorecardTempId,set<string> supplierId)
    {
        system.debug('***inside function');
        Transient set<ID> speTemplateIds = new set<Id>();
        Transient set<ID> speTrackerIds = new set<Id>();
        Transient set<ID> speKPIIds = new set<Id>();
        Transient List<SPE_ScorecardSPETemplateMap__c> speScoreCardSPETempList = [Select Id,SPETemplate__c,Weight__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c =: speScorecardTempId];     
       
                                                     
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
                                                                 AND Supplier__c IN: supplierId AND KPIDefinition__c IN: speKPIIds AND SPETracker__r.Name =:timeFrame limit 49999];
       
        System.debug('===============================toBeinsertedTrackerValuess ======>' + toBeinsertedTrackerValuess.size());
        Map<Id, List<Decimal>> kpiValuesMap = new Map<Id, List<Decimal>>();
        List<ScorecardKPIMap__c> toBeInsertedTrackerValues = new List<ScorecardKPIMap__c>();
        
        /*
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

        system.debug('size of map insert***'+toBeInsertedTrackerValues.size());
        //insert toBeInsertedTrackerValues;       
        
        */
        
                Map<string,SPE_ScoreCard__c> Map_speScoreCard = new Map<string,SPE_ScoreCard__c>();
        for(SPE_ScoreCard__c speScoreCard : toBeInsertedscorecardTracker)
                    Map_speScoreCard.put(speScoreCard.Supplier__c, speScoreCard);
            
        Map<string,SPE_ScorecardSPETemplateMap__c> Map_scoreTemp = new Map<string,SPE_ScorecardSPETemplateMap__c>();
        for(SPE_ScorecardSPETemplateMap__c scoreTemp : speScoreCardSPETempList)
                    Map_scoreTemp.put(scoreTemp.SPETemplate__c, scoreTemp);
            
        for(SPE_TrackerValues__c trackerVal : toBeinsertedTrackerValuess)
        {

                        if(Map_speScoreCard.get(trackerVal.Supplier__c)!=null && Map_scoreTemp.get(trackerVal.SPETracker__r.SPETemplate__c)!=null)
                        {
                                SPE_ScoreCard__c scd = Map_speScoreCard.get(trackerVal.Supplier__c);
                                SPE_ScorecardSPETemplateMap__c scdMap = Map_scoreTemp.get(trackerVal.SPETracker__r.SPETemplate__c);
                                
                                ScorecardKPIMap__c ScorecardKPIMap = new ScorecardKPIMap__c();
                                ScorecardKPIMap.KPI__c= trackerVal.KPIDefinition__c;
                                ScorecardKPIMap.KPIValue__c = trackerVal.Value__c;
                                ScorecardKPIMap.Score__c = trackerVal.Score1__c;
                                ScorecardKPIMap.ScoreCard__c = scd.id;
                                ScorecardKPIMap.SPETemplate__c = scdMap.SPETemplate__c;
                                ScorecardKPIMap.SPETemplateWeight__c = scdMap.Weight__c;
                                toBeInsertedTrackerValues .add(ScorecardKPIMap);                                 
                       }                    

        }
        
        if(toBeInsertedTrackerValues.size()>9999)
            database.executeBatch(new SPE2_ScorecardTrackerValueInsert(toBeInsertedTrackerValues));
        else 
            insert toBeInsertedTrackerValues;
            
            
            
    } 
    
}