trigger PortfolioOwnerProjectAccess on Portfolios_Owner__c (After Insert, After Update) {

    Set<ID> portfolioID = new Set<ID>();
    Map<ID,List<Portfolios_Owner__c>> portfoliosAndOwnersMap = new Map<ID,List<Portfolios_Owner__c>>();
    
    List<Portfolios_Owner__c> ownersList = [select id,Name,QIPP_Portfolio__c,QIPP_Contact__r.User_License__c,Is_Super_Portfolio__c from Portfolios_Owner__c where ID IN:Trigger.new and Is_Super_Portfolio__c =True];

    
    for(Portfolios_Owner__c  owner : ownersList ){
        portfolioID.add(owner.QIPP_Portfolio__c);
        if(portfoliosAndOwnersMap.containsKey(owner.QIPP_Portfolio__c )){
            portfoliosAndOwnersMap.get(owner.QIPP_Portfolio__c).add(owner);
        }else{
            portfoliosAndOwnersMap.put(owner.QIPP_Portfolio__c ,new List<Portfolios_Owner__c>());
            portfoliosAndOwnersMap.get(owner.QIPP_Portfolio__c).add(owner);
        }    
    }
    
    List<QIPP_Project__c> ProjectList = [Select id,Name,Portfolio_Name__c from QIPP_Project__c where Portfolio_Name__c IN:portfolioID];
    Map<ID,List<QIPP_Project__c>> porfolioAndProjects = new Map<ID,List<QIPP_Project__c>>();
    
    for(QIPP_Project__c proj : ProjectList){
        if(porfolioAndProjects.containsKey(proj.Portfolio_Name__c)){
            porfolioAndProjects.get(proj.Portfolio_Name__c).add(proj);
        }else{
            porfolioAndProjects.put(proj.Portfolio_Name__c ,new List<QIPP_Project__c>());
            porfolioAndProjects.get(proj.Portfolio_Name__c ).add(proj);
        }   
    }

    Set<QIPP_Project__Share> insertNewOwners = new Set<QIPP_Project__Share>();


    for(Id porfolioID : porfolioAndProjects.keySet()){    
        for(QIPP_Project__c proj : porfolioAndProjects.get(porfolioID)){
            for(Portfolios_Owner__c  owner : portfoliosAndOwnersMap.get(porfolioID)){
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

    if(Trigger.isUpdate){
        List<Portfolios_Owner__c> deleteOwnersList = new List<Portfolios_Owner__c>();
        
        for(Portfolios_Owner__c owner : Trigger.new){
            Portfolios_Owner__c oldRec = Trigger.OldMap.get(owner.id);
            if(owner.Is_Super_Portfolio__c == false && oldRec.Is_Super_Portfolio__c == True ){
                deleteOwnersList.add(owner);
            }
        }
        
        try{
            if(deleteOwnersList.size()!=0){
                delete deleteOwnersList;
            }
        }catch(exception e){
            system.debug(e);
        }   
    
    
    }



}