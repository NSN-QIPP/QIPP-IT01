@isTest (seeAllData=false)
private class SPE2_NewKPIThresholdExtTest{
     static testMethod void createKPIThresholdPositive(){
         
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
        
       // PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        //SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);       
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.GeoScope__c ='All Markets';
        kpiDefinition1.CategoryScope__c ='All Categories';
        kpiDefinition1.BUScope__c ='All Products';
        kpiDefinition1.IsHighBetter__c = Boolean.ValueOf('True');        
        kpiDefinition1.KPI_Title__c = 'Atos_KPI_Test1';
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
        
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
       // update kpiDefinition1; 
      
        SPE2_KPI_Threshold__c kpiThreshold =new SPE2_KPI_Threshold__c();
        kpiThreshold.KPI_ID__c =kpiDefinition1.Id;
        kpiThreshold.Threshold_Title__c ='ABC Threshold';
        kpiThreshold.OwnerId =Userinfo.getUserId();
        kpiThreshold.High_Better__c =kpiDefinition1.IsHighBetter__c;
        insert kpiThreshold;

        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = kpiThreshold.KPI_ID__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.KPI_Threshold__c = kpiThreshold.Id;
        insert sc;                
        system.debug('sc ::'+sc);
        
        Test.StartTest();        
        ApexPages.StandardController st = new ApexPages.StandardController(kpiThreshold);             
        
        SPE2_NewKPIThresholdExt newkpiThreshold = new SPE2_NewKPIThresholdExt(st);
        SPE2_NewKPIThresholdExt.KPIRangeWrapper Wrapvar = new SPE2_NewKPIThresholdExt.KPIRangeWrapper(sc);
        PageReference pageRef = Page.SPE2_NewKPIThreshold;
        Test.setCurrentPage(pageRef);
        newkpiThreshold.enableattributesMap.put('Market',true);
        newkpiThreshold.enableattributesMap.put('Market Unit',true);
        newkpiThreshold.enableattributesMap.put('Country',true);
        newkpiThreshold.enableattributesMap.put('Project',true);
        newkpiThreshold.enableattributesMap.put('Category Area',true);
        newkpiThreshold.enableattributesMap.put('Category Group',true);
        newkpiThreshold.enableattributesMap.put('Category',true);
        newkpiThreshold.enableattributesMap.put('Business Unit',true);
        newkpiThreshold.enableattributesMap.put('Business Line',true);
        newkpiThreshold.enableattributesMap.put('Product',true);
        newkpiThreshold.save();
        pageRef.getParameters().put('isClone', '');       
        newkpiThreshold.getMarketValues();
        newkpiThreshold.getMarketUnitValues();
        newkpiThreshold.getCountryValues();
        newkpiThreshold.getProjectValues();
        newkpiThreshold.getBusinessUnitValues();
        newkpiThreshold.getBusinesLineValues();
        newkpiThreshold.getProductValues();
        newkpiThreshold.getCategoryAreaValues();
        newkpiThreshold.getCategoryGroupValues();
        newkpiThreshold.getCategoryValues();
        newkpiThreshold.StagePilot();
        newkpiThreshold.StagePublished();
        newkpiThreshold.StageObsolete();
        newkpiThreshold.populateAllValues();
       // newkpiThreshold.calculation();
        newkpiThreshold.validate();              
        newkpiThreshold.cloneFn();
        
        newkpiThreshold.cancel();
        newkpiThreshold.edi(); 
                        
        Test.StopTest();
     }
     static testMethod void createKPIThresholdPositive6(){
         
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
        
       // PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        //SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);       
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.GeoScope__c ='All Markets';
        kpiDefinition1.CategoryScope__c ='All Categories';
        kpiDefinition1.BUScope__c ='All Products';
        kpiDefinition1.IsHighBetter__c = Boolean.ValueOf('True');        
        kpiDefinition1.KPI_Title__c = 'Atos_KPI_Test1';
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
        
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
       // update kpiDefinition1; 
      
        SPE2_KPI_Threshold__c kpiThreshold =new SPE2_KPI_Threshold__c();
        kpiThreshold.KPI_ID__c =kpiDefinition1.Id;
        kpiThreshold.Threshold_Title__c ='ABC Threshold';
        kpiThreshold.OwnerId =Userinfo.getUserId();
        kpiThreshold.High_Better__c =kpiDefinition1.IsHighBetter__c;
        insert kpiThreshold;

        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = kpiThreshold.KPI_ID__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.KPI_Threshold__c = kpiThreshold.Id;
        insert sc;                
        system.debug('sc ::'+sc);
        
        Test.StartTest();        
        ApexPages.StandardController st = new ApexPages.StandardController(kpiThreshold);             
        
        SPE2_NewKPIThresholdExt newkpiThreshold = new SPE2_NewKPIThresholdExt(st);
        SPE2_NewKPIThresholdExt.KPIRangeWrapper Wrapvar = new SPE2_NewKPIThresholdExt.KPIRangeWrapper(sc);
        PageReference pageRef = Page.SPE2_NewKPIThreshold;
        Test.setCurrentPage(pageRef);
        newkpiThreshold.enableattributesMap.put('Market Unit',true);
        newkpiThreshold.enableattributesMap.put('Country',true);
        newkpiThreshold.enableattributesMap.put('Project',true);
        newkpiThreshold.enableattributesMap.put('Category Area',true);
        newkpiThreshold.enableattributesMap.put('Category Group',true);
        newkpiThreshold.enableattributesMap.put('Category',true);
        newkpiThreshold.enableattributesMap.put('Business Unit',true);
        newkpiThreshold.enableattributesMap.put('Business Line',true);
        newkpiThreshold.enableattributesMap.put('Product',true);
        newkpiThreshold.save();
        pageRef.getParameters().put('isClone', '');       
        newkpiThreshold.getMarketValues();
        newkpiThreshold.getMarketUnitValues();
        newkpiThreshold.getCountryValues();
        newkpiThreshold.getProjectValues();
        newkpiThreshold.getBusinessUnitValues();
        newkpiThreshold.getBusinesLineValues();
        newkpiThreshold.getProductValues();
        newkpiThreshold.getCategoryAreaValues();
        newkpiThreshold.getCategoryGroupValues();
        newkpiThreshold.getCategoryValues();
        newkpiThreshold.StagePilot();
        newkpiThreshold.StagePublished();
        newkpiThreshold.StageObsolete();
        newkpiThreshold.populateAllValues();
       // newkpiThreshold.calculation();
        newkpiThreshold.validate();              
        newkpiThreshold.cloneFn();
        
        newkpiThreshold.cancel();
        newkpiThreshold.edi(); 
                        
        Test.StopTest();
     }
    static testMethod void createKPIThresholdPositive2(){
         
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
        
       // PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        //SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);       
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.GeoScope__c ='All Markets';
        kpiDefinition1.CategoryScope__c ='All Categories';
        kpiDefinition1.BUScope__c ='All Products';
        kpiDefinition1.IsHighBetter__c = Boolean.ValueOf('True');        
        kpiDefinition1.KPI_Title__c = 'Atos_KPI_Test1';
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
        
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
        //update kpiDefinition1; 
      
        /*SPE2_KPI_Threshold__c kpiThreshold =new SPE2_KPI_Threshold__c();
        kpiThreshold.KPI_ID__c = ApexPages.currentPage().getParameters().get('kpiDefinition1'); 
        kpiThreshold.Threshold_Title__c ='ABC Threshold';
        kpiThreshold.OwnerId =Userinfo.getUserId();
        kpiThreshold.High_Better__c =kpiDefinition1.IsHighBetter__c;
        insert kpiThreshold;*/
      
        Test.StartTest();
        PageReference pageRef = Page.SPE2_NewKPIThreshold;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('kpiId', kpiDefinition1.Id);
        pageRef.getParameters().put('isNew','TRUE');  
        pageRef.getParameters().put('isEdit','FALSE');      
        ApexPages.StandardController st = new ApexPages.StandardController(new SPE2_KPI_Threshold__c());   
       // ApexPages.currentPage().getParameters().put('kpiDefinition1');          
        
        SPE2_NewKPIThresholdExt newkpiThreshold = new SPE2_NewKPIThresholdExt(st);
        //SPE2_NewKPIThresholdExt.KPIRangeWrapper Wrapvar = new SPE2_NewKPIThresholdExt.KPIRangeWrapper(sc);
        newkpiThreshold.checkValidation();
        newkpiThreshold.Validate();
        pageRef.getParameters().put('isNew','TRUE');  
        pageRef.getParameters().put('isEdit','FALSE');
       // newkpiThreshold.calculation();
        newkpiThreshold.save();
       // pageRef.getParameters().put('isNew','TRUE');  
       // pageRef.getParameters().put('isEdit','FALSE'); 
        newkpiThreshold.cancel();
      //  newkpiThreshold.edi(); 
                        
        Test.StopTest();
        
    }
    
