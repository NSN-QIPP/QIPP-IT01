public class SPE_ReportHelperExt 
{ 
    public SPE_Report_Parameter__c SPEParameter {get;set;}
    public String reportParamId {get;set;}
    private SPE_SPETemplate__c SPETempCloned;  
    public boolean batchProcessed;
    public SPE_SPEKPIMap__c delSPEKPIMap;
    public List<SPE_SPEKPIMap__c> SPEKPIMaps{get;set;}
    public boolean displayReports{get;set;}
    private List<SPE_SPEKPIMap__c> toBeDeletedSPEKPIMaps = new List<SPE_SPEKPIMap__c>();
    List<SPE_SPEKPIMap__c> SPEKPIMapsCloned = new List<SPE_SPEKPIMap__c>();
    //--------------------------Initialization of Variables for Custom Picklist Starts---------------------
    public Set<String> lstTemp{get;set;}
    public string marketVal{get;set;} 
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;} 
    public string projectVal{get;set;}
    public string buVal {get;set;}
    public string blVal{get;set;}
    public string prdVal{get;set;}
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    List<SelectOption>  mkoptions;
    List<SelectOption> countryOptions;
    List<SelectOption> projectOptions;
    List<SelectOption> BusinessLineOptions;
    List<SelectOption> ProductOptions;
    List<SelectOption> CatGroupOptions;
    List<SelectOption> CategoryOptions;
    Set<String> setMarkets;
    Set<String> setBusinessUnits;
    Set<String> setCategoryArea;
    Set<String> setMarketUnit;
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails  {get;set;}
    public ApexPages.StandardController standardController { get; set; }
    public String startDate {get;set;}
    public List<Report> lstReports  {get;set;}
    public Map<String,ID> mapReportNameId;
    
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    
      public SPE_ReportHelperExt(Apexpages.Standardcontroller st){
          this.standardController =st;
          initReportHelper(); 
      }
    
    public void initReportHelper()
    {   
        batchProcessed = false;  
        displayReports = false;
        
        SPEParameter  = (SPE_Report_Parameter__c)standardController.getRecord();   
        lstReports  = new List<Report>();
        
        lstReports  = [Select id,DeveloperName from Report where DeveloperName in ('SPE_RegionCat_Report2','SPE_Region_Report2','SPE_Global_Report2','SPE_Country_Report2','SPE_GlobalCat_Report2')];
          mapReportNameId = new Map<String,Id>();
          for(Report r:lstReports){
              mapReportNameId.put(r.DeveloperName,r.ID);
          
          }
      
         //----------------Code for Custom picklist starts------------------------
        
            //--------------remove the separator ~Market,~BusinessUnit,~Category-----
            
        lstTemp = new Set<String>();
        setMarkets = new Set<String>();
        setBusinessUnits = new Set<String>();
        setCategoryArea = new Set<String>();
        
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
       
        
        for(String s : mapHierarchyDetails.keyset()){
            if(s.contains('~Market')){
                setMarkets.add(s.split('~')[0]);
                
            }
            if(s.contains('~BusinessUnit')){
                setBusinessUnits.add(s.split('~')[0]);
                system.debug('setBusinessUnits'+setBusinessUnits);
            }
            if(s.contains('~CategoryArea')){
                setCategoryArea.add(s.split('~')[0]);
            }
        }
        
                
        for(String s : mapHierarchyDetails.keyset()){
            if(s.contains('~Market')){
                String s1 = s.replace('~Market','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
            }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
            if(s.contains('~BusinessUnit')){
                String s1 = s.replace('~BusinessUnit','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
             }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
            if(s.contains('~CategoryArea')){
                String s1 = s.replace('~CategoryArea','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
            }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
        }
        
        system.debug('mapHierarchyDetails1 values---'+mapHierarchyDetails1);
        system.debug('mapHierarchyDetails1 same here--' + mapHierarchyDetails1.get('All MarketsAll Market Units'));
        //setMarketUnit = mapHierarchyDetails.get(marketVal);

        
        system.debug('setMarkets-----' + setMarkets);
        system.debug('setBusinessUnits-----' + setBusinessUnits);
        system.debug('setCategoryArea-----' + setCategoryArea);
        
        //----------------Code for Custom picklist ends------------------------

        
        
       
            SPEKPIMaps = new List<SPE_SPEKPIMap__c>();
            
            //----------------Code for Custom picklist starts------------------------
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            prdVal = PicklistDefaultValues__c.getall().values()[0].Product__c;
           //----------------Code for Custom picklist ends------------------------ 
        
        
    }
    
    // batch execution progress
    public String getMessage(){
            if(batchProcessed){
                Double itemsProcessed = 0;
                Double totalItems = 0;
                for(AsyncApexJob a : [select TotalJobItems, Status, NumberOfErrors, MethodName, JobType, JobItemsProcessed, Id, 
                                      CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob
                                       where ApexClass.Name = 'SPE_ScorecardReportBatch' order by CreatedDate desc limit 1]){
                    
                    itemsProcessed = a.JobItemsProcessed;
                    totalItems = a.TotalJobItems;
                }
                //Determine the percent complete based on the number of batches complete and set message
                if(totalItems == 0){
                    //A little check here as we don't want to divide by 0.
                    return 'Report execution Started...';
                }else{
                    
                    if(((itemsProcessed  / totalItems) * 100.0).intValue() == 100){
                        displayReports = true;
                        system.debug('displayReports123::');
                    }
                    system.debug('displayReports::'+((itemsProcessed/totalItems)*100.0).intValue());
                    return 'Reports execution ' + String.valueof(((itemsProcessed  / totalItems) * 100.0).intValue())+'% Complete. Reports and Dashboards are loading. Please wait..';
                }

            } else {
                return 'Reports are not required to execute. Loading available reports and dashboards!';
            }
        }
        
        public PageReference process() {
            batchProcessed = true;
            SPE_ScorecardReportBatch  reportBatch = new SPE_ScorecardReportBatch(SPEParameter);
            database.executeBatch(reportBatch,100);
            displayReports = true;
            return null;
        }
         
    
    public Pagereference cancel()
    {
        Schema.DescribeSObjectResult r = SPE_Report_Parameter__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr = new Pagereference('/');
       if(SPEParameter.Id!=null){
          pr =new Pagereference('/'+SPEParameter.Id);
       } else{
             pr =new Pagereference('/'+keyPrefix);
            }    
        return pr;
    }
    public pageReference mainPage()
    {
        //initReportHelper();
        pageReference pg = new pageReference('/apex/SPE_Report_Helper');
        pg.setRedirect(true);
        return pg;
        
    }
    public pageReference save()
    {    
        //SPEParameter  = (SPE_Report_Parameter__c)standardController.getRecord();  
        //if(SPEParameter == null)   
        Integer totalMonths = SPEParameter.Start_date__c.monthsBetween(SPEParameter.End_Date__c);
        system.debug('number of months'+totalMonths);
        if(totalMonths<=36){
        List<SPE_Report_Parameter__c> reportParamObj = new List<SPE_Report_Parameter__c>();
        Boolean isObsoleteKPIFound = false;
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
        SPEParameter.Region__c = marketVal;
        SPEParameter.Business_Unit__c= buVal;
        SPEParameter.SubRegion__c = marketUnitVal;
        SPEParameter.Business_Line__c= blVal;
        SPEParameter.Country__c = countryVal;
        SPEParameter.Product__c = prdVal;
        SPEParameter.Project__c = projectVal;
        SPEParameter.CategoryCluster__c = caVal;
        SPEParameter.Category_Group__c = cgVal;
        SPEParameter.Category__c = ctVal;
        
        
        if(SPEParameter.useCacheReport__c){
            reportParamObj = [SELECT Business_Line__c,Business_Unit__c,CategoryCluster__c,Category_Group__c,Category__c,Country__c,Product__c,Project__c,Region__c,SubRegion__c
                              FROM SPE_Report_Parameter__c where Business_Line__c=:blVal AND Region__c=:marketVal AND Business_Unit__c=:buVal AND
                              SubRegion__c=:marketUnitVal AND Country__c=:countryVal AND Product__c=:prdVal AND Project__c=:projectVal AND
                              CategoryCluster__c=:caVal AND Category_Group__c=:cgVal AND Category__c=:ctVal
                              AND Aggregation_Type__c =:SPEParameter.Aggregation_Type__c LIMIT 1];
         }
         if(reportParamObj.size()==0){
            insert SPEParameter;        
            reportParamId = SPEParameter.Id;
            SPE_ScorecardReportBatch  reportBatch = new SPE_ScorecardReportBatch(SPEParameter);
            database.executeBatch(reportBatch,100);
            batchProcessed = true;
         
         }
         
         if(reportParamObj.size()==1){
             reportParamId = reportParamObj[0].Id;
             displayReports = true;
         }
        
        //displayReports = true; 
        pageReference pf = new PageReference('/apex/SPE_Report_Generation');
        pf.setRedirect(false);
        return pf;
        
       }
       
       else{
          ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,Label.SPE_YearRange));
           return null;
       }    
    }
    
      public pageReference speCountryReport(){
       
        String reportName = mapReportNameId.get('SPE_Country_Report2');
        pageReference pf = new pageReference('/'+reportName+'?pv0='+string.valueOf(reportParamId).substring(0, 15));
        return pf;
    }
    
     public pageReference speRegionReport(){
         String reportName = mapReportNameId.get('SPE_Region_Report2');
        pageReference pf = new pageReference('/'+reportName+'?pv0='+string.valueOf(reportParamId).substring(0, 15));
        return pf;
    }
    
    public pageReference speRegionCatReport(){
        String reportName = mapReportNameId.get('SPE_RegionCat_Report2');
        pageReference pf = new pageReference('/'+reportName+'?pv0='+string.valueOf(reportParamId).substring(0, 15));
        return pf;
    }
    
    public pageReference speGlobalReport(){
        String reportName = mapReportNameId.get('SPE_Global_Report2');
        pageReference pf = new pageReference('/'+reportName+'?pv0='+string.valueOf(reportParamId).substring(0, 15));
        return pf;
    }
    
     public pageReference speGlobalCatReport(){
        String reportName = mapReportNameId.get('SPE_GlobalCat_Report2');
        pageReference pf = new pageReference('/'+reportName+'?pv0='+string.valueOf(reportParamId).substring(0, 15));
        return pf;
    }
    
    public pageReference speGlobalDashboard(){
        pageReference pf = new pageReference('/apex/SPEGlobalDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+'&dboardtype=GlobalDashboard');
        return pf;
    }
    
     public pageReference speCatGroupDashboard(){
        pageReference pf = new pageReference('/apex/SPECatGrpDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+'&dboardtype=CatGroupDashboard');
        return pf;
    }
    
    public pageReference speMarketUnitDashboard(){
        pageReference pf = new pageReference('/apex/SPEMarketUnitDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+'&dboardtype=MarketUnitDashboard');
        return pf;
    }
    
    public pageReference speMarketDashboard(){
        pageReference pf = new pageReference('/apex/SPEMarketDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+'&dboardtype=MarketDashboard');
        return pf;
    }
    
     public pageReference speRegionCatGroupDashboard(){
        pageReference pf = new pageReference('/apex/SPERegionCatGroupDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+
                                '&dboardtype=RegionCatGroupDashboard'+'&selectedRegion='+SPEParameter.Region__c);
        return pf;
    }
    
     public pageReference speSubRegionCatGroupDashboard(){
        pageReference pf = new pageReference('/apex/SPESubRegionCatGroupDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+
                                '&dboardtype=SubRegionCatGroupDashboard'+'&selectedsubRegion='+SPEParameter.SubRegion__c);
        return pf;
    }
    
    public pageReference speSupplierCoverageDashboard(){
        pageReference pf = new pageReference('/apex/speSupplierCoverageDashboard?rPramId='+string.valueOf(reportParamId).substring(0, 15)+'&dboardtype=SupplierCoverageDashboard');
        return pf;
    }
    
     public pageReference speSupplierIndexDashboard(){
        pageReference pf = new pageReference('/apex/SPESupplierIndex?rPramId='+string.valueOf(reportParamId).substring(0, 15)+'&dboardtype=SupplierPerfIndexDashboard');
        return pf;
    }
    //----------------Code for Custom picklist starts------------------------
  
  //-----------------Fetch dropdown values of Market-------------
  
     public List<SelectOption> getMarketValues() 
    {
        List<SelectOption> options = new List<SelectOption>();
        if(!setMarkets.contains(PicklistDefaultValues__c.getall().values()[0].Market__c))
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market__c,PicklistDefaultValues__c.getall().values()[0].Market__c));
        for(String s : setMarkets){
            options.add(new SelectOption(s,s));
        }
        system.debug('market is'+marketVal);
        
        return options;
    }
 
  
   
     //------- Fetch dropdown values of Market Unit ---------------
    
      public List<SelectOption> getMarketUnitValues() 
        {   
            fillMarketUnit();
            return mkoptions;
        }
    
        public void fillMarketUnit()
        {
            if(Apexpages.currentPage().getParameters().get('marketVal')!= null)
                marketVal = Apexpages.currentPage().getParameters().get('marketVal');
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            system.debug('marketVal----' + marketVal);
            setMUVal = mapHierarchyDetails1.get(marketVal);
            system.debug('setMUVal----' + setMUVal);
            if(!setMUVal.contains(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c))
                mkoptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,PicklistDefaultValues__c.getall().values()[0].Market_Unit__c));
            system.debug('marketVal---' + marketVal); 
            for(String s : mapHierarchyDetails1.get(marketVal)){
                mkoptions.add(new SelectOption(s,s));
              }
   
        }
       //----------------Fetch Dropdown Values for Country -----------------
        
        public List<SelectOption> getCountryValues() 
        {   
            fillCountry();
            return countryOptions;
        }
        
        public void fillCountry()
        {
            if(Apexpages.currentPage().getParameters().get('marketUnitVal')!= null)
                marketUnitVal = Apexpages.currentPage().getParameters().get('marketUnitVal');
            countryOptions = new List<SelectOption>();
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal)))
            {
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
    
            }
          else if(marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal);
                
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Country__c))
                    countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
                
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal)){
                    countryOptions.add(new SelectOption(s,s));
                }
            }
            
            else{
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
            }
            
        }
        
     //------------------Fetch dropdown values of Project------------------
    
        public List<SelectOption> getProjectValues() 
        {   
            fillProject();
            return projectOptions;
        }
        
        public void fillProject()
        {
            if(Apexpages.currentPage().getParameters().get('countryVal')!= null)
                countryVal = Apexpages.currentPage().getParameters().get('countryVal');
            projectOptions = new List<SelectOption>();
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || (marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c) || (countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal+countryVal)) )
            {
                 projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
            
            else if(countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal);
                
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Project__c))
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
                
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal)){
                    projectOptions.add(new SelectOption(s,s));
                }
            }
            else{
                projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
            
        }
        
        //--------------Fetch dropdown values of Business Units------------------------------
        
       public List<SelectOption> getBusinessUnitValues() 
        {
            List<SelectOption> options = new List<SelectOption>();
            if(!setBusinessUnits.contains(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c,PicklistDefaultValues__c.getall().values()[0].Business_Unit__c));
            for(String s : setBusinessUnits){
                options.add(new SelectOption(s,s));
            }
            
            return options;
        }
     
     //--------------------Fetch dropdown values for Business Line-------------------
         
          public List<SelectOption> getBusinesLineValues() 
        {   
            fillBusinessLine();
            return BusinessLineOptions;
        }
        
       public void fillBusinessLine()
        {
            if(Apexpages.currentPage().getParameters().get('buVal')!= null)
                buVal= Apexpages.currentPage().getParameters().get('buVal');
            BusinessLineOptions= new List<SelectOption>();
            Set<String> setBUVal = new Set<String>();
            setBUVal = mapHierarchyDetails1.get(buVal);
            if(!setBUVal.contains(PicklistDefaultValues__c.getall().values()[0].Business_Line__c))
                BusinessLineOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Line__c,PicklistDefaultValues__c.getall().values()[0].Business_Line__c));
           
            for(String s : mapHierarchyDetails1.get(buVal)){
                BusinessLineOptions.add(new SelectOption(s,s));
            }
        }
    
    
    //----------------Fetch dropdown values for Product------------------------------
    
          public List<SelectOption> getProductValues() 
        {   
            fillProduct();
            return ProductOptions;
        }
        
       public void showProdVals(){
           fillProduct();
       }
        
       public void fillProduct()
        {
            
            if(Apexpages.currentPage().getParameters().get('blVal')!= null)
                blVal= Apexpages.currentPage().getParameters().get('blVal');
            
            system.debug('I am here-blVal--' + blVal);
            system.debug('I am here-buVal--' + buVal);
            ProductOptions= new List<SelectOption>();
            lstTemp = new Set<String>();
            Set<String> setProductVal = new Set<String>();
            setProductVal = mapHierarchyDetails1.get(buVal+blVal);
            
             if((buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) || !(mapHierarchyDetails1.containsKey(buVal+blVal)))
            {
              system.debug('I am here---');
              ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
              lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
            
            else if(!setProductVal .contains(PicklistDefaultValues__c.getall().values()[0].Product__c)){
                ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
                lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);   
                for(String s : mapHierarchyDetails1.get(buVal+blVal)){
                    ProductOptions.add(new SelectOption(s,s));
                    lstTemp.add(s);  
                }
            }
            else{
             ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
             lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
        }
        
  
    //--------------Fetch dropdown values for Category Area--------------------
    
      
       public List<SelectOption> getCategoryAreaValues() 
        {
            List<SelectOption> options = new List<SelectOption>();
            if(!setCategoryArea.contains(PicklistDefaultValues__c.getall().values()[0].Category_Area__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Area__c,PicklistDefaultValues__c.getall().values()[0].Category_Area__c));
            for(String s : setCategoryArea ){
                options.add(new SelectOption(s,s));
            }
            
            return options;
        }
     
    //-----------------Fetch dropdown values for Category Group---------------------------
    
        public List<SelectOption> getCategoryGroupValues() 
        {   
            fillCategoryGroup();
            return CatGroupOptions;
        }
        
       public void fillCategoryGroup()
        {
            if(Apexpages.currentPage().getParameters().get('caVal')!= null)
                blVal= Apexpages.currentPage().getParameters().get('caVal');
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            if(!setCatGroupVal .contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c))
                CatGroupOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Group__c,PicklistDefaultValues__c.getall().values()[0].Category_Group__c));
           
            for(String s : mapHierarchyDetails1.get(caVal)){
                CatGroupOptions.add(new SelectOption(s,s));
            }
        }
    
    //----------------------Fetch drop down values for Category----------------------------
    
         public List<SelectOption> getCategoryValues() 
        {   
            fillCategory();
            return CategoryOptions;
        }
        
       public void fillCategory()
        {
            if(Apexpages.currentPage().getParameters().get('cgVal')!= null)
                blVal= Apexpages.currentPage().getParameters().get('cgVal');
            CategoryOptions= new List<SelectOption>();
            Set<String> setCatVal = new Set<String>();
            setCatVal = mapHierarchyDetails1.get(caVal+cgVal);
            
             if((caVal== PicklistDefaultValues__c.getall().values()[0].Category_Area__c) || !(mapHierarchyDetails1.containsKey(caVal+cgVal)))
            {
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
           
            }
            
         else  if(!setCatVal .contains(PicklistDefaultValues__c.getall().values()[0].Category__c)){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
           
            for(String s : mapHierarchyDetails1.get(caVal+cgVal)){
                CategoryOptions.add(new SelectOption(s,s));
            }
          }
          
          else
          
           CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
      
        }
        
        public void blankMethod(){
             if(Apexpages.currentPage().getParameters().get('rerenderForm11')!= null)
                prdVal= Apexpages.currentPage().getParameters().get('rerenderForm11');
         }
 //----------------Code for Custom picklist ends------------------------
}