@isTest(seeAllData = false)
private class SPE2_DeletePITempValuesTest
{
   static testMethod void DeletePITempValuesTest1() 
    {   
        Test.startTest();
        
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
        
        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = 'COSCOM';
        insert kpicomment;
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal;

        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>=';
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;

        List<SPE_PITempValue__c> lstPITempVal = new List<SPE_PITempValue__c>();
        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = '10';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c ='Number';
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        lstPITempVal.add(tempval);
                                
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist; 
        
        SPE2_DeletePITempValues  delPiTempval = new SPE2_DeletePITempValues(kpiList[0].Id+'');
        SchedulableContext scb ;
        Database.BatchableContext bcb;
    
        Database.executeBatch(delPiTempval, lstPITempVal.size());    
        Test.stopTest();
    }
}