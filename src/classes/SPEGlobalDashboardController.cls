public class SPEGlobalDashboardController{
   
   public Map<String,Integer> performanceMap{get;set;}
   public String  reportParamId {get;set;}
   
   public list<CombinationWrapper> CatGWrapperlist{get;set;}
   public list<CombinationWrapper> MarketUnitWrapperlist{get;set;}
   public list<CombinationWrapper> MarketWrapperlist {get;set;}
   public list<CombinationWrapper> regionCatGWrapperlist{get;set;}
   public list<CombinationWrapper> subregionCatGWrapperlist{get;set;}
    
   public String dashboardType {get;set;}
   public Integer totalCount {get;set;}
   public Integer uniqueCount {get;set;}
   public Decimal SpeSupplierCoverage {get;set;}
   public Boolean showDashboard {get;set;}
   public Integer supplierPerf {get;set;}
   public Decimal percentVal {get;set;}
   public String regionParam{get;set;}
   public String subRegionParam{get;set;}
   public List<CombinationWrapper> catGrptempList{get;set;}
   public Integer suppliersWithoutSpend{get;set;}
    public SPEGlobalDashboardController(){
        suppliersWithoutSpend = 0;
        reportParamId = ApexPages.currentPage().getParameters().get('rPramId');
        dashboardType = ApexPages.currentPage().getParameters().get('dboardtype');
        regionParam = apexpages.currentpage().getparameters().get('selectedRegion');
        subRegionParam = apexpages.currentpage().getparameters().get('selectedsubRegion');
        showDashboard = false;
        
        performanceMap  = new Map<String,Integer>(); 
        
        CatGWrapperlist = new List<CombinationWrapper>();
        MarketWrapperlist = new List<CombinationWrapper>();
        MarketUnitWrapperlist = new List<CombinationWrapper>();
        regionCatGWrapperlist = new List<CombinationWrapper>();
        subregionCatGWrapperlist = new List<CombinationWrapper>();
        
        catGrptempList = new List<CombinationWrapper>();
        if(dashboardType == System.Label.SPE_GlobalDashboard ){
            showDashboard = true;   
            system.debug('--enter global');       
            globalDashboard();
            
            
        }
        if(dashboardType == System.Label.SPE_CatGroupDashboard){
            showDashboard = true;
            catGroupDashboard();
        }
        if(dashboardType ==System.Label.SPE_MarketUnitDashboard ){
            showDashboard = true;
            marketunitDashboard();
        }
        if(dashboardType == System.Label.SPE_MarketDashboard ){
            showDashboard = true;
            marketDashboard();
        }
        if(dashboardType == System.Label.SPE_RegionCatGroupDashboard){
            showDashboard = true;
            regioncatGroupDashboard();
        }
        if(dashboardType == System.Label.SPE_SubRegionCatGroupDashboard ){
            showDashboard = true;
            subregioncatGroupDashboard();
        }
        if(dashboardType == System.Label.SPE_SupplierCoverageDashboard ){
            showDashboard = true;
            supplierCoverage();
        }
        if(dashboardType == System.Label.SPE_SupplierPerfIndexDashboard){
            showDashboard = true;
            supplierPerfIndexDashboard();
        }
        
        
    }
    public void globalDashboard(){
        suppliersWithoutSpend = 0;
        Map<String,Decimal> mapglobalsupplier = new Map<String,Decimal>();                            
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,supplier__c  Supplier from spe_scorecard_report__c 
                                 where SPE_Report_Parameter__c =:reportParamId group by supplier__c]){
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }
            if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                mapglobalsupplier.put((String)ar.get('Supplier'),((decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            }
            
        
        }
        
         Integer goodperf = 0;
         Integer meetperf = 0;
         Integer needperf = 0;
         Integer poorperf = 0;
         
         
         for(String s:mapglobalsupplier.keySet()){
             
             if(mapglobalsupplier.get(s)>=4){
                 goodperf++;
                   
             }
             
              if(mapglobalsupplier.get(s)>=3 && mapglobalsupplier.get(s)<4 ){
                 meetperf++;
                   
             }
              if(mapglobalsupplier.get(s)>=2 && mapglobalsupplier.get(s)<3){
                 needperf++;
                   
             }
              if(mapglobalsupplier.get(s) >= 1 && mapglobalsupplier.get(s) < 2){
                 poorperf++;
                   
             }
                performanceMap.put(System.Label.SPE_GoodPerformance,goodperf);   
                performanceMap.put(System.Label.SPE_MeetsRequirement,meetperf);   
                performanceMap.put(System.Label.SPE_NeedsImprovement,needperf);   
                performanceMap.put(System.Label.SPE_Poor_Performance,poorperf);
                                 
         }
     }
     
     public void supplierPerfIndexDashboard(){
        suppliersWithoutSpend = 0;
        Map<String,Decimal> mapglobalsupplier = new Map<String,Decimal>();                            
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,supplier__c  Supplier from spe_scorecard_report__c 
                                 where SPE_Report_Parameter__c =:reportParamId group by supplier__c]){
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }
            if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                mapglobalsupplier.put((String)ar.get('Supplier'),((decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            }
            
        
        }
        
        supplierPerf = 0;
                 
         for(String s:mapglobalsupplier.keySet()){
             
             if(mapglobalsupplier.get(s)>=3){
                 supplierPerf++;
                   
             }
                  
         }
     
     uniqueCount = 0; 
     
     set<String> uniqueSupplierList = new Set<String>();
     for(SPE_Scorecard_Report__c ar:[Select Supplier__c from SPE_Scorecard_Report__c where SPE_Report_Parameter__c =:reportParamId AND weight__c != null]){ 

          uniqueSupplierList.add(ar.Supplier__c);
      }
     uniqueCount = uniqueSupplierList.size();
     if(uniqueCount!=0 && uniqueCount!=null){
     percentVal = ((decimal)(supplierPerf*100)/uniqueCount).setScale(2, RoundingMode.HALF_UP) ;
     }
     else
     percentVal = 0;
   }        
           
    
    
    public void catGroupDashboard(){
        Map<String,Decimal> mapcategoryGroup = new Map<String,Decimal>();
        Map<String,Integer> mapCountCatGroup = new Map<String,Integer>();
        suppliersWithoutSpend = 0;
        
        for(AggregateResult ag : [Select count(Id) totalCatG, SPE_Tracker__r.CategoryGroup__c catG,supplier__c supplier from spe_scorecard_report__c
                                  where SPE_Report_Parameter__c =:reportParamId group by SPE_Tracker__r.CategoryGroup__c,supplier__c]){
         
            mapCountCatGroup.put((String)ag.get('catG'),(integer)ag.get('totalCatG'));    
        
        }
        
        
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,
                                SPE_Tracker__r.CategoryGroup__c CatGrp,supplier__c supplier
                                from spe_scorecard_report__c Where SPE_Tracker__r.CategoryGroup__c != null 
                                AND SPE_Report_Parameter__c =:reportParamId
                                group by SPE_Tracker__r.CategoryGroup__c,supplier__c]){
            
            if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                catGrptempList.add(new CombinationWrapper((String)ar.get('CatGrp'),(String)ar.get('supplier'),
                                  (decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            }                  
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }
        }
        Map<String,List<decimal>> catGrpToScore = new Map<String,List<decimal>>();
        for(CombinationWrapper cw :catGrptempList){
            if(!catGrpToScore.containsKey(cw.CatgrpName)){
                catGrpToScore.put(cw.CatgrpName,new List<decimal>{});
            }
            catGrpToScore.get(cw.CatgrpName).add(cw.avgScore);
        }
        system.debug('catGrpToScore::'+catGrpToScore);
        for(String s :catGrpToScore.keySet()){
            integer totalEvaluated = catGrpToScore.get(s).size();
            Integer goodperf = 0;
            Integer meetperf = 0;
            Integer needperf = 0;
            Integer poorperf = 0;
            for(decimal d : catGrpToScore.get(s)){
                if(d >= 4){
                    goodperf++;
                }
                if(d >= 3 && d < 4){
                    needperf++;
                }
                if(d >= 2 && d < 3){
                    meetperf++;
                }
                if(d >= 0 && d < 2 ){
                    poorperf++;
                }
            }
            integer SPI = goodperf + meetperf;
            decimal spiPercentage = 0;
            if(totalEvaluated != null && totalEvaluated != 0){
                spiPercentage = ((decimal)(SPI*100)/totalEvaluated).setScale(2, RoundingMode.HALF_UP);
            }
            CatGWrapperlist.add(new CombinationWrapper(s,totalEvaluated,goodperf,meetperf,needperf,poorperf,SPI,spiPercentage));
        }
    }
    
   public void marketunitDashboard(){
       
       Map<String,Decimal> mapmarketUnit = new Map<String,Decimal>();
       suppliersWithoutSpend = 0;
        
       Map<String,Integer> mktunitperformanceMap = new Map<String,Integer>();
        
        List<CombinationWrapper> MUtempList = new List<CombinationWrapper>();
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,supplier__c supplier,
                                SPE_Tracker__r.SubRegion__c mktUnit
                                from spe_scorecard_report__c Where SPE_Tracker__r.SubRegion__c != null
                                AND SPE_Report_Parameter__c =:reportParamId 
                                group by supplier__c, SPE_Tracker__r.SubRegion__c]){
            
            if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                MUtempList.add(new CombinationWrapper((String)ar.get('mktUnit'),(String)ar.get('supplier'),
                                  (decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            } 
            
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }                                                     
     }
     
     Map<String,List<decimal>> MUtoScore = new Map<String,List<decimal>>();
        for(CombinationWrapper cw :MUtempList){
            if(!MUtoScore.containsKey(cw.CatgrpName)){
                MUtoScore.put(cw.CatgrpName,new List<decimal>{});
            }
            MUtoScore.get(cw.CatgrpName).add(cw.avgScore);
        }
        
        for(String s :MUtoScore.keySet()){
            integer totalEvaluated = MUtoScore.get(s).size();
            Integer goodperf = 0;
            Integer meetperf = 0;
            Integer needperf = 0;
            Integer poorperf = 0;
            for(decimal d : MUtoScore.get(s)){
                if(d >= 4){
                    goodperf++;
                }
                if(d >= 3 && d < 4){
                    needperf++;
                }
                if(d >= 2 && d < 3){
                    meetperf++;
                }
                if(d >= 0 && d < 2 ){
                    poorperf++;
                }
            }
            integer SPI = goodperf + meetperf;
            decimal spiPercentage = 0;
            if(totalEvaluated != null && totalEvaluated != 0){
                spiPercentage = ((decimal)(SPI*100)/totalEvaluated).setScale(2, RoundingMode.HALF_UP);
            }
            MarketUnitWrapperlist.add(new CombinationWrapper(s,totalEvaluated,goodperf,meetperf,needperf,poorperf,SPI,spiPercentage));
        }
                         
   }
   
   public void marketDashboard(){
       
       Map<String,Decimal> mapmarket = new Map<String,Decimal>();
       suppliersWithoutSpend = 0;
        
       Map<String,Integer> mktperformanceMap = new Map<String,Integer>();
        
        List<CombinationWrapper> mktTempList = new List<CombinationWrapper>();
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,supplier__c Supplier,
                                SPE_Tracker__r.Region__c mkt
                                from spe_scorecard_report__c Where SPE_Tracker__r.Region__c != null 
                                AND SPE_Report_Parameter__c =:reportParamId
                                group by supplier__c, SPE_Tracker__r.Region__c]){
            
            if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                mktTempList.add(new CombinationWrapper((String)ar.get('mkt'),(String)ar.get('supplier'),
                                  (decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            }
            
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }
        
        }
        Map<String,List<decimal>> mktToScore = new Map<String,List<decimal>>();
        for(CombinationWrapper cw :mktTempList){
            if(!mktToScore.containsKey(cw.CatgrpName)){
                mktToScore.put(cw.CatgrpName,new List<decimal>{});
            }
            mktToScore.get(cw.CatgrpName).add(cw.avgScore);
        }
        
        for(String s :mktToScore.keySet()){
            integer totalEvaluated = mktToScore.get(s).size();
            Integer goodperf = 0;
            Integer meetperf = 0;
            Integer needperf = 0;
            Integer poorperf = 0;
            for(decimal d : mktToScore.get(s)){
                if(d >= 4){
                    goodperf++;
                }
                if(d >= 3 && d < 4){
                    needperf++;
                }
                if(d >= 2 && d < 3){
                    meetperf++;
                }
                if(d >= 0 && d < 2 ){
                    poorperf++;
                }
            }
            integer SPI = goodperf + meetperf;
            decimal spiPercentage = 0;
            if(totalEvaluated != null && totalEvaluated != 0){
                spiPercentage = ((decimal)(SPI*100)/totalEvaluated).setScale(2, RoundingMode.HALF_UP);
            }
            MarketWrapperlist.add(new CombinationWrapper(s,totalEvaluated,goodperf,meetperf,needperf,poorperf,SPI,spiPercentage));
        }            
     }
                
   
   public void regioncatGroupDashboard(){
        Map<String,Decimal> mapregioncatgroup = new Map<String,Decimal>();
        suppliersWithoutSpend = 0;
        List<CombinationWrapper> mktCatGTempList = new List<CombinationWrapper>();
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,supplier__c Supplier,
                                SPE_Tracker__r.CategoryGroup__c CatGrp
                                from spe_scorecard_report__c Where SPE_Tracker__r.CategoryGroup__c != null 
                                AND SPE_Report_Parameter__c =:reportParamId AND SPE_Tracker__r.region__c =: regionParam
                                group by supplier__c, SPE_Tracker__r.CategoryGroup__c]){
            
             if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                mktCatGTempList.add(new CombinationWrapper((String)ar.get('CatGrp'),(String)ar.get('Supplier'),
                                  (decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            }   
            
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }
        
        }
        Map<String,List<decimal>> MktcatGtoScore = new Map<String,List<decimal>>();
        for(CombinationWrapper cw :mktCatGTempList){
            if(!MktcatGtoScore.containsKey(cw.CatgrpName)){
                MktcatGtoScore.put(cw.CatgrpName,new List<decimal>{});
            }
            MktcatGtoScore.get(cw.CatgrpName).add(cw.avgScore);
        }
        
        for(String s :MktcatGtoScore.keySet()){
            integer totalEvaluated = MktcatGtoScore.get(s).size();
            Integer goodperf = 0;
            Integer meetperf = 0;
            Integer needperf = 0;
            Integer poorperf = 0;
            for(decimal d : MktcatGtoScore.get(s)){
                if(d >= 4){
                    goodperf++;
                }
                if(d >= 3 && d < 4){
                    needperf++;
                }
                if(d >= 2 && d < 3){
                    meetperf++;
                }
                if(d >= 0 && d < 2 ){
                    poorperf++;
                }
            }
            integer SPI = goodperf + meetperf;
            decimal spiPercentage = 0;
            if(totalEvaluated != null && totalEvaluated != 0){
                spiPercentage = ((decimal)(SPI*100)/totalEvaluated).setScale(2, RoundingMode.HALF_UP);
            }
            regionCatGWrapperlist.add(new CombinationWrapper(s,totalEvaluated,goodperf,meetperf,needperf,poorperf,SPI,spiPercentage));
        }            
            
     
                            
    }
    
    
    public void subregioncatGroupDashboard(){
        Map<String,Decimal> mapsubregioncatgroup = new Map<String,Decimal>();
        suppliersWithoutSpend = 0;
        List<CombinationWrapper> MUcatGtempList = new List<CombinationWrapper>();
        for(AggregateResult ar :[select sum(weight__c) totalWt, sum(weightscore__c) TotalWtscore,supplier__c Supplier,
                                SPE_Tracker__r.CategoryGroup__c CatGrp
                                from spe_scorecard_report__c Where SPE_Tracker__r.CategoryGroup__c != null 
                                AND SPE_Report_Parameter__c =:reportParamId AND SPE_Tracker__r.subRegion__c =: subRegionParam
                                group by supplier__c, SPE_Tracker__r.CategoryGroup__c]){
            
            if((decimal)ar.get('totalWt') != 0 && (decimal)ar.get('totalWt') != null){
                MUcatGtempList.add(new CombinationWrapper((String)ar.get('CatGrp'),(String)ar.get('Supplier'),
                                  (decimal)ar.get('TotalWtscore')/(decimal)ar.get('totalWt')));
            } 
            if((decimal)ar.get('totalWt') == 0 || (decimal)ar.get('totalWt') == null){
                suppliersWithoutSpend ++;
            }
        
        }
        Map<String,List<decimal>> MUcatGtoScore = new Map<String,List<decimal>>();
        for(CombinationWrapper cw :MUcatGtempList){
            if(!MUcatGtoScore.containsKey(cw.CatgrpName)){
                MUcatGtoScore.put(cw.CatgrpName,new List<decimal>{});
            }
            MUcatGtoScore.get(cw.CatgrpName).add(cw.avgScore);
        }
        
        for(String s :MUcatGtoScore.keySet()){
            integer totalEvaluated = MUcatGtoScore.get(s).size();
            Integer goodperf = 0;
            Integer meetperf = 0;
            Integer needperf = 0;
            Integer poorperf = 0;
            for(decimal d : MUcatGtoScore.get(s)){
                if(d >= 4){
                    goodperf++;
                }
                if(d >= 3 && d < 4){
                    needperf++;
                }
                if(d >= 2 && d < 3){
                    meetperf++;
                }
                if(d >= 0 && d < 2 ){
                    poorperf++;
                }
            }
            integer SPI = goodperf + meetperf;
            decimal spiPercentage = 0;
            if(totalEvaluated != null && totalEvaluated != 0){
                spiPercentage = ((decimal)(SPI*100)/totalEvaluated).setScale(2, RoundingMode.HALF_UP);
            }
            subregionCatGWrapperlist.add(new CombinationWrapper(s,totalEvaluated,goodperf,meetperf,needperf,poorperf,SPI,spiPercentage));
        }            
            
                       
    }
    
  public void supplierCoverage(){
  
     List<AggregateResult> lsttotalSupplier = [Select Count(EnterpriseId__c) totSupp from SPE_Spend__c];  
     totalCount = (integer)lsttotalSupplier[0].get('totSupp');
     uniqueCount = 0; 
     SpeSupplierCoverage = 0.00;  
    set<String> uniqueSupplierList = new Set<String>();
    for(SPE_Scorecard_Report__c ar:[Select Supplier__c from SPE_Scorecard_Report__c where SPE_Report_Parameter__c =:reportParamId AND Weight__c != null]){ 

        uniqueSupplierList.add(ar.Supplier__c);
    }
    uniqueCount = uniqueSupplierList.size();
    if(totalCount != 0){
        SpeSupplierCoverage = ((decimal)(uniqueCount*100)/totalCount).setScale(2, RoundingMode.HALF_UP);  
    }
    system.debug('SpeSupplierCoverage::'+((uniqueCount*100)/totalCount));
  }  
    
    public class CombinationWrapper{
        public String CatgrpName {get;set;}
        public Integer totalEval {get;set;}
        public Integer gperf {get;set;}
        public Integer mperf {get;set;}
        public Integer nperf {get;set;}
        public Integer pperf {get;set;}
        public Integer SPI{get;set;}
        public decimal SPIpercent{get;set;}
        public String suppid{get;set;}
        public decimal avgScore{get;set;}
        public CombinationWrapper(String CatgrpName,Integer totalEval,Integer gperf,Integer mperf,Integer nperf,Integer pperf,
                                    integer SPI,decimal spiPercentage){
            this.CatgrpName = CatgrpName;
            this.totalEval = totalEval;
            this.gperf = gperf;
            this.mperf = mperf;
            this.nperf = nperf;
            this.pperf = pperf;    
            this.SPI = SPI; 
            this.SPIpercent = spiPercentage;
        }
        
        public CombinationWrapper(String catgrp, string suppId,decimal avgScore){
            this.CatgrpName = catgrp;
            this.suppid = suppId;
            this.avgScore = avgScore;
        }
    
    }
}