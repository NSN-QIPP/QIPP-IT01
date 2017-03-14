@isTest

public class Test_SupplirPrfrmnceChartController {

    public static testmethod void generatePIParamDatamethod(){
    
    Profile p = [Select Id from profile where Name = 'System Administrator'];
    
    User Usr = new User(FirstName = 'test', LastName = 'user', Email = 'test.user@gmail.com', Alias = 'test', ProfileID = p.id , EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
             TimeZoneSidKey='America/Los_Angeles', UserName='testUser@SPEorg.com');
    insert Usr;
    
    System.runas(Usr){
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Actual_Spend__c = 1000;
        acc.LE_Spend__c = 500;
        acc.Enterprise_Id__c = 'SupplierTest';
        acc.CategoryAreaSIM__c= 'Delivery Operations (DO)';
        acc.Supplier_Segmentation__c = 'Shop';
        acc.Nokia_as_a_Customer__c = 'Core';
        acc.LSM__c = Usr.id;
        
        insert acc;
        
        
        PI_Param__c Param = new PI_Param__c();
        Param.Supplier_Name__c = acc.id;
        Param.Commercial__c = 89;
        Param.Delivery__c = 56;
        Param.Innovation__c = 89;
        Param.Quality__c = 88;
        Param.Relationship__c = 89;
        insert Param;
        
        ApexPages.currentPage().getParameters().put('id',acc.id);
        ApexPages.standardController stdCon = new ApexPages.standardController(acc);
        SupplierPerformanceRadarChartController Controller = new SupplierPerformanceRadarChartController (stdCon);
        Controller.generatePIParamData();
        for(SupplierPerformanceRadarChartController.RadarData Wrcon : Controller.data){
            
        }
        }
    
    }

}