public class SPE_NewScoringTemplateExt
{   
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
    private Id stId;
    private Integer i ;
    private ApexPages.StandardController controller;
    public Boolean isCorrect { get ; set ; }
    private Boolean isNew;
    public string titleValue{ get ; set ;}
    public SPE_ScoringTemplate__c scoringTemplate { get ; set ; }
    public SPE_SPETemplate__c speTemplate {get; set;}
    public Map < Id, List <ScoringCalcuationWrapper>> toBeUpdatedScoringCalculation { get ; set ; }
    
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
    Id idScoringTempId;
    SPE_ScoringTemplate__c scoringTemplateCloned;
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails  {get;set;}
    public boolean pilot{get;set;}
    public boolean published{get;set;}
    public boolean obsolete{get;set;}
    public boolean del{get;set;}
    public boolean delval{get;set;}
    public boolean IsAccess{get;set;}
    Public Id RecordId{get;set;}
    public Map<String, Schema.SObjectField> M{get;set;}
    public string stage{get;set;}
    public String SobjectName{get;set;}
    public boolean isSuccess{get;set;}
    public String msg{get;set;}
    public Sobject CurrRecord{get;set;}
    public boolean Proceed{get;set;}
    public List<SPE_ScoringTemplate__c> speScoringList;
    
    public Boolean isNotDraft{get;set;}
        
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
   
