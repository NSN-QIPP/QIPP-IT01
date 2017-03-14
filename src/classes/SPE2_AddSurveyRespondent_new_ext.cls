public with sharing class SPE2_AddSurveyRespondent_new_ext{
    private ApexPages.StandardController std;
    public String spePlanIdentifier{get;set;}
    public boolean supplierAvailable{get;set;}
    public String contactName{get;set;}
    
    public List<SupplierWrapper> suppWrapperlist;
    public List<SupplierWrapper> tempWrapperlist; 
    public List<SupplierWrapper> suppWrapperlist2;
    public List<SPE2Survey__c> speplanlist;
    
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
    public ID speID;
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
    public Map<String,String> exsistingRespondent;    
    public Boolean isInternalCheck{get;set;}
    public ID CurrentUserId  {get;set;}
    public Id RecordOwnerId {get;set;}
    public boolean displayPopup {get; set;}  
    public contact con{get;set;}
    public List<String> BusRoleList {get;set;}
    public List<string> SysRoleList{get;set;}
    public String BusRoleSelected {get;set;}
    public string SysRoleSelected{get;set;}
    public Set<ID> AccountSet;
    public boolean displayPopup2 {get; set;} 
    public String conTargetId{get;set;}
    public SPE2_AddSurveyRespondent_new_ext(ApexPages.StandardController std){  
         
        this.std = std;
        supplierAvailable = false;
        isSuggested = true;
        speID = std.getId();
        isInternalCheck = False;
        speplanlist = new List<SPE2Survey__c>();
        exsistingRespondent = new Map<String,String>();
        con = new contact();
        
        List<Business_System_Role__c> BusSyslist = [Select Name,Business_Role__c,System_Role__c,Object_Name__c from  Business_System_Role__c where Object_Name__c = 'Standalone Survey'];
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
                
        //String  BusRole = Business_System_Role__c.getValues('Standalone Survey').Business_Role__c;
        BusRoleList = new List<string>();
        for(String BusRole: allBusRole){            
            for(String key : BusRole.split(';')){
                BusRoleList.add(key);
            }
        }
        
        //String  SysRole = Business_System_Role__c.getValues('Standalone Survey').System_Role__c;
        SysRoleList = new List<string>();
        for(String SysRole: allSysRole){
            for(String key : SysRole.split(';')){
                SysRoleList.add(key);
            }
        }
        
        System.debug('The members 1 :'+ BusRoleList );
        System.debug('The members 2 :'+ SysRoleList );
        
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
        isSearch = false;
        
        speplanlist = [Select ID,Name,
                        Market__c,MarketUnit__c,Country__c,Project__c,
                        CategoryArea__c,CategoryGroup__c,Category__c,
                        BusinessUnit__c,BusinessLine__c,Product__c,Supplier_Count__c from SPE2Survey__c
                        where ID = :std.getId()];
        CurrentUserId = UserInfo.getUserId();
        RecordOwnerId = [Select Id, ownerId from SPE2Survey__c
                               WHERE Id =: std.getId()].ownerId;
                        
                        
        List<SPE2_SurveySupplierMap__c> suppMapList = [Select Supplier__c from SPE2_SurveySupplierMap__c where SPE2_Survey__c = :std.getId()];
        if(suppMapList.size()>0){
        supplierAvailable = true;
        }
        AccountSet = new Set<ID>();
        for (SPE2_SurveySupplierMap__c splmap : suppMapList){
         AccountSet.add(splmap.Supplier__c);
        }
                                                            
        Map<String,String> ScopeValueCombination = new Map<String,String>();
        for(SPE2Survey__c sp:speplanlist){
            String scopecombinations = sp.Market__c+';'+sp.MarketUnit__c+';'+sp.Country__c+';'+sp.Project__c+';'+sp.CategoryArea__c+';'+sp.CategoryGroup__c+';'+sp.Category__c+';'+sp.BusinessUnit__c+';'+sp.BusinessLine__c+';'+sp.Product__c;
            ScopeValueCombination.put(scopecombinations,scopecombinations);
        }
        System.Debug('**ScopeValueCombination**'+ ScopeValueCombination.values() );
        List<SPE_CategoryInfo__c> spendlist = [Select ID,Contact__c,Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,
                                               Contact__r.Email,Contact__r.isInternal__c,CategoryScopeCombination__c,
                                               Supplier__c,Supplier__r.Name,Business_Role__c,System_Role__c from SPE_CategoryInfo__c where
                                               CategoryScopeCombination__c IN: ScopeValueCombination.values() 
                                               AND Business_Role__c IN: BusRoleList AND System_Role__c IN:SysRoleList 
                                               AND Supplier__c IN: AccountSet];
        
        Map<String,SPE_CategoryInfo__c> uniqueSpendList = new Map<String,SPE_CategoryInfo__c>();
        for(SPE_CategoryInfo__c uniobj: spendlist){            
            uniqueSpendList.put(uniobj.Contact__r.Email,uniobj);
        }
        
        System.Debug('**spendlist **'+spendlist );
        for(SPE_CategoryInfo__c spendobj: uniqueSpendList.values()){
            SupplierWrapper sc = new SupplierWrapper();
            sc.isSelected = true;
            sc.isDisabled = false;
            sc.conwrap.FirstName = spendobj.Contact__r.FirstName;
            sc.conwrap.LastName = spendobj.Contact__r.LastName;
            sc.conwrap.Email = spendobj.Contact__r.Email;
            sc.conwrap.isInternal__c = spendobj.Contact__r.isInternal__c;
            sc.idEntId = spendobj.Contact__c;
            sc.contactSource = 'Smart Contact';
            sc.BusinessRole = spendobj.Business_Role__c;
            sc.SystemRole = spendobj.System_Role__c; 
            sc.SupplierName = spendobj.Supplier__r.Name; 
            sc.contactSource = 'Smart Contact';
            suppWrapperlist.add(sc);
        }
        
        List<SPE2_Survey_Respondents__c> spreslist = [Select ID,Survey__c,Contact__c,Contact__r.AccountId,Contact__r.Account.Name,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,Contact__r.isInternal__c from SPE2_Survey_Respondents__c where Survey__c=: std.getId()];
        Map<String,SPE2_Survey_Respondents__c> uniqueSPEPlanRespondentList = new Map<String,SPE2_Survey_Respondents__c>();
        for(SPE2_Survey_Respondents__c unires: spreslist){
            if(!uniqueSpendList.containskey(unires.Contact__r.Email))
            uniqueSPEPlanRespondentList.put(unires.Contact__r.Email,unires);
        }
        for(SPE2_Survey_Respondents__c  spendobj: uniqueSPEPlanRespondentList.values()){
            SupplierWrapper sc = new SupplierWrapper();
            sc.isSelected = true;
            sc.isDisabled = false;
            sc.conwrap.FirstName = spendobj.Contact__r.FirstName;
            sc.conwrap.LastName = spendobj.Contact__r.LastName;
            sc.conwrap.Email = spendobj.Contact__r.Email;
            sc.conwrap.isInternal__c = spendobj.Contact__r.isInternal__c;
            sc.idEntId = spendobj.Contact__c;
            sc.SupplierName = spendobj.Contact__r.Account.Name;
            sc.contactSource = 'Global Contact';
            suppWrapperlist.add(sc);
        }
        
        for(SupplierWrapper sww: suppWrapperlist){
          exsistingRespondent.put(sww.conwrap.Email,sww.conwrap.Email);  
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
    public List<SelectOption> getBusinessList(){
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
        List<SPE_CategoryInfo__c> catinfolist = new List<SPE_CategoryInfo__c>();

        
        if(con.LastName == '' || con.Email == ''){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please provide the below required fields'));            
        }
        
        try{
            insert con;
            
            for(ID accid: AccountSet){
                SPE_CategoryInfo__c conCatinfo = new SPE_CategoryInfo__c();
                conCatinfo.Contact__c = con.id;
                conCatinfo.Region__c = speplanlist[0].Market__c;
                conCatinfo.SubRegion__c =speplanlist[0].MarketUnit__c;
                conCatinfo.Country__c =speplanlist[0].Country__c ;
                conCatinfo.Project__c =speplanlist[0].Project__c ;
                conCatinfo.CategoryCluster__c =speplanlist[0].CategoryArea__c;
                conCatinfo.CategoryGroup__c =speplanlist[0].CategoryGroup__c ;
                conCatinfo.Category__c =speplanlist[0].Category__c ;
                conCatinfo.BusinessUnit__c =speplanlist[0].BusinessUnit__c ;
                conCatinfo.BusinessLine__c =speplanlist[0].BusinessLine__c ;
                conCatinfo.Product__c =speplanlist[0].Product__c ;
                conCatinfo.Business_Role__c =BusRoleSelected;
                conCatinfo.System_Role__c =SysRoleSelected;
                conCatinfo.Supplier__c =accid;
                catinfolist.add(conCatinfo);
            }
            insert catinfolist;
            
            SPE_CategoryInfo__c contactCatInfo = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Contact__c,Supplier__r.Name,
                                                   Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,
                                                   Contact__r.isInternal__c,CategoryScopeCombination__c from SPE_CategoryInfo__c where Id =: catinfolist[0].ID];
                                                                            
            SupplierWrapper sc = new SupplierWrapper();
            sc.isSelected = true;
            sc.isDisabled = false;
            sc.conwrap.FirstName = contactCatInfo.Contact__r.FirstName;
            sc.conwrap.LastName = contactCatInfo.Contact__r.LastName;
            sc.conwrap.Email = contactCatInfo.Contact__r.Email;
            sc.SupplierName = contactCatInfo.Supplier__r.Name;
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
         finally
         {
             con = new Contact();
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
        List<SPE_CategoryInfo__c> catinfolist = new List<SPE_CategoryInfo__c>();       
        try{                     
            Map<String,String> uniqueSmartWrapList = new Map<String,String>();
            for(SupplierWrapper sw2 :suppWrapperlist){
                uniqueSmartWrapList.put(sw2.conwrap.Email,sw2.conwrap.Email);
            }
            
            Map<String,String> ScopeValueCombination2 = new Map<String,String>();
            for(SPE2Survey__c sp:speplanlist){
                String scopecombinations = sp.Market__c+';'+sp.MarketUnit__c+';'+sp.Country__c+';'+sp.Project__c+';'+sp.CategoryArea__c+';'+sp.CategoryGroup__c+';'+sp.Category__c+';'+sp.BusinessUnit__c+';'+sp.BusinessLine__c+';'+sp.Product__c;
                ScopeValueCombination2.put(scopecombinations,scopecombinations);
            }
            
            List<SPE_CategoryInfo__c> spendlist2 = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Supplier__r.Name,Contact__c,Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,
                                                   Contact__r.Email,Contact__r.isInternal__c,CategoryScopeCombination__c, BusinessLine__c,BusinessUnit__c, Category__c, CategoryCluster__c, CategoryGroup__c,
                                                   Country__c, Region__c, SubRegion__c, Product__c, Project__c from SPE_CategoryInfo__c where
                                                   CategoryScopeCombination__c IN: ScopeValueCombination2.values() 
                                                   AND Supplier__c IN: AccountSet AND Business_Role__c IN: BusRoleList
                                                   AND System_Role__c IN:SysRoleList];
            
            Map<String,SPE_CategoryInfo__c> ContactContainlist = new Map<String,SPE_CategoryInfo__c>();
            for(SPE_CategoryInfo__c scinfo : spendlist2){
                ContactContainlist.put(scinfo.Contact__c,scinfo);
            }
            
            if(!ContactContainlist.containskey(conTargetId)){
                for(ID accid: AccountSet){
                    SPE_CategoryInfo__c conCatinfo = new SPE_CategoryInfo__c();
                    conCatinfo.Contact__c = conTargetId;
                    conCatinfo.Region__c = speplanlist[0].Market__c;
                    conCatinfo.SubRegion__c =speplanlist[0].MarketUnit__c;
                    conCatinfo.Country__c =speplanlist[0].Country__c ;
                    conCatinfo.Project__c =speplanlist[0].Project__c ;
                    conCatinfo.CategoryCluster__c =speplanlist[0].CategoryArea__c;
                    conCatinfo.CategoryGroup__c =speplanlist[0].CategoryGroup__c ;
                    conCatinfo.Category__c =speplanlist[0].Category__c ;
                    conCatinfo.BusinessUnit__c =speplanlist[0].BusinessUnit__c ;
                    conCatinfo.BusinessLine__c =speplanlist[0].BusinessLine__c ;
                    conCatinfo.Product__c =speplanlist[0].Product__c ;
                    conCatinfo.Business_Role__c =BusRoleSelected;
                    conCatinfo.System_Role__c =SysRoleSelected;
                    conCatinfo.Supplier__c =accid;
                    catinfolist.add(conCatinfo);
                }
                insert catinfolist;
                
                SPE_CategoryInfo__c contactCatInfo = [Select ID,Business_Role__c,System_Role__c,Supplier__c,Contact__c,Supplier__r.Name,
                                                       Contact__r.AccountID,Contact__r.Name,Contact__r.FirstName,Contact__r.LastName,Contact__r.Email,
                                                       Contact__r.isInternal__c,CategoryScopeCombination__c from SPE_CategoryInfo__c where Id =: catinfolist[0].ID];
                                                   
                if(!uniqueSmartWrapList.containskey(contactCatInfo.Contact__r.Email)){
                                      
                    SupplierWrapper sc = new SupplierWrapper();
                    sc.isSelected = true;
                    sc.isDisabled = false;
                    sc.conwrap.FirstName = contactCatInfo.Contact__r.FirstName;
                    sc.conwrap.LastName = contactCatInfo.Contact__r.LastName;
                    sc.conwrap.Email = contactCatInfo.Contact__r.Email;
                    sc.SupplierName = contactCatInfo.Supplier__r.Name;
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
                    sc.isDisabled = false;
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
                    try{
                        subwrapperList.add(suppWrapperlist[i]);
                    }catch(exception e){}
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
       Pagereference pr =new Pagereference('/'+speID);
       return pr;
    }
    
    public void searchSuppliers(){
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
        
        if(contactName !='' && contactName !=Null){
            //*************initialization alpha list**********//
            suppWrapperlist2 = new List<SupplierWrapper>();
            String searchString = contactName;
            
         if (contactName != '' && contactName != '*')
            {
                                
              List<Contact> conList = [SELECT Id,Name,AccountID,Account.Name,FirstName,LastName,Email,isInternal__c
                                       FROM Contact];                               
                                                                                                                        
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
                    sc.conwrap.isInternal__c = c.isInternal__c;
                    sc.idEntId = c.Id;
                    sc.contactSource = 'Searched Contact';
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
        
        for(SupplierWrapper scOj : suppWrapperlist2){
            if(exsistingRespondent.containsKey(scOj.conwrap.Email)){
                scOj.isSelected = true;
                scOj.isDisabled = true;
            }
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
    
    public void searchInternalContact(){
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
        
        if(contactName !='' && contactName !=Null){
            //*************initialization alpha list**********//
            suppWrapperlist2 = new List<SupplierWrapper>();
            String searchString = contactName;
            
         if (contactName != '' && contactName != '*')
            {
                                
              List<Contact> conList = [SELECT Id,Name,AccountID,Account.Name,FirstName,LastName,Email,isInternal__c  
                                       FROM Contact where isInternal__c = True];                               
                                                                                                                        
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
                    sc.conwrap.AccountId = c.AccountID;
                    sc.conwrap.isInternal__c = c.isInternal__c;
                    sc.idEntId = c.Id;
                    sc.contactSource = 'Searched Contact';
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
        
        for(SupplierWrapper scOj : suppWrapperlist2){
            if(exsistingRespondent.containsKey(scOj.conwrap.Email)){
                scOj.isSelected = true;
                scOj.isDisabled = true;
            }
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
    
    public void AddRespondent(){
    
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
    
        for(SupplierWrapper scOj : suppWrapperlist2){
            if(scOj.isSelected && !exsistingRespondent.containsKey(scOj.conwrap.Email)){                
                scOj.isDisabled = True;
                scOj.SupplierName = scOj.conwrap.Account.Name;
                suppWrapperlist.add(scOj);
                exsistingRespondent.put(scOj.conwrap.Email,scOj.conwrap.Email);                
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
    
    public PageReference AddToPlans(){
       List<SPE2_Survey_Respondents__c> lstSSM = new List<SPE2_Survey_Respondents__c>();
       List<SPE2_Survey_Respondents__c> tobeInsertedSSM = new List<SPE2_Survey_Respondents__c>();
       List<SPE2_Survey_Respondents__c> tobeDeletedSSM = new List<SPE2_Survey_Respondents__c>();
       
       lstSSM = [Select ID,Contact__c,Survey__c from SPE2_Survey_Respondents__c where Survey__c IN: speplanlist];
       Map<String,String> matchInsertedSupplier = new Map<String,String>();
       Map<String,SPE2_Survey_Respondents__c> toBedeletedRespondent = new Map<String,SPE2_Survey_Respondents__c>();
       
       for(SPE2_Survey_Respondents__c spSSM: lstSSM){
           String temp = spSSM.Contact__c+';'+spSSM.Survey__c;
           matchInsertedSupplier.put(temp,temp);
           toBedeletedRespondent.put(temp,spSSM);
       }
       
       for(SPE2Survey__c sp: speplanlist){
           if(suppWrapperlist.size() > 0){
               for(SupplierWrapper sw : suppWrapperlist){
                   if(sw.isSelected && (!matchInsertedSupplier.containsKey(sw.idEntId+';'+sp.ID))){
                       SPE2_Survey_Respondents__c objSSM = new SPE2_Survey_Respondents__c();
                       objSSM.Survey__c=sp.ID;
                       objSSM.Contact__c = sw.idEntId;
                       tobeInsertedSSM.add(objSSM);
                   }
                   else if(!sw.isSelected && toBedeletedRespondent.containsKey(sw.idEntId+';'+sp.ID)){
                       tobeDeletedSSM.add(toBedeletedRespondent.get(sw.idEntId+';'+sp.ID));
                   }
               }
           }
           /*if(suppWrapperlist2.size() > 0){
               for(SupplierWrapper sw : suppWrapperlist2){
                   if(sw.isSelected && (!matchInsertedSupplier.containsKey(sw.idEntId+';'+sp.ID))){
                       SPE2_Survey_Respondents__c objSSM = new SPE2_Survey_Respondents__c();
                       objSSM.Contact__c = sw.idEntId;
                       objSSM.Survey__c =sp.ID;
                       tobeInsertedSSM.add(objSSM);
                   }
               }
           }*/
       }
       
       
       try{
           if(!tobeInsertedSSM.isEmpty()){
               insert tobeInsertedSSM;
           }
           if(!tobeDeletedSSM.isEmpty()){
               delete tobeDeletedSSM;
           }
       }catch(Exception e){}

       Pagereference pr =new Pagereference('/'+speID);
       return pr;
    }
    /*
    public PageReference AddToPlans2(){
       List<SPE2_Survey_Respondents__c> lstSSM2 = new List<SPE2_Survey_Respondents__c>();
       List<SPE2_Survey_Respondents__c> tobeInsertedSSM2 = new List<SPE2_Survey_Respondents__c>();
       List<SPE2_Survey_Respondents__c> tobeDeletedSSM = new List<SPE2_Survey_Respondents__c>();
       
       lstSSM2 = [Select ID,Contact__c,Survey__c from SPE2_Survey_Respondents__c where Survey__c IN: speplanlist];
       Map<String,String> matchInsertedSupplier2 = new Map<String,String>();
       Map<String,SPE2_Survey_Respondents__c> toBedeletedRespondent = new Map<String,SPE2_Survey_Respondents__c>();
       
       for(SPE2_Survey_Respondents__c spSSM: lstSSM2){
           String temp = spSSM.Contact__c+';'+spSSM.Survey__c;
           matchInsertedSupplier2.put(temp,temp);
           toBedeletedRespondent.put(temp,spSSM);
       }
       for(SPE2Survey__c sp: speplanlist){
           if(suppWrapperlist2.size() > 0){
               for(SupplierWrapper sw : suppWrapperlist2){
                   if(sw.isSelected && (!matchInsertedSupplier2.containsKey(sw.idEntId+';'+sp.ID))){
                       SPE2_Survey_Respondents__c objSSM = new SPE2_Survey_Respondents__c();
                       objSSM.Contact__c = sw.idEntId;
                       objSSM.Survey__c =sp.ID;
                       tobeInsertedSSM2.add(objSSM);
                   }
               }
           }
           if(suppWrapperlist.size() > 0){
               for(SupplierWrapper sw : suppWrapperlist){
                   if(sw.isSelected && (!matchInsertedSupplier2.containsKey(sw.idEntId+';'+sp.ID))){
                       SPE2_Survey_Respondents__c objSSM = new SPE2_Survey_Respondents__c();
                       objSSM.Survey__c =sp.ID;
                       objSSM.Contact__c = sw.idEntId;
                       tobeInsertedSSM2.add(objSSM);
                   }
                   else if(!sw.isSelected && toBedeletedRespondent.containsKey(sw.idEntId+';'+sp.ID)){
                       tobeDeletedSSM.add(toBedeletedRespondent.get(sw.idEntId+';'+sp.ID));
                   }
               }
           }
       }
       
       try{
           if(!tobeInsertedSSM2.isEmpty()){
               insert tobeInsertedSSM2;
           }
           if(!tobeDeletedSSM.isEmpty()){
               delete tobeDeletedSSM;
           }
       }catch(Exception e){}
              
       Pagereference pr =new Pagereference('/'+speID);
       return pr;
    }  
    */ 
    public class SupplierWrapper implements Comparable{
        public boolean isSelected{get;set;}
        public boolean isDisabled{get;set;}
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