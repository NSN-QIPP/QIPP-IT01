/**
 * @author : Vivek Singh
 * @description: This class is used to share manufacturer Records with users
 *               from Manufacturer contacts. As per MCAR Dema: DEM0008730
 * @Date: 06 June 2015
 * @Last Modified by:
 * @Last Modified Date:
 */
public class MCAR_MCARsSharing {
    private map<ID,set<ID>> macarsIdWithMCARExtUsersIDMap = new map<ID,Set<ID>>();
    private map<ID,set<ID>> macarsIdWithMCARsShareUsersIDMap = new map<ID,Set<ID>>();
    private map<String,list<MCAR__Share>> MCARsShareMap = new map<String,list<MCAR__Share>>();
    
    public void shareMACRsWithUserFromManufacturerContact(list<MCAR_Manufacturer_Contact__c> manufacturerContacts){
        set<ID> manufacturerIDSet = new set<ID>();
        set<ID> mcarsIDSet = new set<ID>();
        for(MCAR_Manufacturer_Contact__c manufactContact : manufacturerContacts){
            if(manufactContact.Manufacturer_Name__c != null) manufacturerIDSet.add(manufactContact.Manufacturer_Name__c);
        }
        if(manufacturerIDSet == null || manufacturerIDSet.isEmpty()) return;
        list<MCAR_Manufacturer__c> manufacturerList = [select ID,(select ID, MCAR_User__c 
                                                                  from Manufacturer_Contacts__r),
                                                                (select ID from MCARs__r)
                                                      from MCAR_Manufacturer__c where ID IN : manufacturerIDSet];
        for(MCAR_Manufacturer__c manufact : manufacturerList){
            if(manufact.MCARs__r == null) continue;
            Set<ID> manufactContactIDSet = new Set<ID>();
            manufactContactIDSet = fetchManufacturerContacts(manufact.Manufacturer_Contacts__r);
            for(MCAR__c mcarRec : manufact.MCARs__r){
                mcarsIDSet.add(mcarRec.ID);
                if(manufactContactIDSet == null || manufactContactIDSet.isEmpty()) continue;
                macarsIdWithMCARExtUsersIDMap.put(mcarRec.ID, manufactContactIDSet);
            }
        }
        List<MCAR__Share> mcarsShareList = [select ID,ParentId,UserorGroupId
                                            from MCAR__Share 
                                            where ParentID IN : mcarsIDSet AND RowCause =: 'Supplier__c'];
        String uniqueKey = '';
        for(MCAR__Share macrShare : mcarsShareList){
            if(macarsIdWithMCARsShareUsersIDMap.containsKey(macrShare.ParentId)){
                macarsIdWithMCARsShareUsersIDMap.get(macrShare.ParentId).add(macrShare.UserorGroupId);
            }else{
                macarsIdWithMCARsShareUsersIDMap.put(macrShare.ParentId,new set<ID>{macrShare.UserorGroupId});
            }
            uniqueKey = macrShare.ParentId + '-' + macrShare.UserorGroupId;
            if(MCARsShareMap.containsKey(uniqueKey)){
                MCARsShareMap.get(uniqueKey).add(macrShare);
            }else{
                MCARsShareMap.put(uniqueKey, new list<MCAR__Share>{macrShare});
            }
        }
        List<MCAR__Share> mcarsShareToInsert = new List<MCAR__Share>();
        for(ID mcarIDForConUsr : macarsIdWithMCARExtUsersIDMap.keySet()){
            for(ID contactUsrID : macarsIdWithMCARExtUsersIDMap.get(mcarIDForConUsr)){
                if(!macarsIdWithMCARsShareUsersIDMap.containsKey(mcarIDForConUsr) || !macarsIdWithMCARsShareUsersIDMap.get(mcarIDForConUsr).contains(contactUsrID)){
                    MCAR__Share mcarShare = new MCAR__Share();
                    mcarShare.ParentId = mcarIDForConUsr;
                    mcarShare.UserorGroupId = contactUsrID;
                    mcarShare.AccessLevel = 'Edit';
                    mcarShare.RowCause = Schema.MCAR__Share.RowCause.Supplier__c;
                    mcarsShareToInsert.add(mcarShare);
                    if(macarsIdWithMCARsShareUsersIDMap.containsKey(mcarIDForConUsr)){
                        macarsIdWithMCARsShareUsersIDMap.get(mcarIDForConUsr).add(contactUsrID);
                    }else{
                        macarsIdWithMCARsShareUsersIDMap.put(mcarIDForConUsr,new set<ID>{contactUsrID});
                    }
                }
            }
        }
        list<Database.SaveResult> sr = Database.insert(mcarsShareToInsert,false);
        List<MCAR__Share> mcarShareToDelete = new List<MCAR__Share>();
        String uniqueKeyTodelete = '';
        for(ID mcarIDForShrUser : macarsIdWithMCARsShareUsersIDMap.keySet()){
            for(ID userIDFromShared : macarsIdWithMCARsShareUsersIDMap.get(mcarIDForShrUser)){
                uniqueKeyTodelete = mcarIDForShrUser + '-' + userIDFromShared;
                if(!macarsIdWithMCARExtUsersIDMap.containsKey(mcarIDForShrUser) || !macarsIdWithMCARExtUsersIDMap.get(mcarIDForShrUser).contains(userIDFromShared)){
                    mcarShareToDelete.addALL(MCARsShareMap.get(uniqueKeyTodelete));
                }
            }
        }
        Database.DeleteResult[] delRes = Database.delete(mcarShareToDelete,false);
    }
    
    @TestVisible set<ID> fetchManufacturerContacts(list<MCAR_Manufacturer_Contact__c> manufactContactList){
        Set<ID> manufactContactIDSet = new Set<ID>();
        for(MCAR_Manufacturer_Contact__c manufactContact : manufactContactList){
            if(manufactContact.MCAR_User__c != null) manufactContactIDSet.add(manufactContact.MCAR_User__c);
        }
        return manufactContactIDSet;
    }
}