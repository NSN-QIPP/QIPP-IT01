@isTest (seeAllData=false)
private class SPE_NewSPETemplateExtTest{
    
    
    public static SPE_KPIDefinition__c kpiDefinitionNew;
    
    static testMethod void createSPEKPI()
    {
    
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
        
        //******************Changes For Encryption****************// 
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //******************END****************//
       
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        
        
        
        /*kpiDefinitionNew = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinitionNew.ActualCalculation__c = 'A+B+C';
        kpiDefinitionNew.LifecycleStage__c = 'Published';
        insert kpiDefinitionNew;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Published';
        insert kpiDefinition2;*/
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        
        speTemplate.Name = 'Testing now';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c = 'All Markets';
        speTemplate.SubRegion__c = 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c = 'All Category Areas';
        speTemplate.CategoryGroup__c = 'All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessLine__c ='All Business Units';
        speTemplate.BusinessUnit__c ='All Business Lines';
        speTemplate.Product__c = 'All Products';
        
        insert speTemplate;
        
        
        
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c=kpiDefinition1.id;
        spekpi.SPETemplate__c=speTemplate.id;
        spekpi.UseLatestKPIVersion__c=True;
        spekpi.Weight__c=100.00;
        
        upsert spekpi;
         
         
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemplate);
        
        //Test.startTest();
        
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        //SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate(); 
        
        //SpeTempRecord.addNewKPI();
        //SpeTempRecord.addNewKPI();
        
        
       // SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinitionNew, SpeTempRecord.speTemplate);
       // SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.speTemplate);
        
        //insert SpeTempRecord.SPEKPIMaps[1];
        
        
        
        
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        Apexpages.currentPage().getParameters().put('blVal', 'All Business Units');
        Apexpages.currentPage().getParameters().put('buVal', 'All Business Units');
        
        Apexpages.currentPage().getParameters().put('caVal', '1');
        Apexpages.currentPage().getParameters().put('cgVal', '1');
        Apexpages.currentPage().getParameters().put('rerenderForm11', '1');
        
        
        
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.removeNewKPI();
        
        System.assert(SpeTempRecord.SPEKPIMaps.size() == 1);
        
        SpeTempRecord.Save();
        SpeTempRecord.Cancel();
        SpeTempRecord.getMarketValues();
        SpeTempRecord.getMarketUnitValues();
        SpeTempRecord.fillMarketUnit();
        //SpeTempRecord.fillBusinessLine();
        SpeTempRecord.getCountryValues();
        SpeTempRecord.getProjectValues();
        SpeTempRecord.getBusinessUnitValues();
        
        SpeTempRecord.getBusinesLineValues();
        SpeTempRecord.getProductValues();
        SpeTempRecord.getCategoryAreaValues();
        SpeTempRecord.getCategoryGroupValues();
        SpeTempRecord.getCategoryValues();
        //SpeTempRecord.checkValidation();
        SpeTempRecord.showProdVals();
        SpeTempRecord.blankMethod();
        
        //Test.stopTest();
        
        System.assert(SpeTempRecord.SPETemp.Id != null);
        
        List<SPE_SPEKPIMap__c> insertedKPIDef = [SELECT Id FROM SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplate.Id];
                                                       
