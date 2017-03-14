public Class Claim_Code_Quantity{
    public string claimids{get;set;}
    public MCAR_Claim_Management__c vclaim {get;set;}
    public list<Material_Deviation__c> vlstmd {get;set;}
    public list<MCAR__c> vmcar{get;set;}
    public MCAR__c mcar{get;set;}
    public list<Material_Deviation__c> limad{get;set;}
  
    public Claim_Code_Quantity(){
        
         //claimids = apexpages.currentpage().getparameters().get('id');
        /*if(claimids  != null)
        {
            vclaim = [select id from MCAR_Claim_Management__c where id =:claimids];
        vlstmd = [select MCAR_Claim_Management1__c,Code__c,Quantity__c from Material_Deviation__c where MCAR_Claim_Management1__c =:vclaim.id ];
        system.debug('Meterial Deviation----->' + vlstmd);
        }*/
        
    }
    
    //list<String> licode = new list<String>();
    //public list<String> getMeterialDevaitionRecords()
    	public String getMeterialDevaitionRecords()
    {
        list<String> licode = new list<String>();
     
        if(claimids  != null)
        {
        vclaim = [select id from MCAR_Claim_Management__c where id =:claimids];
        vlstmd = [select MCAR_Claim_Management1__c,Code__c,Quantity__c from Material_Deviation__c where MCAR_Claim_Management1__c =:vclaim.id ];
        system.debug('Meterial Deviation----->' + vlstmd);
                
         for(Material_Deviation__c lim : vlstmd){
        	 licode.add(String.valueOf(lim.Quantity__c ));
        }
        }
          String allstr = String.join(licode,',');

        system.debug('Claim id----->'+vclaim);
         //return licode;  
         return allstr;      
    }
    
    //list<String> test = new list<String>(licode);
  
    //String allstr = String.join(test,',');
    
    
    public String getMeterialDevaitionCode()
    {
        list<String> licode = new list<String>();
        list<String> mcarcode = new list<String>();
        list<String> Combcode = new list<String>();
        list<String> Combcode1 = new list<String>();
        if(claimids  != null)
        {
            vclaim = [select id from MCAR_Claim_Management__c where id =:claimids];
            vlstmd = [select MCAR_Claim_Management1__c,Code__c,code__r.name,Quantity__c,MCARs__c ,MCARs__r.MCAR_NSN_Code__c,MCARs__r.MCAR_NSN_Code__r.name from Material_Deviation__c where MCAR_Claim_Management1__c =:vclaim.id ];
         
             system.debug('Meterial Deviation----->' + vlstmd);
            try{    
         for(Material_Deviation__c lim : vlstmd){
             if(lim.code__r.name!=null){
        	 licode.add(String.valueOf(lim.code__r.name ));
             }
           }
            }
            catch(Exception e){
                
            }
            }
        try{
            for(Material_Deviation__c lim1 : vlstmd){
                if(lim1.MCARs__r.MCAR_NSN_Code__r.name!=null){
        	 mcarcode.add(String.valueOf(lim1.MCARs__r.MCAR_NSN_Code__r.name));
                }}
        }
        catch(Exception e){
            
        }
          Combcode.addAll(licode);
          Combcode.addAll(mcarcode);
          Combcode1.addAll(Combcode);
         set<String> codeset = new set<String>();
         codeset.addAll(combcode1);
        list<String> nonduplicatecodes = new list<string>(codeset);
         String allstr1 = String.join(nonduplicatecodes,',');
        system.debug('Claim id----->'+vclaim);
         //return Combcode1;   
         
         return  allstr1;   
    }
    
    public Id Claim_Id{ get; set;}
    
    public class CQ{
        public CQ(){
            code = '';
            quantity = 0;
        }
        public String code{ get; set; }
        public Decimal quantity{ get; set; }
    }
    
    
    public list<CQ> getCodeQuantity(){
        list<CQ> CdQn = new list<CQ>();
        string man = '';
        integer j = 0;
        list<MCAR_Claim__c> MC = new list<MCAR_Claim__c>(); 
        list<Id> MCId = new list<Id>();  
        MC = [SELECT MCARs__c FROM MCAR_Claim__c WHERE MCAR_Claim_Management__c =: Claim_Id];
        if(!MC.isEmpty()){
            
            for(MCAR_Claim__c mcarm : MC)
                MCId.add(mcarm.MCARs__c);
            list<MCAR__c> MCAR = [SELECT MCAR_NSN_Code__c, MCAR_Defect_Quantity__c FROM MCAR__c WHERE Id IN: MCId];
            
            MCId = new list<Id>();
            CQ cqn;
            for(MCAR__c mc1 : MCAR){
                cqn = new CQ();
                MCId.add(mc1.MCAR_NSN_Code__c);
                cqn.quantity = mc1.MCAR_Defect_Quantity__c;
                cqn.code = mc1.MCAR_NSN_Code__c;
                CdQn.add(cqn);
            }
            list<MCAR_MEPS__c> Manufac = [SELECT Name FROM MCAR_MEPS__c WHERE Id IN: MCId];
            for(integer i = 0; i < Manufac.size()-1; i++){
                man = man + Manufac[i].Name + ', ';
                CdQn[i].code = Manufac[i].Name;
            }
            man = man + Manufac[Manufac.size()-1].Name;
            CdQn[Manufac.size()-1].code = Manufac[Manufac.size()-1].Name;
        }
                
        list<Non_Mcar__c> NM = [SELECT Code__c, Quantity__c FROM Non_Mcar__c WHERE Claim__c =: Claim_Id];
        if(!NM.isEmpty()){
            man = man + ', ';
            MCId = new list<Id>();
            CQ cqn1;
            for(Non_Mcar__c nonm : NM){
                cqn1 = new CQ();
                MCId.add(nonm.Code__c);
                cqn1.quantity = nonm.Quantity__c;
                cqn1.code = nonm.Code__c;
                CdQn.add(cqn1);
            }
            list<MCAR_MEPS__c> Manufac = [SELECT Name FROM MCAR_MEPS__c WHERE Id IN: MCId];
            for(integer i = 0; i < Manufac.size()-1; i++){
                man = man + Manufac[i].Name + ', ';
                CdQn[i+MC.Size()].code = Manufac[i].Name;
            }
            man = man + Manufac[Manufac.size()-1].Name;
            CdQn[Manufac.size()-1+MC.size()].code = Manufac[Manufac.size()-1].Name;
        }
        return CdQn;
    }

    static testmethod void test1(){
        
        MCAR_Manufacturer__c MM = new MCAR_Manufacturer__c();
        MM.Name = 'Samsung';
        insert MM;
        MCAR__c objmcar = new MCAR__c();
        objmcar.MCAR_Status__c ='No Trouble Found';
        objmcar.MCAR_Manufacturer__c = MM.Id;
        insert objmcar;
        MCAR_Claim_Management__c MCM = new MCAR_Claim_Management__c();
        MCM.Claim_Status__c = 'Draft'; 
        MCM.Part_Category__c = 'Components';
        MCM.Manufacturer__c = MM.Id;
        insert MCM;
        //pagereference ref = new pageReference(MCAR_Claim_Cancel);
        
        //NextStepDataCollection(MCM.ID);
        MCM.Claim_Status__c = 'Data Collection'; 
        MCM.Root_Cause_Summary__c = 'Testing';
        MCM.Corrective_Actions_Summary__c = 'Test';
        MCM.Manufacturer_Accepts_Full_Responsibility__c = True;
        MCM.Total_Cost_To_Be_Claimed__c = 123;
        MCM.Amount__c = 123;
        update MCM;
        
        
        NSN_Part__c NP = new NSN_Part__c();
        NP.Name = 'test';
        NP.Description__c = 'test';
        insert NP;
        MCAR_MEPS__c MMP = new MCAR_MEPS__c();
        MMP.Name = 'Test';
        MMP.MCAR_NSN_Part__c = NP.Id;
        MMP.MCAR_Mfg_Part_Number__c = 'test';
        MMP.Manufacturer_Name__c = MM.Id;
        insert MMP;
        Non_Mcar__c NM = new Non_Mcar__c();
        NM.Code__c = MMP.Id;
        NM.Quantity__c = 123;
        NM.Claim__c = MCM.Id;
        insert NM;
        
        MCAR_Claim__c MCL = new MCAR_Claim__c();
        MCL.MCAR_Claim_Management__c = MCM.Id;
        MCL.MCARs__c = objmcar.Id;
        insert MCL;
        
        //NextStepDataCollection(MCM.ID);
        Claim_Contact__c CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'Legal';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'Category Manager';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'SQS';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        
        Claim_Code_Quantity CCQ = new Claim_Code_Quantity();
        CCQ.Claim_Id = MCM.Id;
        try{CCQ.getCodeQuantity();}catch(exception e){}
    }
}