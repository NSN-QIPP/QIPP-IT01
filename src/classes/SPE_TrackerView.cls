public with sharing class SPE_TrackerView
{
   
    public Map<Id, Map<String, ScoreWrapper>> supplierGroupScoreMap {get;set;}

    public Map<Id, List<TrackerWrapper>> trackerWrapperMap {get;set;}
    
    //****************Changes the Code for Encryption*******************//
        //public Map<Id, String> supplierNameMap {get;set;}
        public Map<Id, SPE_TrackerValues__c> supplierNameMap {get;set;}
    //************************END******************************//
        
    public Map<Id, Map<String, ScoreWrapper>> totalSPEScore {get;set;}
    
     public Map<Id, Map<String, ScoreWrapper>> totalAggregateKPIcore {get;set;}
    
    public Map<Id, Decimal> kpiIndividualWeightMap {get;set;}
    
    public SPE_SPETracker__c speTracker {get;set;}
    private Set<String> grps = new Set<String>();
    
    
    public Map<String, ScoreWrapper> totalScoreMap1 {get;set;} 
    public Map<String, ScoreWrapper> totalGrpScoreMap1 {get;set;}
    
    public Map<String, ScoreWrapper> totalScoreMap2 {get;set;} 
    public Map<String, ScoreWrapper> totalGrpScoreMap2 {get;set;}
    
    public Map<String, ScoreWrapper> totalAggregateKPIScore {get;set;}
    
    
    public Map<String, String> totalScoreMap {get;set;}

    public Map<String, Map<String, String>> totalGrpScoreMap {get;set;}
    
     public SPE_TrackerView()
     {
         
     }
         
         
    public SPE_TrackerView (ApexPages.StandardController con)
    {
                
        speTracker = [SELECT Id,Status__c,SPEPlan__r.Owner.name, Name, DateOfExecution__c,SPEPlan__r.name,SPETemplate__r.name, Region__c,Category__c,CategoryCluster__c,CategoryGroup__c, Product__c,SubRegion__c, Country__c, Project__c, SPETemplate__c,BusinessLine__c,BusinessUnit__c
                      FROM SPE_SPETracker__c
                      WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
                        
        supplierGroupScoreMap = new Map<Id, Map<String, ScoreWrapper>>();
        trackerWrapperMap = new Map<Id, List<TrackerWrapper>>();
        
        //****************Changes the Code for Encryption*******************//
            //supplierNameMap = new Map<Id, String>();
            supplierNameMap = new Map<Id, SPE_TrackerValues__c>();
        //***************************END*********************//
        
        totalSPEScore = new Map<Id, Map<String, ScoreWrapper>>();
        
        totalAggregateKPIcore = new Map<Id, Map<String, ScoreWrapper>>();
        
        totalScoreMap = new Map<String, String>();
        
        totalGrpScoreMap = new Map<String, Map<String, String>>();
        
        totalScoreMap1 = new Map<String, ScoreWrapper>();
        totalGrpScoreMap1 = new Map<String, ScoreWrapper>();
        
        totalScoreMap2 = new Map<String, ScoreWrapper>();
        totalGrpScoreMap2= new Map<String, ScoreWrapper>();
        
        totalAggregateKPIScore = new Map<String, ScoreWrapper>();
                
        initialize();                
        
    }
    
    private void initialize()
    {
        Map<String,String> groupSupplierKeyToMissingDataLogic = new map<String,String>();
        Map<String,String> aggregateKPItoMissingDataLogic = new map<String,String>();
    
        //**************Changes For Encryption*************//
        /*for (SPE_TrackerValues__c tv : [SELECT Supplier__c, EnterpriseId__c, Weight__c,MissingDatalogic__c, Supplier__r.Name, KPIDefinition__c, KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, Value__c, Score1__c, Score__c, KPIDefinition__r.Group1__c, DataLogic__c,
                                            KPIDefinition__r.MissingDatalogic__c
                                        FROM SPE_TrackerValues__c
                                        WHERE SPETracker__c =: speTracker.Id
                                        AND Supplier__c != null 
                                        AND EnterpriseId__c != null])*/
         
         /*
         for (SPE_TrackerValues__c tv : [SELECT ID,Supplier__c, EnterpriseId__c,EncryptedEnterpriseId__c,LogicAnnotation__c,Weight__c,MissingDatalogic__c, Supplier__r.Name, KPIDefinition__c, KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, Value__c, Score1__c, Score__c, KPIDefinition__r.Group1__c, DataLogic__c,
                                            KPIDefinition__r.MissingDatalogic__c
                                        FROM SPE_TrackerValues__c
                                        WHERE SPETracker__c =: speTracker.Id
                                        AND Supplier__c != null])                               
        */
        
         List<SPE_TrackerValues__c> trackerValueTemp = [SELECT ID,Supplier__c, EnterpriseId__c,EncryptedEnterpriseId__c,LogicAnnotation__c,Weight__c,MissingDatalogic__c, Supplier__r.Name, KPIDefinition__c, KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, Value__c, Score1__c, Score__c, KPIDefinition__r.Group1__c, DataLogic__c,
                                            KPIDefinition__r.MissingDatalogic__c
                                        FROM SPE_TrackerValues__c
                                        WHERE SPETracker__c =: speTracker.Id
                                        AND Supplier__c != null];
        
        system.debug('***1*** size of spe tracker value :'+trackerValueTemp.size());
                        
        
        for(SPE_TrackerValues__c tv : trackerValueTemp)
        {
            //**************New Added for Encryption******************//
            if(tv.EncryptedEnterpriseId__c != null)  
            {                
                List<TrackerWrapper> trackerWrapperList = new List<TrackerWrapper>();
           
                if(trackerWrapperMap.get(tv.Supplier__c) != null)
                {
                    trackerWrapperList = trackerWrapperMap.get(tv.Supplier__c);                    
                }
                
                String mapGroupkey = tv.KPIDefinition__c;
                String mapKey = tv.KPIDefinition__r.Group1__c + '_' + tv.Score1__c;
                String mapValue = tv.MissingDatalogic__c;
                groupSupplierKeyToMissingDataLogic.put(mapKey,mapValue);
                aggregateKPItoMissingDataLogic.put(mapGroupkey,mapValue);
                
                trackerWrapperList.add(new TrackerWrapper(tv));                                                                              
                
                trackerWrapperMap.put(tv.Supplier__c, trackerWrapperList);
                                
                //****************Changes the Code for Encryption*******************//            
                    //supplierNameMap.put(tv.Supplier__c, tv.EnterpriseId__c);
            
                ////------------------------**** CAL0896324 *** SPE tracker in SPE plan- Show details resulting in error------------------------------------------------ //
                
                    //SPE_TrackerValues__c spetrackerval = [Select ID,EncryptedEnterpriseId__c from SPE_TrackerValues__c where ID =: tv.ID];
                                  
                    supplierNameMap.put(tv.Supplier__c, tv);
                //******************************END*************************//                
                
                if (tv.Score1__c == null)
                {
                    String colorCode = tv.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC1 ? SPE_Constants.COLOR_6 : SPE_Constants.COLOR_7;
                    totalScoreMap2.put('total', new ScoreWrapper('?',colorCode));
                    totalScoreMap1.put('total', new ScoreWrapper('?',colorCode));
                    totalSPEScore.put(tv.Supplier__c, totalScoreMap2); 
                } 
            }
        }        
    
        system.debug('****2***  trackerWrapperMap  '+trackerWrapperMap.size());
        
        
        //*********************END************************//
        
        /*
        for (SPE_TrackerScore__c ts : [SELECT Group__c, Score__c, SPEScore__c,KPIName__c ,SPETracker__c, Supplier__c,Supplier__r.Name FROM SPE_TrackerScore__c
                                        WHERE SPETracker__c =: speTracker.Id ])
    */
        
        List<SPE_TrackerScore__c> trackerScoreTemp = [SELECT Group__c, Score__c, SPEScore__c,KPIName__c ,SPETracker__c, Supplier__c,Supplier__r.Name FROM SPE_TrackerScore__c
                                        WHERE SPETracker__c =: speTracker.Id]; 
    for(SPE_TrackerScore__c ts : trackerScoreTemp)
        {
            if (ts.Supplier__c != null )
            {
                Map<String, String> groupScoreMap = new Map<String, String>();
                Map<String, ScoreWrapper> totalGrpScoreMap2= new Map<String, ScoreWrapper>();
                Map<String, ScoreWrapper> totalScoreMap2 = new Map<String, ScoreWrapper>();
                
                if (supplierGroupScoreMap.get(ts.Supplier__c) != null)
                {
                    totalGrpScoreMap2 = supplierGroupScoreMap.get(ts.Supplier__c);
                }
                
                if (ts.Group__c == null && ts.Score__c == null)
                {
                  //  totalScoreMap2.put('total', new ScoreWrapper('?',SPE_Constants.COLOR_6));
                  //  totalSPEScore.put(ts.Supplier__c, totalScoreMap2);
                    
                }
                else if(ts.Group__c == null && ts.Score__c != null)
                {
                     if (ts.Score__c < 1)
                        {
                            totalScoreMap2.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_1));
                        }
                        else if (ts.Score__c >= 1 && ts.Score__c< 2)
                        {
                            totalScoreMap2.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_2));
                        }
                        else if (ts.Score__c>= 2 && ts.Score__c< 3)
                        {
                           totalScoreMap2.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_3));
                        }
                        else if (ts.Score__c >= 3 && ts.Score__c < 4)
                        {
                           totalScoreMap2.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_4));
                        }
                       
                        else if (ts.Score__c >= 4)
                        {
                          totalScoreMap2.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_5));
                        }
                        
                     totalSPEScore.put(ts.Supplier__c, totalScoreMap2);
                }
                
                else if(ts.Group__c != null && ts.Score__c == null)
                {
                    String mapKeyToMatch = ts.Group__c + '_' + ts.Score__c;
                    String missingdataLogicValue = groupSupplierKeyToMissingDataLogic.get(mapKeyToMatch);
                    String colorCode = (missingdataLogicValue == SPE_Constants.MISSINGDATALOGIC1 ? SPE_Constants.COLOR_6 : SPE_Constants.COLOR_7);
                    groupScoreMap.put(ts.Group__c, String.ValueOf('?'));
                    ScoreWrapper sq1 = new ScoreWrapper('?', colorCode);
                    totalGrpScoreMap2.put(ts.Group__c, sq1);
                }
                else
                {
                     if (ts.Score__c < 1)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_1);
                            totalGrpScoreMap2.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c >= 1 && ts.Score__c< 2)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_2);
                            totalGrpScoreMap2.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c>= 2 && ts.Score__c< 3)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_3);
                            totalGrpScoreMap2.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c >= 3 && ts.Score__c < 4)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_4);
                            totalGrpScoreMap2.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c >= 4)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_5);
                            totalGrpScoreMap2.put(ts.Group__c, sq);
                        }
                    groupScoreMap.put(ts.Group__c, String.ValueOf(ts.Score__c.setScale(4)));
                }
                
                supplierGroupScoreMap.put(ts.Supplier__c, totalGrpScoreMap2);
            }
            else
            {
                Map<String, ScoreWrapper> totalAggregateKPIScore = new Map<String, ScoreWrapper>();
                 
                if (ts.Group__c == null)
                {
                    if(ts.KPIName__c == null)
                    {
                        if (ts.Score__c == null)
                        {
                          // totalScoreMap1.put('total', new ScoreWrapper('?',SPE_Constants.COLOR_0));
                            
                        }
                        else
                        {
                            if (ts.Score__c < 1)
                            {
                                totalScoreMap1.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_1));
                                system.debug('^^^^^'+totalScoreMap1);
                            }
                            else if (ts.Score__c >= 1 && ts.Score__c< 2)
                            {
                                  
                                totalScoreMap1.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_2));
                                system.debug('^^^^^'+totalScoreMap1);
                            }
                            else if (ts.Score__c>= 2 && ts.Score__c< 3)
                            {
                               
                                totalScoreMap1.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_3));
                                system.debug('^^^^^'+totalScoreMap1);
                            }
                            else if (ts.Score__c >= 3 && ts.Score__c < 4)
                            {
                                
                                totalScoreMap1.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_4));
                                system.debug('^^^^^'+totalScoreMap1);
                            }
                            else if (ts.Score__c >= 5)
                            {
                              
                                totalScoreMap1.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_5));
                                system.debug('^^^^^'+totalScoreMap1);
                            }
                           
                         }
                    }
                    else
                    {
                        if (ts.Score__c == null)
                        {
                             
                            String mapKeyToMatch = ts.KPIName__c;
                            String missingdataLogicValue = aggregateKPItoMissingDataLogic.get(mapKeyToMatch);
                            String colorCode = (missingdataLogicValue == SPE_Constants.MISSINGDATALOGIC1 ? SPE_Constants.COLOR_6 : SPE_Constants.COLOR_7); 
                            totalAggregateKPIScore.put('total', new ScoreWrapper(String.valueOf('?'),colorCode));
                        } 
                            else
                            {
                            if (ts.Score__c < 1)
                            {
                                totalAggregateKPIScore.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_1));
                             
                            }
                            else if (ts.Score__c >= 1 && ts.Score__c< 2)
                            {
                                totalAggregateKPIScore.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_2));
                            
                            }
                            else if (ts.Score__c>= 2 && ts.Score__c< 3)
                            {
                                totalAggregateKPIScore.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_3));
                             
                            }
                            else if (ts.Score__c >= 3 && ts.Score__c < 4)
                            {
                                totalAggregateKPIScore.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_4));
                            
                            }
                           
                            else if (ts.Score__c >= 4)
                            {
                                totalAggregateKPIScore.put('total', new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)),SPE_Constants.COLOR_5));
                             
                            }
                           
                         } 
                         
                           totalAggregateKPIcore.put(ts.KPIName__c, totalAggregateKPIScore); 
                    }
                    
                }
                else
                {
                
                        if (ts.Score__c < 1)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_1);
                            totalGrpScoreMap1.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c >= 1 && ts.Score__c< 2)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_2);
                            totalGrpScoreMap1.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c>= 2 && ts.Score__c< 3)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_3);
                            totalGrpScoreMap1.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c >= 3 && ts.Score__c < 4)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_4);
                            totalGrpScoreMap1.put(ts.Group__c, sq);
                        }
                        else if (ts.Score__c >= 4)
                        {
                            ScoreWrapper sq = new ScoreWrapper(String.valueOf(ts.Score__c.setScale(4)), SPE_Constants.COLOR_5);
                            totalGrpScoreMap1.put(ts.Group__c, sq);
                        }
                        else{
                        
                            String mapKeyToMatch = ts.Group__c + '_' + ts.Score__c;
                            String missingdataLogicValue = groupSupplierKeyToMissingDataLogic.get(mapKeyToMatch);
                            String colorCode = (missingdataLogicValue == SPE_Constants.MISSINGDATALOGIC1 ? SPE_Constants.COLOR_6 : SPE_Constants.COLOR_7);
                            ScoreWrapper sq = new ScoreWrapper('?', colorCode);
                            totalGrpScoreMap1.put(ts.Group__c, sq);
                        }
                    
                }
                
            }
        }
        
        
    }
    
    public PageReference redirectToCM()
    {
        PageReference pg = new PageReference('/apex/SPE_ReviewPage?trackerId='+speTracker.Id);
        return pg;
    }
        public pagereference ExlGen(){
        return page.SPE_TrackerView_sample;
    }

    
    public class ScoreWrapper
    {
        public String score {get;set;}
        public String color {get;set;}
        
        public ScoreWrapper (String sore1, String color1)
        {
            score = sore1;
            color = color1;
        }
    }
        
    public class TrackerWrapper
    {
        public Id suppId {get;set;}
        public SPE_TrackerValues__c trackerValue {get;set;}
        public String score {get;set;}
        
        public String color {get;set;}
        
        public String KPIName {get;set;}
        
        public String font  {get;set;}
                
        private Map<String, String> dataLogicMap = new Map<String, String>
        {
            'Actual' => ' ',
            'Derived' => ' *',
            'Assumed' => ' #'
        };
         
        public String fetchColor(){
            return color;
        }
        
        public String fetchScore(){
            return score;
        } 
                
        public TrackerWrapper (SPE_TrackerValues__c tv)
        {
            suppId = tv.Supplier__c;
            //**************Changes For Encryption*************//
                //KPIName = tv.KPIDefinition__r.Name;
                KPIName = tv.KPIDefinition__r.KPI_Title__c;
            //*************END****************//
            trackerValue = tv;
            
            if (tv.Score1__c == null)
            {
                score = (tv.KPIDefinition__r.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC1 || tv.KPIDefinition__r.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC2) ? '?' : '?';
            }
            else
            {
                score = String.valueOf(tv.Score1__c.setScale(4)) +' '+(tv.LogicAnnotation__c == null ? '' : tv.LogicAnnotation__c);
            }
            
            if (tv.Score1__c < 1)
            {
                color = SPE_Constants.COLOR_1;
            }
            else if (tv.Score1__c >= 1 && tv.Score1__c < 2)
            {
                color = SPE_Constants.COLOR_2;  
            }
            else if (tv.Score1__c >= 2 && tv.Score1__c < 3)
            {
                color = SPE_Constants.COLOR_3;
            }
            else if (tv.Score1__c >= 3 && tv.Score1__c < 4)
            {
                color = SPE_Constants.COLOR_4;
            }
           
            else if (tv.Score1__c >= 4)
            {
                color = SPE_Constants.COLOR_5;
            }
            else
            {
                if(tv.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC1 && tv.Score1__c == null)
                {
                    color = SPE_Constants.COLOR_6;
                    font =  SPE_Constants.FontCOLOR_6;
                }
                else if(tv.MissingDatalogic__c == SPE_Constants.MISSINGDATALOGIC2)
                {
                    color = SPE_Constants.COLOR_7;
                }
                
            }
        }
    }
}