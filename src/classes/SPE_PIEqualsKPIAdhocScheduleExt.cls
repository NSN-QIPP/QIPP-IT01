public class SPE_PIEqualsKPIAdhocScheduleExt 
 
{
    public SPE_KPIDefinition__c objKPIDef{get;set;}
    Id idKpiRec;
    List<SPE_KPIDefinition__c> lstKPIDefn;
    public SPE_PIEqualsKPIAdhocScheduleExt(ApexPages.StandardController con)
    {
        objKPIDef = [SELECT Id, FromDate__c,ToDate__c FROM SPE_KPIDefinition__c WHERE Id =: con.getId()];
    }
    
    public PageReference scheduleBatch()
    {
               
        update objKPIDef;
        SPE_PIEqualsKPISchedulebatch1Adhoc objBatch= new SPE_PIEqualsKPISchedulebatch1Adhoc (objKPIDef.Id);
        String CronExp= Datetime.now().addMinutes(1).format('ss mm HH dd MM ? yyyy');
        System.schedule(SPE_Constants.AdhocScheduleJob+system.now(),CronExp,objBatch);
        
        
        PageReference pgRef = new PageReference('/'+objKPIDef.Id);
        pgRef.setRedirect(true);
        return pgRef;
        
       
    }
}