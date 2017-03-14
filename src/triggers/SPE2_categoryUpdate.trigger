trigger SPE2_categoryUpdate on SPE_CategoryInfo__c (before insert, before update) {
    Map<String, string> categoryMasterMap = new  Map<String, string>();
    list<SPE_CategoryMaster__c> catMasterlist = [select id, Category__c, Cluster__c, Group__c from SPE_CategoryMaster__c];
    for(SPE_CategoryMaster__c cm :catMasterlist ){
        categoryMasterMap.put(cm.Category__c + cm.Cluster__c + cm.Group__c, cm.id);
        
    }
    Map<String, string> productMasterMap = new  Map<String, string>();
    list<SPE_BUBL__c> productMasterlist = [select id, BusinessLine__c, BusinessUnit__c, Product__c from SPE_BUBL__c];
    for(SPE_BUBL__c pm :productMasterlist){
        productMasterMap.put(pm.BusinessLine__c + pm.BusinessUnit__c+ pm.Product__c , pm.id);
        
    }
    Map<String, string> projectMasterMap = new  Map<String, string>();
    list<SPE_ProjectMaster__c> projectMasterlist = [select id, Market__c, MarketUnit__c, Project__c, Country__c from SPE_ProjectMaster__c];
    for(SPE_ProjectMaster__c prm :projectMasterlist){
        projectMasterMap.put(prm.Market__c + prm.MarketUnit__c + prm.Project__c + prm.Country__c, prm.id);
        
    }
    
    for(SPE_CategoryInfo__c ci :trigger.New){
        ci.CategoryMaster__c = categoryMasterMap.get(ci.Category__c + ci.CategoryCluster__c + ci.CategoryGroup__c);
        ci.ProductMaster__c = productMasterMap.get(ci.BusinessLine__c + ci.BusinessUnit__c + ci.Product__c );
        ci.ProductMaster__c = projectMasterMap.get(ci.Region__c + ci.SubRegion__c + ci.Project__c + ci.Country__c);
    }
    
}