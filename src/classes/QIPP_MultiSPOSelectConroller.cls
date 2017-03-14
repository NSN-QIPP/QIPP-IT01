public class QIPP_MultiSPOSelectConroller 
{ 
    set<string> UsersEmail;
    Map<string,Portfolios_Owner__c> POlist;            
    public Id theId{get;set;}
    public Id thePortfolioId { set; get; }
    public Id poid { set; get; }
    public List<QIPP_Contacts__c> bumbbList{get;set;}
    public List<String> ConList;
    public String bumbbName{get;set;}
    public Portfolios_Owner__c powner {set;get;}
    public List<POContact> pocSelect { set; get;}
    public List<POContact> pocNotSelect { set; get;}
    @TestVisible private list<Portfolios_Owner__c> MPOSelect = new list <Portfolios_Owner__c>();
    public QIPP_Portfolio__c profolioRec;   
    public POContact editCon{get;set;}
    public Map<String,String> projTypeMap;
    public Map<String,Integer> ProjTypeCount;
    public Map<String,String> ProjDescNOwners;
    public List<Portfolios_Owner__c> availablePortfolioOwners;
    
    public QIPP_MultiSPOSelectConroller(apexpages.StandardController stdController){
        powner = (Portfolios_Owner__c)stdController.getRecord();
        Id theId = ApexPages.currentPage().getParameters().get('id');
        projTypeMap = new Map<String,String>();
        ProjTypeCount = new Map<String,Integer>();
        POlist = new Map<String,Portfolios_Owner__c>();
    }
    public QIPP_MultiSPOSelectConroller()
    {                          
        poId = ApexPages.currentPage().getParameters().get('poid');
        system.debug('poId******'+poId) ; 
        UsersEmail = new set<String>();        
        POlist = new Map<String,Portfolios_Owner__c>();
        pocSelect = new List<POContact>();
        pocNotSelect = new List<POContact>();
        ProjDescNOwners= new Map<String,String>();
        profolioRec = [select id,DMAIC_DMADV__c,X8D__c,A3__c,CIF__c,DI_CoPQ__c,Lean_including_Kaizen__c,RCA_EDA__c,Other__c,Is_Super_Portfolio__c from QIPP_Portfolio__c where id=:poId ];
        availablePortfolioOwners = [select id,Name,Email__c,QIPP_Contact__c,QIPP_Portfolio__c,Is_Super_Portfolio__c from Portfolios_Owner__c where QIPP_Portfolio__c = :poId  ]; 
        
        system.debug('availablePortfolioOwners :'+availablePortfolioOwners);
        for(Portfolios_Owner__c po : availablePortfolioOwners)
        {
            POlist.put(po.email__c,po);
        }
        for(User users : [select email from user where UserRole.Name = 'QIPP Portfolio Owner' and IsActive = true])
        {
            system.debug('***'+users.Email);
            UsersEmail.add(users.email);
        }        
        for(QIPP_Contacts__c qippcon : [select id,name,Email__c from QIPP_Contacts__c where Email__c IN:UsersEmail and User_License__c!= null])
        {
            if(Polist.get(qippcon.Email__c)!=null)
            {
                
                    POContact pocon = new POContact(qippcon.id,qippcon.Name,qippcon.Email__c,true,Polist.get(qippcon.Email__c).Is_Super_Portfolio__c ,profolioRec);
                    pocSelect.add(pocon);
                
            }
            else{
                POContact pocon = new POContact(qippcon.id,qippcon.Name,qippcon.Email__c,false,false,profolioRec);
                pocNotSelect.add(pocon);
            }
        }
        
        projTypeMap = new Map<String,String>();
        projTypeMap.put('Super Portfolio Owner','Is_Super_Portfolio__c');
        ProjTypeCount = new Map<String,Integer>();                      
    }
    public List<Portfolios_Owner__c> getPortfolioOwnerlist(){
        MPOSelect = [select id,Name,Email__c,QIPP_Contact__c,QIPP_Portfolio__c,Is_Super_Portfolio__c from Portfolios_Owner__c where id=:powner.Id];
        thePortfolioId=MPOSelect[0].QIPP_Portfolio__c;
        
        profolioRec = [select id,Is_Super_Portfolio__c from QIPP_Portfolio__c where id=:MPOSelect[0].QIPP_Portfolio__c ];
        editCon = new POContact(MPOSelect[0].id,MPOSelect[0].Name,MPOSelect[0].Email__c,true,true,profolioRec);


        return MPOSelect;
    }

    public pageReference addPO()
    {
        

        Set<Portfolios_Owner__c> insertPo = new Set<Portfolios_Owner__c>();
        Set<Portfolios_Owner__c> updatePo = new Set<Portfolios_Owner__c>();

        //system.debug('pocSelect :'+pocSelect);
        for(POContact poc : pocNotSelect){            
            if(poc.isSelect){
                system.debug('poc.isSelect :'+poc.isSelect);                                        
                Portfolios_Owner__c po = new Portfolios_Owner__c(Name = poc.name,Email__c=poc.email,QIPP_Contact__c = poc.cid,QIPP_Portfolio__c = poid,Is_Super_Portfolio__c=poc.isSuperPO);                       
                insertPo.add(po);
            }            
        }
        for(POContact poc : pocSelect){            
            if(poc.isSelect){
                system.debug('poc.isSelect :'+poc.isSelect);                                        
                Portfolios_Owner__c po = new Portfolios_Owner__c(id= Polist.get(poc.email).id,Name = poc.name,Email__c=poc.email,QIPP_Contact__c = poc.cid,QIPP_Portfolio__c = poid,Is_Super_Portfolio__c=poc.isSuperPO);                       
                updatePo.add(po);
            }            
        }
        if(insertPo.size()>0 || updatePo.size()>0){
            if(insertPo.size()>0 ){
                insert new List<Portfolios_Owner__c>(insertPo);                  
            }
            if(updatePo.size()>0 )update new List<Portfolios_Owner__c>(updatePo);
            pageReference pg = new pageReference('/'+poid);
            return pg;
        }else{
            return null;
        }       

        
    }
    
    public pageReference updatePo()
    {
        availablePortfolioOwners = [select id,Name,Email__c,QIPP_Contact__c,QIPP_Portfolio__c from Portfolios_Owner__c where QIPP_Portfolio__c = :thePortfolioId]; 
        system.debug('availablePortfolioOwners :'+availablePortfolioOwners);
        
        ProjDescNOwners= new Map<String,String>();
        for(Portfolios_Owner__c po : availablePortfolioOwners)
        {
            POlist.put(po.email__c,po);
        }
            projTypeMap.put('DMAIC / DMADV','DMAIC_DMADV__c');
            projTypeMap.put('Lean (including Kaizen)','Lean_including_Kaizen__c');
            projTypeMap.put('8D','X8D__c');
            projTypeMap.put('A3','A3__c');
            projTypeMap.put('CIF','CIF__c');
            projTypeMap.put('DI (CoPQ)','DI_Logic__c');
            projTypeMap.put('Other','Other__c');
            projTypeMap.put('RCA/EDA','RCA_EDA__c');
                
        for(String str : projTypeMap.values()){
         Integer i =0;
          for(Portfolios_Owner__c portOwner : availablePortfolioOwners ){
             
             if((Boolean)portOwner.get(str)){
               system.debug('str = '+i);
               i++;
               if(ProjDescNOwners.get(str) == null){
                ProjDescNOwners.put(str,''+portOwner.id);
               }else{
                ProjDescNOwners.put(str,ProjDescNOwners.get(str)+','+portOwner.id);
               }
             }
          }
          ProjTypeCount.put(str,i);
          
                  
        }
        System.debug('projTypeMap :'+ProjTypeCount);
        List<String> deletePo = new List<String>();
        List<string> uptPo = new List<string>();
        Set<Portfolios_Owner__c> updatePo = new Set<Portfolios_Owner__c>();
        system.debug('ProjDescNOwners :'+ProjDescNOwners);
        for(Portfolios_Owner__c upsertpo : MPOSelect) 
        {
            String errormessage = '';
            
            for(String str : projTypeMap.values()){
                system.debug('upsertpo:::::'+upsertpo);
            if(((Boolean)upsertpo.get(str))  ){
                    if(ProjDescNOwners.keySet().contains(str) && !(ProjDescNOwners.get(str).contains(upsertpo.id))){
                        ProjTypeCount.put(str,ProjTypeCount.get(str)+1);
                    }
                    if(ProjTypeCount.get(str) <= 4){
                    updatePo.add(upsertpo);
                        system.debug(str+' : ProjTypeCount.get(str) :'+ProjTypeCount.get(str));
                    }else{
                        for(String fieldName : projTypeMap.keyset()){
                            if(projTypeMap.get(fieldName) == str){
                                if(errormessage == null || errormessage ==''){
                                    errormessage = 'Maximum of 4 users allowed for one Methodology: '+fieldName;
                                }else{
                                    errormessage = errormessage+','+' '+fieldName;
                                    
                                }
                            }
                        }    
                        if(errormessage!=null && errormessage!=''){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,errormessage));
                            return null;
                        }    
                        
                    }
            }   
            
          }                 

        }
        if(updatePo.size()>0)
        upsert new List<Portfolios_Owner__c>(updatePo);
        
        //delete portfolio owner....
        if(deletePo.size()>0)
        {                    
            List<Portfolios_Owner__c> deletePoList = new List<Portfolios_Owner__c>([select id from Portfolios_Owner__c where Email__c IN:deletePo and QIPP_Portfolio__c =: poid]);                
            delete deletePoList;
        }        
        pageReference pg = new pageReference('/'+thePortfolioId);
        return pg;
    }
    
    public class POContact
    {
        public string cid { set; get; }
        public string name { set; get; }
        public string Email { set; get; }
        public boolean isSelect { set; get; }
        public boolean isSuperPO { set; get; }
        
        public boolean dmaic { set; get; }
        public boolean spo{set;get;}
        public boolean dmaicEdit { set; get; }
        public boolean X8D { set; get; }
        public boolean X8DEdit { set; get; }
        public boolean A3 { set; get; }
        public boolean A3Edit { set; get; }
        public boolean CIF { set; get; }
        public boolean CIFEdit { set; get; }
        public boolean DILogic { set; get; }
        public boolean DILogicEdit { set; get; }
        public boolean lean { set; get; }
        public boolean leanEdit { set; get; }
        public boolean RCA { set; get; }
        public boolean RCAEdit { set; get; }
        public boolean Others { set; get; }
        public boolean OthersEdit { set; get; }
        public QIPP_Portfolio__c portfolioRec{get;set;} 
        
        
        public POContact(string cid,string name,string email, boolean isSelect, boolean isSuperPo,QIPP_Portfolio__c portRec)
        {
            this.cid = cid;
            this.name = name;
            this.email = email;
            this.isSelect = isSelect;
            this.isSuperPO = isSuperPo;
            this.dmaicEdit = !(portRec.DMAIC_DMADV__c);
            this.X8DEdit =!(portRec.X8D__c);
            this.A3Edit =!(portRec.A3__c);
            this.CIFEdit =!(portRec.CIF__c);
            this.DILogicEdit =!(portRec.DI_CoPQ__c);
            this.leanEdit =!(portRec.Lean_including_Kaizen__c);
            this.RCAEdit =!(portRec.RCA_EDA__c);
            this.OthersEdit =!(portRec.Other__c);
        }
    }
}