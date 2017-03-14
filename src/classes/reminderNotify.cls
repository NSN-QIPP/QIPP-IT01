global class reminderNotify implements Database.Batchable<sObject> {
        
        list<ProcessInstance> PIlist = new list<ProcessInstance>();
        list<ProcessInstanceNode> PINlist = new list<ProcessInstanceNode>();
        list<ProcessInstanceWorkitem> PIWlist =new list<ProcessInstanceWorkitem>();
        list<user> userlist = new list<user>();
        list<QIPP_Contacts__c> conlist = new list<QIPP_Contacts__c>();
        Integer Overduedays;
      Integer remainder;
        list<id> projectids = new list<id>();
        map<Id,ProcessInstance> PImap = new map<Id,ProcessInstance>();
        map<Id,ProcessInstanceNode> PINmap = new map<Id,ProcessInstanceNode>();
        map<Id,ProcessInstanceWorkitem> PIWmap = new map<Id,ProcessInstanceWorkitem>();
    map <Id, Id> PIActormap = new map<Id,Id>(); 
        map<Id,user>  usermap = new map<Id,user> ();
        map<string,QIPP_Contacts__c> conmap = new map<string,QIPP_Contacts__c>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String soql = 'SELECT Id,Project_Number__c,Approver_Protfolio_Owner_Email_1__c,Approver_Protfolio_Owner_Email_2__c,Approver_Protfolio_Owner_Email_3__c,Approver_Protfolio_Owner_Email_4__c,Email_Approval_Check__c,Project_Name_Succinct__c,Project_Lead__c,Project_Completion_Date_Actual__c,Unsubscribe_Project_Record__c,Project_Lead__r.name,Project_Lead_Email_ID__c,Salesforce_Org_URL__c,Total_Project_Validation_Amount__c,Project_State_Completed_Date__c,Project_State__c,Next_Approver__c,Approver_Lean_Coach__c,Approver_Financial_Approver__c,Approver_Belt_Project_Sponsor__c,Approver_BU_MBB__c,Approver_Operational_Savings__c,Portfolio_Owner__c,Approver_Improvement_Owner__c,Belt_Project_Sponsor_Email__c,Business_Unit_Master_Black_Belt_Email__c,Email_BU_MBB__c,Email_Finance_Approver__c,Email_Line_Manager__c,Email_Mentor__c,Finance_Approver_Email__c,Global_MBB_Email__c,Lean_Coach_Email__c,Line_Manager_Email__c,Portfolio_Owner_EmailID__c,Project_Lead_Email__c  from QIPP_project__c WHERE (Project_State__c =\'Complete\') and (Unsubscribe_Project_Record__c = false)';
        if(Test.isRunningTest()){
        soql += ' limit 5';
        }
        Database.getQueryLocator(soql);
        return Database.getQueryLocator(soql);
    }
    global void execute(Database.BatchableContext bc, List<QIPP_project__c> recs) {
  map <id,id> idmap = new map<id,id>();
    for(QIPP_project__c m : recs) {
            if(m.Project_State_Completed_Date__c!= null && m.Project_State__c == 'Complete'){
            Overduedays = m.Project_State_Completed_Date__c.daysBetween(system.today());
      remainder = math.mod(Overduedays, 7);
            if((Overduedays > 7) && remainder == 0){
                idmap.put(m.id,m.id);
                }  
            }
        }
        PIlist = [select Id,CompletedDate,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,LastActorId,Status,TargetObjectId,ProcessDefinitionId,createddate from ProcessInstance where TargetObject.Type = 'QIPP_Project__c' and Status ='Pending' and TargetObjectId in :idmap.keyset()];
        if(PIlist.size() > 0){
      for(ProcessInstance p : PIlist ){
                PImap.put(p.id,p); 
                System.debug(' ProcessInstance ids :'+p.id);           
            }
            PIWlist = [ select Id, ActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,OriginalActorId,ProcessInstanceId,createddate  from ProcessInstanceWorkitem where ProcessInstanceId IN :PImap.keyset()];   
            System.debug('ProcessInstanceWorkitem List size :'+PIWlist.size()); 
            for (ProcessInstanceWorkitem p : PIWlist ){
                PIWmap.put(p.ProcessInstanceId,p); 
        PIActormap.put(PImap.get(p.ProcessInstanceId).TargetObjectId,p.ActorId);
        
                System.debug(' ProcessInstanceWorkitem ids :'+p.id+ '=' +p.ProcessInstanceId);
            }
      System.debug('PIActormap***** :'+PIActormap);
            userlist = [select firstname,lastname,email, UserRole.name from user where Id IN : PIActormap.values()]; 
            System.debug('USER List size :'+userlist.size());       
            for (user p : userlist ){
                usermap.put(p.id,p);
                System.debug('User name: '+p.firstname+'User ids :'+p.id);      
            }
            conlist = [select id,name,Email__c,User_License__c,User_License__r.id from QIPP_Contacts__c where User_License__r.id in: usermap.keyset()];
            for (QIPP_Contacts__c con : conlist ){
                conmap.put(con.Email__c,con);
            }
            
            PINlist =[select id,ProcessNodeName,ProcessInstanceId,ProcessNodeId,CompletedDate,NodeStatus from ProcessInstanceNode where ProcessInstanceId in : PImap.keyset() and NodeStatus = 'Pending'];
            System.debug(' ProcessInstanceNode size :'+PINlist.size()); 
            for (ProcessInstanceNode p : PINlist ){
                PINmap.put(p.ProcessInstanceId,p); 
                System.debug(' ProcessInstanceNode values :'+p.id+'='+p.ProcessInstanceId);         
            }
    }
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        for(QIPP_project__c m : recs) {
            
      if((PIActormap.get(m.id) != null) && (idmap.containskey(m.id))){
            List<String> toAddresses = new List<String>();     
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            toAddresses.add(m.Approver_Protfolio_Owner_Email_1__c);
            toAddresses.add(m.Approver_Protfolio_Owner_Email_2__c);
            toAddresses.add(m.Approver_Protfolio_Owner_Email_3__c);
            toAddresses.add(m.Approver_Protfolio_Owner_Email_4__c);
            system.debug('emailaddress'+toAddresses);
            mail.setToAddresses(toAddresses);
            Integer Overduedays = m.Project_State_Completed_Date__c.daysBetween(system.today());
            mail.setSubject('[Action Required] Reminder: ' +m.Project_Number__c+ ' pending your approval for ' +Overduedays+ ' days');
            Date compdt = m.Project_State_Completed_Date__c;
            String dayString = DateTime.newInstance(compdt.year(),compdt.month(),compdt.day()).format('dd-MMM-YYYY');
            //String messageBody = '<html><body><p style="font-size:.9em">[<b><a href="'+m.Salesforce_Org_URL__c+'/apex/UnsubscripeProject?ObjectId='+m.Id+'">Unsubscribe</a></b> ' +m.Project_Number__c+' Reminder]<p> Dear '  + usermap.get(PIActormap.get(m.id)).firstname+''+usermap.get(PIActormap.get(m.id)).lastname+ ',<br><br>This is a reminder to inform you that the below project is waiting your final approval to Close since ' +dayString+'<br><br>Your immediate action is required to review this approval request.<br><br><b style="color:red;">Approval Pending: '+Overduedays +' days</b><br>Project No: '+ m.Project_Number__c+'<br>Project Name: '+ m.Project_Name_Succinct__c+'<br>Project Lead: '+ m.Project_Lead__r.name+'<br>Validated Savings: '+ m.Total_Project_Validation_Amount__c+' k€<br><br>After login into QIPP, Please click the below link to review the approval request. Please ensure that the project has met all the requirements of closure.<br>Upon your approval, the project will be marked as “Closed” and the relevant savings will be reflected in the CII reports.<br><br>'+m.Salesforce_Org_URL__c+''+m.Id+'<br><br>click on this link to log into QIPP and then navigate to the referenced project:<br>https://intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com<br><br><b>Best Regards,</b><br>QIPP Admin<br><br>This is an auto generated email.</body></html>';
            String messageBody = '<html><body><p style="font-size:.9em">[<b><a href="'+m.Salesforce_Org_URL__c+'/apex/UnsubscripeProject?ObjectId='+m.Id+'">Unsubscribe</a></b> ' +m.Project_Number__c+' Reminder]<p> Dear '  +m.Email_Approval_Check__c+ ',<br><br>This is a reminder to inform you that the below project is waiting your final approval to Close since ' +dayString+'<br><br>Your immediate action is required to review this approval request.<br><br><b style="color:red;">Approval Pending: '+Overduedays +' days</b><br>Project No: '+ m.Project_Number__c+'<br>Project Name: '+ m.Project_Name_Succinct__c+'<br>Project Lead: '+ m.Project_Lead__r.name+'<br>Validated Savings: '+ m.Total_Project_Validation_Amount__c+' k€<br><br>After login into QIPP, Please click the below link to review the approval request. Please ensure that the project has met all the requirements of closure.<br>Upon your approval, the project will be marked as “Closed” and the relevant savings will be reflected in the CII reports.<br><br>'+m.Salesforce_Org_URL__c+''+m.Id+'<br><br>click on this link to log into QIPP and then navigate to the referenced project:<br>https://intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com<br><br><b>Best Regards,</b><br>QIPP Admin<br><br>This is an auto generated email.</body></html>';
            mail.setHtmlBody(messageBody); 
            mailList.add(mail);          
            }  
        } 
        Messaging.sendEmail(mailList);
    }
   
    global void finish(Database.BatchableContext bc) {
    }
}