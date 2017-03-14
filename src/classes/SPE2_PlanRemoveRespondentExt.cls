public with sharing class SPE2_PlanRemoveRespondentExt 
{
    private ApexPages.StandardController standardController;
    public List<respondentWrapper> respWrapperlist{get;set;}
    public String spePlanIdentifier{get;set;}
    public SPE2_PlanRemoveRespondentExt(ApexPages.StandardController standardController){
        this.standardController = standardController;    
        respWrapperlist = new List<respondentWrapper>();
    }
    
    
    public void fetchRespondent(){
        spePlanIdentifier = apexpages.currentpage().getparameters().get('planIdentifier');
        List<SPE_Respondent__c> respPlanList = new List<SPE_Respondent__c>();
        respPlanList = [Select Id,Name,SPEPlan__c,SPEPlan__r.Name,Contact__c,Contact__r.Name,
                           Email__c,SPEPlan__r.identifierParam__c From SPE_Respondent__c
                           where SPEPlan__r.identifierParam__c = :spePlanIdentifier];
                           
        
        Map<String,List<String>> respMapIds = new Map<String,List<String>>();
        for(SPE_Respondent__c res :respPlanList){
            if(!respMapIds.containskey(res.Contact__c)){
                respMapIds.put(res.Contact__c,new List<String>()); 
            }   
            respMapIds.get(res.Contact__c).add(res.SPEPlan__r.Name);                                 
        }
        List<Contact> conList = [Select Id,Name,email From Contact Where Id IN: respMapIds.keySet()];
        Map<String,String> contactNameMap = new Map<String,String>();
        for(Contact c :conList){
            contactNameMap.put(c.Id,c.Name+'~'+c.email);
        }
        for(String s :respMapIds.keySet()){
            respWrapperlist.add(new respondentWrapper(contactNameMap.get(s).split('~')[0],s,respMapIds.get(s),contactNameMap.get(s).split('~')[1]));
        }
        
    }
    
    public PageReference returnbackToPlan(){
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    public pageReference removeRespondentPlanMap(){
        List<SPE_Respondent__c> respPlansToDelete = new List<SPE_Respondent__c>();
        Set<String> respIds = new Set<String>();
        Set<String> spePlans = new Set<String>();
        for(respondentWrapper rw :respWrapperlist){
            if(rw.isSelected){
                respIds.add(rw.respondentId);
                spePlans.addAll(rw.PlanNames);
            }
        }
        respPlansToDelete = [Select Id From SPE_Respondent__c Where Contact__c IN : respIds AND SPEPlan__r.Name IN :spePlans];
        
        try{
            delete respPlansToDelete;
        }catch(exception e){}
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    
    public class respondentWrapper{
        public String respondent{get;set;}
        public String respondentId{get;set;}
        public boolean isSelected{get;set;}
        public String Plans{get;set;}
        public String email{get;set;}
        public List<String> planNames{get;set;}
        public respondentWrapper(String respondent, String respondentId,List<String> PlanNames,String email){       
            this.respondent = respondent;
            this.respondentId= respondentId;
            plans = '';
            this.email = email;
            this.planNames = planNames;
            for(String s :PlanNames){
                plans = plans + s + ';';  
            }            
            this.isSelected = false;
        }
    }

    
}