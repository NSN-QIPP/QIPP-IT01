global without sharing class SPE2_CalculationCanvasEXT
{
    public list<SPE_KPICalculation__c> IndexList {get;set;}
    public list<SPE_KPICalculation__c> CalList{get;set;}
    public List<IndexWrapper> IndexWrapperList{get;set;}
    public  string RPN{get;set;}
    public Id KPiID{get;set;}
    public SPE_KPIDefinition__c kpi{get;set;}
    public string orignalCalcValue{get;set;}
    public List<scenarioConditionWrapper> scenarioConditionList{get;set;}
    public boolean displayPopup {get; set;}   
    public Integer count{get;set;}
    public List<formulaWrapper> formulaWrapperlist{get;set;}
    public String showCondition{get;set;}
    public Integer conditionId{get;set;}
    public boolean allowPublish{get;set;}
    public boolean showDoneBtn{get;set;}
    public boolean showNextBtn{get;set;}
    
    public SPE2_CalculationCanvasEXT (ApexPages.Standardcontroller st)
    {
        KPiID=apexpages.currentpage().getparameters().get('id');
        kpi = [SELECT id,Name,KPI_Title__c,PI_Data__c,(Select Id From KPI_Calculations__r)
               FROM SPE_KPIDefinition__c
               WHERE id=:KPiID];
        list<KPI_Calculation_Formula__c> frmList = new list<KPI_Calculation_Formula__c>();
        frmList = [Select Id From KPI_Calculation_Formula__c Where KPI__c =:KPiID];
        allowPublish = false;
        if(frmList.size() > 0){
            allowPublish = true;
        }else{
            allowPublish = false;
        }
    }
    public pageReference displayFormula(){
        displayPopup = false;
        showDoneBtn = false;
        showCondition= 'false';
        system.debug('enter here123');
        return null;
    }
    public SPE2_CalculationCanvasEXT ()
    {
        KPiID=apexpages.currentpage().getparameters().get('id');
        count = 0;
        showCondition = 'false';
        showDoneBtn = false;
        showNextBtn = true;        
        formulaWrapperlist = new List<formulaWrapper>();
        
        scenarioConditionList = new List<scenarioConditionWrapper>();
        //****************Changes for encryption***************//
        kpi = [SELECT id,Name,KPI_Title__c,KPICalulationUpdate__c,Level__c, BUScope__c, categoryscope__c, GeoScope__c , RPNCondition1__c, RPNCondition2__c, RPNExpressionElse__c, RPNCondition__c, LifecycleStage__c, Group2__c, SurveyBased__c, ActualCalculation__c,RPNElse__c
               FROM SPE_KPIDefinition__c
               WHERE id=:KPiID];
        //orignalCalcValue = kpi.ActualCalculation__c;
        //********************END*********************//
        
        IndexList= [SELECT id,Index__c FROM SPE_KPICalculation__c WHERE KPIDefinition__c=:KPiID Order By Index__c];
        
        CalList=   [SELECT id,IndexName__c,Filter1__c,Filter2__c,Filter3__c,Filter4__c,Filter5__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Filter10__c,
                           Index__c,ConstantValue__c,Aggregation__c, KPIDefinition__c, PIDefination__c,PrevKPIDefination__c,SurveyQuestion__c,TimeFrame__c 
                    FROM SPE_KPICalculation__c
                    WHERE KPIDefinition__c=:KPiID Order By Index__c];
        if(CalList.size () == 0){
            CalList = new List<SPE_KPICalculation__c>();
            CalList.add(new SPE_KPICalculation__c());
        }         
        IndexWrapperList= new List<IndexWrapper>();
                
        for(SPE_KPICalculation__c KPI:CalList)
        {
           IndexWrapperList.add(new IndexWrapper(KPI.Index__c, KPI.Indexname__c));
        } 
        fetchKPIFormulas();
    }
    // SPE2.0 changes starts here
    public void fetchKPIFormulas(){
        scenarioConditionList.clear();
        List<KPI_Calculation_Formula__c> formulaList = [SELECT Id,KPI_Formula__c,KPI__c,Name,KPI_Expression__c,
                                        (Select Name,Operator__c,Value__c from KPI_Calulation_Conditions__r order by Name) 
                                        FROM KPI_Calculation_Formula__c where KPI__c=: KPiID];
        
        for(KPI_Calculation_Formula__c cf :formulaList){
            List<formulaWrapper> tempFormulas = new List<formulaWrapper>();
            formulaWrapperlist = new List<formulaWrapper>();
            for(KPI_Calulation_Condition__c con :cf.KPI_Calulation_Conditions__r){
                formulaWrapperlist.add(new formulaWrapper(con.Name));
                tempFormulas.add(new formulaWrapper(con.Name,con.Operator__c,con.Value__c));
            }
            scenarioConditionList.add(new scenarioConditionWrapper(cf.Name,tempFormulas,cf.KPI_Formula__c,cf.KPI_Expression__c));
        }
        if(scenarioConditionList.size() > 0){
            showCondition = 'true';
            showDoneBtn = true;
        }else{
            showCondition = 'false';
            showDoneBtn = false;
        }
    }
    
    public pageReference allowInput(){
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('inputRowNum'));
        Integer conIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('inputConNum'));
        if(scenarioConditionList[rowIndex].formulaWrpperList[conIndex].operator == 'Null' 
         ||scenarioConditionList[rowIndex].formulaWrpperList[conIndex].operator == 'Not Null'){
            scenarioConditionList[rowIndex].formulaWrpperList[conIndex].isEnabled = true;
            scenarioConditionList[rowIndex].formulaWrpperList[conIndex].value = Null;
        }
        else{
            scenarioConditionList[rowIndex].formulaWrpperList[conIndex].isEnabled = false;
        }
        return null;
    }
    public void AddRecords() 
    {
        SPE_KPICalculation__c kpiCalculation= new SPE_KPICalculation__c();
        CalList.add(kpiCalculation);
        showNextBtn = true;
    }

    public void RemoveRecords()
    {
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('rowIndex'));
        rowIndex= rowIndex-1;
        
        list<SPE_KPICalculation__c> newKPICalculation = new list<SPE_KPICalculation__c>();
        list<SPE_KPICalculation__c> newKPIIndex = new list<SPE_KPICalculation__c>();
        
        for(integer i=0;i<CalList.size();i++)
        {
            if(i!= (rowIndex) )
            {
                newKPICalculation.add(CalList[i]);
            }
        }
        
        if (CalList[rowindex].Id != null )
        {
            delete CalList[rowindex];
        }
        
        CalList.clear();
        callist.addall(newKPICalculation);
        
        for (integer i=0;i<IndexList.size();i++)
        {
            if (i!= (rowIndex))
            {
                newKPIIndex.add(IndexList[i]);
            }
        }
        IndexList.clear();
        IndexList.addall(newKPIIndex);
       
        List<IndexWrapper> newIndexWrapperList= new List<IndexWrapper>();
        for(SPE_KPICalculation__c KPI:CalList)
        {
            newIndexWrapperList.add(new IndexWrapper(KPI.Index__c, KPI.Indexname__c));
        }
        IndexWrapperList.clear();
        IndexWrapperList.addall(newIndexWrapperList);
        
        if(CalList.size() <= 0){
            showCondition = 'false';
            showDoneBtn = false;
            showNextBtn = false;
        }               
    }
    
    public void SaveRecords()
    {        
        if (checkValidation() == true)
        {
            //SPE_AdhocCalculations.DoAdhocCalc(apexpages.currentpage().getparameters().get('id'), system.today());
            CalList=[SELECT id,IndexName__c, Filter1__c, Filter2__c, Filter3__c, Filter4__c, Filter5__c, Filter6__c, Filter7__c, Filter8__c, Filter9__c,
                             Filter10__c, Index__c, ConstantValue__c, Aggregation__c, KPIDefinition__c, PIDefination__c, PrevKPIDefination__c,
                             SurveyQuestion__c, TimeFrame__c 
                      FROM SPE_KPICalculation__c
                      WHERE KPIDefinition__c=:KPiID Order 
                      By Index__c];
            
            IndexList= [SELECT id, Index__c FROM SPE_KPICalculation__c WHERE KPIDefinition__c =: KPiID Order By Index__c];
            IndexWrapperList.clear();
                
            for (SPE_KPICalculation__c KPI:CalList)
            {
                indexWrapperList.add(new IndexWrapper(KPI.Index__c, KPI.Index__c)); 
            }
            // SPE2.0 changes starts here
            scenarioConditionList = new List<scenarioConditionwrapper>();
            scenarioConditionList.clear();
            formulaWrapperlist = new List<formulaWrapper>();
            formulaWrapperlist.clear();
            for (SPE_KPICalculation__c KPI:CalList){
                if(KPI.Aggregation__c != 'Constant'){
                    formulaWrapperlist.add(new formulaWrapper(KPI.Index__c));
                }                 
            }
            scenarioConditionList.add(new scenarioConditionwrapper('Condition 1',formulaWrapperlist));
            if(scenarioConditionList.size() > 0){
                showCondition = 'true';
                showDoneBtn = true;
            }else{
                showCondition = 'false';
                showDoneBtn = false;
            }
            
        }
    }
    public void addMoreConditions(){
        count = scenarioConditionList.size() + 1;
        list<formulaWrapper> tempList = new list<formulaWrapper>();
        for(formulaWrapper fw: formulaWrapperlist){
            fw.Value = Null;
            templist.add(new formulaWrapper(fw.index));
        }
        scenarioConditionList.add(new scenarioConditionwrapper('Condition '+count,templist));
    }
    public void removeConditions(){
        String conditionNum = apexpages.currentpage().getparameters().get('conNum');
        if(scenarioConditionList.size() > 0){
            scenarioConditionList.remove(integer.valueOf(conditionNum));
        }
        integer count = 1;
        for(scenarioConditionwrapper temp :scenarioConditionList){
            
            temp.scenario = 'Condition ' + count;
            count ++;
        }
    }
    private Boolean checkValidation()
    {   
        Boolean flag = true;
        for(integer k=0; k < CalList.size(); k++)
        {
           if(CalList[k].Aggregation__c== SPE_Constants.KPICALC_NOAGGREGATION  || CalList[k].Aggregation__c==' ' || CalList[k].Aggregation__c==Null){
            ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_AggregationFunction);
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }            
                        
            if(CalList[k].PIDefination__c!=Null && CalList[k].PrevKPIDefination__c!=Null)
            { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_PIPrevKPIValidation);
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }
            
            if(CalList[k].PrevKPIDefination__c!=Null && (calList[k].Aggregation__c == SPE_Constants.KPICALC_MINSUPPLIER_AGGREGATION  || calList[k].Aggregation__c == SPE_Constants.KPICALC_MAXSUPPLIER_AGGREGATION || calList[k].Aggregation__c == SPE_Constants.KPICALC_AVGSUPPLIER_AGGREGATION ))
            { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_SupplierAggregation );
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }
             
            if((CalList[k].PIDefination__c!= Null || CalList[k].PrevKPIDefination__c!=Null ) && calList[k].Aggregation__c == SPE_Constants.CONSTANTVALUE)
            { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_OnlyConstantValue);
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }
            
            if(CalList[k].PIDefination__c == null && CalList[k].PrevKPIDefination__c == null && calList[k].Aggregation__c != SPE_Constants.CONSTANTVALUE)
            { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_AggregationPIPrevKPI);
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }
            if((CalList[k].PIDefination__c != null || CalList[k].PrevKPIDefination__c != null) && calList[k].ConstantValue__c != Null)
            { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Constant value is allowed only with Aggregation value as Constant');
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }
            
            if(CalList[k].TimeFrame__c==Null  && calList[k].Aggregation__c!=SPE_Constants.CONSTANTVALUE)
            { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_TimeFrame);
                ApexPages.addmessage(msg);
                flag = false;
                break;
            }
               
            if(calList[k].IndexName__c == Null)
            {
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_Indexname);
                ApexPages.addmessage(msg);
                flag = false;
                break;  
            }
            if (CalList[k].PIDefination__c != null)
            {
                SPE_PIDefinition__c PI = [SELECT id, BUScope__c, GeoScope__c, CategoryScope__c, ValuesType__c, LifecycleStage__c, SurveyQuestion__c
                                              FROM SPE_PIDefinition__c WHERE id=:CalList[k].PIDefination__c];
                                
                String ValueType = PI.ValuesType__c;
                String PIStage = PI.LifecycleStage__c;
                String KPIStage = kpi.LifecycleStage__c;
                
                if (PI.LifecycleStage__c == SPE_Constants.PI_OBSOLETE_LIFECYCLE)
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error, System.Label.SPE_ObsoletePItoKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;
                }
                    
                if ((calList[k].Aggregation__c==SPE_Constants.KPICALC_SUMAGGREGATION  || calList[k].Aggregation__c==SPE_Constants.KPICALC_AVGAGGREGATION  || calList[k].Aggregation__c==SPE_Constants.KPICALC_AVGSUPPLIER_AGGREGATION) && (ValueType==SPE_Constants.PI_DATEVALUETYPE ))
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_CannotUse + calList[k].Aggregation__c+ System.Label.SPE_AggFuncWith +ValueType+ System.Label.SPE_PIType );
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;
                }   
                    
                               
                if ((calList[k].Aggregation__c== SPE_Constants.KPICALC_SUMAGGREGATION  || calList[k].Aggregation__c== SPE_Constants.KPICALC_AVGAGGREGATION  || calList[k].Aggregation__c== SPE_Constants.KPICALC_MINAGGREGATION  || calList[k].Aggregation__c== SPE_Constants.KPICALC_MAXAGGREGATION  || calList[k].Aggregation__c== SPE_Constants.KPICALC_AVGSUPPLIER_AGGREGATION || calList[k].Aggregation__c== SPE_Constants.KPICALC_MINSUPPLIER_AGGREGATION  || calList[k].Aggregation__c== SPE_Constants.KPICALC_MAXSUPPLIER_AGGREGATION) 
                       && (ValueType== SPE_Constants.PI_STRINGVALUETYPE  || ValueType== SPE_Constants.PI_BOOLEANVALUETYPE))
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_CannotUse +calList[k].Aggregation__c+ System.Label.SPE_AggFuncWith +ValueType+ System.Label.SPE_PIType );
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;
                }
                                         
                /*if (PIStage != KPIStage)
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Cannot Include '+ PIStage+' PI to '+KPIStage+' KPI');
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }*/
                      
                if ((kpi.BUScope__c == SPE_Constants.PRODUCT_BUSCOPE  && PI.BUScope__c != SPE_Constants.PRODUCT_BUSCOPE ) || 
                    (kpi.BUScope__c == SPE_Constants.BL_BUSCOPE  && (PI.BUScope__c != SPE_Constants.PRODUCT_BUSCOPE  && PI.BUScope__c != SPE_Constants.BL_BUSCOPE  )) ||
                    (kpi.BUScope__c == SPE_Constants.BU_BUSCOPE  && PI.BUScope__c == SPE_Constants.ALL_BUSCOPE ))
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_PIHigherThanKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }
                      
                if ((kpi.categoryscope__c == SPE_Constants.CATSCOPE  && PI.CategoryScope__c != SPE_Constants.CATSCOPE ) || 
                    (kpi.categoryscope__c == SPE_Constants.GROUP_CATSCOPE && (PI.CategoryScope__c != SPE_Constants.CATSCOPE  && PI.CategoryScope__c != SPE_Constants.GROUP_CATSCOPE  )) ||
                    (kpi.categoryscope__c == SPE_Constants.AREA_CATSCOPE && (PI.CategoryScope__c == SPE_Constants.ALL_CATSCOPE ))
                  )
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_PIHighCatScopeKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }
                  
                if ((kpi.GeoScope__c == SPE_Constants.PRJ_GEOSCOPE && PI.GeoScope__c != SPE_Constants.PRJ_GEOSCOPE ) || 
                    (kpi.GeoScope__c == SPE_Constants.COUNTRY_GEOSCOPE && (PI.GeoScope__c != SPE_Constants.PRJ_GEOSCOPE && PI.GeoScope__c != SPE_Constants.COUNTRY_GEOSCOPE )) || 
                    (kpi.GeoScope__c == SPE_Constants.MU_GEOSCOPE && (PI.GeoScope__c == SPE_Constants.MARKET_GEOSCOPE  || PI.GeoScope__c == SPE_Constants.ALL_GEOSCOPE )) || 
                    (kpi.GeoScope__c == SPE_Constants.MARKET_GEOSCOPE && PI.GeoScope__c == SPE_Constants.ALL_GEOSCOPE)
                   )
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_PIHighGeoScopeKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }                  
                
            }
            
            if(KPiID == CalList[k].PrevKPIDefination__c && CalList[k].PIDefination__c==Null && CalList[k].PrevKPIDefination__c !=Null)
                { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_CantRefKPI);
                ApexPages.addmessage(msg);
                flag = false;
                break;
                }
            
            if(CalList[k].aggregation__c== SPE_Constants.CONSTANTVALUE  && CalList[k].constantvalue__c==null)
                { 
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_AggregationConstant);
                ApexPages.addmessage(msg);
                flag = false;
                break;
                }
            
            list<SPE_KPICalculation__c> calculations = new list<SPE_KPICalculation__c>();
            
            if(CalList[k].PrevKPIDefination__c!=Null)
            { 
                
                calculations=[select id from SPE_KPICalculation__c where KPIDefinition__c=:CalList[k].PrevKPIDefination__c and PrevKPIDefination__c!=null];
               
            }    
            if(calculations.size()>0){
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_KPIContainsKPI);
                ApexPages.addmessage(msg);
                flag = false;
                break;                
            }
            
            if(CalList[k].PrevKPIDefination__c!=Null)
            { 
                
            calculations=[select id from SPE_KPICalculation__c where KPIDefinition__c=:CalList[k].PrevKPIDefination__c];
               
            SPE_kPIDefinition__c CurrentKPI = [SELECT id,pi_data__c,CalculationFormula__c,Formula_Count__c from SPE_kPIDefinition__c where id=:CalList[k].PrevKPIDefination__c];
              
            if((CurrentKPI.pi_data__c==Null && calculations.size()==0 && CalList[k].PrevKPIDefination__c!= Null) || (CurrentKPI.pi_data__c==Null && CurrentKPI.Formula_Count__c == Null && CalList[k].PrevKPIDefination__c!= Null))
            {
               ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_ExistingKPI);
                ApexPages.addmessage(msg);
                flag = false;
                break;           
            }           
            }
            
           if (CalList[k].PrevKPIDefination__c!= null)
            {
                SPE_kPIDefinition__c nKPI = [SELECT id, BUScope__c, GeoScope__c, CategoryScope__c
                                              FROM SPE_kPIDefinition__c WHERE id=:CalList[k].PrevKPIDefination__c];
                                
                if ((kpi.BUScope__c == SPE_Constants.PRODUCT_BUSCOPE  && nKPI .BUScope__c != SPE_Constants.PRODUCT_BUSCOPE) || 
                    (kpi.BUScope__c == SPE_Constants.BL_BUSCOPE  && (nKPI .BUScope__c != SPE_Constants.PRODUCT_BUSCOPE  && nKPI .BUScope__c != SPE_Constants.BL_BUSCOPE  )) ||
                    (kpi.BUScope__c == SPE_Constants.BU_BUSCOPE  && nKPI .BUScope__c == SPE_Constants.ALL_BUSCOPE ))
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_KPIHighBUScopeKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }
                      
                if ((kpi.categoryscope__c == SPE_Constants.CATSCOPE  && nKPI .CategoryScope__c != SPE_Constants.CATSCOPE ) || 
                    (kpi.categoryscope__c == SPE_Constants.GROUP_CATSCOPE && (nKPI .CategoryScope__c != SPE_Constants.CATSCOPE && nKPI .CategoryScope__c != SPE_Constants.GROUP_CATSCOPE  )) ||
                    (kpi.categoryscope__c == SPE_Constants.AREA_CATSCOPE && (nKPI .CategoryScope__c == SPE_Constants.ALL_CATSCOPE ))
                  )
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_KPIHighCatScopeKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }
                  
                if ((kpi.GeoScope__c == SPE_Constants.PRJ_GEOSCOPE && nKPI .GeoScope__c != SPE_Constants.PRJ_GEOSCOPE ) || 
                    (kpi.GeoScope__c == SPE_Constants.COUNTRY_GEOSCOPE && (nKPI .GeoScope__c != SPE_Constants.PRJ_GEOSCOPE && nKPI .GeoScope__c != SPE_Constants.COUNTRY_GEOSCOPE )) || 
                    (kpi.GeoScope__c == SPE_Constants.MU_GEOSCOPE && (nKPI .GeoScope__c == SPE_Constants.MARKET_GEOSCOPE  || nKPI .GeoScope__c == SPE_Constants.ALL_GEOSCOPE )) || 
                    (kpi.GeoScope__c == SPE_Constants.MARKET_GEOSCOPE && nKPI .GeoScope__c == SPE_Constants.ALL_GEOSCOPE)
                   )
                {
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,System.Label.SPE_KPIHighGeoScopeKPI);
                    ApexPages.addmessage(msg);
                    flag = false;
                    break;  
                }                        
            }    
            CalList[k].KPIDefinition__c=apexpages.currentpage().getparameters().get('id');
            upsert CalList[K];
        }
        return flag;
    }
    
    public Pagereference updateKPI() 
    {
        try
        {
            RPN=apexpages.currentpage().getparameters().get('RPN');
                
            if (RPN.contains(' ') == false)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_CompleteCalc));
                return null;
            }
                
            RPN=RPN.replace(' ',',');
            RPN=RPN.substring(0,RPN.length()-1);
                
            SPE_KPIDefinition__c KPIDefi= [SELECT id,CalculationFormula__c,RPNExpression__c FROM SPE_KPIDefinition__c WHERE id =: KPiID];
            KPIDefi.ActualCalculation__c=apexpages.currentpage().getparameters().get('ActualCalculation');
            KPIDefi.CalculationFormula__c=KPIDefi.ActualCalculation__c;
            
            for(SPE_KPICalculation__c KPI:CalList)
            {
                KPIDefi.CalculationFormula__c = KPIDefi.CalculationFormula__c.replace(KPI.Index__c,KPI.IndexName__c.toLowerCase());
                KPIDefi.RPNExpression__c=RPN;
            }
            // SPE2.0 changes starts here
            scenarioConditionList[conditionId].formulaInput = apexpages.currentpage().getparameters().get('ActualCalculation');
            system.debug('RPN::'+RPN);
            scenarioConditionList[conditionId].expressionInput = RPN;
            //  SPE2.0 changes ends here
           // update KPIDefi;
            displayPopup = false; 
            return Null;
        }
        catch(Exception e) 
        {
            ApexPages.addMessages(e);
            return null;
        }
    }

    public void updateIfElse()
    {
        kpi.RPNCondition1__c = apexpages.currentpage().getparameters().get('r1');
        kpi.RPNCondition2__c = apexpages.currentpage().getparameters().get('r2');
        kpi.RPNElse__c = apexpages.currentpage().getparameters().get('r3');
       
        kpi.RPNCondition1Expression__c = apexpages.currentpage().getparameters().get('r1Exp');
        kpi.RPNCondition2Expression__c = apexpages.currentpage().getparameters().get('r2Exp');
        kpi.RPNExpressionElse__c = apexpages.currentpage().getparameters().get('r3Exp');
        
        if (kpi.RPNCondition1__c != '' && kpi.RPNCondition1__c != null)
        {
            kpi.RPNCondition1Expression__c= kpi.RPNCondition1Expression__c !=null ? kpi.RPNCondition1Expression__c.replace(' ',',') : null;
            kpi.RPNCondition1Expression__c= kpi.RPNCondition1Expression__c !=null ? kpi.RPNCondition1Expression__c.substring(0,kpi.RPNCondition1Expression__c.length()-1) : null;
        }
        else
        {
            kpi.RPNCondition1Expression__c = null;  
        }
        
        if (kpi.RPNCondition1__c != '' && kpi.RPNCondition1__c != null)
        {
            kpi.RPNCondition2Expression__c= (kpi.RPNCondition2Expression__c !=null && kpi.RPNCondition2Expression__c != '') ? kpi.RPNCondition2Expression__c.replace(' ',',') : null;
            kpi.RPNCondition2Expression__c= kpi.RPNCondition2Expression__c !=null ? kpi.RPNCondition2Expression__c.substring(0,kpi.RPNCondition2Expression__c.length()-1) : null;
        }
        else
        {
            kpi.RPNCondition2Expression__c = null;
        }
        
        if (kpi.RPNElse__c != '' && kpi.RPNElse__c != null)
        {
            kpi.RPNExpressionElse__c= (kpi.RPNExpressionElse__c !=null && kpi.RPNExpressionElse__c != '') ? kpi.RPNExpressionElse__c.replace(' ',',') : null;
            kpi.RPNExpressionElse__c= kpi.RPNExpressionElse__c!=null ? kpi.RPNExpressionElse__c.substring(0,kpi.RPNExpressionElse__c.length()-1) : null;
        }
        else
        {
            kpi.RPNExpressionElse__c = null;
        }
        update kpi;
    }

    public pagereference backToKPI()
    {
        // SPE2.0 changes starts here
        Id kpidefId = apexpages.currentpage().getparameters().get('id');
        List<KPI_Calculation_Formula__c> toDeleteList = [Select Id From KPI_Calculation_Formula__c Where KPI__c =:kpidefId];
        if(toDeleteList.size() > 0){
            try{
                delete toDeleteList;
            }catch(exception e){
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,e.getMessage());
                ApexPages.addmessage(msg);
                return null;
            }
            
        }
        if(scenarioConditionList.size() > 0){
            List<KPI_Calculation_Formula__c> kpiFrmulaLst = new List<KPI_Calculation_Formula__c>();            
            for(scenarioConditionWrapper scw :scenarioConditionList){
                if(scw.formulaInput != null && scw.formulaInput != ''){
                    kpiFrmulaLst.add(new KPI_Calculation_Formula__c(KPI__c = kpidefId,KPI_Formula__c = scw.formulaInput,
                                    Name=scw.scenario,KPI_External_Id__c = kpidefId+';'+scw.scenario,KPI_Expression__c=scw.expressionInput));
                }else{
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Formula input is required for each condition');
                    ApexPages.addmessage(msg);
                    return null;
                }
            }
            system.debug('scenarioConditionList::'+scenarioConditionList);
            try{                
                insert kpiFrmulaLst;
                if(kpiFrmulaLst.size() > 0){
                    List<KPI_Calulation_Condition__c> condList = new List<KPI_Calulation_Condition__c>();
                    for(scenarioConditionWrapper scw1 :scenarioConditionList){                        
                        for(formulaWrapper fw :scw1.formulaWrpperList){                            
                            if(fw.Operator == 'Not Null' || fw.Operator == 'Null'){                                
                                fw.Value = Null;
                            }
                            system.debug('******fw::******'+fw);                           
                            condList.add(new KPI_Calulation_Condition__c(Name = fw.index,
                                         Operator__c = fw.operator,Value__c = fw.Value,
                                         Formula__r = new KPI_Calculation_Formula__c(KPI_External_Id__c = kpidefId+';'+scw1.scenario)));
                        }
                    }
                    system.debug('******scenarioConditionList::'+scenarioConditionList);
                    system.debug('condList::'+condList);
                    insert condList;
                    
                    if(kpi.KPICalulationUpdate__c == null){
                        kpi.KPICalulationUpdate__c = 0;
                    }
                    kpi.KPICalulationUpdate__c = kpi.KPICalulationUpdate__c+1;
                    update kpi;
                }
            }catch(Exception e){
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,e.getMessage());
                ApexPages.addmessage(msg);
                return null;
            }
        }
        
        //SPE2.0 changes ends here
        pagereference p= new pagereference ('/'+apexpages.currentpage().getparameters().get('id'));
        return p;
    }
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {
        conditionId = integer.valueOf(apexpages.currentpage().getparameters().get('conditionId'));
        orignalCalcValue = scenarioConditionList[conditionId].formulaInput;
        displayPopup = true;    
    }
    public class IndexWrapper
    {
        public String IndexValue{get;set;}
        public String IndexName {get;set;}
        
        public IndexWrapper (String I, String N)
        {
        IndexValue=I;
        IndexName = N;
        }
    }
    public class formulaWrapper{
        public String index{get;set;}
        public String operator{get;set;}
        public decimal value{get;set;}
        public boolean isEnabled{get;set;}
        public List<SelectOption> getOperators() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Not Null','Not Null'));
            options.add(new SelectOption('Null','Null'));
            options.add(new SelectOption('>','>'));
            options.add(new SelectOption('>=','>='));
            options.add(new SelectOption('<','<'));
            options.add(new SelectOption('<=','<='));
            options.add(new SelectOption('==','=='));
            options.add(new SelectOption('!=','!='));                        
            return options;
        }
        public formulaWrapper(String index){
            this.index = index;
            //this.value = 0;
            this.isEnabled = true;
        }
        public formulaWrapper(String index,String operator,decimal value){
            this.index = index;           
            this.operator = operator;
            this.value = value;
            if(this.operator == 'Not Null' || this.operator == 'Null'){
                this.isEnabled = true;
            }else{
                this.isEnabled = false;
            }
        }
    }
    public class scenarioConditionWrapper{
        public String scenario{get;set;}
        public List<formulaWrapper> formulaWrpperList{get;set;}
        public String formulaInput{get;set;}
        public String expressionInput{get;set;}
        public scenarioConditionWrapper(String scenario,List<formulaWrapper> formulaWrpperList){
            this.Scenario = Scenario;
            this.formulaWrpperList = formulaWrpperList;
        }
        public scenarioConditionWrapper(String scenario,List<formulaWrapper> formulaWrpperList,String formulaInput,string expressionInput){
            this.Scenario = Scenario;
            this.formulaWrpperList = formulaWrpperList;
            this.formulaInput = formulaInput;
            this.expressionInput = expressionInput;
        }
    }
    @RemoteAction
    global static Boolean getPIDefinition(String piId, Integer level) 
    {    
        Id i = Id.valueOf(piId);
        SPE_PIDefinition__c  piDef = [SELECT Id, Max_Question_Score__c FROM SPE_PIDefinition__c where Id = :i];
        
        system.debug('=======>'+level+piDef.Max_Question_Score__c);
        
        if(level < piDef.Max_Question_Score__c)
            return true;
        else
            return false;
    }

}