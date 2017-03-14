trigger QIRSApexSharing on QIRS__c (after insert, after update) {
       Group g = [SELECT Id FROM group WHERE name = 'QIRS Admin Group'];    
  if(trigger.isInsert) {
        // Create a new list of sharing objects for QIRS 
    
        List<QIRS__Share> QIRSShrs  = new List<QIRS__Share>();

        
         
    
        QIRS__Share CaseOwnShr;
        QIRS__Share MastAppr;
        
        for(QIRS__c QIRS : trigger.new){
            // Instantiate the sharing objects 
    
            CaseOwnShr = new QIRS__Share();
            
            // Set the ID of record being shared 
    
            CaseOwnShr.ParentId = QIRS.Id;
            
            
            // Set the ID of user or group being granted access 
            // Set the access level 
            // Set the Apex sharing reason 
            // Add objects to list for insert 
            if(QIRS.Process_Owner1__c != null){
                    CaseOwnShr.UserOrGroupId = QIRS.Process_Owner1__c;
                    CaseOwnShr.AccessLevel = 'edit';
                    CaseOwnShr.RowCause = Schema.QIRS__Share.RowCause.CaseOwner__c;
                    QIRSShrs.add(CaseOwnShr);
                    }
            
            List<Id> MastApprIds = new List<Id>();
            MastApprIds.add(QIRS.Master_Approver1__c);
            MastApprIds.add(QIRS.Master_Approver2__c);
            MastApprIds.add(QIRS.Master_Approver3__c);
            MastApprIds.add(QIRS.Master_Approver4__c);
            MastApprIds.add(QIRS.Master_Approver5__c);
            MastApprIds.add(QIRS.Master_Approver6__c);
            MastApprIds.add(QIRS.Master_Approver7__c);
            MastApprIds.add(QIRS.Master_Approver8__c);
            MastApprIds.add(QIRS.Master_Approver9__c);
            MastApprIds.add(QIRS.Master_Approver10__c);
            MastApprIds.add(g.Id);
            List<Id> DistMastApprIds = new List<Id>();
            Boolean RepeatedId;
            
            for(integer i = 0; i < MastApprIds.size(); i++){
                RepeatedId = FALSE;
                for(integer j = 0; j < DistMastApprIds.size(); j++)
                    if(DistMastApprIds[j] == MastApprIds[i])
                        RepeatedId = TRUE;
                if(RepeatedId == False)
                    DistMastApprIds.add(MastApprIds[i]);
                }
                
            integer i = 0;
            for(Id MasterAppr : DistMastApprIds)
                if(MasterAppr != null){
                    MastAppr = new QIRS__Share();
                    MastAppr.ParentId = QIRS.Id;
                    MastAppr.UserOrGroupId = MasterAppr;
                    MastAppr.AccessLevel = 'edit';
                    MastAppr.RowCause = Schema.QIRS__Share.RowCause.Master_Approver__c;
                    QIRSShrs.add(MastAppr);
                    }

 
        }
        Database.SaveResult[] lsr = Database.insert(QIRSShrs,false);
        
        
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
    
trigger.newMap.get(QIRSShrs[i].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                }
            }
            i++;
        }   
    }
    


if(trigger.isUpdate) {
        // Create a new list of sharing objects for QIRS 
    
        List<QIRS__Share> QIRSShrs  = new List<QIRS__Share>();
        
         
    
        QIRS__Share CaseOwnShr;
        QIRS__Share MastAppr;
        
        for(QIRS__c QIRS : trigger.new){
            // Instantiate the sharing objects 
    
            CaseOwnShr = new QIRS__Share();
            
            // Set the ID of record being shared 
    
            CaseOwnShr.ParentId = QIRS.Id;
            
            
            // Set the ID of user or group being granted access 
            // Set the access level 
            // Set the Apex sharing reason 
            // Add objects to list for insert 
            if(QIRS.Process_Owner1__c != null){
                    CaseOwnShr.UserOrGroupId = QIRS.Process_Owner1__c;
                    CaseOwnShr.AccessLevel = 'edit';
                    CaseOwnShr.RowCause = Schema.QIRS__Share.RowCause.CaseOwner__c;
                    QIRSShrs.add(CaseOwnShr);
                    }
            
            List<Id> MastApprIds = new List<Id>();
            MastApprIds.add(QIRS.Master_Approver1__c);
            MastApprIds.add(QIRS.Master_Approver2__c);
            MastApprIds.add(QIRS.Master_Approver3__c);
            MastApprIds.add(QIRS.Master_Approver4__c);
            MastApprIds.add(QIRS.Master_Approver5__c);
            MastApprIds.add(QIRS.Master_Approver6__c);
            MastApprIds.add(QIRS.Master_Approver7__c);
            MastApprIds.add(QIRS.Master_Approver8__c);
            MastApprIds.add(QIRS.Master_Approver9__c);
            MastApprIds.add(QIRS.Master_Approver10__c);
            MastApprIds.add(g.Id);
            List<Id> DistMastApprIds = new List<Id>();
            Boolean RepeatedId;
            
            for(integer i = 0; i < MastApprIds.size(); i++){
                RepeatedId = FALSE;
                for(integer j = 0; j < DistMastApprIds.size(); j++)
                    if(DistMastApprIds[j] == MastApprIds[i])
                        RepeatedId = TRUE;
                if(RepeatedId == False)
                    DistMastApprIds.add(MastApprIds[i]);
                }
                
            integer i = 0;
            for(Id MasterAppr : DistMastApprIds)
                if(MasterAppr != null){
                    MastAppr = new QIRS__Share();
                    MastAppr.ParentId = QIRS.Id;
                    MastAppr.UserOrGroupId = MasterAppr;
                    MastAppr.AccessLevel = 'edit';
                    MastAppr.RowCause = Schema.QIRS__Share.RowCause.Master_Approver__c;
                    QIRSShrs.add(MastAppr);
                    }
    
    }
            
        // Insert sharing records and capture save result  
    
        // The false parameter allows for partial processing if multiple records are passed  
    
        // into the operation  
    
        Database.SaveResult[] lsr = Database.insert(QIRSShrs,false);
        
        
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
    
trigger.newMap.get(QIRSShrs[i].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                }
            }
            i++;
        }   
    }
    
}