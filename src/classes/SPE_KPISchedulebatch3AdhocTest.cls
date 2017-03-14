@isTest(SeeAllData = False)

public class SPE_KPISchedulebatch3AdhocTest {
    static testmethod void testSPE_KPISchedulebatch3Adhoc() {
    
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
    
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.SchedulePeriod__c = Date.newInstance(2099, 07, 03);
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    
    
    insert KPI;
    
    //---update KPI--------
    
    KPI.ActualCalculation__c = 'A';
    KPI.LifecycleStage__c = 'Pilot';
    
    
    update KPI;
    
    //---KPI data ends----
    
    //-- PI definition data ---
    
   
   
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption******************//
    //PIDefObj.Name = 'Test PI Definition';
    PIDefObj.PI_Title__c = 'Test PI Definition';
    //**************End***************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    
    insert PIDefObj;
    
    //-----update PI Definition data ----
    
    PIDefObj.LifecycleStage__c= 'Published';
    
    
    update PIDefObj;
    
    //--- SPEKPIcalculation data------
        
    SPE_KPIcalculation__c KPIcalc1 = new SPE_KPIcalculation__c();
    KPIcalc1.PIDefination__c = PIDefObj.Id;
    KPIcalc1.TimeFrame__c = 1.0;
    KPIcalc1.KPIDefinition__c = KPI.Id;
    KPIcalc1.Aggregation__c = 'Sum';
    KPIcalc1.Index__c = 'A';
    KPIcalc1.Filter1__c = '1';
    KPIcalc1.Filter2__c = '1';
    KPIcalc1.Filter3__c = '1';
    KPIcalc1.Filter4__c = '1';
    KPIcalc1.Filter5__c = '1';
    KPIcalc1.Filter6__c = '1';
    KPIcalc1.Filter7__c = '1';
    KPIcalc1.Filter8__c = '1';
    KPIcalc1.Filter9__c = '1';
    KPIcalc1.Filter10__c = '1';
    
      
    
    insert KPIcalc1;

    
    SPEKPIBatchSize__c SPEBatchobj = new SPEKPIBatchSize__c();
    SPEBatchobj.Name = 'KPI Batch Size';
    SPEBatchobj.Size__c= 200;
    
    insert SPEBatchobj;
    
        test.startTest();
        
        SPE_KPISchedulebatch3Adhoc batchObj = new SPE_KPISchedulebatch3Adhoc(KPI.Id);
        Database.executeBatch(batchObj,200);
        SchedulableContext sc = null;
        batchObj.execute(sc);
        test.stopTest();
        
        List<Supplier_KPI_Calculation_Adhoc__c>  lstKPICalcadhoc = [SELECT KPI_Calculation__c,KPI__c,Name FROM Supplier_KPI_Calculation_Adhoc__c];
        system.assertEquals(lstKPICalcadhoc[0].KPI__c,KPI.Id);
        
        }
        
}