@isTest(seeAllData = False)
 private class SPE2_CalculationCanvasEXTTest{
 static testmethod void SPE2_CalculationCanvasEXTmethod1(){
    
    
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
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
    calcObj.showPopup();
    string index = 'a';
    SPE2_CalculationCanvasEXT.formulaWrapper formWrap = new  SPE2_CalculationCanvasEXT.formulaWrapper(index);
    formWrap.getOperators();
    test.stopTest();

    } 
    
static testmethod void SPE2_CalculationCanvasEXTmethod2(){
    
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
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;   PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('RPN','a b');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','1');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT(st);
    SPE2_CalculationCanvasEXT  cal = new SPE2_CalculationCanvasEXT();
   // SPE2_CalculationCanvasEXT.formulaWrapper.Operators();
    calcObj.displayFormula();
    calcObj.updateKPI();
    //calcObj.SaveRecords();
    SPE2_CalculationCanvasEXT.getPIDefinition(lstPIDefObj[0].id,1);
    test.stopTest();
    } 
    
   static testmethod void SPE2_CalculationCanvasEXTmethod3(){
    
    
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
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    //pageRef.getParameters().put('rowIndex','1');
    //pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','0');
    pageRef.getParameters().put('inputConNum','0');
    pageRef.getParameters().put('conNum','0');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','1');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
    calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
   // calcObj.showPopup();  
    test.stopTest();

    } 
 static testmethod void SPE2_CalculationCanvasEXTmethod4(){
    
    
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
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
    
      SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
        KPIcalc.ConstantValue__c=1;
        KPIcalc.TimeFrame__c = 1.0;
        KPIcalc.Aggregation__c ='Constant';
        KPIcalc.Index__c = 'A';
        KPIcalc.IndexName__c='Test Index';
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
    KPIcalc.KPIDefinition__c = KPI.Id;

    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
    calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
    calcObj.showPopup();  
    test.stopTest();

    } 
 static testmethod void SPE2_CalculationCanvasEXTmethod5(){
    
    
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
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
   // KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    insert KPIcalc ;
    KPIcalc.Aggregation__c= 'Constant';
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
    calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
    calcObj.showPopup();  
    test.stopTest();

    } 
 static testmethod void SPE2_CalculationCanvasEXTmethod6(){
    
    
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
   KPI.Aggregation__c = 'Constant';
   KPI.LifecycleStage__c = 'Pilot';       
   update KPI;
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
   SPE_KPIDefinition__c KPI2 = new SPE_KPIDefinition__c();
    KPI2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
    KPI2.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI2.FrequencyinMonth__c = '1';
    KPI2.GeoScope__c = 'Country';
    KPI2.BUScope__c = 'Product';
    KPI2.categoryscope__c = 'Category';
    insert KPI2;    
  //----update KPI----
   KPI2.ActualCalculation__c = 'A';  
   KPI2.LifecycleStage__c = 'Pilot';       
   update KPI2;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
   // KPIcalc.PrevKPIDefination__c= KPI.Id;
    insert KPIcalc;
    KPIcalc.TimeFrame__c= null;
    update KPIcalc;
    KPIcalcList.add(KPIcalc);
   
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
    calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
    calcObj.showPopup();  
    test.stopTest();

    } 
  static testmethod void SPE2_CalculationCanvasEXTmethod7(){
    
    
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
   KPI.Aggregation__c = 'Constant';
   KPI.LifecycleStage__c = 'Pilot';       
   update KPI;
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
   SPE_KPIDefinition__c KPI2 = new SPE_KPIDefinition__c();
    KPI2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
    KPI2.ScheduledDate__c = Date.newInstance(2099, 07, 03); 
    KPI2.FrequencyinMonth__c = '1';
    KPI2.GeoScope__c = 'Country';
    KPI2.BUScope__c = 'Product';
    KPI2.categoryscope__c = 'Category';
    insert KPI2;    
  //----update KPI----
   KPI2.ActualCalculation__c = 'A';  
   KPI2.LifecycleStage__c = 'Pilot';       
   update KPI2;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
   // KPIcalc.PrevKPIDefination__c= KPI.Id;
    insert KPIcalc;
    KPIcalc.TimeFrame__c= null;
    update KPIcalc;
    KPIcalcList.add(KPIcalc);
   
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
   // calcObj.addMoreConditions();
  //  calcObj.removeConditions();
   // calcObj.updateKPI();
  //  calcObj.updateIfElse();
 //   calcObj.backToKPI();
  //  calcObj.closePopup();
  //  calcObj.showPopup();  
    test.stopTest();

    }  
static testmethod void SPE2_CalculationCanvasEXTmethod8(){
    
    
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
    
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'All Markets';
    KPI.BUScope__c = 'All Products';
    KPI.categoryscope__c = 'All Categories';
    KPI.Aggregation__c ='AVG';
    KPI.Category__c = 'All Categories';
    KPI.Group1__c='Quality';
    KPI.KPI_Title__c= 'test Kpi1';
    KPI.LifecycleStage__c = 'Draft';
    KPI.ScheduledDate__c= Date.newinstance(2017,6,1);
    KPI.UoM__c = 'Number';
    insert KPI;    
  
   SPE_KPIDefinition__c KPI2 = new SPE_KPIDefinition__c();
    
    KPI2.FrequencyinMonth__c = '1';
    KPI2.GeoScope__c = 'All Markets';
    KPI2.BUScope__c = 'All Products';
    KPI2.categoryscope__c = 'All Categories';
    KPI2.Aggregation__c ='AVG';
    KPI2.Category__c = 'All Categories';
    KPI2.Group1__c='Quality';
    KPI2.KPI_Title__c= 'test Kpi11';
    KPI2.LifecycleStage__c = 'Pilot';
    KPI2.ScheduledDate__c=  Date.newinstance(2017,5,31);
    KPI2.UoM__c = 'Number';
    KPI2.ActualCalculation__c ='A';
    insert KPI2;    
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    //KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc.Aggregation__c= 'Min';
    KPIcalc.Index__c= 'A';
    KPIcalc.IndexName__c='A';
    KPIcalc.TimeFrame__c= 1;
    
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A;2;+';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c= KPI.ID+';'+'Condition 1';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
  /*  calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
    calcObj.showPopup(); */ 
    test.stopTest();

    } 
    
 static testmethod void SPE2_CalculationCanvasEXTmethod9(){
 
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
    
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'All Markets';
    KPI.BUScope__c = 'All Products';
    KPI.categoryscope__c = 'All Categories';
    KPI.Aggregation__c ='AVG';
    KPI.Category__c = 'All Categories';
    KPI.Group1__c='Quality';
    KPI.KPI_Title__c= 'test Kpi1';
    KPI.LifecycleStage__c = 'Pilot';
    KPI.Level__c = '1;2';
    KPI.MissingDatalogic__c ='Past Data or Category Average';
    KPI.AbbreviatedName__c = 'abbr1';
    KPI.ScheduledDate__c= Date.newinstance(2017,6,1);
    KPI.UoM__c = 'Number';
    insert KPI;    
  
   SPE_KPIDefinition__c KPI2 = new SPE_KPIDefinition__c();
    
    KPI2.FrequencyinMonth__c = '1';
    KPI2.GeoScope__c = 'All Markets';
    KPI2.BUScope__c = 'All Products';
    KPI2.categoryscope__c = 'All Categories';
    KPI2.Aggregation__c ='AVG';
    KPI2.Category__c = 'All Categories';
    KPI2.Group1__c='Quality';
    KPI2.KPI_Title__c= 'test Kpi11';
    KPI2.LifecycleStage__c = 'Pilot';
    KPI2.ScheduledDate__c=  Date.newinstance(2017,5,31);
    KPI2.UoM__c = 'Number';
    KPI2.ActualCalculation__c ='A';
    KPI2.Level__c = '1;2';
    KPI2.MissingDatalogic__c ='Past Data or Category Average';
    KPI2.AbbreviatedName__c = 'abbr2';
    insert KPI2;    
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc2 = new SPE_KPICalculation__c();
    KPIcalc2.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc2.KPIDefinition__c = KPI2.Id;
   // KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc2.Aggregation__c= 'Min';
    KPIcalc2.Index__c= 'A';
    KPIcalc2.IndexName__c='A';
    KPIcalc2.TimeFrame__c= 1;
    
    insert KPIcalc2 ;
    
     List<KPI_Calculation_Formula__c> KPCalFormulaList2 = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula2 = new KPI_Calculation_Formula__c();
    KPFormula2.Name= 'kpformula'+i;
    KPFormula2.KPI__c= KPI2.ID;
    KPFormula2.KPI_Expression__c='A;2;+';
    KPFormula2.KPI_Formula__c ='A+2';
    KPFormula2.KPI_External_Id__c= KPI2.ID+';'+'Condition 1';
    KPCalFormulaList2.add(KPFormula2);
   }
   insert KPCalFormulaList2;
     
    KPI_Calulation_Condition__c KPICondition2 = new KPI_Calulation_Condition__c();
    KPICondition2.Formula__c= KPCalFormulaList2[0].id;
    KPICondition2.Index_Label__c= 'A';
    KPICondition2.Operator__c= 'Not Null';
    insert KPICondition2;
    
    KPI2.LifecycleStage__c = 'Published';
    update KPI2;
           
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI2.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI2); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
  
    
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
  //  KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc.Aggregation__c= 'Min';
    KPIcalc.Index__c= 'A';
    KPIcalc.IndexName__c='A';
    KPIcalc.TimeFrame__c= 1;
    
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A;2;+';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c= KPI.ID+';'+'Condition 1';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
   ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');  
    
     ApexPages.Standardcontroller st2 =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj2 = new SPE2_CalculationCanvasEXT();
    calcObj2.conditionId= 0;
    //calcObj.allowInput();
    calcObj2.addRecords();
   // calcObj.RemoveRecords();
    calcObj2.SaveRecords();
    test.stopTest();

 } 
  static testmethod void SPE2_CalculationCanvasEXTmethod10(){
 
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
    
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'All Markets';
    KPI.BUScope__c = 'All Products';
    KPI.categoryscope__c = 'All Categories';
    KPI.Aggregation__c ='AVG';
    KPI.Category__c = 'All Categories';
    KPI.Group1__c='Quality';
    KPI.KPI_Title__c= 'test Kpi1';
    KPI.LifecycleStage__c = 'Pilot';
    KPI.Level__c = '1;2';
    KPI.MissingDatalogic__c ='Past Data or Category Average';
    KPI.AbbreviatedName__c = 'abbr1';
    KPI.ScheduledDate__c= Date.newinstance(2017,6,1);
    KPI.UoM__c = 'Number';
    insert KPI;    
  
   SPE_KPIDefinition__c KPI2 = new SPE_KPIDefinition__c();
    
    KPI2.FrequencyinMonth__c = '1';
    KPI2.GeoScope__c = 'All Markets';
    KPI2.BUScope__c = 'All Products';
    KPI2.categoryscope__c = 'All Categories';
    KPI2.Aggregation__c ='AVG';
    KPI2.Category__c = 'All Categories';
    KPI2.Group1__c='Quality';
    KPI2.KPI_Title__c= 'test Kpi11';
    KPI2.LifecycleStage__c = 'Pilot';
    KPI2.ScheduledDate__c=  Date.newinstance(2017,5,31);
    KPI2.UoM__c = 'Number';
    KPI2.ActualCalculation__c ='A';
    KPI2.Level__c = '1;2';
    KPI2.MissingDatalogic__c ='Past Data or Category Average';
    KPI2.AbbreviatedName__c = 'abbr2';
    insert KPI2;    
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc2 = new SPE_KPICalculation__c();
    KPIcalc2.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc2.KPIDefinition__c = KPI2.Id;
   // KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc2.Aggregation__c= 'Min( Across Suppliers)';
    KPIcalc2.Index__c= 'A';
    KPIcalc2.IndexName__c='A';
    KPIcalc2.TimeFrame__c= 1;
    
    insert KPIcalc2 ;
    
     List<KPI_Calculation_Formula__c> KPCalFormulaList2 = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula2 = new KPI_Calculation_Formula__c();
    KPFormula2.Name= 'kpformula'+i;
    KPFormula2.KPI__c= KPI2.ID;
    KPFormula2.KPI_Expression__c='A;2;+';
    KPFormula2.KPI_Formula__c ='A+2';
    KPFormula2.KPI_External_Id__c= KPI2.ID+';'+'Condition 1';
    KPCalFormulaList2.add(KPFormula2);
   }
   insert KPCalFormulaList2;
     
    KPI_Calulation_Condition__c KPICondition2 = new KPI_Calulation_Condition__c();
    KPICondition2.Formula__c= KPCalFormulaList2[0].id;
    KPICondition2.Index_Label__c= 'A';
    KPICondition2.Operator__c= 'Not Null';
    insert KPICondition2;
    
    KPI2.LifecycleStage__c = 'Published';
    update KPI2;
           
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI2.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI2); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
  
    
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
  //  KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc.Aggregation__c= 'Min( Across Suppliers)';
    KPIcalc.Index__c= 'A';
    KPIcalc.IndexName__c='A';
    KPIcalc.TimeFrame__c= 1;
    
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A;2;+';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c= KPI.ID+';'+'Condition 1';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
   ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');  
    
     ApexPages.Standardcontroller st2 =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj2 = new SPE2_CalculationCanvasEXT();
    calcObj2.conditionId= 0;
    //calcObj.allowInput();
    calcObj2.addRecords();
   // calcObj.RemoveRecords();
    calcObj2.SaveRecords();
    test.stopTest();

 } 
