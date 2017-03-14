/**
    Controller for MCARs Pending Action Page
*/

public class MCARPendingMyApprovalsController{

    public String mcarstatus { get; set; }
    
    public String mcaropendays { get; set; }

    public MCARPendingMyApprovalsController() {
    }

    
    public String mcarnumber {get; set;}
    public List<MCAR__c> mcarList;
    public List<MCAR__c> mcarList4d;
    public List<MCAR__c> mcarList5d;
    public List<MCAR__c> mcarList6d;
    public List<MCAR__c> mcarList7d;
    public List<MCAR__c> mcarListopen;            

    User loggedinUser = [select id from user where id =:UserInfo.getUserId()];
    
    public List<MCAR__c> getQuery()
    {
        mcarList = [select id, MCAR_3D_Due_Date__c, Ownerid, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__r.Name, MCAR_Containment_Action__c from MCAR__c where MCAR_3D_Due_Date__c >= TODAY and MCAR_3D_Due_Date__c<= NEXT_N_DAYS:5 and MCAR_3D_Approval__c = false and MCAR_Status__c =: 'Open' and Ownerid=:loggedinUser.id ]; 
        return mcarList; 
    }
    
    public List<MCAR__c> getQuery4d()
    {
        mcarList4d = [select id, MCAR_4D_Due_Date__c, Ownerid, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__r.Name, MCAR_4D_Root_Cause__c from MCAR__c where MCAR_4D_Due_Date__c >= TODAY and MCAR_4D_Due_Date__c<= NEXT_N_DAYS:5 and MCAR_4D_Approval__c = false and MCAR_Status__c =: 'Open' and Ownerid=:loggedinUser.id ]; 
        return mcarList4d; 
    }

    public List<MCAR__c> getQuery5d()
    {
        mcarList5d = [select id, MCAR_5D_Due_Date__c, Ownerid, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__r.Name, MCAR_5D_Permanent_Corrective_Action__c from MCAR__c where MCAR_5D_Due_Date__c >= TODAY and MCAR_5D_Due_Date__c<= NEXT_N_DAYS:5 and MCAR_5D_Approval__c = false and MCAR_Status__c =: 'Open' and Ownerid=:loggedinUser.id ]; 
        return mcarList5d; 
    }

    public List<MCAR__c> getQuery6d()
    {
        mcarList6d = [select id, MCAR_6D_Due_Date__c, Ownerid, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__r.Name, MCAR_6D_Ver_Corr_Action_Eff__c from MCAR__c where MCAR_6D_Due_Date__c >= TODAY and MCAR_6D_Due_Date__c<= NEXT_N_DAYS:5 and MCAR_6D_Approval__c = false and MCAR_Status__c =: 'Open' and Ownerid=:loggedinUser.id ]; 
        return mcarList6d; 
    }

    public List<MCAR__c> getQuery7d()
    {
        mcarList7d = [select id, MCAR_7D_Due_Date__c, Ownerid, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__r.Name, MCAR_7D_Preventive_Actions__c from MCAR__c where MCAR_7D_Due_Date__c >= TODAY and MCAR_7D_Due_Date__c<= NEXT_N_DAYS:5 and MCAR_7D_Approval__c = false and MCAR_Status__c =: 'Open' and Ownerid=:loggedinUser.id ]; 
        return mcarList7d; 
    }
    
    public List<MCAR__c> getMcarListopen()
    {
        mcarListopen= [select id, MCAR_Creation_Date_Status_Open__c, MCAR_Days_MCAR_Open__c, Ownerid, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__r.Name from MCAR__c where MCAR_7D_Approval__c = true and MCAR_Status__c =: 'Open' and Ownerid=:loggedinUser.id ]; 
        return mcarListopen; 
    }

}