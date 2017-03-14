public class SPE2overrideSPETemplate{
        
  String recordId;
  Id userId;
  public String RecordOwnerId{get;set;}
  public Boolean isAllow{get;set;}  
  
  public SPE2overrideSPETemplate() {
  }
        
  public SPE2overrideSPETemplate(ApexPages.StandardController controller){
      recordId = controller.getId();
      userId = userInfo.getUserId();
      isAllow = false;
      
      try{      
      RecordOwnerId = [Select Id,ownerId from SPE_SPETemplate__c
                       WHERE Id =: recordId].ownerId;
      }catch(Exception e){
          RecordOwnerId = null;
      }                 
      
      if(RecordOwnerId != Null){
          if(RecordOwnerId != userId){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'You can only edit the SPE Template under your ownership or shared record'));
              isAllow = true;
          }
      }                                                
  }
    
  public PageReference populateSPETemplate(){
      set<string> groupSet = new set<string>();
      for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
       groupSet.add(gm.Group.name);
      }
      
      if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
           PageReference existingSPETempPage =  Page.SPE_NewSPETemplate;
           existingSPETempPage.setRedirect(true);
           existingSPETempPage.getParameters().put('id', recordId);
           return existingSPETempPage ; 
      } 
      else if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
           PageReference newSPETempPage =  Page.SPE2_NewSPETemplate;
           newSPETempPage.setRedirect(true);
           newSPETempPage.getParameters().put('id', recordId);
           return newSPETempPage ;  
      }
   return null;
  }
}