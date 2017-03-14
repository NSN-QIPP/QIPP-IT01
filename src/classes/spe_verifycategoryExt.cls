public with sharing class spe_verifycategoryExt
{
    
    Public List<SPE_PiValueTemp__c> CategoryList1{get;set;}
    Public Boolean validCat {get;set;}
    Public Boolean CatArea{get;set;}
    Public Boolean CatGrp{get;set;}
    Public Boolean Cat{get;set;}
    public integer sizei{get;set;}
    public integer totalCount{get;set;}
    public String uniqueID;
    
    public spe_verifycategoryExt()
    {
        validCat =  true;
        CatArea = false;
        CatGrp = false;
        Cat = false;
        uniqueID = ApexPages.currentPage().getParameters().get('uID');
        
         //******************Changes For Encryption*****************// 
        CategoryList1 = [select id,name,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,Period__c,
                    Country__c,EnterpriseID__c,Market__c,MarketUnit__c,NumberValue__c,PIDefination__r.PI_Title__c,PIDefination__r.name,Product__c,
                    Project__c,ValidateCategory__c,Verified__c,VerrifiedEnterpriseID__c,Verified_Geo__c,Verified_BU__c,PIDefination__r.BUScope__c,PIDefination__r.CategoryScope__c from SPE_PiValueTemp__c where ValidateCategory__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID limit 999];              
        //********************END**********************//
        
        //-----------------------------------------------------------below line for error count---------------------------------------
        //        sizei = CategoryList1.size();
        
            sizei = [select count() from SPE_PiValueTemp__c  where ValidateCategory__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID];
        //------------------------------------------------------------------------------------------------------------------------------
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          totalCount=integer.valueOf(ar.get('expr0'));  
        }                          
                    
         for(SPE_PiValueTemp__c PiValtmp : CategoryList1)
         {
             if(PiValtmp.PIDefination__r.CategoryScope__c == 'Category')
             {
                 cat = true;
             }
             if(PiValtmp.PIDefination__r.CategoryScope__c == 'Category Area')
             {
                 CatArea = true;
             }
             if(PiValtmp.PIDefination__r.CategoryScope__c == 'Category Group')
             {
                 CatGrp = true;
             }
         }
                 
    }
    
    public pagereference updateCat()
    {
        update CategoryList1;
        pagereference  p= new pagereference('/apex/spe_verifyCategory?uID='+uniqueID);
        p.setRedirect(true);
        return p;
    }
    
     public pagereference validateGeography()
    {         
        pagereference  p= new pagereference('/apex/spe_verifyGeography?uID='+uniqueID);
        p.setRedirect(true);
        return p;             
    }
    public pagereference BatchUpload()
    {
        
        pagereference  p= new pagereference('/apex/SPE_FinalInsert_dataupload?uID='+uniqueID);
        p.setRedirect(true);
        return p;

    }
    
    public pagereference skiptoNxtVal()
    {
        pagereference  p= new pagereference('/apex/spe_verifyGeography?uID='+uniqueID);
        p.setRedirect(true);
        return p;
    }
    
}