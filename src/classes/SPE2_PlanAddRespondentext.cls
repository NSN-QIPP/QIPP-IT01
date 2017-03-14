public with sharing class SPE2_PlanAddRespondentext{
    private ApexPages.StandardController std;
    public String spePlanIdentifier{get;set;}
    
    public String contactName{get;set;}
    
    public List<SupplierWrapper> suppWrapperlist;
    public List<SupplierWrapper> suppWrapperlist2;
    public List<SPE_SPEPlan__c> speplanlist;
    
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
    public List<SupplierWrapper> subwrapperList{get;set;}
    
    public boolean isSuggested{get;set;}
        
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
    public boolean isSearch{get;set;}
    
    public SPE2_PlanAddRespondentext(ApexPages.StandardController std){       
        this.std = std;
        isSuggested = true;
        
        speplanlist = new List<SPE_SPEPlan__c>();
        
        DEFAULT_PAGE_SIZE = 50;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        supplistsize=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        subwrapperList = new list<SupplierWrapper>();    
        suppWrapperlist = new List<SupplierWrapper>();
        
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
        suppWrapperlist2 = new List<SupplierWrapper>();
        isSearch = false;
    }
    
    public void fetchRespondent(){
        DEFAULT_PAGE_SIZE = 50;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        supplistsize=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        subwrapperList = new list<SupplierWrapper>();
        
        spePlanIdentifier = apexpages.currentpage().getparameters().get('planIdentifier');
        speplanlist = [Select ID,SPEPlanName__c,identifierParam__c,
                                            Region__c,SubRegion__c,Country__c,Project__c,
                                            CategoryCluster__c,CategoryGroup__c,Category__c,
                                            BusinessUnit__c,BusinessLine__c,Product__c from SPE_SPEPlan__c
                                            where identifierParam__c = :spePlanIdentifier];
        
        Set<ID> SPEPlanSet = new Set<ID>();                                    
        Map<String,String> ScopeValueCombination = new Map<String,String>();
        for(SPE_SPEPlan__c sp:speplanlist){
            String scopecombinations = sp.Region__c+';'+sp.SubRegion__c+';'+sp.Country__c+';'+sp.Project__c+';'+sp.CategoryCluster__c+';'+sp.CategoryGroup__c+';'+sp.Category__c+';'+sp.BusinessUnit__c+';'+sp.BusinessLine__c+';'+sp.Product__c;
            ScopeValueCombination.put(scopecombinations,scopecombinations);
            SPEPlanSet.add(sp.ID); 
        }
        System.Debug('**ScopeValueCombination**'+ScopeValueCombination);
        
        String  BusRole = Business_System_Role__c.getValues('SPE Plan').Business_Role__c;
        List<string> BusRoleList = new List<string>();
        for(String key : BusRole.split(';')){
         BusRoleList.add(key);
        }
        
        String  SysRole = Business_System_Role__c.getValues('SPE Plan').System_Role__c;
        List<string> SysRoleList = new List<string>();
        for(String key : SysRole.split(';')){
         SysRoleList.add(key);
        }
        
        List<SPE_SPEPlanSupplierMap__c> suppMapList = [Select Supplier__c from SPE_SPEPlanSupplierMap__c where SPEPlan__c IN: SPEPlanSet];
        Set<ID> AccountSet = new Set<ID>();
        for (SPE_SPEPlanSupplierMap__c splmap : suppMapList){
         AccountSet.add(splmap.Supplier__c);
        }
        
        List<SPE_CategoryInfo__c> spendlist = [Select ID,Business_Role__c,System_Role__c,Contact__c,Contact__r.AccountID,Contact__r.Name,
                                               Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,
                                               CategoryScopeCombination__c,Supplier__c,Supplier__r.Name from SPE_CategoryInfo__c where
                                               CategoryScopeCombination__c IN: ScopeValueCombination.values()
                                               AND Supplier__c IN: AccountSet AND Business_Role__c IN: BusRoleList
                                               AND System_Role__c IN:SysRoleList];
        
        Map<String,SPE_CategoryInfo__c> uniqueSpendList = new Map<String,SPE_CategoryInfo__c>();
        for(SPE_CategoryInfo__c uniobj: spendlist){
            uniqueSpendList.put(uniobj.Contact__r.Name,uniobj);
        }
        
        System.Debug('**spendlist **'+spendlist );
        for(SPE_CategoryInfo__c spendobj: uniqueSpendList.values()){
                SupplierWrapper sc = new SupplierWrapper();
                sc.isSelected = false;
                sc.conwrap.FirstName = spendobj.Contact__r.FirstName;
                sc.conwrap.LastName = spendobj.Contact__r.LastName;
                sc.conwrap.Email = spendobj.Contact__r.Email;
                sc.idEntId = spendobj.Contact__c;
                sc.contactSource = 'Smart Contact';
                sc.BusinessRole = spendobj.Business_Role__c;
                sc.SystemRole = spendobj.System_Role__c; 
                sc.SupplierName = spendobj.Supplier__r.Name; 
                suppWrapperlist.add(sc);
        }
        
        suppWrapperlist.sort();
        if(suppWrapperlist.size()>0)
         {    
         hasRecords = true;
         integer remainder = math.MOD(suppWrapperlist.size(),DEFAULT_PAGE_SIZE);
             if(remainder ==0){
                maxPages = suppWrapperlist.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages = suppWrapperlist.size()/DEFAULT_PAGE_SIZE + 1;
             }
 
              if(suppWrapperlist.size() > DEFAULT_PAGE_SIZE){
                    firstBtnClick();      
                }
               else{
                    for(SupplierWrapper scOj : suppWrapperlist){
                         subwrapperList.add(scOj);
                     }
                     startRecNo=1;
                     endRecNo=suppWrapperlist.size();
                     supplistsize = suppWrapperlist.size();
                     shownext = false;
                     showprevoius = false;
                }
        }
         
       if(suppWrapperlist.size() == 0)
       {                          
          System.debug('Enter Here'+suppWrapperlist.size());
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
            pageNumber = 1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new List<SupplierWrapper>();
            if(suppWrapperlist.size() > DEFAULT_PAGE_SIZE)
            {
                for(integer i=0;i<DEFAULT_PAGE_SIZE;i++){
                    subwrapperList.add(suppWrapperlist[i]);
                }
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = suppWrapperlist.size();
                shownext = true;
                showprevoius = false;
                showlast=true;
                showfirst=false;
             }else
             {
                 for(integer i=0;i<suppWrapperlist.size();i++){
                     try{
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
                }
                startRecNo=1;
                endRecNo=suppWrapperlist.size();
                supplistsize = suppWrapperlist.size();
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
            pageNumber = pageNumber+1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<suppWrapperlist.size(); i++)           
                {
                    try{
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=suppWrapperlist.size();
                supplistsize = suppWrapperlist.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = suppWrapperlist.size();
    
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
            pageNumber = pageNumber-1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                try{
                    subwrapperList.add(suppWrapperlist[i]);
                }catch(exception e){}
            }
    
            startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
            endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
            supplistsize = suppWrapperlist.size();
    
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
            pageNumber = maxPages;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<SupplierWrapper>();
    
            for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<suppWrapperlist.size();i++)           
            {
                try{
                    subwrapperList.add(suppWrapperlist[i]);
                }catch(exception e){}
            }
    
            startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
            endRecNo=suppWrapperlist.size();
            supplistsize = suppWrapperlist.size();
    
            shownext = false;
            showprevoius = true;
            showlast=false;
            showfirst=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage(){
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
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<suppWrapperlist.size(); i++)           
                {
                    try{
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=suppWrapperlist.size();
                supplistsize = suppWrapperlist.size();
    
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
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
                }
    
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = suppWrapperlist.size();
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
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = suppWrapperlist.size();
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
        
    //*******************************************Pagination End***********************************//
    
    public void goToSearchPage(){
        isSuggested = false;
    } 
     
    public PageReference returnbackToPlan(){
       Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
       String keyPrefix = r.getKeyPrefix();
       Pagereference pr =new Pagereference('/'+keyPrefix);
       return pr;
    }
    
    public void searchSuppliers(){
        isSearch = true;
        DEFAULT_PAGE_SIZE2 = 500;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        
        if(contactName !='' && contactName !=Null){
            //*************initialization alpha list**********//
            suppWrapperlist2 = new List<SupplierWrapper>();
            String searchString = contactName;
            
         if (contactName != '' && contactName != '*')
            {
                                
              List<Contact> conList = [SELECT Id,Name,AccountId,Account.Name,FirstName,LastName,Email
                                             FROM Contact
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
         
          for (Contact c : conList)
            {
             if (c.Name != null)
             {   
                
                String s = c.Name;
                Matcher MyMatcher = MyPattern.matcher(s);
                
                if (MyMatcher.find())
                {
                    SupplierWrapper sc = new SupplierWrapper();
                    sc.isSelected = false;
                    sc.conwrap = c;
                    sc.conwrap.FirstName = c.FirstName;
                    sc.conwrap.LastName = c.LastName;
                    sc.conwrap.Email = c.Email;
                    sc.conwrap.AccountId = c.AccountId;
                    sc.idEntId = c.Id;
                    suppWrapperlist2.add(sc);
                    if (suppWrapperlist2.size()>900)
                    {
                      break;
                    } 
                }
              }  
            }
          }                
        }
        else{
            isSearch = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please provide atleast one character for the wild card search'));
        }
        
        suppWrapperlist2.sort();
        
        subwrapperList2.clear();
        subwrapperList2 = new list<SupplierWrapper>();
        
        if(suppWrapperlist2.size()>0)
         {
         hasRecords2 = true;
         integer remainder = math.MOD(suppWrapperlist2.size(),DEFAULT_PAGE_SIZE2);
            if(remainder ==0){
               maxPages2 = suppWrapperlist2.size()/DEFAULT_PAGE_SIZE2;
            }
            else{
               maxPages2 = suppWrapperlist2.size()/DEFAULT_PAGE_SIZE2 + 1;
            }
 
            if(suppWrapperlist2.size() > DEFAULT_PAGE_SIZE2){
                  firstBtnClick2();      
            }
            else{
                for(SupplierWrapper scOj : suppWrapperlist2){
                     subwrapperList2.add(scOj);
                 }
                 startRecNo2=1;
                 endRecNo2=suppWrapperlist2.size();
                 supplistsize2=suppWrapperlist2.size();
                 shownext2 = false;
                 showprevoius2 = false;
             }
         }
         if(suppWrapperlist2.size() == 0)
         {
             pageNumber2 = 0;
             maxPages2 = 0;
             supplistsize2=0;
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
         } 
    }
    
    /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick2(){
            pageNumber2 = 1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
    
            for(integer i=0;i<DEFAULT_PAGE_SIZE2;i++){
                try{
                    subwrapperList2.add(suppWrapperlist2[i]);
                }catch(exception e){}
            }
            startRecNo2=1;
            endRecNo2=DEFAULT_PAGE_SIZE2;
            supplistsize2=suppWrapperlist2.size();
    
            shownext2 = true;
            showprevoius2 = false;
            showlast2=true;
            showfirst2=false;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick2(){
            pageNumber2 = pageNumber2+1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<suppWrapperlist2.size(); i++)           
                {
                    try{
                    subwrapperList2.add(suppWrapperlist2[i]);
                    }catch(exception e){}
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=suppWrapperlist2.size();
                supplistsize2=suppWrapperlist2.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(suppWrapperlist2[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
                supplistsize2=suppWrapperlist2.size();
                
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
            pageNumber2 = pageNumber2-1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            
            for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
            {
                try{
                    subwrapperList2.add(suppWrapperlist2[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
            endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
            supplistsize2=suppWrapperlist2.size();   
    
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
            pageNumber2 = maxPages2;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<SupplierWrapper>();
    
            for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE2;i<suppWrapperlist2.size();i++)           
            {
                try{
                    subwrapperList2.add(suppWrapperlist2[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE2)+1;
            endRecNo2=suppWrapperlist2.size();
            supplistsize2=suppWrapperlist2.size();
    
            shownext2 = false;
            showprevoius2 = true;
            showlast2=false;
            showfirst2=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage2(){
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
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<suppWrapperlist2.size(); i++)           
                {
                    try{
                        subwrapperList2.add(suppWrapperlist2[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=suppWrapperlist2.size();
    
    
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
                        subwrapperList2.add(suppWrapperlist2[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=1;
                endRecNo2=DEFAULT_PAGE_SIZE2;
                supplistsize2=suppWrapperlist2.size();
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
                        subwrapperList2.add(suppWrapperlist2[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
                supplistsize2=suppWrapperlist2.size();
    
                shownext2 = true;
                showlast2=true;
                showprevoius2 = true;
                showfirst2=true;
            }
        }
        
    //*******************************************Pagination End***********************************//
    
    public PageReference AddToPlans(){
       List<SPE_Respondent__c> lstSSM = new List<SPE_Respondent__c>();
       List<SPE_Respondent__c> tobeInsertedSSM = new List<SPE_Respondent__c>();
       
       lstSSM = [Select ID,Contact__c,SPEPlan__c from SPE_Respondent__c where SPEPlan__c IN: speplanlist];
       Map<String,String> matchInsertedSupplier = new Map<String,String>();
       
       for(SPE_Respondent__c spSSM: lstSSM){
           String temp = spSSM.Contact__c+';'+spSSM.SPEPlan__c;
           matchInsertedSupplier.put(temp,temp);
       }
       
       for(SPE_SPEPlan__c sp: speplanlist){
           if(suppWrapperlist.size() > 0){
               for(SupplierWrapper sw : suppWrapperlist){
                   if(sw.isSelected && (!matchInsertedSupplier.containsKey(sw.idEntId+';'+sp.ID))){
                       SPE_Respondent__c objSSM = new SPE_Respondent__c();
                       objSSM.SPEPlan__c=sp.ID;
                       objSSM.Contact__c = sw.idEntId;
                       tobeInsertedSSM.add(objSSM);
                   }
               }
           }
       }
       
       try{
           if(!tobeInsertedSSM.isEmpty()){
               insert tobeInsertedSSM;
           }
       }catch(Exception e){}
       
       Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
       String keyPrefix = r.getKeyPrefix();
       Pagereference pr =new Pagereference('/'+keyPrefix);
       return pr;
    }
    
    public PageReference AddToPlans2(){
       List<SPE_Respondent__c> lstSSM2 = new List<SPE_Respondent__c>();
       List<SPE_Respondent__c> tobeInsertedSSM2 = new List<SPE_Respondent__c>();
       
       lstSSM2 = [Select ID,Contact__c,SPEPlan__c from SPE_Respondent__c where SPEPlan__c IN: speplanlist];
       Map<String,String> matchInsertedSupplier2 = new Map<String,String>();
       
       for(SPE_Respondent__c spSSM: lstSSM2){
           String temp = spSSM.Contact__c+';'+spSSM.SPEPlan__c;
           matchInsertedSupplier2.put(temp,temp);
       }
       for(SPE_SPEPlan__c sp: speplanlist){
           if(suppWrapperlist2.size() > 0){
               for(SupplierWrapper sw : suppWrapperlist2){
                   if(sw.isSelected && (!matchInsertedSupplier2.containsKey(sw.idEntId+';'+sp.ID))){
                       SPE_Respondent__c objSSM = new SPE_Respondent__c();
                       objSSM.Contact__c = sw.idEntId;
                       objSSM.SPEPlan__c=sp.ID;
                       tobeInsertedSSM2.add(objSSM);
                   }
               }
           }
       }
       
       try{
           if(!tobeInsertedSSM2.isEmpty()){
               insert tobeInsertedSSM2;
           }
       }catch(Exception e){}
       
       Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
       String keyPrefix = r.getKeyPrefix();
       Pagereference pr =new Pagereference('/'+keyPrefix);
       return pr;
    }  
     
    public class SupplierWrapper implements Comparable{
        public boolean isSelected{get;set;}
        public Contact conwrap{get;set;}
        public Id idEntId{get;set;}
        public String contactSource{get;set;}
        public String BusinessRole{get;set;}
        public String SystemRole{get;set;}
        public String SupplierName{get;set;}
        
        public SupplierWrapper(){
            conwrap = new Contact();
        }
        
        public Integer compareTo(Object compareTo) {
            SupplierWrapper compareToSupp = (SupplierWrapper)compareTo;
            if (conwrap.Name == compareToSupp.conwrap.Name) return 0;
            if (conwrap.Name > compareToSupp.conwrap.Name) return 1;
            return -1;        
        }
    }
}