public with sharing class SPE_SPEPlanRespondentExt 
{   
    public List<RespondentWrapper> respondentWrapperList {get;set;}
    
    private Id spePlanId;
    
    private SPE_SPEPlan__c spePlan;
    
    public String contactName {get;set;}
    
    private Set<Id> existContactIds = new Set<Id>();
     
    public SPE_SPEPlanRespondentExt (Apexpages.Standardcontroller st)
    {
        spePlanId = st.getId();
        
        spePlan = [SELECT Id, CategoryCluster__c, CategoryGroup__c, Category__c
                   FROM SPE_SPEPlan__c
                   WHERE Id =: spePlanId];
        
        addRespondent ();
    }   
    
    public void addRespondent ()
    {
        respondentWrapperList = new List<RespondentWrapper>();
        
        List<SPE_Respondent__c> respondents = [SELECT Id, Contact__c, Contact__r.Email, Contact__r.FirstName, Contact__r.LastName 
                                                   FROM SPE_Respondent__c
                                                   WHERE SPEPlan__c =: spePlanId];
        for (SPE_Respondent__c res: respondents)
        {
            existContactIds.add(res.Contact__c);
        }
        
        List<Contact> contactRespondentList = [SELECT Id, Email, FirstName, LastName, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                               FROM Contact  
                                               WHERE Id In: existContactIds 
                                              ];
                                    
        Map<Id, List<SPE_CategoryInfo__c>> contactCategoriesMap = new Map<Id, List<SPE_CategoryInfo__c>>();
        
        for (Contact c: contactRespondentList)
        {
            contactCategoriesMap.put(c.Id, c.Categories_Info__r);
        }
        
        for (SPE_Respondent__c res: respondents)
        {
            RespondentWrapper rw = new RespondentWrapper(res, contactCategoriesMap.get(res.Contact__c));
            respondentWrapperList.add(rw);
        }
        
        Set<Id> contactsIds = new Set<Id>();
        
        for (SPE_CategoryInfo__c cat : [SELECT Category__c, CategoryCluster__c, CategoryGroup__c, Contact__c 
                                        FROM SPE_CategoryInfo__c
                                        WHERE ((CategoryCluster__c =: spePlan.CategoryCluster__c AND CategoryGroup__c = null AND Category__c = null) OR
                                                (CategoryCluster__c =: spePlan.CategoryCluster__c AND CategoryGroup__c =: spePlan.CategoryGroup__c AND Category__c = null) OR
                                                (CategoryCluster__c =: spePlan.CategoryCluster__c AND CategoryGroup__c =: spePlan.CategoryGroup__c AND Category__c =: spePlan.Category__c)
                                                ) AND
                                                Contact__c not In: existContactIds AND
                                                Contact__c != null])
        {
            contactsIds.add(cat.Contact__c);
        }
        
        
        List<SPE_SPEPlanSupplierMap__c> planSupplier = [SELECT Id, Supplier__c, Supplier__r.SupplierManager__c
                                                        FROM SPE_SPEPlanSupplierMap__c
                                                        WHERE SPEPlan__c =: spePlanId ];
        
        for (SPE_SPEPlanSupplierMap__c sup: planSupplier)
        {
            contactsIds.add(sup.Supplier__r.SupplierManager__c);
        }
        
        
        List<Contact> contactList = [SELECT Id, Email, FirstName, LastName, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                     FROM Contact  
                                     Where Id In: contactsIds AND
                                           Id not In: existContactIds ];
        
        for (Contact c : contactList)
        {
            RespondentWrapper res = new RespondentWrapper(c, c.Categories_Info__r);
            
            respondentWrapperList.add(res);
            
            existContactIds.add(c.Id);
        }
        
    }
    
    public void searchRespondent ()
    {
        List<RespondentWrapper> selectedRespondent = new List<RespondentWrapper>();
        
        List<SPE_Respondent__c> toBeDeletedRespondent = new List<SPE_Respondent__c>();
        
        selectedRespondent.addAll(respondentWrapperList);
        
        respondentWrapperList.clear();
        
        
        for (RespondentWrapper r : selectedRespondent)
        {
            if (r.isChecked)
            {
                respondentWrapperList.add(r);
            }
            else
            {
                if (r.res.Id != null)
                {
                    toBeDeletedRespondent.add(r.res);
                }
                existContactIds.remove(r.res.Contact__c);
            }
        }
        
        delete toBeDeletedRespondent;
        
        String searchString = contactName;
        
        if  (searchString !=null && searchString.containsIgnoreCase('*'))
        {
            searchString = searchString.replaceAll('[*]', '%');
        }
        
        if (contactName != '' && contactName != '*')
        {
           List<Contact> contactList = [SELECT Id, Email, FirstName, LastName, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                         FROM Contact  
                                         WHERE (FirstName LIKE: searchString OR LastName LIKE: searchString) AND
                                               Id not IN: existContactIds 
                                               LIMIT 100 ];
            for (Contact c : contactList)
            {
                RespondentWrapper res = new RespondentWrapper(c, c.Categories_Info__r);
                respondentWrapperList.add(res);
                existContactIds.add(c.Id);
            }   
        }
    }
    
    
    public Pagereference insertRespondent()
    {
        List<SPE_Respondent__c> toBeCreatedRespondent = createRespondent(respondentWrapperList);
        
        upsert toBeCreatedRespondent;
        
        Pagereference pr = new Pagereference('/'+spePlanId);
        
        return pr;
    }
    
    public Pagereference cancel()
    {
        Pagereference pr = new Pagereference('/'+spePlanId);
        
        return pr;
    }
    
    private List<SPE_Respondent__c> createRespondent (List<RespondentWrapper> respondentWrapperList)
    {
        
        List<SPE_Respondent__c> toBeCreatedRespondent = new List<SPE_Respondent__c>();
        
        List<SPE_Respondent__c> toBeDeletedRespondent = new List<SPE_Respondent__c>();
        
        for (RespondentWrapper rw : respondentWrapperList)
        {
            if (rw.isChecked)
            {
                rw.res.SPEPlan__c = spePlanId;
                toBeCreatedRespondent.add(rw.res);
            }
            else if (rw.isChecked == false && rw.res.Id != null)
            {
                toBeDeletedRespondent.add(rw.res);
            }
        }
        
        delete toBeDeletedRespondent;
        
        return toBeCreatedRespondent;
    }
    
    public class RespondentWrapper
    {
        public SPE_Respondent__c res {get;set;}
        public Boolean isChecked {get;set;}
        public List<SPE_CategoryInfo__c> categories {get;set;}
        
        public RespondentWrapper (SPE_Respondent__c res, List<SPE_CategoryInfo__c> cat)
        {
            this.res = res;
            isChecked = true;
            categories = cat;
        }
        
        public RespondentWrapper (Contact con, List<SPE_CategoryInfo__c> cat)
        {
            res = new SPE_Respondent__c();
            res.Contact__c = con.Id;
            res.Contact__r = con;
            
            categories = new List<SPE_CategoryInfo__c>();
            categories = cat;
            
            isChecked = false;
        }
    }

}