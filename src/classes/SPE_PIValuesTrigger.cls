public with sharing class SPE_PIValuesTrigger 
{
     //Method to fill Upper Hierarchy
    public static void AutoFill(List<SPE_PIValues__c> newPIValues)
    {
        System.debug('====================>'+newPIValues);
    
        SPE_RegionMaster regionMaster = new SPE_RegionMaster();
    
        Set<Id> piDefinitionIds = new Set<Id>();
        for (SPE_PIValues__c pi : newPIValues)
        {
            piDefinitionIds.add(pi.PIDefination__c);
        }
        
        Map<Id, SPE_PIDefinition__c> piDefinitionMaps = new Map<Id, SPE_PIDefinition__c>([SELECT Id, DataAcquisitionMethod__c, GeoScope__c, BUScope__c, CategoryScope__c
                                                                                          FROM SPE_PIDefinition__c
                                                                                          WHERE Id In: piDefinitionIds]);
        
         
        for (SPE_PIValues__c pi : newPIValues)
        {
            if (piDefinitionMaps.get(pi.PIDefination__c) == null ||
                piDefinitionMaps.get(pi.PIDefination__c).DataAcquisitionMethod__c == 'Survey')
            {
                continue;
            }
            
            String strPIGeoScope = piDefinitionMaps.get(pi.PIDefination__c).GeoScope__c;
            String strPICatScope = piDefinitionMaps.get(pi.PIDefination__c).CategoryScope__c;
            String strPIProdScope = piDefinitionMaps.get(pi.PIDefination__c).BUScope__c;
            
            if((pi.Region__c == null || pi.Region__c == '' || pi.Region__c == '--None--') && pi.Market__c != null && pi.Market__c != '')
            {
                pi.Region__c = pi.Market__c;
            }
            if((pi.SubRegion__c == null || pi.SubRegion__c == '' || pi.SubRegion__c == '--None--') && pi.MarketUnit__c != null && pi.MarketUnit__c != '')
            {
                pi.SubRegion__c = pi.MarketUnit__c;
            }
            pi.Project__c = (pi.Project__c == null || pi.Project__c == '' || pi.Project__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Project__c :  pi.Project__c ;
            pi.Country__c = (pi.Country__c == null || pi.Country__c == '' || pi.Country__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Country__c : pi.Country__c;
            pi.SubRegion__c = (pi.SubRegion__c == null || pi.SubRegion__c == '' || pi.SubRegion__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Market_Unit__c : pi.SubRegion__c;
            pi.Region__c = (pi.Region__c == null || pi.Region__c == '' || pi.Region__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Market__c : pi.Region__c;
            
            pi.Category__c = (pi.Category__c == null || pi.Category__c == '' || pi.Category__c == '--None--')  ? PicklistDefaultValues__c.getall().values()[0].Category__c : pi.Category__c;
            pi.CategoryGroup__c = (pi.CategoryGroup__c == null || pi.CategoryGroup__c == '' || pi.CategoryGroup__c == '--None--' ) ? PicklistDefaultValues__c.getall().values()[0].Category_Group__c : pi.CategoryGroup__c;
            pi.Cluster__c = (pi.Cluster__c == null || pi.Cluster__c == '' || pi.Cluster__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Category_Area__c : pi.Cluster__c;
            
            pi.Product__c = (pi.Product__c == null || pi.Product__c == '' || pi.Product__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Product__c : pi.Product__c;
            pi.BusinessLine__c = (pi.BusinessLine__c == null || pi.BusinessLine__c == '' || pi.BusinessLine__c == '--None--') ? PicklistDefaultValues__c.getall().values()[0].Business_Line__c : pi.BusinessLine__c; 
            pi.BusinessUnit__c = (pi.BusinessUnit__c == null || pi.BusinessUnit__c == '' || pi.BusinessUnit__c == '--None--' ) ? PicklistDefaultValues__c.getall().values()[0].Business_Unit__c : pi.BusinessUnit__c; 
            
            if(strPIGeoScope.equalsIgnoreCase('Project') && 
                pi.Project__c != PicklistDefaultValues__c.getall().values()[0].Project__c)
            {
                pi.Country__c = regionMaster.projectRegionMasterMap.get(pi.Project__c) != null ? regionMaster.projectRegionMasterMap.get(pi.Project__c).Country__c : pi.Country__c;
                pi.SubRegion__c = regionMaster.projectRegionMasterMap.get(pi.Project__c) != null ? regionMaster.projectRegionMasterMap.get(pi.Project__c).MarketUnit__c : pi.SubRegion__c;
                pi.Region__c = regionMaster.projectRegionMasterMap.get(pi.Project__c) != null ? regionMaster.projectRegionMasterMap.get(pi.Project__c).Market__c : pi.Region__c;
            }
            else if(strPIGeoScope.equalsIgnoreCase('Project') && 
                    pi.Project__c == PicklistDefaultValues__c.getall().values()[0].Project__c)
            {
                pi.addError('Please enter Project');
            }
            else if(strPIGeoScope.equalsIgnoreCase('Country') && 
                    pi.Country__c != PicklistDefaultValues__c.getall().values()[0].Country__c )
            {
                pi.SubRegion__c = regionMaster.countrySubregionMap.get(pi.Country__c) != null ? regionMaster.countrySubregionMap.get(pi.Country__c) : pi.SubRegion__c;
                pi.Region__c = regionMaster.subRegionRegionMap.get(pi.SubRegion__c) != null ? regionMaster.subRegionRegionMap.get(pi.SubRegion__c) : pi.Region__c; 
                pi.project__c=PicklistDefaultValues__c.getall().values()[0].Project__c;
            }
            else if(strPIGeoScope.equalsIgnoreCase('Country') && 
                    pi.Country__c == PicklistDefaultValues__c.getall().values()[0].Country__c)
            {
                pi.addError('Please enter Country');
            }
            else if(strPIGeoScope.equalsIgnoreCase('Market Unit') && 
                    pi.SubRegion__c != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c)
            {
                pi.Region__c = regionMaster.subRegionRegionMap.get(pi.SubRegion__c) != null ? regionMaster.subRegionRegionMap.get(pi.SubRegion__c) : pi.Region__c; 
                pi.project__c=PicklistDefaultValues__c.getall().values()[0].Project__c;
                pi.Country__c = PicklistDefaultValues__c.getall().values()[0].Country__c;
            }
            else if(strPIGeoScope.equalsIgnoreCase('Market Unit') && 
                    pi.SubRegion__c == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c)
            {
                pi.addError('Please enter Market Unit');
            }
            else if(strPIGeoScope.equalsIgnoreCase('Market') && 
                    pi.Region__c != PicklistDefaultValues__c.getall().values()[0].Market__c)
            {
                pi.SubRegion__c=PicklistDefaultValues__c.getall().values()[0].Market_Unit__c;
                pi.Country__c = PicklistDefaultValues__c.getall().values()[0].Country__c;
                pi.project__c=PicklistDefaultValues__c.getall().values()[0].Project__c;
            }
            else if(strPIGeoScope.equalsIgnoreCase('Market') && 
                    pi.Region__c == PicklistDefaultValues__c.getall().values()[0].Market__c)
            {
                pi.addError('Please enter Market');
            }
            
            // Category Hierarchy
            if (strPICatScope.equalsIgnoreCase('Category') && 
                pi.Category__c != PicklistDefaultValues__c.getall().values()[0].Category__c
                )
            {
                pi.CategoryGroup__c = regionMaster.categoryGrpMap.get(pi.Category__c) ==  null ? pi.CategoryGroup__c : regionMaster.categoryGrpMap.get(pi.Category__c);
                pi.Cluster__c = regionMaster.grpClusterMap.get(pi.CategoryGroup__c) ==  null ? pi.Cluster__c : regionMaster.grpClusterMap.get(pi.CategoryGroup__c);
            }
            else if(strPICatScope.equalsIgnoreCase('Category') && 
                    pi.Category__c == PicklistDefaultValues__c.getall().values()[0].Category__c)
            {
                pi.addError('Please enter Category');
            }
            else if(strPICatScope.equalsIgnoreCase('Category Group') && 
                    pi.CategoryGroup__c != PicklistDefaultValues__c.getall().values()[0].Category_Group__c)
            {
                pi.Cluster__c = regionMaster.grpClusterMap.get(pi.CategoryGroup__c) ==  null ? pi.Cluster__c : regionMaster.grpClusterMap.get(pi.CategoryGroup__c);
                pi.Category__c= PicklistDefaultValues__c.getall().values()[0].Category__c;
            }
            else if(strPICatScope.equalsIgnoreCase('Category Group') && 
                    pi.CategoryGroup__c == PicklistDefaultValues__c.getall().values()[0].Category_Group__c)
            {
                pi.addError('Please enter Category Group');
            }
            else if(strPICatScope.equalsIgnoreCase('Category Area') && 
                    pi.Cluster__c != PicklistDefaultValues__c.getall().values()[0].Category_Area__c)
            {
                pi.CategoryGroup__c =PicklistDefaultValues__c.getall().values()[0].Category_Group__c;
                pi.Category__c=PicklistDefaultValues__c.getall().values()[0].Category__c;
            }
            else if(strPICatScope.equalsIgnoreCase('Category Area') && 
                    pi.Cluster__c == PicklistDefaultValues__c.getall().values()[0].Category_Area__c)
            {
                pi.addError('Please enter Category Area');
            }
            /*
            else if (strPICatScope.equalsIgnoreCase(PicklistDefaultValues__c.getall().values()[0].Category_Area__c))
            {
                pi.Cluster__c=PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
                pi.Category__c=PicklistDefaultValues__c.getall().values()[0].Category__c;
                pi.CategoryGroup__c =PicklistDefaultValues__c.getall().values()[0].Category_Group__c;
            }*/
            
            // Product Hierarchy
            if(strPIProdScope.equalsIgnoreCase('Product') && 
                pi.Product__c != PicklistDefaultValues__c.getall().values()[0].Product__c)
            {
                pi.BusinessLine__c = regionMaster.productBLMap.get(pi.Product__c) ==  null ? pi.BusinessLine__c : regionMaster.productBLMap.get(pi.Product__c);
                pi.BusinessUnit__c = regionMaster.BLBUMap.get(pi.BusinessLine__c) ==  null ? pi.BusinessUnit__c : regionMaster.BLBUMap.get(pi.BusinessLine__c);
            }
            else if(strPIProdScope.equalsIgnoreCase('Product') && 
                    pi.Product__c == PicklistDefaultValues__c.getall().values()[0].Product__c)
            {
                pi.addError('Please enter Product');
            }
            else if(strPIProdScope.equalsIgnoreCase('Business Line') && 
                    pi.BusinessLine__c != PicklistDefaultValues__c.getall().values()[0].Business_Line__c)
            {
                pi.BusinessUnit__c = regionMaster.BLBUMap.get(pi.BusinessLine__c) ==  null ? pi.BusinessUnit__c : regionMaster.BLBUMap.get(pi.BusinessLine__c);
                pi.Product__c=PicklistDefaultValues__c.getall().values()[0].Product__c;
            }
            else if(strPIProdScope.equalsIgnoreCase('Business Line') && 
                    pi.BusinessLine__c == PicklistDefaultValues__c.getall().values()[0].Business_Line__c)
            {
                pi.addError('Please enter Business Line');
            }
            else if(strPIProdScope.equalsIgnoreCase('Business Unit') && 
                    pi.BusinessUnit__c != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c)
            
            {
                pi.BusinessLine__c= PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
                pi.Product__c=PicklistDefaultValues__c.getall().values()[0].Product__c;
            }
            else if(strPIProdScope.equalsIgnoreCase('Business Unit') && 
                    pi.BusinessUnit__c == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c)
            {
                pi.addError('Please enter Business Unit');
            }
            /*
            else if (strPIProdScope.equalsIgnoreCase(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c))
            {
                pi.BusinessUnit__c= PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
                pi.BusinessLine__c= PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
                pi.Product__c=PicklistDefaultValues__c.getall().values()[0].Product__c;
            }*/
        }
    
    }
    
    // Method added for KPI = PI functionality @ 17 June 2015
    public static void createKPIValues(List<SPE_PIValues__c> newPIValues)
    {
        List<SPE_KPIValue__c> lstKPIValuesToBeInserted = new List<SPE_KPIValue__c>();
        
        System.debug('===============*****************************=====>'+newPIValues);
        Set<Id> piDefinition = new Set<Id>();
        for (SPE_PIValues__c piValues : newPIValues)
        {
            piDefinition.add(piValues.PIDefination__c);
        }
        
        for (SPE_KPIDefinition__c kpiDef : [select id,PI_Data__c from SPE_KPIDefinition__c where PI_Data__c =: piDefinition AND LifecycleStage__c = 'Published'])
        {
            for(SPE_PIValues__c objSPEPIV : newPIValues)
            {
                if (kpiDef.PI_Data__c == objSPEPIV.PIDefination__c)
                {
                    System.debug('===============****************PI Data************=====>'+objSPEPIV.PIDefination__c);
                    SPE_KPIValue__c objKPIVal = new SPE_KPIValue__c();
                    objKPIVal.KPIDefinition__c = kpiDef.Id;
                    objKPIVal.BusinessLine__c = objSPEPIV.BusinessLine__c;
                    objKPIVal.BusinessUnit__c = objSPEPIV.BusinessUnit__c;
                    objKPIVal.Category__c = objSPEPIV.Category__c;
                    objKPIVal.Cluster__c = objSPEPIV.Cluster__c;
                    objKPIVal.CategoryGroup__c = objSPEPIV.CategoryGroup__c;
                    objKPIVal.Country__c = objSPEPIV.Country__c;
                    
                 //*********************Changes For encryption*********************//   
                    objKPIVal.EnterpriseId__c = objSPEPIV.EnterpriseID__c;
                    objKPIVal.EnterpriseIDEncrypted__c = objSPEPIV.EnterpriseIDEncrypted__c;
                 //************************END*********************//   
                    
                    objKPIVal.Region__c = objSPEPIV.Region__c;
                    objKPIVal.SubRegion__c = objSPEPIV.SubRegion__c;
                    objKPIVal.Period__c = objSPEPIV.Period__c;
                    objKPIVal.Product__c = objSPEPIV.Product__c;
                    objKPIVal.Project__c = objSPEPIV.Project__c;
                    objKPIVal.ExecutionPeriod__c = SPE_Utility.monthsMap.get((objSPEPIV.Period__c).month()) + ' - '+ String.valueOf((objSPEPIV.Period__c).year()); 
                    if(objSPEPIV.NumberValue__c != null ){
                        objKPIVal.KPIValue__c = objSPEPIV.NumberValue__c;
                        objKPIVal.KPI_Text_Value__c = objSPEPIV.NumberValue__c+'';
                    }
                    if(objSPEPIV.StringValue__c != ''){
                        objKPIVal.KPI_Text_Value__c = objSPEPIV.StringValue__c;
                        
                    }
                    if(objSPEPIV.dateValue__c != null){
                        objKPIVal.KPI_Text_Value__c = objSPEPIV.dateValue__c.month()+'/'+objSPEPIV.dateValue__c.day()+'/'+objSPEPIV.dateValue__c.year()+'';
                        
                    }
                     
                    lstKPIValuesToBeInserted.add(objKPIVal);
                }
            }
        }
        system.debug('lstKPIValuesToBeInserted----' + lstKPIValuesToBeInserted);
        try
        {
                database.insert(lstKPIValuesToBeInserted,false);
        }
        catch(exception ex)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
        }
    }
    //**********Method Added for Encryption****************************//
    public static void populateMappingKey (List<SPE_PIValues__c> newPIValues)
    {
        System.debug('====================>'+newPIValues);
        Map<String, Id> EIDSupplierMap = new Map<String, Id>();
        Map<Id,String> SupplierEIDMap = new Map<Id,String>();
        
        List<Account> suppliers = [SELECT EnterpriseID__c FROM Account WHERE ParentId = null];
        
        for (Account acc : suppliers)
        {
            EIDSupplierMap.put(acc.EnterpriseID__c,acc.Id); 
            SupplierEIDMap.put(acc.Id,acc.EnterpriseID__c);          
        }
        
        for (SPE_PIValues__c piValues : newPIValues)
        {
            if (EIDSupplierMap.get(piValues.EnterpriseID__c.toUpperCase()) != null)
            {
                  piValues.EnterpriseIDEncrypted__c = EIDSupplierMap.get(piValues.EnterpriseID__c.toUpperCase());
                  piValues.EnterpriseID__c = SupplierEIDMap.get(piValues.EnterpriseIDEncrypted__c);
            }
            else
            {
                  piValues.addError('EID is not correct');
            }
        }
        
        System.debug('====================>'+EIDSupplierMap);
    }
    //***************End*********************************//
}