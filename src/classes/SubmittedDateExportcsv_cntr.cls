public class SubmittedDateExportcsv_cntr{

    public List<reportwrap> reportresult {get;set;}
  //  public Integer countr {get;set;}
    public string CSVtype {get;set;}

    public SubmittedDateExportcsv_cntr() {
       // countr = 0;
       reportresult = new List<reportwrap>(); 
       CSVtype = ',';
    }
    // Page Loader 
    public PageReference actionTrackerProcessor() {
        getProjectsDueForAction();
        return null;
    }
    // Logical function
    public List<reportwrap> getProjectsDueForAction(){
        
        //list<QIPP_Project__c> ProjectList = new list<QIPP_Project__c>();
        list<ProcessInstance> PIlist = new list<ProcessInstance>();
        list<ProcessInstanceNode> PINlist = new list<ProcessInstanceNode>();
        list<ProcessInstanceWorkitem> PIWlist =new list<ProcessInstanceWorkitem>();
        list<user> userlist = new list<user>();
        
        list<id> projectids = new list<id>();
        //map<Id,QIPP_Project__c> prjmap = new map<Id,QIPP_Project__c>();
        map<Id,ProcessInstance> PImap = new map<Id,ProcessInstance>();
        map<Id,ProcessInstanceNode> PINmap = new map<Id,ProcessInstanceNode>();
        map<Id,ProcessInstanceWorkitem> PIWmap = new map<Id,ProcessInstanceWorkitem>();
        map<Id,user>  usermap = new map<Id,user> ();
        
        PIlist = [select Id,CompletedDate,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,LastActorId,Status,TargetObjectId,ProcessDefinitionId,createddate from ProcessInstance where TargetObject.Type = 'QIPP_Project__c' and Status ='Pending' ORDER BY createddate DESC];
        System.debug(' ProcessInstance size :'+PIlist.size());
        // Assign Unique Values   
        if(PIlist.size() > 0){
            for (ProcessInstance p : PIlist ){
                PImap.put(p.id,p); 
                projectids.add(p.TargetObjectId);
                System.debug(' ProcessInstance ids :'+p.id);           
            }
            map<Id,QIPP_Project__c> prjmap = new map<Id,QIPP_Project__c>([select Id,name,Project_Type__c,Project_BL__c,Belt_Project_Phase__c,Project_Lead__c,Project_State__c,Project_Lead__r.name,Project_Lead_Email__c,Project_Lead_BU__c,Project_Lead_BL_Level_3_Org__c,Project_Name_Succinct__c,Portfolio_BU__c,Portfolio_Name__r.name,Belt_Project_Type__c,Portfolio_Name__r.Portfolio_Owner__r.id,Portfolio_Name__c,Business_Unit_Master_Black_Belt__r.id,Business_Unit_Master_Black_Belt__r.name,Portfolio_Owner__c,Approver_BU_MBB__r.name,Portfolio_Owner_EmailID__c,Approver_BU_MBB__c,Email_BU_MBB__c from QIPP_Project__c where id in:projectids ORDER BY LastModifiedDate DESC]);
            
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
                //System.debug(' Prjtget1 size :'+Prjtget1);
                reportwrap result = new reportwrap();
                
                result.ProjectID = Prjtget1.name;
                result.ProjID= Prjtget1.id;
                result.Methodology = Prjtget1.Project_Type__c;
                result.LeadName = Prjtget1.Project_Lead__r.name;
                result.LeadNameID= Prjtget1.Project_Lead__r.id;
                result.Leademail = Prjtget1.Project_Lead_Email__c;
                result.LeadBU = Prjtget1.Project_Lead_BU__c;
                result.LeadBL = Prjtget1.Project_Lead_BL_Level_3_Org__c;
                result.ProjectName = Prjtget1.Project_Name_Succinct__c;
                result.ProjectBU = Prjtget1.Portfolio_BU__c;
                result.ProjectBL = Prjtget1.Project_BL__c;
                result.ProjectType = Prjtget1.Belt_Project_Type__c;
               // result.Phase = Prjtget1.Belt_Project_Phase__c;
                if(Prjtget1.Project_Type__c == 'DMAIC'){
                    result.Phase = Prjtget1.Belt_Project_Phase__c;
                }else{
                    result.Phase = PINget1.ProcessNodeName;
                }
                result.ApproverName = userget1.firstname+' '+userget1.lastname;
                result.ApproverID = userget1.id;
                result.ApproveEmail = userget1.email;
                result.ApproveRole = PINget1.ProcessNodeName;               
                result.ApproveDate = (PISget1.createddate).date().format(); 
                result.PortfolioName = Prjtget1.Portfolio_Name__r.name;
                result.PortfolioOwner = Prjtget1.Portfolio_Owner__c;
                result.PortfolioOwnerID= Prjtget1.Portfolio_Name__r.Portfolio_Owner__r.id;
                result.PortfolioOwneremail = Prjtget1.Portfolio_Owner_EmailID__c;
                result.BUMBBName = Prjtget1.Approver_BU_MBB__r.name;
                result.BUMBBID = Prjtget1.Approver_BU_MBB__r.id;
                result.BUMBBemail = Prjtget1.Email_BU_MBB__c;
                
                reportresult.add(result);
            }
            //countr = reportresult.size();
        }
        return reportresult;
    }
    
    public class reportwrap{
        public String ProjectID{get; set;} 
        public String ProjID{get; set;} 
        public String Methodology{get; set;} 
        public String LeadName{get; set;} 
        public String LeadNameID{get; set;}
        public String Leademail{get; set;} 
        public String LeadBU{get; set;} 
        public String LeadBL{get; set;} 
        public String ProjectName{get; set;} 
        public String ProjectBU{get; set;} 
        public String ProjectBL{get; set;} 
        public String ProjectType{get; set;} 
        public String Phase{get; set;} 
        public String ApproverName{get; set;} 
        public String ApproverID{get; set;} 
        public String ApproveEmail{get; set;} 
        public String ApproveRole{get; set;} 
        public String ApproveDate{get; set;} 
        public String PortfolioName{get; set;} 
        public String PortfolioOwner{get; set;} 
        public String PortfolioOwnerID{get; set;} 
        public String PortfolioOwneremail{get; set;} 
        public String BUMBBName{get; set;} 
        public String BUMBBID{get; set;} 
        public String BUMBBemail{get; set;}   
    }
   /* public Integer getCounter()
    {
        return countr; 
    }   */    
}