public with sharing class SPE2_PlanRemovesupplierext 
{
    private ApexPages.StandardController standardController;
    public List<supplierWrapper> SuppWrapperlist{get;set;}
    public String spePlanIdentifier{get;set;}
    public SPE2_PlanRemovesupplierext(ApexPages.StandardController standardController){
        this.standardController = standardController;
        SuppWrapperlist = new List<supplierWrapper>();        
    }
        
    public void fetchSuppliers(){
        spePlanIdentifier = apexpages.currentpage().getparameters().get('planIdentifier');
        List<SPE_SPEPlanSupplierMap__c> supplierPlanList = new List<SPE_SPEPlanSupplierMap__c>();
        supplierPlanList = [Select Id,Name,SPEPlan__c,SPEPlan__r.Name,Supplier__c,Supplier__r.Name,
                           SPEPlan__r.identifierParam__c From SPE_SPEPlanSupplierMap__c                                                      
                           where SPEPlan__r.identifierParam__c = :spePlanIdentifier];
                           
        
        Map<String,List<String>> suppMapIds = new Map<String,List<String>>();
        for(SPE_SPEPlanSupplierMap__c pl :supplierPlanList){
            if(!suppMapIds.containskey(pl.Supplier__c)){
                suppMapIds.put(pl.Supplier__c,new List<String>()); 
            }   
            suppMapIds.get(pl.Supplier__c).add(pl.SPEPlan__r.Name);                                 
        }
        List<Account> suppList = [Select Id,Name From Account Where Id IN: suppMapIds.keySet()];
        Map<String,String> accountNameMap = new Map<String,String>();
        for(Account ac :suppList){
            accountNameMap.put(ac.Id,ac.Name);
        }
        for(String s :suppMapIds.keySet()){
            SuppWrapperlist.add(new supplierWrapper(accountNameMap.get(s),s,suppMapIds.get(s)));
        }
        system.debug('suppMapIds::'+suppMapIds);
    }
    public PageReference fetchSPEplans()
    {       
        return null;        
    }
    public PageReference returnbackToPlan(){
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    public PageReference removeSupplierPlanMap(){
        List<SPE_SPEPlanSupplierMap__c> suppPlansToDelete = new List<SPE_SPEPlanSupplierMap__c>();
        Set<String> supplierIds = new Set<String>();
        Set<String> spePlans = new Set<String>();
        for(supplierWrapper sw :SuppWrapperlist){
            if(sw.isSelected){
                supplierIds.add(sw.supplierId);
                spePlans.addAll(sw.PlanNames);
            }
        }
        suppPlansToDelete = [Select Id From SPE_SPEPlanSupplierMap__c Where Supplier__c IN : supplierIds AND SPEPlan__r.Name IN :spePlans];
        
        try{
            delete suppPlansToDelete;
        }catch(exception e){}
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    public class supplierWrapper{
        public String supplier{get;set;}
        public String supplierId{get;set;}
        public boolean isSelected{get;set;}
        public String Plans{get;set;}
        public List<String> planNames{get;set;}
        public supplierWrapper(String supplier, String supplierId,List<String> PlanNames){       
            this.supplier = supplier;
            this.supplierId= supplierId;
            plans = '';
            this.planNames = planNames;
            for(String s :PlanNames){
                plans = plans + s + ';';  
            }
            
            this.isSelected = false;
        }
    }

    
}