public class SPE2ErrorLogCapture{
    public Static SPE_Error_Log__c errorLogCapture(Exception e){
        SPE_Error_Log__c errorLog = new SPE_Error_Log__c();
        errorLog.Related_User__c = UserInfo.getUserId();
        errorLog.Error_Line__c = e.getLineNumber();
        errorLog.Exception_Type__c = e.getTypeName();
        //errorLog.Error_Cause__c = e.getCause().getMessage();
        errorLog.Description__c = e.getMessage();
        /*if(e.getNumDML() > 0){
            for(integer i = 0; i < e.getNumDML(); i++){
                errorLog.DmlFieldNames__c += e.getDmlFieldNames(i) + ';';
            }
        }*/
        
        return errorLog;
    }
}