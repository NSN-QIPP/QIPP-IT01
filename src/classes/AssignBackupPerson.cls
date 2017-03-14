public class AssignBackupPerson {

    

    public AssignBackupPerson(){
        if(![SELECT NQT_Backup_Person__c, NQT_Availability_Status__c, NQT_From__c, NQT_To__c FROM NQT_Assign_Backup_Person__c WHERE OwnerId =: UserInfo.getUserId()].isEmpty())
            ABP = [SELECT NQT_Backup_Person__c, NQT_Backup_Person__r.Name, NQT_Availability_Status__c, NQT_From__c, NQT_To__c FROM NQT_Assign_Backup_Person__c WHERE OwnerId =: UserInfo.getUserId() LIMIT 1];
        else
            ABP = new NQT_Assign_Backup_Person__c();
        Edit = TRUE;
        Save = FALSE;
        Cancel= FALSE;
        status = ABP.NQT_Availability_Status__c;
        userCheck = TRUE;
    }
    
    public NQT_Assign_Backup_Person__c ABP { get; set; }
    public Boolean Edit { get; set; }
    public Boolean Save { get; set; }
    public Boolean Cancel { get; set; }
    public String status { get; set; }
    public Boolean userCheck { get; set; }
    public String bpProfile { get; set; }
    
    public pageReference Cancel1(){
        Save = FALSE;
        Edit = TRUE;
        return null;
        }

    public void saveRes(){
        Boolean requiredCheck = FALSE;
        //Boolean userCheck = TRUE;
        Boolean FE = FALSE;
        Boolean SE = FALSE;
        Boolean SEMSC = FALSE;
        Boolean AM = FALSE;
        Boolean PM = FALSE;
        User logedUser = [SELECT ProfileId, FE__c, SE__c, SEMSC__c, PM__c FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        User bpUser = new User();
        try{bpUser = [SELECT ProfileId, FE__c, SE__c, SEMSC__c, PM__c FROM User WHERE Id =: ABP.NQT_Backup_Person__c LIMIT 1];}catch(exception e){}
 
        if(ABP.NQT_Backup_Person__c == NULL){
            requiredCheck = TRUE;
            ABP.NQT_Backup_Person__c.addError('Value must be entered.');
            }
        /*if(ABP.NQT_Backup_Person__r.ProfileId != )*/
        if(ABP.NQT_From__c == NULL){
            requiredCheck = TRUE;
            ABP.NQT_From__c.addError('Value must be entered.');
            }
        if(ABP.NQT_To__c == NULL){
            requiredCheck = TRUE;
            ABP.NQT_To__c.addError('Value must be entered.');
            }
        if(status == ABP.NQT_Availability_Status__c){
            requiredCheck = TRUE;
            ABP.NQT_Availability_Status__c.addError('Please change the status');
            }
        else
            if((status == 'Out of office' && ABP.NQT_Availability_Status__c == 'Un Available') || (status == 'Un Available' && ABP.NQT_Availability_Status__c == 'Out of office')){
                requiredCheck = TRUE;
                ABP.NQT_Availability_Status__c.addError('Please change the status');
                }
        if(requiredCheck == TRUE)
            return;
        
        
      //************************************************************************************************************  
        String logedProfile = [SELECT Name FROM Profile WHERE Id =: logedUser.ProfileId LIMIT 1].Name;
        if(logedProfile.contains('Field Engineer') || logedUser.FE__c == TRUE)
            FE = TRUE;
        if(logedProfile.contains('System Engineer') || logedUser.SE__c == TRUE){
            system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
            if(logedProfile.contains('MSC'))
                SEMSC = TRUE;
            else
                SE = TRUE;
            }
        if(logedUser.SEMSC__c == TRUE)
            SEMSC = TRUE;
        if(logedProfile.contains('Account Manager'))
            AM = TRUE;
        if(logedProfile.contains('Program Manager') || logedUser.PM__c == TRUE)
            PM = TRUE;
        system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%SEMSC:'+SEMSC+':%%%%%%%%%%SE:'+SE+'%%%%%%%%%%'+logedUser.SE__c);     
      //************************************************************************************************************
        bpProfile = [SELECT Name FROM Profile WHERE Id =: bpUser.ProfileId LIMIT 1].Name;
        if((bpProfile.contains('Field Engineer') || bpUser.FE__c == TRUE) && FE == TRUE)
            userCheck = FALSE;
        /*if((bpProfile.contains('System Engineer') || bpUser.SE__c == TRUE))
            if((bpProfile.contains('MSC') || bpUser.SEMSC__c == TRUE) && SEMSC == TRUE)
                userCheck = FALSE;
            else
                if(SE == TRUE)
                    userCheck = FALSE;*/
        if(((bpProfile.contains('System Engineer') && !bpProfile.contains('MSC')) || bpUser.SE__c == TRUE) && SE == TRUE)
            userCheck = FALSE;
        if(((bpProfile.contains('System Engineer') && bpProfile.contains('MSC')) || bpUser.SEMSC__c == TRUE) && SEMSC == TRUE)
            userCheck = FALSE;
        if(bpProfile.contains('Account Manager') && AM == TRUE)
            userCheck = FALSE;
        if((bpProfile.contains('Program Manager') || bpUser.PM__c == TRUE) && PM == TRUE)
            userCheck = FALSE;
      //************************************************************************************************************ 
        if(logedProfile.contains('Account Manager') && !bpProfile.contains('Account Manager'))
            userCheck = TRUE;
        if(logedProfile.contains('Program Manager') && !bpProfile.contains('Program Manager'))
            if(!bpProfile.contains('Account Manager'))
                userCheck = TRUE;
                
        if(userCheck == TRUE){
            ABP.NQT_Backup_Person__c.addError('Selected User doesn\'t have sufficient priviledge');
            return;
        }
        
        
        status = ABP.NQT_Availability_Status__c;
        if(ABP.id != NULL)
            update ABP;
        else
            insert ABP;
        Edit = TRUE;
        Save = FALSE;
        Cancel= FALSE;
        
        }
        
    public void editRes(){
        Edit = FALSE;
        Save = TRUE;
        Cancel= TRUE;
        
        } 
    
    static testMethod void testAssignBackupPerson(){
        AssignBackupPerson abp = new AssignBackupPerson();
        
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        NQT_Assign_Backup_Person__c ab = new NQT_Assign_Backup_Person__c();
        ab.NQT_Backup_Person__c = DummyUser.id;
        ab.NQT_Availability_Status__c = 'Out of office';
        ab.NQT_From__c = date.today();
        ab.NQT_To__c = date.today();
        insert ab;
        
        abp.ABP = ab;//[SELECT NQT_Backup_Person__c, NQT_Backup_Person__r.Name, NQT_Availability_Status__c, NQT_From__c, NQT_To__c FROM NQT_Assign_Backup_Person__c WHERE NQT_Backup_Person__c != NULL LIMIT 1];}catch(exception e){} 
        abp.status = 'Available';
        abp.userCheck = FALSE;
        abp.saveRes();
        abp.userCheck = TRUE;
        abp = new AssignBackupPerson();
        abp.saveRes();
        abp = new AssignBackupPerson();
        abp.ABP = ab;//[SELECT NQT_Backup_Person__c, NQT_Backup_Person__r.Name, NQT_Availability_Status__c, NQT_From__c, NQT_To__c FROM NQT_Assign_Backup_Person__c WHERE NQT_Backup_Person__c != NULL LIMIT 1];}catch(exception e){}
        abp.ABP.NQT_From__c = NULL; 
        abp.ABP.NQT_To__c = NULL;
        abp.status = 'Available';
        abp.bpprofile = 'Account Manager';
        abp.saveRes();
        abp.editRes();
        abp.Cancel1();
    
    }       
}