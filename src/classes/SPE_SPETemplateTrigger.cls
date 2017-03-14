public with sharing class SPE_SPETemplateTrigger 
{
    public static void DeleteValidation (List<SPE_SPETemplate__c> oldSPETemps)
    {
        for(SPE_SPETemplate__c spe: oldSPETemps)
        {
            if(spe.Stage__c == 'Published')
            {
                spe.addError('You cannot delete SPE Template');
            }
        }
    }
    
    public static void UpdateKPIDefinition(List<SPE_SPETemplate__c> newSPETemps, Map<Id, SPE_SPETemplate__c> oldSPETempMaps)
    {
        Set<Id> speTempIds = new Set<Id>();
        
        for (SPE_SPETemplate__c spe : newSPETemps)
        {
            if (spe.Stage__c == 'Published' && spe.Stage__c != oldSPETempMaps.get(spe.Id).Stage__c )
            {
                speTempIds.add(spe.Id);
            }
        }
        
        if (speTempIds.size() > 0)
        {
            List<SPE_KPIDefinition__c> toBeUpdatedKPI = new List<SPE_KPIDefinition__c>();
            
            for (SPE_SPEKPIMap__c speKPI : [SELECT KPIDefinition__c 
                                             FROM SPE_SPEKPIMap__c 
                                             WHERE SPETemplate__c In: speTempIds 
                                             AND KPIDefinition__r.LifecycleStage__c = 'Draft'])
            {
                SPE_KPIDefinition__c kpi = new SPE_KPIDefinition__c();
                kpi.Id = speKPI.KPIDefinition__c;
                kpi.LifecycleStage__c = 'Published';
                
                toBeUpdatedKPI.add(kpi);
            }
            
            update toBeUpdatedKPI;
        }
    }
    
    public static void updateHierarchyFields(List<SPE_SPETemplate__c> newSPETemps){
        
        for(SPE_SPETemplate__c spe :newSPETemps){
            spe.Geo_Hierarchy__c = spe.Region__c+'-->'+spe.SubRegion__c+'-->'+spe.Country__c+'-->'+spe.Project__c;
            spe.Product_Hierarchy__c = spe.BusinessUnit__c+'-->'+spe.BusinessLine__c+'-->'+spe.Product__c;
            spe.Category_Hierarchy__c = spe.CategoryCluster__c+'-->'+spe.CategoryGroup__c+'-->'+spe.Country__c;
            
        }    
       
         
    }
   
}