public class QIPPBGMBBMapController{

    public Id poid{get;set;}
    public List<BGMBBMapWrapper> bgMBBMapList{get;set;}
    
    public List<QIPP_Contacts__c> allBGContList;
    public List<QIPP_BG_BU_BL_Contact_Mapping__c> bgConMappedList;
    public Map<String,QIPP_BG_BU_BL_Contact_Mapping__c> mappedBGMap;

    public QIPPBGMBBMapController(apexpages.StandardController stdController){

        poId = ApexPages.currentPage().getParameters().get('poid');
        system.debug('@@poId:'+poId);
        String retURL = ApexPages.currentPage().getParameters().get('retURL');
        system.debug('@@retURL:'+retURL);
        if(retURL != null && retURL != ''){
            poId = retURL.subString(1,retURL.length());
        }
        system.debug('@@poId 1:'+poId);
        
        allBGContList = new List<QIPP_Contacts__c>();
        bgConMappedList = new List<QIPP_BG_BU_BL_Contact_Mapping__c>();
        bgMBBMapList = new List<BGMBBMapWrapper>();
        mappedBGMap = new Map<String,QIPP_BG_BU_BL_Contact_Mapping__c>();

        allBGContList = [select Id,Name,Email__c from QIPP_Contacts__c where User_License__c != null and User_License__r.Profile.Name = 'Nokia QIPP Project Lead' and User_License__r.isactive = true and (CoPQ_Role_1__c =: 'Business Unit Master Black Belt' or CoPQ_Role_2__c =: 'Business Unit Master Black Belt' or CoPQ_Role_3__c =: 'Business Unit Master Black Belt' or CoPQ_Role_4__c =: 'Business Unit Master Black Belt') and Contact_State__c =:'Active' ORDER BY name];
        bgConMappedList = [Select Id,Name,Business_Group_Master_Black_Belt__c,Business_Group_Master_Black_Belt__r.Name,Portfolio_Name__c,Portfolio_Name__r.Name From QIPP_BG_BU_BL_Contact_Mapping__c Where Portfolio_Name__c =: poId];
        for(QIPP_BG_BU_BL_Contact_Mapping__c bg : bgConMappedList){
            mappedBGMap.put(bg.Business_Group_Master_Black_Belt__c, bg);
        }
        system.debug('@@mappedBGMap:'+mappedBGMap);

        for(QIPP_Contacts__c con : allBGContList){
            boolean isSelected = false;
            String objId = '';
            boolean isGlobalBGMBB = false;            
            if(mappedBGMap != null && mappedBGMap.size() > 0 && mappedBGMap.containsKey(con.id)){
                isSelected = true;
            }
            if(isSelected && mappedBGMap.get(con.id) != null){
                objId = mappedBGMap.get(con.id).Id;
            }

            BGMBBMapWrapper bgWrapper = new BGMBBMapWrapper(con.Id,con.Name,con.Email__c,isSelected,objId);
            bgMBBMapList.add(bgWrapper);
        }        
        system.debug('@@bgMBBMapList:'+bgMBBMapList);
    }
    
    public pageReference saveBGMap(){
        system.debug('@@bgMBBMapList:'+bgMBBMapList);
        system.debug('@@mappedBGMap:'+mappedBGMap);
        try{
            List<QIPP_BG_BU_BL_Contact_Mapping__c> bgMBBInsert = new List<QIPP_BG_BU_BL_Contact_Mapping__c>();
            List<QIPP_BG_BU_BL_Contact_Mapping__c> bgMBBDelete = new List<QIPP_BG_BU_BL_Contact_Mapping__c>();
            
            QIPP_BG_BU_BL_Contact_Mapping__c bgMBB;
            if(bgMBBMapList != null && bgMBBMapList.size() > 0){
                for(BGMBBMapWrapper obj : bgMBBMapList){
                    bgMBB = new QIPP_BG_BU_BL_Contact_Mapping__c();
                    bgMBB.Id = obj.objId != null && obj.objId != '' ? obj.objId : null;
                    bgMBB.Portfolio_Name__c = poId;
                    bgMBB.Business_Group_Master_Black_Belt__c = obj.cid;

                    if(obj.isSelect){
                        if(!mappedBGMap.containsKey(obj.cid)){
                            bgMBBInsert.add(bgMBB);
                        }
                    }else{
                        if(mappedBGMap.containsKey(obj.cid)){
                            bgMBBDelete.add(bgMBB);
                        }
                    }
                }
            }
            system.debug('@@bgMBBInsert:'+bgMBBInsert);
            if(bgMBBInsert != null && bgMBBInsert.size() > 0){
                upsert bgMBBInsert;
            }
            
            system.debug('@@bgMBBDelete:'+bgMBBDelete);
            if(bgMBBDelete != null && bgMBBDelete.size() > 0){
                delete bgMBBDelete;
            }

            pageReference pg = new pageReference('/'+poid);
            return pg;
        }catch(Exception e){
            return null;
        }            
    }

    public class BGMBBMapWrapper{
        public String cid{get;set;}
        public String Name{get;set;}
        public String Email{get;set;}
        public boolean isSelect{get;set;}
        public String objId{get;set;}

        public BGMBBMapWrapper(String cid,String Name,String Email,boolean isSelect,String objId){
            this.cid = cid;
            this.name = Name;
            this.email = Email;
            this.isSelect = isSelect;
            this.objId = objId;
        }
    }
}