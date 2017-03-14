public with sharing class QIRS_AP_MA_PendingTask_Controller {
	public boolean isNokiaQIRSAdminprofileUser	{get;set;}
	public String actionPlanStatus				{get;set;}
	
	public QIRS_AP_MA_PendingTask_Controller(ApexPages.StandardController controller){
		isNokiaQIRSAdminprofileUser = false;
		actionPlanStatus = 'Open';
		QIRS_Admin_Profile__c qirsAdmProfile = QIRS_Admin_Profile__c.getValues('QIRSAdminProfileIDValue');
		isNokiaQIRSAdminprofileUser = UserInfo.getProfileId() == qirsAdmProfile.QIRS_Admin_Profile_ID__c;
	}
	
	public List<QIRS_Action_Plan__c> getOpenQIRSActionPlanForMA(){
		if(!isNokiaQIRSAdminprofileUser) return null;
		return [select Name,QIRS__r.Alert_Type__c,QIRS__r.Process_Owner1__c, Implementation_Comment__c,Implementation_Date__c,
					CreatedBy.Name,Action_Type__c, Approver__c,Champion__c,QIRS__c,Reason1__c,Required_date__c,Status__c 
				from QIRS_Action_Plan__c 
				where Status__c =: actionPlanStatus and Action_Type__c =: 'Containment/Temporal Solution' order by Name desc];
	}
	
	public list<SelectOption> getMA_APStatus(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Open','Open'));
        options.add(new SelectOption('Closed','Closed'));
        return options;
    }
}