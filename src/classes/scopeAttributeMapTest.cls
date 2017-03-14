@isTest (seeAllData=false)
private class scopeAttributeMapTest{
      static testMethod void populateAttributes1(){
           
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
             
           SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
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
            speTemplate.GeoScope__c ='All Markets';            
            speTemplate.Categoryscope__c ='All Category Areas';
            speTemplate.BUScope__c ='All Products';
            insert speTemplate;
            
            SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
            spekpi.KPIDefinition__c=kpiDefinition1.id;
            spekpi.SPETemplate__c=speTemplate.id;
            spekpi.UseLatestKPIVersion__c=True;
            spekpi.Weight__c=100.00;
            
           // upsert spekpi;
           Test.StartTest(); 
           scopeAttributeMap saMap = new scopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(speTemplate);
           
           Test.StopTest();
      }
       static testMethod void populateAttributes2(){
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
             
           SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
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
            kpiDefinition1.lifecyclestage__c='Published';
           // update kpiDefinition1;
          
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
            speTemplate.GeoScope__c ='Market';            
            speTemplate.Categoryscope__c ='Category Area';
            speTemplate.BUScope__c ='Business Unit';
            insert speTemplate;
            
            SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
            spekpi.KPIDefinition__c=kpiDefinition1.id;
            spekpi.SPETemplate__c=speTemplate.id;
            spekpi.UseLatestKPIVersion__c=True;
            spekpi.Weight__c=100.00;
            
           // upsert spekpi;
           Test.StartTest(); 
           scopeAttributeMap saMap = new scopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(speTemplate);
           
           Test.StopTest();
       }
       static testMethod void populateAttributes3(){
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
             
           SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
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
            kpiDefinition1.lifecyclestage__c='Published';
           // update kpiDefinition1;
          
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
            speTemplate.GeoScope__c ='Market Unit';            
            speTemplate.Categoryscope__c ='Category Group';
            speTemplate.BUScope__c ='Business Line';
            insert speTemplate;
            
            SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
            spekpi.KPIDefinition__c=kpiDefinition1.id;
            spekpi.SPETemplate__c=speTemplate.id;
            spekpi.UseLatestKPIVersion__c=True;
            spekpi.Weight__c=100.00;
            
           // upsert spekpi;
           Test.StartTest(); 
           scopeAttributeMap saMap = new scopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(speTemplate);
           
           Test.StopTest();
       }
       static testMethod void populateAttributes4(){
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
             
           SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
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
            kpiDefinition1.lifecyclestage__c='Published';
           // update kpiDefinition1;
          
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
            speTemplate.GeoScope__c ='Country';            
            speTemplate.Categoryscope__c ='Category';
            speTemplate.BUScope__c ='Product';
            insert speTemplate;
            
            SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
            spekpi.KPIDefinition__c=kpiDefinition1.id;
            spekpi.SPETemplate__c=speTemplate.id;
            spekpi.UseLatestKPIVersion__c=True;
            spekpi.Weight__c=100.00;
            
           // upsert spekpi;
           Test.StartTest(); 
           scopeAttributeMap saMap = new scopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(speTemplate);
           
           Test.StopTest();
       }
      static testMethod void populateAttributes5(){
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
             
           SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
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
            kpiDefinition1.lifecyclestage__c='Published';
          // update kpiDefinition1;
          
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
            speTemplate.GeoScope__c ='Project';            
            speTemplate.Categoryscope__c ='All Categories';
            speTemplate.BUScope__c ='Product';
            insert speTemplate;
            
            SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
            spekpi.KPIDefinition__c=kpiDefinition1.id;
            spekpi.SPETemplate__c=speTemplate.id;
            spekpi.UseLatestKPIVersion__c=True;
            spekpi.Weight__c=100.00;
            
           // insert spekpi;
           Test.StartTest(); 
           scopeAttributeMap saMap = new scopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(speTemplate);
           
           Test.StopTest();
       }
}