public class  SPE_SurveyKPI 
{
    public Map<Id, List<ResponseWrapper>> responseWrapperSupplierMap {get;set;}
    
    public Map<Id, String> supplierNameMap {get;set;}
    
    public SPE_SPEPlan__c spePlan {get;set;}
    
    public SPE_SPETracker__c tracker {get;set;}   
    
    public Boolean isExpire {get;set;}
    
    public Boolean isSuveyFilled {get;set;}
    
    public Boolean isDataAvailable {get;set;}
    
    public Contact contact {get;set;}
    
    public String toDate{get;set;}
    
    public String fromDate{get;set;}
    
    private Map<Id, SPE_SPEKPIMap__c> kpiPIMap = new Map<Id, SPE_SPEKPIMap__c>();
    private Map<Id, List<SPE_KPICalculation__c>> kpiKPICalculationMap = new Map<Id, List<SPE_KPICalculation__c>>();
    private Map<Id, List<SPE_KPICalculation__c>> piKPICalListMap = new Map<Id, List<SPE_KPICalculation__c>>();
        
        
        
    private Map<Id, List<SPE_SurveyAnswer__c>> queAnswersMap = new Map<Id, List<SPE_SurveyAnswer__c>>();
    
    private Map<Id, SPE_SurveyQuestion__c> surveyQuestionMap = new Map<Id, SPE_SurveyQuestion__c>();
    
    private Map<Id, Set<Id>> kpiQueMap = new Map<Id, Set<Id>>();
    
    private Set<Id> contactIds;
    
    public String PageName; 
    
    public List<SPE_TrackerRespondent__c> trackerRespList = new List<SPE_TrackerRespondent__c>();
    
