@IsTest(SeeAllData=false)

public with sharing class SPE_intermediateUploadEXTTest

{
//public String query{get;set;}

static testmethod void SPE_intermediateUploadEXTTest()

{
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
    PicklistDefaultValues__c PickdefVal = new PicklistDefaultValues__c();
     PickdefVal.Name='Test';
     PickdefVal.Business_Line__c='test';
     PickdefVal.Business_Unit__c='test';
     PickdefVal.Category__c='test';
     PickdefVal.Category_Area__c='test';
     PickdefVal.Category_Group__c='test';
     PickdefVal.Country__c='test';
     PickdefVal.Market__c='test';
     PickdefVal.Market_Unit__c='test';
     PickdefVal.Product__c='test';
     PickdefVal.Project__c='test';
     
     insert PickdefVal;
    
    String query;    
    Database.QueryLocator QL;
    Database.BatchableContext BC;
    System.SchedulableContext sc;
    
    SPE_PIDefinition__c PIData = new SPE_PIDefinition__c();
    
    //*********************Changes For Encryption******************//  
            //PIData.Name='Test it 2015';
            PIData.PI_Title__c ='Test it 2015';
    //*********************END******************//
    
    PIData.PIAbbreviation__c='123456';
    PIData.ValuesType__c='Number';
    PIData.UoM__c='Number';
    PIData.DataAcquisitionMethod__c='Data Load';
    PIData.GeoScope__c='All Markets';
    PIData.CategoryScope__c='All Categories';
    PIData.BUScope__c='All Products';
    PIData.PIUploadDuedate__c=Date.newInstance(2016,10,10);
    
    insert PIData;
    
    //System.assertEquals(PIData.id,null);
    
    SPE_PiValueTemp__c PIvalTemp = new SPE_PiValueTemp__c();
    
    PIvalTemp.CurrencyIsoCode='EUR';
    PIvalTemp.PIDefination__c=PIData.Id;
    
    Insert PIvalTemp;
    
    List<SPE_PiValueTemp__c > lstpiValueTemp = new List<SPE_PiValueTemp__c >();
    lstpiValueTemp.add(PIvalTemp);
    
    system.assertEquals('EUR',PIvalTemp.CurrencyIsoCode);
    
    test.starttest();
    PageReference pageRef = Page.SPE_intermediateUpload;
    Test.setCurrentPage(pageRef);
    String uniqueID = 'ABCD';
    ID batchprocessid1;
    
    SPE_intermediateUploadEXT InterUpldEXT = new SPE_intermediateUploadEXT();
    
    InterUpldEXT.startbatch();
    InterUpldEXT.asynchBatchRun(); 
    InterUpldEXT.BatchJobDetail();
    
    PageReference pageRef1 = Page.SPE_VerifyEnterpriseID;
    Test.setCurrentPage(pageRef1);
        
    SPE_intermediateUploadEXT InterUpldEXT1 = new SPE_intermediateUploadEXT();
    SPE_intermediateUploadBatch dtBatch = new SPE_intermediateUploadBatch(uniqueID);
    batchprocessid1 = database.executebatch(dtBatch,1);
    
    InterUpldEXT1.statuss1 = 'Completed';
    InterUpldEXT1.statuss = 'Completed';
    InterUpldEXT1.ch1 = 2;
    InterUpldEXT1.startbatch();
    InterUpldEXT1.BatchJobDetail();
 
    test.stoptest();
}

}