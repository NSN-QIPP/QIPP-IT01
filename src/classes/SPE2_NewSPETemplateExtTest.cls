@isTest (seeAllData=false)
private class SPE2_NewSPETemplateExtTest{

    static testMethod void createSPETemplatePositive(){      
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
        
       // insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       // SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
        //update kpiDefinition1;   
        
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
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';      
        insert speTemplate;
    
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();               
        spekpi.KPIDefinition__c=kpiDefinition1.id;
        spekpi.SPETemplate__c=speTemplate.id;
        spekpi.UseLatestKPIVersion__c=True;
        spekpi.Weight__c=100.00;                                
        insert spekpi;
        
       /* SPE_SPEKPIMap__c spekpicloned = new SPE_SPEKPIMap__c();               
        spekpicloned.KPIDefinition__c=kpiDefinition1.id;
        spekpicloned.SPETemplate__c=speTemplatecloned.id;
        spekpicloned.UseLatestKPIVersion__c=True;
        spekpicloned.Weight__c=100.00;                                
        insert spekpicloned ;*/
                        
        Test.StartTest();
                
        Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(speTemplate);      
        SPE2_NewSPETemplateExt speTempRecord = new SPE2_NewSPETemplateExt(sc);
        
        PageReference pageRef = Page.SPE2_NewSPETemplate;
        Test.setCurrentPage(pageRef); 
        speTempRecord.save();       
        pageRef.getParameters().put('isClone', '');        
        speTempRecord.addNewKPI();
  //      speTempRecord.removeNewKPI();        
        pageRef.getParameters().put('rowIndex', '1');
        pageRef.getParameters().put('indexNum', '1');
        speTempRecord.InitialiseScopeMap();
        speTempRecord.assignMinScope();
        speTempRecord.chkScopeLevel();
     //   speTempRecord.clone();
        speTempRecord.cancel();       
        speTempRecord.removeNewKPI();
        speTempRecord.displayKPIdetails();
        
        System.assert(SpeTempRecord.SPETemp.Id != null);
        List<SPE_SPEKPIMap__c> insertedKPIDef = [SELECT Id FROM SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplate.Id];
        
        SPE_SPEKPIMap__c spekpi1 = new SPE_SPEKPIMap__c();               
        spekpi1.KPIDefinition__c=kpiDefinition1.id;
        spekpi1.SPETemplate__c=speTemplate.id;
        spekpi1.UseLatestKPIVersion__c=True;
        spekpi1.Weight__c=100.00;                                
        upsert spekpi1;
        
        speTempRecord.addNewKPI();
        speTempRecord.InitialiseScopeMap();
        speTempRecord.assignMinScope();
        speTempRecord.chkScopeLevel();
        speTempRecord.save();
                                                       
        Test.StopTest();
      }
      static testMethod void updateSPETemplatePositive(){
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
         
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();       
        
        Test.StartTest();
        
        Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(speTemplate);  
        SPE2_NewSPETemplateExt SpeTempRecord = new SPE2_NewSPETemplateExt(sc);
        PageReference pageRef = Page.SPE2_NewSPETemplate;
        Test.setCurrentPage(pageRef); 
        SpeTempRecord.Save();
        SpeTempRecord.addNewKPI();                    
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        SpeTempRecord.Cancel();
      //  SpeTempRecord.removeNewKPI();     
        List<SPE_SPEKPIMap__c> insertedKPIDef = [SELECT Id FROM SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplate.Id];                                                       
        Test.stopTest();
      }     
      
