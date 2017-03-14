global class SPE_SpendHybridLogicCalcBatch implements Database.Batchable<sObject>{
    global String query;
    global List<SPE_SPETracker__c> speTrackerList;
    global String aggrType;
    global Map<String,List<decimal>> speTrackerToWeigtage = new Map<String,List<decimal>>();
    global Map<String,decimal> trackerToWeightageSum;
    global Id ParamId;
    global Date startrangeDate;
    global Date endRangeDate;
    global String negoResParam;
    //global Set<String> spetrackers = new Set<String>();
    global SPE_SpendHybridLogicCalcBatch (String reportparamId, String negoResponsible){
        paramId = reportparamId;
        negoResParam = negoResponsible;
        query = 'SELECT Period_Text__c,Score__c,SPE_Report_Parameter__c,Business_Line__c ,Business_Unit__c,Product__c,Category__c,Category_Group__c ,Category_Area__c ,Project__c,Market__c,Market_Unit__c,Country__c,Supplier__c,Weight__c FROM SPE_Scorecard_Report__c WHERE SPE_Report_Parameter__c ='+'\''+ParamId+'\''; 
        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator(query);        
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){ 
        Integer monthVal;
        Integer yearVal;
        Integer noOfDays;
        Map<String,decimal> trackerToWeightage = new Map<String,decimal>();
        List<String> periodVals = new List<String>();
        Map<String,Integer> monthMap = new Map<String,Integer>();
        monthMap.put('January',01);
        monthMap.put('February',02);
        monthMap.put('March',03);
        monthMap.put('April',04);
        monthMap.put('May',05);
        monthMap.put('June',06);
        monthMap.put('July',07);
        monthMap.put('August',08);
        monthMap.put('September',09);
        monthMap.put('October',10);
        monthMap.put('November',11);
        monthMap.put('December',12);
        system.debug('enter at hybridBatch::'+negoResParam+'****'+paramId);
        SPE_Report_Configs__c reportConfig = SPE_Report_Configs__c.getInstance('Filter for Spend and Volume');
        List <SPE_Scorecard_Report__c> sReportList = new list<SPE_Scorecard_Report__c>();
        for(sobject obj :scope){
            SPE_Scorecard_Report__c rObj = (SPE_Scorecard_Report__c)obj;
            periodVals = rObj.Period_Text__c.replace(' ','').split('-');
            monthVal = monthMap.get(periodVals[0]); 
            yearVal = integer.valueOf(periodVals[1]);
            
            noOfDays = date.daysInMonth(yearVal,monthVal);
            startrangeDate = date.newInstance(yearVal,monthVal,1);
            endRangeDate = date.newInstance(yearVal,monthVal,noOfDays);
            List<AggregateResult> spendList = new List<AggregateResult>();
            //SPE_Scorecard_Report__c sReport = new SPE_Scorecard_Report__c();
            String spendSoql = 'Select SUM(Spend__c) total FROM SPE_Spend__c where EnterpriseId__c = '+'\''+rObj.supplier__c+'\'';
            if(reportConfig.Product_Filter_For_Spend__c){
                if(!spendSoql.contains( ' where ' ) && rObj.Business_Line__c !='All Business Lines'){
                    spendSoql +=' where ' + 'Business_Line__c='+'\''+rObj.Business_Line__c+'\'';
                }
                else if(spendSoql.contains( ' where ' ) && rObj.Business_Line__c !='All Business Lines'){
                    spendSoql +=' AND' + ' Business_Line__c='+'\''+rObj.Business_Line__c+'\'';
                } 
            }
            //-----Business line ends----
            
            if(!spendSoql.contains( ' where ' ) && rObj.Market__c!='All Markets'){
                spendSoql +=' where ' + 'Region__c='+'\''+rObj.Market__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Market__c!='All Markets'){
                spendSoql +=' AND' + ' Region__c='+'\''+rObj.Market__c+'\'';
            } 
            
            //------Market Ends-----
            
            if(!spendSoql.contains( ' where ' ) && rObj.Market_Unit__c!='All Market Units'){
                spendSoql +=' where ' + 'Sub_Region__c='+'\''+rObj.Market_Unit__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Market_Unit__c!='All Market Units'){
                spendSoql +=' AND' + ' Sub_Region__c='+'\''+rObj.Market_Unit__c+'\'';
            } 
            
            //-----Market Unit ends------
            
            
            if(!spendSoql.contains( ' where ' ) && rObj.Country__c!='All Countries'){
                spendSoql +=' where ' + 'Country__c='+'\''+rObj.Country__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Country__c!='All Countries'){
                spendSoql +=' AND' + ' Country__c='+'\''+rObj.Country__c+'\'';
            } 
            
            //-----Country Ends-----
            
             if(!spendSoql.contains( ' where ' ) && rObj.Project__c!='All Projects'){
                spendSoql +=' where ' + 'Project__c='+'\''+rObj.Project__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Project__c!='All Projects'){
                spendSoql +=' AND' + ' Project__c='+'\''+rObj.Project__c+'\'';
            } 
            
            //----- Project Ends-----
            if(reportConfig.Product_Filter_For_Spend__c){
                if(!spendSoql.contains( ' where ' ) && rObj.Business_Unit__c!='All Business Units'){
                    spendSoql +=' where ' + 'Business_Unit__c='+'\''+rObj.Business_Unit__c+'\'';
                }
                else if(spendSoql.contains( ' where ' ) && rObj.Business_Unit__c!='All Business Units'){
                    spendSoql +=' AND' + ' Business_Unit__c='+'\''+rObj.Business_Unit__c+'\'';
                } 
            }
            //------Business Unit ends-----
            if(reportConfig.Product_Filter_For_Spend__c){
                if(!spendSoql.contains( ' where ' ) && rObj.Product__c!='All Products'){
                    spendSoql +=' where ' + 'Product__c='+'\''+rObj.Product__c+'\'';
                }
                else if(spendSoql.contains( ' where ' ) && rObj.Product__c!='All Products'){
                    spendSoql +=' AND' + ' Product__c='+'\''+rObj.Product__c+'\'';
                } 
            }
            //------Product Ends----
            
             if(!spendSoql.contains( ' where ' ) && rObj.Category__c!='All Categories'){
                spendSoql +=' where ' + 'Category__c='+'\''+rObj.Category__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Category__c!='All Categories'){
                spendSoql +=' AND' + ' Category__c='+'\''+rObj.Category__c+'\'';
            } 
            
            //--------Category Ends-----
            
             if(!spendSoql.contains( ' where ' ) && rObj.Category_Group__c!='All Category Groups'){
                spendSoql +=' where ' + 'CategoryGroup__c='+'\''+rObj.Category_Group__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Category_Group__c!='All Category Groups'){
                spendSoql +=' AND' + ' CategoryGroup__c='+'\''+rObj.Category_Group__c+'\'';
            } 
            
            //----------Category Group Ends-----
            
            if(!spendSoql.contains( ' where ' ) && rObj.Category_Area__c !='All Category Areas'){
                spendSoql +=' where ' + 'CategoryArea__c='+'\''+rObj.Category_Area__c +'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.Category_Area__c !='All Category Areas'){
                spendSoql +=' AND' + ' CategoryArea__c='+'\''+rObj.Category_Area__c +'\'';
            } 
            
            //------Category Area ends----
            if(!spendSoql.contains( ' where ' ) ){ 
                spendSoql += ' where '+'Period__c >='+string.valueOf(startrangeDate) + ' AND Period__c <='+string.valueOf(endRangeDate);
            }
            else if(spendSoql.contains( ' where ' )){
              spendSoql += ' AND'+' Period__c >='+string.valueOf(startrangeDate) + ' AND Period__c <='+string.valueOf(endRangeDate);
            }
            // ------ nego responsible check ----
            if(!spendSoql.contains( ' where ' ) ){ 
                spendSoql += ' where Nego_Responsible__c='+ '\''+negoResParam+'\'' ;
            }
            else if(spendSoql.contains( ' where ' )){
              spendSoql += ' AND Nego_Responsible__c='+ '\''+negoResParam+'\'';
            }
             
            system.debug('spendsoql::'+spendsoql);
            spendList = database.query(spendsoql);
                                           
                
            rObj.Weight__c = (decimal)spendList[0].get('total');
            sReportList.add(rObj);
        }
        update sReportList;
        
    }
    
    global void finish(Database.BatchableContext BC){
       
    }
}