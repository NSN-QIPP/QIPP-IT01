@isTest
private class QIPP_BG_Targets_Cntr_Test{
    
    
    static testmethod void method1(){
        List<BG_Targets__c> bgtList = new List<BG_Targets__c>();
        bgtList.add(insertBGTarget('2015'));
        bgtList.add(insertBGTarget('2016'));
        //bgtList.add(insertBGTarget('2016'));
        insert bgtList;
        
        Apexpages.Currentpage().getparameters().put('index','0');
        QIPP_BG_Targets_Cntr obj = new QIPP_BG_Targets_Cntr();
        obj.getYears();
        obj.getbgtargets();
        obj.AddRow();
        obj.Save();
        obj.cancel();
        obj.edit();        
        obj.deltraget();

        obj = new QIPP_BG_Targets_Cntr();
        obj.selectedYear = '2015';
        obj.getbgtargets();
    }
    
    private static BG_Targets__c insertBGTarget(String year){
        BG_Targets__c bgt = new BG_Targets__c();
        bgt.Business_Group__c = 'Human Resources';
        bgt.Total_Target__c = 123;
        bgt.P1__c = 10;
        bgt.P2__c = 15;
        bgt.P3__c = 13;
        bgt.P4__c = 14;
        bgt.P5__c = 18;
        bgt.P6__c = 48;
        bgt.P7__c = 21;
        bgt.P8__c = 23;
        bgt.P9__c = 18;
        bgt.P10__c = 19;
        bgt.P11__c = 20;
        bgt.P12__c = 25;
        bgt.Year__c = year;
        return bgt;
    }
}