/*  
* File Name     : checkForSystemAdminOrOwner 
* Description   : 
*
* @author       : 
*
* Modification Log
* =============================================================================
*   Ver     Date         Author          Modification
*------------------------------------------------------------------------------
*   1.0                                   Initial Creation
*   2.0     10-Feb-15    Srikanth_V       Changes made to restrict COPQ Role : Only "QIPP Portfolio Manager" Role User can change CoPQ_Role value as 'Business Unit Master Black Belt'.
*/
trigger checkForSystemAdminOrOwner on QIPP_Contacts__c (before insert , before update,after update){

Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
if(s.Run_Triggers__c){  //To control trigger at the time of dataloader updates
    String uRoleName;
    String usrProfileName;
    //String usrProfileName = [select u.Profile.Name from User u where u.id = :Userinfo.getUserId()].Profile.Name; 
    User cUser = [Select UserRole.Name,Profile.Name From User Where id = : Userinfo.getUserId()];

    if(cUSER != null){
        uRoleName = cUSER.UserRole.Name;
        usrProfileName = cUSER.Profile.Name;
    }
    System.Debug('uRoleName 1****' + cUSER); 
    System.Debug('uRoleName 2****' + uRoleName); 
    if(trigger.isbefore){
        Boolean  checkAuthentication = false;
        Boolean  pfmanager;
        List<QIPP_Contacts__c> oldContact = Trigger.Old;
        List<QIPP_Contacts__c> newContact = Trigger.New;
        System.Debug('$$$$$ oldContact $$$$$$$$' + oldContact ); 
        System.Debug('$$$$$ newContact $$$$$$$$' + newContact ); 
        for(QIPP_Contacts__c contact : newContact){
            System.Debug('$$$$$ inside for loop $$$$$$$$'); 

            if(contact.OwnerId == Userinfo.getUserId() || usrProfileName == 'System Administrator'){
                checkAuthentication = true;
            }
            System.Debug('$$$$$ checkAuthentication $$$$$$$$' + checkAuthentication ); 
            if(checkAuthentication == true){
                System.Debug('$$$$$ inside if $$$$$$$$'); 
                // Can change Belt certification value ....
            }
            else if(oldContact[0].Belt_Certification__c == newContact[0].Belt_Certification__c){
                System.Debug('$$$$$ inside else if $$$$$$$$'); 
                // can not change or keep same as it is ...
            }
            else{
                 System.Debug('$$$$$ inside else $$$$$$$$'); 
                // Throw an error ...
                 newContact[0].Belt_Certification__c.addError(' Only System Administrator or Contact Name can change Belt Certification value');    
            }
            // Added by Srikanth_V to restrict COPQ Role value(Business Unit Master Black Belt).
            if(uRoleName == 'QIPP Portfolio Manager' || uRoleName == 'QIPP Admin' || usrProfileName == 'System Administrator'){
                pfmanager = true;
            }
            else {
                pfmanager = false;
            }
            if(pfmanager == false){
                if(oldContact[0].CoPQ_Role_1__c != newContact[0].CoPQ_Role_1__c & contact.CoPQ_Role_1__c == 'Business Unit Master Black Belt' ){
                    newContact[0].CoPQ_Role_1__c.addError('User with "Portfolio Manager" rights can assign Role_1 value to "Business Unit Master Black Belt". '); 
                }
                else if(oldContact[0].CoPQ_Role_2__c != newContact[0].CoPQ_Role_2__c & contact.CoPQ_Role_2__c == 'Business Unit Master Black Belt'){
                        newContact[0].CoPQ_Role_2__c.addError('User with "Portfolio Manager" rights can assign Role_2 value to "Business Unit Master Black Belt". '); 
                }
                else if(oldContact[0].CoPQ_Role_3__c != newContact[0].CoPQ_Role_3__c & contact.CoPQ_Role_3__c == 'Business Unit Master Black Belt'){
                        newContact[0].CoPQ_Role_3__c.addError('User with "Portfolio Manager" rights can assign Role_3 value to "Business Unit Master Black Belt". '); 
                }
                else if(oldContact[0].CoPQ_Role_4__c != newContact[0].CoPQ_Role_4__c & contact.CoPQ_Role_4__c == 'Business Unit Master Black Belt'){
                        newContact[0].CoPQ_Role_4__c.addError('User with "Portfolio Manager" rights can assign Role_4 value to "Business Unit Master Black Belt". '); 
                }
            }
        } 
    }
    if(trigger.isafter && trigger.isupdate){    
        list<QIPP_Project__c> projects = [SELECT id,RecordType.Name,Project_State__c,Project_Type__c  ,Project_Lead__c,Project_Lead_Business_Grp__c,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c FROM QIPP_Project__c WHERE Project_Lead__c IN :trigger.newMap.keyset()];
        system.debug('projects '+projects);
        system.debug('Contact keyset'+trigger.newMap.keyset());
        if(projects.size()>0){
            list<QIPP_Project__c> updateprojects = new list<QIPP_Project__c>();
            for(QIPP_Project__c prj :projects ){
                //After Complete freeze the project lead information fields
                //Except DMAIC projects whitch are not complete status
                if(!(prj.Project_Type__c.contains('DMAIC') || prj.Project_Type__c.contains('DMADV'))){
                    if((prj.Project_Lead__c != null && prj.Project_State__c != 'Complete' && prj.Project_State__c != 'Closed')){ 
                        QIPP_Contacts__c cnt = Trigger.newMap.get(prj.Project_Lead__c);
                        system.debug('Contact match'+cnt);
                        system.debug('project type '+prj.Project_Type__c + '****Non-DMAIC - Recordtype name'+prj.RecordType.Name);
                        prj.Project_Lead_Business_Grp__c = cnt.Contact_BU__c;
                        prj.Project_Lead_Business_Unit__c = cnt.Contact_BL__c;
                        prj.Project_Lead_Business_Line__c = cnt.Contact_L4_Org__c;
                        updateprojects.add(prj);
                    }
                } //Only for DMAIC projects after improve phase complete
                else if(prj.Project_Lead__c != null && !(prj.RecordType.Name.contains('Methodology: After DMAIC Improve') || prj.RecordType.Name.contains('Methodology: After QIPP DMAIC Control / Verify')) && (prj.Project_Type__c.contains('DMAIC') || prj.Project_Type__c.contains('DMADV')) ){
                        QIPP_Contacts__c cnt = Trigger.newMap.get(prj.Project_Lead__c);
                        system.debug('Contact match'+cnt);
                        system.debug('DMAIC - Recordtype name'+prj.RecordType.Name);
                        prj.Project_Lead_Business_Grp__c = cnt.Contact_BU__c;
                        prj.Project_Lead_Business_Unit__c = cnt.Contact_BL__c;
                        prj.Project_Lead_Business_Line__c = cnt.Contact_L4_Org__c;
                        updateprojects.add(prj);
                }
            }           
            if(updateprojects.size()>0){
               //Note: projects will not update if Any project throughs validation errors, filter criteria does't match etc...
               Database.update(updateprojects,false);
                //update updateprojects;
                //a16R0000000uLsd
            }
        }
        
        //--E036-Start--//
        Set<String> conIdSet = new Set<String>();
        for(QIPP_Contacts__c con : Trigger.new){
            boolean toAdd = true;
            if((con.CoPQ_Role_1__c != null && con.CoPQ_Role_1__c != '' && con.CoPQ_Role_1__c == 'Business Unit Master Black Belt') ||
                (con.CoPQ_Role_2__c != null && con.CoPQ_Role_2__c != '' && con.CoPQ_Role_2__c == 'Business Unit Master Black Belt') ||
                (con.CoPQ_Role_3__c != null && con.CoPQ_Role_3__c != '' && con.CoPQ_Role_3__c == 'Business Unit Master Black Belt') ||
                (con.CoPQ_Role_4__c != null && con.CoPQ_Role_4__c != '' && con.CoPQ_Role_4__c == 'Business Unit Master Black Belt')){
                toAdd = false;
            }
            if(toAdd){
                conIdSet.add(con.Id);
            }
        }
        if(conIdSet != null && conIdSet.size() > 0){
            List<QIPP_BG_BU_BL_Contact_Mapping__c> bumbbList = [select id from QIPP_BG_BU_BL_Contact_Mapping__c where Business_Group_Master_Black_Belt__c in: conIdSet];
            if(bumbbList != null && bumbbList.size() > 0){
                Database.delete(bumbbList,false);
            }
        }
        //--E036-End--//        
    }
}   
}