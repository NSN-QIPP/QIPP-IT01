public class MySupplierActionsComponentController {
    Public List<Id> supplierIds;
    Public List<Action__c> actionList {set;get;}
    public MySupplierActionsComponentController(){
        supplierIds = new List<Id>();
        actionList= new List<Action__c>();
        String id = userinfo.getuserId();
        for(Account acc :[Select Id from Account where LSM__c=:id OR SAM_Innovation_Manager__c=:id OR Supplier_Governance_Manager__c=:id OR Sponsor__c=:id]){
            supplierIds.add(acc.id);
        }
        actionList = [Select id,Supplier_Name__c,Supplier_Name__r.Name ,Supplier_Responsible__r.Full_Name__c,Action__c,Area__c,Nokia_User__c,Nokia_User__r.name,Supplier_Responsible__c,Due_Date__c,Status__c from Action__c 
                      WHERE Supplier_Name__c IN :supplierIds  AND Status__c ='Open' 
                      ORDER BY Due_Date__c];
    } 

}