/*Purpose: Controller for display Welcome Message at home page and Fetch the In-progress Projects associated with Logged in user in any manner
Author: Haripriya/Manish
Date of Creation: 13-May-2016 */

public with sharing class loggedInUser {
    public String userFirstname{get;set;} // userFirstname is used to store the first name of the logged in user
    public String userLastname{get;set;}//userLastname is used to store the last name of the logged in user
    public String userEmail{get;set;}//userEmail is used to store the emailId of the logged in user
    public String userId{get;set;}// userId is used to store the logged in user id(15 char)
    public List<QIPP_Contacts__c> contacts{get;set;}//contacts is used to store the contact details of the logged in user
    public String contactId{get;set;}//contactId is used to store the contact Id (15 char) of the logged in user
    //public String createdDateFormat{get;set;}
    //public List<string> createdDate{get;set;}
    public string profilename {get;set;}//profilename is used to store the current login user profile
    public string rolename {get;set;}//rolename is used to store the current login user role
        
    public loggedInUser() {
        userFirstname = Userinfo.getFirstName();
        userLastname = Userinfo.getLastName();
        userEmail = Userinfo.getUserEmail();
        userId = userinfo.getuserId();
        contacts = [select id from QIPP_Contacts__c where User_License__c =: UserInfo.getUserId()  and Email__c =: UserInfo.getUserEmail()];
        if(contacts.size()>0){
            contactId = contacts[0].id;
        }
         profile profilena =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
         profilename = profilena.Name;
         if(UserInfo.getUserRoleId()!= null){
         userrole rolenames = [SELECT Id, Name FROM userrole WHERE Id=:UserInfo.getUserRoleId() LIMIT 1];
         rolename = rolenames.Name;
             system.debug('rolename****'+rolename);
         }
    }
    
     public List<QIPP_Project__c> projectList {
        get {
            //system.debug('rolename****'+rolename);
            if ((projectList == null) && (contactId != null)) {
                if (rolename=='QIPP Project Lead'){
                projectList = [SELECT Name,Project_Type__c,Project_Lead__c,Project_Lead__r.Name,Project_Name_Succinct__c,Portfolio_Name__c,Portfolio_Name__r.Name,Project_Number__c, LastModifiedDate, Project_State__c,Project_Owner__c,Project_Created_Date__c,Belt_Candidate_Mentor__c,Belt_Project_Champion__c,Business_Unit_Master_Black_Belt__c,Belt_Project_Sponsor__c,Finance_Approver__c,Belt_Assigned__c,Project_Member1__c,Total_Planned_Financial_Benefits_k__c, Total_Planned_Operational_Benefits_k__c,Total_Project_Validation_Amount__c,Total_Benefit_Planned_Amount__c FROM QIPP_Project__c where (Belt_Project_Champion__c =:contactId OR Business_Unit_Master_Black_Belt__c =: contactId or Belt_Project_Sponsor__c =: contactId or Finance_Approver__c =: contactId or Belt_Assigned__c =:contactId or Belt_Candidate_Mentor__c =: contactId or Project_Member1__c =:contactId or Project_Lead__c =: contactId)  order by LastModifiedDate desc];
                system.debug('projectListinIf'+projectList);
                system.debug('RoleIf'+UserInfo.getUserRoleId());
                }
                else{
                date d = system.today().addDays(-30);    
                projectList = [SELECT Name,Project_Type__c,Project_Lead__c,Project_Lead__r.Name,Project_Name_Succinct__c,Portfolio_Name__c,Portfolio_Name__r.Name,Project_Number__c, LastModifiedDate, Project_State__c,Project_Owner__c,Project_Created_Date__c,Belt_Candidate_Mentor__c,Belt_Project_Champion__c,Business_Unit_Master_Black_Belt__c,Belt_Project_Sponsor__c,Finance_Approver__c,Belt_Assigned__c,Project_Member1__c,Total_Planned_Financial_Benefits_k__c, Total_Planned_Operational_Benefits_k__c,Total_Project_Validation_Amount__c,Total_Benefit_Planned_Amount__c FROM QIPP_Project__c where (Belt_Project_Champion__c =:contactId OR Business_Unit_Master_Black_Belt__c =: contactId or Belt_Project_Sponsor__c =: contactId or Finance_Approver__c =: contactId or Belt_Assigned__c =:contactId or Belt_Candidate_Mentor__c =: contactId or Project_Member1__c =:contactId or Project_Lead__c =: contactId) and (Project_State__c = 'In Progress') and LastModifiedDate >:d order by LastModifiedDate desc];
               system.debug('projectListinelse'+projectList);
                system.debug('Roleelse'+UserInfo.getUserRoleId());
                }
            }    
                return projectList;
         }
        set;
        }
}