trigger SPE2_Scorecard_CcContact_Update on SPE_ScoreCard__c (after insert) {

    List<SPE_ScoreCard__c> sCard = new List<SPE_ScoreCard__c>();
    Set<String> sCardGeneratorIds = new Set<String>();
    sCard = [Select Id ,ScorecardTracker__r.ScorecardGenerator__c,Supplier__c,ScorecardTracker__c from SPE_ScoreCard__c where ID IN :Trigger.new];
    
    Map<String,set<String>> scorecardToSupplierMap = new  Map<String,set<String>>();
        
    for (SPE_ScoreCard__c  sc :sCard){
        sCardGeneratorIds.add(sc.ScorecardTracker__r.ScorecardGenerator__c);
        if(!scorecardToSupplierMap.containsKey(sc.Supplier__c+';'+sc.ScorecardTracker__r.ScorecardGenerator__c)){
            scorecardToSupplierMap.put(sc.Supplier__c+';'+sc.ScorecardTracker__r.ScorecardGenerator__c,new set<String>());
        }
        scorecardToSupplierMap.get(sc.Supplier__c+';'+sc.ScorecardTracker__r.ScorecardGenerator__c).add(sc.ID);
    }
    
    System.debug('scorecardToSupplierMap::' + scorecardToSupplierMap);
    List<SPE_ScorecardSupplierMap__c> scSuppMapList = new   List<SPE_ScorecardSupplierMap__c>();
    scSuppMapList = [Select Id, ScorecardGenerator__c from SPE_ScorecardSupplierMap__c where ScorecardGenerator__c  IN :sCardGeneratorIds];
    Set<String> suppPlanIds = new Set<String>();
    for(SPE_ScorecardSupplierMap__c sm :scSuppMapList){
        suppPlanIds.add(sm.Id);
    }
    List<SPE2_CC_Contact_Details__c> ccContactList = new  List<SPE2_CC_Contact_Details__c>();
    List<SPE2_CC_Contact_Details__c> ccContactsToInsert = new  List<SPE2_CC_Contact_Details__c>();
    ccContactList = [Select Id,Scorecard_Supplier_Map__c,Scorecard_Supplier_Map__r.ScorecardGenerator__c,ScoreCard__c,
                      Scorecard_Supplier_Map__r.Supplier__c,ScoreCard__r.ScorecardTracker__c,Contact__c 
                      from SPE2_CC_Contact_Details__c
                      where Scorecard_Supplier_Map__c IN :suppPlanIds AND ScoreCard__c = null];
    System.debug('ccContactList ::' + ccContactList );
    for(SPE2_CC_Contact_Details__c cc :ccContactList){
        if(!scorecardToSupplierMap.isempty()){
            for(String ss :scorecardToSupplierMap.keySet()){
                if(ss == cc.Scorecard_Supplier_Map__r.Supplier__c+';'+cc.Scorecard_Supplier_Map__r.ScorecardGenerator__c){
                    for(String a :scorecardToSupplierMap.get(ss)){                    
                        SPE2_CC_Contact_Details__c ccCon = new SPE2_CC_Contact_Details__c();
                        //ccCon.Scorecard_Supplier_Map__c = cc.Scorecard_Supplier_Map__c;
                        ccCon.Contact__c = cc.Contact__c;
                        ccCon.ScoreCard__c = a;
                        ccContactsToInsert.add(ccCon);                                       
                    } 
                }                               
            }            
        }
        System.debug('cc.ScoreCard__c::' + cc.ScoreCard__c);
    }
    
    try{
        insert ccContactsToInsert;
    }catch(Exception e){
        System.debug('check::' + e.getMessage());
    } 
}