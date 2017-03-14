public without sharing class SPE_Constants {
/**************************************************************************************
Apex Controller Name :  SPE_Constants 
Version              :  1.0 
Created Date         :  07/29/2015
Function             :  This controller holds all constant values.
              
Modification Log     :
-----------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                  
* Kaushik Ganguly             07/29/2015                      Original Version
*************************************************************************************/   
    
    public static final String SURVEY_ANSWERTYPE = 'Picklist';
    public static final String KPICALC_MINSUPPLIER_AGGREGATION = 'Min( Across Suppliers)';
    public static final String KPICALC_MAXSUPPLIER_AGGREGATION = 'Max( Across Suppliers)';
    public static final String KPICALC_AVGSUPPLIER_AGGREGATION = 'Avg( Across Suppliers)';
  // public static final String KPICALC_CONSTANTAGGREGATION = 'Constant';
    public static final String KPICALC_SUMAGGREGATION = 'Sum';
    public static final String KPICALC_AVGAGGREGATION = 'Avg';
    public static final String KPICALC_MINAGGREGATION = 'Min';
    public static final String KPICALC_MAXAGGREGATION = 'Max';
    public static final String KPICALC_NOAGGREGATION = '--None--';
    public static final String KPICALC_COUNTAGGREGATION = 'Count';
    public static final String CONSTANTVALUE = 'Constant';
    
    public static final String PUBLISHED_LIFECYCLESTAGE = 'Published';
    public static final String PILOT_LIFECYCLESTAGE = 'Pilot';
    public static final String DRAFT_LIFECYCLESTAGE = 'Draft';
    
   // public static final String PI_LIFECYCLE = 'Constant';
    public static final String PI_OBSOLETE_LIFECYCLE = 'Obsolete';
    public static final String PI_DATEVALUETYPE = 'Date';
    public static final String PI_STRINGVALUETYPE = 'String';
    public static final String PI_BOOLEANVALUETYPE = 'Boolean';
    public static final String PI_NUMBERVALUETYPE = 'Number';
    
    public static final String SURVEY_DATAACQUISITION = 'Survey';
    public static final String DATALOAD_DATAACQUISITION = 'Data Load';
   
    public static final String NUMBERVALUE = 'NumberValue__c';
    public static final String DATEVALUE = 'DateValue__c';
    public static final String BOOLEANVALUE = 'BooleanValue__c';
    public static final String STRINGVALUE = 'StringValue__c';
  
    public static final String PRODUCT_BUSCOPE = 'Product';
    public static final String BL_BUSCOPE = 'Business Line';
    public static final String BU_BUSCOPE = 'Business Unit';
    public static final String ALL_BL_BUSCOPE = 'All Business Lines';
    public static final String ALL_BU_BUSCOPE = 'All Business Units';
    public static final String ALL_BUSCOPE = 'All Products';
    public static final String CATSCOPE = 'Category';
    public static final String GROUP_CATSCOPE = 'Category Group';
    public static final String AREA_CATSCOPE = 'Category Area';
    public static final String ALL_CATSCOPE = 'All Categories';
    public static final String PRJ_GEOSCOPE = 'Project';
    public static final String COUNTRY_GEOSCOPE = 'Country';
    public static final String MU_GEOSCOPE = 'Market Unit';
    public static final String MARKET_GEOSCOPE = 'Market';
    public static final String ALL_GEOSCOPE = 'All Markets';
    public static final String ALL_GEOSCOPE_UNIT = 'All Market Units';
    public static final String ALL_Country = 'All Countries';
    public static final String ALL_Project = 'All Projects';
    public static final String ALL_CATSCOPE_AREA = 'All Category Areas';
    public static final String ALL_CATSCOPE_GROUP = 'All Category Groups';
    
    public static final String CO_COUNTRY = 'CO Country';
    public static final String CO_SUBREGION = 'CO Subregion';
    public static final String BUBL= 'BUBL';
   
    public static final String STEP1= 'Step 1';
    public static final String STEP2= 'Step 2';
    public static final String STEP3= 'Step 3';
    
    public static final String KPIAdhocScheduleJob= 'KPIAdhocScheduleJob';
    public static final String AdhocScheduleJob= 'AdhocScheduleJob';
    
    public static final String TESTVALUE= 'test';
    public static final String ENTERPRISEVALUEACROSS = 'Across';
    public static final String STATUS_PENDING = 'Pending';
    public static final String STATUS_ABANDONED = 'Abandoned';
    public static final String STATUS_COMPLETED = 'Completed';
    
    public static final String SPE_PIDATABATCHEMAILTEMPLATE = 'SPE_PIDataBatchEmailTemplate';
    
    public static final String SPE_SURVEYKPIVIEWPAGE = 'SPE2_SurveyKPIView';
    
    public static final String SURVEYPICKLIST = 'Picklist';
    public static final String SURVEYFREETEXT = 'Free Text';
    
    
    public static final String DATALOGICACTUAL = 'Actual';
    public static final String DATALOGICASSUMED = 'Assumed';
    public static final String DATALOGICINVALID = 'Invalid';
    public static final String DATALOGICINDICATOR = 'Indicator';
    public static final String MISSINGDATALOGIC1= 'Past Data or Category Average';
    public static final String MISSINGDATALOGIC2= 'SPE Invalid';
    public static final String MISSINGDATALOGIC3= 'Ignore KPI for SPE';
    
    public static final String COLOR_0 = '#99C2EB';
    public static final String COLOR_1 = '#B20000';
    public static final String COLOR_2 = '#E09999';
    public static final String COLOR_3 = '#FFC200';
    public static final String COLOR_4 = '#99C299';
    public static final String COLOR_5 = '#006600';
    public static final String COLOR_6 = '#FFCCCC';
    public static final String COLOR_7 = '#ADD8E6';
    public static final String FontCOLOR_6 = '#FF0000';
    
    public static final String KPIAGGREGATION_AVG = 'AVG';
    public static final String KPIAGGREGATION_SUM = 'SUM';
    public static final String KPIAGGREGATION_MIN = 'MIN';
    public static final String KPIAGGREGATION_MAX = 'MAX';
    
 // public static final String KPICALC_ALL_BUSCOPE = 'All Products';
  
  
}