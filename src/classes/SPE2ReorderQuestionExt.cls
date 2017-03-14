public class SPE2ReorderQuestionExt{
    public List<SPE2_Question_Survey_Association__c> lstSurveyQuesAssoc {get;set;}
    Id RecordId; 
    public String newOrderW {get;set;}
    
    public SPE2ReorderQuestionExt(ApexPages.StandardController st){
        RecordId = st.getID();
        lstSurveyQuesAssoc = new List<SPE2_Question_Survey_Association__c>();
        lstSurveyQuesAssoc = [SELECT ID,Question_Bank__c,Survey__c,PIData__c,PIData__r.DataAcquisitionMethod__c,Question_Bank__r.Name,
                             Question_Bank__r.QuestionLabel__c,ordernumber__c,Question_Bank__r.surveyQuestion__C from SPE2_Question_Survey_Association__c where Survey__c = :RecordId order by ordernumber__c];
                             
        if(lstSurveyQuesAssoc.size()>0){
        
        }
    }
    
     public PageReference updateOrderList()
  {
    if(newOrderW.length() <= 0)
    {
        return null;
        system.debug('neworder--null');
    }
    system.debug('newOrderW ::'+newOrderW);
    newOrderW = newOrderW.substring(0, newOrderW.length() -1);
    
    List<String> idsToUpdate = newOrderW.split(',',-1);
    List<SPE2_Question_Survey_Association__c> qsToUpdate = new List<SPE2_Question_Survey_Association__c>();
    
    Map<Id,SPE2_Question_Survey_Association__c> questionMap = new Map<Id,SPE2_Question_Survey_Association__c>([select Id, OrderNumber__c from SPE2_Question_Survey_Association__c where Id in :idsToUpdate]);
       system.debug('questionMap'+questionMap);
       system.debug('id to update--'+idsToUpdate);
    SPE2_Question_Survey_Association__c sqToUpdate;
    
    for (Integer i = 0; i < idsToUpdate.size(); i++)
    {
        sqToUpdate = questionMap.get(idsToUpdate.get(i));
        system.debug('sqtoUpdate'+sqToUpdate);
        system.debug('order number ---'+i);
        sqToUpdate.OrderNumber__c = i;
        qsToUpdate.add(sqToUpdate);
    }
    
    system.debug('lst to update'+qsToUpdate);
    update qsToUpdate;
    
    PageReference pg = new PageReference('/'+RecordId);
    return pg;
    

  } 
  
  
  
    
public class QuestionSurveyWrapper implements Comparable{
     public SPE2_Question_Survey_Association__c quesSurvey {get;set;}
     public Boolean isSelected {get;set;}
     public Boolean isInvalid {get;set;} 
     
     public QuestionSurveyWrapper(SPE2_Question_Survey_Association__c qu,Boolean x){
         quesSurvey = qu;
         isSelected = x;
       //  isInvalid = y;
         
     
     }  
     
      public Integer compareTo(Object compareTo) {
         QuestionSurveyWrapper compareToSupp = (QuestionSurveyWrapper)compareTo;
        if (quesSurvey.Question_Bank__r.Name== compareToSupp.quesSurvey.Question_Bank__r.Name) return 0;
        if (quesSurvey.Question_Bank__r.Name> compareToSupp.quesSurvey.Question_Bank__r.Name) return 1;
        return -1;        
    }
        
        
 }       
    


}