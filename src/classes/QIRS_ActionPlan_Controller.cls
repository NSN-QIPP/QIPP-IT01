public class QIRS_ActionPlan_Controller {
    
    public QIRS_Action_Plan__c objAP    {get;set;}
    public boolean Isvisible            {get;set;}
    public string strMode               {get;set;}     
    public string strSubtitleValue      {get;set;}
    public boolean isActionTypeEditable {get;set;}

    public QIRS_ActionPlan_Controller(ApexPages.StandardController controller) {
        isActionTypeEditable = false;
        String strAP= System.currentPagereference().getParameters().get('id');
        String strQIRS =System.currentPagereference().getParameters().get('qirsid'); 
        Isvisible = false;
        if((strAP == '' || strAP == null) && strQIRS != ''){
            strMode = 'ADD';
            strSubtitleValue    = 'New Action Plan';
            objAP               = new QIRS_Action_Plan__c();
            objAP.QIRS__c       = strQIRS;
            objAP.Status__c     = 'Open';
            list<QIRS__c> tempqirs1 = new list<QIRS__c>();                       
            tempqirs1 = [SELECT Problem_Description1__c from QIRS__c where id =: strQIRS];                       
            if(tempqirs1.size() > 0){
                objAP.Reason1__c = tempqirs1[0].Problem_Description1__c;
            }
        }else{
            if(([select ID from QIRS_Action_Plan__c where Id =: strAP]).size() > 0){
                strMode = 'EDIT';  
                objAP = [select IsRecall__c,IsChampChange__c,IsApproverChange__c, ActionPlanDelayedFlag__c, ActionPlanExpiredFlag__c, ManagerEsclationFlag__c,
                            Action_Plan_Counter__c,Implementation_Comment__c,Core_ID__c,ID, Name, Task__c,Action_Type__c,Implementation_Date__c,QIRS__c,Reason1__c,Required_date__c,Status__c,CreatedByID,QIRS__r.Process_Owner1__c 
                            from QIRS_Action_Plan__c where Id =: strAP];
    
                QIRS_Admin_Profile__c qirsAdmProfile = QIRS_Admin_Profile__c.getValues('QIRSAdminProfileIDValue');
                isActionTypeEditable = (UserInfo.getProfileId() == qirsAdmProfile.QIRS_Admin_Profile_ID__c && objAP.Status__c != 'Closed');
                if(objAP != null){
                    strSubtitleValue = objAP.Name;
                    /* NEED TO LOOK WHEN AND WHOM TO SHOW IMPLEMENTATION DATE AND IMPLEMENTATION COMMENT
                       NOW IT IS VISIBLE TO CHAMPION(CURRENT USER IS) AND WHEN STATUS IS NOT IN OPEN AND REJECTED
                       SOME THING WRITTEN ABOUT ADMIN PROFILE CHECK THAT AS WELL */
                }
            }
        }
    }

    public PageReference cancel(){
        PageReference pageRef = new PageReference('/' + objAP.QIRS__c);
        pageRef.setRedirect(true);
        return pageRef;
    }

    @TestVisible private Integer AddRefCode(String QIRSID){
        Integer counter =0;
        list<QIRS_Action_Plan__c> objCount = [select Action_Plan_Counter__c from QIRS_Action_Plan__c where QIRS__c =: QIRSID and Action_Plan_Counter__c != null order by Action_Plan_Counter__c desc];
        counter = objCount.size() == 0 ? 1 : (Integer.ValueOf(objCount[0].Action_Plan_Counter__c) + 1);
        return counter;
    }

    public PageReference Save(){
        try{  
            if(objAP.Required_date__c < Date.TODAY()){
                objAP.Required_date__c.addError('Required date can not be less today date.'); 
                return null;
            }
            if(strMode == 'ADD'){ 
                objAP.Status_Date1__c = Date.Today();
                list<QIRS__c> qirs = [Select Name from QIRS__c where id =: objAP.QIRS__c];
                Integer refCodeValue = AddRefCode(objAP.QIRS__c);
                objAP.Name = qirs[0].Name + '.'+ String.ValueOf(refCodeValue); 
                objAP.Action_Plan_Counter__c = refCodeValue;
                objAP.Original_Created_By__c = UserInfo.getUserId();
                Database.SaveResult sr = Database.insert(objAP);
                 if(sr.isSuccess()){
                    PageReference pageRef = new PageReference('/' + objAP.Id);
                    pageRef.setRedirect(true);
                    return pageRef;
                 }else{
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
                     return null;
                 }
            }else{ 
                if(Isvisible){
                    //Added by tejas on Apr 11,2012 as we received new change request            
                    if(objAP.Implementation_Date__c > Date.TODAY()){
                        objAP.Implementation_Date__c.addError('Implementation date can not be greater than today date.'); 
                        return null;
                    }
                }
                Database.SaveResult sr = Database.update(objAP);
                if(sr.isSuccess()){
                    PageReference pageRef = new PageReference('/' + objAP.Id);
                    pageRef.setRedirect(true);
                    return pageRef;
                }else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to update entered data.')); 
                    return null;
                }
            }         
        }catch(System.DmlException ex){
            ApexPages.addMessages(ex); 
            return null;
        }
        return null;
    }
}