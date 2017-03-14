public class SPE2_SurveyCreateNewExt 
{
public String RecordOwnerId{get;set;}
public String CurrentUserId{get;set;}
public string PageId{get;set;}
public String validateQues {get;set;}
public string strPIPublished{get;set;}
public string strNoPI{get;set;}
    public String catarea;
    public String catgroup;
    public String cat;
    public String busUnit;
    public String busLine;
    public String prod;
    public String market;
    public String mktunit;
    public String cntry;
    public String proj;
    public List<SPE2_Question_Survey_Association__c> quessurveyObj;
public SPE2Survey__c SurveyCloned;  
Id PIdefId;
public Date strtDate;
public ApexPages.StandardController standardController{get;set;}



    public SPE_SPEPlan__c spePlan {get;set;}
    public SPE2Survey__c objSpeSurvey{get;set;}
    public List <SPE_SPEPlanSupplierMap__c> spePlanSuppliers{get;set;} 
    public List <SPE2_Question_Survey_Association__c> lstQuesSurveyAssoc{get;set;}   
    public List <SPE_SurveyQuestion__c> lstsurveyques{get;set;}
    public List <SPE2_SurveySupplierMap__c> lstsurveysupplier{get;set;}
    public List <SPE2_Survey_Respondents__c> lstsurveyrespondent{get;set;}
    public Boolean isScopeMatch {get;set;}
    public Boolean isValid {get;set;}
    public boolean isUserHaveAccessToRecord {get;set;}  
    
    public List<SelectOption> speTemplates {get;set;}
    
    public String speTemplateId {get;set;}
    
    public String isEditDisable{get;set;}

    private Date startDate;
    public Date endDate{get;set;}
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
    public string isPastDate{get;set;}
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    public Boolean isTrackerCreated {get;set;}
     
    public SPE2_SurveyCreateNewExt(ApexPages.Standardcontroller st) 
    {
        //CurrentUserId = UserInfo.getUserId();
        validateQues = 'false';
        strNoPI = 'false';
        strPIPublished = 'false';
         isUserHaveAccessToRecord = true;
         isPastDate = 'false';
         PageId = ApexPages.currentPage().getParameters().get('Id');         
         isEditDisable = 'false';
         
         this.StandardController =st;                            
        //--------------------Recurrence part End ------------------------/
        isTrackerCreated = false;
        system.debug('INSIDE---IF-1');
        speTemplates = new List<SelectOption>();
         //----------------Code for Custom picklist starts------------------------
        
            //--------------remove the separator ~Market,~BusinessUnit,~Category-----
        lstQuesSurveyAssoc = new List <SPE2_Question_Survey_Association__c>();
        lstsurveyques = new List<SPE_SurveyQuestion__c>();
        lstsurveysupplier = new List<SPE2_SurveySupplierMap__c>();
        lstsurveyrespondent = new List<SPE2_Survey_Respondents__c>();
        
        lstTemp = new Set<String>();
        setMarkets = new Set<String>();
        setBusinessUnits = new Set<String>();
        setCategoryArea = new Set<String>();
        
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
       
        system.debug('Market__c-----' + st.getId());
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
        
          
           /*       if(objSpeSurvey.Is_One_Time_Survey__c== false){          
                       RenderRecurrence = true;
                       selectedFrequency = objSpeSurvey.Recurrence_frequency_type__c;
                       RecurrencePattern = objSpeSurvey.Recurrence_Pattern__c;
                       selectedWeekInMonth = objSpeSurvey.Week_Count__c;
                       selectedDayInMonth = objSpeSurvey.Day_name_of_upload_week__c;  
                   }
                   else{
                       RenderRecurrence = false;
                   }     */ 
                
        
        //----------------Code for Custom picklist ends------------------------
        if (st.getId() == null)
        {
            objSpeSurvey = new SPE2Survey__c(ownerid= userinfo.getUserId(),Recurrence_frequency_type__c='Monthly',Recurrence_Pattern__c = 'DayPerMonth');
            objSpeSurvey.Is_One_Time_Survey__c = true;
            objSpeSurvey.StartDate__c = system.today().adddays(1);
            system.debug('INSIDE---IF-');
            
            
             //----------------Code for Custom picklist starts------------------------
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            prdVal = PicklistDefaultValues__c.getall().values()[0].Product__c;
           //----------------Code for Custom picklist ends------------------------
        }
        else 
        {
            if(ApexPages.currentPage().getParameters().get('isClone') == null){
                CurrentUserId = UserInfo.getUserId();
                RecordOwnerId = [Select Id, ownerId from SPE2Survey__c
                                   WHERE Id =: st.getId()].ownerId;                                
           }
        Map<String, String> UrlParameterMap1 = ApexPages.currentPage().getParameters();
        UserRecordAccess usrAcces = [SELECT RecordId, HasEditAccess FROM UserRecordAccess
                                            WHERE UserId =: UserInfo.getUserId() AND RecordId =: st.getId()];
             if (!UrlParameterMap1.containsKey('isClone')){
                isUserHaveAccessToRecord = usrAcces.HasEditAccess;
            }
            system.debug('INSIDE----');
            objSpeSurvey = [SELECT Additional_Days_for_week__c,Additional_Days__c,BusinessLine__c,BusinessUnit__c,
                           CategoryGroup__c,CategoryArea__c,Category__c,Country__c,Day_name_of_upload_week__c,EndDate__c,
                           FrequencyInMonths__c,Id,Is_One_Time_Survey__c,MarketUnit__c,Market__c,Month_Upload_Day__c,Month_Value__c,Name,
                           OwnerId,Product__c,Project__c,Recurrence_frequency_type__c,Recurrence_Pattern__c,Stage__c,
                           StartDate__c,SurveyExecutionBeforeIndays__c,SurveyReminderBeforeExecutionDate__c,Survey_Code__c,Survey_Title__c,Survey_Purpose__c,
                           Survey_Shut_Down__c,Upload_Day__c,Week_Count__c,Yearly_Day_Name_of_Upload_Week__c,
                           Yearly_Week_Count__c FROM SPE2Survey__c
                           WHERE Id =: st.getId()];
            if(objSpeSurvey !=null){
            
                if(objSpeSurvey.Stage__c == 'Obsolete' && !UrlParameterMap1.containsKey('isClone')){
                    isEditDisable = 'true';                    
                }                      
                       
                           
                catarea = objSpeSurvey.CategoryArea__c;
                catgroup = objSpeSurvey.CategoryGroup__c;
                cat = objSpeSurvey.category__c;
                busUnit = objSpeSurvey.BusinessUnit__c;
                busLine = objSpeSurvey.BusinessLine__c;
                prod = objSpeSurvey.Product__c;
                market = objSpeSurvey.Market__c;
                mktunit = objSpeSurvey.MarketUnit__c;
                cntry = objSpeSurvey.Country__c;
                proj = objSpeSurvey.Project__c;              
           }
            system.debug('objSpeSurvey----' + objSpeSurvey.EndDate__c);
            startDate = objSpeSurvey.StartDate__c;
            endDate = objSpeSurvey.EndDate__c; 
            if(objSpeSurvey.StartDate__c <= system.today()){
                isPastDate = 'true';
            }
            frequencyInMonths = objSpeSurvey.FrequencyInMonths__c == null ? 0: Integer.valueOf(objSpeSurvey.FrequencyInMonths__c);
            //----------------Code for Custom picklist starts------------------------
            marketVal = objSpeSurvey.Market__c != null && objSpeSurvey.Market__c != '' ? objSpeSurvey.Market__c : '';
            marketUnitVal = objSpeSurvey.MarketUnit__c != null && objSpeSurvey.MarketUnit__c != '' ? objSpeSurvey.MarketUnit__c : '';
            countryVal = objSpeSurvey.Country__c != null && objSpeSurvey.Country__c != '' ? objSpeSurvey.Country__c : '';
            projectVal = objSpeSurvey.Project__c != null && objSpeSurvey.Project__c != '' ? objSpeSurvey.Project__c : '';
            
            buVal = objSpeSurvey.BusinessUnit__c != null && objSpeSurvey.BusinessUnit__c != '' ? objSpeSurvey.BusinessUnit__c : '';
            blVal = objSpeSurvey.BusinessLine__c != null && objSpeSurvey.BusinessLine__c != '' ? objSpeSurvey.BusinessLine__c : '';
            prdVal = objSpeSurvey.Product__c != null && objSpeSurvey.Product__c != '' ? objSpeSurvey.Product__c : '';
            
            caVal = objSpeSurvey.CategoryArea__c != null && objSpeSurvey.CategoryArea__c != '' ? objSpeSurvey.CategoryArea__c : '';
            cgVal = objSpeSurvey.CategoryGroup__c != null && objSpeSurvey.CategoryGroup__c != '' ? objSpeSurvey.CategoryGroup__c : '';
            ctVal = objSpeSurvey.Category__c != null && objSpeSurvey.Category__c != '' ? objSpeSurvey.Category__c : '';
            
    //----------------Code for Custom picklist Ends------------------------
   
            //SPE_MathsUtil.isEdit = true;
        
            /*if ([SELECT Id FROM SPE2_SurveyTracker__c WHERE Survey__c =: objSpeSurvey.Id] != null &&
                [SELECT Id FROM SPE2_SurveyTracker__c WHERE Survey__c =: objSpeSurvey.Id].size() > 0)
            {
                isTrackerCreated = true;
            }*/
             lstQuesSurveyAssoc = [select id,Name,PIData__c,PIData__r.LifecycleStage__c,QuestionLabel__c,Question_Bank__c,Survey__c,SurveyQuestion__c,ordernumber__c
                              FROM SPE2_Question_Survey_Association__c
                              WHERE Survey__c= : objSpeSurvey.Id];
              
              if(lstQuesSurveyAssoc.isEmpty())
                  strNoPI = 'true';
              for(SPE2_Question_Survey_Association__c s : lstQuesSurveyAssoc){
                  if(s.PIData__r.LifecycleStage__c != SPE_Constants.PUBLISHED_LIFECYCLESTAGE){
                      strPIPublished = 'true';
                      break;
                  }
              }
             /*lstsurveyques = [select id,Name,PIData__c,QuestionLabel__c,Question_Bank__c,Parent_Survey_Question__c,SurveyQuestion__c
                              FROM SPE_SurveyQuestion__c
                              WHERE Question_Bank__c= : objSpeSurvey.Id];*/
             
             lstsurveysupplier = [select id,Supplier__c,SPE2_Survey__c
                              FROM SPE2_SurveySupplierMap__c
                              WHERE SPE2_Survey__c= : objSpeSurvey.Id];
                              
             lstsurveyrespondent = [select id,Contact__c,Email__c,Survey__c
                              FROM SPE2_Survey_Respondents__c
                              WHERE Survey__c= : objSpeSurvey.Id];
        
        }
        spePlanSuppliers = new List<SPE_SPEPlanSupplierMap__c>();
        validateQuestion();
        
    }
    //----------------Code for Custom picklist starts------------------------
  
  //-----------------Fetch dropdown values of Market-------------

public PageReference SaveCustom(){ 
        objSpeSurvey.Market__c = marketVal;
        objSpeSurvey.BusinessUnit__c = buVal;
        objSpeSurvey.MarketUnit__c = marketUnitVal;
        objSpeSurvey.BusinessLine__c = blVal;
        objSpeSurvey.Country__c = countryVal;
        objSpeSurvey.Product__c = prdVal;
        objSpeSurvey.Project__c = projectVal;
        objSpeSurvey.CategoryArea__c = caVal;
        objSpeSurvey.CategoryGroup__c = cgVal;
        objSpeSurvey.Category__c = ctVal;
        objSpeSurvey.Stage__c = 'Draft';
        Integer intSurveyShutDownDate = objSpeSurvey.Survey_Shut_Down__c != null ? Integer.valueOf(objSpeSurvey.Survey_Shut_Down__c) : 0;
        if(objSpeSurvey.Is_One_Time_Survey__c == true){
            objSpeSurvey.EndDate__c = objSpeSurvey.StartDate__c + intSurveyShutDownDate;
            objSpeSurvey.FrequencyInMonths__c = '0';
        }
        if(objSpeSurvey.Is_One_Time_Survey__c == false && objSpeSurvey.StartDate__c <= system.today()){
            objSpeSurvey.EndDate__c = objSpeSurvey.StartDate__c + intSurveyShutDownDate;
            objSpeSurvey.FrequencyInMonths__c = '0';
            //objSpeSurvey.Survey_Shut_Down__c = 0;
            objSpeSurvey.SurveyReminderBeforeExecutionDate__c = 0;
        }
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
    
   try{ 
            if (!UrlParameterMap.containsKey('isClone')){
                upsert objSpeSurvey;
                PageReference nextpage= new PageReference('/'+objSpeSurvey.id);
                return nextpage;
            }
            else{
                objSpeSurvey.ownerid= userinfo.getUserId(); 
                SurveyCloned = objSpeSurvey.clone(false,true,false,false);
                if(SurveyCloned!= null){
                   SurveyCloned.Stage__c = 'Draft';
                   insert SurveyCloned;
                }
                 if(SurveyCloned.Id !=  null){
                        for(SPE2_Question_Survey_Association__c objSQ : lstQuesSurveyAssoc){
                             objSQ.Id = null;
                            objSQ.Survey__c= SurveyCloned.Id;
                        }
                        for(SPE2_SurveySupplierMap__c objSSM : lstsurveysupplier){
                            objSSM.Id = null;
                            objSSM.SPE2_Survey__c= SurveyCloned.Id;
                        }
                        for(SPE2_Survey_Respondents__c objSR : lstsurveyrespondent){
                            objSR.Id = null;
                            objSR.Survey__c= SurveyCloned.Id;
                        }
                        if(!lstQuesSurveyAssoc.isEmpty())
                            insert lstQuesSurveyAssoc;
                        if(!lstsurveysupplier.isEmpty())
                            insert lstsurveysupplier;
                        if(!lstsurveyrespondent.isEmpty())
                            insert lstsurveyrespondent;
                    }
            system.debug('SurveyCloned::'+SurveyCloned);
            } 
      }
   catch(Exception e){
       List<String> msgVal = new List<String>();
       msgVal = e.getMessage().split(',');
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msgVal[1]));
       return null;
   }
   Boolean isAbended = false;
        
        if (startDate != objSpeSurvey.StartDate__c ||
            endDate != objSpeSurvey.EndDate__c ||
            Decimal.valueOf(objSpeSurvey.FrequencyInMonths__c) != frequencyInMonths
           ) 
        {
            isAbended = true;
        }
        
         
        if (objSpeSurvey.Stage__c == 'Published')
        {
            
            List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = createSPETracker(objSpeSurvey, isAbended);
            
            upsert toBeInsertedSPETracker;
        } 
   Pagereference pr;
    if (!UrlParameterMap.containsKey('isClone'))
      pr = new Pagereference('/'+ objSpeSurvey.Id);
    else
      pr = new Pagereference('/'+ SurveyCloned.Id);
    return pr;
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
                caVal = Apexpages.currentPage().getParameters().get('caVal');
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            if(!setCatGroupVal.contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c))
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
        
        public void blankMethod(){}
              
    
 //----------------Code for Custom picklist ends------------------------
    public Pagereference save() 
    {
        
        //system.debug();
        objSpeSurvey.Market__c = marketVal;
        objSpeSurvey.BusinessUnit__c = buVal;
        objSpeSurvey.MarketUnit__c = marketUnitVal;
        objSpeSurvey.BusinessLine__c = blVal;
        objSpeSurvey.Country__c = countryVal;
        objSpeSurvey.Product__c = prdVal;
        objSpeSurvey.Project__c = projectVal;
        objSpeSurvey.CategoryArea__c = caVal;
        objSpeSurvey.CategoryGroup__c = cgVal;
        objSpeSurvey.Category__c = ctVal;
        system.debug('objSpeSurvey::'+objSpeSurvey);        
        try
        {
            //if (checkValidation())
            //{
                upsert objSpeSurvey;
                system.debug('objSpeSurvey1::'+objSpeSurvey);
            //}
            /*else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
                return null;
            }*/
            
        }
        catch(Exception ex)
        {
           ApexPages.addMessages(ex);
           system.debug('ex::'+ex);
           return null;
        }
    
 /*       Boolean isAbended = false;
        
        if (startDate != objSpeSurvey.StartDate__c ||
            endDate != objSpeSurvey.EndDate__c ||
            Decimal.valueOf(objSpeSurvey.FrequencyInMonths__c) != frequencyInMonths
           ) 
        {
            isAbended = true;
        }
        
         
        if (objSpeSurvey.Stage__c == 'Published')
        {
            
            List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = createSPETracker(objSpeSurvey, isAbended);
            
            upsert toBeInsertedSPETracker;
        }   */
      Pagereference pr = new Pagereference('/' + objSpeSurvey.Id);
        
        return pr;  
       
    }
    
    /*private Boolean checkValidation()
    {
        
        if (objSpeSurvey.StartDate__c > objSpeSurvey.EndDate__c )
        {   
            errorMsg = 'Survey: Start date should always be lesser than Survey End Date';
            return false; 
        }
        
        if (objSpeSurvey.StartDate__c <= system.today())
        {   
            errorMsg = 'Survey: Start date should be future Date';
            return false; 
        }
        
        if (objSpeSurvey.EndDate__c > objSpeSurvey.StartDate__c.addYears(5))
        {
            errorMsg = 'Survey: End date should not be more than 5 years of Survey Start Date';
            return false; 
        }
        
        if (objSpeSurvey.SurveyExecutionBeforeIndays__c < objSpeSurvey.SurveyReminderBeforeExecutionDate__c )
        {
            errorMsg = 'Survey: Survey Reminder before Day should always be lesser than survey execution';
            return false; 
        }
        return true;
    }*/
    @TestVisible
    private List<SPE2_SurveyTracker__c> createSPETracker (SPE2Survey__c objSpeSurvey, Boolean isAbended)
    {
        List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = new List<SPE2_SurveyTracker__c>();
        
        if (isAbended)
        {
            List<SPE2_SurveyTracker__c> toBeAbendedTracker = [SELECT Id, Survey__c, Status__c 
                                                          FROM SPE2_SurveyTracker__c
                                                          WHERE Status__c =  'Pending' AND  Survey__c =: objSpeSurvey.Id];
            system.debug('survey tracker list'+toBeAbendedTracker);                                              
                                                          
            for (SPE2_SurveyTracker__c tracker : toBeAbendedTracker)
            {
                tracker.Status__c = 'Abandoned';
                toBeInsertedSPETracker.add(tracker);
            }
        
           strtDate = objSpeSurvey.StartDate__c;
            
            system.debug('start date +--'+strtDate);
            
            List<Date> toBeStartTracker = new List<Date>();///
            
            /*
            while (strtDate <= objSpeSurvey.EndDate__c )
            {
                toBeStartTracker.add(strtDate);
                
                if(objSpeSurvey.FrequencyInMonths__c != '0'){
                    strtDate = strtDate.addMonths(Integer.valueOf(objSpeSurvey.FrequencyInMonths__c));
                    
                }
                else{
                    break;
                }
            }*/
            
            if (objSpeSurvey.FrequencyInMonths__c == '0')
            {
                toBeStartTracker.add(strtDate);
            }
            else
            {
                while (strtDate <= objSpeSurvey.EndDate__c )
                {
                    toBeStartTracker.add(strtDate);
                    
                    strtDate = strtDate.addMonths(Integer.valueOf(objSpeSurvey.FrequencyInMonths__c));
                    system.debug('toBeStartTracker---'+toBeStartTracker);
                }
            }
            
            for  (Date sDate : toBeStartTracker)
            {
                SPE2_SurveyTracker__c surveyTracker = new SPE2_SurveyTracker__c();
                surveyTracker.Name = SPE_Utility.monthsMap.get(sDate.month()) + ' - '+ String.valueOf(sDate.year());
                surveyTracker.Survey__c = objSpeSurvey.Id;
                //surveyTracker.SPETemplate__c = objSpeSurvey.SPETemplate__c;
                surveyTracker.DateOfExecution__c = sDate;
                surveyTracker.Status__c = 'Pending';
                
                surveyTracker.Market__c = objSpeSurvey.Market__c;
                surveyTracker.MarketUnit__c = objSpeSurvey.MarketUnit__c;
                surveyTracker.Country__c = objSpeSurvey.Country__c;
                surveyTracker.Project__c = objSpeSurvey.Project__c;
                
                surveyTracker.BusinessLine__c = objSpeSurvey.BusinessLine__c;
                surveyTracker.BusinessUnit__c = objSpeSurvey.BusinessUnit__c;
                surveyTracker.Product__c = objSpeSurvey.Product__c;
                
                surveyTracker.Category__c = objSpeSurvey.Category__c;
                surveyTracker.CategoryGroup__c = objSpeSurvey.CategoryGroup__c;
                surveyTracker.CategoryArea__c = objSpeSurvey.CategoryArea__c;
                
                toBeInsertedSPETracker.add(surveyTracker);
                system.debug('insert tracker---'+toBeInsertedSPETracker);
            }
        } 
        return toBeInsertedSPETracker;
    }
    
    public Pagereference generateTracker()
    {    
        system.debug('validate ques before'+validateQues);
        
        system.debug('validate ques after---'+validateQues);
        if(validateQues == 'false'){
        objSpeSurvey.Stage__c = 'Published';
        update objSpeSurvey;
        system.debug('stage update ---'+objSpeSurvey);
        List<SPE2_SurveyTracker__c> toBeInsertedSPETracker = createSPETracker(objSpeSurvey, true);
        
        system.debug('spe tracker to insert'+toBeInsertedSPETracker);  
        insert toBeInsertedSPETracker;  
        
        if(toBeInsertedSPETracker.size()>0){
            List<SPE2_SurveyTracker__c> survTrackerUpd = new List<SPE2_SurveyTracker__c>();
            if(strtDate <= System.Today()){
                for(SPE2_SurveyTracker__c trk : toBeInsertedSPETracker){
                    trk.SendSurveyLink__c = true;
                    survTrackerUpd.add(trk);
                }
                update survTrackerUpd;
            }
   
        }
        Pagereference pr = new Pagereference('/' + objSpeSurvey.Id);
        
        return pr;
        }
        else
        return null;
        
    } 
    
    public void validateQuestion(){
    system.debug('inside validate---');
    validateQues = 'false';
    quessurveyObj = new List<SPE2_Question_Survey_Association__c>();
    String query;
        query = 'SELECT ID,Question_Bank__c,Survey__c,PIData__c,PIData__r.DataAcquisitionMethod__c,Question_Bank__r.Name,'+
                 ' Question_Bank__r.QuestionLabel__c,Question_Bank__r.SurveyQuestion__c  from SPE2_Question_Survey_Association__c where Survey__c = :PageId'+
                 ' and (PIData__r.DataAcquisitionMethod__c !=  \'Standalone Survey\' OR PIData__c = null ';
       
       system.debug('query is 1'+query);   
       if(catarea == 'All Category Areas'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'All Categories\'';
       
       }
       
       if(catarea != 'All Category Areas' && catgroup == 'All Category Groups'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'Category Area\'';
       
       }
       
       if(catarea != 'All Category Areas' && catgroup != 'All Category Groups' && cat == 'All Categories'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'Category Group\'';
       
       }
       
        if(catarea != 'All Category Areas' && catgroup != 'All Category Groups' && cat != 'All Categories'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'Category\'';
       
       }
       
       
       if(busUnit == 'All Business Units'){
           query +=' OR '+'PIData__r.BUScope__c!=\'All Products\'';
       
       }
       
       if(busUnit != 'All Business Units' && busLine == 'All Business Lines'){
           query +=' OR '+'PIData__r.BUScope__c!=\'Business Unit\'';
       
       }
       
        if(busUnit != 'All Business Units' && busLine != 'All Business Lines' && prod == 'All Products'){
           query +=' OR '+'PIData__r.BUScope__c!=\'Business Line\'';
       
       }
       
       if(busUnit != 'All Business Units' && busLine != 'All Business Lines' && prod != 'All Products'){
           query +=' OR '+'PIData__r.BUScope__c!=\'Product\'';
       
       }
       
        if(market == 'All Markets'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'All Markets\')';
       
       }
       
       if(market != 'All Markets' && mktunit == 'All Market Units'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Market\')';
       
       }
       
       if(market != 'All Markets' && mktunit != 'All Market Units' && cntry == 'All Countries'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Market Unit\')';
       
       }
        if(market != 'All Markets' && mktunit != 'All Market Units' && cntry != 'All Countries' && proj == 'All Projects'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Country\')';
       
       }
       
       if(market != 'All Markets' && mktunit != 'All Market Units' && cntry != 'All Countries' && proj != 'All Projects'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Project\')';
       
       }
       
       
       system.debug('query is'+query);   
       
       quesSurveyObj = database.query(query);
       if(quesSurveyObj.size()>0){
       system.debug('ques not validated');
       validateQues = 'true';
       }
    
    }
}