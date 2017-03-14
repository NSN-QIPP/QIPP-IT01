public with sharing class SPE_SurveyTrack
{
    public Id trackerId{get;set;}
    public SPE_SPETracker__c speTracker; 
    Set<ID> uniqueResponseId = new Set<Id>();
    List<SPE_TrackerRespondent__c> trackRespondentList;
    List<SPE_SurveyResponse__c> responseList;
    Boolean flag;
    
    public SPE_SurveyTrack(ApexPages.Standardcontroller st) 
    {
        
        speTracker =  [select Id,Name,SPEPlan__c FROM SPE_SPETracker__c Where Id =:st.getId()];
        trackRespondentList =  New List<SPE_TrackerRespondent__c>([SELECT id,Name,Contact__c,Contact__r.Name,Contact__r.Email,SPE_Plan__c,SPE_Tracker__c,CreatedDate ,IsResponseReceived__c FROM SPE_TrackerRespondent__c where SPE_Tracker__c=:speTracker.id ]);
              
        try{ 
               if(trackRespondentList.size()>0 ){
                   getBarChartData();
               }
               else{
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'For this tracker No Response available to track'));
                  
               }
        }
        catch(Exception ex)
        {
               ApexPages.addMessages(ex);
              
        } 
    }
    
   

    public List<BarChartData> getBarChartData() 
    {
        List<BarChartData > barData = new List<BarChartData>();

        Map<String,set<ID>> allUniqueContactMap = new Map<String,set<ID>>();
        Set<Id> completeContactId = new Set<Id>();
        Set<Id> pendingContactId = new Set<Id>();
        
        if(trackRespondentList.size()>0){
        for (SPE_TrackerRespondent__c trackerResp  : trackRespondentList )
         {
             DateTime createdDateTime = trackerResp.createdDate;
             Date createdDate = date.newinstance(createdDateTime.year(), createdDateTime.month(), createdDateTime.day());
             String sDate = String.valueOf(createdDate );
             
             set<Id> allUniqueContactId = new set<Id>();
           
            if(allUniqueContactMap.get(sDate) != null)
            {
                allUniqueContactId = allUniqueContactMap.get(sDate);
            }
             allUniqueContactId.add(trackerResp.Contact__c);
             allUniqueContactMap.put(sDate, allUniqueContactId);
             
            if(trackerResp.IsResponseReceived__c == True){
                completeContactId.add(trackerResp.Contact__c);
            }
            else{
                pendingContactId.add(trackerResp.Contact__c);
            }
              
         }
         
         
         
         for(String createDate : allUniqueContactMap.keySet())
         {  
             barData .add(new BarChartData(createDate , completeContactId.size(), pendingContactId.size()));
         }
       }
        return barData ;
    }

    
    public class BarChartData {
    
        public String name1 { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        
        public BarChartData (String name1, Integer data1, Integer data2) {
            this.name1 = name1;
            this.data1 = data1;
            this.data2 = data2;
        } 
    }

}