global class  QIPPContactUserLicense
{
public QIPPContactUserLicense(ApexPages.StandardController con){
}

webservice static String ApplyForUserLicense(Id contactid)
   {
    String val ;
    try
    {
        User u = [select Id, username from User where Id = :UserInfo.getUserId()];
        QIPP_Contacts__c con = [select id ,NSN_ID_Text__c,Email__c, Full_Name__c,Business_Function__c,CreatedById  from QIPP_Contacts__c where Id =: contactid];
        if(con.Business_Function__c == null || con.Business_Function__c == '')
        {
            val = 'Business Function is not present';
        }
        else if (con.NSN_ID_Text__c == null)
        {
            val = 'NSN ID is not present';
        }
        else
        {
            con.Assign_User_License_Request_Generator__c =  u.username;     
            upsert con;
            val = sendEmail(con, 'Apply');
        }    
    }
    catch(Exception e)
    {
        val = 'false';
    }
    return val;
   }

webservice static String RemoveUserLicense(Id contactid)
{
    String val ;
    try
    {
        User u = [select Id, username from User where Id = :UserInfo.getUserId()];
        QIPP_Contacts__c con1 = [select id ,NSN_ID_Text__c,Email__c, Full_Name__c,Business_Function__c,CreatedById  from QIPP_Contacts__c where Id =: contactid];
        con1.Remove_User_License_Request_Generator__c =  u.username;     
        upsert con1;
        val = sendEmail(con1,'Remove');
    }
    catch(Exception e)
    {
        val = 'false';        
    }
    return val;
}


private static List<String> getEmailAddresses() 
{
        List<String> idList = new List<String>();
        List<String> mailToAddresses = new List<String>();
        Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE name = 'SupportGroupForSalesforceLicense'];
        for (GroupMember gm : g.groupMembers) 
        {
        idList.add(gm.userOrGroupId);
        }
        User[] usr = [SELECT email FROM user WHERE id IN :idList];
        for(User u : usr) 
        {
            mailToAddresses.add(u.email);
        }
        return mailToAddresses;
} 

private static String sendEmail(QIPP_Contacts__c con , String fromaction )
{
        String val = '';
        EmailTemplate emailTmpl = null;
        try
        {
           Messaging.SingleEmailMessage requestemail= new Messaging.SingleEmailMessage();
           requestemail.setToAddresses(getEmailAddresses());   
           requestemail.setTargetObjectId(con.CreatedById); 
           requestemail.setWhatId(con.id );    
           requestemail.setSaveAsActivity(false);
           
           if(fromaction == 'Apply')
             {
                 emailTmpl = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'QIPPCreateUserLicense'];
             }
             else if (fromaction == 'Remove')                    
             {
                  emailTmpl = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'QIPPRemoveUserLicense'];   
             }
           requestemail.setTemplateId(emailTmpl.Id);    
           requestemail.setSaveAsActivity(false);
           requestemail.useSignature = false;
           Messaging.sendEmail(New Messaging.SingleEmailMessage[]{requestemail});
           val = 'ok';
        }
        catch(Exception e)
        {
           val = 'false'; 
           System.Debug('exception ******* ' + e.getMessage());
        }
        return val;
     }
}