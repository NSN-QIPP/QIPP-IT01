public class SPE2_SPETemplateScopeInlineExt{
    String recordId;
    Id userId;
    public SPE_SPETemplate__c spetemplateList{get;set;}
    public boolean isScope{get;set;}
    public boolean isAttribute{get;set;}
    
    public SPE2_SPETemplateScopeInlineExt(ApexPages.StandardController st){
        recordId = st.getId();
        userId = userInfo.getUserId();    
        isScope = false;
        isAttribute = false;        
        spetemplateList = new SPE_SPETemplate__c();
        spetemplateList = [Select Id,GeoScope__c,Categoryscope__c,BUScope__c,Region__c,SubRegion__c,Country__c,
                            Project__c,CategoryCluster__c, CategoryGroup__c,Category__c,BusinessUnit__c,
                            BusinessLine__c,Product__c from SPE_SPETemplate__c Where Id =:st.getId()];
                            
        set<string> groupSet = new set<string>();
        for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userId]){
            groupSet.add(gm.Group.name);
        }
        if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
            isScope = false;
            isAttribute = true; 
        }
       else if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
           isScope = true;
           isAttribute = false; 
       }
    }
}