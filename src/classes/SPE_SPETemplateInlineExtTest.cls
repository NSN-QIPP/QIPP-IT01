@isTest(seeAllData=false)
public  class SPE_SPETemplateInlineExtTest 
{
    static testMethod void createInlinePage()
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
        
        //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
        //*********************END******************//
        
        kpiDefinition1.AbbreviatedName__c = 'TestDef';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Aggregation__c = 'SUM';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.Group1__c = 'Quality';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.Master_KPI__c = null;
        Database.SaveResult srList = Database.insert(kpiDefinition1, false);
        for(Database.Error err : srList .getErrors()) {
            System.debug('The following error has occurred.');                   
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
        }

        kpiDefinition1.LifecycleStage__c = 'Pilot';
        
        update kpiDefinition1;
        
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.Group1__c = 'Delivery';
        kpiDefinition2.Group2__c = 'soft';
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Draft';
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'SUM';
        kpiDefinition2.ScheduledDate__c= Date.newInstance(2016,10,15);
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
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
        //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemp;
        
        //-------------SPE Template created------
        speTemp.Stage__c ='Pilot';
        update speTemp; 
        
        
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.KPI_Target__c = 10;
        spekpi.Weight__c = 100;
        insert spekpi;
        
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemp);
        
        
        
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.addNewKPI();
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 50;
        SpeTempRecord.SPEKPIMaps[1].Weight__c = 50;
        
        SpeTempRecord.SPEKPIMaps[0].UseLatestKPIVersion__c = false;
        SpeTempRecord.SPEKPIMaps[1].UseLatestKPIVersion__c = false;
        
        SpeTempRecord.Save();
        
        Test.startTest();
        
        SPE_SPETemplateInlineExt speInlineExt = new SPE_SPETemplateInlineExt(new Apexpages.Standardcontroller(speTemp));
        
        Test.stopTest();
    }
    
    static testMethod void createInlinePage2()
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
        
        //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
        //*********************END******************//
        
        kpiDefinition1.AbbreviatedName__c = 'TestDef';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Aggregation__c = 'SUM';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.Group1__c = 'Quality';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.Master_KPI__c = null;
        kpiDefinition1.Group1__c = 'Quality';
        kpiDefinition1.Group2__c = 'Hard';
        Database.SaveResult srList = Database.insert(kpiDefinition1, false);
        for(Database.Error err : srList .getErrors()) {
            System.debug('The following error has occurred.');                   
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
        }

        kpiDefinition1.LifecycleStage__c = 'Pilot';
        
        update kpiDefinition1;
        
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.Group1__c = 'Delivery';
        kpiDefinition2.Group2__c = 'soft';
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Draft';
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'SUM';
        kpiDefinition2.ScheduledDate__c= Date.newInstance(2016,10,15);
        insert kpiDefinition2;
        
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        update kpiDefinition2;
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
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
        //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
        insert speTemp;
        
        //-------------SPE Template created------
        speTemp.Stage__c ='Pilot';
        update speTemp; 
        
        
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.KPI_Target__c = 10;
        spekpi.Weight__c = 100;
        insert spekpi;
        
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speTemp);
        
        
        ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);
        SPE_NewSPETemplateExt SpeTempRecord = new SPE_NewSPETemplateExt(stCon);
        
        SpeTempRecord.SPETemp =  SPE_TestObjectCreator.CreateSPETemplate();
        
        SpeTempRecord.addNewKPI();
        SpeTempRecord.addNewKPI();
        
        SpeTempRecord.SPEKPIMaps[0] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1, SpeTempRecord.SPETemp);
        SpeTempRecord.SPEKPIMaps[1] = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition2, SpeTempRecord.SPETemp);
        
        SpeTempRecord.SPEKPIMaps[0].Weight__c = 50;
        SpeTempRecord.SPEKPIMaps[1].Weight__c = 50;
        
        SpeTempRecord.SPEKPIMaps[0].UseLatestKPIVersion__c = false;
        SpeTempRecord.SPEKPIMaps[1].UseLatestKPIVersion__c = false;
        
        SpeTempRecord.Save();
        
        Test.startTest();
        
        SPE_SPETemplateInlineExt speInlineExt = new SPE_SPETemplateInlineExt(new Apexpages.Standardcontroller(speTemp));
        
        Test.stopTest();
    }
}