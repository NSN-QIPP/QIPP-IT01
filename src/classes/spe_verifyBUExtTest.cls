@IsTest(SeeAllData=False)

public with sharing class spe_verifyBUExtTest

{

static testmethod void spe_verifyBUExtTest()

{
    test.starttest();  
    
  //*********************Code For Covering the Encryption*************************//  
    Account a = New Account();
    a.Name = 'Test Account';
    a.enterpriseId__c='MO';
    
    insert a;
  //*********************END*************************//  
    
    
    //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
    PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
    picklistObj.Business_Line__c = 'All Business Lines';
    picklistObj.Business_Unit__c = 'All Business Units';
    picklistObj.Category_Area__c = 'All Category Areas';
    picklistObj.Category_Group__c = 'All Category Groups';
    picklistObj.Category__c = 'All Categories';
    picklistObj.Country__c = 'All Countries';
    picklistObj.Market_Unit__c = 'All Market Units';
    picklistObj.Market__c = 'All Markets';
    picklistObj.Name = 'Picklist Default Values';
    picklistObj.Product__c = 'All Products';
    picklistObj.Project__c = 'All Projects';
    
    lstpicklistObj.add(picklistObj);
    
    insert lstpicklistObj;
    
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
    SPE_PIDefinition__c PIData = new SPE_PIDefinition__c();
    
    //******************Changes For Encryption*****************// 
        //PIData.Name='Test it 2015';
        PIData.PI_Title__c ='Test it 2015';
    //******************END*****************//     
    PIData.PIAbbreviation__c='123456';
    PIData.ValuesType__c='Number';
    PIData.UoM__c='3';
    PIData.DataAcquisitionMethod__c='Data Load';
    PIData.GeoScope__c='All Markets';
    PIData.CategoryScope__c='All Categories';
    PIData.BUScope__c='All Products';
    PIData.PIUploadDuedate__c=Date.newInstance(2016,10,10);
    
    insert PIData;
    
    PIData.LifecycleStage__c='Pilot';
    update PIData;
    
    SPE_PiValueTemp__c PIvalTemp = new SPE_PiValueTemp__c();
    
    PIvalTemp.CurrencyIsoCode='EUR';
    PIvalTemp.PIDefination__c=PIData.Id;
    PIvalTemp.enterpriseId__c='MO';
    
    Insert PIvalTemp;
    
    system.assertEquals('EUR',PIvalTemp.CurrencyIsoCode);
     
    spe_verifyBUExt BUExt = new spe_verifyBUExt();
    BUExt.updateBU(); 
    //BUExt.BatchUpload();
    BUExt.skipVal();   
    
    test.stoptest(); 
    
}
}