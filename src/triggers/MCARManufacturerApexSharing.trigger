/*
    Trigger to grant Supplier Access to various profiles
    Supplier Admin will have Edit Access for that Supplier
*/
trigger MCARManufacturerApexSharing on MCAR_Manufacturer__c (after insert,after update, before update) {

    // Get the Super User group
    Group NSNSupUser=[SELECT Id from group where name=:'MCAR_NSN_SuperUser'];

    if(trigger.isInsert){
    
    List<MCAR_Manufacturer__Share> mcarSupplierShares = new List<MCAR_Manufacturer__Share>();
    MCAR_Manufacturer__Share supplierAdminShare = new MCAR_Manufacturer__Share();
    MCAR_Manufacturer__Share MCARNSNSUserShr = new MCAR_Manufacturer__Share();

    
        for(MCAR_Manufacturer__c currentSupplier : trigger.new){
        if(currentSupplier.MCAR_Supplier_Admin__c != null)          
        {  
                    supplierAdminShare= new MCAR_Manufacturer__Share();                    
                    supplierAdminShare.ParentId = currentSupplier.Id;
                    supplierAdminShare.UserorGroupId = currentSupplier.MCAR_Supplier_Admin__c;
                    supplierAdminShare.AccessLevel = 'Edit';
                    supplierAdminShare.RowCause = Schema.MCAR_Manufacturer__Share.RowCause.Manufacturer_Admin__c;
                    mcarSupplierShares.add(supplierAdminShare);}
        }

        Database.SaveResult[] lsr = Database.insert(mcarSupplierShares,false);
        
        //Create  Counter
        
        Integer i=0;
        
        //Process the Save Result
        
        for(Database.SaveResult sr : lsr){
        
            if(!sr.isSuccess()){
                // Get the first Save result error
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level 
    
                // Access levels equal or more permissive than the object's default  
    
                // access level are not allowed.  
    
                // These sharing records are not required and thus an insert exception is  
    
                // acceptable.  
                
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION
                                                && err.getMessage().contains('AccessLevel'))){
                        // Throw an error when the error is not related to trivial access level.
                trigger.newMap.get(mcarSupplierShares[i].id).addError('Unable to grant sharing access due to following exception :' + err.getMessage());
            }
        }
          i++;
    
    }
    }
    if(trigger.isUpdate){
    
    List<MCAR_Manufacturer__Share> mcarSupplierShares = new List<MCAR_Manufacturer__Share>();
    MCAR_Manufacturer__Share supplierAdminShare = new MCAR_Manufacturer__Share();
    MCAR_Manufacturer__Share MCARNSNSUserShr = new MCAR_Manufacturer__Share();
    
            for(MCAR_Manufacturer__c currentSupplier : trigger.new){
            if(currentSupplier.MCAR_Supplier_Admin__c != null)          
            {        
                    supplierAdminShare= new MCAR_Manufacturer__Share();                    
                    supplierAdminShare.ParentId = currentSupplier.Id;
                    supplierAdminShare.UserorGroupId = currentSupplier.MCAR_Supplier_Admin__c;
                    supplierAdminShare.AccessLevel = 'Edit';
                    supplierAdminShare.RowCause = Schema.MCAR_Manufacturer__Share.RowCause.Manufacturer_Admin__c;
                    mcarSupplierShares.add(supplierAdminShare);}

            }
            
       

            Database.SaveResult[] lsr = Database.insert(mcarSupplierShares,false);
        
        //Create  Counter
        
        Integer i=0;
        
        //Process the Save Result
        
        for(Database.SaveResult sr : lsr){
        
            if(!sr.isSuccess()){
                // Get the first Save result error
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level 
    
                // Access levels equal or more permissive than the object's default  
    
                // access level are not allowed.  
    
                // These sharing records are not required and thus an insert exception is  
    
                // acceptable.  
                
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION
                                                && err.getMessage().contains('AccessLevel'))){
                        // Throw an error when the error is not related to trivial access level.
                        //The below line added by kishore on 25th-Sep-2012
                           if(trigger.newMap.get(mcarSupplierShares[i].id)!=null){
                    trigger.newMap.get(mcarSupplierShares[i].id).addError('Unable to grant sharing access due to following exception :' + err.getMessage());
            }
        }
        }
          i++;
    
    }
   } 
}