public class SPE2_PlanBulkOperationExt{
    private ApexPages.StandardSetController standardController;
    public List<SPE_SPEPlan__c> planList{get;set;}
    public String selectedOperation{get;set;}
    public set<string> selectedPlanIds{get;set;}
    public String spePlanIdentifier{get;set;}
    public SPE2_PlanBulkOperationExt(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        planList = new List<SPE_SPEPlan__c>();
        selectedPlanIds = new Set<String>();
        spePlanIdentifier = system.Now()+';'+userInfo.getUserId();
    }
    public PageReference fetchSPEplans(){       
        List<SPE_SPEPlan__c> selectedplans = (List<SPE_SPEPlan__c>) standardController.getSelected();              
        for(SPE_SPEPlan__c pl :selectedplans){
            selectedPlanIds.add(pl.Id);
        }
        planList = [Select Id,name,identifierParam__c From SPE_SPEPlan__c Where Id IN :selectedPlanIds];
        for(SPE_SPEPlan__c pl :planList){
            pl.identifierParam__c = spePlanIdentifier;
        }
        update planList;
        return null;        
    }
     
    public List<SelectOption> getOperations() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('SPE2PlanBulkOperation','--None--'));
        options.add(new SelectOption('SPE2_PlanAddSupplier','Add Suppliers'));
        options.add(new SelectOption('SPE2_planRemoveSuppliers','Remove Suppliers'));
        options.add(new SelectOption('SPE2_PlanAddRespondent','Add Respondents'));        
        options.add(new SelectOption('SPE2_planRemoveRespondents','Remove Respondents'));
        options.add(new SelectOption('SPE2_planChangeScoringTemplate','Change Scoring Template'));        
        options.add(new SelectOption('SPE2_planChangeStage','Change Stage'));
        options.add(new SelectOption('SPE2_planChangeDate','Change Date'));              
        return options;
    }
    
    public pageReference goToOperationPage(){
        pageReference pf = new pageReference('/apex/'+selectedOperation+'?planIdentifier='+spePlanIdentifier);
        pf.setRedirect(true);
        return pf;
    }
    public PageReference returnbackToPlan(){
        Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr =new Pagereference('/'+keyPrefix);
        return pr;
    }
    
}