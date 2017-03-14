@isTest(SeeAllData=false)

public class SPE_KPIScheduleFinalbatchTest{
    static testmethod void SPE_KPIScheduleFinalbatch_Test1() {
    Test.startTest();           
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
        List<Account> lstAcc = new List<Account>();    
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        lstAcc.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.EnterpriseId__c = 'Test Enterprise2';
        lstAcc.add(acc2);
        
        insert lstAcc;
        
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = lstAcc[0].ID;   
        contact.email='surveyTracktest@test.net';   
        insert contact;  
   
        //-- PI definition data ---  
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition';
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,3,10);
        lstPIDefObj.add(PIDefObj);
                    
        SPE_PIDefinition__c PIDefObj1 = new SPE_PIDefinition__c();
        PIDefObj1 = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj1.PI_Title__c = 'Test PI Definition';
        PIDefObj1.LifecycleStage__c = 'Draft';
        PIDefObj1.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj1.PIUploadDuedate__c = Date.newInstance(2018,10,10);
        lstPIDefObj.add(PIDefObj1);
        
        insert lstPIDefObj;
        
        for(SPE_PIDefinition__c pi : lstPIDefObj){
            pi.LifecycleStage__c= 'Pilot';
        }
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
        //**********************END******************// 
        // kpiDefinition1.PI_Data__c = lstPIDefObj[0].Id;
        kpiDefinition1.Buffer_Days__c = 1;
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c =  'Country';
        kpiDefinition1.categoryscope__c =  'Category';
        kpiDefinition1.BUScope__c = 'Business Line';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.ActualCalculation__c='A';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.ScheduledDate__c = date.newInstance(2018,10,11);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Aggregation__c = 'AVG';        
        kpiDefinition1.IsHighBetter__c=true;
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
        for(Integer i=0;i<2;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
        //  KPIcalc.PrevKPIDefination__c = kpiDefinition1.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = kpiDefinition1.Id;
        KPIcalc.Aggregation__c = 'Sum';
        KPIcalc.Index__c = 'A';
        KPIcalc.Filter1__c = '1';
        KPIcalc.Filter2__c = '1';
        KPIcalc.Filter3__c = '1';
        KPIcalc.Filter4__c = '1';
        KPIcalc.Filter5__c = '1';
        KPIcalc.Filter6__c = '1';
        KPIcalc.Filter7__c = '1';
        KPIcalc.Filter8__c = '1';
        //KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
        }
        insert lstKPIcalc;
        
        //---Suppiler KPI calculation data starts--
        List<Supplier_KPI_Callculation__c> lstsupplierKPICalc = new List<Supplier_KPI_Callculation__c>();
        
        for(Integer i=0;i<2;i++){
        Supplier_KPI_Callculation__c supplierKPICalc = new Supplier_KPI_Callculation__c();
        supplierKPICalc.KPI__c = kpiDefinition1.Id;
        supplierKPICalc.KPI_Calculation__c = lstKPIcalc[i].Id;
        supplierKPICalc.IsAdhoc__c = false;
        lstsupplierKPICalc.add(supplierKPICalc);
        }
        insert lstsupplierKPICalc;
        
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        
        SPE_KPIScheduleFinalbatch batchTest = new SPE_KPIScheduleFinalbatch();
        Database.executeBatch(batchTest,lstAcc.size());   
        SchedulableContext schCon = null;
        batchTest.execute(schCon);
         