    static testMethod void createKPIThresholdCloned(){
         
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
        
       // PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        //SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);       
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.GeoScope__c ='All Markets';
        kpiDefinition1.CategoryScope__c ='All Categories';
        kpiDefinition1.BUScope__c ='All Products';
        kpiDefinition1.IsHighBetter__c = Boolean.ValueOf('True');        
        kpiDefinition1.KPI_Title__c = 'Atos_KPI_Test1';
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
        
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
       // update kpiDefinition1; 
      
        SPE2_KPI_Threshold__c kpiThreshold =new SPE2_KPI_Threshold__c();
        kpiThreshold.KPI_ID__c =kpiDefinition1.Id;
        kpiThreshold.Threshold_Title__c ='ABC Threshold';
        kpiThreshold.OwnerId =Userinfo.getUserId();
        kpiThreshold.High_Better__c =kpiDefinition1.IsHighBetter__c;
        insert kpiThreshold;
               
        SPE2_KPI_Threshold__c kpiThresholdCloned =new SPE2_KPI_Threshold__c();
        kpiThresholdCloned.KPI_ID__c =kpiDefinition1.Id;
        kpiThresholdCloned.Threshold_Title__c ='ABC Threshold';
        kpiThresholdCloned.OwnerId =Userinfo.getUserId();
        kpiThresholdCloned.High_Better__c =kpiDefinition1.IsHighBetter__c;
        insert kpiThresholdCloned ;

        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = kpiThresholdCloned.KPI_ID__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.KPI_Threshold__c = kpiThresholdCloned.Id;
        insert sc;                
        system.debug('sc ::'+sc);
        
        Test.StartTest(); 
        PageReference pageRef = Page.SPE2_NewKPIThreshold;
        Test.setCurrentPage(pageRef);  
        pageRef.getParameters().put('isClone', 'True');      
        ApexPages.StandardController st = new ApexPages.StandardController(kpiThresholdCloned);                     
        SPE2_NewKPIThresholdExt newkpiThreshold = new SPE2_NewKPIThresholdExt(st);
        
    //    ApexPages.currentPage().getParameters().put('isClone','TRUE');        
                       
        newkpiThreshold.save();
                            
        newkpiThreshold.getMarketValues();
        newkpiThreshold.getMarketUnitValues();
        newkpiThreshold.getCountryValues();
        newkpiThreshold.getProjectValues();
        newkpiThreshold.getBusinessUnitValues();
        newkpiThreshold.getBusinesLineValues();
        newkpiThreshold.getProductValues();
        newkpiThreshold.getCategoryAreaValues();
        newkpiThreshold.getCategoryGroupValues();
        newkpiThreshold.getCategoryValues();
        newkpiThreshold.StagePilot();
        newkpiThreshold.StagePublished();
        newkpiThreshold.StageObsolete();
        newkpiThreshold.populateAllValues();
       // newkpiThreshold.calculation();                    
        newkpiThreshold.cloneFn(); 
        newkpiThreshold.validate();
        newkpiThreshold.checkValidation();      
        newkpiThreshold.cancel();
        newkpiThreshold.edi(); 
                        
        Test.StopTest();
     }
      static testMethod void createKPIThreshold3(){
         
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
        
       // PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        //SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);       
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        kpiDefinition1.GeoScope__c ='All Markets';
        kpiDefinition1.CategoryScope__c ='All Categories';
        kpiDefinition1.BUScope__c ='All Products';
        kpiDefinition1.IsHighBetter__c = Boolean.ValueOf('True');        
        kpiDefinition1.KPI_Title__c = 'Atos_KPI_Test1';
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
        
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
        //update kpiDefinition1; 
      
        SPE2_KPI_Threshold__c kpiThreshold =new SPE2_KPI_Threshold__c();
     /* kpiThreshold.KPI_ID__c =kpiDefinition1.Id;
        kpiThreshold.Threshold_Title__c ='ABC Threshold';
        kpiThreshold.OwnerId =Userinfo.getUserId();
        kpiThreshold.High_Better__c =kpiDefinition1.IsHighBetter__c;
        insert kpiThreshold;*/
        ApexPages.currentPage().getParameters().put('isNew','TRUE');
        ApexPages.currentPage().getParameters().put('isEdit','FALSE');
        
               
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = kpiThreshold.KPI_ID__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.KPI_Threshold__c = kpiThreshold.Id;
        insert sc;                
        system.debug('sc ::'+sc);
        
        Test.StartTest(); 
        PageReference pageRef = Page.SPE2_NewKPIThreshold;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('kpiId', kpiDefinition1.Id);
        pageRef.getParameters().put('isNew','TRUE');
        pageRef.getParameters().put('isEdit','FALSE');     
        ApexPages.StandardController st = new ApexPages.StandardController(kpiThreshold);                     
        SPE2_NewKPIThresholdExt newkpiThreshold = new SPE2_NewKPIThresholdExt(st);
        newkpiThreshold.save();
        newkpiThreshold.validate();
        newkpiThreshold.checkValidation();                           
                                    
        newkpiThreshold.getMarketValues();
        newkpiThreshold.getMarketUnitValues();
        newkpiThreshold.getCountryValues();
        newkpiThreshold.getProjectValues();
        newkpiThreshold.getBusinessUnitValues();
        newkpiThreshold.getBusinesLineValues();
        newkpiThreshold.getProductValues();
        newkpiThreshold.getCategoryAreaValues();
        newkpiThreshold.getCategoryGroupValues();
        newkpiThreshold.getCategoryValues();
        newkpiThreshold.StagePilot();
        newkpiThreshold.StagePublished();
        newkpiThreshold.StageObsolete();
        newkpiThreshold.populateAllValues();
       // newkpiThreshold.calculation();                    
      //  newkpiThreshold.cloneFn(); 
             
       // newkpiThreshold.cancel();
      //  newkpiThreshold.edi(); 
                        
        Test.StopTest();
     }
     static testMethod void createKPIThreshold4(){
         
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
        
       // PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        //SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);       
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.GeoScope__c ='All Markets';
        kpiDefinition1.CategoryScope__c ='All Categories';
        kpiDefinition1.BUScope__c ='All Products';
        kpiDefinition1.IsHighBetter__c = Boolean.ValueOf('True');        
        kpiDefinition1.KPI_Title__c = 'Atos_KPI_Test1';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'Project';
        kpiDefinition1.categoryscope__c = 'Category';
        kpiDefinition1.BUScope__c = 'Product';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
        kpiDefinition1.VerNumber__c = 0;
        insert kpiDefinition1;
        
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
              
        SPE2_KPI_Threshold__c kpiThreshold =new SPE2_KPI_Threshold__c();
        kpiThreshold.KPI_ID__c =kpiDefinition1.Id;
        kpiThreshold.Threshold_Title__c ='ABC Threshold';
        kpiThreshold.OwnerId =Userinfo.getUserId();
        kpiThreshold.High_Better__c =kpiDefinition1.IsHighBetter__c;
        kpiThreshold.Region__c= 'NAM'; 
        kpiThreshold.SubRegion__c= 'NAM US'; 
        kpiThreshold.Country__c = 'United States of America'; 
        kpiThreshold.Project__c = 'US Cellular'; 
        kpiThreshold.CategoryCluster__c= 'Product Procurement'; 
        kpiThreshold.CategoryGroup__c ='Mechanics'; 
        kpiThreshold.Category__c = 'Sheet Metal Parts'; 
        kpiThreshold.BusinessUnit__c = 'Global Services'; 
        kpiThreshold.BusinessLine__c = 'Care'; 
        kpiThreshold.Product__c = 'PTF';          

        insert kpiThreshold;
               
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = kpiThreshold.KPI_ID__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.KPI_Threshold__c = kpiThreshold.Id;
        insert sc;                
        system.debug('sc ::'+sc);
        
        ApexPages.currentPage().getParameters().put('isNew','TRUE');
        ApexPages.currentPage().getParameters().put('isEdit','FALSE');  
        
        Test.StartTest(); 
        PageReference pageRef = Page.SPE2_NewKPIThreshold;
        Test.setCurrentPage(pageRef);  
        pageRef.getParameters().put('kpiId', kpiDefinition1.Id);
        pageRef.getParameters().put('isNew','TRUE');
        pageRef.getParameters().put('isEdit','FALSE');    
        ApexPages.StandardController st = new ApexPages.StandardController(kpiThreshold);                     
        SPE2_NewKPIThresholdExt newkpiThreshold = new SPE2_NewKPIThresholdExt(st);
       // SPE2_NewKPIThresholdExt.ScoringCalcWrapper scw = new SPE2_NewKPIThresholdExt.ScoringCalcWrapper(sc);
        newkpiThreshold.populateAllValues(); 
        newkpiThreshold.validate();
        newkpiThreshold.checkValidation();                           
        newkpiThreshold.save();
        List<PicklistDefaultValues__c> picklist =newkpiThreshold.defalultPickl;
        newkpiThreshold.isNew =true;
        newkpiThreshold.isEdit =false;
        
      //  ApexPages.currentPage().getParameters().put('isNew','TRUE');
      //  ApexPages.currentPage().getParameters().put('isEdit','FALSE');                           
                             
        newkpiThreshold.getMarketValues();
        newkpiThreshold.getCountryValues();
        newkpiThreshold.getProjectValues();
        newkpiThreshold.getBusinessUnitValues();
       newkpiThreshold.getProductValues();
        newkpiThreshold.getCategoryAreaValues();
        newkpiThreshold.getCategoryValues();                  
                        
        Test.StopTest();
     }
}