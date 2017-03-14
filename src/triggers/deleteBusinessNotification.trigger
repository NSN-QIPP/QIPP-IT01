trigger deleteBusinessNotification on QIRS_Business_Notification_List__c (before insert) 
{
    for (QIRS_Business_Notification_List__c  QBN : Trigger.new)
            {
               List<QIRS_Business_Notification_List__c > QBNlist= new List<QIRS_Business_Notification_List__c>();                       
                QBNlist=[SELECT Name from QIRS_Business_Notification_List__c  where Business__c =: QBN.Business__c];  
                    if(QBNlist.size() > 0)                       
                    {
                        delete QBNlist; 
                    }
            }

}