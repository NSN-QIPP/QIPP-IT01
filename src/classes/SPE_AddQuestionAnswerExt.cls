public class SPE_AddQuestionAnswerExt 
{
    public SPE_SurveyQuestion__c speSurvey {get;set;}
    public List <SPE_SurveyAnswer__c> speAnswers {get;set;}
    public List <SPE_SurveyAnswer__c> deletespeAnswers {get;set;}
    public List<SPE_SurveyAnswer__c> toBeInsertedSpeSurvey {get;set;}
    public boolean isDuplicate=false;
    Public list<SPE_SurveyAnswer__c> toBeDeletedsurveyAns = New list<SPE_SurveyAnswer__c>();
    SPE_SurveyQuestion__c speSurveyTemp = new SPE_SurveyQuestion__c();
    List <SPE_SurveyAnswer__c> speAnswersTemp = new List <SPE_SurveyAnswer__c>();
   
    public SPE_AddQuestionAnswerExt(ApexPages.Standardcontroller st) 
    {   
        
      if (st.getId() == null)
        {
           speSurvey = new SPE_SurveyQuestion__c();
           
           speSurvey.AnswerType__c = SPE_Constants.SURVEY_ANSWERTYPE;

           speAnswers = new List < SPE_SurveyAnswer__c > ();
        }
        else 
        {
            speSurvey = [SELECT Name,QuestionAbbreviation__c,PIData__c , AnswerType__c,QuestionLabel__c, PIDefinition__c,SurveyQuestion__c, IsRequired__c, BUScope__c, Business__c,
                                CategoryScope__c, GeoScope__c, PIType__c, OperationalType__c   
                         FROM SPE_SurveyQuestion__c 
                         WHERE Id =: st.getId()];
            
            speAnswers = [SELECT Id, Name, Score__c, SurveyQuestion__c, Choices__c 
                          FROM SPE_SurveyAnswer__c 
                          WHERE SurveyQuestion__c = : st.getId()];
            
            //Code added for adding the custom clone feature
            if(Apexpages.currentPage().getParameters().get('isClone') == 'true'){
                speSurveyTemp = speSurvey.clone(false, true, false, false);
                speAnswersTemp = speAnswers.deepclone();
                speSurvey = new SPE_SurveyQuestion__c();
                speAnswers = new List < SPE_SurveyAnswer__c > ();
                speSurvey = speSurveyTemp;
                speSurvey.PIData__c = null;
                speAnswers = speAnswersTemp;
            }
            // End of Code added for adding the custom clone feature
        } 
        
    }
    
    
    public void addAnswers() 
    {
        SPE_SurveyAnswer__c answers = new SPE_SurveyAnswer__c();
        speAnswers.add(answers);
    }
    
    public void deleteQuestionAnswer()
    {
    
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('rowIndex'));
        list<SPE_SurveyAnswer__c> newSurveyAns = new list<SPE_SurveyAnswer__c>();
       
        //integer remve = -1;
        
        for(integer i=0;i<speAnswers.size();i++)
        {
            if(i == rowIndex)
            {
                toBeDeletedsurveyAns.add(speAnswers.remove(i) ); 
            }
            /*else
            {
                remve = i;
            }*/
        }
        /*
        system.debug(+'=====>rowIndex '+rowIndex );
        system.debug(+'=====>remve '+remve );
        system.debug(newSurveyAns+'=====>');
        
        speAnswers.clear();
        speAnswers.addAll(newSurveyAns);
        
        if(remve >= 0)
        {
                toBeDeletedsurveyAns.add(speAnswers.remove(remve) ); 
        }*/
    }
    
    public void deleteAllAnswer()
    {
        //toBeDeletedsurveyAns = new List<SPE_SurveyAnswer__c>(); 
        for(integer i=0;i<speAnswers.size();i++)
        {
            if(speAnswers[i].Id != null)
            {
                toBeDeletedsurveyAns.add(speAnswers[i]);
                
            }
        }
        system.debug('s**********************************************' + toBeDeletedsurveyAns.size());
        speAnswers.clear();
       // delete toBeDeletedsurveyAns;
    }
    
    public Pagereference save() 
    {
       
        if (speAnswers.isEmpty() && speSurvey.AnswerType__c == 'Picklist') 
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add the  answers');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        Try{
                upsert speSurvey;
                system.debug('speSurvey----Created' + speSurvey);
                
                if(toBeDeletedsurveyAns.size()>0 )
                {
                    
                    system.debug('in tobe Deleted===>');
                    list<SPE_SurveyAnswer__c> toBeDeletedsurveyAns1= new list<SPE_SurveyAnswer__c>();
                    
                    for (SPE_SurveyAnswer__c surveyAns: toBeDeletedsurveyAns)
                    {
                        if (surveyAns.Id != null )
                        {
                            toBeDeletedsurveyAns1.add(surveyAns);
                        }
                    }
                    
                    system.debug('toBeDeletedsurveyAns1==>'+toBeDeletedsurveyAns1.size());
                    system.debug('toBeDeletedsurveyAns==>'+toBeDeletedsurveyAns.size());
                    
                    delete toBeDeletedsurveyAns1;
                   
                }
                
                List<SPE_SurveyAnswer__c> toBeInsertedSpeSurvey = assignSPEAnswers(speSurvey);
                if(isDuplicate)
                {
                    //Database.rollback(sp);
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Duplicate answer not allowed');
                    ApexPages.addMessage(myMsg);
                    return null;
                }
                upsert toBeInsertedSpeSurvey;
                system.debug('toBeInsertedSpeSurvey----Created' + toBeInsertedSpeSurvey);
                Pagereference pr = new Pagereference('/' + speSurvey.Id);
                return pr;
        }
        catch(Exception ex){
         ApexPages.addMessages(ex);
         
      }
       return null;
    }
    public Pagereference cancelQuestion()
    {
        Schema.DescribeSObjectResult r = SPE_SurveyQuestion__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr = new Pagereference('/');
       if(speSurvey.Id!=null){
          pr =new Pagereference('/'+speSurvey.Id);
       } else{
             pr =new Pagereference('/'+keyPrefix);
            }    
        return pr;
    }
    private List<SPE_SurveyAnswer__c> assignSPEAnswers (SPE_SurveyQuestion__c speSurey)
    {
        List<SPE_SurveyAnswer__c> toBeInsertedSurveyAns = new List<SPE_SurveyAnswer__c>();
        Set<String> SetChoice=new set<String>();
        isDuplicate=false;
        system.debug('====speAnswers====>' + speAnswers.size());
        for (SPE_SurveyAnswer__c ans : speAnswers) 
        {
           if (SetChoice.contains(ans.Choices__c.toLowerCase()))
            {
                isDuplicate=true;
                }
            SetChoice.add(ans.Choices__c.toLowerCase());
            if (ans.Id == null)
            {
                ans.SurveyQuestion__c = speSurey.Id;
            }
            
            toBeInsertedSurveyAns.add(ans);
        }
        return toBeInsertedSurveyAns;
    }
    
}