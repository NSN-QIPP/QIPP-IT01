public with sharing class SPE_CM_DisplayButtonsExt 
{
	
	public SPE_ConsequenceManagement__c cmObj;
	
	public  SPE_CM_DisplayButtonsExt(ApexPages.standardController st)
	{
		this.cmObj = (SPE_ConsequenceManagement__c)st.getRecord();
	}
	
	public void approvedButton()
	{
		cmObj.TicketStatus__c = 'Approved'; 
		update cmObj;	
	}
	
	public void cancelledButton()
	{
		cmObj.TicketStatus__c = 'Cancel'; 
		update cmObj;
	}
	
	public void rejectedButton()
	{
		cmObj.TicketStatus__c = 'Rejected'; 
		update cmObj;	
	}
	
	public void closeButton()
	{
		cmObj.TicketStatus__c = 'Close'; 
		update cmObj;		
	}
	
	public void openButton()
	{
		cmObj.TicketStatus__c = 'Open'; 
		cmObj.OpenDate__c = Date.today(); 
		cmObj.Problem_Analysis_Completed__c = true; 
		
		update cmObj;		
	}
	
	public void continueOnWatchButton()
	{
		cmObj.ReadyToBeClosed__c = false; 
		cmObj.ContWatchListResetDate__c = Date.today(); 
		update cmObj;
	}
	
	public void deleteButton()
	{
		delete cmObj;
	}
	
	public void deLinkButton()
	{
		cmObj.MasterCM__c = null; 
		update cmObj;	
	}
	
	public void noTroubleFoundButton()
	{
		cmObj.TicketStatus__c = 'No Trouble Found'; 
		update cmObj;
	}

}