public class SPETabViewExt{
    public String SPETempvar {get;set;}
    public String SPEPlanvar {get;set;}
    public String SPETrackervar {get;set;}
    public String SCTempvar {get;set;}
    public String SCGenvar {get;set;}
    public String Scorevar {get;set;}
    public String ScoreTempvar {get;set;}
    
    public SPETabViewExt(){
        Schema.DescribeSObjectResult tempTab = SPE_SPETemplate__c.SObjectType.getDescribe();
        SPETempvar = '/'+tempTab.getKeyPrefix()+'/o';
        Schema.DescribeSObjectResult scoretempTab = SPE_ScoringTemplate__c.SObjectType.getDescribe();
        ScoreTempvar = '/'+scoretempTab.getKeyPrefix()+'/o';
        Schema.DescribeSObjectResult planTab = SPE_SPEPlan__c.SObjectType.getDescribe();
        SPEPlanvar = '/'+planTab.getKeyPrefix();
        Schema.DescribeSObjectResult trackerTab = SPE_SPETracker__c.SObjectType.getDescribe();
        SPETrackervar = '/'+trackerTab.getKeyPrefix()+'/o';
        
        //---------------for tab view of scorecard-------//
        
        Schema.DescribeSObjectResult sctempTab = SPE_ScorecardTemplate__c.SObjectType.getDescribe();
        SCTempvar = '/'+sctempTab.getKeyPrefix()+'/o';
        Schema.DescribeSObjectResult scgenTab = SPE_ScorecardGenerator__c.SObjectType.getDescribe();
        SCGenvar = '/'+scgenTab.getKeyPrefix()+'/o';
        Schema.DescribeSObjectResult sctrackerTab = SPE_ScoreCard__c.SObjectType.getDescribe();
        Scorevar = '/'+sctrackerTab.getKeyPrefix()+'/o';
    }
    

}