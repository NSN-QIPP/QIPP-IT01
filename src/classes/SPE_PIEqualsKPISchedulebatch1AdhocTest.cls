@isTest(SeeAllData = False)

public class SPE_PIEqualsKPISchedulebatch1AdhocTest{
    
    public static testMethod void testSPE_PIEqualsKPISchedulebatch1Adhoc(){
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Market__c = 'All Markets';
        picklistObj.Name = 'Picklist Default Values';
        picklistObj.Product__c = 'All Products';
        picklistObj.Project__c = 'All Projects';
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        //-------insert SPE_KPIDefinition__c-----
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.FromDate__c = Date.today();
        KPI.ToDate__c = Date.today().addDays(5);
                
        insert KPI;
        
        //----SPE_KPIDefinition__c--- ends
        
        //-----insert KPI Values--------
        
        List<SPE_KPIValue__c> lstKPIValue = new List<SPE_KPIValue__c>();
        for(Integer i=0;i<2;i++){
            
        SPE_KPIValue__c  KPIValueObj = new SPE_KPIValue__c();
    
        KPIValueObj.KPIValue__c = 150.0;
        KPIValueObj.Period__c = Date.today().addDays(2);
        KPIValueObj.Category__c = 'Category';
        KPIValueObj.CategoryGroup__c = 'All Business Lines';
        KPIValueObj.BusinessLine__c = 'BL1';
        KPIValueObj.BusinessUnit__c = 'BU2';
        KPIValueObj.Region__c = 'APAC';
        KPIValueObj.SubRegion__c = 'Eastern Asia';
        KPIValueObj.Country__c = 'Country';
        KPIValueObj.Project__c = 'Project';
        KPIValueObj.EnterpriseID__c = 'Test Enterprise1';
        KPIValueObj.KPIDefinition__c = KPI.Id;
        KPIValueObj.Product__c = 'Product';
        KPIValueObj.ExecutionPeriod__c = SPE_Utility.monthsMap.get(KPIValueObj.Period__c.month()) + ' - '+ String.valueOf(KPIValueObj.Period__c.year());
        lstKPIValue.add(KPIValueObj);
        }
        insert lstKPIValue;
        
        test.startTest();
        
        SPE_PIEqualsKPISchedulebatch1Adhoc batchTest = new SPE_PIEqualsKPISchedulebatch1Adhoc(KPI.Id);
        Database.executebatch(batchTest,200);
        
        SchedulableContext sc = null;
        batchTest.execute(sc);
        
        test.stopTest();
        
        List<SPE_KPIValue__c> lstresult = [SELECT ID,Period__c FROM SPE_KPIValue__c WHERE KPIDefinition__c =: KPI.Id AND Period__c >= :KPI.FromDate__c AND Period__c <= :KPI.ToDate__c];
        system.assert(lstresult!=null);
       
            
    }

}