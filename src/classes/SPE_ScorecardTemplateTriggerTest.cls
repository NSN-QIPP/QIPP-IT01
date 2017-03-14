@isTest
private class SPE_ScorecardTemplateTriggerTest{

   static testmethod void test_trigger(){
         SPE_ScorecardTemplate__c sc= new SPE_ScorecardTemplate__c(Name = 'scorecard');
        insert sc;
        
        sc.Name= 'scorecard2';
        update sc;
        delete sc;
      

        
    }
}