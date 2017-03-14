/**
 * @author : Vivek Singh
 * @description: This class is used to share manufacturer Records with users
 *               from Manufacturer contacts. As per MCAR Dema: DEM0008730
 * @Date: 06 June 2015
 * @Last Modified by:
 * @Last Modified Date:
 */
public class MCAR_ManufacturerSharing {
    private map<ID,set<ID>> manufacturerIdWithMCARExtUsersIDMap = new map<ID,Set<ID>>();
    private map<ID,set<ID>> manufacturerIdWithManuShareUsersIDMap = new map<ID,Set<ID>>();
    private map<String,list<MCAR_Manufacturer__Share>> ManifacturerShareMap = new map<String,list<MCAR_Manufacturer__Share>>();
    public void shareManufacturerWithUserFromManufacturerContact(list<MCAR_Manufacturer_Contact__c> manufacturerContacts){
        set<ID> manufacturerIDSet = new set<ID>();
        for(MCAR_Manufacturer_Contact__c manufactContact : manufacturerContacts){
            if(manufactContact.Manufacturer_Name__c != null) manufacturerIDSet.add(manufactContact.Manufacturer_Name__c);
        }
        if(manufacturerIDSet == null || manufacturerIDSet.isEmpty()) return;
        list<MCAR_Manufacturer__c> manufacturerList = [select ID,(select ID, MCAR_User__c 
                                                                  from Manufacturer_Contacts__r)
                                                      from MCAR_Manufacturer__c where ID IN : manufacturerIDSet];
        for(MCAR_Manufacturer__c manufact : manufacturerList){
            for(MCAR_Manufacturer_Contact__c manufactContact : manufact.Manufacturer_Contacts__r){
                if(manufactContact.MCAR_User__c != null){
                    if(manufacturerIdWithMCARExtUsersIDMap.containsKey(manufact.ID)){
                        manufacturerIdWithMCARExtUsersIDMap.get(manufact.ID).add(manufactContact.MCAR_User__c);
                    }else{
                        manufacturerIdWithMCARExtUsersIDMap.put(manufact.ID, new set<ID>{manufactContact.MCAR_User__c});
                    }
                }
            }
        }
        
        List<MCAR_Manufacturer__Share> manufactureShareList = [select ID,ParentId,UserorGroupId
                                                                from MCAR_Manufacturer__Share 
                                                                where ParentID IN : manufacturerIDSet AND RowCause =: 'Supplier__c'];
        String uniqueKey = '';
        for(MCAR_Manufacturer__Share manufactShare : manufactureShareList){
            if(manufacturerIdWithManuShareUsersIDMap.containsKey(manufactShare.ParentId)){
                manufacturerIdWithManuShareUsersIDMap.get(manufactShare.ParentId).add(manufactShare.UserorGroupId);
            }else{
                manufacturerIdWithManuShareUsersIDMap.put(manufactShare.ParentId,new set<ID>{manufactShare.UserorGroupId});
            }
            uniqueKey = manufactShare.ParentId + '-' + manufactShare.UserorGroupId;
            if(ManifacturerShareMap.containsKey(uniqueKey)){
                ManifacturerShareMap.get(uniqueKey).add(manufactShare);
            }else{
                ManifacturerShareMap.put(uniqueKey, new list<MCAR_Manufacturer__Share>{manufactShare});
            }
        }
        List<MCAR_Manufacturer__Share> manufactShareToInsert = new List<MCAR_Manufacturer__Share>();
        for(MCAR_Manufacturer_Contact__c manufactContact : manufacturerContacts){
            if(manufactContact.Manufacturer_Name__c != null && manufactContact.MCAR_User__c != null){
                if(!manufacturerIdWithManuShareUsersIDMap.containsKey(manufactContact.Manufacturer_Name__c) || !manufacturerIdWithManuShareUsersIDMap.get(manufactContact.Manufacturer_Name__c).contains(manufactContact.MCAR_User__c)){
                    MCAR_Manufacturer__Share manuShare = new MCAR_Manufacturer__Share();
                    manuShare.ParentId = manufactContact.Manufacturer_Name__c;
                    manuShare.UserOrGroupId = manufactContact.MCAR_User__c;
                    manuShare.AccessLevel = 'Edit';
                    manuShare.RowCause = Schema.MCAR_Manufacturer__Share.RowCause.Supplier__c;
                    manufactShareToInsert.add(manuShare);
                    if(manufacturerIdWithManuShareUsersIDMap.containsKey(manufactContact.Manufacturer_Name__c)){
                        manufacturerIdWithManuShareUsersIDMap.get(manufactContact.Manufacturer_Name__c).add(manufactContact.MCAR_User__c);
                    }else{
                        manufacturerIdWithManuShareUsersIDMap.put(manufactContact.Manufacturer_Name__c,new set<ID>{manufactContact.MCAR_User__c});
                    }
                }
            } 
        }
        
        list<Database.SaveResult> sr = Database.insert(manufactShareToInsert,false);
        List<MCAR_Manufacturer__Share> manufactShareToDelete = new List<MCAR_Manufacturer__Share>();
        String uniqueKeyTodelete = '';
        for(ID manufactID : manufacturerIdWithManuShareUsersIDMap.keySet()){
            for(ID userIDFromShared : manufacturerIdWithManuShareUsersIDMap.get(manufactID)){
                uniqueKeyTodelete = manufactID + '-' + userIDFromShared;
                if(!manufacturerIdWithMCARExtUsersIDMap.containsKey(manufactID) || !manufacturerIdWithMCARExtUsersIDMap.get(manufactID).contains(userIDFromShared)){
                    manufactShareToDelete.addALL(ManifacturerShareMap.get(uniqueKeyTodelete));
                }
            }
        }
        Database.DeleteResult[] delRes = Database.delete(manufactShareToDelete,false);
    }
}