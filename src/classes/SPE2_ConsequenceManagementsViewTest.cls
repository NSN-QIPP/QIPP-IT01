@isTest(seeAllData=False)
public class SPE2_ConsequenceManagementsViewTest{
    
       static testMethod void SPE2_ConsequenceManagementsViewPositive1(){
       
       //SPE_KPIDefinition__c  kpiObj = new SPE_KPIDefinition__c();
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
        User u = new User(Alias ='standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testuser.com.spe2');
        insert u; 
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';
        cont.Password__c = '12345';
        insert cont;
        system.debug('ConatctPassword:' +cont.Password__c);
        system.debug('ConatctId:' +cont.id);

        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.Contact__c  = cont.id;
        SPEConMngmnt.TicketStatus__c ='abc';
        SPEConMngmnt.SPE_Status__c = 'Active';
        SPEConMngmnt.KPIDetails__c = 'Test_KPI Details';
        SPEConMngmnt.ProblemDescriptionDetails__c = 'PDD';
        SPEConMngmnt.AnalysisFindings__c = 'AF';       
        SPEConMngmnt.InternalContainmentifany__c = 'IC';
        SPEConMngmnt.ManufactureAcceptsFault__c = 'MAF';
        SPEConMngmnt.ManufacturerComments__c = 'MrC';
        SPEConMngmnt.DevelopmentExpectation__c = 'DevExp';       
        SPEConMngmnt.OwnerApproval__c = 'OwnApp';
        SPEConMngmnt.OwnerIsMfrInvolvedinSPECase__c = 'OIMfrIinSc';
        SPEConMngmnt.OwnerComments__c = 'Ocm';
        SPEConMngmnt.X3DManufacturerResponse__c = 'X3DMR';
        SPEConMngmnt.X3DSupplierContributors__c = 'X3DSC';
        SPEConMngmnt.X3DOwnerResponse__c = 'X3DOR';
        SPEConMngmnt.X3DOwnerApproveReject__c = 'X3DOAR';
        SPEConMngmnt.X4DSupplierResponse__c = 'X4DSR';
        SPEConMngmnt.X4DSupplierContributors__c = 'X4DSC';      
        SPEConMngmnt.X4DOwnerResponse__c = 'X4DOR';
        SPEConMngmnt.X4DOwnerApproveReject__c = 'X4DOAR';
        SPEConMngmnt.X5DSupplierResponse__c = 'X5DSR';
        SPEConMngmnt.X5DSupplierContributors__c = 'X5DSC';
        SPEConMngmnt.X5DOwnerResponse__c = 'X5DOR';
        SPEConMngmnt.X5DOwnerApproveReject__c = 'X5DOAR';
        SPEConMngmnt.Summary_spe__c = 'SPEConMgmt_View';
        SPEConMngmnt.CancelledNTFStatusExplanation__c = 'CNTFStatExp';
        SPEConMngmnt.Supplier__c = testAccount.id; 
        SPEConMngmnt.CategoryManager__c = u.id;
         //SPEConMngmnt.KPIName__c = 'Atos_testKPI';
         SPEConMngmnt.InitialKPIValue__c = 2;
        // SPEConMngmnt.RCAInstructions__c = 'RCAins';
         SPEConMngmnt.InitialKPIScore1__c = 3;
        // SPEConMngmnt.PreventiveActionInstructions__c = 'PAI';
         insert SPEConMngmnt;
         system.debug('@@@@@@: '+SPEConMngmnt.Id);
         system.debug('######:' +SPEConMngmnt.Contact__c);
         
        Test.StartTest();  
        PageReference pageRef = Page.SPE2_ConsequenceManagementsView;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',SPEConMngmnt.id);
        SPE2_ConsequenceManagementsView  controller = new SPE2_ConsequenceManagementsView();  
              
        controller.otherConsequenceManagementsticket();        
        controller.enter();
        controller.save1();
        controller.refreshLanguage();
        
        System.Assert(SPEConMngmnt.Contact__c !=null);
        Test.StopTest();
  }   
  
