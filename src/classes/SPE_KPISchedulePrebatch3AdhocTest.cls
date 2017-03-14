@isTest(SeeAllData = False)
public class SPE_KPISchedulePrebatch3AdhocTest {

    public static testmethod void testSPE_KPISchedulePrebatch3AdhocMethod() {
       string enterprise='enterprise';
        //inserting pi 
        Date d=system.today();
        
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
        
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();      
       
        piDef.LifecycleStage__c = 'Draft';        
        piDef.GeoScope__c = 'Market';
        piDef.CategoryScope__c = 'Category Area';
        piDef.BUScope__c = 'Business Unit';       
        insert piDef;
        piDef.LifecycleStage__c = 'Published';
        update piDef;
        System.debug('inserting SPE_PIDefinition__c'+piDef.id);
        
        //entering supplier detail
        
        Account a=SPE_TestObjectCreator.CreateSupplier(enterprise);      
        insert a;
        System.debug('inserting supplier'+a.id);
        
       
         //SPE_KPIDefinition__c  details 
        SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1);      
        kpidef.Adhoc_Date__c=system.today().adddays(1); 
        kpidef.FrequencyinMonth__c='1';
        kpidef.ScheduledDate__c = System.today().adddays(2);
        kpidef.GeoScope__c = 'Market';
        kpidef.CategoryScope__c = 'Category Area';
        kpidef.BUScope__c = 'Business Unit';
        kpidef.Adhoc__c=true;        
        insert kpidef; 
        kpidef.ActualCalculation__c = 'A';
        kpidef.LifecycleStage__c='Pilot';
         update kpidef;    
         system.debug('inserting SPE_KPIDefinition__c done'+ kpidef.id);
         
         //inserting kpicalcualtion
          
         List<SPE_KPICalculation__c> listkpical=new List<SPE_KPICalculation__c>();        
        SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();    
        kpicalc.Aggregation__c='Min( Across Suppliers)';      
        kpicalc.KPIDefinition__c=kpidef.id;
        kpicalc.PIDefination__c=piDef.Id;
        kpicalc.TimeFrame__c=2;
        listkpical.add(kpicalc);
        
        SPE_KPICalculation__c kpicalc1=SPE_TestObjectCreator.createKPICalculation();      
        kpicalc1.Aggregation__c='Max( Across Suppliers)';       
        kpicalc1.KPIDefinition__c=kpidef.id;
        kpicalc1.PIDefination__c=piDef.Id;
        kpicalc1.TimeFrame__c=2;
        listkpical.add(kpicalc1);
        insert listkpical;
        
        //inserting supplier kpi calculation 
        
        Supplier_KPI_Callculation__c suppkpicalc=SPE_TestObjectCreator.createSupplierKPICal();
        suppkpicalc.EnterpriseID__c=a.EnterpriseId__c;        
        suppkpicalc.KPI__c=kpicalc.KPIDefinition__c;
        suppkpicalc.KPI_Calculation__c=kpicalc.id;
        insert suppkpicalc;
        system.debug('inserting Supplier_KPI_Callculation__c'+suppkpicalc.id);
        
       SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
        size.Size__c=2000;
        size.name='KPI Batch Size';
        insert size;
        system.debug('inserting SPEKPIBatchSize__c '+size.id);
        
        Supplier_KPI_Calculation_Adhoc__c batchObj1=new Supplier_KPI_Calculation_Adhoc__c();
        batchObj1.KPI__c=kpicalc.KPIDefinition__c;
        batchObj1.KPI_Calculation__c=kpicalc.id;
        insert batchObj1;
        
        System.debug('testing inserting Supplier_KPI_Calculation_Adhoc__c'+batchObj1.id );
        
    
        
        Test.startTest();
        System.AssertEquals(batchObj1.KPI__c,kpicalc.KPIDefinition__c);
        System.AssertEquals(size.name,'KPI Batch Size');
        SPE_KPISchedulePrebatch3Adhoc batchObj = new SPE_KPISchedulePrebatch3Adhoc(kpidef.id);
       
       
        Database.executeBatch(batchObj,200);
       
        
        Test.stopTest();
       
     
    
   
    
     
    
}
}