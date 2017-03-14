@isTest(SeeAllData = False)

public class SPE_DeleteTestDataBatchTest {

    static testmethod void testSPE_DeleteTestDataBatch() {
    
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'All Business Unit';
        picklistObj.Business_Line__c = 'All Business Line';        
        picklistObj.Project__c = 'All Project';
        
        picklistObj.Category_Area__c =  'All Category Area' ;
        picklistObj.Category_Group__c = 'All Category Group';
        picklistObj.Category__c =  'All Category' ;               
        
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All CO Country' ;       
        picklistObj.Product__c = 'All Product' ;
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        List<SPE_KPIDefinition__c> lstSPE = new List<SPE_KPIDefinition__c>();
        List<SPE_PIDefinition__c> lstPIDef = new List<SPE_PIDefinition__c>();
        
        SPE_KPIDefinition__c speObj = new SPE_KPIDefinition__c();
        speObj = SPE_TestObjectCreator.CreateKPIDefinition(1);
        speObj.ScheduledDate__c =  System.today().addDays(4);
        speObj.FrequencyinMonth__c = '1';
        speObj.adhoc__c = false;
        speObj.Adhoc_Date__c = Date.newInstance(2016,3,20);
        
        lstSPE.add(speObj);
        
        insert lstSPE;
        
        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        
        //**********Changes for Encryption***********//
            //pidef.name= 'test';
            pidef.PI_Title__c = 'test';
        //*********Changes End**************//
        
        pidef.PIAbbreviation__c= 'abb';
        pidef.Type__c= 'Operational';
        pidef.ValuesType__c='Number';
        pidef.UoM__c='10';
        pidef.LifecycleStage__c='Draft';
        pidef.DataAcquisitionMethod__c='data load';
        pidef.CategoryScope__c='Category';
        pidef.BUScope__c='Business Line';
        pidef.GeoScope__c ='Market';
        pidef.PIUploadDuedate__c = Date.newInstance(2016,3,14);
        lstPIDef.add(pidef);
        
        test.startTest();
       
        SPE_DeleteTestDataBatch batchObj = new SPE_DeleteTestDataBatch(lstSPE[0].Id);
        Database.executeBatch(batchObj,200);
        
        SchedulableContext sc = Null;
        Database.BatchableContext BC;
        batchObj.finish(BC);
        batchObj.execute(sc);
     
        test.stopTest();     
    }
    
    static testmethod void testSPE_DeleteTestDataBatch1() {
        
        
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'All Business Unit';
        picklistObj.Business_Line__c = 'All Business Line';        
        picklistObj.Project__c = 'All Project';
        
        picklistObj.Category_Area__c =  'All Category Area' ;
        picklistObj.Category_Group__c = 'All Category Group';
        picklistObj.Category__c =  'All Category' ;               
        
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All CO Country' ;       
        picklistObj.Product__c = 'All Product' ;
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        List<SPE_KPIDefinition__c> lstSPE = new List<SPE_KPIDefinition__c>();
        List<SPE_PIDefinition__c> lstPIDef = new List<SPE_PIDefinition__c>();
        List<SPE_PIValues__c> lstPIVal = new List<SPE_PIValues__c>();
        
        Account sup = SPE_TestObjectCreator.CreateSupplier('1234');
        insert sup;
        
        SPE_KPIDefinition__c speObj = new SPE_KPIDefinition__c();
        speObj = SPE_TestObjectCreator.CreateKPIDefinition(1);
        speObj.ScheduledDate__c =  Date.newInstance(2016,12,01);
        speObj.FrequencyinMonth__c = '1';
        speObj.adhoc__c = false;
        speObj.Adhoc_Date__c = system.today();
        
        lstSPE.add(speObj);
        
        insert lstSPE;
        
        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        
        //**********Changes for Encryption***********//
            //pidef.name= 'test';
            pidef.PI_Title__c = 'test';
        //*********Changes End**************//
        
        pidef.PIAbbreviation__c= 'abb';
        pidef.Type__c= 'Operational';
        pidef.ValuesType__c='Number';
        pidef.UoM__c='10';
        pidef.LifecycleStage__c='Draft';
        pidef.DataAcquisitionMethod__c='data load';
        pidef.CategoryScope__c='Category';
        pidef.BUScope__c='Business Line';
        pidef.GeoScope__c ='Market';
        pidef.PIUploadDuedate__c = Date.newInstance(2016,3,14);
        lstPIDef.add(pidef);
        insert lstPIDef;
        
        test.startTest();
       
        SPE_DeleteTestDataBatch batchObj = new SPE_DeleteTestDataBatch(lstPIDef[0].Id);
        Database.executeBatch(batchObj,200);
        
        SchedulableContext sc = Null;
        Database.BatchableContext BC;
        batchObj.finish(BC);
        batchObj.execute(BC,lstSPE);
     
        test.stopTest();     
    }
}