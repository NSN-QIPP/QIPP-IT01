public class SPE2_Aggregate_NowExt_bckup{
    public SPE_ScorecardTracker__c scrdTrcker{get;set;}
    public String scrdTrckerId{get;set;}
    public String selectedSupplier{get;set;}
    public Map<String,String> supplierToId;
    public decimal overallScore{get;set;}
    public SPE_ScoreCard__c scorecard{get;set;}
    public List<spePlanWrapper> planWrapperlist{get;set;}
    public List<spePlanWrapper> subwrapperList {get;set;}
    public Map<String,decimal> templatetoScoreMap{get;set;}
    public Set<String> reportParamIds{get;set;}
    public Set<String> spePlanIds{get;set;}
    public Map<String,String> templateColorMap {get;set;}
    public SPE_ScoreCard__c scoreRecord{get;set;}
    //-------------------------
    public integer DEFAULT_PAGE_SIZE{get;set;}
    public integer pageNumber{get;set;}
    public integer maxPages{get;set;}
    public integer startRecNo {get;set;}
    public integer endRecNo {get;set;}
    public boolean hasRecords{get;set;}
    public boolean shownext{get;set;}
    public boolean showprevoius{get;set;}
    public boolean showfirst{get;set;}
    public boolean showlast{get;set;}
    public String currentTime{get;set;}
    public Set<String> trackersName{get;set;}
    //---------------------------------
    public AggregateResult[]  Deliveryresults{get;set;}
    public Map<Id, SPE_KPIDefinition__c> IdValueKPIMap {get;set;} 
    public String SupplierName{get;set;}
    public list<ScorecardKPIMap__c> scoreKPIMap {get;set;}
    public list<ScorecardKPIMap__c> scoreKPIMapbySPe {get;set;}
    public Map<String,List<ScorecardKPIMap__c>> KPITemplateMap {get;set;}
    public decimal OverallScore1 {get;set;}
    public decimal OverallScoreper {get;set;}
    public id sid;
    public String strPgDisplay{get;set;} 
    public boolean isShowScorecard{get;set;}
    public boolean isPasswordCorrect{get;set;}
    public string providePassword{get;set;}   
    public String strMode{get;set;}
    public String strKPIName{get;set;}
    public String KPINameDisplay =''; 
    Public String selectedLang {get;set;}
    public Set<ID> idOfKPI {get;set;}
    public List<SPE2_Language_KPI__c> KPISPE2LanList {get;set;}
    public Map<id,String> KPIlangMap{get;set;}
    public Boolean ShowTrans{get;set;}
    public SPE_ScoreCard__c scorecard1{get;set;}
    private List<SPE2_LanguageList__c> languages;
    public String inputLanguage {get;set;}
    public boolean showLangcol {get;set;}
    public boolean isPPUser{get;set;}
    public Set<String> SelectedspePlanIds{get;set;}
    public SPE_Aggregate_Scorecard__c aggrScard{get;set;}
    public Id scorecardGeneratorId;
    public String scorecardPlanId;
    public Id PlanTemplateId;
    public Map<String,Decimal> kpiWeightMap{get;set;}
    public Map<String,Decimal> pillarWeightMap;
    public boolean dispKPIWeight{get;set;}
    public boolean dispPillarWeight{get;set;}
    public SPE2_Aggregate_NowExt_bckup(ApexPages.StandardController controller){
        aggrScard = new SPE_Aggregate_Scorecard__c();
        kpiWeightMap = new Map<String,Decimal>();
        pillarWeightMap = new Map<String,Decimal>();
        templateColorMap = new Map<String,String>();
        templateColorMap.put('Overall','greyClass');
        trackersName = new Set<String>();
        reportParamIds = new Set<String>();
        spePlanIds = new Set<String>();
        currentTime = string.valueOf(system.Now());
        templatetoScoreMap = new Map<String,decimal>();
        planWrapperlist = new List<spePlanWrapper>();
        subwrapperList = new List<spePlanWrapper>();
        scrdTrcker = new SPE_ScorecardTracker__c();
        DEFAULT_PAGE_SIZE = 10;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        scoreRecord = new SPE_ScoreCard__c();
        scrdTrckerId = apexpages.currentpage().getparameters().get('trckerid');
        scrdTrcker = [Select Id,Name,Scorecard_Tracker_Id__c,ScorecardGenerator__c,ScorecardGenerator__r.AggregationType__c, 
                      ScorecardGenerator__r.Aggregation_Period_Adhoc__c,ScorecardGenerator__r.AdhocScorecardName__c,EndDate__c From SPE_ScorecardTracker__c                      
                      Where Id =:scrdTrckerId];
        
        // Fetch the suppliers from related Scorecard Supplier Map
        List<SPE_ScorecardSupplierMap__c> suppList = new List<SPE_ScorecardSupplierMap__c>();
        suppList = [Select Id,ScorecardGenerator__c,Supplier__c,Supplier__r.Name 
                    From SPE_ScorecardSupplierMap__c 
                    Where ScorecardGenerator__c =:scrdTrcker.ScorecardGenerator__c];
        supplierToId = new Map<String,String>();
        if(suppList.size() > 0){
            for(SPE_ScorecardSupplierMap__c supp :suppList){
                supplierToId.put(supp.Supplier__c,supp.Supplier__r.Name);
            }
        }
        system.debug('supplierToId::'+supplierToId);
        
    }
    public void scrdDynamicAggr(){
        scorecard1 = [select Stage__c,Comments__c,ScorecardTracker__c,ScorecardTracker__r.Name from SPE_ScoreCard__c where id=:ApexPages.currentPage().getParameters().get('scrdid')];
        KPIlangMap = new map<id,String>();
        sid=ApexPages.currentPage().getParameters().get('scrdid');
        ScorecardCalculations(sid);
        selectedValue = scorecard1.Stage__c;
        if(selectedLang !=null){
            inputlanguage = selectedLang;
        }         
        showLangcol = false;
        if(inputlanguage!=null)
        showLangcol = true;
        system.debug('***sid'+sid);
        isPasswordCorrect = true;
        strKPIName = [select Id, ScorecardTracker__c,ScorecardTracker__r.Name,ScorecardTracker__r.ScorecardGenerator__r.AdhocScorecardName__c from SPE_ScoreCard__c where Id=:sid].ScorecardTracker__r.ScorecardGenerator__r.AdhocScorecardName__c;
        Id Scorecardtempl=[select id,ScorecardTemplate__c,ScorecardTracker__c,ScorecardTracker__r.Name from SPE_ScoreCard__c where id=:sid].ScorecardTemplate__c ;
        strPgDisplay = [select id,Password__c from SPE_ScoreCard__c where id=:sid].Password__c;
        system.debug('***strPgDisplay'+strPgDisplay);
        SupplierName=[select id,Supplier__r.name from SPE_ScoreCard__c where id=:sid].Supplier__r.name;
        strMode = URL.getSalesforceBaseUrl()+'';
        system.debug('strMode---' + strMode);
        if(strMode.contains('visual'))
            strMode = 'internal';
        else
            strMode = 'site';
        
        if(strMode == 'site')
            isShowScorecard = false;
        else
            isShowScorecard = true;
                                       
        list<SPE_ScorecardSPETemplateMap__c> scorecardMapTemp= [select id,SPETemplate__r.name,Weight__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c=:Scorecardtempl];
        Decimal total=0.0; 
        overallscore1=0.00;
        Map<string,Decimal> mapofWeight= new Map<string,Decimal>();
        system.debug('scorecardMapTemp--' + scorecardMapTemp.size());
        for(SPE_ScorecardSPETemplateMap__c s:scorecardMapTemp){
        if(s.SPETemplate__r.name != null && s.SPETemplate__r.name != '')
            mapofWeight.put(s.SPETemplate__r.name,s.Weight__c );
        }
        system.debug('TemplateDisplay--' + TemplateDisplay.size());
        for(SPE_ScorecardValues__c s:TemplateDisplay){
            if(mapofWeight.containskey(s.SPE_Template_Name__c) && s.SPE_Template_Name__c != null && s.SPE_Template_Name__c != ''){
                overallscore1=overallscore1+(s.score__c*mapofWeight.get(s.SPE_Template_Name__c));
                total=total+mapofWeight.get(s.SPE_Template_Name__c);
            }
        }
        
        if(total != 0.0)
        overallscore1=(overallscore1/total).setScale(2);       
          
          set<string> groupSet = new set<string>();
          isPPUser = false;
          for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userInfo.getUserId()]){
           groupSet.add(gm.Group.name);
          }
          
          if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
               isPPUser = false;
          } 
          else if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
               isPPUser = true; 
          }
    }
    public void refreshAggregation(){
        list<spePlanWrapper> tempPlans = new list<spePlanWrapper>();
        SelectedspePlanIds = new Set<String>();
        for(spePlanWrapper pw :planWrapperlist){
            if(pw.isSelected){
                tempPlans.add(pw);
                SelectedspePlanIds.add(pw.spePlan.Id);
            }
        }
        if(tempPlans.size() > 0){
            templateAggregation(tempPlans);
        }else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a plan to proceed');
            ApexPages.addMessage(myMsg);        
        }
    }
    
   public pageReference generateScorecardPage(){
        String scorecardTempId = supplierToId.get(selectedSupplier);
        scoreRecord = [select ScorecardTracker__c, Name,CategoryCluster__c,CategoryGroup__c,Category__c,BusinessUnit__c,
                       BusinessLine__c,Product__c,Region__c,SubRegion__c,Country__c,Project__c,DisplaySpend__c,
                       ScorecardTracker__r.ScorecardGenerator__r.AggregationType__c,
                       DisplayUnits__c,StartDate__c,ScorecardTracker__r.Name,ScorecardTracker__r.ScorecardGenerator__r.isAdhoc__c,
                       ScorecardTracker__r.ScorecardGenerator__r.DisplayValues__c,ScorecardTracker__r.ScorecardGenerator__r.id,
                       Approval_Type__c,EndDate__c,ScorecardTitle__c,Stage__c
                       From SPE_ScoreCard__c where ScorecardTracker__c=: scrdTrcker.id AND Name =:scorecardTempId];
        aggrScard = new SPE_Aggregate_Scorecard__c(Name=scoreRecord.Name);
        insert aggrScard;
        sid = scoreRecord.id;
        Boolean gen_displayVal = scoreRecord.ScorecardTracker__r.ScorecardGenerator__r.DisplayValues__c; 
        Boolean isAdhoc = scoreRecord.ScorecardTracker__r.ScorecardGenerator__r.isAdhoc__c;
        system.debug('isAdhoc ::'+isAdhoc);
        system.debug('gen_displayVal ::'+gen_displayVal);
        scorecardGeneratorId =scoreRecord.ScorecardTracker__r.ScorecardGenerator__r.id;
        Integer scorecardPlansCount =[SELECT count() FROM SPE_Scorecard_Plan__c WHERE Scorecard_Generator__c =:scorecardGeneratorId]; 
        system.debug('scorecardPlansCount ::'+scorecardPlansCount); 
        if(isAdhoc && gen_displayVal){
            if(scorecardPlansCount == 1){
                dispKPIWeight=true;
                dispPillarWeight=true;
                scorecardPlanId =[Select id,SPE_Plan__r.id From SPE_Scorecard_Plan__c 
                                    Where Scorecard_Generator__c =:scorecardGeneratorId].SPE_Plan__r.id;
                system.debug('scorecardPlanId ::'+scorecardPlanId);                    
                PlanTemplateId =[Select id,SPETemplate__r.id From SPE_SPEPlan__c Where Id =:scorecardPlanId].SPETemplate__r.id; 
                system.debug('PlanTemplateId ::'+PlanTemplateId);
                List<SPE_SPETemplate__c> speTemplateKPI =[Select Id,(Select KPIDefinition__c,Weight__c From SPE_KPI_Maps__r)
                                                           From SPE_SPETemplate__c Where Id =:PlanTemplateId];
                system.debug('speTemplateKPI ::'+speTemplateKPI);   
                kpiWeightMap = new Map<String,Decimal>();                                        
               for(SPE_SPEKPIMap__c kpimap :speTemplateKPI[0].SPE_KPI_Maps__r){
                  system.debug('kpimap ::'+kpimap); 
                 kpiWeightMap.put(kpiMap.KPIDefinition__c,kpiMap.Weight__c);
               } 
               system.debug('kpiWeightMap ::'+kpiWeightMap);
               List<SPE_SPETemplate__c> speTempKPIList =[Select id,(Select KPIDefinition__c,KPIGroup1__c,Weight__c,KPIGroup2__c From SPE_KPI_Maps__r)
                                                        From SPE_SPETemplate__c Where Id = :PlanTemplateId];  
               Set<Id> kpiIds =new Set<Id>(); 
                   
               for(SPE_SPEKPIMap__c smap :speTempKPIList[0].SPE_KPI_Maps__r){
                   kpiIds.add(smap.KPIDefinition__c);
               }    
               List<AggregateResult> kpiMapList =[Select KPIDefinition__r.Group1__c grp,Sum(Weight__c) wt
                                                 From SPE_SPEKPIMap__c 
                                                 Where KPIDefinition__c IN :kpiIds AND SPETemplate__c =:PlanTemplateId
                                                 group by KPIDefinition__r.Group1__c];
                pillarWeightMap = new Map<String,Decimal>();                                 
               for(AggregateResult smap :kpiMapList){
                   pillarWeightMap.put((String)smap.get('grp'),(decimal)smap.get('wt'));
               }                     
            }
        }
        else if(isAdhoc && scorecardPlansCount > 1){
            dispKPIWeight=true;
            dispPillarWeight=true;
            List<SPE_Scorecard_Plan__c> scdPlans = new List<SPE_Scorecard_Plan__c>();
            scdPlans = [Select id,SPE_Plan__c From SPE_Scorecard_Plan__c Where Scorecard_Generator__c =:scorecardGeneratorId];
            Set<String> plantempids = new Set<String>();
            for(SPE_Scorecard_Plan__c  sp :scdPlans){
                plantempids.add(sp.SPE_Plan__c);
            }
            List<SPE_SPEPlan__c> tempPlans = new List<SPE_SPEPlan__c>();
            tempPlans = [Select id,SPETemplate__c From SPE_SPEPlan__c Where Id IN :plantempids];
            Set<String> templateids = new Set<String>();
            for(SPE_SPEPlan__c pl :tempPlans ){
                templateids.add(pl.SPETemplate__c);
            }
            if(templateids.size() == 1){
                List<SPE_SPETemplate__c> speTemplateKPI =[Select Id,(Select KPIDefinition__c,Weight__c From SPE_KPI_Maps__r)
                                                       From SPE_SPETemplate__c Where Id IN:templateids];
                  kpiWeightMap =new Map<String,Decimal>();                                     
                for(SPE_SPEKPIMap__c kpimap :speTemplateKPI[0].SPE_KPI_Maps__r){
                    kpiWeightMap.put(kpiMap.KPIDefinition__c,kpiMap.Weight__c);
                } 
                List<SPE_SPETemplate__c> speTempKPIList =[Select id,(Select KPIDefinition__c,KPIGroup1__c,Weight__c,KPIGroup2__c From SPE_KPI_Maps__r)
                                                        From SPE_SPETemplate__c Where Id IN:templateids];  
                 Set<Id> kpiIds =new Set<Id>(); 
                       
                 for(SPE_SPEKPIMap__c smap :speTempKPIList[0].SPE_KPI_Maps__r){
                    kpiIds.add(smap.KPIDefinition__c);
                 }    
                 List<AggregateResult> kpiMapList =[Select KPIDefinition__r.Group1__c grp,Sum(Weight__c) wt
                                                     From SPE_SPEKPIMap__c 
                                                     Where KPIDefinition__c IN :kpiIds AND SPETemplate__c IN:templateids
                                                     group by KPIDefinition__r.Group1__c];
                 pillarWeightMap = new Map<String,Decimal>();                                    
                 for(AggregateResult smap :kpiMapList){
                    pillarWeightMap.put((String)smap.get('grp'),(decimal)smap.get('wt'));
                 }
            }
        }
        else{
            dispKPIWeight=false;
            dispPillarWeight=false;
        }
        scorecardAggr();
        PageReference scorePage = new PageReference('/apex/SPE2_Scorecard_Aggregate?scrdid='+scoreRecord.id);
        scorePage.setRedirect(false);
        return scorePage;
    }
   //------------------------------Pagination code----------------
   
     public void pagination(){
            if(!planWrapperlist.isEmpty()){
             hasRecords = true;
             // Determining total no of pages 
             integer remainder = math.MOD(planWrapperlist .size(),DEFAULT_PAGE_SIZE);
             subwrapperList.clear();
             if(remainder ==0){
                maxPages = planWrapperlist .size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages = planWrapperlist .size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages);
             system.debug('planWrapperlist  size'+planWrapperlist );
             if(planWrapperlist .size() > DEFAULT_PAGE_SIZE){
                firstBtnClick();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(spePlanWrapper scOj : planWrapperlist ){
                     subwrapperList.add(scOj);
                 }
                 startRecNo=1;
                 endRecNo=planWrapperlist .size();
    
                 shownext = false;
                 showprevoius = false;
                 system.debug('sub wrap----'+subwrapperList.size());
            }
         }
         else{
            hasRecords = false;
           
        }
        system.debug('###'+subwrapperList.size());
    }
  /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
     ****************************************************************/
        
        public void firstBtnClick(){
            pageNumber = 1;
            //showMessage=false;
            system.debug('inside first button');
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<spePlanWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperList.add(planWrapperlist [i]);
                }catch(exception e){}
            }
            startRecNo=1;
            endRecNo=DEFAULT_PAGE_SIZE;
    
            shownext = true;
            showprevoius = false;
            showlast=true;
            showfirst=false;
        }
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick(){
            pageNumber = pageNumber+1;
            //showMessage=false;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<spePlanWrapper>();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<planWrapperlist .size(); i++)           
                {
                    try{
                        subwrapperList.add(planWrapperlist [i]);
                    }catch(exception e){}
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=planWrapperlist .size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                        subwrapperList.add(planWrapperlist [i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
                shownext = true;
                showlast=true;
            }
            showprevoius = true;
            showfirst=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick(){     
            pageNumber = pageNumber-1;
            //showMessage=false;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<spePlanWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                try{
                    subwrapperList.add(planWrapperlist [i]);
                }catch(exception e){}
            }
    
            startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
            endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
    
            shownext = true;
            showprevoius = true;
            showlast=true;
            showfirst=true;
    
    
            if(pageNumber == 1){
                showprevoius = false;
                showfirst=false;
            }
            else{
                showprevoius = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick(){
        pageNumber = maxPages;
        //showMessage=false;
        System.debug('pageNumber----->' + pageNumber);
        subwrapperList.clear();
        subwrapperList = new list<spePlanWrapper>();

        for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<planWrapperlist .size();i++)           
        {
            try{
                    subwrapperList.add(planWrapperlist [i]);
                }catch(exception e){}
        }

        startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo=planWrapperlist .size();


        shownext = false;
        showprevoius = true;
        showlast=false;
        showfirst=true;
        }
        
    //----------------Pagination ends-------------------     
    
    public List<SelectOption> getScorecardSuppliers() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--None--'));
        for(String sup :supplierToId.keySet()){
            options.add(new SelectOption(sup,supplierToId.get(sup)));
        }                
        return options;
    }
    public pageReference fetchAggregateScore(){
        planWrapperlist.clear();        
        trackersName = new Set<String>();
        SPE_ScoreCard__c scoreCard = new SPE_ScoreCard__c();
        if(selectedSupplier != '' && selectedSupplier != null){
            scoreCard = [Select Id From SPE_ScoreCard__c 
                        Where Supplier__c =:selectedSupplier 
                        AND ScorecardTracker__c =:scrdTrckerId limit 1];
             system.debug('scoreCard ::'+scoreCard.id);                                  
            // get all the supplier related plans
            List<SPE_ScorecardTempValues__c> scardPlans = new List<SPE_ScorecardTempValues__c>();
            scardPlans = [Select Id,SPE_Plan__c,ScoreCard__c,Score_Weight__c,weight__c From SPE_ScorecardTempValues__c
                         Where ScoreCard__c =:scoreCard.Id And KPI__c=Null and group__c=null];
            system.debug('scardPlans ::'+scardPlans);             
            List<Id> tempPlanIds = new List<Id>();
            for(SPE_ScorecardTempValues__c scard :scardPlans){
                tempPlanIds.add(scard.SPE_Plan__c);
            }
            
            
            List<SPE_SPEPlan__c> planList = new List<SPE_SPEPlan__c>();
            Map<String,Decimal> avgScorePerplan = new Map<String,Decimal>();
            if(tempPlanIds.size() > 0){                                                                    
                if(scrdTrcker.ScorecardGenerator__r.AggregationType__c != ''){            
                                                           
                    Map<String,List<String>> planToScore = new Map<String,List<String>>();
                    for(SPE_ScorecardTempValues__c ts :scardPlans){
                        if(!planToScore.containsKey(ts.SPE_Plan__c)){
                            planToScore.put(ts.SPE_Plan__c,new List<String>());
                        }
                        if(ts.Score_Weight__c != null && ts.weight__c != null){
                            planToScore.get(ts.SPE_Plan__c).add(ts.Score_Weight__c+'~'+ts.weight__c);
                        }else{
                            planToScore.get(ts.SPE_Plan__c).add(0+'~'+0);
                        }
                    }
                    
                    for(String s :planToScore.keySet()){
                        decimal sumWeight = 0;
                        decimal sumScore = 0;
                        for(string d :planToScore.get(s)){
                            sumScore += Decimal.valueOf(d.split('~')[0]);
                            sumWeight+= Decimal.valueOf(d.split('~')[1]); 
                        }
                        if(sumWeight != null && sumWeight != 0){
                            avgScorePerplan.put(s,(sumScore/sumWeight));
                        }
                    }
                    system.debug('avgScorePerplan ::'+avgScorePerplan);
                    planList = [Select Id,Name,SPETemplate__c,Vintage__c,Active__c,CategoryCluster__c, 
                                CategoryGroup__c,Category__c,Avg_Tracker_Score__c,BusinessUnit__c,BusinessLine__c,    
                                Product__c,Region__c,SubRegion__c,Country__c,Project__c,SPETemplate__r.Name
                                From SPE_SPEPlan__c
                                Where Id IN :tempPlanIds];
                    planWrapperlist = new List<spePlanWrapper>();
                    SelectedspePlanIds = new Set<String>();
                    for(SPE_SPEPlan__c pl :planList){
                        planWrapperlist.add(new spePlanWrapper(pl,avgScorePerplan.get(pl.Id)));
                        SelectedspePlanIds.add(pl.Id);
                    }  
                    if(planWrapperlist.size() > 0){                      
                        templateAggregation(planWrapperlist);
                    }            
                }               
            }             
            if(planWrapperlist!=null)
            pagination();
        }else{
            
        }               
        return null;
    }
     
     
     public void templateAggregation(List<spePlanWrapper> selectedplanList){
        templatetoScoreMap = new Map<String,decimal>();
        map<String,list<decimal>> templateToscorelist = new map<String,list<decimal>>();  
        set<String> tempPlanIds = new Set<String>();
        for(spePlanWrapper spw :selectedplanList){
            tempPlanIds.add(spw.spePlan.Id);
        }       
        String scorecardTempId = supplierToId.get(selectedSupplier);
        String scoreRecordid = [select ID From SPE_ScoreCard__c where ScorecardTracker__c=: scrdTrcker.id AND Name =:scorecardTempId].Id;
        List<AggregateResult> scorecardTempAggr = new List<AggregateResult>();
        scorecardTempAggr = [SELECT SPE_TemplateName__c tName,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scoreRecordid And SPE_Plan__c IN :tempPlanIds and KPI__c=Null and Group__c=Null GROUP BY SPE_TemplateName__c];
        for(AggregateResult ar :scorecardTempAggr){
            if(ar.get('sum') != null && ar.get('weight') != null && ar.get('weight') != 0){
                templatetoScoreMap.put((string)ar.get('tName'),((decimal)ar.get('sum')/(decimal)ar.get('weight')));
            }
        }
        List<AggregateResult> overAllAggr = new List<AggregateResult>();
        overAllAggr = [SELECT SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scoreRecordid And SPE_Plan__c IN :tempPlanIds and KPI__c=Null and Group__c=Null];
        if(overAllAggr[0].get('sum') != null && overAllAggr[0].get('weight') != null && overAllAggr[0].get('weight') != 0){
            templatetoScoreMap.put('Overall',((decimal)overAllAggr[0].get('sum')/(decimal)overAllAggr[0].get('weight')));
        }
        system.debug('templatetoScoreMap ::'+templatetoScoreMap);
        templateColorMap = new Map<String,String>();
        templateColorMap.put('Overall','greyClass');
        for(String s :templatetoScoreMap.keySet()){
            if(templatetoScoreMap.get(s) >= 0 && templatetoScoreMap.get(s) < 2){
                templateColorMap.put(s,'orangeClass');
            }
            else if(templatetoScoreMap.get(s) >= 2 && templatetoScoreMap.get(s) < 3){
                templateColorMap.put(s,'yellowClass');
                system.debug('templateColorMap11::'+templateColorMap);
            }
            else if(templatetoScoreMap.get(s) >= 3){
                templateColorMap.put(s,'greenClass');
            }
            else{
                templateColorMap.put(s,'greyClass');
            }
        }
        overallScore = templatetoScoreMap.get('Overall');
        templatetoScoreMap.remove('Overall');                
        system.debug('templateColorMap::'+templateColorMap);
     }
    
    public class spePlanWrapper{
        public SPE_SPEPlan__c spePlan{get;set;}
        public boolean isSelected{get;set;}
        public decimal speScore{get;set;}
        public String colorCode{get;set;}
        public spePlanWrapper(SPE_SPEPlan__c spePlan,decimal speScore){
            this.spePlan = spePlan;
            this.isSelected = true;
            this.speScore = speScore;
            if(speScore >= 0 && speScore < 2){
                this.colorCode = 'orangeClass';
            }
            if(speScore >= 2 && speScore < 3){
                this.colorCode = 'yellowClass';
            }
            if(speScore >= 3){
                this.colorCode = 'greenClass';
            }
        }
    }  
    public List<SelectOption> options {get;set;}//for the picklist values
    public List<SelectOption> getValues()
    {
        options = new List<SelectOption>();      
        options.add(new SelectOption('Approved','Approve'));
        options.add(new SelectOption('Rejected','Reject'));     
        return options;
    }  
    
    public string selectedValue{get;set;}//for holding the selected value
    private List<SPE_ScoreCard__c> var;
    
    
    
/** New calculations **/
    public void scorecardAggr(){
        list<SPE_ScorecardValues__c> tobeinserted= new list<SPE_ScorecardValues__c >();
        //sid=ApexPages.currentPage().getParameters().get('scrdid');
        AggregateResult[] groupedResults =new List<AggregateResult>(); 
        groupedResults =[SELECT SPE_TemplateName__c,KPI__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:sid And SPE_Plan__c IN :SelectedspePlanIds and KPI__c!=Null GROUP BY SPE_TemplateName__c,KPI__c ];    
        
        for(AggregateResult ar : groupedResults){
            SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
            s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));  
            if(ar.get('sum') != null && ar.get('weight') != null && ar.get('weight') != 0){       
                s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
            }         
            s.SPE_Aggregate_Scorecard__c=aggrScard.id;
            s.kpi__c=String.valueOf(ar.get('KPI__c'));
            tobeinserted.add(s);
        }

        groupedResults = [SELECT SPE_TemplateName__c,Group__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:sid And SPE_Plan__c IN :SelectedspePlanIds and KPI__c=Null and Group__c!=Null GROUP BY SPE_TemplateName__c,Group__c ];    
       
        for(AggregateResult ar : groupedResults){
            SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
            s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c')); 
            if(ar.get('sum') != null && ar.get('weight') != null && ar.get('weight') != 0){       
                s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight'))); 
            }        
            s.SPE_Aggregate_Scorecard__c=aggrScard.id;
            s.Group__c=String.valueOf(ar.get('Group__c'));
            tobeinserted.add(s);
        }
        
        groupedResults = [SELECT SPE_TemplateName__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:sid And SPE_Plan__c IN :SelectedspePlanIds and KPI__c=Null and Group__c=Null GROUP BY SPE_TemplateName__c ];    
        
        for(AggregateResult ar : groupedResults){
            SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
            s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
            if(ar.get('sum') != null && ar.get('weight') != null && ar.get('weight') != 0){
                s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
            }
            s.SPE_Aggregate_Scorecard__c=aggrScard.id;
            tobeinserted.add(s);
        }
        insert tobeinserted;        
    }
    public list<SPE_ScorecardValues__c> TemplateDisplay {get;set;}    
    public scorecardviewNew[] scorecarddisplayNew{get;set;}    
   public void ScorecardCalculations(id Sid) {
     selectedLang =Apexpages.currentPage().getParameters().get('Language');
     
    
    TemplateDisplay = new list<SPE_ScorecardValues__c>();
    TemplateDisplay =[select SPE_Template_Name__c,Score__c from SPE_ScorecardValues__c where SPE_Aggregate_Scorecard__c=:aggrScard.id and KPI__c=Null and group__c=null];
    set<string> setOfname= new set<string>();
    for(SPE_ScorecardValues__c s : TemplateDisplay )
    setOfname.add(s.SPE_Template_Name__c);
    
    
    scorecarddisplayNew= new list<scorecardviewNew>();   
    list<SPE_ScorecardValues__c> listofRecords= new list<SPE_ScorecardValues__c>();
    idOfKPI=new set<id>();
    KPISPE2LanList =new list<SPE2_Language_KPI__c>();
    for(string s:setOfname){
    
  //*************************************Changes For Encryption********************************//  
    listofRecords=[select id,SPE_Template_Name__c,Group__c,Score__c,KPI__c,KPI__r.AbbreviatedName__c,KPI__r.name,KPI__r.KPI_Title__c,kpi__r.group1__c,kpi__r.Confidential__c from SPE_ScorecardValues__c where SPE_Aggregate_Scorecard__c =:aggrScard.id and (KPI__c!=Null OR group__c!=Null) and SPE_Template_Name__c=:s];
    system.debug('test line 94'+s);
    system.debug('test line 97'+listofRecords);
    for(SPE_ScorecardValues__c scoreValList:listofRecords){
        system.debug('Test Null value'+scoreValList);
        system.debug('Test Line 100'+scoreValList.KPI__c);    
        //*******************************************Changes For SPE2****************************************//
        idOfKPI.add(scoreValList.KPI__c);
        SYSTEM.DEBUG('+++TEST'+idOfKPI);
    }
    
       system.debug('Test Language'+selectedLang);
       //*******************************************Changes For SPE2****************************************//
       KPISPE2LanList=[select ID,Language__c,Language_Version__c,English_Version__c,KPI__c from SPE2_Language_KPI__c where KPI__c in: idOfKPI and Language__c =:selectedLang];
       system.debug('Line for condition '+KPISPE2LanList.size());
          if(KPISPE2LanList.size()!=0)
          {
           ShowTrans=true;
           
           system.debug('Line no 114 '+ShowTrans);
    
     system.debug('Test Line 107::'+KPISPE2LanList);
    for(SPE2_Language_KPI__c speLang :KPISPE2LanList){
            KPIlangMap.put(speLang.KPI__c,speLang.Language_Version__c);        
        }
     }
      
        system.debug('Test Line 110'+KPIlangMap);
        system.debug('listofRecords ::::'+listofRecords);
        // if(s != '' && listofRecords.Score__c != 0){
             scorecarddisplayNew.add(new scorecardviewNew(s,listofRecords,KPIlangMap,kpiWeightMap,pillarWeightMap));
        // }
        }
    }
    
    
  //*************************************END********************************//  
      
      
    
    
    public class scorenew{
    public String KPiAbbr1{get;set;}
    public String KPiname1{get;set;}
    public Decimal Score1{get;set;}
    public boolean Confidential1{get;set;}
    //*******************************************Changes For SPE2****************************************//
    public string selectedLanguage1{get;set;}
    public boolean tranValAvail1{get;set;}
    public Decimal kpiWeight1{get;set;}
    public decimal pillarWt{get;set;}
    public scorenew(String KPiAbbr,String KPiname,Decimal Score,boolean Confidential,String selectedLanguage,boolean tranValAvail,Decimal kpiWeight,decimal pillarWt){
   // ,string selectedLang
     KPiAbbr1=KPiAbbr;
     kPiname1=KPiname;  
     score1=score;
     Confidential1=Confidential;
     //*******************************************Changes For SPE2****************************************//
     selectedLanguage1=selectedLanguage;
     tranValAvail1=tranValAvail;
     this.kpiWeight1 =kpiWeight;
     this.pillarWt = pillarWt;
    }
    
    }
    
    
    public class scorecardviewNew {
    public list<SPE_ScorecardValues__c > Quality{get;set;}
    public list<scorenew> Quality1 {get;set;}
    public list<SPE_ScorecardValues__c > Relationship{get;set;}
    public list<scorenew> Relationship1{get;set;}
    public list<SPE_ScorecardValues__c > Cost{get;set;}
    public list<scorenew> Cost1{get;set;}
    public list<SPE_ScorecardValues__c > Delivery{get;set;}
    public list<scorenew> Delivery1{get;set;}
    public list<SPE_ScorecardValues__c > Innovation {get;set;}
    public list<scorenew> Innovation1{get;set;}
    public String QualityScore{get;set;}
    public String CostScore{get;set;}
    public String RelationScore{get;set;}
    public String DeliveryScore{get;set;}
    Public string TemplateName{get;set;}
    Public string InnovationScore{get;set;}
    public Set<Id> KPIIDSet{get;set;}
    public Decimal templateScore{get;set;}
    public String KPINameDisplay='';    
    public AggregateResult[]  Deliveryresults{get;set;}
    public Map<Id,String> KPIlangMap{get;set;}
    public Map<String,Decimal> kpiWeightMap{get;set;}
    public Map<String,Decimal> pillarWeightMap{get;set;}
    public Decimal QualityPillar{get;set;}
    public Decimal DeliveryPillar{get;set;}
    public Decimal CostPillar{get;set;}
    public Decimal RelationshipPillar{get;set;}
    public Decimal InnovationPillar{get;set;}
    public scorecardviewNew(String s,list<SPE_ScorecardValues__c> ScoreValues,Map<Id,String> KPIlangMap,Map<String,Decimal> kpiWeightMap,Map<String,Decimal> pillarWeightMap) {
     TemplateName=s;
     Quality1= new list<scorenew>();
     Relationship1= new list<scorenew>();
     Cost1= new list<scorenew>();
     Delivery1= new list<scorenew>();
     Innovation1= new list<scorenew>();
     Delivery= new list<SPE_ScorecardValues__c >();
     Cost=new list<SPE_ScorecardValues__c >();
     Quality=new list<SPE_ScorecardValues__c >();
     Relationship=new list<SPE_ScorecardValues__c >();
     Innovation=new list<SPE_ScorecardValues__c >(); 
     this.KPIlangMap = KPIlangMap;
     this.kpiWeightMap =kpiWeightMap;
     this.pillarWeightMap =pillarWeightMap;
     
    //Quality, Delivery, Commercial, Innovation and Relationship
    for(SPE_ScorecardValues__c v:ScoreValues){
        
    if(v.Kpi__r.group1__c=='Delivery')
    {
        Delivery.add(v);
        if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= ''){
         Delivery1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        else{
            Delivery1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        DeliveryPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
        //,v.kpi__r.Language_Version__c
    }
    if(v.Kpi__r.group1__c=='Commercial')
    {
        cost.add(v);
        if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= '')
        {
            cost1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        else{
            cost1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        CostPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
    }
    if(v.Kpi__r.group1__c=='Quality')
    {
        Quality.add(v);
        if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= '')
        {
            Quality1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));           
        }
        else{
                Quality1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        QualityPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
    }
    if(v.Kpi__r.group1__c=='Relationship')
    {
        Relationship.add(v); 
        if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= ''){
            Relationship1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        else{
            Relationship1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
        }
        RelationshipPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
    }
    if(v.Kpi__r.group1__c=='Innovation')
    {
        Innovation.add(v);
        if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= ''){
            Innovation1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c))); 
        }
        else{
              Innovation1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c))); 
        }
        InnovationPillar = pillarWeightMap.get(v.Kpi__r.group1__c); 
    }               
    
    if(v.group__c!='' && v.group__c=='Quality')
    QualityScore=(string.valueof(v.score__c)).substring(0,4);
     if(v.group__c!='' && v.group__c=='Commercial')
    CostScore=(string.valueof(v.score__c)).substring(0,4);
     if(v.group__c!='' && v.group__c=='Relationship')
    RelationScore=(string.valueof(v.score__c)).substring(0,4);
     if(v.group__c!='' && v.group__c=='Delivery')
    DeliveryScore=(string.valueof(v.score__c)).substring(0,4);
    if(v.group__c!='' && v.group__c=='Innovation')
    InnovationScore=(string.valueof(v.score__c)).substring(0,4);
    
    
    }
    
    }
    }
    
    
    
    /* New calculation ends here */
    
            
    public void showScorecard(){
        if(providePassword.trim() == strPgDisplay.trim()){
            isShowScorecard = true;
            isPasswordCorrect = true;
        }
        else{
            isPasswordCorrect = false;
            isShowScorecard = false;
        }
    }
     
     public PageReference createPDF()
    {
        PageReference pdf = new PageReference('/apex/SPE2_AggrScorecardPdf?id='+sid);
        pdf.setRedirect(false);
        return pdf;        
    }
    
    //*************method added for language****
    
       public List<SelectOption> getLanguageValues(){
    
        List<SelectOption> options = new List<SelectOption>();
        languages =SPE2_LanguageList__c.getall().values();
        languages.sort();
        options.add(new SelectOption('None','None'));
        for(SPE2_LanguageList__c lang : languages ){
            options.add(new SelectOption(lang.Name,lang.Language__c));    
        }  
        
        return options;
      
      }  
     
     public PageReference refreshLanguage(){
     system.debug('input language is'+inputLanguage);
         if(inputLanguage!='None'){
           PageReference p = new PageReference('/apex/SPE2_Scorecard?id='+sid+'&Language='+inputLanguage);
           p.setRedirect(true);
            return p;
     }
         else{
         PageReference p = new PageReference('/apex/SPE2_Scorecard?id='+sid);
           p.setRedirect(true);
            return p;
         
         }
     }
    
}