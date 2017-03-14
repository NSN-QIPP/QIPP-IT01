public with sharing class SPE_TrackerValuesTrigger 
{
  public static void GenerateCMTicket(List<SPE_TrackerValues__c> trackerValues)
  {
    Set<Id> spePlanIds = new Set<Id>();
    Set<Id> kpiIds = new Set<Id>();
    Set<Id> trackerIds = new Set<Id>();
    Set<Id> enterpriseIds = new Set<Id>();
    Set<Id> trackerValuesIds = new Set<Id>();
     
    for (SPE_TrackerValues__c tv : trackerValues)
    {
      spePlanIds.add(tv.SPEPlanId__c);
      kpiIds.add(tv.KPIDefinition__c);
      trackerIds.add(tv.SPETracker__c);
      enterpriseIds.add(tv.Supplier__c);
      trackerValuesIds.add(tv.Id);
    }
    
    Map<Id, SPE_SPEPlan__c> spePlanMap = new Map<Id, SPE_SPEPlan__c>([SELECT Id, AutoTicket__c 
                                        FROM SPE_SPEPlan__c
                                        WHERE Id IN: spePlanIds]);
    spePlanIds.clear(); 
    
    for (SPE_SPEPlan__c spePlan : spePlanMap.values())
    {
      if (spePlan.AutoTicket__c == 'ON')
      {
        spePlanIds.add(spePlan.Id);
      }
    }
    
    List<SPE_PlanKPIMap__c> spePlanKPIs = [SELECT CMTicket__c, KPI__c, KPIScoreThreshold__c, PeriodRange__c, SPEPlan__c
                         FROM SPE_PlanKPIMap__c
                         WHERE SPEPlan__c IN: spePlanIds AND
                              CMTicket__c != ''];
    
    Map<Id, Map<Id, SPE_PlanKPIMap__c>> spePlanKPIMaps = new Map<Id, Map<Id, SPE_PlanKPIMap__c>>();
    
    for (SPE_PlanKPIMap__c sk : spePlanKPIs)
    {
      Map<Id, SPE_PlanKPIMap__c> kpiMaps = new Map<Id, SPE_PlanKPIMap__c>();
      
      if (spePlanKPIMaps.get(sk.SPEPlan__c) != null)
      {
        kpiMaps = spePlanKPIMaps.get(sk.SPEPlan__c);
      }
      
      kpiMaps.put(sk.KPI__c, sk);
      
      spePlanKPIMaps.put(sk.SPEPlan__c, kpiMaps);
      
    }
  
    List<SPE_TrackerValues__c> oldTrackerValues = [SELECT Score1__c, KPIDefinition__c, SPETracker__r.SPEPlan__c, Supplier__c, SPETracker__r.DateOfExecution__c  
                              FROM SPE_TrackerValues__c
                              WHERE SPETracker__r.SPEPlan__c IN: spePlanIds AND
                                   KPIDefinition__c IN: kpiIds AND
                                   Supplier__c IN: enterpriseIds AND
                                   SPETracker__c NOT IN: trackerIds
                               ORDER BY SPETracker__r.DateOfExecution__c DESC];
    
    Map<Id, Map<Id, Map<Id, List<SPE_TrackerValues__c>>>> spePlanKPItrackervaluesMap = new Map<Id, Map<Id, Map<Id, List<SPE_TrackerValues__c>>>>();
    
    for (SPE_TrackerValues__c tv: oldTrackerValues)
    {
      
      Map<Id, List<SPE_TrackerValues__c>> KPItrackervaluesMap = new Map<Id, List<SPE_TrackerValues__c>>();
      
      Map<Id, Map<Id, List<SPE_TrackerValues__c>>> supplierKPItrackervaluesMap = new Map<Id, Map<Id, List<SPE_TrackerValues__c>>>();
      
      List<SPE_TrackerValues__c> trackerValueList = new List<SPE_TrackerValues__c>();
      
      if (spePlanKPItrackervaluesMap.get(tv.SPETracker__r.SPEPlan__c) != null)
      {
        supplierKPItrackervaluesMap = spePlanKPItrackervaluesMap.get(tv.SPETracker__r.SPEPlan__c);
      }
      
      if (supplierKPItrackervaluesMap.get(tv.Supplier__c) != null)
      {
        KPItrackervaluesMap = supplierKPItrackervaluesMap.get(tv.Supplier__c);
      }
      
      if (KPItrackervaluesMap.get(tv.KPIDefinition__c) != null)
      {
        trackerValueList = KPItrackervaluesMap.get(tv.KPIDefinition__c);
      }
      
      
      trackerValueList.add(tv);
      
      KPItrackervaluesMap.put(tv.KPIDefinition__c, trackerValueList);
      
      supplierKPItrackervaluesMap.put(tv.Supplier__c, KPItrackervaluesMap);
      
      spePlanKPItrackervaluesMap.put(tv.SPETracker__r.SPEPlan__c, supplierKPItrackervaluesMap);
    }
  
    Map<Id, String> toBeCreatedCMTicket = new Map<Id, String>();
    
    //***********************************Changes For Encryption*********************************//
    List<SPE_TrackerValues__c> newTrackerValues = [SELECT KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, KPIDefinition__r.Cluster__c, Supplier__c, SPETracker__r.DateOfExecution__c,SPETracker__r.Status__c,
                                                  SPETracker__r.SPEPlan__c, SPETracker__r.SPEPlan__r.Name,SPETracker__r.SPEPlan__r.Stage__c,Score1__c,Value__c, 
                                                  SPETracker__r.Name, SPETracker__r.Region__c, SPETracker__r.SubRegion__c,SPETracker__r.Country__c,
                                                  SPETracker__r.Project__c,SPETracker__r.CategoryCluster__c,SPETracker__r.CategoryGroup__c,
                                                  SPETracker__r.Category__c,SPETracker__r.BusinessUnit__c,SPETracker__r.BusinessLine__c,
                                                  SPETracker__r.Product__c,Supplier__r.Name from SPE_TrackerValues__c 
                                           WHERE  Id In: trackerValuesIds];
                                           
    //***********************************END*********************************//                                        
    
    for (SPE_TrackerValues__c tv : newTrackerValues)
    {
      Boolean needToCreateTicket = false;
      String ticketType = '';  
      
      if (spePlanMap.get(tv.SPETracker__r.SPEPlan__c) != null &&
        spePlanMap.get(tv.SPETracker__r.SPEPlan__c).AutoTicket__c == 'ON' &&
        spePlanKPIMaps.get(tv.SPETracker__r.SPEPlan__c) != null && 
        spePlanKPIMaps.get(tv.SPETracker__r.SPEPlan__c).get(tv.KPIDefinition__c) != null &&
        spePlanKPItrackervaluesMap.get(tv.SPETracker__r.SPEPlan__c) != null && 
        spePlanKPItrackervaluesMap.get(tv.SPETracker__r.SPEPlan__c).get(tv.Supplier__c) != null && 
        spePlanKPItrackervaluesMap.get(tv.SPETracker__r.SPEPlan__c).get(tv.Supplier__c).get(tv.KPIDefinition__c) != null)
      {
        
        SPE_PlanKPIMap__c spePlanKPIMap = spePlanKPIMaps.get(tv.SPETracker__r.SPEPlan__c).get(tv.KPIDefinition__c);  
        
        if (spePlanKPIMap.KPIScoreThreshold__c != null &&
          spePlanKPIMap.PeriodRange__c != null)
        {
          List<SPE_TrackerValues__c> prevTrackerValues = spePlanKPItrackervaluesMap.get(tv.SPETracker__r.SPEPlan__c).get(tv.Supplier__c).get(tv.KPIDefinition__c);
          
          Integer periodRange = (Integer)spePlanKPIMap.PeriodRange__c;
          
          if (periodRange <= prevTrackerValues.size())
          {
            Integer numKPIScoreThreshold = 0;
            
            for (Integer i = 0; i < periodRange; i ++ )
            {
              if (prevTrackerValues[i].Score1__c != null &&
                tv.Score1__c != null &&
                prevTrackerValues[i].SPETracker__r.DateOfExecution__c < tv.SPETracker__r.DateOfExecution__c)
              {
                if (prevTrackerValues[i].Score1__c < spePlanKPIMap.KPIScoreThreshold__c)
                {
                  numKPIScoreThreshold ++;
                }
                else
                {
                  break;
                }
              }
            }
            
            if (numKPIScoreThreshold >= (periodRange - 1))
            {
              ticketType = spePlanKPIMap.CMTicket__c;
              needToCreateTicket = true;  
            }
          }
        }
      }
      
      if (needToCreateTicket == true)
      {
        toBeCreatedCMTicket.put(tv.Id, ticketType);
      }
    }
    
    GenerateCMTicket(toBeCreatedCMTicket, newTrackerValues);
  }
  
  private static void GenerateCMTicket(Map<Id, String> toBeCreatedCMTicket, List<SPE_TrackerValues__c> trackerValues)
  {
    if ( !toBeCreatedCMTicket.isEmpty())
    {
      List<SPE_ConsequenceManagement__c> toBeInsertedCM = new List<SPE_ConsequenceManagement__c>();
      
      Map<String, RecordType> recordTypeMap = new Map<String, RecordType>();                                           
      
      for (RecordType r: [Select Id,Name from RecordType where sObjectType = 'SPE_ConsequenceManagement__c'])
      {
        recordTypeMap.put(r.Name, r);
      }
      
      
      for (SPE_TrackerValues__c tv: trackerValues)
      {
          if (toBeCreatedCMTicket.get(tv.Id) != null && recordTypeMap.get(toBeCreatedCMTicket.get(tv.Id))!= null)
          {
              SPE_ConsequenceManagement__c cm = new SPE_ConsequenceManagement__c();
            
                cm.RecordTypeId = recordTypeMap.get(toBeCreatedCMTicket.get(tv.Id)).Id;
                cm.IsAutoGenerate__c = true;
                cm.Title__c = '';
                cm.TicketStatus__c = 'Draft';
                cm.Organization_Group__c = tv.KPIDefinition__r.Cluster__c;
                cm.Market__c = tv.SPETracker__r.Region__c;
                cm.MarketUnit__c = tv.SPETracker__r.SubRegion__c;
                cm.Country__c = tv.SPETracker__r.Country__c;
                cm.Project__c = tv.SPETracker__r.Project__c;
                cm.BusinessUnit__c = tv.SPETracker__r.BusinessUnit__c;
                cm.BusinessLine__c = tv.SPETracker__r.BusinessLine__c;
                cm.Product__c = tv.SPETracker__r.Product__c; 
                cm.CategoryArea__c = tv.SPETracker__r.CategoryCluster__c;
                cm.CategoryGroup__c = tv.SPETracker__r.CategoryGroup__c;
                cm.Category__c = tv.SPETracker__r.Category__c;
                cm.KPIName__c = tv.KPIDefinition__c;
                cm.Supplier__c = tv.Supplier__c;
                cm.SPETracker__c = tv.SPETracker__c;
                cm.Duplicate_Checker__c = cm.KPIName__c + '-' + cm.Supplier__c + '-' + cm.SPETracker__c + '-' + cm.RecordTypeId;
     
                toBeInsertedCM.add(cm);
          }
      }
      
      Database.SaveResult[] srList = Database.insert(toBeInsertedCM, false);
    }
  }
}