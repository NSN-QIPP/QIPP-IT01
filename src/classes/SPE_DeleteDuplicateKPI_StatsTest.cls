@isTest(SeeAllData=false)
private class SPE_DeleteDuplicateKPI_StatsTest{
    static testMethod void SPE_DeleteDuplicateKPI_StatsTestmethod(){
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';   
        picklistObj.Name = 'Picklist Default Values';   
        lstpicklistObj.add(picklistObj);     
        insert lstpicklistObj;
        
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        
        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
        insert pidef;
        pidef.LifecycleStage__c = 'Pilot';
        update pidef;
        
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.NumberValue__c =10;
        insert piVal;
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
           // kpiDefinition1.Buffer_Days__c =null;
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        
        SPE_KPIStats__c kpistats = new SPE_KPIStats__c();
        kpistats.ExecutionPeriod__c =String.valueof(Date.newInstance(2016,6,24));
        kpistats.KPI__c =kpiList[0].id;
        kpistats.Records__c=10;
        insert kpistats;
        system.debug('kpistats before delete::'+kpistats);
        delete kpistats;
        system.debug('kpistats after delete::'+kpistats);
        
    }
}