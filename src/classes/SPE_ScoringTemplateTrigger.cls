public with sharing class SPE_ScoringTemplateTrigger{

public static void updateHierarchyFields(List<SPE_ScoringTemplate__c> newSPETemps){
        
        for(SPE_ScoringTemplate__c spe :newSPETemps){
            spe.Geo_Hierarchy__c = spe.Region__c+'-->'+spe.SubRegion__c+'-->'+spe.Country__c+'-->'+spe.Project__c;
            spe.Product_Hierarchy__c = spe.BusinessUnit__c+'-->'+spe.BusinessLine__c+'-->'+spe.Product__c;
            spe.Category_Hierarchy__c = spe.CategoryCluster__c+'-->'+spe.CategoryGroup__c+'-->'+spe.Country__c;
           
        }    
   
   }
  }