    public List<PicklistDefaultValues__c> defalultPicklist
    {
        get
        {
            return PicklistDefaultValues__c.getall().values();
        }
    } 
    public SPE_NewScoringTemplateExt(ApexPages.StandardController controller) 
    {   
    
       published=true;
       pilot=true;
       obsolete=true;
       del=true;
       delval=true;
       Proceed=false;
       isSuccess=false;
       isNotDraft = true;
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
        system.debug('enter constructor here');
        this.controller = controller;
        
        if(controller.getId() == null)
        {
            scoringTemplate = new SPE_ScoringTemplate__c ();
            scoringTemplate.SPETemplate__c = ApexPages.currentPage().getParameters().get('speTempId');
            isNew = true;           
            scoringTemplate.Stage__c = 'Draft';
        }
        else
        {    
            CurrentUserId = UserInfo.getUserId();
            RecordOwnerId = [Select Id, ownerId from SPE_ScoringTemplate__c 
                           WHERE Id =: controller.getId() ].ownerId;
            scoringTemplate = [SELECT Name, BusinessLine__c,Stage__c,ScoringTemplateCode__c, Region__c,Organization_Group__c, BusinessUnit__c, SubRegion__c, Project__c, Product__c, Product1__c, Product2__c, Product3__c, 
                                      Country__c, SPETemplate__c, SPEKPIMap__c, KPIDefinitionName__c, CategoryCluster__c, CategoryGroup__c, Category__c, CreatedById
                               FROM SPE_ScoringTemplate__c 
                               WHERE Id =:  controller.getId()];
            if(Apexpages.currentPage().getParameters().get('isClone')!= null)
                scoringTemplate.Stage__c = 'Draft';
             system.debug('testtest' + scoringTemplate);                   
            isNew = false;
            idScoringTempId = controller.getId();
            
            if(scoringTemplate.Stage__c == 'Draft'){
               isNotDraft = false; 
            }
            
            IsAccess=[SELECT recordId,HasEditAccess FROM UserRecordAccess WHERE UserId =:UserInfo.getUserId() AND RecordId =:controller.getid()].HasEditAccess ; 
            SobjectName=(Id.valueOf(controller.getid()).getSObjectType().getDescribe().getName());
            if(IsAccess) {
                map<String,String> n= new Map<string,string>();   
                Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();  
                Map<String, Schema.SObjectField> M = (gd.get(Id.valueOf(controller.getid()).getSObjectType().getDescribe().getName())).getDescribe().fields.getMap();
                   for (Schema.SObjectField field : m.values())
                    {
                        n.put(field.getDescribe().getLabel(), field.getDescribe().getName());
                        
                    }
                  RecordId = Id.valueOf(controller.getId());
                  stage=n.get('Stage');
                  String query='select id,'+stage+' from '+SobjectName+' where id=: RecordId '; 
                  currRecord=database.query(query);
                  
             
                  if(currRecord.get(stage)=='Draft') {
                  pilot=false;
                  del=false;
                  
                  }
                  
                  
                  if(currRecord.get(stage) =='Pilot') {
                  Published=false;
                  obsolete=false;
                  delval=false;
                  //isNotDraft = true;
                  }
                  
                  if(currRecord.get(stage)=='Published') {
                  Obsolete=false;
                  //isNotDraft = true;
                  }
                  
                      
            }
        }
        if(scoringTemplate.SPETemplate__c !=null){
            speTemplate =[SELECT Id, CategoryCluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Region__c, SubRegion__c, 
                             Country__c, Project__c, Product__c, Product1__c, Product2__c, Product3__c 
                          FROM SPE_SPETemplate__c 
                          WHERE Id =: scoringTemplate.SPETemplate__c];
        }
        if (isNew)
        {
            /*SPE_MathsUtil.market1 = speTemplate.Region__c;
            SPE_MathsUtil.bu1 = speTemplate.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = speTemplate.SubRegion__c;
            SPE_MathsUtil.bl1 = speTemplate.BusinessLine__c;
            SPE_MathsUtil.country1 = speTemplate.Country__c;
            SPE_MathsUtil.prd1 = speTemplate.Product__c;
            SPE_MathsUtil.project1 = speTemplate.Project__c;
            SPE_MathsUtil.ca1 = speTemplate.CategoryCluster__c;
            SPE_MathsUtil.cg1 = speTemplate.CategoryGroup__c;
            SPE_MathsUtil.ct1 = speTemplate.Category__c;*/
            //----------------Code for Custom picklist starts------------------------
            if(scoringTemplate.SPETemplate__c != null){
            marketVal = speTemplate.Region__c != null && speTemplate.Region__c != '' ? speTemplate.Region__c : '';
            marketUnitVal = speTemplate.SubRegion__c != null && speTemplate.SubRegion__c != '' ? speTemplate.SubRegion__c : '';
            countryVal = speTemplate.Country__c != null && speTemplate.Country__c != '' ? speTemplate.Country__c : '';
            projectVal = speTemplate.Project__c != null && speTemplate.Project__c != '' ? speTemplate.Project__c : '';
            
            buVal = speTemplate.BusinessUnit__c != null && speTemplate.BusinessUnit__c != '' ? speTemplate.BusinessUnit__c : '';
            blVal = speTemplate.BusinessLine__c != null && speTemplate.BusinessLine__c != '' ? speTemplate.BusinessLine__c : '';
            prdVal = speTemplate.Product__c != null && speTemplate.Product__c != '' ? speTemplate.Product__c : '';
            
            caVal = speTemplate.CategoryCluster__c != null && speTemplate.CategoryCluster__c != '' ? speTemplate.CategoryCluster__c : '';
            cgVal = speTemplate.CategoryGroup__c != null && speTemplate.CategoryGroup__c != '' ? speTemplate.CategoryGroup__c : '';
            ctVal = speTemplate.Category__c != null && speTemplate.Category__c != '' ? speTemplate.Category__c : '';
            
            //----------------Code for Custom picklist Ends------------------------ 
            AdddefaultValues();
           }
           else{
                marketVal = SPE_Constants.ALL_GEOSCOPE;
                marketUnitVal =SPE_Constants.ALL_GEOSCOPE_UNIT;
                countryVal =SPE_Constants.ALL_Country;
                projectVal =SPE_Constants.ALL_Project;
                caVal =SPE_Constants.ALL_CATSCOPE_AREA ;
                cgVal =SPE_Constants.ALL_CATSCOPE_GROUP ;
                ctVal =SPE_Constants.ALL_CATSCOPE;
                buVal =SPE_Constants.ALL_BU_BUSCOPE;
                blVal =SPE_Constants.ALL_BL_BUSCOPE;
                prdVal =SPE_Constants.ALL_BUSCOPE;   
            }
        }
        else
        {
            /*SPE_MathsUtil.market1 = scoringTemplate.Region__c;
            SPE_MathsUtil.bu1 = scoringTemplate.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = scoringTemplate.SubRegion__c;
            SPE_MathsUtil.bl1 = scoringTemplate.BusinessLine__c;
            SPE_MathsUtil.country1 = scoringTemplate.Country__c;
            SPE_MathsUtil.prd1 = scoringTemplate.Product__c;
            SPE_MathsUtil.project1 = scoringTemplate.Project__c;
            SPE_MathsUtil.ca1 = scoringTemplate.CategoryCluster__c;
            SPE_MathsUtil.cg1 = scoringTemplate.CategoryGroup__c;
            SPE_MathsUtil.ct1 = scoringTemplate.Category__c;*/
            
            //----------------Code for Custom picklist starts------------------------
            marketVal = scoringTemplate.Region__c != null && scoringTemplate.Region__c != '' ? scoringTemplate.Region__c : '';
            marketUnitVal = scoringTemplate.SubRegion__c != null && scoringTemplate.SubRegion__c != '' ? scoringTemplate.SubRegion__c : '';
            countryVal = scoringTemplate.Country__c != null && scoringTemplate.Country__c != '' ? scoringTemplate.Country__c : '';
            projectVal = scoringTemplate.Project__c != null && scoringTemplate.Project__c != '' ? scoringTemplate.Project__c : '';
            
            buVal = scoringTemplate.BusinessUnit__c != null && scoringTemplate.BusinessUnit__c != '' ? scoringTemplate.BusinessUnit__c : '';
            blVal = scoringTemplate.BusinessLine__c != null && scoringTemplate.BusinessLine__c != '' ? scoringTemplate.BusinessLine__c : '';
            prdVal = scoringTemplate.Product__c != null && scoringTemplate.Product__c != '' ? scoringTemplate.Product__c : '';
            
            caVal = scoringTemplate.CategoryCluster__c != null && scoringTemplate.CategoryCluster__c != '' ? scoringTemplate.CategoryCluster__c : '';
            cgVal = scoringTemplate.CategoryGroup__c != null && scoringTemplate.CategoryGroup__c != '' ? scoringTemplate.CategoryGroup__c : '';
            ctVal = scoringTemplate.Category__c != null && scoringTemplate.Category__c != '' ? scoringTemplate.Category__c : '';
            
            //----------------Code for Custom picklist Ends------------------------
        }
        
        toBeUpdatedScoringCalculation = new Map < Id, List < ScoringCalcuationWrapper> >();
        if(scoringTemplate.SPETemplate__c != null){
         addInitialData();
        }
        titleValue=System.Label.SPE_HighKPIValue+ System.Label.SPE_LowPerfScore + System.Label.SPE_Threshold ;
        isCorrect = false ;
       //  showProdVals();
    }
      //------ Method for Populate Attribute Values starts here---
    public void populateAllValues(){
        system.debug('enter here');
        if(scoringTemplate.SPETemplate__c !=null){
            SPE_SPETemplate__c selectedTemplate = [SELECT Id,GeoScope__c,Categoryscope__c,BUScope__c 
                                                   FROM SPE_SPETemplate__c WHERE Id =: scoringTemplate.SPETemplate__c];           
            toBeUpdatedScoringCalculation = new Map < Id, List < ScoringCalcuationWrapper> >();
            addInitialData();
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Please select an SPE Template'));
        }
    }
    //------ Method for Populate Attribute Values ends here---
    
