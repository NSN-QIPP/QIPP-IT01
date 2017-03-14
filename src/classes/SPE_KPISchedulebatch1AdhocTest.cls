@isTest(seeAllData=False)

public class SPE_KPISchedulebatch1AdhocTest
{
   public static testMethod void testSPE_KPISchedulebatch1Adhoc() 
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
        insert kpidef;
        
        system.assertequals(kpidef.FrequencyinMonth__c,'2');
        
        List<SPE_PITempValue__c> listPItemp = new List<SPE_PITempValue__c>();
        
        for(integer i = 0;i<2;i++)
        {
             SPE_PITempValue__c pitempval = SPE_TestObjectCreator.createPITempValue();
             pitempval.KPIDefinition__c = kpidef.id;
             listPItemp.add(pitempval);
             system.assertequals(pitempval.KPIDefinition__c,kpidef.id);
        }
         
         insert listPItemp;
         
         Test.startTest();
         
         SPE_KPISchedulebatch1Adhoc bat = new SPE_KPISchedulebatch1Adhoc(listPItemp[0].id);
         
          //Query Locator
          Database.QueryLocator qryloc;
                
          //Batchable context
           Database.BatchableContext BatCon;
           qryloc = bat.start(BatCon);
                
           bat.execute(BatCon,listPItemp);
           SchedulableContext schCon = null;
                
          //execute method
           bat.execute(schCon);
          //finish method
           bat.finish(BatCon);
           
           Test.stopTest();
          
         //Id processId = Database.executebatch(bat,1000);
         
         
    }
}