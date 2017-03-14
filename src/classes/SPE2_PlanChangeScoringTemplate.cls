public with sharing class SPE2_PlanChangeScoringTemplate{
    private ApexPages.StandardController standardController;
    public List<SPE_SPEPlan__c> spePlanList{get;set;}
    public String spePlanIdentifier{get;set;}
    public SPE_SPEPlan__c spePlan{get;set;}
    public SPE2_PlanChangeScoringTemplate(ApexPages.StandardController standardController){
        spePlan = new SPE_SPEPlan__c();
        spePlanList = new List<SPE_SPEPlan__c>();
        spePlanIdentifier = apexpages.currentpage().getparameters().get('planIdentifier');
        spePlanList = [Select Id,Name,identifierParam__c,SPEScoringTemplate__c From SPE_SPEPlan__c 
                      Where identifierParam__c =:spePlanIdentifier];
        
    }
    public PageReference returnbackToPlan(){
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    public PageReference updateSPEPlans(){
        for(SPE_SPEPlan__c pl :spePlanList){
            pl.SPEScoringTemplate__c = spePlan.SPEScoringTemplate__c;
        }
        try{
            update spePlanList;
        }catch(Exception e){}
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
}