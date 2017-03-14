public with sharing class SPE2_ConsequenceMngtAddContactExt 
{
    public SPE_ConsequenceManagement__c speConsequenceMngt;
    public String contactName{get;set;}
    private ApexPages.StandardController std;
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
    public List<SupplierWrapper> tempWrapperlist;   
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
    public List<SupplierWrapper> tempWrapperlist2;
    public boolean isSearch{get;set;}   
    public Boolean isInternalCheck{get;set;}
    public Boolean isInternalCheck2{get;set;}
    private String defaultQuery;
    public ID cmID; 
    public boolean displayPopup {get; set;}  
    public contact con{get;set;}
    public List<String> BusRoleList {get;set;}
    public List<string> SysRoleList{get;set;}
    public String BusRoleSelected {get;set;}
    public string SysRoleSelected{get;set;}
    public boolean displayPopup2 {get; set;} 
    public String conTargetId{get;set;}
    public SPE2_ConsequenceMngtAddContactExt(Apexpages.Standardcontroller std)
    {
        this.std = std;
        cmID = std.getId();
        DEFAULT_PAGE_SIZE = 5;
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
        tempWrapperlist = new List<SupplierWrapper>();
        tempWrapperlist2 = new List<SupplierWrapper>();
        con = new contact();
        DEFAULT_PAGE_SIZE2 = 25;
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
        
        isInternalCheck = False;
        isInternalCheck2 = False;
        
        List<Business_System_Role__c> BusSyslist = [Select Name,Business_Role__c,System_Role__c,Object_Name__c from  Business_System_Role__c where Object_Name__c = 'Consequence Management'];
        Set<String> allBusRole = new Set<String>();
        Set<String> allSysRole = new Set<String>();
        if(bussyslist.size() > 0){
            for(Business_System_Role__c BSRole: BusSyslist){
                if(BSRole.Business_Role__c != Null){
                   allBusRole.add(BSRole.Business_Role__c); 
                }
                if(BSRole.System_Role__c != Null){
                   allSysRole.add(BSRole.System_Role__c); 
                }
            }
        }
        System.Debug('allBusRole'+allBusRole);
        
        //String  BusRole = Business_System_Role__c.getValues('Consequence Management').Business_Role__c;
        BusRoleList = new List<string>();
        for(String BusRole: allBusRole){            
            for(String key : BusRole.split(';')){
                BusRoleList.add(key);
            }
        }
        
        //String  SysRole = Business_System_Role__c.getValues('Consequence Management').System_Role__c;
        SysRoleList = new List<string>();
        for(String SysRole: allSysRole){
            for(String key : SysRole.split(';')){
                SysRoleList.add(key);
            }
        }
        
        System.Debug('BusRoleList'+BusRoleList);
        System.Debug('SysRoleList'+SysRoleList);
        speConsequenceMngt = [SELECT Id, CategoryManager__c,CategoryCluster__c,
                              CategoryArea__c,CategoryGroup__c,Category__c, 
                              Market__c,MarketUnit__c,Country__c,Project__c,
                              BusinessUnit__c,BusinessLine__c,Product__c,
                              Supplier__c, Supplier__r.EnterpriseId__c, 
                              SupplierManagerContact__c,Contact__r.AccountID,Contact__r.isInternal__c,Contact__r.Name, Contact__c,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email
                              FROM SPE_ConsequenceManagement__c 
                              WHERE Id =: cmID];
        
        Map<String,String> ScopeValueCombination = new Map<String,String>();
        String scopecombinations = speConsequenceMngt.Market__c+';'+speConsequenceMngt.MarketUnit__c+';'+speConsequenceMngt.Country__c+';'+speConsequenceMngt.Project__c+';'+speConsequenceMngt.CategoryArea__c+';'+speConsequenceMngt.CategoryGroup__c+';'+speConsequenceMngt.Category__c+';'+speConsequenceMngt.BusinessUnit__c+';'+speConsequenceMngt.BusinessLine__c+';'+speConsequenceMngt.Product__c;
        ScopeValueCombination.put(scopecombinations,scopecombinations);
        
        ID accid = speConsequenceMngt.Supplier__c;
        
        List<SPE_CategoryInfo__c> spendlist = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Contact__c,Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,Contact__r.isInternal__c,CategoryScopeCombination__c from SPE_CategoryInfo__c where
                                               CategoryScopeCombination__c IN: ScopeValueCombination.values() 
                                               AND Business_Role__c IN: BusRoleList
                                               AND System_Role__c IN: SysRoleList
                                               AND Supplier__c =: accid];
        
        System.Debug('spendlist'+spendlist);
        Map<String,SPE_CategoryInfo__c> uniqueSpendList = new Map<String,SPE_CategoryInfo__c>();
        for(SPE_CategoryInfo__c uniobj: spendlist){
            uniqueSpendList.put(uniobj.Contact__r.Email,uniobj);
        }
        
        for(SPE_CategoryInfo__c spendobj: uniqueSpendList.values()){
            SupplierWrapper sc = new SupplierWrapper();
            sc.conwrap.FirstName = spendobj.Contact__r.FirstName;
            sc.conwrap.LastName = spendobj.Contact__r.LastName;
            sc.conwrap.Email = spendobj.Contact__r.Email;
            sc.conwrap.isInternal__c = spendobj.Contact__r.isInternal__c;
            sc.idEntId = spendobj.Contact__c;
            sc.BusinessRole = spendobj.Business_Role__c;
            sc.SystemRole = spendobj.System_Role__c;
            sc.contactSource = 'Smart Contact';
            suppWrapperlist.add(sc);
        }
        
        if(speConsequenceMngt.Contact__c != Null && (!uniqueSpendList.containskey(speConsequenceMngt.Contact__r.Email))){
            SupplierWrapper sc = new SupplierWrapper();
            sc.conwrap.FirstName = speConsequenceMngt.Contact__r.FirstName;
            sc.conwrap.LastName = speConsequenceMngt.Contact__r.LastName;
            sc.conwrap.Email = speConsequenceMngt.Contact__r.Email;
            sc.idEntId = speConsequenceMngt.Contact__c;
            sc.conwrap.isInternal__c = speConsequenceMngt.Contact__r.isInternal__c;
            sc.contactSource = 'Existing Contact';
            suppWrapperlist.add(sc); 
        }
        
        tempWrapperlist.addAll(suppWrapperlist);
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
    public List<SelectOption> getBusinessList() {
        List<SelectOption> options = new List<SelectOption>();
        for(String st: BusRoleList){
           options.add(new SelectOption(st,st)); 
        }
        return options;
    }   
    public List<SelectOption> getSystemList(){
        List<SelectOption> options = new List<SelectOption>();
        for(String st: SysRoleList){
           options.add(new SelectOption(st,st)); 
        }
        return options;
    }  
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    public void savecontact(){
        subwrapperList = new list<SupplierWrapper>();
        String firstname = '';
        String lastname = '';
        
        if(con.LastName =='' || con.Email ==''){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please provide the below required fields'));            
        }
        if(con.FirstName != ''){
            firstname = con.FirstName;
        }
        lastname = con.LastName;
        
        try{
            insert con;
            SPE_CategoryInfo__c conCatinfo = new SPE_CategoryInfo__c();
            conCatinfo.Contact__c = con.id;
            conCatinfo.Region__c =speConsequenceMngt.Market__c;
            conCatinfo.SubRegion__c =speConsequenceMngt.MarketUnit__c;
            conCatinfo.Country__c =speConsequenceMngt.Country__c ;
            conCatinfo.Project__c =speConsequenceMngt.Project__c ;
            conCatinfo.CategoryCluster__c =speConsequenceMngt.CategoryArea__c;
            conCatinfo.CategoryGroup__c =speConsequenceMngt.CategoryGroup__c ;
            conCatinfo.Category__c =speConsequenceMngt.Category__c ;
            conCatinfo.BusinessUnit__c =speConsequenceMngt.BusinessUnit__c ;
            conCatinfo.BusinessLine__c =speConsequenceMngt.BusinessLine__c ;
            conCatinfo.Product__c =speConsequenceMngt.Product__c ;
            conCatinfo.Business_Role__c =BusRoleSelected;
            conCatinfo.System_Role__c =SysRoleSelected;
            conCatinfo.Supplier__c =speConsequenceMngt.Supplier__c;
            insert conCatinfo;
            
            SPE_CategoryInfo__c contactCatInfo = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Contact__c,
                                                   Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,
                                                   Contact__r.isInternal__c,CategoryScopeCombination__c from SPE_CategoryInfo__c where Id =: conCatinfo.Id];
                        
            SupplierWrapper sc = new SupplierWrapper();
            sc.conwrap.FirstName = contactCatInfo.Contact__r.FirstName;
            sc.conwrap.LastName = contactCatInfo.Contact__r.LastName;
            sc.conwrap.Email = contactCatInfo.Contact__r.Email;
            sc.conwrap.isInternal__c = contactCatInfo.Contact__r.isInternal__c;
            sc.idEntId = contactCatInfo.Contact__c;
            sc.BusinessRole = contactCatInfo.Business_Role__c;
            sc.SystemRole = contactCatInfo.System_Role__c;
            sc.contactSource = 'Smart Contact';
            suppWrapperlist.add(sc);
            
            tempWrapperlist.add(sc);                        
            suppWrapperlist.sort();
            if(suppWrapperlist.size()>0)
            {    
             hasRecords = true;
             integer remainder = math.MOD(suppWrapperlist.size(),DEFAULT_PAGE_SIZE);
                 if(remainder == 0){
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
           displayPopup = false;             
        }       
        catch(exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,+e.getMessage().split(';')[1]));
            system.debug('contact ::'+e.getMessage());
            
            suppWrapperlist.sort();
            if(suppWrapperlist.size()>0)
            {    
             hasRecords = true;
             integer remainder = math.MOD(suppWrapperlist.size(),DEFAULT_PAGE_SIZE);
                 if(remainder == 0){
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
    }
    public void closePopup2() {        
        displayPopup2 = false;    
    }     
    public void showPopup2() {        
        displayPopup2 = true;    
    }
    public void savecontact2(){
        subwrapperList = new list<SupplierWrapper>();
        //List<SPE_CategoryInfo__c> catlistinfo = new List<SPE_CategoryInfo__c>();
        try{
            Map<String,String> uniqueSmartWrapList = new Map<String,String>();
            for(SupplierWrapper sw2 :suppWrapperlist){
                uniqueSmartWrapList.put(sw2.conwrap.Email,sw2.conwrap.Email);
            }
            
            Map<String,String> ScopeValueCombination2 = new Map<String,String>();
            String scopecombinations = speConsequenceMngt.Market__c+';'+speConsequenceMngt.MarketUnit__c+';'+speConsequenceMngt.Country__c+';'+speConsequenceMngt.Project__c+';'+speConsequenceMngt.CategoryArea__c+';'+speConsequenceMngt.CategoryGroup__c+';'+speConsequenceMngt.Category__c+';'+speConsequenceMngt.BusinessUnit__c+';'+speConsequenceMngt.BusinessLine__c+';'+speConsequenceMngt.Product__c;
            ScopeValueCombination2.put(scopecombinations,scopecombinations);
            
            List<SPE_CategoryInfo__c> spendlist2 = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Contact__c,Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,Contact__r.isInternal__c,CategoryScopeCombination__c from SPE_CategoryInfo__c where
                                                   CategoryScopeCombination__c IN: ScopeValueCombination2.values() 
                                                   AND Business_Role__c IN: BusRoleList
                                                   AND System_Role__c IN: SysRoleList
                                                   AND Supplier__c =: speConsequenceMngt.Supplier__c];
            
            Map<String,SPE_CategoryInfo__c> ContactContainlist = new Map<String,SPE_CategoryInfo__c>();
            for(SPE_CategoryInfo__c scinfo : spendlist2){
                ContactContainlist.put(scinfo.Contact__c,scinfo);
            }
           if(!ContactContainlist.containskey(conTargetId)){            
                SPE_CategoryInfo__c conCatinfo = new SPE_CategoryInfo__c();
                conCatinfo.Contact__c = conTargetId;
                conCatinfo.Region__c =speConsequenceMngt.Market__c;
                conCatinfo.SubRegion__c =speConsequenceMngt.MarketUnit__c;
                conCatinfo.Country__c =speConsequenceMngt.Country__c ;
                conCatinfo.Project__c =speConsequenceMngt.Project__c ;
                conCatinfo.CategoryCluster__c =speConsequenceMngt.CategoryArea__c;
                conCatinfo.CategoryGroup__c =speConsequenceMngt.CategoryGroup__c ;
                conCatinfo.Category__c =speConsequenceMngt.Category__c ;
                conCatinfo.BusinessUnit__c =speConsequenceMngt.BusinessUnit__c ;
                conCatinfo.BusinessLine__c =speConsequenceMngt.BusinessLine__c ;
                conCatinfo.Product__c =speConsequenceMngt.Product__c ;
                conCatinfo.Business_Role__c =BusRoleSelected;
                conCatinfo.System_Role__c =SysRoleSelected;
                conCatinfo.Supplier__c = speConsequenceMngt.Supplier__c;
                //catlistinfo.add(conCatinfo);
                insert conCatinfo;
                
                //Contact contarget = [Select ID,FirstName,LastName,Email from Contact where ];
                
                SPE_CategoryInfo__c contactCatInfo = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Contact__c,
                                                       Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,
                                                       Contact__r.isInternal__c,CategoryScopeCombination__c from SPE_CategoryInfo__c where Id =: conCatinfo.Id];
                 
                if(!uniqueSmartWrapList.containskey(contactCatInfo.Contact__r.Email)){            
                    SupplierWrapper sc = new SupplierWrapper();
                    sc.conwrap.FirstName = contactCatInfo.Contact__r.FirstName;
                    sc.conwrap.LastName = contactCatInfo.Contact__r.LastName;
                    sc.conwrap.Email = contactCatInfo.Contact__r.Email;
                    sc.conwrap.isInternal__c = contactCatInfo.Contact__r.isInternal__c;
                    sc.idEntId = contactCatInfo.Contact__c;
                    sc.BusinessRole = contactCatInfo.Business_Role__c;
                    sc.SystemRole = contactCatInfo.System_Role__c;
                    sc.contactSource = 'Smart Contact';
                    suppWrapperlist.add(sc);
                    
                    tempWrapperlist.add(sc);                        
                    suppWrapperlist.sort();
                    if(suppWrapperlist.size()>0)
                    {    
                     hasRecords = true;
                     integer remainder = math.MOD(suppWrapperlist.size(),DEFAULT_PAGE_SIZE);
                         if(remainder == 0){
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
               
                   if(suppWrapperlist.size() == 0){                          
                      System.debug('Enter Here'+suppWrapperlist.size());
                      pageNumber = 0;
                      maxPages = 0;
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
                   }
               }
           } 
           else if(ContactContainlist.containskey(conTargetId)){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'This Contact is already existing as Smart Contact'));
               
               suppWrapperlist.sort();
                if(suppWrapperlist.size()>0)
                {    
                 hasRecords = true;
                 integer remainder = math.MOD(suppWrapperlist.size(),DEFAULT_PAGE_SIZE);
                     if(remainder == 0){
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
           displayPopup2 = false;             
        }       
        catch(exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,+e.getMessage().split(';')[1]));
            system.debug('contact ::'+e.getMessage());
            
            suppWrapperlist.sort();
            if(suppWrapperlist.size()>0)
            {    
             hasRecords = true;
             integer remainder = math.MOD(suppWrapperlist.size(),DEFAULT_PAGE_SIZE);
                 if(remainder == 0){
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
    }
    public void showInternalContactOnly(){
        DEFAULT_PAGE_SIZE = 5;
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
        
        for(SupplierWrapper sc: tempWrapperlist){           
            if(isInternalCheck == true){
                if(sc.conwrap.isInternal__c == true){
                    suppWrapperlist.add(sc);
                }
            }    
            else if(isInternalCheck == false){
                suppWrapperlist.add(sc);
            }
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
                    subwrapperList.add(suppWrapperlist[i]);
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
                    subwrapperList.add(suppWrapperlist[i]);
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
                    subwrapperList.add(suppWrapperlist[i]);
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
                subwrapperList.add(suppWrapperlist[i]);
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
                subwrapperList.add(suppWrapperlist[i]);
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
                    subwrapperList.add(suppWrapperlist[i]);
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
                    subwrapperList.add(suppWrapperlist[i]);
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
                    subwrapperList.add(suppWrapperlist[i]);
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
    
    public void doSearch()
    {
        isSearch = true;
        DEFAULT_PAGE_SIZE2 = 25;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        tempWrapperlist2 = new List<SupplierWrapper>();
        
        if(contactName !='' && contactName !=Null){
            //*************initialization alpha list**********//
            suppWrapperlist2 = new List<SupplierWrapper>();
            String searchString = contactName;
            
         if (contactName != '' && contactName != '*')
            {
                                
              List<Contact> conList = [SELECT Id,Name,AccountID,Account.Name,FirstName,LastName,Email,isInternal__c
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
                    sc.conwrap = c;
                    sc.conwrap.FirstName = c.FirstName;
                    sc.conwrap.LastName = c.LastName;
                    sc.conwrap.Email = c.Email;
                    sc.conwrap.AccountId = c.AccountID;
                    sc.conwrap.isInternal__c = c.isInternal__c;
                    sc.contactSource = 'Searched Contact';
                    sc.idEntId = c.Id;
                    suppWrapperlist2.add(sc);
                }
              }  
            }
          }                
        }
        else{
            isSearch = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please provide atleast one character for the wild card search'));
        }
        
        tempWrapperlist2.addAll(suppWrapperlist2);
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
    
    public void showInternalContactOnly2(){
        DEFAULT_PAGE_SIZE2 = 25;
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
        
        for(SupplierWrapper sc: tempWrapperlist2){           
            if(isInternalCheck2 == true){
                if(sc.conwrap.isInternal__c == true){
                    suppWrapperlist2.add(sc);
                }
            }    
            else if(isInternalCheck2 == false){
                suppWrapperlist2.add(sc);
            }
        }
        
        suppWrapperlist2.sort();
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
                subwrapperList2.add(suppWrapperlist2[i]);
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
                    subwrapperList2.add(suppWrapperlist2[i]);
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
                    subwrapperList2.add(suppWrapperlist2[i]);
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
                subwrapperList2.add(suppWrapperlist2[i]);
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
                subwrapperList2.add(suppWrapperlist2[i]);
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
                    subwrapperList2.add(suppWrapperlist2[i]);
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
                    subwrapperList2.add(suppWrapperlist2[i]);
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
                    subwrapperList2.add(suppWrapperlist2[i]);
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
    
        
    public Pagereference addContact()
    {   
        System.Debug('contactId'+Apexpages.currentPage().getParameters().get('contactId'));
        
        if(Apexpages.currentPage().getParameters().get('contactId') != Null){              
            speConsequenceMngt.Contact__c = Apexpages.currentPage().getParameters().get('contactId');
        }
        
        update speConsequenceMngt;    
        Pagereference pr = new Pagereference('/'+speConsequenceMngt.Id);
      
        return pr;
    }
    
    
    public Pagereference cancel()
    {
        Pagereference pr = new Pagereference('/'+speConsequenceMngt.Id);
      
        return pr;
    }
    
    public class SupplierWrapper implements Comparable{
        public Contact conwrap{get;set;}
        public Id idEntId{get;set;}
        public String contactSource{get;set;}
        public String BusinessRole{get;set;}
        public String SystemRole{get;set;}
        
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