public without sharing class SPE_InsertSupplier_New{
    
    SPE_SPEPlan__c objSG;
    SPE_Spend__c Spendvalues;
    String idSPEPlanID;
    
    
      
  //****************************Changes for Encryption*************************//  
    //private Set<String> existSupplier = new Set<String>();
    //private Set<Id> existSupplierId = new Set<Id>();
  //****************************END*************************//   
  
    Transient List<SPE_SPEPlanSupplierMap__c> lstExistingSuppliers;
    public String supplierName {get;set;}
    public String supplierName2 {get;set;}
    public boolean isShowSuppliers{get;set;}
    public boolean isSearch{get;set;}
    public boolean isSearch2{get;set;}
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
    
    public list<String> AlphaList {get; set;}
    Transient List<SupplierWrapper> DisplaySupplierWrapperList;
    List<SupplierWrapper> templistSupplierWrapper;
    Map<String,String> tempMapDeSupplierWrapper;
    
    public list<String> AlphaList2 {get; set;}
    Transient List<SupplierWrapper> DisplaySupplierWrapperList2;
    
    public List<SPE_SPEPlanSupplierMap__c> lstSSM{get;set;}
    public SPE_SPEPlanSupplierMap__c objSSM{get;set;}
    List<SPE_SPEPlanSupplierMap__c> toDelete;
    
    
    
    public SPE_InsertSupplier_New(Apexpages.Standardcontroller st){
        idSPEPlanID = st.getId();
        
        isShowSuppliers = true;
        isSearch = false;
        isSearch2 = false;
        isDisplayError = False;
        objSG = new SPE_SPEPlan__c();
        sortname = '';
        sortname2 = '';
        
        SupplierWrapperList = new List<SupplierWrapper>();
        setIds = new Set<Id>();
        
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
        
        templistSupplierWrapper = new List<SupplierWrapper>();
        tempMapDeSupplierWrapper = new Map<String,String>();
        toDelete = new List<SPE_SPEPlanSupplierMap__c>();
        //*************initialization alpha list**********//
        AlphaList = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
        
        objSG = [SELECT Id, BusinessLine__c,BusinessUnit__c,CategoryCluster__c,CategoryGroup__c,Category__c,Country__c,
                  Product__c,Project__c,Region__c,SubRegion__c  FROM SPE_SPEPlan__c
                       WHERE Id =: idSPEPlanID];
               
         
         
        alphasortname();
        
      }                                              
                
        //************************Method For Alphabaticall sorting*********************//
        public void selectwrappsupp()
        {
           isSearch2 = false;                      
           lstExistingSuppliers = new List<SPE_SPEPlanSupplierMap__c>();
           lstExistingSuppliers = [SELECT Id, Supplier__c, Supplier__r.Name, Supplier__r.EnterpriseId__c
                                                   FROM SPE_SPEPlanSupplierMap__c
                                                   WHERE SPEPlan__c =: idSPEPlanID];
         lstExistingSuppliers.sort();
         List<SPE_Spend__c> SpendList = new List<SPE_Spend__c>();
///----------------------------------------------Add Supplier with spend data -------------------------------//
            
            boolean queryFlag = false;
            
            string query = 'Select Id,EnterpriseId__c,EnterpriseId__r.EnterpriseId__c,EnterpriseId__r.Name, Period__c from SPE_Spend__c where EnterpriseId__c != Null ';


            //-----------------------Get Highest Category Scope--------------------------------------//

            if(objSG.Category__c != 'All Categories')
            {
                query = query + 'and Category__c =\''+objSG.Category__c+'\'';
                queryFlag = true;
            }               
            else if(objSG.CategoryGroup__c!='All Category Groups')
            {
                query = query + 'and CategoryGroup__c =\''+objSG.CategoryGroup__c+'\'';
                queryFlag = true;
            }               
            else if(objSG.CategoryCluster__c!='All Category Areas')
            {
                query = query + 'and CategoryArea__c =\''+objSG.CategoryCluster__c+'\'';
                queryFlag = true;
            }
                
        
            //----------------------------------------------------------------------------------------//

            if(objSG.Project__c!='All Projects')
            {
                query = query +' and Project__c = \''+objSG.Project__c+'\'';
                queryFlag = true;
            }               
            else if(objSG.Country__c!='All Countries')
            {
                query = query +' and Country__c = \''+objSG.Country__c+'\'';
                queryFlag = true;
            }               
            else if(objSG.SubRegion__c!='All Market Units')
            {
                query = query +' and Sub_Region__c = \''+objSG.SubRegion__c+'\'';
                queryFlag = true;
            }               
            else if(objSG.Region__c!='All Markets')
            {
                query = query +' and Region__c = \''+objSG.Region__c+'\'';
                queryFlag = true;
            }               

            //----------------------------------------------------------------------------------------//
            
            system.debug('Query : '+query);
            
            if(queryFlag)
            SpendList = Database.query(query);
            
            system.debug('**size of spend List :'+SpendList.size());
///-----------------------------------------------------------------------------------------------------------//
                        
            
           DisplaySupplierWrapperList = new List<SupplierWrapper>();
           SupplierWrapperList = new List<SupplierWrapper>();
           Map<String,String> DeselectedSupplierMap = new Map<String,String>();
           
            for(SPE_SPEPlanSupplierMap__c ssmT : lstExistingSuppliers){
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
                
                setIds.add(sc.idEntId);
               
                
             //****************************Changes for Encryption*************************// 
                //existSupplier.add(ssmT.Supplier__r.EnterpriseId__c);            
                //existSupplierId.add(ssmT.Supplier__c);
             //****************************END*************************//   
                
            }    
            
            for(SPE_Spend__c  spend: SpendList){
                if(!setIds.contains(spend.EnterpriseId__c)){
                    SupplierWrapper sc1 = new SupplierWrapper();
                    sc1.isChecked = true;
                    sc1.strEnterpriseName = spend.EnterpriseId__r.EnterpriseId__c;
                    sc1.strSupplierName = spend.EnterpriseId__r.Name;
                    sc1.idEntId = spend.EnterpriseId__c;
                    sc1.accwrap = spend.EnterpriseId__r;
                    sc1.accwrap.Name = spend.EnterpriseId__r.Name;
                    sc1.accwrap.EnterpriseId__c = spend.EnterpriseId__r.EnterpriseId__c;
                    sc1.isExisting = false;
                    templistSupplierWrapper.add(sc1);
                    
                    setIds.add(sc1.idEntId);
                 }
                
             //****************************Changes for Encryption*************************// 
                //existSupplier.add(ssmT.Supplier__r.EnterpriseId__c);            
                //existSupplierId.add(ssmT.Supplier__c);
             //****************************END*************************//   
                
            }                          
              
            for(SupplierWrapper sw : subwrapperList2){
                if(sw.isChecked){                
                    //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+sw.isChecked);
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
                    toDelete = new List<SPE_SPEPlanSupplierMap__c>();
                    
                    for(SupplierWrapper scws : DisplaySupplierWrapperList)
                    {                    
                        if(tempMapDeSupplierWrapper.containsKey(scws.strSupplierName))
                        {
                            scws.isChecked  = False;
                            SPE_SPEPlanSupplierMap__c s = new SPE_SPEPlanSupplierMap__c (id=scws.idPlanSuppId,SPEPlan__c=idSPEPlanID);
                            toDelete.add(s);
                        }
                    } 
                }  
                
                if(templistSupplierWrapper.size()>0)
                 {
                     DisplaySupplierWrapperList.addAll(templistSupplierWrapper);
                 }
                 
    //------------Added for top search suppliers----------------
          
        
        if(supplierName2 !='' && supplierName2 !=Null){
            //*************initialization alpha list**********//
            //AlphaList = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
            SupplierWrapperListSelected = new List<SupplierWrapper>();
            List<SupplierWrapper> tempList = new List<SupplierWrapper>();
            String searchString = supplierName2;
            
            if   (searchString !=null && searchString.containsIgnoreCase('*'))
            {
              //searchString = searchString.replaceAll('[*]', '%');
            }
            
         if (supplierName2 != '' && supplierName2 != '*')
            {
          //*******************************Changes For Encryption***********************//
                                                                                                         
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
                 
          for (SupplierWrapper a : DisplaySupplierWrapperList)
            {
                if(a.strEnterpriseName!=null){
                String s = a.strEnterpriseName;
                Matcher MyMatcher = MyPattern.matcher(s);
                
                if (MyMatcher.find())
                {
                    SupplierWrapper sw = new SupplierWrapper();
                    sw.isChecked = true;
                    sw.strEnterpriseName = a.strEnterpriseName;
                    sw.strSupplierName = a.strSupplierName;
                    sw.idEntId = a.idEntId;
                    sw.accwrap = a.accwrap;
                    sw.accwrap.Name = a.accwrap.Name;
                    sw.accwrap.EnterpriseId__c = a.accwrap.EnterpriseId__c;
                    sw.isExisting = false;
                    tempList.add(sw);
                }
              }  
             
            }
             if(tempList.size()>0){
                  DisplaySupplierWrapperList.clear();
                  DisplaySupplierWrapperList.addAll(tempList);
                  
              }
              else{
               isSearch2 = true;
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display here'));
              }
              
            }
         
    }
   

//-----------------------------------       

              if (sortname == null || sortname == 'All') {
                    for(SupplierWrapper scOj : DisplaySupplierWrapperList)
                             {
                                 SupplierWrapperList.add(scOj);
                                 hasRecords = true;                         
                                 integer remainder = math.MOD(SupplierWrapperList.size(),DEFAULT_PAGE_SIZE);
                                 if(remainder == 0){
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
                     System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+DisplaySupplierWrapperList.size());
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
                      if(SupplierWrapperList.size() == 0)
                      {                          
                          System.debug('Enter Here'+SupplierWrapperList.size());
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
                /*if(DisplaySupplierWrapperList.size()>0)
                {
                    SupplierWrapperList.addAll(DisplaySupplierWrapperList); 
                }*/
                for(SupplierWrapper scw : SupplierWrapperList)
                {
                    AddedSupplierMap.put(scw.strSupplierName,scw.strSupplierName);
                }
                
                for(SupplierWrapper scws : DisplaySupplierWrapperList2)
                {
                    if(AddedSupplierMap.containsKey(scws.strSupplierName))
                    {
                        scws.isChecked  = True;
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
            //isDisplayError = True;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please provide atleast one character for the wild card search'));
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
                  if(SupplierWrapperListSelected.size() == 0)
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
            lstSSM = new List<SPE_SPEPlanSupplierMap__c>();
            if(subwrapperList2.size() > 0 || templistSupplierWrapper.size() > 0)
            {
            for(SupplierWrapper sw : templistSupplierWrapper){
                if(sw.isChecked){
                    objSSM = new SPE_SPEPlanSupplierMap__c();
                    objSSM.Supplier__c = sw.idEntId;
                    objSSM.SPEPlan__c=idSPEPlanID;
                    if(sw.idPlanSuppId != null)
                        objSSM.Id = sw.idPlanSuppId;
                    lstSSM.add(objSSM);
                }
            }
          }
        else{
            if(subwrapperList2.size() == 0)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please add suppliers to proceed'));
            else
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please click "Add" button to add the suppliers to proceed'));
        }
        system.debug('lstSSM----' + lstSSM);
        if(!toDelete.isEmpty())
        {
            delete toDelete;
        }
        
        if(!lstSSM.isEmpty()){
            try{
                upsert lstSSM;                
            }
            catch(exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
                return null;
            }
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
        SPE_SPEPlanSupplierMap__c scMap;
        
        public Integer compareTo(Object compareTo) {
        SupplierWrapper compareToSupp = (SupplierWrapper)compareTo;
        if (strSupplierName == compareToSupp.strSupplierName) return 0;
        if (strSupplierName > compareToSupp.strSupplierName) return 1;
        return -1;        
    }
    }   
}