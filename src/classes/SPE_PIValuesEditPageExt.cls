public with sharing class SPE_PIValuesEditPageExt 
{
    public SPE_PIValues__c piValues{get;set;}
    public string StageValues{get;set;}
    public string marketVal{get;set;}
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;}
    public string projectVal{get;set;}
    public string buVal{get;set;}
    public string blVal{get;set;}
    public string prdVal{get;set;}
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public string strSaveNNew{get;set;}
    public Boolean isDraftPI{get;set;}
    public Boolean isSurveyPI{get;set;}
    public Boolean Flag{get;set;}
    private String errorMessage = '';
    private SPE_PIDefinition__c objPIDef = new SPE_PIDefinition__c();
        
    Map<string,string> URLParameters;
    String strPIData;
    
    public String piValuesType {get;set;}
    
    public SPE_PIValuesEditPageExt(ApexPages.StandardController con)
    {
        flag=false;
        isDraftPI = false;
        strSaveNNew='';
        piValues = new SPE_PIValues__c();
        
        URLParameters = ApexPages.currentPage().getParameters();
        
        if (con.getId() != null)
        {
            
            piValues = [SELECT id, BooleanValue__c, BusinessLine__c, BusinessUnit__c, Category__c,
                               Cluster__c, CategoryGroup__c, Country__c, DateValue__c, EnterpriseID__c,
                               Filter1__c, Filter10__c, Filter2__c, Filter3__c, Filter4__c, filter5__c,
                               Filter6__c, Filter7__c, Filter8__c, Filter9_del__c, IsConverted__c, Region__c,
                               SubRegion__c, NumberValue__c, Period__c, PIDefination__c,Product__c, Project__c,
                               StringValue__c, Supplier__c, PIDefination__r.LifecycleStage__c, PIDefination__r.SurveyQuestion__c
                        FROM SPE_PIValues__c
                        WHERE id=: con.getId()];
            
            SPE_MathsUtil.market1 = piValues.Region__c;
            SPE_MathsUtil.bu1 = piValues.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = piValues.SubRegion__c;
            SPE_MathsUtil.bl1 = piValues.BusinessLine__c;
            SPE_MathsUtil.country1 = piValues.Country__c;
            SPE_MathsUtil.prd1 = piValues.Product__c;
            SPE_MathsUtil.project1 = piValues.Project__c;
            SPE_MathsUtil.ca1 = piValues.Cluster__c;
            SPE_MathsUtil.cg1 = piValues.CategoryGroup__c;
            SPE_MathsUtil.ct1 = piValues.Category__c;
            
            if (piValues.PIDefination__r.LifecycleStage__c == 'Draft'  || piValues.PIDefination__r.LifecycleStage__c == 'Obsolete')
            {
                isDraftPI = true;
                StageValues = piValues.PIDefination__r.LifecycleStage__c;
                Flag=true;
            }
                if(piValues.PIDefination__r.SurveyQuestion__c != null){
                    isSurveyPI= true;
                    Flag=true;    
                 }
            
            SPE_PIDefinition__c piDef = [SELECT id, ValuesType__c 
                                         FROM SPE_PIDefinition__c 
                                         WHERE Id =: piValues.PIDefination__c];
            
            
            piValuesType = piDef.ValuesType__c;
        
        }
        else if (ApexPages.currentPage().getparameters().get('pid') != null)
        {
            SPE_PIDefinition__c piDef = [SELECT id, LifecycleStage__c,SurveyQuestion__c,SurveyQuestion__r.name, ValuesType__c  
                                         FROM SPE_PIDefinition__c 
                                         WHERE Id =: ApexPages.currentPage().getparameters().get('pid')];
            
            if (piDef.LifecycleStage__c == 'Draft' || piDef.LifecycleStage__c == 'Obsolete')
            {
                isDraftPI = true;
                StageValues = piDef.LifecycleStage__c;
                Flag=true;
            }
                if(piDef.SurveyQuestion__c != null){ 
                isSurveyPI= true;
                Flag=true;  
                 }
            
            piValues.PIDefination__c = piDef.Id;
            
            piValuesType = piDef.ValuesType__c;
        }
        
        /*
        if(URLParameters.containsKey('retURL'))
        {
            strPIData = ApexPages.currentPage().getparameters().get('retURL');
            piValues.PIDefination__c = strPIData.contains('/') ? strPIData.remove('/'): strPIData;
            objPIDef = [select id, LifecycleStage__c,SurveyQuestion__c,SurveyQuestion__r.name from SPE_PIDefinition__c where Id =: piValues.PIDefination__c];
            StageValues=objPIDef.LifecycleStage__c;
            isSurveyPI=objPIDef.SurveyQuestion__r.name;  
            if (objPIDef.LifecycleStage__c !=null && objPIDef.LifecycleStage__c !='' && (objPIDef.LifecycleStage__c == 'Draft' || objPIDef.SurveyQuestion__c != null || objPIDef.LifecycleStage__c == 'Obsolete'))
                isDraftPI = true;
            
                      
        }
        if(URLParameters.containsKey('id'))
        {
            piValues = [SELECT id, BooleanValue__c, BusinessLine__c, BusinessUnit__c, Category__c,
                               Cluster__c, CategoryGroup__c, Country__c, DateValue__c, EnterpriseID__c,
                               Filter1__c, Filter10__c, Filter2__c, Filter3__c, Filter4__c, filter5__c,
                               Filter6__c, Filter7__c, Filter8__c, Filter9_del__c, IsConverted__c, Region__c,
                               SubRegion__c, NumberValue__c, Period__c, PIDefination__c,Product__c, Project__c,
                               StringValue__c, Supplier__c
                        FROM SPE_PIValues__c
                        WHERE id=:ApexPages.currentPage().getparameters().get('id')];
            
            SPE_MathsUtil.market1 = piValues.Region__c;
            SPE_MathsUtil.bu1 = piValues.BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = piValues.SubRegion__c;
            SPE_MathsUtil.bl1 = piValues.BusinessLine__c;
            SPE_MathsUtil.country1 = piValues.Country__c;
            SPE_MathsUtil.prd1 = piValues.Product__c;
            SPE_MathsUtil.project1 = piValues.Project__c;
            SPE_MathsUtil.ca1 = piValues.Cluster__c;
            SPE_MathsUtil.cg1 = piValues.CategoryGroup__c;
            SPE_MathsUtil.ct1 = piValues.Category__c; 
        }*/
    }
    
    public pageReference savePIVal()
    {
        
        piValues.Region__c = marketVal;
        piValues.BusinessUnit__c = buVal;
        piValues.SubRegion__c = marketUnitVal;
        piValues.BusinessLine__c = blVal;
        piValues.Country__c = countryVal;
        piValues.Product__c = prdVal;
        piValues.Project__c = projectVal;
        piValues.Cluster__c = caVal;
        piValues.CategoryGroup__c = cgVal;
        piValues.Category__c = ctVal;
        
        try{
        upsert piValues;
        }
        catch(exception ex){
            return null;
        }
        
        PageReference pageRef = new PageReference('/'+piValues.PIDefination__c);
        
        return pageRef;
    }
    
    public Pagereference cancel()
    {  
        Pagereference pr = new Pagereference('/');
        pr =new Pagereference('/'+piValues.PIDefination__c);
        return pr;
    }
    
    /*private Boolean checkHierarchyValidation()
    {    
        
        SPE_MasterDataExt masterData = new SPE_MasterDataExt();
        List<PicklistDefaultValues__c> defaultPicklistValues =  PicklistDefaultValues__c.getall().values();
        
        if (marketUnitVal != defaultPicklistValues[0].Market_Unit__c)
        {
            if (!masterData.marketVsMarketUnitCountryProjectMap.get(marketVal).get(marketUnitVal).keySet().contains(countryVal))
            {
               errorMessage = 'Please correct Hierarchy Data';
               return false; 
            }
        }
        
        else
        {
            if (countryVal != defaultPicklistValues[0].Country__c && projectVal != defaultPicklistValues[0].Project__c)
            {
                errorMessage = 'Please correct Hierarchy Data';
                return false;
            }
            
        }
        
        if (cgVal != defaultPicklistValues[0].Category_Group__c && !masterData.ctgAreaVsctgGroupCtgMap.get(caVal).get(cgVal).contains(ctVal))
        {
           errorMessage = 'Please correct Hierarchy Data';
           return false; 
        }
        
        if (blVal != defaultPicklistValues[0].Business_Line__c && !masterData.BUVsBLProduct.get(buVal).get(blVal).contains(prdVal))
        {
           errorMessage = 'Please correct Hierarchy Data';
           return false; 
        }
        
        
        return true;
    }*/
}