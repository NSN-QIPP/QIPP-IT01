@isTest(SeeAllData=false)

private class SPE2ErrorLogCapturetest{

    static testmethod void testSPE2ErrorLogCapturetest(){
        
        integer a =2;
        integer b = 0;
        try{       
            SPE_Error_Log__c errorLog = new  SPE_Error_Log__c();   
            errorLog.DmlFieldNames__c = 'ABC' ;
            errorLog.DmlType__c   = 'YUW';
            errorLog.Error_Cause__c = 'dgf';
            errorLog.Description__c ='dfwe';
            errorLog.Error_Line__c = 5;
            errorLog.Exception_Type__c= 'dffgf';
            errorLog.Module_Name__c = 'pI';
            //errorLog .Related_User__c = User.id;
            errorLog.VisualforcePage_Name__c = 'hdh';
            insert errorLog;
            integer c = a/b;
        }catch(exception e){
            SPE2ErrorLogCapture.errorLogCapture(e);
        }
    }
}