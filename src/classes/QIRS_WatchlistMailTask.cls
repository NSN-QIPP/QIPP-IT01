Global class QIRS_WatchlistMailTask implements Schedulable{

    global void execute (SchedulableContext SC)
    {   
        /** @Last Modified By: Vivek Singh
         *  @Description: Not to send email if there is No Wachlist
         */
        List<QIRS__c> watchlist = new List<QIRS__c>();
        watchlist = [select ID,Status__c,Watchlist__c from QIRS__c where Watchlist__c = true AND Status__c !=: 'Closed' AND Status__c !=: 'Canceled'
                     AND Status__c !=: 'Submitted to Master Approval'];
        system.debug(System.LoggingLevel.INFO, '****EXECUTE****' + watchlist);                     
        if(watchlist == null || watchlist.isEmpty()) return;
        system.debug(System.LoggingLevel.INFO, '****After IF****' + watchlist);                                  
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'QIRS_Business_Quality_Watch_List'];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(getEmailAddresses());    
        email.setTargetObjectId(UserInfo.getUserId());                 
        email.setSaveAsActivity(false);            
        email.setTemplateId(et.id);           
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email}); 
            
    }
   
   public List<String> getEmailAddresses() 
     {
        List<String> idList = new List<String>();
        List<String> mailToAddresses = new List<String>();
        List<QIRS_Watchlist_Notification__c> watchlist= new List<QIRS_Watchlist_Notification__c>();                       
                watchlist=[SELECT Email__c,Name from QIRS_Watchlist_Notification__c];     
        for(QIRS_Watchlist_Notification__c u : watchlist) 
        {
            mailToAddresses.add(u.Email__c);
        }
        return mailToAddresses;
     } 

static testMethod void testQIRS_WatchlistMailTask()
     {
      
             
            
      /*QIRS_WatchlistMailTask controller = new QIRS_WatchlistMailTask();
      controller.getEmailAddresses();
        SchedulableContext SC;*/
         test.startTest();
          QIRS_WatchlistMailTask controller = new QIRS_WatchlistMailTask();
          String schedule = '0 0 23 * * ?';
          system.schedule('Test sch', schedule, controller);
          test.stopTest();
       
 //       controller.execute(SC);
   //    controller.getEmailAddresses();        
      
     }
}