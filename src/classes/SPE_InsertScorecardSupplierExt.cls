public with sharing class SPE_InsertScorecardSupplierExt {
    
    SPE_ScorecardGenerator__c objSG;
    String idScorecardTemplate;
    Id idScorecardGenId;
    
  //****************************Changes for Encryption*************************//  
    private Set<String> existSupplier = new Set<String>();
    private Set<Id> existSupplierId = new Set<Id>();
  //****************************END*************************//   
  
    List<SPE_ScorecardSPETemplateMap__c> lstScSPETemplateMapRecords;
    List<SPE_ScorecardSupplierMap__c> lstExistingSuppliers;
    public List<SPE_SPEPlan__c> lstSPEPlans{get;set;}
    public String supplierName {get;set;}
    public boolean isShowSuppliers{get;set;}
    public boolean isSearch{get;set;}
    public List<SupplierWrapper> SupplierWrapperList {get;set;}
    public List<SupplierWrapper> SupplierWrapperListSelected {get;set;}
    public Set<Id> setIds {get;set;}
    public Integer supplimit{get;set;}
    
    
    public List<SPE_ScorecardSupplierMap__c> lstSSM{get;set;}
    public SPE_ScorecardSupplierMap__c objSSM{get;set;}
    Set<Id> idSPETemplates;
    Set<String> setExistingSupNames = new Set<String>();
    List<SPE_ScorecardSupplierMap__c> toDelete;
    
    
    public SPE_InsertScorecardSupplierExt(Apexpages.Standardcontroller st){
        system.debug('st.getId()----' + st.getId());
        idScorecardGenId = st.getId();
        isShowSuppliers = true;
        isSearch = false;
        objSG = new SPE_ScorecardGenerator__c();
        SupplierWrapperListSelected = new List<SupplierWrapper>();
        lstScSPETemplateMapRecords = new List<SPE_ScorecardSPETemplateMap__c>();
        lstExistingSuppliers = new List<SPE_ScorecardSupplierMap__c>();
        SupplierWrapperList = new List<SupplierWrapper>();
        lstSPEPlans = new List<SPE_SPEPlan__c>();
        idSPETemplates = new Set<Id>();
        setIds = new Set<Id>();
        supplimit = 0;
        
        objSG = [select 
                    Id,Name,ScorecardTemplate__c,CategoryCluster__c,Categorygroup__c,Category__c,Region__c,SubRegion__c,country__c,project__c
                from 
                    SPE_ScorecardGenerator__c
                where
                    Id =: idScorecardGenId];
        system.debug('objSG.ScorecardTemplate__c----' + objSG.ScorecardTemplate__c);
        if(objSG.ScorecardTemplate__c != null){
            idScorecardTemplate = objSG.ScorecardTemplate__c;
        }
        
        lstExistingSuppliers = [Select Id,Supplier__c,Supplier__r.Name,Supplier__r.EnterpriseId__c,ScorecardGenerator__c,Approver__c,SupplierContact__c,CC_Contact1__c,CC_Contact2__c From SPE_ScorecardSupplierMap__c where ScorecardGenerator__c =: objSG.Id];
        system.debug('idScorecardTemplate----' + idScorecardTemplate);
        if(idScorecardTemplate != null && idScorecardTemplate != ''){
            system.debug('idScorecardTemplate---11-' + idScorecardTemplate);
            lstScSPETemplateMapRecords = [select
                                              Id,SPETemplate__c,Weight__c
                                          from 
                                              SPE_ScorecardSPETemplateMap__c
                                          where
                                              ScorecardTemplate__c =: idScorecardTemplate];
        }
        
        for(SPE_ScorecardSPETemplateMap__c objScSPETem : lstScSPETemplateMapRecords){
            idSPETemplates.add(objScSPETem.SPETemplate__c);
        }
        system.debug('idSPETemplates----' + idSPETemplates);
        
        // matching scope of scorecard with plans
        string query='select Id,(Select Supplier__c,Supplier__r.Name,Supplier__r.EnterpriseId__c From SPE_Plan_Supplier_Maps__r limit 990) from SPE_SPEPlan__c where SPETemplate__c IN :idSPETemplates';
        
             String CategoryArea;
             String CategoryGroup;
             String Category; 
             String country; 
             string project; 
             string SubMarket;
             string market;                      
        if(!objSG.region__c.containsIgnoreCase('All')){
        market=objSG.region__c;
        query=query+' and region__c=:market';
        }
        if(!objSG.SubRegion__c.containsIgnoreCase('All')){
        Submarket=objSG.SubRegion__c;
        query=query+' and SubRegion__c=:Submarket';
        }
        if(!objSG.Country__c.containsIgnoreCase('All')){
        country=objSG.Country__c;
        query=query+' and Country__c=:country';
        } 
        if(!objSG.Project__c.containsIgnoreCase('All')){
        project=objSG.Project__c;
        query=query+' and project__c=:project';
        }
         if(!objSG.Category__c.containsIgnoreCase('All')){
        Category=objSG.Category__c;
        query=query+' and Category__c=:Category';
        }
        if(!objSG.CategoryGroup__c.containsIgnoreCase('All')){
        CategoryGroup=objSG.CategoryGroup__c;
        query=query+' and CategoryGroup__c=:CategoryGroup';
        }
        if(!objSG.CategoryCluster__c.containsIgnoreCase('All')){
        CategoryArea=objSG.CategoryCluster__c;
        query=query+' and CategoryCluster__c=:CategoryArea';
        }
        
        
      lstSPEPlans =  Database.query(query);
       
      /**  lstSPEPlans = [select
                          Id,(Select Supplier__c,Supplier__r.Name,Supplier__r.EnterpriseId__c From 

SPE_Plan_Supplier_Maps__r)
                       from
                           SPE_SPEPlan__c
                       where
                           SPETemplate__c IN :idSPETemplates];  
        **/
        lstExistingSuppliers.sort();
        for(SPE_ScorecardSupplierMap__c ssmT : lstExistingSuppliers){
            SupplierWrapper sc = new SupplierWrapper();
            sc.isChecked = true;
            sc.strEnterpriseName = ssmT.Supplier__r.EnterpriseId__c;
            sc.strSupplierName = ssmT.Supplier__r.Name;
            sc.idEntId = ssmT.Supplier__c;
            sc.idPlanSuppId = ssmT.Id;
            sc.isExisting = true;
            sc.scMap = ssMT;
            SupplierWrapperList.add(sc);
            if (SupplierWrapperList.size()>990)
                {
                    break;
                }
                
            supplimit = SupplierWrapperList.size();
            System.Debug('$$$$$$$$$$$$$$$$$$$$$$'+supplimit);
                
            setExistingSupNames.add(sc.strEnterpriseName);
            setIds.add(sc.idEntId);
            
         //****************************Changes for Encryption*************************//   
            existSupplier.add(ssmT.Supplier__r.EnterpriseId__c);
            existSupplierId.add(ssmT.Supplier__c);
         //****************************END*************************//   
            
        }
            
        for(SPE_SPEPlan__c s : lstSPEPlans){
            for(SPE_SPEPlanSupplierMap__c s1 : s.SPE_Plan_Supplier_Maps__r){
                if(!setExistingSupNames.contains(s1.Supplier__r.EnterpriseId__c)){
                    SupplierWrapper sc = new SupplierWrapper();
                    sc.isChecked = false;
                    sc.strEnterpriseName = s1.Supplier__r.EnterpriseId__c;
                    sc.strSupplierName = s1.Supplier__r.Name;
                    sc.idEntId = s1.Supplier__c;
                    //sc.idPlanSuppId = s1.Id;
                    sc.isExisting = false;
                    SupplierWrapperList.add(sc);
                    if (SupplierWrapperList.size()>990)
                        {
                            break;
                        }
                    supplimit = SupplierWrapperList.size();
                    
                    System.Debug('@@@@@@@@@@@@@@@@@@@@@@@@'+supplimit);
                }
            }
        }
        system.debug('existSupplier----' + existSupplier);
        system.debug('existSupplierId----' + existSupplierId);    
    
    }
    
    public void searchSuppliers(){
        if(supplierName !=''){
            isSearch = true;
            SupplierWrapperListSelected = new List<SupplierWrapper>();
            String searchString = supplierName;
            
            if   (searchString !=null && searchString.containsIgnoreCase('*'))
            {
              //searchString = searchString.replaceAll('[*]', '%');
            }
            
            //searchString = '%' + searchString + '%'; 
         if (supplierName != '' && supplierName != '*')
            {
          //*******************************Changes For Encryption***********************//
              
              /*List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE EnterpriseId__c LIKE: searchString AND
                                                  EnterpriseId__c not IN: existSupplier AND
                                                  ParentId = Null AND
                                                  EnterpriseId__c != null 
                                             LIMIT 100];*/
                                             
               List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE Id not IN: existSupplierId AND
                                                   ParentId = Null
                                             LIMIT 10000];
                                                                                                                        
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
                    SupplierWrapper sw = new SupplierWrapper();
                    sw.isChecked = false;
                    sw.strEnterpriseName = a.EnterpriseId__c;
                    sw.strSupplierName = a.Name;
                    sw.idEntId = a.Id;
                    sw.isExisting = false;
                    SupplierWrapperListSelected.add(sw);
                    if (SupplierWrapperListSelected.size()>(990-supplimit))
                        {
                            break;
                        }
                }
              }  
            }                          
          } 
            
        //******************************************END**********************************//          
        }
        else{
            isSearch = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please provide atleast one character for the wild card search'));
        }
    }
    public void addToMainList(){
        for(SupplierWrapper sw : SupplierWrapperListSelected){
            if(sw.isChecked){
                if(!setIds.contains(sw.idEntId)){
                SupplierWrapperList.add(sw);
                setIds.add(sw.idEntId);
                }
                else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'The supplier is already selected'));
                }
                
            }
        }
        searchSuppliers();
    }
    public void showNextPanel(){
        if(SupplierWrapperList.size() > 0 ){
            isShowSuppliers = false;
            toDelete = new List<SPE_ScorecardSupplierMap__c>();
            lstSSM = new List<SPE_ScorecardSupplierMap__c>();
            for(SupplierWrapper sw : SupplierWrapperList){
                if(!sw.isChecked && sw.isExisting && sw.idPlanSuppId != null){
                    SPE_ScorecardSupplierMap__c s = new SPE_ScorecardSupplierMap__c

(id=sw.idPlanSuppId,ScorecardGenerator__c=idScorecardGenId);
                    toDelete.add(s);
                }
            }
            system.debug('toDelete---' + toDelete);
            if(SupplierWrapperListSelected.size() > 0)
                SupplierWrapperList.addAll(SupplierWrapperListSelected);
            for(SupplierWrapper sw : SupplierWrapperList){
                if(sw.isChecked){
                    objSSM = new SPE_ScorecardSupplierMap__c();
                    objSSM.Supplier__c = sw.idEntId;
                    objSSM.ScorecardGenerator__c = idScorecardGenId;
                    objSSM.Approver__c = sw.scMap.Approver__c;
                    objSSM.SupplierContact__c = sw.scMap.SupplierContact__c;
                    objSSM.CC_Contact1__c = sw.scMap.CC_Contact1__c;
                    objSSM.CC_Contact2__c = sw.scMap.CC_Contact2__c;
                    if(sw.idPlanSuppId != null)
                        objSSM.Id = sw.idPlanSuppId;
                    lstSSM.add(objSSM);
                }
            }
        }
        else{
            if(SupplierWrapperListSelected.size() == 0)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please add suppliers to proceed'));
            else
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please click "Add" button to add the suppliers to proceed'));
        }
    }
    
    public pagereference gotoDetailPage(){
        system.debug('lstSSM----' + lstSSM);
        if(!lstSSM.isEmpty()){
            try{
                upsert lstSSM;
                delete toDelete;
            }
            catch(exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
                return null;
            }
        }
            
        pagereference pg = new pagereference('/' + idScorecardGenId);
        pg.setRedirect(true);
        return pg;
    }
    public class SupplierWrapper
    {
        public Boolean isChecked {get;set;}
        public String strEnterpriseName {get;set;}
        public String strSupplierName {get;set;}
        public Id idEntId{get;set;}
        Id idPlanSuppId;
        boolean isExisting;
        SPE_ScorecardSupplierMap__c scMap;
    }
}