@isTest(SeeAllData = False)
public class SPE_KPISchedulePrebatch3Test {

    public static testmethod void testSPE_KPISchedulePrebatch3Method() {  
     
        
                
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
    
    //inserting pidefinition 
        
        Date d=system.today();
        List<SPE_PIDefinition__c> listpidef=new List<SPE_PIDefinition__c>();
        for(integer i=0;i<1;i++)
        {
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        
        //*********Changes For Encryption***************//
        //piDef.Name    = 'Test PI Definition'+i;
        piDef.PI_Title__c = 'Test PI Definition'+i;
        //*********End***************//
             
        piDef.GeoScope__c = 'Market';
        piDef.CategoryScope__c = 'Category Area';
        piDef.BUScope__c = 'Business Unit';
        piDef.Frequency__c = 'Monthly';
        piDef.LifecycleStage__c = 'Draft';
        listpidef.add(pidef);
        }       
        insert listpidef;
        for(integer i=0;i<1;i++){
        listpidef[i].LifecycleStage__c = 'Pilot';
        }
        update listpidef; 
        System.debug('inserting SPE_PIDefinition__c'+listpidef[0].id);
        
        //entering supplier detail 
        
        List<Account> listaccf=new List<Account>();
        for(integer i=0;i<1;i++){
        Account a=SPE_TestObjectCreator.CreateSupplier('enterprise');
        a.Name = 'enterprise'+i;
        listaccf.add(a);
        }
        insert listaccf;
        System.debug('inserting supplier'+listaccf[0].id); 
        
        //SPE_KPIDefinition__c  details
        
        List<SPE_KPIDefinition__c> listkpidef=new List<SPE_KPIDefinition__c>();
     
        SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1);        
        kpidef.FrequencyinMonth__c='1';
        kpidef.ScheduledDate__c = System.today().addDays(2);
        kpidef.GeoScope__c = 'Market';
        kpidef.CategoryScope__c = 'Category Area';
        kpidef.BUScope__c = 'Business Unit';
        listkpidef.add(kpidef);        
        insert listkpidef;        
        listkpidef[0].ActualCalculation__c = 'A';
        listkpidef[0].LifecycleStage__c='Pilot';                
        update listkpidef;
         
        system.debug('inserting SPE_KPIDefinition__c done'+listkpidef[0].id);
        
         //inserting kpicalculation
         
        List<SPE_KPICalculation__c> listkpical=new List<SPE_KPICalculation__c>(); 
       
        SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();           
        kpicalc.Aggregation__c='Min( Across Suppliers)';        
        kpicalc.KPIDefinition__c=listkpidef[0].id;
        kpicalc.PIDefination__c=listpidef[0].Id;
        
        kpicalc.TimeFrame__c=2;
        listkpical.add(kpicalc);
        
       SPE_KPICalculation__c kpicalc1=SPE_TestObjectCreator.createKPICalculation();      
        kpicalc1.Aggregation__c='Max( Across Suppliers)';       
        kpicalc1.KPIDefinition__c=listkpidef[0].id;
        kpicalc1.PIDefination__c=listpidef[0].Id;
        kpicalc1.TimeFrame__c=2;
        listkpical.add(kpicalc1);
        
        SPE_KPICalculation__c kpicalc2=SPE_TestObjectCreator.createKPICalculation();      
        kpicalc2.Aggregation__c='Avg( Across Suppliers)';       
        kpicalc2.KPIDefinition__c=listkpidef[0].id;
        kpicalc2.PIDefination__c=listpidef[0].Id;
        kpicalc2.TimeFrame__c=2;
        listkpical.add(kpicalc2);
        
        insert listkpical;
      
       // entering supplier kpi calculation
        List<Supplier_KPI_Callculation__c> listsuppkpical=new List<Supplier_KPI_Callculation__c>(); 
        for(integer i=0;i<1;i++){
        Supplier_KPI_Callculation__c suppkpicalc=SPE_TestObjectCreator.createSupplierKPICal();
        suppkpicalc.EnterpriseID__c=listaccf[0].EnterpriseId__c;        
        suppkpicalc.KPI__c=listkpical[0].KPIDefinition__c;
        suppkpicalc.KPI_Calculation__c=listkpical[0].id;
        listsuppkpical.add(suppkpicalc);
        }
        insert listsuppkpical;
        system.debug('inserting Supplier_KPI_Callculation__c'+listsuppkpical[0].id);
        
        //inserting batch size
         List<SPEKPIBatchSize__c> listkpibatchsize=new List<SPEKPIBatchSize__c>(); 
        for(integer i=0;i<1;i++){
        SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
        size.Size__c=2000;
        size.name='KPI Batch Size'+i;listkpibatchsize.add(size);
        }
        insert listkpibatchsize;
        system.debug('inserting SPEKPIBatchSize__c '+listkpibatchsize[0].id);
        
        Test.startTest();
        
        SPE_KPISchedulePrebatch3 batchObj = new SPE_KPISchedulePrebatch3();  
        
        //Query Locator     
        Database.QueryLocator qryloc;       
                
        //Batchable context     
        Database.BatchableContext BatCon;       
        qryloc = batchObj.start(BatCon);        
                
        batchObj.execute(BatCon,listkpical);        
        SchedulableContext schCon = null;       
                
        //execute method        
        batchObj.execute(schCon);       
        //finish method     
        batchObj.finish(BatCon);
          
        Database.executeBatch(batchObj,100);
        system.assertequals('Market', listpidef[0].GeoScope__c);
        System.AssertEquals(2000, [SELECT Size__c FROM SPEKPIBatchSize__c WHERE Id = :listkpibatchsize[0].Id].Size__c);
        
        Test.stopTest();
}
}