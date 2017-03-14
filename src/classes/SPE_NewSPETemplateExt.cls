public class SPE_NewSPETemplateExt 
{ 
    public SPE_SPETemplate__c SPETemp {get;set;}
    private SPE_SPETemplate__c SPETempCloned;  
    public List<SPE_SPEKPIMap__c> SPEKPIMaps{get;set;}
    
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
    
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    
    public SPE_NewSPETemplateExt(){}
    
    public SPE_NewSPETemplateExt (Apexpages.Standardcontroller st)
    {    
        this.standardController =st;
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

        
        
        if (st.getId() == null)
        {
            SPETemp = new SPE_SPETemplate__c();
            SPEKPIMaps = new List<SPE_SPEKPIMap__c>();
            
            //----------------Code for Custom picklist starts------------------------
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            prdVal = PicklistDefaultValues__c.getall().values()[0].Product__c;
           //----------------Code for Custom picklist ends------------------------ 
        }
        else 
        {
            SPETemp = [SELECT Name, Stage__c, Type__c, BusinessLine__c, Region__c, BusinessUnit__c, SubRegion__c, CategoryCluster__c, Country__c, Category__c, 
                              Project__c, CategoryGroup__c, Product__c, Product1__c, Product2__c, Product3__c, Organization_Group__c   
                       FROM SPE_SPETemplate__c 
                       WHERE Id =: st.getId()];
            SPETempCloned = new SPE_SPETemplate__c();
            if(Apexpages.currentPage().getParameters().get('isClone')!= null)
                SPETemp.Stage__c = 'Draft'; 
            /*SPE_MasterDataExt masterExt = new SPE_MasterDataExt();
            SPE_MathsUtil.market1 = SPETemp.Region__c;
            SPE_MathsUtil.bu1 = SPETemp.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = SPETemp.SubRegion__c;
            SPE_MathsUtil.bl1 = SPETemp.BusinessLine__c;
            SPE_MathsUtil.country1 = SPETemp.Country__c;
            SPE_MathsUtil.prd1 = SPETemp.Product__c;
            SPE_MathsUtil.project1 = SPETemp.Project__c;
            SPE_MathsUtil.ca1 = SPETemp.CategoryCluster__c;
            SPE_MathsUtil.cg1 = SPETemp.CategoryGroup__c;
            SPE_MathsUtil.ct1 = SPETemp.Category__c;*/ 
            
             //----------------Code for Custom picklist starts------------------------
            marketVal = SPETemp.Region__c != null && SPETemp.Region__c != '' ? SPETemp.Region__c : '';
            marketUnitVal = SPETemp.SubRegion__c != null && SPETemp.SubRegion__c != '' ? SPETemp.SubRegion__c : '';
            countryVal = SPETemp.Country__c != null && SPETemp.Country__c != '' ? SPETemp.Country__c : '';
            projectVal = SPETemp.Project__c != null && SPETemp.Project__c != '' ? SPETemp.Project__c : '';
            
            buVal = SPETemp.BusinessUnit__c != null && SPETemp.BusinessUnit__c != '' ? SPETemp.BusinessUnit__c : '';
            blVal = SPETemp.BusinessLine__c != null && SPETemp.BusinessLine__c != '' ? SPETemp.BusinessLine__c : '';
            prdVal = SPETemp.Product__c != null && SPETemp.Product__c != '' ? SPETemp.Product__c : '';
            
            caVal = SPETemp.CategoryCluster__c != null && SPETemp.CategoryCluster__c != '' ? SPETemp.CategoryCluster__c : '';
            cgVal = SPETemp.CategoryGroup__c != null && SPETemp.CategoryGroup__c != '' ? SPETemp.CategoryGroup__c : '';
            ctVal = SPETemp.Category__c != null && SPETemp.Category__c != '' ? SPETemp.Category__c : '';
            
            //----------------Code for Custom picklist Ends------------------------
            
            SPEKPIMaps = [SELECT KPIDefinition__c, KPIDefinition__r.Id,KPIDefinition__r.LifecycleStage__c, Weight__c, UseLatestKPIVersion__c FROM SPE_SPEKPIMap__c WHERE SPETemplate__c = : st.getId()];
            system.debug('SPEKPIMaps----' + SPEKPIMaps);
            
            SPEKPIMapsCloned = SPEKPIMaps.deepClone();
       }
      // showProdVals(); 
    }
    
    public void addNewKPI()
    {
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
                
        SPEKPIMaps.add(spekpi);
        //SPEKPIMapsCloned.add(spekpi);
    }
        
    public Pagereference removeNewKPI()
    {
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('rowIndex'));
        
        List<SPE_SPEKPIMap__c> newKPISPETemplateMaps = new List<SPE_SPEKPIMap__c>();
        
        for (integer i=0; i<SPEKPIMaps.size(); i++) 
        {
            if(i == rowIndex)
            {
                toBeDeletedSPEKPIMaps.add(SPEKPIMaps[i]);
                SPEKPIMaps.remove(i);
                //SPEKPIMapsCloned.remove(i);
            }
        }
        
        return null;
    }
    
    public Pagereference cancel()
    {
        Schema.DescribeSObjectResult r = SPE_SPETemplate__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr = new Pagereference('/');
       if(SPETemp.Id!=null){
          pr =new Pagereference('/'+SPETemp.Id);
       } else{
             pr =new Pagereference('/'+keyPrefix);
            }    
        return pr;
    }
    
    public Pagereference save()
    {
        Boolean isObsoleteKPIFound = false;
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
        if (checkValidation() == true)
        {
            
            SPETemp.Region__c = marketVal;
            SPETemp.BusinessUnit__c = buVal;
            SPETemp.SubRegion__c = marketUnitVal;
            SPETemp.BusinessLine__c = blVal;
            SPETemp.Country__c = countryVal;
            SPETemp.Product__c = prdVal;
            SPETemp.Project__c = projectVal;
            SPETemp.CategoryCluster__c = caVal;
            SPETemp.CategoryGroup__c = cgVal;
            SPETemp.Category__c = ctVal;
            
            
          try
          {
                
                // check for a specific parameter
                if (!UrlParameterMap.containsKey('isClone')){
                    upsert SPETemp;
                    
                    if(toBeDeletedSPEKPIMaps.size()>0)
                    {
                        List<SPE_SPEKPIMap__c> toBeHardDeletedSPEKPIMaps = new List<SPE_SPEKPIMap__c>();
                        
                        for (SPE_SPEKPIMap__c speKPI: toBeDeletedSPEKPIMaps)
                        {
                            if (speKPI.Id != null )
                            {
                                toBeHardDeletedSPEKPIMaps.add(speKPI);
                            }
                        }
                        System.debug('==List=='+toBeHardDeletedSPEKPIMaps);
                        delete toBeHardDeletedSPEKPIMaps;
                    }
                    
                    List<SPE_SPEKPIMap__c> toBeInsertedKPISPETemp = assignKPI(SPETemp);
                    upsert toBeInsertedKPISPETemp;
                   }
                   else{
                       system.debug('SPETemp---' + SPETemp);
                       system.debug('SPEKPIMapsCloned---' + SPEKPIMapsCloned);
                       SPETempCloned = SPETemp.clone(false,true,false,false);
                       SPEKPIMapsCloned = SPEKPIMaps.deepClone();
                       if(SPETempCloned != null)
                           insert SPETempCloned;
                       for(SPE_SPEKPIMap__c s : SPEKPIMapsCloned){
                           s.SPETemplate__c = SPETempCloned.id;
                       }
                       system.debug('****SPEKPIMapsCloned****' + SPEKPIMapsCloned);
                       if(!SPEKPIMapsCloned.isEmpty())
                           insert SPEKPIMapsCloned;
                   } 
           }
           
            catch(Exception ex)
            {
               ApexPages.addMessages(ex);
               return null;
            } 
           
          Pagereference pr;
          if (!UrlParameterMap.containsKey('isClone'))
              pr = new Pagereference('/'+ SPETemp.Id);
          else
              pr = new Pagereference('/'+ SPETempCloned.Id);
          return pr; 
        }
        return null;
          
    }
    
    private Boolean checkValidation()
    {
        Decimal total = 0;
        
        Set<Id>  addedKPIs = new Set<Id>();
        
        for (SPE_SPEKPIMap__c spekpi: SPEKPIMaps)
        {
            if (!addedKPIs.contains(spekpi.KPIDefinition__c))
            {
                addedKPIs.add(spekpi.KPIDefinition__c);
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_DuplicateKPI));
                return false;
            }   
            if (spekpi.Weight__c == null )
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_NullWeightage));
                return false;   
            }
            else
            {
                total = total + spekpi.Weight__c;
            }
        }
         
        if ( total != 100 )
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_Weightage));
            return false;
        }
        
        Map<Id, String> kpiIdLifecycleMap = new Map<Id, String>();
        
        for(SPE_KPIDefinition__c kpiDef : [SELECT Id, LifecycleStage__c FROM SPE_KPIDefinition__c WHERE Id IN : addedKPIs])
        {
            kpiIdLifecycleMap.put(kpiDef.Id, kpiDef.LifecycleStage__c);
        }
        
        for (SPE_SPEKPIMap__c kpispeTemp : SPEKPIMaps)
        {
            if (kpispeTemp.KPIDefinition__c == null)
            {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_KPIDefinition));
                 return false;
            }
            
            if (kpiIdLifecycleMap.get(kpispeTemp.KPIDefinition__c) == SPE_Constants.PI_OBSOLETE_LIFECYCLE)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_ObsoleteKPI));
                return false;
            }
         
        } 
        
        return true;
    }
        
    private List<SPE_SPEKPIMap__c> assignKPI (SPE_SPETemplate__c SPETemp)
    {
        List<SPE_SPEKPIMap__c> toBeInsertedKPISPETemp = new List<SPE_SPEKPIMap__c>();
                
        for (SPE_SPEKPIMap__c kpispeTemp : SPEKPIMaps)
        {
            kpispeTemp.SPETemplate__c = SPETemp.Id;
            toBeInsertedKPISPETemp.add(kpispeTemp);
        }       
        return toBeInsertedKPISPETemp;
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