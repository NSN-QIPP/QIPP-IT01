trigger deleteBusinessGrpNotification on QIRS_Site_Notification__c (before insert) 
{
    for (QIRS_Site_Notification__c QSN : Trigger.new)
            {
               List<QIRS_Site_Notification__c> QSNlist= new List<QIRS_Site_Notification__c>();                       
                QSNlist=[SELECT Name from QIRS_Site_Notification__c where Business_Group__c =: QSN.Business_Group__c];  
                    if(QSNlist.size() > 0)                       
                    {
                        delete QSNlist; 
                    }
            }

}