public class ExecutiveSupplierDataController {
Public List<Account> mySuppliers {set;get;}
    public static String id;
    public ID supplierID{get;set;}
    public Account supplier{get;set;}
    public Set<String> businessGroups {get; set;}
    Public List<StakeHolder_Matrix_Supplier_contacts__c> supplierContactsList {set;get;}
    Public ExecutiveSupplierDataController(){
        id=userinfo.getuserId();
        mySuppliers = new List<Account>();
        businessGroups = new Set<String>();
        mySuppliers = [Select id,Name,Classification__c,Business_Groups__c,LSM__c,Supplier_Governance_Manager__c,Business_Owner__c,SAM_Innovation_Manager__c,Sponsor__c From Account where (LSM__c=:id OR SAM_Innovation_Manager__c=:id OR Supplier_Governance_Manager__c=:id OR Sponsor__c=:id or Lead_Category_Manager1__c=:id) and Unique_Id__c != NULL];
        supplierID = apexpages.currentpage().getparameters().get('id');
        if(supplierID != null){
            getContactDetails(supplierID);
        }
        for(Account mySupplier : mySuppliers )
        {
            if(mySupplier.Business_Groups__c<>null)
            {
                businessGroups.add(mySupplier.Business_Groups__c); // contains distict businessGroups
            }
            
        }
    }
     
    Public void getContactDetails(Id supplierID){
        supplier = new Account();
        supplier = [Select Id,Name from Account where id =:supplierID];
        supplierContactsList = new List<StakeHolder_Matrix_Supplier_contacts__c>();
        supplierContactsList = [Select Id,Name,Full_Name__c,email__c,Business_Group__c,phone__c  from StakeHolder_Matrix_Supplier_contacts__c where SupplierName__c =:supplierID];
    }
    
}