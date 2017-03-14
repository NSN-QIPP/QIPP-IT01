trigger SupplierTrigger on Account (before insert,before update) {

     list<account> accN = [SELECT Id,Name,Enterprise_Id__c FROM Account where Unique_Id__c != NULL];
     //list<account> accN = [SELECT Id,Name,Enterprise_Id__c FROM Account]; 
     for(Account a:Trigger.New)
     {
       for(Account oldAcc : accN)
       {
           if(a.name==oldAcc.name && a.id!=oldAcc.id)
           {
               a.name.addERROR('Supplier with same name already exists', false);
           }
            if(a.Enterprise_Id__c ==oldAcc.Enterprise_Id__c && oldAcc.Enterprise_Id__c!= null && a.id!=oldAcc.id)
           {
               a.Enterprise_Id__c.addERROR('Supplier with same Enterprise ID already exists', false);
           }
       }
     }    
    
    Map<String, Supplier_Model__c> modelMap = Supplier_Model__c.getAll();
    for(Account acc : Trigger.new){
        if(modelMap.containsKey(acc.Supplier_Segmentation__c +'-'+acc.Nokia_as_a_Customer__c)){
            acc.Model__c = modelMap.get(acc.Supplier_Segmentation__c +'-'+acc.Nokia_as_a_Customer__c).Model__c;
        }    
    }
      
    string s1,s2,s3,s4,s5,s6;
              
    for(Account Sup : trigger.New)
    {               
        if(Sup.Model__c=='Integrate'  )
        {
        s1='1) Develop and strengthen relationship';
        s2='2) Joint improvement programs - joint investments';
        s3='3) Seek areas of mutual exclusivity for competitive advantage';
        s4= s1 +'\n' +s2+'\n' +s3;
        Sup.Model_Description__c= s4 ;
        }  
        
        if(Sup.Model__c=='Grow'  )
        {
        s1='1) Work to build relationship more and increase supplier dependency';
        s2='2) Encourage preferential access to new developments and consider growing business'; 
        s3='3) Try to establish supplier\'s motives for attractiveness (check no hidden agendas)';               
        s4= s1 +'\n' +s2+'\n' +s3;
        Sup.Model_Description__c= s4 ;
        }  
        
        if(Sup.Model__c=='Influence' || Sup.Model__c=='Influence / Bail out'  )
        {
        s1='Address issue immediately: root cause analysis, action plan to change situation.';
        s2='Short term: increase Nokia attractiveness.';
        s3='Assess longer term options: phase out vs. Improvement path';
        s4= s1 +'\n' +s2+'\n' +s3;
        Sup.Model_Description__c= s4 ;
        }
        
        if(Sup.Model__c=='Sustain'  )
        {
        s1='Find right balance between effort and return from relationship.';
        s2='Recognise suppliers efforts, re-evaluate strategic potential.';
        s3='Watch for signs of degrading performance / commitment.';
        s4= s1 +'\n' +s2+'\n' +s3;
        Sup.Model_Description__c= s4 ;
        }
        
        if(Sup.Model__c=='Bail out / Develop'  )
        {
        s1='Analyse root cause of diverging views.';
        s2='Decide (remember: estimate efforts & costs for either approach): phase out or develop relationship (address root cause).';
        s4= s1 +'\n' +s2;
        Sup.Model_Description__c= s4 ;
        }
        
        if(Sup.Model__c=='Improve'  )
        {
        s1='1) Work with supplier to eliminate factors that put this in Manage risk';
        s2='2) Challenge the supplier hard';
        s3='3) Jointly agree and follow up risk management plan';
        s4= s1 +'\n' +s2+'\n' +s3;
        Sup.Model_Description__c= s4 ;
        }
        
        if(Sup.Model__c=='Mitigate'  )
        {
        s1='1) Analyse, why the supplier is able to exploit Nokia';
        s2='2) Find out from the supplier if the behaviour is recognized and deliberate';
        s3='3) Actions to get out of Manage risk';
        s4='4) internal business continuity plan & risk assessment';
        s5='5) Increase attractiveness through bundling with other spend';                
        s6= s1 +'\n' +s2+'\n' +s3+'\n' +s4+'\n' +s5;
        Sup.Model_Description__c= s6 ;
        }
        
        if(Sup.Model__c=='Harvest'  )
        {
        s1='Business relationship running - avoid complacency.';
        s2='Maintain open communcation and be transparent on status.';
        s4= s1 +'\n' +s2;
        Sup.Model_Description__c= s4 ;
        }
        
        if(Sup.Model__c=='Replace'  )
        {
        s1='Consider phase out / replacement (remember: estimate efforts & costs)';
        Sup.Model_Description__c= s1 ;
        }
        
         

    }


    

}