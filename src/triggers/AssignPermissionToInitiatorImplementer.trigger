trigger AssignPermissionToInitiatorImplementer on QIPP_Task__c (after insert , after update) 
{
for(QIPP_Task__c  task : Trigger.New)
    {
       QIPP_Task__Share Initiatorsharing;
       QIPP_Task__Share implementorsharing;
       
       QIPP_Contacts__c InitiatorName = null;
       QIPP_Contacts__c ImplementorName = null;
       List<User> Initiatorpresence = null;
       List<User> Implementorpresence = null;
       
       if(task.Task_Initiator__c != null)
       {
           InitiatorName = [Select Name FROM QIPP_Contacts__c where Id =: task.Task_Initiator__c];
           Initiatorpresence = [select Id , Name , Profile.Name FROM User where Name  =: InitiatorName.Name];
       }
       
       if(task.Task_Implementer__c != null)
       {    
           ImplementorName = [Select Name FROM QIPP_Contacts__c where Id =: task.Task_Implementer__c];
           Implementorpresence = [select Id , Name , Profile.Name FROM User where Name  =: ImplementorName.Name];
       }
       
       if(Initiatorpresence != null)
       {
           if(Initiatorpresence.size() > 0)
           {
              if(Initiatorpresence[0].Id == task.ownerid)
               continue;
              Initiatorsharing = new QIPP_Task__Share();
              Initiatorsharing.ParentId = task.Id;
              Id assignId = Initiatorpresence[0].Id;
              Initiatorsharing.UserorGroupId = assignId;
              Initiatorsharing.AccessLevel = 'Edit';
              Initiatorsharing.RowCause = Schema.QIPP_Task__Share.RowCause.Manual;
              insert Initiatorsharing;
           }
        }
        
        if(Implementorpresence != null)
        {
           if(Implementorpresence.size() > 0)
           {
               if(Implementorpresence[0].Id == task.ownerid)
                   continue;
              implementorsharing = new QIPP_Task__Share();
              implementorsharing.ParentId = task.Id;
              Id assignId = Implementorpresence[0].Id;
              implementorsharing.UserorGroupId = assignId;
              implementorsharing.AccessLevel = 'Edit';
              implementorsharing.RowCause = Schema.QIPP_Task__Share.RowCause.Manual;
              insert implementorsharing;
           }
         }   
    }

}