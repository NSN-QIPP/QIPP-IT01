trigger MCARCRApproveReject on MCAR_Change_Request__c (before update) {


   
   //RecordType rcdType = [select Id from RecordType where SObjectType='MCAR__c' and Name='Closed MCAR' limit 1]; 
   for (MCAR_Change_Request__c mcar : Trigger.new)    { 
    if ((mcar.MCAR_CR_Status__c == 'Approved') || (mcar.MCAR_CR_Status__c == 'Rejected') )
     if(mcar.CR_Type__c == 'Facility')  
      { 
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='Closed Facility' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
       }
      else if(mcar.CR_Type__c == 'Facility Contacts')
      {
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='Closed Facility Contacts' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
      }   
      else if(mcar.CR_Type__c == 'Manufacturer')
      {
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='Closed Manufacturer' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
      }   
      else if(mcar.CR_Type__c == 'Manufacturer Contact')
      {
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='Closed Manufacturer Contact' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
      }   
      else if(mcar.CR_Type__c == 'NSN Code')
      {
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='Closed NSN Code' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
      }
      else if(mcar.CR_Type__c == 'Manufacturer Site')
      {
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='closed site' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
      }
      else if(mcar.CR_Type__c == 'Other')
      {
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR_Change_Request__c' and Name='closed other' limit 1];   
        mcar.RecordTypeId=rcdType.id ;
      }   
   }
}