     static testMethod void createSPEKPINegative(){
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
        
       // insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.ActualCalculation__c = 'A+B+C';
        kpiDefinition1.LifecycleStage__c = 'Published';
        insert kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = SPE_TestObjectCreator.CreateKPIDefinition(2);
        kpiDefinition2.ActualCalculation__c = 'A+B+C';
        kpiDefinition2.LifecycleStage__c = 'Published';
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
        kpiDefinition3.LifecycleStage__c = 'Obsolete';
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
    
    
    static testMethod void insertspeTempCloned()
    {
    
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
        
       // insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        PicklistDefaultValues__c defaultPicklist = SPE_TestObjectCreator.CreateDefaultPicklist();
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       // SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
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
        kpiDefinition1.lifecyclestage__c='Pilot';
        update kpiDefinition1;
        
        kpiDefinition1.lifecyclestage__c='Published';
        //update kpiDefinition1; 
        
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
        speTemplate.GeoScope__c = 'All Markets';
        speTemplate.Categoryscope__c ='All Categories';
        speTemplate.BUScope__c = 'All Products';      
        insert speTemplate;               
        
        SPE_SPETemplate__c speTemplatecloned = new SPE_SPETemplate__c();
        speTemplatecloned.Name = 'Testing now Cloned';
        speTemplatecloned.Stage__c = 'Draft';
        speTemplatecloned.Region__c = 'All Markets';
        speTemplatecloned.SubRegion__c = 'All Market Units';
        speTemplatecloned.Country__c = 'All Countries';
        speTemplatecloned.Project__c = 'All Projects';
        speTemplatecloned.CategoryCluster__c = 'All Category Areas';
        speTemplatecloned.CategoryGroup__c = 'All Category Groups';
        speTemplatecloned.Category__c = 'All Categories';
        speTemplatecloned.BusinessLine__c ='All Business Units';
        speTemplatecloned.BusinessUnit__c ='All Business Lines';
        speTemplatecloned.Product__c = 'All Products';  
        speTemplatecloned.GeoScope__c = 'All Markets';
        speTemplatecloned.Categoryscope__c ='All Categories';
        speTemplatecloned.BUScope__c = 'All Products';      
        insert speTemplatecloned;
                       
        SPE_SPEKPIMap__c spekpicloned = new SPE_SPEKPIMap__c();               
        spekpicloned.KPIDefinition__c=kpiDefinition1.id;
        spekpicloned.SPETemplate__c=speTemplatecloned.id;
        spekpicloned.UseLatestKPIVersion__c=True;
        spekpicloned.Weight__c=100.00;                                
        insert spekpicloned ;
                        
        Test.StartTest();
                
        PageReference pageRef = Page.SPE2_NewSPETemplate;
        Test.setCurrentPage(pageRef); 
        Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(speTemplatecloned);    
        SPE2_NewSPETemplateExt speTempRecord = new SPE2_NewSPETemplateExt(sc);

        ApexPages.currentPage().getParameters().put('isClone','TRUE');
        speTempRecord.save();    
        pageRef.getParameters().put('isClone', 'abcd');      
        speTempRecord.addNewKPI();      
        pageRef.getParameters().put('rowIndex', '1');
        pageRef.getParameters().put('indexNum', '1');
        speTempRecord.InitialiseScopeMap();
        speTempRecord.assignMinScope();
        speTempRecord.chkScopeLevel();
        speTempRecord.cancel();       
        speTempRecord.removeNewKPI();
        speTempRecord.displayKPIdetails();
        
        System.assert(SpeTempRecord.SPETemp.Id != null);
        List<SPE_SPEKPIMap__c> insertedKPIDef = [SELECT Id FROM SPE_SPEKPIMap__c WHERE SPETemplate__c =:speTemplatecloned.Id];
        
        SPE_SPEKPIMap__c spekpi1 = new SPE_SPEKPIMap__c();               
        spekpi1.KPIDefinition__c=kpiDefinition1.id;
        spekpi1.SPETemplate__c=speTemplatecloned.id;
        spekpi1.UseLatestKPIVersion__c=True;
        spekpi1.Weight__c=100.00;                                
        upsert spekpi1;
        
        speTempRecord.addNewKPI();
        speTempRecord.InitialiseScopeMap();
        speTempRecord.assignMinScope();
        speTempRecord.chkScopeLevel();
        speTempRecord.save();
                                                       
        Test.StopTest();
}
}