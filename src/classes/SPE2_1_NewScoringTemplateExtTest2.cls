@isTest (seeAllData=false)
private class SPE2_1_NewScoringTemplateExtTest2{
     static testMethod void createScoringTemplate1()  {
     Test.StartTest();    
        //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
    PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c= 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c ='All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';
        picklistObj.Name = 'Picklist Default Values';
    
       lstpicklistObj.add(picklistObj);
       insert lstpicklistObj;
    
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
       // insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;       
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';       
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Region__c= 'NAM';
        threshold.SubRegion__c= 'NAM US';
        threshold.Country__c = 'United States of America';
        threshold.Project__c = 'US Cellular';
        threshold.CategoryCluster__c= 'Product Procurement';
        threshold.CategoryGroup__c ='Mechanics';
        threshold.Category__c = 'Sheet Metal Parts';
        threshold.BusinessUnit__c = 'Global Services';
        threshold.BusinessLine__c = 'Care';
        threshold.Product__c = 'PTF';
        threshold.Weightage__c= 10;
        insert threshold;
        
        
           SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Published';
            speTemplate.Region__c= 'All Markets';
            speTemplate.SubRegion__c= 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c= 'All Category Areas';
            speTemplate.CategoryGroup__c='All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessUnit__c = 'All Business Units';
            speTemplate.BusinessLine__c = 'All Business Lines';
            speTemplate.Product__c = 'All Products';
            speTemplate.Product1__c ='--None--';
            speTemplate.Product2__c ='--None--';
            speTemplate.Product3__c = '--None--';
            speTemplate.GeoScope__c = 'All Markets';
            speTemplate.Categoryscope__c ='All Categories';
            speTemplate.BUScope__c = 'All Products';
            insert speTemplate; 
            
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;        

        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Stage__c='Draft';
        scoringTemplate.Region__c= 'NAM';
        scoringTemplate.SubRegion__c= 'NAM US';
        scoringTemplate.Country__c = 'United States of America';
        scoringTemplate.Project__c = 'US Cellular';
        scoringTemplate.CategoryCluster__c= 'Product Procurement';
        scoringTemplate.CategoryGroup__c ='Mechanics';
        scoringTemplate.Category__c = 'Sheet Metal Parts';
        scoringTemplate.BusinessUnit__c = 'Global Services';
        scoringTemplate.BusinessLine__c = 'Care';
        scoringTemplate.Product__c = 'PTF';   
        insert scoringTemplate;
        
        scoringTemplate.SPETemplate__c = speTemplate.id;
        scoringTemplate.SPEKPIMap__c = speKPIMaps1.id;
        scoringTemplate.SPE2_KPI_Threshold__c =threshold.id;
        scoringTemplate.Stage__c='Published';
        update scoringTemplate; 
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<=';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;  
        
        PageReference pageRef = Page.SPE2_1_NewScoringTemplate;
        Test.setCurrentPage(pageRef); 
        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        SPE2_1_NewScoringTemplateExt newScoringTemp = new SPE2_1_NewScoringTemplateExt(st);
        
        SPE2_1_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE2_1_NewScoringTemplateExt.KPIRangeWrapper(sc);
        List<SPE2_1_NewScoringTemplateExt.KPIRangeWrapper> wrpList = new List<SPE2_1_NewScoringTemplateExt.KPIRangeWrapper>(); 
        pageRef.getParameters().put('isClone',NULL);
        pageRef.getParameters().put('isNew','TRUE');
        pageRef.getParameters().put('kpiDefId1',sc.KPIDefinition__c);
        pageRef.getParameters().put('ThresId',sc.KPI_Threshold__c);
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', scoringTemplate.Id);
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('projectVal','All Projects');
        pageRef.getParameters().put('caVal', 'All Category Areas');
        pageRef.getParameters().put('cgVal', 'All Category Groups');
        pageRef.getParameters().put('ctVal', 'All Categories');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        newScoringTemp.methodSave();
        newScoringTemp.getMarketValues();
        newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        newScoringTemp.getBusinesLineValues();
    
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        newScoringTemp.getCategoryGroupValues();
        newScoringTemp.getCategoryValues();
        newScoringTemp.populateAllValues();
        newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        newScoringTemp.StageDelete();
        newScoringTemp.cloneFn();
        newScoringTemp.Cancel();
       // newScoringTemp.executeTestBatch();
        newScoringTemp.blankMethod();
        newScoringTemp.edi();
        newScoringTemp.duplicatecheck();
        newScoringTemp.findMinKPIValues(wrpList);
        newScoringTemp.findMaxKPIValues(wrpList);
        newScoringTemp.fetchScoringCalculation();
        newScoringTemp.AdddefaultValues();
        
        Test.StopTest();
    } 
    static testMethod void createScoringTemplate2()  {
     Test.StartTest();    
        //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
    PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
       picklistObj.Market__c= 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c ='All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';
        picklistObj.Name = 'Picklist Default Values';
    
       lstpicklistObj.add(picklistObj);
       insert lstpicklistObj;
    
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
       // insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;       
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';       
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Region__c= 'NAM';
        threshold.SubRegion__c= 'NAM US';
        threshold.Country__c = 'United States of America';
        threshold.Project__c = 'US Cellular';
        threshold.CategoryCluster__c= 'Product Procurement';
        threshold.CategoryGroup__c ='Mechanics';
        threshold.Category__c = 'Sheet Metal Parts';
        threshold.BusinessUnit__c = 'Global Services';
        threshold.BusinessLine__c = 'Care';
        threshold.Product__c = 'PTF';
        threshold.Weightage__c= 10;
        insert threshold;
                         
           SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Published';
            speTemplate.Region__c= 'All Markets';
            speTemplate.SubRegion__c= 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c= 'All Category Areas';
            speTemplate.CategoryGroup__c='All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessUnit__c = 'All Business Units';
            speTemplate.BusinessLine__c = 'All Business Lines';
            speTemplate.Product__c = 'All Products';
            speTemplate.Product1__c ='--None--';
            speTemplate.Product2__c ='--None--';
            speTemplate.Product3__c = '--None--';
            speTemplate.GeoScope__c = 'All Markets';
            speTemplate.Categoryscope__c ='All Categories';
            speTemplate.BUScope__c = 'All Products';
            insert speTemplate; 
            
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
                       
        SPE_ScoringTemplate__c scoringtemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringtemplate.SPETemplate__c = speTemplate.id;
        insert scoringtemplate;
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<=';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
        insert sc;  
        List<SPE_ScoringTemplate__c> scList =new List<SPE_ScoringTemplate__c>();
        scList =[SELECT Name, BusinessLine__c,Stage__c,ScoringTemplateCode__c, Region__c,Organization_Group__c, BusinessUnit__c, SubRegion__c, Project__c, Product__c, Product1__c, Product2__c, Product3__c, 
               Country__c, SPETemplate__c, SPEKPIMap__c, KPIDefinitionName__c, CategoryCluster__c, CategoryGroup__c, Category__c, CreatedById
               FROM SPE_ScoringTemplate__c 
               WHERE Id =:scoringtemplate.id];
       // ApexPages.currentPage().getParameters().put('Id',scoringtemplate.SPETemplate__c);
        system.debug('spe template ::'+scoringtemplate.SPETemplate__c);
        PageReference pageRef = Page.SPE2_1_NewScoringTemplate;
        Test.setCurrentPage(pageRef); 
        ApexPages.StandardController st = new ApexPages.StandardController(new SPE_ScoringTemplate__c());
        SPE2_1_NewScoringTemplateExt newScoringTemp = new SPE2_1_NewScoringTemplateExt(st);
        
        SPE2_1_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE2_1_NewScoringTemplateExt.KPIRangeWrapper(sc);
        List<SPE2_1_NewScoringTemplateExt.KPIRangeWrapper> wrpList = new List<SPE2_1_NewScoringTemplateExt.KPIRangeWrapper>(); 
        pageRef.getParameters().put('isClone',NULL);
        pageRef.getParameters().put('isNew','TRUE');
       // pageRef.getParameters().put('speTempId',scoringtemplate.SPETemplate__c);
        pageRef.getParameters().put('speTempId',scList[0].SPETemplate__c);
        pageRef.getParameters().put('Id','');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'United States of America');
        pageRef.getParameters().put('projectVal', 'US Cellular');
        pageRef.getParameters().put('caVal', 'All Category Areas');
        pageRef.getParameters().put('cgVal', 'All Category Groups');
        pageRef.getParameters().put('ctVal', 'Sheet Metal Parts');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('prdVal', 'PTF');
       // pageRef.getParameters().put('rerenderForm11', 'test');
        
