trigger QIPP_UpdateLineManagerEmail on QIPP_Contacts__c (before insert , before update) {
   
    List<QIPP_Contacts__c> check = Trigger.new;
    if(check[0].User_License__c != null)
    {
        User selectedUser = [select Email From User where Id =: check[0].User_License__c];
        if( selectedUser.Email !=  check[0].Email__c )
        {
             trigger.new[0].User_License__c.addError('Please select correct User License. Both contact and User Email ID are not matching.');
        }
    }

    
    for(QIPP_Contacts__c cont:Trigger.new)
    {
        if(cont.Contact_Line_Manager_NSN_ID__c!=NULL && cont.Contact_Line_Manager_NSN_ID__c!='')
        {
        
          System.Debug('&&&&&&&&&&&&&&&&&& Contact_Line_Manager_NSN_ID__c &&&&&&&&&&&&&&&&&&& ' + cont.Contact_Line_Manager_NSN_ID__c);
          System.Debug('&&&&&&&&&&&&&&&&&& NSN_ID_Text__c &&&&&&&&&&&&&&&&&&& ' + cont.NSN_ID_Text__c);
         
          List<QIPP_Contacts__c> qippList = new List<QIPP_Contacts__c>();        
          
          qippList= [select Email__c from QIPP_Contacts__c WHERE NSN_ID_Text__c = :cont.Contact_Line_Manager_NSN_ID__c];
          
          System.Debug('&&&&&&&&&&&&&&&&&& qippList &&&&&&&&&&&&&&&&&&& ' + qippList.size());
          
          if(qippList!=null && qippList.size() > 0 && qippList[0].Email__c != null)
              cont.Contact_Line_Manager_Email__c = qippList[0].Email__c;
        }
        else{
          cont.Contact_Line_Manager_Email__c = '';
        }
    }
}