@isTest(SeeAllData = false)
private class SPE2_CategoryInfoExtTest{
        
     static testMethod void createNewCatInfoForSaveTest1(){ 
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;
         
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';       
        insert cont;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('ABC');
        insert supplier; 
        
        SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c ();
        catInfo.Supplier__c = supplier.ID;
        catInfo.BusinessLine__c = 'All Business Lines';
        catInfo.Business_Role__c = 'System Administrator';
        catInfo.BusinessUnit__c ='All Business Units';
        catInfo.Category__c ='All Categories';
        catInfo.CategoryCluster__c ='All Category Areas';
        catInfo.CategoryGroup__c = 'All Category Groups';
        catInfo.Contact__c = cont.ID;
        catInfo.Country__c = 'All Countries'; 
        catInfo.Region__c ='All Markets';
        catInfo.SubRegion__c = 'All Market Units';
        catInfo.Product__c = 'All Products';
        catInfo.Project__c = 'All Projects';
       // catInfo.System_Role__c = 'User'
        insert catInfo;
        
        Test.StartTest();  
        PageReference pageRef = Page.SPE2_SPECategoryInfo;
        Test.setCurrentPage(pageRef);                      
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE2_CategoryInfoEXT catInfo1 = new SPE2_CategoryInfoEXT(stCon);
        catInfo1.getMarketValues();
        catInfo1.getMarketUnitValues();
        catInfo1.fillMarketUnit();
        catInfo1.getCountryValues();
        catInfo1.fillCountry();
        catInfo1.getProjectValues();
        catInfo1.fillProject();
        catInfo1.getBusinessUnitValues();
        catInfo1.getBusinesLineValues();
        catInfo1.fillBusinessLine();
        catInfo1.getProductValues();
        catInfo1.showProdVals();
        catInfo1.fillProduct();
        catInfo1.getCategoryAreaValues();
        catInfo1.getCategoryGroupValues();
        catInfo1.fillCategoryGroup();
        catInfo1.getCategoryValues();
        catInfo1.fillCategory();
        catInfo1.blankMethod();
        catInfo1.save();
        catInfo1.cancel();
        
        Test.StopTest();
    }
    
    static testMethod void createNewCatInfoForSaveTest2(){ 
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;
         
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';       
        insert cont;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('ABC');
        insert supplier; 
        
        SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c ();
        catInfo.Supplier__c = supplier.ID;
        catInfo.BusinessLine__c = 'All Business Lines';
        catInfo.Business_Role__c = 'System Administrator';
        catInfo.BusinessUnit__c ='All Business Units';
        catInfo.Category__c ='All Categories';
        catInfo.CategoryCluster__c ='All Category Areas';
        catInfo.CategoryGroup__c = 'All Category Groups';
        catInfo.Contact__c = cont.ID;
        catInfo.Country__c = 'All Countries'; 
        catInfo.Region__c ='All Markets';
        catInfo.SubRegion__c = 'All Market Units';
        catInfo.Product__c = 'All Products';
        catInfo.Project__c = 'All Projects';
       // catInfo.System_Role__c = 'User'
        insert catInfo;
        
        Test.StartTest();  
        PageReference pageRef = Page.SPE2_SPECategoryInfo;
        Test.setCurrentPage(pageRef);                      
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(new SPE_CategoryInfo__c());
        SPE2_CategoryInfoEXT catInfo1 = new SPE2_CategoryInfoEXT(stCon);
        catInfo1.getMarketValues();
        catInfo1.getMarketUnitValues();
        catInfo1.fillMarketUnit();
        catInfo1.getCountryValues();
        catInfo1.fillCountry();
        catInfo1.getProjectValues();
        catInfo1.fillProject();
        catInfo1.getBusinessUnitValues();
        catInfo1.getBusinesLineValues();
        catInfo1.fillBusinessLine();
        catInfo1.getProductValues();
        catInfo1.showProdVals();
        catInfo1.fillProduct();
        catInfo1.getCategoryAreaValues();
        catInfo1.getCategoryGroupValues();
        catInfo1.fillCategoryGroup();
        catInfo1.getCategoryValues();
        catInfo1.fillCategory();
        catInfo1.blankMethod();
        catInfo1.save();
        catInfo1.cancel();
        
        Test.StopTest();
        
     }
      static testMethod void createNewCatInfoForSaveTest3()
      { 
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;
         
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';       
        insert cont;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('ABC');
        insert supplier; 
        
        SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c ();
        catInfo.Supplier__c = supplier.ID;
        catInfo.BusinessLine__c = 'All Business Lines';
        catInfo.Business_Role__c = 'System Administrator';
        catInfo.BusinessUnit__c ='All Business Units';
        catInfo.Category__c ='All Categories';
        catInfo.CategoryCluster__c ='All Category Areas';
        catInfo.CategoryGroup__c = 'All Category Groups';
        catInfo.Contact__c = cont.ID;
        catInfo.Country__c = 'All Countries'; 
        catInfo.Region__c ='All Markets';
        catInfo.SubRegion__c = 'All Market Units';
        catInfo.Product__c = 'All Products';
        catInfo.Project__c = 'All Projects';
       // catInfo.System_Role__c = 'User'
        insert catInfo;
        
        Test.StartTest();  
        PageReference pageRef = Page.SPE2_SPECategoryInfo;
        Apexpages.currentPage().getParameters().put('caVal', 'All Categories');
        
        Test.setCurrentPage(pageRef);                      
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE2_CategoryInfoEXT catInfo1 = new SPE2_CategoryInfoEXT(stCon);
        
        catInfo1.getCategoryGroupValues();
        
        
        Apexpages.currentPage().getParameters().put('caVal', 'All Categories');
        
        Test.setCurrentPage(pageRef);                      
        Apexpages.Standardcontroller stCon1 =  new Apexpages.Standardcontroller(catInfo);
        SPE2_CategoryInfoEXT catInfo2 = new SPE2_CategoryInfoEXT(stCon1);
        
        catInfo2.getMarketUnitValues();
        catInfo2.getCountryValues();
        catInfo2.fillCountry();
        
        Test.StopTest();
        }
        
