@isTest(SeeAllData = true)
Public class SPE_CM_DisplayButtonsExt_Test{
      
    public static testmethod void SPE_CM_DisplayButtonsExtTest1(){
        test.startTest();
        
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
        cont.Accountid= acc.id;
        cont.Email= 'abc@gmail.com';
        cont.Password__c = '12345';
        insert cont;
        system.debug('ConatctPassword:' +cont.Password__c);
        system.debug('ConatctId:' +cont.id);
        
        SPE_ConsequenceManagement__c SPEConMngmnt1 = new SPE_ConsequenceManagement__c();
        SPEConMngmnt1.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt1.Contact__c  = cont.id;
        SPEConMngmnt1.TicketStatus__c ='abc';
        SPEConMngmnt1.SPE_Status__c = 'Active';
        SPEConMngmnt1.KPIDetails__c = 'Test_KPI Details';
        SPEConMngmnt1.ProblemDescriptionDetails__c = 'PDD';
        SPEConMngmnt1.AnalysisFindings__c = 'AF';       
        SPEConMngmnt1.InternalContainmentifany__c = 'IC';
        SPEConMngmnt1.ManufactureAcceptsFault__c = 'MAF';
        SPEConMngmnt1.ManufacturerComments__c = 'MrC';
        SPEConMngmnt1.DevelopmentExpectation__c = 'DevExp';       
        SPEConMngmnt1.OwnerApproval__c = 'OwnApp';
        SPEConMngmnt1.OwnerIsMfrInvolvedinSPECase__c = 'OIMfrIinSc';
        SPEConMngmnt1.OwnerComments__c = 'Ocm';
        SPEConMngmnt1.X3DManufacturerResponse__c = 'X3DMR';
        SPEConMngmnt1.X3DSupplierContributors__c = 'X3DSC';
        SPEConMngmnt1.X3DOwnerResponse__c = 'X3DOR';
        SPEConMngmnt1.X3DOwnerApproveReject__c = 'X3DOAR';
        SPEConMngmnt1.X4DSupplierResponse__c = 'X4DSR';
        SPEConMngmnt1.X4DSupplierContributors__c = 'X4DSC';      
        SPEConMngmnt1.X4DOwnerResponse__c = 'X4DOR';
        SPEConMngmnt1.X4DOwnerApproveReject__c = 'X4DOAR';
        SPEConMngmnt1.X5DSupplierResponse__c = 'X5DSR';
        SPEConMngmnt1.X5DSupplierContributors__c = 'X5DSC';
        SPEConMngmnt1.X5DOwnerResponse__c = 'X5DOR';
        SPEConMngmnt1.X5DOwnerApproveReject__c = 'X5DOAR';
        SPEConMngmnt1.Summary_spe__c = 'SPEConMgmt_View';
        SPEConMngmnt1.CancelledNTFStatusExplanation__c = 'CNTFStatExp';
        SPEConMngmnt1.Supplier__c = acc.id; 
        SPEConMngmnt1.CategoryManager__c = u.id;
         //SPEConMngmnt.KPIName__c = 'Atos_testKPI';
         SPEConMngmnt1.InitialKPIValue__c = 2;
        // SPEConMngmnt.RCAInstructions__c = 'RCAins';
         SPEConMngmnt1.InitialKPIScore1__c = 3;
        // SPEConMngmnt.PreventiveActionInstructions__c = 'PAI';
         insert SPEConMngmnt1;
        
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
        SPEConMngmnt.Supplier__c = acc.id; 
        SPEConMngmnt.CategoryManager__c = u.id;
        SPEConMngmnt.MasterCM__c = SPEConMngmnt1.id;
         //SPEConMngmnt.KPIName__c = 'Atos_testKPI';
         SPEConMngmnt.InitialKPIValue__c = 2;
        // SPEConMngmnt.RCAInstructions__c = 'RCAins';
         SPEConMngmnt.InitialKPIScore1__c = 3;
        // SPEConMngmnt.PreventiveActionInstructions__c = 'PAI';
         insert SPEConMngmnt;
         
        ApexPages.StandardController st = new ApexPages.StandardController(SPEConMngmnt);
        SPE_CM_DisplayButtonsExt dsplyButton = new  SPE_CM_DisplayButtonsExt(st);
        dsplyButton.approvedButton();
        dsplyButton.cancelledButton();
        dsplyButton.rejectedButton();
        dsplyButton.closeButton();
        dsplyButton.openButton();
        dsplyButton.continueOnWatchButton();
        dsplyButton.deLinkButton();
        dsplyButton.noTroubleFoundButton();
        dsplyButton.deleteButton();
        test.stopTest();
        
        
       } 
        
         
}