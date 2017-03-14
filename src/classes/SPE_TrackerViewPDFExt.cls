public class SPE_TrackerViewPDFExt 
{
    public SPE_SPETracker__c speTracker {get;set;}
    public list<SPE_TrackerValues__c> speTrackervaluelist {get;set;}
    public Map<Id, List<TrackerWrapper>> trackerWrapperMap {get;set;}
    public List<TrackerWrapper> trackerWrapperList {get;set;}
    
    public List<List<TrackerWrapper>> twll { set; get; }
    
    public SPE_TrackerViewPDFExt(ApexPages.StandardController con) 
    {
        speTracker = [SELECT Id,SPEPlan__r.Owner.name,Status__c,Name, DateOfExecution__c,SPEPlan__r.name,SPETemplate__r.name, Region__c,Category__c,CategoryCluster__c,CategoryGroup__c, Product__c,SubRegion__c, Country__c, Project__c, SPETemplate__c,BusinessLine__c,BusinessUnit__c
                      FROM SPE_SPETracker__c
                      WHERE Id =: con.getid()];
                      
        initialize();
    }
    
    private void initialize()
    {   
        //******Code Commented For Encryption on 30/09/2015 *****************//
        /*
        speTrackervaluelist=[SELECT Supplier__c, EnterpriseId__c, Weight__c, Supplier__r.Name, KPIDefinition__c, KPIDefinition__r.Name, Value__c, Score1__c, Score__c, KPIDefinition__r.Group1__c, DataLogic__c 
                             FROM SPE_TrackerValues__c
                             WHERE SPETracker__c =: speTracker.Id
                             AND Supplier__c != null 
                             AND EnterpriseId__c != null]; 
        trackerWrapperList = new List<TrackerWrapper>();
        for (SPE_TrackerValues__c tv : [SELECT Supplier__c, EnterpriseId__c, Weight__c, Supplier__r.Name, KPIDefinition__c, KPIDefinition__r.Name, Value__c, Score1__c, Score__c, KPIDefinition__r.Group1__c, DataLogic__c 
                                        FROM SPE_TrackerValues__c
                                        WHERE SPETracker__c =: speTracker.Id
                                              AND Supplier__c != null])
        {
            trackerWrapperMap =new Map<Id, List<TrackerWrapper>>();
            
            if(trackerWrapperMap.get(tv.Supplier__c) != null)
            {
                trackerWrapperList = trackerWrapperMap.get(tv.Supplier__c);
            }
                        
            TrackerWrapper tw = new TrackerWrapper (tv);
            trackerWrapperList.add(tw);
            system.debug('!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+trackerWrapperList);
           // trackerWrapperMap.put(tv.Supplier__c, trackerWrapperList);
            
            
        }*/
        //*************Comment End Here *************************//
        
        //************Code added for encryption on 30/09/2015 ************//
        list<SPE_TrackerValues__c> speTrackervaluelistTemp=[SELECT Supplier__c, EnterpriseId__c,EncryptedEnterpriseId__c, Weight__c, Supplier__r.Name, KPIDefinition__c, KPIDefinition__r.KPI_Title__c,
                                                               Value__c, Score1__c, Score__c, KPIDefinition__r.Group1__c, DataLogic__c 
                                                        FROM SPE_TrackerValues__c
                                                        WHERE SPETracker__c =: speTracker.Id
                                                        AND Supplier__c != null]; 
        trackerWrapperList = new List<TrackerWrapper>();
        speTrackervaluelist = new List<SPE_TrackerValues__c>();
                
                twll = new  List<List<TrackerWrapper>>();
                
        for (SPE_TrackerValues__c tv : speTrackervaluelistTemp)
        {
            if (tv.EncryptedEnterpriseId__c != null)
            {
                speTrackervaluelist.add(tv);
                
                trackerWrapperMap =new Map<Id, List<TrackerWrapper>>();
            
                if (trackerWrapperMap.get(tv.Supplier__c) != null)
                {
                    trackerWrapperList = trackerWrapperMap.get(tv.Supplier__c);
                }
                            
                TrackerWrapper tw = new TrackerWrapper (tv);
                trackerWrapperList.add(tw);                
            }
                            
                  if(trackerWrapperList.size()>=500)
                {
                    twll.add(trackerWrapperList.clone());
                    trackerWrapperList.clear();
                }
        }
        twll.add(trackerWrapperList);
        ///List of list
        
        
        //**********************Code addition ends here ************************//
    }
    
    public pagereference PDFGen(){
        return page.SPE_TrackerViewPDFGenepage;
    }
    public pagereference ExlGen(){
        return page.SPE_TrackerViewExcelGenepage;
    }
    public class TrackerWrapper
    {
        
        
        public Id suppId {get;set;}
        public SPE_TrackerValues__c trackerValue {get;set;}
        public String score {get;set;}
        
        public Decimal suppCost {get;set;}
        public Decimal suppDelivery {get;set;}
        public Decimal suppQuality {get;set;}
        public Decimal suppRelationship {get;set;}
        
        public String color {get;set;}
                
        private Map<String, String> dataLogicMap = new Map<String, String>
        {
            'Actual' => ' ',
            'Derived' => ' *',
            'Assumed' => ' #'
        };
                
        public TrackerWrapper (SPE_TrackerValues__c tv)
        {
            
            
            suppId = tv.Supplier__c;
            trackerValue = tv;
            score = tv.Score1__c == null ? '?' : String.valueOf(tv.Score1__c.setScale(2)) + dataLogicMap.get(tv.DataLogic__c);
            
            if (tv.Score1__c < 1)
            {
                color = '#B20000';
            }
            else if (tv.Score1__c >= 1 && tv.Score1__c < 2)
            {
                color = '#E09999';  
            }
            else if (tv.Score1__c >= 2 && tv.Score1__c < 3)
            {
                color = '#FFC200';
            }
            else if (tv.Score1__c >= 3 && tv.Score1__c < 4)
            {
                color = '#99C299';
            }
            else if (tv.Score1__c >= 5)
            {
                color = '#006600';
            }
            else
            {
                color = '#99C2EB';
            }
        }
       
    }
}