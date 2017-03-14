trigger UpdateActionOwnerAndFindingAuditorName on QIPP_Action_Plan__c (before insert , before update,after insert,after update){
    set<id> findingids = new set<id>();
    set<id> contactsids = new set<id>();
    for(QIPP_Action_Plan__c action : Trigger.New){
        contactsids.add(action.Action_Owner__c);
        findingids.add(action.Finding_ID__c);
    }
    Map<ID, Finding__c> findings = new Map<ID, Finding__c>([SELECT Id,Finding_State__c, Finding_Auditor_Email__c,(select id,Action_Plan_State__c from Action_Plans__r) FROM Finding__c where Id =: findingids]);
    system.debug('findings MAP ::  '+findings );
    if(Trigger.isBefore){
        Map<ID, QIPP_Contacts__c> contacts = new Map<ID, QIPP_Contacts__c>([SELECT Id, Email__c FROM QIPP_Contacts__c where Id =: contactsids]);
        for (QIPP_Action_Plan__c action : Trigger.New){
            QIPP_Contacts__c Owner = contacts.get(action.Action_Owner__c);
            Finding__c Auditor = findings.get(action.Finding_ID__c);
            if (action.Action_Owner__c != null){
                action.Action_Owner_Email__c =  Owner.Email__c   ;
            }
            if(action.Finding_ID__c != null){
                action.Finding_Auditor_Email__c = Auditor.Finding_Auditor_Email__c ;
            }
        }
    }
    /*
    if(Trigger.isAfter){
        list<Finding__c> updatefinding = new list<Finding__c>();
        for (QIPP_Action_Plan__c action : Trigger.New){
            boolean Fupdate = true;
            Finding__c finding = findings.get(action.Finding_ID__c);
            system.debug('Actions Size  ::  '+finding.Action_Plans__r.size());
            //list<QIPP_Action_Plan__c> lacp = finding.Action_Plans__r;
            for(QIPP_Action_Plan__c acp : finding.Action_Plans__r){
                if(acp.Action_Plan_State__c != 'Complete'){
                    Fupdate = false;
                    break;
                }
            }
            //if(Fupdate & finding.Record_Status__c == 'Closed')
            if(Fupdate){
                finding.Finding_State__c = 'Complete';
                updatefinding.add(finding);
            }
        }
        if(updatefinding.size()>0){
            update updatefinding;
        }
    }
    */
}








/*****************Old Code*************

trigger UpdateActionOwnerAndFindingAuditorName on QIPP_Action_Plan__c (before insert  , before update) 
{
    for (QIPP_Action_Plan__c action : Trigger.New)
    {
              System.Debug(' ##############  Before Action ################  ' + action);

               QIPP_Contacts__c Owner = null;
               Finding__c Auditor = null;
  
                if (action.Action_Owner__c != null)
                {
                         Owner =   [select Email__c from QIPP_Contacts__c where Id =: action.Action_Owner__c];                
                         action.Action_Owner_Email__c =  Owner.Email__c   ;
               }
               
               if(action.Finding_ID__c != null)
                {
                          Auditor = [select Finding_Auditor_Email__c from Finding__c where Id =: action.Finding_ID__c];      
                          action.Finding_Auditor_Email__c = Auditor.Finding_Auditor_Email__c ;
                }
             System.Debug(' ##############  After Action ################  ' + action);
    }
}
*/