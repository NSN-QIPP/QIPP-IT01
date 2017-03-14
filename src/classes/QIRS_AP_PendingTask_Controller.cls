public class QIRS_AP_PendingTask_Controller {

    public String CurrentID1 {get; set;} 
    public String Type {get; set;} 
    public String QIRS_Action_plan_Tag {get; set;}
    public boolean Approve_Flag {get; set;}
    public boolean Reassign_Flag {get; set;}
    
    public QIRS_AP_PendingTask_Controller() 
    {
        Type = System.currentPagereference().getParameters().get('type');
        if(Type == 'ctask')
        {
            QIRS_Action_plan_Tag = 'Pending Tasks';
           Approve_Flag = true;
            Reassign_Flag = false;
        }
        else if(Type == 'atask')
        {
            QIRS_Action_plan_Tag = 'Task Analysis';
            Approve_Flag = true;
            Reassign_Flag = false;
        }
        else if(Type == 'dtask')
        {
            Approve_Flag = false;
            Reassign_Flag = true;
            QIRS_Action_plan_Tag = 'Delegate My Actions';        
        }
    }
    public List<QIRS_Action_Plan__c> getPendingTask() 
      {
          List<QIRS_Action_Plan__c> accpetedactionplanQirs = new List<QIRS_Action_Plan__c>();
          if(Type == 'ctask')
          {
                    accpetedactionplanQirs = [select Name,QIRS__r.Alert_Type__c,QIRS__r.Process_Owner1__c,Implementation_Comment__c,Implementation_Date__c,CreatedBy.Name, Action_Type__c,Approver__c,Champion__c
                   ,QIRS__c,Reason1__c,Required_date__c,Status__c from QIRS_Action_Plan__c where 
                    ( Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() )
                    and Status__c =: QIRSBasecontroller.BaseVarPendingforChampion
                    order by Name desc];
          }                
          else if(Type == 'atask')
          {
                    accpetedactionplanQirs = [select Name, QIRS__r.Alert_Type__c,QIRS__r.Process_Owner1__c,Implementation_Comment__c,Implementation_Date__c,CreatedBy.Name,Action_Type__c,Approver__c,Champion__c
                   ,QIRS__c,Reason1__c,Required_date__c,Status__c from QIRS_Action_Plan__c where 
                    ( Approver1__c =: UserInfo.getUserId() or Approver2__c =: UserInfo.getUserId() or
                    Approver3__c =: UserInfo.getUserId() or Approver4__c =: UserInfo.getUserId() or
                    Approver5__c =: UserInfo.getUserId() or Approver6__c =: UserInfo.getUserId() or
                    Approver7__c =: UserInfo.getUserId() or Approver8__c =: UserInfo.getUserId() or
                    Approver9__c =: UserInfo.getUserId() or Approver10__c =: UserInfo.getUserId() 
                    ) 
                    and Status__c =: QIRSBasecontroller.BaseVarImplementedbyChampion order by Name desc];
          }
          else if(Type == 'dtask')
          {
                    accpetedactionplanQirs = [select Name, QIRS__r.Alert_Type__c,QIRS__r.Process_Owner1__c,Implementation_Comment__c,Implementation_Date__c,CreatedBy.Name,Action_Type__c,Approver__c,Champion__c
                   ,QIRS__c,Reason1__c,Required_date__c,Status__c from QIRS_Action_Plan__c where 
                    ( Approver1__c =: UserInfo.getUserId() or Approver2__c =: UserInfo.getUserId() or
                    Approver3__c =: UserInfo.getUserId() or Approver4__c =: UserInfo.getUserId() or
                    Approver5__c =: UserInfo.getUserId() or Approver6__c =: UserInfo.getUserId() or
                    Approver7__c =: UserInfo.getUserId() or Approver8__c =: UserInfo.getUserId() or
                    Approver9__c =: UserInfo.getUserId() or Approver10__c =: UserInfo.getUserId() or
                    Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() ) 
                    and (Status__c =: QIRSBasecontroller.BaseVarImplementedbyChampion or
                    Status__c =: QIRSBasecontroller.BaseVarPendingforChampion) order by Name desc];
          }
          return accpetedactionplanQirs ;
      }
 public PageReference Reassign()
    {
        String strid = System.currentPagereference().getParameters().get('LQ2');
        PageReference pageRef = new PageReference('/apex/QIRS_Reassigned?id='+strid+'&type='+Type);
        return pageRef;
    }
    public PageReference ApprRej() 
    {
        String id = System.currentPagereference().getParameters().get('LQ1');
        String qirsid = System.currentPagereference().getParameters().get('qirsid');        
         if(Type == 'ctask')
        {
            //String partialURL = '/apex/QIRS_AP_Implement?id=' + id;
            String partialURL = '/apex/QIRS_AP_Implement_test?id=' + id;            
            PageReference pageRef = new PageReference(partialURL);
            pageRef.setRedirect(true);
            return pageRef;
        }
        else
        {
           
            List<ProcessInstanceWorkItem> workItemList =
             [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId
             ,p.OriginalActorId,p.Id,p.ActorId From ProcessInstanceWorkitem p
              where p.ProcessInstance.TargetObjectId = :id and (p.OriginalActorId =: UserInfo.getUserId() or p.ActorId =: UserInfo.getUserId())];
            if(workItemList.size()>0)
            {
            String strAppId = workItemList[0].Id;
            String partialURL = '/p/process/ProcessInstanceWorkitemWizardStageManager?id=' + strAppId+ '&retURL=' +qirsid;
            PageReference pageRef = new PageReference(partialURL);
            pageRef.setRedirect(true);
            return pageRef;
            }
            else
            {
            String partialURL = '/apex/QIRS_AP_AppRjt?id=' + id;            
            PageReference pageRef = new PageReference(partialURL);
            pageRef.setRedirect(true);
            return pageRef;
            }
         }
        return null;
    }
      static testMethod void testQIRS_AP_PendingTask_Controller()
     {
       QIRS_AP_PendingTask_Controller controller = new QIRS_AP_PendingTask_Controller();
       controller.CurrentID1 ='a0GZ0000000Bwm9';
       controller.Type = ApexPages.currentPage().getParameters().put('type', 'ctask');
      
       
       controller.QIRS_Action_plan_Tag ='Pending Tasks';
       controller.Approve_Flag=true;
       controller.Reassign_Flag=false;

     
       
       controller.Type ='ctask';
        controller.getPendingTask(); 
       controller.Type ='atask';
        controller.getPendingTask();         
        controller.Type ='dtask';
        controller.getPendingTask(); 
       ApexPages.currentPage().getParameters().put('LQ2', '005Z0000000Hnsp');
        controller.Reassign();
       controller.Type ='ctask';
       ApexPages.currentPage().getParameters().put('LQ1', 'a0GZ0000000Bwm9');
       ApexPages.currentPage().getParameters().put('qirsid', '005Z0000000Hnsp');      
                controller.ApprRej();
controller.Type ='dtask';
       ApexPages.currentPage().getParameters().put('LQ1', 'a0GZ0000000Bwm9');
       ApexPages.currentPage().getParameters().put('qirsid', '005Z0000000Hnsp');      
                controller.ApprRej();
     }
}