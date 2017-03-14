public with sharing class spe_verifyBUExt
{
    
    Public List<SPE_PiValueTemp__c> BUList1{get;set;}
    Public Boolean validBU {get;set;}
    Public Boolean BUunt{get;set;}
    Public Boolean BULine{get;set;}
    Public Boolean Product{get;set;}
    public integer sizei{get;set;}
    public integer totalCount{get;set;}
    public integer EID{get;set;}
    public integer cat{get;set;}
    public integer geo{get;set;}
    public String uniqueID;
    
    public spe_verifyBUExt()
    {
        EID = 0;
        cat = 0;
        geo = 0;
        validBU =  true;
        BUunt = false;
        BUline = false;
        Product = false;
        uniqueID = ApexPages.currentPage().getParameters().get('uID');
        
        //**********************Changes For Encryption*******************//
        BUList1 = [select id,name,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,period__c,
                    Country__c,EnterpriseID__c,Market__c,MarketUnit__c,NumberValue__c,PIDefination__r.name,PIDefination__r.PI_Title__c,Product__c,
                    Project__c,ValidateCategory__c,Verified__c,VerrifiedEnterpriseID__c,Verified_Geo__c,Verified_BU__c,PIDefination__r.BUScope__c from SPE_PiValueTemp__c where Verified_BU__c = false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID limit 999];              
        //**********************END*******************//
        
        //sizei = BUList1.size();
        
        sizei = [select count() from SPE_PiValueTemp__c  where Verified_BU__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID];
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          totalCount=integer.valueOf(ar.get('expr0'));  
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and VerrifiedEnterpriseID__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          EID =integer.valueOf(ar.get('expr0'));
          system.debug('*******EID*******' + EID);  
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and ValidateCategory__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          cat =integer.valueOf(ar.get('expr0'));  
          system.debug('*******Cat*******' + cat);
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and Verified_Geo__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          geo =integer.valueOf(ar.get('expr0')); 
          system.debug('*******geo*******' + geo); 
        }                          
        /*
        EID = [select count() from SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and VerrifiedEnterpriseID__c = false];
        cat = [select count() from SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and ValidateCategory__c = false];
        geo = [select count() from SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and Verified_Geo__c = false];  
        */
                    
         for(SPE_PiValueTemp__c piValtmp : BUList1)
         {
             if(piValtmp.PIDefination__r.BUScope__c == 'Business Unit')
             {
                 BUunt = true;
             }
             if(piValtmp.PIDefination__r.BUScope__c == 'Business Line')
             {
                 BUline = true;
             }
             if(piValtmp.PIDefination__r.BUScope__c == 'Product')
             {
                 Product = true;
             }
         }           
    }
    
    public pagereference updateBU()
    {
        
        pagereference  p= new pagereference('/apex/spe_verifyBU?uID='+uniqueID);
        update BUList1;
        p.setRedirect(true);
        return p;
    }
    
    public pagereference BatchUpload()
    {
        SPE_PIUploadBatch ttBat = new SPE_PIUploadBatch(uniqueID);
        
        Database.executeBatch(ttBat); 
        pagereference p=Page.SPE_FinalDataloadPage;
        p.setRedirect(true);
        return p;

    }
    
    public pagereference skipVal()
    {
        
        pagereference  p= new pagereference('/apex/SPE_FinalInsert_dataupload?uID='+uniqueID);
        p.setRedirect(true);
        return p;

    }
}