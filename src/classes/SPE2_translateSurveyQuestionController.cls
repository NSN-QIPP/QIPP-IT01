public class SPE2_translateSurveyQuestionController {
    
    public string selectedValue {get;set;}
    public List<SelectOption> statusOptions {get;set;}
    public boolean showOption {get;set;}
    public boolean showquestion {get;set;}
    public boolean abc{get;set;}
    public id questionId {get;set;}
    public list<ansWrapperCls> listansWrapperCls {get;set;}
    Private List<SPE2_LanguageList__c> languages;
    
    /*
    objects question and answer retrieved for translation
    */
        public SPE_SurveyQuestion__c qestionTransReq {get;set;}
        public list<SPE_SurveyAnswer__c> answerTransreq {get;set;}
    
    /*
    objects Question and answers are stored after translation
    */
        public SPE_SurveyQuestion__c translatedQuestion {get;set;}
        public list<SPE_SurveyAnswer__c> translatedAnswers{get;set;}
   
    /*
    Question already translated
    */
        public SPE_SurveyQuestion__c presenttranslatedQuestion {get;set;}
        public list<SPE_SurveyAnswer__c> presenttranslatedAnswers {get;set;}


public SPE2_translateSurveyQuestionController(ApexPages.StandardController st) {
           
            showquestion =false;
            abc=false;
            listansWrapperCls= new list<ansWrapperCls>();
            
            
            questionId= st.getId();
            
            translatedQuestion= new SPE_SurveyQuestion__c();
            translatedAnswers=new List<SPE_SurveyAnswer__c>();
            //Question and Answers Need to be transalted
            qestionTransReq= [select id,QuestionLabel__c, name,SurveyQuestion__c,AnswerType__c,IsActive__c,MaxScore__c,IsRequired__c,
                                                           Question_Bank__c ,PIData__c,Is_Translated__c,Parent_Survey_Question__c  from SPE_SurveyQuestion__c where id=:questionId];
            system.debug('test tran'+qestionTransReq.Is_Translated__c);
            //if(qestionTransReq.Is_Translated__c!=true){
            showOption =true;
            answerTransreq= [select id,Choices__c,OrderNumber__c,Score__c from SPE_SurveyAnswer__c where SurveyQuestion__c=:questionId];
            
            
            //listansWrapperCls.add(answerTransreq);
           //section for populating the Language field.
            statusOptions = new list<SelectOption>();
            languages =SPE2_LanguageList__c.getall().values();
            languages.sort();
            for(SPE2_LanguageList__c lang : languages ){
                 statusOptions.add(new SelectOption(lang.Name,lang.Language__c));    
            }
            
            /*    Schema.DescribeFieldResult fieldResult = User.LanguageLocaleKey.getDescribe();
                    for (Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()){
                    if(pickListEntry.getLabel() != 'English')
                        statusOptions.add(new SelectOption(pickListEntry.getLabel(),pickListEntry.getLabel()));
                }*/
             //}   
   /*else{
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: This is a translated Question');
            ApexPages.addMessage(myMsg);
       }*/       
    }
    
    
    
    
  public void Next() {
       showOption =false;
       showquestion =true;
       presenttranslatedQuestion =new SPE_SurveyQuestion__c();
       presenttranslatedAnswers= new list<SPE_SurveyAnswer__c>();
                   try{
                           presenttranslatedQuestion = [select id,QuestionLabel__c, name,SurveyQuestion__c,AnswerType__c,IsRequired__c,IsActive__c,MaxScore__c,
                                                       PIData__c,Parent_Survey_Question__c  from SPE_SurveyQuestion__c where Question_Bank__c=:questionId 
                                                       AND Secondary_Language__c=: selectedValue];
                       }
                   catch(Exception e){
                       presenttranslatedQuestion = null;
                   }
            
                        if(presenttranslatedQuestion!=NULL)
                            {
                               abc=true;
                               presenttranslatedAnswers= [select id,Choices__c,OrderNumber__c,Score__c,PrimarySurvey_Answer__c,
                                                          PrimarySurvey_Answer__r.Choices__c,PrimarySurvey_Answer__r.Score__c
                                                          From SPE_SurveyAnswer__c Where SurveyQuestion__c=:presenttranslatedQuestion.id];
                               if(presenttranslatedAnswers.size()>0){
                                  
                                       for(SPE_SurveyAnswer__c testvariable :presenttranslatedAnswers)
                                       {
                                            ansWrapperCls aa = new ansWrapperCls();
                                            aa.answerID=testvariable.id;
                                            aa.AnswerChoices = testvariable.PrimarySurvey_Answer__r.Choices__c;
                                            aa.AnswerValue =  testvariable.PrimarySurvey_Answer__r.Score__c;
                                            aa.SecondaryChoices=testvariable.Choices__c;
                                            aa.primaryAnswerId = testvariable.id;
                                            listansWrapperCls.add(aa);
                                       }
                                }
                                system.debug('enter at 91'+presenttranslatedAnswers);
                            }
                            else
                             {
                               system.debug('Test Else part'+answerTransreq);
                                   for(SPE_SurveyAnswer__c testvariable :answerTransreq)
                                   {
                                        ansWrapperCls aa = new ansWrapperCls();
                                        aa.AnswerChoices = testvariable.Choices__c;
                                        aa.AnswerValue =  testvariable.Score__c;
                                        aa.primaryAnswerId = testvariable.id;
                                        listansWrapperCls.add(aa);
                                    }
                               }    
                
            }
    
    public pageReference save()
        {
        if(abc==true){
            
            presenttranslatedQuestion.Is_Translated__c=true;
            update presenttranslatedQuestion; 
            //update listansWrapperCls;
            //update presenttranslatedAnswers;
            for(ansWrapperCls listoftranslatedanswers : listansWrapperCls ){
                      SPE_SurveyAnswer__c Translateans= new SPE_SurveyAnswer__c();
                       Translateans.id=listoftranslatedanswers.answerID;
                       Translateans.Choices__c= listoftranslatedanswers.SecondaryChoices;
                       Translateans.Secondary_Language__c=selectedValue;
                       Translateans.Score__c=listoftranslatedanswers.AnswerValue;
                       translatedAnswers.add(Translateans);
                }
             update translatedAnswers;  
            //PageReference pgref = new PageReference('/' + presenttranslatedQuestion.id);
            PageReference pgref = new PageReference('/' + questionId);
                pgref.setRedirect(true);
                return pgref;
        }
        else{
            
                translatedQuestion.QuestionLabel__c=qestionTransReq.QuestionLabel__c;
                translatedQuestion.PIData__c=qestionTransReq.PIData__c;
                translatedQuestion.Question_Bank__c=questionId;
                translatedQuestion.Secondary_Language__c=selectedValue;               
                translatedQuestion.Is_Translated__c=true;
              //  translatedQuestion.MaxScore__c=qestionTransReq.MaxScore__c;
                translatedQuestion.AnswerType__c=qestionTransReq.AnswerType__c; 
                translatedQuestion.IsRequired__c=qestionTransReq.IsRequired__c;
                translatedQuestion.Parent_Survey_Question__c = qestionTransReq.SurveyQuestion__c;
                insert translatedQuestion;
                
                for(ansWrapperCls listoftranslatedanswers : listansWrapperCls ){
                      SPE_SurveyAnswer__c Translateans= new SPE_SurveyAnswer__c();
                       Translateans.Choices__c= listoftranslatedanswers.SecondaryChoices;
                       Translateans.Secondary_Language__c=selectedValue;
                       Translateans.SurveyQuestion__c=translatedQuestion.id;
                       Translateans.PrimarySurvey_Answer__c = listoftranslatedanswers.primaryAnswerId;
                       Translateans.Score__c = listoftranslatedanswers.AnswerValue;
                       translatedAnswers.add(Translateans);
                }
              
               insert translatedAnswers; 
            //PageReference pgref = new PageReference('/' + translatedQuestion.id);
            PageReference pgref = new PageReference('/' + questionId);
                pgref.setRedirect(true);
                return pgref;
            }
        
        }
    
    public pageReference Cancel()
    {
     PageReference pgref = new PageReference('/' + questionId);
        pgref.setRedirect(true);
        return pgref;
    }
    
    public class ansWrapperCls 
        {            
             public String AnswerChoices{get;set;}
             public String SecondaryChoices{get;set;}
             public Decimal AnswerValue{get;set;}
             public String SecondaryLanguage{get;set;}
             public id primaryAnswerId{get;set;}
             public id answerID{get;set;}
        }
     
}