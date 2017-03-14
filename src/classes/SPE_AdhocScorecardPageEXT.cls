public with sharing class SPE_AdhocScorecardPageEXT{
    
    
    public Date startDate {get;set;}
    
    public Date endDate {get;set;} 
    public SPE_ScorecardTemplate__c scoreCardTemp {get;set;}
    public String scoreCardTempName{get;set;}
    public List<PlanSupplierWrapper> lstWrapper{get;set;}
    integer rowCount;
    public List<SPE_ScorecardSPETemplateMap__c> scorecardSPETemplateMaps {get;set;}
    public Map<Integer,PlanSupplierWrapper> templateMap{get;set;}
    public Map<Integer,SPE_SPEPlanSupplierMap__c> supplierPlanMap{get;set;}
    public List<SPE_SPEPlanSupplierMap__c> lstSPEPlanSuppMap{get;set;}   
    public Set<Id> idSPETemplate = new Set<Id>();
    Map<Id,String> supIdSuppName = new Map<Id,String>();
    public SPE_ScorecardGenerator__c scoreCardgenerator{get;set;}
    public List<SPE_Scorecard_Plan__c> scloreCardPlans{get;set;}
    private String soql {get;set;}
    
    public Boolean selected {get; set;}
    
    public List<SelectOption> tickeOptions{get; set;}
    
    public List<SelectOption> allTickeOptions{get; set;}
    
    public String allTicketType{get; set;}
    
    public List<SPE_SPEPlanSupplierMap__c> speTrackerValues{get;set;}
    public List<SPE_SPEPlanSupplierMap__c> SelectedMap{get;set;}
    public List<SPE_ScorecardSupplierMap__c> scorecardSupplierList{get;set;}
    
    public string planStage = 'Published';
    
    public string trackerStatus = 'Completed';
    
    public list<SPE_TrackerValues__c> trackerVal {get; set;}
    
    public list<SPE_TrackerValues__c> tvList {get; set;} 
    
    //public list<TrackerWrapper> trackerWrapperList {get; set;} 
    
    
    public list<PlanWrapper> PlanWrapperList {get; set;}
    public list<SPE_TrackerValues__c> trackerWrapperListRequested {get; set;}
    
    //**************************************Line Added For Encryption******************************//  
    private String supplierName;
    //**************************************END******************************//  
    
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
   
    
    public Integer minNumber {get;set;}
    
    public Integer maxNumber {get;set;}
    
    @Testvisible private map<ID,SPE_TrackerValues__c> selectedTrackerValuesMap;
    
    public SPE_SPEPLan__c plan {get;set;}
   
    //TrackerWrapper tw;
    String strUID;
    
    public SPE_AdhocScorecardPageEXT(Apexpages.Standardcontroller st)
    {    
        //SPE_ScorecardTemplate__c scoreCardTemp = new SPE_ScorecardTemplate__c();
        selectedTrackerValuesMap = new map<ID,SPE_TrackerValues__c>();
        trackerWrapperListRequested = new list<SPE_TrackerValues__c>(); 
        plan = new SPE_spePlan__c();
        SelectedMap= new list<SPE_SPEPlanSupplierMap__c>();
        //************Line Added In During Encryption Process***************//
        supplierName ='';
        //************END***************//
        soql = 'select Supplier__r.name,Supplier__r.EnterpriseId__c,SPEPlan__r.name,SPEPlan__r.SPETemplate__c,SPEPlan__r.SPETemplate__r.Name from SPE_SPEPlanSupplierMap__c LIMIT 50';
        runQuery();
     
    }
    
    
    
    public PageReference getSelected()
    {    
        SelectedMap.clear();
        
        for(PlanWrapper trWrapper : PlanWrapperList)
        if(trWrapper.isSelected){
        SelectedMap.add(trWrapper.stv );   
        }
        
        return null;
    }
    
         
    public Class PlanWrapper
    {
        public boolean isSelected {get;set;}
        public SPE_SPEPlanSupplierMap__c stv {get;set;}
        
        public PlanWrapper(boolean isSelected, SPE_SPEPlanSupplierMap__c stv)
        {
            this.isSelected = isSelected;
            this.stv = stv;
        }
    }  
 
    public void runQuery()
    {
         speTrackerValues = Database.query(soql);
         system.debug('speTrackerValues---' + speTrackerValues);
         
         //***************************Changes For Encryption*****************************//
            List<SPE_SPEPlanSupplierMap__c> newTrackerValue = new List<SPE_SPEPlanSupplierMap__c>();
             
            for (SPE_SPEPlanSupplierMap__c tv : speTrackerValues)
            {
                if (!supplierName.equals(''))
                {
                    System.debug('supplier====>'+supplierName);
                    
                    if(tv.Supplier__r.Name != Null)
                    {
                        String supplier = tv.Supplier__r.Name;
                        
                        Pattern MySupplierPattern =  Pattern.compile('(?i)\\A^'+supplierName);
                        
                        Matcher MySupplierMatcher = MySupplierPattern.matcher(supplier);
                        
                        if (MySupplierMatcher.find())
                        {
                            System.debug('Matching====>');
                            newTrackerValue.add(tv);
                        }
                    }
                }
                else
                {
                    newTrackerValue.add(tv);
                }
                newTrackerValue.sort();
            }
            CustomIterable(newTrackerValue); 
            
        //***************************END*****************************//
         
    }
    @TestVisible
    private void CustomIterable(List<SPE_SPEPlanSupplierMap__c> sQuery){ 
       PlanWrapperList = new list<PlanWrapper>();
       for(SPE_SPEPlanSupplierMap__c tv : sQuery)
       {
            PlanWrapperList.add(new PlanWrapper(false, tv));
       } 
       
   }
   
    
    public List<SPE_TrackerValues__c> getSelectedTracker()
    {
        if(trackerWrapperListRequested.size()>0)
        return trackerWrapperListRequested;
        else
        return null;
    }
 
    public PageReference runSearch() 
    {
    
        String kpiName = Apexpages.currentPage().getParameters().get('SPEPlanName');
        String speTracker = Apexpages.currentPage().getParameters().get('speTracker');
        
      //**********************************Changes For Encryption***********************//  
        //String supplier = Apexpages.currentPage().getParameters().get('supplier');
        supplierName = Apexpages.currentPage().getParameters().get('supplier');
      //**********************************END***********************//
        
        String market = Apexpages.currentPage().getParameters().get('market');
        String marketunit = Apexpages.currentPage().getParameters().get('marketunit');
        String country = Apexpages.currentPage().getParameters().get('country');
        String project = Apexpages.currentPage().getParameters().get('project');
        String categoryarea = Apexpages.currentPage().getParameters().get('categoryarea');
        String categorygrp = Apexpages.currentPage().getParameters().get('categorygrp');
        String category = Apexpages.currentPage().getParameters().get('category');
        String bunit = Apexpages.currentPage().getParameters().get('bunit');
        String bline = Apexpages.currentPage().getParameters().get('bline');
        String product = Apexpages.currentPage().getParameters().get('product');
        startDate = plan.StartDate__c != null ? plan.StartDate__c : startDate;
        endDate = plan.EndDate__c != null ? plan.EndDate__c : endDate;
               
        soql = 'select Supplier__r.name,SPEPlan__r.name,Supplier__r.EnterpriseId__c,SPEPlan__r.SPETemplate__c,SPEPlan__r.SPETemplate__r.name from SPE_SPEPlanSupplierMap__c where name!=Null';
        if (!kpiName.equals(''))
          soql += ' and SPEPlan__r.name LIKE \''+String.escapeSingleQuotes(kpiName)+'%\'';
          
     //*******************Line Commented for Encryption Part************************//      
        /*if (!supplier.equals(''))
          soql += ' and Supplier__r.name LIKE \''+String.escapeSingleQuotes(supplier)+'%\'';*/
     //*******************END************************//
          
        if (!market.equals(''))
          soql += ' and SPEPlan__r.Region__c LIKE \''+String.escapeSingleQuotes(market)+'%\'';
        if (!marketunit.equals(''))
          soql += ' and SPEPlan__r.SubRegion__c LIKE \''+String.escapeSingleQuotes(marketunit)+'%\'';
        if (!country.equals(''))
          soql += ' and SPEPlan__r.Country__c LIKE \''+String.escapeSingleQuotes(country)+'%\'';  
        if (!project.equals(''))
          soql += ' and SPEPlan__r.Project__c LIKE \''+String.escapeSingleQuotes(project)+'%\'';   
        if (!categoryarea.equals(''))
          soql += ' and SPEPlan__r.CategoryCluster__c LIKE \''+String.escapeSingleQuotes(categoryarea)+'%\'';
        if (!categorygrp.equals(''))
          soql += ' and SPEPlan__r.CategoryGroup__c LIKE \''+String.escapeSingleQuotes(categorygrp)+'%\'';  
        if (!category.equals(''))
          soql += ' and SPEPlan__r.Category__c LIKE \''+String.escapeSingleQuotes(category)+'%\'';  
        if (!bunit.equals(''))
          soql += ' and SPEPlan__r.BusinessUnit__c LIKE \''+String.escapeSingleQuotes(bunit)+'%\'';
        if (!bline.equals(''))
          soql += ' and SPEPlan__r.BusinessLine__c LIKE \''+String.escapeSingleQuotes(bline)+'%\'';  
        if (!product.equals(''))
          soql += ' and SPEPlan__r.Product__c LIKE \''+String.escapeSingleQuotes(product)+'%\'';
        if(StartDate!= Null)
           soql += ' and SPEPlan__r.StartDate__c>=:StartDate';
         if(EndDate!= Null)
           soql += ' and SPEPlan__r.EndDate__c<=:StartDate';   
        system.debug('====soql===>' + soql);  
        runQuery();
        
        return null;
    }
    
    public void removeTrackerValue()
    {
        Id tarckerValueId= Apexpages.currentPage().getParameters().get('tarckerValueId');
        
        List <SPE_TrackerValues__c> trackerValues = new List <SPE_TrackerValues__c>();
        trackerValues.addAll(trackerWrapperListRequested);
        
        trackerWrapperListRequested.clear();
        for (SPE_TrackerValues__c tv : trackerValues )
        {
            if (tarckerValueId != tv.Id)
            {
                trackerWrapperListRequested.add(tv);
            }
        }           
        
    }
    
    
    
    /************************************************************
            PAGE 2 METHODS
    *************************************************************/
    public pageReference redirectToSecondPg(){
        fetchData();
        PageReference pg;
         if(ApexPages.currentpage().getURL().contains('adhocView=true') && ApexPages.currentpage().getURL().contains('isNew=false')){
            pg = new PageReference('/apex/SPE_NewScorecardTemplate?adhocview=true&uniqueI=' + strUID+'&id='+ApexPages.currentpage().getParameters().get('id'));
            pg.setRedirect(true);
         }
         else if(ApexPages.currentpage().getURL().contains('adhocView=true') && ApexPages.currentpage().getURL().contains('isNew=true')){
              pg = new PageReference('/apex/SPE_NewScorecardTemplate?adhocview=true&uniqueI='+strUID+'&RecName='+Apexpages.currentPage().getParameters().get('RecName')+'&isNew=true');
              pg.setRedirect(true);
         }
         else{
            pg = new PageReference('/apex/SPE_NewScorecardTemplateAdhoc');
            pg.setRedirect(false);
        }
        return pg;
    }
    
    public void fetchData(){
        lstWrapper = new List<PlanSupplierWrapper>();
        lstSPEPlanSuppMap = new List<SPE_SPEPlanSupplierMap__c>();
        system.debug('The value is -SelectedMap---' + SelectedMap);
        for(SPE_SPEPlanSupplierMap__c p : SelectedMap){
                lstSPEPlanSuppMap.add(p);
        }
        
        system.debug('The value is ----' + lstSPEPlanSuppMap);
        supplierPlanMap = new Map<Integer,SPE_SPEPlanSupplierMap__c>();
        integer rowPln = 0;
        for(SPE_SPEPlanSupplierMap__c sm :lstSPEPlanSuppMap){
            supplierPlanMap.put(rowPln,sm);
            rowPln++;
        }
        for(SPE_SPEPlanSupplierMap__c s : lstSPEPlanSuppMap){
            idSPETemplate.add(s.SPEPlan__r.SPETemplate__c);
            supIdSuppName.put(s.SPEPlan__r.SPETemplate__c,s.SPEPlan__r.SPETemplate__r.Name);
        }
        
        templateMap = new Map<Integer,PlanSupplierWrapper>();
        rowCount = 0;
        for(Id i : idSPETemplate){
            
            SPE_ScorecardSPETemplateMap__c s = new SPE_ScorecardSPETemplateMap__c();
            s.SPETemplate__c = i;
            lstWrapper.add(new PlanSupplierWrapper(s,rowCount,supIdSuppName.get(s.SPETemplate__c),s.SPETemplate__c));
            rowCount++;
        }
        for(PlanSupplierWrapper psw :lstWrapper){
            templateMap.put(psw.rowNum,psw);
        }
        if(ApexPages.currentpage().getURL().contains('adhocView=true') && ApexPages.currentpage().getURL().contains('UID')){
            strUID = ApexPages.currentpage().getParameters().get('UID');
            system.debug('inside adhoc view');
            List<SPE_SPETemplateHolder__c> lsttempHolder = new List<SPE_SPETemplateHolder__c>();
            for(Id i : idSPETemplate){
              SPE_SPETemplateHolder__c tempholder = new SPE_SPETemplateHolder__c();
               tempholder.SPE_Template__c = i;
               tempholder.UniqueIdentifier__c = strUID;
               lsttempHolder.add(tempholder);   
            }
         if(lsttempHolder.size()>0){
            insert lsttempHolder;
         }
         
         
        }
        system.debug('id of spetemplate is'+idSPETemplate);
        
    }
    
    public void removeSupplierPlandata(){
        Integer tempName1 = integer.valueOf(ApexPages.currentPage().getParameters().get('tempId2'));
        supplierPlanMap.remove(tempName1);
        templateMap.clear();
        lstWrapper = new List<PlanSupplierWrapper>();
        Set<Id> setRefreshedTemplateIds = new Set<Id>();
        for(SPE_SPEPlanSupplierMap__c s : supplierPlanMap.values()){
            setRefreshedTemplateIds.add(s.SPEPlan__r.SPETemplate__c);
        }
        
        for(Id i : setRefreshedTemplateIds){
        
            SPE_ScorecardSPETemplateMap__c s = new SPE_ScorecardSPETemplateMap__c();
            s.SPETemplate__c = i;
            lstWrapper.add(new PlanSupplierWrapper(s,rowCount,supIdSuppName.get(s.SPETemplate__c),s.SPETemplate__c));
            rowCount++;
        }
        for(PlanSupplierWrapper psw :lstWrapper){
            templateMap.put(psw.rowNum,psw);
        }
        
    }
    public void removedata(){
        Integer tempName = integer.valueOf(ApexPages.currentPage().getParameters().get('tempId1'));
        templateMap.remove(tempName);
    }
    
        
    
        
    public Pagereference save()
    {
        boolean ret = checkValidation();
        if (checkValidation() == true)
        {   
            try{
                scoreCardTemp = new SPE_ScorecardTemplate__c(Name = scoreCardTempName,isAdhoc__c = true);
                insert scoreCardTemp;
                scoreCardTemp.Stage__c = 'Published';
                update scoreCardTemp;
                System.debug('scoreCardTemp---' + scoreCardTemp);
                List<SPE_ScorecardSPETemplateMap__c> scorecardTempMaps = new List<SPE_ScorecardSPETemplateMap__c>();
                for(PlanSupplierWrapper spe: templateMap.values()){
                    scorecardTempMaps.add(new SPE_ScorecardSPETemplateMap__c
                    (ScorecardTemplate__c = scoreCardTemp.id,Weight__c = spe.objScorecradTempMapRec.Weight__c,SPETemplate__c 
    = spe.templateId));
                    
                }
                system.debug('scorecardTempMaps----' + scorecardTempMaps + '----' + scoreCardTemp.id);
                insert scorecardTempMaps;
                
                System.debug('scorecardSupplierList12-->'+scorecardSupplierList);
                pageReference pf = new pageReference('/apex/SPE_AdhocScorecardGenerator?scoreCardTempId='+scoreCardTemp.id);
                pf.setRedirect(false);
                return pf;
            }
            catch(Exception ex){
                ApexPages.addMessages(ex) ; 
            }
            
            
        }
        return null;
        
    }
    // Adhoc scorecard generator 
    public Pagereference submitAdhocScorecard(){
        scoreCardgenerator = new SPE_ScorecardGenerator__c(isAdhoc__c = true);
        scoreCardgenerator.Stage__c='Draft';
        scoreCardgenerator.AggregationType__c = 'Simple Average';          
        scoreCardgenerator.ScorecardTemplate__c = ApexPages.currentPage().getParameters().get('scoreCardTempId');       
        scorecardSupplierList = new List<SPE_ScorecardSupplierMap__c>();
        scloreCardPlans = new List<SPE_Scorecard_Plan__c>();
        Set<String> supplierIds = new Set<String>();
        Set<String> spePlanIds = new Set<String>();
        for(SPE_SPEPlanSupplierMap__c s : supplierPlanMap.values()){
            supplierIds.add(s.Supplier__c);
            spePlanIds.add(s.SPEPlan__c);
        }
        for(String acc :supplierIds){
            scorecardSupplierList.add(new SPE_ScorecardSupplierMap__c(Supplier__c = acc));    
        }
        scloreCardPlans = new List<SPE_Scorecard_Plan__c>();
        for(String plan :spePlanids){
            scloreCardPlans.add(new SPE_Scorecard_Plan__c(SPE_Plan__c = plan));    
        }
                
        return null;
    }
    public pageReference SaveAdhocScoreCardData(){
        system.debug('marketVal---' + marketVal);
        system.debug('buVal---' + buVal);
        system.debug('marketUnitVal---' + marketUnitVal);
        system.debug('blVal---' + blVal);
        system.debug('countryVal---' + countryVal);
        system.debug('prdVal---' + prdVal);
        system.debug('caVal---' + caVal);
        system.debug('cgVal---' + cgVal);
        system.debug('ctVal---' + ctVal);
        
        scoreCardgenerator.Region__c = marketVal;
        scoreCardgenerator.BusinessUnit__c = buVal;
        scoreCardgenerator.SubRegion__c = marketUnitVal;
        scoreCardgenerator.BusinessLine__c = blVal;
        scoreCardgenerator.Country__c = countryVal;
        scoreCardgenerator.Product__c = prdVal;
        scoreCardgenerator.Project__c = projectVal;
        scoreCardgenerator.CategoryCluster__c = caVal;
        scoreCardgenerator.CategoryGroup__c = cgVal;
        scoreCardgenerator.Category__c = ctVal;
        try{
        insert scoreCardgenerator;
        for(SPE_ScorecardSupplierMap__c sm :scorecardSupplierList){
            sm.ScorecardGenerator__c = scoreCardgenerator.Id;
        }
        for(SPE_Scorecard_Plan__c sp :scloreCardPlans){
            sp.Scorecard_Generator__c = scoreCardgenerator.Id;
        }
        insert scorecardSupplierList;
        insert scloreCardPlans;
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
                                                            ex.getMessage()));
        }
        pageReference pf = new pageReference('/'+scoreCardgenerator.Id);
        return pf;
    }
    public Pagereference cancel()
    {
        Pagereference pr = new Pagereference('/apex/SPE_AdhocScorecardPage');
        pr.setRedirect(true);
        return pr;
            
    }  
    @TestVisible  
    private Boolean checkValidation()
    {
        Decimal total = 0;
        
        Set<Id>  addedSPEs = new Set<Id>();
        system.debug('templateMap  -----'+ templateMap);
        for (PlanSupplierWrapper spe: templateMap.values())
        {   
               
            if (spe.objScorecradTempMapRec.Weight__c == null )
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
                                                            'Weightage Should Always Be Filled with NonZero Value'));
                 return false;
            }

            else
            {
                total = total + spe.objScorecradTempMapRec.Weight__c;
            } 
         }
        
        if ( total != 100 )
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_Weightage));
            return false;
        }   
                       
        return true;
    }
    @TestVisible    
    private List<SPE_ScorecardSPETemplateMap__c> assignScoreCards (SPE_ScorecardTemplate__c scorecardTemp)
    {
        List<SPE_ScorecardSPETemplateMap__c> toBeInsertedScorecardSPETemp = new List<SPE_ScorecardSPETemplateMap__c>();
            
        for (SPE_ScorecardSPETemplateMap__c speScorecardTemp : scorecardSPETemplateMaps)
        {
            speScorecardTemp.ScorecardTemplate__c = scorecardTemp.Id;
            toBeInsertedScorecardSPETemp.add(speScorecardTemp);
        }       
        return toBeInsertedScorecardSPETemp;
    }
     public class PlanSupplierWrapper{
         public SPE_ScorecardSPETemplateMap__c objScorecradTempMapRec{get;set;}
         public integer rowNum{get;set;}
         public String templateName{get;set;}
         public String templateId;
         
         public PlanSupplierWrapper(SPE_ScorecardSPETemplateMap__c objScorecradTempMapRecT,integer rowNumT,String templateNameT,String templateIdT){
             objScorecradTempMapRec = objScorecradTempMapRecT;
             rowNum = rowNumT;
             templateName = templateNameT;
             templateId = templateIdT;
         }
     }
     
     /*******************************************************************************
                 END OF PAGE 2 METHODS
     ***************************************************************************/       
 //----------------Code for Custom picklist ends------------------------
     /*
    public Class TrackerWrapper
    {
        public boolean isSelected {get;set;}
        public SPE_SPEPlanSupplierMap__c stv {get;set;}
        
        public TrackerWrapper(boolean isSelected, SPE_SPEPlanSupplierMap__c stv)
        {
            this.isSelected = isSelected;
            this.stv = stv;
        }
    }
    
   */
}