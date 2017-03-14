trigger SPE_updateKPIVersions on SPE_KPIDefinition__c (after insert,after update) 
{
   try{
    if(SPE_Stop__c.getInstance('Stop').Stop_trigger__c) {
    
    List<SPE_KPIDefinition__c> NeedtoUpdate= new List<SPE_KPIDefinition__c>();
        
        if(trigger.new[0].Master_KPI__c!=Null) {
        
      //*************Changes for Encryption**************//
        for(SPE_KPIDefinition__c kpi : [select id,KPI_Title__c,AbbreviatedName__c from SPE_KPIDefinition__c where (Master_KPI__c =:trigger.new[0].Master_KPI__c and Id!=:trigger.new[0].Id) or id =: trigger.new[0].Master_KPI__c])
      //******************END******************//
      
        {
        
          //*************Changes for Encryption**************//
            //kpi.name = trigger.new[0].name;
            kpi.KPI_Title__c = trigger.new[0].KPI_Title__c;
          //******************END******************//
            
            kpi.AbbreviatedName__c= trigger.new[0].AbbreviatedName__c ;
            NeedtoUpdate.add(kpi);
        }
        }
        else {
            
           //*************Changes for Encryption**************//
             for(SPE_KPIDefinition__c kpi : [select id,KPI_Title__c,AbbreviatedName__c from SPE_KPIDefinition__c where Master_KPI__c = : trigger.new[0].Id ])
           //******************END******************//   
                
                {
                    
                //*************Changes for Encryption**************//
                    //kpi.name = trigger.new[0].name;
                    kpi.KPI_Title__c = trigger.new[0].KPI_Title__c;
               //******************END******************//
                    
                    kpi.AbbreviatedName__c= trigger.new[0].AbbreviatedName__c ;
                    NeedtoUpdate.add(kpi);
                }
        
        }
        if(NeedtoUpdate.size()>0) {
        SPE_Stop__c s=SPE_Stop__c.getInstance('Stop');
        s.Stop_trigger__c=false;
        update s;
        update NeedtoUpdate;
        s.Stop_trigger__c=true;
        update s;
        
        }
    }    
   
   }
   
   catch(exception e) {
    if(!Test.isRunningTest()){
       trigger.new[0].addError('Cannot Proceed : '+e);
   }
   
   }
}