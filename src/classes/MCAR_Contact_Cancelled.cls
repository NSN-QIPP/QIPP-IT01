global class MCAR_Contact_Cancelled
{
    public static MCAR__c CURRENT {get;set;} 
    public Id MCAR_ID {get;set;}
    
    public MCAR_Contact_Cancelled()
    {
        
    }
   
    
    webservice static Boolean OkButtonJavaScript(Id mcarid)
    {
        
        CURRENT= [select id, MCAR_Index_NSN_Code__c , MCAR_Part_Enterprise_ID__c, MCAR_Facility__c, MCAR_NSN_Code__c, CreatedById, OwnerId, MCAR_Manufacturer__c, MCAR_Status__c , MCAR_Severity_Level__c , MCAR_Defect_Location__c  from MCAR__C where id=:mcarid];           

        CURRENT.MCAR_Status__c ='Open';
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR__c' and Name='Open MCAR' limit 1]; 
        CURRENT.RecordTypeId=rcdType.id ;
        Database.SaveResult lsr3 = Database.update(CURRENT,false);
        if(lsr3.isSuccess())
            {
                 return true;               
            } 
            else
            {
                return false;
            }
    }
    
    webservice static Boolean isContactSelected(ID mcarid)
    {
        CURRENT= [select id , isContactCreatedForMCAR__c  from MCAR__C where id=:mcarid];           
        if(CURRENT.isContactCreatedForMCAR__c == 'Yes')
            return true;
        else 
            return false;
    }
    
    webservice static void changeRecordId(ID mcarid)
    {
        CURRENT = [select id , isContactCreatedForMCAR__c  from MCAR__C where id=:mcarid];
        CURRENT.MCAR_Status__c ='Open';
        RecordType rcdType = [select Id from RecordType where SObjectType='MCAR__c' and Name='Open MCAR' limit 1]; 
        CURRENT.RecordTypeId=rcdType.id ;
        update CURRENT;
        System.Debug('CURRENT : ' + CURRENT);
        
        sendNotificationMail(mcarid);
        // send  notification mails
    }
    
    public static void sendNotificationMail(ID mcarid)
    {        
            List<String> toEmailListNSN = new List<String>();
            List<String> toEmailListManufacturer = new List<String>();
            MCAR__c currentMCAR = [select id, CreatedById, Bruchsal__c , Beijing__c, Oulu__c, Chennai__c, Shanghai__c, Suzhou__c ,Tianjin__c ,
                                   MCAREmail1__c ,MCAREmail2__c ,MCAREmail3__c,MCAREmail4__c,MCAREmail5__c,MCAREmail6__c,MCAREmail7__c,MCAREmail8__c  from MCAR__C where id=:mcarid];                
            if(currentMCAR.Bruchsal__c)    
                toEmailListNSN.add('heinrich.jurtan@nokia.com'); //heinrich.jurtan@nokia.com
            if(currentMCAR.Beijing__c)    
                toEmailListNSN.add('xuejun.wang@nokia.com'); //xuejun.wang@nokia.com
            if(currentMCAR.Oulu__c)    
                toEmailListNSN.add('erja.sankari@nokia.com');  //erja.sankari@nokia.com            
            if(currentMCAR.Chennai__c)    
                toEmailListNSN.add('satendra.singh@nokia.com'); //satendra.singh@nokia.com
            if(currentMCAR.Shanghai__c)    
                toEmailListNSN.add('jose.menendez_herrero@nokia.com'); //jose.menendez_herrero@nokia.com
            if(currentMCAR.Suzhou__c)
                toEmailListNSN.add('michael.x.yang@nokia.com'); //michael.x.yang@nokia.com
            if(currentMCAR.Tianjin__c)     
                toEmailListNSN.add('weichong.tan@nokia.com');  //weichong.tan@nokia.com
            if(currentMCAR.MCAREmail1__c != null && currentMCAR.MCAREmail1__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail1__c);
            if(currentMCAR.MCAREmail2__c != null && currentMCAR.MCAREmail2__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail2__c);
            if(currentMCAR.MCAREmail3__c != null && currentMCAR.MCAREmail3__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail3__c);
            if(currentMCAR.MCAREmail4__c != null && currentMCAR.MCAREmail4__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail4__c);
            if(currentMCAR.MCAREmail5__c != null && currentMCAR.MCAREmail5__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail5__c);
            if(currentMCAR.MCAREmail6__c != null && currentMCAR.MCAREmail6__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail6__c);
            if(currentMCAR.MCAREmail7__c != null && currentMCAR.MCAREmail7__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail7__c);
            if(currentMCAR.MCAREmail8__c != null && currentMCAR.MCAREmail8__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail8__c);

            List<MCAR_Email_List__c>   emailListtobeSent= [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: mcarid and MCAR_Selected__c =: true]; 
            for(MCAR_Email_List__c selEmail :emailListtobeSent)
            {
                if (selEmail.MCAR_Email__c != null )
                {
                    if(selEmail.MCAR_Contact_Type__c == 'OTHER')
                        toEmailListManufacturer.add(selEmail.MCAR_Email__c);    
                    else
                        toEmailListNSN.add(selEmail.MCAR_Email__c);
                 }               
            } 
                   Messaging.SingleEmailMessage mCARCreationEmail= new Messaging.SingleEmailMessage();
                   EmailTemplate emailTmpl = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_Notify_Email_NSN_Contacts'];
                   mCARCreationEmail.setToAddresses(toEmailListNSN); 
                   mCARCreationEmail.setTargetObjectId(currentMCAR.CreatedById); 
                   mCARCreationEmail.setWhatId(currentMCAR.id );    
                   mCARCreationEmail.setSaveAsActivity(false);
                   mCARCreationEmail.setTemplateId(emailTmpl.Id);  
                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mCARCreationEmail});
                   mCARCreationEmail= new Messaging.SingleEmailMessage();
                   emailTmpl = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_Notify_Email_Manufacturer_Contact'];
                   mCARCreationEmail.setToAddresses(toEmailListManufacturer); 
                   mCARCreationEmail.setTargetObjectId(currentMCAR.CreatedById); 
                   mCARCreationEmail.setWhatId(currentMCAR.id );    
                   mCARCreationEmail.setSaveAsActivity(false);
                   mCARCreationEmail.setTemplateId(emailTmpl.Id);  
                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mCARCreationEmail});     
    }
}