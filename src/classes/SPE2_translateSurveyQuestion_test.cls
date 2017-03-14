@isTest(SeeAllData=false)

public class SPE2_translateSurveyQuestion_test{
     
 Public Static TestMethod Void  SPE2_translateSurveyQuestionTest1(){
         SPE_SurveyQuestion__c TestSPESurveyQuestion =new SPE_SurveyQuestion__c();
         TestSPESurveyQuestion.Name ='Atos123';
         TestSPESurveyQuestion.QuestionLabel__c = 'AtosTestScore3';
         TestSPESurveyQuestion.SurveyQuestion__c ='Atos_TestScore3';
         TestSPESurveyQuestion.AnswerType__c ='Picklist';        
         Insert TestSPESurveyQuestion;
         
         SPE_SurveyAnswer__c TestAnswer = new SPE_SurveyAnswer__c();
         TestAnswer.Choices__c='Good';
         TestAnswer.Score__c=90;
         TestAnswer.SurveyQuestion__c=TestSPESurveyQuestion.id;
         insert TestAnswer;

        ApexPages.StandardController sc = new ApexPages.StandardController(TestSPESurveyQuestion);
        SPE2_translateSurveyQuestionController controller = new SPE2_translateSurveyQuestionController(sc);
        controller.selectedValue='German';
        controller.Next();
        controller.cancel();
        controller.save();
 }
 Public Static TestMethod Void  SPE2_translateSurveyQuestionTest2(){
         SPE_SurveyQuestion__c TestSPESurveyQuestion =new SPE_SurveyQuestion__c();
         TestSPESurveyQuestion.Name ='Atos1234';
         TestSPESurveyQuestion.QuestionLabel__c = 'AtosTestScore3';
         TestSPESurveyQuestion.SurveyQuestion__c ='Atos_TestScore3';
         TestSPESurveyQuestion.AnswerType__c ='Picklist';
         Insert TestSPESurveyQuestion;
         
         SPE_SurveyQuestion__c TestSPESurveyQuestion1 =new SPE_SurveyQuestion__c();
         TestSPESurveyQuestion1.Name ='Atos12345';
         TestSPESurveyQuestion1.QuestionLabel__c = 'AtosTestScore3';
         TestSPESurveyQuestion1.SurveyQuestion__c ='Atos_TestScore3';
         TestSPESurveyQuestion1.AnswerType__c ='Picklist';
         TestSPESurveyQuestion1.Question_Bank__c=TestSPESurveyQuestion.id;
         TestSPESurveyQuestion1.Secondary_Language__c='German';
         Insert TestSPESurveyQuestion1;
         
         SPE_SurveyAnswer__c TestAnswer = new SPE_SurveyAnswer__c();
         TestAnswer.Choices__c='Good';
         TestAnswer.Score__c=90;
         TestAnswer.SurveyQuestion__c=TestSPESurveyQuestion.id;
         insert TestAnswer;
         
         SPE_SurveyAnswer__c TestAnswer1 = new SPE_SurveyAnswer__c();
         TestAnswer1.Choices__c='Good';
         TestAnswer1.Score__c=90;
         TestAnswer1.SurveyQuestion__c=TestSPESurveyQuestion1.id;
         TestAnswer1.PrimarySurvey_Answer__c=TestAnswer.id;
         insert TestAnswer1;
      
        ApexPages.StandardController sc = new ApexPages.StandardController(TestSPESurveyQuestion);
        SPE2_translateSurveyQuestionController controller = new SPE2_translateSurveyQuestionController(sc);
        controller.selectedValue='German';
        controller.Next();
        controller.cancel();
        controller.save();
 }
    
}