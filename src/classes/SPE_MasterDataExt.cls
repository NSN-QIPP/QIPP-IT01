public class SPE_MasterDataExt 
{
    public Map<String, Map<String, Map<String, Set<String>>>> marketVsMarketUnitCountryProjectMap = new Map<String, Map<String, Map<String, Set<String>>>>();
    
    public Map<String, Map<String, Set<String>>> ctgAreaVsctgGroupCtgMap = new Map<String, Map<String, Set<String>>>();
    
    public Map<String, Map<String, Set<String>>> BUVsBLProduct = new Map<String, Map<String, Set<String>>>();
    
    List<SelectOption> optionsMarketUnit = new List<SelectOption>();
    List<SelectOption> optionsCountries = new List<SelectOption>();
    List<SelectOption> optionsProject = new List<SelectOption>();
    List<SelectOption> optionsBusinessLines = new List<SelectOption>();
    List<SelectOption> optionsProduct = new List<SelectOption>();
    List<SelectOption> optionsCategoryGrps = new List<SelectOption>();
    List<SelectOption> optionsCategory = new List<SelectOption>();
    
    List<PicklistDefaultValues__c> defaultPicklistValues; 
    
    public static string market1;
    public static string marketUnit1;
    public static string country1;
    public static string project1;
    public static string bu1;
    public static string bl1;
    public static string prd1;
    public static string ca1;
    public static string cg1;
    public static string ct1;
    
    public string marketMaster{get; set;}
    public string marketUnitMaster{get;set;}
    public string countryMaster{get;set;}
    public string projectMaster{get;set;}
    public string buMaster{get;set;}
    public string blMaster{get;set;}
    public string prdMaster{get;set;}
    public string caMaster{get;set;}
    public string cgMaster{get;set;}
    public string ctMaster{get;set;}
    
    public static Boolean isEdit = false;
    
    
    public SPE_MasterDataExt(Apexpages.Standardcontroller st)
    {   
        initialization();
        marketMaster = SPE_MathsUtil.market1; 
        marketUnitMaster =  SPE_MathsUtil.marketUnit1;
        countryMaster = SPE_MathsUtil.country1;
        projectMaster = SPE_MathsUtil.project1;
        caMaster = SPE_MathsUtil.ca1;
        cgMaster = SPE_MathsUtil.cg1;
        ctMaster = SPE_MathsUtil.ct1;
        buMaster = SPE_MathsUtil.bu1;
        blMaster = SPE_MathsUtil.bl1;
        prdMaster = SPE_MathsUtil.prd1;
    }
    
    public SPE_MasterDataExt()
    {   
        initialization();   
    }
    
    private void initialization()
    {   
        defaultPicklistValues = PicklistDefaultValues__c.getall().values();
        
        for (SPE_ProjectMaster__c projectMaster : [SELECT  Project__c, Country__c, MarketUnit__c, Market__c FROM SPE_ProjectMaster__c
                                                    WHERE Project__c != null AND Country__c != null AND MarketUnit__c != null AND
                                                          Market__c != null
                                                    ])
        {   
            Map<String, Map<String, Set<String>>> marketUnitVscountryProjectMap = new Map<String, Map<String, Set<String>>>();
            Map<String, Set<String>> countryVsProjectMap = new Map<String, Set<String>>();
            Set<String> projects = new Set<String>();
            
            if (marketVsMarketUnitCountryProjectMap.get(projectMaster.Market__c) != null)
            {
                marketUnitVscountryProjectMap = marketVsMarketUnitCountryProjectMap.get(projectMaster.Market__c);
            }
            
            if (marketUnitVscountryProjectMap.get(projectMaster.MarketUnit__c) != null)
            {
                countryVsProjectMap = marketUnitVscountryProjectMap.get(projectMaster.MarketUnit__c);
            }
            
            if (countryVsProjectMap.get(projectMaster.Country__c) != null)
            {
                projects = countryVsProjectMap.get(projectMaster.Country__c);
            }
            
            projects.add(projectMaster.Project__c);
            countryVsProjectMap.put(projectMaster.Country__c, projects);
            marketUnitVscountryProjectMap.put(projectMaster.MarketUnit__c, countryVsProjectMap);
            marketVsMarketUnitCountryProjectMap.put(projectMaster.Market__c, marketUnitVscountryProjectMap);
            
        }
        
        Map<String, Map<String, Set<String>>> marketUnitVscountryProjectMap = new Map<String, Map<String, Set<String>>>();
        Map<String, Set<String>> countryVsProjectMap = new Map<String, Set<String>>();
        Set<String> projects = new Set<String>();
        
        projects.add(defaultPicklistValues[0].Project__c);
        countryVsProjectMap.put(defaultPicklistValues[0].Country__c, projects);
        marketUnitVscountryProjectMap.put(defaultPicklistValues[0].Market_Unit__c, countryVsProjectMap);
        marketVsMarketUnitCountryProjectMap.put(defaultPicklistValues[0].Market__c, marketUnitVscountryProjectMap);
        
        for (SPE_CategoryMaster__c categoryMaster : [SELECT Cluster__c, Group__c, Category__c FROM SPE_CategoryMaster__c
                                                        WHERE Cluster__c != null AND Group__c != null AND Category__c != null])
        {
            Map<String, Set<String>> ctgGroupVsCtgMap = new Map<String, Set<String>>();
            Set<String> categories = new Set<String>();
            
            if (ctgAreaVsctgGroupCtgMap.get(categoryMaster.Cluster__c) != null)
            {
                ctgGroupVsCtgMap = ctgAreaVsctgGroupCtgMap.get(categoryMaster.Cluster__c);
            }
            
            else
            {
                ctgAreaVsctgGroupCtgMap.put(categoryMaster.Cluster__c, ctgGroupVsCtgMap);
                ctgGroupVsCtgMap.put(defaultPicklistValues[0].Category_Group__c, categories);
                categories.add(defaultPicklistValues[0].Category__c);
            }
            
            if (ctgGroupVsCtgMap.get(categoryMaster.Group__c) != null)
            {
                categories = ctgGroupVsCtgMap.get(categoryMaster.Group__c);
            }
            
            else
            {
                categories.add(defaultPicklistValues[0].Category__c);
            }
            
            categories.add(categoryMaster.Category__c);
            ctgGroupVsCtgMap.put(categoryMaster.Group__c, categories);
            ctgAreaVsctgGroupCtgMap.put(categoryMaster.Cluster__c, ctgGroupVsCtgMap);
        }
        
        Map<String, Set<String>> ctgGroupVsCtgMap = new Map<String, Set<String>>();
        Set<String> categories = new Set<String>();
        
        categories.add(defaultPicklistValues[0].Category__c);
        ctgGroupVsCtgMap.put(defaultPicklistValues[0].Category_Group__c, categories);
        ctgAreaVsctgGroupCtgMap.put(defaultPicklistValues[0].Category_Area__c, ctgGroupVsCtgMap);
        
        for (SPE_BUBL__c BUBLMaster : [SELECT BusinessUnit__c, BusinessLine__c, Product__c FROM SPE_BUBL__c
                                                        WHERE BusinessUnit__c != null AND BusinessLine__c != null AND Product__c != null])
        {
            Map<String, Set<String>> BLVsProductMap = new Map<String, Set<String>>();
            Set<String> products = new Set<String>();
            
            if (BUVsBLProduct.get(BUBLMaster.BusinessUnit__c) != null)
            {
                BLVsProductMap = BUVsBLProduct.get(BUBLMaster.BusinessUnit__c);
            }
            
            else
            {
                BUVsBLProduct.put(BUBLMaster.BusinessUnit__c, BLVsProductMap);
                BLVsProductMap.put(BUBLMaster.BusinessUnit__c, products);
                products.add(defaultPicklistValues[0].Product__c);
            }
            
            if (BLVsProductMap.get(BUBLMaster.BusinessLine__c) != null)
            {
                products = BLVsProductMap.get(BUBLMaster.BusinessLine__c);
            }
            
            else
            {
                products.add(defaultPicklistValues[0].Product__c);
            }
            
            products.add(BUBLMaster.Product__c);
            BLVsProductMap.put(BUBLMaster.BusinessLine__c, products);
            BUVsBLProduct.put(BUBLMaster.BusinessUnit__c, BLVsProductMap);
        }
        
        Map<String, Set<String>> BLVsProductMap = new Map<String, Set<String>>();
        Set<String> products = new Set<String>();
        
        products.add(defaultPicklistValues[0].Product__c);
        BLVsProductMap.put(defaultPicklistValues[0].Business_Line__c, products);
        BUVsBLProduct.put(defaultPicklistValues[0].Business_Unit__c, BLVsProductMap);
    }
    
    public List<SelectOption> getMarketValues() 
    {
        List<SelectOption> options = new List<SelectOption>();
        
        if (marketVsMarketUnitCountryProjectMap.keySet().contains(SPE_MathsUtil.market1))
        {
            options.add(new SelectOption(SPE_MathsUtil.market1, SPE_MathsUtil.market1));
        }
        else
        {
            SPE_MathsUtil.market1 = PicklistDefaultValues__c.getall().values()[0].Market__c;
            SPE_MathsUtil.marketUnit1 = PicklistDefaultValues__c.getall().values()[0].Market_Unit__c;
            SPE_MathsUtil.country1 = PicklistDefaultValues__c.getall().values()[0].Country__c;
            SPE_MathsUtil.project1 = PicklistDefaultValues__c.getall().values()[0].Project__c;
            
            options.add(new SelectOption(SPE_MathsUtil.market1, SPE_MathsUtil.market1));
        }
        
        for (String market: marketVsMarketUnitCountryProjectMap.keySet())
        {
            if (market != SPE_MathsUtil.market1)
            {
                options.add(new SelectOption(market, market));
            }
        }
        return options;
    }
     
    public List<SelectOption> getMarketUnitValues() 
    {   
        if (marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1) != null &&
            marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).keySet().contains(SPE_MathsUtil.marketUnit1) 
            )
        {
            optionsMarketUnit.add(new SelectOption(SPE_MathsUtil.marketUnit1, SPE_MathsUtil.marketUnit1));
        }
        else
        {
            SPE_MathsUtil.marketUnit1 = PicklistDefaultValues__c.getall().values()[0].Market_Unit__c;
            SPE_MathsUtil.country1 = PicklistDefaultValues__c.getall().values()[0].Country__c;
            SPE_MathsUtil.project1 = PicklistDefaultValues__c.getall().values()[0].Project__c;
            
            optionsMarketUnit.add(new SelectOption(SPE_MathsUtil.marketUnit1, SPE_MathsUtil.marketUnit1));
        }
        
        if (marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1) != null)
        {
            for (String marketUnit : marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).keySet())
            {
                if (marketUnit != SPE_MathsUtil.marketUnit1)
                {
                    optionsMarketUnit.add(new SelectOption(marketUnit, marketUnit));
                }
            }
        }
        
        if (SPE_MathsUtil.marketUnit1 != defaultPicklistValues[0].Market_Unit__c)
        {
            optionsMarketUnit.add(new SelectOption(defaultPicklistValues[0].Market_Unit__c, defaultPicklistValues[0].Market_Unit__c));
        }
        
        return optionsMarketUnit;
    }
    
    public List<SelectOption> getCountryValues() 
    {
        if (marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1) != null &&
            marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1) != null &&
            marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1).keySet().contains(SPE_MathsUtil.country1) )
        {
            optionsCountries.add(new SelectOption(SPE_MathsUtil.country1, SPE_MathsUtil.country1));
        }
        else
        {
            SPE_MathsUtil.country1 = PicklistDefaultValues__c.getall().values()[0].Country__c;
            SPE_MathsUtil.project1 = PicklistDefaultValues__c.getall().values()[0].Project__c;
    
            optionsCountries.add(new SelectOption(SPE_MathsUtil.country1, SPE_MathsUtil.country1));
        }
        
        if(SPE_MathsUtil.marketUnit1 != defaultPicklistValues[0].Market_Unit__c)
        {
            if (marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1) != null &&
                marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1) != null)
            {
                for (String country : marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1).keySet())
                {
                    if (country != SPE_MathsUtil.country1)
                    {
                        optionsCountries.add(new SelectOption(country, country));
                    }
                }
            }
        }
        
        if (SPE_MathsUtil.country1 != defaultPicklistValues[0].Country__c)
        {
            optionsCountries.add(new SelectOption(defaultPicklistValues[0].Country__c, defaultPicklistValues[0].Country__c));
        }
        
        return optionsCountries;
    }
    
    public List<SelectOption> getProjectValues() 
    {
        if (marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1) !=null &&
            marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1) != null &&
            marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1).get(SPE_MathsUtil.country1) != null  &&
            marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1).get(SPE_MathsUtil.country1).contains(SPE_MathsUtil.project1)
            )
        {
            optionsProject.add(new SelectOption(SPE_MathsUtil.project1, SPE_MathsUtil.project1));   
        }
        else
        {
            SPE_MathsUtil.project1 = PicklistDefaultValues__c.getall().values()[0].Project__c;
            
            optionsProject.add(new SelectOption(SPE_MathsUtil.project1, SPE_MathsUtil.project1));
        }
        
        
        if(SPE_MathsUtil.country1 != defaultPicklistValues[0].Country__c)
        {
            if (marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1) !=null &&
                marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1) != null &&
                marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1).get(SPE_MathsUtil.country1) != null 
                )
            {
                for (String project : marketVsMarketUnitCountryProjectMap.get(SPE_MathsUtil.market1).get(SPE_MathsUtil.marketUnit1).get(SPE_MathsUtil.country1))
                {
                    if (project != SPE_MathsUtil.project1)
                    {
                        optionsProject.add(new SelectOption(project, project));
                    }
                }
            }
        }
        
        if (SPE_MathsUtil.project1 != defaultPicklistValues[0].Project__c)
        {
            optionsProject.add(new SelectOption(defaultPicklistValues[0].Project__c, defaultPicklistValues[0].Project__c));
        }
        
        return optionsProject;
    }
    
    public List<SelectOption> getCaValues() 
    {
        List<SelectOption> options = new List<SelectOption>();
        
        if (ctgAreaVsctgGroupCtgMap.keySet().contains(SPE_MathsUtil.ca1))
        {
            options.add(new SelectOption(SPE_MathsUtil.ca1, SPE_MathsUtil.ca1));
        }
        else 
        {
            SPE_MathsUtil.ca1 = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            
            options.add(new SelectOption(SPE_MathsUtil.ca1, SPE_MathsUtil.ca1));
        }
        
        for (String categoryArea : ctgAreaVsctgGroupCtgMap.keySet())
        {
            if (categoryArea != SPE_MathsUtil.ca1)
            {
                options.add(new SelectOption(categoryArea, categoryArea));
            }
        }
        return options;
    }
    
    public List<SelectOption> getCgValues() 
    {
        if (ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1) !=null &&
            ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1).keySet().contains(SPE_MathsUtil.cg1)
           )
        {
            optionsCategoryGrps.add(new SelectOption(SPE_MathsUtil.cg1, SPE_MathsUtil.cg1));
        }
        else
        {
            SPE_MathsUtil.cg1 = PicklistDefaultValues__c.getall().values()[0].Category_Group__c;
            SPE_MathsUtil.ct1 = PicklistDefaultValues__c.getall().values()[0].Category__c;
            
            optionsCategoryGrps.add(new SelectOption(SPE_MathsUtil.cg1, SPE_MathsUtil.cg1));
        }
        
        for (String categoryGroup : ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1).keySet())
        {
            if (categoryGroup != SPE_MathsUtil.cg1)
            {
                optionsCategoryGrps.add(new SelectOption(categoryGroup, categoryGroup));
            }
        }
        
        return optionsCategoryGrps;
    }
    
    public List<SelectOption> getCategoryValues()
    {
        
        if (ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1) != null &&
            ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1).get(SPE_MathsUtil.cg1) != null &&
            ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1).get(SPE_MathsUtil.cg1).contains(SPE_MathsUtil.ct1)
            )
        {
            optionsCategory.add(new SelectOption(SPE_MathsUtil.ct1, SPE_MathsUtil.ct1));
        }
        else
        {
            SPE_MathsUtil.ct1 = PicklistDefaultValues__c.getall().values()[0].Category__c;
            
            optionsCategory.add(new SelectOption(SPE_MathsUtil.ct1, SPE_MathsUtil.ct1));
        }
        
        if (ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1) != null &&
            ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1).get(SPE_MathsUtil.cg1) != null 
            )
        {
            for (String categorry: ctgAreaVsctgGroupCtgMap.get(SPE_MathsUtil.ca1).get(SPE_MathsUtil.cg1))
            {
                if (categorry != SPE_MathsUtil.ct1)
                {
                    optionsCategory.add(new SelectOption(categorry, categorry));    
                }
            }
        }
        
        return optionsCategory;
    }
    
     public List<SelectOption> getBuValues() 
     {
        List<SelectOption> options = new List<SelectOption>();
        
        if (BUVsBLProduct.keySet().contains(SPE_MathsUtil.bu1))
        {
            options.add(new SelectOption(SPE_MathsUtil.bu1, SPE_MathsUtil.bu1));
        }
        else 
        {
            SPE_MathsUtil.bu1 = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            SPE_MathsUtil.bl1 = PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
            SPE_MathsUtil.prd1 = PicklistDefaultValues__c.getall().values()[0].Product__c;
            
            options.add(new SelectOption(SPE_MathsUtil.bu1, SPE_MathsUtil.bu1));
        }
        
        for (String BU : BUVsBLProduct.keySet())
        {
            if (BU != SPE_MathsUtil.bu1)
            {
                options.add(new SelectOption(BU, BU));
            }
        }
        return options;
    }
    
    public List<SelectOption> getBlValues() 
    {
        if (BUVsBLProduct.get(SPE_MathsUtil.bu1) != null &&
            BUVsBLProduct.get(SPE_MathsUtil.bu1).keySet().contains(SPE_MathsUtil.bl1)
            )
        {
            optionsBusinessLines.add(new SelectOption(SPE_MathsUtil.bl1, SPE_MathsUtil.bl1));
        }
        else
        {
            SPE_MathsUtil.bl1 = PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
            SPE_MathsUtil.prd1 = PicklistDefaultValues__c.getall().values()[0].Product__c;
            
            optionsBusinessLines.add(new SelectOption(SPE_MathsUtil.bl1, SPE_MathsUtil.bl1));
        }
        
        if (BUVsBLProduct.get(SPE_MathsUtil.bu1) != null)
        {
            for (String BL : BUVsBLProduct.get(SPE_MathsUtil.bu1).keySet())
            {
               if (BL != SPE_MathsUtil.bl1)
               {
                   optionsBusinessLines.add(new SelectOption(BL, BL));
               }
            }
        }
         
        return optionsBusinessLines;
    }
    
    public List<SelectOption> getProductValues() 
    {
        if (BUVsBLProduct.get(SPE_MathsUtil.bu1) != null &&
            BUVsBLProduct.get(SPE_MathsUtil.bu1).get(SPE_MathsUtil.bl1) != null &&
            BUVsBLProduct.get(SPE_MathsUtil.bu1).get(SPE_MathsUtil.bl1).contains(SPE_MathsUtil.prd1))
        {
            optionsProduct.add(new SelectOption(SPE_MathsUtil.prd1, SPE_MathsUtil.prd1));   
        }
        else
        {
            SPE_MathsUtil.prd1 = PicklistDefaultValues__c.getall().values()[0].Product__c;
            
            optionsProduct.add(new SelectOption(SPE_MathsUtil.prd1, SPE_MathsUtil.prd1));
        }
        optionsProduct.add(new SelectOption(SPE_MathsUtil.prd1, SPE_MathsUtil.prd1));
        
        if (SPE_MathsUtil.bl1 != defaultPicklistValues[0].Business_Line__c)
        {
            if (BUVsBLProduct.get(SPE_MathsUtil.bu1) != null &&
                BUVsBLProduct.get(SPE_MathsUtil.bu1).get(SPE_MathsUtil.bl1) != null
                )
            {
                for (String product: BUVsBLProduct.get(SPE_MathsUtil.bu1).get(SPE_MathsUtil.bl1))
                {
                    if (product != SPE_MathsUtil.prd1)
                    {
                        optionsProduct.add(new SelectOption(product, product));
                    }
                }
            }
        }
        
        return optionsProduct;
    }
    
    public void fillMarketUnit()
    {
        marketMaster = Apexpages.currentPage().getParameters().get('marketVal');
        
        optionsMarketUnit = new List<SelectOption>();
        for (String marketUnit : marketVsMarketUnitCountryProjectMap.get(marketMaster).keySet())
        {
            optionsMarketUnit.add(new SelectOption(marketUnit, marketUnit));
        }
        fillCountry();
    }
    
    public void fillCountry()
    {
        marketUnitMaster = Apexpages.currentPage().getParameters().get('marketUnitVal');
        
        if (marketUnitMaster == null)
        {
            marketUnitMaster = 'All Market Units';
        }
        
        optionsCountries = new List<SelectOption>();
        if(marketUnitMaster != defaultPicklistValues[0].Market_Unit__c)
        {
            for (String country : marketVsMarketUnitCountryProjectMap.get(marketMaster).get(marketUnitMaster).keySet())
            {
                optionsCountries.add(new SelectOption(country, country)); 
            }
        }
        else
        optionsCountries.add(new SelectOption(defaultPicklistValues[0].Country__c, defaultPicklistValues[0].Country__c));
        
        fillProject();
    }
    
     public void fillProject()
     {
        
        String marketVal = Apexpages.currentPage().getParameters().get('marketVal');
        
        String marketUnitVal = Apexpages.currentPage().getParameters().get('marketUnitVal');
        
        countryMaster = Apexpages.currentPage().getParameters().get('countryVal');
        
         if (countryMaster == null)
        {
            countryMaster = 'All Countries';
        }
        
        
        optionsProject = new List<SelectOption>();
        if (countryMaster != defaultPicklistValues[0].Country__c)
        {
            for (String project : marketVsMarketUnitCountryProjectMap.get(marketMaster).get(marketUnitMaster).get(countryMaster))
            {
                optionsProject.add(new SelectOption(project, project));
            }
        }
     }
     
     public void fillCategoryGroups()
     {
        caMaster = Apexpages.currentPage().getParameters().get('caVal');
        
        optionsCategoryGrps = new List<SelectOption>();
        
        for (String categoryGroup : ctgAreaVsctgGroupCtgMap.get(caMaster).keySet())
        {
            if (categoryGroup != SPE_MathsUtil.cg1 || caMaster == SPE_MathsUtil.ca1)
            {
                optionsCategoryGrps.add(new SelectOption(categoryGroup, categoryGroup));
            }
        }
        fillCategory();
     }
     
     public void fillCategory()
     {
        cgMaster = Apexpages.currentPage().getParameters().get('cgVal');
         if (cgMaster == null)
        {
            cgMaster = 'All Category Groups';
        }
        
        /*optionsCategory = new List<SelectOption>();
        for (String categorry: ctgAreaVsctgGroupCtgMap.get(caMaster).get(cgMaster))
        {
            if (categorry != SPE_MathsUtil.ct1)
            {
                optionsCategory.add(new SelectOption(categorry, categorry));
            }
        }*/
        
        optionsCategory = new List<SelectOption>();
        if (cgMaster != defaultPicklistValues[0].Category_Group__c)
        {
            for (String categorry: ctgAreaVsctgGroupCtgMap.get(caMaster).get(cgMaster))
            {
                optionsCategory.add(new SelectOption(categorry, categorry));
            }
        }
        
     }
     
     public void fillBusinessLines()
     {
        buMaster = Apexpages.currentPage().getParameters().get('buVal');
        
        optionsBusinessLines = new List<SelectOption>();
        
        for (String BL : BUVsBLProduct.get(buMaster).keySet())
        {
            if (BL != SPE_MathsUtil.bl1 || buMaster == SPE_MathsUtil.bu1)
            {
                optionsBusinessLines.add(new SelectOption(BL, BL));
            }
        }
        fillProduct();
     }
     
      public void fillProduct()
      {
        
        String buVal = Apexpages.currentPage().getParameters().get('buVal');
        
        blMaster = Apexpages.currentPage().getParameters().get('blVal');
        if (blMaster == null)
        {
            blMaster = 'All Business Lines';
        }

              
        optionsProduct = new List<SelectOption>();
        if (blMaster  != defaultPicklistValues[0].Business_Line__c)
        {    
            for (String product: BUVsBLProduct.get(buMaster).get(blMaster))
            {
                if (product != SPE_MathsUtil.prd1)
                {
                    optionsProduct.add(new SelectOption(product, product));
                }
            }
         
         }
      }
}