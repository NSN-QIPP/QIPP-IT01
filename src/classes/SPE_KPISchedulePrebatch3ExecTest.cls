@IsTest(SeeAllData=false)
public class SPE_KPISchedulePrebatch3ExecTest {

        public static testmethod void testSPE_KPISchedulePrebatch3ExecMethod1() {
   
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            string enterprise='enterprise';
            Date d=system.today(); 
       
            //inserting picklist values 
              
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
            System.debug('inserting picklistvalue'+lstpicklistObj[0].id);
        
            //inserting pidefinitions
            
            SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();           
            piDef.LifecycleStage__c = 'Draft';
            piDef.ValuesType__c = 'Number';
            piDef.CategoryScope__c='Category Area';
            piDef.GeoScope__c='Project';
            piDef.BUScope__c='Business Unit'; 
            insert piDef;
            piDef.LifecycleStage__c= 'Published';    
            update piDef;
            System.debug('inserting SPE_PIDefinition__c'+piDef.id);
   
    
            //inserting kpi def
     
            SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1);             
            kpidef.FrequencyinMonth__c='1';
            kpidef.Adhoc_Date__c = System.today();
            kpidef.GeoScope__c = 'Project';
            kpidef.CategoryScope__c = 'Category Area';
            kpidef.BUScope__c = 'Business Unit';       
            insert kpidef; 
            kpidef.ActualCalculation__c = 'A';  
            kpidef.LifecycleStage__c='Pilot';
            kpidef.SchedulePeriod__c = System.today();
            update kpidef;    
            system.debug('inserting SPE_KPIDefinition__c done'+kpidef.id);        
        
             //entering supplier detail     
        
            List<Account> lstAcc = new  List<Account>();
            Account acc1 = new Account();
            acc1.Name = 'COSCOM';
            acc1.EnterpriseId__c = 'COSCOM';
            insert acc1;
            lstAcc.add(acc1);
        
            Account acc = new Account();
            acc.Name = 'UNITEL';
            acc.EnterpriseId__c = 'UNITEL';
            insert acc;
            lstAcc.add(acc);
            System.debug('inserting supplier'+lstAcc[0].id);        
        
            SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();      
            kpicalc.Aggregation__c='Min( Across Suppliers)';        
            kpicalc.KPIDefinition__c=kpidef.id;
            kpicalc.PIDefination__c=piDef.Id;
            kpicalc.TimeFrame__c=2.0;
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';       
            kpicalc.Filter5__c =Null;
            kpicalc.Filter6__c = Null;
            kpicalc.Filter7__c = Null;
            kpicalc.Filter8__c = Null;
            kpicalc.Filter9__c = Null;
            kpicalc.Filter10__c = null;    
            insert kpicalc;
            
            /*kpidef.LifecycleStage__c='Published';
            update kpidef;*/
        //inserting pi values
              
            SPE_PIValues__c piValueObj = new SPE_PIValues__c(); 
            piValueObj.PIDefination__c = piDef.Id;
            piValueObj.Supplier__c = lstAcc[0].Id;
            piValueObj.EnterpriseID__c = lstAcc[0].EnterpriseId__c;
            piValueObj.Period__c = system.today().addMonths(-1);
            piValueObj.Cluster__c='Indirect procurement';
            piValueObj.Market__c    ='INDIA';
            piValueObj.SubRegion__c ='INDIA VF';
            piValueObj.Country__c   ='India';
            piValueObj.Project__c   ='IN BPL';
            piValueObj.BusinessUnit__c='Mobile Broadband';
            piValueObj.NumberValue__c = 10;
            piValueObj.Filter1__c = '1';
            piValueObj.Filter2__c = '1';
            piValueObj.Filter3__c = '1';
            piValueObj.Filter4__c = '1';     
            insert piValueObj;
        
            System.debug('inserting SPE_KPICalculation__c  list:kpical='+kpicalc.id);
        
        //inserting supplier pki calculation        
        
            List<Supplier_KPI_Callculation__c> listsuppkalc=new List<Supplier_KPI_Callculation__c>();
            Supplier_KPI_Callculation__c suppkpicalc =SPE_TestObjectCreator.createSupplierKPICal();
            suppkpicalc.EnterpriseID__c=lstAcc[0].EnterpriseId__c;       
            suppkpicalc.KPI__c=kpidef.id;
            suppkpicalc.KPI_Calculation__c=kpicalc.id;     
            listsuppkalc.add(suppkpicalc);
            insert listsuppkalc;
            system.debug('inserting Supplier_KPI_Callculation__c'+listsuppkalc[0].id);
        
            SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
            size.Size__c=2000;
            size.name='KPI Batch Size';
            insert size;
            system.debug('inserting SPEKPIBatchSize__c '+size.id);
             
        
            //CreatePIDefinition 
   
               SPE_PITempValue__c piTempValue = SPE_TestObjectCreator.createPITempValue();
               piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get((system.today()).month()) + ' - '+ String.valueOf((system.today()).year());
               piTempValue.PIValue__c = String.valueof(10);               
               piTempValue.Valuetype__c = piDef.ValuesType__c;
               piTempValue.KPIDefinition__c = kpicalc.KPIDefinition__c; 
               piTempValue.KPICalculation__c = kpicalc.Id; 
               piTempValue.Project__c ='All Projects';
               piTempValue.Country__c ='All Countries';
               piTempValue.SubRegion__c = 'All Market Units';        
               insert piTempValue;     
               
            SPE_BUBL__c bubl = new SPE_BUBL__c();
            bubl.BusinessLine__c = 'Care';
            bubl.BusinessUnit__c = 'Global Services';
            bubl.Product__c = 'PTF';
            insert bubl;
            
            SPE_CategoryMaster__c catMas = new SPE_CategoryMaster__c();
            catMas.Category__c= 'All Categories';  
            catMas.Cluster__c = 'All Category Areas';
            catMas.Group__c ='All Category Groups';
            insert catMas;
            
            SPE_ProjectMaster__c projMas = new SPE_ProjectMaster__c();
            projMas.name ='projMas';
            projMas.Country__c ='All Countries'; 
            projMas.Market__c ='All Markets';
            projMas.MarketUnit__c = 'All Market Units';
            projMas.Project__c ='All Projects';
            projMas.Region__c = 'All Region';
            insert projMas; 

                Test.startTest(); 
                
                SPE_KPISchedulePrebatch3Exec bobj = new SPE_KPISchedulePrebatch3Exec();     
                System.assertequals(size.Size__c,2000); 
              
