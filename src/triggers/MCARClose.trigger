trigger MCARClose on MCAR__c (before update) {
   
   RecordType rcdType = [select Id from RecordType where SObjectType='MCAR__c' and Name='Closed MCAR' limit 1]; 
   for (MCAR__c mcar : Trigger.new)    { 
    
    if ((mcar.MCAR_Status__c == 'Closed') || (mcar.MCAR_Status__c == 'Cancelled') || (mcar.MCAR_Status__c == 'No Trouble Found'))
    {
        mcar.RecordTypeId=rcdType.id ;
        if(mcar.MCAR_IsWorkflowExecuted__c == True) {
        
            List<String> toEmailListNSN = new List<String>();
            List<String> toEmailListManufacturer = new List<String>();
            if(mcar.MCAR_CC_Email__c != null) 
                toEmailListNSN.add(mcar.MCAR_CC_Email__c );
            if(mcar.MCAR_CC_Email2__c != null) 
                toEmailListNSN.add(mcar.MCAR_CC_Email2__c );
            if(mcar.MCAR_CC_Email3__c != null) 
                toEmailListNSN.add(mcar.MCAR_CC_Email3__c );
            if(mcar.MCAR_CC_Email4__c != null) 
                toEmailListNSN.add(mcar.MCAR_CC_Email4__c );
            if(mcar.MCAR_CC_Email5__c != null) 
                toEmailListNSN.add(mcar.MCAR_CC_Email5__c );

            if(mcar.MCAR_Factory_GM_Email__c != null) 
                toEmailListNSN.add(mcar.MCAR_Factory_GM_Email__c);
                
            List<MCAR_Email_List__c>   emailListtobeSent= [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: mcar.Id and MCAR_Selected__c =: true]; 
            for(MCAR_Email_List__c selEmail :emailListtobeSent)
            {
                if (selEmail.MCAR_Email__c != null )
                {
                    toEmailListNSN.add(selEmail.MCAR_Email__c);
                 }               
            } 
                   
                   Messaging.SingleEmailMessage mCARCreationEmail= new Messaging.SingleEmailMessage();
                   EmailTemplate emailTmpl = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_Close_VF'];
                   mCARCreationEmail.setToAddresses(toEmailListNSN); 
                   mCARCreationEmail.setTargetObjectId(mcar.CreatedById); 
                   mCARCreationEmail.setWhatId(mcar.id );    
                   mCARCreationEmail.setSaveAsActivity(false);
                   mCARCreationEmail.setTemplateId(emailTmpl.Id);  
                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mCARCreationEmail});
                   
                          }
    }    mcar.MCAR_Days_Open__c=mcar.MCAR_Days_MCAR_Open__c;
    //MCAR_Creation_Date_Status_Open__c
   }
}