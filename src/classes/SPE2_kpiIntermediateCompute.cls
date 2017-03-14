global class SPE2_kpiIntermediateCompute implements Database.Batchable<sObject>{
    global string kpiidentifier;
    global String kpiDefinationID; 
    global String query;
    global Map<Id, Map<String, String>> kpiEnterpriseCommentsMap;
    global Map<String, Decimal> indexConstantMap;
    
     global SPE2_kpiIntermediateCompute(String kpiidentifier,String kpiDefinationID,Map<Id, Map<String, String>> kpiEnterpriseCommentsMap){
        this.kpiidentifier = kpiidentifier;
        this.kpiDefinationID = kpiDefinationID;
        this.kpiEnterpriseCommentsMap = kpiEnterpriseCommentsMap;
        system.debug('kpiidentifier ::'+kpiidentifier);
        indexConstantMap = new Map<String, Decimal>();
        System.debug('Refreshed');        
        //system.now()+';'+userInfo.getUserId();                                                                        
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        query = 'Select Id,IdentifierParam__c,KPI__c,KPI_Mappingscope__c,KPI__r.Adhoc_Date__c FROM KPI_IntermediateComputation__c Where KPI__c =: kpiDefinationID';
        system.debug('query:12:'+query);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<KPI_IntermediateComputation__c> scope){
        List<SPE_KPIValue__c> toBeInsertedKPIValues = new List<SPE_KPIValue__c>();
        List<String> toBeDeletedKPIValues = new List<String>();
        String valuestype = '';
        String PIValues = ''; 
        String exec;
        
        Map<String, Map<String, Decimal>> enterprisescopeKPIIndexValuesMap = new Map<String, Map<String, Decimal>>();                        
                                        
        // ******************** //
        
        Map<String, Map<String, Date>> enterprisescopeKPIIndexValuesDateMap = new Map<String, Map<String, Date>>();
        
        Set<ID> kpiformulaID = new Set<ID>();
        List<KPI_Calculation_Formula__c> allkpiformulalist = [Select ID,Name,KPI__c,KPI_Expression__c,KPI_Formula__c from KPI_Calculation_Formula__c
                                                              Where KPI__c =: kpiDefinationID];
                                                              
        for(KPI_Calculation_Formula__c kpifml: allkpiformulalist ){
            kpiformulaID.add(kpifml.ID);
        }                                                       
        
        List<KPI_Calulation_Condition__c> allkpiconditions = [Select ID,Name,Formula__c,Operator__c,Value__c from KPI_Calulation_Condition__c
                                                              Where Formula__c IN: kpiformulaID];
                                                              
        Map<String,List<KPI_Calulation_Condition__c>> newKPIFormulaConditionMap = new  Map<String,List<KPI_Calulation_Condition__c>>();
        
        for(KPI_Calulation_Condition__c kpicon: allkpiconditions){
            if(!newKPIFormulaConditionMap.containsKey(kpicon.Formula__c)){
                newKPIFormulaConditionMap.put(kpicon.Formula__c,new List<KPI_Calulation_Condition__c>());
            }
            newKPIFormulaConditionMap.get(kpicon.Formula__c).add(kpicon);
        }
             
        system.debug('scope ::'+scope);
        system.debug('kpiDefinationID ::'+kpiDefinationID);
        
        for(KPI_IntermediateComputation__c  sc :scope){                                                                                    
            for (SPE_PITempValue__c piTemp : [SELECT Index__c, KPIDefinition__c, PIValue__c, Mappingscope__c, IsConstant__c, ValueType__c 
                                              FROM SPE_PITempValue__c 
                                              WHERE KPIDefinition__c =: kpiDefinationID AND ValueType__c = :SPE_Constants.PI_DATEVALUETYPE 
                                              AND Mappingscope__c =: sc.KPI_Mappingscope__c])
            {
                //PIValues = piTemp.PIValue__c;
                System.debug('Entered Here for Date');
                Map<String, Date> indexValuesMap = new Map<String, Date>();
                    
                if (enterprisescopeKPIIndexValuesDateMap.get(piTemp.Mappingscope__c) != null )
                {
                    indexValuesMap = enterprisescopeKPIIndexValuesDateMap.get(piTemp.Mappingscope__c);
                }
                
                indexValuesMap.put(piTemp.Index__c, Date.valueOf(piTemp.PIValue__c));
                
                enterprisescopeKPIIndexValuesDateMap.put(piTemp.Mappingscope__c, indexValuesMap);
            }
                            
            for (String scopeKPI : enterprisescopeKPIIndexValuesDateMap.keyset())
            {                   
                for(KPI_Calculation_Formula__c kpiformula: allkpiformulalist)
                {
                    Map<String,Boolean> ConditionMatchResult = new Map<String,Boolean>();
                    Boolean isSatisfied = False;
                    String conditionmet = '';
                                                                        
                    for(KPI_Calulation_Condition__c kpicond: newKPIFormulaConditionMap.get(kpiformula.ID)){
                            if(kpicond.Name != Null && kpicond.Operator__c!= Null){
                                try{
                                    ConditionMatchResult.put(kpicond.Name,SPE_ReversePolishAlgorithm.conditionComparision(enterprisescopeKPIIndexValuesMap.get(scopeKPI).get(kpicond.Name),kpicond.Value__c,kpicond.Operator__c));    
                                }catch(Exception e){}
                                
                                if(conditionmet != ''){
                                    if(kpicond.Operator__c != 'Null' && kpicond.Operator__c != 'Not Null'){
                                        conditionmet = kpicond.Name+' '+kpicond.Operator__c+' '+kpicond.Value__c+' '+'&&'+' '+conditionmet;
                                    }
                                    else if(kpicond.Operator__c == 'Null' || kpicond.Operator__c == 'Not Null'){
                                       conditionmet = kpicond.Name+' is '+kpicond.Operator__c+' '+'&&'+' '+conditionmet; 
                                    } 
                                }
                                else{
                                    if(kpicond.Operator__c != 'Null' && kpicond.Operator__c != 'Not Null'){
                                        conditionmet = kpicond.Name+' '+kpicond.Operator__c+' '+kpicond.Value__c;
                                    }
                                    else if(kpicond.Operator__c == 'Null' || kpicond.Operator__c == 'Not Null'){
                                        conditionmet = kpicond.Name+' is '+kpicond.Operator__c;
                                    }
                                }
                            }                                          
                    }
                    
                    List<Boolean> mapValues = new List<Boolean>();
                    mapValues = ConditionMatchResult.values();
                    
                    System.Debug('++++++++++++ConditionMatchResult.values()+++++++++++++'+ConditionMatchResult.values());
                    
                    Set<Boolean> matchMapValues = new Set<Boolean>();
                    
                    for(Boolean b:mapValues){
                        matchMapValues.add(b);
                    }
                    
                    if(!matchMapValues.contains(false)){
                        isSatisfied = true;
                    }
                    if(isSatisfied == true)
                    {
                        List<Object> objectListActual = new List<Object>();
                        
                        Decimal valueActual = null;
                                                                                                
                        if (kpiformula.KPI_Expression__c != null)
                        {
                            for (String exp: kpiformula.KPI_Expression__c.split(','))
                            {
                                if (SPE_Utility.indexList.contains(exp))
                                {
                                    Date piAggregate = null;
                                    
                                    if (enterprisescopeKPIIndexValuesDateMap.get(scopeKPI).get(exp) != null)
                                    {
                                        piAggregate = enterprisescopeKPIIndexValuesDateMap.get(scopeKPI).get(exp);    
                                    }
                                    
                                    objectListActual.add((Object) piAggregate);
                                }
                                if (SPE_Utility.operatorList.contains(exp))
                                {
                                    objectListActual.add(exp);
                                } 
                            }
                            
                            valueActual = objectListActual.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculationDate(objectListActual);
                          }
                            
                        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c ();
                        kpiValue.KPIDefinition__c = kpiDefinationID;
                        
                        //**********Changes Done As Part of Encryption************************//
                            //kpiValue.EnterpriseId__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                            kpiValue.EnterpriseIDEncrypted__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                        //*************************End*****************************************//
                        kpiValue.BusinessLine__c  = scopeKPI.split(';')[1] == null ? null : scopeKPI.split(';')[1];
                        kpiValue.BusinessUnit__c = scopeKPI.split(';')[2] == null ? null : scopeKPI.split(';')[2];
                        kpiValue.Category__c = scopeKPI.split(';')[3] == null ? null : scopeKPI.split(';')[3];
                        kpiValue.CategoryGroup__c = scopeKPI.split(';')[4] == null ? null : scopeKPI.split(';')[4];
                        kpiValue.Cluster__c = scopeKPI.split(';')[5] == null ? null : scopeKPI.split(';')[5];
                        kpiValue.Country__c = scopeKPI.split(';')[6] == null ? null : scopeKPI.split(';')[6];
                        kpiValue.Region__c = scopeKPI.split(';')[7] == null ? null : scopeKPI.split(';')[7];
                        kpiValue.SubRegion__c = scopeKPI.split(';')[8] == null ? null : scopeKPI.split(';')[8];
                        kpiValue.Project__c = scopeKPI.split(';')[9] == null ? null : scopeKPI.split(';')[9];
                        kpiValue.Product__c = scopeKPI.split(';')[10] == null ? null : scopeKPI.split(';')[10];
                        kpiValue.ExecutionPeriod__c = scopeKPI.split(';')[11] == null ? null : scopeKPI.split(';')[11]; //(scopeKPI.split(';')[8] == null && Date.valueOf(scopeKPI.split(';')[8]) == null)  ? null : Date.valueOf(scopeKPI.split(';')[8]);
                        KpiValue.Period__c= sc.KPI__r.Adhoc_Date__c;
                        kpiValue.Actual_Formula__c = kpiformula.KPI_Formula__c;
                        kpiValue.KPIValue__c = valueActual;
                        kpiValue.IdentifierParam__c = kpiidentifier;
                        //kpiValue.KPI_Text_Value__c = Date.ValueOf(PIValues).month()+'/'+Date.ValueOf(PIValues).day()+'/'+Date.ValueOf(PIValues).year()+'';
                        
                        kpiValue.Actual_Condition__c = conditionmet;
                        kpiValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpiDefinationID) != null && kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) != null) ? kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) : '';
                       
                        toBeInsertedKPIValues.add(kpiValue);
                                                  
                        toBeDeletedKPIValues.add(kpiValue.ExecutionPeriod__c);
                        exec = kpiValue.ExecutionPeriod__c;
                        break;
                        }
                        else if(isSatisfied == False){
                        
                            SPE_KPIValue__c kpiValue = new SPE_KPIValue__c ();                        
                            kpiValue.KPIDefinition__c = kpiDefinationID;
                            //**********Changes Done As Part of Encryption************************//
                                //kpiValue.EnterpriseId__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                                kpiValue.EnterpriseIDEncrypted__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                            //*************************End*****************************************//
                            kpiValue.BusinessLine__c  = scopeKPI.split(';')[1] == null ? null : scopeKPI.split(';')[1];
                            kpiValue.BusinessUnit__c = scopeKPI.split(';')[2] == null ? null : scopeKPI.split(';')[2];
                            kpiValue.Category__c = scopeKPI.split(';')[3] == null ? null : scopeKPI.split(';')[3];
                            kpiValue.CategoryGroup__c = scopeKPI.split(';')[4] == null ? null : scopeKPI.split(';')[4];
                            kpiValue.Cluster__c = scopeKPI.split(';')[5] == null ? null : scopeKPI.split(';')[5];
                            kpiValue.Country__c = scopeKPI.split(';')[6] == null ? null : scopeKPI.split(';')[6];
                            kpiValue.Region__c = scopeKPI.split(';')[7] == null ? null : scopeKPI.split(';')[7];
                            kpiValue.SubRegion__c = scopeKPI.split(';')[8] == null ? null : scopeKPI.split(';')[8];
                            kpiValue.Project__c = scopeKPI.split(';')[9] == null ? null : scopeKPI.split(';')[9];
                            kpiValue.Product__c = scopeKPI.split(';')[10] == null ? null : scopeKPI.split(';')[10];
                            kpiValue.ExecutionPeriod__c = scopeKPI.split(';')[11] == null ? null : scopeKPI.split(';')[11]; //(scopeKPI.split(';')[8] == null && Date.valueOf(scopeKPI.split(';')[8]) == null)  ? null : Date.valueOf(scopeKPI.split(';')[8]);
                            KpiValue.Period__c= sc.KPI__r.Adhoc_Date__c;
                            kpiValue.Actual_Formula__c = Null;
                            kpiValue.KPIValue__c = Null;
                            kpiValue.Actual_Condition__c = 'No Conditions Met';
                            kpiValue.IdentifierParam__c = kpiidentifier;
                            kpiValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpiDefinationID) != null && kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) != null) ? kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) : '';
            
                            toBeInsertedKPIValues.add (kpiValue);
                                                    
                            toBeDeletedKPIValues.add(kpiValue.ExecutionPeriod__c);
                            exec = kpiValue.ExecutionPeriod__c;
                        }
                    }
                }
            
            List<SPE_PITempValue__c> piconslist = [SELECT ID,Index__c, KPIDefinition__c, PIValue__c, Mappingscope__c, IsConstant__c, 
                                                      ValueType__c,EnterpriseId__c,EnterpriseIDEncrypted__c
                                                      FROM SPE_PITempValue__c 
                                                      WHERE KPIDefinition__c =: kpiDefinationID AND
                                                      ValueType__c != :SPE_Constants.PI_DATEVALUETYPE 
                                                      AND IsConstant__c = true]; 
                                                      
            if(piconslist.size() > 0){
                for (SPE_PITempValue__c piTempcon:piconslist){
                    if (piTempcon.IsConstant__c)
                    {
                        indexConstantMap.put(piTempcon.Index__c, Decimal.valueOf(piTempcon.PIValue__c));
                        System.Debug('++++++++++++indexConstantMap+++++++++++++'+indexConstantMap);
                    } 
                }
            }                                                       
            
            for (SPE_PITempValue__c piTemp : [SELECT Index__c, KPIDefinition__c, PIValue__c, Mappingscope__c, IsConstant__c, 
                                              ValueType__c,EnterpriseId__c,EnterpriseIDEncrypted__c
                                              FROM SPE_PITempValue__c 
                                              WHERE KPIDefinition__c =: kpiDefinationID AND
                                              ValueType__c != :SPE_Constants.PI_DATEVALUETYPE 
                                              AND Mappingscope__c =: sc.KPI_Mappingscope__c])
            {                                       
                //valuestype = piTemp.ValueType__c;
                //PIValues = piTemp.PIValue__c;
                System.debug('Entered Here for Number');
                system.debug('PiTemp MappscopeKPI ::'+piTemp.Mappingscope__c);
                system.debug('intermedieate MappscopeKPI ::'+sc.KPI_Mappingscope__c);
                system.debug('piTemp ::'+piTemp);
                if (piTemp.PIValue__c == null)
                {
                    continue;
                }
                
                if (piTemp.IsConstant__c)
                {
                    indexConstantMap.put(piTemp.Index__c, Decimal.valueOf(piTemp.PIValue__c));
                    System.Debug('++++++++++++indexConstantMap+++++++++++++'+indexConstantMap);
                }
                else
                {                        
                    Map<String, Decimal> indexValuesMap = new Map<String, Decimal>();
                    
                    if (enterprisescopeKPIIndexValuesMap.get(piTemp.Mappingscope__c) != null )
                    {
                        indexValuesMap = enterprisescopeKPIIndexValuesMap.get(piTemp.Mappingscope__c);
                    }
                    
                    indexValuesMap.put(piTemp.Index__c,Decimal.valueOf(piTemp.PIValue__c));
                    System.Debug('++++++++++++indexValuesMap+++++++++++++'+indexValuesMap);                       
                    enterprisescopeKPIIndexValuesMap.put(piTemp.Mappingscope__c, indexValuesMap);
                    System.Debug('++++++++++++enterprisescopeKPIIndexValuesMap+++++++++++++'+enterprisescopeKPIIndexValuesMap);                   
                }   
                System.Debug('++++++++++++indexConstantMap+++++++++++++'+indexConstantMap);
            }
            
     for (String scopeKPI: enterprisescopeKPIIndexValuesMap.keyset())
     {    
        for(KPI_Calculation_Formula__c kpiformula: allkpiformulalist)
        {             
            //System.Debug('++++++++++++kpiformula.KPI_Expression__c+++++++++++++'+kpiformula.KPI_Expression__c);
            String conditionmet = '';                                                
            Map<String,Boolean> ConditionMatchResult = new Map<String,Boolean>();
            Boolean isSatisfied = False;
                                                                
            for(KPI_Calulation_Condition__c kpicond: newKPIFormulaConditionMap.get(kpiformula.ID)){
                    if(kpicond.Name != Null && kpicond.Operator__c!= Null){
                        ConditionMatchResult.put(kpicond.Name,SPE_ReversePolishAlgorithm.conditionComparision(enterprisescopeKPIIndexValuesMap.get(scopeKPI).get(kpicond.Name),kpicond.Value__c,kpicond.Operator__c));    
                        
                        if(conditionmet != ''){
                            if(kpicond.Operator__c != 'Null' && kpicond.Operator__c != 'Not Null'){
                                conditionmet = kpicond.Name+' '+kpicond.Operator__c+' '+kpicond.Value__c+' '+'&&'+' '+conditionmet;
                            }
                            else if(kpicond.Operator__c == 'Null' || kpicond.Operator__c == 'Not Null'){
                               conditionmet = kpicond.Name+' is '+kpicond.Operator__c+' '+'&&'+' '+conditionmet; 
                            } 
                        }
                        else{
                            if(kpicond.Operator__c != 'Null' && kpicond.Operator__c != 'Not Null'){
                                conditionmet = kpicond.Name+' '+kpicond.Operator__c+' '+kpicond.Value__c;
                            }
                            else if(kpicond.Operator__c == 'Null' || kpicond.Operator__c == 'Not Null'){
                                conditionmet = kpicond.Name+' is '+kpicond.Operator__c;
                            }
                        }    
                    }                                          
            }
            
            List<Boolean> mapValues = new List<Boolean>();
            mapValues = ConditionMatchResult.values();
            
            System.Debug('++++++++++++ConditionMatchResult.values()+++++++++++++'+ConditionMatchResult.values());
            
            Set<Boolean> matchMapValues = new Set<Boolean>();
            
            for(Boolean b:mapValues){
                matchMapValues.add(b);
            }
            
            if(!matchMapValues.contains(false)){
                isSatisfied = true;
            }
            
            System.Debug('++++++++++++isSatisfied +++++++++++++'+isSatisfied);
                                                           
            if(isSatisfied == true)
            {                                                                                        
                // actual expression                    
                List<Object> objectListActual = new List<Object>();
                
                Decimal valueActual = null;
                //Decimal valueElse = null;
                
                System.debug('-------------->'+kpiformula.KPI_Expression__c);
                
                if (kpiformula.KPI_Expression__c != null)
                {
                    for (String exp: kpiformula.KPI_Expression__c.split(','))
                    {
                        if (SPE_Utility.indexList.contains(exp))
                        { 
                            Decimal piAggregate = null;
                            
                            if (enterprisescopeKPIIndexValuesMap.get(scopeKPI).get(exp) != null)
                            {
                                piAggregate = enterprisescopeKPIIndexValuesMap.get(scopeKPI).get(exp);    
                            }
                            if (indexConstantMap.get(exp) != null)
                            {
                                piAggregate =  indexConstantMap.get(exp);
                            }
                            
                            System.debug('-------indexConstantMap.get(exp)------>'+indexConstantMap.get(exp));
                            System.debug('-------piAggregate------>'+piAggregate);
                            
                            objectListActual.add((Object)piAggregate);
                        }
                        
                        if (SPE_Utility.operatorList.contains(exp))
                        {
                            objectListActual.add(exp);
                        }
                    }
                    
                    System.debug('-------objectListActual------>'+objectListActual);
                    valueActual = objectListActual.isEmpty() ? null : SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual);
                    }                                            
                    System.Debug('++++++++++++valueActual +++++++++++++'+valueActual);                  
                    SPE_KPIValue__c kpiValue = new SPE_KPIValue__c ();
                    
                    kpiValue.KPIDefinition__c = kpiDefinationID;
                    //**********Changes Done As Part of Encryption************************//
                        //kpiValue.EnterpriseId__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                        kpiValue.EnterpriseIDEncrypted__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                    //*************************End*****************************************//
                    kpiValue.BusinessLine__c  = scopeKPI.split(';')[1] == null ? null : scopeKPI.split(';')[1];
                    kpiValue.BusinessUnit__c = scopeKPI.split(';')[2] == null ? null : scopeKPI.split(';')[2];
                    kpiValue.Category__c = scopeKPI.split(';')[3] == null ? null : scopeKPI.split(';')[3];
                    kpiValue.CategoryGroup__c = scopeKPI.split(';')[4] == null ? null : scopeKPI.split(';')[4];
                    kpiValue.Cluster__c = scopeKPI.split(';')[5] == null ? null : scopeKPI.split(';')[5];
                    kpiValue.Country__c = scopeKPI.split(';')[6] == null ? null : scopeKPI.split(';')[6];
                    kpiValue.Region__c = scopeKPI.split(';')[7] == null ? null : scopeKPI.split(';')[7];
                    kpiValue.SubRegion__c = scopeKPI.split(';')[8] == null ? null : scopeKPI.split(';')[8];
                    kpiValue.Project__c = scopeKPI.split(';')[9] == null ? null : scopeKPI.split(';')[9];
                    kpiValue.Product__c = scopeKPI.split(';')[10] == null ? null : scopeKPI.split(';')[10];
                    kpiValue.ExecutionPeriod__c = scopeKPI.split(';')[11] == null ? null : scopeKPI.split(';')[11]; //(scopeKPI.split(';')[8] == null && Date.valueOf(scopeKPI.split(';')[8]) == null)  ? null : Date.valueOf(scopeKPI.split(';')[8]);
                    KpiValue.Period__c= sc.KPI__r.Adhoc_Date__c;
                    kpiValue.Actual_Formula__c = kpiformula.KPI_Formula__c;
                    kpiValue.IdentifierParam__c = kpiidentifier;                    
                    kpiValue.KPIValue__c = valueActual;    
                    kpiValue.Actual_Condition__c = conditionmet;
                    kpiValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpiDefinationID) != null && kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) != null) ? kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) : '';
    
                    toBeInsertedKPIValues.add (kpiValue);
                                            
                    toBeDeletedKPIValues.add(kpiValue.ExecutionPeriod__c);
                    exec = kpiValue.ExecutionPeriod__c;
                    break;
                    }
                    else if(isSatisfied == False){
                        
                        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c ();                        
                        kpiValue.KPIDefinition__c = kpiDefinationID;
                        //**********Changes Done As Part of Encryption************************//
                            //kpiValue.EnterpriseId__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                            kpiValue.EnterpriseIDEncrypted__c = scopeKPI.split(';')[0] == null ? null : scopeKPI.split(';')[0];
                        //*************************End*****************************************//
                        kpiValue.BusinessLine__c  = scopeKPI.split(';')[1] == null ? null : scopeKPI.split(';')[1];
                        kpiValue.BusinessUnit__c = scopeKPI.split(';')[2] == null ? null : scopeKPI.split(';')[2];
                        kpiValue.Category__c = scopeKPI.split(';')[3] == null ? null : scopeKPI.split(';')[3];
                        kpiValue.CategoryGroup__c = scopeKPI.split(';')[4] == null ? null : scopeKPI.split(';')[4];
                        kpiValue.Cluster__c = scopeKPI.split(';')[5] == null ? null : scopeKPI.split(';')[5];
                        kpiValue.Country__c = scopeKPI.split(';')[6] == null ? null : scopeKPI.split(';')[6];
                        kpiValue.Region__c = scopeKPI.split(';')[7] == null ? null : scopeKPI.split(';')[7];
                        kpiValue.SubRegion__c = scopeKPI.split(';')[8] == null ? null : scopeKPI.split(';')[8];
                        kpiValue.Project__c = scopeKPI.split(';')[9] == null ? null : scopeKPI.split(';')[9];
                        kpiValue.Product__c = scopeKPI.split(';')[10] == null ? null : scopeKPI.split(';')[10];
                        kpiValue.ExecutionPeriod__c = scopeKPI.split(';')[11] == null ? null : scopeKPI.split(';')[11]; //(scopeKPI.split(';')[8] == null && Date.valueOf(scopeKPI.split(';')[8]) == null)  ? null : Date.valueOf(scopeKPI.split(';')[8]);
                        KpiValue.Period__c= sc.KPI__r.Adhoc_Date__c;
                        kpiValue.Actual_Formula__c = Null;
                        kpiValue.KPIValue__c = Null;
                        kpiValue.IdentifierParam__c = kpiidentifier;
                        //kpiValue.KPI_Text_Value__c = '';
                        kpiValue.Actual_Condition__c = 'No Conditions Met';
                        kpiValue.SurveyComments__c = (kpiEnterpriseCommentsMap.get(kpiDefinationID) != null && kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) != null) ? kpiEnterpriseCommentsMap.get(kpiDefinationID).get(kpiValue.EnterpriseIDEncrypted__c) : '';
        
                        toBeInsertedKPIValues.add(kpiValue);
                                                                         
                        toBeDeletedKPIValues.add(kpiValue.ExecutionPeriod__c);
                        exec = kpiValue.ExecutionPeriod__c;
                    }
                 }                                          
             } 
                   
        delete [SELECT Id FROM SPE_KPIValue__c WHERE ExecutionPeriod__c In: toBeDeletedKPIValues AND KPIDefinition__c =: kpiDefinationID AND IdentifierParam__c != :kpiidentifier limit 9999];
        
        Map<String,SPE_KPIValue__c> duplicateKpiCheck =  new Map<String,SPE_KPIValue__c>();
        for(SPE_KPIValue__c kpiVal :toBeInsertedKPIValues){
            duplicateKpiCheck.put(kpiVal.EnterpriseIDEncrypted__c+kpiVal.BusinessUnit__c+kpiVal.BusinessLine__c+kpiVal.Category__c+kpiVal.CategoryGroup__c+kpiVal.Cluster__c+kpiVal.Country__c+kpiVal.Region__c+kpiVal.SubRegion__c+kpiVal.Project__c+kpiVal.Product__c+kpiVal.ExecutionPeriod__c,kpiVal);
        }
        
        list<SPE_KPIValue__c> toInsertKPIvalues = duplicateKpiCheck.values();            
        
        System.Debug(Logginglevel.ERROR,'******toInsertKPIvalues*****'+toInsertKPIvalues.size());
        try{
            insert toInsertKPIvalues;                                
        }catch(exception e){}
      }  
    }          
    global void finish(Database.BatchableContext BC){
        Id kpiId = kpiDefinationID;
         //*********************Changes For Encryption*****************//
             //String KpiName= [select Name from SPE_KPIDefinition__c where Id=: kpiId].name;
             String KpiName= [select KPI_Title__c from SPE_KPIDefinition__c where Id=: kpiId].KPI_Title__c;
         //*****************END********************//
        
        String AbbName= [select AbbreviatedName__c from SPE_KPIDefinition__c where Id=: kpiId].AbbreviatedName__c;
        String userEmail =String.valueof(Userinfo.getUserEmail());
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        String[] toAddresses = new String[] {userEmail}; 
        mail.setToAddresses(toAddresses); 
        string tab='';
        
        //List<AggregateResult> totalKPIValuesList = [SELECT Count(ID) total,ExecutionPeriod__c execution FROM SPE_KPIValue__c WHERE KPIDefinition__c =: kpiId group by ExecutionPeriod__c];
        /*for(AggregateResult ar : [SELECT Count(ID) total,ExecutionPeriod__c execution FROM SPE_KPIValue__c WHERE KPIDefinition__c =: kpiId group by ExecutionPeriod__c]){
            system.debug('result---' + ar.get('expr0'));
        }*/
        
        for(AggregateResult ar: [SELECT Count(ID) total,ExecutionPeriod__c execution FROM SPE_KPIValue__c WHERE KPIDefinition__c =: kpiId group by ExecutionPeriod__c]){
            tab=tab+'<tr><td>'+String.valueof(ar.get('execution'))+'</td><td>'+Integer.valueof(ar.get('total'))+'</td></tr>';
        }
     
        mail.setSubject(System.Label.SPE_MailSubjectBatch5); 
        mail.setHtmlBody('Hi,<br/><br/>'+
                            'KPI-<b>'+KpiName+'</b>,KPI Abbreviation-<b>'+AbbName+'</b> Adhoc schedule triggered by <b>'+String.valueof(UserInfo.getFirstName())+' '+String.valueof(UserInfo.getLastName())+ '</b> is completed; See the below table for execution summary.<br/><br/>'+
                                  '<table border="1"><tr><td bgcolor="#337AB7">KPI Period*</td><td bgcolor="#337AB7">No. Of Records Created*</td></tr>'+
                                      tab+
                                      '</table><br/></br/>No. Of records Created* = They are total number of records created fresh and replaced over existing records<br/>'+
                                       'KPI Period* = If some months are not available in the table in reference to your Adhoc time range; No data was found for those months hence zero records created<br/><br/>'+
                                        'Thanks and Regards,<br/>SPE Scorecard Tool');
        
        Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        
        if(!Test.isRunningTest()){
            SPE2_DeleteKPIIntermediate dBatch = new SPE2_DeleteKPIIntermediate(kpiId);
            database.executebatch(dBatch,1000);
        }
    }
}