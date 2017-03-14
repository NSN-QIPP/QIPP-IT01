trigger BBGGroups on Project_Redeployed__c (after insert,after update) {
     Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
     if(s.Run_Triggers__c){
         System.debug('In BBG Groups trigger');
      Map<ID,QIPP_Project__c> projectmap = new Map<ID,QIPP_Project__c>(); 
      List<Id> listIds = new List<Id>();
      List<Qipp_project__C> updateproj= new List<Qipp_project__C> ();
      List<Project_Redeployed__c> rederec= new List<Project_Redeployed__c> ();
      
      for (Project_Redeployed__c childObj : Trigger.new) {
        listIds.add(childObj.Project__c);
        
      }
     System.debug('listIds:::'+listIds);
     System.debug('childObj:::'+Trigger.new);
    String BusinessUnits='';
    String BusinessGroups='';
    String BBGroup='';
    projectmap = new Map<Id,QIPP_Project__c>([SELECT id,Redeployment_Business_Units__c,Redeployment_Business_Groups__c,(SELECT ID,Benefitting_Business_Unit__c,Benefitting_Business_Grp_Functional_Grp__c,project__C FROM Project_Redeployeds__r) FROM QIPP_Project__c WHERE ID IN :listIds]);
    rederec= [SELECT ID,Benefitting_Business_Unit__c,Benefitting_Business_Grp_Functional_Grp__c,project__C FROM Project_Redeployed__c where project__C IN :listIds];
      System.debug('rederec:::'+rederec);
        try{    
            QIPP_Project__c myParentOpp;
            for (Project_Redeployed__c projredeprec: rederec){
                  myParentOpp = projectmap.get(projredeprec.project__C);
                  System.debug('projredeprec:'+projredeprec);
                  BusinessGroups+= projredeprec.Benefitting_Business_Grp_Functional_Grp__c;
                  BusinessGroups+=';';
                  BusinessUnits+=projredeprec.Benefitting_Business_Grp_Functional_Grp__c;
                  BusinessUnits+='-';
                  BusinessUnits+=projredeprec.Benefitting_Business_Unit__c;
                  BusinessUnits+=';';
                  myParentOpp.Redeployment_Business_Groups__c=BusinessGroups; 
                  myParentOpp.Redeployment_Business_Units__c=BusinessUnits;
             }
          updateproj.add(myParentOpp);
          update updateproj;
    system.debug('updateproj::'+updateproj); 
    //update projectmap.values(); 
   // update updateproj;
}
  Catch(Exception e){
      System.debug('Exception:::'+e.getMessage());
  }
}
}