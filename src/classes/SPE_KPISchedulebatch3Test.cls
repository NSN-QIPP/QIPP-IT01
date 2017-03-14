@isTest(SeeAllData = False) 
private class SPE_KPISchedulebatch3Test 
{
     public static testMethod void testSPE_KPISchedulebatch3Test() 
    {
        
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
            
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
            insert kpidef;
            
            system.assertequals(kpidef.FrequencyinMonth__c,'2');
            
            List<SPE_KPICalculation__c> lisKPIcal = new List<SPE_KPICalculation__c>();
            
            for(Integer i = 0; i<300 ; i ++)
            {
                SPE_KPICalculation__c kpical = SPE_TestObjectCreator.createKPICalculation();
                kpical.KPIDefinition__c= kpidef.id;
                
                lisKPIcal.add(kpical);
                
                system.assertequals(kpical.KPIDefinition__c,kpidef.id);
            }
            
            insert lisKPIcal;
            
            
            
            SPEKPIBatchSize__c btsiz = new SPEKPIBatchSize__c(name='Test KPI Batch Size',Size__c =2000);
            insert btsiz;
            
             SPE_KPICalculation__c kpical1 = SPE_TestObjectCreator.createKPICalculation();
             kpical1.KPIDefinition__c= kpidef.id; 
             insert kpical1;
            
             Supplier_KPI_Callculation__c supcal = SPE_TestObjectCreator.createSupplierKPICal();
             supcal.enterpriseId__c='test';
             supcal.KPI__c=kpidef.id;
             supcal.KPI_Calculation__c=kpical1.id;
             
             insert supcal;
            
            Test.startTest();
                SPE_KPISchedulebatch3 bat = new SPE_KPISchedulebatch3();
                //Query Locator
                Database.QueryLocator qryloc;
                
                //Batchable context
                Database.BatchableContext BatCon;
                qryloc = bat.start(BatCon);
                
                bat.execute(BatCon,lisKPIcal);
                SchedulableContext schCon = null;
                
                //execute method
                bat.execute(schCon);
                //finish method
                bat.finish(BatCon);
            
             Test.stopTest();
             //Id processId = Database.executebatch(bat,150);
        
    }
}