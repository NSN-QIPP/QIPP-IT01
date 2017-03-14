global class SPE_SpendCalculateBatch implements Database.Batchable<sObject>{
    global String query;
    global List<SPE_SPETracker__c> speTrackerList;
    global String aggrType;
    global Map<String,List<decimal>> speTrackerToWeigtage = new Map<String,List<decimal>>();
    global Map<String,decimal> trackerToWeightageSum;
    global Id ParamId;
    global Date startrangeDate;
    global Date endRangeDate;
    //global Set<String> spetrackers = new Set<String>();
    global SPE_SpendCalculateBatch(String reportparamId){
        paramId = reportparamId;
        query = 'SELECT Period_Text__c,Score__c,SPE_Report_Parameter__c,SPE_Tracker__c,Period__c,SPE_Tracker__r.BusinessLine__c,SPE_Tracker__r.BusinessUnit__c,SPE_Tracker__r.Product__c,SPE_Tracker__r.Category__c,SPE_Tracker__r.CategoryGroup__c,SPE_Tracker__r.CategoryCluster__c,SPE_Tracker__r.Project__c,SPE_Tracker__r.Region__c,SPE_Tracker__r.SubRegion__c,SPE_Tracker__r.Country__c,SPE_Tracker__r.DateofExecution__c,Supplier__c,Tracker_Score__c,Weight__c FROM SPE_Scorecard_Report__c WHERE SPE_Report_Parameter__c ='+'\''+ParamId+'\''; 
        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator(query);        
    }
    
    global void execute(Database.BatchableContext BC, List<sObject>scope){ 
        Integer monthVal;
        Integer yearVal;
        Integer noOfDays;
        Map<String,decimal> trackerToWeightage = new Map<String,decimal>();
        List <SPE_Scorecard_Report__c> sReportList = new list<SPE_Scorecard_Report__c>();
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
        
        SPE_Report_Configs__c reportConfig = SPE_Report_Configs__c.getInstance('Filter for Spend and Volume');
        for(sobject obj :scope){
            SPE_Scorecard_Report__c rObj = (SPE_Scorecard_Report__c)obj;
            periodVals = rObj.Period_Text__c.replace(' ','').split('-');
            monthVal = monthMap.get(periodVals[0]); 
            yearVal = integer.valueOf(periodVals[1]); 
            noOfDays = date.daysInMonth(yearVal,monthVal);
            startrangeDate = date.newInstance(yearVal,monthVal,1);
            endRangeDate = date.newInstance(yearVal,monthVal,noOfDays);
            
            system.debug('start date is'+startrangeDate);
            system.debug('end date is'+endRangeDate);

            List<AggregateResult> spendList = new List<AggregateResult>();
            //SPE_Scorecard_Report__c sReport = new SPE_Scorecard_Report__c();
            String spendSoql = 'Select SUM(Spend__c) total FROM SPE_Spend__c where EnterpriseId__c = '+'\''+rObj.supplier__c+'\'';
            if(reportConfig.Product_Filter_For_Spend__c){
                if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessLine__c!='All Business Lines'){
                    spendSoql +=' where ' + 'Business_Line__c='+'\''+rObj.SPE_Tracker__r.BusinessLine__c+'\'';
                }
                else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessLine__c!='All Business Lines'){
                    spendSoql +=' AND' + ' Business_Line__c='+'\''+rObj.SPE_Tracker__r.BusinessLine__c+'\'';
                } 
            }
            //-----Business line ends----
            
            if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Region__c!='All Markets'){
                spendSoql +=' where ' + 'Region__c='+'\''+rObj.SPE_Tracker__r.Region__c+'\'' + ' And Nego_Responsible__c='+ '\''+'R'+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Region__c!='All Markets'){
                spendSoql +=' AND' + ' Region__c='+'\''+rObj.SPE_Tracker__r.Region__c+'\'' + ' And Nego_Responsible__c='+ '\''+'R'+'\'';
            } 
            
            //------Market Ends-----
            
            if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.SubRegion__c!='All Market Units'){
                spendSoql +=' where ' + 'Sub_Region__c='+'\''+rObj.SPE_Tracker__r.SubRegion__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.SubRegion__c!='All Market Units'){
                spendSoql +=' AND' + ' Sub_Region__c='+'\''+rObj.SPE_Tracker__r.SubRegion__c+'\'';
            } 
            
            //-----Market Unit ends------
            
            
            if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Country__c!='All Countries'){
                spendSoql +=' where ' + 'Country__c='+'\''+rObj.SPE_Tracker__r.Country__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Country__c!='All Countries'){
                spendSoql +=' AND' + ' Country__c='+'\''+rObj.SPE_Tracker__r.Country__c+'\'';
            } 
            
            //-----Country Ends-----
            
             if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Project__c!='All Projects'){
                spendSoql +=' where ' + 'Project__c='+'\''+rObj.SPE_Tracker__r.Project__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Project__c!='All Projects'){
                spendSoql +=' AND' + ' Project__c='+'\''+rObj.SPE_Tracker__r.Project__c+'\'';
            } 
            
            //----- Project Ends-----
            if(reportConfig.Product_Filter_For_Spend__c){
                if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessUnit__c!='All Business Units'){
                    spendSoql +=' where ' + 'Business_Unit__c='+'\''+rObj.SPE_Tracker__r.BusinessUnit__c+'\'';
                }
                else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessUnit__c!='All Business Units'){
                    spendSoql +=' AND' + ' Business_Unit__c='+'\''+rObj.SPE_Tracker__r.BusinessUnit__c+'\'';
                } 
            }
            //------Business Unit ends-----
            if(reportConfig.Product_Filter_For_Spend__c){
                if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Product__c!='All Products'){
                    spendSoql +=' where ' + 'Product__c='+'\''+rObj.SPE_Tracker__r.Product__c+'\'';
                }
                else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Product__c!='All Products'){
                    spendSoql +=' AND' + ' Product__c='+'\''+rObj.SPE_Tracker__r.Product__c+'\'';
                } 
            }
            //------Product Ends----
            
             if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Category__c!='All Categories'){
                spendSoql +=' where ' + 'Category__c='+'\''+rObj.SPE_Tracker__r.Category__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Category__c!='All Categories'){
                spendSoql +=' AND' + ' Category__c='+'\''+rObj.SPE_Tracker__r.Category__c+'\'';
            } 
            
            //--------Category Ends-----
            
             if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryGroup__c!='All Category Groups'){
                spendSoql +=' where ' + 'CategoryGroup__c='+'\''+rObj.SPE_Tracker__r.CategoryGroup__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryGroup__c!='All Category Groups'){
                spendSoql +=' AND' + ' CategoryGroup__c='+'\''+rObj.SPE_Tracker__r.CategoryGroup__c+'\'';
            } 
            
            //----------Category Group Ends-----
            
            if(!spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryCluster__c!='All Category Areas'){
                spendSoql +=' where ' + 'CategoryArea__c='+'\''+rObj.SPE_Tracker__r.CategoryCluster__c+'\'';
            }
            else if(spendSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryCluster__c!='All Category Areas'){
                spendSoql +=' AND' + ' CategoryArea__c='+'\''+rObj.SPE_Tracker__r.CategoryCluster__c+'\'';
            } 
            
            //------Category Area ends----
          /**   if(!query.contains( ' where' )){ 
                query += ' where '+' Period__c>='+startrangeDate+ ' AND Period__c <='+endRangeDate;
                 }
             else if(query.contains( ' where' )){
                  //query += ' AND'+' Supplier__c!=null';
                  query += ' AND'+' Period__c >='+startrangeDate+ ' AND Period__c <='+endRangeDate;
             } 
          **/
          
          if(!spendSoql.contains( ' where' ) ){ 
            spendSoql += ' where '+' Period__c >='+string.valueOf(startrangeDate) + ' AND Period__c <='+string.valueOf(endRangeDate);
             }
         else if(spendSoql.contains( ' where' )){
          //query += ' AND'+' Supplier__c!=null';
          spendSoql += ' AND'+' Period__c >='+string.valueOf(startrangeDate) + ' AND Period__c <='+string.valueOf(endRangeDate);
         } 
       
            system.debug('spendsoql::'+spendsoql);
            spendList = database.query(spendsoql);
                                           
            if(spendList.size() > 0){
                trackerToWeightage.put(rObj.SPE_Tracker__c,(decimal)spendList[0].get('total'));
            }    
            rObj.Weight__c = (decimal)spendList[0].get('total');
            sReportList.add(rObj);
        }
        update sReportList;
        System.debug('ANVCD**'+trackerToWeightage);
    }
    
    global void finish(Database.BatchableContext BC){
       //SPE_ScorecardReportupdateFinalBatch finalbatch = new SPE_ScorecardReportupdateFinalBatch(trackerToWeightageSum,ParamId);
       //database.executeBatch(finalbatch,100);
    }
}