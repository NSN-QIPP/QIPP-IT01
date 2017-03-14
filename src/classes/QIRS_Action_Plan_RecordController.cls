public class QIRS_Action_Plan_RecordController {
public String QIRS_Tag {get; set;}
    public QIRS_Action_Plan_RecordController(ApexPages.StandardController controller) {
    QIRS_Action_plan_Status ='All';
    strusertype = 'All';
    QIRS_Tag ='Master Analysis';
    }
    Public String Type = System.currentPagereference().getParameters().get('type');
    public String QIRS_Action_plan_Status {get; set;}
    public String strusertype {get; set;}    
    List<QIRS_Action_Plan__c> lstQirs1 = new List<QIRS_Action_Plan__c>();

    public List<SelectOption> getQIRS_Action_plan_Item() 
    {
        return QIRSBasecontroller.getActionPlanStatus();
    }

    
     public List<QIRS__c> getPendingQIRSApprovalDetails() 
      {
            List<QIRS__c> lstpenqirs = new List<QIRS__c>();
            lstpenqirs = [select  Master_Approver__c,Name,Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,
            Process_Owner1__c ,Issue_Level__c, Defective_Part__c, Symptom__c, CreatedDate , IssueLevelColor__c ,
            View_Product_Name__c, Watchlist__c, MCAR__c 
             from QIRS__c where 
//             Master_Approver__c =: UserInfo.getUserId() 
             ( Master_Approver1__c =: UserInfo.getUserId() or Master_Approver2__c =: UserInfo.getUserId() or
                    Master_Approver3__c =: UserInfo.getUserId() or Master_Approver4__c =: UserInfo.getUserId() or
                    Master_Approver5__c =: UserInfo.getUserId() or Master_Approver6__c =: UserInfo.getUserId() or
                    Master_Approver7__c =: UserInfo.getUserId() or Master_Approver8__c =: UserInfo.getUserId() or
                    Master_Approver9__c =: UserInfo.getUserId() or Master_Approver10__c =: UserInfo.getUserId() )
             and Status__c =: QIRSBasecontroller.BaseVarQIRSSubmitForApproval order by Name desc];
             return  lstpenqirs; 
      }
      
    
    
     

}