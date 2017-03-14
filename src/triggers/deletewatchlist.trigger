trigger deletewatchlist on QIRS_Watchlist_Notification__c (before insert) 
{
    for (QIRS_Watchlist_Notification__c WN : Trigger.new)
            {
               List<QIRS_Watchlist_Notification__c> watchlist= new List<QIRS_Watchlist_Notification__c>();                       
                watchlist=[SELECT Name from QIRS_Watchlist_Notification__c];                       
                    if(watchlist.size() > 0)                       
                    {
                        delete watchlist; 
                    }
            }
}