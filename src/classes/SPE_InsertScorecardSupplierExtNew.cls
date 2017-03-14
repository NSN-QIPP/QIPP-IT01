public without sharing class SPE_InsertScorecardSupplierExtNew {
    
    SPE_ScorecardGenerator__c objSG;
    public String idSPEPlanID{get;set;}
    String idScorecardTemplate;
    
  //****************************Changes for Encryption*************************//  
    //private Set<String> existSupplier = new Set<String>();
    //private Set<Id> existSupplierId = new Set<Id>();
  //****************************END*************************//   
    Public boolean isShowError{get;set;}
    Transient List<SPE_ScorecardSupplierMap__c> lstExistingSuppliers;
    public String supplierName {get;set;}
    public boolean isShowSuppliers{get;set;}
    public boolean isSearch{get;set;}
    public boolean isSearch1{get;set;}
    public boolean isDisplayError{get;set;}
    Transient List<SupplierWrapper> SupplierWrapperList;
    Transient List<SupplierWrapper> SupplierWrapperListSelected;
    public Set<Id> setIds {get;set;}
    
    public integer DEFAULT_PAGE_SIZE{get;set;}
    public integer pageNumber{get;set;}
    public integer maxPages{get;set;}
    public integer startRecNo {get;set;}
    public integer endRecNo {get;set;}
    public boolean hasRecords{get;set;}
    public boolean shownext{get;set;}
    public boolean showprevoius{get;set;}
    public boolean showfirst{get;set;}
    public boolean showlast{get;set;}
    public Integer supplistsize{get;set;}
    public List<SupplierWrapper> subwrapperList{get;set;} // list of wrapper class to store only the limited no of(# of page size) Suppliers   
    
    public integer DEFAULT_PAGE_SIZE2{get;set;}
    public integer pageNumber2{get;set;}
    public integer maxPages2{get;set;}
    public integer startRecNo2 {get;set;}
    public integer endRecNo2 {get;set;}
    public boolean hasRecords2{get;set;}
    public boolean shownext2{get;set;}
    public boolean showprevoius2{get;set;}
    public boolean showfirst2{get;set;}
    public boolean showlast2{get;set;}    
    public Integer supplistsize2{get;set;}
    public List<SupplierWrapper> subwrapperList2{get;set;}
    public String sortname;
    public String sortname2;
    
    Boolean isMsgDisplay;
    
    public integer DEFAULT_PAGE_SIZE3{get;set;}
    public integer pageNumber3{get;set;}
    public integer maxPages3{get;set;}
    public integer startRecNo3 {get;set;}
    public integer endRecNo3 {get;set;}
    public boolean hasRecords3{get;set;}
    public boolean shownext3{get;set;}
    public boolean showprevoius3{get;set;}
    public boolean showfirst3{get;set;}
    public boolean showlast3{get;set;}    
    public Integer supplistsize3{get;set;}
    
    public list<String> AlphaList {get; set;}
    Transient List<SupplierWrapper> DisplaySupplierWrapperList;
    List<SupplierWrapper> templistSupplierWrapper;
    public List<SupplierWrapper> templistSupplierWrapper2;
    Map<String,String> tempMapDeSupplierWrapper;
    Set<String> setExistingSupNames;
    
    public list<String> AlphaList2 {get; set;}
    Transient List<SupplierWrapper> DisplaySupplierWrapperList2;
    
    Transient List<SPE_ScorecardSupplierMap__c> lstSSM;
    public List<SPE_ScorecardSupplierMap__c> DisplaySSM{get;set;}
    public SPE_ScorecardSupplierMap__c objSSM{get;set;}
    List<SPE_ScorecardSupplierMap__c> toDelete;
    Set<Id> idSPETemplates;
    public String uidentify {get;set;}
    public string accountName{get;set;}
    
    
    public SPE_InsertScorecardSupplierExtNew(Apexpages.Standardcontroller st){
        
        idSPEPlanID = st.getId();
        
        uidentify = system.Now()+userInfo.getUserId();
        
        isShowSuppliers = true;
        isSearch =False;
        
        isDisplayError = False;
        objSG = new SPE_ScorecardGenerator__c();
        sortname = '';
        sortname2 = '';
        //SupplierWrapperListSelected = new list<SupplierWrapper>();
        SupplierWrapperList = new List<SupplierWrapper>();
        setIds = new Set<Id>();
        isShowError = false;        
        
        DEFAULT_PAGE_SIZE = 500;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        supplistsize=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        subwrapperList = new list<SupplierWrapper>();
        
        DEFAULT_PAGE_SIZE2 = 500;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        subwrapperList2 = new list<SupplierWrapper>();
        
        DEFAULT_PAGE_SIZE3 = 200;
        pageNumber3 = 1;
        startRecNo3=0;
        endRecNo3=0;
        supplistsize3=0;
        shownext3=false;
        showprevoius3=false;
        showfirst3=false;
        showlast3=false;
        DisplaySSM = new list<SPE_ScorecardSupplierMap__c>();
        
        idSPETemplates = new Set<Id>();
        templistSupplierWrapper = new List<SupplierWrapper>();
        templistSupplierWrapper2 = new List<SupplierWrapper>();
        tempMapDeSupplierWrapper = new Map<String,String>();
        toDelete = new List<SPE_ScorecardSupplierMap__c>();
        lstSSM = new List<SPE_ScorecardSupplierMap__c>();
        List<SPE_SPEPlan__c> lstSPEPlans = new List<SPE_SPEPlan__c>();
        List<SPE_ScorecardSPETemplateMap__c> lstScSPETemplateMapRecords = new List<SPE_ScorecardSPETemplateMap__c>();
        setExistingSupNames = new Set<String>();
        //*************initialization alpha list**********//
        AlphaList = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
        
        objSG = [SELECT Id,Name,ScorecardTemplate__c,CategoryCluster__c,Categorygroup__c,Category__c,Region__c,SubRegion__c,country__c,project__c
                        From 
                        SPE_ScorecardGenerator__c
                        WHERE Id =: idSPEPlanID];
                                               
        if(objSG.ScorecardTemplate__c != null){
            idScorecardTemplate = objSG.ScorecardTemplate__c;
        }
        alphasortname();                                  
        if(idScorecardTemplate != null && idScorecardTemplate != ''){
            //system.debug('idScorecardTemplate---11-' + idScorecardTemplate);
            lstScSPETemplateMapRecords = [select
                                              Id,SPETemplate__c,Weight__c
                                          from 
                                              SPE_ScorecardSPETemplateMap__c
                                          where
                                              ScorecardTemplate__c =: idScorecardTemplate];
        }
        
        for(SPE_ScorecardSPETemplateMap__c objScSPETem : lstScSPETemplateMapRecords){
            idSPETemplates.add(objScSPETem.SPETemplate__c);
        }
        system.debug('idSPETemplates----' + idSPETemplates);
        
        // matching scope of scorecard with plans
        string query='Select Id,(Select Supplier__c,Supplier__r.Name,Supplier__r.EnterpriseId__c From SPE_Plan_Supplier_Maps__r) from SPE_SPEPlan__c where SPETemplate__c IN :idSPETemplates';
        
             String CategoryArea;
             String CategoryGroup;
             String Category; 
             String country; 
             string project; 
             string SubMarket;
             string market;                      
        if(!objSG.region__c.containsIgnoreCase('All')){
        market=objSG.region__c;
        query=query+' and region__c=:market';
     
        }
        if(!objSG.SubRegion__c.containsIgnoreCase('All')){
        Submarket=objSG.SubRegion__c;
        query=query+' and SubRegion__c=:Submarket';
        }
        if(!objSG.Country__c.containsIgnoreCase('All')){
        country=objSG.Country__c;
        query=query+' and Country__c=:country';
        } 
        if(!objSG.Project__c.containsIgnoreCase('All')){
        project=objSG.Project__c;
        query=query+' and project__c=:project';
       
        }
         if(!objSG.Category__c.containsIgnoreCase('All')){
        Category=objSG.Category__c;
        query=query+' and Category__c=:Category';
        }
        if(!objSG.CategoryGroup__c.containsIgnoreCase('All')){
        CategoryGroup=objSG.CategoryGroup__c;
        query=query+' and CategoryGroup__c=:CategoryGroup';
        }
        if(!objSG.CategoryCluster__c.containsIgnoreCase('All')){
        CategoryArea=objSG.CategoryCluster__c;
        query=query+' and CategoryCluster__c=:CategoryArea';
        }
        
        
        lstSPEPlans =  Database.query(query);
        
        
        for(SPE_SPEPlan__c s : lstSPEPlans){
            for(SPE_SPEPlanSupplierMap__c s1 : s.SPE_Plan_Supplier_Maps__r){
                if(!setExistingSupNames.contains(s1.Supplier__r.EnterpriseId__c)){
                    SupplierWrapper sc2 = new SupplierWrapper();                   
                    sc2.isChecked = false;
                    sc2.strEnterpriseName = s1.Supplier__r.EnterpriseId__c;
                    sc2.strSupplierName = s1.Supplier__r.Name;
                    sc2.idEntId = s1.Supplier__c;
                    sc2.accwrap = s1.Supplier__r;
                    sc2.accwrap.Name = s1.Supplier__r.Name;
                    sc2.accwrap.EnterpriseId__c = s1.Supplier__r.EnterpriseId__c;
                    sc2.isExisting = false;
                    templistSupplierWrapper2.add(sc2);
                                        
                    setExistingSupNames.add(sc2.strEnterpriseName);
                }
            }
        }
        
        if(templistSupplierWrapper2.size() > 0){
             isMsgDisplay = True;
        }
        if(templistSupplierWrapper2.size() == 0){
             isMsgDisplay = False;
        }
        
        //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+templistSupplierWrapper2.size()); 
        
        alphasortname();
      }                                              
                
        //************************Method For Alphabaticall sorting*********************//
        public void selectwrappsupp()
        {           
                      
           lstExistingSuppliers = new List<SPE_ScorecardSupplierMap__c>();
           lstExistingSuppliers = [SELECT Id, Supplier__c, Supplier__r.Name, Supplier__r.EnterpriseId__c,Approver__c,SupplierContact__c,                                           
                                          ScorecardGenerator__c,CC_Contact1__c,CC_Contact2__c FROM SPE_ScorecardSupplierMap__c
                                                   WHERE ScorecardGenerator__c =: idSPEPlanID];
           lstExistingSuppliers.sort();
           DisplaySupplierWrapperList = new List<SupplierWrapper>();
           SupplierWrapperList = new List<SupplierWrapper>();
           Map<String,String> DeselectedSupplierMap = new Map<String,String>();
           lstSSM = new List<SPE_ScorecardSupplierMap__c>();
           
            for(SPE_ScorecardSupplierMap__c ssmT : lstExistingSuppliers){
                SupplierWrapper sc = new SupplierWrapper();
                sc.isChecked = true;
                sc.strEnterpriseName = ssmT.Supplier__r.EnterpriseId__c;
                sc.strSupplierName = ssmT.Supplier__r.Name;
                sc.idEntId = ssmT.Supplier__c;
                sc.accwrap = ssmT.Supplier__r;
                sc.accwrap.Name = ssmT.Supplier__r.Name;
                sc.accwrap.EnterpriseId__c = ssmT.Supplier__r.EnterpriseId__c;
                sc.idPlanSuppId = ssmT.Id;
                sc.isExisting = true;
                sc.scMap = ssMT;
                DisplaySupplierWrapperList.add(sc);
                
                setExistingSupNames.add(sc.strEnterpriseName);
                setIds.add(sc.idEntId);
                
             //****************************Changes for Encryption*************************// 
                //existSupplier.add(ssmT.Supplier__r.EnterpriseId__c);            
                //existSupplierId.add(ssmT.Supplier__c);
             //****************************END*************************//   
                
            }
            
        for(SupplierWrapper sw : subwrapperList2){
            if(sw.isChecked){                
                if(!setIds.contains(sw.idEntId)){
                sw.isSelected = True;
                templistSupplierWrapper.add(sw);
                //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+templistSupplierWrapper.size());
                setIds.add(sw.idEntId);
                }
                else{
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'The supplier is already selected'));
                }                        
             }
         }
         
       if(templistSupplierWrapper.size()>0)
         {
             DisplaySupplierWrapperList.addAll(templistSupplierWrapper);
         }
        
        if(templistSupplierWrapper2.size()>0)
         {
            DisplaySupplierWrapperList.addAll(templistSupplierWrapper2);
         }  
         
       //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+templistSupplierWrapper2.size());
          
       DisplaySupplierWrapperList.sort(); 
          
       for(SupplierWrapper sw1 : subwrapperList){
            if(!sw1.isChecked && sw1.isExisting && sw1.idPlanSuppId != null){
                tempMapDeSupplierWrapper.put(sw1.strSupplierName,sw1.strSupplierName);                        
            }
            else
            {
                tempMapDeSupplierWrapper.remove(sw1.strSupplierName);                        
            }
         }
            
        if(tempMapDeSupplierWrapper.size()>0)
        {
            toDelete = new List<SPE_ScorecardSupplierMap__c>();
            
            for(SupplierWrapper scws : DisplaySupplierWrapperList)
            {                    
                if(tempMapDeSupplierWrapper.containsKey(scws.strSupplierName))
                {
                    scws.isChecked  = False;
                    SPE_ScorecardSupplierMap__c s = new SPE_ScorecardSupplierMap__c (id=scws.idPlanSuppId,ScorecardGenerator__c=idSPEPlanID);
                    toDelete.add(s);
                }
            } 
        }  
                                                         
            if (sortname == null || sortname == 'All') {
                for(SupplierWrapper scOj : DisplaySupplierWrapperList)
                         {
                             SupplierWrapperList.add(scOj);
                             hasRecords = true;                         
                             integer remainder = math.MOD(SupplierWrapperList.size(),DEFAULT_PAGE_SIZE);
                             if(remainder ==0){
                                maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE;
                             }
                             else{
                                maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                             }
                         }
                         
            }else if(sortname != null && sortname != 'All'){
                    Pattern MyPattern = Pattern.compile('(?i)\\A^'+sortname);
                    System.debug('$$$$$$$$$$$$$$$$$$$$$$'+MyPattern);                    
                    
                    for(SupplierWrapper scOj : DisplaySupplierWrapperList){
                       String sname = scOj.strSupplierName;
                       System.debug('$$$$$$$$$$$$$$$$$$$$$$'+sname);
                       Matcher MyMatcher = MyPattern.matcher(sname);
                           if (MyMatcher.find())
                           {                                    
                                 SupplierWrapperList.add(scOj);
                                 hasRecords = true;                         
                                 integer remainder = math.MOD(SupplierWrapperList.size(),DEFAULT_PAGE_SIZE);
                                 if(remainder ==0){
                                    maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE;
                                 }
                                 else{
                                    maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                                 }
                           }                                                                             
                     }  
            }
            
            List<SPE_ScorecardSupplierMap__c> mainlist = new List<SPE_ScorecardSupplierMap__c>();
                
             for(SupplierWrapper sw : DisplaySupplierWrapperList){
                if(sw.isChecked){                    
                    objSSM = new SPE_ScorecardSupplierMap__c();
                    objSSM.Supplier__c = sw.idEntId;
                    objSSM.ScorecardGenerator__c = idSPEPlanID ;
                    objSSM.Approver__c = sw.scMap.Approver__c;
                    objSSM.SupplierContact__c = sw.scMap.SupplierContact__c;
                    objSSM.CC_Contact1__c = sw.scMap.CC_Contact1__c;
                    objSSM.CC_Contact2__c = sw.scMap.CC_Contact2__c;
                    if(sw.idPlanSuppId != null)
                    {
                        objSSM.Id = sw.idPlanSuppId;
                    }
                    mainlist.add(objSSM);
                    //System.debug(LoggingLevel.ERROR,'*****************************************'+objSSM);
                    //System.debug(LoggingLevel.ERROR,'*******************&&&&&**********************'+mainlist);
                }
            }

            Map<ID,SPE_ScorecardSupplierMap__c> uniqueMapSupp = new Map<ID,SPE_ScorecardSupplierMap__c>();
            
            for(SPE_ScorecardSupplierMap__c sssm: mainlist)
            {           
                uniqueMapSupp.put(sssm.Supplier__c,sssm);
                System.debug(LoggingLevel.ERROR,'&&&&&'+uniqueMapSupp);                
            }
            
            for(ID s :uniqueMapSupp.keySet()){
                lstSSM.add(uniqueMapSupp.get(s));
                System.debug(LoggingLevel.ERROR,'$$$$$$$$'+lstSSM);
            }
            
            lstSSM.sort();
      } 
      
       public void displayScorecardSupplierWrapper(){
            DEFAULT_PAGE_SIZE3 = 200;
            pageNumber3 = 1;
            startRecNo3=0;
            endRecNo3=0;
            supplistsize3=0;
            shownext3=false;
            showprevoius3=false;
            showfirst3=false;
            showlast3=false;
            lstSSM = new List<SPE_ScorecardSupplierMap__c>();
            
            DisplaySSM.clear();
            DisplaySSM = new list<SPE_ScorecardSupplierMap__c>();
            selectwrappsupp();
            
                if(lstSSM.size()>0)
                     {    
                     isShowSuppliers = false;
                     
                     integer remainder = math.MOD(lstSSM.size(),DEFAULT_PAGE_SIZE3);
                         if(remainder ==0){
                            maxPages3 = lstSSM.size()/DEFAULT_PAGE_SIZE3;
                         }
                         else{
                            maxPages3 = lstSSM.size()/DEFAULT_PAGE_SIZE3 + 1;
                         }
             
                          if(lstSSM.size() > DEFAULT_PAGE_SIZE3){
                                firstBtnClick3();      
                            }
                           else{
                                for(SPE_ScorecardSupplierMap__c scOj : lstSSM){
                                     DisplaySSM.add(scOj);
                                 }
                                 startRecNo3=1;
                                 endRecNo3=lstSSM.size();
                                 supplistsize3 = lstSSM.size();
                                 shownext3 = false;
                                 showprevoius3 = false;
                            }
                    }
                    else
                    {                       
                       //System.Debug(LoggingLevel.ERROR,'lstSSM in Main%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+lstSSM.size());
                       //gotoDetailPage();
                       gotoDetailPageforNoRecords();                        
                    }

       } 
        public void alphasortname(){
                DEFAULT_PAGE_SIZE = 500;
                pageNumber = 1;
                startRecNo=0;
                endRecNo=0;
                supplistsize=0;
                shownext=false;
                showprevoius=false;
                showfirst=false;
                showlast=false;
                SupplierWrapperList = new List<SupplierWrapper>();
                sortname = apexpages.currentpage().getparameters().get('alpha');
                                
            //*****alpha filter, use page parameter or set default to all*****//
                 if (sortname == null || sortname == 'All') {
                     subwrapperList.clear();
                     subwrapperList = new list<SupplierWrapper>();
                     selectwrappsupp();
                     if(SupplierWrapperList.size()>0)
                     {    
                     hasRecords = true;
                     System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+SupplierWrapperList.size());
                     //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+DisplaySupplierWrapperList.size());
                     integer remainder = math.MOD(SupplierWrapperList.size(),DEFAULT_PAGE_SIZE);
                         if(remainder ==0){
                            maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE;
                         }
                         else{
                            maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                         }
             
                          if(SupplierWrapperList.size() > DEFAULT_PAGE_SIZE){
                                firstBtnClick();      
                            }
                           else{
                                for(SupplierWrapper scOj : SupplierWrapperList){
                                     subwrapperList.add(scOj);
                                 }
                                 startRecNo=1;
                                 endRecNo=SupplierWrapperList.size();
                                 supplistsize = SupplierWrapperList.size();
                                 shownext = false;
                                 showprevoius = false;
                            }
                    } 
                 }else {
                    subwrapperList.clear();
                    subwrapperList = new list<SupplierWrapper>();
                    selectwrappsupp();
                     if(SupplierWrapperList.size()>0)
                     {
                         System.debug(LoggingLevel.ERROR,'$$$$$$$$$$$$$$$$$$$$$$'+SupplierWrapperList.size());                     
                         hasRecords = true;                         
                         integer remainder = math.MOD(SupplierWrapperList.size(),DEFAULT_PAGE_SIZE);
                         if(remainder ==0){
                            maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE;
                         }
                         else{
                            maxPages = SupplierWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                         }
             
                          if(SupplierWrapperList.size() > DEFAULT_PAGE_SIZE){
                                firstBtnClick();      
                            }
                           else{
                                for(SupplierWrapper scOj1 : SupplierWrapperList){
                                     subwrapperList.add(scOj1);
                                 }
                                 startRecNo=1;
                                 endRecNo=SupplierWrapperList.size();
                                 supplistsize = SupplierWrapperList.size();
                                 shownext = false;
                                 showprevoius = false;
                            }
                        }
                      }
                      if(SupplierWrapperList.size() == 0 && isMsgDisplay == False)
                      {                          
                          System.debug(LoggingLevel.ERROR,'$$$$$$$$$$$$$$$$$$$$$$'+SupplierWrapperList.size());
                          pageNumber = 0;
                          maxPages = 0;
                          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
                      }
        }
        
        //*****************Code written for Pagination Part for Upper List******************//
       /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick(){
            selectwrappsupp();
            //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+SupplierWrapperList.size());
            //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+DisplaySupplierWrapperList.size());
            pageNumber = 1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new List<SupplierWrapper>();
            if(SupplierWrapperList.size() > DEFAULT_PAGE_SIZE)
            {
                for(integer i=0;i<DEFAULT_PAGE_SIZE;i++){
                    try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = SupplierWrapperList.size();
                shownext = true;
                showprevoius = false;
                showlast=true;
                showfirst=false;
             }else
             {
                 for(integer i=0;i<SupplierWrapperList.size();i++){
                     try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
                startRecNo=1;
                endRecNo=SupplierWrapperList.size();
                supplistsize = SupplierWrapperList.size();
                shownext = false;
                showprevoius = false;
                showlast=false;
                showfirst=false;
             }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick(){
            //templistSupplierWrapper2 = new List<SupplierWrapper>();
            selectwrappsupp();
            pageNumber = pageNumber+1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<SupplierWrapperList.size(); i++)           
                {
                    try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=SupplierWrapperList.size();
                supplistsize = SupplierWrapperList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = SupplierWrapperList.size();
    
                shownext = true;
                showlast=true;
            }
            showprevoius = true;
            showfirst=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick(){
            //templistSupplierWrapper2 = new List<SupplierWrapper>();
            selectwrappsupp();
            pageNumber = pageNumber-1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                try{
                    subwrapperList.add(SupplierWrapperList[i]);
                }catch(exception e){}
            }
    
            startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
            endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
            supplistsize = SupplierWrapperList.size();
    
            shownext = true;
            showprevoius = true;
            showlast=true;
            showfirst=true;
    
    
            if(pageNumber == 1){
                showprevoius = false;
                showfirst=false;
            }
            else{
                showprevoius = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick(){
            //templistSupplierWrapper2 = new List<SupplierWrapper>();
            selectwrappsupp();
            pageNumber = maxPages;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<SupplierWrapper>();
    
            for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<SupplierWrapperList.size();i++)           
            {
                try{
                    subwrapperList.add(SupplierWrapperList[i]);
                }catch(exception e){}
            }
    
            startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
            endRecNo=SupplierWrapperList.size();
            supplistsize = SupplierWrapperList.size();
    
            shownext = false;
            showprevoius = true;
            showlast=false;
            showfirst=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage(){
            //templistSupplierWrapper2 = new List<SupplierWrapper>();
            selectwrappsupp();
            try
            {
                pageNumber = integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum').trim());
            }
            catch(exception ex)
            {
                pageNumber=1;
            }
    
            if(pageNumber>maxPages)
                pageNumber=maxPages;
                
            if(pageNumber<1)// to handle the negative digit as page number
                pageNumber=1;
                
            subwrapperList.clear();    
            subwrapperList = new list<SupplierWrapper>();
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<SupplierWrapperList.size(); i++)           
                {
                    try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=SupplierWrapperList.size();
                supplistsize = SupplierWrapperList.size();
    
                if(pageNumber==1)
                {
                    shownext = false;
                    showlast=false;
                    showprevoius = false;
                    showfirst=false;
                }else
                {
                    shownext = false;
                    showlast=false;
                    showprevoius = true;
                    showfirst=true;
                }
    
            }
            else if(pageNumber == 1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = SupplierWrapperList.size();
                shownext = true;
                showlast=true;
                showprevoius = false;
                showfirst=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                        subwrapperList.add(SupplierWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = SupplierWrapperList.size();
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
        
    //*******************************************Pagination End***********************************//
    
    /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick2(){
            searchSuppliers();
            pageNumber2 = 1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<SupplierWrapper>();
    
            for(integer i=0;i<DEFAULT_PAGE_SIZE2;i++){
                try{
                    subwrapperList2.add(SupplierWrapperListSelected[i]);
                }catch(exception e){}
            }
            startRecNo2=1;
            endRecNo2=DEFAULT_PAGE_SIZE2;
            supplistsize2=SupplierWrapperListSelected.size();
    
            shownext2 = true;
            showprevoius2 = false;
            showlast2=true;
            showfirst2=false;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick2(){
            searchSuppliers();
            pageNumber2 = pageNumber2+1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<SupplierWrapper>();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<SupplierWrapperListSelected.size(); i++)           
                {
                    try{
                        subwrapperList2.add(SupplierWrapperListSelected[i]);
                    }catch(exception e){}
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=SupplierWrapperListSelected.size();
                supplistsize2=SupplierWrapperListSelected.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(SupplierWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
                supplistsize2=SupplierWrapperListSelected.size();
                
                shownext2 = true;
                showlast2=true;
            }
            showprevoius2 = true;
            showfirst2=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick2(){
            searchSuppliers();     
            pageNumber2 = pageNumber2-1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<SupplierWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
            {
                try{
                    subwrapperList2.add(SupplierWrapperListSelected[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
            endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
            supplistsize2=SupplierWrapperListSelected.size();   
    
            shownext2 = true;
            showprevoius2 = true;
            showlast2=true;
            showfirst2=true;
    
    
            if(pageNumber2 == 1){
                showprevoius2 = false;
                showfirst2=false;
            }
            else{
                showprevoius2 = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick2(){
            searchSuppliers();
            pageNumber2 = maxPages2;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<SupplierWrapper>();
    
            for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE2;i<SupplierWrapperListSelected.size();i++)           
            {
                try{
                    subwrapperList2.add(SupplierWrapperListSelected[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE2)+1;
            endRecNo2=SupplierWrapperListSelected.size();
            supplistsize2=SupplierWrapperListSelected.size();
    
            shownext2 = false;
            showprevoius2 = true;
            showlast2=false;
            showfirst2=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage2(){
            searchSuppliers();
            try
            {
                pageNumber2 = integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum2').trim());
            }
            catch(exception ex)
            {
                pageNumber2=1;
            }
    
            if(pageNumber2>maxPages2)
                pageNumber2=maxPages2;
                
            if(pageNumber2<1)// to handle the negative digit as page number
                pageNumber2=1;
                
                
            subwrapperList2 = new list<SupplierWrapper>();
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<SupplierWrapperListSelected.size(); i++)           
                {
                    try{
                        subwrapperList2.add(SupplierWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=SupplierWrapperListSelected.size();
    
    
                if(pageNumber2==1)
                {
                    shownext2 = false;
                    showlast2=false;
                    showprevoius2 = false;
                    showfirst2=false;
                }else
                {
                    shownext2 = false;
                    showlast2=false;
                    showprevoius2 = true;
                    showfirst2=true;
                }
    
            }
            else if(pageNumber2 ==1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE2;i++)           
                {
                    try{
                        subwrapperList2.add(SupplierWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=1;
                endRecNo2=DEFAULT_PAGE_SIZE2;
                supplistsize2=SupplierWrapperListSelected.size();
                shownext2 = true;
                showlast2=true;
                showprevoius2 = false;
                showfirst2=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(SupplierWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
                supplistsize2=SupplierWrapperListSelected.size();
    
                shownext2 = true;
                showlast2=true;
                showprevoius2 = true;
                showfirst2=true;
            }
        }
        
    //*******************************************Pagination End***********************************//     
    
    public void searchSuppliers(){
            isSearch = true;
            Map<String,String> AddedSupplierMap = new Map<String,String>();      
            Boolean isPresent = False;
        
        if(supplierName !='' && supplierName !=Null){
            //*************initialization alpha list**********//
            AlphaList2 = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
            DisplaySupplierWrapperList2 = new List<SupplierWrapper>();
            SupplierWrapperListSelected = new List<SupplierWrapper>();
            String searchString = supplierName;
            
            if   (searchString !=null && searchString.containsIgnoreCase('*'))
            {
              //searchString = searchString.replaceAll('[*]', '%');
            }
            
         if (supplierName != '' && supplierName != '*')
            {
          //*******************************Changes For Encryption***********************//
              
              /*List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE EnterpriseId__c LIKE: searchString AND
                                                  EnterpriseId__c not IN: existSupplier AND
                                                  ParentId = Null AND
                                                  EnterpriseId__c != null 
                                             LIMIT 100];*/
                                             
               /*List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE Id not IN: existSupplierId AND
                                                   ParentId = Null
                                             ];*/
                                             
              List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE ParentId = Null
                                             ];                               
                                                                                                                        
              Pattern MyPattern = Pattern.compile('');
             
             if (searchString.substring(0,1) == '*' && searchString.substring(searchString.length()-1,searchString.length()) == '*')
             {
                if (searchString.length()>1)
                {
                    String Temp = searchString.subString(1, searchString.length());
                    searchString = Temp.replaceAll('[*]', '+');
                    MyPattern = Pattern.compile('(?i)'+searchString );
                }
             }
             else if (searchString.substring(0,1) != '*' && searchString.substring(searchString.length()-1,searchString.length()) == '*')
             {
                searchString = searchString.replaceAll('[*]', '+');
                MyPattern = Pattern.compile('(?i)\\A'+searchString);
             }
             
             else if (searchString.substring(0,1) == '*' && searchString.substring(searchString.length()-1,searchString.length()) != '*')
             {
                if (searchString.length()>1)
                {
                    String Temp = searchString.subString(1, searchString.length());
                    searchString = Temp + '+';
                    MyPattern = Pattern.compile('(?i)'+searchString +'\\z');
                }
             } 
             
             else if (searchString.substring(0,1) != '*' && searchString.substring(searchString.length()-1,searchString.length()) != '*')
             {
                 if (searchString.length()>1)
                {
                    MyPattern = Pattern.compile('(?i)\\A^'+searchString+'$');
                }
             }
         
          if (!accountlist.isEmpty()){
              isShowError = false;
          }
          else{
              isShowError = true;
          }
          for (Account a : accountList)
            {
             if (a.EnterpriseId__c != null)
             {   
                
                String s = a.EnterpriseId__c;
                Matcher MyMatcher = MyPattern.matcher(s);
                
                if (MyMatcher.find())
                {
                    SupplierWrapper sw = new SupplierWrapper();
                    sw.isChecked = false;
                    sw.strEnterpriseName = a.EnterpriseId__c;
                    sw.strSupplierName = a.Name;
                    sw.idEntId = a.Id;
                    sw.accwrap = a;
                    sw.accwrap.Name = a.Name;
                    sw.accwrap.EnterpriseId__c = a.EnterpriseId__c;
                    sw.isExisting = false;
                    DisplaySupplierWrapperList2.add(sw);
                }
              }  
            }
          }      
                                
                System.debug(LoggingLevel.ERROR,'+++++++++++++++++++'+DisplaySupplierWrapperList2.size()); 
                DisplaySupplierWrapperList2.sort();
                selectwrappsupp();
                for(SupplierWrapper scw : SupplierWrapperList)
                {
                    if(scw.isChecked)
                    {
                        AddedSupplierMap.put(scw.strSupplierName,scw.strSupplierName);
                        isPresent = True;
                    }
                    if(!scw.isChecked)
                    {
                        AddedSupplierMap.put(scw.strSupplierName,scw.strSupplierName);
                        isPresent = False;
                    }    
                }
                
                for(SupplierWrapper scws : DisplaySupplierWrapperList2)
                {
                    if(AddedSupplierMap.containsKey(scws.strSupplierName) && isPresent == True)
                    {
                        scws.isChecked  = True;
                        scws.isSelected = True;                        
                    }
                    
                    if(AddedSupplierMap.containsKey(scws.strSupplierName) && isPresent == False)
                    {
                        scws.isChecked  = False;
                        scws.isSelected = True;                        
                    }
                }
                    
                if(sortname2 == null || sortname2 == 'All') {                 
                 for(SupplierWrapper scOj : DisplaySupplierWrapperList2)
                     {
                         SupplierWrapperListSelected.add(scOj);
                     }
                 }else if(sortname2 != null && sortname2 != 'All'){
                     Pattern MyPattern2 = Pattern.compile('(?i)\\A^'+sortname2);                    
                     for(SupplierWrapper scOj : DisplaySupplierWrapperList2){
                       String sname2 = scOj.strSupplierName;
                       System.debug('$$$$$$$$$$$$$$$$$$$$$$'+sname2);
                       Matcher MyMatcher2 = MyPattern2.matcher(sname2);
                           if (MyMatcher2.find())
                           {
                                 SupplierWrapperListSelected.add(scOj);                                
                           }                                                                             
                     }
                 }    
            
        //******************************************END**********************************//          
        }
        else{
            isSearch = false;
            isShowError = true;
            //isDisplayError = True;
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please provide atleast one character for the wild card search'));
        }
    }
    
    //************************Method For Alphabaticall sorting*********************//
    public void alphasortname2(){
            DEFAULT_PAGE_SIZE2 = 500;
            pageNumber2 = 1;
            startRecNo2=0;
            endRecNo2=0;
            supplistsize2=0;
            shownext2=false;
            showprevoius2=false;
            showfirst2=false;
            showlast2=false;
            SupplierWrapperListSelected = new list<SupplierWrapper>();
            sortname2 = apexpages.currentpage().getparameters().get('alpha2');
                            
        //*****alpha filter, use page parameter or set default to all*****//
             if (sortname2 == null || sortname2 == 'All') {
                 subwrapperList2.clear();
                 subwrapperList2 = new list<SupplierWrapper>();
                 searchSuppliers();
                 if(SupplierWrapperListSelected.size()>0)
                 {
                 hasRecords2 = true;
                 integer remainder = math.MOD(SupplierWrapperListSelected.size(),DEFAULT_PAGE_SIZE2);
                     if(remainder ==0){
                        maxPages2 = SupplierWrapperListSelected.size()/DEFAULT_PAGE_SIZE2;
                     }
                     else{
                        maxPages2 = SupplierWrapperListSelected.size()/DEFAULT_PAGE_SIZE2 + 1;
                     }
         
                      if(SupplierWrapperListSelected.size() > DEFAULT_PAGE_SIZE2){
                            firstBtnClick2();      
                        }
                       else{
                            for(SupplierWrapper scOj : SupplierWrapperListSelected){
                                 subwrapperList2.add(scOj);
                             }
                             startRecNo2=1;
                             endRecNo2=SupplierWrapperListSelected.size();
                             supplistsize2=SupplierWrapperListSelected.size();
                             shownext2 = false;
                             showprevoius2 = false;
                        }
                 } 
             }else {
                subwrapperList2.clear();                
                subwrapperList2 = new list<SupplierWrapper>();
                searchSuppliers();
                 if(SupplierWrapperListSelected.size()>0)
                 {
                     System.debug('$$$$$$$$$$$$$$$$$$$$$$'+SupplierWrapperListSelected);                     
                     hasRecords2 = true;                         
                     integer remainder = math.MOD(SupplierWrapperListSelected.size(),DEFAULT_PAGE_SIZE2);
                     if(remainder ==0){
                        maxPages2 = SupplierWrapperListSelected.size()/DEFAULT_PAGE_SIZE2;
                     }
                     else{
                        maxPages2 = SupplierWrapperListSelected.size()/DEFAULT_PAGE_SIZE2 + 1;
                     }
         
                      if(SupplierWrapperListSelected.size() > DEFAULT_PAGE_SIZE2){
                            firstBtnClick2();      
                        }
                       else{
                            for(SupplierWrapper scOj1 : SupplierWrapperListSelected){
                                 subwrapperList2.add(scOj1);
                             }
                             startRecNo2=1;
                             endRecNo2=SupplierWrapperListSelected.size();
                             supplistsize2=SupplierWrapperListSelected.size();
                             shownext2 = false;
                             showprevoius2 = false;
                        }
                     }
                  }
                  if(SupplierWrapperListSelected.size() == 0 && SupplierWrapperList.size() == 0)
                  {
                      
                      System.debug('Enter Here'+SupplierWrapperListSelected.size());
                      pageNumber2 = 0;
                      maxPages2 = 0;
                      supplistsize2=0;
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
                  }
                  
    }
    
    public void addToMainList(){
           firstBtnClick();
    }
    
    public pagereference gotoDetailPage(){
        selectwrappsupp();
        if(!toDelete.isEmpty())
        {
            delete toDelete;
        }
        
        if(!DisplaySSM.isEmpty()){
            try{
                upsert DisplaySSM;                
            }
            catch(exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
                return null;
            }
        }
        if(shownext3 == false)
        {
            Pagereference pr = new Pagereference('/'+idSPEPlanID);
            pr.setRedirect(true);
            return pr;
        }
 
        return null;
    }
    public pagereference gotoDetailPageforNoRecords(){
        selectwrappsupp();
        if(!toDelete.isEmpty())
        {
            delete toDelete;
        }
        Pagereference pr = new Pagereference('/'+idSPEPlanID);
        pr.setRedirect(true);
        return pr;
    }
    public class SupplierWrapper implements Comparable
    {
        public Boolean isChecked {get;set;}
        public Boolean isSelected {get;set;}
        public String strEnterpriseName {get;set;}
        public String strSupplierName {get;set;}
        public Account accwrap{get;set;}
        public Id idEntId{get;set;}
        Id idPlanSuppId;
        boolean isExisting;
        SPE_ScorecardSupplierMap__c scMap;
        
        public Integer compareTo(Object compareTo) {
        SupplierWrapper compareToSupp = (SupplierWrapper)compareTo;
        if (strSupplierName == compareToSupp.strSupplierName) return 0;
        if (strSupplierName > compareToSupp.strSupplierName) return 1;
        return -1;        
        }
    }
    public void firstBtnClick3(){
            selectwrappsupp();
            pageNumber3 = 1;
            System.debug('pageNumber----->' + pageNumber);
            DisplaySSM.clear();
            DisplaySSM= new List<SPE_ScorecardSupplierMap__c>();
           
                for(integer i=0;i<DEFAULT_PAGE_SIZE3;i++){
                    try{
                        DisplaySSM.add(lstSSM[i]);
                    }catch(exception e){}
                }
                startRecNo3=1;
                endRecNo3=DEFAULT_PAGE_SIZE3;
                supplistsize3 = lstSSM.size();
                shownext3 = true;
                showprevoius3 = false;
                showlast3=true;
                showfirst3=false;
 
        }
        //***************************************************Next Button******************************
        public void nextBtnClick3(){
            selectwrappsupp();
            pageNumber3 = pageNumber3+1;
            System.debug('pageNumber3----->' + pageNumber3);
            DisplaySSM.clear();
            DisplaySSM= new List<SPE_ScorecardSupplierMap__c>();
            if(pageNumber3== maxPages3){
                for(integer i=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3); i<lstSSM.size(); i++)           
                {
                    try{
                        DisplaySSM.add(lstSSM[i]);
                    }catch(exception e){}
                }
                shownext3 = false;
                showlast3=false;
    
                startRecNo3=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3)+1;
                endRecNo3=lstSSM.size();
                supplistsize3 =lstSSM.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3); i<(DEFAULT_PAGE_SIZE3*pageNumber3); i++)           
                {
                    try{
                        DisplaySSM.add(lstSSM[i]);
                    }catch(exception e){}
                }
    
                startRecNo3=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3)+1;
                endRecNo3=(DEFAULT_PAGE_SIZE3*pageNumber3);
                supplistsize3 = lstSSM.size();
    
                shownext3 = true;
                showlast3=true;
            }
            showprevoius3 = true;
            showfirst3=true;
        }
        
    public void previousBtnClick3(){
            selectwrappsupp();
            pageNumber3 = pageNumber3-1;
            System.debug('pageNumber3----->' + pageNumber3);
            DisplaySSM.clear();
            DisplaySSM= new List<SPE_ScorecardSupplierMap__c>();
            for(integer i=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3); i<(DEFAULT_PAGE_SIZE3*pageNumber3); i++)           
            {
                try{
                    DisplaySSM.add(lstSSM[i]);
                }catch(exception e){}
            }
    
            startRecNo3=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3)+1;
            endRecNo3=(DEFAULT_PAGE_SIZE3*pageNumber3);
            supplistsize3 = lstSSM.size();
    
            shownext3 = true;
            showprevoius3 = true;
            showlast3=true;
            showfirst3=true;
    
    
            if(pageNumber3 == 1){
                showprevoius3 = false;
                showfirst3=false;
            }
            else{
                showprevoius3 = true;
            }
        }
        public void lastBtnClick3(){
            selectwrappsupp();
            pageNumber3 = maxPages3;
            //System.debug('pageNumber3----->' + pageNumber3);
            DisplaySSM.clear();
            DisplaySSM = new list<SPE_ScorecardSupplierMap__c>();
    
            for(integer i =(maxPages3-1)*DEFAULT_PAGE_SIZE3;i<lstSSM.size();i++)           
            {
                try{
                    DisplaySSM.add(lstSSM[i]);
                }catch(exception e){}
            }
    
            startRecNo3=((maxPages3-1)*DEFAULT_PAGE_SIZE3)+1;
            endRecNo3=lstSSM.size();
            supplistsize3= lstSSM.size();
    
            shownext3 = false;
            showprevoius3 = true;
            showlast3=false;
            showfirst3=true;
        }
     public void goToPage3(){
            selectwrappsupp();
            try
            {
                pageNumber3 = integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum3').trim());
            }
            catch(exception ex)
            {
                pageNumber3=1;
            }
    
            if(pageNumber3>maxPages3)
                pageNumber3=maxPages3;
                
            if(pageNumber3<1)// to handle the negative digit as page number
                pageNumber3=1;
                
            DisplaySSM.clear();    
            DisplaySSM = new list<SPE_ScorecardSupplierMap__c>();
            if(pageNumber3 == maxPages3){
                for(integer i=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3); i<lstSSM.size(); i++)           
                {
                    try{
                        DisplaySSM.add(lstSSM[i]);
                    }catch(exception e){}
                }
    
                startRecNo3=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3)+1;
                endRecNo3=lstSSM.size();
                supplistsize3 = lstSSM.size();
    
                if(pageNumber3==1)
                {
                    shownext3= false;
                    showlast3=false;
                    showprevoius3 = false;
                    showfirst3=false;
                }else
                {
                    shownext3 = false;
                    showlast3=false;
                    showprevoius3 = true;
                    showfirst3=true;
                }
    
            }
            else if(pageNumber3 == 1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE3;i++)           
                {
                    try{
                        DisplaySSM.add(lstSSM[i]);
                    }catch(exception e){}
                }
    
                startRecNo3=1;
                endRecNo3=DEFAULT_PAGE_SIZE3;
                supplistsize3 = lstSSM.size();
                shownext3 = true;
                showlast3=true;
                showprevoius3 = false;
                showfirst3=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3); i<(DEFAULT_PAGE_SIZE3*pageNumber3); i++)           
                {
                    try{
                        DisplaySSM.add(lstSSM[i]);
                    }catch(exception e){}
                }
    
                startRecNo3=((DEFAULT_PAGE_SIZE3*pageNumber3)-DEFAULT_PAGE_SIZE3)+1;
                endRecNo3=(DEFAULT_PAGE_SIZE3*pageNumber3);
                supplistsize3= lstSSM.size();
    
                shownext3 = true;
                showlast3=true;
                showprevoius3 = true;
                showfirst3=true;
            }
        }   
}