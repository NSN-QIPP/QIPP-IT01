global class ClaimEmailController 
{
    public id ClaimId { set; get; }
    public static List<String> email{ set; get; }
    public String SQM  { set; get; }
    
    
    public static List<Claim_Contact__c> ClaimContact { set; get; }
         
    //---------------Variable Using In settleMent Letter-----------------//
    public String categoryManager {set; get;}
    public String supplierManager { set; get; }
    //--------------------------------------------------------------------//
  
    public ClaimEmailController(ApexPages.StandardController controller)
    {        
        ClaimId = ApexPages.currentPage().getParameters().get('id');
                         
        for(Claim_Contact__c cc:[select Name__c,Contact_Type__c from Claim_Contact__c where Claims__c =:ClaimId])
        {
            System.debug('^^^^%%%%%%'+cc);
            
            if(cc.Contact_Type__c == 'SQM')
            {
                SQM = cc.Name__c;
            }
            else if(cc.Contact_Type__c == 'Category Manager')
            {
                categoryManager = cc.Name__c;
            }            
        }
        
    }
    
    public ClaimEmailController()
    {        
    }
    
   
    webservice static boolean sendMail(id cid)
    {           
        try{
        PageReference pdf = Page.SettlementLetter;
        pdf.getParameters().put('id',cid);
        pdf.setRedirect(true);
        
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        //Blob body = pdf.getContent();                          
            Blob body;   	
            if (Test.IsRunningTest())  			
            {	
        		body=Blob.valueOf('UNIT.TEST');   
            }  			 
            else  			 
            {
        		body = pdf.getContent();
            }        
        attach.setContentType('application/pdf');
        attach.setFileName('Settlement Letter.pdf');
        attach.setInline(false);
        attach.Body = body;    
        
        MCAR_Claim_Management__c claim;
        claim = [select name,Owner.Email,Open_Date__c,Manufacturer_Email__c from MCAR_Claim_Management__c where id=:cid];                
        
        ClaimContact = new List<Claim_Contact__c>([select id,Name,Email__c,Contact_Type__c from Claim_Contact__c where Claims__c=:cid]); 
        MCAR_Claim_Management__c mcarclaim  = new MCAR_Claim_Management__c ();
         mcarclaim  = [select id,Sending_Settlement_letter__c from MCAR_Claim_Management__c where id=:cid];               
        email = new List<String>();               
                
        for(Claim_Contact__c con : ClaimContact)
        {
            if(con.Contact_Type__c =='Category Manager')
                email.add(con.Email__c);  
            if(con.Contact_Type__c=='Manufacturer' && con.Email__c!=claim.Manufacturer_Email__c)
                email.add(con.Email__c);  
        }        
        email.add(claim.Owner.Email);
        
        if(mcarclaim.Sending_Settlement_letter__c == TRUE){                    
        
        //mail.setSubject('Nokia Networks Settlement Update for '+claim.name);
            
		//-------------------------------Settlement Letter Email Body------------------------------------------//		
        //mail.setHtmlBody('Hi Please find the attachment for Nokia Settlement Letter ');                        
            
		EmailTemplate et = [SELECT Id,Markup,Body FROM EmailTemplate WHERE Name = 'Settlement Notification to Manufacturer'];
	
            Id ManufactuerId = [select id from User where Email =:claim.Manufacturer_Email__c limit 1].id;
            //String htmlbody = et.Markup;                       
		//mail.setHtmlBody(htmlbody);  
		            
            mail.setTemplateId(et.Id);
            mail.setCcAddresses(email);
            mail.setTargetObjectId(ManufactuerId);
            mail.setWhatId(cid);
			mail.setSaveAsActivity(false);            
             
		//------------------------------------------------------------------------------------------------------//
		            system.debug('***test');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
    
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });      
            
            
            ////-------------------------------------------------------------------------------///
            try
            {                
            	MCAR_Claim_Management__c[] claimAttachement = [select id,name,(select id,name from Attachments where name = 'Settlement Letter.pdf') from MCAR_Claim_Management__c where id =:cid limit 1];
            
            	SObject[] myAttachement = claimAttachement[0].getSObjects('Attachments');                                                     	                                  
                
				if(myAttachement == null)     
                {                                    
                    Attachment recAttach = new Attachment();                       
                    recAttach.body = body;                    
                    recAttach.Name = 'Settlement Letter.pdf';                        
                    recAttach.IsPrivate = false;                        
                    recAttach.parentId = cid;                        
                    insert recAttach;
                }/*
                else
            	for(SObject attachment : myAttachement)  
            	{
                	if(attachment.get('Name')!='Settlement Letter.pdf')
                	{
                    	Attachment recAttach = new Attachment();
                        recAttach.body = body;
                        recAttach.Name = 'Settlement Letter.pdf';
                        recAttach.IsPrivate = false;
                        recAttach.parentId = cid;
                        insert recAttach;
                	}
            	}    */
            }
            catch(Exception e)
            {
                
            }            
            //--------------------------------------------------------------------------------///
        }
        return true;
        
        }
        catch(Exception e)
        {            
            return false;
        }
        
    }
}