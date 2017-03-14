global class SPE_SendScorecard
{   
   webservice static void UpdateScorecard(Id SCiD) {
   SPE_ScoreCard__c s=[select id,isExecute__c from SPE_ScoreCard__c where id=:SCiD];
   s.isExecute__c = true;
   update s;
   }
    
    webservice static void SendScorecard(Id SCiD) {
        SPE_ScoreCard__c s=[select contact__r.password__c,LastModifiedBy.name,Owner.name,Approver__r.name,Owner.email,id,name,Distribute_Scorecard__c,isInternalScorecard__c,Supplier__r.name,Supplier__c,EnterpriseId__c,ScorecardTracker__r.name,ScorecardTracker__r.ScorecardGenerator__r.name,contact__r.email,CCContact1__r.email,CCContact2__r.email,CCContact3__r.email,EndDate__c,Password__c,Region__c,Country__c,Category__c,Project__c from SPE_ScoreCard__c where id=:SCiD];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        EmailTemplate emptemp =[Select id,name,subject,body from EmailTemplate where name = 'Spe_ScorecardUrl'];
        mail.setTemplateId(emptemp.id);
        String[] toAddresses = new String[]{s.contact__r.email};
        mail.setToAddresses(toAddresses);
       // List<String> CCEmails = new List<String>();
        List<SPE_ScoreCard__c> scCC = [SELECT (select Contact__r.Email from CC_Contact_Details__r) FROM SPE_ScoreCard__c WHERE Id =: SCiD ];
        List<String> CcList = new List<String>();
         for(SPE_ScoreCard__c SPEsc: scCC){
            for(SPE2_CC_Contact_Details__c ccCon: SPEsc.CC_Contact_Details__r){
            CcList.add(ccCon.Contact__r.Email);
            }
        }    
        
        
        if(s.Distribute_Scorecard__c != 'DISTRIBUTED')
        {
            s.Distribute_Scorecard__c = 'DISTRIBUTED';
            update s;
        }
        if(s.Distribute_Scorecard__c == 'DISTRIBUTED')
        {
        if(CcList.size()>0)
        mail.setCCAddresses(CcList);
        mail.setReplyTo('Saurabh.dua@atos.net');
        mail.setSenderDisplayName('From:' +s.LastModifiedBy.name);
        mail.setBccSender(false);
        mail.setUseSignature(false);
        String subjectnew = emptemp.subject.replace('{!SPE_ScoreCard__c.Name}',s.Name);
        subjectnew = subjectnew.replace('{!SPE_ScoreCard__c.ScorecardTracker__c}',s.ScorecardTracker__r.name);
        mail.setSubject(subjectnew);
        String bodynew = emptemp.body.replace('{!SPE_ScoreCard__c.Name}',s.Name);
        bodynew = bodynew.replace('Dear Supplier','Hello');
        bodynew = bodynew.replace('{!SPE_ScoreCard__c.ScorecardTracker__c}',s.ScorecardTracker__r.name);
        bodynew = bodynew.replace('{!$Label.SPE_ScorecardUrl}',System.Label.SPE_ScorecardUrl);
        bodynew = bodynew.replace('{!SPE_ScoreCard__c.Id}',s.ID);
        bodynew = bodynew.replace('{!SPE_ScoreCard__c.Password__c}',s.Password__c);
        mail.setPlainTextBody(bodynew);
         
        
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment where ParentId = :SCiD ORDER BY createdDate DESC Limit 1])
        {
        // Add to attachment file list
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(a.Name);
        efa.setBody(a.Body);
        fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
      
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        //sending Password mail
        /*
        Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();
        String[] toAddresses2 = new String[]{s.contact__r.email};
        
        List<String> CCEmails2 = new List<String>();
        
        
        mail2.setToAddresses(toAddresses2);
        mail2.setCCAddresses(CcList);
        mail2.setReplyTo('Saurabh.dua@atos.net');
        mail2.setSenderDisplayName('From: '+s.LastModifiedBy.name);
        mail2.setBccSender(false);
        mail2.setUseSignature(false);
        mail2.setSubject('Scorecard -'+s.ScorecardTracker__r.name+','+s.Supplier__r.name+','+s.Category__c+'');
        mail2.sethtmlBody('Dear Supplier, <br/><br/>This is regarding your company\'s performance evaluation in:'+'<br/>'+'Market-'+s.Region__c+
        ',Country-'+s.Country__c+',Category-'+s.Category__c+',Project-'+s.Project__c+'<br/><br/>'+'Use below mentioned password to access the link <font color="red">provided in separate mail</font>.'+'<br/><br/>'+s.Password__c+'<br/><br/>With Kind Regards,<br/>Nokia SPE Tool'); 
       
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail2 });
        */
       }
   } 
}