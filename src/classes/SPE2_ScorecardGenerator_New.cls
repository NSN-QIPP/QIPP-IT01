public with sharing class SPE2_ScorecardGenerator_New 
{
    public SPE_ScorecardGenerator__c scoreCardgenerate{get;set;}
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
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
     //-------------------Display PopUp window--------------------//  
    public boolean displaypopup{get;set;}
    public Date kpiday{get;set;}
    public String displaydate{get;set;}
    private Set<String> availableEterpriseIds = new Set<String>();
       
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

     
    public SPE2_ScorecardGenerator_New(ApexPages.Standardcontroller st) 
    {
        scoreCardgenerateCloned = new SPE_ScorecardGenerator__c();
        String Loc;
        System.debug('$$$$$$$$$$$$$$$$$$$$$ The value is 111: ');
        isTrackerCreated = false;
        stID = st.getId();
        StdCtrl = st;
        displaypopup = false;
        If(stID != Null){
        CurrentUserId = UserInfo.getUserId();
        RecordOwnerId = [Select Id, ownerId from SPE_ScorecardGenerator__c
                       WHERE Id =: stID].ownerId;
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
        system.debug('setMarkets-----' + setMarkets);
        system.debug('setBusinessUnits-----' + setBusinessUnits);
        system.debug('setCategoryArea-----' + setCategoryArea);
        
        //----------------Code for Custom picklist ends------------------------
        
        
        if (stdCtrl.getId() == null) 
        {
            scoreCardgenerate = new SPE_ScorecardGenerator__c();
            scoreCardgenerate.Stage__c = 'Draft';
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
            scoreCardgenerate = [SELECT BusinessLine__c,Scorecardtemplate_Stage__c, IsAutoApproved__c,isAutoDistributionON__c,Stage__c, BusinessUnit__c, Category__c, CategoryCluster__c, CategoryGroup__c, Country__c, DisplaySpend__c,
                                 DisplayUnits__c, EndDate__c, Product__c, Product1__c, Product2__c, Product3__c, Project__c, RangeEndDate__c, RangeStartDate__c,Additional_Days__c,Next_Computed_Day__c,isAdhoc__c, 
                                 Region__c, StartDate__c, SubRegion__c, ScorecardTemplate__c, FrequencyInMonths__c, Name, TimeFrame__c,AggregationType__c
                                FROM SPE_ScorecardGenerator__c
                                WHERE Id =: stdCtrl.getId()];
            
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

     public void closePopup() {        
        displayPopup = false;    
    } 
    
    public Pagereference continueCustom(){
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
        system.debug('url parameters'+UrlParameterMap);
        Pagereference pr;
        
        system.debug('checkValidation'+checkValidation());       
        
        if(kpiDay < scoreCardgenerate.EndDate__c){
            scoreCardgenerate.Next_Computed_Day__c = kpiday;
        }
        
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
                    if(!Apexpages.currentPage().getURL().contains('isClone') && scoreCardgenerate != null){
                        upsert scoreCardgenerate;
                    }
                    system.debug('scoreCardgenerate------' + scoreCardgenerate);
                    if(Apexpages.currentPage().getURL().contains('isClone') && scoreCardgenerate.Id != null){
                        scoreCardgenerateCloned = scoreCardgenerate.clone(false,true);
                        scoreCardgenerateCloned.Stage__c = 'Draft';
                        scoreCardgenerateCloned.ownerid= userinfo.getUserId();
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
                closePopup();
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
                // Automatic tracker execution code for past date
                SPE2_pastDateTracker trckrExecute = new SPE2_pastDateTracker();
                trckrExecute.scorecardTracker(toBeInsertedScorecardTracker,userInfo.getUserId());
            }
            
            if(!Apexpages.currentPage().getURL().contains('isClone'))   
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
 
  
    //----------------Code for Custom picklist starts------------------------
  
  //-----------------Fetch dropdown values of Market-------------
    //------- Fetch dropdown values of Market Unit ---------------
    
      public List<SelectOption> getMarketUnitValues() 
        {   
            fillMarketUnit();
            return mkoptions;
        }
    
        public void fillMarketUnit()
        {
            if(Apexpages.currentPage().getParameters().get('marketVal')!= null){
                marketVal = Apexpages.currentPage().getParameters().get('marketVal');
            }
            else{
               marketVal = 'All Markets'; 
            }
            system.debug('marketVal-1--' + marketVal);
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            setMUVal = mapHierarchyDetails1.get(marketVal);
            try{
                if(!setMUVal.contains(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c)){
                    mkoptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,PicklistDefaultValues__c.getall().values()[0].Market_Unit__c));
                }
                          
            system.debug('marketVal---' + marketVal); 
            for(String s : mapHierarchyDetails1.get(marketVal)){
                mkoptions.add(new SelectOption(s,s));
              }
           }catch(exception e){
               
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
            if(Apexpages.currentPage().getParameters().get('buVal')!= null){            
                buVal= Apexpages.currentPage().getParameters().get('buVal');
            }else{
                buVal  = 'All Business Units';
            }
            BusinessLineOptions= new List<SelectOption>();
            Set<String> setBUVal = new Set<String>();
            setBUVal = mapHierarchyDetails1.get(buVal);
            try{
                if(!setBUVal.contains(PicklistDefaultValues__c.getall().values()[0].Business_Line__c))
                    BusinessLineOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Line__c,PicklistDefaultValues__c.getall().values()[0].Business_Line__c));
               
                for(String s : mapHierarchyDetails1.get(buVal)){
                    BusinessLineOptions.add(new SelectOption(s.trim(),s.trim()));
                }
            }catch(exception e){}
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
            if(Apexpages.currentPage().getParameters().get('caVal')!= null){
                caVal = Apexpages.currentPage().getParameters().get('caVal');
            }else{
                caVal = 'All Category Areas';
            }
                
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            try{
                if(!setCatGroupVal .contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c))
                    CatGroupOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Group__c,PicklistDefaultValues__c.getall().values()[0].Category_Group__c));
               
                for(String s : mapHierarchyDetails1.get(caVal)){
                    CatGroupOptions.add(new SelectOption(s,s));
                }
            }catch(Exception e){}
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
                cgVal = Apexpages.currentPage().getParameters().get('cgVal');              
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
            
            kpiDay = Date.newinstance(1960, 1, 1);
            Integer monthvalue = System.Today().Month();
            
            Id templateId = scoreCardgenerate.ScorecardTemplate__c;
            List<SPE_ScorecardSPETemplateMap__c> scorecardTemplatelist = [SELECT SPETemplate__c,ScorecardTemplate__c
                                                                         FROM SPE_ScorecardSPETemplateMap__c
                                                                         WHERE ScorecardTemplate__c =: templateId];
                                                         
            List<Id> spetemplatesID = new List<ID>();
            for(SPE_ScorecardSPETemplateMap__c ssspe: scorecardTemplatelist){
                spetemplatesID.add(ssspe.SPETemplate__c);
            }
            
            List<SPE_SPEPlan__c> spePlanMapList = [SELECT Id,SPETemplate__c,Next_Computed_Day__c from SPE_SPEPlan__c where SPETemplate__c IN:spetemplatesID];
            List<ID> speplanID = new List<ID>();
            for(SPE_SPEPlan__c spp: spePlanMapList){
                speplanID.add(spp.ID);
            }
            
            List<SPE_SPETracker__c> spetrackList = [Select ID,Name,DateOfExecution__c,SPEPlan__c,Period__c from SPE_SPETracker__c where SPEPlan__c IN:speplanID];
            
            for(SPE_SPETracker__c speTrackMap : spetrackList)
            {  
                if (speTrackMap.DateOfExecution__c != null && monthvalue == (speTrackMap.DateOfExecution__c.Month()-1) && System.Today().Year() == speTrackMap.DateOfExecution__c.Year())
                {
                    if(speTrackMap.DateOfExecution__c > kpiDay){
                        kpiDay = speTrackMap.DateOfExecution__c;
                    }                               
                }
            }
            
            if(kpiDay == Date.newinstance(1960, 1, 1)){
               kpiDay = System.Today(); 
            }
             
            if(scoreCardgenerate.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(scoreCardgenerate.Additional_Days__c);
                kpiDay = kpiDay.addDays(additional_days);
            }
            
            if(monthvalue < kpiDay.Month() && kpiDay < scoreCardgenerate.EndDate__c){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                displaypopup = true;
                return null;
            }
            else if(monthvalue < kpiDay.Month() && kpiDay > scoreCardgenerate.EndDate__c){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;    
            }
            
            if(kpiDay < scoreCardgenerate.EndDate__c && kpiDay >= System.Today()){
                scoreCardgenerate.Next_Computed_Day__c = kpiday;
            }
            else if(kpiDay < scoreCardgenerate.EndDate__c && kpiDay < System.Today()){
                Integer additional_days = Integer.ValueOf(scoreCardgenerate.Additional_Days__c);
                scoreCardgenerate.Next_Computed_Day__c = System.Today().addDays(additional_days);
            }
            else if(kpiDay > scoreCardgenerate.EndDate__c && kpiDay >= System.Today()){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;
            }
            
            if (checkValidation())
            { 
               try{ 
                    if(!Apexpages.currentPage().getURL().contains('isClone') && scoreCardgenerate != null){
                        upsert scoreCardgenerate;
                    }
                    system.debug('scoreCardgenerate------' + scoreCardgenerate);
                    if(Apexpages.currentPage().getURL().contains('isClone') && scoreCardgenerate.Id != null){
                        scoreCardgenerateCloned = scoreCardgenerate.clone(false,true);
                        scoreCardgenerateCloned.Stage__c = 'Draft';
                        scoreCardgenerateCloned.ownerid= userinfo.getUserId();
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
                // Automatic tracker execution code for past date
                SPE2_pastDateTracker trckrExecute = new SPE2_pastDateTracker();
                trckrExecute.scorecardTracker(toBeInsertedScorecardTracker,userInfo.getUserId());
            }
            
            Pagereference pr;
            if(!Apexpages.currentPage().getURL().contains('isClone'))   
                pr = new Pagereference('/' + scoreCardgenerate.Id);
            else
                pr = new Pagereference('/' + scoreCardgenerateCloned.Id);
            
            return pr;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please provide name for the Scorecard Generator.'));
            return null;
        }
    }
    
    private Boolean checkValidation()
    {
        if (scoreCardgenerate.StartDate__c > scoreCardgenerate.EndDate__c )
        {   
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
            errorMsg = 'Scorecard Generator: End date should not be more than 5 years of Start Date';
            return false; 
        }
        return true;
    } 
    
    public Pagereference generateTracker()
    {
      
        scoreCardgenerate.Stage__c = 'Published';
        update scoreCardgenerate;
    
        List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = CreateScorecardTracker(scoreCardgenerate, true);
            
        insert toBeInsertedScorecardTracker;  
        // Automatic tracker execution code for past date
        SPE2_pastDateTracker trckrExecute = new SPE2_pastDateTracker();
        trckrExecute.scorecardTracker(toBeInsertedScorecardTracker,userInfo.getUserId());
        
        Pagereference pr = new Pagereference('/' + scoreCardgenerate.Id);
        
        return pr;
      
    }
    
    private List<SPE_ScorecardTracker__c> CreateScorecardTracker (SPE_ScorecardGenerator__c scoreCardgenerate, Boolean isAbended)
    {
        List<SPE_ScorecardTracker__c> toBeInsertedScorecardTracker = new List<SPE_ScorecardTracker__c>();
        SPE_ScorecardGenerator__c tempSCG = new SPE_ScorecardGenerator__c();
        tempSCG = [select id,isAdhoc__c,StartDate__c,EndDate__c,Aggregation_Period_Adhoc__c from SPE_ScorecardGenerator__c Where Id=: scoreCardgenerate.Id];
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
             
        Date strtDate = System.Today();
        
        if((tempSCG.isAdhoc__c == False) || (tempSCG.isAdhoc__c == True && tempSCG.StartDate__c >= System.Today())){    
            if(scoreCardgenerate.Next_Computed_Day__c == Null){
                strtDate = kpiDay;
            }
            else if(scoreCardgenerate.Next_Computed_Day__c != Null){
                strtDate = scoreCardgenerate.Next_Computed_Day__c;
            } 
        }
        else if(tempSCG.isAdhoc__c == True && tempSCG.StartDate__c < System.Today()){
            strtDate = tempSCG.StartDate__c;
        }
        
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
        System.debug('toBeStartTracker-----' + toBeStartTracker);
        for  (Date sDate : toBeStartTracker)
        {
            SPE_ScorecardTracker__c scoreTrack = new SPE_ScorecardTracker__c();
            if(tempSCG.isAdhoc__c){
                if(tempSCG.Aggregation_Period_Adhoc__c == 'Monthly'){
                    if(sDate.month() > 9)
                        scoreTrack.Name = 'P - ' + sDate.month() + ' '+ String.valueOf(sDate.year());
                    else
                        scoreTrack.Name = 'P - 0' + sDate.month() + ' '+ String.valueOf(sDate.year());
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Quarterly'){
                    Integer quarter = sDate.month()/3;
                    if(quarter == 0)
                        scoreTrack.Name = 'Q1 - ' + String.valueOf(sDate.year());
                    else if(quarter == 1)
                        scoreTrack.Name = 'Q2 - ' + String.valueOf(sDate.year());
                    else if (quarter == 2)
                        scoreTrack.Name = 'Q3 - ' + String.valueOf(sDate.year());
                    else 
                        scoreTrack.Name = 'Q4 - ' + String.valueOf(sDate.year());
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Half Yearly'){
                    Integer halfYearly = sDate.month()/6;
                    if(halfYearly == 0)
                        scoreTrack.Name = 'H1 - ' + String.valueOf(sDate.year());
                    else if(halfYearly == 1)
                        scoreTrack.Name = 'H2 - ' + String.valueOf(sDate.year());
                    
                }
                else{
                    scoreTrack.Name = String.valueOf(sDate.year());
                }
            }
            else{
                scoreTrack.Name = SPE_Utility.monthsMap.get(sDate.month()) + ' - '+ String.valueOf(sDate.year());
            }
            scoreTrack.ScorecardGenerator__c = scoreCardgenerate.Id;
            scoreTrack.DateOfExecution__c = sDate;
            if(tempSCG.isAdhoc__c){
                if(tempSCG.Aggregation_Period_Adhoc__c == 'Monthly'){
                    Integer numberOfDays = Date.daysInMonth(sDate.year(), sDate.month());
                    Date lastDayOfMonth = Date.newInstance(sDate.year(), sDate.month(), numberOfDays);
                    scoreTrack.EndDate__c = lastDayOfMonth;
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Quarterly'){
                    if(scoreTrack.Name.startsWith('Q1')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),03,31);
                    }
                    else if(scoreTrack.Name.startsWith('Q2')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),06,30);
                    }
                    else if(scoreTrack.Name.startsWith('Q3')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),09,30);
                    }
                    else{
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),12,31);
                    }
                }
                else if(tempSCG.Aggregation_Period_Adhoc__c == 'Half Yearly'){
                    if(scoreTrack.Name.startsWith('H1')){
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),06,30);
                    }
                    else{
                        scoreTrack.EndDate__c = Date.newInstance(sDate.year(),12,31);
                    }
                }
                else{
                    scoreTrack.EndDate__c = Date.newInstance(sDate.year(),12,31);
                }
            }
            else{
                scoreTrack.EndDate__c = sDate.addMonths(integer.ValueOf(scoreCardgenerate.FrequencyInMonths__c)).addDays(-timeFrame);
            }
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