global class SPE2_createkpiIntermediateCompute implements Database.Batchable<sObject>{
    global string kpiidentifier;
    //global Set<String> intermidateKPI;
    global String kpiDefinationID;
    global String query; 
    global Map<Id, Map<String, String>> kpiEnterpriseCommentsMap;
    
     global SPE2_createkpiIntermediateCompute(String kpiidentifier,String kpiDefinationID,Map<Id, Map<String, String>> kpiEnterpriseCommentsMap){
        this.kpiidentifier = kpiidentifier;
        this.kpiDefinationID = kpiDefinationID;
        this.kpiEnterpriseCommentsMap = kpiEnterpriseCommentsMap;
        //this.intermidateKPI = intermidateKPI;
        system.debug('kpiidentifier ::'+kpiidentifier);
        System.debug('Refreshed');        
        //system.now()+';'+userInfo.getUserId();                                                                        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        query = 'SELECT Index__c, KPIDefinition__c, PIValue__c, MappingScope__c, IsConstant__c, ValueType__c FROM SPE_PITempValue__c WHERE KPIDefinition__c =: kpiDefinationID';
        system.debug('query:12:'+query);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<SPE_PITempValue__c> scope){
        List<KPI_IntermediateComputation__c> kpiInterComlist = new List<KPI_IntermediateComputation__c>();
        
        List<KPI_IntermediateComputation__c> kpiInsertedlist = [Select ID,KPI_MappingScope__c from KPI_IntermediateComputation__c 
                                                                where KPI__c =: kpiDefinationID];
                                                                
        Map<String,String> allKpiInterScope = new Map<String,String>();
        if(kpiInsertedlist.size() > 0){
            for(KPI_IntermediateComputation__c kpiInter: kpiInsertedlist){
                allKpiInterScope.put(kpiInter.KPI_MappingScope__c,kpiInter.KPI_MappingScope__c);
            }
        }
                                                               
        Set<String> intermidateKPI = new Set<String>();
        for(SPE_PITempValue__c piTemp: scope){
            intermidateKPI.add(piTemp.MappingScope__c);             
        }
        
        for(String scopeinter: intermidateKPI){
            if(!allKpiInterScope.containsKey(scopeinter)){
                KPI_IntermediateComputation__c kpiIntCom = new KPI_IntermediateComputation__c();
                kpiIntCom.IdentifierParam__c = kpiidentifier;
                kpiIntCom.KPI_MappingScope__c = scopeinter;
                kpiIntCom.KPI__c = kpiDefinationID;
                kpiInterComlist.add(kpiIntCom);
            }
        }                                         
        system.debug('kpiInterComlist ::'+kpiInterComlist);
        try{
            if(!kpiInterComlist.isEmpty()){
                insert kpiInterComlist;
            }            
        }catch(Exception e){}        
    }          
    global void finish(Database.BatchableContext BC){        
        if(!Test.isRunningTest()){
            SPE2_kpiIntermediateCompute dbatch = new SPE2_kpiIntermediateCompute(kpiidentifier,kpiDefinationID,kpiEnterpriseCommentsMap);
            database.executebatch(dbatch,1);
        }
    }
}