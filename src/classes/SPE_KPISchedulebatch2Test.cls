@IsTest(SeeAllData=false)
public class SPE_KPISchedulebatch2Test
{
   public static testMethod void testSPE_KPISchedulebatch2() 
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
        
        system.assertEquals(kpidef.FrequencyinMonth__c,'2');
        
         Supplier_KPI_Callculation__c call = SPE_TestObjectCreator.createSupplierKPICal();
         insert call;
        
        SPE_KPICalculation__c kpical = SPE_TestObjectCreator.createKPICalculation();
        kpical.KPIDefinition__c= kpidef.id;
        kpical.Aggregation__c= 'Constant';
        insert kpical;
        
        system.assertequals(kpical.KPIDefinition__c,kpidef.id);
        
        List<SPE_KPICalculation__c> lsitKPIcal = new List<SPE_KPICalculation__c>();
        lsitKPIcal.add(kpical);
        //insert lsitKPIcal;
        
        List <SPE_PITempValue__c> listPItempval = new List <SPE_PITempValue__c>();
         
         
         SPEKPIBatchSize__c btsiz = new SPEKPIBatchSize__c(name='KPI Batch Size',Size__c =2000);
         insert btsiz;
         
         
         system.assertequals(btsiz.name,'KPI Batch Size');
         
         for(Integer i = 0;i<2 ; i++)
         {
             SPE_PITempValue__c pitempval = SPE_TestObjectCreator.createPITempValue();
             pitempval.KPIDefinition__c = kpidef.id;
             listPItempval.add(pitempval);
             System.assertEquals(pitempval.KPIDefinition__c, kpidef.id);
         }
        
         
         insert listPItempval;
         
         
         Test.startTest(); 
         SPE_KPISchedulebatch2 bat = new SPE_KPISchedulebatch2();
         //Query Locator
                Database.QueryLocator qryloc;
                
                //Batchable context
                Database.BatchableContext BatCon;
                qryloc = bat.start(BatCon);
                
                bat.execute(BatCon,lsitKPIcal);
                SchedulableContext schCon = null;
                
                //execute method
                bat.execute(schCon);
                //finish method
                bat.finish(BatCon);
         
         
         Id processId = Database.executebatch(bat,150);
         Test.stopTest(); 
    }
}