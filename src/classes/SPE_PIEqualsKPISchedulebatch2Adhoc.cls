global class SPE_PIEqualsKPISchedulebatch2Adhoc implements Database.Batchable <sObject>  
{
    global Id kpiIds;
    global Date fromDate;
    global Date toDate;
    global Id PIDataId;
    
    public SPE_PIEqualsKPISchedulebatch2Adhoc (String s)
    {
        kpiIds = s;
        List<SPE_KPIDefinition__c> lstKPIDef = [SELECT Id, FromDate__c,PI_Data__c,ToDate__c FROM SPE_KPIDefinition__c where ID=:s];
        fromDate = lstKPIDef[0].FromDate__c;
        toDate = lstKPIDef[0].ToDate__c;
        PIDataId = lstKPIDef[0].PI_Data__c; 
    }

    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(10000));
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
        
        //**************Changes for Encryption*******************//
        String query = 'SELECT BusinessLine__c,BusinessUnit__c,CategoryGroup__c,Category__c,Cluster__c,Country__c,EnterpriseId__c,EnterpriseIDEncrypted__c,Period__c,Product__c,Project__c,Region__c,SubRegion__c,numbervalue__c FROM SPE_PIValues__c WHERE PIDefination__c=: PIDataId AND Period__c >= :fromDate AND Period__c <= :toDate' ;
        //**************END********************//
        
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <SPE_PIValues__c> scope) 
    {
        list<Spe_KpiValue__c> KPIVal= new list<Spe_KpiValue__c>();
        for(SPE_PIValues__c p:scope) {
        Spe_KpiValue__c s= new Spe_KpiValue__c();
        s.period__c=p.period__c;
        
        //**************Changes for Encryption*******************//
        s.enterpriseId__c=p.enterpriseId__c;
        s.EnterpriseIDEncrypted__c=p.EnterpriseIDEncrypted__c;
        //**************END********************//
        
        s.Region__c=p.Region__c;
        s.SubRegion__c=p.subregion__c;
        s.Country__c=p.Country__c;
        s.Project__c=p.project__c;
        s.Product__c=p.product__c;
        s.BusinessUnit__c=p.BusinessUnit__c;
        s.BusinessLine__c=p.BusinessLine__c;
        s.Cluster__c=p.cluster__c;
        s.Category__c=p.category__c;
        s.KPIDefinition__c=kpiIds;
        s.kpivalue__c=p.numbervalue__c;
        s.categoryGroup__c=p.categorygroup__c;
        s.executionPeriod__c=SPE_Utility.monthsMap.get((p.period__c).month()) + ' - '+ String.valueOf((p.period__c).year());  
        KPIVal.add(s);
        
        }
        
        if(KPIVal.size()>0)
        insert KPIVal;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        Id kpiId = this.kpiIds;
        
         System.debug('=========>In Finish');
        
        
        //**************Changes for Encryption*******************//
        //String KpiName= [select Name from SPE_KPIDefinition__c where Id=: kpiId].name;
        String KpiName= [select KPI_Title__c from SPE_KPIDefinition__c where Id=: kpiId].KPI_Title__c;
        //**************END********************//
        
        String userEmail =String.valueof(Userinfo.getUserEmail());
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        String[] toAddresses = new String[] {userEmail}; 
        mail.setToAddresses(toAddresses); 
        mail.setSubject('Schedule Completed'); 
        String body = 'KPI-'+KpiName+' scheduled by '+String.valueof(UserInfo.getFirstName())+' '+String.valueof(UserInfo.getLastName())+ ' is scheduled Successfully' ; 
        mail.setPlainTextBody(body); 
        Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        
    }
}