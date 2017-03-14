@IsTest(SeeAllData=false)

public with sharing class SPEPIUploaderExtension_k1Test

{

    static testmethod void SPEPIUploaderExtension_k1Test()
    {
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
     Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
       System.RunAs(u){ 
        
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        
        SPE_PIDefinition__c PIData = new SPE_PIDefinition__c();
        
        PIData.PI_Title__c='Test it finally';
        PIData.PIAbbreviation__c='123456';
        PIData.ValuesType__c='Number';
        PIData.UoM__c='3';
        PIData.DataAcquisitionMethod__c='Data Load';
        PIData.GeoScope__c='All Markets';
        PIData.CategoryScope__c='All Categories';
        PIData.BUScope__c='All Products';
        PIData.PIUploadDuedate__c= Date.newInstance(2016,10,10);
        PIData.ValuesType__c='Number';
        
        
         
        insert PIData;
        
        SPE_PIDefinition__c PIDataList = new SPE_PIDefinition__c();
        
        PIDataList = [select id from SPE_PIDefinition__c where id = :PIData.id];
        system.assertEquals(PIDataList.id == PIData.id, true);
        
        PIData.LifecycleStage__c='Pilot';
        
        update PIData;
        
        system.debug('<<<<<<<<<<<<<<PIDATA>>>>>>>>>>>>'+PIdata);
        
        
        SPE_PIValues__c PIVal = new SPE_PIValues__c();
    
        PIVal.PIDefination__c=PIData.id;
        PIVal.EnterpriseID__c= acc1.EnterpriseId__c;
        PIVal.Period__c=System.today();
        PIVal.NumberValue__c=777.00;
        try{
            insert PIVal;
            }
        Catch(Exception e){
        }
        
        system.debug('<<<<<<<<<<<<<<   PIVALUE>>>>>>>>>>>>'+PIVal);
        
        /********************Insert PI Values Temp*******************/
        
        
        SPE_PiValueTemp__c PIvalTemp = new SPE_PiValueTemp__c();
    
        PIvalTemp.CurrencyIsoCode='EUR';
        PIvalTemp.PIDefination__c=PIData.Id;
        
        insert PIvalTemp;
        
        
        system.debug('<<<<<<<<<<<<<<   PIvalTemp>>>>>>>>>>>>'+PIvalTemp);
        
        
        SPE_Mapping_Template__c MapTemplate = new SPE_Mapping_Template__c();
        MapTemplate.Name='Test it now';
        MapTemplate.CurrencyIsoCode='EUR';
        MapTemplate.Number_Of_Columns_to_Skip__c=2;
        MapTemplate.Number_Of_Rows_to_Skip__c=2;
        
        insert MapTemplate;
        
        SPE_Mapping_Template__c MapTemplateList = new SPE_Mapping_Template__c();
        
        MapTemplateList = [select Id from SPE_Mapping_Template__c where id =:MapTemplate.id];
        system.assertEquals(MapTemplateList.id == MapTemplate.id,true);
        
        ApexPages.currentPage().getParameters().put('id',MapTemplateList.Id);
        
        system.debug('<<<<<<<<<<<<<<   MapValue>>>>>>>>>>>>'+MapTemplateList);
        
        
        /***********************Mapping Values********************/
        
        SPE_Mapping_Values__c MapValue =  new SPE_Mapping_Values__c();  
        MapValue.Mapping_Template__c=MapTemplate.Id;
        MapValue.CurrencyIsoCode='EUR';
        MapValue.Header_value__c='Test';
        MapValue.SPE_IsScreenInput__c = true;
            
        insert MapValue;
        
        
        PageReference pageRef = Page.SPEPIUploader;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',PIData.Id);
                
        Apexpages.standardcontroller ctr =  new apexpages.standardcontroller(PIData);
        SPEPIUploaderExtension_k1 UpldExt = new SPEPIUploaderExtension_k1(ctr);
        
        SPEPIUploaderExtension_k1.fillAdditionalDataWrapper wrapperTest = new SPEPIUploaderExtension_k1.fillAdditionalDataWrapper();
        
        UpldExt.objSPEMT=Maptemplate;
        UpldExt.objSPEMTSelected=Maptemplate;
        UpldExt.objSPEMTNew=Maptemplate;
        UpldExt.objSPEPIValues =PIVal;
        UpldExt.objSPEMVEditPopUp=MapValue;
        UpldExt.objSPEMV=MapValue;
        UpldExt.isValidated=True;
        UpldExt.isHeaderColMissing=False;
        UpldExt.isDefaultFieldsValidated=true;
        UpldExt.defVals='';
        UpldExt.erroredFields='';
        UpldExt.isDefaultFieldsAvailable='false';
        UpldExt.strHeadersToAppend='tempS';
        UpldExt.strFinalHeaders='';
        UpldExt.existingHeaders='';
        UpldExt.headerVals='';
        UpldExt.headerValsFinal='';
        UpldExt.isValidatedUpdate=true;
        UpldExt.fetchTemplateDetails();
        UpldExt.fetchTemplateDetails1();
        UpldExt.fetchTemplateDetailsPopUp();
        UpldExt.setHiddenFldVals();
        UpldExt.saveNClose();
        UpldExt.validateFileHeaders();
        UpldExt.createNewMT();
        UpldExt.fillData();
        UpldExt.updateNewMT();
        UpldExt.saveNewTemplate();
        UpldExt.setDefValues();
        
    }
 }
}