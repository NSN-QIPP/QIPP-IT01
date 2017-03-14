trigger SPE_ConsequenceManagementTrigger on SPE_ConsequenceManagement__c (before insert,before update) 
{
    Set<Id>  contactIds = new Set<Id>();
    Map<Id, Contact> contactMap;
    Map<Id, SPE_ConsequenceManagement__c> IdCMMap = new Map<Id, SPE_ConsequenceManagement__c>([SELECT Id, SPETracker__r.SPEPlan__c FROM SPE_ConsequenceManagement__c WHERE ID In: trigger.new]);
    

    for (SPE_ConsequenceManagement__c  cm: trigger.new)
    {
        contactIds.add(cm.Contact__c);
        contactIds.add(cm.SupplierManagerContact__c);
    }
    
    if (!contactIds.IsEmpty())
    {
        contactMap = new Map<Id, Contact>([SELECT Id, Email FROM Contact WHERE Id In: contactIds ]);
    }
    
    for (SPE_ConsequenceManagement__c cm: trigger.new)
    {
        cm.SPEPlan__c = IdCMMap.get(cm.Id) != null ? IdCMMap.get(cm.Id).SPETracker__r.SPEPlan__c : null;
        if (cm.Contact__c != null && contactMap.get(cm.Contact__c) != null)
        {
            cm.SupplierContactEmail__c = contactMap.get(cm.Contact__c).Email;
        }
        
        if (cm.SupplierManagerContact__c != null && contactMap.get(cm.SupplierManagerContact__c) != null)
        {
              cm.SupplierManager__c = contactMap.get(cm.SupplierManagerContact__c).Email;
        }
    }
    
    List<SPE_CMKPITrend__c> kpiTrends = [SELECT ConsequenceManagement__c, TrackerValue__c, KPIScore__c, DateofExecution__c FROM SPE_CMKPITrend__c WHERE ConsequenceManagement__c IN : trigger.new ORDER BY DateofExecution__c];
    
    Map<ID, List<SPE_CMKPITrend__c>> CMKpiTrends = new Map<ID, List<SPE_CMKPITrend__c>>();
    
    for (SPE_CMKPITrend__c cmkpi : kpiTrends)
    {
            List<SPE_CMKPITrend__c> newKpiTrends = new List<SPE_CMKPITrend__c>();
            if (CMKpiTrends.get(cmkpi.ConsequenceManagement__c) != null)
            {
                newKpiTrends = CMKpiTrends.get(cmkpi.ConsequenceManagement__c);
            }
            
            newKpiTrends.add(cmkpi);
            CMKpiTrends.put(cmkpi.ConsequenceManagement__c, newKpiTrends);
    }
    
    System.debug('CMKpiTrends'+CMKpiTrends);
    
    for (SPE_ConsequenceManagement__c  cm : trigger.new)
    {
        System.debug('=======>'+cm.ContWatchListResetDate__c);
        
        List<SPE_CMKPITrend__c> newKpiTrends = CMKpiTrends.get(cm.Id) != null ? CMKpiTrends.get(cm.Id) : null; 
        
        System.debug('newKpiTrends '+newKpiTrends );
        
        Integer i = 0;
        
        if (newKpiTrends  != null)
        {
            for (SPE_CMKPITrend__c nkt : newKpiTrends )
            {
                if (nkt.DateofExecution__c >= cm.ContWatchListResetDate__c && nkt.KPIScore__c > cm.KPIScoreThreshold__c)
                {
                    i++;
                    System.debug('======>'+i);
                    if (i == cm.ContinuouslyAboveThreshold_Period__c)
                    {
                        break;
                    }
                }
                else
                {
                    i = 0;
                }
            }
        }
        
        if (i >= cm.ContinuouslyAboveThreshold_Period__c)
        {
            cm.ReadyToBeClosed__c = true;
        }
        else
        {
            cm.ReadyToBeClosed__c = false;
        }
    
    }
    
}