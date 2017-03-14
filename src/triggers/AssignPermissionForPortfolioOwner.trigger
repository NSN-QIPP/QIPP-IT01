trigger AssignPermissionForPortfolioOwner on QIPP_Portfolio__c (after insert , after update) 
{
    for(QIPP_Portfolio__c  portfolio : Trigger.New)
    {
       QIPP_Portfolio__Share sharing;
       QIPP_Contacts__c ContactName = null;
       List<User> userpresence   = null;
       //Line no 9 added by sasya on 29-10-2014
       list<QIPP_Portfolio__Share> qippshare = new list<QIPP_Portfolio__Share>();
       if(portfolio.Portfolio_Owner__c != null)
           ContactName = [Select Name FROM QIPP_Contacts__c where Id =: portfolio.Portfolio_Owner__c];
        system.debug('contact Name----------->'+ ContactName );
       if(ContactName.Name != null) 
           userpresence = [select Id , Name , Profile.Name FROM User where Name  =: ContactName.Name] ;
    system.debug('user name----------->' +userpresence  );
       if( userpresence != null)
       { 
           if(userpresence.size() > 0)
           {
               if(userpresence[0].Id == portfolio.ownerid)
                   continue;
              sharing = new QIPP_Portfolio__Share();
              sharing.ParentId = portfolio.Id;
              Id assignId = userpresence[0].Id;
              sharing.UserorGroupId = assignId;
              sharing.AccessLevel = 'Edit';
              sharing.RowCause = Schema.QIPP_Portfolio__Share.RowCause.Manual;
              //Line no 29 added by sasya on 29-10-2014
             qippshare.add(sharing);
            //insert sharing;
           }
       /* Database.SaveResult[] lsr = Database.insert( qippshare,false);
        
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
                trigger.newMap.get(qippshare[i].id).addError('Unable to grant sharing access due to following exception :' + err.getMessage());
            }
        }
         i++; 
       }*/
    }   
}
}