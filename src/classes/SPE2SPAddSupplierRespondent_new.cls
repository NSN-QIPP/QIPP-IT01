global class SPE2SPAddSupplierRespondent_new implements Database.Batchable<sObject>{
    global String query;
    
    global SPE2SPAddSupplierRespondent_new(String PlanIdentifier){
        query='SELECT ID,Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,CategoryGroup__c,Category__c,';
        query+='BusinessUnit__c,BusinessLine__c,Product__c,Plan_Identifier__c FROM SPE_SPEPlan__c where Plan_Identifier__c = \''+PlanIdentifier+'\'';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){
        List<SPE_SPEPlanSupplierMap__c>  insupplist = new List<SPE_SPEPlanSupplierMap__c>();
        List<SPE_Respondent__c>  inconlist = new List<SPE_Respondent__c>();
        List<SPE_Spend__c> supplist = new List<SPE_Spend__c>();
        List<SPE_CategoryInfo__c> respondentlist = new List<SPE_CategoryInfo__c>();
        Set<ID> acclist = new Set<ID>();
        ID suppId;
        String speregion;
        String spesubregion;
        String specountry;
        String speproject;
        String specatArea;
        String specatGroup;
        String specat;
        String speBuUnit;
        String speBuLine;
        String speproduct;
        for(SObject obj:scope){
            SPE_SPEPlan__c spdata = (SPE_SPEPlan__c)obj;
            
            suppId = spdata.ID;
            speregion = spdata.Region__c;
            spesubregion = spdata.SubRegion__c;
            specountry = spdata.Country__c;
            speproject = spdata.Project__c;
            specatArea = spdata.CategoryCluster__c;
            specatGroup = spdata.CategoryGroup__c;
            specat = spdata.Category__c;
            speBuUnit = spdata.BusinessUnit__c;
            speBuLine = spdata.BusinessLine__c;
            speproduct = spdata.Product__c;
                                                                   
        }
        
        supplist = [Select Id,EnterpriseId__c,Period__c from SPE_Spend__c where EnterpriseId__c != Null
                        AND Region__c =: speregion AND Sub_Region__c =: spesubregion AND Country__c =: specountry AND Project__c =: speproject
                        AND CategoryArea__c =: specatArea AND CategoryGroup__c =: specatGroup AND Category__c =: specat
                        AND Business_Unit__c =: speBuUnit AND Business_Line__c =: speBuLine AND Product__c =: speproduct
                        AND Period__c >= :System.Today().addMonths(-4)];
            
        for(SPE_Spend__c sp:supplist){
            SPE_SPEPlanSupplierMap__c objSSM = new SPE_SPEPlanSupplierMap__c();
            objSSM.Supplier__c = sp.EnterpriseId__c;
            objSSM.SPEPlan__c= suppId;
            insupplist.add(objSSM);
            acclist.add(sp.EnterpriseId__c); 
        }
        
        respondentlist = [Select Id,Supplier__c,Contact__c from SPE_CategoryInfo__c where Supplier__c IN:acclist
                          AND Region__c =: speregion AND SubRegion__c =: spesubregion AND Country__c =: specountry AND Project__c =: speproject
                          AND CategoryCluster__c =: specatArea AND CategoryGroup__c =: specatGroup AND Category__c =: specat
                          AND BusinessUnit__c =: speBuUnit AND BusinessLine__c =: speBuLine AND Product__c =: speproduct];
        
          
        for(SPE_CategoryInfo__c catinfo:respondentlist){
            SPE_Respondent__c objCon = new SPE_Respondent__c();
            objCon.Contact__c = catinfo.Contact__c;
            objCon.SPEPlan__c = suppId;
            inconlist.add(objCon);
        }
                           
        try{
            insert insupplist;
            insert inconlist;
        }catch(Exception e){}
                
    }
    
    global void finish(Database.BatchableContext BC){
    }
}