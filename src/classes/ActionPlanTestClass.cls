@isTest
private class ActionPlanTestClass
{
    // Crreate action plan
    static testmethod void fieldUpdation()
    {
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'Abhishek';
        con.Email__c = 'abhishek@igate.com';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '122465';
        insert con;
        
        Management_System_Audit__c audit = new Management_System_Audit__c();
        audit.Name = 'Test Audit';
        audit.Management_System__c = 'QMS';
        audit.Audit_Type__c = 'Other';
        audit.Audit_Year__c = '2013';
        audit.Audit_Status__c = 'In Progress';
        audit.Audit_Location__c = 'India';
        audit.Internal_Audit_Program_Owner__c = con.id;
        audit.Audit_organization__c = 'MBB';
        audit.Audit_Planned_Date__c = Date.Today();
        audit.Lead_Auditor__c = con.id;
        insert audit;
        
                
        Finding__c finding = new Finding__c();
        finding.Finding_Name__c = 'Test Finding';
        finding.Finding_Type__c = 'QMS';
        finding.Primary_QLT_Function__c = 'CO';
        finding.Finding_State__c = 'In Progress';
        finding.Finding_Owner__c = con.Id;
        finding.Audit_Name__c = audit.id;
        finding.Standards_Reference__c = '5.3 Quality Policy';
        finding.Classification__c = 'Strength';
        finding.Record_Status__c = 'Open';
        finding.Auditor__c = con.id;
        insert finding;


        
        QIPP_Action_Plan__c action = new QIPP_Action_Plan__c();
        action.Action_Plan_Name__c = 'Test Action Plan';
        action.Description_Detailed_CA__c = 'Test';
        action.Description_Detailed_PA__c = 'Test';
        action.Action_Plan_State_CA__c = 'On hold';
        action.Description_Detailed__c = 'On hold';
        action.Action_Plan_State_PA__c = 'On hold';
        action.Action_Plan_Start_Date__c = Date.Today();
        action.Finding_ID__c = finding.id;
        action.Action_Owner__c = con.id;
        action.Action_Initiator__c = con.id;
        action.Action_Initiator_CA__c = con.id;
        action.Action_Initiator_PA__c = con.id;
        action.Action_Plan_Target_Completion_Date__c = Date.Today();
        action.Target_Completion_Date_CA__c = Date.Today();        
        action.Target_Completion_Date_PA__c = Date.Today();
        insert action;
        
        Management_System_Audit__c auditselect = [select Name , Management_System__c , Audit_Type__c , Audit_Year__c , Audit_Status__c , Audit_Location__c ,
         Internal_Audit_Program_Owner__c  , Audit_organization__c , Audit_Planned_Date__c ,Lead_Auditor__c from  Management_System_Audit__c where Id =: audit.Id];
        update  auditselect ;
        

         Finding__c findingselect = [select Finding_Name__c , Finding_Type__c , Primary_QLT_Function__c , 
                                          Finding_State__c , Finding_Owner__c , Audit_Name__c , Standards_Reference__c ,
                                         Classification__c  , Record_Status__c , Auditor__c  from Finding__c
        where Id =: finding.Id];
        
        update findingselect ;
               
    }
}