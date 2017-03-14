/*
	Dema Number : DEMA0015460
	Description : Controller for send Notification to Safty Product Notification
	Name 	    : Rajkumar
*/

public class QIRSNotificationController 
{ 
 	//public static String BodyFormat
    public static boolean sendNotification(id rid)  
    {   
        //__________________Get Product Safty Email___________________________
        //
        Set<string> EmailSet =new Set<string>();
        List<QIRS_Product_Safety__c> productSafty = new List<QIRS_Product_Safety__c>();   
     	List<QIRS__c> qirs = new List<QIRS__c>();        
                
        productSafty = [select Email__c from QIRS_Product_Safety__c];
        system.debug('***'+productSafty);
         
        for(integer i=0; i<productSafty.size(); i++)
        {
        	    EmailSet.add(productSafty[i].Email__c);                
        }
        system.debug('*** Email Set *** ' + EmailSet );        
        
        //____________________________________E-Mail Definistion_________________________
            
        
        qirs = [select CreatedBy.Email,Process_Owner1__r.Email,Process_Owner1__r.Name,Master_Approver__c,Impacted_Region__c,Product_PN__c,Id,Problem_Description1__c,Name,Owner.Name,View_AP_Color__c,Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,StatusColor__c,Process_Owner1__c ,Issue_Level__c, Defective_Part__c, Symptom__c, CreatedDate , IssueLevelColor__c,View_Product_Name__c, Watchlist__c, MCAR__c, Closed_Date1__c,Countries__c,CreatedBy.Name,Customer__c,Orders_backlog__c,Units_Backlog__c,Revenue_Backlog__c,
               Master_Approver1__r.Email,Master_Approver2__r.Email,Master_Approver3__r.Email,Master_Approver4__r.Email,Master_Approver5__r.Email,Master_Approver6__r.Email,Master_Approver7__r.Email,Master_Approver8__r.Email,Master_Approver9__r.Email,Master_Approver10__r.Email,
               Orders_Impact__c,Units_Impact__c,(select Comment__c from	 QIRS_Status__r),Revenue_Impact__c,Factory__c,View_Release_Product__c,Additional_Email__c
               from QIRS__c where Id =:  rid]; 
                
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setHtmlBody(QIRSBasecontroller.BodyFormat(qirs,qirs[0].status__c));
        email.setSubject('QIRS Record '+qirs[0].Name+' is '+qirs[0].Status__c);    //change Subject if need
		email.setSaveAsActivity(false);         
        
        //String[] toEmail = new String[]{'rajkumar.p@atos.net'};
            	
        	List<String> toEmail = new List<String>(EmailSet);
			    	
       	email.setToAddresses(toEmail);
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
        
         //__________________________________return Type Value (Result of Email Status)_______________________________
         
        if (!results.get(0).isSuccess()) 
        {
            	System.StatusCode statusCode = results.get(0).getErrors()[0].getStatusCode();
            	String errorMessage = results.get(0).getErrors()[0].getMessage(); 
            	system.debug('Error Code ' + statusCode + ':' +errorMessage);
            	return false;
        }
        else return true;
        /*
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toEmail = new String[]{'rajkumar.p@atos.net',''};
		email.setSubject('Mail From My controller....');
		email.setPlainTextBody('Test by raj : The QIRS Record '+qirs[0].Name+' is '+qirs[0].Status__c);
		email.setToAddresses(toEmail);
		Messaging.sendEmail(New Messaging.SingleEmailMessage[] {email});
        */               
    }
}