public with sharing class SPE_SPEPlanAutoCMTicketExt 
{
  public SPE_SPEPlan__c spePlan {get;set;}
  public List<SPE_PlanKPIMap__c> spePlanKPIMaps {get;set;}
  
  public SPE_SPEPlanAutoCMTicketExt (ApexPages.StandardController std)
  {
    std.addFields(new List<String>{'SPEPlanName__c', 'SPETemplate__c', 'AutoTicket__c'});
    this.spePlan = (SPE_SPEPlan__c)std.getRecord();
    
    spePlanKPIMaps = new List<SPE_PlanKPIMap__c>();
    initialize();
  }
  
  private void initialize()
  {
    //****************************************Changes For Encryption********************************//
    List<SPE_SPEKPIMap__c> spekpidef =[SELECT ID, KPIDefinition__c, KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, KPIDefinition__r.Level__c 
                                           FROM SPE_SPEKPIMap__c 
                                           WHERE SPETemplate__c=:spePlan.SPETemplate__c];
    //****************************************END********************************//
    
    List<SPE_PlanKPIMap__c> planKPIs =[SELECT ID, CMTicket__c, KPI__c, KPIScoreThreshold__c, PeriodRange__c, SPEPlan__c
                                           FROM SPE_PlanKPIMap__c 
                                           WHERE SPEPlan__c=:spePlan.Id];
    
    Set<Id> kpiIds = new Set<Id>();
    
    for (SPE_PlanKPIMap__c spk: planKPIs)
    {
      SPE_PlanKPIMap__c planKPI = spk;
      kpiIds.add(spk.KPI__c);
      
      spePlanKPIMaps.add(planKPI);
    }
    for (SPE_SPEKPIMap__c sk : spekpidef)
    {
      if (! kpiIds.contains(sk.KPIDefinition__c))
      {
        SPE_PlanKPIMap__c planKPI = new SPE_PlanKPIMap__c();
        
        planKPI.KPI__c = sk.KPIDefinition__c;
        planKPI.SPEPlan__c = spePlan.Id; 
        
        spePlanKPIMaps.add(planKPI);  
      }
    }
  }
  
  public PageReference  Save()
  {
    upsert spePlanKPIMaps;
    update spePlan;
    
    return new ApexPages.StandardController(spePlan).view();
  }

}