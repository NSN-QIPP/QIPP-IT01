public class SPE2overrideScoringViewTemplate{
        
    String recordId;
    Id userId;
    Id idScoringTempId ;
    public SPE2overrideScoringViewTemplate() {
    }
        
  public SPE2overrideScoringViewTemplate(ApexPages.StandardController controller){
            recordId = controller.getId();
            userId = userInfo.getUserId();  
            idScoringTempId =controller.getId();             
  }
    
  public PageReference populateScoringViewTemplate(){
      set<string> groupSet = new set<string>();
      for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
       groupSet.add(gm.Group.name);
      }
      
      if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
           PageReference existingScoringTempPage =  new PageReference('/apex/SPE_NewScoringViewTemplate?id='+idScoringTempId);
           existingScoringTempPage.setRedirect(true);
           return existingScoringTempPage; 
      } 
      else if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
           PageReference newScoringTempPage =  new PageReference('/apex/SPE2_1_NewScoringViewTemplate?id='+idScoringTempId);
           newScoringTempPage.setRedirect(true);      
           return newScoringTempPage;  
      }
   return null;
  }
}