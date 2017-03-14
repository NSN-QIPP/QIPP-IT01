trigger ApproverlistValidation on QIRS_Action_Plan_Approver_List__c (before insert,before update) 
{
    for (QIRS_Action_Plan_Approver_List__c qirsapal : Trigger.new)
    {
                 List<QIRS_Action_Plan_Approver_List__c> tempqirsAPAL = new List<QIRS_Action_Plan_Approver_List__c>();
                tempqirsAPAL =  [select ID from QIRS_Action_Plan_Approver_List__c
                            where Business__c =: qirsapal.Business__c 
                            and User__c =: qirsapal.User__c
                            ];
 User user1= new User();
            user1= [select Id,Name,Phone,Email from User where Id =: qirsapal.User__c];
    RecordType rcdType = [select Id from RecordType where SObjectType='QIRS_Action_Plan_Approver_List__c' and Name='QIRS_Master_Config_Layout' limit 1];             
    if(Trigger.isInsert)
        {
           
             Trigger.new[0].Phone__c =  user1.Phone;//qirsapal.User__r.Phone;
             Trigger.new[0].Email__c =  user1.Email;//'tejas.kardile@igate.com';//qirsapal.User__r.Email;
                                
                            if(tempqirsAPAL.size()>0)
                            {
                                  qirsapal.User__c.addError('Selected user already exist for selected combination'); 
                            }
          
           qirsapal.RecordTypeId=rcdType.id ;
        }
        else if(Trigger.isUpdate)
        {
                      //RecordType rcdType = [select Id from RecordType where SObjectType='QIRS_Action_Plan_Approver_List__c' and Name='QIRS_Master_Config_Layout' limit 1]; 
                      if(qirsapal.RecordTypeId != rcdType.id)
                      {
                          qirsapal.RecordTypeId =rcdType.id;
                          Trigger.new[0].Phone__c =  user1.Phone;//qirsapal.User__r.Phone;
                          Trigger.new[0].Email__c =  user1.Email;//'tejas.kardile@igate.com';//qirsapal.User__r.Email;

                      } 
                         
                         if(tempqirsAPAL.size()>1)
                            {
                                  qirsapal.User__c.addError('Selected user already exist for selected combination'); 
                            }
        
        }
            
    }
}