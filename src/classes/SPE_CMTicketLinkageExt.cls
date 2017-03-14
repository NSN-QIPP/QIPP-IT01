public Class SPE_CMTicketLinkageExt
{
    public String kpiName{get; set;}
    public String kpiName1{get; set;}
    public String supplierName{get; set;}
    public List<SPE_ConsequenceManagement__c> matchingCMParent{get;set;}
    public List<CMTicketLinkageWrapper> matchingCMChildWrapList{get;set;}
    private List<CMTicketLinkageWrapper> existingCMChildWrapList;
    private Set<Id> extCMIds;
    private List<CMTicketLinkageWrapper> checkedCMChildWrapList;
    public SPE_ConsequenceManagement__c cm {get;set;}
    public String relType{get;set;}
        
    public Boolean isParent {get;set;}
    
    public SPE_CMTicketLinkageExt(ApexPages.StandardController st)
    {
        //*********************************Changes For Encryption******************************//  
        cm = [SELECT Id, KPIName__r.Name,KPIName__r.KPI_Title__c, Supplier__r.Name, RecordType.Name, MasterCM__c FROM SPE_ConsequenceManagement__c WHERE ID =: st.getId()];
        //*********************************END******************************// 
       
        relType = ApexPages.currentPage().getParameters().get('rel');
        
        //*********************************Changes For Encryption******************************//
        //kpiName = cm.KPIName__r.Name;    
        kpiName1 = cm.KPIName__r.KPI_Title__c;
        //*********************************Changes For Encryption******************************//   
        
        supplierName = cm.Supplier__r.Name;
        
        isParent = false;
        List<SPE_ConsequenceManagement__c > childCMRecords = [SELECT Id, Name, Title__c, SPETracker__c, KPIName__c,KPIName__r.KPI_Title__c, Supplier__c, Supplier__r.Name FROM SPE_ConsequenceManagement__c WHERE MasterCM__c =: st.getId()];
        
        if (relType == 'Child' && childCMRecords.size()>0)
        {
            isParent = true;
        }
        
        extCMIds = new Set<Id>();
        matchingCMParent = new List<SPE_ConsequenceManagement__c>();
        matchingCMChildWrapList = new List<CMTicketLinkageWrapper>();
        existingCMChildWrapList = new List<CMTicketLinkageWrapper>();
        
        for (SPE_ConsequenceManagement__c  cm : childCMRecords )
        {
            existingCMChildWrapList.add(new CMTicketLinkageWrapper(true, cm));
            extCMIds.add(cm.Id);
        }
        
        extCMIds.add(cm.Id);
        matchingCMChildWrapList.addAll(existingCMChildWrapList);
        searchMatchingTicket();
    }
    
    public void searchMatchingTicket()
    {
        List<SPE_ConsequenceManagement__c> matchingCM = new List<SPE_ConsequenceManagement__c>();
        checkedCMChildWrapList = new List<CMTicketLinkageWrapper>();
        
        for (CMTicketLinkageWrapper cmWrapper : matchingCMChildWrapList)
        {
            if (cmWrapper.isSelected)
            {
                checkedCMChildWrapList.add(cmWrapper);
            }
        }
        
        matchingCMChildWrapList = new List<CMTicketLinkageWrapper>();
        matchingCMChildWrapList.addAll(checkedCMChildWrapList);
        
        String recordTypeName = cm.RecordType.Name;
        Id cmId = cm.Id;
        Id supplierId = cm.Supplier__c;
        
        //String kpiNameSearchString = '%'+kpiName+'%';
        
        //*********************************Changes For Encryption******************************//
        String queryString  = 'SELECT Name, Title__c, SPETracker__c, KPIName__c,KPIName__r.KPI_Title__c, Supplier__c, Supplier__r.Name FROM SPE_ConsequenceManagement__c WHERE Id NOT IN : extCMIds AND TicketStatus__c = \'Open\' AND RecordType.Name =: recordTypeName AND MasterCM__c = null AND Supplier__c =: supplierId ';
        
        
        /*if (!String.isBlank(kpiName) && !String.isEmpty(kpiName))
        {
            queryString  = queryString  + ' AND KPIName__r.Name LIKE : kpiNameSearchString';
        }
        
        if (!String.isBlank(supplierName) && !String.isEmpty(supplierName))
        {
            queryString  = queryString  + ' AND Supplier__r.Name LIKE : supplierNameSearchString';
        }*/
        //*********************************END******************************//
        
        matchingCMParent = Database.query(queryString);
        
        //***************************Changes For Encryption*****************************//
        
        List<SPE_ConsequenceManagement__c> matchingCMParentTemp = new List<SPE_ConsequenceManagement__c>();
        
        Integer count = 0;
        for (SPE_ConsequenceManagement__c  cm : matchingCMParent)
        {
            if ((!String.isBlank(kpiName) && !String.isEmpty(kpiName)))
                {
                    if(cm.KPIName__r.KPI_Title__c != Null)
                    {
                        String skpi = cm.KPIName__r.KPI_Title__c;
                        
                        Pattern MyKPIPattern = Pattern.compile('(?i)\\A^'+kpiName);                         
                        Matcher MyKPIMatcher = MyKPIPattern.matcher(skpi);
                       
                        if (MyKPIMatcher.find())
                        {
                            count ++; 
                            
                            if (count  > 100)
                            {
                                break;
                            }
                            matchingCMParentTemp.add(cm);                           
                            matchingCMChildWrapList.add(new CMTicketLinkageWrapper(false, cm));
                        }
                    }
                }
                else
                {
                    matchingCMParentTemp.add(cm);
                    matchingCMChildWrapList.add(new CMTicketLinkageWrapper(false, cm));
                }
        }
        
        matchingCMParent.clear();
        matchingCMParent.addAll(matchingCMParentTemp);
        
        //*********************************END******************************//
    }
    
    public PageReference linkToParent()
    {
        List<SPE_ConsequenceManagement__c> CMChildToBeLiked = new List<SPE_ConsequenceManagement__c>();
        List<CMTicketLinkageWrapper> matchingCMChildWrapListTemp = new List<CMTicketLinkageWrapper>();
        Integer i = 0;
        
        for (CMTicketLinkageWrapper cmWrapper : matchingCMChildWrapList)
        {
            if (cmWrapper.isSelected)
            {
                cmWrapper.cm.MasterCM__c  = cm.Id;
                CMChildToBeLiked.add(cmWrapper.cm);
            }
        }
        
        update CMChildToBeLiked;
        
        PageReference pg = new PageReference('/'+cm.Id);
        
        return pg;
    }
    
    public PageReference link()
    {
        cm.MasterCM__c = ApexPages.currentPage().getParameters().get('masterId');
       
        Update cm;
        
        PageReference pg = new PageReference('/'+cm.MasterCM__c);
        
        return pg;
    }
    
    public Class CMTicketLinkageWrapper
    {
        public Boolean isSelected{get;set;}
        public SPE_ConsequenceManagement__c cm{get;set;}
        
        public CMTicketLinkageWrapper(Boolean isSelected, SPE_ConsequenceManagement__c cm)
        {
            this.isSelected = isSelected;
            this.cm = cm;
        }
    }
}