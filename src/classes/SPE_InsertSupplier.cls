public class SPE_InsertSupplier {

    //public List<SupplierWrapperForGenerator> SupplierWrapperListForGenerator {get;set;}
    public List<SupplierWrapper> SupplierWrapperList {get;set;}
    private Id spePlanId;
    private Id speScoreGenId;
    private String query='';
    private SPE_SPEPlan__c spePlan;
    //private SPE_ScorecardGenerator__c speScoreCardGenerate;
    public transient String supplierName {get;set;}
    private Set<Id> existAccountIds = new Set<Id>();
    
    public boolean isUserHaveAccessToRecord {get;set;} 
    
    public SPE_InsertSupplier(Apexpages.Standardcontroller st)
    {   
        isUserHaveAccessToRecord = true;
        String type = st.getRecord().getSObjectType().getDescribe().getName();
        if(type== 'SPE_SPEPlan__c')
        {
            
            spePlanId = st.getId();
            UserRecordAccess usrAcces = [SELECT RecordId, HasEditAccess FROM UserRecordAccess
                                            WHERE UserId =: UserInfo.getUserId() AND RecordId =: st.getId()];
                                            
            isUserHaveAccessToRecord = usrAcces.HasEditAccess;
            
            spePlan = [SELECT Id, CategoryCluster__c, CategoryGroup__c, Category__c
                       FROM SPE_SPEPlan__c
                       WHERE Id =: spePlanId];
             addSupplier ();
        }/*
        else if(type == 'SPE_ScorecardGenerator__c')
        {
            speScoreGenId = st.getId();
            speScoreCardGenerate = [SELECT Id, BusinessLine__c, BusinessUnit__c, CategoryCluster__c, CategoryGroup__c, Category__c,
                                EndDate__c, Product__c, Project__c, ScorecardTemplate__c, SubRegion__c
                                FROM SPE_ScorecardGenerator__c
                                WHERE Id =: speScoreGenId];
            addRespondent ();
        }*/
        else
        {
            system.debug('No Plan Or Scorecard generator selected');
        }
    }
    //*******Methods for Scorecard Generator*******
    /*
    public void addRespondent ()
    {
        
        SupplierWrapperListForGenerator = new List<SupplierWrapperForGenerator>();
        List<SPE_ScorecardSupplierMap__c> speScorecardList = [SELECT Id, Supplier__c, Supplier__r.Name, Supplier__r.EnterpriseId__c,Supplier__r.CategoryArea__c,Supplier__r.CategoryGroup__c
                                                            FROM SPE_ScorecardSupplierMap__c
                                                            WHERE ScorecardGenerator__c =: speScoreGenId];
        List<SPE_ScorecardSupplierMap__c> tobeDeletedScoreSupp = new List<SPE_ScorecardSupplierMap__c>();
        for (SPE_ScorecardSupplierMap__c speScorecardSup : speScorecardList)
        {
            if (speScorecardSup.Supplier__c == null)
            {
                tobeDeletedScoreSupp.add(speScorecardSup);
            }
            
            existAccountIds.add(speScorecardSup.Supplier__c);
        }
        List<Account> AccountSupplierList = [Select Id,EnterpriseId__c,NAme, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                     FROM Account 
                                     Where Id In: existAccountIds ];                           
        Map<Id, List<SPE_CategoryInfo__c>> accountCategoriesMap = new Map<Id, List<SPE_CategoryInfo__c>>();
        
        for (Account a: AccountSupplierList )
        {
          //List<SPE_CategoryInfo__c> catList = 
          accountCategoriesMap.put(a.Id, a.Categories_Info__r);
        }
        for (SPE_ScorecardSupplierMap__c speScoreSupp : speScorecardList)
        {   
            SupplierWrapperForGenerator sw;
            if (speScoreSupp.Supplier__c != null)
            {
                sw = new SupplierWrapperForGenerator(speScoreSupp, accountCategoriesMap.get(speScoreSupp.Supplier__c), true);
            }
            else
            {
                sw = new SupplierWrapperForGenerator(speScoreSupp, accountCategoriesMap.get(speScoreSupp.Supplier__c), false);
            }
            SupplierWrapperListForGenerator.add(sw);
        }
        Set<Id> accountsIds = new Set<Id>();
        for (SPE_CategoryInfo__c cat : [SELECT Category__c, CategoryCluster__c, CategoryGroup__c, Supplier__c
                                        FROM SPE_CategoryInfo__c
                                        WHERE  (CategoryCluster__c =: speScoreCardGenerate.CategoryCluster__c 
                                                AND CategoryGroup__c=: speScoreCardGenerate.CategoryGroup__c 
                                                AND Category__c =: speScoreCardGenerate.Category__c)
                                                AND Supplier__c not In: existAccountIds
                                                AND Supplier__c != null
                                                ])
        {
            accountsIds.add(cat.Supplier__c);   
        }
        
        List<Account> accountList = [Select Id, EnterpriseId__c,Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                     FROM Categories_Info__r LIMIT 5) cat
                                     FROM Account
                                     Where Id In: accountsIds 
                                     AND ParentId = null 
                                     AND EnterpriseId__c != null
                                     AND Id not In: existAccountIds LIMIT 100];
        for (Account a : accountList)
        {
            SupplierWrapperForGenerator sw = new SupplierWrapperForGenerator(a, a.Categories_Info__r);
            SupplierWrapperListForGenerator.add(sw);
            existAccountIds.add(a.Id);
        }
    }
    public Pagereference insertSupplier()
    {
        List<SPE_ScorecardSupplierMap__c> toBeCreatedSupplier = createRespondent(SupplierWrapperListForGenerator);
        upsert toBeCreatedSupplier;
        Pagereference pr = new Pagereference('/'+speScoreGenId);
        return pr;
    }
    public Pagereference cancel()
    {
      Pagereference pr = new Pagereference('/'+speScoreGenId);
      
      return pr;
    }
    
    private List<SPE_ScorecardSupplierMap__c> createRespondent (List<SupplierWrapperForGenerator> SupplierWrapperListForGenerator)
    {
        
        List<SPE_ScorecardSupplierMap__c> toBeCreatedSupplier = new List<SPE_ScorecardSupplierMap__c>();
        List<SPE_ScorecardSupplierMap__c> toBeDeletedSupplier= new List<SPE_ScorecardSupplierMap__c>();
        for (SupplierWrapperForGenerator sw : SupplierWrapperListForGenerator)
        {
            if (sw.isChecked)
            {
                sw.speScoreMap.ScorecardGenerator__c = speScoreGenId;
                toBeCreatedSupplier.add(sw.speScoreMap);
            }
            else if (sw.isChecked == false && sw.speScoreMap.Id != null)
            {
              toBeDeletedSupplier.add(sw.speScoreMap);
            }
        }
        delete toBeDeletedSupplier;
        return toBeCreatedSupplier;
    }
    public void searchSupplierforGenerator()
    {
        List<SupplierWrapperForGenerator> selectedSupplier = new List<SupplierWrapperForGenerator>();
        List<SPE_ScorecardSupplierMap__c> toBeDeletedSupplier= new List<SPE_ScorecardSupplierMap__c>();
        selectedSupplier.addAll(SupplierWrapperListForGenerator);
        SupplierWrapperListForGenerator.clear();
        for (SupplierWrapperForGenerator r : selectedSupplier)
        {
            if (r.isChecked)
            {
                SupplierWrapperListForGenerator.add(r);
            }
            else
            {
                if (r.speScoreMap.Id != null)
                {
                    toBeDeletedSupplier.add(r.speScoreMap);
                }
                existAccountIds.remove(r.speScoreMap.Supplier__c);
            }
        } 
        delete toBeDeletedSupplier;
        String searchString = supplierName;
        if  (searchString !=null && searchString.containsIgnoreCase('*'))
        {
            searchString = searchString.replaceAll('[*]', '%');
        }
        if (supplierName != '' && supplierName != '*')
        {
            List<Account> accountList = [SELECT Id, EnterpriseId__c, Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                         FROM Categories_Info__r LIMIT 5) cat
                                         FROM Account  
                                         WHERE EnterpriseId__c LIKE: searchString AND
                                              Id not IN: existAccountIds AND
                                              ParentId = null AND
                                              EnterpriseId__c != null
                                         LIMIT 100];
             for (Account a : accountList)
            {
                SupplierWrapperForGenerator sw = new SupplierWrapperForGenerator(a, a.Categories_Info__r);
                SupplierWrapperListForGenerator.add(sw);
                existAccountIds.add(a.Id);
            }                          
        }
    }*/
    //********Methods for SPE Plan**********
    public void addSupplier ()
    {
        SupplierWrapperList = new List<SupplierWrapper>();
        List<SPE_SPEPlanSupplierMap__c> spePlanList = [SELECT Id, Supplier__c, Supplier__r.Name, Supplier__r.EnterpriseId__c
                                                       FROM SPE_SPEPlanSupplierMap__c
                                                       WHERE SPEPlan__c =: spePlanId];
        List<SPE_SPEPlanSupplierMap__c> toBeDeletedPlanSuppMap = new List<SPE_SPEPlanSupplierMap__c>();
        for (SPE_SPEPlanSupplierMap__c spePln : spePlanList )
        {
            if (spePln.Supplier__c == null)
            {
                toBeDeletedPlanSuppMap.add(spePln);
            }
            existAccountIds.add(spePln.Supplier__c);
        }
        List<Account> Suppliers = [SELECT Id, EnterpriseId__c, Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                  FROM Categories_Info__r LIMIT 5) cat FROM Account 
                                  WHERE Id In: existAccountIds];
        Map<Id, List<SPE_CategoryInfo__c>> accountCategoriesMap = new Map<Id, List<SPE_CategoryInfo__c>>();
        for (Account a: Suppliers )
        {
            accountCategoriesMap.put(a.Id, a.Categories_Info__r);
        }
        for (SPE_SPEPlanSupplierMap__c spepln : spePlanList)
        {   
            SupplierWrapper sw;
            if (spePln.Supplier__c != null)
            {
                sw = new SupplierWrapper(spePln, accountCategoriesMap.get(spePln.Supplier__c), true);
            }
            else
            {
                sw = new SupplierWrapper(spePln, accountCategoriesMap.get(spePln.Supplier__c), false);
            }
            SupplierWrapperList.add(sw);
        }
        Set<Id> accountsIds = new Set<Id>();
        for (SPE_CategoryInfo__c cat : [SELECT Category__c, CategoryCluster__c, CategoryGroup__c, Supplier__c
                                        FROM SPE_CategoryInfo__c
                                        WHERE  (CategoryCluster__c =: spePlan.CategoryCluster__c 
                                                AND CategoryGroup__c=: spePlan.CategoryGroup__c 
                                                AND Category__c =: spePlan.Category__c)
                                                AND Supplier__c not In: existAccountIds
                                                AND Supplier__c != null
                                                ])
        {
            accountsIds.add(cat.Supplier__c);   
        }
          //**********************Changes For Encryption********************//
        /*List<Account> accountList = [Select Id, EnterpriseId__c,Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                     FROM Categories_Info__r LIMIT 5) cat
                                     FROM Account
                                     Where Id In: accountsIds 
                                     AND ParentId = null 
                                     AND EnterpriseId__c != null
                                     AND Id not In: existAccountIds LIMIT 100];*/
                                     
        List<Account> accountList = [Select Id, EnterpriseId__c,Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                     FROM Categories_Info__r LIMIT 5) cat
                                     FROM Account
                                     Where Id In: accountsIds 
                                     AND ParentId = null 
                                     AND Id not In: existAccountIds LIMIT 100];                             
                                     
        for (Account a : accountList)
        {
           if(a.EnterpriseId__c != Null)
           {
                SupplierWrapper sw = new SupplierWrapper(a, a.Categories_Info__r);
                SupplierWrapperList.add(sw);
                existAccountIds.add(a.Id);
           }     
        }
        //***********************END*******************//
        
    }
    public void searchSupplier()
    {
      
        List<SupplierWrapper> selectedSupplier = new List<SupplierWrapper>();
        List<SPE_SPEPlanSupplierMap__c> toBeDeletedSupplier= new List<SPE_SPEPlanSupplierMap__c>();
        selectedSupplier.addAll(SupplierWrapperList);
        SupplierWrapperList.clear();
        for (SupplierWrapper r : selectedSupplier)
        {
            if (r.isChecked)
            {
                SupplierWrapperList.add(r);
            }
            else
            {
                if (r.spePlanMap.Id != null)
                {
                    toBeDeletedSupplier.add(r.spePlanMap);
                }
                existAccountIds.remove(r.spePlanMap.Supplier__c);
            }
        }
        delete toBeDeletedSupplier;
        String searchString = supplierName;
        if  (searchString !=null && searchString.containsIgnoreCase('*') && searchString.substring(0,1) != '*')
        {
           // searchString = searchString.replaceAll('[*]', '+');
        }
        if (supplierName != '' && supplierName != '*')
        {
            //*******************Changes For Encryption***************//
            /*List<Account> accountList = [SELECT Id, EnterpriseId__c, Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                         FROM Categories_Info__r LIMIT 5) cat
                                         FROM Account  
                                         WHERE EnterpriseId__c LIKE: searchString AND
                                              Id not IN: existAccountIds AND
                                              ParentId = null AND
                                              EnterpriseId__c != null
                                         LIMIT 100];*/
                                         
             List<Account> accountList = [SELECT Id, EnterpriseId__c, Name, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c 
                                         FROM Categories_Info__r LIMIT 5) cat
                                         FROM Account  
                                         WHERE Id not IN: existAccountIds AND
                                         ParentId = null LIMIT 10000];
                                                                           
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
                        SupplierWrapper sw = new SupplierWrapper(a, a.Categories_Info__r);
                        SupplierWrapperList.add(sw);
                        if (SupplierWrapperList.size()>675)
                        {
                            break;
                        }
                        existAccountIds.add(a.Id);
                    }
                }       
            } 
            
          //*********************END********************//  
        }
        
    }
    public Pagereference insertSupplierForPlan()
    {
        List<SPE_SPEPlanSupplierMap__c> toBeCreatedSupplier = createSupplierforPlan(SupplierWrapperList);
        upsert toBeCreatedSupplier;
        Pagereference pr = new Pagereference('/'+spePlanId);
        return pr;
    }
    public Pagereference cancelforPlan()
    {
        Pagereference pr = new Pagereference('/'+spePlanId);
        return pr;
    }
    private List<SPE_SPEPlanSupplierMap__c> createSupplierforPlan (List<SupplierWrapper> SupplierWrapperList)
    {
        List<SPE_SPEPlanSupplierMap__c> toBeCreatedSupplier = new List<SPE_SPEPlanSupplierMap__c>();
        List<SPE_SPEPlanSupplierMap__c> toBeDeletedSupplier= new List<SPE_SPEPlanSupplierMap__c>();
        for (SupplierWrapper sw : SupplierWrapperList)
        {
            if (sw.isChecked)
            {
                sw.spePlanMap.SPEPlan__c = spePlanId;
                toBeCreatedSupplier.add(sw.spePlanMap);
            }
            else if (sw.isChecked == false && sw.spePlanMap.Id != null)
            {
              toBeDeletedSupplier.add(sw.spePlanMap);
            }
        }
        delete toBeDeletedSupplier;
        return toBeCreatedSupplier;
    }
    //*******Wrapper for ScorecardGenerator**********
    /*
    public class SupplierWrapperForGenerator
    {
        public SPE_ScorecardSupplierMap__c speScoreMap{get;set;}
        public Boolean isChecked {get;set;}
        public List<SPE_CategoryInfo__c> categories {get;set;}
        public SupplierWrapperForGenerator(SPE_ScorecardSupplierMap__c speScoreMap, List<SPE_CategoryInfo__c> cat, Boolean flag)
        {
            this.speScoreMap = speScoreMap;
            isChecked = flag;
            categories = cat;
        }
        public SupplierWrapperForGenerator (Account acc, List<SPE_CategoryInfo__c> cat)
        {
            speScoreMap = new SPE_ScorecardSupplierMap__c();
            speScoreMap.Supplier__c = acc.Id;
            speScoreMap.Supplier__r = acc;
            categories = new List<SPE_CategoryInfo__c>();
            categories = cat;
            isChecked = false;
        }
    }*/
    //********Wraper for Supplier for SPE Plan********
    public class SupplierWrapper
    {
        public SPE_SPEPlanSupplierMap__c  spePlanMap{get;set;}
        public Boolean isChecked {get;set;}
        public List<SPE_CategoryInfo__c> categories {get;set;}
        public SupplierWrapper(SPE_SPEPlanSupplierMap__c spePlanMap,List<SPE_CategoryInfo__c> cat, Boolean flag)
        {
            this.spePlanMap = spePlanMap;
            isChecked = flag;
            categories = cat;
        }
        public SupplierWrapper (Account acc, List<SPE_CategoryInfo__c> cat)
        {
            spePlanMap = new SPE_SPEPlanSupplierMap__c();
            spePlanMap.Supplier__c = acc.Id;
            spePlanMap.Supplier__r = acc;
            
            categories = new List<SPE_CategoryInfo__c>();
            categories = cat;
            
            isChecked = false;
        } 
    }

}