global class ClaimReclamationLetterController 
{
    public static List<Claim_Contact__c> ClaimContact { set; get; }
    public static List<String> toAddresses {set; get;}
    public Claim_Contact__c ManufacturerContact { set; get; }  
    public Claim_Contact__c CMcontact { set; get; }
    public static String ClaimName {set; get;}
    public static MCAR_Claim_Management__c ClaimDetails { set; get;}
    public MCAR_Manufacturer_Contact__c supplierContact {set; get;}
    public MCAR_Manufacturer__c manufacturer { set; get; }        
    
    public ClaimReclamationLetterController(ApexPages.StandardController controller)
    {
        try
        {
            id ClaimId = ApexPages.currentPage().getParameters().get('id');                
            ClaimDetails = [select id,Name,Manufacturer__c,Manufacturer_Email__c,Owner.Email from MCAR_Claim_Management__c where id =:ClaimId limit 1];
            manufacturer = [select Name,MCAR_HQ_Street__c, MCAR_HQ_State__c, MCAR_HQ_Zip_Postal_Code__c,MCAR_HQ_City__c,MCAR_HQ_Country__c from MCAR_Manufacturer__c where id = :ClaimDetails.Manufacturer__c limit 1];
            ManufacturerContact = [select id,Name__c,Name,Email__c,Contact_Type__c from Claim_Contact__c where Contact_Type__c='Manufacturer' and Claims__c=:ClaimId and Email__c =:ClaimDetails.Manufacturer_Email__c limit 1];                                      
            CMcontact = [select Name__c,Email__c from Claim_Contact__c where Contact_Type__c='Category Manager' and Claims__c=:ClaimId ];
            supplierContact = [select Contact_Type__c from MCAR_Manufacturer_Contact__c where Manufacturer_Name__c =: ClaimDetails.Manufacturer__c and Email__c =:ClaimDetails.Manufacturer_Email__c ];                  
            //supplierContact = [select id,name,MCAR_Street__c,MCAR_City__c,MCAR_Country__c,State__c,Zip__c,Contact_Type__c from MCAR_Manufacturer_Contact__c where Manufacturer_Name__c =: ClaimDetails.Manufacturer__c and Email__c =:ClaimDetails.Manufacturer_Email__c ];                  
            //JobTitle = [select Title__c from QIPP_Contacts__c where email__c =: ClaimDetails.Owner.Email limit 1].Title__c;
        }
        catch(Exception e)
        {
            
        }
                
        
    }        
        
    webservice static boolean sendReclamationLetter(id claimRecordID)
    {
        try
        {
            PageReference pdf = Page.ReclamationLetterPage;
            pdf.getParameters().put('id',claimRecordID);
            pdf.setRedirect(true);
            
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            //Blob body = pdf.getContent();
              
            Blob body;          
            if (Test.IsRunningTest())                   
            {   
                        body=Blob.valueOf('UNIT.TEST');   
            }                    
            else                         
            {
                        body = pdf.getContent();
            }
            
            ClaimContact = new List<Claim_Contact__c>([select id,Name,Email__c,Contact_Type__c from Claim_Contact__c where Contact_Type__c='Manufacturer' and Claims__c=:claimRecordID]);                   
            
            attach.setContentType('application/pdf');
            attach.setFileName('Reclamation Letter.pdf');
            attach.setInline(false);
            attach.Body = body;
                                
            
            
        toAddresses = new List<String>();
        for(Claim_Contact__c con : ClaimContact)
        toAddresses.add(con.Email__c);          
            
        System.debug('*****'+toAddresses);        
       
        ClaimName = [select Name from MCAR_Claim_Management__c where id=:claimRecordID].name;
        Datetime ResponseDueDate = [select Response_Due_Date__c from MCAR_Claim_Management__c where id=:claimRecordID].Response_Due_Date__c;
            
            String ResponseDueDateStr = ResponseDueDate.format('dd-MMMM-yyyy');
            
        mail.setToAddresses(toAddresses);
        mail.setSubject('Nokia Networks Reclamation Notice for '+ClaimName);                 
            
        mail.setReplyTo('reclamationconfirmation@tz0tgjr0kf5o20dfv1u05bl5slh0nno3ydo1y95d15zo3cdjj.u-h1t7mak.na12.apex.salesforce.com');                          
        
        String EmailBody;
            
        //mail.setHtmlBody('Test Body' + '<img height="" width="" src="https://dev1-nsn.cs20.force.com/emailTrace?Id='+claimRecordID+'"/>');                 
        //mail.setHtmlBody('<html><head><style>h1.hidden {visibility: hidden;}</style></head><body><p>Dear Sir or Madam:</P><p>Attached is a Reclamation Letter that gives a brief overview </br>of an issue that Nokia Networks is experiencing.</p></br></br><p> Please reply to this email to conform receipt of the letter.</p> <h1 class="hidden"><img height="0" width="0"  src="https://qa01-nsn.cs22.force.com/emailTrace?Id='+claimRecordID+'"/></h1>Yours sincerely,<br/><h4>Nokia Networks</h4></body></html>');                
        
        mail.setHtmlBody('<html><head><style>h1.hidden {visibility: hidden;}</style></head><body><tr><td>Dear Sir or Madam:</td></tr><br/><br/><tr><td>Attached is a Reclamation Letter that gives a brief overview of an issue that Nokia Networks is experiencing.</td></tr><br/><br/><tr><td>Please reply to this email to confirm receipt of the letter before '+ResponseDueDateStr+'.</td></tr><br/><br/>Yours sincerely,<br/><h>Nokia Networks</h></b><h1 class="hidden"><img height="0" width="0"  src="http://nsn.force.com/emailTrace?Id='+claimRecordID+'"/></h1></body></html>');                
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
         MCAR_Claim_Management__c claimUpdated = [select Last_Reclamation_Sent__c from MCAR_Claim_Management__c where id=:claimRecordID];
            claimUpdated.Last_Reclamation_Sent__c = Date.today();
            update claimUpdated;
            
            //--------------------attachement------------------------//     
            try
            {
                MCAR_Claim_Management__c[] claimAttachement = [select id,name,(select id,name from Attachments where name = 'Reclamation Letter.pdf') from MCAR_Claim_Management__c where id =:claimRecordID limit 1];
            
                SObject[] myAttachement = claimAttachement[0].getSObjects('Attachments');                                                                                         
                
                if(myAttachement == null)     
                {                                           
                    Attachment recAttach = new Attachment();                       
                    recAttach.body = body;                    
                    recAttach.Name = 'Reclamation Letter.pdf';                        
                    recAttach.IsPrivate = false;                        
                    recAttach.parentId = claimRecordID;                        
                    insert recAttach;
                }
                /*
                else
                for(SObject attachment : myAttachement)  
                {
                    if(attachment.get('Name')!='Reclamation Letter.pdf')
                    {
                        Attachment recAttach = new Attachment();
                        recAttach.body = body;
                        recAttach.Name = 'Reclamation Letter.pdf';
                        recAttach.IsPrivate = false;
                        recAttach.parentId = claimRecordID;
                        insert recAttach;
                    }
                }*/    
            }
            catch(Exception e)
            {
                
            }
            //--------------------------------------------//
                        
            system.debug('***Letter Sent Successfully.........');
        return true;
                        
        }
        catch(Exception e)
        {
            return false;
        }        
        return false;
    }
    
    webservice static Boolean isfoundManufacturer(String claimId)
    {
    
    Boolean result;
        System.debug('****'+claimId);
        
        ClaimContact = new List<Claim_Contact__c>([select id from Claim_Contact__c where Contact_Type__c = 'Manufacturer' and Claims__c =:claimId ]);
        system.debug('****'+ClaimContact.size());

        if(ClaimContact.size()==0)  
        {         
            system.debug('****False will be');
            result = true;
            return result;    
        } 
        else{
        result = false;
        return result;
        } 
       
        
        return result;
        
    }
    
    
    
    
        
    webservice static boolean isSentAlready(String claimId)
    {        
        
        System.debug('****'+claimId);        
        Trace_Email__c te;
        try
        {            
            te = [select id from Trace_Email__c where Claim__c =: claimId limit 1];                
            if(te.id!=null)
            {
                System.debug('***record exist');
                return true;
            }
        }
        Catch(Exception e)
        {                
            System.debug('***record not exist and its catch block');
            return false;
        }                  
        System.debug('****record not exist');
        
        return false;           
    }
}


////-------------------------------for testing-----------------------------------------------------