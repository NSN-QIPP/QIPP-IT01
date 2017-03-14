@isTest (seeAllData=false)
private class SPE2overrideEditScoringTemplateTest{
   static testMethod void SPE2overrideEditScoringTemplateTest1(){
    
    Test.StartTest();
    Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
    User u = new User(Alias ='standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
    insert u; 
    Group g = new Group(Name ='SPE1.0 User Group',
                    DeveloperName = 'unit_test_group',
                    Type = 'Regular');
    insert g;  
    GroupMember gm= new GroupMember();
    gm.GroupId =g.id;
    gm.UserOrGroupId = u.id;  
    insert gm;   
    System.runAs(u){   
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
        scoringTemplate.OwnerId =u.id;
        update scoringTemplate;    
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(scoringTemplate); 
    SPE2overrideEditScoringTemplate speoverride = new SPE2overrideEditScoringTemplate(sc);
    speoverride.RecordOwnerId =scoringTemplate.OwnerId;
    speoverride.populateEditScoringTemplate();  
    PageReference existScoreTempPage =  Page.SPE_NewScoringTemplate;
    Test.setCurrentPage(existScoreTempPage); 
    }
    Test.StopTest();
  }
  static testMethod void SPE2overrideEditScoringTemplateTest2(){
    Test.StartTest();
    
    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
    User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe1');
    insert u;
    Group g = new Group(Name = 'SPE2.0 User Group',
                    DeveloperName = 'unit_test_group',
                    Type = 'Regular');
    insert g;  
    GroupMember gm= new GroupMember();
    gm.GroupId =g.id;
    gm.UserOrGroupId = u.id;  
    insert gm; 
    System.runAs(u){  
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
        scoringTemplate.OwnerId =u.id;
        update scoringTemplate;    
    Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(scoringTemplate); 
    SPE2overrideEditScoringTemplate speoverride = new SPE2overrideEditScoringTemplate(sc);
    speoverride.populateEditScoringTemplate(); 
    PageReference newScoringTempPage =  Page.SPE2_1_NewScoringTemplate;
    Test.setCurrentPage(newScoringTempPage);
    }
    Test.StopTest();
  } 
   static testMethod void SPE2overrideEditScoringTemplateTest3(){
    
    Test.StartTest();
    Profile p = [SELECT Id FROM Profile WHERE Name='SPE Key Users']; 
    User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
    insert u; 
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
        scoringTemplate.OwnerId =u.id;
        update scoringTemplate;      
        try{
            Apexpages.Standardcontroller sc =  new Apexpages.Standardcontroller(scoringTemplate); 
            SPE2overrideEditScoringTemplate speoverride = new SPE2overrideEditScoringTemplate();
            speoverride.populateEditScoringTemplate();  
            PageReference newSPETempPage =  Page.SPE2_NewSPETemplate;
            Test.setCurrentPage(newSPETempPage); 
        }catch(exception e){}
    
    Test.StopTest();
  } 
}