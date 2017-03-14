/****************************************************************************
Author        : Rajkumar (rajkumar.p@atos.net)
Description   : Send MCAR SPE report to NSN super User - DEM0019546 
Dependencies  : MCARReportController (via) MCARReportPage
Number of DML : No DML operations
*****************************************************************************/

global class MCARReportScheduler implements Schedulable
{        
    global void execute(SchedulableContext sc)
    {        
       MCARReportScheduler.sendReport();            
    }
             
    webservice static boolean sendReport()
    {
        try
        {
            PageReference ref = new PageReference('/apex/mcarreportpage?flag=lm');	//change the name
            
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();       		
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                	
            //Blob body = ref.getContent();
                                    
            Blob body;   	
            if (Test.IsRunningTest())  			
            {	
        		body=Blob.valueOf('UNIT.TEST');   
            }  			 
            else 
                body = ref.getContent();
                
	        attach.Body = body;    
            //attach.setContentType('text/plain');
            
            Date dt = Date.today();
            attach.setFileName('SPE_Report_'+dt.Year()+'-'+dt.Month()+'-'+dt.Day()+'.csv');   
            attach.setInline(false);
            
            List<String> email = new List<String>();                      
                             
            for(User User1 : [select Email from user where profileid = '00eU0000000F07a' and isActive=true order by LastLoginDate desc limit 10])
			{
    			email.add(User1.Email);
            }			                                        
                           
            String mcarreportview = 'https://'+System.URL.getSalesforceBaseUrl().getHost().remove('-api' )+'/apex/MCARReportView';
                            
            mail.setSubject('MCAR Scorecard Report Data '+dt.Year()+'-'+dt.Month()+'-'+dt.Day());  
            
            mail.setHtmlBody('<html><head></head><Body><p>Hi,<br/><br/>Please find the attached MCAR Scorecard Report Data for last month.</p><br/><p><a href="'+mcarreportview+'">Click Here</a> to export all Months data</p><br/><br/>Thanks,<br/>MCAR Admin</body></html>');              
            mail.setToAddresses(email);            
            
			mail.setSaveAsActivity(false);            
             				            
        	mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
    
        	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            
            return true;
        }
        catch(Exception e)
        {
            adminNotification('MCARReportScheduler',e.getLineNumber(),e.getMessage(),e.getTypeName());
                        
            system.debug('****Exception Block in sendReport Method******');
            system.debug('Cause      :'+e.getCause());
            system.debug('Line Number:'+e.getLineNumber());
            system.debug('Message    :'+e.getMessage());
            system.debug('Type Name  :'+e.getTypeName());
            system.debug('*************************');            			
                
            return false;
        }
        return true;
    }
    
    webservice static boolean adminNotification(String ClassName,Integer LineNumber, String Message, String TypeName)
    {	
        try
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setSubject('Exception In SPE Report Generate');
            mail.setHtmlBody('<html><head></head><Body><p>Hi Admin,<br/><br/>Please find below the Error Detail for MCAR SPE Report Generate.<br/><br/>Class Name &nbsp &nbsp :'+ClassName+'<br/>Line Number &nbsp &nbsp:'+LineNumber+'<br/>Error Message &nbsp:'+Message+'<br/>Error Type  &nbsp &nbsp &nbsp &nbsp:'+TypeName+'<br/></p></body></html>');  
            
            List<String> email = new List<String>();
            
            for(User User1 : [select Email from user where profileid = '00eU0000000UGZX' and isActive=true and Email Like '%atos.net%' order by LastLoginDate desc limit 9])
			{
    			email.add(User1.Email);
            }                         
            mail.setToAddresses(email);            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            
            return true;
        }
        Catch(Exception e)
        {
            system.debug('****Exception Block in AdminNotification Method******');
            system.debug('Cause      :'+e.getCause());
            system.debug('Line Number:'+e.getLineNumber());
            system.debug('Message    :'+e.getMessage());
            system.debug('Type Name  :'+e.getTypeName());
            system.debug('*****************************************************');
            
            return false;
        }
        return true;
    }        
}