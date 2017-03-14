public class SPE_SPEPlanCloneExt 
{
    String strSPEPlan;
    public boolean isError{get;set;}
    public SPE_SPEPlanCloneExt(ApexPages.Standardcontroller st){
         isError = false;
         if (st.getId() != null){
             strSPEPlan = st.getId();
         }
    }
    
    /*******************************************************************************************************
     * METHOD FOR CLONNING THE SPE PLAN FROM THE CLONE BUTTON OF THE DETAIL PAGE OF SPE PLAN
     * *****************************************************************************************************/
    public PageReference cloneSPEPlan(){
        SPE_SPEPlan__c objSpePlan = new SPE_SPEPlan__c();
        List<SPE_SPEPlanSupplierMap__c> lstSpePlanSuppliers = new List <SPE_SPEPlanSupplierMap__c>();
        List<SPE_Respondent__c> lstSurveyRespondent = new List<SPE_Respondent__c>();
        
        objSpePlan = [SELECT Id, SPEScoringTemplate__c, Name, PPM1__c, CM__c, Stage__c, SPEPlanName__c, Region__c,
                             SubRegion__c, Country__c, Category__c, Project__c, SPETemplate__c, SPETemplate__r.Name,
                             StartDate__c, EndDate__c,FrequencyInMonths__c, SurveyExecutionBeforeIndays__c,
                             SurveyReminderBeforeExecutionDate__c, SurveyHeader__c, SurveyFooter__c,
                             CategoryCluster__c, CategoryGroup__c, BusinessUnit__c, BusinessLine__c, Product__c,
                             Product1__c, Product2__c, Product3__c,Organization_Group__c
                       FROM SPE_SPEPlan__c 
                       WHERE Id =: strSPEPlan];
        
        objSpePlan.Id = null;
        objSpePlan.Stage__c = 'Draft';
        
        lstSpePlanSuppliers = [SELECT Id,Supplier__c,SPEPlan__c
                              FROM SPE_SPEPlanSupplierMap__c
                              WHERE SPEPlan__c = : strSPEPlan];
        
        lstSurveyRespondent = [select id,Contact__c,Email__c,SPEPlan__c
                              FROM SPE_Respondent__c
                              WHERE SPEPlan__c = : strSPEPlan];
        
        try{
            if(objSpePlan != null){
                insert objSpePlan;
            }
            if(objSpePlan.Id !=  null){
                for(SPE_SPEPlanSupplierMap__c objSM : lstSpePlanSuppliers){
                    objSM.Id = null;
                    objSM.SPEPlan__c = objSpePlan.Id;
                }
                for(SPE_Respondent__c objRs : lstSurveyRespondent){
                    objRs.Id = null;
                    objRs.SPEPlan__c = objSpePlan.Id;
                }
                if(!lstSpePlanSuppliers.isEmpty())
                    insert lstSpePlanSuppliers;
                if(!lstSurveyRespondent.isEmpty())
                    insert lstSurveyRespondent;
            }
            isError = false;
            PageReference pg = new PageReference('/'+objSpePlan.Id+'/e');
            pg.setRedirect(true);
            return pg;
        }catch(Exception ex){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'There was some error in performing the operation.'));
             isError = true;
             return null;
        }
    }
    
    public Pagereference backToSPE(){
        PageReference pg = new PageReference('/'+strSPEPlan);
        pg.setRedirect(true);
        return pg;
    }
}