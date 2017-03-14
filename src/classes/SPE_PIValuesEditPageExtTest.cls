@isTest(SeeAllData = False)
public class SPE_PIValuesEditPageExtTest
{
    public static testMethod void testSPE_PIValuesEditPageExt()
    {
         
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';        
        picklistObj.Project__c = 'All Projects';
        
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';               
        
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';       
        picklistObj.Product__c = 'All Products';
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        SPE_SurveyQuestion__c surveyQuestion = SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surveyQuestion;
        
        SPE_SurveyAnswer__c surveyAnswer = SPE_TestObjectCreator.CreateSurveyAnswer();
        surveyAnswer.SurveyQuestion__c = surveyQuestion.Id;
        insert surveyAnswer;
        
        List<SPE_PIDefinition__c> lstPIDef = new List<SPE_PIDefinition__c>();
        List<SPE_PIValues__c> lstPIVal = new List<SPE_PIValues__c>();
        
        Account sup = SPE_TestObjectCreator.CreateSupplier('1234');
        sup.EnterpriseID__c= '3M';
        insert sup;
        
        SPE_PIDefinition__c piDef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.DataAcquisitionMethod__c = 'Survey';
        pidef.LifecycleStage__c = 'Draft';
        piDef.SurveyQuestion__c = surveyQuestion.Id;
        piDef.Frequency__c = '0';
        insert piDef;             
        
        /*pidef.LifecycleStage__c = 'Pilot';
        update pidef;
        
        pidef.LifecycleStage__c = 'Published';
        update pidef;*/
        
        SPE_PIValues__c pivalues = new  SPE_PIValues__c();
        
        pivalues.BusinessUnit__c = 'All Business Units';
        pivalues.BusinessLine__c = 'All Business Lines';
        pivalues.Project__c = 'All Projects';           
        
        pivalues.Cluster__c = 'All Category Areas';
        pivalues.CategoryGroup__c= 'All Category Groups';
        pivalues.Category__c =  'All Categories';                                
        
        pivalues.Region__c='All Markets';
        pivalues.SubRegion__c= 'All Market Units';
        pivalues.Country__c= 'All Countries';
        pivalues.Product__c= 'All Products';
        
        pivalues.EnterpriseID__c= '3M';
        pivalues.Filter1__c= '1';
        pivalues.Filter10__c='2'; 
        pivalues.Filter2__c='3';
        pivalues.Filter3__c= '4';
        pivalues.Filter4__c= '5';
        pivalues.filter5__c='6';
        pivalues.Filter6__c= '7';
        pivalues.Filter7__c= '8';
        pivalues.Filter8__c= '9';
        pivalues.Filter9_del__c='10'; 
        pivalues.IsConverted__c= false;
        pivalues.NumberValue__c= 1;
        pivalues.Period__c= Date.newInstance(2015,07,3);
        pivalues.Supplier__c= sup.id;
        pivalues.PIDefination__c = pidef.id;
        System.assert(pivalues.Region__c != null);
        System.assert(pivalues.Category__c != null);
        System.assert(pivalues.BusinessUnit__c != null);
        insert pivalues;
    
        test.startTest();
        
        Pagereference pageRef = Page.SPE_PIValuesEditPage;       
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(pivalues);
        SPE_PIValuesEditPageExt edp = new SPE_PIValuesEditPageExt(sc);
        
        edp.savePIVal();
        edp.cancel();
        
        test.stopTest();
    }
    
