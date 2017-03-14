@IsTest(SeeAllData=false)

public with sharing class SPE_intermediateUploadBatch_Test

{
static testmethod void testSPE_intermediateUploadBatch()

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
    
    SPE_PIDefinition__c PIData = new SPE_PIDefinition__c();
    
    //************************Changes For Encryption********************//
        //PIData.Name='Test it 2015';
        PIData.PI_Title__c ='Test it 2015';
    //************************END********************//
    
    PIData.PIAbbreviation__c='123456';
    PIData.ValuesType__c='Number';
    PIData.UoM__c='Number';
    PIData.DataAcquisitionMethod__c='Data Load';
    PIData.GeoScope__c='All Markets';
    PIData.CategoryScope__c='All Categories';
    PIData.BUScope__c='All Products';
    PIData.PIUploadDuedate__c= Date.newInstance(2016,10,10);
    
    insert PIData;
        
    SPE_PiValueTemp__c PIvalTemp = new SPE_PiValueTemp__c();
    
    PIvalTemp.CurrencyIsoCode='EUR';
    PIvalTemp.PIDefination__c=PIData.Id;
    
    Insert PIvalTemp;
    
    List<SPE_PiValueTemp__c > lstpiValueTemp = new List<SPE_PiValueTemp__c >();
    lstpiValueTemp.add(PIvalTemp);
    
    system.assertEquals('EUR',PIvalTemp.CurrencyIsoCode);
    String s = 'ABCD';
    String isExecuteinFinish = 'AsynchExecution';
     
    test.starttest();
    PageReference pageRef = Page.SPE_intermediateUpload;
    Test.setCurrentPage(pageRef);
    
    SPE_intermediateUploadBatch InterUpldEXT = new SPE_intermediateUploadBatch(s,isExecuteinFinish);
    
    SchedulableContext sc = Null;
    Database.BatchableContext BC;
    
    InterUpldEXT.execute(sc);
    InterUpldEXT.start(BC);
    InterUpldEXT.finish(BC);
   
    SPE_intermediateUploadBatch InterUpldEXT1 = new SPE_intermediateUploadBatch(s);
    InterUpldEXT1.execute(BC,lstpiValueTemp);
    InterUpldEXT1.start(BC);
    InterUpldEXT1.finish(BC);
    test.stoptest();
}

}