        newScoringTemp.methodSave();
        newScoringTemp.getMarketValues();
        newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        newScoringTemp.getBusinesLineValues();
    
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        newScoringTemp.populateAllValues();
       // newScoringTemp.StagePilot();
      //  newScoringTemp.StagePublished();
       // newScoringTemp.StageObsolete();
      //newScoringTemp.StageDelete();
       // newScoringTemp.cloneFn();
        newScoringTemp.Cancel();
       // newScoringTemp.executeTestBatch();
        newScoringTemp.blankMethod();
       // newScoringTemp.edi();
        newScoringTemp.duplicatecheck();
      //  newScoringTemp.addInitialData();
        newScoringTemp.findMinKPIValues(wrpList);
        newScoringTemp.findMaxKPIValues(wrpList);
      //  newScoringTemp.fetchScoringCalculation();
     //   newScoringTemp.AdddefaultValues();
        
        Test.StopTest();
    } 
    static testMethod void createScoringTemplate3()  {
     Test.StartTest();    
        //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
    PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c= 'NAM';
        picklistObj.Market_Unit__c = 'NAM US';
        picklistObj.Country__c = 'United States of America';
        picklistObj.Project__c = 'US Cellular';
        picklistObj.Category_Area__c = 'Product Procurement';
        picklistObj.Category_Group__c ='Mechanics';
        picklistObj.Category__c = 'Sheet Metal Parts';
        picklistObj.Business_Unit__c = 'Global Services';
        picklistObj.Business_Line__c = 'Care';
        picklistObj.Product__c = 'PTF';
        picklistObj.Name = 'Picklist Default Values';
    
       lstpicklistObj.add(picklistObj);
       insert lstpicklistObj;
    
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
       // insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;       
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';       
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Region__c= 'NAM';
        threshold.SubRegion__c= 'NAM US';
        threshold.Country__c = 'United States of America';
        threshold.Project__c = 'US Cellular';
        threshold.CategoryCluster__c= 'Product Procurement';
        threshold.CategoryGroup__c ='Mechanics';
        threshold.Category__c = 'Sheet Metal Parts';
        threshold.BusinessUnit__c = 'Global Services';
        threshold.BusinessLine__c = 'Care';
        threshold.Product__c = 'PTF';
        threshold.Weightage__c= 10;
        insert threshold;
        
        
           SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Published';
            speTemplate.Region__c= 'All Markets';
            speTemplate.SubRegion__c= 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c= 'All Category Areas';
            speTemplate.CategoryGroup__c='All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessUnit__c = 'All Business Units';
            speTemplate.BusinessLine__c = 'All Business Lines';
            speTemplate.Product__c = 'All Products';
            speTemplate.Product1__c ='--None--';
            speTemplate.Product2__c ='--None--';
            speTemplate.Product3__c = '--None--';
            speTemplate.GeoScope__c = 'All Markets';
            speTemplate.Categoryscope__c ='All Categories';
            speTemplate.BUScope__c = 'All Products';
            insert speTemplate; 
            
                
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;        
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        scoringTemplate.Stage__c='Draft';
        scoringTemplate.Region__c= 'NAM';
        scoringTemplate.SubRegion__c= 'NAM US';
        scoringTemplate.Country__c = 'United States of America';
        scoringTemplate.Project__c = 'US Cellular';
        scoringTemplate.CategoryCluster__c= 'Product Procurement';
        scoringTemplate.CategoryGroup__c ='Mechanics';
        scoringTemplate.Category__c = 'Sheet Metal Parts';
        scoringTemplate.BusinessUnit__c = 'Global Services';
        scoringTemplate.BusinessLine__c = 'Care';
        scoringTemplate.Product__c = 'PTF';   
        insert scoringTemplate;
        
        scoringTemplate.SPETemplate__c = speTemplate.id;
        scoringTemplate.SPEKPIMap__c = speKPIMaps1.id;
        scoringTemplate.SPE2_KPI_Threshold__c =threshold.id;
        scoringTemplate.Stage__c='Published';
        update scoringTemplate; 
        
       SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<=';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        sc.SPEKPIMap__c = speKPIMaps1.Id;
        sc.KPI_Threshold__c = threshold.id;
       // insert sc;  
        
        PageReference pageRef = Page.SPE2_1_NewScoringTemplate;
        Test.setCurrentPage(pageRef); 
        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        SPE2_1_NewScoringTemplateExt newScoringTemp = new SPE2_1_NewScoringTemplateExt(st);
        
        SPE2_1_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE2_1_NewScoringTemplateExt.KPIRangeWrapper(sc);
        List<SPE2_1_NewScoringTemplateExt.KPIRangeWrapper> wrpList = new List<SPE2_1_NewScoringTemplateExt.KPIRangeWrapper>(); 
        pageRef.getParameters().put('isClone',Null);
        pageRef.getParameters().put('isNew','TRUE');
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', scoringTemplate.Id);
        pageRef.getParameters().put('marketVal', 'NAM');
        pageRef.getParameters().put('marketUnitVal', 'NAM US');
        pageRef.getParameters().put('countryVal', 'United States of America');
        pageRef.getParameters().put('projectVal', 'US Cellular');
        pageRef.getParameters().put('caVal', 'Product Procurement');
        pageRef.getParameters().put('cgVal', 'Mechanics');
        pageRef.getParameters().put('ctVal', 'Sheet Metal Parts');
        pageRef.getParameters().put('buVal', 'Global Services');
        pageRef.getParameters().put('blVal', 'Care');
        pageRef.getParameters().put('prdVal', 'PTF');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        newScoringTemp.methodSave();
        newScoringTemp.getMarketValues();
        newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        newScoringTemp.getBusinesLineValues();
    
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        newScoringTemp.getCategoryGroupValues();
        newScoringTemp.getCategoryValues();
        newScoringTemp.populateAllValues();
        newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        newScoringTemp.StageDelete();
       // newScoringTemp.cloneFn();
        newScoringTemp.Cancel();
       // newScoringTemp.executeTestBatch();
        newScoringTemp.blankMethod();
        newScoringTemp.edi();
        newScoringTemp.duplicatecheck();
        newScoringTemp.findMinKPIValues(wrpList);
        newScoringTemp.findMaxKPIValues(wrpList);
      //  newScoringTemp.fetchScoringCalculation();
        newScoringTemp.AdddefaultValues();
        
        Test.StopTest();
    } 
    
    static testMethod void createScoringTemplate4()
    {    
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c = 'NAM';
        picklistObj.Market_Unit__c = 'NAM US';
        picklistObj.Country__c = 'United States of America';
        picklistObj.Project__c = 'US Cellular';
        picklistObj.Category_Area__c = 'Product procurement';
        picklistObj.Category_Group__c ='Mechanics & RF Products';
        picklistObj.Category__c = 'Standard Mechanics';
        picklistObj.Business_Unit__c = 'Global Services';
        picklistObj.Business_Line__c = 'Care';
        picklistObj.Product__c = 'PTF';
        picklistObj.Name = 'Picklist Default Values';
    
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.GeoScope__c = 'Project';
        kpiDefinition1.categoryscope__c = 'Category';
        kpiDefinition1.BUScope__c = 'Product';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;       
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        SPE2_KPI_Threshold__c threshold = new SPE2_KPI_Threshold__c();
        threshold.KPI_ID__c= kpiDefinition1.id;
        threshold.BusinessLine__c ='Care';
        threshold.BusinessUnit__c= 'Global Services';
        threshold.Category__c ='Sheet Metal Parts';
        threshold.CategoryCluster__c= 'Product Procurement';
        threshold.CategoryGroup__c ='Mechanics';
        threshold.Country__c= 'United States of America';
        threshold.KPI_Attrribute__c= 'KPIAttribute';
        threshold.KPI_Title__c = 'KPIdef1';
        threshold.Region__c='NAM';
        threshold.SubRegion__c= 'NAM US';
        threshold.Product__c= 'PTF';
        threshold.Project__c = 'US Cellular';
        threshold.Stage__c= 'Draft';
        threshold.Threshold_Boundary__c= 'threshold boundary';
        threshold.Threshold_Title__c='Sample threshold';
        threshold.Weightage__c= 10;
        insert threshold;
   
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate 123';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c= 'NAM';
        speTemplate.SubRegion__c= 'NAM US';
        speTemplate.Country__c = 'United States of America';
        speTemplate.Project__c = 'US Cellular';
        speTemplate.CategoryCluster__c= 'Product Procurement';
        speTemplate.CategoryGroup__c ='Mechanics';
        speTemplate.Category__c = 'Sheet Metal Parts';
        speTemplate.BusinessUnit__c = 'Global Services';
        speTemplate.BusinessLine__c = 'Care';
        speTemplate.Product__c = 'PTF';
        speTemplate.GeoScope__c = 'Project';
        speTemplate.CategoryGroup__c = 'Category';
        speTemplate.BUScope__c = 'Product';
        insert speTemplate;
        
        speTemplate.Stage__c ='Pilot';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps = new SPE_SPEKPIMap__c();       
        speKPIMaps.KPIDefinition__c = kpiDefinition1.Id;
        speKPIMaps.SPETemplate__c = speTemplate.Id;
        speKPIMaps.Weight__c = 100;
        insert speKPIMaps;
        
       
                
        SPE_ScoringTemplate__c scoringTemplate = new SPE_ScoringTemplate__c();
        scoringTemplate.Name = 'Test Demo scoring Template 1234';
        scoringTemplate.SPETemplate__c = speTemplate.Id; 
        scoringTemplate.Stage__c='Draft';      
        scoringTemplate.Region__c= 'NAM';
        scoringTemplate.SubRegion__c= 'NAM US';
        scoringTemplate.Country__c = 'United States of America';
        scoringTemplate.Project__c = 'US Cellular';
        scoringTemplate.CategoryCluster__c= 'Product Procurement';
        scoringTemplate.CategoryGroup__c ='Mechanics';
        scoringTemplate.Category__c = 'Sheet Metal Parts';
        scoringTemplate.BusinessUnit__c = 'Global Services';
        scoringTemplate.BusinessLine__c = 'Care';
        scoringTemplate.Product__c = 'PTF';   
        insert scoringTemplate;
       
        scoringTemplate.SPEKPIMap__c = speKPIMaps.id;
        scoringTemplate.SPE2_KPI_Threshold__c =threshold.id;
        update scoringTemplate;
               
        SPE_ScoringTemplate__c scoreTemplatecloned = new SPE_ScoringTemplate__c();
        scoreTemplatecloned.Name = 'Test Demo scoring Template 1234 clone';
        scoreTemplatecloned.SPETemplate__c = speTemplate.Id; 
        scoreTemplatecloned.Stage__c='Draft';      
        scoreTemplatecloned.Region__c= 'NAM';
        scoreTemplatecloned.SubRegion__c= 'NAM US';
        scoreTemplatecloned.Country__c = 'United States of America';
        scoreTemplatecloned.Project__c = 'US Cellular';
        scoreTemplatecloned.CategoryCluster__c= 'Product Procurement';
        scoreTemplatecloned.CategoryGroup__c ='Mechanics';
        scoreTemplatecloned.Category__c = 'Sheet Metal Parts';
        scoreTemplatecloned.BusinessUnit__c = 'Global Services';
        scoreTemplatecloned.BusinessLine__c = 'Care';
        scoreTemplatecloned.Product__c = 'PTF';              
        insert scoreTemplatecloned;
        
        scoreTemplatecloned.SPEKPIMap__c = speKPIMaps.id;
        scoreTemplatecloned.SPE2_KPI_Threshold__c =threshold.id;
        update scoreTemplatecloned;
                       
        SPE_ScoringCalculation__c scCloned = new SPE_ScoringCalculation__c();               
        scCloned.KPIDefinition__c = speKPIMaps.KPIDefinition__c;
        scCloned.Score__c = 1;
        scCloned.Lower__c = 0;
        scCloned.LowerTo__c = '>';
        scCloned.Upper__c = 50;
        scCloned.UpperTo__c = '<';
        scCloned.ScoringTemplate__c = scoreTemplatecloned.Id;
        scCloned.SPEKPIMap__c = speKPIMaps.Id;
        scCloned.KPI_Threshold__c = threshold.id;                                
        insert scCloned;
        
        Test.StartTest();
      
        PageReference pageRef = Page.SPE2_1_NewScoringTemplate;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController st = new ApexPages.StandardController(scoreTemplatecloned);       
        SPE2_1_NewScoringTemplateExt newScoringTemp = new SPE2_1_NewScoringTemplateExt(st);
        Apexpages.currentPage().getParameters().put('isClone','TRUE');
        
        pageRef.getParameters().put('idScoringTempId',scoreTemplatecloned.Id);
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', scoringTemplate.Id);
         pageRef.getParameters().put('kpiDefId1',scCloned.KPIDefinition__c);
        pageRef.getParameters().put('ThresId',scCloned.KPI_Threshold__c);
        pageRef.getParameters().put('isClone','TRUE');
        pageRef.getParameters().put('marketVal', 'NAM');
        pageRef.getParameters().put('marketUnitVal', 'NAM US');
        pageRef.getParameters().put('countryVal', 'United States of America');
        pageRef.getParameters().put('projectVal', 'US Cellular');
        pageRef.getParameters().put('caVal', 'Product Procurement');
        pageRef.getParameters().put('cgVal', 'Mechanics');
        pageRef.getParameters().put('ctVal', 'Sheet Metal Parts');
        pageRef.getParameters().put('buVal', 'Global Services');
        pageRef.getParameters().put('blVal', 'Care');
        pageRef.getParameters().put('prdVal', 'PTF');
      //  pageRef.getParameters().put('rerenderForm11', 'test');
    //    pageRef.getParameters().put('isNew','TRUE');
        

     
       // SPE2_1_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE2_1_NewScoringTemplateExt.KPIRangeWrapper(sc);
        newScoringTemp.cloneFn();
        newScoringTemp.methodSave();
        newScoringTemp.duplicatecheck();
        newScoringTemp.fetchScoringCalculation();        
        newScoringTemp.getMarketValues();
        newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        newScoringTemp.getBusinesLineValues();
        newScoringTemp.fillBusinessLine();
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        newScoringTemp.Cancel();
        newScoringTemp.edi();  
        
        Test.StopTest();
    }     
    
}