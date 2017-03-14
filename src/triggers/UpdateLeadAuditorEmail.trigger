trigger UpdateLeadAuditorEmail on Management_System_Audit__c (before insert , before update) 
{
for(Management_System_Audit__c audit : Trigger.New)
{
      if( audit.Lead_Auditor__c != null )
      {
             QIPP_Contacts__c contact =   [select Email__c from QIPP_Contacts__c where Id =: audit.Lead_Auditor__c];
             audit.Lead_Auditor_Email__c =  contact.Email__c ; 
     } 
}
}