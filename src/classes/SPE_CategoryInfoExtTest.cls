@isTest
private class SPE_CategoryInfoExtTest{
   
    static testMethod void createNewCatInfoForSaveTest_Supp(){   
        Account supplier = SPE_TestObjectCreator.CreateSupplier('priya');
        insert supplier; 
        SPE_CategoryInfo__c catInfo = SPE_TestObjectCreator.CreateCategoryInfo();
        catInfo.Supplier__c = supplier.ID;
        insert catInfo;
        
        PicklistDefaultValues__c picklistDefaultValues = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert picklistDefaultValues;
        
        //Contact contact = SPE_TestObjectCreator.CreateContact('Burghate');
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE_CategoryInfoEXT catInfo1 = new SPE_CategoryInfoEXT(stCon);
        catInfo1.save();
    }
    
    static testMethod void createNewCatInfoForSaveTest_Con(){    
        Contact con = SPE_TestObjectCreator.CreateContact('Burghate');
        con.Email = 'priyaatos@nokia.com';
        insert con; 
        SPE_CategoryInfo__c catInfo = SPE_TestObjectCreator.CreateCategoryInfo();
        catInfo.Contact__c = con.ID;
        insert catInfo;
        
        PicklistDefaultValues__c picklistDefaultValues = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert picklistDefaultValues;
        
        //Contact contact = SPE_TestObjectCreator.CreateContact('Burghate');
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE_CategoryInfoEXT catInfo1 = new SPE_CategoryInfoEXT(stCon);
        catInfo1.save();
    }
    
    static testMethod void createNewCatInfoForCancelTest_Supp(){   
        Account supplier = SPE_TestObjectCreator.CreateSupplier('priya');
        insert supplier; 
        SPE_CategoryInfo__c catInfo = SPE_TestObjectCreator.CreateCategoryInfo();
        catInfo.Supplier__c = supplier.ID;
        insert catInfo;
        
        PicklistDefaultValues__c picklistDefaultValues = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert picklistDefaultValues;
        
        //Contact contact = SPE_TestObjectCreator.CreateContact('Burghate');
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE_CategoryInfoEXT catInfo1 = new SPE_CategoryInfoEXT(stCon);
        catInfo1.cancel();
    }
    
     static testMethod void createNewCatInfoForCancelTest_Con(){    
        Contact con = SPE_TestObjectCreator.CreateContact('Burghate');
        con.Email = 'testingSPE@atos.net';
        insert con; 
        SPE_CategoryInfo__c catInfo = SPE_TestObjectCreator.CreateCategoryInfo();
        catInfo.Contact__c = con.ID;
        insert catInfo;
        
        PicklistDefaultValues__c picklistDefaultValues = SPE_TestObjectCreator.CreateDefaultPicklist();
        insert picklistDefaultValues;
        
        //Contact contact = SPE_TestObjectCreator.CreateContact('Burghate');
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(catInfo);
        SPE_CategoryInfoEXT catInfo1 = new SPE_CategoryInfoEXT(stCon);
        catInfo1.cancel();
    }
}