  static testMethod void SPE2_ConsequenceManagementsViewPositive2(){
       
       //SPE_KPIDefinition__c  kpiObj = new SPE_KPIDefinition__c();
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';
        cont.Password__c = null;
        insert cont;
                      
        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.Contact__c  = cont.id;
        SPEConMngmnt.TicketStatus__c ='abc';
        SPEConMngmnt.SPE_Status__c = 'Active';
        SPEConMngmnt.KPIDetails__c = 'Test_KPI Details';
        SPEConMngmnt.ProblemDescriptionDetails__c = 'PDD';
        SPEConMngmnt.AnalysisFindings__c = 'AF';       
        SPEConMngmnt.InternalContainmentifany__c = 'IC';
        SPEConMngmnt.ManufactureAcceptsFault__c = 'MAF';
        SPEConMngmnt.ManufacturerComments__c = 'MrC';
        SPEConMngmnt.DevelopmentExpectation__c = 'DevExp';       
        SPEConMngmnt.OwnerApproval__c = 'OwnApp';
        SPEConMngmnt.OwnerIsMfrInvolvedinSPECase__c = 'OIMfrIinSc';
        SPEConMngmnt.OwnerComments__c = 'Ocm';
        SPEConMngmnt.X3DManufacturerResponse__c = 'X3DMR';
        SPEConMngmnt.X3DSupplierContributors__c = 'X3DSC';
        SPEConMngmnt.X3DOwnerResponse__c = 'X3DOR';
        SPEConMngmnt.X3DOwnerApproveReject__c = 'X3DOAR';
        SPEConMngmnt.X4DSupplierResponse__c = 'X4DSR';
        SPEConMngmnt.X4DSupplierContributors__c = 'X4DSC';      
        SPEConMngmnt.X4DOwnerResponse__c = 'X4DOR';
        SPEConMngmnt.X4DOwnerApproveReject__c = 'X4DOAR';
        SPEConMngmnt.X5DSupplierResponse__c = 'X5DSR';
        SPEConMngmnt.X5DSupplierContributors__c = 'X5DSC';
        SPEConMngmnt.X5DOwnerResponse__c = 'X5DOR';
        SPEConMngmnt.X5DOwnerApproveReject__c = 'X5DOAR';
        SPEConMngmnt.Summary_spe__c = 'SPEConMgmt_View';
        SPEConMngmnt.CancelledNTFStatusExplanation__c = 'CNTFStatExp';
         
        insert SPEConMngmnt;
         system.debug('@@@@@@: '+SPEConMngmnt.Id);
         ApexPages.currentPage().getParameters().put('pwsd',SPEConMngmnt.Password__c);
      //   ApexPages.currentPage().getParameters().put('password','password');

        Test.StartTest();  
        PageReference pageRef = Page.SPE2_ConsequenceManagementsView;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('pswd','12345');
           
        pageRef.getParameters().put('Id',SPEConMngmnt.id);
        SPE2_ConsequenceManagementsView  controller = new SPE2_ConsequenceManagementsView();        
        controller.otherConsequenceManagementsticket();        
        controller.enter();
        controller.save1();
        controller.refreshLanguage();
        
        Test.StopTest();  
  } 
   static testMethod void SPE2_ConsequenceManagementsViewPositive3(){
       
       //SPE_KPIDefinition__c  kpiObj = new SPE_KPIDefinition__c();
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';
        cont.Password__c = '45321';
        insert cont;
                       
        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.Contact__c  = cont.id;
        SPEConMngmnt.TicketStatus__c ='abc';
        SPEConMngmnt.SPE_Status__c = 'Active';
        SPEConMngmnt.KPIDetails__c = 'Test_KPI Details';
        SPEConMngmnt.ProblemDescriptionDetails__c = 'PDD';
        SPEConMngmnt.AnalysisFindings__c = 'AF';       
        SPEConMngmnt.InternalContainmentifany__c = 'IC';
        SPEConMngmnt.ManufactureAcceptsFault__c = 'MAF';
        SPEConMngmnt.ManufacturerComments__c = 'MrC';
        SPEConMngmnt.DevelopmentExpectation__c = 'DevExp';       
        SPEConMngmnt.OwnerApproval__c = 'OwnApp';
        SPEConMngmnt.OwnerIsMfrInvolvedinSPECase__c = 'OIMfrIinSc';
        SPEConMngmnt.OwnerComments__c = 'Ocm';
        SPEConMngmnt.X3DManufacturerResponse__c = 'X3DMR';
        SPEConMngmnt.X3DSupplierContributors__c = 'X3DSC';
        SPEConMngmnt.X3DOwnerResponse__c = 'X3DOR';
        SPEConMngmnt.X3DOwnerApproveReject__c = 'X3DOAR';
        SPEConMngmnt.X4DSupplierResponse__c = 'X4DSR';
        SPEConMngmnt.X4DSupplierContributors__c = 'X4DSC';      
        SPEConMngmnt.X4DOwnerResponse__c = 'X4DOR';
        SPEConMngmnt.X4DOwnerApproveReject__c = 'X4DOAR';
        SPEConMngmnt.X5DSupplierResponse__c = 'X5DSR';
        SPEConMngmnt.X5DSupplierContributors__c = 'X5DSC';
        SPEConMngmnt.X5DOwnerResponse__c = 'X5DOR';
        SPEConMngmnt.X5DOwnerApproveReject__c = 'X5DOAR';
        SPEConMngmnt.Summary_spe__c = 'SPEConMgmt_View';
        SPEConMngmnt.CancelledNTFStatusExplanation__c = 'CNTFStatExp';
         insert SPEConMngmnt;
         system.debug('@@@@@@: '+SPEConMngmnt.Id);
         ApexPages.currentPage().getParameters().put('pwsd',SPEConMngmnt.Password__c);
         system.debug('pswd ::'+SPEConMngmnt.Password__c);
         ApexPages.currentPage().getParameters().put('pwsd','password');

        Test.StartTest(); 
        
        PageReference pageRef = Page.SPE2_ConsequenceManagementsView;                         
        pageRef.getParameters().put('45321',SPEConMngmnt.Password__c);
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id',SPEConMngmnt.id);
        SPE2_ConsequenceManagementsView  controller = new SPE2_ConsequenceManagementsView();        
        controller.otherConsequenceManagementsticket();        
        controller.enter();
        controller.save1();
        controller.refreshLanguage();
        
        Test.StopTest();  
  }
  static testMethod void SPE2_ConsequenceManagementsViewPositive4(){
       
       //SPE_KPIDefinition__c  kpiObj = new SPE_KPIDefinition__c();
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
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        cont.Email= 'abc@gmail.com';
        cont.Password__c = '45321';
        insert cont;
        
      /*  Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
         User u2 = new User(Alias = 'newUser', Email='newuser@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='newuser22@testorg.com');*/
        
       
        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.Contact__c  = cont.id;
        SPEConMngmnt.TicketStatus__c ='abc';
        SPEConMngmnt.SPE_Status__c = 'Active';
        SPEConMngmnt.KPIDetails__c = 'Test_KPI Details';
        SPEConMngmnt.ProblemDescriptionDetails__c = 'PDD';
        SPEConMngmnt.AnalysisFindings__c = 'AF';       
        SPEConMngmnt.InternalContainmentifany__c = 'IC';
        SPEConMngmnt.ManufactureAcceptsFault__c = 'MAF';
        SPEConMngmnt.ManufacturerComments__c = 'MrC';
        SPEConMngmnt.DevelopmentExpectation__c = 'DevExp';       
        SPEConMngmnt.OwnerApproval__c = 'OwnApp';
        SPEConMngmnt.OwnerIsMfrInvolvedinSPECase__c = 'OIMfrIinSc';
        SPEConMngmnt.OwnerComments__c = 'Ocm';
        SPEConMngmnt.X3DManufacturerResponse__c = 'X3DMR';
        SPEConMngmnt.X3DSupplierContributors__c = 'X3DSC';
        SPEConMngmnt.X3DOwnerResponse__c = 'X3DOR';
        SPEConMngmnt.X3DOwnerApproveReject__c = 'X3DOAR';
        SPEConMngmnt.X4DSupplierResponse__c = 'X4DSR';
        SPEConMngmnt.X4DSupplierContributors__c = 'X4DSC';      
        SPEConMngmnt.X4DOwnerResponse__c = 'X4DOR';
        SPEConMngmnt.X4DOwnerApproveReject__c = 'X4DOAR';
        SPEConMngmnt.X5DSupplierResponse__c = 'X5DSR';
        SPEConMngmnt.X5DSupplierContributors__c = 'X5DSC';
        SPEConMngmnt.X5DOwnerResponse__c = 'X5DOR';
        SPEConMngmnt.X5DOwnerApproveReject__c = 'X5DOAR';
        SPEConMngmnt.Summary_spe__c = 'SPEConMgmt_View';
        SPEConMngmnt.CancelledNTFStatusExplanation__c = 'CNTFStatExp';
         insert SPEConMngmnt;
         system.debug('@@@@@@: '+SPEConMngmnt.Id);
        // ApexPages.currentPage().getParameters().put('45321',SPEConMngmnt.Password__c);
         system.debug('pswd ::'+SPEConMngmnt.Password__c);
        // ApexPages.currentPage().getParameters().put('45321','password');

        Test.StartTest(); 
       // System.runAs(u2){
        PageReference pageRef =  ApexPages.currentPage();                       
        pageRef.getParameters().put(cont.Password__c,SPEConMngmnt.Password__c);
        system.debug('password ::'+SPEConMngmnt.Password__c);      
        Test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('Id',SPEConMngmnt.id);
      //  pageRef.getParameters().put('45321','password');
      //  system.AssertEquals('password','password','i m coll');
        
        SPE2_ConsequenceManagementsView  controller = new SPE2_ConsequenceManagementsView();        
        controller.otherConsequenceManagementsticket(); 
        controller.password = [select id, password__c from contact where Id =: cont.id].password__c;       
        controller.enter();
        controller.save1();
        controller.refreshLanguage();
      //  }
        Test.StopTest();  
  }                                  
}