@isTest(SeeAllData = False)

public class SPE_PIValuesTriggerTest {
    static testmethod void testSPE_PIValuesTrigger() {
    
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
    
     //insert Account data
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
    
     //-- PI definition data ---
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //************************Changes For Encryption**************************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************************END**************************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.PIUploadDuedate__c = Date.newinstance(2020,6,15);  
    PIDefObj.GeoScope__c = 'Country';
    PIDefObj.CategoryScope__c = 'Category';
    PIDefObj.BUScope__c = 'Product';
    PIDefObj.ValuesType__c = 'Number';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //----update pi definition---
    for(Integer i=0;i<3;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //----SPE_KPIDefinition---
    
     SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
     KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    // KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.PI_Data__c = lstPIDefObj[0].Id;
    KPI.ScheduledDate__c = null;
    KPI.FrequencyinMonth__c = '';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    KPI.LifecycleStage__c = 'Draft';
    KPI.FrequencyinMonth__c=null;
    KPI.Buffer_Days__c =null;
    insert KPI;
    //---update KPI----
    
    KPI.LifecycleStage__c = 'Published';
       
    update KPI;
    
    //----KPI data ends----
    
    //--- project master data starts----
    
    SPE_ProjectMaster__c projMasterObj = new SPE_ProjectMaster__c();
    projMasterObj.Name = '8715';
    projMasterObj.Project__c = 'Telkomsel';
    
    insert projMasterObj;
    
    //----project master data ends ---
    
    //----- category master data preparation starts----
    
    SPE_CategoryMaster__c catMasterObj = new SPE_CategoryMaster__c();
    catMasterObj.Category__c = 'Facility Services';
    
    insert catMasterObj;
    
    //--- BU BL object data starts----
    
    SPE_BUBL__c BUBLobj = new SPE_BUBL__c();
    BUBLobj.Product__c = 'Spare Parts';
    
    insert BUBLobj;
    
    //----BU BL data ends-----
    
    //---- Region master data preparation starts----
    
    SPE_RegionMaster__c regMasterobj = new SPE_RegionMaster__c();
    regMasterobj.Country__c = 'India';
    insert regMasterobj;
    
    /*
    //-----PicklistDefaultValues----
    
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
    */
    
    //--- SPE_PIValues__c  data preparation----
   
    List<SPE_PIValues__c> lstPiValueObj = new List<SPE_PIValues__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Region__c = 'XYZ';
    piValueObj.Product__c = 'Spare Parts';
    piValueObj.Category__c = 'Facility Services';
    piValueObj.Project__c = 'Telkomsel';
    piValueObj.Country__c = 'India';
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
    
    lstPiValueObj.add(piValueObj);
    }
    try{
        insert lstPiValueObj;
    }
    Catch(Exception e){
    }
    
    test.stopTest();   
   
    List<SPE_KPIValue__c> lstKPIVal = [SELECT Product__c,Category__c,Country__c FROM SPE_KPIValue__c];
    
    //system.assert(lstKPIVal.SIZE()>0);
}


static testmethod void testSPE_PIValuesTrigger2() {
    
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
        
     //insert Account data
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
    
     //-- PI definition data ---
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //************************Changes For Encryption**************************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************************END**************************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.PIUploadDuedate__c = Date.newinstance(2020,6,15);  
    PIDefObj.GeoScope__c = 'Project';
    PIDefObj.CategoryScope__c = 'Category Group';
    PIDefObj.BUScope__c = 'Business Line';
    PIDefObj.ValuesType__c = 'Number';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    
    
    //----update pi definition---
    for(Integer i=0;i<3;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //----SPE_KPIDefinition---
    
     SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
     KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    // KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.PI_Data__c = lstPIDefObj[0].Id;
    KPI.ScheduledDate__c = null;
    KPI.FrequencyinMonth__c = '';
    KPI.GeoScope__c = 'Project';
    KPI.BUScope__c = 'Business Line';
    KPI.categoryscope__c = 'Category Group';
    KPI.LifecycleStage__c = 'Draft';
    KPI.FrequencyinMonth__c=null;
    KPI.Buffer_Days__c =null;
    insert KPI;
    //---update KPI----
    
    KPI.LifecycleStage__c = 'Published';
       
    update KPI;
    
    //----KPI data ends----
    
    //--- project master data starts----
    
    SPE_ProjectMaster__c projMasterObj = new SPE_ProjectMaster__c();
    projMasterObj.Name = '8715';
    projMasterObj.Project__c = 'Telkomsel';
    
    insert projMasterObj;
    
    //----project master data ends ---
    
    //----- category master data preparation starts----
    
    SPE_CategoryMaster__c catMasterObj = new SPE_CategoryMaster__c();
    catMasterObj.Category__c = 'Facility Services';
    
    insert catMasterObj;
    
    //--- BU BL object data starts----
    
    SPE_BUBL__c BUBLobj = new SPE_BUBL__c();
    BUBLobj.Product__c = 'Spare Parts';
    
    insert BUBLobj;
    
    //----BU BL data ends-----
    
    //---- Region master data preparation starts----
    
    SPE_RegionMaster__c regMasterobj = new SPE_RegionMaster__c();
    regMasterobj.Country__c = 'India';
    insert regMasterobj;
    
    /*
    //-----PicklistDefaultValues----
    
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
    */
    
    //--- SPE_PIValues__c  data preparation----
   
    List<SPE_PIValues__c> lstPiValueObj = new List<SPE_PIValues__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Region__c = 'XYZ';
    piValueObj.Product__c = 'Spare Parts';
    piValueObj.Category__c = 'Facility Services';
    piValueObj.Project__c = 'Telkomsel';
    piValueObj.Country__c = 'India';
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
    piValueObj.BusinessLine__c = 'Teth';
    piValueObj.CategoryGroup__c = 'cat group';
    
    lstPiValueObj.add(piValueObj);
    }
    try{
        insert lstPiValueObj;
        }
    Catch(Exception e){
    }
    test.stopTest();   
   
    List<SPE_KPIValue__c> lstKPIVal = [SELECT Product__c,Category__c,Country__c FROM SPE_KPIValue__c];
    
    //system.assert(lstKPIVal.SIZE()>0);
}


static testmethod void testSPE_PIValuesTrigger3() {
    
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
    
     //insert Account data
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
    
     //-- PI definition data ---
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //************************Changes For Encryption**************************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************************END**************************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.PIUploadDuedate__c = Date.newinstance(2020,6,15);  
    PIDefObj.GeoScope__c = 'Market Unit';
    PIDefObj.CategoryScope__c = 'Category Area';
    PIDefObj.BUScope__c = 'Business Unit';
    PIDefObj.ValuesType__c = 'Number';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    
    
    //----update pi definition---
    for(Integer i=0;i<3;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //----SPE_KPIDefinition---
    
     SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
     KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    // KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
    KPI.PI_Data__c = lstPIDefObj[0].Id;
    KPI.ScheduledDate__c = null;
    KPI.FrequencyinMonth__c = '';
    KPI.GeoScope__c = 'Market Unit';
    KPI.BUScope__c = 'Business Unit';
    KPI.categoryscope__c = 'Category Area';
    KPI.LifecycleStage__c = 'Draft';
    KPI.FrequencyinMonth__c=null;
    KPI.Buffer_Days__c =null;
    insert KPI;
    //---update KPI----
    
    KPI.LifecycleStage__c = 'Published';
       
    update KPI;
    
    //----KPI data ends----
    
    //--- project master data starts----
    
    SPE_ProjectMaster__c projMasterObj = new SPE_ProjectMaster__c();
    projMasterObj.Name = '8715';
    projMasterObj.Project__c = 'Telkomsel';
    projMasterObj.Market__c = 'XYZ';
    projMasterObj.MarketUnit__c = 'makt';
    
    insert projMasterObj;
    
    //----project master data ends ---
    
    //----- category master data preparation starts----
    
    SPE_CategoryMaster__c catMasterObj = new SPE_CategoryMaster__c();
    catMasterObj.Category__c = 'Facility Services';
    
    insert catMasterObj;
    
    //--- BU BL object data starts----
    
    SPE_BUBL__c BUBLobj = new SPE_BUBL__c();
    BUBLobj.Product__c = 'Spare Parts';
    BUBLobj.BusinessLine__c = 'Test Business';
    BUBLobj.BusinessUnit__c = 'Teth';
    
    insert BUBLobj;
    
    //----BU BL data ends-----
    
    //---- Region master data preparation starts----
    
    SPE_RegionMaster__c regMasterobj = new SPE_RegionMaster__c();
    regMasterobj.Country__c = 'India';
    insert regMasterobj;
    
    /*
    //-----PicklistDefaultValues----
    
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
    */
    
    //--- SPE_PIValues__c  data preparation----
   
    List<SPE_PIValues__c> lstPiValueObj = new List<SPE_PIValues__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Region__c = 'XYZ';
    piValueObj.Product__c = 'Spare Parts';
    piValueObj.Category__c = 'Facility Services';
    piValueObj.Project__c = 'Telkomsel';
    piValueObj.Country__c = 'India';
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
    piValueObj.BusinessUnit__c  = 'Teth';
    piValueObj.MarketUnit__c  = 'market';
    piValueObj.Cluster__c = 'cat area';
    piValueObj.SubRegion__c = 'makt';
    piValueObj.BusinessLine__c = 'Test Business';
    lstPiValueObj.add(piValueObj);
    }
    try{
        insert lstPiValueObj;
    }
    Catch(Exception e){
    }
   
    test.stopTest();   
   
    List<SPE_KPIValue__c> lstKPIVal = [SELECT Product__c,Category__c,Country__c FROM SPE_KPIValue__c];
    
    //system.assert(lstKPIVal.SIZE()>0);
}

static testmethod void testSPE_PIValuesTrigger4() {
    
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
    
     //insert Account data
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
    
     //-- PI definition data ---
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //************************Changes For Encryption**************************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************************END**************************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.PIUploadDuedate__c = Date.newinstance(2020,6,15);  
    PIDefObj.GeoScope__c = 'Project';
    PIDefObj.CategoryScope__c = 'Category';
    PIDefObj.BUScope__c = 'Product';
    PIDefObj.ValuesType__c = 'Number';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
 
    //----update pi definition---
    for(Integer i=0;i<3;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    
    //--- project master data starts----
    
    SPE_ProjectMaster__c projMasterObj = new SPE_ProjectMaster__c();
    projMasterObj.Name = '8715';
    
    insert projMasterObj;
    
    //----project master data ends ---
    
    //----- category master data preparation starts----
    
    SPE_CategoryMaster__c catMasterObj = new SPE_CategoryMaster__c();
    catMasterObj.Category__c = 'Facility Services';
    
    insert catMasterObj;
    
    //--- BU BL object data starts----
    
    SPE_BUBL__c BUBLobj = new SPE_BUBL__c();
    BUBLobj.Product__c = 'Spare Parts';
    BUBLobj.BusinessLine__c = 'Test Business';
    BUBLobj.BusinessUnit__c = 'Teth';
    
    insert BUBLobj;
    
    //----BU BL data ends-----
    
    //---- Region master data preparation starts----
    
    SPE_RegionMaster__c regMasterobj = new SPE_RegionMaster__c();
    regMasterobj.Country__c = 'India';
    insert regMasterobj;
    
    /*
    //-----PicklistDefaultValues----
    
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
    */
    
    //--- SPE_PIValues__c  data preparation----
   
    List<SPE_PIValues__c> lstPiValueObj = new List<SPE_PIValues__c>();
    
    for(Integer i=0;i<3;i++){
    SPE_PIValues__c piValueObj = new SPE_PIValues__c();
    piValueObj = SPE_TestObjectCreator.CreatePIValues(lstPIDefObj[i].Id,lstAcc[0].Id,lstAcc[0].EnterpriseId__c);
    piValueObj.Region__c = 'XYZ';
    piValueObj.Product__c = 'Spare Parts';
    piValueObj.Category__c = 'Facility Services';
    piValueObj.Project__c = 'Telkomsel';
    piValueObj.Country__c = 'India';
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
    piValueObj.BusinessUnit__c  = 'Teth';
    piValueObj.MarketUnit__c  = 'market';
    piValueObj.Cluster__c = 'cat area';
    piValueObj.SubRegion__c = 'makt';
    piValueObj.BusinessLine__c = 'Test Business';
    lstPiValueObj.add(piValueObj);
    }
    try{
    insert lstPiValueObj;
        }
    Catch(Exception e){
    }
    //----SPE_KPIDefinition---
    List<SPE_KPIDefinition__c> kplist = new List<SPE_KPIDefinition__c>();
    
    for(Integer i=0;i<3;i++)
    {
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        // KPI.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
        KPI.PI_Data__c = lstPIDefObj[i].Id;
        KPI.ScheduledDate__c = null;
        KPI.FrequencyinMonth__c = '';
        KPI.GeoScope__c = 'Market';
        KPI.BUScope__c = 'Business Unit';
        KPI.categoryscope__c = 'Category Area';
        KPI.LifecycleStage__c = 'Draft';
        KPI.FrequencyinMonth__c=null;
        KPI.Buffer_Days__c =null;
        kplist.add(KPI);
    }
    
    insert kplist;
    
    //---update KPI----
    for(Integer i=0;i<3;i++)
    {
        kplist[i].LifecycleStage__c = 'Published';
    } 
    
    update kplist;
    
    //----KPI data ends----
    
 
    test.stopTest();   
   
    List<SPE_KPIValue__c> lstKPIVal = [SELECT Product__c,Category__c,Country__c FROM SPE_KPIValue__c];
    
    //system.assert(lstKPIVal.SIZE()>0);
   // SPE_PIValuesTrigger piTrigger = new SPE_PIValuesTrigger();
    SPE_PIValuesTrigger.createKPIValues(lstPiValueObj);
}


}