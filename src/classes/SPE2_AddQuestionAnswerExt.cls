public class SPE2_AddQuestionAnswerExt 
{
    public SPE_SurveyQuestion__c speSurvey {get;set;}
    public List <SPE_SurveyAnswer__c> speAnswers {get;set;}
    public List <SPE_SurveyAnswer__c> deletespeAnswers {get;set;}
    public List<SPE_SurveyAnswer__c> toBeInsertedSpeSurvey {get;set;}
    public boolean isDuplicate=false;
    Public list<SPE_SurveyAnswer__c> toBeDeletedsurveyAns = New list<SPE_SurveyAnswer__c>();
    SPE_SurveyQuestion__c speSurveyTemp = new SPE_SurveyQuestion__c();
    List<SPE_SurveyAnswer__c> speAnswersTemp = new List <SPE_SurveyAnswer__c>();
    private List <SPE_SurveyQuestion__c> altrLangQue = new list <SPE_SurveyQuestion__c>();
    private List <SPE_SurveyQuestion__c> altrLangQueCloned = new list <SPE_SurveyQuestion__c>();
    private List <SPE_SurveyAnswer__c > altrLangAnsCloned = new list <SPE_SurveyAnswer__c >();
    public boolean hasRecord{get;set;}
    public boolean cloneAltrLang{get;set;}
    public boolean isAlterLangExist{get;set;}
    private Map<String,List<SPE_SurveyAnswer__c >> queAnsMap;
    public boolean answerTypeHide{get;set;}
      
    public SPE2_AddQuestionAnswerExt(ApexPages.Standardcontroller st) 
    {   
         answerTypeHide = true;
      if (st.getId() == null)
        {
           speSurvey = new SPE_SurveyQuestion__c();
           
           speSurvey.AnswerType__c = SPE_Constants.SURVEY_ANSWERTYPE;

           speAnswers = new List < SPE_SurveyAnswer__c > ();
           
           cloneAltrLang=false; 
          
        }
        else 
        {
            queAnsMap =new Map<String,List<SPE_SurveyAnswer__c >>();
            cloneAltrLang=false; 
            isAlterLangExist=false;           
            speSurvey = [SELECT Name,QuestionAbbreviation__c,Is_Translated__c,Secondary_Language__c,PIData__c , AnswerType__c,QuestionLabel__c, PIDefinition__c,SurveyQuestion__c, IsRequired__c, BUScope__c, Business__c,
                                CategoryScope__c, GeoScope__c, Question_Bank__c, PIType__c, OperationalType__c   
                         FROM SPE_SurveyQuestion__c 
                         WHERE Id =: st.getId()];
             
            speAnswers = [SELECT Id, Name, Score__c, SurveyQuestion__c, Choices__c, PrimarySurvey_Answer__r.Choices__c
                          FROM SPE_SurveyAnswer__c 
                          WHERE SurveyQuestion__c = : st.getId()];
                                     
            altrLangQue = [select Id,QuestionLabel__c,Name,Secondary_Language__c,SurveyQuestion__c,AnswerType__c,IsRequired__c,Parent_Survey_Question__c,Is_Translated__c, (select Id , Name,OrderNumber__c,Choices__c,Secondary_Language__c,Score__c, PrimarySurvey_Answer__c from SPE_SurveyAnswers__r) from SPE_SurveyQuestion__c  where Question_Bank__c= : st.getId()]; 
            
            //Code added for adding the custom clone feature   
            if(altrLangQue.size() > 0 && Apexpages.currentPage().getParameters().get('isClone') == 'false' )
             {
                 hasRecord = True;                            
             }
          
            if(Apexpages.currentPage().getParameters().get('isClone') == 'true'){
                speSurveyTemp = speSurvey.clone(false, true, false, false);
                speAnswersTemp = speAnswers.deepclone();
                speSurvey = new SPE_SurveyQuestion__c();
                speAnswers = new List < SPE_SurveyAnswer__c > ();
                speSurvey = speSurveyTemp;
                speSurvey.PIData__c = null;
                speAnswers = speAnswersTemp;               
                
                answerTypeHide = false;
                if(altrLangQue.size() > 0 )
                {
                    isAlterLangExist = true;                                     
                }              
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
        }
    }
    
    public void deleteAllAnswer()
    {
        for(integer i=0;i<speAnswers.size();i++)
        {
            if(speAnswers[i].Id != null)
            {
                toBeDeletedsurveyAns.add(speAnswers[i]);                
            }
        }
        system.debug('s**********************************************' + toBeDeletedsurveyAns.size());
        speAnswers.clear();
    }
    private list<SPE_SurveyAnswer__c>  altrAnsList;
    private list<SPE_SurveyQuestion__c > queList;
    public Pagereference save() 
    {
       altrAnsList = new List<SPE_SurveyAnswer__c>();
       queList = new list<SPE_SurveyQuestion__c>();
        if (speAnswers.isEmpty() && speSurvey.AnswerType__c == 'Picklist') 
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add the  answers');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
       Try{ 
              if(Apexpages.currentPage().getParameters().get('isClone') == 'true')
              {                                
                 cloneQuestionAnswer();
              }
               else{
                 
                   altrLangQueCloned=altrLangQue.deepclone();
                   upsert speSurvey;                   
                   System.debug('$$$$$$$$$$$$$$$$$$$$$$$ after upate----speSurvey.id'+speSurvey);
                   System.debug('$$$$$$$$$$$$$$$$$$$$$$$ after upate----isDuplicate'+isDuplicate);
                   List<SPE_SurveyAnswer__c> toBeInsertedSpeSurvey = assignSPEAnswers(speSurvey);
                   if(isDuplicate)
                   {
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Duplicate answer not allowed');
                        ApexPages.addMessage(myMsg);
                        return null;
                   }
                   upsert  toBeInsertedSpeSurvey;
                   List<SPE_SurveyAnswer__c> altrAnse = new List<SPE_SurveyAnswer__c> ();
                   
                   for (SPE_SurveyQuestion__c  q : altrLangQue)
                    {
                        q.QuestionLabel__c = speSurvey.QuestionLabel__c ;
                        q.Parent_Survey_Question__c =speSurvey.SurveyQuestion__c;
                        q.IsRequired__c =speSurvey.IsRequired__c ;
                        q.AnswerType__c =speSurvey.AnswerType__c;                    
                    }
                   
                    upsert altrLangQue;  
                    Integer i = 0;
                    for (SPE_SurveyQuestion__c  q : altrLangQue)
                    {
                        List<SPE_SurveyAnswer__c> anseCloned = q.SPE_SurveyAnswers__r;

                        Integer j = 0;
                        for (SPE_SurveyAnswer__c a : anseCloned )
                        {                            
                          // a.SurveyQuestion__c = altrLangQueCloned[i].Id;
                          // a.PrimarySurvey_Answer__c = toBeInsertedSpeSurvey[j].Id; //q.SPE_SurveyAnswers__r[j].Id; 
                             a.Score__c =toBeInsertedSpeSurvey[j].Score__c ;                                                        
                             System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$ before upate----anseCloned '+a);                          
                           j++;
                        }
                        upsert anseCloned ; 
                        i ++;                        
                        System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$ after upate----anseCloned '+anseCloned );  
                    }                   
                 } 
              
               
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
                
                
                system.debug('toBeInsertedSpeSurvey----Created' + toBeInsertedSpeSurvey);
                Pagereference pr = new Pagereference('/' + speSurvey.Id);
                return pr;
        }
       catch(Exception ex){
        ApexPages.addMessages(ex);
         
      }
       return null;
    }
    
    Public void cloneQuestionAnswer(){
		insert speSurvey;
        system.debug('speSurvey----Created' + speSurvey);
                
        List<SPE_SurveyAnswer__c> toBeInsertedSpeSurvey = assignSPEAnswers(speSurvey);
        if(isDuplicate)
        {
         //Database.rollback(sp);
         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Duplicate answer not allowed');
         ApexPages.addMessage(myMsg);
        }
        insert toBeInsertedSpeSurvey;
        
        // clone Alternate Question and Answers                
        if(cloneAltrLang)
        {                    
        	system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$----cloneAltrLang');
            altrLangQueCloned=altrLangQue.deepclone();                    
            List<SPE_SurveyAnswer__c> anseCloned = new List<SPE_SurveyAnswer__c> ();
                 
            for (SPE_SurveyQuestion__c  q : altrLangQueCloned)
            {
            	q.Question_Bank__c = speSurvey.Id;
                q.QuestionLabel__c = speSurvey.QuestionLabel__c ;
                q.Parent_Survey_Question__c =speSurvey.SurveyQuestion__c;
                q.IsRequired__c =speSurvey.IsRequired__c ;
                q.AnswerType__c =speSurvey.AnswerType__c;
                    
            }
            insert altrLangQueCloned;
            system.debug('altrLangQueCloned---'+altrLangQueCloned);
            system.debug('altrLangQue ---'+altrLangQue );
                    
             Integer i=0;
             for (SPE_SurveyQuestion__c  q : altrLangQue )
             {
                system.debug('!!!!!!!!!!q--!!!!!'+q);                       
             	List<SPE_SurveyAnswer__c> anseCloned1 = q.SPE_SurveyAnswers__r.deepclone();
                System.debug('anseCloned1 '+anseCloned1 );
                Integer j = 0;
                for (SPE_SurveyAnswer__c a : anseCloned1 )
                {
                	a.SurveyQuestion__c = altrLangQueCloned[i].Id;
                    system.debug('altrLangQueCloned[i]--'+altrLangQueCloned[i]);
                    a.PrimarySurvey_Answer__c = toBeInsertedSpeSurvey[j].Id; 
                    a.Score__c =toBeInsertedSpeSurvey[j].Score__c ;
                    system.debug('!!!!!!!!!!a--!!!!!'+a);
                    j++;
                    System.debug('j is--'+j);
                }
                insert anseCloned1; 
                system.debug('cloned ans---'+anseCloned1);
                i ++;  
                system.debug('i is--'+i);
            }                   
       }
    }
    public Pagereference cancelQuestion()
    {
      //  Schema.DescribeSObjectResult r = SPE_SurveyQuestion__c.sObjectType.getDescribe();
      //  String keyPrefix = r.getKeyPrefix();
        Id recId=ApexPages.CurrentPage().getParameters().get('id');
        Pagereference pr = new Pagereference('/'+recId);
        pr.setRedirect(true);
        
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
            if(!speSurey.Is_Translated__c)
            ans.Secondary_Language__c = 'English';
            toBeInsertedSurveyAns.add(ans);
        }
        return toBeInsertedSurveyAns;
    }  
}