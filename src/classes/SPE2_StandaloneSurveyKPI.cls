public class  SPE2_StandaloneSurveyKPI{

    public SPE2Survey__c spePlan {get;set;}
    public Contact contact {get;set;}
    public SPE2_SurveyTracker__c tracker {get;set;}   
    public String PageName; 
    public String fromDate{get;set;}
    public String toDate{get;set;}  
    public List<surveySupplierWrapper> surveySuppList{get;set;}
    public List<surveyQuestionWrapper> sqWrpperList{get;set;}
    public String surveyId{get;set;}
    public boolean isSubmitted{get;set;}
    public String reqError {get;set;}
    public SPE2_SurveyTrackerRespondent__c sRepondent{get;set;}
    public Date currentDate{get;set;}
    public String surveySeqId{get;set;}
    public boolean isReturnFalse;
    public SPE2_StandaloneSurveyKPI(){          
        initialize();
    }
    @Testvisible
    private void initialize(){  
        isSubmitted = false;
        sqWrpperList = new List<surveyQuestionWrapper>();
        surveySuppList = new List<surveySupplierWrapper>();
        PageName=ApexPages.currentPage().getUrl();
        PageName=PageName.substringAfterLast('/');
        PageName=PageName.substringBefore('?');
        surveyId = ApexPages.currentPage().getParameters().get('id');                                    
        spePlan = [SELECT Id, Name,StartDate__c ,Survey_Title__c,Country__c, Project__c, CategoryArea__c, CategoryGroup__c, Category__c, Market__c,
                   MarketUnit__c, BusinessUnit__c, BusinessLine__c, Product__c, FrequencyInMonths__c,Survey_Sequential_Id__c,
                   OwnerId,SurveyExecutionBeforeIndays__c
                   FROM SPE2Survey__c 
                   WHERE Id = :surveyId];
        
        currentDate =  system.today();
        String s1 = spePlan.Survey_Sequential_Id__c+'';
        surveySeqId =  s1.substringBetween('>','</a>');
                                                                       
        if(ApexPages.currentPage().getParameters().get('trackerId') != null){
            tracker = [SELECT Id, Name, Survey__c,DateOfExecution__c,Survey__r.FrequencyInMonths__c, NewExecution__c, Survey__r.Stage__c,
                        CategoryArea__c, CategoryGroup__c, Category__c, Survey_Execution_Date__c,Market__c, MarketUnit__c, Country__c, Project__c, BusinessUnit__c, BusinessLine__c, Product__c
                       FROM SPE2_SurveyTracker__c 
                       WHERE Id =: ApexPages.currentPage().getParameters().get('trackerId')];
        }
        else{
            tracker = new SPE2_SurveyTracker__c();
        }
        if(ApexPages.currentPage().getParameters().get('conId') != null){
            contact = [SELECT Id, Name 
                       FROM Contact 
                       WHERE Id =: ApexPages.currentPage().getParameters().get('conId')];
        }
        else{
            contact = new Contact();
        }
        Integer toBeaddedMonths = tracker.Survey__r.FrequencyInMonths__c == null ? 1 :  Integer.valueOf(tracker.Survey__r.FrequencyInMonths__c);
       
        Date fromDateTemp = tracker.DateOfExecution__c.addMonths(-(toBeaddedMonths));
        Date toDateTemp = tracker.DateOfExecution__c.addMonths(-1);
        
        fromDate = SPE_Utility.monthsMap.get(fromDateTemp.month()) + ' - '+ String.valueOf(fromDateTemp.year());
        toDate = SPE_Utility.monthsMap.get(toDateTemp.month()) + ' - '+ String.valueOf(toDateTemp.year());
        sRepondent = new SPE2_SurveyTrackerRespondent__c();
        sRepondent = [Select Id,Contact__c,Survey__c,IsResponseReceived__c From SPE2_SurveyTrackerRespondent__c 
                     Where Contact__c =:ApexPages.currentPage().getParameters().get('conId')
                     And Survey__c =:surveyId And Survey_Tracker__c =: ApexPages.currentPage().getParameters().get('trackerId')];
        if(sRepondent.IsResponseReceived__c){
            isSubmitted = true;
        }
        if(!isSubmitted){
            List<SPE2_Question_Survey_Association__c> qsaList = new List<SPE2_Question_Survey_Association__c>();
            qsaList = [Select Id,Name,ordernumber__c,PIData__c,PIData__r.ValuesType__c,Question_Bank__c,Supplier__c,Question_Bank__r.IsRequired__c,
                       Survey__c,Question_Bank__r.AnswerType__c,Question_Bank__r.SurveyQuestion__c 
                       From SPE2_Question_Survey_Association__c 
                       Where Survey__c =:surveyId order by ordernumber__c];
                       
            set<String> questionIds = new set<String>();
            for(SPE2_Question_Survey_Association__c qs :qsaList){
                questionIds.add(qs.Question_Bank__c);
            }
            List<SPE_SurveyQuestion__c> surveyQnlist = new List<SPE_SurveyQuestion__c>();
            surveyQnlist = [Select Id,SurveyQuestion__c,Name,(Select name,Choices__c,Score__c From SPE_SurveyAnswers__r order by name) From SPE_SurveyQuestion__c 
                            Where ID IN :questionIds order by Name];
            
            Map<String,List<SPE_SurveyAnswer__c>> qstnToAnsMap = new Map<String,List<SPE_SurveyAnswer__c>>();
            for(SPE_SurveyQuestion__c sq :surveyQnlist){
                qstnToAnsMap.put(sq.id,sq.SPE_SurveyAnswers__r);
            }
            List<SPE2_SurveySupplierMap__c> surveySupplierlist = new List<SPE2_SurveySupplierMap__c>();
            surveySupplierlist = [Select Id,Supplier__c,Supplier__r.Name,SPE2_Survey__c From SPE2_SurveySupplierMap__c
                                  Where SPE2_Survey__c =:surveyId];
            
            for(SPE2_SurveySupplierMap__c ssm :surveySupplierlist){
                List<surveyQuestionWrapper> sqWrptempList = new List<surveyQuestionWrapper>();
                sqWrpperList = new List<surveyQuestionWrapper>();
                for(SPE2_Question_Survey_Association__c qsaTemp :qsaList){
                    sqWrptempList.add(new surveyQuestionWrapper(qsaTemp,qstnToAnsMap.get(qsaTemp.Question_Bank__c)));
                    sqWrpperList.add(new surveyQuestionWrapper(qsaTemp));
                }           
                surveySuppList.add(new surveySupplierWrapper(ssm,sqWrptempList));
            }
        }                
    }
    public void selectNAForSupplier(){
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('inputRowNum'));        
        for(surveyQuestionWrapper sqw :surveySuppList[rowIndex].sqWrpList){
            sqw.isApplicable = surveySuppList[rowIndex].isSelected;
        }                   
    }
    public pageReference submitSurvey(){
        List<SPE_PIValues__c> piValuesToInsert = new List<SPE_PIValues__c>();
        List<SPE_SurveyResponse__c> surveyResponsesToinsert = new List<SPE_SurveyResponse__c>();  
        if(checkValidations()){            
            for(surveySupplierWrapper ssw :surveySuppList){
                for(surveyQuestionWrapper sqw :ssw.sqWrpList){
                    if(!sqw.isApplicable){
                        SPE_PIValues__c piVal = new SPE_PIValues__c();
                        if(sqw.qsa.PIData__c != null){
                            piVal.PIDefination__c = sqw.qsa.PIData__c;
                            piVal.EnterpriseID__c = ssw.suppName;
                            piVal.Respondent__c = ApexPages.currentPage().getParameters().get('conId');
                            pival.BusinessLine__c = tracker.BusinessLine__c;
                            piVal.BusinessUnit__c = tracker.BusinessUnit__c;
                            piVal.Category__c = tracker.Category__c;
                            piVal.Cluster__c = tracker.CategoryArea__c;
                            pival.CategoryGroup__c = tracker.CategoryGroup__c;
                            piVal.Country__c = tracker.Country__c;
                            piVal.Market__c = tracker.Market__c;
                            pival.MarketUnit__c = tracker.MarketUnit__c;
                            piVal.SubRegion__c = tracker.MarketUnit__c;
                            pival.Project__c = tracker.Project__c;
                            pival.Product__c = tracker.Product__c;
                            piVal.Period__c = Date.newinstance(tracker.DateOfExecution__c.year(),tracker.DateOfExecution__c.month(),7);
                            if(sqw.qsa.PIData__r.ValuesType__c == 'Number'){
                                system.debug('enter here::');
                                if(sqw.selectedAns != '-1' && sqw.qsa.Question_Bank__r.AnswerType__c == 'Picklist'){
                                    system.debug('enter here::34');
                                    pival.NumberValue__c = integer.valueOf(sqw.selectedAns);
                                }  
                                else
                                {
                                pival.NumberValue__c =0;
                                }                     
                            }
                            if(sqw.qsa.PIData__r.ValuesType__c == 'String'){
                                if(sqw.qsa.Question_Bank__r.AnswerType__c == 'Free Text'){
                                    pival.StringValue__c = sqw.FreeTextResponse;
                                }else{
                                    pival.StringValue__c = 'N/A';
                                }                           
                            }
                            piVal.SurveyComments__c = sqw.respComment;
                            piVal.Survey_Tracker__c = tracker.Id;
                            piValuesToInsert.add(piVal);
                            
                        }
                        
                        // insert Survey Responses
                        SPE_SurveyResponse__c sResp = new SPE_SurveyResponse__c();
                        if(sqw.qsa.Question_Bank__c != Null){
                            sResp.Questions__c = sqw.qsa.Question_Bank__c;
                            sResp.Supplier__c = ssw.suppId;
                            sResp.Respondent__c = ApexPages.currentPage().getParameters().get('conId');
                            sResp.Answers__c = sqw.ansObjId.get(sqw.selectedAns);
                            sResp.Response__c = sqw.respComment;
                            sResp.Survey_Tracker__c = tracker.Id;
                            sResp.Survey__c = surveyID;
                           
                            surveyResponsesToinsert.add(sResp);                        
                        }                    
                    }
                }                
                    
            }
            try{            
                List<SPE_PIValues__c> newpiValuesToInfsert = new List<SPE_PIValues__c>();  
               List<SPE_SurveyResponse__c> newresponseToInfsert = new List<SPE_SurveyResponse__c>();  
                
                for(SPE_PIValues__c pivalit : piValuesToInsert)
                {
                 if(pivalit.NumberValue__c!=null && pivalit.NumberValue__c!=0.00 )
                    newpiValuesToInfsert.add(pivalit);
                    }
                 for(SPE_SurveyResponse__c resvalit : surveyResponsesToinsert)
                {
                 if(resvalit.Answers__c!=null)
                 {
                 system.debug('checking my answers list' +resvalit.Answers__c);
                 newresponseToInfsert.add(resvalit);
                 }
                 
                }
                
                insert newpiValuesToInfsert;
               
                insert newresponseToInfsert;
                //insert piValuesToInfsert;
               // insert surveyResponsesToinsert;
                isSubmitted = true;
                
                if(isSubmitted){
                    sRepondent.IsResponseReceived__c = true;
                   // sRepondent.RespondentC__c = 1;
                    update sRepondent;
                }             
            }catch(Exception e){
                system.debug('***'+e.getMessage());
            }
        }else{
        
             ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Please Fill out the required fields!');
             ApexPages.addmessage(msg);
            reqError = 'Please fill the required field';
             isSubmitted = False;
        }
        return null;
    }
    public boolean checkValidations(){
        isReturnFalse = false;
        for(surveySupplierWrapper ssw :surveySuppList){
            for(surveyQuestionWrapper sqw :ssw.sqWrpList){  
                sqw.errorMsg = 'false';              
                if(!sqw.isApplicable && sqw.qsa.Question_Bank__r.IsRequired__c && sqw.isFreeText){
                    if(sqw.FreeTextResponse == '' || sqw.FreeTextResponse == null){
                        sqw.errorMsg = 'true';
                        isReturnFalse = true;
                        //return false;
                    }
                    
                }
                if(!sqw.isApplicable && sqw.qsa.Question_Bank__r.IsRequired__c && !sqw.isFreeText){
                    if(sqw.selectedAns == '-1'){
                        sqw.errorMsg = 'true';
                        isReturnFalse = true;
                        //return false;
                    }
                }
                 if(!sqw.isApplicable && !sqw.qsa.Question_Bank__r.IsRequired__c && !sqw.isFreeText){
                    if(sqw.selectedAns == '-1'){
                       
                        isReturnFalse = true;
                        //return false;
                    }
                }
            }
        }
        if(isReturnFalse)
            return true;
        else
            return false;
    }
      public class surveySupplierWrapper{
          public String surveyId{get;set;}
          public String suppId{get;set;}
          public String suppName{get;set;}
          public boolean isSelected{get;set;}
          public List<surveyQuestionWrapper> sqWrpList{get;set;}
          public surveySupplierWrapper(SPE2_SurveySupplierMap__c supplier,List<surveyQuestionWrapper> sqWrpList){
              this.sqWrpList = sqWrpList;
              surveyId = supplier.SPE2_Survey__c;
              suppId = supplier.Supplier__c;
              suppName = supplier.Supplier__r.Name;
          }
      }
      
      public class surveyQuestionWrapper{
          public SPE2_Question_Survey_Association__c qsa{get;set;}
          public String selectedAns{get;set;}
          public List<SelectOption> ansOptions{get;set;}
          public boolean isFreeText{get;set;}
          public String FreeTextResponse{get;set;}
          public String respComment{get;set;}
          public boolean isApplicable{get;set;}
          public Map<String,String> ansObjId{get;set;}
          public String errorMsg {get;set;}
          public surveyQuestionWrapper(SPE2_Question_Survey_Association__c qsa,List<SPE_SurveyAnswer__c> surveyAns){
              this.qsa = qsa;
              isFreeText = true;
              ansObjId = new map<String,String>();
              ansOptions = new List<SelectOption>();
              if(qsa.Question_Bank__r.AnswerType__c == 'Picklist'){   
                  ansOptions.add(new SelectOption('-1','--None--'));                       
                  for(SPE_SurveyAnswer__c sa :surveyAns){
                      ansOptions.add(new SelectOption(string.valueOf(sa.Score__c),sa.Choices__c));
                      ansObjId.put(string.valueOf(sa.Score__c),sa.Id);                      
                  }   
                  isFreeText = false;     
              }else{
                  isFreeText = true;         
              }                                  
          }
          public surveyQuestionWrapper(SPE2_Question_Survey_Association__c qsa){
              this.qsa = qsa;
             }
      }
}