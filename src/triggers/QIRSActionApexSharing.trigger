trigger QIRSActionApexSharing on QIRS_Action_Plan__c (after insert, after update) 
{  /*
   List<QIRS__Share> QIRSAPShrs  = new List<QIRS__Share>();
   QIRS__Share ChampShr;
    for(QIRS_Action_Plan__c QIRSAP : trigger.new)
    {
            // Instantiate the sharing objects 
    
            ChampShr = new QIRS__Share();

            // Set the ID of record being shared 
    
            ChampShr.ParentId = QIRSAP.QIRS__r.Id;
           

            
            List<Id> ChampIds = new List<Id>();
            ChampIds.add(QIRSAP.Champion1__c);
            ChampIds.add(QIRSAP.Champion2__c);
            ChampIds.add(QIRSAP.Champion3__c);
            ChampIds.add(QIRSAP.Champion4__c);
            ChampIds.add(QIRSAP.Champion5__c);
            ChampIds.add(QIRSAP.Champion6__c);
            ChampIds.add(QIRSAP.Champion7__c);
            ChampIds.add(QIRSAP.Champion8__c);
            ChampIds.add(QIRSAP.Champion9__c);
            ChampIds.add(QIRSAP.Champion10__c);
            ChampIds.add(QIRSAP.Approver1__c);
            ChampIds.add(QIRSAP.Approver10__c);
            ChampIds.add(QIRSAP.Approver2__c);
            ChampIds.add(QIRSAP.Approver3__c);
            ChampIds.add(QIRSAP.Approver4__c);
            ChampIds.add(QIRSAP.Approver5__c);
            ChampIds.add(QIRSAP.Approver6__c);
            ChampIds.add(QIRSAP.Approver7__c);
            ChampIds.add(QIRSAP.Approver8__c);
            ChampIds.add(QIRSAP.Approver9__c);


            List<Id> DistMastApprIds = new List<Id>();
            Boolean RepeatedId;
            
            for(integer i = 0; i < ChampIds.size(); i++){
                RepeatedId = FALSE;
                for(integer j = 0; j < DistMastApprIds.size(); j++)
                    if(DistMastApprIds[j] == ChampIds[i])
                        RepeatedId = TRUE;
                if(RepeatedId == False)
                    DistMastApprIds.add(ChampIds[i]);
                }
                
            integer i = 0;
            for(Id MasterAppr : DistMastApprIds)
                if(MasterAppr != null){
                    ChampShr = new QIRS__Share();
                    ChampShr.ParentId = QIRSAP.QIRS__c;
                    ChampShr.UserOrGroupId = MasterAppr;
                    ChampShr.AccessLevel = 'edit';
                    ChampShr.RowCause = Schema.QIRS__Share.RowCause.ChampApprover__c;
                    QIRSAPShrs.add(ChampShr);
                    }

 
        }
        Database.SaveResult[] lsr = Database.insert(QIRSAPShrs,false);
        
        
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
    
trigger.newMap.get(QIRSAPShrs[i].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                }
            }
            i++;
        } */  
    }