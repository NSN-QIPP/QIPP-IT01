@IsTest(SeeAllData=false)

    public with sharing class SPE_PiValueTempValidateRecordsTest{
    static testmethod void SPE_PiValueTempValidateRecordsTest()
    {
    
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
    
     SPE_ProjectMaster__c promaster = new SPE_ProjectMaster__c();
     promaster.Name='test';
     promaster.CBT__c='test';
     promaster.Country__c='test';
     promaster.CT__c='test';
     promaster.Market__c='test';
     promaster.MarketUnit__c='test';
     promaster.Project__c='test';
     promaster.Region__c='test';
     
     
     insert promaster;
     
     
     SPE_BUBL__c bubl = new SPE_BUBL__c();
     bubl.BusinessLine__c='test';
     bubl.BusinessUnit__c='test';
     bubl.Product__c='test';
     bubl.ProductCode__c='test';
     insert bubl;
     
     
     SPE_CategoryMaster__c Catmaster = new SPE_CategoryMaster__c();
     Catmaster .Category__c='test';
     Catmaster .Cluster__c='test';
     Catmaster .Group__c='test';
     
     insert Catmaster;
     
     
     account acc= new account();
     acc.name='testing account';
     acc.enterpriseid__c='MO';
     
     insert acc;
     
     
/**************************************Enterprise Transform Table*******************************************************************************/      
     
     SPE_EnterpriseIDTransformTable__c EntTranstbl = new SPE_EnterpriseIDTransformTable__c();
     EntTranstbl .FromValue__c='test';
     EntTranstbl .ToValue__c=acc.id;
     
     insert EntTranstbl;
     
/**************************************Geo Transform Table*******************************************************************************/ 
     SPE_Geo_Transform_Table__c GeoTransTbl = new SPE_Geo_Transform_Table__c ();
     GeoTransTbl.FromValue__c='test';     
     GeoTransTbl.ToValue__c=promaster.id;
     GeoTransTbl.Transform__c='Market';
     insert GeoTransTbl;
     
     SPE_Geo_Transform_Table__c GeoTransTbl1 = new SPE_Geo_Transform_Table__c ();
     GeoTransTbl1.FromValue__c='test axa1';     
     GeoTransTbl1.ToValue__c=promaster.id;
     GeoTransTbl1.Transform__c='Market Unit';
     insert GeoTransTbl1;
     
     
     SPE_Geo_Transform_Table__c GeoTransTbl2 = new SPE_Geo_Transform_Table__c ();
     GeoTransTbl2.FromValue__c='test axa2';     
     GeoTransTbl2.ToValue__c=promaster.id;
     GeoTransTbl2.Transform__c='Country';
     insert GeoTransTbl2;
     
      SPE_Geo_Transform_Table__c GeoTransTbl3 = new SPE_Geo_Transform_Table__c ();
     GeoTransTbl3.FromValue__c='test axa3';     
     GeoTransTbl3.ToValue__c=promaster.id;
     GeoTransTbl3.Transform__c='Project';
     insert GeoTransTbl3;



/**************************************Category Transform Table*******************************************************************************/ 

     SPE_Category_Transform_Table__c CatTransTbl = new SPE_Category_Transform_Table__c();
     CatTransTbl .FromValue__c='test';     
     CatTransTbl .ToValue__c=Catmaster.id;
     CatTransTbl .Transform__c='Category Area';
     insert CatTransTbl ;
     
     
     SPE_Category_Transform_Table__c CatTransTbl1 = new SPE_Category_Transform_Table__c();
     CatTransTbl1 .FromValue__c='test 11';     
     CatTransTbl1 .ToValue__c=Catmaster.id;
     CatTransTbl1 .Transform__c='Category Group';
     insert CatTransTbl1 ;
     
     
     
     SPE_Category_Transform_Table__c CatTransTbl2 = new SPE_Category_Transform_Table__c();
     CatTransTbl2 .FromValue__c='test 12';     
     CatTransTbl2 .ToValue__c=Catmaster.id;
     CatTransTbl2 .Transform__c='Category';
     insert CatTransTbl2 ;
     
     

/**************************************Product  Transform Table*******************************************************************************/      
     
     SPE_Product_Transform_Table__c ProdTransTbl = new SPE_Product_Transform_Table__c ();
     ProdTransTbl .FromValue__c='test 11';     
     ProdTransTbl .ToValue__c=bubl.id;
     ProdTransTbl .Transform__c='Business Unit';
     insert ProdTransTbl ;
     
     SPE_Product_Transform_Table__c ProdTransTbl1 = new SPE_Product_Transform_Table__c ();
     ProdTransTbl1 .FromValue__c='test 12';     
     ProdTransTbl1 .ToValue__c=bubl.id;
     ProdTransTbl1 .Transform__c='Business Line';
     insert ProdTransTbl1 ;
     
     SPE_Product_Transform_Table__c ProdTransTbl2 = new SPE_Product_Transform_Table__c ();
     ProdTransTbl2 .FromValue__c='test 13';     
     ProdTransTbl2 .ToValue__c=bubl.id;
     ProdTransTbl2 .Transform__c='Product';
     insert ProdTransTbl2 ;
          
     
     
/**************Category='Category' & category__c!=null , GeoScope__c='Project' & project__c!= null******************************************/
     
     
     SPE_PIDefinition__c pd1= new SPE_PIDefinition__c();
     
   //**********************Changes For Encryption******************//  
     //pd1.name= 'test pd1';
     pd1.PI_Title__c = 'test pd1';
   //**********************END******************//  
     
     pd1.PIAbbreviation__c='pabb';   
     pd1.ValuesType__c='Number';
     pd1.UoM__c='number';
     pd1.DataAcquisitionMethod__c='Survey Question';
     pd1.GeoScope__c='Project';
     pd1.CategoryScope__c='Category';
     pd1.BUScope__c='Product';
     
     insert pd1;
     
  //**********************Changes For Encryption******************//
     //system.assertequals(pd1.name,'test pd1');
     system.assertequals(pd1.PI_Title__c,'test pd1');
  //**********************END******************//
     
       SPE_PiValueTemp__c PIvalTemp1 = new SPE_PiValueTemp__c();    
        PIvalTemp1 .CurrencyIsoCode='EUR';
        PIvalTemp1 .PIDefination__c=Pd1.Id;
        PIvalTemp1 .EnterpriseId__c='MO';
        PIvalTemp1 .project__c='test';
        //PIvalTemp1 .country__c='test';
        //PIvalTemp1 .Cluster__c='test';
        PIvalTemp1 .Category__c='test';
        PIvalTemp1 .product__c='test';
        PIvalTemp1 .BusinessUnit__c='test';
        PIvalTemp1 .BusinessLine__c='test';        
        PIvalTemp1 .ValidateCategory__c =false;
        PIvalTemp1 .Verified_Geo__c=true;
        PIvalTemp1 .Verified_BU__c=false;
        PIvalTemp1 .VerrifiedEnterpriseID__c=true;
        Insert PIvalTemp1 ;
        
        PIvalTemp1 .EnterpriseId__c='Test';
        
              
        update PIvalTemp1 ;
        
        
        
/************************Category='Category Area' & Cluster__c!=null , GeoScope__c='Country' & MarketUnit__c!=null**********************/
          
          
          
       SPE_PIDefinition__c pd2= new SPE_PIDefinition__c();
       
    //**********************Changes For Encryption******************//  
         //pd2.name= 'test pd2';
         pd2.PI_Title__c = 'test pd2';
   //**********************END******************//
       
       pd2.PIAbbreviation__c='pabb1';   
       pd2.ValuesType__c='Number';
       pd2.UoM__c='number';
       pd2.DataAcquisitionMethod__c='Survey Question';
       pd2.GeoScope__c='Country';
       pd2.CategoryScope__c='Category Area';
       pd2.BUScope__c='Business unit';
     
       insert pd2;
 
  //**********************Changes For Encryption******************//
     //system.assertequals(pd2.name,'test pd2');
     system.assertequals(pd2.PI_Title__c,'test pd2');
  //**********************END******************//
     
          
        SPE_PiValueTemp__c PIvalTemp2 = new SPE_PiValueTemp__c();    
        PIvalTemp2 .CurrencyIsoCode='EUR';
        PIvalTemp2 .PIDefination__c=Pd2.Id;
        PIvalTemp2 .EnterpriseId__c='test';
        //PIvalTemp2 .project__c='test';
        PIvalTemp2 .country__c='test';
        PIvalTemp2 .Cluster__c='test';
        //PIvalTemp2 .product__c='test';
        PIvalTemp2 .BusinessUnit__c='test';
        PIvalTemp2 .BusinessLine__c='Business Line';        
        PIvalTemp2 .ValidateCategory__c =true;
        //PIvalTemp2 .categorygroup__c='test';
        PIvalTemp2 .MarketUnit__c='Market Unit';
        PIvalTemp2 .ValidateCategory__c =false;
        PIvalTemp2 .Verified_Geo__c=false;
        PIvalTemp2 .Verified_BU__c=false;
        PIvalTemp2 .VerrifiedEnterpriseID__c=true;
        Insert PIvalTemp2 ;
      
        PIvalTemp2 .EnterpriseId__c='MO';
        
        update PIvalTemp2 ;
        

/********************************Category='Category Group' & categorygroup__c!=null**************************************************************/
        
      SPE_PIDefinition__c pd3= new SPE_PIDefinition__c();
      
   //**********************Changes For Encryption******************//  
         //pd3.name= 'test pd3';
         pd3.PI_Title__c = 'test pd3';
   //**********************END******************//
   
      pd3.PIAbbreviation__c='pabb3';   
      //pd3.ValuesType__c='Market';
      pd3.UoM__c='number';
      pd3.DataAcquisitionMethod__c='Survey Question';
      pd3.GeoScope__c='Market Unit';
      pd3.CategoryScope__c='Category Group';
      pd3.BUScope__c='Business Line';
     
      insert pd3;
  
  //**********************Changes For Encryption******************//
     //system.assertequals(pd3.name,'test pd3');
     system.assertequals(pd3.PI_Title__c,'test pd3');
  //**********************END******************//
   
        SPE_PiValueTemp__c PIvalTemp3 = new SPE_PiValueTemp__c();    
        PIvalTemp3 .CurrencyIsoCode='EUR';
        PIvalTemp3 .PIDefination__c=Pd3.Id;
        PIvalTemp3 .EnterpriseId__c='test';
        //PIvalTemp3 .project__c='test';
        //PIvalTemp3 .country__c='test';
        //PIvalTemp3 .Cluster__c='test';
        //PIvalTemp3 .product__c='test';
        PIvalTemp3 .BusinessUnit__c='Business Unit';
        PIvalTemp3 .BusinessLine__c='test';    
        PIvalTemp3 .MarketUnit__c='test';
        PIvalTemp3 .ValidateCategory__c =true;
        PIvalTemp3 .Verified_Geo__c=true;
        PIvalTemp3 .Verified_BU__c=true;
        PIvalTemp3 .Categorygroup__c='test';
         PIvalTemp3 .VerrifiedEnterpriseID__c=true;
       
        Insert PIvalTemp3 ;
        
        PIvalTemp3 .EnterpriseId__c='MO';   
        
        update PIvalTemp3 ;
       
/*******************************************GeoScope = Market******************************************************************************/
        
      SPE_PIDefinition__c pd4= new SPE_PIDefinition__c();
      
   //**********************Changes For Encryption******************//  
         //pd4.name= 'test pd4';
         pd4.PI_Title__c = 'test pd4';
   //**********************END******************// 
        
      pd4.PIAbbreviation__c='pabb4';   
     // pd4.ValuesType__c='Market';
      pd4.UoM__c='number';
      pd4.DataAcquisitionMethod__c='Survey Question';
      pd4.GeoScope__c='Market';
      pd4.CategoryScope__c='Category Group';
      pd3.BUScope__c='Product';
     
      insert pd4;
      
  //**********************Changes For Encryption******************//
     //system.assertequals(pd4.name,'test pd4');
     system.assertequals(pd4.PI_Title__c,'test pd4');
  //**********************END******************//  
      
     
        SPE_PiValueTemp__c PIvalTemp4 = new SPE_PiValueTemp__c();    
        PIvalTemp4 .CurrencyIsoCode='EUR';
        PIvalTemp4 .PIDefination__c=Pd3.Id;
        PIvalTemp4 .EnterpriseId__c='MO';
        //PIvalTemp4 .project__c='test';
        //PIvalTemp4 .country__c='test';
        //PIvalTemp4 .Cluster__c='test';
        PIvalTemp4 .product__c='test';
        PIvalTemp4 .BusinessUnit__c='Business Unit';
        PIvalTemp4 .BusinessLine__c='Business Line';    
        PIvalTemp4 .Market__c='test';
        PIvalTemp4 .MarketUnit__c='test';
        PIvalTemp4 .ValidateCategory__c =true;
        PIvalTemp4 .Verified_Geo__c=true;
        PIvalTemp4 .Categorygroup__c='test';
        PIvalTemp4 .VerrifiedEnterpriseID__c=true;
        
        
        Insert PIvalTemp4 ;
        
        PIvalTemp4 .EnterpriseId__c='Test';   
        
        update PIvalTemp4 ;




      SPE_PIDefinition__c pd5= new SPE_PIDefinition__c();
      
   //**********************Changes For Encryption******************//  
         //pd5.name= 'test pd5';
         pd5.PI_Title__c = 'test pd5';
   //**********************END******************//
   
      pd5.PIAbbreviation__c='pabb5';   
      pd5.ValuesType__c='Market';
      pd5.UoM__c='number';
      pd5.DataAcquisitionMethod__c='Survey Question';
      pd5.GeoScope__c='All Markets';
      pd5.CategoryScope__c='All Categories';
      pd3.BUScope__c='All Products';
     
      insert pd5;
  
  //**********************Changes For Encryption******************//
     //system.assertequals(pd5.name,'test pd5');
     system.assertequals(pd5.PI_Title__c,'test pd5');
  //**********************END******************//
     
        SPE_PiValueTemp__c PIvalTemp5 = new SPE_PiValueTemp__c();    
        PIvalTemp5 .CurrencyIsoCode='EUR';
        PIvalTemp5 .PIDefination__c=Pd3.Id;
        PIvalTemp5 .EnterpriseId__c='test';
        PIvalTemp5 .project__c='testing the class';
        PIvalTemp5 .country__c='testing the class';
        PIvalTemp5 .Cluster__c='testing the class';
        PIvalTemp5 .product__c='testing the class';
        PIvalTemp5 .BusinessUnit__c='testing the class';
        PIvalTemp5 .BusinessLine__c='testing the class';    
        PIvalTemp5 .Market__c='testing the class';
        PIvalTemp5 .MarketUnit__c='testing the class';
        //PIvalTemp5 .ValidateCategory__c =true;
        //PIvalTemp5 .Verified_Geo__c=true;
        //PIvalTemp5 .Verified_BU__c=true;
        PIvalTemp5 .Categorygroup__c='testing the class';
        
        
        Insert PIvalTemp5 ;
        
        PIvalTemp5 .EnterpriseId__c='MO';    
        
        update PIvalTemp5 ;
        
 }        
}