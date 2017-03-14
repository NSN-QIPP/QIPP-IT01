trigger CPRApexSharing on CPR__c (after insert, after update) {
    
  if(trigger.isInsert) {
        // Create a new list of sharing objects for CPR 
    
        List<CPR__Share> cprShrs  = new List<CPR__Share>();
        
        // Declare variables for SE, MSC, FE and Project Manager sharing 
    
        CPR__Share SEShr;
        CPR__Share MSCShr;
        CPR__Share FEShr;
        CPR__Share PROJMGRShr;
       
        
        for(CPR__c cpr : trigger.new){
            // Instantiate the sharing objects 
    
            SEShr = new CPR__Share();
            MSCShr = new CPR__Share();
            FEShr = new CPR__Share();
            PROJMGRShr = new CPR__Share();
            
            // Set the ID of record being shared 
    
            SEShr.ParentId = cpr.Id;
            MSCShr.ParentId = cpr.Id;
            FEShr.ParentId = cpr.Id;
            PROJMGRShr.ParentId = cpr.Id;
            
            // Set the ID of user or group being granted access 
            // Set the access level 
            // Set the Apex sharing reason 
            // Add objects to list for insert 
    if(cpr.NQT_SE__c != null){
            SEShr.UserOrGroupId = cpr.NQT_SE__c;
            SEShr.AccessLevel = 'edit';
            SEShr.RowCause = Schema.CPR__Share.RowCause.SE__c;
            cprShrs.add(SEShr);
            }
    if(cpr.NQT_SE_MSC__c != null){
            MSCShr.UserOrGroupId = cpr.NQT_SE_MSC__c;
            MSCShr.AccessLevel = 'edit';
            MSCShr.RowCause = Schema.CPR__Share.RowCause.MSC__c;
            cprShrs.add(MSCShr);
            }
    if(cpr.NQT_FE__c != null){
            FEShr.UserOrGroupId = cpr.NQT_FE__c;
            FEShr.AccessLevel = 'edit';
            FEShr.RowCause = Schema.CPR__Share.RowCause.FE__c;
            cprShrs.add(FEShr);
            }
    if(cpr.NQT_Project_Manager__c != null){
            PROJMGRShr.UserOrGroupId = cpr.NQT_Project_Manager__c;
            PROJMGRShr.AccessLevel = 'edit';
            PROJMGRShr.RowCause = Schema.CPR__Share.RowCause.PROJMGR__c;
            cprShrs.add(PROJMGRShr);
            }
 
        }
        Database.SaveResult[] lsr = Database.insert(cprShrs,false);
        
        
        // Create counter 
    
        Integer i=0;
        
        // Process the save results 
    
        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){
                // Get the first save result error 
    
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level 
    
                // Access levels equal or more permissive than the object's default  
    
                // access level are not allowed.  
    
                // These sharing records are not required and thus an insert exception is  
    
                // acceptable.  
    
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    // Throw an error when the error is not related to trivial access level. 
    
trigger.newMap.get(cprShrs[i].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                }
            }
            i++;
        }   
    }
    


if(trigger.isUpdate) {
        // Create a new list of sharing objects for CPR 
    
        List<CPR__Share> UcprShrs  = new List<CPR__Share>();
        
        // Declare variables for SE, MSC, FE and Project Manager sharing 
    
        CPR__Share USEShr;
        CPR__Share UMSCShr;
        CPR__Share UFEShr;
        CPR__Share UPROJMGRShr;
        
        for(CPR__c cpr : trigger.new){
            // Instantiate the sharing objects 
    
            USEShr = new CPR__Share();
            UMSCShr = new CPR__Share();
            UFEShr = new CPR__Share();
            UPROJMGRShr = new CPR__Share();
            
            // Set the ID of record being shared 
    
            USEShr.ParentId = cpr.Id;
            UMSCShr.ParentId = cpr.Id;
            UFEShr.ParentId = cpr.Id;
            UPROJMGRShr.ParentId = cpr.Id;
            
            // Set the ID of user or group being granted access 
            // Set the access level 
            // Set the Apex sharing reason 
            // Add objects to list for insert 
    if(cpr.NQT_SE__c != null){
            USEShr.UserOrGroupId = cpr.NQT_SE__c;
            USEShr.AccessLevel = 'edit';
            USEShr.RowCause = Schema.CPR__Share.RowCause.SE__c;
            UcprShrs.add(USEShr);
            }
    if(cpr.NQT_SE_MSC__c != null){
            UMSCShr.UserOrGroupId = cpr.NQT_SE_MSC__c;
            UMSCShr.AccessLevel = 'edit';
            UMSCShr.RowCause = Schema.CPR__Share.RowCause.MSC__c;
            UcprShrs.add(UMSCShr);
            }
    if(cpr.NQT_FE__c != null){
            UFEShr.UserOrGroupId = cpr.NQT_FE__c;
            UFEShr.AccessLevel = 'edit';
            UFEShr.RowCause = Schema.CPR__Share.RowCause.FE__c;
            UcprShrs.add(UFEShr);
            }
    if(cpr.NQT_Project_Manager__c != null){
            UPROJMGRShr.UserOrGroupId = cpr.NQT_Project_Manager__c;
            UPROJMGRShr.AccessLevel = 'edit';
            UPROJMGRShr.RowCause = Schema.CPR__Share.RowCause.PROJMGR__c;
            UcprShrs.add(UPROJMGRShr);
            }
            }
            
        // Insert sharing records and capture save result  
    
        // The false parameter allows for partial processing if multiple records are passed  
    
        // into the operation  
    
        Database.SaveResult[] lsr = Database.insert(UcprShrs,false);
        
        
        // Create counter 
    
        Integer i=0;
        
        // Process the save results 
    
        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){
                // Get the first save result error 
    
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level 
    
                // Access levels equal or more permissive than the object's default  
    
                // access level are not allowed.  
    
                // These sharing records are not required and thus an insert exception is  
    
                // acceptable.  
    
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    // Throw an error when the error is not related to trivial access level. 
    
trigger.newMap.get(UcprShrs[i].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                }
            }
            i++;
        }   
    }
    
}