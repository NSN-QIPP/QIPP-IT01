public class SPE2_ConvertQuestionToPIDataExt
{
    public SPE2_Question_Survey_Association__c speQuestions {get;set;}
    public SPE_SurveyQuestion__c speQue {get;set;}
    public SPE2Survey__c surveyObj;
    public boolean flag{get;set;}
    public SPE_PIDefinition__c PIDef {get;set;}
    public Id SId;
    public Id CurrentUserId {get;set;}
    public ID RecordOwnerId {get;set;}
    public SPE2_ConvertQuestionToPIDataExt( ApexPages.StandardController controller )
    {   
        
        flag =false;
        SId = ApexPages.currentPage().getParameters().get('sid');
        ID Qid = ApexPages.currentPage().getParameters().get('QID');
        surveyObj = new SPE2Survey__c();
        speQuestions = [SELECT ID,Question_Bank__c,Survey__c,Survey__r.FrequencyInMonths__c,PIData__c,PIData__r.DataAcquisitionMethod__c,Question_Bank__r.Name,
                         Question_Bank__r.QuestionLabel__c,Question_Bank__r.SurveyQuestion__c,Question_Bank__r.PIData__c,Survey__r.OwnerId,
                         Question_Bank__r.OwnerId,Question_Bank__r.PIType__c,Question_Bank__r.Business__c,
                         Question_Bank__r.GeoScope__c,Question_Bank__r.BUScope__c,Question_Bank__r.CategoryScope__c from SPE2_Question_Survey_Association__c
                         where Survey__c = :SId and Question_Bank__c =:Qid];
        speQue = [Select ID from SPE_SurveyQuestion__c where ID = :Qid];  
        surveyObj = [SELECT ID,BusinessLine__c,BusinessUnit__c,Category__c,CategoryArea__c,CategoryGroup__c,Country__c,Market__c,
                    MarketUnit__c,Product__c,Project__c from SPE2Survey__c where id = :SId];  
        CurrentUserId = UserInfo.getUserId();
         RecordOwnerId = [Select Id, ownerId from SPE2Survey__C
                          WHERE Id =: SId].ownerId;
                                 
        PIDef = new SPE_PIDefinition__c();             
        if(surveyObj!=null){
              if(surveyObj.CategoryArea__c == 'All Category Areas'){
                  PIDef.CategoryScope__c = 'All Categories';
       
               }
       
           if(surveyObj.CategoryArea__c != 'All Category Areas' && surveyObj.CategoryGroup__c == 'All Category Groups'){
                PIDef.CategoryScope__c = 'Category Area';
           
           }
           
           if(surveyObj.CategoryArea__c != 'All Category Areas' && surveyObj.CategoryGroup__c != 'All Category Groups' && surveyObj.Category__c== 'All Categories'){
               PIDef.CategoryScope__c = 'Category Group';
           
           }
           
            if(surveyObj.CategoryArea__c != 'All Category Areas' && surveyObj.CategoryGroup__c != 'All Category Groups' && surveyObj.Category__c != 'All Categories'){
                PIDef.CategoryScope__c = 'Category';
           
           }
           
           
           if(surveyObj.BusinessUnit__c == 'All Business Units'){
               PIDef.BUScope__c = 'All Products';
           
           }
           
           if(surveyObj.BusinessUnit__c != 'All Business Units' && surveyObj.BusinessLine__c == 'All Business Lines'){
               PIDef.BUScope__c = 'Business Unit';
           
           }
           
            if(surveyObj.BusinessUnit__c != 'All Business Units' && surveyObj.BusinessLine__c != 'All Business Lines' && surveyObj.Product__c == 'All Products'){
                PIDef.BUScope__c = 'Business Line';
           
           }
           
           if(surveyObj.BusinessUnit__c != 'All Business Units' && surveyObj.BusinessLine__c != 'All Business Lines' && surveyObj.Product__c != 'All Products'){
                PIDef.BUScope__c = 'Product';
           
           }
           
            if(surveyObj.Market__c == 'All Markets'){
               PIDef.GeoScope__c ='All Markets';
           
           }
           
           if(surveyObj.Market__c != 'All Markets' && surveyObj.MarketUnit__c == 'All Market Units'){
               PIDef.GeoScope__c ='Market';
           
           }
           
           if(surveyObj.Market__c != 'All Markets' && surveyObj.MarketUnit__c != 'All Market Units' && surveyObj.Country__c == 'All Countries'){
               PIDef.GeoScope__c ='Market Unit';
           
           }
            if(surveyObj.Market__c != 'All Markets' && surveyObj.MarketUnit__c != 'All Market Units' && surveyObj.Country__c != 'All Countries' && surveyObj.Project__c == 'All Projects'){
               PIDef.GeoScope__c ='Country';
           
           }
           
           if(surveyObj.Market__c != 'All Markets' && surveyObj.MarketUnit__c != 'All Market Units' && surveyObj.Country__c != 'All Countries' && surveyObj.Project__c != 'All Projects'){
               PIDef.GeoScope__c ='Project';
           
           }
            
        
        }                       
        
       if(speQuestions.Question_Bank__r.PIData__c != null){
            flag=true;
        }                  
       
        
        //*********Changes for Encryption*************//
        //PIDef.Name= speQuestions.SurveyQuestion__c;
        PIDef.PI_Title__c = speQuestions.Question_Bank__r.SurveyQuestion__c;
        //**********End****************//
        
        PIDef.OwnerId = speQuestions.Survey__r.OwnerId;
        PIDef.LifecycleStage__c = 'Draft';
        PIDef.SourceDataOwner__c = 'Survey';
        PIDef.ValuesType__c = 'Number';
        PIDef.Type__c = speQuestions.Question_Bank__r.PIType__c;
        PIDef.DataAcquisitionMethod__c = 'Standalone Survey';
        PIDef.UoM__c = 'Number';
        PIDef.Business__c = speQuestions.Question_Bank__r.Business__c;
       // PIDef.GeoScope__c = speQuestions.Question_Bank__r.GeoScope__c;
       // PIDef.BUScope__c = speQuestions.Question_Bank__r.BUScope__c;
       // PIDef.CategoryScope__c = speQuestions.Question_Bank__r.CategoryScope__c;
        PIDef.SurveyQuestion__c = speQuestions.Question_Bank__r.Id;
      //  PIDef.Frequency__c = speQuestions.Survey__r.FrequencyInMonths__c;
        
    }
    
    
    public pageReference PICancel(){
        pageReference pg = new pageReference('/apex/SPE2_ValidateQuestionInSurvey?id='+SId);
        return pg;
    }
    public pageReference PISave(){
        try{
            insert PIDef;
            speQuestions.PIData__c=PIDef.Id;
            upsert speQue;
            upsert speQuestions;
            pageReference pg = new pageReference('/apex/SPE2_ValidateQuestionInSurvey?id='+SId);
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