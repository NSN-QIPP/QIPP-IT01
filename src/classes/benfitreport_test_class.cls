@isTest
private class benfitreport_test_class {

    static testmethod void benfitreportnew_trigger(){
        test.startTest();
        Trigger_Control__c ts = QIPP_TestData_Helper.Trigger_Control(true);
        insert ts;
        Qipp_BU_reporting__C bureport = new Qipp_BU_reporting__C(Name = 'a1C17000001RjzZ');
        insert bureport;
        test.stopTest();
               
    }
}