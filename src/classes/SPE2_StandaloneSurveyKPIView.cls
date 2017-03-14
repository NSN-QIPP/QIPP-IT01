public class  SPE2_StandaloneSurveyKPIView{

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
    public SPE2_StandaloneSurveyKPIView(){          
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
        system.debug('spePlan---' + spePlan);    
        currentDate =  system.today();
        String s1 = spePlan.Survey_Sequential_Id__c+'';
        surveySeqId =  s1.substringBetween('>','</a>');
        system.debug('surveySeqId---' + surveySeqId);                                                                 
        
            List<SPE2_Question_Survey_Association__c> qsaList = new List<SPE2_Question_Survey_Association__c>();
            qsaList = [Select Id,Name,ordernumber__c,PIData__c,PIData__r.ValuesType__c,Question_Bank__c,Supplier__c,Question_Bank__r.IsRequired__c,
                       Survey__c,Question_Bank__r.AnswerType__c,Question_Bank__r.SurveyQuestion__c 
                       From SPE2_Question_Survey_Association__c 
                       Where Survey__c =:surveyId order by ordernumber__c];
            system.debug('qsaList---' + qsaList);           
            set<String> questionIds = new set<String>();
            for(SPE2_Question_Survey_Association__c qs :qsaList){
                questionIds.add(qs.Question_Bank__c);
            }
            List<SPE_SurveyQuestion__c> surveyQnlist = new List<SPE_SurveyQuestion__c>();
            surveyQnlist = [Select Id,SurveyQuestion__c,Name,(Select name,Choices__c,Score__c From SPE_SurveyAnswers__r order by name) From SPE_SurveyQuestion__c 
                            Where ID IN :questionIds order by Name];
            
            system.debug('surveyQnlist---' + surveyQnlist);
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
    
      public class surveySupplierWrapper{
          public String surveyId{get;set;}
          public String suppId{get;set;}
          public String suppName{get;set;}
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