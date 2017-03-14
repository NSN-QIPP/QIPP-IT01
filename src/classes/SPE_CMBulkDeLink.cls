public Class SPE_CMBulkDeLink
{
    public String supplierName{get; set;}
    public List<SPE_ConsequenceManagement__c> cmList {get;set;}
    
    public SPE_CMBulkDeLink()
    {
        cmList = new List<SPE_ConsequenceManagement__c>();
        supplierName = '';
        searchMatchingTicket();
    }
    
    public void searchMatchingTicket()
    {
        String supplierNameSearchString = '%'+supplierName+'%';
       
       String currentUser = userinfo.getuserid();
    //***************************Changes For Encryption*****************************// 
         Pattern MySupplierPattern = Pattern.compile('.*'+supplierName+'.*');       
      
        /*String queryString  = 'SELECT Id, Name, Title__c, SPETracker__c, KPIName__c, Supplier__c,Supplier__r.Name, ' +
        ' (SELECT Id, Name, Title__c, SPETracker__c, KPIName__c, Supplier__c, Supplier__r.Name FROM Consequence_Management__r )a ' +
        'FROM SPE_ConsequenceManagement__c WHERE '+
        ' Supplier__r.Name LIKE : supplierNameSearchString';*/
        
        String queryString  = 'SELECT Id, Name, Title__c, SPETracker__c, KPIName__c, KPIName__r.KPI_Title__c, Supplier__c,Supplier__r.Name, ' +
        ' (SELECT Id, Name, Title__c, SPETracker__c, KPIName__c, KPIName__r.KPI_Title__c, Supplier__c, Supplier__r.Name FROM Consequence_Management__r )a ' +
        'FROM SPE_ConsequenceManagement__c where OwnerId=:currentUser';
    //***************************END*****************************//
        
        cmList.clear();
        List<SPE_ConsequenceManagement__c> dupCMList = Database.query(queryString);
    
    //***************************Changes For Encryption*****************************//    
        for (SPE_ConsequenceManagement__c cm : dupCMList )
            {
              if  (cm.Consequence_Management__r.size() > 0)
                  { 
                      String ssupplier = cm.Supplier__r.Name;
                      Matcher MySupplierMatcher = MySupplierPattern.matcher(ssupplier);
                      
                       if (MySupplierMatcher.find())
                           { 
                                if  (cm.Consequence_Management__r.size() > 0)
                                    {
                                        cmList.add(cm);
                                    }
                           }
                  }   
            }
     //***************************END*****************************//       
    }
    
    public void deLinkParentTicket()
    {
        Id cmId = ApexPages.currentPage().getParameters().get('Id');
        
        SPE_ConsequenceManagement__c cm = new SPE_ConsequenceManagement__c();
        cm.Id = cmId;
        cm.MasterCM__c = null;
        
        update cm;
        
        searchMatchingTicket();
    }
    
    public void deLinkChildTicket()
    {
        Id cmId = ApexPages.currentPage().getParameters().get('Id');
        
        List<SPE_ConsequenceManagement__c> toBeUpdateCM = [SELECT Id, MasterCM__c FROM SPE_ConsequenceManagement__c WHERE MasterCM__c =:cmId];
        
        for (SPE_ConsequenceManagement__c cm : toBeUpdateCM)
        {
            cm.MasterCM__c = null;
        }
        
        update toBeUpdateCM;
        searchMatchingTicket();
    }
}