public with sharing class SPE_MasterDataTest {
    /*
    public static List<SPE_RegionMaster__c> createMassRegionMaster()
    {   
        List<SPE_RegionMaster__c> lstRegionMaster = new List<SPE_RegionMaster__c>();
        
        SPE_RegionMaster__c regionMaster1 = new SPE_RegionMaster__c();
        regionMaster1.CORegion__c = 'APAC';
        regionMaster1.Country__c = 'Thailand';
        regionMaster1.GPRregion__c = 'APAC';
        regionMaster1.GPRSubregion__c = 'APAC Asia North';
        lstRegionMaster.add(regionMaster1);
        
        SPE_RegionMaster__c regionMaster2 = new SPE_RegionMaster__c();
        regionMaster2.CORegion__c = 'ELAT EE';
        regionMaster2.Country__c = 'Belarus';
        regionMaster2.GPRregion__c = 'EUR North East';
        regionMaster2.GPRSubregion__c = 'EUR';
        lstRegionMaster.add(regionMaster2);
        
        SPE_RegionMaster__c regionMaster3 = new SPE_RegionMaster__c();
        regionMaster3.CORegion__c = 'ELAT SEE';
        regionMaster3.Country__c = 'Czech Republic';
        regionMaster3.GPRregion__c = 'EUR SEE';
        regionMaster3.GPRSubregion__c = 'EUR';
        lstRegionMaster.add(regionMaster3);
        
        SPE_RegionMaster__c regionMaster4 = new SPE_RegionMaster__c();
        regionMaster4.CORegion__c = 'JAPAN';
        regionMaster4.Country__c = 'Japan';
        regionMaster4.GPRregion__c = 'APA';
        regionMaster4.GPRSubregion__c = 'APA J';
        lstRegionMaster.add(regionMaster4);
        
        return lstRegionMaster;
    }
    
    public static List<SPE_ProjectMaster__c> createMassProjectMaster()
    {
        List<SPE_ProjectMaster__c> lstRegionMaster = new List<SPE_ProjectMaster__c>();
        
        SPE_ProjectMaster__c projectMaster1 = new SPE_ProjectMaster__c();
        projectMaster1.Name = '5024';
        projectMaster1.Market__c = 'CO AMEA';
        projectMaster1.Region__c = 'CHINA';
        projectMaster1.Country__c = 'CHINA';
        projectMaster1.Project__c = 'CN Beijing MCC';
        projectMaster1.CT__c = 'CHINA CMCC N Beijing';
        projectMaster1.CBT__c = 'CHINA CBT CMCC';
        lstRegionMaster.add(projectMaster1);
        
        SPE_ProjectMaster__c projectMaster2= new SPE_ProjectMaster__c();
        projectMaster2.Name = '2293';
        projectMaster2.Market__c = 'CO AMEA';
        projectMaster2.Region__c = 'JAPAN';
        projectMaster2.Country__c = 'Japan';
        projectMaster2.Project__c = 'Vodafone Japan';
        projectMaster2.CT__c = 'JAPAN JP Softbank';
        projectMaster2.CBT__c = 'JAPAN SR JP';
        lstRegionMaster.add(projectMaster2);
        
        SPE_ProjectMaster__c projectMaster3= new SPE_ProjectMaster__c();
        projectMaster3.Name = '3385';
        projectMaster3.Market__c = 'CO AMEA';
        projectMaster3.Region__c = 'INDIA';
        projectMaster3.Country__c = 'India';
        projectMaster3.Project__c = 'Bharti India';
        projectMaster3.CT__c = 'INDIA BHARTI Bharti';
        projectMaster3.CBT__c = 'INDIA CBT BHARTI';
        lstRegionMaster.add(projectMaster3);
        
        SPE_ProjectMaster__c projectMaster4= new SPE_ProjectMaster__c();
        projectMaster4.Name = '1014';
        projectMaster4.Market__c = 'CO ELAT';
        projectMaster4.Region__c = 'SEE';
        projectMaster4.Country__c = 'Switzerland';
        projectMaster4.Project__c = 'Sunrise';
        projectMaster4.CT__c = 'SEE CH Swiss';
        projectMaster4.CBT__c = 'SEE CBT CH';
        lstRegionMaster.add(projectMaster4);
        
        return lstRegionMaster;
    }

    public static List<SPE_CategoryMaster__c> CreateMassCategoryMaster()
    {
        List<SPE_CategoryMaster__c> lstcategoryMaster = new List<SPE_CategoryMaster__c>();
        
        SPE_CategoryMaster__c categoryMaster1 = new SPE_CategoryMaster__c();
        categoryMaster1.Category__c = 'Basestation Antennas';
        categoryMaster1.Cluster__c = 'DSP Category groups';
        categoryMaster1.Group__c = 'NI Materials';
        categoryMaster1.CurrencyIsoCode = 'EUR';
        lstcategoryMaster.add(categoryMaster1);
        
        SPE_CategoryMaster__c categoryMaster2 = new SPE_CategoryMaster__c();
        categoryMaster2.Category__c = 'HWS Inbound';
        categoryMaster2.Cluster__c = 'Indirect Procurement (INP)';
        categoryMaster2.Group__c = 'Logistics Services';
        categoryMaster2.CurrencyIsoCode = 'EUR';
        lstcategoryMaster.add(categoryMaster2);
        
        SPE_CategoryMaster__c categoryMaster3 = new SPE_CategoryMaster__c();
        categoryMaster3.Category__c = 'Site Installation Materials';
        categoryMaster3.Cluster__c = 'DSP Category groups';
        categoryMaster3.Group__c = 'NI Materials';
        categoryMaster3.CurrencyIsoCode = 'EUR';
        lstcategoryMaster.add(categoryMaster3);
        
        SPE_CategoryMaster__c CategoryMaster4 = new SPE_CategoryMaster__c();
        CategoryMaster4.Category__c = 'Facility Services';
        CategoryMaster4.Cluster__c = 'Indirect Procurement (INP)';
        CategoryMaster4.Group__c = 'Facility';
        CategoryMaster4.CurrencyIsoCode = 'EUR';
        lstcategoryMaster.add(categoryMaster4);
        
        return lstcategoryMaster;
    }
    
    public static List<SPE_BUBL__c> CreateMassBUBLMaster()
    {
        List<SPE_BUBL__c> lstBUBLMaster = new List<SPE_BUBL__c>();
        
        SPE_BUBL__c BUBLMaster1 = new SPE_BUBL__c();
        BUBLMaster1.BusinessLine__c = 'Mature Products';
        BUBLMaster1.BusinessUnit__c = 'Mobile Broadband';
        BUBLMaster1.Product__c = 'M1921';
        BUBLMaster1.ProductCode__c = '133-000101';
        BUBLMaster1.CurrencyIsoCode = 'EUR';
        lstBUBLMaster.add(BUBLMaster1);
        
        SPE_BUBL__c BUBLMaster2 = new SPE_BUBL__c();
        BUBLMaster2.BusinessLine__c = 'Mature Products';
        BUBLMaster2.BusinessUnit__c = 'Mobile Broadband';
        BUBLMaster2.Product__c = 'M1921';
        BUBLMaster2.ProductCode__c = '133-000101';
        BUBLMaster2.CurrencyIsoCode = 'EUR';
        lstBUBLMaster.add(BUBLMaster2);
        
        SPE_BUBL__c BUBLMaster3 = new SPE_BUBL__c();
        BUBLMaster3.BusinessLine__c = 'Single RAN';
        BUBLMaster3.BusinessUnit__c = 'Mobile Broadband';
        BUBLMaster3.Product__c = 'Talk Family BTS';
        BUBLMaster3.ProductCode__c = '133-000270';
        BUBLMaster3.CurrencyIsoCode = 'EUR';
        lstBUBLMaster.add(BUBLMaster3);
        
        SPE_BUBL__c BUBLMaster4 = new SPE_BUBL__c();
        BUBLMaster4.BusinessLine__c = 'Mature Products';
        BUBLMaster4.BusinessUnit__c = 'Mobile Broadband';
        BUBLMaster4.CurrencyIsoCode = 'EUR';
        BUBLMaster4.Product__c = 'N 1920';
        BUBLMaster4.ProductCode__c = '133-000254';
        lstBUBLMaster.add(BUBLMaster4);
        
        return lstBUBLMaster;
        
    }
*/
}