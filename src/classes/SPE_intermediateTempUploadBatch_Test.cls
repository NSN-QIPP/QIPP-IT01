@IsTest(SeeAllData=false)

public with sharing class SPE_intermediateTempUploadBatch_Test

{
static testmethod void testSPE_intermediateTempUploadBatch()

{
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
    
    Account sup = SPE_TestObjectCreator.CreateSupplier('1234');
    sup.EnterpriseID__c= '3M';
    insert sup;
    
    SPE_PIDefinition__c PIData = new SPE_PIDefinition__c();
    
    PIData.PI_Title__c='Test it 2015';
    PIData.PIAbbreviation__c='123456';
    PIData.ValuesType__c='Number';
    PIData.UoM__c='Number';
    PIData.DataAcquisitionMethod__c='Data Load';
    PIData.GeoScope__c='All Markets';
    PIData.CategoryScope__c='All Categories';
    PIData.BUScope__c='All Products';
    PIData.LifecycleStage__c= 'Draft';
    PIData.PIUploadDuedate__c= Date.newInstance(2016,10,10);
    
    insert PIData;
    
    PIData.LifecycleStage__c= 'Pilot';
    update PIData;
    
    SPE_PIValues__c pivalues = new  SPE_PIValues__c();
        
    pivalues.BusinessUnit__c = 'All Business Units';
    pivalues.BusinessLine__c = 'All Business Lines';
    pivalues.Project__c = 'All Projects';           
    
    pivalues.Cluster__c = 'All Category Areas';
    pivalues.CategoryGroup__c= 'All Category Groups';
    pivalues.Category__c =  'All Categories';                                
    
    pivalues.Region__c='All Markets';
    pivalues.SubRegion__c= 'All Market Units';
    pivalues.Country__c= 'All Countries';
    pivalues.Product__c= 'All Products';
    
    pivalues.EnterpriseID__c= '3M';
    pivalues.Filter1__c= '1';
    pivalues.Filter10__c='2'; 
    pivalues.Filter2__c='3';
    pivalues.Filter3__c= '4';
    pivalues.Filter4__c= '5';
    pivalues.filter5__c='6';
    pivalues.Filter6__c= '7';
    pivalues.Filter7__c= '8';
    pivalues.Filter8__c= '9';
    pivalues.Filter9_del__c='10'; 
    pivalues.IsConverted__c= false;
    pivalues.NumberValue__c= 1;
    pivalues.Period__c= Date.newInstance(2015 , 07 ,3);
    pivalues.Supplier__c= sup.id;
    pivalues.PIDefination__c = PiData.id;
    insert pivalues;
    
    String s = 'ABCD';
        
    SPEIntermediateTempvalue__c PIvalTemp = new SPEIntermediateTempvalue__c();
    
    PIvalTemp.DateFormat__c='Test Date';
    PIvalTemp.PIData__c=PIData.Id;
    PIvalTemp.TempValue__c = 'enterpriseid__c$$$3M@@@country__c$$$All Countries@@@project__c$$$All Projects@@@businessunit__c$$$All Business Units@@@businessline__c$$$All Business Lines@@@product__c$$$All Products@@@categorygroup__c$$$All Category Groups@@@category__c$$$All Categories@@@cluster__c$$$All Category Areas@@@period__c$$$11-15-2015@@@numbervalue__c$$$1@@@###';
    PIvalTemp.UniqueIdentifier__c = s;
    
    Insert PIvalTemp;
    
    List <SPEIntermediateTempvalue__c>  PIvalTemplist = new  List <SPEIntermediateTempvalue__c>();
    PIvalTemplist.add(PIvalTemp);   
         
    test.starttest();
    //PageReference pageRef = Page.SPE_intermediateUpload;
    //Test.setCurrentPage(pageRef);
    
    SPE_intermediateTempUploadBatch InterUpldEXT = new SPE_intermediateTempUploadBatch(s);
    
    SchedulableContext sc = Null;
    Database.BatchableContext BC;
    
    InterUpldEXT.execute(sc);
    InterUpldEXT.start(BC);
    InterUpldEXT.execute(BC,PIvalTemplist);
    InterUpldEXT.finish(BC);
   
    test.stoptest();
}

}