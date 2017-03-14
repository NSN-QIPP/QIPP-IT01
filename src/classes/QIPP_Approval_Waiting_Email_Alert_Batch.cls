/*
    Class/Triger Name : QIPP_Approval_Waiting_Email_Alert_Batch
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
        01) 
        02)    
*/
global class QIPP_Approval_Waiting_Email_Alert_Batch  implements Database.Batchable<sObject> {
    public String query; 
    public id OWEA; 
    //public id temp3week;
    //public id temp6week;
    //public id temp9week;     
    
    public QIPP_Approval_Waiting_Email_Alert_Batch(){
        OrgWideEmailAddress[] owa = [select id, Address from OrgWideEmailAddress where Address = 'qippadmin.quality@nokia.com'];
        if(owa.size() > 0 ){OWEA = owa.get(0).Id;}
        System.debug('OWEA :'+OWEA);        
        /*list<EmailTemplate> et1 = new list<EmailTemplate>( [SELECT Id,developerName FROM EmailTemplate WHERE developerName in ('Sample3W_TEMP','Sample6W_TEMP','Sample9W_TEMP')]);
        for( EmailTemplate e: [SELECT Id,developerName FROM EmailTemplate WHERE developerName in ('Sample3W_TEMP','Sample6W_TEMP','Sample9W_TEMP')]){
            if(e.developerName == 'Sample3W_TEMP'){temp3week = e.id;}
            if(e.developerName == 'Sample6W_TEMP'){temp6week = e.id;}
            if(e.developerName == 'Sample9W_TEMP'){temp9week = e.id;}
        }*/               
    }        
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, list<QIPP_Project__c> pids){
        List<reportwrap> reportresult = new List<reportwrap>();  // Main Result**
        
        list<QIPP_Project__c> ProjectList = new list<QIPP_Project__c>();
        list<ProcessInstance> PIlist = new list<ProcessInstance>();
        list<ProcessInstanceNode> PINlist = new list<ProcessInstanceNode>();
        list<ProcessInstanceWorkitem> PIWlist =new list<ProcessInstanceWorkitem>();
        list<user> userlist = new list<user>();
        list<QIPP_Contacts__c> conlist = new list<QIPP_Contacts__c>();
        
        map<Id,QIPP_Project__c> prjmap = new map<Id,QIPP_Project__c>();
        map<Id,ProcessInstance> PImap = new map<Id,ProcessInstance>();
        map<Id,ProcessInstanceNode> PINmap = new map<Id,ProcessInstanceNode>();
        map<Id,ProcessInstanceWorkitem> PIWmap = new map<Id,ProcessInstanceWorkitem>();
        map<Id,user>  usermap = new map<Id,user> ();
        map<string,QIPP_Contacts__c> conmap = new map<string,QIPP_Contacts__c>();
        //ProjectList  = [select Id,name,Project_Type__c,Project_BL__c,Belt_Project_Phase__c,Project_Lead__c,Project_State__c,Project_Lead__r.name,Project_Lead_Email__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Name_Succinct__c,Portfolio_BU__c,Portfolio_Name__r.name,Belt_Project_Type__c,Portfolio_Name__r.Portfolio_Owner__r.id,Portfolio_Name__c,Business_Unit_Master_Black_Belt__r.id,Business_Unit_Master_Black_Belt__r.name,Portfolio_Owner__c,Approver_BU_MBB__r.name,Portfolio_Owner_EmailID__c,Approver_BU_MBB__c,Email_BU_MBB__c from QIPP_Project__c where Project_State__c != 'Not Started'];        
        System.debug('Project List size :'+pids.size());
        // Assign Unique Values           
        for(QIPP_Project__c q : pids){
            prjmap.put(q.Id,q);
        }
        //ProcessInstance for Approval requested data
        PIlist = [select Id,CompletedDate,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,LastActorId,Status,TargetObjectId,ProcessDefinitionId,createddate from ProcessInstance where TargetObjectId IN : prjmap.keyset() and Status ='Pending' ORDER BY createddate DESC];
        System.debug(' ProcessInstance size :'+PIlist.size());
        // Assign Unique Values   
        for (ProcessInstance p : PIlist ){
            PImap.put(p.id,p); 
            System.debug(' ProcessInstance ids :'+p.id);           
        }
        //Geting current approver 'User'/'QIPP Contact' details from 'ProcessInstanceWorkitem'
        set<id> PendingUserId = new set<id>();
        PIWlist = [ select ActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,OriginalActorId,ProcessInstanceId,createddate from ProcessInstanceWorkitem where ProcessInstanceId IN :PImap.keyset()];   
        System.debug('ProcessInstanceWorkitem List size :'+PIWlist.size());     
        for (ProcessInstanceWorkitem p : PIWlist ){
            PIWmap.put(p.ProcessInstanceId,p); 
            PendingUserId.add(p.ActorId);
            System.debug(' ProcessInstanceWorkitem ids :'+p.id+ '=' +p.ProcessInstanceId);           
        }
        userlist = [select firstname,lastname,email, UserRole.name from user where Id IN : PendingUserId]; 
        System.debug('USER List size :'+userlist.size());       
        for (user p : userlist ){
            usermap.put(p.id,p);
            System.debug('User name: '+p.firstname+'User ids :'+p.id);      
        }
        conlist = [select id,name,Email__c,User_License__c,User_License__r.id from QIPP_Contacts__c where User_License__r.id in: usermap.keyset()];
        for (QIPP_Contacts__c con : conlist ){
            conmap.put(con.Email__c,con);
        }
        //Geting Approval process step Approver role name from 'ProcessInstanceNode'
        PINlist =[select id,ProcessNodeName,ProcessInstanceId,ProcessNodeId,CompletedDate,NodeStatus from ProcessInstanceNode where ProcessInstanceId in : PImap.keyset() and NodeStatus = 'Pending'];
        System.debug(' ProcessInstanceNode size :'+PINlist.size());
        // Assign Unique Values   
        for (ProcessInstanceNode p : PINlist ){
            PINmap.put(p.ProcessInstanceId,p); 
            System.debug(' ProcessInstanceNode values :'+p.id+'='+p.ProcessInstanceId);         
        }
        // main Logic 
        for(ProcessInstance Pi : PIlist){
            QIPP_Project__c Prjtget1= prjmap.get(pi.TargetObjectId);
            ProcessInstanceNode  PINget1 = PINmap.get(pi.id);
            ProcessInstanceWorkitem  PISget1 = PIWmap.get(pi.id);
            user userget1 = USERmap.get(PISget1.ActorId);
            QIPP_Contacts__c cons = conmap.get(userget1.email);
            reportwrap  result = new reportwrap();
                        result.proj = Prjtget1;
                        result.ApproveRole = PINget1.ProcessNodeName;
                        result.ApproveDate = PISget1.createddate.date();         
                        result.ApproverName = userget1.firstname+' '+userget1.lastname;
                        result.ApproverID = userget1.id;
                        result.ApproveEmail = userget1.email;
            reportresult.add(result);
        }            
        //Pending Approval Email Remainder Logic
        if(reportresult != null){
            List<Messaging.SingleEmailMessage> listEmails = new List<Messaging.SingleEmailMessage>();
            // Create Contact for temporarily 
            // Used for Targetobject for templete in sending email
            /*Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'Contact';
            con.Email = 'no-reply@organization.com';
            insert con;
            */
            for(reportwrap aprvdata : reportresult){
                integer diff = aprvdata.ApproveDate.daysBetween(system.today());
                            system.debug('Difference = '+diff);
                            system.debug('Project details = '+aprvdata.proj);
                //Geting Toadress 
                set<String> emailAddr = new set<String>(); 
                emailAddr.add(aprvdata.ApproveEmail);                           
                emailAddr.add(aprvdata.proj.Project_Lead_Email__c);
                emailAddr.add(aprvdata.proj.Belt_Candidate_Mentor_Email__c);
                emailAddr.add('management_desk.qipp@nokia.com');
                emailAddr.remove(null);
                list<string> emailAddrs = new list<string>(emailAddr);
                            system.debug('Project details = '+aprvdata.ApproveEmail);
                            system.debug('Project details = '+aprvdata.proj.Project_Lead_Email__c);
                            system.debug('Project details = '+aprvdata.proj.Belt_Candidate_Mentor_Email__c);                
                //Email Remainders for 3,6 and 9weeks 
                Messaging.SingleEmailMessage RemindEmail = new Messaging.SingleEmailMessage();              
                RemindEmail.setToAddresses(emailAddrs); 
                //RemindEmail.setTargetObjectId(con.id);                        
                //RemindEmail.setWhatId(aprvdata.proj.id);    
                RemindEmail.setSaveAsActivity(false);               
                if(OWEA != null){
                    RemindEmail.setOrgWideEmailAddressId(OWEA); 
                }
                //for 3weeks(21days)
                if(diff == 21){ 
                    //RemindEmail.setTemplateId(temp3week); 
                    //RemindEmail.setPlainTextBody(' Sample Remainder for 3week ');                    
                    String Subject = 'Reminder: ['+aprvdata.proj.Name+']'+' '+'Reminder - QIPP Project Awaiting Approval';
                    RemindEmail.setSubject(Subject);                    
                    String messageBody = '<html><body>Dear ['+aprvdata.ApproverName+'],<br/><br/>A request for your approval of QIPP project '+ aprvdata.proj.name+' '+'has been pending for 3 weeks and is awaiting your action. Please log into QIPP and disposition the approval request as appropriate.  Contact ['+aprvdata.proj.Project_Lead__r.name+'] (cc\'d) with any questions.<br/>If there are genuine reasons for keeping your approval requests pending then please ignore this email.<br/><br/>Thanks<br/><br/>Click on this link to log into QIPP and the approval request will be available on the Home Page: <a href="https:///intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com">https:///intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com</a><br/><br/></body></html>';
                    RemindEmail.setHtmlBody(messageBody);
                    //Adding all emails in list called as listEmails
                    listEmails.add(RemindEmail);
                    system.debug('9week sent out');
                }
                //for 6weeks(42days)
                if(diff == 42){  
                    //RemindEmail.setTemplateId(temp6week); 
                    //RemindEmail.setPlainTextBody(' Sample Remainder for 6week ');                    
                    String Subject = 'Reminder: ['+aprvdata.proj.Name+']'+' '+'Reminder - QIPP Project Awaiting Approval';
                    RemindEmail.setSubject(Subject);                    
                    String messageBody = '<html><body>Dear ['+aprvdata.ApproverName+'],<br/><br/>A request for your approval of QIPP project '+ aprvdata.proj.name+' '+'has been pending for 6 weeks and is awaiting your action. Please log into QIPP and disposition the approval request as appropriate.  Contact ['+aprvdata.proj.Project_Lead__r.name+'] (cc\'d) with any questions.<br/>If there are genuine reasons for keeping your approval requests pending then please ignore this email.<br/><br/>Thanks<br/><br/>Click on this link to log into QIPP and the approval request will be available on the Home Page: <a href="https:///intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com">https:///intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com</a><br/><br/> </body></html>';
                    RemindEmail.setHtmlBody(messageBody);
                    //Adding all emails in list called as listEmails
                    listEmails.add(RemindEmail);
                    system.debug('9week sent out');
                }
                //for 9weeks(63days)
                if(diff == 63){  
                    //RemindEmail.setTemplateId(temp9week); 
                    //RemindEmail.setPlainTextBody(' Sample Remainder for 9week ');                    
                    String Subject = 'Reminder: ['+aprvdata.proj.Name+']'+' '+'Reminder - QIPP Project Awaiting Approval';
                    RemindEmail.setSubject(Subject);                    
                    String messageBody = '<html><body>Dear ['+aprvdata.ApproverName+'],<br/><br/>A request for your approval of QIPP project '+ aprvdata.proj.name+' '+'has been pending for 9 weeks and is awaiting your action. Please log into QIPP and disposition the approval request as appropriate.  Contact ['+aprvdata.proj.Project_Lead__r.name+'] (cc\'d) with any questions.<br/>If there are genuine reasons for keeping your approval requests pending then please ignore this email.<br/><br/>Thanks<br/><br/>Click on this link to log into QIPP and the approval request will be available on the Home Page: <a href="https:///intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com">https:///intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com</a><br/><br/></body></html>';
                    RemindEmail.setHtmlBody(messageBody);
                    //Adding all emails in list called as listEmails
                    listEmails.add(RemindEmail);
                    system.debug('9week sent out');
                }
            }
            if(listEmails.size() > 0){
                Messaging.sendEmail(listEmails);    // Sending all emails in list at same time, so that governer limit...
            }                                       // like Too many Email invocation and No: of SOQL queries can be controlled.      
            //Delete Temporary Contact 
            //Delete con;
        }
    }
    
    public class reportwrap{
        public QIPP_Project__c proj{get; set;}
        public String ApproverName{get; set;} 
        public String ApproverID{get; set;} 
        public String ApproveEmail{get; set;} 
        public String ApproveRole{get; set;} 
        public Date ApproveDate{get; set;} 
    }    
    global void finish(Database.BatchableContext BC){ 
                        
    }

}