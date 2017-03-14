@isTest(SeeAllData = False)
public class SPE_KPISchedulePrebatch3ExecAdhocTest {
      
       
        //inserting picklist values 
              
           

    public static testmethod void testSPE_KPISchedulePrebatch3ExecAdhocTestMethod1() {  
    string enterprise='enterprise';
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
        
          //entering supplier detail 
            List<Account> lstAcc = new List<Account>();
    
             Account a = SPE_TestObjectCreator.CreateSupplier(enterprise);   
            lstAcc.add(a);    
            Account a2 = SPE_TestObjectCreator.CreateSupplier(enterprise);    
            lstAcc.add(a2);
            insert lstAcc;
            System.debug('inserting supplier'+lstAcc[0].id);       
            
            //-----accnt data ends----
            
     
        System.debug('inserting picklistvalue'+lstpicklistObj[0].id);
           //inserting pidefinitions
           
          SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
           piDef.LifecycleStage__c = 'Draft';
           piDef.ValuesType__c = 'Number';
           piDef.DataAcquisitionMethod__c ='Data Load';
           piDef.PIUploadDuedate__c = Date.newInstance(2016,10,10);
           insert piDef;
           piDef.LifecycleStage__c= 'Published'; 
           piDef.GeoScope__c = 'Project';
           piDef.CategoryScope__c = 'Category Area';
           piDef.BUScope__c = 'Business Unit';   
           update piDef;
           System.debug('inserting SPE_PIDefinition__c'+piDef.id);
   
    
               //inserting kpi def
            SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1); 
            kpidef.FrequencyinMonth__c=null;
            kpidef.Buffer_Days__c =null;
            kpidef.ScheduledDate__c = null;
            kpidef.GeoScope__c = 'Project';
            kpidef.CategoryScope__c = 'Category Area';
            kpidef.Adhoc_Date__c = system.today(); 
            kpidef.PI_Data__c=piDef.id;
            kpidef.GeoScope__c = 'Project';
            kpidef.CategoryScope__c = 'Category Area';
            kpidef.BUScope__c = 'Business Unit'; 
            insert kpidef;   
            kpidef.LifecycleStage__c='Pilot';
            
            update kpidef;    
            system.debug('inserting SPE_KPIDefinition__c done'+kpidef.id);
                       
        
         
         //inserting kpi calculation
          
        SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();          
        kpicalc.Aggregation__c='Min( Across Suppliers)';       
        kpicalc.KPIDefinition__c=kpidef.id;
        kpicalc.PIDefination__c=piDef.Id;
        kpicalc.TimeFrame__c=2;       
       kpicalc.Filter5__c =null;
       kpicalc.Filter6__c = null;
        kpicalc.Filter7__c = null;
       kpicalc.Filter8__c = null;
       kpicalc.Filter9__c = null;
       kpicalc.Filter10__c = null;       
         insert kpicalc;
         system.debug(kpicalc.id);
         
        //inserting pi values
       
