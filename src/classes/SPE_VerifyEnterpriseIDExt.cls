Public with sharing class SPE_VerifyEnterpriseIDExt
{
    Public List<SPE_PiValueTemp__c> PVTList1{get;set;}
    public integer sizei{get;set;}
    public integer totalCount{get;set;}
    public String uniqueID;
    
    
    public SPE_VerifyEnterpriseIDExt()
    {
        //******************Changes For Encryption*****************//  
        uniqueID = ApexPages.currentPage().getParameters().get('uID');
        PVTList1 = [select id,name,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,Period__c,
                    Country__c,EnterpriseID__c,Market__c,MarketUnit__c,NumberValue__c,PIDefination__r.name,PIDefination__r.PI_Title__c,Product__c,
                    Project__c,ValidateCategory__c,Verified__c,VerrifiedEnterpriseID__c,Verified_Geo__c,Verified_BU__c,PIDefination__r.BUScope__c from SPE_PiValueTemp__c where VerrifiedEnterpriseID__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID limit 999];              
        //************************END************************//
        
        //-----------------------------------Modified for find Error record----------------------------------      
        //sizei = PVTList1.size();
        
        sizei = [select count() from SPE_PiValueTemp__c  where VerrifiedEnterpriseID__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID];
        
        //------------------------------------------------------------------------------------------------
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
            totalCount=integer.valueOf(ar.get('expr0'));    
        }        
    }
    
    public pagereference updateEIDs()
    {
        update PVTList1;
        pagereference  p= new pagereference('/apex/SPE_VerifyEnterpriseID?uID='+uniqueID);
        p.setRedirect(true);
        return p;
    }
    
    
    public pagereference validateCategory()
    {         
        pagereference  p= new pagereference('/apex/spe_verifyCategory?uID='+uniqueID);
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
        pagereference  p= new pagereference('/apex/spe_verifyCategory?uID='+uniqueID);
        p.setRedirect(true);
        return p;
    }
    
}