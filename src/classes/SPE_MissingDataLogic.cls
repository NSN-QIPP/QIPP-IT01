public with sharing class SPE_MissingDataLogic 
{
    public static SPE_TrackerValues__c LogicFirst(Id kpiId, Integer toBeaddedMonths, Date executionDate, String enterpriseId, SPE_SPETracker__c speTracker, SPE_TrackerValues__c trackerValue)
    {
        Boolean isCase1Apply = false;
        Boolean isCase2Apply = false;
        Boolean isCase3Apply = false;
        
        Date toDate = executionDate;
        Date fromDateCase1 = toDate.addMonths(-(2 + toBeaddedMonths));
        
        List<String> kpiMonthsCase1 = new List<String>();
        
        while (fromDateCase1 <= toDate )
        {
            kpiMonthsCase1.add(SPE_Utility.monthsMap.get(fromDateCase1.month()) + ' - '+ String.valueOf(fromDateCase1.year()));
            
            fromDateCase1 = fromDateCase1.addMonths(1);
        }
        
        //*************************Changes Done As Part of Encryption*****************************//
        
        /*List<SPE_KPIValue__c> kpiValuesCase1 = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c,
                                                       Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c 
                                                FROM SPE_KPIValue__c
                                                WHERE KPIDefinition__c =: kpiId
                                                AND EnterpriseId__c =: enterpriseId
                                                AND KPIValue__c != null
                                                AND ExecutionPeriod__c IN : kpiMonthsCase1];*/
                                                
         List<SPE_KPIValue__c> kpiValuesCase1 = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c,
                                                       Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c 
                                                FROM SPE_KPIValue__c
                                                WHERE KPIDefinition__c =: kpiId
                                                AND KPIValue__c != null
                                                AND ExecutionPeriod__c IN : kpiMonthsCase1];                                

        //************************************END*******************************************//
        
        Decimal sumCase1 = 0;
        Integer cntCase1 = 0;
        
        for (SPE_KPIValue__c kv : kpiValuesCase1)
        {
        
        //**********************Changes Done As Part of Encryption ****************************//
            if ( kv.EnterpriseId__c !=null && kv.KPIValue__c != null && enterpriseId == kv.EnterpriseId__c &&
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
                   isCase1Apply = true;
                   sumCase1 = sumCase1 + kv.KPIValue__c;
                   cntCase1 ++;
               }
               
               //*****************************End*********************************// 
        }
        
        if (isCase1Apply)
        {
            //return  sumCase1 / cntCase1 ;
            trackerValue.Value__c = (sumCase1 == 0 || cntCase1 == 0) ? 0 : sumCase1 / cntCase1 ;
            trackerValue.LogicAnnotation__c ='H-Ave-3';
            return trackerValue; 
        }    
        
        toDate = executionDate;
        Date fromDateCase2 = toDate.addMonths(-(11 + toBeaddedMonths));
        
        List<String> kpiMonthsCase2 = new List<String>();
        
        while (fromDateCase2 <= toDate )
        {
            kpiMonthsCase2.add(SPE_Utility.monthsMap.get(fromDateCase2.month()) + ' - '+ String.valueOf(fromDateCase2.year()));
            
            fromDateCase2 = fromDateCase2.addMonths(1);
        }
        
        //*************************Changes Done As Part of Encryption*****************************//
        
        /*List<SPE_KPIValue__c> kpiValuesCase2 = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c,
                                                       Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c 
                                                FROM SPE_KPIValue__c
                                                WHERE KPIDefinition__c =: kpiId
                                                AND EnterpriseId__c =: enterpriseId
                                                AND KPIValue__c != null
                                                AND ExecutionPeriod__c IN : kpiMonthsCase2];*/
        
        List<SPE_KPIValue__c> kpiValuesCase2 = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c,
                                                       Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c 
                                                FROM SPE_KPIValue__c
                                                WHERE KPIDefinition__c =: kpiId
                                                AND KPIValue__c != null
                                                AND ExecutionPeriod__c IN : kpiMonthsCase2];                                

        
        //************************************END*******************************************//
                                       
        Decimal sumCase2 = 0;
        Integer cntCase2 = 0;
        
        System.debug('==>'+kpiValuesCase2);
        
        for (SPE_KPIValue__c kv : kpiValuesCase2)
        {
        
        //*************************Changes Done As Part of Encryption*****************************//
            if ( kv.EnterpriseId__c !=null && kv.KPIValue__c != null && enterpriseId == kv.EnterpriseId__c &&
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
                    isCase2Apply = true;
                    sumCase2 = sumCase2 + kv.KPIValue__c;
                    cntCase2 ++;
               }
               
             //*************************END*****************************//  
         }
         
         if (isCase2Apply)
         {
            //return  sumCase2 / cntCase2 ;
            trackerValue.Value__c = (sumCase2 == 0 || cntCase2 == 0) ? 0 : sumCase2 / cntCase2 ;
            trackerValue.LogicAnnotation__c ='H-Ave-12';
            return trackerValue;
         }
         
         sumCase2 = 0;
         cntCase2 = 0;
        
        
        List<SPE_SPEPlanSupplierMap__c> spePlansupplier = [SELECT Id, Supplier__r.EnterpriseId__c FROM SPE_SPEPlanSupplierMap__c WHERE SPEPlan__c =: speTracker.SPEPlan__c];
        
        List<String> enterpriseIds = new List<String>();
        for (SPE_SPEPlanSupplierMap__c sp : spePlansupplier)
        {
            enterpriseIds.add(sp.Supplier__r.EnterpriseId__c);
        }
        
        System.debug('=====>'+speTracker);
        System.debug('=====>'+enterpriseIds);
        
        //*************************Changes Done As Part of Encryption*****************************//
        
        /*List<SPE_KPIValue__c> kpiValuesCase3 = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c,
                                                       Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c, KPIDefinition__r.Aggregation__c 
                                                FROM SPE_KPIValue__c
                                                WHERE KPIDefinition__c =: kpiId
                                                AND EnterpriseId__c In: enterpriseIds
                                                AND KPIValue__c != null
                                                AND ExecutionPeriod__c =: speTracker.Name];*/
                                                
         List<SPE_KPIValue__c> kpiValuesCase3 = [SELECT Period__c, Region__c, SubRegion__c, Country__c, Project__c, EnterpriseId__c, KPIValue__c, KPIDefinition__c,
                                                       Cluster__c, CategoryGroup__c, Category__c, BusinessUnit__c, BusinessLine__c, Product__c, KPIDefinition__r.Aggregation__c 
                                                FROM SPE_KPIValue__c
                                                WHERE KPIDefinition__c =: kpiId
                                                AND KPIValue__c != null
                                                AND ExecutionPeriod__c =: speTracker.Name];                                       
                                                
        //*****************************END*****************************//                                        
        
        System.debug('=====>'+kpiValuesCase3);
        
        Map<String, List<Decimal>> supplierKpiValuesMap = new Map<String, List<Decimal>>();
                               
        for (SPE_KPIValue__c kv : kpiValuesCase3)
        {
        
        //*************************Changes Done As Part of Encryption*****************************//
            if ( kv.EnterpriseId__c !=null && kv.KPIValue__c != null &&
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
                    isCase2Apply = true;
               
                    List<Decimal> kpiValues = new List<Decimal>();
                    
                    if  (supplierKpiValuesMap.get(kv.EnterpriseId__c) != null)
                    {
                        kpiValues = supplierKpiValuesMap.get(kv.EnterpriseId__c);
                    }
                    kpiValues.add(kv.KPIValue__c);
                    
                    supplierKpiValuesMap.put(kv.EnterpriseId__c, kpiValues);
               }
               
             //******************************END*****************************//  
         }
         
         System.debug('=====>'+supplierKpiValuesMap);
        
         if (isCase2Apply)
         {  
            
            for (String s : supplierKpiValuesMap.keySet())
            {
                Decimal d = SPE_TrackerExecutionExt.ListToAggregate(kpiValuesCase3[0].KPIDefinition__r.Aggregation__c, supplierKpiValuesMap.get(s));
                
                sumCase2 = sumCase2 + d;
                cntCase2 ++;
            }
            
            System.debug('=====>'+cntCase2);
            System.debug('=====>'+sumCase2);
             
            trackerValue.Value__c = (sumCase2 == 0 || cntCase2 == 0) ? 0 : sumCase2 / cntCase2 ;
            trackerValue.LogicAnnotation__c ='C-Ave';
            return trackerValue;
         }                                 
          
        return trackerValue;
    }
}