 static testMethod void createNewCatInfoForSaveTest4()
      { 
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;
         
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';       
        insert cont;
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('ABC');
        insert supplier; 
        
        SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c ();
        catInfo.Supplier__c = supplier.ID;
        catInfo.BusinessLine__c = 'All Business Lines';
        catInfo.Business_Role__c = 'System Administrator';
        catInfo.BusinessUnit__c ='All Business Units';
        catInfo.Category__c ='All Categories';
        catInfo.CategoryCluster__c ='All Category Areas';
        catInfo.CategoryGroup__c = 'All Category Groups';
        catInfo.Contact__c = cont.ID;
        catInfo.Country__c = 'All Countries'; 
        catInfo.Region__c ='All Markets';
        catInfo.SubRegion__c = 'All Market Units';
        catInfo.Product__c = 'All Products';
        catInfo.Project__c = 'All Projects';
       // catInfo.System_Role__c = 'User'
        insert catInfo;
        
        Test.StartTest();  
        PageReference pageRef = Page.SPE2_SPECategoryInfo;        
        Test.setCurrentPage(pageRef);  
        Apexpages.currentPage().getParameters().put('caVal', 'All Categories');
        Apexpages.currentPage().getParameters().put('cgVal', 'All Category Groups');
        Apexpages.currentPage().getParameters().put('ctVal', 'All Category Areas');
        Apexpages.currentPage().getParameters().put('marketVal', 'All Markets');
        Apexpages.currentPage().getParameters().put('marketUnitVal', 'All Market Units');
        Apexpages.currentPage().getParameters().put('countryVal', 'All Countries');
        Apexpages.currentPage().getParameters().put('buVal', 'All Business Units');
        Apexpages.currentPage().getParameters().put('blVal', 'All Business Lines');
        Apexpages.currentPage().getParameters().put('setCatVal', 'NAM');
        Apexpages.currentPage().getParameters().put('rerenderForm11', 'NAM');
                           
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE2_CategoryInfoEXT catInfo1 = new SPE2_CategoryInfoEXT(stCon);
        
        catInfo1.getCategoryGroupValues();

        Test.setCurrentPage(pageRef);                      
        Apexpages.Standardcontroller stCon1 =  new Apexpages.Standardcontroller(catInfo);
        SPE2_CategoryInfoEXT catInfo2 = new SPE2_CategoryInfoEXT(stCon1);
        
        catInfo2.getMarketUnitValues();
        catInfo2.getCountryValues();
        catInfo2.fillCountry();
        catInfo2.blankMethod();
        
        
        Test.StopTest();
        }

}