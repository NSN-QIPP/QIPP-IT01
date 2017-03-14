public class SPE2_NewKPIThresholdExt
{
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
    public SPE2_KPI_Threshold__c kpiThreshold{get;set;}
    public SPE_KPIDefinition__c kpiDef {get;set;}
    public List<ScoringCalcWrapper> scoringcalclist{get;set;}
    public List<KPIRangeWrapper> kpiRangeWrapperList{get;set;}
    public List<SPE_ScoringCalculation__c> scoreValcalcdisplay{get;set;}
    public list<String> kpiLevels;
    public Boolean isCorrect {get;set;}
    Public String kpiIds {get;set;}
    public Map<String,Double> kpiValuesAggrMap{get;set;} 
    public String aggregationVal{get;set;}
    private ApexPages.StandardController controller;
    public Sobject CurrRecord{get;set;}
    public boolean isSuccess{get;set;}
    public boolean isAccess{get;set;}
    public boolean pilot{get;set;}
    public boolean published{get;set;}
    public boolean obsolete{get;set;}
    public Id RecordId{get;set;}
    Id kpiThresholdId;
    public boolean Proceed{get;set;}
    public String SobjectName{get;set;}
    public string stage{get;set;}
    public String msg{get;set;}
    public Map<String, Schema.SObjectField> M{get;set;}
    public List<SPE2_KPI_Threshold__c> scoreThresholdList {get;set;}
    public boolean isHighBetterNew{get;set;}
    public boolean isHighBetterView{get;set;}
    public Boolean isNew{get;set;}
    public Boolean isEdit{get;set;} 
    public List<SPE2_KPI_Threshold__c> scoreThresholdToDisplay {get;set;}
    public boolean popUpSelected{get;set;}
    public String isClone{get;set;}
    public boolean showheaderAndSidebar{get;set;}
     //-----------------Initialization of Variables for Custom Picklist Starts-----------------------
    
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public string buVal{get;set;}
    public string blVal{get;set;}
    public string marketVal{get;set;} 
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;} 
    public string projectVal{get;set;}
    public string prdVal{get;set;}
    List<SelectOption> CatGroupOptions;
    List<SelectOption> CategoryOptions;
    public Set<String> lstTemp{get;set;}
    Set<String> setCategoryArea;
    Set<String> setMarkets;
    Set<String> setMarketUnit;
    Set<String> setBusinessUnits;
    List<SelectOption>  mkoptions;
    List<SelectOption> countryOptions;
    List<SelectOption> projectOptions;
    List<SelectOption> BusinessLineOptions;
    List<SelectOption> ProductOptions;
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails  {get;set;}
    public thresholdscopeAttributeMap threshsaMap;
    //-----------------Initialising variable for enabling and disabling scope attributes starts here---------
    public Map<String,Boolean> enableattributesMap{get;set;}
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    public List<PicklistDefaultValues__c> defalultPickl{
        get{
            return PicklistDefaultValues__c.getall().values();
        }
    } 
    
    public SPE2_NewKPIThresholdExt(ApexPages.StandardController controller){
        showheaderAndSidebar = true;
        String popUpWindow = ApexPages.currentPage().getParameters().get('isPopUpWindow');
        if(popUpWindow != '' && popUpWindow == 'true'){
            showheaderAndSidebar =false;
        }
        isClone = 'false';
        popUpSelected = false;
        this.controller = controller;
        scoringcalclist = new list<ScoringCalcWrapper>();
        system.debug('123::' +controller.getId());
        pilot=true;
        published=true;
        obsolete=true;
        Proceed=false;
        isSuccess=false;
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
        setCategoryArea = new Set<String>();
        setMarkets = new Set<String>();
        lstTemp =new Set<String>();
        setBusinessUnits = new Set<String>();
        system.debug('<<<<Sud'+controller.getId());
        threshsaMap = new thresholdscopeAttributeMap();
        enableattributesMap = threshsaMap.initializeMapValue();
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
            
            marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
            caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
        
        if(controller.getId() == null){
            kpiThreshold = new SPE2_KPI_Threshold__c (Stage__c = 'Draft',OwnerId =Userinfo.getUserId());
            kpiThreshold.OwnerId =Userinfo.getUserId();
            kpiThreshold.KPI_ID__c= ApexPages.currentPage().getParameters().get('kpiId');
            kpiIds =kpiThreshold.KPI_ID__c;
            kpiLevels = new list<string>();
            kpiValuesAggrMap = new Map<String,Double>();
            isNew =true;
            isEdit=false;
            SPE_KPIDefinition__c kpiDef = [Select Id,Level__c,KPI_Title__c,Aggregation__c,IsHighBetter__c From SPE_KPIDefinition__c Where Id =:kpiIds];
            kpiThreshold.High_Better__c= kpiDef.IsHighBetter__c;
            isHighBetterNew =kpiThreshold.High_Better__c;
            aggregationVal = kpiDef.Aggregation__c;
            system.debug('<<aggregation values'+kpiValuesAggrMap.values());

            system.debug('aggregate ::'+aggregationVal);
            calculation();
            kpiLevels = kpiDef.Level__c.split(';');
            for(string s :kpilevels){
                scoringcalclist.add(new ScoringCalcWrapper(new SPE_ScoringCalculation__c(score__c = integer.valueOf(s)),kpiDef.KPI_Title__c));
            }
            system.debug('nitish'+kpiThreshold.KPI_ID__c);
            kpiDef = [Select Id,GeoScope__c,Categoryscope__c,BUScope__c from SPE_KPIDefinition__c where Id =:kpiIds];
            enableattributesMap = threshsaMap.qualifyScopeAttributes(kpiDef);
             
         }
         
         else{
              if(ApexPages.currentPage().getParameters().get('isClone') == null){
            CurrentUserId = UserInfo.getUserId();
            RecordOwnerId = [Select Id, ownerId from SPE2_KPI_Threshold__c 
                           WHERE Id =: controller.getId()].ownerId;
             }
             
             isNew =false;
             isEdit=true;
             isClone = ApexPages.currentPage().getParameters().get('isClone');
             kpiThreshold =[Select Name,ownerId,CreatedDate, KPI_ID__c,High_Better__c,KPI_ID__r.IsHighBetter__c ,KPI_ID__r.KPI_Title__c,KPI_Attrribute__c,KPI_Title__c,Threshold_Title__c,Stage__c,Weightage__c,
                             Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c,BusinessUnit__c,BusinessLine__c,Product__c,LastModifiedById 
                             FROM SPE2_KPI_Threshold__c where ID =:controller.getId()];
             scoreValcalcdisplay = [Select Score__c,Lower__c,Upper__c,LowerTo__c,UpperTo__c from SPE_ScoringCalculation__c where KPI_Threshold__c =:kpiThreshold.Id];
             
             isHighBetterNew =kpiThreshold.High_Better__c;
           //  isHighBetterNew = [Select Id,IsHighBetter__c From SPE_KPIDefinition__c Where Id =:kpiThreshold.KPI_ID__c].IsHighBetter__c;
             system.debug('<<<scoreValcalcdisplay ::'+scoringcalclist);         
             if(Apexpages.currentPage().getParameters().get('isClone')!= null)
                    kpiThreshold.Stage__c = 'Draft';
             
             kpiIds =kpiThreshold.KPI_ID__c;
             marketVal = kpiThreshold.Region__c;
             marketUnitVal = kpiThreshold.SubRegion__c;
             countryVal = kpiThreshold.Country__c;            
             projectVal = kpiThreshold.Project__c;
             caVal = kpiThreshold.CategoryCluster__c;
             cgVal = kpiThreshold.CategoryGroup__c;
             ctVal = kpiThreshold.Category__c;
             buVal =kpiThreshold.BusinessUnit__c ;
             blVal =kpiThreshold.BusinessLine__c ;
             prdVal =kpiThreshold.Product__c ;
             
             RecordId = Id.valueOf(controller.getId());
             kpiThresholdId= controller.getId();
             
             IsAccess=[SELECT recordId,HasEditAccess FROM UserRecordAccess WHERE UserId =:UserInfo.getUserId() AND RecordId =:controller.getid()].HasEditAccess ; 
             if(IsAccess){
                  if(kpiThreshold.stage__c=='Draft'){
                      pilot=false;
                      Published=false;
                      Obsolete=false;
                  }
                  if(kpiThreshold.stage__c =='Pilot'){
                      Published=false;
                      obsolete=false;
                  }
                  if(kpiThreshold.stage__c=='Published'){
                      Obsolete=false;
                  }
               } 
           kpiDef = [Select Id,GeoScope__c,Categoryscope__c,BUScope__c from SPE_KPIDefinition__c where Id =:kpiIds];
           enableattributesMap = threshsaMap.qualifyScopeAttributes(kpiDef);      
           }
           
      iscorrect=false;
     }
     
     //-----------------Fetch dropdown values of Market-------------
     
     public List<SelectOption> getMarketValues(){
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

      public List<SelectOption> getMarketUnitValues(){   
            fillMarketUnit();
            return mkoptions;
      }
    
      public void fillMarketUnit(){
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
        
        // Fetch drop down values for country
        
        public List<SelectOption> getCountryValues(){   
            fillCountry();
            return countryOptions;
        }
        
        
        public void fillCountry(){
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
        
        public List<SelectOption> getProjectValues(){   
            fillProject();
            return projectOptions;
        }
        
        public void fillProject(){
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
        
        //--------------Fetch dropdown values for Category Area--------------------
        
        public List<SelectOption> getCategoryAreaValues(){
            List<SelectOption> options = new List<SelectOption>();
            if(!setCategoryArea.contains(PicklistDefaultValues__c.getall().values()[0].Category_Area__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Area__c,PicklistDefaultValues__c.getall().values()[0].Category_Area__c));
            for(String s : setCategoryArea ){
                options.add(new SelectOption(s,s));
            }
            return options;
         }
         
         //-----------------Fetch dropdown values for Category Group---------------------------
         
        public List<SelectOption> getCategoryGroupValues(){   
            fillCategoryGroup();
            return CatGroupOptions;
        }
        
        public void fillCategoryGroup(){
            if(Apexpages.currentPage().getParameters().get('caVal')!= null)
                caVal= Apexpages.currentPage().getParameters().get('caVal');
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
         
        public List<SelectOption> getCategoryValues(){   
            fillCategory();
            return CategoryOptions;
        }
        
        public void fillCategory(){
            if(Apexpages.currentPage().getParameters().get('cgVal')!= null)
            cgVal= Apexpages.currentPage().getParameters().get('cgVal');
            CategoryOptions= new List<SelectOption>();
            Set<String> setCatVal = new Set<String>();
            setCatVal = mapHierarchyDetails1.get(caVal+cgVal);
            
             if((caVal== PicklistDefaultValues__c.getall().values()[0].Category_Area__c) || !(mapHierarchyDetails1.containsKey(caVal+cgVal)))
             {
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
             }
            
             else if(!setCatVal .contains(PicklistDefaultValues__c.getall().values()[0].Category__c)){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
           
                 for(String s : mapHierarchyDetails1.get(caVal+cgVal)){
                    CategoryOptions.add(new SelectOption(s,s));
                  }
             }
          
             else
               CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
        }
        
        //--------------Fetch dropdown values of Business Units------------------------------
        
       public List<SelectOption> getBusinessUnitValues(){
            List<SelectOption> options = new List<SelectOption>();
            if(!setBusinessUnits.contains(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c,PicklistDefaultValues__c.getall().values()[0].Business_Unit__c));
            for(String s : setBusinessUnits){
                options.add(new SelectOption(s,s));
            }
            
            return options;
        }
     
     //--------------------Fetch dropdown values for Business Line-------------------
         
        public List<SelectOption> getBusinesLineValues(){   
            fillBusinessLine();
            return BusinessLineOptions;
        }
        
       public void fillBusinessLine(){
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
    
       public List<SelectOption> getProductValues(){   
            fillProduct();
            return ProductOptions;
        }
        
       public void fillProduct(){
            
            if(Apexpages.currentPage().getParameters().get('blVal')!= null){
                blVal= Apexpages.currentPage().getParameters().get('blVal');
            }
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
        
         //---------------------- Code for Changing into Pilot Stage----------------------------
        
       public void StagePilot(){
             try{  
                 kpiThreshold.stage__c = 'Pilot';
                 update kpiThreshold;
                 isSuccess =true;
                 pilot= true;
                 published = false;
                 obsolete = false;
                 
             }
             catch(Exception ex){
                  msg= ex.getMessage();
                  list<string> s=msg.split(':');
                  msg=s[1];
                  isSuccess = false;
                  system.debug('**********'+msg);
              }
       }
       
       //---------------------- Code for Changing into Published Stage----------------------------
       
       public void StagePublished(){
             try{ 
                 kpiThreshold.stage__c = 'Published';
                 update kpiThreshold;               
                 isSuccess=true;
                 published = true;
                 pilot =true;
                 obsolete =false;
                 system.debug('******isSuccess'+isSuccess);
             } 
             catch(Exception ex){
                   msg= ex.getMessage();
                   list<string> s=msg.split(':');
                   msg=s[1];
                   isSuccess = false;
                   system.debug('**********'+msg);
              }
         }
          
          //---------------------- Code for Changing into Obsolete Stage----------------------------
    
         public void StageObsolete(){
              try{                    
                   kpiThreshold.stage__c = 'obsolete';
                   update kpiThreshold;
                   isSuccess=true;
                   obsolete = true;
                   pilot =true;
                   published =true;
               } 
            
           catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               isSuccess = false;
             }
           }
          
          //---------------------- Code for Calculating Aggregation values of KPI----------------------------
            
        public void calculation(){
            AggregateResult kpigroupedResult= [SELECT AVG(kpivalue__c)avgkpi,SUM(kpivalue__c)sumkpi,MAX(kpivalue__c)maxkpi,MIN(kpivalue__c)minkpi FROM SPE_KPIValue__c where kpiDefinition__c =: kpiIds];
            
            kpiValuesAggrMap.put('AVG',Double.ValueOf(kpigroupedResult.get('avgkpi')));
            kpiValuesAggrMap.put('SUM',Double.ValueOf(kpigroupedResult.get('sumkpi')));
            kpiValuesAggrMap.put('MAX',Double.ValueOf(kpigroupedResult.get('maxkpi')));
            kpiValuesAggrMap.put('MIN',Double.ValueOf(kpigroupedResult.get('minkpi')));
            system.debug('<<aggregatiom'+kpiValuesAggrMap.get(aggregationVal));
            system.debug('<<aggregation values'+kpiValuesAggrMap.values());
        }
        
        //---------------------- Code for Validating Scoring Threshold----------------------------
    
        public void Validate(){
            if(checkValidation() == true){
            
            }
        }
        
        //---------------------- Code for Cloning KPI Threshold----------------------------
        public pagereference cloneFn(){
            system.debug('kpiThresholdId::'+kpiThresholdId);
            pagereference pg1 = new pagereference('/apex/SPE2_NewKPIThreshold?id='+kpiThresholdId+'&isClone=true');
            pg1.setRedirect(true);
            return pg1;
        } 
        //------ Method for Populate Attribute Values starts here---
       public void populateAllValues(){
            system.debug('KpiIdsval ::'+kpiIds);
            kpiDef = [Select Id,IsHighBetter__c,GeoScope__c,Categoryscope__c,BUScope__c from SPE_KPIDefinition__c where Id =:kpiThreshold.KPI_ID__c];
            isHighBetterNew = kpiDef.IsHighBetter__c ;
            enableattributesMap.clear();
            threshsaMap.initializeMapValue();
            enableattributesMap = threshsaMap.qualifyScopeAttributes(kpiDef);
            system.debug('enableattributesMap::'+enableattributesMap);
          //  toBeUpdatedScoringCalculation = new Map < Id, List < ScoringCalcuationWrapper> >();            
      }  
     //------ Method for Populate Attribute Values ends here--- 
        //---------------------- Code for Saving the KPI Threshold----------------------------
    
        public PageReference save(){
            PageReference pg;
            if(checkValidation() == true){
                //----------------Code for Custom picklist starts------------------------
                if(marketVal == null || marketVal == ''){
                    marketVal = SPE_Constants.ALL_GEOSCOPE;
                }
                if(marketUnitVal == null || marketUnitVal == ''){
                    marketUnitVal = SPE_Constants.ALL_GEOSCOPE_UNIT;
                }
                if(countryVal == null || countryVal == ''){
                    countryVal = SPE_Constants.ALL_Country;
                }
                if(projectVal == null || projectVal == ''){
                    projectVal = SPE_Constants.ALL_Project;
                }
                if(buVal == null || buVal == ''){
                    buVal = SPE_Constants.ALL_BU_BUSCOPE;
                }
                if(blVal == null || blVal == ''){
                    blVal = SPE_Constants.ALL_BL_BUSCOPE ;
                }
                if(prdVal == null ||  prdVal == ''){
                     prdVal = SPE_Constants.ALL_BUSCOPE;
                }
                if(caVal == null ||  caVal == ''){
                     caVal = SPE_Constants.ALL_CATSCOPE_AREA;
                }
                if(cgVal == null ||  cgVal == ''){
                     cgVal = SPE_Constants.ALL_CATSCOPE_GROUP;
                }
                if(ctVal == null ||  ctVal == ''){
                     ctVal = SPE_Constants.ALL_CATSCOPE;
                }
             
                //----------------Code for Custom picklist Ends------------------------
                kpiThreshold.CategoryCluster__c= caVal;
                kpiThreshold.CategoryGroup__c = cgVal;
                kpiThreshold.Category__c = ctVal;
                kpiThreshold.Region__c= marketVal;
                kpiThreshold.SubRegion__c= marketUnitVal;
                kpiThreshold.Country__c = countryVal;
                kpiThreshold.Project__c = projectVal;
                kpiThreshold.BusinessUnit__c =buVal;
                kpiThreshold.BusinessLine__c =blVal;
                kpiThreshold.Product__c =prdVal;
                isClone = ApexPages.currentPage().getParameters().get('isClone');
                
                if(enableattributesMap.get('Market') !=false){
                    if(marketVal ==SPE_Constants.ALL_GEOSCOPE){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    }
                    else{
                        kpiThreshold.Region__c =marketVal;
                    } 
                }
                if(enableattributesMap.get('Market Unit') !=false){
                    if(marketUnitVal ==SPE_Constants.ALL_GEOSCOPE_UNIT){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.SubRegion__c = marketUnitVal;
                    }
                }
                if(enableattributesMap.get('Country') !=false){
                    if(countryVal ==SPE_Constants.ALL_Country){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.Country__c = countryVal;
                    }
                }
                if(enableattributesMap.get('Project') !=false){
                    if(projectVal ==SPE_Constants.ALL_Project ){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.Project__c = projectVal;
                    }
                }
                
                if(enableattributesMap.get('Category Area') !=false){
                    if(caVal ==SPE_Constants.ALL_CATSCOPE_AREA){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.CategoryCluster__c = caVal;
                    }
                }
                if(enableattributesMap.get('Category Group') !=false){
                    if(cgVal ==SPE_Constants.ALL_CATSCOPE_GROUP ){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.CategoryGroup__c = cgVal;
                    }
                }
                if(enableattributesMap.get('Category') !=false){
                    if(ctVal ==SPE_Constants.ALL_CATSCOPE){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.Category__c = ctVal;
                    }
                }
                
                if(enableattributesMap.get('Business Unit') !=false){
                    if(buVal ==SPE_Constants.ALL_BU_BUSCOPE){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.BusinessUnit__c = buVal;
                    }
                }
                if(enableattributesMap.get('Business Line') !=false){
                    if(blVal ==SPE_Constants.ALL_BL_BUSCOPE){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    } 
                    else{
                        kpiThreshold.BusinessLine__c = blVal;
                    }
                }
                if(enableattributesMap.get('Product') !=false){
                    if(prdVal ==SPE_Constants.ALL_BUSCOPE){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please specify the full attributes for this KPI Threshold'));
                        return null;
                    }
                    else{
                        kpiThreshold.Product__c = prdVal;
                    } 
                }
                
                if(isClone == 'true'){
                    SPE2_KPI_Threshold__c kpiThresholdCloned = new SPE2_KPI_Threshold__c();
                    
                    kpiThresholdCloned.KPI_ID__c = kpiThreshold.KPI_ID__c;
                    kpiThresholdCloned.Threshold_Title__c = kpiThreshold.Threshold_Title__c;
                    kpiThresholdCloned.stage__c =kpiThreshold.stage__c;
                    kpiThresholdCloned.stage__c ='Draft';
                    kpiThresholdCloned.High_Better__c =kpiThreshold.High_Better__c;
                    kpiThresholdCloned.CategoryCluster__c= caVal;
                    kpiThresholdCloned.CategoryGroup__c = cgVal;
                    kpiThresholdCloned.Category__c = ctVal;
                    kpiThresholdCloned.Region__c= marketVal;
                    kpiThresholdCloned.SubRegion__c= marketUnitVal;
                    kpiThresholdCloned.Country__c = countryVal;
                    kpiThresholdCloned.Project__c = projectVal;
                    kpiThresholdCloned.BusinessUnit__c =buVal;
                    kpiThresholdCloned.BusinessLine__c =blVal;
                    kpiThresholdCloned.Product__c =prdVal;
                    try{
                        insert kpiThresholdCloned;
                        system.debug('kpiThresholdCloned ::'+kpiThresholdCloned);  
                        
                        List<SPE_ScoringCalculation__c> scoringCalToInsert = new List<SPE_ScoringCalculation__c>(); 
                        for(SPE_ScoringCalculation__c sc :scoreValcalcdisplay){
                            scoringCalToInsert.add(new SPE_ScoringCalculation__c (KPI_Threshold__c = kpiThresholdCloned.Id,KPIDefinition__c =kpiThresholdCloned.KPI_ID__c,Lower__c = sc.Lower__c,LowerTo__c =sc.LowerTo__c,Upper__c =sc.Upper__c,UpperTo__c =sc.UpperTo__c,Score__c =sc.Score__c));
                        } 
                        
                        insert scoringCalToInsert; 
                        // set threshold boundary for cloned
                        List<SPE_ScoringCalculation__c> scalBoundaryListCloned= [SELECT KPI_Threshold__c,Lower__c,Upper__c,KPI_Threshold__r.High_Better__c FROM SPE_ScoringCalculation__c 
                                                                                 Where KPI_Threshold__c =:kpiThresholdCloned.Id];
                        Set<decimal> boundaryValsCloned = new Set<decimal>();
                        for(SPE_ScoringCalculation__c scblc :scalBoundaryListCloned){
                            boundaryValsCloned.add(scblc.Lower__c);
                            boundaryValsCloned.add(scblc.Upper__c);
                        }
                        String boundaryLimitCln = '';
                        list<decimal> tempListCloned = new list<decimal>();
                        for(decimal d :boundaryValsCloned){
                            tempListCloned.add(d);
                        }
                        tempListCloned.sort();
                        if(!scalBoundaryListCloned[0].KPI_Threshold__r.High_Better__c){
                            for(decimal d :tempListCloned){
                                boundaryLimitCln = boundaryLimitCln + string.valueOf(d)+'-->';
                            }
                        }else{                            
                            for(integer i = tempListCloned.size()-1; i>=0;i--){
                                boundaryLimitCln = boundaryLimitCln + string.valueOf(tempListCloned[i])+'-->';
                            }
                        }
                        kpiThresholdCloned.Threshold_Boundary__c = boundaryLimitCln;
                        update kpiThresholdCloned;
                        // end threshold boundary for cloned
                                                                   
                        pg = new PageReference('/' +kpiThresholdCloned.Id);
                        return pg;
                     }
                    catch(Exception e){
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, e.getmessage().split(';')[1]));
                         system.debug('<<score'+e.getMessage());                
                         return null;
                    }
                }                
                if((isNew == true && isEdit == false)){
           
                    try{
                        insert kpiThreshold;
                        List<SPE_ScoringCalculation__c> scoringCalculations = new List<SPE_ScoringCalculation__c>();
                        for(ScoringCalcWrapper scw :scoringcalclist){
                            scw.spesc.KPI_Threshold__c = kpiThreshold.Id;
                            scw.spesc.KPIDefinition__c = kpiThreshold.KPI_ID__c;
                            system.debug('kpiThresholdId ::'+kpiThreshold.KPI_ID__c);                            
                            scoringCalculations.add(scw.spesc);
                        }
                        
                        insert scoringCalculations;
                        // set threshold boundary 
                        List<SPE_ScoringCalculation__c> scalBoundaryList= [SELECT KPI_Threshold__c,Lower__c,Upper__c,KPI_Threshold__r.High_Better__c FROM SPE_ScoringCalculation__c 
                                                                           Where KPI_Threshold__c =:kpiThreshold.Id];
                        Set<decimal> boundaryVals = new Set<decimal>();
                        for(SPE_ScoringCalculation__c scbl :scalBoundaryList){
                            boundaryVals.add(scbl.Lower__c);
                            boundaryVals.add(scbl.Upper__c);
                        }
                        String boundaryLimit = '';
                        list<decimal> tempList = new list<decimal>();
                        for(decimal d :boundaryVals){
                            tempList.add(d);
                        }
                        templist.sort();
                        if(!scalBoundaryList[0].KPI_Threshold__r.High_Better__c){
                            for(decimal d :tempList){
                                boundaryLimit = boundaryLimit + string.valueOf(d)+'-->';
                            }
                        }else{                            
                            for(integer i = tempList.size()-1; i>=0;i--){
                                boundaryLimit = boundaryLimit + string.valueOf(templist[i])+'-->';
                            }
                        }
                        kpiThreshold.Threshold_Boundary__c = boundaryLimit;
                        update kpiThreshold;
                        // end threshold boundary
                        system.debug('kpiThreshold::'+kpiThreshold);
                        String popUpWindow = ApexPages.currentPage().getParameters().get('isPopUpWindow');
                           
                        if(popUpWindow != '' && popUpWindow == 'true'){
                            showheaderAndSidebar =false;
                                                         
                            scoreThresholdToDisplay = [Select Id,Name,Threshold_Title__c,KPI_ID__r.Name From SPE2_KPI_Threshold__c
                                                        Where Id =: kpiThreshold.Id];
                            popUpSelected = true;
                            //PageReference pf = new PageReference('/'+kpiThreshold.Id);
                            //return pf;
                        }else{        
                            PageReference pf = new PageReference('/'+kpiThreshold.Id);
                            return pf;
                        }
                    }
                    catch(Exception e){
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, e.getmessage().split(';')[1])); 
                        system.debug('<<score'+e.getMessage());                
                        return null;
                    }
                 } 
                 
                 if(isNew == false && isEdit == true){
                     try{
                        update kpiThreshold;
                        update scoreValcalcdisplay;
                        // set threshold boundary 
                        List<SPE_ScoringCalculation__c> scalBoundaryListedit= [SELECT KPI_Threshold__c,Lower__c,Upper__c,KPI_Threshold__r.High_Better__c FROM SPE_ScoringCalculation__c 
                                                                           Where KPI_Threshold__c =:kpiThreshold.Id];
                        Set<decimal> boundaryValsedit = new Set<decimal>();
                        for(SPE_ScoringCalculation__c scbled :scalBoundaryListedit){
                            boundaryValsedit.add(scbled.Lower__c);
                            boundaryValsedit.add(scbled.Upper__c);
                        }
                        String boundaryLimited = '';
                        list<decimal> tempListedit = new list<decimal>();
                        for(decimal d :boundaryValsedit){
                            tempListedit.add(d);
                        }
                        tempListedit.sort();
                        if(!scalBoundaryListedit[0].KPI_Threshold__r.High_Better__c){
                            for(decimal d :tempListedit){
                                boundaryLimited  = boundaryLimited + string.valueOf(d)+'-->';
                            }
                        }else{                            
                            for(integer i = tempListedit.size()-1; i>=0;i--){
                                boundaryLimited = boundaryLimited + string.valueOf(tempListedit[i])+'-->';
                            }
                        }
                        kpiThreshold.Threshold_Boundary__c = boundaryLimited;
                        upsert kpiThreshold;
                        // end threshold boundary               
                        PageReference pf = new PageReference('/'+kpiThresholdId);
                        return pf;
                    }
                    catch(Exception e){
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, e.getmessage().split(';')[1]));
                         system.debug('<<score'+e.getMessage());                
                         return null;
                    }
                  }
               }    
            return null;
        }
        
        //---------------------- Code for Cancelling the KPI Threshold----------------------------
    
        public PageReference cancel(){
            PageReference pf = new PageReference('/'+kpiIds);
            return pf;
        }
        
        //---------------------- Code for Editing the KPI Threshold----------------------------
        
        public PageReference edi()
        {
            PageReference pg = controller.edit();
            return pg;
        }
        
        //---------------------- Code for Validation----------------------------
    
        public  Boolean checkValidation(){
            isCorrect = false ;
            Map<Id,List<ScoringCalcWrapper>> toBeUpdatedScoringCalculation = new Map<Id,List<ScoringCalcWrapper>>();
            if(isNew){
                toBeUpdatedScoringCalculation.put(kpiIds,scoringcalclist);                
            }
            if(isEdit){
                List<ScoringCalcWrapper> tempScoreWrapper = new List<ScoringCalcWrapper>();
                for(SPE_ScoringCalculation__c scal :scoreValcalcdisplay){
                    tempScoreWrapper.add(new ScoringCalcWrapper(scal,kpiThreshold.KPI_ID__r.KPI_Title__c));
                }
                toBeUpdatedScoringCalculation.put(kpiIds,tempScoreWrapper);                
            }
            system.debug('test'+toBeUpdatedScoringCalculation);
          
               system.debug('test'+toBeUpdatedScoringCalculation.values());
            for (Id kpiIds : toBeUpdatedScoringCalculation.keySet())
            {   
                set <Integer> rangeSet = new set  <Integer>  ();                
                List<KPIRangeWrapper> kpiRangeWrapperList = new List<KPIRangeWrapper>();                
                Map <Decimal, ScoringCalcWrapper>  scoreScoringCalculationMap = new Map <Decimal, ScoringCalcWrapper>();                
                String kpiName; 
                for (ScoringCalcWrapper sc : toBeUpdatedScoringCalculation.get(kpiIds))
                {
                    sc.isError = false;
                    
                    scoreScoringCalculationMap.put(sc.spesc.Score__c, sc);
                }
                
                for (ScoringCalcWrapper sc : toBeUpdatedScoringCalculation.get(kpiIds))
                {
                    kpiName = sc.kpiName;
                    
                    system.debug('###### Lower ('+sc.spesc.Lower__c+')  '+'Upper ('+sc.spesc.Lower__c+')  '+'Lower To'+'('+sc.spesc.LowerTo__c+')');
                    if (sc.spesc.Lower__c == null || sc.spesc.Upper__c == null || sc.spesc.LowerTo__c == null || sc.spesc.UpperTo__c == null)
                    {
                        sc.isError = true;
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, System.Label.SPE_RequiredFields));
                        return false;
                    } 
                    else if ((sc.spesc.LowerTo__c == '==' && sc.spesc.UpperTo__c != '==') || (sc.spesc.UpperTo__c == '==' && sc.spesc.LowerTo__c != '==')) 
                    {
                        sc.isError = true;
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, System.Label.SPE_OperatorValue ));
                        return false;
                    } 
                    else if (sc.spesc.Lower__c >sc.spesc.Upper__c) 
                    {
                        sc.isError = true;
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, System.Label.SPE_GreaterUpperValue));
                        return false;
                    } 
                    else if ((sc.spesc.LowerTo__c == '=='  && sc.spesc.UpperTo__c == '==') && (sc.spesc.Lower__c != sc.spesc.Upper__c)) 
                    {
                        sc.isError = true;
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, System.Label.SPE_FillOperator));
                        return false;
                    }
        
                    KPIRangeWrapper kpiWr = new KPIRangeWrapper(sc.spesc);
                    kpiRangeWrapperList.add (kpiWr);
                }
                system.debug('kpiRangeWrapperList ::'+kpiRangeWrapperList[0].sc);
                Decimal min = findMinKPIValues(kpiRangeWrapperList);
                Decimal max = findMaxKPIValues(kpiRangeWrapperList);
                system.debug('min ::'+min);
                system.debug('max ::'+max);
                
                Set<Decimal> lowerValues = new Set<Decimal>();
                Set<Decimal> upperValues = new Set<Decimal>();
                
                
                Boolean isValid = false;
                integer i = 0;
                if(isHighBetterNew){
                    if(kpiRangeWrapperList[0].lowerValue == min && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue == max){
                       
                        for (KPIRangeWrapper kw: kpiRangeWrapperList)
            {
              if (max == kw.upperValue)
              {
                integer k = 0;
                for (KPIRangeWrapper kw2: kpiRangeWrapperList)
                {
                    if (kw.score != kw2.score && kw.upperValue == kw2.lowerValue && !kw.upperOperator.contains('='))
                    {
                        i++;
                        system.debug(kw.score+'*********in If******************'+kw2.score+'*******'+i+'*******');
                        
                    }
                    
                    else if (kw.score != kw2.score && kw.upperValue == kw2.lowerValue && kw.upperOperator.contains('=')) 
                    {
                        system.debug(kw.score+'*********in If Else******************'+kw2.score+'*******'+i+'*******');
                    }
                    
                    else
                    {
                        k++;
                        system.debug('kkkkkkkkkkkkkkk*'+k);
                    }
                }
                
                system.debug('**********last If*****'+k+'Wrapper Size'+kpiRangeWrapperList.size());
                if (kpiRangeWrapperList.size() == k)
                {
                    i++;
                    system.debug('iiiiiiii'+i);
                    continue;
                }
                system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+i+'*******');
                continue;
              }
              
                for (KPIRangeWrapper kw1: kpiRangeWrapperList)
               {
                 if (kw.score != kw1.score && kw.upperValue == kw1.lowerValue && 
                  (kw.upperOperator.contains('=') || kw1.lowerOperator.contains('=')) && 
                  !(kw.upperOperator.contains('=') && kw1.lowerOperator.contains('=')) && !kw.upperOperator.contains('==')
                  )
                 {
                    i ++ ;
                    system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+kw1.lowerOperator+'*******'+i+'*******'+kw1.score);
                   
                 }
                 if (kw.score != kw1.score  && kw.upperOperator.contains('==') && 
                  (kw.upperValue) == kw1.lowerValue && 
                  !kw1.lowerOperator.contains('='))
                  {
                    i ++ ;
                    system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+kw1.lowerOperator+'*******'+i+'*******'+kw1.score);
                    
                  }
                }
            }
                        
                    }
                 /*if(kpiRangeWrapperList.size()==4){
                 if( kpiRangeWrapperList[1].lowerValue==kpiRangeWrapperList[0].upperValue && kpiRangeWrapperList[2].lowerValue==kpiRangeWrapperList[1].upperValue && kpiRangeWrapperList[3].lowerValue==kpiRangeWrapperList[2].upperValue 
                    && (kpiRangeWrapperList[0].upperOperator=='<='||kpiRangeWrapperList[1].lowerOperator=='>=') && (kpiRangeWrapperList[1].upperOperator=='<='||kpiRangeWrapperList[2].lowerOperator=='>=')
                    && (kpiRangeWrapperList[2].upperOperator=='<='||kpiRangeWrapperList[3].lowerOperator=='>=')){
                    if(kpiRangeWrapperList[0].lowerValue == min && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue == max){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue);
                         system.debug('????'+kpiRangeWrapperList[0].lowerValue);
                        isValid = true;
                    } 
                    
                }
                }
                
                else if(kpiRangeWrapperList.size()==3 )
                {
                if( kpiRangeWrapperList[1].lowerValue==kpiRangeWrapperList[0].upperValue && kpiRangeWrapperList[2].lowerValue==kpiRangeWrapperList[1].upperValue 
                    && (kpiRangeWrapperList[0].upperOperator=='<='||kpiRangeWrapperList[1].lowerOperator=='>=') && (kpiRangeWrapperList[1].upperOperator=='<='||kpiRangeWrapperList[2].lowerOperator=='>=')){
                    if(kpiRangeWrapperList[0].lowerValue == min && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue == max){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue);
                         system.debug('????'+kpiRangeWrapperList[0].lowerValue);
                        isValid = true; 
                    } 
                    
                }
                }
                
                else if(kpiRangeWrapperList.size()==2 )
                {
                 
                if( kpiRangeWrapperList[1].lowerValue==kpiRangeWrapperList[0].upperValue && (kpiRangeWrapperList[0].upperOperator=='<='||kpiRangeWrapperList[1].lowerOperator=='>=')){
                    if(kpiRangeWrapperList[0].lowerValue == min && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue == max){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue);
                         system.debug('????'+kpiRangeWrapperList[0].lowerValue);
                        isValid = true;
                    } 
                    
                }
                  
                }
                else{
                if(kpiRangeWrapperList[0].lowerValue == min && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue == max){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].upperValue);
                         system.debug('????'+kpiRangeWrapperList[0].lowerValue);
                        isValid = true;
                    } 
                }*/
     
           }
           if(!isHighBetterNew){
               if(kpiRangeWrapperList[0].upperValue == max && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue == min){
                 
                   for (KPIRangeWrapper kw: kpiRangeWrapperList)
            {
              if (max == kw.upperValue)
              {
                integer k = 0;
                for (KPIRangeWrapper kw2: kpiRangeWrapperList)
                {
                    if (kw.score != kw2.score && kw.upperValue == kw2.lowerValue && !kw.upperOperator.contains('='))
                    {
                        i++;
                        system.debug(kw.score+'*********in If******************'+kw2.score+'*******'+i+'*******');
                        
                    }
                    
                    else if (kw.score != kw2.score && kw.upperValue == kw2.lowerValue && kw.upperOperator.contains('=')) 
                    {
                        system.debug(kw.score+'*********in If Else******************'+kw2.score+'*******'+i+'*******');
                    }
                    
                    else
                    {
                        k++;
                        system.debug('kkkkkkkkkkkkkkk*'+k);
                    }
                }
                
                system.debug('**********last If*****'+k+'Wrapper Size'+kpiRangeWrapperList.size());
                if (kpiRangeWrapperList.size() == k)
                {
                    i++;
                    system.debug('iiiiiiii'+i);
                    continue;
                }
                system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+i+'*******');
                continue;
              }
              
                for (KPIRangeWrapper kw1: kpiRangeWrapperList)
               {
                 if (kw.score != kw1.score && kw.upperValue == kw1.lowerValue && 
                  (kw.upperOperator.contains('=') || kw1.lowerOperator.contains('=')) && 
                  !(kw.upperOperator.contains('=') && kw1.lowerOperator.contains('=')) && !kw.upperOperator.contains('==')
                  )
                 {
                    i ++ ;
                    system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+kw1.lowerOperator+'*******'+i+'*******'+kw1.score);
                   
                 }
                 if (kw.score != kw1.score  && kw.upperOperator.contains('==') && 
                  (kw.upperValue) == kw1.lowerValue && 
                  !kw1.lowerOperator.contains('='))
                  {
                    i ++ ;
                    system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+kw1.lowerOperator+'*******'+i+'*******'+kw1.score);
                    
                  }
                }
            }
                   
               }
             
                /*if(kpiRangeWrapperList.size()==4){
                if( kpiRangeWrapperList[0].lowerValue==kpiRangeWrapperList[1].upperValue && kpiRangeWrapperList[1].lowerValue==kpiRangeWrapperList[2].upperValue && kpiRangeWrapperList[2].lowerValue==kpiRangeWrapperList[3].upperValue 
                    && (kpiRangeWrapperList[0].upperOperator=='<='||kpiRangeWrapperList[1].lowerOperator=='>=') && (kpiRangeWrapperList[1].upperOperator=='<='||kpiRangeWrapperList[2].lowerOperator=='>=')
                    && (kpiRangeWrapperList[2].upperOperator=='<='||kpiRangeWrapperList[3].lowerOperator=='>=')
                     ){
                    if(kpiRangeWrapperList[0].upperValue == max && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue == min){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue);
                        system.debug('????'+kpiRangeWrapperList[0].upperValue);
                        isValid = true;
                    } 
                    }
                    }
                    else if(kpiRangeWrapperList.size()==3)
                    {
                    if( kpiRangeWrapperList[0].lowerValue==kpiRangeWrapperList[1].upperValue && kpiRangeWrapperList[1].lowerValue==kpiRangeWrapperList[2].upperValue 
                       && (kpiRangeWrapperList[0].upperOperator=='<='||kpiRangeWrapperList[1].lowerOperator=='>=') && (kpiRangeWrapperList[1].upperOperator=='<='||kpiRangeWrapperList[2].lowerOperator=='>=')){
                    if(kpiRangeWrapperList[0].upperValue == max && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue == min){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue);
                        system.debug('????'+kpiRangeWrapperList[0].upperValue);
                        isValid = true;
                    }
                    }
                    }
                    else if(kpiRangeWrapperList.size()==2 )
                    {
                     
                    if( kpiRangeWrapperList[0].lowerValue==kpiRangeWrapperList[1].upperValue  && (kpiRangeWrapperList[0].upperOperator=='<='||kpiRangeWrapperList[1].lowerOperator=='>=')){
                    if(kpiRangeWrapperList[0].upperValue == max && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue == min ){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue);
                        system.debug('????'+kpiRangeWrapperList[0].upperValue);
                        isValid = true;
                    }
                    
                    }
                    }
                    else
                    {
                    if(kpiRangeWrapperList[0].upperValue == max && kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue == min){
                        system.debug('::'+kpiRangeWrapperList[kpiRangeWrapperList.size() - 1].lowerValue);
                        system.debug('????'+kpiRangeWrapperList[0].upperValue);
                        isValid = true;
                    }
                    }*/
                    
                }
               
               /*if (!isValid){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, System.Label.SPE_HighBetterFlag +':'+kpiName));
                    return false; 
                }
               
                if(isValid){
                    
                    for (KPIRangeWrapper kw: kpiRangeWrapperList)
                    {
                      if (max == kw.upperValue)
                      {
                        integer k = 0;
                        for (KPIRangeWrapper kw2: kpiRangeWrapperList)
                        {
                        
                            if (kw.score != kw2.score && kw.upperValue == kw2.lowerValue && !kw.upperOperator.contains('=') )
                            {
                                i++;
                                system.debug(kw.score+'*********in If******************'+kw2.score+'*******'+i+'*******');
                                
                            }
                            
                            else if (kw.score != kw2.score && kw.upperValue == kw2.lowerValue && kw.upperOperator.contains('=')) 
                            {
                                system.debug(kw.score+'*********in If Else******************'+kw2.score+'*******'+i+'*******');
                            }
                            
                            else
                            {
                                k++;
                                system.debug('kkkkkkkkkkkkkkk*'+k);
                            }
                        }
                      
                        system.debug('**********last If*****'+k+'Wrapper Size'+kpiRangeWrapperList.size());
                        if (kpiRangeWrapperList.size() == k)
                        {
                            i++;
                            system.debug('iiiiiiii'+i);
                            continue;
                        }
                        system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+i+'*******');
                        continue;
                      }
                      
                        for (KPIRangeWrapper kw1: kpiRangeWrapperList)
                       {
                         
                         if (kw.score != kw1.score && kw.upperValue == kw1.lowerValue && 
                          (kw.upperOperator.contains('=') || kw1.lowerOperator.contains('=')) && 
                          !(kw.upperOperator.contains('=') && kw1.lowerOperator.contains('=')) && !kw.upperOperator.contains('==')
                          )
                         {
                            i ++ ;
                            system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+kw1.lowerOperator+'*******'+i+'*******'+kw1.score);
                           
                         }
                         if (kw.score != kw1.score  && kw.upperOperator.contains('==') && 
                          (kw.upperValue) == kw1.lowerValue && 
                          !kw1.lowerOperator.contains('='))
                          {
                            i ++ ;
                            system.debug(kw.score+'***************************'+kw.upperOperator+'*******'+kw1.lowerOperator+'*******'+i+'*******'+kw1.score);
                            
                          }
                        }
                    }
                }*/
            
                system.debug('*************Last Validation'+i);
                if (kpiRangeWrapperList.size() == i)
                {
                  isValid = true;
                }
                
              if (!isValid)
              {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, System.Label.SPE_ThresholdValues + kpiName));
                return false; 
              }
        }
            
        isCorrect= true ;
        return true;
        }

    public class ScoringCalcWrapper{
        public Decimal score;
        public String ScoreName{get;set;}       
        public SPE_ScoringCalculation__c spesc{get;set;}   
        public String concatenatevalues {get;set;}
        public String kpiName {get;set;}  
        public Boolean isError {get;set;}
        public ScoringCalcWrapper(SPE_ScoringCalculation__c sc,String name)        
        {
            this.concatenatevalues ='and';
            this.ScoreName = 'Score ' + sc.score__c+ ' For KPI Values';
            this.score = sc.score__c;
            this.spesc=sc;
            kpiName= name;
            isError = false;
        }
    }
    
    public class KPIRangeWrapper{
        public Decimal score;
        public Decimal lowerValue;
        public Decimal upperValue;
        public String lowerOperator;
        public String upperOperator;
        public SPE_ScoringCalculation__c sc{get;set;}  
        public KPIRangeWrapper (SPE_ScoringCalculation__c sc)
        {
            this.score = sc.score__c;
            this.lowerValue = sc.Lower__c;
            this.upperValue = sc.Upper__c; 
            this.lowerOperator = sc.LowerTo__c;
            this.upperOperator = sc.UpperTo__c;
            this.sc=sc;          
        }
    }
    
    private Decimal findMaxKPIValues(List<KPIRangeWrapper> kpiRangeWrapperList){
        Decimal larger = -9999999999.99;
        for (KPIRangeWrapper wr : kpiRangeWrapperList)
        {
            larger = math.max(larger, wr.upperValue);
        }
        
        return larger;
    }
    
    private Decimal findMinKPIValues(List<KPIRangeWrapper> kpiRangeWrapperList){
        Decimal smaller = 9999999999.99;
        for (KPIRangeWrapper wr : kpiRangeWrapperList)
        {
            smaller = math.min(smaller, wr.lowerValue);
        }
       
        return smaller;
    }  
  
}