    public static testMethod void testSPE_PIValuesEditPageExt1()
    {
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';        
        picklistObj.Project__c = 'All Projects';
        
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';               
        
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';       
        picklistObj.Product__c = 'All Products';
        
        
        lstpicklistObj.add(picklistObj);
        
        insert lstpicklistObj;
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        SPE_ProjectMaster__c projectMaster = new SPE_ProjectMaster__c();                  
        projectMaster.Market__c = 'INDIA'; 
        projectMaster.MarketUnit__c = 'INDIA BHARTI';          
        projectMaster.Country__c = 'India';
        projectMaster.Project__c = 'In Bharti 4G';
        insert projectMaster;
        
        SPE_BUBL__c BUBL = new SPE_BUBL__c();
        BUBL.BusinessUnit__c = 'Global Services';
        BUBL.BusinessLine__c = 'Network Implementation';
        BUBL.Product__c = 'WinPower Silver';
        insert BUBL;
        
        SPE_CategoryMaster__c categoryMaster = new SPE_CategoryMaster__c();
        categoryMaster.Cluster__c = 'Indirect Procurement';
        categoryMaster.Group__c = 'Facility';
        categoryMaster.Category__c = 'Facility Services';
        insert categoryMaster;
        
        List<SPE_PIDefinition__c> lstPIDef = new List<SPE_PIDefinition__c>();
        List<SPE_PIValues__c> lstPIVal = new List<SPE_PIValues__c>();
        
        Account sup = SPE_TestObjectCreator.CreateSupplier('1234');
        insert sup;
        
        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        
        //************Changes for Encryption**************//
             //pidef.name= 'test';
             pidef.PI_Title__c = 'test';
       //*************End******************//
       
        pidef.PIAbbreviation__c= 'abb';
        pidef.Type__c= 'Operational';
        pidef.ValuesType__c='Number';
        pidef.UoM__c='10';
        pidef.LifecycleStage__c='Draft';
        pidef.DataAcquisitionMethod__c='data load';
        pidef.CategoryScope__c='All Categories';
        pidef.BUScope__c='All Products';
        pidef.GeoScope__c ='All Markets';
        pidef.PIUploadDuedate__c = Date.newInstance(2020,07,10);
        insert pidef;
    
        pidef.LifecycleStage__c = 'Pilot';
        update pidef;
    
        lstPIDef.add(pidef);
    
        //System.currentPageReference().getParameters().put('pid', pidef.id); 
        
        SPE_PIValues__c pivalues = new  SPE_PIValues__c();
        
        pivalues.BusinessUnit__c = 'All Business Units';
        pivalues.BusinessLine__c = 'All Business Lines';
        pivalues.Project__c = 'All Projects';           
        
        pivalues.Cluster__c = 'All Category Areas';
        pivalues.CategoryGroup__c= 'All Category Groups';
        pivalues.Category__c =  'All Categories';                                
        
        pivalues.Region__c='All Markets';
        pivalues.SubRegion__c= 'All Market Units';
        pivalues.Country__c= 'All Countries';
        pivalues.Product__c= 'All Products';
        
        pivalues.EnterpriseID__c= '3M';
        pivalues.Filter1__c= '1';
        pivalues.Filter10__c='2'; 
        pivalues.Filter2__c='3';
        pivalues.Filter3__c= '4';
        pivalues.Filter4__c= '5';
        pivalues.filter5__c='6';
        pivalues.Filter6__c= '7';
        pivalues.Filter7__c= '8';
        pivalues.Filter8__c= '9';
        pivalues.Filter9_del__c='10'; 
        pivalues.IsConverted__c= false;           
        pivalues.NumberValue__c= 1;
        pivalues.Period__c= Date.newInstance(2016,07,3);
        pivalues.Supplier__c= sup.id;
        pivalues.PIDefination__c = pidef.id;
        System.assert(pivalues.Region__c != null);
        System.assert(pivalues.Category__c != null);
        System.assert(pivalues.BusinessUnit__c != null);
        
        lstPIVal.add(pivalues);
        
        test.startTest();
        
        Pagereference pageRef = Page.SPE_PIValuesEditPage;
        pageRef.getParameters().put('pid',piDef.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController scNew = new ApexPages.StandardController(pivalues);
        SPE_PIValuesEditPageExt edp = new SPE_PIValuesEditPageExt(scNew); 
        
        edp.savePIVal();
        edp.cancel();
        
        test.stopTest();
    }
    
}