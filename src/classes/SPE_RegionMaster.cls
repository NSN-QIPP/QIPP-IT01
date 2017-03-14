public with sharing class SPE_RegionMaster 
{
    
    public Map<String, String> projectCountryMap = new  Map<String, String>();
    
    public Map<String, String> countrySubregionMap = new  Map<String, String>();
    
    public Map<String, String> subRegionRegionMap = new  Map<String, String>();
    
    public Map<String, SPE_ProjectMaster__c> projectRegionMasterMap = new  Map<String, SPE_ProjectMaster__c>();
    
    public Map<String, String> categoryGrpMap = new Map<String, String>();
    
    public Map<String, String> grpClusterMap = new Map<String, String>();
    
    public Map<String, String> productBLMap = new Map<String, String>();
    
    public Map<String, String> BLBUMap = new Map<String, String>();
    
    public SPE_RegionMaster (String scope)
    {
        initialization(scope);
    }
    
    public SPE_RegionMaster ()
    {
    	for (SPE_ProjectMaster__c projectMaster : [SELECT  Project__c, Country__c, MarketUnit__c, Market__c FROM SPE_ProjectMaster__c])
		{	
			projectRegionMasterMap.put(projectMaster.Project__c, projectMaster);
			
			if (projectMaster.Project__c != null)
			{
				projectCountryMap.put(projectMaster.Project__c, projectMaster.Country__c);
			}
			
			if (projectMaster.Country__c != null)
			{
				countrySubregionMap.put(projectMaster.Country__c, projectMaster.MarketUnit__c);
			}
			
			if (projectMaster.MarketUnit__c != null)
			{
				subRegionRegionMap.put(projectMaster.MarketUnit__c, projectMaster.Market__c);
			}
		}
		
		for (SPE_CategoryMaster__c cat : [SELECT Cluster__c, Group__c, Category__c FROM SPE_CategoryMaster__c])
		{
			if (cat.Category__c != null)
			{
				categoryGrpMap.put(cat.Category__c, cat.Group__c);
			}
			if (cat.Group__c != null)
			{
            	grpClusterMap.put(cat.Group__c, cat.Cluster__c);
			}
		}
		
		for (SPE_BUBL__c b : [SELECT BusinessUnit__c, BusinessLine__c, Product__c FROM SPE_BUBL__c ])
		{
			if (b.Product__c != null)
			{
				productBLMap.put(b.Product__c, b.BusinessLine__c);
			}
			
			if (b.BusinessLine__c != null)
			{
            	BLBUMap.put(b.BusinessLine__c, b.BusinessUnit__c);
			}
		}
	}
    
    private void initialization(String scope)
    {
        if (scope == 'Project')
        {
            for (SPE_ProjectMaster__c master : [SELECT Project__c, marketUnit__c, Market__c, Country__c 
                                                FROM SPE_ProjectMaster__c]
                                                )
            {
                projectRegionMasterMap.put(master.Project__c, master);
            }
        }
        
        else if (scope == 'CO Country')
        {
            for (SPE_ProjectMaster__c master : [SELECT marketUnit__c, Market__c, Country__c 
                                                FROM SPE_ProjectMaster__c]
                                                )
            {
                countrySubregionMap.put(master.Country__c, master.Market__c);
                
                subRegionRegionMap.put(master.Market__c, master.marketUnit__c);
            }
        }
        
        else if (scope == 'CO Subregion')
        {
            for (SPE_ProjectMaster__c master : [SELECT marketUnit__c, Market__c FROM SPE_ProjectMaster__c])
            {
                subRegionRegionMap.put(master.Market__c, master.marketUnit__c);
            }
        }
        
        else if (scope == 'Category')
        {
            for (SPE_CategoryMaster__c cat : [SELECT Category__c, Group__c, Cluster__c
                                              FROM SPE_CategoryMaster__c])
            {
                categoryGrpMap.put(cat.Category__c, cat.Group__c);
                grpClusterMap.put(cat.Group__c, cat.Cluster__c);
            }
        }
        else if (scope == 'Category Group')
        {
            for (SPE_CategoryMaster__c cat : [SELECT Category__c, Group__c, Cluster__c
                                              FROM SPE_CategoryMaster__c])
            {
                grpClusterMap.put(cat.Group__c, cat.Cluster__c);
            }
        }
        else if (scope == 'BUBL')
        {
            for (SPE_BUBL__c b : [SELECT Id, BusinessUnit__c, BusinessLine__c, Product__c
                                  FROM SPE_BUBL__c])
            {
                productBLMap.put(b.Product__c, b.BusinessLine__c);
                BLBUMap.put(b.BusinessLine__c, b.BusinessUnit__c);
            }
        }
        else
        {
            for (SPE_RegionMaster__c master: [SELECT Id, CORegion__c, Country__c, GPRregion__c, GPRSubregion__c 
                                              FROM SPE_RegionMaster__c]
                                             )
            {
                countrySubregionMap.put(master.Country__c, master.GPRSubregion__c);
                
                subRegionRegionMap.put(master.GPRSubregion__c, master.GPRregion__c);
            }
        }
    }
    
}