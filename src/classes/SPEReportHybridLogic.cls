global class SPEReportHybridLogic{
    global List<AggregateResult> lstscorecardReport; 
    global String RepParam;
    global String negoResParam;
    global void hybridLogicCalc(String reportParamID, String negoResponsible){
        RepParam = reportParamID;
        negoResParam = negoResponsible;
        List<spe_scorecard_report__c> lstScorecardtoInsert = new List<spe_scorecard_report__C>();
        List<spe_scorecard_report__c> lstScorecardtoDelete = new List<spe_scorecard_report__C>();
        lstscorecardReport = new List<AggregateResult>();
        for(AggregateResult ar:[select avg(Score__c) avgscore,supplier__c supp,spe_tracker__r.BusinessLine__c BL,spe_tracker__r.BusinessUnit__c BU,
                                spe_tracker__r.Category__c Cat,spe_tracker__r.CategoryCluster__c CatArea,spe_tracker__r.CategoryGroup__c CGroup,
                                spe_tracker__r.Region__c Mkt,spe_tracker__r.SubRegion__c subMkt,spe_tracker__r.Country__c Cntry,spe_tracker__r.Product__c Prod,
                                spe_tracker__r.Project__c Proj
                                from spe_scorecard_report__c
                                where spe_tracker__r.Project__c!='All Projects' AND SPE_Report_Parameter__c = :reportParamID
                                group by supplier__c,spe_tracker__r.BusinessLine__c,spe_tracker__r.BusinessUnit__c,
                                spe_tracker__r.Category__c,spe_tracker__r.CategoryCluster__c,spe_tracker__r.CategoryGroup__c,
                                spe_tracker__r.Region__c,spe_tracker__r.SubRegion__c,spe_tracker__r.Country__c,spe_tracker__r.Product__c,
                                spe_tracker__r.Project__c]){
                                
                                
            lstScorecardtoInsert.add(new spe_scorecard_report__c(
                                     Score__c = (decimal)ar.get('avgscore'),SPE_Report_Parameter__c = reportParamID,
                                     Supplier__c = (String)ar.get('supp'),Weight__c = 1,
                                     Business_Line__c = (String)ar.get('BL'),Business_Unit__c = (String)ar.get('BU'),
                                     Category__c = (String)ar.get('Cat'),Category_Area__c = (String)ar.get('CatArea'),
                                     Category_Group__c = (String)ar.get('CGroup'),Country__c = (String)ar.get('Cntry'),
                                     Market__c = (String)ar.get('Mkt'),Market_Unit__c = (String)ar.get('subMkt'),
                                     Product__c = (String)ar.get('Prod'),Project__c = (String)ar.get('Proj')                                                                         
                                     ));                        
        
                                    
        }
        
        if(lstScorecardtoInsert.size() > 0){
            insert lstScorecardtoInsert;
        }
        
        
        
        // delete all the records except all projects
        
        lstScorecardtoDelete = [Select Id from spe_scorecard_report__c
                                where spe_tracker__r.Project__c!='All Projects' 
                                AND SPE_Report_Parameter__c = :reportParamID]; 
        if(lstScorecardtoDelete.size()>0){
            delete lstScorecardtoDelete;
          }  
        
        // execute the batch class for spend calculation
        
        SPE_SpendHybridLogicCalcBatch hybridbatch = new SPE_SpendHybridLogicCalcBatch(RepParam,negoResponsible);
        Database.executeBatch(hybridbatch,90);
        
                                
    }
    
    

}