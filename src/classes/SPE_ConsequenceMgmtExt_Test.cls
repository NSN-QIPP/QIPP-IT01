@isTest(seeAllData=False)
public class SPE_ConsequenceMgmtExt_Test {
    static testMethod void SPE_ConsequenceMgmtExt_Test1(){
        
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
         PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
         picklistObj.Name = 'Picklist Default Values';        
         picklistObj.Business_Unit__c = 'All Business Units';
         picklistObj.Business_Line__c = 'All Business Lines';        
         picklistObj.Project__c = 'All Projects';        
         picklistObj.Category_Area__c = 'All Category Areas';
         picklistObj.Category_Group__c = 'All Category Groups';
         picklistObj.Category__c = 'All Categories';                       
         picklistObj.Market__c = 'All Markets';
         picklistObj.Market_Unit__c = 'All Market Units';
         picklistObj.Country__c = 'All Countries';       
         picklistObj.Product__c = 'All Products';              
         lstpicklistObj.add(picklistObj);        
         insert lstpicklistObj;
         
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
        EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
                    
        insert u;     
       // System.RunAs(u){ 
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna1@gmail.com';
        insert con;
        
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
        
        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.Contact__c  = con.id;
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
        SPEConMngmnt.Supplier__c = acc1.id; 
        SPEConMngmnt.CategoryManager__c = u.id;
         //SPEConMngmnt.KPIName__c = 'Atos_testKPI';
         SPEConMngmnt.InitialKPIValue__c = 2;
        // SPEConMngmnt.RCAInstructions__c = 'RCAins';
         SPEConMngmnt.InitialKPIScore1__c = 3;
        // SPEConMngmnt.PreventiveActionInstructions__c = 'PAI';
         insert SPEConMngmnt;
        
        
        PageReference pageRef = Page.SPE_ConsequencesRecordType;
        Test.setCurrentPage(pageRef); 
         
        Test.StartTest();
       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SPEConMngmnt);
        SPE_ConsequenceMgmtExt conmgmt = new SPE_ConsequenceMgmtExt(stcon);
        conmgmt.selectedValue = 'Audit NC';
        conmgmt.doCancel();
        conmgmt.redirect();
       
        Test.StopTest();    
    }
    static testMethod void SPE_ConsequenceMgmtExt_Test2(){
        
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
         PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
         picklistObj.Name = 'Picklist Default Values';        
         picklistObj.Business_Unit__c = 'All Business Units';
         picklistObj.Business_Line__c = 'All Business Lines';        
         picklistObj.Project__c = 'All Projects';        
         picklistObj.Category_Area__c = 'All Category Areas';
         picklistObj.Category_Group__c = 'All Category Groups';
         picklistObj.Category__c = 'All Categories';                       
         picklistObj.Market__c = 'All Markets';
         picklistObj.Market_Unit__c = 'All Market Units';
         picklistObj.Country__c = 'All Countries';       
         picklistObj.Product__c = 'All Products';              
         lstpicklistObj.add(picklistObj);        
         insert lstpicklistObj;
         
         insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
        EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
                    
        insert u;     
       // System.RunAs(u){ 
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'sudeshna1@gmail.com';
        insert con;
        
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
        
        SPE_ConsequenceManagement__c SPEConMngmnt = new SPE_ConsequenceManagement__c();
        SPEConMngmnt.KPITitle__c = 'test SPEConseMangmnt 123';
        SPEConMngmnt.Contact__c  = con.id;
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
       // SPEConMngmnt.Supplier__c = acc1.id; 
        SPEConMngmnt.CategoryManager__c = u.id;
         //SPEConMngmnt.KPIName__c = 'Atos_testKPI';
         SPEConMngmnt.InitialKPIValue__c = 2;
        // SPEConMngmnt.RCAInstructions__c = 'RCAins';
         SPEConMngmnt.InitialKPIScore1__c = 3;
        // SPEConMngmnt.PreventiveActionInstructions__c = 'PAI';
         insert SPEConMngmnt;
        
        
        PageReference pageRef = Page.SPE_ConsequencesRecordType;
        Test.setCurrentPage(pageRef); 
         
        Test.StartTest();       
        Apexpages.currentpage().getparameters().put('supplierId','');
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SPEConMngmnt);
        SPE_ConsequenceMgmtExt conmgmt = new SPE_ConsequenceMgmtExt(stcon);
        conmgmt.selectedValue = 'Audit';
        conmgmt.doCancel();
        conmgmt.redirect();
       
        Test.StopTest();    
    }
}