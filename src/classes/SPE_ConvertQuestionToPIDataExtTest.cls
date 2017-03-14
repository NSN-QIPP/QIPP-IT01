@isTest(SeeAllData = False)
public class SPE_ConvertQuestionToPIDataExtTest {
      /********************************************************************
    * Method name           :       SPE_ConvertQuestionToPIDataExtTest
    * Description           :       Covert Question to PI
    ** *****************************************************************
    * Sl.        Modification Date            Author             Description
    * -----------------------------------------------------------------------------
    *  1.        07/07/2015                 Amjad khan            Created                        
    */ 
    
        static testmethod void  positiveTestcase(){
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
            
            SPE_SurveyQuestion__c speQuestions= SPE_TestObjectCreator.CreateSurveyQuestion();
            insert speQuestions;
            SPE_PIDefinition__c PIDef=SPE_TestObjectCreator.CreatePIDefinition();
            PIDef.SurveyQuestion__c = speQuestions.Id;
            PIDef.LifecycleStage__c='Draft';
            insert PIDef;
            system.debug('@@@@@@@@@@'+speQuestions);
            ApexPages.CurrentPage().getparameters().put('Id', speQuestions.id);
            Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speQuestions);
            SPE_ConvertQuestionToPIDataExt SPE_Con= new SPE_ConvertQuestionToPIDataExt(stCon);
            SPE_Con.PICancel();
            SPE_Con.PISave();
      }
      
      static testmethod void  negativeTestcase(){
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
      
            SPE_SurveyQuestion__c speQuestions= SPE_TestObjectCreator.CreateSurveyQuestion();
            insert speQuestions;
            ApexPages.CurrentPage().getparameters().put('Id', speQuestions.id);
            Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(speQuestions);
            SPE_ConvertQuestionToPIDataExt SPE_Con= new SPE_ConvertQuestionToPIDataExt(stCon);
            SPE_Con.PIDef.LifecycleStage__c = 'Published';   
            SPE_Con.PISave();
      }
}