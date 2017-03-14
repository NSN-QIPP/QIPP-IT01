public class thresholdscopeAttributeMap{
    public Map<String,Boolean> enableattributesMap = new Map<String,Boolean>();        
    public Map<String,Boolean> initializeMapValue(){
        enableattributesMap.put('Market',true);
        enableattributesMap.put('Market Unit',true);
        enableattributesMap.put('Country',true);
        enableattributesMap.put('Project',true);
        enableattributesMap.put('Category Area',true);
        enableattributesMap.put('Category Group',true);
        enableattributesMap.put('Category',true);
        enableattributesMap.put('Business Unit',true);
        enableattributesMap.put('Business Line',true);
        enableattributesMap.put('Product',true);        
        return enableattributesMap;
    }
    
    public Map<String,Boolean> qualifyScopeAttributes(SPE_KPIDefinition__c kpiDef){
        //Map<String,Boolean> enableattributesMap = new Map<String,Boolean>();   
        // For Geography Scope Attributes values
        if(kpiDef.GeoScope__c ==SPE_Constants.ALL_GEOSCOPE){
            enableattributesMap.put('Market',false);
            enableattributesMap.put('Market Unit',false);
            enableattributesMap.put('Country',false);
            enableattributesMap.put('Project',false);            
        }
        if(kpiDef.GeoScope__c ==SPE_Constants.MARKET_GEOSCOPE){
            enableattributesMap.put('Market Unit',false);
            enableattributesMap.put('Country',false);
            enableattributesMap.put('Project',false);            
        }
        if(kpiDef.GeoScope__c ==SPE_Constants.MU_GEOSCOPE){
            enableattributesMap.put('Country',false);
            enableattributesMap.put('Project',false);            
        }
        if(kpiDef.GeoScope__c ==SPE_Constants.COUNTRY_GEOSCOPE ){
            enableattributesMap.put('Project',false);            
        }
        
           // For Category Scope Attributes values
        if(kpiDef.Categoryscope__c ==SPE_Constants.ALL_CATSCOPE ){
            enableattributesMap.put('Category Area',false);
            enableattributesMap.put('Category Group',false);
            enableattributesMap.put('Category',false);            
        }
        if(kpiDef.Categoryscope__c ==SPE_Constants.AREA_CATSCOPE ){
            enableattributesMap.put('Category Group',false);
            enableattributesMap.put('Category',false);            
        }
        if(kpiDef.Categoryscope__c  ==SPE_Constants.GROUP_CATSCOPE ){
            enableattributesMap.put('Category',false);            
        }
        
           // For Product Scope Attributes values
        if(kpiDef.BUScope__c ==SPE_Constants.ALL_BUSCOPE){
            enableattributesMap.put('Business Unit',false);
            enableattributesMap.put('Business Line',false);
            enableattributesMap.put('Product',false);            
        }
        if(kpiDef.BUScope__c ==SPE_Constants.BU_BUSCOPE){
            enableattributesMap.put('Business Line',false);
            enableattributesMap.put('Product',false);            
        }
        if(kpiDef.BUScope__c ==SPE_Constants.BL_BUSCOPE){
            enableattributesMap.put('Product',false);            
        }
        return enableattributesMap;
    }
}