public class MCAREMSSearchController{

    public String mcarstatus { get; set; }
    
    public String mcaropendays { get; set; }

    public MCAREMSSearchController() {

    }

    
    public String mcarnumber {get; set;}
    public List<MCAR__c> mcarList;


    
    public void on_query(){
        getquery();     
    }

    public List<MCAR__c> getQuery()
    {
        User loggedinUser = [select id from user where id =:UserInfo.getUserId()];
       
        UserRole eMSFlextronics = [SELECT Id FROM UserRole WHERE Name='MCAR EMS Flextronics'];
        UserRole eMSFoxconn = [SELECT Id FROM UserRole WHERE Name='MCAR EMS Foxconn'];
        UserRole eMSJabilCircuit  = [SELECT Id FROM UserRole WHERE Name='MCAR EMS Jabil Circuit'];
        UserRole eMSMLSManufacturing = [SELECT Id FROM UserRole WHERE Name='MCAR EMS ML&S Manufacturing'];
        UserRole eMSSanminaSCI  = [SELECT Id FROM UserRole WHERE Name='MCAR EMS Sanmina-SCI'];
        UserRole eMSSRIRadioSystems = [SELECT Id FROM UserRole WHERE Name='MCAR EMS SRI Radio Systems'];

        
        if(UserInfo.getUserRoleId() == eMSFlextronics.Id)
        {
            //MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];       
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Facility__r.MCAR_Facility_Company__c ='Flextronics' and MCAR_Facility__r.MCAR_Facility_Type__c='EMS' and MCAR_Status__c =: mcarstatus ]; 
        }    
        else if(UserInfo.getUserRoleId() == eMSFoxconn.Id)
        {
            //MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];       
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Facility__r.MCAR_Facility_Company__c ='Foxconn' and MCAR_Facility__r.MCAR_Facility_Type__c='EMS' and MCAR_Status__c =: mcarstatus ]; 
        }    
        else if(UserInfo.getUserRoleId() == eMSJabilCircuit.Id)
        {
            //MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];       
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Facility__r.MCAR_Facility_Company__c ='Jabil Circuit' and MCAR_Facility__r.MCAR_Facility_Type__c='EMS' and MCAR_Status__c =: mcarstatus ]; 
        }    
        else if(UserInfo.getUserRoleId() == eMSMLSManufacturing.Id)
        {
            //MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];       
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Facility__r.MCAR_Facility_Company__c ='ML&S Manufacturing' and MCAR_Facility__r.MCAR_Facility_Type__c='EMS' and MCAR_Status__c =: mcarstatus ]; 
        }    
        else if(UserInfo.getUserRoleId() == eMSSanminaSCI.Id)
        {
            //MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];       
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Facility__r.MCAR_Facility_Company__c ='Sanmina-SCI' and MCAR_Facility__r.MCAR_Facility_Type__c='EMS' and MCAR_Status__c =: mcarstatus ]; 
        }    
        if(UserInfo.getUserRoleId() == eMSSRIRadioSystems.Id)
        {
            //MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];       
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Facility__r.MCAR_Facility_Company__c ='SRI Radio Systems' and MCAR_Facility__r.MCAR_Facility_Type__c='EMS' and MCAR_Status__c =: mcarstatus ]; 
        }    

        return mcarList; 
    }
    public pagereference clear(){

        PageReference pageRef = new PageReference('/apex/MCARSupplierSearch');
        pageRef.setredirect(true);
        return pageRef;
       
    }  
    
     public List<SelectOption> getItems1() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Open','Open'));
            options.add(new SelectOption('Closed','Closed'));
            return options;
        }
}