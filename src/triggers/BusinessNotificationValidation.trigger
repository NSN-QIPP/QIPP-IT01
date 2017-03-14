trigger BusinessNotificationValidation on QIRS_Business_Notification_List__c (before insert,before update) 
{
    for (QIRS_Business_Notification_List__c  qirssite : Trigger.new)
    {
    
     List<QIRS_Business_Notification_List__c> tempqirsAPAL = new List<QIRS_Business_Notification_List__c>();
        tempqirsAPAL  =  [select ID from QIRS_Business_Notification_List__c 
        where Business__c =: qirssite.Business__c 
        and Email__c =: qirssite.Email__c];
                    if(tempqirsAPAL.size()>0)
                    {
                          qirssite.Email__c.addError('EmailID already exist for selected combination'); 
                    }
                    
    }
}