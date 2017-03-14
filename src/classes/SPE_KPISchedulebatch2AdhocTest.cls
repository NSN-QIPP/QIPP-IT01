@isTest(SeeAllData = False)

public class SPE_KPISchedulebatch2AdhocTest
{
   public static testMethod void testSPE_KPISchedulebatch2Adhoc() 
    {
        
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
        
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.adhoc_date__c = system.today();
        kpidef.FrequencyinMonth__c = '2';
        insert kpidef;
        
        system.assertequals(kpidef.FrequencyinMonth__c,'2');
        
        List<SPE_KPICalculation__c> listSPcal = new List<SPE_KPICalculation__c>();
        
        for(Integer i=0;i<2;i++)
        {
            SPE_KPICalculation__c kpical = new SPE_KPICalculation__c();
            kpical.KPIDefinition__c= kpidef.id;
            listSPcal.add(kpical);
            
            system.assertEquals(kpical.KPIDefinition__c,kpidef.id);
        }
        
        insert listSPcal;
        Test.startTest();
        
         SPEKPIBatchSize__c btsiz = new SPEKPIBatchSize__c(name='KPI Batch Size',Size__c =2000);
         insert btsiz;
        
        
        
        SPE_KPISchedulebatch2Adhoc batch = new SPE_KPISchedulebatch2Adhoc(kpidef.id);
        Id processId = Database.executebatch(batch,2000);
         
        Test.stopTest();
        
    }
}