        SPE_PIValues__c piValueObj = SPE_TestObjectCreator.CreatePIValues(piDef.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c= 'Project';
        piValueObj.Product__c='Product';
        piValueObj.Category__c='Category';
        piValueObj.NumberValue__c=10;
        piValueObj.Period__c= Date.newInstance(2016,10,12); 
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1'; 
        //piValueObj.Period__c = system.today().addMonths(-1);
        piValueObj.Project__c= 'Project';
        piValueObj.BusinessUnit__c ='Business';
        piValueObj.Cluster__c = 'Category';
        try{
            insert piValueObj;
            }
        Catch(Exception e)
        {
        }
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
        
        //inserting batch size
        
        SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
        size.Size__c=2000;
        size.name='KPI Batch Size';
        insert size;
        system.debug('inserting SPEKPIBatchSize__c '+size.id);
        
        //inserting supplier kpi calculation
        
        Supplier_KPI_Calculation_Adhoc__c suppkpicalcadhoc=new Supplier_KPI_Calculation_Adhoc__c ();
        suppkpicalcadhoc.KPI__c=kpidef.id;
        suppkpicalcadhoc.KPI_Calculation__c=kpicalc.id;
        insert suppkpicalcadhoc;
         
        
        //CreatePItempvalues 
        
        SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
        piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get((system.today()).month()) + ' - '+ String.valueOf((system.today()).year());
        piTempValue.PIValue__c = String.valueof(10);             
        piTempValue.Valuetype__c = piDef.ValuesType__c;
        piTempValue.KPIDefinition__c = kpicalc.KPIDefinition__c; 
        piTempValue.KPICalculation__c = kpicalc.Id;
        piTempValue.Project__c = 'Project';
        piTempValue.Country__c = 'Country';
        piTempValue.SubRegion__c = 'Market Unit';
        piTempValue.Period__c = Date.newInstance(2016,10,15);
        insert piTempValue;
        
        SPE_ProjectMaster__c objPM = new SPE_ProjectMaster__c(Project__c='Project',Country__c='Country', MarketUnit__c='Market Unit', Market__c='Market');
        insert objPM;
        SPE_RegionMaster masterData = new SPE_RegionMaster();
        
        SPE_CategoryMaster__c objCM = new SPE_CategoryMaster__c(Cluster__c='Test CL', Group__c='Test CG', Category__c='Test Category');
        insert objCM;
        
        SPE_BUBL__c objBUBL = new SPE_BUBL__c(BusinessUnit__c = 'Test BU', BusinessLine__c = 'Test BL', Product__c = 'Test Prod');
        insert objBUBL;
        
        system.debug('masterData----'+masterData.projectCountryMap);
        system.debug('masterData11----'+masterData.countrySubregionMap);
        system.debug('masterData22----'+masterData.subRegionRegionMap);
        system.debug('Test******' + masterData.projectCountryMap.get(piTempValue.Project__c)) ;
        system.debug('Testing***' +  masterData.countrySubregionMap.get(piTempValue.Country__c));
        system.debug('Testing11***' +  masterData.subRegionRegionMap.get(piTempValue.SubRegion__c));
        Test.startTest(); 
        
        SPE_KPISchedulePrebatch3ExecAdhoc bobj = new SPE_KPISchedulePrebatch3ExecAdhoc(kpidef.id); 
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null); 

