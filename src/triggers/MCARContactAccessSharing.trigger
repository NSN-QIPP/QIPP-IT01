trigger MCARContactAccessSharing on MCAR_Manufacturer_Contact__c (before insert, after update, before delete,after insert,after delete) 
{
/*
 * Commented By: Vivek Singh
 * Reason: As per changes to Manufacturer tab Issue related to Wrong sharing with users.
 *         As per Deema No:  DEM0012507
 
list<MCAR__Share> delMCARShares = new list<MCAR__Share>();
if(trigger.isDelete)
{
for(MCAR_Manufacturer_Contact__c con : Trigger.old)
{
List<Mcar__c> mcar =[SELECT Id from Mcar__c WHERE MCAR_Manufacturer__c=:con.Manufacturer_Name__c];
    MCAR__Share newUserShr;
    List<MCAR__Share> allUserShare = new List<MCAR__Share>();
    if(con.MCAR_User__c != null)
    {
    for(Mcar__c mcar1 : mcar){
         if(trigger.isDelete){

        delMCARShares.addAll([SELECT Id FROM MCAR__Share WHERE ParentId =: mcar1.id AND RowCause =: 'Supplier__c' and UserorGroupId=:con.MCAR_User__c]);

    }
    }

    }
}
if(trigger.isDelete){
        Database.DeleteResult[] dlsr = Database.Delete(delMCARShares,false); }
}
else 
{
for(MCAR_Manufacturer_Contact__c con : Trigger.new)
{
    
    List<Mcar__c> mcar =[SELECT Id from Mcar__c WHERE MCAR_Manufacturer__c=:con.Manufacturer_Name__c];
    MCAR__Share newUserShr;
    List<MCAR__Share> allUserShare = new List<MCAR__Share>();
    if(con.MCAR_User__c != null)
    {
    for(Mcar__c mcar1 : mcar){

    newUserShr = new MCAR__Share();
    newUserShr.ParentId = mcar1.id;
    newUserShr.UserorGroupId = con.MCAR_User__c;
    newUserShr.AccessLevel = 'edit';
    newUserShr.RowCause = Schema.MCAR__Share.RowCause.Supplier__c;
    if(con.MCAR_User__c != NULL)
        allUserShare.add(newUserShr);
    }
    insert allUserShare;
    }
}

}*/
/*
 * @author : Vivek Singh
 * @description : Above comented code was not working fine.
 *                Below class is written to correct the functionality.
 *                As per Deema No:  DEM0012507
 */
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isDelete)){
        MCAR_MCARsSharing mcarshareObj = new MCAR_MCARsSharing();
        if(trigger.isDelete){
            mcarshareObj.shareMACRsWithUserFromManufacturerContact(trigger.old);
        }else{
            mcarshareObj.shareMACRsWithUserFromManufacturerContact(trigger.new);
        }
    }
}