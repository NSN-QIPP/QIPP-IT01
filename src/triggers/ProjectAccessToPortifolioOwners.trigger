trigger ProjectAccessToPortifolioOwners on QIPP_Project__c (After Insert) {

    List<ID> portfolioIDs = new List<ID>();
    Set<QIPP_Project__Share> insertNewOwners = new Set<QIPP_Project__Share>();
    
    for(QIPP_Project__c proj : Trigger.New ){
        portfolioIDs.add(proj.Portfolio_Name__c);       
    }

    List<Portfolios_Owner__c> ownersList = new List<Portfolios_Owner__c>();
    ownersList = [select id,Name,QIPP_Portfolio__c,QIPP_Contact__r.User_License__c,Is_Super_Portfolio__c from Portfolios_Owner__c where QIPP_Portfolio__c IN:portfolioIDs and Is_Super_Portfolio__c =True];

    Map<ID,List<Portfolios_Owner__c>> portfoliosOwnersMap = new Map<ID,List<Portfolios_Owner__c>>();
    
    for(Portfolios_Owner__c owner : ownersList ){
        if(portfoliosOwnersMap.containsKey(owner.QIPP_Portfolio__c )){
            portfoliosOwnersMap.get(owner.QIPP_Portfolio__c).add(owner);
        }else{
            portfoliosOwnersMap.put(owner.QIPP_Portfolio__c ,new List<Portfolios_Owner__c>());
            portfoliosOwnersMap.get(owner.QIPP_Portfolio__c).add(owner);
        }
    }
    
    for(QIPP_Project__c proj : Trigger.New){
        if(portfoliosOwnersMap.get(proj.Portfolio_Name__c) != null){
            for(Portfolios_Owner__c owner : portfoliosOwnersMap.get(proj.Portfolio_Name__c)){
               QIPP_Project__Share shareRec = new QIPP_Project__Share();
               shareRec.ParentId = proj.id;
               shareRec.UserOrGroupId  = owner.QIPP_Contact__r.User_License__c;
               shareRec.AccessLevel = 'edit';
               shareRec.RowCause = Schema.QIPP_Project__Share.RowCause.Owner;
               insertNewOwners.add(shareRec);
            }
        }
    
    }
    
    try{
        if(insertNewOwners.size()!=0){
            insert new List<QIPP_Project__Share>(insertNewOwners);
        }
    }catch(exception e){
        system.debug(e);
    }    

}