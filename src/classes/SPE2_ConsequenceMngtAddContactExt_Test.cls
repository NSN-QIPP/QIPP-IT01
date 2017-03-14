@isTest(SeeAllData = false)
Public class SPE2_ConsequenceMngtAddContactExt_Test{
      
    public static testmethod void SPE2_ConsequenceMngtAddContactExtTest1(){
    test.startTest();
    
    SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition2.Level__c = '1';
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        kpiDefinition2.Description__c = 'Test';
        kpiDefinition2.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition2.OperationalType__c = 'Leading PI';
        kpiDefinition2.GeoScope__c = 'All Markets';
        kpiDefinition2.categoryscope__c = 'All Categories';
        kpiDefinition2.BUScope__c = 'All Products';
        kpiDefinition2.UoM__c = 'max';
        kpiDefinition2.Group1__c = 'Cost';
        kpiDefinition2.Group2__c = 'Hard';
        kpiDefinition2.Type__c = 'Operational';
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG'; 
        kpiDefinition2.IsHighBetter__c=true;
        kpiDefinition2.CorrectiveActionInstructions__c = 'ABCXYZ';
        insert kpiDefinition2;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator' OR Name='SPE']; 
        User u = new User(Alias ='standt', Email='abc@gmail.com.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
        insert u; 
        
        Account acc= new Account();
        acc.Name='Test Account' ;
        insert acc;

        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.AccountID = acc.id;
        cont.Email= 'test@atos.net';
        cont.Password__c = '12345';
        cont.isInternal__c = true;
        insert cont;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc.Id;
        CCcon1.Email = 'Test1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc.Id;
        CCcon2.Email = 'test2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc.Id;
        CCcon3.Email = 'test3@atos.net';
       
        
        system.debug('ConatctPassword:' +cont.Password__c);
        system.debug('ConatctId:' +cont.id);
        
        Account supplier = SPE_TestObjectCreator.CreateSupplier('Atos');
        insert supplier; 

        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.CategoryManager__c = u.id;
        SPEConMngmnt.Contact__c  = cont.id;
        SPEConMngmnt.CategoryCluster__c = 'All Category Areas';
        SPEConMngmnt.CategoryArea__c = 'All Category Areas';
        SPEConMngmnt.CategoryGroup__c = 'All Category Groups';
        SPEConMngmnt.Category__c = 'All Categories';
        SPEConMngmnt.Market__c = 'All Markets';
        SPEConMngmnt.MarketUnit__c ='All Market Units';
        SPEConMngmnt.Country__c = 'All Countries'; 
        SPEConMngmnt.Project__c = 'All Projects';
        SPEConMngmnt.BusinessUnit__c = 'All Business Units';
        SPEConMngmnt.BusinessLine__c = 'All Business Lines';
        SPEConMngmnt.Product__c =  'All Products';
        SPEConMngmnt.Supplier__c = supplier.id; 
        SPEConMngmnt.SupplierManagerContact__c = CCcon1.id;
        insert SPEConMngmnt;        
        
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Consequence Management';
        businessystrole.Object_Name__c = 'Consequence Management';
        businessystrole.Business_Role__c ='Supplier Quality Manager (SQM);Category Manager;Supplier Manager;Country Manager;Project Manager;Regional Category Manager;Nokia Global Account Manager;Supplier Account Manager;Supplier – Lead Quality Manager;Supplier – Quality Engineer';
        businessystrole.System_Role__c ='Developed Ticket Owner;Phase Out Manager;Auditor';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;        
         
        list<SPE_CategoryInfo__c> lstCategory= new list<SPE_CategoryInfo__c>(); 
        for(integer i=0; i<20 ; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c ();
            catInfo.Supplier__c = supplier.ID;
            catInfo.BusinessLine__c = 'All Business Lines';
            catInfo.Business_Role__c = 'Category Manager';
            catInfo.BusinessUnit__c ='All Business Units';
            catInfo.Category__c ='All Categories';
            catInfo.CategoryCluster__c ='All Category Areas';
            catInfo.CategoryGroup__c = 'All Category Groups';
            catInfo.Contact__c = CCcon1.ID;
            catInfo.Country__c = 'All Countries'; 
            catInfo.Region__c ='All Markets';
            catInfo.SubRegion__c = 'All Market Units';
            catInfo.Product__c = 'All Products';
            catInfo.Project__c = 'All Projects';
            catInfo.System_Role__c = 'Developed Ticket Owner';
            catInfo.CategoryScopeCombination__c = SPEConMngmnt.Market__c+';'+SPEConMngmnt.MarketUnit__c+';'+SPEConMngmnt.Country__c+';'+SPEConMngmnt.Project__c+';'+SPEConMngmnt.CategoryArea__c+';'+SPEConMngmnt.CategoryGroup__c+';'+SPEConMngmnt.Category__c+';'+SPEConMngmnt.BusinessUnit__c+';'+SPEConMngmnt.BusinessLine__c+';'+SPEConMngmnt.Product__c;

         //   insert catInfo;
            
           lstCategory.add(catInfo);
         }
         insert lstCategory;
         ApexPages.currentPage().getParameters().put('Id',SPEConMngmnt.id);
         ApexPages.StandardController sc = new ApexPages.StandardController(SPEConMngmnt);
        
        SPE2_ConsequenceMngtAddContactExt controller = new SPE2_ConsequenceMngtAddContactExt(sc);
        controller.getBusinessList();
        controller.getSystemList();
        controller.closePopup();
        controller.showPopup();
        controller.savecontact();
        controller.closePopup2();
        controller.showPopup2();
        controller.savecontact2();
        controller.con = CCcon3;
        controller.savecontact();
        controller.DEFAULT_PAGE_SIZE = 1;
        controller.showInternalContactOnly();
        controller.firstBtnClick();
        controller.DEFAULT_PAGE_SIZE = 1;
        controller.firstBtnClick();
        controller.nextBtnClick();
        controller.previousBtnClick();
        controller.lastBtnClick();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        controller.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        controller.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        controller.goToPage(); 
        if(controller.maxPages != null){
          controller.pageNumber = controller.maxPages-1;
          controller.nextBtnClick();
        }
        controller.goToPage();
        controller.DEFAULT_PAGE_SIZE2 = 1;
        controller.contactName = '* Contact*';
        controller.doSearch();
        controller.contactName = 'Test Contact1';
        controller.doSearch();
        controller.contactName = 'Test*';
        controller.doSearch();
        controller.DEFAULT_PAGE_SIZE2 = 1;
        controller.firstBtnClick2();
        controller.nextBtnClick2();
        controller.previousBtnClick2();
        controller.lastBtnClick2();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        controller.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        controller.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        controller.goToPage2(); 
        if(controller.maxPages2 != null){
          controller.pageNumber2 = controller.maxPages2-1;
          controller.nextBtnClick2();
        }
        controller.goToPage2();
        controller.addContact();
        ApexPages.currentPage().getParameters().put('contactId',CCcon2.id);
        controller.addContact();
        controller.cancel();
        controller.showInternalContactOnly2();
    test.stopTest();    
    
    }
}