trigger SiteNotificationValidation  on QIRS_Site_Notification__c (before insert,before update) 
{
   for (QIRS_Site_Notification__c  qirssite : Trigger.new)
    {
    
     List<QIRS_Site_Notification__c> tempqirsAPAL = new List<QIRS_Site_Notification__c>();
        tempqirsAPAL  =  [select ID from QIRS_Site_Notification__c 
        where Business_Group__c =:  qirssite.Business_Group__c and Email__c =: qirssite.Email__c ];
                    if(tempqirsAPAL.size()>0)
                    {
                          qirssite.Email__c.addError('EmailID already exist for selected combination'); 
                    }
                   
                  /* if(Trigger.isUpdate == true && Trigger.isBefore==true)
                   {
                     RecordType rcdType = [select Id from RecordType where SObjectType='QIRS_Action_Plan_Approver_List__c' and Name='QIRS_Master_Config_Layout' limit 1]; 
                      List<QIRS_Action_Plan_Approver_List__c> objtemp = new List<QIRS_Action_Plan_Approver_List__c>();
                      objtemp = [select User__c,Phone__c,Email__c,id, RecordTypeId from QIRS_Action_Plan_Approver_List__c where phone__c = '' and id !=: Trigger.New[0].id];
                      system.debug('aaaaaaaaaaaaaaaaaaaaaa['+objtemp.size()+']aaaaaaaaaaaaaaaaaaaaaaaaaa');
                      for(Integer i=0;i<objtemp.size();i++)
                      {
                          User user1= new User();
                          user1= [select Id,Name,Phone,Email from User where Id =: objtemp[i].User__c];
                          objtemp[i].RecordTypeId = rcdType.id;
                          objtemp[i].Phone__c =  user1.Phone;//qirsapal.User__r.Phone;
                          objtemp[i].Email__c =  user1.Email;//'tejas.kardile@igate.com';//qirsapal.User__r.Email;
                      }
                      update objtemp;
                   }*/
                    
    }
}