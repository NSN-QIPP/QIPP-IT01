public class ClaimNegotiationLogController 
{
    public Negotiation_Log__c NegotiationLog { set; get; }
    public ApexPages.StandardController controller { set; get; }    
    public Id Claim { set; get; }
    
    public ClaimNegotiationLogController(ApexPages.StandardController controller)
    {
        this.controller = controller;
        Id NRID  = ApexPages.currentPage().getParameters().get('id');
        NegotiationLog = [select id,Claim__c,Memo_Title__c,Memo_Description__c,Date__c from Negotiation_Log__c where Id=:NRID]; 
        Claim = NegotiationLog.Claim__c;
    }    
    public ClaimNegotiationLogController()
    {         
       Claim = ApexPages.currentPage().getParameters().get('claim');         
        //NegotiationLog = [select id,Claim__c,Memo_Title__c,Memo_Description__c,Date__c from Negotiation_Log__c where Claim__c =:claim];                         
        NegotiationLog = new Negotiation_Log__c(Claim__c=Claim);
    }
    
    public PageReference SaveNewRecord()
    {
     	controller.save();
        NegotiationLog = new Negotiation_Log__c(Claim__c=Claim);
        PageReference pg = new PageReference('/apex/ClaimNegotiationLogedit?claim='+Claim);
        return pg;        
    }
    
   	public PageReference saveRecord()
    {
        controller.save();
        PageReference pg = new PageReference('/'+claim);
        return pg;
    }
    
    public PageReference Save()
    {                        
        if(checkvalidation())
        { 
        checkvalidation();
        insert NegotiationLog;                    
        PageReference pg = new PageReference('/'+NegotiationLog.Claim__c);        
        return pg;
        }
        else return null;
    }
    
    public PageReference SaveandNew()
    {                             
        if(checkvalidation())
        {                  
            insert NegotiationLog;                   
       		NegotiationLog = new Negotiation_Log__c(Claim__c=Claim);       		 
            PageReference pg = new PageReference('/apex/ClaimNegotiationLogedit?claim='+Claim);
        	return pg;  
        }
        else return null;

    }
    
    public boolean checkvalidation()
    {
        if(NegotiationLog.Memo_Title__c==null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Memo Title Should not be blank...!')); 
            return false;
        }
        if(NegotiationLog.Memo_Description__c==null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Memo Descruotuib Should not be blank...!')); 
            return false;
        }
		return true;        
    }
}