static testmethod void SPE2_CalculationCanvasEXTmethod11(){
 
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
    
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'All Markets';
    KPI.BUScope__c = 'All Products';
    KPI.categoryscope__c = 'All Categories';
    KPI.Aggregation__c ='AVG';
    KPI.Category__c = 'All Categories';
    KPI.Group1__c='Quality';
    KPI.KPI_Title__c= 'test Kpi1';
    KPI.LifecycleStage__c = 'Pilot';
    KPI.Level__c = '1;2';
    KPI.MissingDatalogic__c ='Past Data or Category Average';
    KPI.AbbreviatedName__c = 'abbr1';
    KPI.ScheduledDate__c= Date.newinstance(2017,6,1);
    KPI.UoM__c = 'Number';
    insert KPI;    
  
   SPE_KPIDefinition__c KPI2 = new SPE_KPIDefinition__c();
    
    KPI2.FrequencyinMonth__c = '1';
    KPI2.GeoScope__c = 'All Markets';
    KPI2.BUScope__c = 'All Products';
    KPI2.categoryscope__c = 'All Categories';
    KPI2.Aggregation__c ='AVG';
    KPI2.Category__c = 'All Categories';
    KPI2.Group1__c='Quality';
    KPI2.KPI_Title__c= 'test Kpi11';
    KPI2.LifecycleStage__c = 'Pilot';
    KPI2.ScheduledDate__c=  Date.newinstance(2017,5,31);
    KPI2.UoM__c = 'Number';
    KPI2.ActualCalculation__c ='A';
    KPI2.Level__c = '1;2';
    KPI2.MissingDatalogic__c ='Past Data or Category Average';
    KPI2.AbbreviatedName__c = 'abbr2';
    insert KPI2;    
    
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Published';
    lstPIDefObj[i].ValuesType__c= 'Date';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc2 = new SPE_KPICalculation__c();
    KPIcalc2.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc2.KPIDefinition__c = KPI2.Id;
   // KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc2.Aggregation__c=  'Avg( Across Suppliers)';
    KPIcalc2.Index__c= null;
    KPIcalc2.IndexName__c=null;
    KPIcalc2.TimeFrame__c= null;
    
    insert KPIcalc2 ;
    
     List<KPI_Calculation_Formula__c> KPCalFormulaList2 = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula2 = new KPI_Calculation_Formula__c();
    KPFormula2.Name= 'kpformula'+i;
    KPFormula2.KPI__c= KPI2.ID;
    KPFormula2.KPI_Expression__c='A;2;+';
    KPFormula2.KPI_Formula__c ='A+2';
    KPFormula2.KPI_External_Id__c= KPI2.ID+';'+'Condition 1';
    KPCalFormulaList2.add(KPFormula2);
   }
   insert KPCalFormulaList2;
     
    KPI_Calulation_Condition__c KPICondition2 = new KPI_Calulation_Condition__c();
    KPICondition2.Formula__c= KPCalFormulaList2[0].id;
    KPICondition2.Index_Label__c= 'A';
    KPICondition2.Operator__c= 'Not Null';
    insert KPICondition2;
    
    KPI2.LifecycleStage__c = 'Published';
    update KPI2;
           
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI2.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI2); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
   // calcObj.RemoveRecords();
    calcObj.SaveRecords();
  
    
    
    SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
  //  KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.PrevKPIDefination__c = KPI2.Id;
    KPIcalc.Aggregation__c=  'Avg( Across Suppliers)';
    KPIcalc.Index__c= null;
    KPIcalc.IndexName__c=null;
    KPIcalc.TimeFrame__c= null;
    
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A;2;+';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c= KPI.ID+';'+'Condition 1';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
   ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');  
    
     ApexPages.Standardcontroller st2 =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj2 = new SPE2_CalculationCanvasEXT();
    calcObj2.conditionId= 0;
    //calcObj.allowInput();
    calcObj2.addRecords();
   // calcObj.RemoveRecords();
    calcObj2.SaveRecords();
    test.stopTest();

 }     
 static testmethod void SPE2_CalculationCanvasEXTmethod12(){
    
    
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
  // KPI.LifecycleStage__c = 'Published';
  // update KPI;
   
    //-----KPI data ends----
    
     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    //---------------Changes for Encryption---------------------------------//
    //PIDefObj.Name = 'Test PI Definition'+i;
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
    //------------------Changes End---------------------------------//
    
    PIDefObj.LifecycleStage__c = 'Draft';
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    lstPIDefObj[i].ValuesType__c='Date';
    }
    
    update lstPIDefObj;
    
    //-----pi definition data ends----
    
    //--- KPI calculation data preparation starts ---
    
    
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();
      
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c='Sum';
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);
    //-----KPI calc data ends----
    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'kpformula'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A+2';
    KPFormula.KPI_Formula__c ='A+2';
    KPFormula.KPI_External_Id__c='abcd';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Index_Label__c= 'A';
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= 'Not Null';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
    pageRef.getParameters().put('rowIndex','1');
    pageRef.getParameters().put('conIndex','1');
    pageRef.getParameters().put('inputRowNum','1');
    pageRef.getParameters().put('inputConNum','1');
    pageRef.getParameters().put('conNum','1');
    pageRef.getParameters().put('ActualCalculation','A');
    pageRef.getParameters().put('r1','a');
    pageRef.getParameters().put('r2','b');
    pageRef.getParameters().put('r3','c');
    pageRef.getParameters().put('r1Exp','x');
    pageRef.getParameters().put('r2Exp','y');
    pageRef.getParameters().put('r3Exp','z');
    pageRef.getParameters().put('conditionId','0');
    pageRef.getParameters().put('RPN','a b');
    
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.conditionId= 0;
    //calcObj.allowInput();
    calcObj.addRecords();
    calcObj.RemoveRecords();
    calcObj.SaveRecords();
    calcObj.addMoreConditions();
    calcObj.removeConditions();
    calcObj.updateKPI();
    calcObj.updateIfElse();
    calcObj.backToKPI();
    calcObj.closePopup();
    calcObj.showPopup();
    string index = 'a';
    SPE2_CalculationCanvasEXT.formulaWrapper formWrap = new  SPE2_CalculationCanvasEXT.formulaWrapper(index);
    formWrap.getOperators();
    test.stopTest();    
    }
 static testmethod void SPE2_CalculationCanvasEXTmethodtest13(){
    
    
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
        
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
    
    //--- KPI data------
    SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
    KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
    KPI.ScheduledDate__c = Date.newInstance(2016,07,03); 
    KPI.FrequencyinMonth__c = '1';
    KPI.GeoScope__c = 'Country';
    KPI.BUScope__c = 'Product';
    KPI.categoryscope__c = 'Category';
    insert KPI;    

   KPI.ActualCalculation__c = 'A';  
   KPI.LifecycleStage__c = 'Pilot';       
   update KPI;

    
    List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
    for(Integer i=0;i<2;i++){
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    PIDefObj.PI_Title__c = 'Test PI Definition'+i;    
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.GeoScope__c = 'Country';
    PIDefObj.CategoryScope__c = 'Category';
    PIDefObj.BUScope__c = 'Product';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,6,24); 
    lstPIDefObj.add(PIDefObj);
    }
    insert lstPIDefObj;
    
    //update lifecycle stage
    
    for(Integer i=0;i<2;i++){
    lstPIDefObj[i].LifecycleStage__c= 'Pilot';
    lstPIDefObj[i].ValuesType__c='Number';
    }
    
    update lstPIDefObj;
      
       
    List<SPE_KPICalculation__c> KPIcalcList = new  List<SPE_KPICalculation__c>();    
    SPE_KPICalculation__c KPIcalc = SPE_TestObjectCreator.createKPICalculation();
    //KPIcalc.PIDefination__c = lstPIDefObj[0].Id;
    KPIcalc.KPIDefinition__c = KPI.Id;
    KPIcalc.Aggregation__c='CONSTANT';
    KPIcalc.ConstantValue__c =100;
    insert KPIcalc ;
    KPIcalcList.add(KPIcalc);

    List<KPI_Calculation_Formula__c> KPCalFormulaList = new List<KPI_Calculation_Formula__c>();
    for (integer i=0;i<1;i++)
   { 
    KPI_Calculation_Formula__c KPFormula = new KPI_Calculation_Formula__c();
    KPFormula.Name= 'Condition 1'+i;
    KPFormula.KPI__c= KPI.ID;
    KPFormula.KPI_Expression__c='A';
    KPFormula.KPI_Formula__c ='A';
    KPCalFormulaList.add(KPFormula);
   }
   insert KPCalFormulaList;
    System.debug('list size'+ KPCalFormulaList.size() ); 
    
    KPI_Calulation_Condition__c KPICondition = new KPI_Calulation_Condition__c();
    KPICondition.Name ='A';
    KPICondition.Formula__c= KPCalFormulaList[0].id;
    KPICondition.Value__c= 1;
    KPICondition.Operator__c= '>';
    insert KPICondition;
    
    PageReference pageRef = Page.SPE2_CalculationCanvas;
    Test.setCurrentPage(pageRef);
    
    ApexPages.currentPage().getParameters().put('id',KPI.Id );
   
    pageRef.getParameters().put('conditionId','0');
    test.startTest();
    ApexPages.Standardcontroller st =new ApexPages.Standardcontroller(KPI); 
    SPE2_CalculationCanvasEXT calcObj = new SPE2_CalculationCanvasEXT();
    calcObj.SaveRecords();
    /*calcObj.addRecords();
    
    calcObj.showPopup();
    string index = 'a';
    SPE2_CalculationCanvasEXT.formulaWrapper formWrap = new  SPE2_CalculationCanvasEXT.formulaWrapper(index);
    formWrap.getOperators();*/
    test.stopTest();    
    }
}