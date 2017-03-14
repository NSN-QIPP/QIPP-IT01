@isTest
public class StrategicSupplierOverviewControllerTest {

    static testMethod void StrategicSupplier(){
Profile p = [Select Id from profile where Name = 'System Administrator'];
  User Usr23 = new User(FirstName = 'test', LastName = 'user', Email = 'test.user@gmail.com', Alias = 'test', ProfileID = p.id , EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles', UserName='testUser@SPEorg.com');
    insert Usr23;

    Profile p1 = [Select Id from profile where Name = 'Supplier Manager'];
User supMgr = new User(FirstName = 'test', LastName = 'user', Email = 'test.user123@gmail.com', Alias = 'test123', ProfileID = p1.id , EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles', UserName='testUser123@SPEorg.com');
    insert supMgr; 
    
    system.debug('***'+supMgr.id);
/*PageReference pageRef = Page.MySupplierCompleteView;
Test.setCurrentPage(pageRef);
ApexPages.currentPage().getParameters().put('Id',Usr23.id);
new MySupplierDataController().getContactDetails(Usr23.id);
MySupplierDataController mspdcontroller = new MySupplierDataController();*/
System.runas(Usr23){ 
        Account acc01 = new Account();
        acc01.Name = 'Test Account01';
        acc01.Model__c='Integrate';
        acc01.LSM__c = supMgr.id;
    	acc01.Lead_Category_Manager1__c = Usr23.id;
        acc01.SAM_Innovation_Manager__c= Usr23.id;
        acc01.Supplier_Governance_Manager__c = Usr23.id;
        acc01.Sponsor__c = Usr23.id;
        acc01.Supplier_Segmentation__c ='Leverage';
        acc01.Nokia_as_a_Customer__c = 'Develop';
        acc01.Business_Groups__c = 'sample';
        acc01.Business_Owner__c=Usr23.id;
    	acc01.Actual_Spend__c = 19.5;
		acc01.Unique_Id__c = 'XYZ';    
    acc01.Classification__c = 'Focus';
        insert acc01;
        
List<PI_Param__c> piPramaList=new List<PI_Param__c>();
PI_Param__c ppc=new PI_Param__c();
        ppc.Supplier_Name__c = acc01.id;
        ppc.Quality__c=40;
        ppc.Commercial__c=40;
        ppc.Delivery__c=40;
        ppc.Innovation__c=40;
        ppc.Relationship__c=40;
        //insert ppc;
        piPramaList.add(ppc);
		insert piPramaList;
        
	StrategicSupplierOverviewController sso= new StrategicSupplierOverviewController();
        
        Simrelatedsupplierscontroller srs = new Simrelatedsupplierscontroller();
        srs.search1();
        srs.search();
        srs.display();
    
    ApexPages.currentPage().getParameters().put('id',acc01.id);
    ApexPages.StandardController accpg = new ApexPages.StandardController(acc01);
    SupplierPerformanceRadarChartController rad = new SupplierPerformanceRadarChartController(accpg);
    rad.generatePIParamData();
}
    }

}