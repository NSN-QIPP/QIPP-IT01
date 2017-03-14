@isTest(SeeAllData=False)
public class SPE_updateKPIVersions_Test{
    
    public static testmethod void testSPE_updateKPIVersions1(){
    
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
    
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    
    //for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
     //**********************Changes For Encryption***********************//   
        //PIDefObj.Name = 'Test PI Definition'+i;
        PIDefObj.PI_Title__c = 'Test PI Definition';
     //**********************END***********************//   
        
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
        insert PIDefObj;
        //lstPIDefObj.add(PIDefObj);
    //}
    //insert lstPIDefObj;
    
    /*update lifecycle stage
    
    for(Integer i=0;i<1;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;*/
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    //-----KPI data-----------
    
    SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
    
    //**********************Changes For Encryption***********************//
        //kpiDefinition1.Name = 'Test KPI Definition 1236';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
    //**********************END***********************//    
        
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Published';
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
        kpiDefinition1.FrequencyinMonth__c='1';
        kpiDefinition1.Buffer_Days__c =1;
        kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
        kpiDefinition1.VerNumber__c = 1;
    insert kpiDefinition1;
    
    SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.ActualCalculation__c= 'a';
        kpidef.Master_KPI__c= kpiDefinition1.Id;
        kpidef.ScheduledDate__c = null;
        kpidef.FrequencyinMonth__c=null;
        kpidef.Buffer_Days__c =null;
        kpidef.PI_Data__c = PIDefObj.Id;
        kpidef.VerNumber__c = 1;
    
    insert kpidef;
    
    /*SPE_KPIDefinition__c kpidef2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpidef2.ActualCalculation__c= 'a2';
        //kpidef2.Master_KPI__c= kpidef.Id;
        kpidef2.ScheduledDate__c = null;
        kpidef2.FrequencyinMonth__c = null;
        kpidef2.PI_Data__c = PIDefObj.Id;
        kpidef2.VerNumber__c = 2;
    
    insert kpidef2;
    
    SPE_KPIDefinition__c kpidef3 = SPE_TestObjectCreator.CreateKPIDefinition(3);
        kpidef3.ActualCalculation__c= 'a3';
        kpidef3.Master_KPI__c= kpidef2.Id;
        kpidef3.ScheduledDate__c = null;
        kpidef3.FrequencyinMonth__c = null;
        kpidef3.PI_Data__c = PIDefObj.Id;
        kpidef3.VerNumber__c = 3;
    
    insert kpidef3;*/
    
    kpidef.LifecycleStage__c = 'Published';
    update kpidef;
    
    //kpidef2.LifecycleStage__c = 'Published';
    //update kpidef2;
    
    //kpidef3.LifecycleStage__c = 'Published';
    //update kpidef3;
    

    //---KPI data ends----
    
    
    //----add KPI Calculation -----
    
    /*List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();

    for(Integer i=0;i<1;i++){
        SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.PIDefination__c = PIDefObj.Id;
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
    
    insert lstKPIcalc;*/
    
    SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Published';
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        speTemp.BusinessLine__c ='All Business Units';
        speTemp.BusinessUnit__c ='All Business Lines';
        speTemp.Product__c = 'All Products';   
    insert speTemp;
    
    speTemp.Stage__c ='Published';
    //update speTemp;
    
    SPE_ScoringTemplate__c scoringTemplate = new SPE_ScoringTemplate__c();
        scoringTemplate.Name = 'Demo scoring Template';
        scoringTemplate.SPETemplate__c = speTemp.Id;
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        speTemp.BusinessLine__c ='All Business Units';
        speTemp.BusinessUnit__c ='All Business Lines';
        speTemp.Product__c = 'All Products';
        speTemp.Stage__c ='Published';
    
    insert scoringTemplate;
    
    
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();   
    spekpi.KPIDefinition__c = kpiDef.Id;
    spekpi.SPETemplate__c = speTemp.Id;
    spekpi.Weight__c = 100;
    spekpi.UseLatestKPIVersion__c = true;
    insert spekpi;
    
    SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = spekpi.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = scoringTemplate.Id;
    insert sc;
    
    test.stopTest();
    
    }
        public static testmethod void testSPE_updateKPIVersions2(){
    
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
    
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();   
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    PIDefObj.PI_Title__c = 'Test PI Definition';        
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
    insert PIDefObj; 
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    //-----KPI data-----------   
    
    SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
    kpidef.KPI_Title__c ='MyKPI1234';
    kpidef.AbbreviatedName__c ='kpi12';
    kpidef.ActualCalculation__c= 'a';
   // kpidef.Master_KPI__c= null;
    kpidef.PI_Data__c = PIDefObj.Id;
    kpidef.VerNumber__c = 1;    
    kpidef.GeoScope__c = 'All Markets';
    kpidef.categoryscope__c = 'All Categories';
    kpidef.BUScope__c = 'All Products';
    kpidef.UoM__c = 'max';
    kpidef.Group1__c = 'Cost';
    kpidef.Group2__c = 'Hard';
    kpidef.Type__c = 'Operational';
    kpidef.FrequencyinMonth__c=null;
    kpidef.Buffer_Days__c =null;
    kpidef.ScheduledDate__c = system.today().addDays(20);
    insert kpidef;   
    kpidef.LifecycleStage__c = 'Pilot';
    update kpidef;
    
    SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
    speTemp.Name = 'Test SPE TEmplate 123';
    speTemp.Stage__c = 'Published';
    speTemp.Region__c = 'All Markets';
    speTemp.SubRegion__c = 'All Market Units';
    speTemp.Country__c = 'All Countries';
    speTemp.Project__c = 'All Projects';
    speTemp.CategoryCluster__c = 'All Category Areas';
    speTemp.CategoryGroup__c = 'All Category Groups';
    speTemp.Category__c = 'All Categories';
    speTemp.BusinessLine__c ='All Business Units';
    speTemp.BusinessUnit__c ='All Business Lines';
    speTemp.Product__c = 'All Products';   
    insert speTemp;
    
    speTemp.Stage__c ='Published';
    //update speTemp;
    
    SPE_ScoringTemplate__c scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate.Name = 'Demo scoring Template';
    scoringTemplate.SPETemplate__c = speTemp.Id;
    speTemp.Region__c = 'All Markets';
    speTemp.SubRegion__c = 'All Market Units';
    speTemp.Country__c = 'All Countries';
    speTemp.Project__c = 'All Projects';
    speTemp.CategoryCluster__c = 'All Category Areas';
    speTemp.CategoryGroup__c = 'All Category Groups';
    speTemp.Category__c = 'All Categories';
    speTemp.BusinessLine__c ='All Business Units';
    speTemp.BusinessUnit__c ='All Business Lines';
    speTemp.Product__c = 'All Products';
    speTemp.Stage__c ='Published';  
    insert scoringTemplate;
    
    
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();   
    spekpi.KPIDefinition__c = kpiDef.Id;
    spekpi.SPETemplate__c = speTemp.Id;
    spekpi.Weight__c = 100;
    spekpi.UseLatestKPIVersion__c = true;
    insert spekpi;
    
    SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
    sc.KPIDefinition__c = spekpi.KPIDefinition__c;
    sc.Score__c = 1;
    sc.Lower__c = 0;
    sc.LowerTo__c = '>';
    sc.Upper__c = 50;
    sc.UpperTo__c = '<';
    sc.ScoringTemplate__c = scoringTemplate.Id;
    insert sc;
    
    test.stopTest();
    
    }
    
    
}