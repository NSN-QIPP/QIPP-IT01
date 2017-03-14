@isTest (seeAllData=false)
private class SPE_NewScoringTemplateExtTest {
    
    static testMethod void createScoringTemplatePositive()
    {
    Test.StartTest();    
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'All Category Areas';
            speTemplate.CategoryGroup__c = 'All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='Draft';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
                
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        insert sc;
        
        
        
        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        
        Apexpages.currentPage().getParameters().put('speTempId', speTemplate.Id);
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        SPE_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE_NewScoringTemplateExt.KPIRangeWrapper(sc);
        
        
        newScoringTemp.save();
        
        newScoringTemp.getMarketValues();
        //newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        //newScoringTemp.getBusinesLineValues();
        //newScoringTemp.fillBusinessLine();
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        //newScoringTemp.getCategoryGroupValues();
        newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        //newScoringTemp.StageDelete();
        //newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        newScoringTemp.edi();
        newScoringTemp.getIsScopeMatch();
        newScoringTemp.populateAllValues();
        //newScoringTemp.duplicatecheck();
        //newScoringTemp.findMinKPIValues();
        //newScoringTemp.findMaxKPIValues();
        
        
        Test.StopTest();
    }
    
 /*   
    static testMethod void createScoringTemplate2()
    {
    Test.StartTest();    
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'All Category Areas';
            speTemplate.CategoryGroup__c = 'All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='ab';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        //insert scoringTemplate;
        
        
        
        
        //Apexpages.currentPage().getParameters().put('Id', scoringTemplate.Id );
        
        
        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        
        Apexpages.currentPage().getParameters().put('speTempId', speTemplate.Id);
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        
        newScoringTemp.save();
        
        
         newScoringTemp.getMarketValues();
        //newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        //newScoringTemp.getBusinesLineValues();
        //newScoringTemp.fillBusinessLine();
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        //newScoringTemp.StageDelete();
        //newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        newScoringTemp.edi();
        newScoringTemp.getIsScopeMatch();
        //newScoringTemp.duplicatecheck();
        //newScoringTemp.findMinKPIValues();
        //newScoringTemp.findMaxKPIValues();
        
        
        Test.StopTest();
    }
    
   */ 
    static testMethod void createScoringTemplate3()
    {
    Test.StartTest();    
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'All Category Areas';
            speTemplate.CategoryGroup__c = 'All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='Published';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '==';
        sc.Upper__c = 50;
        sc.UpperTo__c = '==';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        insert sc;
       
        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        Apexpages.currentPage().getParameters().put('speTempId', speTemplate.Id);
        Apexpages.currentPage().getParameters().put('Id', scoringTemplate.Id);
        Apexpages.currentPage().getParameters().put('cgVal', 'Test');
        Apexpages.currentPage().getParameters().put('caVal', 'Test');
        Apexpages.currentPage().getParameters().put('buVal', 'Test');
        
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        SPE_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE_NewScoringTemplateExt.KPIRangeWrapper(sc);
        
        
        newScoringTemp.save();
        
        
        newScoringTemp.getMarketValues();
        //newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        //newScoringTemp.getBusinesLineValues();
        //newScoringTemp.fillBusinessLine();
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        //newScoringTemp.getCategoryGroupValues();
         newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        //newScoringTemp.StageDelete();
        //newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        newScoringTemp.edi();
        newScoringTemp.getIsScopeMatch();
        //newScoringTemp.duplicatecheck();
        //newScoringTemp.findMinKPIValues();
        //newScoringTemp.findMaxKPIValues();
        //
        SPE_SPETemplate__c speTemplate1 = new SPE_SPETemplate__c();
        try{
        insert speTemplate1;
        }catch(Exception e){}
        Test.StopTest();
    }
    
