/*
    Author - Sunanda Budati
    Developed on - 05/07/2015
    Updated on   - 04/09/2015
*/
public class MCARSupplierDataTriggerUtils {

    // Method to updates the "Supplier_ID__c" and "Supplier_Name__c" on "MCAR_MEPS__c" object.    
    public static void updateMEPSData(list<MCAR_Supplier_Data_Cross_Reference__c> MCARSupplierDataList) {        
        
        // keyed with "Manufacturer_Name__c" from "MCAR_Supplier_Data_Cross_Reference__c".
        map<string,MCAR_Supplier_Data_Cross_Reference__c> MCARSupplierDataMap 
            = new map<string,MCAR_Supplier_Data_Cross_Reference__c>(); 
        list<MCAR_MEPS__c> MEPSUpdateList = new list<MCAR_MEPS__c>();
        
        system.debug(MCARSupplierDataList);
        for(MCAR_Supplier_Data_Cross_Reference__c msd : MCARSupplierDataList) {
            if(msd.Manufacturer_Name__c != null || string.isNotBlank(msd.Manufacturer_Name__c)){
                MCARSupplierDataMap.put(msd.Manufacturer_Name__c,msd);  
                system.debug(MCARSupplierDataMap.keySet());         
            }
        }
        
        system.debug('DEBUG: MCARSupplierDataMap: '+ MCARSupplierDataMap.size());
        
        //veera modifyde
        list<MCAR_MEPS__c> mep = [select id, Supplier_ID__c, Supplier_Name__c,Manufacturer_Name__r.Name from MCAR_MEPS__c
                                    where Manufacturer_Name__r.Name =: MCARSupplierDataMap.keySet()];
                                     system.debug(mep);
        if(!MCARSupplierDataMap.keySet().isEmpty()){
            /* Querying all the MCAR_MEPS__c records with the map keyset
            for(MCAR_MEPS__c meps : [select id, Supplier_ID__c, Supplier_Name__c,Manufacturer_Name__r.Name from MCAR_MEPS__c
                                    //where Manufacturer_Name__r.Name =: MCARSupplierDataMap.keySet()]) { 
                                    
                mep.Supplier_ID__c = MCARSupplierDataMap.get(mep.Manufacturer_Name__r.Name).Name;          
                mep.Supplier_Name__c = MCARSupplierDataMap.get(mep.Manufacturer_Name__r.Name).Supplier_Name__c;  
                MEPSUpdateList.add(mep);*/ 
                
             for(MCAR_MEPS__c meps : mep) {  
                  meps.Supplier_ID__c = MCARSupplierDataMap.get(meps.Manufacturer_Name__r.Name).Name;          
                  meps.Supplier_Name__c = MCARSupplierDataMap.get(meps.Manufacturer_Name__r.Name).Supplier_Name__c;  
                  system.debug(meps.Supplier_ID__c);
                  MEPSUpdateList.add(meps);
             system.debug(MEPSUpdateList);
            }
            
            system.debug('DEBUG: MEPSUpdateList: ' + MEPSUpdateList.size());
            // updating MEPSUpdateList.  
            if( ! MEPSUpdateList.isEmpty() ) {
                update MEPSUpdateList;
                  system.debug(MEPSUpdateList);
            }
        }   
    } // End of updateMEPSData()
    
    @future
    public static void updateNSNParts(set<String> McarCatEsnNameSet) {        
        
        map<String,MCAR_Category_Cross_Reference__c> MCARCatCrossRefMap = new map<String,MCAR_Category_Cross_Reference__c>(); 
        list<NSN_Part__c> NSNPartsUpdateList = new list<NSN_Part__c>();
        list<MCAR_Category_Cross_Reference__c> MACRcategoryRecord = [select ID,Name,Category_Area__c,Category_Group__c,ESN__c
                                                                        from MCAR_Category_Cross_Reference__c 
                                                                        where ESN__c IN: McarCatEsnNameSet];
            system.debug('========MACRcategoryRecord======='+MACRcategoryRecord);
        
        for(MCAR_Category_Cross_Reference__c mccr : MACRcategoryRecord) {
            if(mccr.ESN__c != null || String.isNotBlank(mccr.ESN__c)){
                MCARCatCrossRefMap.put(mccr.ESN__c,mccr);
            }
        }
           system.debug('========MCARCatCrossRefMap======='+MCARCatCrossRefMap);  
           system.debug('========MCARCatCrossRefMap.keySet()======='+MCARCatCrossRefMap.keySet());     
        if(!MCARCatCrossRefMap.keySet().isEmpty()){
            list<NSN_Part__c> NSNPartRecords = [select ID, Category__c, Category_Area__c, Category_Group__c, COM__c, Sub_Category_ID_ESN__c from NSN_Part__c
                                                    where COM__c != null AND COM__c IN : MCARCatCrossRefMap.keySet()];
             system.debug('========NSNPartRecords======='+NSNPartRecords);
            for(NSN_Part__c NSNPart : NSNPartRecords) { 
                NSNPart.Category__c = MCARCatCrossRefMap.get(NSNPart.COM__c).Name;    
                NSNPart.Category_Area__c = MCARCatCrossRefMap.get(NSNPart.COM__c).Category_Area__c; 
                NSNPart.Category_Group__c = MCARCatCrossRefMap.get(NSNPart.COM__c).Category_Group__c;
                NSNPart.Sub_Category_ID_ESN__c = MCARCatCrossRefMap.get(NSNPart.COM__c).ESN__c;               
                NSNPartsUpdateList.add(NSNPart);  
            }
            
            // updating NSNPartsUpdateList.  
            if(!NSNPartsUpdateList.isEmpty()) {
                update NSNPartsUpdateList;
                system.debug('========Updated Successfully=======');
            }
        }
    } // End of updateNSNParts()
}