@IsTest(SeeAllData=false)
Public with sharing class SPE_VerifyEnterpriseIDExtTest{
 static testmethod void SPE_VerifyEnterpriseIDExtTest(){
   
 
     SPE_PIDefinition__c pd= new SPE_PIDefinition__c();
     
     //********************Changes For Encryption******************// 
     //pd.name= 'test pd';
     pd.PI_Title__c = 'test pd';
     //********************END******************//   
     pd.PIAbbreviation__c='pabb';   
     pd.ValuesType__c='Number';
     pd.UoM__c='number';
     pd.DataAcquisitionMethod__c='Survey Question';
     pd.GeoScope__c='Market';
     pd.CategoryScope__c='Category Area';
     pd.BUScope__c='Product';
     
     insert pd;
     
     //********************Changes For Encryption******************// 
     //system.assertequals(pd.name,'test pd');
     system.assertequals(pd.PI_Title__c ,'test pd');
     //********************END******************//   
          
     SPE_PiValueTemp__c pv = new SPE_PiValueTemp__c ();
        
     pv.PIDefination__c= pd.ID;
     pv.enterpriseId__c='MO';
     pv.Cluster__c='Test';
     pv.market__c='Test';
     pv.product__c='Test';
     pv.BusinessUnit__c='Test';
     pv.BusinessLine__c='Test';
     insert pv;  
      
     SPE_VerifyEnterpriseIDExt vex = new SPE_VerifyEnterpriseIDExt();
     vex.updateEIDs();
     vex.validateCategory();
     vex.BatchUpload();
     vex.skiptoNxtVal();  
   
   }
   
}