    Test.stopTest();    
   }
   
   static testmethod void SPE_KPIScheduleFinalbatch_Test2() {
     Test.startTest();           
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'Services Procurement';
        picklistObj.Category_Group__c = 'NI Materials';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = '--None--';
        picklistObj.Market_Unit__c = '--None--';
        picklistObj.Market__c = '--None--';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = '--None--';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        List<Account> lstAcc = new List<Account>();    
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        lstAcc.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.EnterpriseId__c = 'Test Enterprise2';
        lstAcc.add(acc2);
        
        insert lstAcc;
        
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = lstAcc[0].ID;   
        contact.email='surveyTracktest@test.net';   
        insert contact;  
        
        SPE_ProjectMaster__c projMaster = new SPE_ProjectMaster__c();
        projMaster.Country__c = 'Netherlands';
        projMaster.MarketUnit__c = 'SEE';
        projMaster.Market__c = 'EUR';
        projMaster.Project__c ='NL-GSMR';    
        insert projMaster;
        
        SPE_RegionMaster__c regMaster = new SPE_RegionMaster__c();
        regMaster.CORegion__c = 'Asia';
        regMaster.Country__c = 'India';
        regMaster.GPRregion__c = 'Pak';
        regMaster.GPRSubregion__c ='Indo';    
        insert regMaster;
        
        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'SB';
        bubl.BusinessUnit__c = 'SL';
        bubl.Product__c = 'SM';
        insert bubl;
        
        SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
        cm.Category__c = 'Cat';
        cm.Cluster__c = 'RAT';
        cm.Group__c = 'Test';
        insert cm;
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
        KPI.FrequencyinMonth__c = '1';
        KPI.GeoScope__c = 'Project';
        KPI.BUScope__c = 'Product';
        KPI.categoryscope__c = 'Category';
        KPI.Adhoc_Date__c = system.today(); 
        insert KPI;
                  
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
        //*********************Changes For Encryption******************//  
                //PIDefObj.Name = 'Test PI Definition'+i;
                PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        //*********************END******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].ValuesType__c = 'Number';
        }        
        update lstPIDefObj;
        
        //-----pi definition data ends----
        
        List<SPE_PIValues__c> lstpiValueObj = new List<SPE_PIValues__c>();
        
        for(Integer i=0;i<2;i++){        
        SPE_PIValues__c piValueObj = new SPE_PIValues__c();
        piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c = 'Country';
        piValueObj.Category__c  = 'Category';
        piValueObj.Product__c =  'Product';
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1';
        piValueObj.Filter5__c = '1';
        piValueObj.Filter6__c = '1';
        piValueObj.Filter7__c = '1';
        piValueObj.Filter8__c = '1';
        //piValueObj.Filter9_del__c = '1';
        piValueObj.Filter10__c = '1';
        piValueObj.Period__c = Date.newInstance(2099, 06, 02);
        piValueObj.SurveyComments__c = 'Test Test';
        piValueObj.Respondent__c = contact.ID;
        lstpiValueObj.add(piValueObj);
        }
        try{
            insert lstpiValueObj;
        }
        catch(exception e){
        
        }
        //--- KPI calculation data preparation starts ---
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
        for(Integer i=0;i<2;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
       // KPIcalc.PrevKPIDefination__c = KPI.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = KPI.Id;
        KPIcalc.Aggregation__c = 'Sum';
        KPIcalc.Index__c = 'A';
        KPIcalc.Filter1__c = '1';
        KPIcalc.Filter2__c = '1';
        KPIcalc.Filter3__c = '1';
        KPIcalc.Filter4__c = '1';
        KPIcalc.Filter5__c = '1';
        KPIcalc.Filter6__c = '1';
        KPIcalc.Filter7__c = '1';
        KPIcalc.Filter8__c = '1';
       // KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
        }
        insert lstKPIcalc;
        
        //---Suppiler KPI calculation data starts--
        List<Supplier_KPI_Callculation__c> lstsupplierKPICalc = new List<Supplier_KPI_Callculation__c>();
        
        for(Integer i=0;i<2;i++){
        Supplier_KPI_Callculation__c supplierKPICalc = new Supplier_KPI_Callculation__c();
        supplierKPICalc.KPI__c = KPI.Id;
        supplierKPICalc.KPI_Calculation__c = lstKPIcalc[i].Id;
        supplierKPICalc.IsAdhoc__c = false;
        lstsupplierKPICalc.add(supplierKPICalc);
        }
        insert lstsupplierKPICalc;
        
        SPE_KPIScheduleFinalbatch batchTest = new SPE_KPIScheduleFinalbatch();
        Database.executeBatch(batchTest,200);
        
        SchedulableContext schCon = null;
        batchTest.execute(schCon);
       
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
         
    Test.stopTest();    
   }
  
   static testmethod void SPE_KPIScheduleFinalbatch_Test3() {
     Test.startTest();           
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'Services Procurement';
        picklistObj.Category_Group__c = 'NI Materials';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = '--None--';
        picklistObj.Market_Unit__c = '--None--';
        picklistObj.Market__c = '--None--';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = '--None--';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        List<Account> lstAcc = new List<Account>();    
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        lstAcc.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.EnterpriseId__c = 'Test Enterprise2';
        lstAcc.add(acc2);
        
        insert lstAcc;
        
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = lstAcc[0].ID;   
        contact.email='surveyTracktest@test.net';   
        insert contact;  
        
        SPE_ProjectMaster__c projMaster = new SPE_ProjectMaster__c();
        projMaster.Country__c = 'Netherlands';
        projMaster.MarketUnit__c = 'SEE';
        projMaster.Market__c = 'EUR';
        projMaster.Project__c ='NL-GSMR';    
        insert projMaster;
        
        SPE_RegionMaster__c regMaster = new SPE_RegionMaster__c();
        regMaster.CORegion__c = 'Asia';
        regMaster.Country__c = 'India';
        regMaster.GPRregion__c = 'Pak';
        regMaster.GPRSubregion__c ='Indo';    
        insert regMaster;
        
        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'SB';
        bubl.BusinessUnit__c = 'SL';
        bubl.Product__c = 'SM';
        insert bubl;
        
        SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
        cm.Category__c = 'Cat';
        cm.Cluster__c = 'RAT';
        cm.Group__c = 'Test';
        insert cm;
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
        KPI.FrequencyinMonth__c = '1';
        KPI.GeoScope__c = 'Market Unit';
        KPI.BUScope__c = 'Product';
        KPI.categoryscope__c = 'Category';
        KPI.Adhoc_Date__c = system.today(); 
        insert KPI;
                  
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
        //*********************Changes For Encryption******************//  
                //PIDefObj.Name = 'Test PI Definition'+i;
                PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        //*********************END******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].ValuesType__c = 'Date';
        }        
        update lstPIDefObj;
        
        //-----pi definition data ends----
        
        List<SPE_PIValues__c> lstpiValueObj = new List<SPE_PIValues__c>();
        
        for(Integer i=0;i<2;i++){        
        SPE_PIValues__c piValueObj = new SPE_PIValues__c();
        piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c = 'Country';
        piValueObj.Category__c  = 'Category';
        piValueObj.Product__c =  'Product';
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1';
        piValueObj.Filter5__c = '1';
        piValueObj.Filter6__c = '1';
        piValueObj.Filter7__c = '1';
        piValueObj.Filter8__c = '1';
        //piValueObj.Filter9_del__c = '1';
        piValueObj.Filter10__c = '1';
        piValueObj.Period__c = Date.newInstance(2099, 06, 02);
        piValueObj.SurveyComments__c = 'Test Test';
        piValueObj.Respondent__c = contact.ID;
        lstpiValueObj.add(piValueObj);
        }
        try{
            insert lstpiValueObj;
        }
        catch(exception e){
        
        }
        //--- KPI calculation data preparation starts ---
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
        for(Integer i=0;i<2;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
       // KPIcalc.PrevKPIDefination__c = KPI.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = KPI.Id;
        KPIcalc.Aggregation__c = 'Min';
        KPIcalc.Index__c = 'A';
        KPIcalc.Filter1__c = '1';
        KPIcalc.Filter2__c = '1';
        KPIcalc.Filter3__c = '1';
        KPIcalc.Filter4__c = '1';
        KPIcalc.Filter5__c = '1';
        KPIcalc.Filter6__c = '1';
        KPIcalc.Filter7__c = '1';
        KPIcalc.Filter8__c = '1';
       // KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
        }
        insert lstKPIcalc;
        
        //---Suppiler KPI calculation data starts--
        List<Supplier_KPI_Callculation__c> lstsupplierKPICalc = new List<Supplier_KPI_Callculation__c>();
        
        for(Integer i=0;i<2;i++){
        Supplier_KPI_Callculation__c supplierKPICalc = new Supplier_KPI_Callculation__c();
        supplierKPICalc.KPI__c = KPI.Id;
        supplierKPICalc.KPI_Calculation__c = lstKPIcalc[i].Id;
        supplierKPICalc.IsAdhoc__c = false;
        lstsupplierKPICalc.add(supplierKPICalc);
        }
        insert lstsupplierKPICalc;
        
        SPE_KPIScheduleFinalbatch batchTest = new SPE_KPIScheduleFinalbatch();
        Database.executeBatch(batchTest,200);
        
        SchedulableContext schCon = null;
        batchTest.execute(schCon);
       
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
         
    Test.stopTest();    
    }
     static testmethod void SPE_KPIScheduleFinalbatch_Test4() {
     Test.startTest();           
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'Services Procurement';
        picklistObj.Category_Group__c = 'NI Materials';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = '--None--';
        picklistObj.Market_Unit__c = '--None--';
        picklistObj.Market__c = '--None--';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = '--None--';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        List<Account> lstAcc = new List<Account>();    
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        lstAcc.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.EnterpriseId__c = 'Test Enterprise2';
        lstAcc.add(acc2);
        
        insert lstAcc;
        
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = lstAcc[0].ID;   
        contact.email='surveyTracktest@test.net';   
        insert contact;  
        
        SPE_ProjectMaster__c projMaster = new SPE_ProjectMaster__c();
        projMaster.Country__c = 'Netherlands';
        projMaster.MarketUnit__c = 'SEE';
        projMaster.Market__c = 'EUR';
        projMaster.Project__c ='NL-GSMR';    
        insert projMaster;
        
        SPE_RegionMaster__c regMaster = new SPE_RegionMaster__c();
        regMaster.CORegion__c = 'Asia';
        regMaster.Country__c = 'India';
        regMaster.GPRregion__c = 'Pak';
        regMaster.GPRSubregion__c ='Indo';    
        insert regMaster;
        
        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'SB';
        bubl.BusinessUnit__c = 'SL';
        bubl.Product__c = 'SM';
        insert bubl;
        
        SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
        cm.Category__c = 'Cat';
        cm.Cluster__c = 'RAT';
        cm.Group__c = 'Test';
        insert cm;
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
        KPI.FrequencyinMonth__c = '1';
        KPI.GeoScope__c =  'Market Unit';
        KPI.BUScope__c = 'Product';
        KPI.categoryscope__c = 'Category';
        KPI.Adhoc_Date__c = system.today(); 
        insert KPI;
                  
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
        //*********************Changes For Encryption******************//  
                //PIDefObj.Name = 'Test PI Definition'+i;
                PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        //*********************END******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].ValuesType__c = 'Boolean';
        }        
        update lstPIDefObj;
        
        //-----pi definition data ends----
        
        List<SPE_PIValues__c> lstpiValueObj = new List<SPE_PIValues__c>();
        
        for(Integer i=0;i<2;i++){        
        SPE_PIValues__c piValueObj = new SPE_PIValues__c();
        piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c = 'Country';
        piValueObj.Category__c  = 'Category';
        piValueObj.Product__c =  'Product';
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1';
        piValueObj.Filter5__c = '1';
        piValueObj.Filter6__c = '1';
        piValueObj.Filter7__c = '1';
        piValueObj.Filter8__c = '1';
        //piValueObj.Filter9_del__c = '1';
        piValueObj.Filter10__c = '1';
        piValueObj.Period__c = Date.newInstance(2099, 06, 02);
        piValueObj.SurveyComments__c = 'Test Test';
        piValueObj.Respondent__c = contact.ID;
        lstpiValueObj.add(piValueObj);
        }
        try{
            insert lstpiValueObj;
        }
        catch(exception e){
        
        }
        //--- KPI calculation data preparation starts ---
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
        for(Integer i=0;i<2;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
       // KPIcalc.PrevKPIDefination__c = KPI.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = KPI.Id;
        KPIcalc.Aggregation__c = 'Min';
        KPIcalc.Index__c = 'A';
        KPIcalc.Filter1__c = '1';
        KPIcalc.Filter2__c = '1';
        KPIcalc.Filter3__c = '1';
        KPIcalc.Filter4__c = '1';
        KPIcalc.Filter5__c = '1';
        KPIcalc.Filter6__c = '1';
        KPIcalc.Filter7__c = '1';
        KPIcalc.Filter8__c = '1';
       // KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
        }
        insert lstKPIcalc;
        
        //---Suppiler KPI calculation data starts--
        List<Supplier_KPI_Callculation__c> lstsupplierKPICalc = new List<Supplier_KPI_Callculation__c>();
        
        for(Integer i=0;i<2;i++){
        Supplier_KPI_Callculation__c supplierKPICalc = new Supplier_KPI_Callculation__c();
        supplierKPICalc.KPI__c = KPI.Id;
        supplierKPICalc.KPI_Calculation__c = lstKPIcalc[i].Id;
        supplierKPICalc.IsAdhoc__c = false;
        lstsupplierKPICalc.add(supplierKPICalc);
        }
        insert lstsupplierKPICalc;
        
        SPE_KPIScheduleFinalbatch batchTest = new SPE_KPIScheduleFinalbatch();
        Database.executeBatch(batchTest,200);
        
        SchedulableContext schCon = null;
        batchTest.execute(schCon);
       
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
         
    Test.stopTest();    
   }
   static testmethod void SPE_KPIScheduleFinalbatch_Test5() {
     Test.startTest();           
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'Services Procurement';
        picklistObj.Category_Group__c = 'NI Materials';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = '--None--';
        picklistObj.Market_Unit__c = '--None--';
        picklistObj.Market__c = '--None--';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = '--None--';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        List<Account> lstAcc = new List<Account>();    
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        lstAcc.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.EnterpriseId__c = 'Test Enterprise2';
        lstAcc.add(acc2);
        
        insert lstAcc;
        
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = lstAcc[0].ID;   
        contact.email='surveyTracktest@test.net';   
        insert contact;  
        
        SPE_ProjectMaster__c projMaster = new SPE_ProjectMaster__c();
        projMaster.Country__c = 'Netherlands';
        projMaster.MarketUnit__c = 'SEE';
        projMaster.Market__c = 'EUR';
        projMaster.Project__c ='NL-GSMR';    
        insert projMaster;
        
        SPE_RegionMaster__c regMaster = new SPE_RegionMaster__c();
        regMaster.CORegion__c = 'Asia';
        regMaster.Country__c = 'India';
        regMaster.GPRregion__c = 'Pak';
        regMaster.GPRSubregion__c ='Indo';    
        insert regMaster;
        
        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'SB';
        bubl.BusinessUnit__c = 'SL';
        bubl.Product__c = 'SM';
        insert bubl;
        
        SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
        cm.Category__c = 'Cat';
        cm.Cluster__c = 'RAT';
        cm.Group__c = 'Test';
        insert cm;
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
        KPI.FrequencyinMonth__c = '1';
        KPI.GeoScope__c =  'Country';
        KPI.BUScope__c = 'Business Line';
        KPI.categoryscope__c =  'Category Group';
        KPI.Adhoc_Date__c = system.today(); 
        insert KPI;
                  
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
        //*********************Changes For Encryption******************//  
                //PIDefObj.Name = 'Test PI Definition'+i;
                PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        //*********************END******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].ValuesType__c = 'String';       
        }        
        update lstPIDefObj;
        
        //-----pi definition data ends----
        
        List<SPE_PIValues__c> lstpiValueObj = new List<SPE_PIValues__c>();
        
        for(Integer i=0;i<2;i++){        
        SPE_PIValues__c piValueObj = new SPE_PIValues__c();
        piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
        piValueObj.Country__c = 'Country';
        piValueObj.Category__c  = 'Category';
        piValueObj.Product__c =  'Product';
        piValueObj.Filter1__c = '1';
        piValueObj.Filter2__c = '1';
        piValueObj.Filter3__c = '1';
        piValueObj.Filter4__c = '1';
        piValueObj.Filter5__c = '1';
        piValueObj.Filter6__c = '1';
        piValueObj.Filter7__c = '1';
        piValueObj.Filter8__c = '1';
        //piValueObj.Filter9_del__c = '1';
        piValueObj.Filter10__c = '1';
        piValueObj.Period__c = Date.newInstance(2099, 06, 02);
        piValueObj.SurveyComments__c = 'Test Test';
        piValueObj.Respondent__c = contact.ID;
        lstpiValueObj.add(piValueObj);
        }
        try{
            insert lstpiValueObj;
        }
        catch(exception e){
        
        }
        //--- KPI calculation data preparation starts ---
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
        for(Integer i=0;i<2;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
       // KPIcalc.PrevKPIDefination__c = KPI.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = KPI.Id;
        KPIcalc.Aggregation__c ='Min';
        KPIcalc.Index__c = 'A';
        KPIcalc.Filter1__c = '1';
        KPIcalc.Filter2__c = '1';
        KPIcalc.Filter3__c = '1';
        KPIcalc.Filter4__c = '1';
        KPIcalc.Filter5__c = '1';
        KPIcalc.Filter6__c = '1';
        KPIcalc.Filter7__c = '1';
        KPIcalc.Filter8__c = '1';
       // KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
        }
        insert lstKPIcalc;
        
        //---Suppiler KPI calculation data starts--
        List<Supplier_KPI_Callculation__c> lstsupplierKPICalc = new List<Supplier_KPI_Callculation__c>();
        
        for(Integer i=0;i<2;i++){
        Supplier_KPI_Callculation__c supplierKPICalc = new Supplier_KPI_Callculation__c();
        supplierKPICalc.KPI__c = KPI.Id;
        supplierKPICalc.KPI_Calculation__c = lstKPIcalc[i].Id;
        supplierKPICalc.IsAdhoc__c = false;
        lstsupplierKPICalc.add(supplierKPICalc);
        }
        insert lstsupplierKPICalc;
        
        SPE_KPIScheduleFinalbatch batchTest = new SPE_KPIScheduleFinalbatch();
        Database.executeBatch(batchTest,200);
        
        SchedulableContext schCon = null;
        batchTest.execute(schCon);
       
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
         
    Test.stopTest();    
   }
   
      static testmethod void SPE_KPIScheduleFinalbatch_Test6() {
     Test.startTest();           
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'Services Procurement';
        picklistObj.Category_Group__c = 'NI Materials';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = '--None--';
        picklistObj.Market_Unit__c = '--None--';
        picklistObj.Market__c = '--None--';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = '--None--';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        List<Account> lstAcc = new List<Account>();
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

        
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = lstAcc[0].ID;   
        contact.email='surveyTracktest@test.net';   
        insert contact;  
        
        SPE_ProjectMaster__c projMaster = new SPE_ProjectMaster__c();
        projMaster.Country__c = 'Netherlands';
        projMaster.MarketUnit__c = 'SEE';
        projMaster.Market__c = 'EUR';
        projMaster.Project__c ='NL-GSMR';    
        insert projMaster;
        
        SPE_RegionMaster__c regMaster = new SPE_RegionMaster__c();
        regMaster.CORegion__c = 'Asia';
        regMaster.Country__c = 'India';
        regMaster.GPRregion__c = 'Pak';
        regMaster.GPRSubregion__c ='Indo';    
        insert regMaster;
        
        SPE_BUBL__c bubl = new SPE_BUBL__c();
        bubl.BusinessLine__c = 'SB';
        bubl.BusinessUnit__c = 'SL';
        bubl.Product__c = 'SM';
        insert bubl;
        
        SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
        cm.Category__c = 'Cat';
        cm.Cluster__c = 'RAT';
        cm.Group__c = 'Test';
        insert cm;
     
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.AnswerType__c = 'FreeText';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
      //  surQues.OperationalType__c = 'Picklist';
        surQues.PIDefinition__c = 'Test PI Definition';
        surQues.PIType__c = 'Survey PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
        insert surQues;  
        
 
                  
           List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
            SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();         
            PIDefObj.PI_Title__c = 'Test PI Definition'+i;
            PIDefObj.SurveyQuestion__c = surQues.Id ;
            PIDefObj.LifecycleStage__c = 'Draft';
            PIDefObj.SourceDataOwner__c = 'testing';
            PIDefObj.ValuesType__c = 'Number';
            PIDefObj.OperationalType__c = 'Leading KPI';
            PIDefObj.Type__c = 'Operational';
            PIDefObj.DataAcquisitionMethod__c = 'Survey';
            PIDefObj.UoM__c = 'max';
           // PIDefObj.Business__c = 'NPP';
            PIDefObj.GeoScope__c = 'All Markets';
            PIDefObj.CategoryScope__c = 'All Categories';
            PIDefObj.BUScope__c = 'All Products';
            PIDefObj.Frequency__c = '0';
            PIDefObj.ValuesType__c='Number';
            lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        lstPIDefObj[0].LifecycleStage__c= 'Pilot';
        update lstPIDefObj;
        
        
        
        //-----pi definition data ends----
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI.KPI_Title__c = 'Test KPI Definition';
        //KPI.PI_Data__c = lstPIDefObj[0].Id;
        KPI.AbbreviatedName__c = 'TKPIDef';
        KPI.Level__c = '1';
        KPI.LifecycleStage__c = 'Draft';
        KPI.Description__c = 'Test';
        KPI.MissingDatalogic__c = 'Past Data or Category Average';
        KPI.OperationalType__c = 'Leading PI';
        KPI.GeoScope__c =  'Project';
        KPI.categoryscope__c = 'Category Area';
        KPI.BUScope__c = 'Business Unit';
        KPI.UoM__c = 'max';
        KPI.Group1__c = 'Cost';
        KPI.Group2__c = 'Hard';
        KPI.Type__c = 'Operational';
        KPI.Buffer_Days__c= 1;
        KPI.FrequencyinMonth__c = '1';
        KPI.SurveyBased__c = true;
        KPI.ScheduledDate__c = system.today().addDays(3);
        KPI.FromDate__c = Date.today();
        KPI.ToDate__c = Date.today().addDays(10);
     //   KPI.ActualCalculation__c = 'A+B+C';
        insert KPI;
        
        KPI.LifecycleStage__c = 'Pilot';
        update KPI;
        
        List<SPE_PIValues__c> lstpiValueObj = new List<SPE_PIValues__c>();
        
        for(Integer i=0;i<1;i++){        
       
        SPE_PIValues__c piValueObj = new SPE_PIValues__c(); 
            piValueObj.PIDefination__c = lstPIDefObj[0].Id;
            piValueObj.Supplier__c = lstAcc[0].Id;
            piValueObj.EnterpriseID__c = lstAcc[0].EnterpriseId__c;
            piValueObj.Period__c = system.today().addMonths(-1);
            piValueObj.Cluster__c='All Category Areas';
            piValueObj.Market__c ='IND';
            piValueObj.SubRegion__c ='IND MX';
            piValueObj.Country__c ='India';
            piValueObj.Project__c ='IND BPL';
            piValueObj.BusinessUnit__c='All Business Units';
            piValueObj.NumberValue__c = 10;
            piValueObj.Filter1__c = '1';
            piValueObj.Filter2__c = '1';
            piValueObj.Filter3__c = '1';
            piValueObj.Filter4__c = '1';
            piValueObj.Filter5__c = '1';
            piValueObj.Filter6__c = '1';
            piValueObj.Filter7__c = '1';
            piValueObj.Filter8__c = '1';
          //  piValueObj.Filter9_del__c = '1';
            piValueObj.Filter10__c = '1'; 
            piValueObj.SurveyComments__c = 'OK';
            insert piValueObj;

        lstpiValueObj.add(piValueObj);
        }
        
      //--- KPI calculation data preparation starts ---
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
        for(Integer i=0;i<1;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
       // KPIcalc.PrevKPIDefination__c = KPI.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = KPI.Id;
        KPIcalc.Aggregation__c = 'Max';
        KPIcalc.Index__c = 'A';
        KPIcalc.Filter1__c = '1';
        KPIcalc.Filter2__c = '1';
        KPIcalc.Filter3__c = '1';
        KPIcalc.Filter4__c = '1';
        KPIcalc.Filter5__c = '1';
        KPIcalc.Filter6__c = '1';
        KPIcalc.Filter7__c = '1';
        KPIcalc.Filter8__c = '1';
       // KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
        }
        insert lstKPIcalc;
        
        //---Suppiler KPI calculation data starts--
        List<Supplier_KPI_Callculation__c> lstsupplierKPICalc = new List<Supplier_KPI_Callculation__c>();
        
        for(Integer i=0;i<1;i++){
        Supplier_KPI_Callculation__c supplierKPICalc = new Supplier_KPI_Callculation__c();
        supplierKPICalc.KPI__c = KPI.Id;
        supplierKPICalc.KPI_Calculation__c = lstKPIcalc[i].Id;
        supplierKPICalc.IsAdhoc__c = false;
        lstsupplierKPICalc.add(supplierKPICalc);
        }
        insert lstsupplierKPICalc;

        SPE_KPIScheduleFinalbatch batchTest = new SPE_KPIScheduleFinalbatch();
       // Database.executeBatch(batchTest,1);
        
        SchedulableContext schCon = null;
        batchTest.execute(schCon);
       
        List<SPE_KPICalculation__c> lstResult = [SELECT ID,KPIDefinition__c FROM SPE_KPICalculation__c];
        system.assert(lstResult[0].KPIDefinition__c!=null);
         
    Test.stopTest();    
   }
}