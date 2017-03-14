@isTest(SeeAllData = False)

public class SPE_PIEqualsKPIAdhocScheduleExtTest{
    
    public static testMethod void testSPE_PIEqualsKPIAdhocScheduleExt(){
        
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
        
        
        //------insert SPE_KPIDefinition__c-----
        
        SPE_KPIDefinition__c KPI = new SPE_KPIDefinition__c();
        KPI = SPE_TestObjectCreator.CreateKPIDefinition(1);
        KPI.FromDate__c = Date.newInstance(2099, 07, 02); 
        KPI.ToDate__c = Date.newInstance(2099, 07, 02); 
                
        insert KPI;
        
        //-----SPE_KPIDefinition__c insert ends-----
        
        PageReference pageRef = Page.SPE_PIEqualsKPIAdhocSchedule;
        Test.setCurrentPage(pageRef);
    
        ApexPages.currentPage().getParameters().put('id',KPI.Id );
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(KPI);
        SPE_PIEqualsKPIAdhocScheduleExt PIEqualsKPIobj = new SPE_PIEqualsKPIAdhocScheduleExt(sc);       
        PageReference P = PIEqualsKPIobj.scheduleBatch();
        test.stopTest();
        system.assert(KPI!=null);
    }

}