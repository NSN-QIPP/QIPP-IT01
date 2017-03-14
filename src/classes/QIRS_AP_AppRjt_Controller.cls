public class QIRS_AP_AppRjt_Controller 
{
    public string strMode {get;set;}     
    public string strSubtitleValue {get;set;} 
    public QIRS_Action_Plan__c objap{get;set;}    
    
    public QIRS_AP_AppRjt_Controller()
    {
      String strap = System.currentPagereference().getParameters().get('id');  
      if(([select ID from QIRS_Action_Plan__c where Id =: strap]).size()>0)
             {
                 objap = [select Re_Submit__c,App_Rej__c,Approval_Comment__c,IsRecall__c,IsChampChange__c,IsApproverChange__c, ActionPlanDelayedFlag__c, ActionPlanExpiredFlag__c, ManagerEsclationFlag__c, Action_Plan_Counter__c,Implementation_Comment__c,Core_ID__c,ID, Name, Task__c,Action_Type__c,Implementation_Date__c, Approver__c,Champion__c,
                 QIRS__c,Reason1__c,Required_date__c,Status__c, 
                 Approver1__c,Approver2__c,Approver3__c,Approver4__c,Approver5__c,Approver6__c,Approver7__c,Approver8__c,Approver9__c,Approver10__c,
                 Champion1__c,Champion2__c,Champion3__c,Champion4__c,Champion5__c,Champion6__c,Champion7__c,Champion8__c,Champion9__c,Champion10__c,
                 CreatedByID,QIRS__r.Process_Owner1__c 
                 from QIRS_Action_Plan__c where Id =: strap];
                 strSubtitleValue = 'QIRS_Action_Plan: ' + objap.Name;
                 
             }
    }

    public PageReference cancel() 
    {
          return  Redirect();
    }
    public PageReference Redirect() 
    {
        PageReference pageRef = new PageReference('/' + objap.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference Reject() 
    {
    //2 - for reject.
      Save('2',QIRSBasecontroller.BaseVarQIRSAPRejected);
      return  Redirect();
    }

    public Void Save(String apprej,String Status) 
    {
       try
          {  
            if(Status != QIRSBasecontroller.BaseVarQIRSAPClosed)
            objap.Status__c = Status;
            objap.Status_Date1__c = Date.Today();
            objap.App_Rej__c = apprej;
            objap.Re_Submit__c = false;
            update objap; 
            System.Debug('sssssssssssssssssssssss' + objap.Status__c +'xxxxxxxxxxxxxxxxxxxxxxx');
            System.Debug('sssssssssssssssssssssss' + Status +'xxxxxxxxxxxxxxxxxxxxxxx');   
          }
          catch(System.DmlException ex)
          {
            ApexPages.addMessages(ex); 
          }  
    }
    public PageReference Approve() 
    {
        //1 - for Approve.
        Save('1',QIRSBasecontroller.BaseVarQIRSAPClosed);
       return Redirect();
    }

}