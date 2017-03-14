public with sharing class SPE_SPEPIAvailability 
{


  public Map<String, Map<Id, Boolean>> enterprisePIDataIsSurveyExecuteMap{get;set;} 
  
  public Map<Id, String> piDefinitionMap {get;set;}
 
 //*************************************Changes For Encryption*****************************// 
   public Map<Id, SPE_PIDefinition__c> piDefinitionMapEncrypted {get;set;}
   public Map<Id, Account> supplierMapEncrypted {get;set;}
   public Map<Account, Map<Id, Boolean>> enterprisePIDataIsSurveyExecuteMapEncrypted{get;set;}
 //*************************************END*****************************//  
  
     //public Boolean IsSurveyBasePI{get;set;}
  public SPE_SPEPIAvailability(ApexPages.StandardController controller)
    {
       /* if (controller.getId() != null)
        {
            SPE_SPETracker__c speTracker = [SELECT Id, SPETemplate__c FROM SPE_SPETracker__c WHERE Id =: controller.getId()];
            IsSurveyBasePI = isSurveyExecute(speTracker.id);
        }*/
        
        piCheckAvailability(controller.getId());
    }

    private void piCheckAvailability(Id speTrackerId)
    {
        enterprisePIDataIsSurveyExecuteMap = new Map<String, Map<Id, Boolean>>();
        
        //piDefinitionMap = new Map<Id, String>();
     
    //***********************************Changes For Encryption************************//    
        piDefinitionMapEncrypted = new Map<Id, SPE_PIDefinition__c>();
        enterprisePIDataIsSurveyExecuteMapEncrypted = new Map<Account, Map<Id, Boolean>>();
    //***********************************END************************//
        
        SPE_SPETracker__c speTracker = [SELECT Id, Status__c, CategoryCluster__c, CategoryGroup__c, Category__c, Region__c, SubRegion__c, Country__c, Project__c, BusinessUnit__c, 
                                               BusinessLine__c , Product__c, SPEPlan__c, DateOfExecution__c, SPETemplate__c,PilotTestDataCheck__c, Name   
                                        FROM SPE_SPETracker__c 
                                        WHERE Id =: speTrackerId];
    
      Map<String, Boolean> enterpriseIsSurveyExecuteMap = new Map<String, Boolean>();
    
    
      System.debug('=======================>');
      
      Boolean isSurveyExecute = true;
        
      Set<Id> kpiDefinationIds = new Set<Id>();
        
        Set<Id> piDefinationIds = new Set<Id>();
        
        Set<String> enterpriseIds = new  Set<String>();
        
        //****************Changes Are Done As Part of Encryption*****************//
        Set<Id> enterpriseIdsTemp = new  Set<Id>();
        //**************************************End**************************************************//
        
        for (SPE_SPEPlanSupplierMap__c speSup : [SELECT Id, Supplier__c, Supplier__r.EnterpriseId__c 
                            FROM SPE_SPEPlanSupplierMap__c
                            WHERE SPEPlan__c =: speTracker.SPEPlan__c ])
        {
          enterpriseIds.add(speSup.Supplier__r.EnterpriseId__c);
          
          //****************Changes Are Done As Part of Encryption*****************//
          enterpriseIdsTemp.add(speSup.Supplier__c);
          
          
          //********************************************End************************************************//
          
          enterpriseIsSurveyExecuteMap.put(speSup.Supplier__r.EnterpriseId__c, true);
        }
        
        System.debug('==============>enterpriseIdsTemp'+enterpriseIdsTemp);
         System.debug('==============>enterpriseIds'+enterpriseIds);
        
        /*
        // return if the force survey clicked
        
        if (trackerRespondent.ForceSurvey__c)
        {
          return enterpriseIsSurveyExecuteMap;
        }*/
        
        for (SPE_SPEKPIMap__c speKPI : [SELECT Id, KPIDefinition__c FROM SPE_SPEKPIMap__c WHERE SPE_SPEKPIMap__c.SPETemplate__c =: speTracker.SPETemplate__c])
        {
            kpiDefinationIds.add(speKPI.KPIDefinition__c);
        }
        
        Map<Id, Decimal> piAggregationDurationMap = new Map<Id, Decimal>();
        
        //***********************Changes for Encryption**********************//
        for (SPE_KPICalculation__c kpiCal : [SELECT Id, KPIDefinition__c, PIDefination__c, PIDefination__r.Name,PIDefination__r.PI_Title__c, TimeFrame__c FROM SPE_KPICalculation__c 
                                             WHERE KPIDefinition__c IN : kpiDefinationIds 
                                                  AND PIDefination__c != null ])
        //******************END*****************//
        {   
            piDefinationIds.add(kpiCal.PIDefination__c);
            
            piAggregationDurationMap.put(kpiCal.PIDefination__c, kpiCal.TimeFrame__c);
            
            //***********************Changes for Encryption**********************//
            //piDefinitionMap.put(kpiCal.PIDefination__c, kpiCal.PIDefination__r.Name);
            //piDefinitionMap.put(kpiCal.PIDefination__c, kpiCal.PIDefination__r.PI_Title__c);
            piDefinitionMapEncrypted.put(kpiCal.PIDefination__c,[Select Id,PI_Title__c from SPE_PIDefinition__c where ID =: kpiCal.PIDefination__c]);           
            //******************END*****************//
            
        }
                
        Map<Id, Boolean> piDataIsSurveyExecuteMapNew = new Map<Id, Boolean>();
        
        for (String eId : enterpriseIds)
        {
          Map<Id, Boolean> piDataIsSurveyExecuteMap = new Map<Id, Boolean>();
          for (Id piId : piDefinationIds)
          {
            piDataIsSurveyExecuteMap.put(piId, true);
            
          //*********************************Changes For Encryption*************************//  
            piDataIsSurveyExecuteMapNew.put(piId,true);
          //*********************************END*************************//
            
          }
          enterprisePIDataIsSurveyExecuteMap.put(eId, piDataIsSurveyExecuteMap);         
        }
      
   //*********************************Changes For Encryption*************************//     
        for(Id suppid:enterpriseIdsTemp)
        {
            enterprisePIDataIsSurveyExecuteMapEncrypted.put([Select EnterpriseId__c from Account where Id =: suppid], piDataIsSurveyExecuteMapNew);
        }
   //*********************************END*************************//
        
        Decimal maxTimeDuration = 1;
        
        for (Decimal d: piAggregationDurationMap.values())
        {
          maxTimeDuration = math.max(maxTimeDuration, d);
        }
        
        System.debug('maxTimeDuration=======================>'+maxTimeDuration);
        
        maxTimeDuration = maxTimeDuration - 1;
        
        Date speDate = speTracker.DateOfExecution__c.addMonths(-1);
        
        System.debug('speDate=======================>'+speDate);
        
        Integer numberOfDays = Date.daysInMonth(speDate.year(), speDate.month());
        
        System.debug('numberOfDays=======================>'+numberOfDays);
    
        Date endSPEDate = Date.newInstance(speDate.year(), speDate.month(), numberOfDays);
        
        Date startSPEDate1 = speDate.addMonths(-(Integer.valueOf(maxTimeDuration)));
        
        Date startSPEDate = Date.newInstance(startSPEDate1.year(), startSPEDate1.month(), 1);
    
    System.debug('endSPEDate=======================>'+endSPEDate);
    System.debug('startSPEDate=======================>'+startSPEDate);
    
    Set<String> surveyNeedToBeExecute = new Set<String>();
    
      //**************************Changes Are Done As Part of Encryption**********************//
        /*for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                      Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c, EnterpriseID__c 
                       FROM SPE_PIValues__c 
                       WHERE PIDefination__c In : piDefinationIds 
                       AND EnterpriseID__c In: enterpriseIds
                       AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])*/
                       
        for (SPE_PIValues__c kv : [SELECT Id, PIDefination__c, BusinessUnit__c, BusinessLine__c, Product__c, Category__c, CategoryGroup__c, Cluster__c, Period__c, 
                      Region__c, SubRegion__c, Country__c, Project__c, SPETracker__c,EnterpriseIDEncrypted__c, EnterpriseID__c 
                       FROM SPE_PIValues__c 
                       WHERE PIDefination__c In : piDefinationIds 
                       AND EnterpriseIDEncrypted__c In: enterpriseIdsTemp
                       AND Period__c >=: startSPEDate AND Period__c <=: endSPEDate])
                       
      //****************************************End*******************************************************//              
        {
          
          Decimal piDuration = piAggregationDurationMap.get(kv.PIDefination__c);
          piDuration = piDuration + 1;
          
          System.debug('piDuration=======================>'+piDuration);
          
          Date speDate1 = speDate.addMonths(-(Integer.valueOf(piDuration)));
            
          Date newStartSPEDate = Date.newInstance(speDate1.year(), speDate1.month(), 1);
          
          System.debug('newStartSPEDate=======================>'+newStartSPEDate);
          
          System.debug('newStartSPEDate=======================>'+kv.Period__c);
          
          /*
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
            
          }*/
          /*
          if (surveyNeedToBeExecute.contains(kv.EnterpriseID__c))
          {
            continue;
          }*/
          
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
         
         //*********************************Changes For Encryption*************************//   
            enterprisePIDataIsSurveyExecuteMapEncrypted.put([Select EnterpriseID__c from Account where ID =: kv.EnterpriseIDEncrypted__c],piDataIsSurveyExecuteMap);
         //*********************************END*************************//
            
            // ************************** //
            }
        }
        
        System.debug('enterpriseIsSurveyExecuteMap==========>'+enterpriseIsSurveyExecuteMap);
        
        System.debug('enterprisePIDataIsSurveyExecuteMap==========>'+enterprisePIDataIsSurveyExecuteMap);
        
        supplierMapEncrypted = new Map<Id, Account>();
      
      //*********************************Changes For Encryption*************************//  
        for (Account acc : enterprisePIDataIsSurveyExecuteMapEncrypted.keySet())
        {
            supplierMapEncrypted.put(acc.Id, acc );
        }
      //*********************************END*************************//
      
    }


}