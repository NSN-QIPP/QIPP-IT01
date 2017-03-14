@isTest
private class MySupplierDataController_Test{

@isTest
private static void MySupplierDataController_Test(){

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



       StakeHolder_Matrix_Supplier_contacts__c c02 = new StakeHolder_Matrix_Supplier_contacts__c();
        c02.FirstName__c='smpleTest';
        c02.Name='lastTest';
        c02.email__c='Test@test.com';
        c02.Business_Group__c = 'sample';
        c02.SupplierName__c= acc01.id;
        c02.phone__c='2345675623';
      //c02.Type_Of_Contact_Picklist__c = 'Supplier';
    insert c02;
    
            
//System.runas(Usr23){  
/*PageReference pageRef = Page.MySupplierCompleteView;
Test.setCurrentPage(pageRef);
ApexPages.currentPage().getParameters().put('Id',Usr23.id); */ 

    MySupplierDataController controller= new MySupplierDataController();
controller.getContactDetails(acc01.id);

ExecutiveSupplierDataController controllerE= new ExecutiveSupplierDataController();
controllerE.getContactDetails(acc01.id);

supplierSpendController SSC = new supplierSpendController();
    
  }  //}//
//System.runas(Usr23){
//Test.startTest();
//PageReference pageRef = Page.MySupplierCompleteView;
//Test.setCurrentPage(pageRef);
//ApexPages.currentPage().getParameters().put('Id',Usr23.id);
//new MySupplierDataController().getContactDetails(Usr23.id);
//Test.stopTest();   
//}


}
}