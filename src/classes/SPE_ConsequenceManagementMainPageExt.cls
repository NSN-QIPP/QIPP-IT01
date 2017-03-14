public class SPE_ConsequenceManagementMainPageExt
{
    public string selectedValue{get;set;}
    public string profileName{get;set;}
    public boolean isEdit{get;set;}
    public SPE_ConsequenceManagement__c cmObj{get;set;}
    private Apexpages.Standardcontroller stdCon;
    public transient  Database.UpsertResult srList;
    public Contact contact {get;set;}

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
    public string speTrackerSelectedVal{get;set;}
    public string kpiFieldVal{get;set;}
    public boolean displayNotifyButton{get;set;}
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
    
    public SPE_ConsequenceManagementMainPageExt(Apexpages.Standardcontroller st)
    {
        
        stdCon = st;
        st.addFields(SPE_SectionUtilityGenerator.getFieldsAPINames());
        this.cmObj= (SPE_ConsequenceManagement__c)st.getRecord(); 
        
        profileName = [SELECT Name From Profile Where Id =: userinfo.getProfileId()][0].Name;
        marketVal = cmObj.Market__c != null ? cmObj.Market__c:PicklistDefaultValues__c.getall().values()[0].Market__c;
        buVal = cmObj.BusinessUnit__c != null ? cmObj.BusinessUnit__c : PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
        caVal = cmObj.CategoryArea__c != null ? cmObj.CategoryArea__c : PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
        
        if (cmObj.Id == null)
        {
            selectedValue = ApexPages.currentPage().getParameters().get('recordTypeId');
            String auditId = [SELECT id from RecordType where Name =: selectedValue].Id;
            cmObj.RecordTypeId = auditId;
            displayNotifyButton = selectedValue.equalsIgnoreCase('Phase out')||selectedValue.equalsIgnoreCase('Audit') ? true :false; 
        }
        else
        {
            selectedValue = [SELECT Name FROM RecordType WHERE Id =: cmObj.RecordTypeId].Name;
            displayNotifyButton = selectedValue.equalsIgnoreCase('Phase out') || selectedValue.equalsIgnoreCase('Audit') ? true :false; 
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
        
    
    	if (Apexpages.currentPage().getParameters().get('isClone') != null)
    	{
    		SPE_ConsequenceManagement__c cm = [SELECT Id, Title__c, RecordTypeId, Supplier__c, Contact__c, CategoryManager__c, KPIName__c, SPETracker__c, SPEPlan__c,
    												Market__c, MarketUnit__c, Country__c, Project__c, CategoryArea__c, CategoryGroup__c, Category__c,
    												BusinessUnit__c, BusinessLine__c, Product__c 
    										  FROM SPE_ConsequenceManagement__c 
    										  WHERE  Id =: Apexpages.currentPage().getParameters().get('isClone')];
    		
    		
    		cmObj.Title__c = cm.Title__c;
    		cmObj.RecordTypeId = cm.RecordTypeId;
    		cmObj.Supplier__c = cm.Supplier__c;
    		cmObj.Contact__c = cm.Contact__c;
    		cmObj.CategoryManager__c = cm.CategoryManager__c;
    		cmObj.KPIName__c = cm.KPIName__c;
    		cmObj.SPETracker__c = cm.SPETracker__c;
    		cmObj.Market__c = cm.Market__c;
    		cmObj.MarketUnit__c = cm.MarketUnit__c;
    		cmObj.Country__c = cm.Country__c;
    		cmObj.Project__c = cm.Project__c;
    		cmObj.CategoryArea__c = cm.CategoryArea__c;
    		cmObj.CategoryGroup__c  = cm.CategoryGroup__c;
    		cmObj.Category__c = cm.Category__c;
    		cmObj.BusinessUnit__c = cm.BusinessUnit__c;
    		cmObj.BusinessLine__c = cm.BusinessLine__c;
    		cmObj.Product__c = cm.Product__c;
    		
    		marketVal = cmObj.Market__c;
            marketUnitVal = cmObj.MarketUnit__c;
            countryVal = cmObj.Country__c;
            projectVal = cmObj.Project__c;
            
            buVal = cmObj.BusinessUnit__c ;
            blVal = cmObj.BusinessLine__c;
            prdVal = cmObj.Product__c;
            
            caVal = cmObj.CategoryArea__c;
            cgVal = cmObj.CategoryGroup__c;
            ctVal = cmObj.Category__c;
        }
    
    }
    
    public Component.Apex.PageBlock getDynamicForm() 
   {
    Set<String> requiredFields = SPE_SectionUtilityGenerator.getRequiredFields();
    Component.Apex.PageBlock outerPageBlock = new Component.Apex.PageBlock();
    outerPageBlock.Id = 'conmgmt';
    for (String secTitle: SPE_SectionUtilityGenerator.getPageSectionValueMap().get(selectedValue))
    {
        Component.Apex.pageBlockSection pbSection = new Component.Apex.pageBlockSection();
        pbSection.title= secTitle ;
        pbSection.Id = secTitle.replaceAll( '\\s+', '').replaceAll('[/&]', '');
        pbSection.collapsible= false;
        pbSection.columns= 2 ;
        map<String,Boolean> fieldsApiMap = SPE_SectionUtilityGenerator.getSectionFieldvalueMap().get(secTitle);
        for (String secField1 : fieldsApiMap.KeySet())
        {
            if ((secField1 != 'BLANK' && !secField1.equalsIgnoreCase('SPETracker__c')) || (secField1 != 'BLANK' && secField1.equalsIgnoreCase('SPETracker__c') && cmObj.SPETracker__c != null))
            {
                String  secField = 'cmObj.' + secField1;
                Boolean isInputField = fieldsApiMap.get(secField1);  
                system.debug('isInputField value@@@@@@@@'+isInputField+'SecField Value**'+secField);
                if(isInputField)
                {
                    Component.Apex.inputField inputField = new Component.Apex.inputField(); 
                    inputField.expressions.value = '{!'+secField+'}' ;
                    inputField.required = requiredFields.contains(secField1);
                    if (secField1.equalsIgnoreCase('KPIName__c')){
                        inputField.id = 'KPIFieldvalue';
                    }
                    if (secField1.equalsIgnoreCase('SPETracker__c')){
                        inputField.id = 'speTrackerFieldValue';
                        inputField.onselect = 'callActionMethod()'; 
                    }
                     system.debug('inputField********'+inputField);
                    pbSection.childComponents.add(inputField);
                }
                else
                {
                    if (!secField1.equalsIgnoreCase('OpenDate__c') || (secField1.equalsIgnoreCase('OpenDate__c') && cmObj.TicketStatus__c != 'Draft' && cmObj.TicketStatus__c !=  null) )
                    {
                        Component.Apex.outputField outputField = new Component.Apex.outputField();
                        outputField.expressions.value = '{!'+secField+'}' ;
                        pbSection.childComponents.add(outputField);
                    }
                }
            }
            else if (secField1 == 'BLANK')
            {
                Component.Apex.inputHidden inputHidden = new Component.Apex.inputHidden();
                string test = 'Title__c';
                inputHidden.expressions.value = '{!'+test+'}' ;
                pbSection.childComponents.add(inputHidden);
            }
        }   
            outerPageBlock.childComponents.add(pbSection); 
    }
    return outerPageBlock;
    }
   
    public void UpdateScopevalues()
    {
        Map<Id,Set<Id>> SpeTemplateKpiIdMap = new map<Id, set<Id>>();
                
        SPE_SPETracker__c selectedSpeTrackerVal = [ select BusinessLine__c,BusinessUnit__c,Category__c,CategoryCluster__c,CategoryGroup__c,Country__c,Region__c,SubRegion__c,Product__c,Project__c,SPETemplate__c
                                                                               From SPE_SPETracker__c where Id=:speTrackerSelectedVal];
        SPE_SPETemplate__c SpeTrackerKpimap = [Select Name, (Select KPIDefinition__c From SPE_KPI_Maps__r) From SPE_SPETemplate__c where id=:selectedSpeTrackerVal.SPETemplate__c]; 
        
        list<SPE_SPEKPIMap__c> spiKpi = SpeTrackerKpimap.SPE_KPI_Maps__r;
        for (SPE_SPEKPIMap__c spi : spiKpi){
            if (!SpeTemplateKpiIdMap.containsKey(SpeTrackerKpimap.id)){
                SpeTemplateKpiIdMap.put(selectedSpeTrackerVal.SPETemplate__c, new set<Id>{spi.KPIDefinition__c});
                }
            else{
                SpeTemplateKpiIdMap.get(SpeTrackerKpimap.id).add(spi.KPIDefinition__c);
            }
        }
        if (SpeTemplateKpiIdMap.get(selectedSpeTrackerVal.SPETemplate__c).contains(kpiFieldVal)){
                marketVal = selectedSpeTrackerVal.Region__c;
                marketUnitVal = selectedSpeTrackerVal.SubRegion__c;
                countryVal = selectedSpeTrackerVal.Country__c;
                projectVal = selectedSpeTrackerVal.Project__c;
                buVal = selectedSpeTrackerVal.BusinessUnit__c;
                blVal = selectedSpeTrackerVal.BusinessLine__c;
                prdVal = selectedSpeTrackerVal.Product__c;
                caVal = selectedSpeTrackerVal.CategoryCluster__c;
                cgVal = selectedSpeTrackerVal.CategoryGroup__c;
                ctVal = selectedSpeTrackerVal.Category__c;
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Fatal,'Please select only those SPETracker for which you have selected KPI'));
        }
    }
    
    
    public boolean doSave(){
        List<SPE_ConsequenceManagement__c> consequenceManagementList=new List<SPE_ConsequenceManagement__c>();
        boolean isError = false;
        if (cmObj.Id == null)
        cmObj.TicketStatus__c = 'Draft';
        cmObj.Market__c = marketVal ;
        cmObj.MarketUnit__c =  marketUnitVal ;
        cmObj.Country__c = countryVal ;
        cmObj.Project__c = projectVal ;
        cmObj.BusinessUnit__c = buVal ;
        cmObj.BusinessLine__c = blVal ;
        cmObj.Product__c = prdVal;
        cmObj.CategoryArea__c = caVal ;
        cmObj.CategoryGroup__c = cgVal ;
        cmObj.Category__c = ctVal ;
        cmObj.Duplicate_Checker__c = cmObj.KPIName__c + '-' + cmObj.Supplier__c + '-' + cmObj.SPETracker__c + '-' + cmObj.RecordTypeId;
        
        consequenceManagementList = [SELECT id,Name,KPIName__c, Supplier__c,TicketStatus__c, CategoryCluster__c,Market__c,MarketUnit__c,
                                        CategoryGroup__c,CategoryArea__c,Country__c,BusinessUnit__c,Project__c,BusinessLine__c,Product__c,
                                        X3DDaysAllowed__c,X4DDaysAllowed__c,X5DDaysAllowed__c
                                     FROM SPE_ConsequenceManagement__c 
                                     WHERE KPIName__c = :cmObj.KPIName__c 
                                     AND Supplier__c =: cmObj.Supplier__c  
                                     AND (SPETracker__c = null OR SPETracker__c =:cmObj.SPETracker__c)
                                     AND id !=: cmObj.id 
                                     AND Market__c=:cmObj.Market__c 
                                     AND MarketUnit__c=:cmObj.MarketUnit__c 
                                     AND Country__c =: cmObj.Country__c
                                     AND Project__c =: cmObj.Project__c 
                                     AND CategoryArea__c =: cmObj.CategoryArea__c 
                                     AND CategoryCluster__c =: cmObj.CategoryCluster__c
                                     AND BusinessUnit__c =: cmObj.BusinessUnit__c 
                                     AND BusinessLine__c =: cmObj.BusinessLine__c 
                                     AND Product__c =: cmObj.Product__c 
                                     AND RecordTypeId =: cmObj.RecordTypeId];
        try
        {
              for(SPE_ConsequenceManagement__c oldCMVal : consequenceManagementList)
              {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,  'There is already an identical SPE Tracker, Please use the same : <a href=\'/' + oldCMVal.id + '\'>Consequence Management ' + oldCMVal.Name + '</a>'));
                 isError = true;
                 return false; 
              }
              if(cmObj != null && isError==false)
              {
                 srList = Database.upsert(cmObj, false); 
                 return true;
              }
        }
        catch(Exception error){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Fatal,error.getMessage()));
            return false;
        }
        return true;
    }
     
    public pagereference save()
    {
        if (doSave())
        {
            if (srList != null && srList.isSuccess()) {
                
                SPE_KPITrendScoreBatchScheduler batch = new SPE_KPITrendScoreBatchScheduler(System.Today() , cmObj.id, true);
                Database.executeBatch(batch , 1);
                
                Pagereference pr = new Pagereference('/'+cmObj.id);
                return pr;
            }
            else{
                list<Database.Error> err = srList.getErrors();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Fatal,err[0].getMessage()));
                return null;
            }
        }
        return null;        
    }
     
    public PageReference saveNotifyTicket(){
        doSave();
        if (srList.isSuccess()) {
            cmObj.TicketStatus__c = 'Open';
            cmObj.ApprovalStatus__c = 'Pending';
            update cmObj;
            Pagereference pr = new Pagereference('/'+cmObj.id);
            pr.setRedirect(true);
            return pr;
        }
        else{
            list<Database.Error> err = srList.getErrors();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Fatal,err[0].getMessage()));
            return null;
        }
    }
     
    public pagereference cancel(){
         
         if (cmObj.Id != null)
         {
              PageReference pageRef = new PageReference('/'+cmObj.Id);
              return pageRef ;
         }
         else
         {
              PageReference pageRef = new PageReference('/apex/SPE_ConsequencesRecordType?retURL=%2Fa1W%2Fo&save_new=1&sfdc.override=1');
              pageRef.setredirect(true);
              return pageRef ;
         }
    }
     
    //----------------Code for Custom picklist starts------------------------
  
   //-----------------Fetch dropdown values of Market-------------
  
    public List<SelectOption> getMarketValues() {
        List<SelectOption> options = new List<SelectOption>();
        system.debug('SetmarketsValues'+setMarkets);
       
        if(!setMarkets.contains(PicklistDefaultValues__c.getall().values()[0].Market__c)){
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market__c,PicklistDefaultValues__c.getall().values()[0].Market__c));
        }
        for(String s : setMarkets){
            options.add(new SelectOption(s,s));
        }
        system.debug('market is'+marketVal);
        
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
            
            system.debug('marketVal----' + marketVal);
            system.debug('mapHierarchyDetails1.get(marketVal)----' + mapHierarchyDetails1);
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
            system.debug('I am here-blVal--' + blVal);
            system.debug('I am here-buVal--' + buVal);
            ProductOptions= new List<SelectOption>();
            lstTemp = new Set<String>();
            Set<String> setProductVal = new Set<String>();
            setProductVal = mapHierarchyDetails1.get(buVal+blVal);
            
             if((buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) || !(mapHierarchyDetails1.containsKey(buVal+blVal))){
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
            system.debug('caVal'+caVal);
            system.debug('setCatGroupVal'+mapHierarchyDetails1.get(caVal));
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
        
    public void blankMethod(){
         if(Apexpages.currentPage().getParameters().get('rerenderForm11')!= null)
            prdVal= Apexpages.currentPage().getParameters().get('rerenderForm11');
     }
 //----------------Code for Custom picklist ends------------------------
 //----------------Start Check Duplication ---------------------------

}