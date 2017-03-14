@isTest(seeAllData=false)

public class SPE_KPIAdhocScheduleExtTest
{
   public static testMethod void testSPE_KPIAdhocScheduleExt() 
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
    
        Date adhocDate = date.newInstance(2015,10,2);
        
        SPE_KPIDefinition__c kpiDefinition = new SPE_KPIDefinition__c();
        //*********************Changes For Encryption******************//  
                 //kpiDefinition.Name = 'Test KPI Definition';
                 kpiDefinition.KPI_Title__c = 'Test KPI Definition';
        //*********************END******************//
        
        kpiDefinition.AbbreviatedName__c = 'TKPIDef' ;
        kpiDefinition.Level__c = '1';
        kpiDefinition.LifecycleStage__c = 'Draft';
        kpiDefinition.Description__c = 'Test';
        kpiDefinition.MissingDatalogic__c = 'Logic1';
        kpiDefinition.OperationalType__c = 'Leading PI';
        kpiDefinition.GeoScope__c = 'All Markets';
        kpiDefinition.categoryscope__c = 'All Categories';
        kpiDefinition.BUScope__c = 'All Products';
        kpiDefinition.UoM__c = 'max';
        kpiDefinition.Group1__c = 'Cost';
        kpiDefinition.Group2__c = 'Hard';
        kpiDefinition.Type__c = 'Operational';
        kpiDefinition.FrequencyinMonth__c = '2';
        kpiDefinition.Number_Of_Months__c= 10;
        kpiDefinition.Adhoc_Date__c= adhocDate;
        kpiDefinition.ScheduledDate__c = system.today().addDays(5);
        insert kpiDefinition ;
        
        //kpiDefinition.Adhoc_Date__c = system.today();
        //update kpiDefinition;
          
        Test.startTest();
        
        PageReference pageRef = Page.SPE_KPIAdhocSchedulePage;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('yearVal','2015');
        ApexPages.currentPage().getParameters().put('monthVal','Jan');
        ApexPages.currentPage().getParameters().put('inputdate','25');
        ApexPages.currentPage().getParameters().put('Id',kpiDefinition.Id);
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(kpiDefinition);
        SPE_KPIAdhocScheduleExt objKPIAdhoc = new SPE_KPIAdhocScheduleExt(sc);
        system.assert(kpiDefinition.id!=null);
        
        
        //ApexPages.currentPage().getParameters().put(string.valueof(adhocDate),);
        
        objKPIAdhoc.getMonth();
        objKPIAdhoc.getYear();
        //objKPIAdhoc.scheduleBatch();
        Test.stopTest();
    }
}