                Database.executeBatch(bobj,listsuppkalc.size());
                Test.stopTest();
}

 public static testmethod void testSPE_KPISchedulePrebatch3ExecMethod2() {
   
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            string enterprise='enterprise';
            Date d=system.today(); 
       
            //inserting picklist values 
              
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
            System.debug('inserting picklistvalue'+lstpicklistObj[0].id);
        
            //inserting pidefinitions
            
            SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();           
            piDef.LifecycleStage__c = 'Draft';
            piDef.ValuesType__c = 'Number';
            piDef.CategoryScope__c='Category Area';
            piDef.GeoScope__c='Project';
            piDef.BUScope__c='Business Unit'; 
            insert piDef;
            piDef.LifecycleStage__c= 'Published';    
            update piDef;
            System.debug('inserting SPE_PIDefinition__c'+piDef.id);
   
    
            //inserting kpi def
     
            SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1);             
            kpidef.FrequencyinMonth__c='1';
            kpidef.Adhoc_Date__c = System.today();
            kpidef.GeoScope__c = 'Project';
            kpidef.CategoryScope__c = 'Category Area';
            kpidef.BUScope__c = 'Business Unit';       
            insert kpidef; 
            kpidef.ActualCalculation__c = 'A';  
            kpidef.LifecycleStage__c='Pilot';
            kpidef.SchedulePeriod__c = System.today();
            update kpidef;    
            system.debug('inserting SPE_KPIDefinition__c done'+kpidef.id);      
        
             //entering supplier detail     
        
            List<Account> lstAcc = new  List<Account>();
            Account acc1 = new Account();
            acc1.Name = 'COSCOM';
            acc1.EnterpriseId__c = 'COSCOM';
            insert acc1;
            lstAcc.add(acc1);
        
            Account acc = new Account();
            acc.Name = 'UNITEL';
            acc.EnterpriseId__c = 'UNITEL';
            insert acc;
            lstAcc.add(acc);
            System.debug('inserting supplier'+lstAcc[0].id);        
        
            SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();      
            kpicalc.Aggregation__c='Min( Across Suppliers)';        
            kpicalc.KPIDefinition__c=kpidef.id;
            kpicalc.PIDefination__c=piDef.Id;
            kpicalc.TimeFrame__c=2.0;
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';       
            kpicalc.Filter5__c =  '1';
            kpicalc.Filter6__c = '1';
            kpicalc.Filter7__c = '1';
            kpicalc.Filter8__c = '1';
            kpicalc.Filter9__c = Null;
            kpicalc.Filter10__c = null;    
            insert kpicalc;
            
            /*kpidef.LifecycleStage__c='Published';
            update kpidef;*/
        //inserting pi values
              
            SPE_PIValues__c piValueObj = new SPE_PIValues__c(); 
            piValueObj.PIDefination__c = piDef.Id;
            piValueObj.Supplier__c = lstAcc[0].Id;
            piValueObj.EnterpriseID__c = lstAcc[0].EnterpriseId__c;
            piValueObj.Period__c = system.today().addMonths(-1);
            piValueObj.Cluster__c='Indirect procurement';
            piValueObj.Market__c    ='INDIA';
            piValueObj.SubRegion__c ='INDIA VF';
            piValueObj.Country__c   ='India';
            piValueObj.Project__c   ='IN BPL';
            piValueObj.BusinessUnit__c='Mobile Broadband';
            piValueObj.NumberValue__c = 10;
            piValueObj.Filter1__c = '1';
            piValueObj.Filter2__c = '1';
            piValueObj.Filter3__c = '1';
            piValueObj.Filter4__c = '1';     
            insert piValueObj;
        
            System.debug('inserting SPE_KPICalculation__c  list:kpical='+kpicalc.id);
        
        //inserting supplier pki calculation        
        
            List<Supplier_KPI_Callculation__c> listsuppkalc=new List<Supplier_KPI_Callculation__c>();
            Supplier_KPI_Callculation__c suppkpicalc =SPE_TestObjectCreator.createSupplierKPICal();
            suppkpicalc.EnterpriseID__c=lstAcc[0].EnterpriseId__c;       
            suppkpicalc.KPI__c=kpidef.id;
            suppkpicalc.KPI_Calculation__c=kpicalc.id;     
            listsuppkalc.add(suppkpicalc);
            insert listsuppkalc;
            system.debug('inserting Supplier_KPI_Callculation__c'+listsuppkalc[0].id);
        
            SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
            size.Size__c=2000;
            size.name='KPI Batch Size';
            insert size;
            system.debug('inserting SPEKPIBatchSize__c '+size.id);
             
        
            //CreatePIDefinition 
   
          SPE_PITempValue__c piTempValue = SPE_TestObjectCreator.createPITempValue();
          piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get((system.today()).month()) + ' - '+ String.valueOf((system.today()).year());
          piTempValue.PIValue__c = String.valueof(10);               
          piTempValue.Valuetype__c = piDef.ValuesType__c;
          piTempValue.KPIDefinition__c = kpicalc.KPIDefinition__c; 
          piTempValue.KPICalculation__c = kpicalc.Id; 
          piTempValue.Project__c = 'Project';
          piTempValue.Country__c ='All Countries';
          piTempValue.SubRegion__c = 'All Market Units';        
          insert piTempValue;     
               
            SPE_BUBL__c bubl = new SPE_BUBL__c();
            bubl.BusinessLine__c = 'Care';
            bubl.BusinessUnit__c = 'Global Services';
            bubl.Product__c = 'PTF';
            insert bubl;
            
            SPE_CategoryMaster__c catMas = new SPE_CategoryMaster__c();
            catMas.Category__c= 'All Categories';  
            catMas.Cluster__c = 'All Category Areas';
            catMas.Group__c ='All Category Groups';
            insert catMas;
            
            SPE_ProjectMaster__c projMas = new SPE_ProjectMaster__c();
            projMas.name ='projMas';
            projMas.Country__c ='All Countries'; 
            projMas.Market__c ='All Markets';
            projMas.MarketUnit__c = 'All Market Units';
            projMas.Project__c = 'Project';
            projMas.Region__c = 'All Region';
            insert projMas; 

                Test.startTest(); 
                
                SPE_KPISchedulePrebatch3Exec bobj = new SPE_KPISchedulePrebatch3Exec();     
                System.assertequals(size.Size__c,2000); 
              
                Database.executeBatch(bobj,listsuppkalc.size());
                Test.stopTest();
}
}