global class SPE_VolumeCalculateBatch implements Database.Batchable<sObject>{
    global String query;
    global List<SPE_SPETracker__c> speTrackerList;
    global String aggrType;
    global Map<String,List<decimal>> speTrackerToWeigtage = new Map<String,List<decimal>>();
    global Map<String,decimal> trackerToWeightageSum;
    global Id ParamId;
    global Date startrangeDate;
    global Date endRangeDate;
    //global Set<String> spetrackers = new Set<String>();
    global SPE_VolumeCalculateBatch(String reportparamId){
        paramId = reportparamId;
        query = 'SELECT Period_Text__c,Score__c,Period__c,SPE_Report_Parameter__c,SPE_Tracker__c,SPE_Tracker__r.BusinessLine__c,SPE_Tracker__r.BusinessUnit__c,SPE_Tracker__r.Product__c,SPE_Tracker__r.Category__c,SPE_Tracker__r.CategoryGroup__c,SPE_Tracker__r.CategoryCluster__c,SPE_Tracker__r.Project__c,SPE_Tracker__r.Region__c,SPE_Tracker__r.SubRegion__c,SPE_Tracker__r.Country__c,Supplier__c,Tracker_Score__c,Weight__c FROM SPE_Scorecard_Report__c WHERE SPE_Report_Parameter__c ='+'\''+ParamId+'\''; 
        
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
            List<AggregateResult> volList = new List<AggregateResult>();
            //SPE_Scorecard_Report__c sReport = new SPE_Scorecard_Report__c();
            String volSoql = 'Select SUM(Volume__c) total FROM SPE_Volume__c where EnterpriseID__c = '+'\''+rObj.supplier__c+'\'';
            if(reportConfig.Product_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessLine__c!='All Business Lines'){
                    volSoql +=' where ' + 'Business_Line__c='+'\''+rObj.SPE_Tracker__r.BusinessLine__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessLine__c!='All Business Lines'){
                    volSoql +=' AND' + ' Business_Line__c='+'\''+rObj.SPE_Tracker__r.BusinessLine__c+'\'';
                } 
            }
            //-----Business line ends----
            if(reportConfig.Market_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Region__c!='All Markets'){
                    volSoql +=' where ' + 'Region__c='+'\''+rObj.SPE_Tracker__r.Region__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessLine__c!='All Markets'){
                    volSoql +=' AND' + ' Region__c='+'\''+rObj.SPE_Tracker__r.Region__c+'\'';
                } 
            }
            //------Market Ends-----
            if(reportConfig.Market_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.SubRegion__c!='All Market Units'){
                    volSoql +=' where ' + 'SubRegion__c='+'\''+rObj.SPE_Tracker__r.SubRegion__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.SubRegion__c!='All Market Units'){
                    volSoql +=' AND' + ' SubRegion__c='+'\''+rObj.SPE_Tracker__r.SubRegion__c+'\'';
                } 
            }
            //-----Market Unit ends------
            
            if(reportConfig.Market_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Country__c!='All Countries'){
                    volSoql +=' where ' + 'Country__c='+'\''+rObj.SPE_Tracker__r.Country__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Country__c!='All Countries'){
                    volSoql +=' AND' + ' Country__c='+'\''+rObj.SPE_Tracker__r.Country__c+'\'';
                } 
            }
            //-----Country Ends-----
            if(reportConfig.Market_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Project__c!='All Projects'){
                    volSoql +=' where ' + 'Project__c='+'\''+rObj.SPE_Tracker__r.Project__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Project__c!='All Projects'){
                    volSoql +=' AND' + ' Project__c='+'\''+rObj.SPE_Tracker__r.Project__c+'\'';
                } 
            }
            //----- Project Ends-----
            if(reportConfig.Product_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessUnit__c!='All Business Units'){
                    volSoql +=' where ' + 'Business_Unit__c='+'\''+rObj.SPE_Tracker__r.BusinessUnit__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.BusinessUnit__c!='All Business Units'){
                    volSoql +=' AND' + ' Business_Unit__c='+'\''+rObj.SPE_Tracker__r.BusinessUnit__c+'\'';
                } 
            }
            //------Business Unit ends-----
            if(reportConfig.Product_Filter_For_Volume__c){
                if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Product__c!='All Products'){
                    volSoql +=' where ' + 'Product__c='+'\''+rObj.SPE_Tracker__r.Product__c+'\'';
                }
                else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Product__c!='All Products'){
                    volSoql +=' AND' + ' Product__c='+'\''+rObj.SPE_Tracker__r.Product__c+'\'';
                } 
            }
            //------Product Ends----
            
             if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Category__c!='All Categories'){
                volSoql +=' where ' + 'Category__c='+'\''+rObj.SPE_Tracker__r.Category__c+'\'';
            }
            else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.Category__c!='All Categories'){
                volSoql +=' AND' + ' Category__c='+'\''+rObj.SPE_Tracker__r.Category__c+'\'';
            } 
            
            //--------Category Ends-----
            
             if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryGroup__c!='All Category Groups'){
                volSoql +=' where ' + 'Category_Group__c='+'\''+rObj.SPE_Tracker__r.CategoryGroup__c+'\'';
            }
            else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryGroup__c!='All Category Groups'){
                volSoql +=' AND' + ' Category_Group__c='+'\''+rObj.SPE_Tracker__r.CategoryGroup__c+'\'';
            } 
            
            //----------Category Group Ends-----
            
            if(!volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryCluster__c!='All Category Areas'){
                volSoql +=' where ' + 'CategoryCluster__c='+'\''+rObj.SPE_Tracker__r.CategoryCluster__c+'\'';
            }
            else if(volSoql.contains( ' where ' ) && rObj.SPE_Tracker__r.CategoryCluster__c!='All Category Areas'){
                volSoql +=' AND' + ' CategoryCluster__c='+'\''+rObj.SPE_Tracker__r.CategoryCluster__c+'\'';
            } 
            
            //------Category Area ends----
            
             if(!volSoql.contains( ' where' ) ){ 
            volSoql += ' where '+' Period__c >='+string.valueOf(startrangeDate) + ' AND Period__c <='+string.valueOf(endRangeDate);
             }
             else if(volSoql.contains( ' where' )){
          //query += ' AND'+' Supplier__c!=null';
              volSoql += ' AND'+' Period__c >='+string.valueOf(startrangeDate) + ' AND Period__c <='+string.valueOf(endRangeDate);
             } 
            system.debug('volSoql::'+volSoql);
            volList = database.query(volSoql);
                                           
            if(volList.size() > 0){
                trackerToWeightage.put(rObj.SPE_Tracker__c,(decimal)volList[0].get('total'));
            }    
            rObj.Weight__c = (decimal)volList[0].get('total');
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