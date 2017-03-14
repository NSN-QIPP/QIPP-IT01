@istest(seealldata =true)
public class QIPP_Approval_Waiting_EmailAlert_Test {
    static testmethod void QIPP_Approval_Waiting_Email_Alert_Batch_test(){   
        Test.startTest();
            QIPP_Approval_Waiting_Email_Alert_Batch weekwise= new QIPP_Approval_Waiting_Email_Alert_Batch();     
            weekwise.query ='select Id,name,Belt_Candidate_Mentor_Email__c,Project_Lead_Email_ID__c,Project_Type__c,Project_BL__c,Belt_Project_Phase__c,Project_Lead__c,Project_State__c,Project_Lead__r.name,Project_Lead_Email__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Name_Succinct__c,Portfolio_BU__c,Portfolio_Name__r.name,Belt_Project_Type__c,Portfolio_Name__r.Portfolio_Owner__r.id,Portfolio_Name__c,Business_Unit_Master_Black_Belt__r.id,Business_Unit_Master_Black_Belt__r.name,Portfolio_Owner__c,Approver_BU_MBB__r.name,Portfolio_Owner_EmailID__c,Approver_BU_MBB__c,Email_BU_MBB__c from QIPP_Project__c where Project_State__c != \'Not Started\' limit 200 ';
            ID batchID= Database.executeBatch(weekwise);
            //System.abortJob(batchID);
        Test.stopTest();
    }    
 	static testmethod void QIPP_ApprovalWaiting_EmailAlert_Schedule_test(){   
    	QIPP_ApprovalWaiting_EmailAlert_Schedule Sch = new QIPP_ApprovalWaiting_EmailAlert_Schedule();
        Test.startTest();
            String CRON_EXP = '0 0 0 1 1 ? 2025';  
            String jobId = System.schedule('testScheduledApex', CRON_EXP, Sch );
            CronTrigger ct = [select id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression); 
            System.assertEquals(0, ct.TimesTriggered);
            System.assertEquals('2025-01-01 00:00:00', String.valueOf(ct.NextFireTime));
        	system.debug('Job ID'+ jobid);
        Test.stopTest();
    }        
}