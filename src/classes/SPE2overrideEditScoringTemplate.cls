public class SPE2overrideEditScoringTemplate{
    public String RecordOwnerId{get;set;}
    public String CurrentUserId{get;set;}    
    String recordId;
    Id userId; 
    Public Boolean differentOwner{get;set;}   
    
    public SPE2overrideEditScoringTemplate() {
    }
        
  public SPE2overrideEditScoringTemplate(ApexPages.StandardController controller){
        differentOwner = false;
        recordId = controller.getId();
        userId = userInfo.getUserId(); 
        CurrentUserId = UserInfo.getUserId();
        RecordOwnerId = [Select Id, ownerId from SPE_ScoringTemplate__c
                       WHERE Id =: controller.getId() ].ownerId; 
                           
          if(CurrentUserId  != RecordOwnerId){
              differentOwner = true;
          }            
  }
    
  public PageReference checkOwner(){
  differentOwner = true;
  return Null;
  }
  public PageReference populateEditScoringTemplate(){
      set<string> groupSet = new set<string>();
      for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
       groupSet.add(gm.Group.name);
      }
      if(differentOwner){
          return Null;
      }
       
      if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
           PageReference existingScoringTempPage =  Page.SPE_NewScoringTemplate;
           existingScoringTempPage.setRedirect(true);
           existingScoringTempPage.getParameters().put('id', recordId);
           
           return existingScoringTempPage; 
      } 
      if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
           PageReference newScoringTempPage =  Page.SPE2_1_NewScoringTemplate;
           newScoringTempPage.setRedirect(true);
           newScoringTempPage.getParameters().put('id', recordId);
           
           return newScoringTempPage;  
      }
      
   return null;
  }
}