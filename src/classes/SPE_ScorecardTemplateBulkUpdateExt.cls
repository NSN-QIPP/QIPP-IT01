public with sharing class SPE_ScorecardTemplateBulkUpdateExt 
{
    public List<Selectoption> fromStageList {get;set;}
    public List<Selectoption> toStageList {get;set;}
    
    public String fromStage {get;set;}
    public String toStage {get;set;}
    
     transient public Boolean sendNotification {get;set;} 
    
    public List<ScorecardTempTempWrapper> ScorecardTempWrapperList {get;set;}
    
    public SPE_ScorecardTemplateBulkUpdateExt (Apexpages.StandardSetcontroller stCon)
    {
        fromStage = 'Draft';
    
        initialize();
        searchScorecardTemps();
    }
    
    public void initialize()
    {
        ScorecardTempWrapperList= new List<ScorecardTempTempWrapper>();
        
        fromStageList = new List<SelectOption>();
        fromStageList.add(new SelectOption('Draft','Draft'));
        fromStageList.add(new SelectOption('Published','Published'));
        
        toStageList = new List<SelectOption>();
        toStageList.add(new SelectOption('Published','Published'));
        toStageList.add(new SelectOption('Obsolete','Obsolete'));
    }
    
    public void searchScorecardTemps()
    {
        ScorecardTempWrapperList.clear();
        
        for (SPE_ScorecardTemplate__c k : [SELECT Id, Name,OwnerId,Stage__c,Category__c,CategoryGroup__c,CategoryCluster__c,Region__c,SubRegion__c,Country__c,Project__c,ScorecardTemplateId__c
                                       FROM SPE_ScorecardTemplate__c
                                       WHERE  Stage__c=: fromStage LIMIT 100])
        {
            
            ScorecardTempTempWrapper kw = new ScorecardTempTempWrapper(k);  
            ScorecardTempWrapperList.add(kw);
        }
    }
    
    public void updateScorecardTemps ()
    {
        List<SPE_ScorecardTemplate__c> toBeUpdateScorecardTempDefinitions=  new List<SPE_ScorecardTemplate__c>();
        
        if(sendNotification)
        {
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress Where DisplayName like 'SPE Admin' ];
            EmailTemplate emailTemplate =[Select id,Name from EmailTemplate where name=:'SPE_ScorecardTemplateStageChangeNotification'];
        
        for (ScorecardTempTempWrapper  kw : ScorecardTempWrapperList)
        {
             Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
             
            if (kw.isChecked)
            {
                SPE_ScorecardTemplate__c updatedScorecardTemp = new SPE_ScorecardTemplate__c();
                updatedScorecardTemp = kw.ScoreTemp;
                updatedScorecardTemp.Stage__c= toStage;
                
                mail.setTargetObjectId(kw.ownerId);
                    mail.setOrgWideEmailAddressId(owe.Id);
                    
                    System.debug('UserId======>' + kw.ownerId);
                    
                    mail.setTemplateId(emailTemplate.id);
                    mail.setSaveAsActivity(false);
                    mail.setUseSignature(false);
                    System.debug('UserId======>' + kw.kpiId);
                    mail.setWhatId(kw.kpiId);
                    mails.add(mail);
                
                toBeUpdateScorecardTempDefinitions.add(updatedScorecardTemp);           
            }
        }
        
        update toBeUpdateScorecardTempDefinitions;
        
             Messaging.sendEmail(mails);
             mails.clear();
        }
        else
        {
            for (ScorecardTempTempWrapper  kw : ScorecardTempWrapperList)
            {
                if (kw.isChecked)
                {
                   SPE_ScorecardTemplate__c updatedScorecardTemp = new SPE_ScorecardTemplate__c();
                   updatedScorecardTemp = kw.ScoreTemp;
                   updatedScorecardTemp.Stage__c= toStage;
                    
                    toBeUpdateScorecardTempDefinitions.add(updatedScorecardTemp);
                }
            }
            update toBeUpdateScorecardTempDefinitions;
        }
        
        sendNotification = false;
        initialize();
        searchScorecardTemps();
    }
    
    public class ScorecardTempTempWrapper
    {
        public SPE_ScorecardTemplate__c ScoreTemp {get;set;}
        public Boolean isChecked {get;set;}
        public Id ownerId {get;set;}
        public Id kpiId {get;set;}
        
        public ScorecardTempTempWrapper(SPE_ScorecardTemplate__c Kpis)
        {
            ScoreTemp = Kpis;
            isChecked = false;
            this.ownerId = kpis.OwnerId;
            kpiId = kpis.Id;
        }
    }
}