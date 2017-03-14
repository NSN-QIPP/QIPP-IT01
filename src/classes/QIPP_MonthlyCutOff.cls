/****************************************************************************
Author        : Rajkumar (rajkumar.p@atos.net)
Description   : Send QIPP_MonthlyCutOff Report data from standard report to Public group
Dependencies  : No-Dependencies
Number of DML : No-DML operations
*****************************************************************************/

global class QIPP_MonthlyCutOff implements Schedulable
{
    global void execute(SchedulableContext sc)
    {                       
        //String reportName;        	
		//String Filename;                                
       //MCARReportScheduler.sendReport();
       //            
       sendReport('MonthlyCutOff_ProjectReports-public','QIPP MonthlyCutOff_ProjectReports.csv','QIPP MonthlyCutOff_ProjectReports','<html><head></head><Body><p>Hello,<br/><br/>Please find the attached QIPP MonthlyCutOff_ProjectReports.</p><br/><br/>Thanks,<br/>QIPP Admin</body></html>','QIPP MonthlyCutOff_ProjectReports');       
       sendReport('A3_MonthlyCutOff_ProjectReports','A3_MonthlyCutOff_ProjectReports.csv','A3_MonthlyCutOff_ProjectReports','<html><head></head><Body><p>Hello,<br/><br/>Please find the attached QIPP A3_MonthlyCutOff_ProjectReports.</p><br/><br/>Thanks,<br/>QIPP Admin</body></html>','QIPP A3_MonthlyCutOff_ProjectReports');       
    }
    
    webservice static boolean sendReport(String reportName,String Filename,String subject,string body,string GroupName)
    {
        try
        {                
            String reportId;
            
            if (Test.IsRunningTest())
            {
               reportId =  'apex/mcarreportview';
            }
            else
            reportId = [select id,name from report where name =:reportName].id;
            
        	//ApexPages.PageReference report = new ApexPages.PageReference('/00O17000000Q09v?csv=1');
        	
            ApexPages.PageReference report = new ApexPages.PageReference('/'+reportId+'?csv=1');
        	Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        	attachment.setFileName(Filename);
               
            if (Test.IsRunningTest())  			
            {	
        		attachment.setBody(Blob.valueOf('UNIT.TEST'));   
            }  
        	else attachment.setBody(report.getContent());                                  
                
            attachment.setContentType('text/csv');
            
        	Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            
            message.setOrgWideEmailAddressId([select Id from OrgWideEmailAddress where Address ='qippadmin.quality@nokia.com' limit 1].id);
        	message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        	message.setSubject(subject);        	
              
            message.setHtmlBody(body);              
        	//message.setToAddresses( new String[] { 'rajmca138@yahoo.com' } );
            
            //---------------------Add Group Users-------------------------------//  
            Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE name =: GroupName];           
            set<Id> UsersIds = new set<id>();
            for(GroupMember gm : g.GroupMembers)            
            {
                UsersIds.add(gm.userOrGroupId);
            }
            List<String> MailList = new List<String>();
            for(User u : [Select email from User where id IN:UsersIds])
            {
                MailList.add(u.email);
                system.debug('****'+u.Email);
            }                                    
            message.setToAddresses(MailList);
            //-------------------------------------------------------------------//
            
        	Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
			system.debug('*****');        
        
        	return true;    
        }    
        catch(Exception e)
        {

            return false;
        }
        return true;
    }        

}