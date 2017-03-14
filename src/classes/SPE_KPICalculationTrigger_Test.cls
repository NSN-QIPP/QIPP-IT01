@isTest(SeeAllData=False)
public class SPE_KPICalculationTrigger_Test{
    
    
    //--------Test method for object SPE_KPIDefinition__c-----------
    
    public static testmethod void testSPE_KPICalculationTrigger1(){
    
    test.startTest();
    
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

    SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
    
   //**********************Changes For Encryption******************//
    //kpiDefinition1.Name = 'Test KPI Definition 123';
    kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
   //**********************END******************//
    kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
    kpiDefinition1.Level__c = '1';
    kpiDefinition1.LifecycleStage__c = 'Draft';
    kpiDefinition1.Description__c = 'Test';
    kpiDefinition1.MissingDatalogic__c = 'Logic1';
    kpiDefinition1.OperationalType__c = 'Leading PI';
    kpiDefinition1.GeoScope__c = 'All Markets';
    kpiDefinition1.categoryscope__c = 'All Categories';
    kpiDefinition1.BUScope__c = 'All Products';
    kpiDefinition1.UoM__c = 'max';
    kpiDefinition1.Group1__c = 'Cost';
    kpiDefinition1.Group2__c = 'Hard';
    kpiDefinition1.Type__c = 'Operational';
    kpiDefinition1.FrequencyinMonth__c = '2';
    kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
    kpiDefinition1.VerNumber__c = 0;
    insert kpiDefinition1;
    
    
    SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
    kpidef.Master_KPI__c= kpiDefinition1.Id;
    kpidef.ActualCalculation__c= 'a';
    insert kpidef;
    
    /*kpidef.LifecycleStage__c = 'Published';
    update kpidef;*/
    
    //---KPI data ends---- 
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
  //**********************Changes For Encryption******************//  
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
  //**********************END******************//  
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //----add KPI Calculation -----  
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();

    for(Integer i=0;i<2;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
        //KPIcalc.PrevKPIDefination__c = kpidef.Id;
        KPIcalc.TimeFrame__c = 2.0;
        KPIcalc.KPIDefinition__c = kpidef.Id;
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
        KPIcalc.Filter9__c = '1';
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
    } 
    insert lstKPIcalc;
    
    for(Integer i=0;i<2;i++){
    lstKPIcalc[i].TimeFrame__c = 2.0;
    }
    update lstKPIcalc;
    
    SPE_KPIDefinition__c resultObj = [SELECT Id,LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
    system.assert(resultObj!=null);
                    
    test.stopTest();
    
    }
}