/**************************************************************************************************
Apex Controller Name :  SPE_MapUtility
Version              :  1.0 
Created Date         :  2015/07/27
Function             :  Create Maps from the master tables
              
Modification Log     :
-----------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                  
* Kaushik Ganguly           2015/07/27            Original Version
* Kaushik Ganguly           2015/08/06            Prepared a common map for holding the values
* Kaushik Ganguly           2015/09/08            Added null check for map values
*****************************************************************************************************/ 

public without sharing class SPE_MapUtility {
    
    public static map<String,Set<String>> returnMapValues(){
        
        List<SPE_ProjectMaster__c> lstProjectMaster = new List<SPE_ProjectMaster__c>();
        List<SPE_BUBL__c> lstBUBL = new List<SPE_BUBL__c>();
        List<SPE_CategoryMaster__c> lstCategoryMaster = new List<SPE_CategoryMaster__c>();
        
        map<String,Set<String>> mapUniqueHierarchyListValues = new map<String,Set<String>>(); // map which holds all the possible combinations of the user selection
        lstProjectMaster = [select Id,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c]; // querying records from project master
        lstBUBL = [select Id,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c]; // querying records from product master
        lstCategoryMaster = [select Id,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c]; // querying records from category master
        
        
        
        Set<String> strKeys = new Set<String>(); // common set to hold the various combinations which can result out of user selection
        Set<String> setMarketUnits; // holds the set of market units for the specific markets
        Set<String> setCountry; // holds the set of countries for the combination of market and market unit
        Set<String> setProject; // holds the set of projects for the combination of market, market unit and countries   
        Set<String> setBL; // holds the set business lines for the specific business units
        Set<String> setProducts; // holds the set of products for the combination of business units and business lines
        Set<String> setCategoryGroups; // holds the set category groups for the specific category areas
        Set<String> setCategory; // holds the set of categories for the combination of category areas and category groups
        
        /*****************************************************************************************************
        * START OF FILLING THE MAP FOR THE DEFAULT VALUES OF THE DROP-DOWNS
        *****************************************************************************************************/
        Set<String> setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c);
        system.debug('setDefaultValues---' + setDefaultValues);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Market__c+'~Market',setDefaultValues);
        setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Country__c);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Market__c
                                        +PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,setDefaultValues);
        setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Market__c+
                                        PicklistDefaultValues__c.getall().values()[0].Market_Unit__c+
                                        PicklistDefaultValues__c.getall().values()[0].Country__c,setDefaultValues);
        
        setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Business_Line__c);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c+'~BusinessUnit',setDefaultValues);
        
        setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c+
                                        PicklistDefaultValues__c.getall().values()[0].Business_Line__c,setDefaultValues);
        
        setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Category_Group__c);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Category_Area__c+'~CategoryArea',setDefaultValues);
        
        setDefaultValues = new Set<String>();
        setDefaultValues.add(PicklistDefaultValues__c.getall().values()[0].Category__c);
        mapUniqueHierarchyListValues.put(PicklistDefaultValues__c.getall().values()[0].Category_Area__c+
                                        PicklistDefaultValues__c.getall().values()[0].Category_Group__c,setDefaultValues);
                                        
        system.debug('++++mapUniqueHierarchyListValues+++first'+mapUniqueHierarchyListValues);
        
        /*****************************************************************************************************
        * END OF FILLING THE MAP FOR THE DEFAULT VALUES OF THE DROP-DOWNS
        *****************************************************************************************************/
        
        /**************************************************************************
        *   ADDING VALUES FROM PROJECT MASTER TABLE TO THE MAP
        ***************************************************************************/
        
        for(SPE_ProjectMaster__c objPM : lstProjectMaster) {
            // creating the map of markets to market units
            if(objPM.Market__c != null && objPM.Market__c != ''){
                if(!strKeys.contains(objPM.Market__c+'~Market')) {
                   setMarketUnits = new Set<String>();
                   if(objPM.MarketUnit__c != null && objPM.MarketUnit__c != '')
                       setMarketUnits.add(objPM.MarketUnit__c);
                   mapUniqueHierarchyListValues.put(objPM.Market__c+'~Market',setMarketUnits);
                   strKeys.add(objPM.Market__c+'~Market');
                } else {
                   setMarketUnits = mapUniqueHierarchyListValues.get(objPM.Market__c+'~Market');
                   if(objPM.MarketUnit__c != null && objPM.MarketUnit__c != '')
                       setMarketUnits.add(objPM.MarketUnit__c);
                   mapUniqueHierarchyListValues.put(objPM.Market__c+'~Market',setMarketUnits);
                }
            }
            // creating the map of market + market unit as key and the set of countries as value
            if(objPM.Market__c != null && objPM.Market__c != '' && objPM.MarketUnit__c != null && objPM.MarketUnit__c != ''){
                if(!strKeys.contains(objPM.Market__c+objPM.MarketUnit__c)) {
                   setCountry = new Set<String>();
                   if(objPM.Country__c != null && objPM.Country__c != '')
                       setCountry.add(objPM.Country__c);
                   mapUniqueHierarchyListValues.put(objPM.Market__c+objPM.MarketUnit__c,setCountry);
                   strKeys.add(objPM.Market__c+objPM.MarketUnit__c);
                } else {
                   setCountry = mapUniqueHierarchyListValues.get(objPM.Market__c+objPM.MarketUnit__c);
                   if(objPM.Country__c != null && objPM.Country__c != '')
                       setCountry.add(objPM.Country__c);
                   mapUniqueHierarchyListValues.put(objPM.Market__c+objPM.MarketUnit__c,setCountry);
                }
            }
            // creating the map of market + market unit + country as key and the set of projects as value
            if(objPM.Market__c != null && objPM.Market__c != '' && objPM.MarketUnit__c != null && objPM.MarketUnit__c != '' 
                    && objPM.Country__c !=null && objPM.Country__c != ''){
                if(!strKeys.contains(objPM.Market__c+objPM.MarketUnit__c+objPM.Country__c)) {
                   setProject = new Set<String>();
                   if(objPM.Project__c != null && objPM.Project__c != '')
                       setProject.add(objPM.Project__c);
                   mapUniqueHierarchyListValues.put(objPM.Market__c+objPM.MarketUnit__c+objPM.Country__c,setProject);
                   strKeys.add(objPM.Market__c+objPM.MarketUnit__c+objPM.Country__c);
                } else {
                   setProject = mapUniqueHierarchyListValues.get(objPM.Market__c+objPM.MarketUnit__c+objPM.Country__c);
                   if(objPM.Project__c != null && objPM.Project__c != '')
                       setProject.add(objPM.Project__c);
                   mapUniqueHierarchyListValues.put(objPM.Market__c+objPM.MarketUnit__c+objPM.Country__c,setProject);
                }
            }
        }
        
        
        /**************************************************************************
        *   ADDING VALUES FROM PRODUCT MASTER TABLE TO THE MAP
        ***************************************************************************/
        for(SPE_BUBL__c objBUBL : lstBUBL) {
            // creating the map of business units to business lines
            if(objBUBL.BusinessUnit__c != null && objBUBL.BusinessUnit__c != ''){
                if(!strKeys.contains(objBUBL.BusinessUnit__c+'~BusinessUnit')) {
                   setBL = new Set<String>();
                   if(objBUBL.BusinessLine__c != null && objBUBL.BusinessLine__c != '')
                       setBL.add(objBUBL.BusinessLine__c);
                   mapUniqueHierarchyListValues.put(objBUBL.BusinessUnit__c+'~BusinessUnit',setBL);
                   strKeys.add(objBUBL.BusinessUnit__c+'~BusinessUnit');
                } else {
                   setBL = mapUniqueHierarchyListValues.get(objBUBL.BusinessUnit__c+'~BusinessUnit');
                   if(objBUBL.BusinessLine__c != null && objBUBL.BusinessLine__c != '')
                       setBL.add(objBUBL.BusinessLine__c);
                   mapUniqueHierarchyListValues.put(objBUBL.BusinessUnit__c+'~BusinessUnit',setBL);
                }
            }
            // creating the map of business units + business lines as key and the set of products as value
            if(objBUBL.BusinessUnit__c != null && objBUBL.BusinessUnit__c != '' && objBUBL.BusinessLine__c != null && objBUBL.BusinessLine__c != ''){
                if(!strKeys.contains(objBUBL.BusinessUnit__c+objBUBL.BusinessLine__c)) {
                   setProducts = new Set<String>();
                   if(objBUBL.Product__c != null && objBUBL.Product__c != '')
                       setProducts.add(objBUBL.Product__c);
                   mapUniqueHierarchyListValues.put(objBUBL.BusinessUnit__c+objBUBL.BusinessLine__c,setProducts);
                   strKeys.add(objBUBL.BusinessUnit__c+objBUBL.BusinessLine__c);
                } else {
                   setProducts = mapUniqueHierarchyListValues.get(objBUBL.BusinessUnit__c+objBUBL.BusinessLine__c);
                   if(objBUBL.Product__c != null && objBUBL.Product__c != '')
                       setProducts.add(objBUBL.Product__c);
                   mapUniqueHierarchyListValues.put(objBUBL.BusinessUnit__c+objBUBL.BusinessLine__c,setProducts);
                }
            }
        }
        
        /**************************************************************************
        *   ADDING VALUES FROM CATEGORY MASTER TABLE TO THE MAP
        ***************************************************************************/
        for(SPE_CategoryMaster__c ObjCM : lstCategoryMaster) {
            // creating the map of business units to business lines
            if(ObjCM.Cluster__c != null && ObjCM.Cluster__c != ''){
                if(!strKeys.contains(ObjCM.Cluster__c+'~CategoryArea')) {
                   setCategoryGroups = new Set<String>();
                   if(ObjCM.Group__c != null && ObjCM.Group__c != '')
                       setCategoryGroups.add(ObjCM.Group__c);
                   mapUniqueHierarchyListValues.put(ObjCM.Cluster__c+'~CategoryArea',setCategoryGroups);
                   strKeys.add(ObjCM.Cluster__c+'~CategoryArea');
                } else {
                   setCategoryGroups = mapUniqueHierarchyListValues.get(ObjCM.Cluster__c+'~CategoryArea');
                   if(ObjCM.Group__c != null && ObjCM.Group__c != '')
                       setCategoryGroups.add(ObjCM.Group__c);
                   mapUniqueHierarchyListValues.put(ObjCM.Cluster__c+'~CategoryArea',setCategoryGroups);
                }
            }
            // creating the map of business units + business lines as key and the set of products as value
            if(ObjCM.Cluster__c != null && ObjCM.Cluster__c != '' && ObjCM.Group__c != null && ObjCM.Group__c != ''){
                if(!strKeys.contains(ObjCM.Cluster__c+ObjCM.Group__c)) {
                   setCategory = new Set<String>();
                   if(ObjCM.Category__c != null && ObjCM.Category__c != '')
                       setCategory.add(ObjCM.Category__c);
                   mapUniqueHierarchyListValues.put(ObjCM.Cluster__c+ObjCM.Group__c,setCategory);
                   strKeys.add(ObjCM.Cluster__c+ObjCM.Group__c);
                } else {
                   setCategory = mapUniqueHierarchyListValues.get(ObjCM.Cluster__c+ObjCM.Group__c);
                   if(ObjCM.Category__c != null && ObjCM.Category__c != '')
                       setCategory.add(ObjCM.Category__c);
                   mapUniqueHierarchyListValues.put(ObjCM.Cluster__c+ObjCM.Group__c,setCategory);
                }
            }
        }
        system.debug('mapUniqueHierarchyListValues----' + mapUniqueHierarchyListValues.get('All Markets'));
        
        return mapUniqueHierarchyListValues;
    }

}