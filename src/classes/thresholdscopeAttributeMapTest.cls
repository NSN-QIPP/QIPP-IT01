@isTest (seeAllData=false)
private class thresholdscopeAttributeMapTest{
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
             
           SPE_KPIDefinition__c kpiDef = new SPE_KPIDefinition__c();
            kpiDef.KPI_Title__c = 'Test KPI Definition 123';
            kpiDef.AbbreviatedName__c = 'TKPIDe1';
            kpiDef.Level__c = '1';
            kpiDef.LifecycleStage__c = 'Draft';
            kpiDef.Description__c = 'Test';
            kpiDef.MissingDatalogic__c = 'Logic1';
            kpiDef.OperationalType__c = 'Leading PI';
            kpiDef.GeoScope__c = 'All Markets';
            kpiDef.categoryscope__c = 'All Categories';
            kpiDef.BUScope__c = 'All Products';
            kpiDef.UoM__c = 'max';
            kpiDef.Group1__c = 'Cost';
            kpiDef.Group2__c = 'Hard';
            kpiDef.Type__c = 'Operational';
            kpiDef.FrequencyinMonth__c = '2';
            kpiDef.ScheduledDate__c = system.today().addDays(20);
            kpiDef.VerNumber__c = 0;
            insert kpiDef;
            
           /* kpiDef.ActualCalculation__c = 'A+B+C';
            kpiDef.lifecyclestage__c='Published';
            update kpiDef;
             */      
           Test.StartTest(); 
           thresholdscopeAttributeMap saMap = new thresholdscopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(kpiDef);
           
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
             
           SPE_KPIDefinition__c kpiDef = new SPE_KPIDefinition__c();
            kpiDef.KPI_Title__c = 'Test KPI Definition 123';
            kpiDef.AbbreviatedName__c = 'TKPIDe1';
            kpiDef.Level__c = '1';
            kpiDef.LifecycleStage__c = 'Draft';
            kpiDef.Description__c = 'Test';
            kpiDef.MissingDatalogic__c = 'Logic1';
            kpiDef.OperationalType__c = 'Leading PI';
            kpiDef.GeoScope__c = 'Market';
            kpiDef.categoryscope__c = 'Category Area';
            kpiDef.BUScope__c = 'Business Unit';
            kpiDef.UoM__c = 'max';
            kpiDef.Group1__c = 'Cost';
            kpiDef.Group2__c = 'Hard';
            kpiDef.Type__c = 'Operational';
            kpiDef.FrequencyinMonth__c = '2';
            kpiDef.ScheduledDate__c = system.today().addDays(20);
            kpiDef.VerNumber__c = 0;
            insert kpiDef;
            
           /* kpiDef.ActualCalculation__c = 'A+B+C';
            kpiDef.lifecyclestage__c='Published';
            update kpiDef;
             */        
           Test.StartTest(); 
           thresholdscopeAttributeMap saMap = new thresholdscopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(kpiDef);
           
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
             
           SPE_KPIDefinition__c kpiDef = new SPE_KPIDefinition__c();
            kpiDef.KPI_Title__c = 'Test KPI Definition 123';
            kpiDef.AbbreviatedName__c = 'TKPIDe1';
            kpiDef.Level__c = '1';
            kpiDef.LifecycleStage__c = 'Draft';
            kpiDef.Description__c = 'Test';
            kpiDef.MissingDatalogic__c = 'Logic1';
            kpiDef.OperationalType__c = 'Leading PI';
            kpiDef.GeoScope__c = 'Market Unit';
            kpiDef.categoryscope__c = 'Category Group';
            kpiDef.BUScope__c = 'Business Line';
            kpiDef.UoM__c = 'max';
            kpiDef.Group1__c = 'Cost';
            kpiDef.Group2__c = 'Hard';
            kpiDef.Type__c = 'Operational';
            kpiDef.FrequencyinMonth__c = '2';
            kpiDef.ScheduledDate__c = system.today().addDays(20);
            kpiDef.VerNumber__c = 0;
            insert kpiDef;
            
           /* kpiDef.ActualCalculation__c = 'A+B+C';
            kpiDef.lifecyclestage__c='Published';
            update kpiDef;
             */      
           Test.StartTest(); 
           thresholdscopeAttributeMap saMap = new thresholdscopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(kpiDef);
           
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
             
           SPE_KPIDefinition__c kpiDef = new SPE_KPIDefinition__c();
            kpiDef.KPI_Title__c = 'Test KPI Definition 123';
            kpiDef.AbbreviatedName__c = 'TKPIDe1';
            kpiDef.Level__c = '1';
            kpiDef.LifecycleStage__c = 'Draft';
            kpiDef.Description__c = 'Test';
            kpiDef.MissingDatalogic__c = 'Logic1';
            kpiDef.OperationalType__c = 'Leading PI';
            kpiDef.GeoScope__c = 'Country';
            kpiDef.categoryscope__c = 'Category';
            kpiDef.BUScope__c = 'Product';
            kpiDef.UoM__c = 'max';
            kpiDef.Group1__c = 'Cost';
            kpiDef.Group2__c = 'Hard';
            kpiDef.Type__c = 'Operational';
            kpiDef.FrequencyinMonth__c = '2';
            kpiDef.ScheduledDate__c = system.today().addDays(20);
            kpiDef.VerNumber__c = 0;
            insert kpiDef;
            
          /*  kpiDef.ActualCalculation__c = 'A+B+C';
            kpiDef.lifecyclestage__c='Published';
            update kpiDef;
            */        
           Test.StartTest(); 
           thresholdscopeAttributeMap saMap = new thresholdscopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(kpiDef);
           
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
             
           SPE_KPIDefinition__c kpiDef = new SPE_KPIDefinition__c();
            kpiDef.KPI_Title__c = 'Test KPI Definition 123';
            kpiDef.AbbreviatedName__c = 'TKPIDe1';
            kpiDef.Level__c = '1';
            kpiDef.LifecycleStage__c = 'Draft';
            kpiDef.Description__c = 'Test';
            kpiDef.MissingDatalogic__c = 'Logic1';
            kpiDef.OperationalType__c = 'Leading PI';
            kpiDef.GeoScope__c = 'Project';
            kpiDef.categoryscope__c = 'All Categories';
            kpiDef.BUScope__c = 'Product';
            kpiDef.UoM__c = 'max';
            kpiDef.Group1__c = 'Cost';
            kpiDef.Group2__c = 'Hard';
            kpiDef.Type__c = 'Operational';
            kpiDef.FrequencyinMonth__c = '2';
            kpiDef.ScheduledDate__c = system.today().addDays(20);
            kpiDef.VerNumber__c = 0;
            insert kpiDef;
            
            /*kpiDef.ActualCalculation__c = 'A+B+C';
            kpiDef.lifecyclestage__c='Published';
            update kpiDef;
              */      
           Test.StartTest(); 
           thresholdscopeAttributeMap saMap = new thresholdscopeAttributeMap();
           saMap.initializeMapValue();
           saMap.qualifyScopeAttributes(kpiDef);
           
           Test.StopTest();
       }
}