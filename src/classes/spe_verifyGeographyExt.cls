public with sharing class spe_verifyGeographyExt
{
    
    Public List<SPE_PiValueTemp__c> GeographyList1{get;set;}
    Public Boolean validGeo {get;set;}
    Public Boolean Mar{get;set;}
    Public Boolean MarUnit{get;set;}
    Public Boolean Con{get;set;}
    Public Boolean Pro{get;set;}
    public integer sizei{get;set;}
    public integer totalCount{get;set;}
    public String uniqueID;
    
    public spe_verifyGeographyExt()
    {
        validGeo =  true;
        Mar = false;
        MarUnit= false;
        Con= false;
        Pro= false;
        uniqueID = ApexPages.currentPage().getParameters().get('uID');
        
        //******************Changes For Encryption*****************// 
        GeographyList1 = [select id,name,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,Period__c,
                    Country__c,EnterpriseID__c,Market__c,MarketUnit__c,NumberValue__c,PIDefination__r.PI_Title__c,PIDefination__r.name,Product__c,
                    Project__c,ValidateCategory__c,Verified__c,VerrifiedEnterpriseID__c,Verified_Geo__c,Verified_BU__c,PIDefination__r.GeoScope__c from SPE_PiValueTemp__c where Verified_Geo__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID limit 999];              
        //*******************END********************//          
        
        //-----------------------------------------------------------below line for error count---------------------------------------
        //        sizei = CategoryList1.size();
        
            sizei = [select count() from SPE_PiValueTemp__c  where Verified_Geo__c = :false and CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID];
        //------------------------------------------------------------------------------------------------------------------------------
                                  
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          totalCount=integer.valueOf(ar.get('expr0'));  
        }  
        
                    
        for(SPE_PiValueTemp__c  piValtmp : GeographyList1)
        {
            if(piValtmp.PIDefination__r.GeoScope__c == 'Market')
             {
                 Mar = true;
             }
             if(piValtmp.PIDefination__r.GeoScope__c == 'Market Unit')
             {
                 MarUnit = true;
             }
             if(piValtmp.PIDefination__r.GeoScope__c == 'Country')
             {
                 Con = true;
             }
             if(piValtmp.PIDefination__r.GeoScope__c == 'Project')
             {
                 Pro= true;
             }
        }            
    }
    
    public pagereference updateGeo()
    {
        update GeographyList1;
        pagereference  p= new pagereference('/apex/spe_verifyGeography?uID='+uniqueID);
        p.setRedirect(true);
        return p;
    }
    
    public pagereference validateBU()
    {         
        pagereference  p= new pagereference('/apex/spe_verifyBU?uID='+uniqueID);
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
        pagereference  p= new pagereference('/apex/spe_verifyBU?uID='+uniqueID);
        p.setRedirect(true);
        return p;
    }
}