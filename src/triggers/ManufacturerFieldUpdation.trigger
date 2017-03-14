trigger ManufacturerFieldUpdation on MCAR_Manufacturer__c (before update)  {

    if(Trigger.isBefore && Trigger.isUpdate){
        
        map<ID,MCAR_Manufacturer__c> mcarManufactWithSupplierContact = new map<Id,MCAR_Manufacturer__c>([select ID,(select Supplier_Manager__c,Email__c, MCAR_User_Status__c, SupplierManagerTitle__c,MCAR_User_Account__r.Name
                                                                                                                        from SupplierContacts__r order by LastModifiedDate desc)
                                                                                                            from MCAR_Manufacturer__c
                                                                                                            where ID IN: trigger.new]);
        list<MCAR_Manufacturer__c> mcarManufactListForSupplierData = new list<MCAR_Manufacturer__c>();
        set<String> supplierEmailSet = new set<String>();
                                                                                                                        
        for(MCAR_Manufacturer__c mfr: trigger.new){
            if(mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r == null || (mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r).isEmpty()){
            	mfr.Supplier_Manager__c         = null;
	            mfr.Email__c                    = null;         
	            mfr.MCAR_User_Account__c        = null; 
	            mfr.MCAR_User_Status__c         = false;
	            mfr.SupplierManagerTitle__c     = null;
	            mfr.Supplier_Manager_City__c	= null;
                mfr.Supplier_Manager_Country__c = null;
                mfr.SupplierManagerTitle__c     = null;
                mfr.SupplierManagerPhone__c     = null;
            }else{
	            mfr.Supplier_Manager__c         = mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r[0].Supplier_Manager__c;
	            mfr.Email__c                    = mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r[0].Email__c;         
	            mfr.MCAR_User_Account__c        = mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r[0].MCAR_User_Account__r.Name; 
	            mfr.MCAR_User_Status__c         = mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r[0].MCAR_User_Status__c;
	            mfr.SupplierManagerTitle__c     = mcarManufactWithSupplierContact.get(mfr.ID).SupplierContacts__r[0].SupplierManagerTitle__c;         
	            
	            if(mfr.Email__c != null){
	                mcarManufactListForSupplierData.add(mfr);
	                supplierEmailSet.add(mfr.Email__c);
	            }   
            }
        }
        
        if(!supplierEmailSet.isEmpty()){
            list<QIPP_Contacts__c> qippContactList = new list<QIPP_Contacts__c>();
            qippContactList = [SELECT ID,Contact_Country__c,Contact_City__c,Title__c,Phone__c,Email__c
                                FROM QIPP_Contacts__c 
                                WHERE Email__c IN: supplierEmailSet];
            map<String,QIPP_Contacts__c> qippContactEmailWithContactDataMap = new map<String,QIPP_Contacts__c>();                       
            if(qippContactList != null && !qippContactList.isEmpty()){
                for(QIPP_Contacts__c qippCon : qippContactList){
                    qippContactEmailWithContactDataMap.put(qippCon.Email__c,qippCon);
                }
            }
            QIPP_Contacts__c tempQippContact = new QIPP_Contacts__c();
            for(MCAR_Manufacturer__c mcarManufact : mcarManufactListForSupplierData){
                tempQippContact = qippContactEmailWithContactDataMap.get(mcarManufact.Email__c);
                system.debug(System.LoggingLevel.INFO,'*****tempQippContact****' + tempQippContact);
                if(tempQippContact == null) continue;
                mcarManufact.Supplier_Manager_City__c       = tempQippContact.Contact_City__c;
                mcarManufact.Supplier_Manager_Country__c    = tempQippContact.Contact_Country__c;
                mcarManufact.SupplierManagerTitle__c        = tempQippContact.Title__c;
                mcarManufact.SupplierManagerPhone__c        = tempQippContact.Phone__c;
            } 
        }
    }
}