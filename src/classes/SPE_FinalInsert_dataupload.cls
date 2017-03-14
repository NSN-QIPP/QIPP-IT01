public class SPE_FinalInsert_dataupload 
{
    public integer totalCount{get;set;}
    public integer EID{get;set;}
    public integer cat{get;set;}
    public integer geo{get;set;}
    public integer BUn{get;set;}
    public String uniqueID;
    
    
    public SPE_FinalInsert_dataupload()
    {
        uniqueID = ApexPages.currentPage().getParameters().get('uID'); 
        
        EID = 0;
        cat = 0;
        geo = 0;
        BUn = 0;
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          totalCount=integer.valueOf(ar.get('expr0'));  
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and VerrifiedEnterpriseID__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          EID =integer.valueOf(ar.get('expr0'));  
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and ValidateCategory__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          cat =integer.valueOf(ar.get('expr0'));  
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and Verified_Geo__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          geo =integer.valueOf(ar.get('expr0'));  
        }
        
        for(AggregateResult ar:[SELECT count(id),UniqueIdentifier__c FROM SPE_PiValueTemp__c where CreatedBy.id = :UserInfo.getUserId() and Verified_BU__c = false and UniqueIdentifier__c =: uniqueID GROUP BY UniqueIdentifier__c ])
        {
          BUn =integer.valueOf(ar.get('expr0'));  
        }
        
    }
    
    public pagereference BatchUpload()
    { 
        SPE_PIUploadBatch ttBat = new SPE_PIUploadBatch(uniqueID);       
        //String CronExp= Datetime.now().addMinutes(1).format('ss mm HH dd MM ? yyyy');
        //System.schedule(SPE_Constants.AdhocScheduleJob+system.now(),CronExp,ttBat);
        
        Database.executeBatch(ttBat);
        pagereference p=Page.SPE_FinalDataloadPage;
        p.setRedirect(true);
        return p;
        
    }
}