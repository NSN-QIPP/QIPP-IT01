@isTest(seeAllData=False)

public class SPE2deleteChildQuestionsTest{

 static testMethod void TestSPE2deleteChildQuestions(){
        
        SPE_SurveyQuestion__c surQue1 = new SPE_SurveyQuestion__c();
        surQue1.Name = 'SPE_Test Question';
        surQue1.SurveyQuestion__c = 'What color is your hair?';
        surQue1.AnswerType__c = 'Picklist';
        surQue1.IsActive__c = true;
        surQue1.QuestionAbbreviation__c = 'SPE_Que';
        insert surQue1;
        
        SPE_SurveyQuestion__c surQue2 = new SPE_SurveyQuestion__c();
        surQue2.Name = 'SPE_Test Question';
        surQue2.SurveyQuestion__c = 'What color is your hair?';
        surQue2.AnswerType__c = 'Picklist';
        surQue2.IsActive__c = true;
        surQue2.QuestionAbbreviation__c = 'SPE_Que';
        surQue2.Question_Bank__c  = surQue1 .id;
        insert surQue2;
        
        delete surQue1;
       
         
        
 
 }
    static testMethod void TestSPE2deleteChildQuestions1(){
        try{
        SPE_SurveyQuestion__c surQue3 = new SPE_SurveyQuestion__c();
        surQue3.Name = 'SPE_Test Question';
        surQue3.SurveyQuestion__c = 'What color is your hair?';
        surQue3.AnswerType__c = 'Picklist';
        surQue3.IsActive__c = true;
        surQue3.QuestionAbbreviation__c = 'SPE_Que';
        //surQue3.Question_Bank__c  = surQue1.id;
        
        delete surQue3;
        }catch(Exception e){
         // SPE2ErrorLogCapture.errorLogCapture(e);
          }
    }
}