    static testMethod void createScoringTemplate5()
    {
    Test.StartTest();    
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'All Category Areas';
            speTemplate.CategoryGroup__c = 'All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='Pilot';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        //insert scoringTemplate;
        
        
        
        
        //Apexpages.currentPage().getParameters().put('Id', scoringTemplate.Id );
        
        
        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        
        Apexpages.currentPage().getParameters().put('speTempId', speTemplate.Id);
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        
        newScoringTemp.save();
        
        
        newScoringTemp.getMarketValues();
        //newScoringTemp.getMarketUnitValues();
        newScoringTemp.getCountryValues();
        newScoringTemp.getProjectValues();
        newScoringTemp.getBusinessUnitValues();
        //newScoringTemp.getBusinesLineValues();
        //newScoringTemp.fillBusinessLine();
        newScoringTemp.getProductValues();
        newScoringTemp.showProdVals();
        newScoringTemp.getCategoryAreaValues();
        //newScoringTemp.StagePilot();
        newScoringTemp.StagePublished();
        newScoringTemp.StageObsolete();
        //newScoringTemp.StageDelete();
        //newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        //newScoringTemp.edi();
       
        
        Test.StopTest();
    }
    
    
    static testMethod void createScoringTemplate4()
    {
    Test.StartTest();    
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'All Category Areas';
            speTemplate.CategoryGroup__c = 'FACILITY';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='Published';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 50;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '=';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        insert sc;
        
        
        PageReference pageRef = Page.SPE_NewScoringTemplate;
        //pageRef.getParameters().put('id', String.valueOf(testAccountPlanInsert.Id));
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', scoringTemplate.Id);
        pageRef.getParameters().put('cgVal', 'FACILITY');
        pageRef.getParameters().put('caVal', 'PRODUCT PROCUREMENT');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('ctVal', 'Application Development');
        pageRef.getParameters().put('projectVal', 'All Projects');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        

        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        SPE_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE_NewScoringTemplateExt.KPIRangeWrapper(sc);
        
        
        newScoringTemp.save();
        
        
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
      // newScoringTemp.getCategoryGroupValues();
        newScoringTemp.getCategoryValues();
        newScoringTemp.blankMethod();
        newScoringTemp.fillCategory();
        newScoringTemp.StageDelete();
        //newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        newScoringTemp.edi();
        newScoringTemp.getIsScopeMatch();
        //newScoringTemp.duplicatecheck();
        //newScoringTemp.findMinKPIValues();
        //newScoringTemp.findMaxKPIValues();
        
        Test.StopTest();
    }
    
/*      
    static testMethod void createScoringTemplate6()
    {
    Test.StartTest();    
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'All Category Areas';
            speTemplate.CategoryGroup__c = 'All Category Groups';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='Published';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Pilot';
        update scoringTemplate;
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        insert sc;
        
        
        PageReference pageRef = Page.SPE_NewScoringTemplate;
        //pageRef.getParameters().put('id', String.valueOf(testAccountPlanInsert.Id));
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', scoringTemplate.Id);
        pageRef.getParameters().put('cgVal', 'All Category Groups');
        pageRef.getParameters().put('caVal', 'All Category Areas');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('ctVal', 'All Categories');
        pageRef.getParameters().put('projectVal', 'All Projects');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        

        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        SPE_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE_NewScoringTemplateExt.KPIRangeWrapper(sc);
        
        
        newScoringTemp.save();
        
        
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
       // newScoringTemp.getCategoryGroupValues();
        newScoringTemp.getCategoryValues();
        newScoringTemp.blankMethod();
        newScoringTemp.fillCategory();
        newScoringTemp.StageDelete();
        newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        newScoringTemp.edi();
        newScoringTemp.getIsScopeMatch();
        //newScoringTemp.duplicatecheck();
        //newScoringTemp.findMinKPIValues();
        //newScoringTemp.findMaxKPIValues();
        
        Test.StopTest();
    }
    
  
    static testMethod void createScoringTemplate7()
    {
    Test.StartTest();    
        //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
    PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
    picklistObj.Business_Line__c = 'All Business Lines';
    picklistObj.Business_Unit__c = 'All Business Units';
    picklistObj.Category_Area__c = 'abcd';
    picklistObj.Category_Group__c = 'cg1';
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
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        //insert defaultPicklist;
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.Level__c = '1;2';
        insert kpiDefinition1;
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.Level__c = '1;2';
        insert kpiDefinition2;
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        //SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        //insert speTemplate;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
            speTemplate.Name = 'Test SPE TEmplate 123';
            speTemplate.Stage__c = 'Draft';
            speTemplate.Region__c = 'All Markets';
            speTemplate.SubRegion__c = 'All Market Units';
            speTemplate.Country__c = 'All Countries';
            speTemplate.Project__c = 'All Projects';
            speTemplate.CategoryCluster__c = 'abcd';
            speTemplate.CategoryGroup__c = 'cg1';
            speTemplate.Category__c = 'All Categories';
            speTemplate.BusinessLine__c ='All Business Lines';
            speTemplate.BusinessUnit__c ='All Business Units';
            speTemplate.Product__c = 'All Products'; 
            //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemplate;
        
        speTemplate.Stage__c ='Published';
        update speTemplate;
        
        SPE_SPEKPIMap__c speKPIMaps1 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        insert speKPIMaps1;
        
        SPE_SPEKPIMap__c speKPIMaps2 = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2,speTemplate);
        insert speKPIMaps2;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemplate);
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = speKPIMaps1.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = scoringTemplate.Id;
        insert sc;
        
        
        PageReference pageRef = Page.SPE_NewScoringTemplate;
        //pageRef.getParameters().put('id', String.valueOf(testAccountPlanInsert.Id));
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        pageRef.getParameters().put('Id', scoringTemplate.Id);
        pageRef.getParameters().put('cgVal', 'cg1');
        pageRef.getParameters().put('caVal', 'abcd');
        pageRef.getParameters().put('buVal', 'All Business Units');
        pageRef.getParameters().put('marketVal', 'All Markets');
        pageRef.getParameters().put('marketUnitVal', 'All Market Units');
        pageRef.getParameters().put('countryVal', 'All Countries');
        pageRef.getParameters().put('blVal', 'All Business Lines');
        pageRef.getParameters().put('ctVal', 'All Categories');
        pageRef.getParameters().put('projectVal', 'All Projects');
        pageRef.getParameters().put('prdVal', 'All Products');
        pageRef.getParameters().put('rerenderForm11', 'test');
        
        

        ApexPages.StandardController st = new ApexPages.StandardController(scoringTemplate);
        
        SPE_NewScoringTemplateExt newScoringTemp = new SPE_NewScoringTemplateExt(st);
        SPE_NewScoringTemplateExt.KPIRangeWrapper Wrapvar = new SPE_NewScoringTemplateExt.KPIRangeWrapper(sc);
        
        
        newScoringTemp.save();
        
        
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
        //newScoringTemp.defalultPicklist();
       // newScoringTemp.getCategoryGroupValues();
        newScoringTemp.getCategoryValues();
        newScoringTemp.blankMethod();
        newScoringTemp.fillCategory();
        newScoringTemp.StageDelete();
        newScoringTemp.executeTestBatch();
        newScoringTemp.cloneFn();
        newScoringTemp.cancel();
        newScoringTemp.validate();
        newScoringTemp.edi();
        newScoringTemp.getIsScopeMatch();
        newScoringTemp.populateAllValues();
        //newScoringTemp.executeTestBatch();
        //newScoringTemp.duplicatecheck();
        //newScoringTemp.findMinKPIValues();
        //newScoringTemp.findMaxKPIValues();
        
        Test.StopTest();
    }
    */
 }