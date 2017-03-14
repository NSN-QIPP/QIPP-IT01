public with sharing class SPE_ConsequenceMngtAddContactExt 
{
    private SPE_ConsequenceManagement__c speConsequenceMngt;
    public String contactName {get;set;}
    public Boolean isSupplierManager{get;set;}
    public List<Contact> contactSearchResult{get; set;}
    public List<User> userSearchResults {get;set;}
    
  //*******************Changes For Encryption*************************//  
    private String EID;
    private ID EIDEncrypted;
  //******************************END************************************//  
    
    private String defaultQuery; 
     
    public SPE_ConsequenceMngtAddContactExt(Apexpages.Standardcontroller st)
    {
        speConsequenceMngt = [SELECT Id, CategoryManager__c,CategoryArea__c, CategoryGroup__c, CategoryCluster__c, Supplier__c, Supplier__r.EnterpriseId__c, SupplierManagerContact__c, Contact__c
                                              FROM SPE_ConsequenceManagement__c 
                                              WHERE Id =: st.getId()];
        
     //*******************Changes For Encryption*************************//   
        EID = speConsequenceMngt.Supplier__r.EnterpriseId__c;
        EIDEncrypted = speConsequenceMngt.Supplier__c;
     //******************************END************************************//  
        
        isSupplierManager = false;
        if (Apexpages.currentPage().getParameters().get('supplierManager') != null)
        {
            isSupplierManager = true;
        }
        else
        {
          //*******************Changes For Encryption*************************//  
            //defaultQuery = 'SELECT Id, Email, FirstName, LastName, Account.EnterpriseId__c, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) FROM Contact WHERE Account.EnterpriseId__c =: EID';
            defaultQuery = 'SELECT Id, Email, FirstName, LastName,AccountId, Account.EnterpriseId__c, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) FROM Contact WHERE AccountId =: EIDEncrypted';
          //******************************END************************************//
            
            contactSearchResult = database.query(defaultQuery);
        }
        contactName ='';
    }   
    
    public void doSearch()
    {
        String whereCond = ' Where ';
        String query;
        
        String searchString = contactName;
        
        if  (searchString !=null && searchString.containsIgnoreCase('*'))
        {
            searchString = searchString.replaceAll('[*]', '%');
        }
        
        if(isSupplierManager)
        {
            userSearchResults = new list<User>();
            if(!string.isBlank(searchString))
            {
                query = 'SELECT Id, Email, Name, Username, Profile.Name, IsActive FROM User WHERE Name LIKE : searchString ';
            }
            
            if(query != null){
                userSearchResults = Database.query(query);
            }
            if(userSearchResults.isEmpty()){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Either you have not mentioned User name or there are no existing records exists for selected user name'));
            }
        }
        else
        {
           
           //*******************Changes For Encryption*************************//
            query = 'SELECT Id, Email, FirstName, LastName,AccountId, Account.EnterpriseId__c, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) FROM Contact ';
           //******************************END************************************//
            
            contactSearchResult = new list<Contact>();
            if(string.isBlank(searchString))
            {
                if(speConsequenceMngt.Supplier__r.EnterpriseId__c !=null){
                    query = defaultQuery;
                }
            }
            else
            {
                query = query+ ' WHERE (FirstName LIKE : searchString  OR LastName LIKE : searchString) And AccountId != null';     
            }
            contactSearchResult = database.query(query);
            if(contactSearchResult.isEmpty())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'There are no records exists for the given contact name'));
            }         
        }
    }
    
    public Pagereference addContact()
    {       
        if (isSupplierManager == false)
        {
            speConsequenceMngt.Contact__c = Apexpages.currentPage().getParameters().get('contactId');
        }   
        else
        {
            speConsequenceMngt.CategoryManager__c = Apexpages.currentPage().getParameters().get('contactId');            
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
    
  }