trigger CPR_Migration on CPR__c (before insert, before update) {
    for(CPR__c wf: trigger.new){
        if(wf.NQT_Project_Status__c == 'Request Submitted' && wf.NQT_Deliverable_Status__c == 'Assign'){
            wf.RecordTypeId = '012U00000000vnB';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Team_Assignment' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Request In-Review' && wf.NQT_Deliverable_Status__c == 'In Review'){
            wf.RecordTypeId = '012U00000000vn9';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Review' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Request In-Review' && wf.NQT_Deliverable_Status__c == 'Determine Deadline'){
            wf.RecordTypeId = '012U00000000vn6';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Milestone' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Engineering Assigned' && wf.NQT_Deliverable_Status__c == 'Engineering Deliverable'){
            wf.RecordTypeId = '012U00000000vn8';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Project_Deliverables' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Quote Generation' && wf.NQT_Deliverable_Status__c == 'Sales Deliverable'){
            wf.RecordTypeId = '012U00000000vnA';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Sales_Deliverables' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Quote Submitted'){
            wf.RecordTypeId = '012U00000000vnC';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Update_Project' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Quote Closed'){
            wf.RecordTypeId = '012U00000000vn4';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Closed_Cancelled' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Cancelled'){
            wf.RecordTypeId = '012U00000000vn4';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Closed_Cancelled' LIMIT 1].Id;
            }
        if(wf.NQT_Project_Status__c == 'Customer Hold'){    
            wf.RecordTypeId = '012U00000000vn5';//[SELECT Id FROM RecordType WHERE developerName = 'CPR_Customer_Hold' LIMIT 1].Id;
            }
        }
    }