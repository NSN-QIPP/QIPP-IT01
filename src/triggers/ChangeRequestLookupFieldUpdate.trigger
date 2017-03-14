trigger ChangeRequestLookupFieldUpdate on MCAR_Change_Request__c (before insert,before update)

 {
 for(MCAR_Change_Request__c changeReq : Trigger.new)
 {
 
 for(MCAR_Facility__c facility : [select id ,Name,MCAR_Facility_Company__c from MCAR_Facility__c where id =:changeReq.Facility_Name__c ])
 {
 changeReq.Facility_Company_Name__c = facility.MCAR_Facility_Company__c;
 }
 }

}