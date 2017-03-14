@isTest
public class QIPP_MonthlyCutOff_Test 
{    
    static testMethod void testCase1()
    {
                              /*                 
        Group gp = new Group();
		gp.Name = 'MonthlyCutOff_ProjectReports-public';
        gp.Email = 'raj@user.com';
		insert gp;
               */                   
        test.startTest();  	
            
        QIPP_MonthlyCutOff.sendReport('MonthlyCutOff_ProjectReports-public','QIPP MonthlyCutOff_ProjectReports.csv','QIPP MonthlyCutOff_ProjectReports','<html><head></head><Body><p>Hello,<br/><br/>Please find the attached QIPP MonthlyCutOff_ProjectReports.</p><br/><br/>Thanks,<br/>QIPP Admin</body></html>','QIPP MonthlyCutOff_ProjectReports');       
        test.stopTest();
        //sendReport(String reportName,String Filename,String subject,string body,string GroupName)
    }
}