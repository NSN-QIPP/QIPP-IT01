@isTest(SeeAllData=False)
public class SPE_PIDefinition_Test{

public static testmethod void testSPE_PIDefinition1(){
    
    //---Custom Setting data ---
    List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<1;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
     //***************************Changes For Encryption***********************//   
        //PIDefObj.Name = 'Test PI Definition'+i;
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
     //***************************END***********************//   
        
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
        lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<1;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
    
  //***************************Changes For Encryption***********************//  
    //kpiDefinition1.Name = 'Test KPI Definition 1234';
    kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1234';
  //***************************END***********************//  
    
    kpiDefinition1.AbbreviatedName__c = 'TKPIDe2';
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
        kpidef.ActualCalculation__c= 'a';
        kpidef.Master_KPI__c= kpiDefinition1.Id;
        kpidef.ScheduledDate__c = null;
        kpidef.FrequencyinMonth__c = null;
        kpidef.PI_Data__c = lstPIDefObj[0].Id;
        kpidef.VerNumber__c = 1;
        kpidef.FrequencyinMonth__c=null;
        kpidef.Buffer_Days__c =null;
        insert kpidef;
    
    
    //---KPI data ends---- 
    
    kpidef.LifecycleStage__c = 'Published';
    //kpidef.PI_Data__c = lstPIDefObj[0].Id;
    update kpidef;
    
    //update lifecycle stage
    
    for(Integer i=0;i<1;i++){
    lstPIDefObj[i].OperationalType__c= 'Leading KPI';
    }
    
    update lstPIDefObj;
    
    //----add KPI Calculation -----  
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();

    for(Integer i=0;i<1;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
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
        KPIcalc.Filter10__c = '1';
        lstKPIcalc.add(KPIcalc);
    } 
    insert lstKPIcalc;
    
    test.startTest();
    
    try{
    
    SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
       
    ApexPages.StandardController ctlr = new ApexPages.StandardController(lstPIDefObj[0]);
    
    SPE_LifecycleEXT testObj = new SPE_LifecycleEXT(ctlr);
    PageReference p = testObj.StagePublished();
    ApexPages.currentPage().getParameters().put('msg','Complete  KPI before Publishing'); 
    testObj.StagePilot();
    testObj.StageObsolete();
    testObj.StageDelete();
    testObj.executeTestBatch();
    
    }catch(Exception e){
        Boolean expectedExceptionThrown =  e.getMessage().contains('My Error Message') ? true : false;
    } 
    
    test.stopTest();
    
    }
    
}