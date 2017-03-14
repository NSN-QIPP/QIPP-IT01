public class SupplierTagCon {
        public SupplierTagCon(ApexPages.StandardController controller) {
    }

    public id id1 = userinfo.getuserid();
    public id profileId = userinfo.getProfileId();
    public profile p = [select name,id from profile where id =:profileId limit 1];
    public string userName = userinfo.getname();
    public string msg {get;set;}
        
    Public pagereference checkUser(){
        id id2 = apexpages.currentpage().getparameters().get('id');
        Account accInfo = new Account();
        accInfo= [select LSM__c from Account where ID =:id2 limit 1];
        if(accInfo.LSM__c!=id1 && p.Name !='Key Users' )
             {
                msg='You are not LSM for this Supplier so you cannot edit this record.';
             }
             else
             {                
                 msg=' ';
             } 
        return null;
    }


}