    public void StagePilot() {
       
       try {     
       currRecord.put(stage,'Pilot');
       update currRecord;
        isSuccess =true;
        isNotDraft = true;
       }
       catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               isSuccess = false;
               system.debug('**********'+msg);
           }
    }
    
    public pagereference StagePublished() {
        if(SobjectName=='SPE_ScoringTemplate__c') {
           system.debug('******SobjectName'+SobjectName);
           String query='select id,SPETemplate__c,'+stage+' from '+SobjectName+' where id=: RecordId '; 
           currRecord=database.query(query);
           if(currRecord.get('SPETemplate__c')!=Null) {
               Id Id=String.valueOf(currRecord.get('SPETemplate__c'));    
               if([select Stage__c from SPE_SPETemplate__c where id=:Id].Stage__c=='Published')
                   Proceed=true;
           }
          system.debug('******Proceed'+Proceed);
        if(Proceed) {
          try{ 
               currRecord.put(stage,'Published');
               update currRecord;
               isSuccess=true;
               isNotDraft = true;
               return null;
               system.debug('******isSuccess'+isSuccess);
           } 
            
           catch(Exception ex){
               msg= ex.getMessage();
               list<string> s=msg.split(':');
               msg=s[1];
               isSuccess = false;
               system.debug('**********'+msg);
               return null;
           }
        }
       }
        return null;
    }
    
    public void StageObsolete() {
        if(SobjectName=='SPE_ScoringTemplate__c') 
       {    
           speScoringList = new List<SPE_ScoringTemplate__c>();
           for(SPE_ScoringTemplate__c speScoring: [select id,Stage__c from SPE_ScoringTemplate__c where id=: RecordId AND ( Stage__c='Published' OR Stage__c='Pilot')])
           {
               speScoringList.add(speScoring);
               system.debug('----speScoringList---->' + speScoringList.size());
           }
           
           if(speScoringList.size()> 0)
           {
         
                        proceed=true;
                        try{ 
                           currRecord.put(stage,'obsolete');
                           update currRecord;
                           isSuccess=true;
                           isNotDraft = true;
                       } 
                        
                       catch(Exception ex){
                           msg= ex.getMessage();
                           list<string> s=msg.split(':');
                           msg=s[1];
                           isSuccess = false;
                           
                       }
                   
           }
           
           
       }
    
    }
    
    
    public void StageDelete() {
    
       
       Delete currRecord;
    
    
    }
    
    public void executeTestBatch(){
        Id processId = Database.executeBatch(new SPE_DeleteTestDataBatch(RecordId), 200);
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
    
    private void addInitialData ()
    {
        //****************Chages For Encryption*****************//
        List<SPE_SPEKPIMap__c> spekpidef =[SELECT ID, KPIDefinition__c, 

KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, KPIDefinition__r.Level__c 
                                           FROM SPE_SPEKPIMap__c 
                                           WHERE SPETemplate__c=:scoringTemplate.SPETemplate__c];
        //****************END*****************//
        
        //*********Extra Code Added For Encryption*******************//
        Set<Id> kpiIds = new Set<Id>();
        
        for (SPE_SPEKPIMap__c speKpi : spekpidef )
        {
            kpiIds.add(speKpi.KPIDefinition__c);
        }
        
        Map<Id, SPE_KPIDefinition__c> kpiDefinitionMap = new Map<Id, SPE_KPIDefinition__c>([SELECT KPI_Title__c FROM 
                                                                                            SPE_KPIDefinition__c WHERE ID IN : kpiIds]);
        
        //***************************End***********************************//
                                           
        for(SPE_SPEKPIMap__c  spekpi : spekpidef )
        {
                String str= spekpi.KPIDefinition__r.Level__c;
                List<String> split = str.Split(';');
            
            if (isNew)
            {
                for (String s: split)
                { 
                    SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
                    sc.Score__c =  Integer.valueOf(s);
                    sc.KPIDefinition__c = spekpi.KPIDefinition__c;
                    
                    //****************Chages For Encryption*****************//
                    //ScoringCalcuationWrapper scw = new ScoringCalcuationWrapper (sc, spekpi.KPIDefinition__r.Name);
                    ScoringCalcuationWrapper scw = new ScoringCalcuationWrapper (sc, kpiDefinitionMap.get(spekpi.KPIDefinition__c), spekpi.KPIDefinition__r.KPI_Title__c);
                    //****************END*****************//
                    
                    List<ScoringCalcuationWrapper> scoringCalcuationWrapperList = new List<ScoringCalcuationWrapper>();  
                    
                    if (toBeUpdatedScoringCalculation.get(sc.KPIDefinition__c) != null )
                    {
                        scoringCalcuationWrapperList = toBeUpdatedScoringCalculation.get(sc.KPIDefinition__c);
                    }    
                          
                    scoringCalcuationWrapperList.add(scw);
                    toBeUpdatedScoringCalculation.put(sc.KPIDefinition__c ,scoringCalcuationWrapperList);
                }
            }
            else
            {
                //****************Chages For Encryption*****************//
                List <SPE_ScoringCalculation__c> scoringCals = [SELECT Lower__c, LowerTo__c, Upper__c, UpperTo__c, 
                                                                KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, Score__c 
                                                                FROM SPE_ScoringCalculation__c 
                                                                WHERE KPIDefinition__c =: spekpi.KPIDefinition__c AND 
                                                                ScoringTemplate__c=: scoringTemplate.Id];
                //****************END*****************//
            
                if (scoringCals.isEmpty())
                {
                    for (String s: split)
                    { 
                        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
                        sc.Score__c =  Integer.valueOf(s);
                        sc.KPIDefinition__c = spekpi.KPIDefinition__c;
                        
                        //****************Chages For Encryption*****************//
                        //ScoringCalcuationWrapper scw = new ScoringCalcuationWrapper (sc, spekpi.KPIDefinition__r.Name);
                        ScoringCalcuationWrapper scw = new ScoringCalcuationWrapper (sc, kpiDefinitionMap.get(spekpi.KPIDefinition__c), spekpi.KPIDefinition__r.KPI_Title__c);
                        //****************END*****************//
                        
                        List<ScoringCalcuationWrapper> scoringCalcuationWrapperList = new List<ScoringCalcuationWrapper>();  
                        
                        if (toBeUpdatedScoringCalculation.get(sc.KPIDefinition__c) != null )
                        {
                            scoringCalcuationWrapperList = toBeUpdatedScoringCalculation.get(sc.KPIDefinition__c);
                        }    
                              
                        scoringCalcuationWrapperList.add(scw);
                        toBeUpdatedScoringCalculation.put(sc.KPIDefinition__c ,scoringCalcuationWrapperList);
                    }   
                }   
                else
                {           
                    for (SPE_ScoringCalculation__c sc: scoringCals)
                    {
                        //****************Chages For Encryption*****************//
                        //ScoringCalcuationWrapper scw = new ScoringCalcuationWrapper (sc, sc.KPIDefinition__r.Name);
                        ScoringCalcuationWrapper scw = new ScoringCalcuationWrapper (sc, kpiDefinitionMap.get(spekpi.KPIDefinition__c), sc.KPIDefinition__r.KPI_Title__c);
                        //****************END*****************//
                        
                        List<ScoringCalcuationWrapper> scoringCalcuationWrapperList = new List<ScoringCalcuationWrapper>();
                        
                        if (toBeUpdatedScoringCalculation.get(sc.KPIDefinition__c) != null )
                        {
                            scoringCalcuationWrapperList = toBeUpdatedScoringCalculation.get(sc.KPIDefinition__c);
                        }    
                                  
                        scoringCalcuationWrapperList.add(scw);
                        toBeUpdatedScoringCalculation.put(sc.KPIDefinition__c ,scoringCalcuationWrapperList);
                    }
                }
            }
        }
       
    }
    
    public pagereference cloneFn(){
        
        pagereference pg = new pagereference('/apex/SPE_NewScoringTemplate?id='+idScoringTempId+'&isClone=true');
        return pg;
    }    
    public PageReference save() 
    {
        PageReference pg;
        if (checkValidation() == true && duplicatecheck() == false)
        {      
            scoringTemplate.Region__c = marketVal != null ? marketVal : speTemplate.Region__c;
            scoringTemplate.BusinessUnit__c = buVal != null ? buVal : speTemplate.BusinessUnit__c;
            scoringTemplate.SubRegion__c = marketUnitVal != null ? marketUnitVal : speTemplate.SubRegion__c;
            scoringTemplate.BusinessLine__c = blVal != null ? blVal: speTemplate.BusinessLine__c;
            scoringTemplate.Country__c = countryVal != null ? countryVal : speTemplate.Country__c;
            scoringTemplate.Product__c = prdVal != null? prdVal : speTemplate.Product__c;
            scoringTemplate.Project__c = projectVal != null ? projectVal: speTemplate.Project__c;
            scoringTemplate.CategoryCluster__c = caVal != null ? caVal : speTemplate.CategoryCluster__c;
            scoringTemplate.CategoryGroup__c = cgVal != null ? cgVal : speTemplate.CategoryGroup__c;
            scoringTemplate.Category__c = ctVal != null ? ctVal : speTemplate.Category__c;
            try{
            if(Apexpages.currentPage().getParameters().get('isClone')!= null){
                scoringTemplateCloned = scoringTemplate.clone(false,true,false,false);
                if(scoringTemplateCloned != null)
                insert scoringTemplateCloned;
            }
            else{
                upsert  scoringTemplate;
            }
            }
            catch(Exception e){
            ApexPages.addmessages(e);
            }
            List < SPE_ScoringCalculation__c > listsc = new List  < SPE_ScoringCalculation__c > ( );
            List <SPE_ScoringCalculation__c> listscCloned = new List  < SPE_ScoringCalculation__c > ( );
            for ( List <ScoringCalcuationWrapper> LOLsc: toBeUpdatedScoringCalculation.values() ) 
            {   
                for( ScoringCalcuationWrapper sc :LoLsc)
                {
                    SPE_ScoringCalculation__c scNew = new SPE_ScoringCalculation__c();
                    
                    if(Apexpages.currentPage().getParameters().get('isClone')!= null){
                        scNew = sc.spesc.clone(false,true,false,false) ;
                        scNew.ScoringTemplate__c = scoringTemplateCloned.Id;
                    }
                    else{
                        scNew = sc.spesc ;
                        scNew.ScoringTemplate__c = scoringTemplate.Id;
                    }
                    listsc.add (scNew) ;
                    listscCloned.add(scNew);
                }
            }
            
            if(Apexpages.currentPage().getParameters().get('isClone')!= null){
                if(! listscCloned.isEmpty())
                    insert listscCloned;
                pg = new PageReference('/'+ scoringTemplateCloned.SPETemplate__c );
                return pg;
            }
            else{
                upsert listsc;
                pg = new PageReference('/'+ scoringTemplate.SPETemplate__c );
                return pg;
            }
            
        }
        return null;
    }
        
    public PageReference cancel()
    {      
       Schema.DescribeSObjectResult r = SPE_ScoringTemplate__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        system.debug('keyPrefix ::'+keyPrefix);      
        Pagereference pr;   
        if(scoringTemplate.id == null || scoringTemplate.id != null){        
              if(scoringTemplate.SPETemplate__c != null){
                  try{
                      pr =new Pagereference('/'+speTemplate.Id);
                  }catch(exception e){
                       pr =new Pagereference('/'+keyPrefix);
                  }
              } 
              else{
                  pr =new Pagereference('/'+keyPrefix);
              }                          
        }         
      return pr;
          
    }
        
    public void validate()
    {
        if (checkValidation() == true)
        {
        }
    }
            
    public pageReference edi()
    {
        pageReference pg = controller.edit();
        return pg;
    }
    
    public  Boolean checkValidation () 
    {
        isCorrect = false ;
        Map <Id, Set <Integer> > rangeMap= new Map  <Id, Set <Integer> >();
        
        
        
        for (Id kpiIds : toBeUpdatedScoringCalculation.keySet())
        {   
            set <Integer> rangeSet = new set  <Integer>  ();
            
            List<KPIRangeWrapper> kpiRangeWrapperList = new List<KPIRangeWrapper>();
            
            Map <Decimal, ScoringCalcuationWrapper>  scoreScoringCalculationMap = new Map <Decimal, ScoringCalcuationWrapper>();
             
            String kpiName; 
            for (ScoringCalcuationWrapper sc : toBeUpdatedScoringCalculation.get(kpiIds))
            {
                sc.isError = false;
                
                scoreScoringCalculationMap.put(sc.spesc.Score__c, sc);
            }
            
            for (ScoringCalcuationWrapper sc : toBeUpdatedScoringCalculation.get(kpiIds))
            {
                kpiName = sc.kpiName;
                
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
            
            Decimal min = findMinKPIValues(kpiRangeWrapperList);
            Decimal max = findMaxKPIValues(kpiRangeWrapperList);
            
            Set<Decimal> lowerValues = new Set<Decimal>();
            Set<Decimal> upperValues = new Set<Decimal>();
            
            Boolean isValid = false;
            integer i = 0;
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
  
    //******************Code is commented as part of encryption *********************// 
    /*public class ScoringCalcuationWrapper
    {
        public SPE_ScoringCalculation__c spesc {get;set;} 
        public String kpiName {get;set;} 
        public Boolean isError {get;set;}
        public ScoringCalcuationWrapper (SPE_ScoringCalculation__c sc, String name)
        {
            spesc = sc;
            kpiName = name;
            isError = false;
        }
    }*/
    //*************************************************End*****************************************************//
    
    //************************New Code is Added as part of encryption************************************//
    public class ScoringCalcuationWrapper
    {
        public SPE_ScoringCalculation__c spesc {get;set;}
        public SPE_KPIDefinition__c kpiDef{get;set;}
        public String kpiName {get;set;} 
        public Boolean isError {get;set;}
        public ScoringCalcuationWrapper (SPE_ScoringCalculation__c sc, SPE_KPIDefinition__c kpiDef, String name)
        {
            spesc = sc;
            this.kpiDef = kpiDef;
            kpiName = name;
            isError = false;
        }
    }
    
    //************************************End*******************************************************//
    
    public class KPIRangeWrapper
    {
        public Decimal score;
        public Decimal lowerValue;
        public Decimal upperValue;
        public String lowerOperator;
        public String upperOperator;
        
        public KPIRangeWrapper (SPE_ScoringCalculation__c sc)
        {
            this.score = sc.score__c;
            
            this.lowerValue = sc.Lower__c;
            this.upperValue = sc.Upper__c;
            
            this.lowerOperator = sc.LowerTo__c;
            this.upperOperator = sc.UpperTo__c;
        }
    }
    
    private Decimal findMaxKPIValues (List<KPIRangeWrapper> kpiRangeWrapperList)
    {
        Decimal larger = -9999999999.99;
        for (KPIRangeWrapper wr : kpiRangeWrapperList)
        {
            larger = math.max(larger, wr.upperValue);
        }
        
        return larger;
    }
    
    private Decimal findMinKPIValues (List<KPIRangeWrapper> kpiRangeWrapperList)
    {
        Decimal smaller = 9999999999.99;
        for (KPIRangeWrapper wr : kpiRangeWrapperList)
        {
            smaller = math.min(smaller, wr.lowerValue);
        }
       
        return smaller;
    }
    
    private boolean duplicatecheck()
    {   
        Boolean isDuplicate = false;
   
        if(scoringTemplate.SPETemplate__c!=null)
        {
            
            List<SPE_ScoringTemplate__c> ScotempList=new List<SPE_ScoringTemplate__c>();
            ScotempList = [SELECT id,name,CategoryCluster__c,Region__c,SubRegion__c,CategoryGroup__c,Category__c,Country__c,BusinessUnit__c,Project__c,BusinessLine__c,Product__c
                                                       FROM SPE_ScoringTemplate__c 
                                                       WHERE SPETemplate__c = :scoringTemplate.SPETemplate__c];
          
            
            for(SPE_ScoringTemplate__c oldScoringTemp : ScotempList)
            {
             
                
                if (oldScoringTemp.Id != scoringTemplate.Id && 
                    (oldScoringTemp.CategoryCluster__c == caVal && oldScoringTemp.CategoryGroup__c == cgVal
                    && oldScoringTemp.Category__c == ctVal && oldScoringTemp.Region__c == marketVal
                    && oldScoringTemp.SubRegion__c == marketUnitVal && oldScoringTemp.Country__c == countryVal
                    && oldScoringTemp.Project__c == projectVal && oldScoringTemp.BusinessUnit__c == buVal
                    && oldScoringTemp.BusinessLine__c == blVal && oldScoringTemp.Product__c == prdVal
                    || oldScoringTemp.Name == scoringTemplate.Name))
                 {
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.SPE_SameScope));
                    //return null;
                 }
                 else
                 {
                     //isDuplicate = false;
                 }
             }
       
        }
        
        return isDuplicate;    
    }
    
    public void AdddefaultValues ()
    {
        
        caVal = caVal!=null ? caVal : speTemplate.CategoryCluster__c;
        scoringTemplate.Region__c = scoringTemplate.Region__c !=null ? scoringTemplate.Region__c : speTemplate.Region__c;
        scoringTemplate.CategoryGroup__c = scoringTemplate.CategoryGroup__c != null ? scoringTemplate.CategoryGroup__c : speTemplate.CategoryGroup__c;
        scoringTemplate.SubRegion__c = scoringTemplate.SubRegion__c !=null ? scoringTemplate.SubRegion__c : speTemplate.SubRegion__c;
        scoringTemplate.Category__c = scoringTemplate.Category__c !=null ? scoringTemplate.Category__c : speTemplate.Category__c;
        scoringTemplate.Country__c = scoringTemplate.Country__c !=null ? scoringTemplate.Country__c : speTemplate.Country__c;
        scoringTemplate.BusinessUnit__c = scoringTemplate.BusinessUnit__c  !=null ? scoringTemplate.BusinessUnit__c : speTemplate.BusinessUnit__c;
        scoringTemplate.Project__c = scoringTemplate.Project__c !=null ? scoringTemplate.Project__c : speTemplate.Project__c;
        scoringTemplate.BusinessLine__c = scoringTemplate.BusinessLine__c !=null ? scoringTemplate.BusinessLine__c : speTemplate.BusinessLine__c;
        scoringTemplate.Product__c = scoringTemplate.Product__c !=null ? scoringTemplate.Product__c : speTemplate.Product__c;
        scoringTemplate.Product1__c = scoringTemplate.Product1__c !=null ? scoringTemplate.Product1__c : speTemplate.Product1__c;
        scoringTemplate.Product2__c = scoringTemplate.Product2__c !=null ? scoringTemplate.Product2__c : speTemplate.Product2__c;
        scoringTemplate.Product3__c = scoringTemplate.Product3__c !=null ? scoringTemplate.Product3__c : speTemplate.Product3__c; 
    }
     
    public Boolean getIsScopeMatch()
    {   
        if(scoringTemplate.id !=null){
            if (marketVal != speTemplate.Region__c || marketUnitVal != speTemplate.SubRegion__c || countryVal != speTemplate.Country__c || projectVal != speTemplate.Project__c ||
                buVal != speTemplate.BusinessUnit__c || blVal != speTemplate.BusinessLine__c || prdVal != speTemplate.Product__c ||
                caVal != speTemplate.CategoryCluster__c || cgVal != speTemplate.CategoryGroup__c || ctVal != speTemplate.Category__c)
                {
                    return false;
                }
       }    
        return true;
    }
    public PageReference GoToBulkSPEPlan(){
        PageReference pf = new PageReference('/apex/SPE2_BulkPlanCreate?scoringtempId='+scoringTemplate.id);
        return pf;
    }
       
}