global class SPE_BatchScorecardGenerateTempValues3 implements Database.Batchable<sObject>,Schedulable  {


    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(1));
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        
        Date dddd=system.today()-1;
        String query = 'SELECT Id FROM SPE_ScoreCard__c where createdDate>=:dddd';
        return Database.getQueryLocator(query);
    }




    global void execute(Database.BatchableContext BC, List <SPE_ScoreCard__c> scope) 
    {
       list<SPE_ScorecardTempValues__c> temp=new list<SPE_ScorecardTempValues__c>();
      temp=[select id from SPE_ScorecardTempValues__c where ScoreCard__c=:scope[0].id and Weight__c=Null];  
      
      if (temp.size()==0){
      list<SPE_ScorecardValues__c> tobeinserted= new list<SPE_ScorecardValues__c >();
   
    AggregateResult[] groupedResults =new List<AggregateResult>(); 
    groupedResults =[SELECT SPE_TemplateName__c,KPI__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scope[0].id and KPI__c!=Null GROUP BY SPE_TemplateName__c,KPI__c ];    
   
    for (AggregateResult ar : groupedResults)  {
        SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
        s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
        s.scorecard__c=scope[0].id;
        s.kpi__c=String.valueOf(ar.get('KPI__c'));
        tobeinserted.add(s);
        }

    groupedResults = [SELECT SPE_TemplateName__c,Group__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scope[0].id and KPI__c=Null and Group__c!=Null GROUP BY SPE_TemplateName__c,Group__c ];    
   
    for (AggregateResult ar : groupedResults)  {
        SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
        s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
        s.scorecard__c=scope[0].id;
        s.Group__c=String.valueOf(ar.get('Group__c'));
        tobeinserted.add(s);
        }
    
    
    groupedResults = [SELECT SPE_TemplateName__c,SUM(Score_Weight__c) sum,SUM(Weight__c) weight FROM SPE_ScorecardTempValues__c where ScoreCard__c=:scope[0].id and KPI__c=Null and Group__c=Null GROUP BY SPE_TemplateName__c ];    
   
    for (AggregateResult ar : groupedResults)  {
        SPE_ScorecardValues__c s= new SPE_ScorecardValues__c();
        s.SPE_Template_Name__c=String.valueOf(ar.get('SPE_TemplateName__c'));
        s.score__c=Decimal.valueOf(String.valueOf(ar.get('sum')))/ Decimal.valueOf(String.valueOf(ar.get('weight')));
        s.scorecard__c=scope[0].id;
        tobeinserted.add(s);
        }
       
        if(tobeinserted.size()>0)
           {
           delete [select id from SPE_ScorecardValues__c where ScoreCard__c=:scope[0].id];
           insert tobeinserted;
           }
        }
        
           
    }
    
    
    
    
    
    
    
    
    
    
    
    
    global void finish(Database.BatchableContext BC) 
    {        
    }
 }