        Database.executeBatch(bobj);
        Test.stopTest();
   
    
     
    
}
// piDef.GeoScope__c = 'Country' condition  
public static testmethod void testSPE_KPISchedulePrebatch3ExecAdhocTestMethod2() {  
string enterprise='enterprise';
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
            System.debug('inserting picklistvalue'+lstpicklistObj[0].id);
           //inserting pidefinitions
           
          SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
           piDef.LifecycleStage__c = 'Draft';
           piDef.ValuesType__c = 'Number';
           piDef.DataAcquisitionMethod__c ='Data Load';
           piDef.PIUploadDuedate__c = Date.newInstance(2016,10,10);
           insert piDef;
           piDef.LifecycleStage__c= 'Published'; 
           piDef.GeoScope__c = 'Country';
           piDef.CategoryScope__c = 'Category';
           piDef.BUScope__c = 'Product';    
           update piDef;
           System.debug('inserting SPE_PIDefinition__c'+piDef.id);
   
    
               //inserting kpi def
             SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1); 
             kpidef.FrequencyinMonth__c=null;
            kpidef.Buffer_Days__c =null;
            kpidef.ScheduledDate__c = null;
            kpidef.GeoScope__c = 'Country';
            kpidef.CategoryScope__c = 'Category';
            kpidef.BUScope__c = 'Product'; 
            kpidef.Adhoc_Date__c=system.today(); 
            kpidef.PI_Data__c = piDef.id; 
            insert kpidef;   
            kpidef.LifecycleStage__c='Pilot';
            update kpidef;    
            system.debug('inserting SPE_KPIDefinition__c done'+kpidef.id);
        
        
             //entering supplier detail 
            List<Account> lstAcc = new List<Account>();
    
             Account a = SPE_TestObjectCreator.CreateSupplier(enterprise);   
            lstAcc.add(a);    
            Account a2 = SPE_TestObjectCreator.CreateSupplier(enterprise);    
            lstAcc.add(a2);
            insert lstAcc;
            System.debug('inserting supplier'+lstAcc[0].id);       
  
        
         
         //inserting kpi calculation
          
        SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();          
        kpicalc.Aggregation__c='Max( Across Suppliers)';       
        kpicalc.KPIDefinition__c=kpidef.id;
        kpicalc.PIDefination__c=piDef.Id;
        kpicalc.TimeFrame__c=2;       
        kpicalc.Filter5__c ='1';
        kpicalc.Filter6__c = '1';
        kpicalc.Filter7__c = '1';
        kpicalc.Filter8__c = '1';
        kpicalc.Filter9__c = null;
        kpicalc.Filter10__c = '1';       
         insert kpicalc;
         system.debug(kpicalc.id);
    
    
    
      
        //inserting pi values
       
        SPE_PIValues__c piValueObj = SPE_TestObjectCreator.CreatePIValues(piDef.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c= 'Project';
        piValueObj.Product__c='Product';
        piValueObj.Category__c='Category';
        piValueObj.NumberValue__c=10;
        piValueObj.Period__c=Date.newInstance(2016,10,12); 
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1'; 
        //piValueObj.period__c=system.today(); 
        piValueObj.Project__c= 'Project';
        piValueObj.BusinessUnit__c ='Business';
        piValueObj.Cluster__c = 'Category';
        piValueObj.BusinessUnit__c ='Businedss Unit';
        piValueObj.MarketUnit__c = 'Market';
        piValueObj.BusinessLine__c = 'Business Line';
        piValueObj.CategoryGroup__c = 'Category Group';
        //piValueObj.Period__c = system.today().addMonths(-1);
        try{
            insert piValueObj;
        }
        Catch(Exception e){
        }
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
        
        //inserting batch size
        
        SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
        size.Size__c=2000;
        size.name='KPI Batch Size';
        insert size;
        system.debug('inserting SPEKPIBatchSize__c '+size.id);
        
        //inserting supplier kpi calculation
        
        Supplier_KPI_Calculation_Adhoc__c suppkpicalcadhoc=new Supplier_KPI_Calculation_Adhoc__c ();
        suppkpicalcadhoc.KPI__c=kpidef.id;
        suppkpicalcadhoc.KPI_Calculation__c=kpicalc.id;
        insert suppkpicalcadhoc;
         
        
        //CreatePItempvalues 
        
        SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
               piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get((system.today()).month()) + ' - '+ String.valueOf((system.today()).year());
               piTempValue.PIValue__c = String.valueof(10);             
               piTempValue.Valuetype__c = piDef.ValuesType__c;
               piTempValue.KPIDefinition__c = kpicalc.KPIDefinition__c; 
               piTempValue.KPICalculation__c = kpicalc.Id;
               piTempValue.Project__c = 'Project';
               piTempValue.Country__c = 'Country';
               piTempValue.SubRegion__c = 'Market Unit';
               piTempValue.Period__c = Date.newInstance(2016,10,15);
               insert piTempValue;
        
        SPE_ProjectMaster__c objPM = new SPE_ProjectMaster__c(Project__c='Project',Country__c='Country', MarketUnit__c='Market Unit', Market__c='Market');
        insert objPM;
        SPE_RegionMaster masterData = new SPE_RegionMaster();
        
        SPE_CategoryMaster__c objCM = new SPE_CategoryMaster__c(Cluster__c='Test CL', Group__c='Test CG', Category__c='Test Category');
        insert objCM;
        
        SPE_BUBL__c objBUBL = new SPE_BUBL__c(BusinessUnit__c = 'Test BU', BusinessLine__c = 'Test BL', Product__c = 'Test Prod');
        insert objBUBL;
        
        system.debug('masterData----'+masterData.projectCountryMap);
        system.debug('masterData11----'+masterData.countrySubregionMap);
        system.debug('masterData22----'+masterData.subRegionRegionMap);
        system.debug('Test******' + masterData.projectCountryMap.get(piTempValue.Project__c)) ;
        system.debug('Testing***' +  masterData.countrySubregionMap.get(piTempValue.Country__c));
        system.debug('Testing11***' +  masterData.subRegionRegionMap.get(piTempValue.SubRegion__c));
        Test.startTest(); 
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null); 

        SPE_KPISchedulePrebatch3ExecAdhoc bobj = new SPE_KPISchedulePrebatch3ExecAdhoc(String.valueof(kpidef.id)); 
        
        Database.executeBatch(bobj);
       Test.stopTest();
  }  
  public static testmethod void testSPE_KPISchedulePrebatch3ExecAdhocTestMethod3() {  
  
  
string enterprise='enterprise';
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
        
            System.debug('inserting picklistvalue'+lstpicklistObj[0].id);
           //inserting pidefinitions
           
          SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
           piDef.LifecycleStage__c = 'Draft';
           piDef.ValuesType__c = 'Number';
           piDef.DataAcquisitionMethod__c ='Data Load';
           piDef.PIUploadDuedate__c = Date.newInstance(2016,10,10);
           insert piDef;
           piDef.LifecycleStage__c= 'Published'; 
           piDef.GeoScope__c = 'Market Unit'; 
           piDef.CategoryScope__c = 'category';
           piDef.BUScope__c = 'Product';   
           update piDef;
           System.debug('inserting SPE_PIDefinition__c'+piDef.id);
   
    
               //inserting kpi def
             SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1); 
             kpidef.FrequencyinMonth__c=null;
            kpidef.Buffer_Days__c =null;
           kpidef.ScheduledDate__c = null;
            kpidef.GeoScope__c = 'Market Unit';
            kpidef.CategoryScope__c = 'category';
            kpidef.BUScope__c = 'Product'; 
            kpidef.PI_Data__c = piDef.id; 
            kpidef.Adhoc_Date__c = system.today().adddays(1); 
            
            insert kpidef;   
            kpidef.LifecycleStage__c='Pilot';
            update kpidef;    
            system.debug('inserting SPE_KPIDefinition__c done'+kpidef.id);
        
        
             //entering supplier detail 
            List<Account> lstAcc = new List<Account>();
    
             Account a = SPE_TestObjectCreator.CreateSupplier(enterprise);   
            lstAcc.add(a);    
            Account a2 = SPE_TestObjectCreator.CreateSupplier(enterprise);    
            lstAcc.add(a2);
            insert lstAcc;
            System.debug('inserting supplier'+lstAcc[0].id);       
  
        
         
         //inserting kpi calculation
          
        SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();          
        kpicalc.Aggregation__c='Avg( Across Suppliers)';       
        kpicalc.KPIDefinition__c=kpidef.id;
        kpicalc.PIDefination__c=piDef.Id;
        kpicalc.TimeFrame__c=2;       
       kpicalc.Filter5__c =null;
       kpicalc.Filter6__c = null;
        kpicalc.Filter7__c = null;
       kpicalc.Filter8__c = null;
       kpicalc.Filter9__c = null;
       kpicalc.Filter10__c = null;       
         insert kpicalc;
         system.debug(kpicalc.id);
    
    
    
      
        //inserting pi values
       
        SPE_PIValues__c piValueObj = SPE_TestObjectCreator.CreatePIValues(piDef.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c= 'Project';
        piValueObj.Product__c='Product';
        piValueObj.Category__c='Category';
        piValueObj.NumberValue__c=10;
        piValueObj.Period__c = Date.newInstance(2016,10,12);
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1'; 
        piValueObj.period__c=system.today(); 
        piValueObj.Project__c= 'Project';
        piValueObj.BusinessUnit__c ='Business';
        piValueObj.MarketUnit__c = 'Market';
        piValueObj.Cluster__c = 'Category';
        piValueObj.SubRegion__c = ' Market clus';
        try{
            insert piValueObj;
        }
        Catch(Exception e){
        }
        
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
        
        //inserting batch size
        
        SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
        size.Size__c=2000;
        size.name='KPI Batch Size';
        insert size;
        system.debug('inserting SPEKPIBatchSize__c '+size.id);
        
        //inserting supplier kpi calculation
        
        Supplier_KPI_Calculation_Adhoc__c suppkpicalcadhoc=new Supplier_KPI_Calculation_Adhoc__c ();
        suppkpicalcadhoc.KPI__c=kpidef.id;
        suppkpicalcadhoc.KPI_Calculation__c=kpicalc.id;
        insert suppkpicalcadhoc;
         
        
        //CreatePItempvalues 
        
        SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
               piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get((system.today()).month()) + ' - '+ String.valueOf((system.today()).year());
               piTempValue.PIValue__c = String.valueof(10);             
               piTempValue.Valuetype__c = piDef.ValuesType__c;
               piTempValue.KPIDefinition__c = kpicalc.KPIDefinition__c; 
               piTempValue.KPICalculation__c = kpicalc.Id;
               piTempValue.Project__c = 'Project';
               piTempValue.Country__c = 'Country';
               piTempValue.SubRegion__c = 'Market Unit';
               piTempValue.Period__c = Date.newInstance(2016,10,15);
               insert piTempValue;
        
        SPE_ProjectMaster__c objPM = new SPE_ProjectMaster__c(Project__c='Project',Country__c='Country', MarketUnit__c='Market Unit', Market__c='Market');
        insert objPM;
        SPE_RegionMaster masterData = new SPE_RegionMaster();
        
        SPE_CategoryMaster__c objCM = new SPE_CategoryMaster__c(Cluster__c='Test CL', Group__c='Test CG', Category__c='Test Category');
        insert objCM;
        
        SPE_BUBL__c objBUBL = new SPE_BUBL__c(BusinessUnit__c = 'Test BU', BusinessLine__c = 'Test BL', Product__c = 'Test Prod');
        insert objBUBL;
        
        system.debug('masterData----'+masterData.projectCountryMap);
        system.debug('masterData11----'+masterData.countrySubregionMap);
        system.debug('masterData22----'+masterData.subRegionRegionMap);
        system.debug('Test******' + masterData.projectCountryMap.get(piTempValue.Project__c)) ;
        system.debug('Testing***' +  masterData.countrySubregionMap.get(piTempValue.Country__c));
        system.debug('Testing11***' +  masterData.subRegionRegionMap.get(piTempValue.SubRegion__c));
        Test.startTest(); 
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null); 

        SPE_KPISchedulePrebatch3ExecAdhoc bobj = new SPE_KPISchedulePrebatch3ExecAdhoc(String.valueof(kpidef.id)); 
        
        Database.executeBatch(bobj);
       Test.stopTest();
  }  
  public static testmethod void testSPE_KPISchedulePrebatch3ExecAdhocTestMethod4() {  
string enterprise='enterprise';
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
        
            System.debug('inserting picklistvalue'+lstpicklistObj[0].id);
           //inserting pidefinitions
           
          SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
           piDef.LifecycleStage__c = 'Draft';
           piDef.ValuesType__c = 'Number';
           piDef.DataAcquisitionMethod__c ='Data Load';
           piDef.PIUploadDuedate__c = Date.newInstance(2016,10,10);
           insert piDef;
           piDef.LifecycleStage__c= 'Published'; 
           piDef.GeoScope__c = 'Country'; 
           piDef.CategoryScope__c = 'category';
           piDef.BUScope__c = 'Product';  
           update piDef;
           System.debug('inserting SPE_PIDefinition__c'+piDef.id);
   
    
               //inserting kpi def
             SPE_KPIDefinition__c kpidef=SPE_TestObjectCreator.CreateKPIDefinition(1); 
             kpidef.FrequencyinMonth__c=null;
            kpidef.Buffer_Days__c =null;
           kpidef.ScheduledDate__c = null;
            kpidef.GeoScope__c = 'Country';
            kpidef.CategoryScope__c = 'category';
            kpidef.BUScope__c = 'Product'; 
            kpidef.Adhoc_Date__c=system.today().adddays(1); 
            kpidef.PI_Data__c = piDef.id; 
            insert kpidef;   
            kpidef.LifecycleStage__c='Pilot';
            update kpidef;    
            system.debug('inserting SPE_KPIDefinition__c done'+kpidef.id);
        
        
             //entering supplier detail 
            List<Account> lstAcc = new List<Account>();
    
             Account a = SPE_TestObjectCreator.CreateSupplier(enterprise);   
            lstAcc.add(a);    
            Account a2 = SPE_TestObjectCreator.CreateSupplier(enterprise);    
            lstAcc.add(a2);
            insert lstAcc;
            System.debug('inserting supplier'+lstAcc[0].id);       
  
        
         
         //inserting kpi calculation
          
        SPE_KPICalculation__c kpicalc=SPE_TestObjectCreator.createKPICalculation();          
        kpicalc.Aggregation__c='Avg( Across Suppliers)';       
        kpicalc.KPIDefinition__c=kpidef.id;
        kpicalc.PIDefination__c=piDef.Id;
        kpicalc.TimeFrame__c=2;       
       kpicalc.Filter5__c =null;
       kpicalc.Filter6__c = null;
        kpicalc.Filter7__c = null;
       kpicalc.Filter8__c = null;
       kpicalc.Filter9__c = null;
       kpicalc.Filter10__c = null;       
         insert kpicalc;
         system.debug(kpicalc.id);
    
    
    
      
        //inserting pi values
       
        SPE_PIValues__c piValueObj = SPE_TestObjectCreator.CreatePIValues(piDef.Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c= 'Project';
        piValueObj.Product__c='Product';
        piValueObj.Category__c='Category';
        piValueObj.NumberValue__c=10;
        piValueObj.Period__c=Date.newInstance(2016,10,12); 
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1'; 
        piValueObj.period__c=system.today(); 
        piValueObj.Project__c= 'Project';
        piValueObj.BusinessUnit__c ='Business';
        piValueObj.Cluster__c = 'Category';
        try{
            insert piValueObj;
            }
        Catch(Exception e){
        }
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
        
        //inserting batch size
        
        SPEKPIBatchSize__c size=new SPEKPIBatchSize__c();
        size.Size__c=2000;
        size.name='KPI Batch Size';
        insert size;
        system.debug('inserting SPEKPIBatchSize__c '+size.id);
        
        //inserting supplier kpi calculation
        
        Supplier_KPI_Calculation_Adhoc__c suppkpicalcadhoc=new Supplier_KPI_Calculation_Adhoc__c ();
        suppkpicalcadhoc.KPI__c=kpidef.id;
        suppkpicalcadhoc.KPI_Calculation__c=kpicalc.id;
        insert suppkpicalcadhoc;
         
        
        //CreatePItempvalues 
        
        SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
               piTempValue.ExecutionPeriod__c = SPE_Utility.monthsMap.get((system.today()).month()) + ' - '+ String.valueOf((system.today()).year());
               piTempValue.PIValue__c = String.valueof(10);             
               piTempValue.Valuetype__c = piDef.ValuesType__c;
               piTempValue.KPIDefinition__c = kpicalc.KPIDefinition__c; 
               piTempValue.KPICalculation__c = kpicalc.Id;
               piTempValue.Project__c = 'Project';
               piTempValue.Country__c = 'Country';
               piTempValue.SubRegion__c = 'Market Unit';
               piTempValue.Period__c = Date.newInstance(2016,10,15);
               insert piTempValue;
        
        SPE_ProjectMaster__c objPM = new SPE_ProjectMaster__c(Project__c='Project',Country__c='Country', MarketUnit__c='Market Unit', Market__c='Market');
        insert objPM;
        SPE_RegionMaster masterData = new SPE_RegionMaster();
        
        SPE_CategoryMaster__c objCM = new SPE_CategoryMaster__c(Cluster__c='Test CL', Group__c='Test CG', Category__c='Test Category');
        insert objCM;
        
        SPE_BUBL__c objBUBL = new SPE_BUBL__c(BusinessUnit__c = 'Test BU', BusinessLine__c = 'Test BL', Product__c = 'Test Prod');
        insert objBUBL;
        
        system.debug('masterData----'+masterData.projectCountryMap);
        system.debug('masterData11----'+masterData.countrySubregionMap);
        system.debug('masterData22----'+masterData.subRegionRegionMap);
        system.debug('Test******' + masterData.projectCountryMap.get(piTempValue.Project__c)) ;
        system.debug('Testing***' +  masterData.countrySubregionMap.get(piTempValue.Country__c));
        system.debug('Testing11***' +  masterData.subRegionRegionMap.get(piTempValue.SubRegion__c));
        Test.startTest(); 
        
        SPE_KPISchedulePrebatch3ExecAdhoc bobj = new SPE_KPISchedulePrebatch3ExecAdhoc(String.valueof(kpidef.id)); 
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null); 

        Database.executeBatch(bobj);
       Test.stopTest();
  }  
}