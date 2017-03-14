global class SPE_KPISchedulebatch5Adhoc implements Database.Batchable <sObject> , Schedulable 
{
    global Id kpiIds;
    
    public SPE_KPISchedulebatch5Adhoc (String s)
    {
        kpiIds = s;
    }

    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,1);
    }

    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
        String query='select id,ScheduledDate__c,Adhoc_Date__c,FrequencyinMonth__c,KPIValuesCalculation__c from SPE_KPIDefinition__c where Id=: kpiId';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_KPIDefinition__c> scope) 
    {
        try{                        
            Date d = Date.newInstance(1960, 2, 17);
            d=(scope[0].Adhoc_Date__c).addMonths(-1);        
            Integer numberOfDays = Date.daysInMonth(d.year(), d.month());
            d= Date.newInstance(d.year(), d.month(), numberOfDays);
            scope[0].Adhoc_Date__c=d;
            Update scope[0];           
        }catch(Exception e){}
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
        /**---Added to implement Number of Months field for Adhoc Schedule----- */
        SPE_KPIDefinition__c KPIDefObj = [SELECT Id,ScheduledDate__c ,adhoc_date__c,Number_Of_Months__c,KPIValuesCalculation__c FROM SPE_KPIDefinition__c WHERE Id =:kpiId];
        if(KPIDefObj.Number_Of_Months__c!=1){
            KPIDefObj.Number_Of_Months__c = KPIDefObj.Number_Of_Months__c - 1;
            //KPIDefObj.adhoc_date__c = (KPIDefObj.Adhoc_Date__c).addMonths(-1);
            update KPIDefObj;
            SPE_KPISchedulebatch1Adhoc objBatch= new SPE_KPISchedulebatch1Adhoc(KPIDefObj.Id);  
            database.executebatch(objBatch,2000); 
        
        }
        else{        
            try{
                if(KPIDefObj.KPIValuesCalculation__c == null){
                    KPIDefObj.KPIValuesCalculation__c = 0;
                }
                KPIDefObj.KPIValuesCalculation__c = KPIDefObj.KPIValuesCalculation__c+1;
                Update KPIDefObj;
            }catch(Exception e){}     
        }
    }
}