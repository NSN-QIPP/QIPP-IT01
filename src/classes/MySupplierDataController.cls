public class MySupplierDataController {
    
    public List<selectOption> classList { set; get; }
    public List<selectOption> roleList { set; get; }
    public List<selectOption> CAlist { set;  get; }
    public List<selectOption> groupList { set; get; } // rm lt
        
    public string selectedGroup { set; get; }
    public string selectedRole { set; get; }
    public string selectclass { set; get; }
    public string selectCA { set; get; }
    
    private set<string> groupset { set; get; }  
    private set<string> roleset { set; get; }
    private set<string> classset { set; get; }  
    private set<string> CAset { set; get; }
    
    Public List<Account> mySuppliers {set;get;}
    public static String id;
    public ID supplierID{get;set;}
    public Account supplier{get;set;}
    public Set<String> businessGroups {get; set;}
    Public List<StakeHolder_Matrix_Supplier_contacts__c> supplierContactsList {set;get;}
            
    Public List<string> leftselected{get;set;}
    Public List<string> rightselected{get;set;}
    Set<string> leftvalues = new Set<string>();
    Set<string> rightvalues = new Set<string>();
    
    Public MySupplierDataController()
    {
        leftselected = new List<String>();
        rightselected = new List<String>();                               
        
        classList = new list<selectOption>();
        CAlist = new list<selectOption>();
        
        roleList = new list<selectOption>();
        roleList.add(new selectoption('All','All')); 
        roleList.add(new selectoption('LSM__c','Lead Supplier Manager'));  
        roleList.add(new selectoption('Supplier_Governance_Manager__c','Supplier Governance Manager'));          
        roleList.add(new selectoption('Business_Owner__c','Business Owner')); 
        roleList.add(new selectoption('SAM_Innovation_Manager__c','Supplier Innovation Account Manager')); 
        roleList.add(new selectoption('Sponsor__c','Executive Sponsor')); 
        
        selectedRole = 'All';
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accSchema = schemaMap.get('Account');
        Map<String, Schema.SObjectField> fieldMap = accSchema.getDescribe().fields.getMap();
        
        groupList = new list<selectOption>();
        groupList.add(new selectoption('All','All'));
                   
        groupset = new set<string>();
        
        classset = new set<string>();
        CAset = new set<string>();
                     
        selectedGroup = 'All';
        
        classList.add(new selectOption('All','All'));
        selectclass = 'All';
        
        CAlist.add(new selectOption('All','All'));
        selectCA = 'All';
        
        id=userinfo.getuserId();
        mySuppliers = new List<Account>();
        businessGroups = new Set<String>();
        mySuppliers = [Select id,Name,Classification__c,Total_Score__c,Total_SPE_score__c,Business_Groups__c,CategoryAreaSIM__c,LSM__c,Supplier_Governance_Manager__c,Business_Owner__c,SAM_Innovation_Manager__c,Sponsor__c From Account where (LSM__c=:id OR SAM_Innovation_Manager__c=:id OR Supplier_Governance_Manager__c=:id OR Sponsor__c=:id) AND Unique_Id__c != NULL];        		
                    
        
        supplierID = apexpages.currentpage().getparameters().get('id');
        if(supplierID != null){
            getContactDetails(supplierID);
        }
        for(Account mySupplier : mySuppliers )
        {
            if(mySupplier.Business_Groups__c<>null)
            {
                businessGroups.add(mySupplier.Business_Groups__c); // contains distict businessGroups                 
                
                //if(groupset.add(mySupplier.Business_Groups__c))
                	//grouplist.add(new selectOption(mySupplier.Business_Groups__c,mySupplier.Business_Groups__c));
                
                string businessGrouptemp = mySupplier.Business_Groups__c;
                string[] str = businessGrouptemp.split(',');
                for(string strtemp : str)
                {                               
                    strtemp = strtemp.trim();
                    
                        if(groupset.add(strtemp))                                           
                    		groupList.add(new selectOption(strtemp,strtemp));
                }                
                
                if(classset.add(mySupplier.Classification__c))
                	classList.add(new selectOption(mySupplier.Classification__c ,mySupplier.Classification__c));
                
                if(mySupplier.CategoryAreaSIM__c!=null)
                if(caset.add(mySupplier.CategoryAreaSIM__c))
                    CAlist.add(new selectOption(mySupplier.CategoryAreaSIM__c,mySupplier.CategoryAreaSIM__c));                                
            }
            
        }       	
    }
    
    
//------------------------------------------------------------------------------------------
/*
        public PageReference selectclick(){
        rightselected.clear();
        for(String s : leftselected){
            leftvalues.remove(s);
            rightvalues.add(s);
        }
                        
        return null;
    }
    
    public PageReference unselectclick(){
        leftselected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftvalues.add(s);
        }
        return null;
    }

    public List<SelectOption> getunSelectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }

    public List<SelectOption> getSelectedValues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }
    */
//------------------------------------------------------------------------------------------   
    Public void getContactDetails(Id supplierID){
        supplier = new Account();
        supplier = [Select Id,Name from Account where id =:supplierID];
        supplierContactsList = new List<StakeHolder_Matrix_Supplier_contacts__c>();
        supplierContactsList = [Select Id,Name,Full_Name__c,email__c,Business_Group__c,phone__c,Mobile__c  from StakeHolder_Matrix_Supplier_contacts__c where SupplierName__c =:supplierID];
    }
    
    
}