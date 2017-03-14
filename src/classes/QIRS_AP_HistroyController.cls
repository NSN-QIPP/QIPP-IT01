public class QIRS_AP_HistroyController 
{

    public QIRS_AP_HistroyController(ApexPages.StandardController controller) {
       APID  = System.currentPagereference().getParameters().get('id');
        List<QIRS_Action_Plan__c> obj = [Select Id,Action_Type__c from QIRS_Action_Plan__c  where Id =: APID];
        if(obj.size()>0)
        ActionType  = obj[0].Action_Type__c;
    }


 


    //public String histories { get; set; }
    public String APID {get; set;} 
   public String ActionType {get; set;} 
 public QIRS_AP_HistroyController() 
    {
//        APID = 'a0GZ0000000BJur';
        
        APID  = System.currentPagereference().getParameters().get('id');
        List<QIRS_Action_Plan__c> obj = [Select Id,Action_Type__c from QIRS_Action_Plan__c  where Id =: APID];
        if(obj.size()>0)
        ActionType  = obj[0].Action_Type__c;
    }

public List<ProcessInstanceStep> getHistory() 
{
Return [Select ActorId, Comments, CreatedById, CreatedDate,  OriginalActorId, ProcessInstanceId, StepStatus 
From ProcessInstanceStep where ProcessInstance.TargetObjectId=: APID order by CreatedDate desc];
/*Return    [Select Id,Action_Type__c, (Select Id, Status From ProcessInstances), 
(Select ActorId, Comments, CreatedById, CreatedDate, Id, IsPending, OriginalActorId, RemindersSent, StepStatus 
From ProcessSteps) from QIRS_Action_Plan__c  where Id =: APID];*/
/*Return    [SELECT Id,Status,TargetObjectId, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)
FROM ProcessInstance where TargetObjectId=: APID];*/
//Select o.Id, (Select Id, Status From ProcessInstances), (Select ActorId, Comments, CreatedById, CreatedDate, Id, IsPending, OriginalActorId, RemindersSent, StepStatus From ProcessSteps) from Opportunity o where Id = '<RECORD ID>'

}
}