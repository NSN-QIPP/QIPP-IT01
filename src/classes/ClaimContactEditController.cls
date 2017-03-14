public class ClaimContactEditController 
{    	
    public ApexPages.StandardController controller { set; get; }
    public Id ClaimId { set; get; }
    
	public ClaimContactEditController(ApexPages.StandardController controller)
    {
		this.controller = controller;		
        id ContactId = ApexPages.currentPage().getParameters().get('id');
        ClaimId = [select id,Claims__c from Claim_Contact__c where id=:ContactId].Claims__c;        
    }
        
    public PageReference SaveAndNew()
    {
    	controller.save();
        PageReference pg = new PageReference('/apex/ClaimContactDetails?claimId=' + ClaimId);
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference updateMyRecord() 
    {  		
    	controller.save();
    	PageReference parentPage = new PageReference('/' + ClaimId);
    	parentPage.setRedirect(true);
    	return parentPage;	
    }
}