/* ******************************** Schedule class for sending notification email to user ***************************************
    Createdby : Amjad khan                     Createddate : 12/03/2015                               
*/
Global class SPE_SchedulePIDataBatchEmail implements Database.batchable<sObject>, Schedulable
{
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,200);
    }

    Global Database.QueryLocator Start(Database.BatchableContext BC)
    {
        List<String> stage = new List<String>();
        stage.add(SPE_Constants.PUBLISHED_LIFECYCLESTAGE);
        stage.add(SPE_Constants.PILOT_LIFECYCLESTAGE); 
        
        String dataAcquisitionMethod = SPE_Constants.DATALOAD_DATAACQUISITION;
        
      //*****************************Changes For Encryption***********************//  
        String query = 'SELECT Id, Name,PI_Title__c,PIUploadDuedate__c,LastPIImportDate__c,OwnerId,CreatedBy.Email,PriorValue_Last_PI_Import_Date__c,Frequency__c '+ 
                       'FROM SPE_PIDefinition__c WHERE LifecycleStage__c In:stage AND DataAcquisitionMethod__c =: dataAcquisitionMethod';
      //*****************************END***********************//  
        return Database.getQueryLocator(query);
    }
    
    Global void execute(Database.BatchableContext BC, List<SPE_PIDefinition__c> scope)
    {
        
        List<Messaging.singleEmailMessage> mails = new List<Messaging.singleEmailMessage>();
        Date LastDUploadPI;
        Date DUploadPI;
        EmailTemplate reminderEmailTemplate =[Select id from EmailTemplate where name=:SPE_Constants.SPE_PIDATABATCHEMAILTEMPLATE];
        
        Map<Id,SPE_PIDefinition__c> PIMap=new Map<Id,SPE_PIDefinition__c>();
        for(SPE_PIDefinition__c PI : Scope)
        {
            
            if( PI.PIUploadDuedate__c !=null && PI.Frequency__c !=null)
            { 
                if(PI.LastPIImportDate__c!=null)
                {
                    LastDUploadPI=Date.newinstance(PI.LastPIImportDate__c.year(),PI.LastPIImportDate__c.month(),PI.LastPIImportDate__c.day());
                }
                
                if (PI.Frequency__c  == null || PI.Frequency__c == '0' || PI.Frequency__c == '')
                {
                    PI.Frequency__c = '1';
                }
                
                DUploadPI = PI.PIUploadDuedate__c.addMonths(-Integer.valueof(PI.Frequency__c));
                
                Date TODAYs = Date.today();
        
                string numberOfDays = Label.SPE_ScheduleDateModifier == null ? '0' : Label.SPE_ScheduleDateModifier;

                Integer addDay = integer.valueOf(numberOfDays) == null ? 0 : integer.valueOf(numberOfDays);
                
                TODAYs = TODAYs.addDays(addDay);
                
                if(TODAYs.adddays(7)==PI.PIUploadDuedate__c && (PI.LastPIImportDate__c==null || LastDUploadPI <= DUploadPI))
                { 
                      Messaging.singleEmailMessage mail = new Messaging.singleEmailMessage();
                      mail.setTargetObjectId(PI.ownerid);
                      mail.setWhatId(PI.id);
                      //mail.setCcAddresses(CcAdd);
                      mail.settemplateid(reminderEmailTemplate.id);
                      mail.setSaveAsActivity(false);
                      mails.add(mail);
                } 
            }
        }
        
        Messaging.sendEmail(mails);
        
        List<SPE_PIDefinition__c> UpdateListofPI= new List<SPE_PIDefinition__c>();
        for(SPE_PIDefinition__c PI : Scope)
        {
            if(date.today()==PI.PIUploadDuedate__c)
            {
                PI.PIUploadDuedate__c=PI.PIUploadDuedate__c.addmonths(Integer.valueof(PI.Frequency__c));
                UpdateListofPI.add(PI);
            }
        }
        
        update UpdateListofPI; 
    }
         
    Global void finish(Database.BatchableContext BC) 
    {
    } 
}