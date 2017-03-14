global class SPE_KPISchedulePrebatch3ExecAdhoc implements Database.Batchable <sObject> , Schedulable 
{
    global Id kpiIds;
    
    public SPE_KPISchedulePrebatch3ExecAdhoc (String s)
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
        String query='select id,KPI__c,KPI_Calculation__c from Supplier_KPI_Calculation_Adhoc__c where KPI__c =: kpiId';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <Supplier_KPI_Calculation_Adhoc__c> scope) 
    {
        
        SPE_KPICalculation__c cal = new SPE_KPICalculation__c();
        cal=[Select id,PIDefination__c,TimeFrame__c,ConstantValue__c,KPIDefinition__c,Aggregation__c,index__c from SPE_KPICalculation__c where id=:scope[0].KPI_Calculation__c];
        
        // New Design ..................
        String BUScope;
        String GEOScope;
        String CatScope;
    
        Map<String, String> fieldLabelAPIMaps = new Map<String, String> 
        {
            'Market' => 'Region__c',
            'Market Unit' => 'SubRegion__c',
            'Country' => 'Country__c',
            'Project' => 'Project__c',
            'Category Area' => 'Cluster__c',
            'Category Group' => 'CategoryGroup__c',
            'Category' => 'Category__c',
            'Business Unit' => 'BusinessUnit__c',
            'Business Line' => 'BusinessLine__c',
            'Product' => 'Product__c'
        };
    
        AggregateResult[]  results;
        SPE_KPIDefinition__c KPIDef = [SELECT geoscope__c,adhoc_date__c,SchedulePeriod__c,CategoryScope__c, BUScope__c
                                   FROM SPE_KPIDefinition__c WHERE id =: cal.KPIDefinition__c];
        
        Date d = Date.newInstance(1960, 2, 17);
        Date fromDate = Date.newInstance(1960, 2, 17);
        
        d=(KPIDef.Adhoc_Date__c).addMonths(-1);        
        // Calculation date Ranges
        Integer numberOfDays = Date.daysInMonth(d.year(), d.month());
        d= Date.newInstance(d.year(), d.month(), numberOfDays);
        fromDate = d.addmonths(-integer.ValueOf(cal.TimeFrame__c-1 ));
        fromDate = Date.newInstance(fromDate.year(), fromDate.month(), 1);
        
        system.debug('+++++++++++date'+d); 

        String filter = '';
    
        GEOScope = KPIDef.geoscope__c;
        CatScope = KPIDef.CategoryScope__c;
        BUScope = KPIDef.BUScope__c ;
            
        List<SPE_PITempValue__c> ToBeUpdatedPITempValue = new List<SPE_PITempValue__c>();
            
        String QueryString = '';
        Set<String> toBeDeletedTempIndex = new Set<String>();
        
        SPE_KPICalculation__c kpiCalculation =[SELECT id, ConstantValue__c, Aggregation__c, Index__c, TimeFrame__c, PIDefination__c, PrevKPIDefination__c,
                                                       SurveyQuestion__c, Filter1__c, Filter2__c, Filter3__c, Filter4__c, Filter5__c, Filter6__c, Filter7__c,
                                                       Filter8__c, Filter9__c, Filter10__c
                                                 FROM SPE_KPICalculation__c
                                                 WHERE id=: cal.Id]; 
    
        ID PIDefID = kpiCalculation.PIDefination__c;
        String Expression = kpiCalculation.Aggregation__c;
        QueryString = '';
        
        SPE_RegionMaster masterData = new SPE_RegionMaster(); //piyush
        
        String ExecPeriod=SPE_Utility.monthsMap.get((d).month()) + ' - '+ String.valueOf((d).year());                
        
        if (Expression != null && Expression != 'Constant' && PIDefID != null)
        {
            String PIType = [SELECT ValuesType__c FROM SPE_PIDefinition__c WHERE id =: PIDefID].ValuesType__c;
            String QueryFirstHalf = 'SELECT ';
            String QuerySecondHalf = 'GROUP BY ';
            String QueryMiddle = 'FROM SPE_PIValues__c WHERE PIDefination__c =: PIDefID AND Period__c >=:fromDate AND Period__c<=:d';
        
            if (GEOScope != null && GEOScope != PicklistDefaultValues__c.getall().values()[0].Market__c) //'All Marketes'
            {
                QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(GEOScope) + ' GeoScopes,';
                QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(GEOScope) + ',';
                QueryMiddle = QueryMiddle + ' AND ' + fieldLabelAPIMaps.get(GEOScope) + '!=Null';
            }
        
            if (BUScope != Null && BUScope != PicklistDefaultValues__c.getall().values()[0].Product__c) // 'All Products'
            { 
                QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(BUScope) + ' BUScopes,';
                QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(BUScope) +',';
                QueryMiddle = QueryMiddle + ' AND ' + fieldLabelAPIMaps.get(BUScope) + '!=Null';
            }
        
            if (CatScope != Null && CatScope != PicklistDefaultValues__c.getall().values()[0].Category__c ) // 'All Categories' 
            { 
                QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(CatScope) + ' CatScopes,';
                QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(CatScope) +',';
                QueryMiddle = QueryMiddle+' AND '+ fieldLabelAPIMaps.get(CatScope) + '!=Null';
            }  
                            
            if (kpiCalculation.Filter1__c != Null)
            {
                filter = kpiCalculation.Filter1__c;
                QueryMiddle = QueryMiddle+' AND Filter1__c = : filter';
            }
           
            if (kpiCalculation.Filter2__c != Null)
            {
                filter = kpiCalculation.Filter2__c; 
                QueryMiddle = QueryMiddle+' AND Filter2__c =: filter';
            }
          
            if (kpiCalculation.Filter3__c != Null)
            {
                filter = kpiCalculation.Filter3__c;
                QueryMiddle = QueryMiddle+' AND Filter3__c =: filter';
            }
          
            if (kpiCalculation.Filter4__c != Null)
            {
                filter = kpiCalculation.Filter4__c; 
                QueryMiddle = QueryMiddle+' AND Filter4__c =: filter';
            }
           
            if (kpiCalculation.Filter5__c != Null)
            {
                filter = kpiCalculation.Filter5__c;
                QueryMiddle = QueryMiddle+' AND Filter5__c =: filter';
            }
           
            if (kpiCalculation.Filter6__c != Null)
            {
                filter = kpiCalculation.Filter6__c;
                QueryMiddle = QueryMiddle+' AND Filter6__c =: filter';
            } 
            
            if (kpiCalculation.Filter7__c != Null)
            {
                filter = kpiCalculation.Filter7__c;  
                QueryMiddle = QueryMiddle+' AND Filter7__c =: filter';
            }
          
            if (kpiCalculation.Filter8__c != Null)
            {
                filter = kpiCalculation.Filter8__c;
                QueryMiddle = QueryMiddle+' AND Filter8__c =: filter';
            }
           
            if (kpiCalculation.Filter9__c != Null)
            {
                filter = kpiCalculation.Filter9__c; 
                QueryMiddle = QueryMiddle+' AND Filter9__c =: filter';
            }
           
            if (kpiCalculation.Filter10__c != Null)
            {
                filter = kpiCalculation.Filter10__c; 
                QueryMiddle = QueryMiddle+' AND Filter10__c =: filter';
            }               
                            
            if(Expression=='Min( Across Suppliers)')
            {
                Expression='Min';
            }
            if(Expression=='Max( Across Suppliers)')
            {
                Expression='Max';
            }
            if(Expression=='Avg( Across Suppliers)')
            {
                Expression='Avg';                  
            }
            
            if(QuerySecondHalf.endswith(','))
            {
                QuerySecondHalf=QuerySecondHalf.subStringBeforeLast(',');
            }
           
            if(QuerySecondHalf=='GROUP BY ')
            {
                QueryString = QueryFirstHalf + Expression + '(NumberValue__c) Quantity '+QueryMiddle;
            }
            else
            {
                QueryString = QueryFirstHalf + Expression + '(NumberValue__c) Quantity '+QueryMiddle+' '+ QuerySecondHalf;
            }
          
            for (AggregateResult ar : Database.query(QueryString))
            {
                SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
                piTempValue.ExecutionPeriod__c = ExecPeriod;
                piTempValue.PIValue__c = String.valueof(ar.get('Quantity'));
                piTempValue.Valuetype__c = 'Number';
                piTempValue.KPIDefinition__c = cal.KPIDefinition__c; 
                piTempValue.KPICalculation__c = cal.Id;
                piTempValue.IsConstant__c=true;
                piTempValue.Period__c = d;
                
                piTempValue = SPE_DefaultValueUtil.assignPITempValues(piTempValue);
             
                if (GEOScope != null && GEOScope != PicklistDefaultValues__c.getall().values()[0].Market__c) //'All Marketes'
                {  
                    if (GeoScope == 'Project')
                    {
                        piTempValue.Project__c = (String)ar.get('GeoScopes');
                 
                        if (masterData.projectCountryMap.get(piTempValue.Project__c) != null)
                        {
                            piTempValue.Country__c = masterData.projectCountryMap.get(piTempValue.Project__c);
                            piTempValue.SubRegion__c = masterData.countrySubregionMap.get(piTempValue.Country__c);
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                    }
                    
                    if (GeoScope == 'Country')
                    {
                        piTempValue.Country__c = (String)ar.get('GeoScopes');
                        if (masterData.countrySubregionMap.get(piTempValue.Country__c) != null)
                        {
                            piTempValue.SubRegion__c = masterData.countrySubregionMap.get(piTempValue.Country__c);
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                    }
                 
                    if (GeoScope == 'Market Unit')
                    {
                        piTempValue.SubRegion__c = (String)ar.get('GeoScopes');
                        if (masterData.subRegionRegionMap.get(piTempValue.SubRegion__c) != null)
                        {
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                    }
                 
                    if (GeoScope == 'Market')
                    {
                        piTempValue.Region__c = (String) ar.get('GeoScopes');
                    }
                }
                                                     
                if (BUScope != Null && BUScope != PicklistDefaultValues__c.getall().values()[0].Product__c) // 'All Products'
                {
                    if (BUScope == 'Business Unit')
                    {
                        piTempValue.BusinessUnit__c = (String)ar.get('BUScopes');
                    }
              
                    if (BUScope == 'Business Line')
                    {
                        piTempValue.BusinessLine__c = (String) ar.get('BUScopes');
                        if (masterData.BLBUMap.get(piTempValue.BusinessLine__c) != null)
                        {
                            piTempValue.BusinessUnit__c = masterData.BLBUMap.get(piTempValue.BusinessLine__c);
                        }
                    }    
                    if (BUScope == 'Product')
                    {
                        piTempValue.Product__c = (String) ar.get('BUScopes');
                        if (masterData.productBLMap.get(piTempValue.Product__c) != null)
                        {
                            piTempValue.BusinessLine__c = masterData.productBLMap.get(piTempValue.Product__c);
                            piTempValue.BusinessUnit__c = masterData.BLBUMap.get(piTempValue.BusinessLine__c);
                        }
                    }    
                }
                
                if (CatScope != Null && CatScope != PicklistDefaultValues__c.getall().values()[0].Category__c ) // 'All Categories'
                {
                    if (CatScope == 'Category Area' )
                    {
                        piTempValue.Cluster__c = (String) ar.get('CatScopes');
                    }
                    if (CatScope == 'Category Group')
                    {
                        piTempValue.CategoryGroup__c = (String) ar.get('CatScopes');
                        
                        if (masterData.grpClusterMap.get(piTempValue.CategoryGroup__c) != null)
                        {
                            piTempValue.Cluster__c = masterData.grpClusterMap.get(piTempValue.CategoryGroup__c);
                        }
                    }                           
                    if (CatScope == 'Category')
                    {
                        piTempValue.Category__c = (String) ar.get('CatScopes');
                        
                        if (masterData.categoryGrpMap.get(piTempValue.Category__c) != null)
                        {
                            piTempValue.CategoryGroup__c = masterData.categoryGrpMap.get(piTempValue.Category__c);
                            piTempValue.Cluster__c = masterData.grpClusterMap.get(piTempValue.CategoryGroup__c);
                        }
                    }
                }
                
                if (piTempValue.PIValue__c != null)
                {      
                    ToBeUpdatedPITempValue.add(piTempValue);
                }
            }       
        }
       
           
        if(tobeupdatedPITempValue.size()>0)
            insert ToBeUpdatedPITempValue;
        
        delete scope[0];
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        if(!test.isRunningTest())
        {
            SPE_KPISchedulebatch3Adhoc dtbatch= new SPE_KPISchedulebatch3Adhoc(kpiIds);
            database.executebatch(dtBatch,10000);
        }
    }
}