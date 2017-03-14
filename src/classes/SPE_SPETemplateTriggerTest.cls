@isTest(SeeAllData = False)
public class SPE_SPETemplateTriggerTest 
{
    static TestMethod void updateTest()
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
        
        SPE_PIDefinition__c piDefinition = SPE_TestObjectCreator.CreatePIDefinition();
        piDefinition.LifecycleStage__c = 'Draft';
        piDefinition.ValuesType__c = 'Number';   
        piDefinition.DataAcquisitionMethod__c = 'Data Load';  
        piDefinition.PIUploadDuedate__c  = Date.newInstance(2020,10,10);     
        insert piDefinition;
        piDefinition.LifecycleStage__c = 'Published'; 
        update piDefinition;
        
        SPE_KPIDefinition__c kpiDefinition = SPE_TestObjectCreator.CreateKPIDefinition(1);
        
        kpiDefinition.PI_Data__c = piDefinition.Id;
        kpiDefinition.FrequencyinMonth__c = NULL;
        kpiDefinition.ScheduledDate__c = NULL;
        kpiDefinition.Buffer_Days__c = Null;
        
        insert kpiDefinition;
        
        SPE_SPETemplateTrigger speTemplateTrigger = new SPE_SPETemplateTrigger();
        List<SPE_SPETemplate__c> speTemplateList = new List<SPE_SPETemplate__c>();
        for(integer i=0;i<2;i++)
        {
        SPE_SPETemplate__c speTemplate = SPE_TestObjectCreator.CreateSPETemplate();
        speTemplate.Stage__c = 'Published';
        speTemplateList.add(speTemplate);
        }
        
        Insert speTemplateList;
        SPE_SPETemplateTrigger.DeleteValidation(speTemplateList);
        
     }     
}