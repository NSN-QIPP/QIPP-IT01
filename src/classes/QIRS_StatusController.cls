public class QIRS_StatusController{

    public String statustype        = '';
    public boolean ISLifted         {get;set;}
    public String statusValue       {get;set;}
    public boolean Visible          {get;set;}
    public boolean WatchlistVisible {get;set;}
    public boolean TempVisible      {get;set;}
    public boolean Watchlist        {get;set;}
    public QIRS_Status__c objQStatus{get;set;}
    public string[] strmultiApp     {get;set;}
    public boolean IsMasterApp      {get;set;}
    public List<QIRS__c> tempqirs   = new List<QIRS__c>(); 
    
    public void setState(String n) {
        state = n;
    }
            
    public String getState() {
        return state;
    }
            
    public PageReference methodOne() {
        return null;
    }
            
    private String state = 'ProgressYellow';
      
    public QIRS_StatusController(){
        objQStatus= new QIRS_Status__c();
        objQStatus.QIRS__c = System.currentPagereference().getParameters().get('id');
        
        statustype = System.currentPagereference().getParameters().get('LQ1');
                             
        tempqirs=[SELECT Master_Approver__c,CreatedById,
                    Master_Approver1__c,Master_Approver2__c, Master_Approver3__c,Master_Approver4__c,Master_Approver5__c,Master_Approver6__c,
                    Master_Approver7__c,Master_Approver8__c,Master_Approver9__c,Master_Approver10__c,
                    Watchlist__c,Closed_Date1__c,WatchListComment__c,WatchListType__c,Status__c 
                from QIRS__c where id =: objQStatus.QIRS__c];                       
        if(tempqirs.size()>0){
            objQStatus.Comment__c= tempqirs[0].WatchListComment__c;
            Watchlist = tempqirs[0].Watchlist__c;
            if(statustype != 'app' || statustype != 'rej'){
                 if(tempqirs[0].Status__c != 'Submitted to Master Approval' && tempqirs[0].Status__c != 'Canceled'){
                     objQStatus.Status__c ='Open';
                     if(tempqirs[0].Status__c == QIRSBasecontroller.BaseVarQIRSLifted)
                         ISLifted = true;
                     else
                         ISLifted = false;
                 }else{
                     objQStatus.Status__c =tempqirs[0].Status__c;
                     ISLifted = false;                     
                 }
            }
        }   
              
        if(statustype == 'app' || statustype == 'rej'){
            String strChamp = UserInfo.getUserId(); 
            if(strChamp == tempqirs[0].CreatedById){
                IsMasterApp = true;                  
            }else{
                 IsMasterApp = false;                                        
            }
            ISLifted = false;
            Visible = false; 
            WatchlistVisible = false;
            TempVisible = true;
            if(statustype == 'app'){
                 statusValue = 'Approved';
            }else if(statustype == 'rej'){
                statusValue = 'Rejected';     
            }
        }else{
            if(tempqirs.size()>0){
                if(tempqirs[0].Watchlist__c){
                    WatchlistVisible = true;
                }else{
                    WatchlistVisible = false;
                }
            
                state = 'ProgressYellow';
                if(tempqirs[0].WatchListType__c == '' || tempqirs[0].WatchListType__c == null){
                    state = 'ProgressYellow';
                }else{
                    state =tempqirs[0].WatchListType__c;
                }
            }
            Visible = true;     
            TempVisible = false;        
        }
    }

    public QIRS_StatusController(ApexPages.StandardController controller) {}

    public PageReference cancel() {
        PageReference pageRef = new PageReference('/' + objQStatus.QIRS__c);
        pageRef.setRedirect(true);
        return pageRef;
        return null;
    }
    
    public PageReference Save(){
        list<QIRS_Action_Plan__c> qirsAllActionPlan = [select ID, Name, Action_Type__c,QIRS__c,Reason1__c,Required_date__c,Status__c 
                                                        from QIRS_Action_Plan__c where QIRS__r.Id =: objQStatus.QIRS__c];
        try{
            boolean  bError = true;
            String ErrorMessage ='';
            String  strActionPlanNumber = '';
            List<QIRS_Action_Plan__c> qirsAP = new List<QIRS_Action_Plan__c>();
        
            if(statusValue != '' && statusValue != null && TempVisible == true){
                if(IsMasterApp){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Master Approval can be provided by the Originator')); 
                    return null;
                }
                if(statusValue == 'Approved'){
                    objQStatus.Status_Support__c = 'Closed';   
                }else{
                    objQStatus.Status__c = QIRSBasecontroller.BaseVarQIRSLifted;
                    objQStatus.Status_Support__c = QIRSBasecontroller.BaseVarQIRSLifted;
                
                }
                bError = false;
            }else{
                objQStatus.Status_Support__c = objQStatus.Status__c;
                qirsAP =  [select ID, Name, Action_Type__c,QIRS__c,Reason1__c,Required_date__c,Status__c 
                            from QIRS_Action_Plan__c
                            where QIRS__r.Id =: objQStatus.QIRS__c and Status__c !=: 'Canceled' and Action_Type__c =: 'Containment/Temporal Solution'];
            
                if(qirsAP.size() == 0 && objQStatus.Status__c == 'Submitted to Master Approval' && statusValue == ''){
                    bError =true; 
                }
            
                for(Integer i = 0; i < qirsAP.size(); i++){
                    if(qirsAP[i].Status__c == QIRSBasecontroller.BaseVarQIRSAPClosed ){
                        bError =false;
                        ErrorMessage = '';
                        break;
                    }else{
                        bError =true;  
                        ErrorMessage ='Kindly make sure Containment/Temporal Solution action plan is Closed.';
                        break; 
                    }  
                }

                boolean isRootCauseAPPresent = false;
                boolean isCorrectiveAPPresent = false;
                boolean isPreventiveAPPresent = false;
                
                for(QIRS_Action_Plan__c qirsAPRec : qirsAllActionPlan){
                    if(qirsAPRec.Action_Type__c == 'Root Cause/Escape Point Analysis'){
                        isRootCauseAPPresent = true;
                    }else if(qirsAPRec.Action_Type__c == 'Corrective'){
                        isCorrectiveAPPresent = true;
                    }else if(qirsAPRec.Action_Type__c == 'Preventive'){
                        isPreventiveAPPresent = true;
                    }
                }
                
                if(!(isRootCauseAPPresent && isCorrectiveAPPresent && isPreventiveAPPresent)){
                    bError =true;  
                    ErrorMessage ='Kindly make sure all action plans are present.';
                }

                if(TempVisible == false){
                    if(objQStatus.Status__c == 'Canceled' || objQStatus.Status__c == 'Open' ){
                        bError =false;                            
                    }
                }            
                if(objQStatus.Status__c == 'Submitted to Master Approval'){
                    if(!ISLifted){
                        bError = true;
                        ErrorMessage ='Record can not be sent for Submit for Master approver as the record status is not Released.';                    
                    }
                }
            }

            if(bError == false){
                objQStatus.Watch_List_Status__c = state; 
                insert objQStatus;
                List<QIRS__c> qirs = new List<QIRS__c>();                       
                qirs=[SELECT Process_Owner1__r.Name, RejectedFlag__c, Business__c,Site1__c,Alert_Type__c,Business_Group__c,Reopen__c,Watchlist__c,Closed_Date1__c,WatchListComment__c,WatchListType__c,Status__c 
                        from QIRS__c where id =: objQStatus.QIRS__c];                       
                if(qirs.size() > 0){                           
                    if((qirs[0].Status__c == QIRSBasecontroller.BaseVarQIRSLifted && objQStatus.Status__c != QIRSBasecontroller.BaseVarQIRSOpen)
                         || (qirs[0].Status__c == 'Submitted to Master Approval' &&  objQStatus.Status__c != QIRSBasecontroller.BaseVarQIRSOpen) || 
                         (qirs[0].Status__c == QIRSBasecontroller.BaseVarQIRSOpen && objQStatus.Status__c != QIRSBasecontroller.BaseVarQIRSOpen)){
                            qirs[0].Status__c = objQStatus.Status_Support__c; 
                    }
                    qirs[0].WatchListComment__c = objQStatus.Comment__c; 
                    qirs[0].WatchListType__c = state; 
                    qirs[0].Watchlist__c = Watchlist; 
                    if(qirs[0].Reopen__c)   
                        qirs[0].Reopen__c = false; 
                    if(statusValue == 'Rejected')
                        qirs[0].RejectedFlag__c = true;
                    if(objQStatus.Status_Support__c == 'Closed')
                        qirs[0].Closed_Date1__c = Date.Today();                                                            
                    list<QIRS_Action_Plan__c> qirsAPToUpdate = new list<QIRS_Action_Plan__c>();
                    if(qirsAllActionPlan != null && !qirsAllActionPlan.isEmpty() && statusValue == 'Approved'){
                        for(QIRS_Action_Plan__c qirsAPRec : qirsAllActionPlan){
                            if(qirsAPRec.Status__c != 'Closed'){
                                qirsAPRec.Status__c = 'Closed';
                                qirsAPToUpdate.add(qirsAPRec);
                            }
                        }
                        if(qirsAPToUpdate != null && !qirsAPToUpdate.isEmpty()) update qirsAPToUpdate;
                    }
                    update qirs;
                }
                
                string strEmailStatus='';
                List<String> SiteList = new List<String>();
                SiteList.add(qirs[0].Site1__c);
                Boolean bresult = false;
                
                if(objQStatus.Status_Support__c == 'Closed'){
                    strEmailStatus ='Closed';
                    bresult = QIRSBasecontroller.SendEmail(SiteList, qirs[0].Business__c, qirs[0].Alert_Type__c,qirs[0].Business_Group__c,strEmailStatus,qirs[0].Id);
                }else if(objQStatus.Status_Support__c == QIRSBasecontroller.BaseVarQIRSLifted){
                    if(statustype == 'rej'){
                        strEmailStatus  = 'Rejected';
                        bresult = QIRSBasecontroller.SendEmail(SiteList, qirs[0].Business__c, qirs[0].Alert_Type__c,qirs[0].Business_Group__c,strEmailStatus,qirs[0].Id);
                    }
                }else if(objQStatus.Status_Support__c == 'Canceled'){     
                    strEmailStatus  = 'Canceled';
                    bresult = QIRSBasecontroller.SendEmail(SiteList, qirs[0].Business__c, qirs[0].Alert_Type__c,qirs[0].Business_Group__c,strEmailStatus,qirs[0].Id);
                }
                
                PageReference pageRef = new PageReference('/' + objQStatus.QIRS__c);
                pageRef.setRedirect(true);
                return pageRef;
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,ErrorMessage)); 
        
            }
        }catch(System.DmlException ex){
            ApexPages.addMessages(ex);
        }
        return null;
    }
}