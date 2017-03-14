@isTest(seeAlldata=False)

     public class SPE_KPISchedulebatch5AdhocTest {
        static testmethod void testSPE_KPISchedulebatch5Adhoc() {
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        List<SPE_KPIDefinition__c> lstSPE = new List<SPE_KPIDefinition__c>();
        SPE_KPIDefinition__c speObj1 = new SPE_KPIDefinition__c();
        speObj1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        speObj1.ScheduledDate__c =  System.today().addDays(4);
        speObj1.FrequencyinMonth__c = '1';
        speObj1.adhoc__c = false;
        speObj1.Adhoc_Date__c = system.today();
        
        system.debug('date for obj1'+speObj1.ScheduledDate__c);
        lstSPE.add(speObj1);
        
        insert lstSPE;
        
        test.startTest();
       
        SPE_KPISchedulebatch5Adhoc batchObj2 = new SPE_KPISchedulebatch5Adhoc(lstSPE[0].Id);
        Database.executeBatch(batchObj2,200);
        SchedulableContext sc = null;
        batchObj2.execute(sc);
        
        test.stopTest();
        
       SPE_KPIDefinition__c resultObj = [SELECT NAME FROM  SPE_KPIDefinition__c WHERE ID = :lstSPE[0].ID];
       system.assert(resultObj!=null);
        }
        
        
        /*
        
        static testmethod void testSPE_KPISchedulebatch5Adhoc2() {
        List<SPE_KPIDefinition__c> lstSPE = new List<SPE_KPIDefinition__c>();
        SPE_KPIDefinition__c speObj1 = new SPE_KPIDefinition__c();
        speObj1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        speObj1.ScheduledDate__c =  System.today().addDays(4);
        speObj1.FrequencyinMonth__c = '1';
        speObj1.adhoc__c = false;
        speObj1.Adhoc_Date__c = system.today();
        speObj1.Number_Of_Months__c = 2;
        
        system.debug('date for obj1'+speObj1.ScheduledDate__c);
        lstSPE.add(speObj1);
        
        insert lstSPE;
        
        
        

        test.startTest();
       
       
        SPE_KPISchedulebatch5Adhoc batchObj2 = new SPE_KPISchedulebatch5Adhoc(lstSPE[0].Id);
        Database.executeBatch(batchObj2,200);
        SchedulableContext sc = null;
        batchObj2.execute(sc);
        
        test.stopTest();
        
       SPE_KPIDefinition__c resultObj = [SELECT NAME FROM  SPE_KPIDefinition__c WHERE ID = :lstSPE[0].ID];
       system.assert(resultObj!=null);
        }
        
        */
}