trigger UpdatingTodayDateinAllSteps on MCAR__c (before insert , before update) 
{
   List<MCAR__c> currentMCAR = Trigger.New;
   if(Trigger.isBefore)
   {
       if(Trigger.isInsert)
       {
              if(currentMCAR[0].Owner_Approval__c == 'NO')
              {
                  currentMCAR[0].X2D_Reject_Date__c = date.today();
              } 
              if(currentMCAR[0].X3D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X3D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X4D_Owner_Approve_Reject__c == 'REJECT')
              {
                  currentMCAR[0].X4D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X5D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X5D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X6D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X6D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X7D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X7D_Reject_Date__c = date.today();
              } 
              try
              {
               //update currentMCAR[0];
              }
              catch(Exception exe)
              {
                  System.Debug('## Exception in Trigger.isInsert ##' + exe.getMessage());
              } 
              System.Debug('################## in isbefore + isinsert : currentMCAR[0] ' + currentMCAR[0]);
       }
       else if (Trigger.isUpdate)
       {
              if(currentMCAR[0].Owner_Approval__c == 'NO')
              {
                  currentMCAR[0].X2D_Reject_Date__c = date.today();
              } 
              if(currentMCAR[0].X3D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X3D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X4D_Owner_Approve_Reject__c == 'REJECT')
              {
                  currentMCAR[0].X4D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X5D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X5D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X6D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X6D_Reject_Date__c = date.today();
              }
              if(currentMCAR[0].X7D_Status__c  == 'REJECT')
              {
                  currentMCAR[0].X7D_Reject_Date__c = date.today();
              }
              
             try
              {
               //update currentMCAR[0];
              }
              catch(Exception exe)
              {
                  System.Debug('## Exception in Trigger.isUpdate ##' + exe.getMessage());
              } 
              System.Debug('################## in isbefore + isupdate currentMCAR[0] : ' + currentMCAR[0]);           
       }
   }
   
}