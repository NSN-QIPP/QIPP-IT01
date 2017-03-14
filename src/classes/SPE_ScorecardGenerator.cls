public with sharing class SPE_ScorecardGenerator 
{
    public SPE_ScorecardGenerator__c scoreCardgenerate{get;set;}
    
    private Date startDate;
    private Date endDate;
    private String frequencyInMonths;
    public Boolean isTrackerCreated {get;set;}
    private string errorMsg = '';
    public Boolean isScopeMatch {get;set;}
    public Boolean isValid {get;set;}
    public Boolean isObsolete{get;set;}
    public String stID{get;set;}
    public SPE_ScorecardTemplate__c scorecardTemplate {get;set;}
    public SPE_ScorecardTemplate__c scorecardTemplateNew {get;set;}
    
    public SPE_ScorecardTemplate__c scorecardTemplatescope {get;set;}
    
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
    SPE_ScorecardGenerator__c scoreCardgenerateCloned;
    
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    public string param1{get;set;}
    public ApexPages.StandardController StdCtrl;

     
    public SPE_ScorecardGenerator (ApexPages.Standardcontroller st) 
    {
        scoreCardgenerateCloned = new SPE_ScorecardGenerator__c();
        String Loc;
        System.debug('$$$$$$$$$$$$$$$$$$$$$ The value is 111: ');
        isTrackerCreated = false;
        stID = st.getId();
        StdCtrl = st;
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
        
        
        if (stdCtrl.getId() == null) 
        {
            scoreCardgenerate = new SPE_ScorecardGenerator__c();
            scoreCardgenerate.Stage__c = 'Draft';
            //fetchTemplateDetails();
            
            //scoreCardgenerate = (SPE_ScorecardGenerator__c) stdCtrl.getRecord();
            
          //----------------Code for Custom picklist starts------------------------
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            prdVal = PicklistDefaultValues__c.getall().values()[0].Product__c;
           //----------------Code for Custom picklist ends------------------------ 
                           
        }     
        
        else
        {            
            scoreCardgenerate = new SPE_ScorecardGenerator__c();
            scoreCardgenerate = [SELECT BusinessLine__c,Scorecardtemplate_Stage__c, IsAutoApproved__c,isAutoDistributionON__c
,Stage__c, BusinessUnit__c, Category__c, CategoryCluster__c, CategoryGroup__c, Country__c, DisplaySpend__c,
                                        DisplayUnits__c, EndDate__c, Product__c, Product1__c, Product2__c, Product3__c, Project__c, RangeEndDate__c, RangeStartDate__c, 
                                        Region__c, StartDate__c, SubRegion__c, ScorecardTemplate__c, FrequencyInMonths__c, Name, TimeFrame__c,AggregationType__c
                                FROM SPE_ScorecardGenerator__c
                                WHERE Id =: stdCtrl.getId()];
            
            
            /*if(scoreCardgenerate.ScorecardTemplate__c != Null)
            {
                System.Debug('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+scoreCardgenerate.ScorecardTemplate__c); 
                   
                scorecardTemplatescope = [Select Region__c,BusinessUnit__c,SubRegion__c,BusinessLine__c,Country__c,Product__c,Project__c,CategoryCluster__c,
                                        CategoryGroup__c,Category__c from SPE_ScorecardTemplate__c where Id =: scoreCardgenerate.ScorecardTemplate__c];
               
                scoreCardgenerate.Region__c = scorecardTemplatescope.Region__c;
                scoreCardgenerate.BusinessUnit__c = scorecardTemplatescope.BusinessUnit__c;
                scoreCardgenerate.SubRegion__c = scorecardTemplatescope.SubRegion__c;
                scoreCardgenerate.BusinessLine__c = scorecardTemplatescope.BusinessLine__c;
                scoreCardgenerate.Country__c = scorecardTemplatescope.Country__c;
                scoreCardgenerate.Product__c = scorecardTemplatescope.Product__c;
                scoreCardgenerate.Project__c = scorecardTemplatescope.Project__c;
                scoreCardgenerate.CategoryCluster__c = scorecardTemplatescope.CategoryCluster__c;
                scoreCardgenerate.CategoryGroup__c = scorecardTemplatescope.CategoryGroup__c;
                scoreCardgenerate.Category__c = scorecardTemplatescope.Category__c;
             }
            
                                             
            SPE_MathsUtil.market1 = scoreCardgenerate.Region__c;
            SPE_MathsUtil.bu1 = scoreCardgenerate.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = scoreCardgenerate.SubRegion__c;
            SPE_MathsUtil.bl1 = scoreCardgenerate.BusinessLine__c;
            SPE_MathsUtil.country1 = scoreCardgenerate.Country__c;
            SPE_MathsUtil.prd1 = scoreCardgenerate.Product__c;
            SPE_MathsUtil.project1 = scoreCardgenerate.Project__c;
            SPE_MathsUtil.ca1 = scoreCardgenerate.CategoryCluster__c;
            SPE_MathsUtil.cg1 = scoreCardgenerate.CategoryGroup__c;
            SPE_MathsUtil.ct1 = scoreCardgenerate.Category__c;
            ***/
            //----------------Code for Custom picklist starts------------------------
            marketVal = scoreCardgenerate.Region__c != null && scoreCardgenerate.Region__c != '' ? scoreCardgenerate.Region__c : '';
            marketUnitVal = scoreCardgenerate.SubRegion__c != null && scoreCardgenerate.SubRegion__c != '' ? scoreCardgenerate.SubRegion__c : '';
            countryVal = scoreCardgenerate.Country__c != null && scoreCardgenerate.Country__c != '' ? scoreCardgenerate.Country__c : '';
            projectVal = scoreCardgenerate.Project__c != null && scoreCardgenerate.Project__c != '' ? scoreCardgenerate.Project__c : '';
            
            buVal = scoreCardgenerate.BusinessUnit__c != null && scoreCardgenerate.BusinessUnit__c != '' ? scoreCardgenerate.BusinessUnit__c : '';
            blVal = scoreCardgenerate.BusinessLine__c != null && scoreCardgenerate.BusinessLine__c != '' ? scoreCardgenerate.BusinessLine__c : '';
            prdVal = scoreCardgenerate.Product__c != null && scoreCardgenerate.Product__c != '' ? scoreCardgenerate.Product__c : '';
            
            caVal = scoreCardgenerate.CategoryCluster__c != null && scoreCardgenerate.CategoryCluster__c != '' ? scoreCardgenerate.CategoryCluster__c : '';
            cgVal = scoreCardgenerate.CategoryGroup__c != null && scoreCardgenerate.CategoryGroup__c != '' ? scoreCardgenerate.CategoryGroup__c : '';
            ctVal = scoreCardgenerate.Category__c != null && scoreCardgenerate.Category__c != '' ? scoreCardgenerate.Category__c : '';
            
            //----------------Code for Custom picklist Ends------------------------
            
            startDate = scoreCardgenerate.StartDate__c;
            endDate = scoreCardgenerate.EndDate__c;
            frequencyInMonths = scoreCardgenerate.FrequencyInMonths__c;
            
        }
        
        if ([SELECT Id FROM SPE_ScorecardTracker__c WHERE ScorecardGenerator__c =: scoreCardgenerate.Id] != null && [SELECT Id FROM SPE_ScorecardTracker__c WHERE ScorecardGenerator__c =: scoreCardgenerate.Id].size() > 0)
        {
            isTrackerCreated = true;
        } 
  
    }
   /* 
    public pageReference readTemplate()
    {
        scorecardTemplateNew = [SELECT Id,Name,BusinessLine__c,BusinessUnit__c,Category__c,CategoryCluster__c,CategoryGroup__c,Country__c,KPIDefinition__c,Region__c,SubRegion__c,Organization_Group__c,Product__c,Product1__c,Product2__c,Product3__c,Project__c,ScorecardTemplateId__c,Stage__c FROM SPE_ScorecardTemplate__c WHERE Id = : scoreCardgenerate.ScorecardTemplate__c];
        System.debug('$$$$$$$$$$$$$$$$$$$$$ The value is: Name New '+scorecardTemplateNew.Name);
        marketVal = scorecardTemplateNew.Region__c;
        marketUnitVal = scorecardTemplateNew.SubRegion__c;
        countryVal = scorecardTemplateNew.Country__c;
        projectVal = scorecardTemplateNew.Project__c;
        ctVal = scorecardTemplateNew.CategoryCluster__c;
        cgVal = scorecardTemplateNew.CategoryGroup__c;
        caVal = scorecardTemplateNew.Category__c;
        buVal = scorecardTemplateNew.BusinessUnit__c;
        blVal = scorecardTemplateNew.BusinessLine__c;
        prdVal = scorecardTemplateNew.Product__c;
        return null;
    }
    */
    
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
            system.debug('marketVal-1--' + marketVal);
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            setMUVal = mapHierarchyDetails1.get(marketVal);
            
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
                BusinessLineOptions.add(new SelectOption(s.trim(),s.trim()));
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
                    ProductOptions.add(new SelectOption(s.trim(),s.trim()));
                    lstTemp.add(s.trim());  
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
    
    public Pagereference save() 
    {
        if(scoreCardgenerate.Name != null && scoreCardgenerate.Name !=''){
            scoreCardgenerate.Region__c = marketVal;
            scoreCardgenerate.BusinessUnit__c = buVal;
            scoreCardgenerate.SubRegion__c = marketUnitVal;
            scoreCardgenerate.BusinessLine__c = blVal;
            scoreCardgenerate.Country__c = countryVal;
            scoreCardgenerate.Product__c = prdVal;
            scoreCardgenerate.Project__c = projectVal;
            scoreCardgenerate.CategoryCluster__c = caVal;
            scoreCardgenerate.CategoryGroup__c = cgVal;
            scoreCardgenerate.Category__c = ctVal;
            
            
            if (checkValidation())
            { 
               try{ 
                    if(!Apexpages.currentPage().getURL().contains('clone') && scoreCardgenerate != null){
                        upsert scoreCardgenerate;
                    }
                    system.debug('scoreCardgenerate------' + scoreCardgenerate);
                    if(Apexpages.currentPage().getURL().contains('clone') && scoreCardgenerate.Id != null){
                        scoreCardgenerateCloned = scoreCardgenerate.clone(false,true);
                        scoreCardgenerateCloned.Stage__c = 'Draft';
                        system.debug('scoreCardgenerateCloned--12----' + scoreCardgenerateCloned);
                        if(scoreCardgenerateCloned != null)
                            insert scoreCardgenerateCloned;
                    }
                    system.debug('scoreCardgenerateCloned------' + scoreCardgenerateCloned);
                }
                catch(Exception ex){
                    ApexPages.addMessages(ex) ; 
                    return null;
                 }
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
                return null;
            }
                
            Boolean isAbended = false;
            
            if (startDate != scoreCardgenerate.StartDate__c ||
                endDate != scoreCardgenerate.EndDate__c ||
                frequencyInMonths != scoreCardgenerate.FrequencyInMonths__c)
            {
                isAbended = true;
            }
            
            if (scoreCardgenerate.Stage__c == SPE_Constants.PUBLISHED_LIFECYCLESTAGE)
            {
                
                List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = CreateScorecardTracker(scoreCardgenerate,isAbended);
                
                upsert toBeInsertedScorecardTracker ;
            }
            
            Pagereference pr;
            if(!Apexpages.currentPage().getURL().contains('clone'))   
                pr = new Pagereference('/' + scoreCardgenerate.Id);
            else
                pr = new Pagereference('/' + scoreCardgenerateCloned.Id);
            
            return pr;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please provide a name for the scorecard plan'));
            return null;
        }
    }
    
    private Boolean checkValidation()
    {
        if (scoreCardgenerate.StartDate__c > scoreCardgenerate.EndDate__c )
        {   
            //errorMsg = System.Label.SPE_StartDateValidation;
            errorMsg = 'Scorecard Generator: Start date should always be lesser than End Date';
            return false; 
        }
        
       /* if (scoreCardgenerate.StartDate__c <= system.today() )
        {   
            //errorMsg = System.Label.SPE_FutureDateValidation;
            errorMsg = 'Scorecard Generator: Start date should be future Date';
            return false; 
        }
        */
        if (scoreCardgenerate.EndDate__c > scoreCardgenerate.StartDate__c.addYears(5))
        {
            //errorMsg = System.Label.SPE_EndDateValidation;
            errorMsg = 'Scorecard Generator: End date should not be more than 5 years of Start Date';
            return false; 
        }
        //As per Product Backlog :UC-REQ-SC-10 
        // Auto publishing flag [Yes/No] is available for selection only when the Auto approval flag = Yes.. else its Greyed out
      /*  if(scoreCardgenerate.isAutoDistributionON__c == TRUE && scoreCardgenerate.IsAutoApproved__c == FALSE){
            errorMsg = '"Auto Distribute" can be checked only if "Auto Approval" is true.';
            return false; 
        }
        
        */
        return true;
    } 
    
    public Pagereference generateTracker()
    {
      
        scoreCardgenerate.Stage__c = 'Published';
        update scoreCardgenerate;
    
        List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = CreateScorecardTracker(scoreCardgenerate, true);
            
        insert toBeInsertedScorecardTracker;  
        
        Pagereference pr = new Pagereference('/' + scoreCardgenerate.Id);
        
        return pr;
      
    }
    
    private List<SPE_ScorecardTracker__c> CreateScorecardTracker (SPE_ScorecardGenerator__c scoreCardgenerate, Boolean isAbended)
    {
        List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = new List<SPE_ScorecardTracker__c>();
        
        if (isAbended) 
        {
            List<SPE_ScorecardTracker__c> toBeAbendedTracker = [SELECT Id, ScorecardGenerator__c, Status__c 
                                                                 FROM SPE_ScorecardTracker__c
                                                                WHERE Status__c =  'Pending' AND  ScorecardGenerator__c =: scoreCardgenerate.Id];
                                                          
            for (SPE_ScorecardTracker__c tracker : toBeAbendedTracker)
            {
                tracker.Status__c = 'Abandoned';
                toBeInsertedScorecardTracker.add(tracker);
            }
             
        Date strtDate = scoreCardgenerate.StartDate__c;
        
        List<Date> toBeStartTracker = new List<Date>();
        
        if (scoreCardgenerate.FrequencyInMonths__c == '0')
            {
                toBeStartTracker.add(strtDate);
            }
        else{
            
            while (strtDate <= scoreCardgenerate.EndDate__c )
            {
                toBeStartTracker.add(strtDate);
                
                strtDate = strtDate.addMonths(integer.ValueOf(scoreCardgenerate.FrequencyInMonths__c));
            }
         }
        Integer timeFrame = integer.ValueOf(scoreCardgenerate.TimeFrame__c);
        for  (Date sDate : toBeStartTracker)
        {
            SPE_ScorecardTracker__c scoreTrack = new SPE_ScorecardTracker__c();
            scoreTrack.Name = SPE_Utility.monthsMap.get(sDate.month()) + ' - '+ String.valueOf(sDate.year());
            scoreTrack.ScorecardGenerator__c = scoreCardgenerate.Id;
            scoreTrack.DateOfExecution__c = sDate;
            
            scoreTrack.EndDate__c = sDate.addMonths(integer.ValueOf(scoreCardgenerate.FrequencyInMonths__c)).addDays(-timeFrame);
            scoreTrack.Status__c = 'Pending';
              
            toBeInsertedScorecardTracker.add(scoreTrack);
        }
       } 
        return toBeInsertedScorecardTracker;
    }
    public void scopeMatch()
    {   
        isValid = false;
        if (checkValidation())
        {
            isValid = true;
            isScopeMatch = true;
            
            List<SPE_ScorecardTemplate__c> scorecardTemplates = [SELECT Id, Region__c, SubRegion__c, Country__c, Project__c, CategoryCluster__c, CategoryGroup__c, Category__c,
                                                                        BusinessUnit__c, BusinessLine__c, Product__c
                                                                 FROM SPE_ScorecardTemplate__c
                                                                 WHERE Id = : scoreCardgenerate.ScorecardTemplate__c];
                                                             
            for (SPE_ScorecardTemplate__c scorecardTemplate : scorecardTemplates)
            {
                if (marketVal != scorecardTemplate.Region__c || marketUnitVal != scorecardTemplate.SubRegion__c || countryVal != scorecardTemplate.Country__c || projectVal != scorecardTemplate.Project__c ||
                buVal != scorecardTemplate.BusinessUnit__c || blVal != scorecardTemplate.BusinessLine__c || prdVal != scorecardTemplate.Product__c ||
                caVal != scorecardTemplate.CategoryCluster__c || cgVal != scorecardTemplate.CategoryGroup__c || ctVal != scorecardTemplate.Category__c)
                {
                    isScopeMatch = false;
                }
            }
        
        }   
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
        }       
    }
    
 //***************************************************************//  
 public void ScopeChange()
  {
      String ScorecardTemp = '%' + ApexPages.currentPage().getParameters().get('param1K') + '%';
      system.debug('ScorecardTemp---' + ScorecardTemp);
      
      scorecardTemplatescope = new SPE_ScorecardTemplate__c();
      try{
      scorecardTemplatescope = [Select Id,Name,Region__c,BusinessUnit__c,SubRegion__c,BusinessLine__c,Country__c,Product__c,Project__c,CategoryCluster__c,
                                        CategoryGroup__c,Category__c from SPE_ScorecardTemplate__c where Name Like : ScorecardTemp limit 1];
       }catch(exception ex){}       
       
        marketVal = scorecardTemplatescope.Region__c != null && scorecardTemplatescope.Region__c != '' ? scorecardTemplatescope.Region__c : '';
        marketUnitVal = scorecardTemplatescope.SubRegion__c != null && scorecardTemplatescope.SubRegion__c != '' ? scorecardTemplatescope.SubRegion__c : '';
        countryVal = scorecardTemplatescope.Country__c != null && scorecardTemplatescope.Country__c != '' ? scorecardTemplatescope.Country__c : '';
        projectVal = scorecardTemplatescope.Project__c != null && scorecardTemplatescope.Project__c != '' ? scorecardTemplatescope.Project__c : '';
        
        buVal = scorecardTemplatescope.BusinessUnit__c != null && scorecardTemplatescope.BusinessUnit__c != '' ? scorecardTemplatescope.BusinessUnit__c : '';
        blVal = scorecardTemplatescope.BusinessLine__c != null && scorecardTemplatescope.BusinessLine__c != '' ? scorecardTemplatescope.BusinessLine__c : '';
        prdVal = scorecardTemplatescope.Product__c != null && scorecardTemplatescope.Product__c != '' ? scorecardTemplatescope.Product__c : '';
        
        caVal = scorecardTemplatescope.CategoryCluster__c != null && scorecardTemplatescope.CategoryCluster__c != '' ? scorecardTemplatescope.CategoryCluster__c : '';
        cgVal = scorecardTemplatescope.CategoryGroup__c != null && scorecardTemplatescope.CategoryGroup__c != '' ? scorecardTemplatescope.CategoryGroup__c : '';
        ctVal = scorecardTemplatescope.Category__c != null && scorecardTemplatescope.Category__c != '' ? scorecardTemplatescope.Category__c : '';
  }  
}