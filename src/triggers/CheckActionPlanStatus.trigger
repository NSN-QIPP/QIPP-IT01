/*
    Class/Triger Name : CheckActionPlanStatus
    Test Class Name   : ActionPlanTestClass and QIPPActionPlanTestClass
    Author            : XXXX-XXXXXX
    Created Date      : 24.JUNE.2013
    Purpose/Overview  : 
        ********************************************************************************************************************         
        01) Updating 'Target Completion Date' field based on 'Finding Start date'
        02) All action plans must be either closed or canceled before finding status considered as Complete.
        03) Updating 'Actual' date field as today date when Finding state is in Complete.
    
        ********************************************************************************************************************  
    Change History    : 
        ********************************************************************************************************************         
        SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
        ********************************************************************************************************************  
        01  : 24.JUNE.2013   :  XXX-XXX(XXXX)     : Trigger Created  :
        02  : 28.APRL.2015   :  Srikanth V(IGATE) : Trigger Modified : Updating 'Target Completion Date' field based on 'Finding Start date'.
        03  : 08.JULY.2015   :  Srikanth V(IGATE) : Trigger Modified : Updating 'Actual' date field with today date when Finding state is Complete.
        04  : 18.AUG.2015    :  Srikanth V(IGATE) : Trigger Modified : Bug Fix - For: Updating 'Actual' date field with today date when Finding state is 
                                                                       Complete.(Added ISUPDATE and ISINSERT conditions)
        05  : 22.SEP.2015    :  Srikanth V(IGATE) : Trigger Modified : Updating 'Primary Function' field based on Audit 
                                                                       'Audit Organization'.                                                     
                                                                       
    Notes   :
        ********************************************************************************************************************         
        01) 
        02)    
*/
Trigger CheckActionPlanStatus on Finding__c (before update,before insert){   
    if(trigger.isbefore & (trigger.isupdate || trigger.isinsert)){
        Map<id,list<QIPP_Action_Plan__c>> actionmap = new Map<id,list<QIPP_Action_Plan__c>>();
        IF(trigger.isupdate){
            //Geting all child records(Acrion plan)
            List<QIPP_Action_Plan__c> actionplans = [select Finding_ID__c ,Target_Completion_Date_PA__c,Target_Completion_Date_CA__c,Action_Plan_Target_Completion_Date__c,Action_Plan_State__c from  QIPP_Action_Plan__c where Finding_ID__c =: Trigger.NewMap.keyset()];
            for(QIPP_Action_Plan__c acp :actionplans){
                if(!actionmap.containsKey(acp.Finding_ID__c)){
                actionmap.put(acp.Finding_ID__c, new list<QIPP_Action_Plan__c>{acp});
                }else{
                    actionmap.get(acp.Finding_ID__c).add(acp);
                }
            }
        }
            
        Map<id,Management_System_Audit__c> auditmap = new Map<id,Management_System_Audit__c>();
        set<id> auditids = new set<id>();
        if(trigger.isinsert){
            for(Finding__c finding : Trigger.New){
                auditids.add(finding.Audit_Name__c);
            }
            for(Management_System_Audit__c audit : [select id, name,Audit_organization__c from Management_System_Audit__c where id in:auditids]){
                auditmap.put(audit.id,audit);
            }
        }

        for(Finding__c finding : Trigger.New){
            IF(trigger.isupdate){
                Boolean checkActionPlanCount = true;
                Boolean checkActionPlanStatus = true;
                // get all acction planes
                list<QIPP_Action_Plan__c> acp = actionmap.get(finding.id);
                if(acp != null){
                    for( QIPP_Action_Plan__c a : acp) {
                        if(a.Action_Plan_State__c == 'In Progress' || a.Action_Plan_State__c == 'On hold' || a.Action_Plan_State__c == 'Not started'){
                            checkActionPlanStatus = false;
                            break;
                        }
                    }  
                }else{
                    checkActionPlanCount = false;
                }
                if(finding.Finding_State__c == 'Complete' && checkActionPlanCount == false && (finding.Classification__c == 'Non-Conformance Major' || finding.Classification__c == 'Non-Conformance Minor' || finding.Classification__c == 'Opportunity For Improvement') ){
                    finding.Finding_State__c.addError('Please include atleast one Action Plan.');    
                }
                else if(finding.Finding_State__c == 'Complete' && checkActionPlanStatus == false && (finding.Classification__c == 'Non-Conformance Major' || finding.Classification__c == 'Non-Conformance Minor' || finding.Classification__c == 'Opportunity For Improvement') ){
                    finding.Finding_State__c.addError('All action plans must be either closed or canceled before finding status considered as Complete.');
                }                
            }
            // Before Insert and update
            if(finding.FindingStartDate__c != null && finding.Finding_Completion_Date_Target__c == null && finding.Update_Target_Completion_Date__c ){
                //date tdate = n.FindingStartDate__c+90;  
                finding.Finding_Completion_Date_Target__c = finding.FindingStartDate__c+90;
                finding.Update_Target_Completion_Date__c = False;
                system.debug('Entered : Target Completion Date');
            }
            if(trigger.isupdate){
                if(finding.Finding_State__c == 'Complete'  &&  finding.Finding_State__c != Trigger.oldMap.get(finding.Id).Finding_State__c ){
                    finding.Finding_Completion_Date_Actual__c = system.today();
                }
            }else{ // Before Insert Trigger
                if(trigger.isinsert && finding.Finding_State__c == 'Complete'){
                    finding.Finding_Completion_Date_Actual__c = system.today();                    
                }
            }
            //R63 Release = R15-5 
            //Before Insert Trigger
            if(trigger.isinsert && string.isblank(Finding.Primary_QLT_Function__c)){
                Management_System_Audit__c audit = auditmap.get(Finding.Audit_Name__c);
                system.debug('Finding Primary Function empty  ::::: '+string.isblank(Finding.Primary_QLT_Function__c));
                
                system.debug('Finding Primary Function From Audit : '+Finding.Audit_Name__r.Audit_organization__c); // Not Updated this value in Before Insert
                Finding.Primary_QLT_Function__c = audit.Audit_organization__c;
            }    
        }
    }
}