public with sharing class SPE_BulkUpdation{
    
    private String soqlOnCM {get;set;}
    
    public string stage {get;set;}
    
    public Date openDate {get;set;}
    
    public SPE_ConsequenceManagement__c conManagement {get;set;}
    
    public List<SPE_ConsequenceManagement__c> conManagementList {get;set;}
    
    public list<CMWrapper> CMWrapperList {get; set;}
    
    private list<CMWrapper> unselectedCMWrapperList;
    
    public list<CMWrapper> selectedWrapperList {get; set;} 
    
    List<SPE_ConsequenceManagement__c> updateCMList {get; set;} 
    
    public list<SPE_ConsequenceManagement__c> selectedCMWrapperList {get; set;} 
    
   //**************************************Line Added For Encryption******************************//  
    private String kpiName;
    private String supplierName;
   //**************************************END******************************//
    
    @Testvisible private map<ID,SPE_ConsequenceManagement__c> selectedCMMap;
    
    CMWrapper cmObj;
    
    public ID watchlistId {get;set;}
    
    public String sortDir
    {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
    
    public String sortField
    {
        get  { if (sortField == null) {sortField = 'Name'; } return sortField;  }
        set;
    }
    
    public SPE_BulkUpdation()
    {
        conManagement = new SPE_ConsequenceManagement__c();
        unselectedCMWrapperList = new list<CMWrapper>();
        selectedWrapperList = new list<CMWrapper>();
        selectedCMWrapperList = new List<SPE_ConsequenceManagement__c>();
        conManagement.OpenDate__c = system.today();
        openDate = conManagement.OpenDate__c;
        stage = 'Open';
      //  Id watchlistId = Schema.SObjectType.SPE_ConsequenceManagement__c.RecordTypeInfosByName.get('Watchlist').RecordTypeId;
        watchlistId = [Select id from RecordType where sObjectType = 'SPE_ConsequenceManagement__c' and developerName ='Watchlist' ].id;
    
    //***************************Changes For Encryption*****************************//
        soqlOnCM = 'select Id,Name,TicketStatus__c,OpenDate__c,KPIName__c,KPIName__r.KPI_Title__c,SPETracker__c,Supplier__c, KPIName__r.Name,Supplier__r.Name,SPETracker__r.Name from SPE_ConsequenceManagement__c where TicketStatus__c =: stage and RecordTypeId =: watchlistId and Supplier__c != null ';
   //***************************END*****************************//     
        //soqlOnCM += ' and OpenDate__c <=: openDate';
        runBulkQuery();
    }
    
    public void toggleSort()
    {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        runBulkQuery();
    }
    
    public PageReference bulkDataSearch() 
    {
      //***************************Changes For Encryption*****************************//  
        kpiName = Apexpages.currentPage().getParameters().get('kpiName');       
        supplierName = Apexpages.currentPage().getParameters().get('supplier');
        System.debug('======>'+kpiName);
        System.debug('======>'+supplierName );
      //***************************END*****************************// 
         
        String speTracker = Apexpages.currentPage().getParameters().get('speTracker');
        
        openDate = conManagement.OpenDate__c != null ? conManagement.OpenDate__c : openDate;
        
      //***************************Changes For Encryption*****************************//  
        soqlOnCM = 'select Id,Name,TicketStatus__c,OpenDate__c,KPIName__c,SPETracker__c,Supplier__c,KPIName__r.KPI_Title__c, KPIName__r.Name,Supplier__r.Name,SPETracker__r.Name from SPE_ConsequenceManagement__c where TicketStatus__c =: stage and RecordTypeId =: watchlistId and Supplier__c != null';
      //***************************END*****************************// 
      
      //***************************Line Commented for Encryption Part*****************************//   
        /*if (!kpiName.equals(''))
          soqlOnCM += ' and KPIName__r.Name LIKE \''+String.escapeSingleQuotes(kpiName)+'%\'';
          if (!supplier.equals(''))
          soqlOnCM += ' and Supplier__r.Name LIKE \''+String.escapeSingleQuotes(supplier)+'%\'';*/  
     //***************************END*****************************//     
        if (!speTracker.equals(''))
          soqlOnCM += ' and SPETracker__r.Name LIKE \''+String.escapeSingleQuotes(speTracker)+'%\'';
        runBulkQuery();
        return null;
    }
    
    public void runBulkQuery()
    {
        try
        {
            String currentUser = userinfo.getuserid();
            
         conManagementList = Database.query(soqlOnCM + ' and OwnerId=:currentUser  order by ' + sortField + ' ' + sortDir + ' NULLS LAST limit 100');
         
          //***************************Changes For Encryption*****************************//
            List<SPE_ConsequenceManagement__c> newconManagementList = new List<SPE_ConsequenceManagement__c>();
             
            for (SPE_ConsequenceManagement__c comm : conManagementList)
            {
                if (!kpiName.equals('') || !supplierName.equals(''))
                {
                    System.debug('kpiName====>'+kpiName);
                    System.debug('supplier====>'+supplierName);
                    
                    if(comm.KPIName__r.KPI_Title__c != Null)
                    {
                        String skpi = comm.KPIName__r.KPI_Title__c;
                        String supplier = comm.Supplier__r.Name;
                        
                        Pattern MyKPIPattern = Pattern.compile('.*'+kpiName+'.*'); 
                        Pattern MySupplierPattern = Pattern.compile('.*'+supplierName+'.*');
                        
                        Matcher MyKPIMatcher = MyKPIPattern.matcher(skpi);
                        Matcher MySupplierMatcher = MySupplierPattern.matcher(supplier);
                        
                        if (MyKPIMatcher.matches() && MySupplierMatcher.matches())
                        {
                            System.debug('Matching====>');
                            newconManagementList.add(comm);
                        }
                    }
                }
                else
                {
                    newconManagementList.add(comm);
                }
            }
            CustomIterable(newconManagementList); 
            
        //***************************END*****************************//
        
        } catch (Exception e) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is no Data Available for Searching criteria'));
        }
    
    }
    
    private void CustomIterable(List<SPE_ConsequenceManagement__c> cmQuery)
     {
       CMWrapperList = new list<CMWrapper>();
       boolean hasSelectedCM = ((selectedCMWrapperList == null || selectedCMWrapperList.isEmpty()) ? false : true);
       for(SPE_ConsequenceManagement__c cm : cmQuery)
       {
            if(hasSelectedCM)
            {
                if(selectedCMMap.containsKey(cm.ID))
                {
                    cmObj = new CMWrapper(true, cm);
                }
                else
                {
                    cmObj = new CMWrapper(false, cm);
                }
            }
            else
            {
                cmObj = new CMWrapper(false, cm);   
            }
            CMWrapperList.add(cmObj);
            system.debug('====CMWrapperList===>'+ CMWrapperList);
       }     
     } 
    
    public List<CMWrapper> getSelected()
    {
      selectedWrapperList.clear();
      unselectedCMWrapperList.clear();
        for(CMWrapper cmWrap : CMWrapperList){
            CMWrapper c1 =new CMWrapper(false,cmWrap.scm);
                system.debug('c1 is: ' + c1);
                if(cmWrap.isSelected == True)
                {
                    c1.isSelected = cmWrap.isSelected;
                    selectedWrapperList.add(c1);
                }else{
                    unselectedCMWrapperList.add(cmWrap);
                }
                
       }
        /*if(cmWrap.isSelected){
            selectedCMMap.put(cmWrap.scm.ID,cmWrap.scm);
        }
        selectedWrapperList.addAll(selectedCMMap.values()); */
        return null;
    }
    
    public PageReference save(){
        
        List<CMWrapper> cmList = selectedWrapperList;
        
        try
        {
            for(CMWrapper cmw : selectedWrapperList)
            {
                cmw.scm.TicketStatus__c = 'Close';
                selectedCMWrapperList.add(cmw.scm);
                CMWrapperList = unselectedCMWrapperList.clone();
            }
            update selectedCMWrapperList;
            selectedWrapperList.clear();
            return null;
        }    
        catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'No Record to Take off from the Watchlist'));
           
        }
        
        /*system.debug('====selectedCMWrapperList===>' + selectedCMWrapperList);
        PageReference pref = ApexPages.currentPage(); 
        Id id = pref.getParameters().get('Id');
        pref .getParameters().clear();
        pref .getParameters().put('Id', id);  
        pref .setRedirect(true);
        return pref; */
        return null;
    }
    
    public List<SPE_ConsequenceManagement__c> getSelectedCMTicket()
    {
        if(selectedCMWrapperList.size()>0){
        
        return selectedCMWrapperList;
        }
        else{
        return null;
        }
    } 
    
  /*  public List<SPE_ConsequenceManagement__c> getSelectedCM()
    {
        if(selectedCMWrapperList.size()>0)
        return selectedCMWrapperList;
        else
        return null;
    } */
     
    public Class CMWrapper
    {
        public boolean isSelected {get;set;}
        public SPE_ConsequenceManagement__c scm {get;set;}
        
        public CMWrapper(boolean isSelected, SPE_ConsequenceManagement__c  scm)
        {
            this.isSelected = isSelected;
            this.scm = scm;
        }
    }
    
    
}