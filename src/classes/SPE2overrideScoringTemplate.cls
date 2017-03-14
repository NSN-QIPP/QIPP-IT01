public class SPE2overrideScoringTemplate{
        
    String recordId;
    Id userId;
    public string speTempId;
    public string scorTempId;
    
    public SPE2overrideScoringTemplate() {
    }
        
  public SPE2overrideScoringTemplate(ApexPages.StandardController controller){
            recordId = controller.getId();
            userId = userInfo.getUserId();      
            speTempId = ApexPages.currentPage().getParameters().get('speTempId');
            scorTempId =  ApexPages.currentPage().getParameters().get('scorTempId');
            
  }
    
  public PageReference populateScoringTemplate(){
      set<string> groupSet = new set<string>();
      for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
       groupSet.add(gm.Group.name);
      }
      
      if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
           PageReference existingScoringTempPage =  Page.SPE_NewScoringTemplate;
           existingScoringTempPage.setRedirect(true);
          // existingScoringTempPage.getParameters().put('id', recordId);
           existingScoringTempPage.getParameters().put('speTempId', speTempId);
           existingScoringTempPage.getParameters().put('scorTempId', scorTempId);
           return existingScoringTempPage; 
      } 
      if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
           PageReference newScoringTempPage =  Page.SPE2_1_NewScoringTemplate;
           newScoringTempPage.setRedirect(true);
         //  newScoringTempPage.getParameters().put('id', recordId);
           newScoringTempPage.getParameters().put('speTempId', speTempId);
           newScoringTempPage.getParameters().put('scorTempId', scorTempId);
           return newScoringTempPage;  
      }
      
   return null;
  }
}