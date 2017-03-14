global class SPE_KPIScheduleFinalbatchAdhoc implements Database.Batchable <sObject> , Schedulable 
{
    global Id kpiIds;
    
    public SPE_KPIScheduleFinalbatchAdhoc (String s)
    {
        kpiIds = s;
    }
    
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,2000);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        String query='select id,enterpriseId__c from account where parentid=Null';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List <Account> scope) 
    {
        Supplier_KPI_Calculation_adhoc__c cc = [select id,KPI__c,KPI_Calculation__c from Supplier_KPI_Calculation_adhoc__c WHERE KPI__c=:kpiIds order By createdDate limit 1 ];
        SPE_KPICalculation__c cal = new SPE_KPICalculation__c();
        cal=[Select id,PIDefination__c,TimeFrame__c,ConstantValue__c,KPIDefinition__c,Aggregation__c,index__c from SPE_KPICalculation__c where id=:cc.KPI_Calculation__c];
        
        //******************Changes for Encryption******************//
        set<string> eId= new set<string>();
        set<ID> ed= new set<ID>();
        
        for(Account k:scope)
        {
            eid.add(k.enterpriseId__c);
            ed.add(k.ID);
        } 
        //*********************END*****************//
        
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
        AggregateResult[]  results1;
        SPE_KPIDefinition__c KPIDef = [SELECT geoscope__c,Adhoc_date__c,CategoryScope__c, BUScope__c
                                       FROM SPE_KPIDefinition__c WHERE id =: cal.KPIDefinition__c];
        
        Date d = Date.newInstance(1960, 2, 17);
        Date fromDate = Date.newInstance(1960, 2, 17);
        
        
        d=(KPIDef.Adhoc_Date__c).addMonths(-1);        
        // Calculation date Ranges
        Integer numberOfDays = Date.daysInMonth(d.year(), d.month());
        d= Date.newInstance(d.year(), d.month(), numberOfDays);
        fromDate = d.addmonths(-integer.ValueOf(cal.TimeFrame__c-1 ));
        fromDate = Date.newInstance(fromDate.year(), fromDate.month(), 1);
        system.debug('fromDate :::'+fromDate);
        system.debug('D12345 :::'+d);
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
        ID PrevKPiID = kpiCalculation.PrevKPIDefination__c;
        ID QuestionID = kpiCalculation.SurveyQuestion__c;
        String Expression = kpiCalculation.Aggregation__c;
        QueryString = '';
        
        SPE_RegionMaster masterData = new SPE_RegionMaster(); //piyush
        
        String ExecPeriod=SPE_Utility.monthsMap.get((d).month()) + ' - '+ String.valueOf((d).year());                
        
        // Survey Comments //
        String surveyCommentsQueryFirstPart = 'SELECT SurveyComments__c, Respondent__c, Respondent__r.Name, EnterpriseID__c, EnterpriseIDEncrypted__c ';
        String surveyCommentsQuerySecondPart =''; 
        
        List<SPE_KPIComments__c> toBeInsertedKPiComments = new List<SPE_KPIComments__c>();
        // Survey Comments //
        
        if (Expression != null && Expression != SPE_Constants.CONSTANTVALUE && PIDefID != null)
        {
            String PIType = [SELECT ValuesType__c FROM SPE_PIDefinition__c WHERE id =: PIDefID].ValuesType__c;
            String QueryFirstHalf = 'SELECT ';
            String QuerySecondHalf = 'GROUP BY ';
            
            //*******************Changes For Encryption*******************//
            //String QueryMiddle = 'FROM SPE_PIValues__c WHERE PIDefination__c =: PIDefID AND Period__c >=:fromDate AND Period__c<=:d AND enterpriseId__c IN:eId';
            String QueryMiddle = 'FROM SPE_PIValues__c WHERE PIDefination__c =: PIDefID AND Period__c >=:fromDate AND Period__c<=:d AND EnterpriseIDEncrypted__c IN:ed';
            //**********************END********************//
            
            if (GEOScope != null && GEOScope != PicklistDefaultValues__c.getall().values()[0].Market__c) //'All Marketes'
            {
                if(GEOScope== SPE_Constants.PRJ_GEOSCOPE) 
                {
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(GEOScope) + ' GeoScopes,';
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get('Country') + ' GeoScopes1,';
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get('Market Unit') + ' GeoScopes2,';
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get('Market') + ' GeoScopes3,';
                 
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(GEOScope) + ',';
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get('Country') + ',';
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get('Market Unit') + ',';
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get('Market') + ',';
                 
                    QueryMiddle = QueryMiddle + ' AND ' + fieldLabelAPIMaps.get(GEOScope) + '!=Null';
                }
                if(GEOScope== SPE_Constants.COUNTRY_GEOSCOPE ) 
                {
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(GEOScope) + ' GeoScopes,';
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get('Market Unit') + ' GeoScopes2,';
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get('Market') + ' GeoScopes3,';
                    
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(GEOScope) + ',';
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get('Market Unit') + ',';
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get('Market') + ',';
                    
                    QueryMiddle = QueryMiddle + ' AND ' + fieldLabelAPIMaps.get(GEOScope) + '!=Null';
                }
                if(GEOScope== SPE_Constants.MU_GEOSCOPE ) 
                {
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(GEOScope) + ' GeoScopes,';
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get('Market') + ' GeoScopes3,';
                    
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(GEOScope) + ',';
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get('Market') + ',';
                    
                    QueryMiddle = QueryMiddle + ' AND ' + fieldLabelAPIMaps.get(GEOScope) + '!=Null';
                }
                if(GEOScope== SPE_Constants.MARKET_GEOSCOPE ) 
                {
                    QueryFirstHalf = QueryFirstHalf + fieldLabelAPIMaps.get(GEOScope) + ' GeoScopes,';
                    
                    QuerySecondHalf = QuerySecondHalf + fieldLabelAPIMaps.get(GEOScope) + ',';
                    
                    QueryMiddle = QueryMiddle + ' AND ' + fieldLabelAPIMaps.get(GEOScope) + '!=Null';
                }
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
            
            //****************Changes For Encryption**************//                
            if (PIType == SPE_Constants.PI_NUMBERVALUETYPE)
            {
                //QueryString = QueryFirstHalf + Expression + '(NumberValue__c) Quantity, EnterpriseID__c EID '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseID__c';
                QueryString = QueryFirstHalf + Expression + '(NumberValue__c) Quantity,EnterpriseIDEncrypted__c ED '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseIDEncrypted__c';
            }                 
            if (PIType == SPE_Constants.PI_STRINGVALUETYPE)
            {
                //QueryString = QueryFirstHalf + Expression + '(StringValue__c) Quantity,EnterpriseID__c EID '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseID__c';
                QueryString = QueryFirstHalf + Expression + '(StringValue__c) Quantity,EnterpriseIDEncrypted__c ED '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseIDEncrypted__c';
                PIType = SPE_Constants.PI_NUMBERVALUETYPE;
            }
            if (PIType == SPE_Constants.PI_BOOLEANVALUETYPE)
            {
                //QueryString = QueryFirstHalf + Expression + '(Id) Quantity,EnterpriseID__c EID '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseID__c';
                QueryString = QueryFirstHalf + Expression + '(Id) Quantity,EnterpriseIDEncrypted__c ED '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseIDEncrypted__c';
                PIType = SPE_Constants.PI_NUMBERVALUETYPE;
            }
            if (PIType == SPE_Constants.PI_DATEVALUETYPE)
            {
                //QueryString = QueryFirstHalf + Expression + '(DateValue__c) Quantity,EnterpriseID__c EID '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseID__c';
                QueryString = QueryFirstHalf + Expression + '(DateValue__c) Quantity,EnterpriseIDEncrypted__c ED '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseIDEncrypted__c';
            }                           
        
            if (Expression == SPE_Constants.KPICALC_MINAGGREGATION  || Expression == SPE_Constants.KPICALC_MAXAGGREGATION || Expression == SPE_Constants.KPICALC_COUNTAGGREGATION)
            {
                PIType = SPE_Constants.PI_NUMBERVALUETYPE;
            }
            //*********************END************************//
            
            //Survey Comments //
            surveyCommentsQuerySecondPart = QueryMiddle;
            String surveyCommentsQueryThirdPart = ' AND SurveyComments__c != NULL';
          String surveyQuery = surveyCommentsQueryFirstPart + surveyCommentsQuerySecondPart + surveyCommentsQueryThirdPart;
          system.debug('surveyQuery:::'+surveyQuery);
          Map<String, String> enterpriseIdCommentsMap = new Map<String, String>();
          for (SPE_PIValues__c pi : Database.query(surveyQuery))
          
          {
            String comments = ''; 
            if(enterpriseIdCommentsMap.get(pi.EnterpriseIDEncrypted__c) != null)
            {
              comments = enterpriseIdCommentsMap.get(pi.EnterpriseIDEncrypted__c);
            }
            
            String response = '@' +pi.Respondent__r.Name + ': ' + pi.SurveyComments__c;
            
            comments = comments == '' ? response : comments + ' | ' + response;
            
            comments = comments.left(32000);
            
            enterpriseIdCommentsMap.put(pi.EnterpriseIDEncrypted__c, comments);
          }
          
          for (String s : enterpriseIdCommentsMap.keySet())
          {
            SPE_KPIComments__c kpiComm = new SPE_KPIComments__c();
            kpiComm.KPI__c = kpiIds; 
            kpiComm.EnterpriseId__c = s;
            kpiComm.ExecutionPeriod__c = ExecPeriod;
            kpiComm.SurveyComments__c = enterpriseIdCommentsMap.get(s);
            toBeInsertedKPiComments.add(kpiComm);
            
          }
            //Survey Comments  //
        
             //results = ;
            System.debug('====>'+QueryString);
            results1 = Database.query(QueryString);
            for (AggregateResult ar : results1)
            {
                SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
                piTempValue.ExecutionPeriod__c = ExecPeriod;
                piTempValue.PIValue__c = String.valueof(ar.get('Quantity'));
                piTempValue.Valuetype__c = PIType;
                piTempValue.KPIDefinition__c = cal.KPIDefinition__c; 
                piTempValue.KPICalculation__c = cal.Id;
                
                //***************Changes For Encryption*************//
                //piTempValue.enterpriseId__c = (String) ar.get('EID');
                piTempValue.EnterpriseIDEncrypted__c = (ID) ar.get('ED');
                //*******************END*****************//
                
                piTempValue.Period__c = d;
                
                piTempValue = SPE_DefaultValueUtil.assignPITempValues(piTempValue);
                system.debug('********PitempValue'+piTempValue ); 
                if (GEOScope != null && GEOScope != PicklistDefaultValues__c.getall().values()[0].Market__c) //'All Marketes'
                {  
                
                    if (GeoScope == SPE_Constants.PRJ_GEOSCOPE)
                    {
                        piTempValue.Project__c = (String)ar.get('GeoScopes');
                        piTempValue.Country__c=String.valueof(ar.get('GeoScopes1'));
                        piTempValue.SubRegion__c=String.valueof(ar.get('GeoScopes2'));
                        piTempValue.Region__c=String.valueof(ar.get('GeoScopes3'));
                        /*if (masterData.projectCountryMap.get(piTempValue.Project__c) != null)
                        {
                            piTempValue.Country__c = masterData.projectCountryMap.get(piTempValue.Project__c);
                            piTempValue.SubRegion__c = masterData.countrySubregionMap.get(piTempValue.Country__c);
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }*/
                    }
                 
                  
                    if (GeoScope == SPE_Constants.COUNTRY_GEOSCOPE)
                    {
                        piTempValue.Country__c = (String)ar.get('GeoScopes');
                        piTempValue.SubRegion__c=String.valueof(ar.get('GeoScopes2'));
                        piTempValue.Region__c=String.valueof(ar.get('GeoScopes3'));
                        /*
                        if (masterData.countrySubregionMap.get(piTempValue.Country__c) != null)
                        {
                            piTempValue.SubRegion__c = masterData.countrySubregionMap.get(piTempValue.Country__c);
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                        */
                    }
                 
                    if (GeoScope == SPE_Constants.MU_GEOSCOPE)
                    {
                        piTempValue.SubRegion__c = (String)ar.get('GeoScopes');
                        piTempValue.Region__c=String.valueof(ar.get('GeoScopes3'));
                        /*
                        if (masterData.subRegionRegionMap.get(piTempValue.SubRegion__c) != null)
                        {
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                        */
                    }
                 
                    if (GeoScope == SPE_Constants.MARKET_GEOSCOPE)
                    {
                        piTempValue.Region__c = (String) ar.get('GeoScopes');
                    }
                }
                                     
                if (BUScope != Null && BUScope != PicklistDefaultValues__c.getall().values()[0].Product__c) // 'All Products'
                {
                    if (BUScope == SPE_Constants.BU_BUSCOPE)
                    {
                        piTempValue.BusinessUnit__c = (String)ar.get('BUScopes');
                    }
              
                    if (BUScope == SPE_Constants.BL_BUSCOPE)
                    {
                        piTempValue.BusinessLine__c = (String) ar.get('BUScopes');
                        
                        if (masterData.BLBUMap.get(piTempValue.BusinessLine__c) != null)
                        {
                            piTempValue.BusinessUnit__c = masterData.BLBUMap.get(piTempValue.BusinessLine__c);
                        }
                    } 
                    if (BUScope == SPE_Constants.PRODUCT_BUSCOPE)
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
                    if (CatScope == SPE_Constants.AREA_CATSCOPE)
                    {
                        piTempValue.Cluster__c = (String) ar.get('CatScopes');
                    }
                    if (CatScope == SPE_Constants.GROUP_CATSCOPE)
                    {
                        piTempValue.CategoryGroup__c = (String) ar.get('CatScopes');
                        
                        if (masterData.grpClusterMap.get(piTempValue.CategoryGroup__c) != null)
                        {
                            piTempValue.Cluster__c = masterData.grpClusterMap.get(piTempValue.CategoryGroup__c);
                        }
                    }                           
                    if (CatScope == SPE_Constants.CATSCOPE)
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
        else if ( PIDefID != null)
        {
            String PIType = [select ValuesType__c from SPE_PIDefinition__c where id=:PIDefID].ValuesType__c;
            
            //****************Changes For Encryption***************//    
            for (SPE_PIValues__c  ss:[SELECT NumberValue__c,StringValue__c, Period__c, Category__c, Cluster__c, CategoryGroup__c, BusinessLine__c,
                                            BusinessUnit__c,Product__c,Region__c,SubRegion__c,Country__c,Project__c,EnterpriseID__c,EnterpriseIDEncrypted__c
                                     FROM SPE_PIValues__c
                                     WHERE PIDefination__c=:PIDefID and period__c>=:fromDate AND Period__c<=:d])
            //*****************END****************//
                                     
            {
                SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
             
                piTempValue.PIValue__c = String.valueOf(ss.NumberValue__c);
                piTempValue.PI_Temp_Value_Text__c = ss.StringValue__c;
                piTempValue.KPIDefinition__c = cal.KPIDefinition__c; 
                piTempValue.KPICalculation__c = cal.Id;
                piTempValue.Period__c = ss.period__c;
                piTempValue.ExecutionPeriod__c = ExecPeriod; 
                piTempValue.Region__c = ss.Region__c;
                piTempValue.SubRegion__c = ss.SubRegion__c;
                piTempValue.country__c = ss.country__c;
                piTempValue.Project__c = ss.Project__c;
                
                //******************Changes For Encryption****************//
                //piTempValue.EnterpriseId__c = ss.EnterpriseID__c;
                piTempValue.EnterpriseIDEncrypted__c = ss.EnterpriseIDEncrypted__c;
                //***************END****************//
                
                piTempValue.BusinessLine__c = ss.BusinessLine__c;
                piTempValue.BusinessUnit__c = ss.BusinessUnit__c;
                piTempValue.Product__c = ss.Product__c;
                piTempValue.Category__c = ss.Category__c;
                piTempValue.CategoryGroup__c = ss.CategoryGroup__c;
                piTempValue.Cluster__c = ss.Cluster__c;
                piTempValue.valuetype__c = PIType;
                if(piTempValue.PIValue__c != Null)
                { 
                    ToBeUpdatedPITempValue.add(piTempValue);
                }
            } 
        }
                        
        if (Expression != null && Expression != SPE_Constants.CONSTANTVALUE  && PrevKPiID != null)
        {
            
            String QueryFirstHalf = 'SELECT ';
            String QuerySecondHalf = 'GROUP BY ';
            
            //****************Changes For Encryption****************//
            //String QueryMiddle = 'FROM SPE_KPIValue__c WHERE KPIDefinition__c=:PrevKPiID AND Period__c>=:fromDate AND Period__c<=:d AND enterpriseId__c IN:eId';
            String QueryMiddle = 'FROM SPE_KPIValue__c WHERE KPIDefinition__c=:PrevKPiID AND Period__c>=:fromDate AND Period__c<=:d AND EnterpriseIDEncrypted__c IN:ed';
            //***********************END*****************//        
            
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
            
            //*********************Changes For Encryption****************//        
            //QueryString = QueryFirstHalf+Expression+'(KPIValue__c) Quantity,EnterpriseID__c EID '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseID__c';
            QueryString = QueryFirstHalf+Expression+'(KPIValue__c) Quantity,EnterpriseIDEncrypted__c ED '+QueryMiddle+' '+ QuerySecondHalf+'EnterpriseIDEncrypted__c';
            //**********************END**********************//
            
            system.debug('---query string is ----'+QueryString);
            results = Database.query(QueryString);
            
            for (AggregateResult ar : results)
            {
                SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
               
                piTempValue.PIValue__c = String.ValueOf( ar.get('Quantity'));
                piTempValue.KPIDefinition__c = cal.KPIDefinition__c; 
                piTempValue.KPICalculation__c = cal.Id;
                
                //*****************Changes For Encryption**************//
                //piTempValue.enterpriseId__c = (String) ar.get('EID');
                piTempValue.EnterpriseIDEncrypted__c = (ID) ar.get('ED');
                //***************END***************//
                
                piTempValue.Period__c = d;
                piTempValue.ExecutionPeriod__c = ExecPeriod;
                
                piTempValue = SPE_DefaultValueUtil.assignPITempValues(piTempValue);
                
                if (GeoScope != Null && GeoScope != PicklistDefaultValues__c.getall().values()[0].Market__c) //'All Marketes'
                {
                    if(GeoScope == SPE_Constants.PRJ_GEOSCOPE)
                    {
                        piTempValue.Project__c = (String)ar.get('GeoScopes');
                        
                        if (masterData.projectCountryMap.get(piTempValue.Project__c) != null)
                        {
                            piTempValue.Country__c = masterData.projectCountryMap.get(piTempValue.Project__c);
                            piTempValue.SubRegion__c = masterData.countrySubregionMap.get(piTempValue.Country__c);
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                    }
                    if(GeoScope == SPE_Constants.COUNTRY_GEOSCOPE)
                    {
                        piTempValue.Country__c = (String)ar.get('GeoScopes');
                        if (masterData.countrySubregionMap.get(piTempValue.Country__c) != null)
                        {
                            piTempValue.SubRegion__c = masterData.countrySubregionMap.get(piTempValue.Country__c);
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                    }
                    if(GeoScope == SPE_Constants.MU_GEOSCOPE)
                    {
                        piTempValue.SubRegion__c = (String)ar.get('GeoScopes');
                        if (masterData.subRegionRegionMap.get(piTempValue.SubRegion__c) != null)
                        {
                            piTempValue.Region__c = masterData.subRegionRegionMap.get(piTempValue.SubRegion__c);
                        }
                    }
                    if(GeoScope == SPE_Constants.MARKET_GEOSCOPE)
                    {
                        piTempValue.Region__c = (String)ar.get('GeoScopes');
                    }
                    
                }
               
                if (BUScope != Null && BUScope != PicklistDefaultValues__c.getall().values()[0].Product__c) // All Product
                {
                    if(BUScope == SPE_Constants.BU_BUSCOPE)
                    {
                        piTempValue.BusinessUnit__c = (String) ar.get('BUScopes');
                    }
                    if(BUScope == SPE_Constants.BL_BUSCOPE)
                    {
                        piTempValue.BusinessLine__c = (String) ar.get('BUScopes');
                        
                        if (masterData.BLBUMap.get(piTempValue.BusinessLine__c) != null)
                        {
                            piTempValue.BusinessUnit__c = masterData.BLBUMap.get(piTempValue.BusinessLine__c);
                        }
                    }
                    if(BUScope == SPE_Constants.PRODUCT_BUSCOPE)
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
                    if(CatScope == SPE_Constants.AREA_CATSCOPE)
                    {
                        piTempValue.Cluster__c = (String) ar.get('CatScopes');
                    }
                    
                    if(CatScope == SPE_Constants.GROUP_CATSCOPE)
                    {
                        piTempValue.CategoryGroup__c = (String) ar.get('CatScopes');
                        
                        if (masterData.grpClusterMap.get(piTempValue.CategoryGroup__c) != null)
                        {
                            piTempValue.Cluster__c = masterData.grpClusterMap.get(piTempValue.CategoryGroup__c);
                        }
                    }
                    
                    if(CatScope == SPE_Constants.CATSCOPE)
                    {
                        piTempValue.Category__c = (String) ar.get('CatScopes');
                        
                        if (masterData.categoryGrpMap.get(piTempValue.Category__c) != null)
                        {
                            piTempValue.CategoryGroup__c = masterData.categoryGrpMap.get(piTempValue.Category__c);
                            piTempValue.Cluster__c = masterData.grpClusterMap.get(piTempValue.CategoryGroup__c);
                        }
                    }
                }
               
                ToBeUpdatedPITempValue.add(piTempValue);
            }       
        }
        /*
        else if ( PrevKPiID != Null)
        {
            for (SPE_KPIValue__c  ss:[SELECT KPIValue__c, Period__c, Category__c, CategoryGroup__c, BusinessLine__c, BusinessUnit__c, Region__c,
                                            SubRegion__c,Country__c,Project__c,EnterpriseID__c
                                     FROM SPE_KPIValue__c 
                                     WHERE KPIDefinition__c=:PrevKPiID and Period__c>:fromdate AND Period__c<:d])
            {
                SPE_PITempValue__c piTempValue = new SPE_PITempValue__c();
                piTempValue.ExecutionPeriod__c = ExecPeriod;
                piTempValue.PIValue__c = String.valueOf(ss.KPIValue__c);
                piTempValue.KPIDefinition__c = cal.KPIDefinition__c; 
                piTempValue.KPICalculation__c = cal.Id;
                piTempValue.Period__c = ss.period__c;
                piTempValue.Region__c = ss.Region__c;
                piTempValue.SubRegion__c = ss.SubRegion__c;
                piTempValue.country__c = ss.country__c;
                piTempValue.Project__c = ss.Project__c;
                piTempValue.EnterpriseId__c = ss.EnterpriseID__c;
                piTempValue.BusinessLine__c = ss.BusinessLine__c;
                piTempValue.BusinessUnit__c = ss.BusinessUnit__c;
                piTempValue.Category__c = ss.Category__c;
                piTempValue.CategoryGroup__c = ss.CategoryGroup__c;
                           
                ToBeUpdatedPITempValue.add(piTempValue);
            } 
        } 
        */ 
        //Saurabh Dua 30th June 2015 .. Code snippet is no longer required.
        
        if(tobeupdatedPITempValue.size()>0)
           insert ToBeUpdatedPITempValue;
    
        // Survey Comments //
        if (toBeInsertedKPiComments.size() > 0 )
        {
          insert toBeInsertedKPiComments;
        }
        // Survey Commeents //     
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
        List<Supplier_KPI_Calculation_adhoc__c> cc= [select id,KPI__c,KPI_Calculation__c from Supplier_KPI_Calculation_Adhoc__c WHERE KPI__c=:kpiIds order By createdDate limit 1];
        delete cc;
        
        List<Supplier_KPI_Calculation_adhoc__c> c= [select id from Supplier_KPI_Calculation_adhoc__c WHERE KPI__c=:kpiIds ];
        if(c.size()>0)
        {
            if(!test.isRunningTest()){
                SPE_KPIScheduleFinalbatchAdhoc dtbatch= new SPE_KPIScheduleFinalbatchAdhoc(kpiIds);
                database.executebatch(dtBatch,2000);
            } 
        }    
        else
        {
            if(!test.isRunningTest()){
                SPE_KPISchedulebatch5Adhoc dtbatch= new SPE_KPISchedulebatch5Adhoc(kpiIds);
                database.executebatch(dtBatch,1);
            }
        } 
    }
}