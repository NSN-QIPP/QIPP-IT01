public with sharing class  SPE_SPEPlanCreateExt
{
    public SPE_SPEPlan__c spePlan {get;set;}
    private SPE_SPEPlan__c SPEPlanCloned;
    
    public boolean isUserHaveAccessToRecord {get;set;}  
    
    public List <SPE_SPEPlanSupplierMap__c> spePlanSuppliers {get;set;}
    
    public Boolean isScopeMatch {get;set;}
    public Boolean isValid {get;set;}
    
    public List<SelectOption> speTemplates {get;set;}
    
    public String speTemplateId {get;set;}
    
    
    private Date startDate;
    private Date endDate;
    private Decimal frequencyInMonths;
    private Id prevSPETemplateIds;
    private List<SPE_ScoringTemplate__c> scoringTemplates;
    
    private Set<String> availableEterpriseIds = new Set<String>();
    
    private string errorMsg = '';
    
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
    
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    public Boolean isTrackerCreated {get;set;}
    List<SPE_SPEPlanSupplierMap__c> lstSpePlanSuppliers;
    List<SPE_Respondent__c> lstSurveyRespondent; 
    public SPE_SPEPlanCreateExt(ApexPages.Standardcontroller st) 
    {
        isUserHaveAccessToRecord = true;
        lstSpePlanSuppliers = new List <SPE_SPEPlanSupplierMap__c>();
        lstSurveyRespondent = new List<SPE_Respondent__c>();
        isTrackerCreated = false;
        
        speTemplates = new List<SelectOption>();
        
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
            spePlan = new SPE_SPEPlan__c(); 
            SPEPlanCloned = new SPE_SPEPlan__c();
            //----------------Code for Custom picklist starts------------------------
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            prdVal = PicklistDefaultValues__c.getall().values()[0].Product__c;
           //----------------Code for Custom picklist ends------------------------
        
        }
        else 
        {
            //Id currentUsrId = 
            
            UserRecordAccess usrAcces = [SELECT RecordId, HasEditAccess FROM UserRecordAccess
                                            WHERE UserId =: UserInfo.getUserId() AND RecordId =: st.getId()];
                                            
            isUserHaveAccessToRecord = usrAcces.HasEditAccess;
            
            SPEPlanCloned = new SPE_SPEPlan__c();
            spePlan = [SELECT Id, SPEScoringTemplate__c, AggregationDuration__c, Name, PPM1__c, CM__c, Stage__c, SPEPlanName__c, Region__c, SubRegion__c, Country__c, Category__c, Project__c, SPETemplate__c, SPETemplate__r.Name, StartDate__c, EndDate__c,
                              FrequencyInMonths__c, SurveyExecutionBeforeIndays__c, SurveyReminderBeforeExecutionDate__c, SurveyHeader__c, SurveyFooter__c,
                              CategoryCluster__c, CategoryGroup__c, BusinessUnit__c, BusinessLine__c, Product__c, Product1__c, Product2__c, Product3__c,Organization_Group__c
                       FROM SPE_SPEPlan__c 
                       WHERE Id =: st.getId()];
           
           
            startDate = spePlan.StartDate__c;
            endDate = spePlan.EndDate__c;
            frequencyInMonths = spePlan.FrequencyInMonths__c == null ? 1: Integer.valueOf(spePlan.FrequencyInMonths__c);
            prevSPETemplateIds = spePlan.SPEScoringTemplate__c;
            
        
            SPE_MathsUtil.market1 = spePlan.Region__c;
            SPE_MathsUtil.bu1 = spePlan.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = spePlan.SubRegion__c;
            SPE_MathsUtil.bl1 = spePlan.BusinessLine__c;
            SPE_MathsUtil.country1 = spePlan.Country__c;
            SPE_MathsUtil.prd1 = spePlan.Product__c;
            SPE_MathsUtil.project1 = spePlan.Project__c;
            SPE_MathsUtil.ca1 = spePlan.CategoryCluster__c;
            SPE_MathsUtil.cg1 = spePlan.CategoryGroup__c;
            SPE_MathsUtil.ct1 = spePlan.Category__c;
            
            SPE_MathsUtil.isEdit = true;
            
            //----------------Code for Custom picklist starts------------------------
            marketVal = spePlan.Region__c != null && spePlan.Region__c != '' ? spePlan.Region__c : '';
            marketUnitVal = spePlan.SubRegion__c != null && spePlan.SubRegion__c != '' ? spePlan.SubRegion__c : '';
            countryVal = spePlan.Country__c != null && spePlan.Country__c != '' ? spePlan.Country__c : '';
            projectVal = spePlan.Project__c != null && spePlan.Project__c != '' ? spePlan.Project__c : '';
            
            buVal = spePlan.BusinessUnit__c != null && spePlan.BusinessUnit__c != '' ? spePlan.BusinessUnit__c : '';
            blVal = spePlan.BusinessLine__c != null && spePlan.BusinessLine__c != '' ? spePlan.BusinessLine__c : '';
            prdVal = spePlan.Product__c != null && spePlan.Product__c != '' ? spePlan.Product__c : '';
            
            caVal = spePlan.CategoryCluster__c != null && spePlan.CategoryCluster__c != '' ? spePlan.CategoryCluster__c : '';
            cgVal = spePlan.CategoryGroup__c != null && spePlan.CategoryGroup__c != '' ? spePlan.CategoryGroup__c : '';
            ctVal = spePlan.Category__c != null && spePlan.Category__c != '' ? spePlan.Category__c : '';
            
            //----------------Code for Custom picklist Ends------------------------
          
        
           
        
            if ([SELECT Id FROM SPE_SPETracker__c WHERE SPEPlan__c =: spePlan.Id] != null &&
                [SELECT Id FROM SPE_SPETracker__c WHERE SPEPlan__c =: spePlan.Id].size() > 0)
            {
                isTrackerCreated = true;
            }
            lstSpePlanSuppliers = [SELECT Id,Supplier__c,SPEPlan__c
                              FROM SPE_SPEPlanSupplierMap__c
                              WHERE SPEPlan__c = : spePlan.Id];
        
            lstSurveyRespondent = [select id,Contact__c,Email__c,SPEPlan__c
                              FROM SPE_Respondent__c
                              WHERE SPEPlan__c = : spePlan.Id];
        }
        
        spePlanSuppliers = new List<SPE_SPEPlanSupplierMap__c>();
       // showProdVals();
    }
     
    public Pagereference save()
    {
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
        system.debug('url parameters'+UrlParameterMap);
        Pagereference pr;
        spePlan.Region__c = marketVal;
        spePlan.BusinessUnit__c = buVal;
        spePlan.SubRegion__c = marketUnitVal;
        spePlan.BusinessLine__c = blVal;
        spePlan.Country__c = countryVal;
        spePlan.Product__c = prdVal;
        spePlan.Project__c = projectVal;
        spePlan.CategoryCluster__c = caVal;
        spePlan.CategoryGroup__c = cgVal;
        spePlan.Category__c = ctVal;
        
        List<SPE_ScoringTemplate__c> scoringTemplates = [SELECT SPETemplate__c 
                                                         FROM SPE_ScoringTemplate__c
                                                         WHERE Id = : spePlan.SPEScoringTemplate__c];
        spePlan.SPETemplate__c = scoringTemplates[0].SPETemplate__c;
         
            system.debug('checkValidation'+checkValidation());
        
        try
        {
            if (checkValidation())
            {
                if (!UrlParameterMap.containsKey('isClone'))
                    upsert spePlan;
                else{
                    SPEPlanCloned = spePlan.clone(false,true,false,false);
                    if(SPEPlanCloned.Id != null)
                        SPEPlanCloned.Id = null;
                    if(SPEPlanCloned != null)
                        insert SPEPlanCloned;
                }
                system.debug('SPEPlanCloned----' + SPEPlanCloned);
                if(SPEPlanCloned.Id !=  null){
                    for(SPE_SPEPlanSupplierMap__c objSM : lstSpePlanSuppliers){
                        objSM.Id = null;
                        objSM.SPEPlan__c = SPEPlanCloned.Id;
                    }
                    for(SPE_Respondent__c objRs : lstSurveyRespondent){
                        objRs.Id = null;
                        objRs.SPEPlan__c = SPEPlanCloned.Id;
                    }
                    if(!lstSpePlanSuppliers.isEmpty())
                        insert lstSpePlanSuppliers;
                    if(!lstSurveyRespondent.isEmpty())
                        insert lstSurveyRespondent;
                }
                    
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
                return null;
            }
            
        }
        catch(Exception ex)
        {
           ApexPages.addMessages(ex);
           return null;
        }
    
        Boolean isAbended = false;
        
        if (!UrlParameterMap.containsKey('isClone')){
            if (startDate != spePlan.StartDate__c ||
                endDate != spePlan.EndDate__c ||
                Decimal.valueOf(spePlan.FrequencyInMonths__c) != frequencyInMonths ||
                prevSPETemplateIds != spePlan.SPEScoringTemplate__c
               ) 
            {
                isAbended = true;
            }
             
            if (spePlan.Stage__c == SPE_Constants.PUBLISHED_LIFECYCLESTAGE)
            {
                
                List<SPE_SPETracker__c> toBeInsertedSPETracker = createSPETracker(spePlan, isAbended);
                
                upsert toBeInsertedSPETracker;
            }
            pr = new Pagereference('/' + spePlan.Id);
        }
        else{
            if (startDate != SPEPlanCloned.StartDate__c ||
                endDate != SPEPlanCloned.EndDate__c ||
                Decimal.valueOf(SPEPlanCloned.FrequencyInMonths__c) != frequencyInMonths ||
                prevSPETemplateIds != SPEPlanCloned.SPEScoringTemplate__c
               ) 
            {
                isAbended = true;
            }
             
            if (SPEPlanCloned.Stage__c == SPE_Constants.PUBLISHED_LIFECYCLESTAGE)
            {
                
                List<SPE_SPETracker__c> toBeInsertedSPETrackerC = createSPETracker(SPEPlanCloned, isAbended);
                
                insert toBeInsertedSPETrackerC;
            }
            pr = new Pagereference('/' + SPEPlanCloned.Id);
        }
        return pr;
    }
    
    @testVisible 

    private Boolean checkValidation()
    {
       system.debug('First check default'+spePlan);
        if (spePlan.SPEPlanName__c == null ||
            spePlan.SPEScoringTemplate__c == null)
        {
             system.debug('Inside 1');
            errorMsg = System.Label.SPE_SPEPlanMandatoryField;
            return false;
        }
    
        if (spePlan.StartDate__c > spePlan.EndDate__c )
        {   
             system.debug('Inside 2');
            errorMsg = System.Label.SPE_StartDateValidation;
            return false; 
        }
        
        if (spePlan.StartDate__c <= system.today())
        {   
        system.debug('Inside 3');
            errorMsg = System.Label.SPE_FutureDateValidation;
            return false; 
        }
        
        if (spePlan.EndDate__c > spePlan.StartDate__c.addYears(5))
        {
        system.debug('Inside 4');
            errorMsg = System.Label.SPE_EndDateValidation;
            return false; 
        }
        
        if (spePlan.SurveyExecutionBeforeIndays__c < spePlan.SurveyReminderBeforeExecutionDate__c )
        {
        system.debug('Inside 5');
            errorMsg = System.Label.SPE_SurveyReminder;
            return false; 
        }
        
        Id templateId = [SELECT Id, SPETemplate__c from SPE_ScoringTemplate__c WHERE Id =: spePlan.SPEScoringTemplate__c].SPETemplate__c;
        
        system.debug('===templateId  ==> ' + templateId   );
        
        if(SPE_RecalculateIsSurveyBasePI.recalculateIsSurveyPI(templateId) &&
           (spePlan.SurveyExecutionBeforeIndays__c == null || spePlan.SurveyReminderBeforeExecutionDate__c == null))
        {
             system.debug('Inside 6');
              errorMsg = 'Please enter the survey scheduling details';
              return false;
        }
        
        Id speKPIMapId = [SELECT Id, SPETemplate__c,SPEKPIMap__c from SPE_ScoringTemplate__c WHERE Id =: spePlan.SPEScoringTemplate__c].SPEKPIMap__c;
        
        system.debug('===speKPIMapId  ==> ' + speKPIMapId   );
        
        List<SPE_SPEKPIMap__c> speKPIMapList = [SELECT Id,SPETemplate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c from SPE_SPEKPIMap__c where SPETemplate__c =:  templateId ];
        
        system.debug('===speKPIMapList ==> ' + speKPIMapList  );
        
        Integer daySPEPlanNew = spePlan.StartDate__c.day();
        
        system.debug('===daySPEPlanNew==> ' + daySPEPlanNew );
        
        for (SPE_SPEKPIMap__c speKPIMap : speKPIMapList )
        {  
            if (speKPIMap.KPIDefinition__r.ScheduledDate__c != null)
            {
                Integer kpiDay = speKPIMap.KPIDefinition__r.ScheduledDate__c.day();   
                system.debug('===kpiDay ==> ' + kpiDay  );
                if(kpiDay > daySPEPlanNew)
                {
                    system.debug('===kpiDay ==> ');
                    errorMsg = 'SPE Plan Start Date should be greater than KPI Next Scheduled Date';
                    return false;
                } 
            }
        }
        
        return true;
    }
    
    private List<SPE_SPETracker__c> createSPETracker (SPE_SPEPlan__c spePlan, Boolean isAbended)
    {
        List<SPE_SPETracker__c> toBeInsertedSPETracker = new List<SPE_SPETracker__c>();
        
        if (isAbended)
        {
            List<SPE_SPETracker__c> toBeAbendedTracker = [SELECT Id, SPEPlan__c, Status__c 
                                                          FROM SPE_SPETracker__c
                                                          WHERE Status__c =:SPE_Constants.STATUS_PENDING AND  SPEPlan__c =: spePlan.Id];
                                                          
            for (SPE_SPETracker__c tracker : toBeAbendedTracker)
            {
                tracker.Status__c = SPE_Constants.STATUS_ABANDONED;
                toBeInsertedSPETracker.add(tracker);
            }
        
            Date strtDate = spePlan.StartDate__c;
            
            List<Date> toBeStartTracker = new List<Date>();
            
            /*
            while (strtDate <= spePlan.EndDate__c )
            {
                toBeStartTracker.add(strtDate);
                
                if(spePlan.FrequencyInMonths__c != '0'){
                    strtDate = strtDate.addMonths(Integer.valueOf(spePlan.FrequencyInMonths__c));
                    
                }
                else{
                    break;
                }
            }*/
            
            if (spePlan.FrequencyInMonths__c == '0')
            {
                toBeStartTracker.add(strtDate);
            }
            else
            {
                while (strtDate <= spePlan.EndDate__c )
                {
                    toBeStartTracker.add(strtDate);
                    
                    strtDate = strtDate.addMonths(Integer.valueOf(spePlan.FrequencyInMonths__c));
                }
            }
            
            for  (Date sDate : toBeStartTracker)
            {
                SPE_SPETracker__c speTrack = new SPE_SPETracker__c();
                speTrack.Name = SPE_Utility.monthsMap.get(sDate.addMonths(-1).month()) + ' - '+ String.valueOf(sDate.addMonths(-1).year());
                speTrack.SPEPlan__c = spePlan.Id;
                speTrack.SPETemplate__c = spePlan.SPETemplate__c;
                speTRack.DateOfExecution__c = sDate;
                speTRack.Status__c = SPE_Constants.STATUS_PENDING ;
                
                speTrack.Region__c = spePlan.Region__c;
                speTrack.SubRegion__c = spePlan.SubRegion__c;
                speTrack.Country__c = spePlan.Country__c;
                speTrack.Project__c = spePlan.Project__c;
                
                speTrack.BusinessLine__c = spePlan.BusinessLine__c;
                speTrack.BusinessUnit__c = spePlan.BusinessUnit__c;
                speTrack.Product__c = spePlan.Product__c;
                
                speTrack.Category__c = spePlan.Category__c;
                speTrack.CategoryGroup__c = spePlan.CategoryGroup__c;
                speTrack.CategoryCluster__c = spePlan.CategoryCluster__c;
                
                toBeInsertedSPETracker.add(speTrack);
            }
        } 
        return toBeInsertedSPETracker;
    }
    
    public Pagereference generateTracker()
    {
        spePlan.Stage__c = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        update spePlan;
    
        List<SPE_SPETracker__c> toBeInsertedSPETracker = createSPETracker(spePlan, true);
            
        insert toBeInsertedSPETracker;  
        
        Pagereference pr = new Pagereference('/' + spePlan.Id);
        
        return pr;
    }
    
    public void scopeMatch()
    {   
        isValid = false;
        if (checkValidation())
        {
            isValid = true;
        
        
            isScopeMatch = true;
            
            List<SPE_ScoringTemplate__c> scoringTemplates = [SELECT Id, Region__c, SubRegion__c, Country__c, Project__c, CategoryCluster__c, CategoryGroup__c, Category__c,
                                                                    BusinessUnit__c, BusinessLine__c, Product__c, SPETemplate__c 
                                                             FROM SPE_ScoringTemplate__c
                                                             WHERE Id = : spePlan.SPEScoringTemplate__c];
                                                             
            for (SPE_ScoringTemplate__c scoringTemplate : scoringTemplates)
            {
                if (marketVal != scoringTemplate.Region__c || marketUnitVal != scoringTemplate.SubRegion__c || countryVal != scoringTemplate.Country__c || projectVal != scoringTemplate.Project__c ||
                buVal != scoringTemplate.BusinessUnit__c || blVal != scoringTemplate.BusinessLine__c || prdVal != scoringTemplate.Product__c ||
                caVal != scoringTemplate.CategoryCluster__c || cgVal != scoringTemplate.CategoryGroup__c || ctVal != scoringTemplate.Category__c)
                {
                    isScopeMatch = false;
                }
            }
        
        }   
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
            //return null;
        }       
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