        System.assertEquals(insertedKPIDef.size(), 1);
        
      }
      
    static testMethod void updateSPEKPIPositive()
    {
    
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
        
        //******************Changes For Encryption****************// 
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //******************END****************//
       
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        
        
        
        /*kpiDefinitionNew = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinitionNew.ActualCalculation__c = 'A+B+C';
        kpiDefinitionNew.LifecycleStage__c = 'Published';
        insert kpiDefinitionNew;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Published';
        insert kpiDefinition2;*/
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        
        speTemplate.Name = 'Testing now';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c = 'All Markets';
        speTemplate.SubRegion__c = 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c = 'All Category Areas';
        speTemplate.CategoryGroup__c = 'All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessLine__c ='All Business Units';
        speTemplate.BusinessUnit__c ='All Business Lines';
        speTemplate.Product__c = 'All Products';
        
        insert speTemplate;
        
        speTemplate.Stage__c = 'Pilot';
        
        update speTemplate;
        
        speTemplate.Stage__c = 'Published';
        
        update speTemplate;
        
        
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c=kpiDefinition1.id;
        spekpi.SPETemplate__c=speTemplate.id;
        spekpi.UseLatestKPIVersion__c=True;
        spekpi.Weight__c=100.00;
        
        upsert spekpi;
         
         
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemplate);
        
        //Test.startTest();
        
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        //SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate(); 
        
        //SpeTempRecord.addNewKPI();
        //SpeTempRecord.addNewKPI();
        
        
       // SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinitionNew, SpeTempRecord.speTemplate);
       // SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.speTemplate);
        
        //insert SpeTempRecord.SPEKPIMaps[1];
        
        
        
        
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.removeNewKPI();
        
        System.assert(SpeTempRecord.SPEKPIMaps.size() == 1);
        
        SpeTempRecord.Save();
        SpeTempRecord.Cancel();
        //SpeTempRecord.checkValidation();
        
        //Test.stopTest();
        
        System.assert(SpeTempRecord.SPETemp.Id != null);
        
        List<SPE_SPEKPIMap__c> insertedKPIDef = [SELECT Id FROM SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplate.Id];
                                                       
        System.assertEquals(insertedKPIDef.size(), 1);
        
      }     
      
      
    
    static testMethod void UpdateSPEKPIPositive1()
    {   
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
        
        //******************Changes For Encryption****************// 
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //******************END****************//
       
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        insert kpiDefinition2;
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        
        insert speTemplate;
        
        //SPE_SPEKPIMap__c speKPIMaps = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemplate);
        
        //insert speKPIMaps;
        
        SPE_SPEKPIMap__c speKPIMaps= new SPE_SPEKPIMap__c();
        
        speKPIMaps.KPIDefinition__c=kpiDefinition1.id;
        speKPIMaps.SPETemplate__c=speTemplate.id;
        speKPIMaps.UseLatestKPIVersion__c=True;
        speKPIMaps.Weight__c=100.00;
        
        upsert speKPIMaps;
        
        
        insert SPE_TestObjectCreator.CreateProjectMasterData('APAC','South Asia','India','Bharti');
        insert SPE_TestObjectCreator.CreateCategoryData('Global Area','Global Group','Global Category');
        insert SPE_TestObjectCreator.CreateBUBLData('Global BU', 'Global BL', 'Global Product');
        
        insert SPE_TestObjectCreator.CreateDefaultPicklist();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(speTemplate);
        
        /*
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(sc);
        
        SpeTempRecord.SPEKPIMaps[0].KPIDefinition__c = kpiDefinition2.Id;
        
        SpeTempRecord.Save();
        
        SPE_SPEKPIMap__c speKPI = [SELECT KPIDefinition__c
                                   FROM SPE_SPEKPIMap__c 
                                   WHERE SPETemplate__c = : speTemplate.Id];
        
        System.assertEquals(speKPI.KPIDefinition__c, kpiDefinition2.Id);
        
        Apexpages.currentPage().getParameters().put('rowIndex', '0');
        
        SpeTempRecord.removeNewKPI();
        
        System.assertEquals(SpeTempRecord.SPEKPIMaps.size(),0);
        */
    }
    
    static testMethod void createSPEKPINegative()
    {
        
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
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        insert kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        insert kpiDefinition2;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
         
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemplate);
        
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        Test.startTest();
        
        //Testing For Duplicate KPI
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.addNewKPI(); 
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        
        SpeTempRecord.Save();
        
        System.assertEquals(SpeTempRecord.SPETemp.Id,null);
        
        //Testing For Null or Zero Weightage 
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.addNewKPI(); 
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = null;
        
        SpeTempRecord.Save();
        
        System.assertEquals(SpeTempRecord.SPETemp.Id,null);
        
        //Testing For Total Weightage less than or greater than 100 
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.SPEKPIMaps.clear();
        
        SpeTempRecord.addNewKPI();
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 50;
        SpeTempRecord.SPEKPIMaps[1].Weight__c = 40;
        
        SpeTempRecord.Save();
        
        System.assertEquals(SpeTempRecord.SPETemp.Id,null); 
        
        //Testing For Obsolete KPI
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.SPEKPIMaps.clear();
        
        SpeTempRecord.addNewKPI();
        
        SPE_KPIDefinition__c kpiDefinition3 = SPE_TestObjectCreator.CreateKPIDefinition(3);
        kpiDefinition3.LifecycleStage__c = 'Pilot';
        insert kpiDefinition3;
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition3, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 100;
        
        SpeTempRecord.Save();
        
        //System.assertEquals(SpeTempRecord.SPETemp.Id,null);
        
        //Testing For Insert SPE without Some Required Fields
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.SPETemp.Name = null;
        
        SpeTempRecord.SPEKPIMaps.clear();
        
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition3, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 100;
        
        SpeTempRecord.Save();
        
        System.assertEquals(SpeTempRecord.SPETemp.Id,null);
        
        //Testing For Empty KPI Definition 
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.SPEKPIMaps.clear();
        
        SpeTempRecord.addNewKPI();
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.SPETemp);
        
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 50;
        SpeTempRecord.SPEKPIMaps[1].Weight__c = 50;
        
        SpeTempRecord.SPEKPIMaps[0].KPIDefinition__c = null;
        
        SpeTempRecord.Save();
        
        System.assertEquals(SpeTempRecord.SPETemp.Id,null);
        
        Test.stopTest();
    }
    //Testing For SPE_SPETemplateTrigger
    static testMethod void deleteSPETemp()
    {
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
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Stage__c = 'published' ;
        
        insert speTemplate;
        try
        {
        delete speTemplate;
        }
        catch(DmlException e)
        {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
        System.assertNotEquals(speTemplate.Id,null);
    }
    
    static testMethod void insertSPETemp()
    {   
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
        
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Name = null;
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemplate);
        
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        Test.startTest();
        
        SpeTempRecord.SPEKPIMaps.clear();
        
        SpeTempRecord.addNewKPI();
        
        SPE_KPIDefinition__c kpiDefinition3 = SPE_TestObjectCreator.CreateKPIDefinition(3);
        kpiDefinition3.ActualCalculation__c = 'A+B+C';
        kpiDefinition3.LifecycleStage__c = 'Published';
        insert kpiDefinition3;
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition3, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 100;
        
        SpeTempRecord.Save();
        
        SpeTempRecord.cancel();
        
        Test.stopTest();
        
        //System.assertNotEquals(SpeTempRecord.SPETemp.Id,null);
    }
    
    
    static testMethod void updateSPEKPIPositive2()
    {
    
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
        
        //******************Changes For Encryption****************// 
        //kpiDefinition1.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //******************END****************//
       
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        
        
        
        /*kpiDefinitionNew = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinitionNew.ActualCalculation__c = 'A+B+C';
        kpiDefinitionNew.LifecycleStage__c = 'Published';
        insert kpiDefinitionNew;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Published';
        insert kpiDefinition2;*/
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        
        speTemplate.Name = 'Testing now';
        speTemplate.Stage__c = 'Draft';
        speTemplate.Region__c = 'All Markets';
        speTemplate.SubRegion__c = 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        speTemplate.CategoryCluster__c = 'All Category Areas';
        speTemplate.CategoryGroup__c = 'All Category Groups';
        speTemplate.Category__c = 'All Categories';
        speTemplate.BusinessLine__c ='All Business Units';
        speTemplate.BusinessUnit__c ='All Business Lines';
        speTemplate.Product__c = 'All Products';
        
        //insert speTemplate;
        
        //speTemplate.Stage__c = 'Pilot';
        
        //update speTemplate;
        
        speTemplate.Stage__c = 'Published';
        
        //update speTemplate;
        
        
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c=kpiDefinition1.id;
        spekpi.SPETemplate__c=speTemplate.id;
        spekpi.UseLatestKPIVersion__c=True;
        spekpi.Weight__c=100.00;
        
        //upsert spekpi;
        
        
        PageReference pageRef = Page.SPE_NewSPETemplate;
        //pageRef.getParameters().put('id', String.valueOf(testAccountPlanInsert.Id));
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('speTempId', speTemplate.Id);
        //pageRef.getParameters().put('Id', scoringTemplate.Id);
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
        
         
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemplate);
        
        //Test.startTest();
        
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        //SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate(); 
        
        //SpeTempRecord.addNewKPI();
        //SpeTempRecord.addNewKPI();
        
        
       // SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinitionNew, SpeTempRecord.speTemplate);
       // SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.speTemplate);
        
        //insert SpeTempRecord.SPEKPIMaps[1];
        
        
        
        
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.removeNewKPI();
        
        System.assert(SpeTempRecord.SPEKPIMaps.size() == 1);
        
        SpeTempRecord.Save();
        SpeTempRecord.Cancel();
        //SpeTempRecord.checkValidation();
        
        //Test.stopTest();
        
        //System.assert(SpeTempRecord.SPETemp.Id != null);
        
        List<SPE_SPEKPIMap__c> insertedKPIDef = [SELECT Id FROM SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplate.Id];
                                                       
        //System.assertEquals(insertedKPIDef.size(), 1);
        
      }     
    
}