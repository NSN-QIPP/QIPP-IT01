@isTest(SeeAllData = true) 
private class SPE2_AddQuestionAnswerExtTest {
    boolean cloneAltrLang{get;set;}
    static testMethod void positiveMethod()
    {       
        SPE_SurveyQuestion__c surQues=SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surQues;
        SPE_SurveyAnswer__c surAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns1.SurveyQuestion__c=surQues.Id;
        insert surAns1;
        SPE_SurveyAnswer__c surAns2=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns2.SurveyQuestion__c=surQues.Id;
        insert surAns2;
              
        SPE_SurveyQuestion__c altrSurveyQues1=SPE_TestObjectCreator.CreateSurveyQuestion(); 
        altrSurveyQues1.Parent_Survey_Question__c = surQues.SurveyQuestion__c;
        altrSurveyQues1.Question_Bank__c=surQues.Id;
        altrSurveyQues1.Secondary_Language__c='Albanian';
        insert altrSurveyQues1;
        
        SPE_SurveyAnswer__c altrSurAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        altrSurAns1.SurveyQuestion__c=altrSurveyQues1.Id;
        altrSurAns1.PrimarySurvey_Answer__c=surAns1.Id;
        insert altrSurAns1; 
        SPE_SurveyAnswer__c altrSurAns2=SPE_TestObjectCreator.CreateSurveyAnswer();
        altrSurAns2.SurveyQuestion__c=surQues.Id;
        insert altrSurAns2;
        
        altrSurAns1.Choices__c='white';
        update altrSurAns1;
       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQues);
        SPE2_AddQuestionAnswerExt addQueAns = new SPE2_AddQuestionAnswerExt(stCon);
        Apexpages.currentPage().getParameters().put('isClone', 'true'); 
            
        addQueAns.speSurvey = SPE_TestObjectCreator.CreateSurveyQuestion();
        addQueAns.addAnswers();      
        addQueAns.speAnswers[0] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        addQueAns.speAnswers[1] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        
        addQueAns.deleteQuestionAnswer();
        
        addQueAns.addAnswers();      
        addQueAns.speAnswers[0] = SPE_TestObjectCreator.CreateSurveyAnswer();
     
        addQueAns.speAnswers[1] = SPE_TestObjectCreator.CreateSurveyAnswer();
  
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        addQueAns.cloneAltrLang=true;
        addQueAns.addAnswers();
        addQueAns.addAnswers();
        
        addQueAns.save();
        addQueAns.cancelQuestion();
        List<SPE_SurveyAnswer__c> ansList=new List<SPE_SurveyAnswer__c>();
        ansList.add(surAns1);
        ansList.add(surAns2);
        
        
        
        addQueAns.deleteAllAnswer();   
        
    }
    static testMethod void NegativeMethod()
    {
         Apexpages.currentPage().getParameters().put('isClone', 'false');
        SPE_SurveyQuestion__c surQue=SPE_TestObjectCreator.CreateSurveyQuestion();
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue);
        SPE2_AddQuestionAnswerExt addQuesAns = new SPE2_AddQuestionAnswerExt(stCon);
   
        addQuesAns.isDuplicate = true;
                     
        SPE_SurveyQuestion__c surQues=SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surQues;
        SPE_SurveyAnswer__c surAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns1.SurveyQuestion__c=surQues.Id;
        insert surAns1;
        SPE_SurveyAnswer__c surAns2=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns2.SurveyQuestion__c=surQues.Id;
        insert surAns2;
        surAns2.Choices__c='White';
        update surAns2;
        
        SPE_SurveyQuestion__c altrSurveyQues1=SPE_TestObjectCreator.CreateSurveyQuestion(); 
        altrSurveyQues1.Parent_Survey_Question__c = surQues.SurveyQuestion__c;
        altrSurveyQues1.Question_Bank__c=surQues.Id;
        altrSurveyQues1.Secondary_Language__c='Albanian';
        insert altrSurveyQues1;
        
        SPE_SurveyAnswer__c altrSurAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        altrSurAns1.SurveyQuestion__c=altrSurveyQues1.Id;
        altrSurAns1.PrimarySurvey_Answer__c=surAns1.Id;
        insert altrSurAns1;
        
        list<SPE_SurveyQuestion__c> QuestList=[select Id,Question_Bank__c from SPE_SurveyQuestion__c where Question_Bank__c= :surQues.Id];
        list<SPE_SurveyQuestion__c> QuestListClone= QuestList.deepClone();
       
                    
        Apexpages.Standardcontroller stCon1 =  new Apexpages.Standardcontroller(surQues);
        Apexpages.currentPage().getParameters().put('isClone', 'false');
        
        SPE2_AddQuestionAnswerExt addQueAns = new SPE2_AddQuestionAnswerExt(stCon1);
         
        addQueAns.isDuplicate = true;
        addQueAns.save();

    }
     static testMethod void cloneQuestionAns()
    {
       
        SPE_SurveyQuestion__c surQues=SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surQues;
        SPE_SurveyAnswer__c surAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns1.SurveyQuestion__c=surQues.Id;
        surAns1.Choices__c = 'White';
        insert surAns1;
        SPE_SurveyAnswer__c surAns2=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns2.SurveyQuestion__c=surQues.Id;
        surAns2.Choices__c = 'Black';
        insert surAns2;
              
        SPE_SurveyQuestion__c altrSurveyQues1=SPE_TestObjectCreator.CreateSurveyQuestion(); 
        altrSurveyQues1.Parent_Survey_Question__c = surQues.SurveyQuestion__c;
        altrSurveyQues1.Question_Bank__c=surQues.Id;
        altrSurveyQues1.Secondary_Language__c='Albanian';
        insert altrSurveyQues1;
        
        SPE_SurveyAnswer__c altrSurAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        altrSurAns1.SurveyQuestion__c=altrSurveyQues1.Id;
        altrSurAns1.PrimarySurvey_Answer__c=surAns1.Id;
        insert altrSurAns1; 
        SPE_SurveyAnswer__c altrSurAns2=SPE_TestObjectCreator.CreateSurveyAnswer();
        altrSurAns2.SurveyQuestion__c=altrSurveyQues1.Id;
        altrSurAns2.PrimarySurvey_Answer__c=surAns2.Id;
        insert altrSurAns2;
        
        Apexpages.currentPage().getParameters().put('isClone', 'true'); 
       
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQues);
        SPE2_AddQuestionAnswerExt addQueAns = new SPE2_AddQuestionAnswerExt(stCon);
        addQueAns.cloneAltrLang=true;
        
        addQueAns.save();
        addQueAns.addAnswers();
        addQueAns.cancelQuestion();
      
    }
     static testMethod void NegativeClone()
    {
        SPE_SurveyQuestion__c surQ = SPE_TestObjectCreator.CreateSurveyQuestion();
        insert surQ;
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQ);               
        SPE2_AddQuestionAnswerExt addQueAns = new SPE2_AddQuestionAnswerExt(stCon);
        
        addQueAns.save();
        addQueAns.addAnswers();
        addQueAns.cancelQuestion();              
    }
}