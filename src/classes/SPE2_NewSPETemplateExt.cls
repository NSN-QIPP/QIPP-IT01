public class SPE2_NewSPETemplateExt 
{ 
    public SPE_SPETemplate__c SPETemp {get;set;}
    private SPE_SPETemplate__c SPETempCloned;  
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}
    public string Userid{get;set;}
    public List<SPE_SPEKPIMap__c> SPEKPIMaps{get;set;}
    private List<SPE_SPEKPIMap__c> toBeDeletedSPEKPIMaps = new List<SPE_SPEKPIMap__c>();
    //map<Integer,List<SPE_SPEKPIMap__c>> SPEKPIMapsCloned1 =new map<Integer,List<SPE_SPEKPIMap__c>>();
    List<SPE_SPEKPIMap__c> SPEKPIMapsCloned = new List<SPE_SPEKPIMap__c>();
    public Set<String> lstTemp{get;set;}
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails  {get;set;}
    public ApexPages.StandardController standardController { get; set; }
     
     //------ SPE2 Changes start here-----------
    public Map<Integer,SPE_SPEKPIMap__c> kpiToSpeKPIMap{get;set;}
    public Integer incrementVal{get;set;}
    public Map<String,Integer> geoScopeMap;
    public Map<String,Integer> catScopeMap;
    public Map<String,Integer> prodScopeMap;
    Id SpeTempId;
    public Boolean isNew {get;set;}
    public Boolean isEdit {get;set;}
    public String minGeoScope{get;set;}
    public String minCatScope{get;set;}
    public String minProductScope{get;set;}
    public boolean isGeoScopeMatch{get;set;}
    public boolean isCatScopeMatch{get;set;}
    public boolean isProdScopeMatch{get;set;}
     //------ SPE2 Changes ends here-----------
    
    public SPE2_NewSPETemplateExt(){}
    
    public SPE2_NewSPETemplateExt (Apexpages.Standardcontroller st)
    {    
        this.standardController =st;
        lstTemp = new Set<String>();
        Userid =[Select id,name from user where id =:UserInfo.getUserId()].name;
        toBeDeletedSPEKPIMaps = new List<SPE_SPEKPIMap__c>();  
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
       
        if (st.getId() == null)
        {
            SPETemp = new SPE_SPETemplate__c(Stage__c = 'Draft', OwnerId =UserInfo.getUserId());
            SPETemp.Region__c = SPE_Constants.ALL_GEOSCOPE;
            SPETemp.SubRegion__c =SPE_Constants.ALL_GEOSCOPE_UNIT;
            SPETemp.Country__c =SPE_Constants.ALL_Country;
            SPETemp.Project__c =SPE_Constants.ALL_Project;
            SPETemp.CategoryCluster__c =SPE_Constants.ALL_CATSCOPE_AREA ;
            SPETemp.CategoryGroup__c =SPE_Constants.ALL_CATSCOPE_GROUP ;
            SPETemp.Category__c =SPE_Constants.ALL_CATSCOPE;
            SPETemp.BusinessUnit__c =SPE_Constants.ALL_BU_BUSCOPE;
            SPETemp.BusinessLine__c =SPE_Constants.ALL_BL_BUSCOPE;
            SPETemp.Product__c =SPE_Constants.ALL_BUSCOPE;
       //     SPETemp.RecordtypeId = [SELECT Id,DeveloperName,SobjectType FROM RecordType WHERE DeveloperName = 'Pilot_PP' AND SobjectType = 'SPE_SPETemplate__c'].Id;
            SPEKPIMaps = new List<SPE_SPEKPIMap__c>();
            kpiToSpeKPIMap =new Map<Integer,SPE_SPEKPIMap__c>();
            incrementVal =0;
       }
        else 
        {
            SPETemp = [SELECT Name, Stage__c,OwnerId,Type__c, BusinessLine__c, Region__c, BusinessUnit__c, SubRegion__c, CategoryCluster__c, Country__c, Category__c, 
                       Project__c, CategoryGroup__c,GeoScope__c,Categoryscope__c,BUScope__c, Product__c, Product1__c, Product2__c, Product3__c, Organization_Group__c   
                       FROM SPE_SPETemplate__c WHERE Id =: st.getId()];
            SpeTempId =st.getId();
            if(ApexPages.currentPage().getParameters().get('isClone') == null){
            CurrentUserId = UserInfo.getUserId();
            RecordOwnerId = [Select Id, ownerId from SPE_SPETemplate__c 
                           WHERE Id =: st.getId()].ownerId;
             }
            SPETempCloned = new SPE_SPETemplate__c(Stage__c = 'Draft', OwnerId =UserInfo.getUserId());
            if(Apexpages.currentPage().getParameters().get('isClone')!= null)
                SPETemp.Stage__c =  'Draft';
            system.debug('SpeTempId ::'+SpeTempId);
            SPEKPIMaps = [SELECT KPIDefinition__c, KPIDefinition__r.Id,KPIDefinition__r.LifecycleStage__c, Weight__c, UseLatestKPIVersion__c FROM SPE_SPEKPIMap__c WHERE SPETemplate__c = : SpeTempId];
            system.debug('SPEKPIMaps----' + SPEKPIMaps);
            incrementVal =0;
            kpiToSpeKPIMap =new Map<Integer,SPE_SPEKPIMap__c>();
            for(SPE_SPEKPIMap__c kpiToSpe :SPEKPIMaps)
            {
                incrementVal++;
                kpiToSpeKpiMap.put(incrementVal,kpiToSpe);
            }
            system.debug('kpiToSpeKpiMap----' + kpiToSpeKpiMap);
            chkScopeLevel();
            SPEKPIMapsCloned = kpiToSpeKpiMap.values().deepClone();
        }
     }
    
    public void addNewKPI()
    {
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();                
        SPEKPIMaps.add(spekpi);
        incrementVal++;
        kpiToSpeKpiMap.put(incrementVal,spekpi);
    }
        
    public Pagereference removeNewKPI()
    {       
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('indexNum'));
        system.debug('rowIndex::'+rowIndex);
        toBeDeletedSPEKPIMaps.add(kpiToSpeKpiMap.get(rowIndex));
        kpiToSpeKpiMap.remove(rowIndex);
        if(kpiToSpeKpiMap.size() == 0){
            minGeoScope = '';
            minCatScope = '';
            minProductScope = '';
        }
        //system.debug('toBeDeletedSPEKPIMaps$$$$$$$$$$$$$$$::'+toBeDeletedSPEKPIMaps);
        chkScopeLevel();
        return null;
    }
    
    public Pagereference cancel()
    {
        Schema.DescribeSObjectResult r = SPE_SPETemplate__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr = new Pagereference('/');
        if(SPETemp.Id!=null){
          pr =new Pagereference('/'+SPETemp.Id);
        } 
        else{
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
                    system.debug('toBeInsertedKPISPETemp $$$$$$$$$$$$$$$::'+toBeInsertedKPISPETemp);
                    if(!toBeInsertedKPISPETemp.isEmpty()){
                        upsert toBeInsertedKPISPETemp;
                    }
                      
                   }
                   else{
                       system.debug('SPETemp---' + SPETemp);
                       system.debug('SPEKPIMapsCloned---' + SPEKPIMapsCloned);
                       SPETempCloned = SPETemp.clone(false,true,false,false);
                       SPETempCloned.OwnerId =UserInfo.getUserId();
                       SPEKPIMapsCloned = kpiToSpeKpiMap.values().deepClone();
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
    
    public void InitialiseScopeMap(){
         geoScopeMap = new Map<String,Integer>();
         geoScopeMap.put('All Markets',0);
         geoScopeMap.put('Market',1);
         geoScopeMap.put('Market Unit',2);
         geoScopeMap.put('Country',3);
         geoScopeMap.put('Project',4);
         
         catScopeMap = new Map<String,Integer>();
         catScopeMap.put('All Categories',0);
         catScopeMap.put('Category Area',1);
         catScopeMap.put('Category Group',2);
         catScopeMap.put('Category',3);
         
         prodScopeMap = new Map<String,Integer>();
         prodScopeMap.put('All Products',0);
         prodScopeMap.put('Business Unit',1);
         prodScopeMap.put('Business Line',2);
         prodScopeMap.put('Product',3);
         
    }
    public pageReference assignMinScope(){
        chkScopeLevel();
        system.debug('minGeoScope::'+minGeoScope);
        return null;
    }
    public boolean chkScopeLevel(){
        Set<Id> addedKPIs = new Set<Id>();
        for (SPE_SPEKPIMap__c spekpi: kpiToSpeKpiMap.values()){        
            if (!addedKPIs.contains(spekpi.KPIDefinition__c)){            
                addedKPIs.add(spekpi.KPIDefinition__c);
            }
        }
        // SPE2 changes start here
        List<SPE_KPIDefinition__c> kpiScopes =[Select id,name,GeoScope__c,CategoryScope__c,BUScope__c from SPE_KPIDefinition__c Where Id IN :addedKPIs];
        system.debug('geo ::'+kpiScopes);
        InitialiseScopeMap();
        Map<Integer,String> kpiGeoScopeMap = new Map<Integer,String>();
        Map<Integer,String> kpiCatScopeMap = new Map<Integer,String>();
        Map<Integer,String> kpiProdScopeMap = new Map<Integer,String>();      
        for(SPE_KPIDefinition__c scope: kpiScopes){
            kpiGeoScopeMap.put(geoScopeMap.get(scope.GeoScope__c),scope.GeoScope__c+'~'+scope.name);
            kpiCatScopeMap.put(catScopeMap.get(scope.CategoryScope__c),scope.CategoryScope__c+'~'+scope.name);
            kpiProdScopeMap.put(prodScopeMap.get(scope.BUScope__c ),scope.BUScope__c+'~'+scope.name );                        
        }
        String addKpi = Apexpages.currentPage().getParameters().get('addingKpi');
        String removeKpi = Apexpages.currentPage().getParameters().get('removeKpi');
        String isGeoScope = Apexpages.currentPage().getParameters().get('isGeoScope');
        String isCatScope = Apexpages.currentPage().getParameters().get('isCatScope');
        String isProdScope = Apexpages.currentPage().getParameters().get('isProdScope');
        //GeographyScope match starts here
        if(!kpiGeoScopeMap.isEmpty()){
            integer geoScopeKeyVal = -1;
            for(Integer i : kpiGeoScopeMap.keySet()){
                if(geoScopeKeyVal < i){
                    geoScopeKeyVal = i;
                    String tempgeoScope = kpiGeoScopeMap.get(geoScopeKeyVal);
                    minGeoScope = tempgeoScope.split('~')[0];
                }
                
                system.debug('11::'+i);
            }
            if(!(geoScopeKeyVal <= geoScopeMap.get(SPETemp.GeoScope__c)) && minGeoScope != 'All Markets'){
                isGeoScopeMatch = false;
            }else{
                isGeoScopeMatch = true;
            }
            if(addKpi!= 'AddKpi' && removeKpi != 'RemoveKpi' && isGeoScope != 'isGeoScope' && isCatScope != 'isCatScope' && isProdScope != 'isProdScope'){
                if(!(geoScopeKeyVal <= geoScopeMap.get(SPETemp.GeoScope__c)) && minGeoScope != 'All Markets'){
                    return false;
                }
            }
        }
         //GeoScope match ends here
         
         //CategoryScope match starts here 
        if(!kpiCatScopeMap.isEmpty()){
            integer catScopeKeyVal = -1;
            for(Integer i : kpiCatScopeMap.keySet()){
                if(catScopeKeyVal < i){
                    catScopeKeyVal = i;
                    String tempcatScope = kpiCatScopeMap.get(catScopeKeyVal);
                    minCatScope = tempcatScope.split('~')[0];
                }
                
                system.debug('22::'+i);
            }
            if(!(catScopeKeyVal <= catScopeMap.get(SPETemp.CategoryScope__c)) &&  minCatScope != 'All Categories'){
                isCatScopeMatch = false;
            }else{
                isCatScopeMatch = true;
            }
            if(addKpi!= 'AddKpi' && removeKpi != 'RemoveKpi' && isGeoScope != 'isGeoScope' && isCatScope != 'isCatScope' && isProdScope != 'isProdScope'){
                if(!(catScopeKeyVal <= catScopeMap.get(SPETemp.CategoryScope__c)) &&  minCatScope != 'All Categories'){
                    return false;
                }
            }
        }
         //CategoryScope match ends here
          
         //ProductScope match starts here
        if(!kpiProdScopeMap.isEmpty()){
            integer prodScopeKeyVal = -1;
            for(Integer i : kpiProdScopeMap.keySet()){
                if(prodScopeKeyVal < i){
                    prodScopeKeyVal = i;
                    String tempprodScope = kpiProdScopeMap.get(prodScopeKeyVal);
                    minProductScope = tempprodScope.split('~')[0];
                }
                
                system.debug('33::'+i);
            }
            if(!(prodScopeKeyVal <= prodScopeMap.get(SPETemp.BUScope__c )) && minProductScope != 'All Products'){
                isProdScopeMatch = false;
            }else{
                isProdScopeMatch = true;
            }
            if(addKpi!= 'AddKpi' && removeKpi != 'RemoveKpi' && isGeoScope != 'isGeoScope' && isCatScope != 'isCatScope' && isProdScope != 'isProdScope'){
                if(!(prodScopeKeyVal <= prodScopeMap.get(SPETemp.BUScope__c )) && minProductScope != 'All Products'){
                    return false;
                }
            }
            
        }
       //ProductScope match ends here                
       // SPE2 changes ends here 
    return true;
    }
    private boolean checkValidation()
    {
        Decimal total = 0;
        
        Set<Id> addedKPIs = new Set<Id>();
        if(!kpiToSpeKpiMap.isEmpty()){   
            for (SPE_SPEKPIMap__c spekpi: kpiToSpeKpiMap.values())
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
         }
         else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE2_AddKPI));
            return false;
         }
        if ( total != 100 )
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_Weightage));
            return false;
        }
            
        if(!chkScopeLevel()){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'SPE Template Scope doesnot match'));
            return false;   
        }
        Map<Id, String> kpiIdLifecycleMap = new Map<Id, String>();
        
        for(SPE_KPIDefinition__c kpiDef : [SELECT Id, LifecycleStage__c FROM SPE_KPIDefinition__c WHERE Id IN : addedKPIs])
        {
            kpiIdLifecycleMap.put(kpiDef.Id, kpiDef.LifecycleStage__c);
        }
        
        for (SPE_SPEKPIMap__c kpispeTemp : kpiToSpeKpiMap.values())
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
          if(kpiToSpeKpiMap.size()>0)
          {      
            for (SPE_SPEKPIMap__c kpispeTemp : kpiToSpeKpiMap.values())
            {
                kpispeTemp.SPETemplate__c = SPETemp.Id;
                toBeInsertedKPISPETemp.add(kpispeTemp);
            }
          }   
           
        return toBeInsertedKPISPETemp;
    }
    // SPE 2 requirement changes
    public void displayKPIdetails(){
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('rowIndex'));
        
    } 
}