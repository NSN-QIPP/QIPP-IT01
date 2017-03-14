@isTest(SeeAllData = False)
private class SPE_AddQuestionAnswerExtTest 
{
    
    static testMethod void createQuestionAnsPositive() 
    {
        Test.startTest();
        
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
        
        SPE_SurveyQuestion__c surQue = new SPE_SurveyQuestion__c();
                
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue);
        
        SPE_AddQuestionAnswerExt addQueAns = new SPE_AddQuestionAnswerExt(stCon);
        
        addQueAns.speSurvey = SPE_TestObjectCreator.CreateSurveyQuestion();
        
        addQueAns.addAnswers();
        addQueAns.addAnswers();
                
        addQueAns.speAnswers[0] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        addQueAns.speAnswers[1] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        Apexpages.currentPage().getParameters().put('rowIndex', '1');
        
        addQueAns.deleteQuestionAnswer();
        
        addQueAns.save();
        
        Test.stopTest();
        
        System.assert(addQueAns.speSurvey.Id != null);
        
        List<SPE_SurveyAnswer__c> insertedSurveyAns = [SELECT Id, Choices__c 
                                                       FROM SPE_SurveyAnswer__c
                                                       WHERE SurveyQuestion__c =: addQueAns.speSurvey.Id];
        
        System.assertEquals(insertedSurveyAns.size(), 1);
    }
    
    
    static testMethod void createQuestionAnsNegative()
    {
       
         Test.startTest();
         
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
        
        SPE_SurveyQuestion__c surQue = new SPE_SurveyQuestion__c();
        
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue);
        
        SPE_AddQuestionAnswerExt addQueAns = new SPE_AddQuestionAnswerExt(stCon);
        
        addQueAns.speSurvey = SPE_TestObjectCreator.CreateSurveyQuestion();
        
        addQueAns.save();
       
        System.assertEquals(addQueAns.speSurvey.Id, null); 
        
        Test.stopTest();
        
    }

        
    
    static testMethod void editQuestionAnsDuplicate()
    {
        SPE_SurveyQuestion__c surQue1 = new SPE_SurveyQuestion__c();
        surQue1 = SPE_TestObjectCreator.CreateSurveyQuestion();
        surQue1.AnswerType__c = 'Freetext';
        insert surQue1;
        
        Test.startTest();
        
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
              
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue1);
        
        SPE_AddQuestionAnswerExt addQueAns = new SPE_AddQuestionAnswerExt(stCon);
        
        addQueAns.speSurvey = SPE_TestObjectCreator.CreateSurveyQuestion();
        
        addQueAns.addAnswers();
        addQueAns.addAnswers();
                
        addQueAns.speAnswers[0] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        addQueAns.speAnswers[1] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        addQueAns.save();
        
        Test.stopTest();
        
        System.assert(addQueAns.speSurvey.Id != null);
        
    }
    
    static testMethod void deleteQuestionAnsPostive()
    {
        
        
       Test.startTest();
       
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
      
        SPE_SurveyQuestion__c surQue = new SPE_SurveyQuestion__c();
        surQue.AnswerType__c = 'Picklist';
                
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue);
        
        SPE_AddQuestionAnswerExt addQueAns = new SPE_AddQuestionAnswerExt(stCon);
        
        addQueAns.speSurvey = SPE_TestObjectCreator.CreateSurveyQuestion();
        
        addQueAns.addAnswers();
                
        addQueAns.speAnswers[0] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        surQue.AnswerType__c = 'Freetext';
        
        addQueAns.deleteAllAnswer();
        
        addQueAns.speSurvey.AnswerType__c = 'Freetext';
        
        addQueAns.save(); 
        
        Test.stopTest();
    }
    
    static testMethod void canceQuestionAns()
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
        
        SPE_SurveyQuestion__c surQue1 = new SPE_SurveyQuestion__c();
        surQue1 = SPE_TestObjectCreator.CreateSurveyQuestion();
        surQue1.AnswerType__c = 'Freetext';
        insert surQue1;
        
        Test.startTest();
              
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue1);
        
        SPE_AddQuestionAnswerExt addQueAns = new SPE_AddQuestionAnswerExt(stCon);
        
        addQueAns.speSurvey = SPE_TestObjectCreator.CreateSurveyQuestion();
        
        addQueAns.addAnswers();
        addQueAns.addAnswers();
                
        addQueAns.speAnswers[0] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        addQueAns.speAnswers[1] = SPE_TestObjectCreator.CreateSurveyAnswer();
        
        addQueAns.cancelQuestion();
        
        Test.stopTest();
    }
    
    static testMethod void cloneQuestionAns()
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
        
        SPE_SurveyQuestion__c surQue1 = new SPE_SurveyQuestion__c();
        surQue1 = SPE_TestObjectCreator.CreateSurveyQuestion();
        surQue1.AnswerType__c = 'Freetext';
        insert surQue1;
        
        Test.startTest(); 
        
        Apexpages.currentPage().getParameters().put('isClone', 'true');     
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(surQue1);
        
       
        SPE_AddQuestionAnswerExt addQueAns = new SPE_AddQuestionAnswerExt(stCon);
        
        Test.stopTest();
    }
  
}