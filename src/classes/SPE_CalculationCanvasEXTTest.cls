@isTest(SeeAllData = False)

public class SPE_CalculationCanvasEXTTest{
    
  
    //-----CalList[k].PIDefination__c!= Null || CalList[k].PrevKPIDefination__c!=Null ) && calList[k].Aggregation__c == 'Constant'---
    
    static testmethod void testSPE_CalculationCanvasEXT1(){
    
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
   KPI.ActualCalculation__c = 'A';  


   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Constant'; // method 1
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    }

    //------f(CalList[k].Aggregation__c=='--None--' || CalList[k].Aggregation__c==' ' || CalList[k].Aggregation__c==Null){-------
    
     static testmethod void testSPE_CalculationCanvasEXT2(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = ''; //method 2
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    
    
    }
    
    //--------CalList[k].PrevKPIDefination__c!=Null && (calList[k].Aggregation__c == 'Min( Across Suppliers)' || calList[k].Aggregation__c == 'Max( Across Suppliers)' || calList[k].Aggregation__c == 'Avg( Across Suppliers)'))----------
    
     static testmethod void testSPE_CalculationCanvasEXT3(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = null;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Min( Across Suppliers)'; //method 3 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    //----if(CalList[k].PIDefination__c == null && CalList[k].PrevKPIDefination__c == null && calList[k].Aggregation__c != 'Constant' )
    
     static testmethod void testSPE_CalculationCanvasEXT4(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = null;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 4 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();
    
    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
     static testmethod void testSPE_CalculationCanvasEXT5(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = null;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 5
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT6(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = null;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 6
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c = :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT7(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 7 - indexname=null;
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }

    
    static testmethod void testSPE_CalculationCanvasEXT8(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
      KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Date';  //---------ValueType=='Date' and PIDefinition!= NULL---
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 8 - PIDefination__c!=Null
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; //IndexName!=Null
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    //------------test BUSCOPE,GEOSCOPE And Category Scope and PIDEFINITION!=NULL--------
    
    static testmethod void testSPE_CalculationCanvasEXT9(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Market Unit';
    KPI.BUScope__c = 'Business Unit';
    KPI.categoryscope__c = 'Category Area';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number'; 
    PIDefObj.GeoScope__c = 'All Markets';   
    PIDefObj.CategoryScope__c = 'All Categories';
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    
    
    static testmethod void testSPE_CalculationCanvasEXT10(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number'; 
    PIDefObj.GeoScope__c = 'All Markets';   
    PIDefObj.CategoryScope__c = 'All Categories';
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = null;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    //KPIcalc.IndexName__c = 'Test'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    //------------test UpdateKPI-----------
    
    static testmethod void testSPE_CalculationCanvasEXT11(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    KPI.CalculationFormula__c = 'sum';
    KPI.RPNExpression__c = 'A';

    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number'; 
    PIDefObj.GeoScope__c = 'All Markets';   
    PIDefObj.CategoryScope__c = 'All Categories';
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'A'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('RPN','A');
    ApexPages.currentPage().getParameters().put('ActualCalculation','sum');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.SaveRecords();
    calcObj.updateKPI();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT12(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    KPI.CalculationFormula__c = 'sum';
    KPI.RPNExpression__c = 'A,B,+';

    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number'; 
    PIDefObj.GeoScope__c = 'All Markets';   
    PIDefObj.CategoryScope__c = 'All Categories';
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'A'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('RPN','A');
    ApexPages.currentPage().getParameters().put('ActualCalculation','sum');
    
    
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.SaveRecords();
    calcObj.updateKPI();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c = :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT13(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    //PIDefObj.Max_Question_Score__c = 3.0;
    
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'A'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
        
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    PageReference p = calcObj.backToKPI();
    Integer I=2;
    Boolean bool = SPE_CalculationCanvasEXT.getPIDefinition(lstPIDefObj[0].Id,I);
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c = :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    //----- test valuetype=String ----
    
    static testmethod void testSPE_CalculationCanvasEXT14(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'String';  
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 8 - PIDefination__c!=Null
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; //IndexName!=Null
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    //calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c = :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT15(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'String';  
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; //method 8 - PIDefination__c!=Null
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; //IndexName!=Null
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    //calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    //  ----kpi.categoryscope__c =='Category Area' && (PI.CategoryScope__c == 'All Categories'---
    
    static testmethod void testSPE_CalculationCanvasEXT16(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Market Unit';
    KPI.BUScope__c = 'Business Unit';
    KPI.categoryscope__c = 'Category Area';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number'; 
    PIDefObj.GeoScope__c = 'All Markets';   
    PIDefObj.BUScope__c = 'Product';
    PIDefObj.CategoryScope__c = 'All Categories';
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
   
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c= :KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT17(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Market';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Number'; 
    PIDefObj.GeoScope__c = 'All Markets';   
    PIDefObj.BUScope__c = 'Product';
    PIDefObj.CategoryScope__c = 'Category';
    
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
   
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT18(){
        
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = null;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Constant'; 
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
   
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    
    static testmethod void testSPE_CalculationCanvasEXT19(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
  //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
   KPI.LifecycleStage__c = 'Pilot';
       
    update KPI;
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************/
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = null;
    KPIcalc.PrevKPIDefination__c = null;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Constant'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'A';
    KPIcalc.constantvalue__c = null;
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
   
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
    
    static testmethod void testSPE_CalculationCanvasEXT20(){
    
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
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;
    
    //----update KPI----
  KPI.ActualCalculation__c = 'A'; 
    KPI.LifecycleStage__c = 'Pilot';
           
    update KPI;
        
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //*************Changes for Encryption*************//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //************Changes End****************//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.ValuesType__c = 'Date';  //---------ValueType=='Date' and PIDefinition!= NULL---
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    for(Integer i=0;i<2;i++){
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = null;
    //KPIcalc.PrevKPIDefination__c = KPI.Id;
    KPIcalc.TimeFrame__c = 2.0;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c = 'Sum'; 
    KPIcalc.Index__c = 'A';
    KPIcalc.IndexName__c = 'Test'; //IndexName!=Null
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
    
    //-----KPI calc data ends----
    
    
    PageReference pageRef = Page.SPE_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    ApexPages.currentPage().getParameters().put('rowIndex','3');
    
    //----row index data------
    
    test.startTest();

    SPE_CalculationCanvasEXT calcObj = new SPE_CalculationCanvasEXT();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    
    test.stopTest();
    
    List<SPE_KPICalculation__c> testResult = [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                    Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPI.Id];
                
    system.assert(testResult!=null);
    
    
    }
  


}