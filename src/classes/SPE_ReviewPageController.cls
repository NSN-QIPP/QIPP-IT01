public with sharing class SPE_ReviewPageController {
 
  
    private String soql {get;set;}
    public List<SelectOption> tickeOptions{get; set;}
    public List<SelectOption> allTickeOptions{get; set;}
    public String allTicketType{get; set;}
    public List<SPE_TrackerValues__c> speTrackerValues{get;set;}
    public string planStage = 'Published';
    public string trackerStatus = 'Completed';
    public list<TrackerWrapper> trackerWrapperList {get; set;} 
    public list<TrackerValueWrapper> trackerValueWrapperList {get; set;}
    public list<SPE_TrackerValues__c> trackerWrapperListRequested {get; set;}
    public list<CreatedCMDetailWrapper> processesCMDetails{get; set;} 
    public list<FailedCMDetailWrapper> FailedCMDetailWrapperList{get; set;} 
    public Date startDate {get;set;}
    public Date endDate {get;set;}
    public Integer minNumber {get;set;}
    public Integer maxNumber {get;set;}
    
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
    
    
    //**************************************Line Added For Encryption******************************//  
    public String kpiName{get;set;}
    public String supplierName {get;set;}
    public String speTrackerName {get;set;}
    //**************************************END******************************//  
    
    @Testvisible private map<ID,SPE_TrackerValues__c> selectedTrackerValuesMap;
    public SPE_SPEPLan__c plan {get;set;}
    TrackerWrapper tw;
  
    public String sortDir
    {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
    
    public String sortField
    {
      //**************************************Changes For Encryption******************************//  
        //get  { if (sortField == null) {sortField = 'KPIDefinition__r.Name'; } return sortField;  }
        get  { if (sortField == null) {sortField = 'KPIDefinition__c'; } return sortField;  }
      //**************************************END******************************//  
        set;
    }
    
    public SPE_ReviewPageController()
    {
        selectedTrackerValuesMap = new map<ID,SPE_TrackerValues__c>();
        trackerWrapperListRequested = new list<SPE_TrackerValues__c>(); 
        plan = new SPE_spePlan__c();
        plan.StartDate__c = system.Today().addmonths(-3);
        plan.EndDate__c =  system.Today();
        processesCMDetails= new List<CreatedCMDetailWrapper>();
        FailedCMDetailWrapperList = new List<FailedCMDetailWrapper>();
        minNumber = 0;
        maxNumber = 3;
        startDate = plan.StartDate__c;
        endDate = plan.EndDate__c ;
        
        //----------------Code for Custom picklist starts------------------------
        //--------------remove the separator ~Market,~BusinessUnit,~Category-----
        
        lstTemp = new Set<String>();
        setMarkets = new Set<String>();
        setBusinessUnits = new Set<String>();
        setCategoryArea = new Set<String>();
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
        
        marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
        buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
        caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
        
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
        
     //***************************Changes For Encryption*****************************//   
        soql = 'select KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, Supplier__c, Supplier__r.Name, KPIDefinition__r.Cluster__c, SPETracker__r.DateOfExecution__c,SPETracker__r.Status__c,SPETracker__r.SPEPlan__r.Name,SPETracker__r.SPEPlan__r.Stage__c,Score1__c,Value__c, SPETracker__r.Name, SPETracker__r.Region__c, SPETracker__r.SubRegion__c,SPETracker__r.Country__c,SPETracker__r.Project__c,SPETracker__r.CategoryCluster__c,SPETracker__r.CategoryGroup__c,SPETracker__r.Category__c,SPETracker__r.BusinessUnit__c,SPETracker__r.BusinessLine__c,SPETracker__r.Product__c from SPE_TrackerValues__c  where SPETracker__r.Name != null and SPETracker__r.SPEPlan__r.Stage__c =: planStage and SPETracker__r.Status__c =: trackerStatus and Supplier__c != null ';
     //***************************END*****************************//
       
        soql += ' and SPETracker__r.DateOfExecution__c >=: startDate';
        soql += ' and SPETracker__r.DateOfExecution__c <= : endDate ';
        soql += ' and Score1__c >= : minNumber';
        soql += ' and Score1__c <= : maxNumber';
    }
 
  
    public void toggleSort()
    {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        runQuery();
    }
 
    public void runQuery()
    {
        if (apexpages.currentpage().getparameters().get('trackerId') != null)
        {
         
            //***************************Changes For Encryption*****************************//    
            trackerWrapperListRequested = [SELECT KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, KPIDefinition__r.Cluster__c, Supplier__c, SPETracker__r.DateOfExecution__c,SPETracker__r.Status__c,
                                                  SPETracker__r.SPEPlan__r.Name,SPETracker__r.SPEPlan__r.Stage__c,Score1__c,Value__c, 
                                                  SPETracker__r.Name, SPETracker__r.Region__c, SPETracker__r.SubRegion__c,SPETracker__r.Country__c,
                                                  SPETracker__r.Project__c,SPETracker__r.CategoryCluster__c,SPETracker__r.CategoryGroup__c,
                                                  SPETracker__r.Category__c,SPETracker__r.BusinessUnit__c,SPETracker__r.BusinessLine__c,
                                                  SPETracker__r.Product__c,Supplier__r.Name from SPE_TrackerValues__c 
                                           WHERE  SPETracker__r.Id =: Apexpages.currentpage().getparameters().get('trackerId')];
                                               
            //***************************END*****************************//
        }
        
        try
        {
            speTrackerValues = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' NULLS LAST limit 10000');
            
          //***************************Changes For Encryption*****************************//
            List<SPE_TrackerValues__c> newTrackerValue = new List<SPE_TrackerValues__c>();
            
            Integer count = 0;
            for (SPE_TrackerValues__c tv : speTrackerValues)
            {
                if (!kpiName.equals('') || !supplierName.equals(''))
                {
                    
                    if(tv.KPIDefinition__r.KPI_Title__c != Null)
                    {
                        String skpi = tv.KPIDefinition__r.KPI_Title__c;
                        String supplier = tv.Supplier__r.Name;
                        Pattern MyKPIPattern = Pattern.compile('(?i)\\A^'+kpiName); 
                        Pattern MySupplierPattern = Pattern.compile('(?i)\\A^'+supplierName);
                        
                        Matcher MyKPIMatcher = MyKPIPattern.matcher(skpi);
                        Matcher MySupplierMatcher = MySupplierPattern.matcher(supplier);
                        
                        if (MyKPIMatcher.find() && MySupplierMatcher.find())
                        {
                            count ++; 
                            
                            if (count  > 1000)
                            {
                                break;
                            }
                            newTrackerValue.add(tv);
                        }
                    }
                }
                else
                {
                    newTrackerValue.add(tv);
                }
            }
            CustomIterable(newTrackerValue); 
            
        //***************************END*****************************//    
        } 
        catch (Exception e) {
          System.debug('Exception :::::'+e);
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No Record Available with your search Criteria!'));
        }
    
    }
    
    private void CustomIterable(List<SPE_TrackerValues__c> sQuery){
    
       trackerWrapperList = new list<TrackerWrapper>();
       boolean hasSelectedTrackerValue = ((trackerWrapperListRequested == null || trackerWrapperListRequested.isEmpty()) ? false : true);
       for(SPE_TrackerValues__c tv : sQuery)
       {          
           if(hasSelectedTrackerValue)
                    {
                        if(selectedTrackerValuesMap.containsKey(tv.ID))
                            {
                                tw = new TrackerWrapper(true, tv);
                            }
                        else
                            {
                                tw = new TrackerWrapper(false, tv);
                            }
                    }
                else
                    {
                        tw = new TrackerWrapper(false, tv);   
                    }
                    
           trackerWrapperList.add(tw);
       } 
       
   }
   
    public PageReference getSelected()
    {
        trackerWrapperListRequested.clear();
        
        for(TrackerWrapper trWrapper : trackerWrapperList)
        if(trWrapper.isSelected){
            selectedTrackerValuesMap.put(trWrapper.stv.ID,trWrapper.stv);
        }
        trackerWrapperListRequested.addAll(selectedTrackerValuesMap.values());
        return null;
    }
    
    public List<SPE_TrackerValues__c> getSelectedTracker()
    {
        if(trackerWrapperListRequested.size()>0)
        return trackerWrapperListRequested;
        else
        return null;
    }
    public void blankMethod(){
        
    }
    public PageReference runSearch() 
    {
        String speTracker = speTrackerName;
        startDate = plan.StartDate__c != null ? plan.StartDate__c : startDate;
        endDate = plan.EndDate__c != null ? plan.EndDate__c : endDate;
        
        //***************************Changes For Encryption*****************************//   
        soql = 'SELECT KPIDefinition__c, KPIDefinition__r.Name, KPIDefinition__r.KPI_Title__c, KPIDefinition__r.Cluster__c, Supplier__c, Supplier__r.Name, SPETracker__c, SPETracker__r.Status__c, SPETracker__r.DateOfExecution__c,SPETracker__r.SPEPlan__r.Name,SPETracker__r.SPEPlan__r.Stage__c,Score1__c,Value__c, SPETracker__r.Name, SPETracker__r.Region__c, SPETracker__r.SubRegion__c,SPETracker__r.Country__c,SPETracker__r.Project__c,SPETracker__r.CategoryCluster__c,SPETracker__r.CategoryGroup__c,SPETracker__r.Category__c,SPETracker__r.BusinessUnit__c,SPETracker__r.BusinessLine__c,SPETracker__r.Product__c from SPE_TrackerValues__c where SPETracker__r.Name != null and SPETracker__r.SPEPlan__r.Stage__c =: planStage and SPETracker__r.Status__c =: trackerStatus and Supplier__c != null ';
        //***************************END*****************************//
      
        if (!speTracker.equals(''))
          soql += ' and SPETracker__r.Name LIKE \''+String.escapeSingleQuotes(speTracker)+'%\'';
        if (!marketVal.equals('') && !marketVal.equals('All Markets'))
          soql += ' and SPETracker__r.Region__c LIKE \''+String.escapeSingleQuotes(marketVal)+'%\'';
        if (!marketUnitVal.equals('') && !marketUnitVal.equals('All Market Units'))
          soql += ' and SPETracker__r.SubRegion__c LIKE \''+String.escapeSingleQuotes(marketUnitVal)+'%\'';
        if (!countryVal.equals('') && !countryVal.equals('All Countries'))
          soql += ' and SPETracker__r.Country__c LIKE \''+String.escapeSingleQuotes(countryVal)+'%\'';  
        if (!projectVal.equals('') && !projectVal.equals('All Projects'))
          soql += ' and SPETracker__r.Project__c LIKE \''+String.escapeSingleQuotes(projectVal)+'%\'';   
        if (!caVal.equals('') && !caVal.equals('All Category Areas'))
          soql += ' and SPETracker__r.CategoryCluster__c LIKE \''+String.escapeSingleQuotes(caVal)+'%\'';
        if (!cgVal.equals('') && !cgVal.equals('All Category Groups'))
          soql += ' and SPETracker__r.CategoryGroup__c LIKE \''+String.escapeSingleQuotes(cgVal)+'%\'';  
        if (!ctVal.equals('') && !ctVal.equals('All Categories'))
          soql += ' and SPETracker__r.Category__c LIKE \''+String.escapeSingleQuotes(ctVal)+'%\'';  
        if (!buVal.equals('') && !buVal.equals('All Business Units'))
          soql += ' and SPETracker__r.BusinessUnit__c LIKE \''+String.escapeSingleQuotes(buVal)+'%\'';
        if (!blVal.equals('') && !blVal.equals('All Business Lines'))
          soql += ' and SPETracker__r.BusinessLine__c LIKE \''+String.escapeSingleQuotes(blVal)+'%\'';  
        if (!prdVal.equals('') && !prdVal.equals('All Products'))
          soql += ' and SPETracker__r.Product__c LIKE \''+String.escapeSingleQuotes(prdVal)+'%\'';
          soql += ' and SPETracker__r.DateOfExecution__c >=: startDate';
          soql += ' and SPETracker__r.DateOfExecution__c <= : endDate ';
          soql += ' and Score1__c >=: minNumber';
          soql += ' and Score1__c <=: maxNumber';
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
    
    public PageReference next()
    {
        cmReview();
        PageReference pg = new PageReference('/apex/SPE_CMReviewLanding');
        return pg;
    }
    
    public void cmReview()
    {
      SelectOption s0 = new SelectOption ('None', '-None-');
      SelectOption s2 = new SelectOption ('Develop', 'Develop');
      SelectOption s3 = new SelectOption ('Phase Out', 'Phase-Out');
      SelectOption s4 = new SelectOption ('Watchlist', 'Watchlist');
      tickeOptions = new List<SelectOption>{s0, s3, s4, s2};
      allTickeOptions = new List<SelectOption>{s0, s2, s3, s4};
      
      trackerValueWrapperList = new List<TrackerValueWrapper>();
  
      for (SPE_TrackerValues__c trV : trackerWrapperListRequested)
      {
        TrackerValueWrapper tvw = new TrackerValueWrapper();
    
        tvw.tv = trV;
        
      //*******************************Changes For Encryption*****************************//  
        tvw.pastTrackerValues = [SELECT KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, KPIDefinition__r.Cluster__c, SPETracker__r.DateOfExecution__c, Score1__c, Value__c, SPETracker__r.Name, Supplier__r.Name
                 FROM SPE_TrackerValues__c 
                 WHERE SPETracker__r.SPEPlan__C =: trV.SPETracker__r.SPEPlan__c AND 
                     Supplier__c =: trV.Supplier__c AND
                     SPETracker__r.DateOfExecution__c < :  trV.SPETracker__r.DateOfExecution__c
                 ORDER BY SPETracker__r.DateOfExecution__c DESC LIMIT 6
                 ];
       
        tvw.pastCMTickets = [SELECT Name, KPIName__c,KPIName__r.KPI_Title__c, CurrentStage__c, Type__c, RecordType.Name,TicketStatus__c
               FROM SPE_ConsequenceManagement__c 
               WHERE KPIName__c =: trV.KPIDefinition__c AND
                   Supplier__c =: trV.Supplier__c LIMIT 10] ;
     //*******************************END*****************************//
    
        trackerValueWrapperList.add(tvw);
      }
    }
    
    public PageReference submit()
    {
        List<SPE_ConsequenceManagement__c> cmList = new List<SPE_ConsequenceManagement__c>();
        
        List<CreatedCMDetailWrapper> cmCreatedWrapperTemp = new List<CreatedCMDetailWrapper>();
        
        List<TrackerValueWrapper> trackerValueWrapperListTemp = new List<TrackerValueWrapper>();
        
        boolean isError = false;
        
        Set<Id> createdCM = new Set<Id>();
        Integer i = 0;
        
        for (TrackerValueWrapper tvw : trackerValueWrapperList)
        {
            if (tvw.ticketType != 'None')
            {
                SPE_ConsequenceManagement__c cmObj = new SPE_ConsequenceManagement__c();
                
                List<SPE_ConsequenceManagement__c> consequenceManagementList = new List<SPE_ConsequenceManagement__c>();
            
                id recordTypeId =  [Select id from RecordType where sObjectType = 'SPE_ConsequenceManagement__c' AND Name =: tvw.ticketType].id;
                cmObj.Title__c = tvw.cmTitle;
                cmObj.RecordTypeId = recordTypeId;
                cmObj.TicketStatus__c = 'Draft';
                cmObj.Organization_Group__c = tvw.tv.KPIDefinition__r.Cluster__c;
                cmObj.Market__c = tvw.tv.SPETracker__r.Region__c;
                cmObj.MarketUnit__c = tvw.tv.SPETracker__r.SubRegion__c;
                cmObj.Country__c = tvw.tv.SPETracker__r.Country__c;
                cmObj.Project__c = tvw.tv.SPETracker__r.Project__c;
                cmObj.BusinessUnit__c = tvw.tv.SPETracker__r.BusinessUnit__c;
                cmObj.BusinessLine__c = tvw.tv.SPETracker__r.BusinessLine__c;
                cmObj.Product__c = tvw.tv.SPETracker__r.Product__c; 
                cmObj.CategoryArea__c = tvw.tv.SPETracker__r.CategoryCluster__c;
                cmObj.CategoryGroup__c = tvw.tv.SPETracker__r.CategoryGroup__c;
                cmObj.Category__c = tvw.tv.SPETracker__r.Category__c;
                cmObj.KPIName__c = tvw.tv.KPIDefinition__c;
                cmObj.Supplier__c = tvw.tv.Supplier__c;
                cmObj.SPETracker__c = tvw.tv.SPETracker__c;
                cmObj.Duplicate_Checker__c = cmObj.KPIName__c + '-' + cmObj.Supplier__c + '-' + cmObj.SPETracker__c + '-' + recordTypeId;
                consequenceManagementList = [SELECT Id, Name
                                     FROM SPE_ConsequenceManagement__c WHERE KPIName__c = :cmObj.KPIName__c AND Supplier__c =: cmObj.Supplier__c  AND (SPETracker__c = null OR SPETracker__c =:cmObj.SPETracker__c)
                                     AND id !=: cmObj.id AND Market__c=:cmObj.Market__c AND MarketUnit__c=:cmObj.MarketUnit__c AND Country__c =: cmObj.Country__c
                                     AND Project__c =: cmObj.Project__c AND CategoryArea__c =: cmObj.CategoryArea__c AND CategoryCluster__c =: cmObj.CategoryCluster__c
                                     AND BusinessUnit__c =: cmObj.BusinessUnit__c AND BusinessLine__c =: cmObj.BusinessLine__c AND Product__c =: cmObj.Product__c AND RecordTypeId =: cmObj.RecordTypeId];
                
                if(consequenceManagementList.size()>0)
                {
                    FailedCMDetailWrapper cmFailedWrapper = new FailedCMDetailWrapper();
                    cmFailedWrapper.tv  = trackerValueWrapperList.get(i).tv;
                    cmFailedWrapper.errorMessage = 'There is already an identical SPE Tracker, Please use the same :';
                    cmFailedWrapper.dupCMName = consequenceManagementList[0].Name;
                    cmFailedWrapper.dupCMID = consequenceManagementList[0].Id;
                    FailedCMDetailWrapperList.add(cmFailedWrapper);
                }
                else
                {
                    cmList.add(cmObj);
                }
            }
            else
            {
                trackerValueWrapperListTemp.add(tvw);
            }
            
        }
        
        Database.SaveResult[] srList = Database.insert(cmList, false);
        
        for (Database.SaveResult sr : srList) 
        {
            
            if (sr.isSuccess()) 
            {
                createdCM.add(sr.getId());
                CreatedCMDetailWrapper cmWrapperTemp = new CreatedCMDetailWrapper ();
                cmWrapperTemp.tv  = trackerValueWrapperList.get(i).tv;
                cmWrapperTemp.CMID= sr.getId();
                cmCreatedWrapperTemp.add(cmWrapperTemp);
                
            }
            
            else 
            {
                FailedCMDetailWrapper cmFailedWrapper = new FailedCMDetailWrapper();
                for (Database.Error err : sr.getErrors()) 
                {
                    cmFailedWrapper.tv  = trackerValueWrapperList.get(i).tv;
                    cmFailedWrapper.errorMessage = err.getMessage();
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                    
                    FailedCMDetailWrapperList.add(cmFailedWrapper);
                }
            }
            i++;
        }
        
        Map<Id, SPE_ConsequenceManagement__c> cmCMIdMap = new Map<Id, SPE_ConsequenceManagement__c>([SELECT ID, Name,RecordType.Name,Title__c FROM SPE_ConsequenceManagement__c WHERE ID IN : createdCM]);
        
        for (CreatedCMDetailWrapper cm : cmCreatedWrapperTemp)
        {
            
            CreatedCMDetailWrapper cmWrapperTemp = new CreatedCMDetailWrapper ();
            cmWrapperTemp.cm = cmCMIdMap.get(cm.CMID);
            cmWrapperTemp.tv= cm.tv;
            processesCMDetails.add(cmWrapperTemp);
        }
        
        trackerValueWrapperList.clear();
        trackerValueWrapperList.addAll(trackerValueWrapperListTemp);
        
        return null;
    }
    
    public PageReference selectAll()
    {
        for (TrackerValueWrapper tw : trackerValueWrapperList )
        {
            tw.ticketType = allTicketType;
        }
        return null;
    }
    
    //----------------Code for Custom picklist starts------------------------
  
   //-----------------Fetch dropdown values of Market-------------
  
    public List<SelectOption> getMarketValues() {
        List<SelectOption> options = new List<SelectOption>();
        if(!setMarkets.contains(PicklistDefaultValues__c.getall().values()[0].Market__c)){
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market__c,PicklistDefaultValues__c.getall().values()[0].Market__c));
        }
        for(String s : setMarkets){
            options.add(new SelectOption(s,s));
        }
        
        return options;
    }
   
    //------- Fetch dropdown values of Market Unit ---------------
    
    public List<SelectOption> getMarketUnitValues(){   
        fillMarketUnit();
        return mkoptions    ;
    }
    
    public void fillMarketUnit(){
        if(Apexpages.currentPage().getParameters().get('marketVal')!= null){
            marketVal = Apexpages.currentPage().getParameters().get('marketVal');
       }
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            
            setMUVal = mapHierarchyDetails1.get(marketVal);
            if(!setMUVal.contains(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c))
            mkoptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,PicklistDefaultValues__c.getall().values()[0].Market_Unit__c));
            for(String s : mapHierarchyDetails1.get(marketVal)){
                mkoptions.add(new SelectOption(s,s));
            }
    }
    //----------------Fetch Dropdown Values for Country -----------------
        
    public List<SelectOption> getCountryValues(){   
        fillCountry();
        return countryOptions;
    }
        
    public void fillCountry(){
        if(Apexpages.currentPage().getParameters().get('marketUnitVal')!= null)
            
            marketUnitVal = Apexpages.currentPage().getParameters().get('marketUnitVal');
            countryOptions = new List<SelectOption>();
            
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal))){
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
            }
            else if(marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal);
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Country__c)){
                    countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
                }
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
            
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || 
                (marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c) || 
                (countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c) || 
                !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal+countryVal)) ){
                    
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
        
            else if(countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal);
                 if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Project__c)){
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
                 }
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal)){
                    projectOptions.add(new SelectOption(s,s));
                }
            }
            else{
                projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
        
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
             if(!setBUVal.contains(PicklistDefaultValues__c.getall().values()[0].Business_Line__c)){
                BusinessLineOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Line__c,PicklistDefaultValues__c.getall().values()[0].Business_Line__c));
             }
       
            for(String s : mapHierarchyDetails1.get(buVal)){
                BusinessLineOptions.add(new SelectOption(s,s));
            }
        
    }
    //----------------Fetch dropdown values for Product------------------------------
    
    public List<SelectOption> getProductValues(){   
        fillProduct();
        return ProductOptions;
    }
        
    public void showProdVals(){
        fillProduct();
    }
        
    public void fillProduct(){
        
        if(Apexpages.currentPage().getParameters().get('blVal')!= null)
            blVal= Apexpages.currentPage().getParameters().get('blVal');
            ProductOptions= new List<SelectOption>();
            lstTemp = new Set<String>();
            Set<String> setProductVal = new Set<String>();
            setProductVal = mapHierarchyDetails1.get(buVal+blVal);
            
             if((buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) || !(mapHierarchyDetails1.containsKey(buVal+blVal))){
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
        if(Apexpages.currentPage().getParameters().get('caVal')!= null){
            blVal= Apexpages.currentPage().getParameters().get('caVal');
        }
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            if(!setCatGroupVal .contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c)){
                CatGroupOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Group__c,PicklistDefaultValues__c.getall().values()[0].Category_Group__c));
            }
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
             blVal= Apexpages.currentPage().getParameters().get('cgVal');
            CategoryOptions= new List<SelectOption>();
            Set<String> setCatVal = new Set<String>();
            setCatVal = mapHierarchyDetails1.get(caVal+cgVal);
            if((caVal== PicklistDefaultValues__c.getall().values()[0].Category_Area__c) || !(mapHierarchyDetails1.containsKey(caVal+cgVal))){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
            }
            
            else  if(!setCatVal .contains(PicklistDefaultValues__c.getall().values()[0].Category__c)){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
                for(String s : mapHierarchyDetails1.get(caVal+cgVal)){
                    CategoryOptions.add(new SelectOption(s,s));
                }
            }
            else{
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
            }
        
    }    
 //----------------Code for Custom picklist ends------------------------
 //----------------Start Check Duplication ---------------------------
    
    public Class TrackerWrapper
    {
        public boolean isSelected {get;set;}
        public SPE_TrackerValues__c stv {get;set;}
        
        public TrackerWrapper(boolean isSelected, SPE_TrackerValues__c stv)
        {
            this.isSelected = isSelected;
            this.stv = stv;
        }
    }
    
    public Class TrackerValueWrapper
    {
        public String ticketType {get;set;}
        public transient String cmTitle {get;set;}
        public SPE_TrackerValues__c tv {get;set;}
        public List<SPE_TrackerValues__c> pastTrackerValues {get;set;}
        public List<SPE_ConsequenceManagement__c> pastCMTickets {get;set;}
  
    }
    
    public Class CreatedCMDetailWrapper
    {
        public Id CMID{get;set;}
        public SPE_TrackerValues__c tv {get;set;}
        public SPE_ConsequenceManagement__c cm{get;set;}
    }
    
    public Class FailedCMDetailWrapper
    {
        public String errorMessage{get;set;}
        public SPE_TrackerValues__c tv {get;set;}
        public SPE_ConsequenceManagement__c cm{get;set;}
        public String dupCMName{get;set;}
        public String dupCMID{get;set;}
    }
}