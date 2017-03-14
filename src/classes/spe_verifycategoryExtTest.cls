@IsTest(SeeAllData=false)

    public with sharing class spe_verifycategoryExtTest{
    static testmethod void spe_verifycategoryExtTest()
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
     
     
     SPE_PIDefinition__c pd1= new SPE_PIDefinition__c();
     
     //**************************Changes For Encryption*******************//
     //pd1.name= 'test pd1';
     pd1.PI_Title__c = 'test pd1';
     //**************************END*******************// 
     
     pd1.PIAbbreviation__c='pabb';   
     pd1.ValuesType__c='Number';
     pd1.UoM__c='number';
     pd1.DataAcquisitionMethod__c='Survey Question';
     pd1.GeoScope__c='Country';
     pd1.CategoryScope__c='Category Area';
     pd1.BUScope__c='Product';
     
     insert pd1;
     
     //**************************Changes For Encryption*******************//
     //system.assertequals(pd1.name,'test pd1');
     system.assertequals(pd1.PI_Title__c,'test pd1');
     //**************************END*******************//
       
     pd1.lifecyclestage__c='Published';
     
     update pd1;
     
     
     SPE_PiValueTemp__c PIvalTemp = new SPE_PiValueTemp__c();    
     PIvalTemp.CurrencyIsoCode='EUR';
     PIvalTemp.PIDefination__c=Pd1.Id;
     PIvalTemp.EnterpriseId__c='test';
     PIvalTemp.project__c='test';
     PIvalTemp.country__c='test';
     PIvalTemp.Cluster__c='test';
    
    
     PIvalTemp.product__c='test';
     PIvalTemp.BusinessUnit__c='test';
     PIvalTemp.BusinessLine__c='test';        
     PIvalTemp.ValidateCategory__c =false;
    
     Insert PIvalTemp;
        
        
     SPE_PIDefinition__c pd2= new SPE_PIDefinition__c();
     //**************************Changes For Encryption*******************//
     //pd2.name= 'test pd2';
     pd2.PI_Title__c = 'test pd2';
     //**************************END*******************// 
     
     pd2.PIAbbreviation__c='pabb1';   
     pd2.ValuesType__c='Number';
     pd2.UoM__c='number';
     pd2.DataAcquisitionMethod__c='Survey Question';
     pd2.GeoScope__c='Market Unit';
     pd2.CategoryScope__c='Category Group';
     pd2.BUScope__c='Product';
     
     insert pd2;
  
     //**************************Changes For Encryption*******************//
     //system.assertequals(pd2.name,'test pd2');
     system.assertequals(pd2.PI_Title__c,'test pd2');
     //**************************END*******************//
     
     pd2.lifecyclestage__c='Published';
     
     update pd2;
     
        SPE_PiValueTemp__c PIvalTemp1 = new SPE_PiValueTemp__c();    
        PIvalTemp1.CurrencyIsoCode='EUR';
        PIvalTemp1.PIDefination__c=Pd2.Id;
        PIvalTemp1.EnterpriseId__c='test';
        PIvalTemp1.project__c='test';
        PIvalTemp1.country__c='test';
        PIvalTemp1.Cluster__c='test';
        PIvalTemp1.product__c='test';
        PIvalTemp1.BusinessUnit__c='test';
        PIvalTemp1.BusinessLine__c='test';        
        PIvalTemp1.ValidateCategory__c =false;
        PIvalTemp1.Cluster__c='test';
       
        
        
        Insert PIvalTemp1;
      
      
      SPE_PIDefinition__c pd3= new SPE_PIDefinition__c();
     //**************************Changes For Encryption*******************//
     //pd3.name= 'test pd3';
     pd3.PI_Title__c = 'test pd3';
     //**************************END*******************//
     pd3.PIAbbreviation__c='pabb3';   
     pd3.ValuesType__c='Market';
     pd3.UoM__c='number';
     pd3.DataAcquisitionMethod__c='Survey Question';
     pd3.GeoScope__c='Project';
     pd3.CategoryScope__c='Category';
     pd3.BUScope__c='Product';
     
     insert pd3;
  
     //**************************Changes For Encryption*******************//
     //system.assertequals(pd3.name,'test pd2');
     system.assertequals(pd3.PI_Title__c,'test pd3');
     //**************************END*******************//
     
     pd3.lifecyclestage__c='Published';
     
     update pd3;
     
        SPE_PiValueTemp__c PIvalTemp2 = new SPE_PiValueTemp__c();    
        PIvalTemp2.CurrencyIsoCode='EUR';
        PIvalTemp2.PIDefination__c=Pd3.Id;
        PIvalTemp2.EnterpriseId__c='test';
        PIvalTemp2.project__c='test';
        PIvalTemp2.country__c='test';
        PIvalTemp2.Cluster__c='test';
        PIvalTemp2.product__c='test';
        PIvalTemp2.BusinessUnit__c='test';
        PIvalTemp2.BusinessLine__c='test';        
        PIvalTemp2.ValidateCategory__c =false;
        PIvalTemp2.Cluster__c='test';
        
        
        
        Insert PIvalTemp2;
        
        SPE_PIDefinition__c pd4= new SPE_PIDefinition__c();
     //**************************Changes For Encryption*******************//
     //pd4.name= 'test pd4';
     pd4.PI_Title__c = 'test pd4';
     //**************************END*******************//
     pd4.PIAbbreviation__c='pabb4';   
     pd4.ValuesType__c='Market';
     pd4.UoM__c='number';
     pd4.DataAcquisitionMethod__c='Survey Question';
     pd4.GeoScope__c='Market';
     pd4.CategoryScope__c='Category';
     pd4.BUScope__c='Product';
     
     insert pd4;
  
     //**************************Changes For Encryption*******************//
     //system.assertequals(pd4.name,'test pd4');
     system.assertequals(pd4.PI_Title__c,'test pd4');
     //**************************END*******************//
     
     pd4.lifecyclestage__c='Published';
     
     update pd4;
     
        SPE_PiValueTemp__c PIvalTemp3 = new SPE_PiValueTemp__c();    
        PIvalTemp3 .CurrencyIsoCode='EUR';
        PIvalTemp3 .PIDefination__c=Pd4.Id;
        PIvalTemp3 .EnterpriseId__c='test';
        PIvalTemp3 .project__c='test';
        PIvalTemp3 .country__c='test';
        PIvalTemp3 .Cluster__c='test';
        PIvalTemp3 .product__c='test';
        PIvalTemp3 .BusinessUnit__c='test';
        PIvalTemp3 .BusinessLine__c='test';        
        PIvalTemp3 .ValidateCategory__c=false;
        PIvalTemp3.Cluster__c='test';
       
        
        
        Insert PIvalTemp3 ;
        
        spe_verifycategoryExt vcx = new spe_verifycategoryExt();
        
        vcx.updateCat();
        vcx.validateGeography();
        vcx.BatchUpload();
        vcx.skiptoNxtVal();
}
}