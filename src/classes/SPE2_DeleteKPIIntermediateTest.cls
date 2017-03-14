@isTest(seeAllData = false)
private class SPE2_DeleteKPIIntermediateTest
{
   static testMethod void DeleteKPIIntermediateTest1() 
    {   
        Test.startTest();
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
        System.RunAs(u){
        
         Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
         
         pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
         insert pidef;
        
         pidef.LifecycleStage__c = 'Pilot';
         update pidef;
         System.debug('pidef ::'+pidef);
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.NumberValue__c =10;
        insert piVal;
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;           
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;  
                
        List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
        kpiInterComp.KPI__c = kpilist[0].Id;
        //kpiInterComp.KPI_MappingScope__c = 
        insert kpiInterComp;
        lstkpiInterComp.add(kpiInterComp);
        
        SPE2_DeleteKPIIntermediate delKpiInter = new SPE2_DeleteKPIIntermediate(kpiList[0].Id+'');
        SchedulableContext scb ;
        Database.BatchableContext bcb;
        Database.executeBatch(delKpiInter , lstkpiInterComp.size());    
              
        }
        Test.stopTest();
    }
}