public class QIRS_Action_Plan_Submition_Controller {
	public String QIRS_Action_plan_Tag {get; set;}
	public String QIRS_Action_plan_Status {get; set;}
	public boolean QIRS_Action_plan_Flag {get; set;}
	public string[] SelectedStatus{get;set;}
	public String Type {get; set;}
    
    public QIRS_Action_Plan_Submition_Controller(ApexPages.StandardController controller){
    	Type = System.currentPagereference().getParameters().get('type');
        if(Type == 'stask'){
			QIRS_Action_plan_Tag = 'Submitted tasks';
            QIRS_Action_plan_Flag = true;
            SelectedStatus = new String[]{'Open','Rejected'}; 
		}
        QIRS_Action_plan_Status ='Pending';
    }
     
	public List<QIRS_Action_Plan__c> getshowQIRSActionPlan(){
		String st = QIRS_Action_plan_Status;
    	list<QIRS_Action_Plan__c> lstQirs = new list<QIRS_Action_Plan__c>();
		if(Type == 'stask'){
			if(st == 'Pending'){
				lstQirs= [select Name,QIRS__r.Alert_Type__c,QIRS__r.Process_Owner1__c, Implementation_Comment__c,Implementation_Date__c,
							CreatedBy.Name,Action_Type__c, Approver__c,Champion__c,QIRS__c,Reason1__c,Required_date__c,Status__c 
							from QIRS_Action_Plan__c 
							where CreatedById =: UserInfo.getUserId() and Status__c In : SelectedStatus order by Name desc];
			}else{
				lstQirs= [select Name,QIRS__r.Alert_Type__c,QIRS__r.Process_Owner1__c, Implementation_Comment__c,Implementation_Date__c,
							CreatedBy.Name,Action_Type__c,Approver__c,Champion__c,QIRS__c,Reason1__c,Required_date__c,Status__c 
							from QIRS_Action_Plan__c 
							where CreatedById =: UserInfo.getUserId() and Status__c =: 'Closed' order by Name desc];
			}
		}
		return lstQirs;
	}
	
	public List<SelectOption> getQIRS_Action_plan_Item(){
	        return QIRSBasecontroller.getAPStatus();
	}
}