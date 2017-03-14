public class SPE2overrideCloneSPETemplate{
        
    public String SpeTempId;
    Id userId;    
    public string isClone;

    public SPE2overrideCloneSPETemplate() {
    }
        
  public SPE2overrideCloneSPETemplate(ApexPages.StandardController controller){
            SpeTempId = controller.getId();
            userId = userInfo.getUserId();      
            isClone =ApexPages.currentPage().getParameters().get('isClone');
  }
    
  public PageReference populateCloneSPETemplate(){
      set<string> groupSet = new set<string>();
      for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
       groupSet.add(gm.Group.name);
      }
      
      if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
           PageReference existingScoringTempPage =  new PageReference('/apex/SPE_NewSPETemplate?isClone='+isClone+'&id='+SpeTempId);
           existingScoringTempPage.setRedirect(true);
           existingScoringTempPage.getParameters().get('isClone'); 
           existingScoringTempPage.getParameters().put('SpeTempId',SpeTempId);           
           return existingScoringTempPage; 
      } 
      if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
           PageReference newScoringTempPage =  new PageReference('/apex/SPE2_NewSPETemplate?isClone='+isClone+'&id='+SpeTempId);
           newScoringTempPage.setRedirect(true);
           newScoringTempPage.getParameters().get('isClone');
           newScoringTempPage.getParameters().put('SpeTempId',SpeTempId);           
           return newScoringTempPage;  
      }
      
   return null;
  }
}