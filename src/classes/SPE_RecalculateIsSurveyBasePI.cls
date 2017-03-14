global class SPE_RecalculateIsSurveyBasePI 
{   
    public Boolean IsSurveyBasePI{get;set;}
     
    global SPE_RecalculateIsSurveyBasePI(ApexPages.StandardController controller)
    {
        if (controller.getId() != null)
        {
            SPE_SPEPlan__c spePlan = [SELECT Id, SPETemplate__c FROM SPE_SPEPlan__c WHERE Id =: controller.getId()];
            IsSurveyBasePI = recalculateIsSurveyPI(spePlan.SPETemplate__c);
        }
    }
    
    webservice static Boolean recalculateIsSurveyPI(Id templateId)
    {
        
        Set<Id> kpiDefinationIds = new Set<Id>();
        
        Set<Id> PIKPIIds = new Set<Id>();
        
        Map<Id, Set<Id>> kpiKPICalMap = new Map<Id, Set<Id>>();
        
        for (SPE_SPEKPIMap__c speKPI : [SELECT Id, KPIDefinition__c FROM SPE_SPEKPIMap__c WHERE SPE_SPEKPIMap__c.SPETemplate__c =: templateId])
        {
            kpiDefinationIds.add(speKPI.KPIDefinition__c);
        }
        
        for (SPE_KPICalculation__c kpiCal : [SELECT Id, KPIDefinition__c FROM SPE_KPICalculation__c 
                                             WHERE KPIDefinition__c IN : kpiDefinationIds AND PIDefination__c != null AND PIDefination__r.DataAcquisitionMethod__c = 'Survey'])
        {   
            return true;
        }
        
        for (SPE_KPIDefinition__c kpiDefination : [SELECT Id FROM SPE_KPIDefinition__c WHERE Id IN : kpiDefinationIds AND PI_Data__c != null AND PI_Data__r.DataAcquisitionMethod__c = 'Survey'])
        {
            return true;
        } 
        
        return false;
    }
     
    webservice static string isSurveyExecute(Id speTrackerId)
    {
        SPE_SPETracker__c speTracker = [SELECT Id, Status__c, CategoryCluster__c, CategoryGroup__c, Category__c, Region__c, SubRegion__c, Country__c, Project__c, BusinessUnit__c, 
                                               BusinessLine__c , Product__c, SPEPlan__c, DateOfExecution__c, SPETemplate__c,PilotTestDataCheck__c, Name   
                                        FROM SPE_SPETracker__c 
                                        WHERE Id =: speTrackerId];
    
        if (speTracker.Status__c != 'Pending')
        {
            return 'The Tracker has already executed'; 
        }
        
        if (recalculateIsSurveyPI(speTracker.SPETemplate__c) == false)
        {
            return 'The Tracker does not have Survey based PI';
        }
        
        
        Map<String, Boolean> enterpriseIsSurveyExecuteMap = new Map<String, Boolean>();
        
        Boolean isSurveyExecute = false;
        
        Set<Id> kpiDefinationIds = new Set<Id>();
        
        Set<Id> piDefinationIds = new Set<Id>();
        
        //*******************Changes For Encryption******************//
        Set<String> enterpriseIds = new  Set<String>();
        Set<ID> enterpriseIdencrypted = new  Set<ID>();//******************New Line Added for Encryption****************//
        
        for (SPE_SPEPlanSupplierMap__c speSup : [SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c 
                                                FROM SPE_SPEPlanSupplierMap__c
                                                WHERE SPEPlan__c =: speTracker.SPEPlan__c ])
        {
            enterpriseIds.add(speSup.Supplier__r.EnterpriseId__c);
            enterpriseIdencrypted.add(speSup.Supplier__c);//******************New Line Added for Encryption****************//
            enterpriseIsSurveyExecuteMap.put(speSup.Supplier__r.EnterpriseId__c, true);
        }
        //*******************END******************//
        
        for (SPE_SPEKPIMap__c speKPI : [SELECT Id, KPIDefinition__c FROM SPE_SPEKPIMap__c WHERE SPE_SPEKPIMap__c.SPETemplate__c =: speTracker.SPETemplate__c])
        {
            kpiDefinationIds.add(speKPI.KPIDefinition__c);
        }
        
        Map<Id, Decimal> piAggregationDurationMap = new Map<Id, Decimal>();
        
        for (SPE_KPICalculation__c kpiCal : [SELECT Id, KPIDefinition__c, PIDefination__c, TimeFrame__c FROM SPE_KPICalculation__c 
                                             WHERE KPIDefinition__c IN : kpiDefinationIds 
                                                   AND PIDefination__c != null 
                                                   AND PIDefination__r.DataAcquisitionMethod__c = 'Survey' ])
        {   
            piDefinationIds.add(kpiCal.PIDefination__c);
            
            piAggregationDurationMap.put(kpiCal.PIDefination__c, kpiCal.TimeFrame__c);
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
        
        Date startSPEDate = Date.newInstance(speDate.year(), speDate.addMonths(-(Integer.valueOf(maxTimeDuration))).month(), 1);
        
        Set<String> surveyNeedToBeExecute = new Set<String>();
        
        //*******************Changes For Encryption******************//
        /*for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                      Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c, EnterpriseID__c 
                       FROM SPE_PIValues__c 
                       WHERE PIDefination__c In : piDefinationIds 
                       AND EnterpriseID__c In: enterpriseIds
                       AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])*/
                       
         for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                      Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c, EnterpriseID__c,EnterpriseIDEncrypted__c 
                       FROM SPE_PIValues__c 
                       WHERE PIDefination__c In : piDefinationIds 
                       AND EnterpriseIDEncrypted__c In: enterpriseIdencrypted
                       AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])              
        //************END******************//
        {
            
            
            Decimal piDuration = piAggregationDurationMap.get(kv.PIDefination__c);
            piDuration = piDuration + 1;
            
            Date speDate1 = speDate.addMonths(-(Integer.valueOf(piDuration)));
            
            Date newStartSPEDate = Date.newInstance(speDate1.year(), speDate1.month(), 1);
            
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
                //isSurveyExecute = false;
                enterpriseIsSurveyExecuteMap.put(kv.EnterpriseId__c, false);
            }
        }
        
        for (Boolean b : enterpriseIsSurveyExecuteMap.values())
        {
            if (b)
            {
                isSurveyExecute = true;
            }
        }
        return isSurveyExecute ? 'true' : 'The PI/Suvrey Data is available for the Tracker';
    }
}