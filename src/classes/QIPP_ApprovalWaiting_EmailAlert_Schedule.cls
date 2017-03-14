/*
    Class/Triger Name : QIPP_ApprovalWaiting_EmailAlert_Schedule
    Test Class Name   : QIPP_Approval_Waiting_EmailAlert_Test
    Author            : Srikanth V(IGATE)
    Created Date      : 09.JULY.2015
    Purpose/Overview  : 
        ********************************************************************************************************************         
        01) Sending Remaidner email alert to Approvers for every 3,6 and 9 weeks when there is no action on approvals(pending approvals)
        02) 
    
        ********************************************************************************************************************  
    Change History    : 
        ********************************************************************************************************************         
        SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
        ********************************************************************************************************************  
        01  : 09.JULY.2015  :  Srikanth V(IGATE)  :   Class Created  :
        02  : 

    Notes   :
        ********************************************************************************************************************         
        01) Schedule this class everyday at 2.00AM
        02)
*/
global class QIPP_ApprovalWaiting_EmailAlert_Schedule implements Schedulable{ 
  global void execute(SchedulableContext SC) {
     //Executing Batch class named 'Approval_Waiting_Email_Alert_Batch'
     QIPP_Approval_Waiting_Email_Alert_Batch weekwise= new QIPP_Approval_Waiting_Email_Alert_Batch();     
     //weekwise.query ='select Id,name,Belt_Candidate_Mentor_Email__c,Project_Lead_Email_ID__c,Project_Type__c,Project_BL__c,Belt_Project_Phase__c,Project_Lead__c,Project_State__c,Project_Lead__r.name,Project_Lead_Email__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Name_Succinct__c,Portfolio_BU__c,Portfolio_Name__r.name,Belt_Project_Type__c,Portfolio_Name__r.Portfolio_Owner__r.id,Portfolio_Name__c,Business_Unit_Master_Black_Belt__r.id,Business_Unit_Master_Black_Belt__r.name,Portfolio_Owner__c,Approver_BU_MBB__r.name,Portfolio_Owner_EmailID__c,Approver_BU_MBB__c,Email_BU_MBB__c from QIPP_Project__c where Project_State__c != \'Not Started\' ';
     weekwise.query ='select Id,name,Belt_Candidate_Mentor_Email__c,Project_Lead_Email_ID__c,Project_Type__c,Project_BL__c,Belt_Project_Phase__c,Project_Lead__c,Project_State__c,Project_Lead__r.name,Project_Lead_Email__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Name_Succinct__c,Portfolio_BU__c,Portfolio_Name__r.name,Belt_Project_Type__c,Portfolio_Name__r.Portfolio_Owner__r.id,Portfolio_Name__c,Business_Unit_Master_Black_Belt__r.id,Business_Unit_Master_Black_Belt__r.name,Portfolio_Owner__c,Approver_BU_MBB__r.name,Portfolio_Owner_EmailID__c,Approver_BU_MBB__c,Email_BU_MBB__c from QIPP_Project__c ORDER BY LastModifiedDate DESC ';
     if(!Test.isRunningTest()){ Database.executeBatch(weekwise); }
  }
}