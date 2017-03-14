global class ClaimReclamationConfirm implements Messaging.InboundEmailHandler
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        String MailSubject = email.subject;
        String MailFrom = email.fromAddress;        
        
		string ClaimName = checkClaimName(MailSubject);        
        
        //String ClaimName = MailSubject.substring(MailSubject.length() - 11);
        
        System.debug('Claim Name :'+ClaimName);
        System.debug('Mail From :'+MailFrom);
        System.debug('Mail Subject :'+MailSubject);
                
        
        if(ClaimName!=null)
        {
       	 	if([select id from MCAR_Claim_Management__c where name=:ClaimName limit 1].size()==1)
       		 {
           		 system.debug('control came inside.....');
            	MCAR_Claim_Management__c claim = [select id,Sup_Confirmed_Re_ceipt_of_Reclamation__c,Supplier_Confirmation_Mail_Detail__c,Supplier_Confirmation_BY__c from MCAR_Claim_Management__c where name=:ClaimName limit 1];             
                
                if([select id,Email__c from Claim_Contact__c where Claims__c =: claim.Id and Contact_Type__c ='Manufacturer' and Email__c =:MailFrom].size()>0)
           		 {            	
            		if(claim.Sup_Confirmed_Re_ceipt_of_Reclamation__c==null)
              	  	{
            			claim.Sup_Confirmed_Re_ceipt_of_Reclamation__c = system.now();                        
            			claim.Supplier_Confirmation_Mail_Detail__c = email.plainTextBody;
                        claim.Supplier_Confirmation_BY__c = MailFrom;
            			update Claim;     
                    
                    	boolean status  = sendMail(MailFrom,'Your Confirmation successfully updated for '+ClaimName,MailSubject);                        
               		}
                	else
                	{            		                  
            			String errInfo = 'Confirmation already sent for '+ClaimName+' at '+claim.Sup_Confirmed_Re_ceipt_of_Reclamation__c+' by '+claim.Supplier_Confirmation_BY__c;
                		system.debug(errInfo);
            			boolean status  = sendMail(MailFrom,errInfo,MailSubject);
            			return null;                     
                	}                
            	}
            	else
            	{
            		String errInfo = 'Your Contact Details (Email Id :'+ MailFrom +') not available for '+ ClaimName+ '. Please contact Claim Owner regarding same.';            	        
                	system.debug(errInfo);
            		boolean status  = sendMail(MailFrom,errInfo,MailSubject);
            		return null;           
           	 	}                
        	}        
        	else
        	{
           	 	String errInfo = 'Claim Name '+ClaimName+' Not Avaliable in Production. Do Not Edit subject line before sending your confirmation. Please contact Claim Owner regarding same.'; 
            	system.debug(errInfo);
            	boolean status  = sendMail(MailFrom,errInfo,MailSubject);
            	return null;
            }    
        }
        else
        {
            String errInfo = 'Claim Not Avaliable in Production. Do Not Edit subject line before sending your confirmation. Please contact Claim Owner regarding same.'; 
            system.debug(errInfo);
            boolean status  = sendMail(MailFrom,errInfo,MailSubject);
            return null;
		}
        result.success = true;
        return result;
    }    
    
    public boolean sendMail(String userMail,String errInfo,String sub)
    {   
        try
        {                        
            List<String> toMail =new List<String>();        
            toMail.add(userMail);              
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();              
        	Mail.setToAddresses(toMail);            
        	Mail.setSubject(sub);            
       	 	mail.setHtmlBody(errInfo);            
        	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { Mail });                        
        	return true;    
        }
        catch(Exception e)
        {
            return false;
        }     
    }
    
    public string checkClaimName(String sub)
    {                
        Pattern p = Pattern.compile('Claim-{1}([0-9]+)');                           
        List<string> subVal = sub.split(' ');
        
        for(String s : subVal)
        {
            Matcher m = p.matcher(s);
           	if(m.matches() == true) 
				return s;
        }
        return null;
    }
}