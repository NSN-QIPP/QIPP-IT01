public class SPE_DataLoaderExt {
    public SPE_PIValues__c objPIVal{get;set;}
    public string stepName{get;set;}
    public String strValueType{get;set;}
    public SPE_DataLoaderExt(ApexPages.StandardController con){
        objPIVal = new SPE_PIValues__c();
        if(con!=null){
          objPIVal.PIDefination__c = con.getId();
       	  strValueType = [select id,ValuesType__c from SPE_PIDefinition__c where id =: con.getId()].ValuesType__c;
          if(strValueType.equalsIgnoreCase('Number'))
              strValueType = 'NumberValue__c';
         if(strValueType.equalsIgnoreCase('Date'))
              strValueType = 'DateValue__c';
        if(strValueType.equalsIgnoreCase('Boolean'))
              strValueType = 'BooleanValue__c';
        if(strValueType.equalsIgnoreCase('String'))
              strValueType = 'StringValue__c';
        }
        stepName = 'Step 1';
    }
    public void go(){
        stepName = 'Step 2';
    }
    public void gomore(){
        stepName = 'Step 3';
    }
    public void prev(){
        stepName = 'Step 1';
    }
}