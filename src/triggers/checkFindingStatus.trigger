trigger checkFindingStatus on Management_System_Audit__c (before update,after insert,after update) 
{

    // Added By Srikanth_V R15-3****
    if(trigger.isafter & (trigger.isupdate || trigger.isinsert)){
       
        Map<Id,List<Finding__c>> mapAuditIdAndFinding = new Map<Id,List<Finding__c>>();
        for(Finding__c obj :[select id,Audit_Name__c,Finding_Completion_Date_Target__c , Update_Target_Completion_Date__c ,FindingStartDate__c from Finding__c where Audit_Name__c in : trigger.newmap.keyset()]){
            if(mapAuditIdAndFinding.get(obj.Audit_Name__c) == null){
                mapAuditIdAndFinding.put(obj.Audit_Name__c,new List<Finding__c>());
            }
            mapAuditIdAndFinding.get(obj.Audit_Name__c).add(obj);
        }

        List<Finding__c> updateFinds = new List<Finding__c>();
        
        for(Management_System_Audit__c audits : trigger.new){
            List<Finding__c> auditChildList = mapAuditIdAndFinding.get(audits.Id);
            if(auditChildList != null ){
                for(Finding__c n : auditChildList){
                    if(audits.Audit_Executed_Date__c != null && n.Finding_Completion_Date_Target__c == null && n.Update_Target_Completion_Date__c ){
                        n.Finding_Completion_Date_Target__c = audits.Audit_Executed_Date__c+90;
                        n.Update_Target_Completion_Date__c = False;
                        updateFinds.add(n);
                    }
                    system.debug('$$$$$$$$$$1 Target**  '+n.Finding_Completion_Date_Target__c);
                    system.debug('$$$$$$$$$$2  Target check** '+n.Update_Target_Completion_Date__c);
                    system.debug('$$$$$$$$$$3   '+n.FindingStartDate__c);
                }
            }
        }
        if(updateFinds != null){
            update updateFinds;
        }
    }

    if(trigger.isbefore & trigger.isupdate){
        for(Management_System_Audit__c Audits : Trigger.new)
        {
                System.Debug('Audits : ' + Audits);

                List<Finding__c> listOfFinding = [select Finding_State__c , Audit_Name__c from Finding__c where Audit_Name__c  =: Audits.Id ]; // 'a18K0000000FIun'
                
                System.Debug('This is list : ' + listOfFinding);
                
                Boolean checkFindingStatus = true;
                
                if(listOfFinding != null)
                {
                    if(listOfFinding.size() > 0)
                    {
                        for(Finding__c a : listOfFinding) 
                        {
                            if(a.Finding_State__c == 'In Progress' || a.Finding_State__c == 'On hold' || a.Finding_State__c == 'Not started')
                            {
                                checkFindingStatus = false; 
                                break;
                            }
                        }
                    }
                 }   
                
                if(checkFindingStatus == false && Audits.Audit_Status__c == 'Completed')
                {
                      trigger.new[0].Audit_Status__c.addError('All findings must be either closed or canceled before audit status considered as Complete.');
                }
        }
    }
}