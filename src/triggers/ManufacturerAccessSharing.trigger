trigger ManufacturerAccessSharing on MCAR_Manufacturer_Contact__c (before insert, after update, before delete,after insert,after delete) 
{

/*List<MCAR_Manufacturer__c>mname=[SELECT Id,Name from MCAR_Manufacturer__c];
List<MCAR_Manufacturer_Contact__c> mconnanme=[SELECT Id,Name,Manufacturer_Name__c from MCAR_Manufacturer_Contact__c];
*/

/*
 * Commenated By: Vivek Singh
 * Reason: As per changes to Manufacturer tab Issue related to Wrong sharing with users.Changes Related To  DEM0012507
 * 
list<MCAR_Manufacturer__Share> delMCARShares = new list<MCAR_Manufacturer__Share>();
if(trigger.isDelete)
{
for(MCAR_Manufacturer_Contact__c con : Trigger.old)
{
List<MCAR_Manufacturer__c> mcar =[SELECT Name,Id from MCAR_Manufacturer__c WHERE Id=:con.Manufacturer_Name__c];
//List<Mcar__c> mcar =[SELECT Id from Mcar__c WHERE MCAR_Manufacturer__c=:con.Manufacturer_Name__c];
    MCAR_Manufacturer__Share newUserShr;
    List<MCAR_Manufacturer__Share> allUserShare = new List<MCAR_Manufacturer__Share>();
    if(con.MCAR_User__c != null)
    {
    for(MCAR_Manufacturer__c mcar1 : mcar){
         if(trigger.isDelete){

        delMCARShares.addAll([SELECT Id FROM MCAR_Manufacturer__Share WHERE ParentId =: mcar1.id AND RowCause =: 'Supplier__c' and UserorGroupId=:con.MCAR_User__c]);

    }
    }

    }
}
//if(trigger.isDelete){
        //Database.DeleteResult[] dlsr = Database.Delete(delMCARShares,false); }
}
else 
{

for(MCAR_Manufacturer_Contact__c con : Trigger.new)
{
    List<MCAR_Manufacturer__c> mcar =[SELECT Id,Name from MCAR_Manufacturer__c WHERE Id=:con.Manufacturer_Name__c];
    List<MCAR_Manufacturer__Share> allUserShare = new List<MCAR_Manufacturer__Share>();

    //List<Mcar__c> mcar =[SELECT Id from Mcar__c WHERE MCAR_Manufacturer__c=:con.Manufacturer_Name__c];
    MCAR_Manufacturer__Share newUserShr1;
        if(con.MCAR_User__c != null)
    {
    for(MCAR_Manufacturer__c mcar1 : mcar){

    newUserShr1 = new MCAR_Manufacturer__Share();
    newUserShr1.ParentId = mcar1.id;
    newUserShr1.UserorGroupId = con.MCAR_User__c;
    newUserShr1.AccessLevel = 'Edit';
    newUserShr1.RowCause = Schema.MCAR_Manufacturer__Share.RowCause.Supplier__c;
    if(con.MCAR_User__c != NULL)
        allUserShare.add(newUserShr1);
    }
    insert allUserShare;
    }
     Database.SaveResult[] jobShareInsertResult = Database.insert(allUserShare,false);
}

}
*/

/*
 * @author : Vivek Singh
 * @description : Above comented code was not working fine.
 *                Below class is written to correct the functionality.
 *                As per MCAR Deema:  DEM0012507
 */
if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || trigger.isdelete)){
    MCAR_ManufacturerSharing manuShareObj = new MCAR_ManufacturerSharing();
    if(trigger.isdelete){
        manuShareObj.shareManufacturerWithUserFromManufacturerContact(trigger.old);
    }else{
        manuShareObj.shareManufacturerWithUserFromManufacturerContact(trigger.new);
    }
}

}