    public SPE_SurveyKPI()
    {       
        initialize();       
    }
    @Testvisible
    private Boolean initialize()
    {   
        PageName=ApexPages.currentPage().getUrl();
        PageName=PageName.substringAfterLast('/');
        PageName=PageName.substringBefore('?');
        
        System.debug('PageName' + PageName); 
        
        isSuveyFilled = false;
        isExpire = false;
        isDataAvailable = false;
        Boolean isSurveyView = true;
        
        SPE_TrackerRespondent__c trackerRespondent = new SPE_TrackerRespondent__c();
        
                   
        spePlan = [SELECT Id, Name, SPETemplate__c,StartDate__c ,Country__c, Project__c, CategoryCluster__c, CategoryGroup__c, Category__c, Region__c,
                            SubRegion__c, BusinessUnit__c, BusinessLine__c, Product__c, FrequencyInMonths__c
                   FROM SPE_SPEPlan__c 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
        
        if(PageName != SPE_Constants.SPE_SURVEYKPIVIEWPAGE)
        {
            tracker = [SELECT Id, Name, SPEPlan__c,DateOfExecution__c,SPEPlan__r.FrequencyInMonths__c, SPETemplate__c, NewExecution__c, SPEPlan__r.Stage__c,
                        CategoryCluster__c, CategoryGroup__c, Category__c, Region__c, SubRegion__c, Country__c, Project__c, BusinessUnit__c, BusinessLine__c, Product__c
                       FROM SPE_SPETracker__c 
                       WHERE Id =: ApexPages.currentPage().getParameters().get('trackerId')];
            
            contact = [SELECT Id, Name 
                       FROM Contact 
                       WHERE Id =: ApexPages.currentPage().getParameters().get('conId')];
            
            trackerRespondent = [SELECT ForceSurvey__c FROM SPE_TrackerRespondent__c 
                                                       WHERE SPE_Tracker__c =: tracker.Id AND Contact__c =: contact.Id];
        
              
            List<SPE_Respondent__c> SPERespList=new List<SPE_Respondent__c>([select Contact__c,id,SPEPlan__c from SPE_Respondent__c where SPEPlan__c = :ApexPages.currentPage().getParameters().get('id') AND Contact__c=:ApexPages.currentPage().getParameters().get('conId')]);            
            
            Integer toBeaddedMonths = tracker.SPEPlan__r.FrequencyInMonths__c == null ? 1 :  Integer.valueOf(tracker.SPEPlan__r.FrequencyInMonths__c);
           
            Date fromDateTemp = tracker.DateOfExecution__c.addMonths(-(toBeaddedMonths));
            Date toDateTemp = tracker.DateOfExecution__c.addMonths(-1);
            
            fromDate = SPE_Utility.monthsMap.get(fromDateTemp.month()) + ' - '+ String.valueOf(fromDateTemp.year());
            toDate = SPE_Utility.monthsMap.get(toDateTemp.month()) + ' - '+ String.valueOf(toDateTemp.year());          
            if (isSuveyFilled())
            {
                isSuveyFilled = true;
                return isSuveyFilled;
            }  
            
            if (tracker.NewExecution__c < System.today() || SPERespList.size()<=0 || tracker.SPEPlan__r.Stage__c == 'Obsolete')
            {
                isExpire = true;
                return isExpire;
            }   
            
            isSurveyView = false;      
        }
        
        
        
        Set<Id> kpiDefinitions = new Set<Id>();
        
        Set<Id> kpiDefinitions1 = new Set<Id>();
        
        for (SPE_SPEKPIMap__c speKPIMap : [SELECT Id, SPETemplate__c, KPIDefinition__c ,KPIDefinition__r.SurveyBased__c, KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c, KPIDefinition__r.PI_Data__c,
                                          KPIDefinition__r.PI_Data__r.SurveyQuestion__c, KPIDefinition__r.Name 
                                        From SPE_SPEKPIMap__c 
                                        WHERE SPE_SPEKPIMap__c.SPETemplate__c =: spePlan.SPETemplate__c])
        {
            kpiDefinitions.add(speKPIMap.KPIDefinition__c);
            
            if (speKPIMap.KPIDefinition__r.PI_Data__c != null && 
                speKPIMap.KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c == 'Survey')
            {
                kpiDefinitions1.add(speKPIMap.KPIDefinition__c);
                kpiPIMap.put(speKPIMap.KPIDefinition__c, speKPIMap);
            } 
        }
        
        Set<Id> questionsId = new Set<Id>();
        
         //**********************Changes For Encryption*******************//
        
        /*List<SPE_KPICalculation__c> kpiCalculations = [SELECT Id, SurveyQuestion__c, KPIDefinition__c, KPIDefinition__r.Name, PIDefination__c,PIDefination__r.ValuesType__c,PIDefination__r.SurveyQuestion__c 
                                                       FROM SPE_KPICalculation__c 
                                                       WHERE KPIDefinition__c In:kpiDefinitions AND PIDefination__r.SurveyQuestion__c != null AND PIDefination__r.DataAcquisitionMethod__c = 'Survey'];*/
        
        List<SPE_KPICalculation__c> kpiCalculations = [SELECT Id, SurveyQuestion__c, KPIDefinition__c, KPIDefinition__r.Name, KPIDefinition__r.KPI_Title__c, PIDefination__c,PIDefination__r.ValuesType__c,PIDefination__r.SurveyQuestion__c 
                                                       FROM SPE_KPICalculation__c 
                                                       WHERE KPIDefinition__c In:kpiDefinitions AND PIDefination__r.SurveyQuestion__c != null AND PIDefination__r.DataAcquisitionMethod__c = 'Survey'];
        //***********************END*************************//
        
        for(SPE_KPICalculation__c kpiCalculat : kpiCalculations)
        {
            kpiDefinitions1.add(kpiCalculat.KPIDefinition__c);
        }
        
        Set<Id> piIds = new Set<Id>();
        Map<Id, SPE_KPICalculation__c> piKPICalMap = new Map<Id, SPE_KPICalculation__c>();
        Set<Id> dupPIProcesses = new Set<Id>();
        
        If(kpiDefinitions1.size()>0)
        {
            for (SPE_KPICalculation__c kpiCal: kpiCalculations)
            {
                if (piIds.contains(kpiCal.PIDefination__c))
                {
                    List<SPE_KPICalculation__c> kpiCallistDup = new List<SPE_KPICalculation__c>();
                    if (piKPICalListMap.get(kpiCal.PIDefination__c) != null)
                    {
                        kpiCallistDup = piKPICalListMap.get(kpiCal.PIDefination__c);
                    }
                    else
                    {
                        kpiCallistDup.add(piKPICalMap.get(kpiCal.PIDefination__c));
                    }
                    kpiCallistDup.add(kpiCal);
                    piKPICalListMap.put(kpiCal.PIDefination__c, kpiCallistDup);
                    continue;
                }
                piIds.add(kpiCal.PIDefination__c);
                
                piKPICalMap.put(kpiCal.PIDefination__c, kpiCal);
                
                questionsId.add(kpiCal.PIDefination__r.SurveyQuestion__c);
                
                Set<Id> queIds = new Set<Id> ();
                
                List<SPE_KPICalculation__c> kpiCallist = new List<SPE_KPICalculation__c>();
                
                if (kpiQueMap.get(kpiCal.KPIDefinition__c) !=null)
                {
                    queIds = kpiQueMap.get(kpiCal.KPIDefinition__c);
                }
                
                if (kpiKPICalculationMap.get(kpiCal.KPIDefinition__c) != null)
                {
                    kpiCallist = kpiKPICalculationMap.get(kpiCal.KPIDefinition__c);
                }
                
                queIds.add(kpiCal.PIDefination__r.SurveyQuestion__c);
                kpiCallist.add(kpiCal);
                
                kpiQueMap.put(kpiCal.KPIDefinition__c, queIds);
                kpiKPICalculationMap.put(kpiCal.KPIDefinition__c, kpiCallist);
            }
        
            // **************** pi = kpi //
            for (SPE_SPEKPIMap__c speKPIMap : [SELECT Id, SPETemplate__c, KPIDefinition__c ,KPIDefinition__r.SurveyBased__c, KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c, KPIDefinition__r.PI_Data__c,
                                                KPIDefinition__r.PI_Data__r.SurveyQuestion__c
                                        From SPE_SPEKPIMap__c 
                                        WHERE SPE_SPEKPIMap__c.SPETemplate__c =: spePlan.SPETemplate__c])
            {
                if (speKPIMap.KPIDefinition__r.PI_Data__c != null && 
                    speKPIMap.KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c == 'Survey')
                {
                    piIds.add(speKPIMap.KPIDefinition__r.PI_Data__c);
                    
                    questionsId.add(speKPIMap.KPIDefinition__r.PI_Data__r.SurveyQuestion__c);
                    kpiQueMap.put(speKPIMap.KPIDefinition__c, questionsId);
                } 
            }
            // **************** pi = kpi //
       
            List<SPE_SurveyQuestion__c> sueveyQuestion = [SELECT Id, IsRequired__c, PIDefinition__c, SurveyQuestion__c, AnswerType__c 
                                                          FROM SPE_SurveyQuestion__c
                                                          WHERE Id In: questionsId];
            
            for (SPE_SurveyQuestion__c surQue : sueveyQuestion)
            {
                surveyQuestionMap.put(surQue.Id, surQue);
            }
            
            responseWrapperSupplierMap = new Map<Id, List<responseWrapper>>();
            supplierNameMap = new Map<Id, String>();
            
            List<SPE_SPEPlanSupplierMap__c> supplier = [SELECT Supplier__c, Supplier__r.Name, Supplier__r.EnterpriseId__c 
                                                        FROM SPE_SPEPlanSupplierMap__c
                                                        WHERE SPEPlan__c =: spePlan.Id];
            
            List<SPE_SurveyAnswer__c> surAnsList = [SELECT Id, Choices__c, SurveyQuestion__c, Score__c
                                                    FROM SPE_SurveyAnswer__c 
                                                    WHERE SurveyQuestion__c In: sueveyQuestion];
            
            for (SPE_SurveyAnswer__c ans : surAnsList)
            {
                List<SPE_SurveyAnswer__c> newAns = new List<SPE_SurveyAnswer__c>();
                
                if (queAnswersMap.get(ans.SurveyQuestion__c) != null)
                {
                    newAns = queAnswersMap.get(ans.SurveyQuestion__c);
                }
                
                newAns.add(ans);
                queAnswersMap.put(ans.SurveyQuestion__c, newAns);
            }
            
            Map<String, Map<Id, Boolean>> enterprisePIDataIsSurveyExecuteMap =  surveyExecuteForEnterpriseIds(tracker, trackerRespondent, isSurveyView, spePlan);
            
            for (SPE_SPEPlanSupplierMap__c sup : supplier)
            { 
                Map<Id, Boolean> enterpriseIsSurveyExecuteMap = enterprisePIDataIsSurveyExecuteMap.get(sup.Supplier__r.EnterpriseId__c);
                
                Boolean isSurveyForEnterpriseId = false;
                
                for (Boolean piId : enterpriseIsSurveyExecuteMap.values())
                {
                    if (piId)
                    {
                        isSurveyForEnterpriseId = true;
                        continue;
                    }
                }
        
                if (isSurveyForEnterpriseId)
                {
                    responseWrapperSupplierMap.put(sup.Supplier__c, suplierResponseWrapperList(sup.Supplier__c, sup.Supplier__r.EnterpriseId__c, kpiDefinitions1, sueveyQuestion , enterpriseIsSurveyExecuteMap));
                 
                    supplierNameMap.put(sup.Supplier__c, sup.Supplier__r.Name);
                }
            }
            
            if (responseWrapperSupplierMap.size() == 0)
            {
                isDataAvailable = true;
            }
        
        }
        
       return isExpire;
    }
    
    private List<ResponseWrapper> suplierResponseWrapperList (Id suppId, String enterpriseId, Set<Id> kpiDefIds, List<SPE_SurveyQuestion__c> quesList, Map<Id, Boolean> enterpriseIsSurveyExecuteMap)
    {
        List<ResponseWrapper> responseWrapperList =  new List<ResponseWrapper>();
       
        for (Id kpiId : kpiDefIds)
        {
          
            if (kpiKPICalculationMap.get(kpiId) == null && kpiPIMap.get(kpiId) == null)
            {
                continue;
            }
            if (kpiKPICalculationMap.get(kpiId) != null )
            {
              for (SPE_KPICalculation__c kpiCal : kpiKPICalculationMap.get(kpiId))
              {
                  if (enterpriseIsSurveyExecuteMap.get(kpiCal.PIDefination__c) == false)
                  {
                      //continue;
                  }
                  
                  ResponseWrapper rw = new ResponseWrapper();
                  
                  // ******************* //
                  rw.isAnswerVisible = enterpriseIsSurveyExecuteMap.get(kpiCal.PIDefination__c);
                  // *******************//
                  
                  rw.surQue = surveyQuestionMap.get(kpiCal.PIDefination__r.SurveyQuestion__c);
                  rw.suppId = suppId;
                  rw.enterpriseId = enterpriseId;
                  rw.kpiId = kpiCal.KPIDefinition__c;
                  rw.piId = kpiCal.PIDefination__c;
                  //****************Changes For Encryption*************//
                    //rw.kpiName = kpiCal.KPIDefinition__r.Name;
                    rw.kpiName = kpiCal.KPIDefinition__r.KPI_Title__c;
                  //********************END***************//
                  
                  if (piKPICalListMap.get(kpiCal.PIDefination__c) != null)
                  {
                      List<SPE_KPICalculation__c> kpicalDupl = piKPICalListMap.get(kpiCal.PIDefination__c);
                      for (SPE_KPICalculation__c cal : kpicalDupl)
                      {
                          if (cal.id != kpiCal.Id)
                          {
                              //****************Changes For Encryption*************//
                                //rw.kpiName = rw.kpiName + ' / ' + cal.KPIDefinition__r.Name;
                                rw.kpiName = rw.kpiName + ' / ' + cal.KPIDefinition__r.KPI_Title__c;
                              //********************END***************//
                          }
                      }
                  }
                  rw.surAns = queAnswersMap.get(kpiCal.PIDefination__r.SurveyQuestion__c);
                  
                  rw.renderPicklist = false;
                  rw.booleanData = false;
                  rw.renderDate = false;
                  rw.renderFreeText = false;
                  rw.renderStringFreeText = false;
                  rw.isSkip = false;
                  
                  if (surveyQuestionMap.get(kpiCal.PIDefination__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYPICKLIST)
                  {
                      rw.selectAns = selectOptionAns(queAnswersMap.get(kpiCal.PIDefination__r.SurveyQuestion__c), rw.surQue.IsRequired__c);
                      rw.renderPicklist = true;
                  }
                  else if(surveyQuestionMap.get(kpiCal.PIDefination__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYFREETEXT && kpiCal.PIDefination__r.ValuesType__c == SPE_Constants.PI_BOOLEANVALUETYPE)
                  {
                      rw.booleanData = true;
                  }
                  
                  else if(surveyQuestionMap.get(kpiCal.PIDefination__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYFREETEXT && kpiCal.PIDefination__r.ValuesType__c == SPE_Constants.PI_DATEVALUETYPE)
                  {
                      rw.renderDate = true;
                  }
                  else if(surveyQuestionMap.get(kpiCal.PIDefination__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYFREETEXT && kpiCal.PIDefination__r.ValuesType__c == SPE_Constants.PI_NUMBERVALUETYPE)
                  {
                      rw.renderFreeText = true;
                  }
                  
                  else if(surveyQuestionMap.get(kpiCal.PIDefination__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYFREETEXT && kpiCal.PIDefination__r.ValuesType__c == SPE_Constants.PI_STRINGVALUETYPE)
                  {
                      rw.renderStringFreeText = true;
                  }
                  
                  responseWrapperList.add(rw);                                        
              }
          }
            
            if (kpiPIMap.get(kpiId) != null)
            {
                SPE_SPEKPIMap__c speKPIMap = kpiPIMap.get(kpiId);
            
        ResponseWrapper rw = new ResponseWrapper();
                
                // ******************* //
                rw.isAnswerVisible = enterpriseIsSurveyExecuteMap.get(speKPIMap.KPIDefinition__r.PI_Data__c);
                // *******************//
                
                rw.surQue = surveyQuestionMap.get(speKPIMap.KPIDefinition__r.PI_Data__r.SurveyQuestion__c);
                rw.suppId = suppId;
                rw.enterpriseId = enterpriseId;
                rw.kpiId = speKPIMap.KPIDefinition__c;
                rw.piId = speKPIMap.KPIDefinition__r.PI_Data__c;
                rw.kpiName = speKPIMap.KPIDefinition__r.Name;
                
                rw.surAns = queAnswersMap.get(speKPIMap.KPIDefinition__r.PI_Data__r.SurveyQuestion__c);
                
                rw.renderPicklist = false;
                rw.booleanData = false;
                rw.renderDate = false;
                rw.renderFreeText = false;
                rw.renderStringFreeText = false;
                rw.isSkip = false;
                
                if (surveyQuestionMap.get(speKPIMap.KPIDefinition__r.PI_Data__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYPICKLIST)
                {
                    rw.selectAns = selectOptionAns(queAnswersMap.get(speKPIMap.KPIDefinition__r.PI_Data__r.SurveyQuestion__c), rw.surQue.IsRequired__c);
                    rw.renderPicklist = true;
                }
                else if(surveyQuestionMap.get(speKPIMap.KPIDefinition__r.PI_Data__r.SurveyQuestion__c).AnswerType__c == SPE_Constants.SURVEYFREETEXT )
                {
                    rw.renderFreeText = true;
                }
                
                responseWrapperList.add(rw);
            }
    }
        
        return responseWrapperList;
    }
    
    public static Map<String, Map<Id, Boolean>> surveyExecuteForEnterpriseIds(SPE_SPETracker__c speTracker, SPE_TrackerRespondent__c trackerRespondent, Boolean isSurveyView, SPE_SPEPlan__c plan)
    {
        
        
        Map<String, Boolean> enterpriseIsSurveyExecuteMap = new Map<String, Boolean>();
        
        Map<String, Map<Id, Boolean>> enterprisePIDataIsSurveyExecuteMap = new Map<String, Map<Id, Boolean>>();
        
        Boolean isSurveyExecute = true;
        
        Set<Id> kpiDefinationIds = new Set<Id>();
        
        Set<Id> piDefinationIds = new Set<Id>();
        
        
        //*******************Changes for Encryption*******************//
        
        Set<String> enterpriseIds = new  Set<String>();
        Set<ID> enterpriseIdsencrypted = new  Set<ID>(); //*************New Line Added for Encryption***********//
        
        for (SPE_SPEPlanSupplierMap__c speSup : [SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c 
                                                FROM SPE_SPEPlanSupplierMap__c
                                                WHERE SPEPlan__c =: plan.Id ])
        {
            enterpriseIds.add(speSup.Supplier__r.EnterpriseId__c);
            enterpriseIdsencrypted.add(speSup.Supplier__c); //*************New Line Added for Encryption***********//
            enterpriseIsSurveyExecuteMap.put(speSup.Supplier__r.EnterpriseId__c, true);
        }
        //*******************Changes END*******************//
        
        Map<Id, Decimal> piAggregationDurationMap = new Map<Id, Decimal>();
        
        for (SPE_SPEKPIMap__c speKPI : [SELECT Id, KPIDefinition__c, KPIDefinition__r.PI_Data__c, KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c FROM SPE_SPEKPIMap__c WHERE SPE_SPEKPIMap__c.SPETemplate__c =: plan.SPETemplate__c])
        {
            kpiDefinationIds.add(speKPI.KPIDefinition__c);
            
            if (speKPI.KPIDefinition__r.PI_Data__c != null && 
                speKPI.KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c == 'Survey')
            {
                piDefinationIds.add(speKPI.KPIDefinition__r.PI_Data__c);
                
                piAggregationDurationMap.put(speKPI.KPIDefinition__r.PI_Data__c, 0);
            }        
        }
        
        
        for (SPE_KPICalculation__c kpiCal : [SELECT Id, KPIDefinition__c, PIDefination__c, TimeFrame__c FROM SPE_KPICalculation__c 
                                             WHERE KPIDefinition__c IN : kpiDefinationIds 
                                                   AND PIDefination__c != null 
                                                   AND PIDefination__r.DataAcquisitionMethod__c = 'Survey' ])
        {   
            piDefinationIds.add(kpiCal.PIDefination__c);
            
            piAggregationDurationMap.put(kpiCal.PIDefination__c, kpiCal.TimeFrame__c);
            
        }
        
        for (String eId : enterpriseIds)
        {
            Map<Id, Boolean> piDataIsSurveyExecuteMap = new Map<Id, Boolean>();
            for (Id piId : piDefinationIds)
            {
                piDataIsSurveyExecuteMap.put(piId, true);
            }
            enterprisePIDataIsSurveyExecuteMap.put(eId, piDataIsSurveyExecuteMap);
        }
        
        // return if the force survey clicked
        
        if (isSurveyView || trackerRespondent.ForceSurvey__c)
        {
            return enterprisePIDataIsSurveyExecuteMap;
        }
        
        Decimal maxTimeDuration = 1;
        
        for (Decimal d: piAggregationDurationMap.values())
        {
            maxTimeDuration = math.max(maxTimeDuration, d);
        }
        
        maxTimeDuration = maxTimeDuration - 1;
        
        Date speDate = speTracker.DateOfExecution__c.addMonths(-1);
        
        
        Integer numberOfDays = Date.daysInMonth(speDate.year(), speDate.month());
        
        
        Date endSPEDate = Date.newInstance(speDate.year(), speDate.month(), numberOfDays);
        
        Date startSPEDate1 = speDate.addMonths(-(Integer.valueOf(maxTimeDuration)));
        
        Date startSPEDate = Date.newInstance(startSPEDate1.year(), startSPEDate1.month(), 1);
        
        Set<String> surveyNeedToBeExecute = new Set<String>();
        
        //****************Changes For Encryption******************//
        /*for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                                    Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c, EnterpriseID__c 
                                   FROM SPE_PIValues__c 
                                   WHERE PIDefination__c In : piDefinationIds 
                                   AND EnterpriseID__c In: enterpriseIds
                                   AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])*/
        for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                                    Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c, EnterpriseID__c 
                                   FROM SPE_PIValues__c 
                                   WHERE PIDefination__c In : piDefinationIds 
                                   AND EnterpriseIDEncrypted__c In: enterpriseIdsencrypted
                                   AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])
        
        //******************************END**************************//
        {
            
            Decimal piDuration = piAggregationDurationMap.get(kv.PIDefination__c);
            piDuration = piDuration + 1;
            
            Date speDate1 = speDate.addMonths(-(Integer.valueOf(piDuration)));
            
            Date newStartSPEDate = Date.newInstance(speDate1.year(), speDate1.month(), 1);
            
            if (kv.SPETracker__c == speTracker.Id)
            {
                enterpriseIsSurveyExecuteMap.put(kv.EnterpriseId__c, true);
            
                surveyNeedToBeExecute.add(kv.EnterpriseId__c);
                
                // *************************** //
                Map<Id, Boolean> piDataIsSurveyExecuteMap = enterprisePIDataIsSurveyExecuteMap.get(kv.EnterpriseId__c);
                for (Id piId : piDataIsSurveyExecuteMap.keySet())
                {
                    if (kv.PIDefination__c == piId)
                    {
                        piDataIsSurveyExecuteMap.put(piId, true);
                    }
                }
                
                enterprisePIDataIsSurveyExecuteMap.put(kv.EnterpriseId__c, piDataIsSurveyExecuteMap);
                // ************************** //
                
            }
            
            if (surveyNeedToBeExecute.contains(kv.EnterpriseID__c))
            {
                continue;
            }
            
            if (kv.Period__c < newStartSPEDate)
            {
                continue;
            }
        
            if ((true) &&
                ( (speTracker.CategoryCluster__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c || kv.Cluster__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c || kv.Cluster__c == speTracker.CategoryCluster__c) && 
                  (speTracker.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c || kv.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c || kv.CategoryGroup__c == speTracker.CategoryGroup__c) &&
                  (speTracker.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c || kv.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c || kv.Category__c == speTracker.Category__c)
                ) &&
                ( (speTracker.Region__c == PicklistDefaultValues__c.getall().values()[0].Market__c || kv.Region__c== PicklistDefaultValues__c.getall().values()[0].Market__c || kv.Region__c == speTracker.Region__c) &&
                  (speTracker.SubRegion__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c || kv.SubRegion__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c || kv.SubRegion__c == speTracker.SubRegion__c) &&
                  (speTracker.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c || kv.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c || kv.Country__c == speTracker.Country__c) &&
                  (speTracker.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c || kv.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c || kv.Project__c == speTracker.Project__c)
                ) &&
                ( (speTracker.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c || kv.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c || kv.BusinessUnit__c == speTracker.BusinessUnit__c) &&
                  (speTracker.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c || kv.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c || kv.BusinessLine__c == speTracker.BusinessLine__c) &&
                  (speTracker.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c || kv.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c || kv.Product__c == speTracker.Product__c)
                )
               )
            {
                enterpriseIsSurveyExecuteMap.put(kv.EnterpriseId__c, false);
                
                // *************************** //
                Map<Id, Boolean> piDataIsSurveyExecuteMap = enterprisePIDataIsSurveyExecuteMap.get(kv.EnterpriseId__c);
                for (Id piId : piDataIsSurveyExecuteMap.keySet())
                {
                    if (kv.PIDefination__c == piId)
                    {
                        piDataIsSurveyExecuteMap.put(piId, false);
                    }
                }
                
                enterprisePIDataIsSurveyExecuteMap.put(kv.EnterpriseId__c, piDataIsSurveyExecuteMap);
                // ************************** //
            }
        }
        
        return enterprisePIDataIsSurveyExecuteMap;
        //return isSurveyExecute;
    }   
    
    private List<SelectOption> selectOptionAns( List<SPE_SurveyAnswer__c> surAnsList, Boolean IsRequired)
    {
        List<SelectOption> ansOptions = new List<SelectOption>();
        ansOptions.add (new SelectOption('', '--None--'));
        for (SPE_SurveyAnswer__c optAns : surAnsList)
        {
            ansOptions.add (new SelectOption(optAns.Id, optAns.Choices__c));
        }
        
        return ansOptions;
    }
    
    private Boolean isSuveyFilled()
    {
        List<SPE_TrackerRespondent__c> surveyResponses = [SELECT Id 
                                                          From SPE_TrackerRespondent__c
                                                          WHERE SPE_Tracker__c =: tracker.Id AND Contact__c =: contact.Id AND IsResponseReceived__c = true];
    
        if (surveyResponses.size() > 0)
        {
            return true;
        }
        return false;
    }
    
    public Pagereference submit()
    {
        if  (isSuveyFilled())
        {
            Pagereference pg = Page.SPE_ConsequenceManagementThankyouPage;
            return pg;  
        }
        
        contactIds = new Set<Id>();
        
        List<SPE_SurveyResponse__c> toBeInsertedSurveyresponse = new List<SPE_SurveyResponse__c>();
      
        List<SPE_PIValues__c> toBeInsertedPIValues = new List<SPE_PIValues__c>();
        
        List<SPE_SurveyResponse__c> toBeAddedSurveyresponse = new List<SPE_SurveyResponse__c>();
        
        List<SPE_PIValues__c> toBeAddedPIValues = new List<SPE_PIValues__c>();
     
        Map<Id, List<ResponseWrapper>> responseWrapperQuestionMap = new Map<Id, List<ResponseWrapper>>();
        
        List<SPE_SurveyResponse__c> submittedResponses = [SELECT Id , SPETracker__c , Respondent__c FROM SPE_SurveyResponse__c WHERE SPETracker__c =: tracker.Id AND Respondent__c =: contact.Id];
        
        for(SPE_SurveyResponse__c sr: submittedResponses)
        {
            //contactIds.add(sr.Respondent__c);
        }
        
        for (List<ResponseWrapper> rwList : responseWrapperSupplierMap.values())
        {   
            
            for (ResponseWrapper rw: rwList)
            {   
                if (rw.isAnswerVisible && rw.surQue.IsRequired__c == true && rw.isSkip == false && 
                    (( (rw.ansId == null) && rw.renderPicklist) || 
                     ((rw.textAreaData == null || rw.textAreaData =='')&& rw.renderFreeText) ||
                     (rw.dateData == null && rw.renderDate) ||
                     ((rw.textStringData== null || rw.textStringData== '') && rw.renderStringFreeText)
                   ))
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Answer of ' + surveyQuestionMap.get(rw.surQue.Id).SurveyQuestion__c + ' for '+ supplierNameMap.get(rw.suppId) + System.Label.SPE_NotFilled));
                    return null;
                }
            }
            if (!contactIds.contains(contact.Id))
            {
                toBeAddedSurveyresponse = createSurveyresponse(rwList);
                
                toBeAddedPIValues = createPIValues(rwList);
            }
            
            toBeInsertedSurveyresponse.addAll(toBeAddedSurveyresponse);
            
            toBeInsertedPIValues.addAll(toBeAddedPIValues);
        }
        
        
        if (!toBeInsertedSurveyresponse.isEmpty() || !toBeInsertedPIValues.isEmpty())
        {
            try
            {
                insert toBeInsertedSurveyresponse;
                insert toBeInsertedPIValues;
            }
            catch (Dmlexception ex)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.SPE_CorrectValue));
            }
        }
        
        List<SPE_TrackerRespondent__c> trackerResp = [SELECT IsResponseReceived__c FROM SPE_TrackerRespondent__c WHERE Contact__c =: contact.Id AND SPE_Tracker__c =: tracker.Id];
        for(SPE_TrackerRespondent__c trackRespondent : trackerResp)
        {
            trackRespondent.IsResponseReceived__c = true;
            trackerRespList.add(trackRespondent);
        }
        
        update trackerRespList;
        
        
        Pagereference pg = Page.SPE_ConsequenceManagementThankyouPage;
        return pg;
    } 
    
    private List<SPE_SurveyResponse__c> createSurveyresponse(List<ResponseWrapper> rwList)
    {   
        List<SPE_SurveyResponse__c> toBeAddedSurveyresponse = new List<SPE_SurveyResponse__c>();
        for (ResponseWrapper rw: rwList)
        {   
            if (rw.isAnswerVisible == true && rw.isSkip == false)
            {   
                SPE_SurveyResponse__c sr  = new SPE_SurveyResponse__c();
                sr.Questions__c = rw.surQue.Id;
                sr.Answers__c = rw.ansId;
                sr.KPIDefinition__c = rw.kpiId;
                //*************Line Commented As Part of Encryption Process*************************//
                    //sr.Supplier__c = rw.suppId;
                //*************************************END*****************************************//
                sr.Response__c = rw.comments;
                sr.SPEPlan__c = spePlan.Id;
                sr.Respondent__c = contact.Id == null ? null : contact.Id;
                sr.SPETracker__c = tracker.Id == null ? null : tracker.Id;
                
                sr.ChoiceForFreeText__c = (rw.textAreaData == '' || rw.textAreaData == NULL)? Null: Decimal.Valueof(rw.textAreaData);
                sr.Date__c = rw.dateData;
                sr.BooleanChoice__c = rw.renderCheckBox == true ? True : False;
                sr.NA__c = rw.isSkip;
                sr.Invisible__c = rw.isAnswerVisible;
            
                if(sr.Answers__c != null || sr.ChoiceForFreeText__c != null || sr.BooleanChoice__c != false || sr.Date__c != null )
                {
                    toBeAddedSurveyresponse.add(sr);
                } 
                
            }
        }
        
        return toBeAddedSurveyresponse;
    }
    
    private List<SPE_PIValues__c> createPIValues(List<ResponseWrapper> rwList)
    {   
        List<SPE_PIValues__c> toBeAddedPIValues = new List<SPE_PIValues__c>();
        for (ResponseWrapper rw: rwList)
        {
            if (rw.isAnswerVisible == true && rw.isSkip == false)
            {
                SPE_PIValues__c piValues = new SPE_PIValues__c();
                piValues.PIDefination__c = rw.piId;
                //*************Line Commented As Part of Encryption Process*************************//
                    //piValues.Supplier__c = rw.suppId;
                //*************************************END*****************************************//
                piValues.EnterpriseID__c = rw.enterpriseId;
                piValues.Region__c = spePlan.Region__c;
                piValues.Market__c = spePlan.Region__c;
                piValues.MarketUnit__c = spePlan.SubRegion__c;
                piValues.SubRegion__c = spePlan.SubRegion__c;
                piValues.Country__c = spePlan.Country__c;
                piValues.Project__c = spePlan.Project__c;
                piValues.Cluster__c = spePlan.CategoryCluster__c;
                
                piValues.CategoryGroup__c = spePlan.CategoryGroup__c;
                piValues.Category__c = spePlan.Category__c;
                piValues.BusinessUnit__c = spePlan.BusinessUnit__c;
                piValues.BusinessLine__c = spePlan.BusinessLine__c;
                piValues.Product__c = spePlan.Product__c;
                piValues.Period__c = tracker.DateOfExecution__c.addMonths(-1);
                piValues.NumberValue__c = rw.renderPicklist == true ? scoreAnswer(rw.surQue.Id, rw.ansId) : ((rw.textAreaData == '' || rw.textAreaData == NULL) ? NULL: Decimal.ValueOf(rw.textAreaData));
                piValues.BooleanValue__c = rw.renderCheckBox == true ? True : False;
                piValues.DateValue__c = rw.dateData;
                piValues.StringValue__c = rw.renderStringFreeText == true ? rw.textStringData : NULL;
                
                piValues.SurveyComments__c = rw.comments;
                piValues.SPETracker__c = tracker.Id;
                piValues.Respondent__c = contact.Id;
                
                if(piValues.NumberValue__c != null || piValues.DateValue__c != null || piValues.StringValue__c != null || rw.booleanData != False)
                {
                    toBeAddedPIValues.add(piValues);
                }
            }            
        }
        
        return toBeAddedPIValues;
    }
    
    private Decimal scoreAnswer (Id queId, Id ansId)
    {
        if (queAnswersMap.get(queId) != null )
        {
            for (SPE_SurveyAnswer__c ans : queAnswersMap.get(queId))
            {
                if (ansId == ans.Id)
                {
                    return ans.Score__c;
                }
            }   
        }
        
        return null;
    }
    
    public class ResponseWrapper
    {
        public Id suppId {get;set;}
        public String enterpriseId{get;set;}
        public SPE_SurveyQuestion__c surQue {get;set;}
        public List<SPE_SurveyAnswer__c> surAns {get;set;} 
        public List<SelectOption> selectAns {get;set;}
        public Id ansId {get;set;}
        public String kpiName {get;set;}
        public Id kpiId {get;set;}
        public String comments {get;set;}
        public String textStringData {get;set;}
        public String textAreaData{get;set;}
        public Date dateData{get; set;}
        public Boolean booleanData{get; set;}
        public List<SelectOption> multiOptions{get; set;}
        public Boolean renderCheckBox {get;set;}
        public Boolean renderDate {get;set;}
        public Boolean renderFreeText{get;set;}
        public Boolean renderStringFreeText{get;set;}
        public Boolean renderPicklist{get;set;}
        public Boolean isSkip {get;set;}
        public Id piId;
        public Boolean isAnswerVisible {get;set;}
    }
  
}