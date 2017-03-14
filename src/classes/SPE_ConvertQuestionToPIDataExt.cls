public class SPE_ConvertQuestionToPIDataExt
{
    public SPE_SurveyQuestion__c speQuestions {get;set;}
    public boolean flag{get;set;}
    public SPE_PIDefinition__c PIDef {get;set;}
    public SPE_ConvertQuestionToPIDataExt( ApexPages.StandardController controller )
    {   
        
        flag =false;
        ID id = ApexPages.currentPage().getParameters().get('id');
        speQuestions = [SELECT Id, Name, AnswerType__c,PIData__c,QuestionLabel__c,QuestionAbbreviation__c, PIDefinition__c, SurveyQuestion__c, IsRequired__c, BUScope__c, Business__c,
                                CategoryScope__c, GeoScope__c, PIType__c, OperationalType__c, OwnerId   
                         FROM SPE_SurveyQuestion__c 
                         WHERE Id =: id];
       if(speQuestions.PIData__c != null){
            flag=true;
        }                  
        PIDef = new SPE_PIDefinition__c();
        
        //*********Changes for Encryption*************//
        //PIDef.Name= speQuestions.SurveyQuestion__c;
        PIDef.PI_Title__c = speQuestions.SurveyQuestion__c;
        //**********End****************//
        
        PIDef.OwnerId = speQuestions.OwnerId;
        PIDef.LifecycleStage__c = 'Draft';
        PIDef.SourceDataOwner__c = 'Survey';
        PIDef.ValuesType__c = 'Number';
        PIDef.Type__c = speQuestions.PIType__c;
        PIDef.DataAcquisitionMethod__c = 'Survey';
        PIDef.UoM__c = 'Number';
        PIDef.Business__c = speQuestions.Business__c;
        PIDef.GeoScope__c = speQuestions.GeoScope__c;
        PIDef.BUScope__c = speQuestions.BUScope__c;
        PIDef.CategoryScope__c = speQuestions.CategoryScope__c;
        PIDef.SurveyQuestion__c = speQuestions.Id;
        
    }
    
    
    public pageReference PICancel(){
        pageReference pg = new pageReference('/'+speQuestions.id);
        return pg;
    }
    public pageReference PISave(){
        try{
            insert PIDef;
            speQuestions.PIData__c=PIDef.Id;
            upsert speQuestions;
            pageReference pg = new pageReference('/'+PIDef.Id);
            return pg;
        }catch(System.DmlException ex){
            String err = ex.getMessage();
            ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,ex.getDmlMessage(0));
            Apexpages.addMessage(msg);
            return null;
        }
        return null;
        
    }
    
}