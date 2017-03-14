public with sharing class SPE_InsertSupplierOnScoreCard 
{
    public List<SupplierWrapper> SupplierWrapperList {get;set;}
    
    private Id speScoreGenId;
    
    private SPE_ScorecardGenerator__c speScoreCardGenerate;
    
   
    
    private Set<Id> existAccountIds = new Set<Id>();
     
    public SPE_InsertSupplierOnScoreCard (Apexpages.Standardcontroller st)
    {
        speScoreGenId = st.getId();
        
        speScoreCardGenerate = [SELECT Id, BusinessLine__c, BusinessUnit__c, CategoryCluster__c, CategoryGroup__c, Category__c,
                                EndDate__c, Product__c, Project__c, ScorecardTemplate__c, SubRegion__c
                                FROM SPE_ScorecardGenerator__c
                                WHERE Id =: speScoreGenId];
        
        addRespondent ();
    }   
    
    public void addRespondent ()
    {
      SupplierWrapperList = new List<SupplierWrapper>();
      
        List<SPE_ScorecardSupplierMap__c> speScorecardList = [SELECT Id, Supplier__c, Supplier__r.Name, Supplier__r.EnterpriseId__c,Supplier__r.CategoryArea__c,Supplier__r.CategoryGroup__c
                                                            FROM SPE_ScorecardSupplierMap__c
                                                            WHERE ScorecardGenerator__c =: speScoreGenId];
        for (SPE_ScorecardSupplierMap__c speScorecardSup : speScorecardList)
        {
            //RespondentWrapper rw = new RespondentWrapper(res);
            //respondentWrapperList.add(rw);
            
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
        
      for (SPE_ScorecardSupplierMap__c speScorecardSup : speScorecardList)
        {
            SupplierWrapper sw = new SupplierWrapper(speScorecardSup, accountCategoriesMap.get(speScorecardSup.Supplier__c));
            SupplierWrapperList.add(sw);
            //existContactIds.add(res.Contact__c);
        }
        
        
        
        Set<Id> accountsIds = new Set<Id>();
        
        for (SPE_CategoryInfo__c cat : [SELECT Category__c, CategoryCluster__c, CategoryGroup__c, Supplier__c
                                        FROM SPE_CategoryInfo__c
                                        WHERE (CategoryCluster__c =: speScoreCardGenerate.CategoryCluster__c OR
                                               (CategoryCluster__c =: speScoreCardGenerate.CategoryCluster__c AND CategoryGroup__c=: speScoreCardGenerate.CategoryGroup__c)OR
                                               (CategoryCluster__c =: speScoreCardGenerate.CategoryCluster__c AND CategoryGroup__c=: speScoreCardGenerate.CategoryGroup__c AND Category__c =: speScoreCardGenerate.Category__c)) AND
                                                Supplier__c not In: existAccountIds])
        {
          accountsIds.add(cat.Supplier__c);
          
        }
        
        
        List<SPE_ScorecardSupplierMap__c> speScoreSupplier = [SELECT Id, Supplier__c, Supplier__r.SupplierManager__c
                                                        FROM SPE_ScorecardSupplierMap__c
                                                        WHERE ScorecardGenerator__c =: speScoreGenId];
        
        for (SPE_ScorecardSupplierMap__c speScoresup: speScoreSupplier)
        {
            accountsIds.add(speScoresup.Supplier__r.SupplierManager__c);
        }
        
        
        List<Account> accountList = [Select Id,EnterpriseId__c,NAme, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                     FROM Account
                                     Where Id In: accountsIds AND
                                     Id not In: existAccountIds ];
        
        for (Account a : accountList)
        {
            SupplierWrapper sw = new SupplierWrapper(a, a.Categories_Info__r);
            SupplierWrapperList.add(sw);
            existAccountIds.add(a.Id);
        }
        
    }
    
    
    
    public Pagereference insertSupplier()
    {
        List<SPE_ScorecardSupplierMap__c> toBeCreatedSupplier = createRespondent(SupplierWrapperList);
        
        upsert toBeCreatedSupplier;
        
        Pagereference pr = new Pagereference('/'+speScoreGenId);
      
        return pr;
    }
    
    public Pagereference cancel()
    {
      Pagereference pr = new Pagereference('/'+speScoreGenId);
      
      return pr;
    }
    
    private List<SPE_ScorecardSupplierMap__c> createRespondent (List<SupplierWrapper> SupplierWrapperList)
    {
        
        List<SPE_ScorecardSupplierMap__c> toBeCreatedSupplier = new List<SPE_ScorecardSupplierMap__c>();
        
        List<SPE_ScorecardSupplierMap__c> toBeDeletedSupplier= new List<SPE_ScorecardSupplierMap__c>();
        
        for (SupplierWrapper sw : SupplierWrapperList)
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
    
    public class SupplierWrapper
    {
        public SPE_ScorecardSupplierMap__c speScoreMap{get;set;}
        public Boolean isChecked {get;set;}
        public List<SPE_CategoryInfo__c> categories {get;set;}
        
        public SupplierWrapper(SPE_ScorecardSupplierMap__c speScoreMap, List<SPE_CategoryInfo__c> cat)
        {
            this.speScoreMap = speScoreMap;
            isChecked = true;
            categories = cat;
        }
        
        public SupplierWrapper (Account acc, List<SPE_CategoryInfo__c> cat)
        {
            speScoreMap = new SPE_ScorecardSupplierMap__c();
            speScoreMap.Supplier__c = acc.Id;
            speScoreMap.Supplier__r = acc;
            
            categories = new List<SPE_CategoryInfo__c>();
            categories = cat;
            
            isChecked = false;
        }
    }
}