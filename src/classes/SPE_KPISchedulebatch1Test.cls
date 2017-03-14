@isTest(SeeAllData = False)

public class SPE_KPISchedulebatch1Test
{
   public static testMethod void testSPE_KPISchedulebatch1() 
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
        
        
         List <SPE_PITempValue__c> listPItempval = new List <SPE_PITempValue__c>();
         
         for(Integer i =0; i <2;i++)
         {
        
             SPE_PITempValue__c pitempval = SPE_TestObjectCreator.createPITempValue();
             
             pitempval.KPIDefinition__c = kpidef.id;
             listPItempval.add(pitempval);
             system.assertequals(pitempval.KPIDefinition__c,kpidef.id);
         }
         
         insert listPItempval;
         
         
         //Not available in Utility class
         SPEKPIBatchSize__c btsiz = new SPEKPIBatchSize__c(name='test',Size__c =2000);
         insert btsiz;
         
         SPE_KPICalculation__c kpical = SPE_TestObjectCreator.createKPICalculation();
         insert kpical;
         
         test.startTest();
         
         SPE_KPISchedulebatch1 bat = new SPE_KPISchedulebatch1();
         //Query locator
            Database.QueryLocator Qryloc;
            //BC
            Database.BatchableContext BC;
            Qryloc = bat.start(BC);
            
            //execution
            bat.execute(BC,listPItempval);
            SchedulableContext sc = null;
            bat.execute(sc);
            
            bat.finish(BC);
            test.stopTest();
          
         //Id processId = Database.executebatch(bat,Integer.valueof(btsiz.size__c));
         
       }
}