public class MCARSupplierSearchController{

    public String mcarstatus { get; set; }
    
    public String mcaropendays { get; set; }

    public MCARSupplierSearchController() {

    }

    
    public String mcarnumber {get; set;}
    public List<MCAR__c> mcarList;


    
    public void on_query()
    {
       
        getquery();     
    }

    public List<MCAR__c> getQuery()
    {
      
       User loggedinUser = [select id from user where id =:UserInfo.getUserId()];
      
       System.debug('-----------loggedinUser -------------'+loggedinUser );
       
        Profile extsupp = [SELECT Id FROM Profile WHERE Name='Nokia MCAR External Supplier'];
       //Profile extsupp = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        system.debug('extsupid' + extsupp.Id);  
        system.debug('profid' + UserInfo.getProfileId()); 
        
        if(UserInfo.getProfileId() == extsupp.Id)
        {
            MCAR_Manufacturer_Contact__c con = [select id,MCAR_User__c,Manufacturer_Name__c  from MCAR_Manufacturer_Contact__c where MCAR_User__c =: loggedinUser.id  limit 1];     
            
            System.debug('------------CON-------------------'+con);  
            System.debug('------------CON.Manufacturer-------------------'+con.Manufacturer_Name__c); 
            
            mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_Index_NSN_Code__c,MCAR_Manufacturer__c from MCAR__c where MCAR_Manufacturer__c =: con.Manufacturer_Name__c and MCAR_Status__c =: mcarstatus]; 
                                      
//mcarList = [select id, MCAR_Mfg_Part_Number__c, name,MCAR_Failure_Type__c,MCAR_Index_NSN_Code__c,  MCAR_Facility__r.name,MCAR_Part_Description__c, MCAR_NSN_Code__c ,MCAR_Manufacturer__c from MCAR__c where name like : '%'+ mcarnumber  +'%' and MCAR_Status__c =: mcarstatus LIMIT 1]; 
system.debug('sss'+mcarList.size());
if(mcarList.size()>0)
system.debug('--------------MCAR Manufaturer------------'+mcarList[0].MCAR_Manufacturer__c);
system.debug('sss'+mcarlist);


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